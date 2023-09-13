Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F57F79DF98
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 07:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbjIMF6T convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Sep 2023 01:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjIMF6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 01:58:18 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171AA172A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 22:58:12 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id C6A0F24DFCE;
        Wed, 13 Sep 2023 13:58:07 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 13 Sep
 2023 13:58:07 +0800
Received: from [192.168.151.232] (172.16.6.8) by EXMBX066.cuchost.com
 (172.16.6.66) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 13 Sep
 2023 13:58:06 +0800
Message-ID: <e2783323-6f76-bedb-4e0c-aafba909117b@starfivetech.com>
Date:   Wed, 13 Sep 2023 13:58:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/1] i3c: Add fallback method for GETMXDS CCC
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        <vitor.soares@synopsys.com>, <conor.culhane@silvaco.com>
CC:     <alexandre.belloni@bootlin.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230911082456.23239-1-joshua.yeong@starfivetech.com>
 <20230911082456.23239-2-joshua.yeong@starfivetech.com>
 <20230912130821.21edfafc@xps-13>
Content-Language: en-US
From:   Joshua Yeong <joshua.yeong@starfivetech.com>
In-Reply-To: <20230912130821.21edfafc@xps-13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-Originating-IP: [172.16.6.8]
X-ClientProxiedBy: EXCAS081.cuchost.com (172.16.6.41) To EXMBX066.cuchost.com
 (172.16.6.66)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,


On 12-Sep-23 7:08 PM, Miquel Raynal wrote:
> Hi Joshua,
>
> joshua.yeong@starfivetech.com wrote on Mon, 11 Sep 2023 16:24:56 +0800:
>
>> Some I3C hardware will report error when incorrect length is received from
>> device. GETMXDS CCC are availble in 2 formats; without turnaround time (format
>> 1) and with turnaround time (format 2). There is no mechanics to determine which
>> format is supported by device. In case sending GETMXDS CCC format 2 resulted
>> failure, try sending GETMXDS CCC format 1 instead.
>>
>> Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
>> ---
>>   drivers/i3c/master.c    | 33 ++++++++++++++++++++++++++++-----
>>   include/linux/i3c/ccc.h | 17 +++++++++++++++--
>>   2 files changed, 43 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
>> index 87283e4a4607..084f64bef155 100644
>> --- a/drivers/i3c/master.c
>> +++ b/drivers/i3c/master.c
>> @@ -1088,10 +1088,37 @@ static int i3c_master_getmxds_locked(struct i3c_master_controller *master,
>>   				     struct i3c_device_info *info)
>>   {
>>   	struct i3c_ccc_getmxds *getmaxds;
>> +	struct i3c_ccc_getmxds_turnaround *getmaxds_ta;
>>   	struct i3c_ccc_cmd_dest dest;
>>   	struct i3c_ccc_cmd cmd;
>>   	int ret;
>>   
>> +	getmaxds_ta = i3c_ccc_cmd_dest_init(&dest, info->dyn_addr,
>> +					 sizeof(*getmaxds_ta));
>> +	if (!getmaxds_ta)
>> +		return -ENOMEM;
>> +
>> +	i3c_ccc_cmd_init(&cmd, true, I3C_CCC_GETMXDS, &dest, 1);
>> +	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
>> +	if (ret) {
>> +		goto alternative;
>> +	}
>> +
>> +	if (dest.payload.len != 2 && dest.payload.len != 5) {
> Can len be 2 here?

I do not know if other IP allows lower payload length. The Cadence IP 
will trigger an error in case the GET CCC length is mismatch. May need 
Vitor/Conor to confirm this behavior in Synopsys/Silvaco.

>> +		ret = -EIO;
>> +		goto out;
>> +	}
>> +
>> +	info->max_read_ds = getmaxds_ta->maxrd;
>> +	info->max_write_ds = getmaxds_ta->maxwr;
>> +	if (dest.payload.len == 5)
>> +		info->max_read_turnaround = getmaxds_ta->maxrdturn[0] |
>> +					    ((u32)getmaxds_ta->maxrdturn[1] << 8) |
>> +					    ((u32)getmaxds_ta->maxrdturn[2] << 16);
> Don't you want to avoid the "alternative" if it worked?
Thank you, will fix this.
>
>> +
>> +alternative:
> I would expect a comment somewhere to explain the subtlety.
Will add comments to explain this code.
>
>> +	i3c_ccc_cmd_dest_cleanup(&dest);
>> +
>>   	getmaxds = i3c_ccc_cmd_dest_init(&dest, info->dyn_addr,
>>   					 sizeof(*getmaxds));
>>   	if (!getmaxds)
>> @@ -1102,17 +1129,13 @@ static int i3c_master_getmxds_locked(struct i3c_master_controller *master,
>>   	if (ret)
>>   		goto out;
>>   
>> -	if (dest.payload.len != 2 && dest.payload.len != 5) {
>> +	if (dest.payload.len != 2) {
>>   		ret = -EIO;
>>   		goto out;
>>   	}
>>   
>>   	info->max_read_ds = getmaxds->maxrd;
>>   	info->max_write_ds = getmaxds->maxwr;
>> -	if (dest.payload.len == 5)
>> -		info->max_read_turnaround = getmaxds->maxrdturn[0] |
>> -					    ((u32)getmaxds->maxrdturn[1] << 8) |
>> -					    ((u32)getmaxds->maxrdturn[2] << 16);
>>   
>>   out:
>>   	i3c_ccc_cmd_dest_cleanup(&dest);
>> diff --git a/include/linux/i3c/ccc.h b/include/linux/i3c/ccc.h
>> index ad59a4ae60d1..50ed41d4d5a1 100644
>> --- a/include/linux/i3c/ccc.h
>> +++ b/include/linux/i3c/ccc.h
>> @@ -269,14 +269,27 @@ enum i3c_tsco {
>>   #define I3C_CCC_MAX_SDR_FSCL(x)		((x) & I3C_CCC_MAX_SDR_FSCL_MASK)
>>   
>>   /**
>> - * struct i3c_ccc_getmxds - payload passed to GETMXDS CCC
>> + * struct i3c_ccc_getmxds - payload passed to GETMXDS CCC without turnaround
>> + * (format 1)
>> + *
>> + * @maxwr: write limitations
>> + * @maxrd: read limitations
>> + */
>> +struct i3c_ccc_getmxds {
>> +	u8 maxwr;
>> +	u8 maxrd;
>> +} __packed;
>> +
>> +/**
>> + * struct i3c_ccc_getmxds_ta - payload passed to GETMXDS CCC with turnaround
>> + * (format 2)
>>    *
>>    * @maxwr: write limitations
>>    * @maxrd: read limitations
>>    * @maxrdturn: maximum read turn-around expressed micro-seconds and
>>    *	       little-endian formatted
>>    */
>> -struct i3c_ccc_getmxds {
>> +struct i3c_ccc_getmxds_turnaround {
>>   	u8 maxwr;
>>   	u8 maxrd;
>>   	u8 maxrdturn[3];
>
> Thanks,
> Miquèl

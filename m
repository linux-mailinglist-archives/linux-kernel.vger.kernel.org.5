Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C328B80F7C4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377319AbjLLUU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377223AbjLLUUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:20:54 -0500
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0868EB7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:21:00 -0800 (PST)
Received: from [192.168.1.18] ([92.140.202.140])
        by smtp.orange.fr with ESMTPA
        id D9FRrnKnRNKQID9FRrw6kc; Tue, 12 Dec 2023 21:20:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1702412459;
        bh=pNHY33zAf7Z3DmgX24lQE73GMdfp/a1HUEW+16HBU1c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Ckt3fq/rBkfcujHT41TO6D5jD/Ky4GMIjnBO4BquSXf7sCud206bT8D0LisXM3mlQ
         lahNKe28W78HxNuK5Ds9gSA+tunp4kMt4j5T9+mf3mwhaKJLNF+5JQBXPJA5RgNBrg
         nvZVTqqshDNZ05BrLQ+7ieCJ5GHLBlL/WiByI94dIaQGSziubklOkaajcmX1S+cEOJ
         BnoV43Fs9Rp7oJSHvhQDbDHl+hrj/xunX2oVuBGd4RAVCGs/adUB/0bOgGcpVCDsoU
         +wsejwhMixn6HwhIIenymfA7RTvvajvjk28z/MsKpPf3VI84OsHq8iDgbJWk74fUvS
         P5RJcYEkuW36A==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 12 Dec 2023 21:20:59 +0100
X-ME-IP: 92.140.202.140
Message-ID: <70b7e97b-2044-4515-aadc-87d202d32b93@wanadoo.fr>
Date:   Tue, 12 Dec 2023 21:20:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] scsi: myrb: Fix a potential string truncation in
 rebuild_show()
To:     Bart Van Assche <bvanassche@acm.org>, hare@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     hare@suse.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <cover.1702411083.git.christophe.jaillet@wanadoo.fr>
 <2d3096dd4b1b6e758287e4062e3147c57c007eaa.1702411083.git.christophe.jaillet@wanadoo.fr>
 <dac24fac-57eb-4ca8-b819-fbdc24464d94@acm.org>
Content-Language: fr, en-US
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <dac24fac-57eb-4ca8-b819-fbdc24464d94@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 12/12/2023 à 21:14, Bart Van Assche a écrit :
> On 12/12/23 10:09, Christophe JAILLET wrote:
>> "physical device - not rebuilding\n" is 34 bytes long. When written in
>> 'buf' with a limit of 32 bytes, it is truncated.
>>
>> When building with W=1, it leads to:
>>     drivers/scsi/myrb.c: In function ‘rebuild_show’:
>>     drivers/scsi/myrb.c:1906:24: error: ‘physical device - not 
>> rebuil...’ directive output truncated writing 33 bytes into a region 
>> of size 32 [-Werror=format-truncation=]
>>      1906 |                 return snprintf(buf, 32, "physical device 
>> - not rebuilding\n");
>>           |                        
>> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>     drivers/scsi/myrb.c:1906:24: note: ‘snprintf’ output 34 bytes into 
>> a destination of size 32
>>
>> Change the allowed size to 64 to fix the issue.
>>
>> Fixes: 081ff398c56c ("scsi: myrb: Add Mylex RAID controller (block 
>> interface)")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   drivers/scsi/myrb.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/scsi/myrb.c b/drivers/scsi/myrb.c
>> index ca2e932dd9b7..ca2380d2d6d3 100644
>> --- a/drivers/scsi/myrb.c
>> +++ b/drivers/scsi/myrb.c
>> @@ -1903,15 +1903,15 @@ static ssize_t rebuild_show(struct device *dev,
>>       unsigned char status;
>>       if (sdev->channel < myrb_logical_channel(sdev->host))
>> -        return snprintf(buf, 32, "physical device - not rebuilding\n");
>> +        return snprintf(buf, 64, "physical device - not rebuilding\n");
>>       status = myrb_get_rbld_progress(cb, &rbld_buf);
>>       if (rbld_buf.ldev_num != sdev->id ||
>>           status != MYRB_STATUS_SUCCESS)
>> -        return snprintf(buf, 32, "not rebuilding\n");
>> +        return snprintf(buf, 64, "not rebuilding\n");
>> -    return snprintf(buf, 32, "rebuilding block %u of %u\n",
>> +    return snprintf(buf, 64, "rebuilding block %u of %u\n",
>>               rbld_buf.ldev_size - rbld_buf.blocks_left,
>>               rbld_buf.ldev_size);
>>   }
> 
> Anyone who sees the resulting code without having seen the above patch will
> wonder where the magic number '64' comes from. Please use sysfs_emit() 
> instead
> of snprintf(buf, 64, ...).

Ok.

In this case, do you still prefer 2 patches (one to fix rebuild_show() 
and one for all the other _show function) or only 1 with everything in it?

CJ

> 
> Thanks,
> 
> Bart.
> 


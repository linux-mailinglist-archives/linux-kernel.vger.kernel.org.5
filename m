Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B777FB0A1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 04:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbjK1DNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 22:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjK1DNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 22:13:44 -0500
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133881A5;
        Mon, 27 Nov 2023 19:13:48 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VxJ3ovR_1701141224;
Received: from 30.221.128.219(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VxJ3ovR_1701141224)
          by smtp.aliyun-inc.com;
          Tue, 28 Nov 2023 11:13:46 +0800
Message-ID: <b7caa2cc-4615-6f0e-c296-6142b3724e01@linux.alibaba.com>
Date:   Tue, 28 Nov 2023 11:13:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v2 7/7] net/smc: manage system EID in SMC stack
 instead of ISM driver
To:     Alexandra Winter <wintera@linux.ibm.com>, wenjia@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, kgraul@linux.ibm.com, jaka@linux.ibm.com
Cc:     borntraeger@linux.ibm.com, svens@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        raspl@linux.ibm.com, schnelle@linux.ibm.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1700836935-23819-1-git-send-email-guwen@linux.alibaba.com>
 <1700836935-23819-8-git-send-email-guwen@linux.alibaba.com>
 <48732f15-64bf-4bb7-8b88-95263a99cf6a@linux.ibm.com>
From:   Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <48732f15-64bf-4bb7-8b88-95263a99cf6a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.8 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/27 22:04, Alexandra Winter wrote:
> 
> 
> On 24.11.23 15:42, Wen Gu wrote:
>> The System EID (SEID) is an internal EID that is used by the SMCv2
>> software stack that has a predefined and constant value representing
>> the s390 physical machine that the OS is executing on. So it should
>> be managed by SMC stack instead of ISM driver and be consistent for
>> all ISMv2 device (including virtual ISM devices) on s390 architecture.
>>
>> Suggested-by: Alexandra Winter <wintera@linux.ibm.com>
>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>> ---
> 
> Yes, this is what I had in mind. Thank you Wen Gu.

:)
> [...]
> 
>>
>> diff --git a/drivers/s390/net/ism.h b/drivers/s390/net/ism.h
>> index 70c5bbd..49ccbd68 100644
>> --- a/drivers/s390/net/ism.h
>> +++ b/drivers/s390/net/ism.h
> 
> Please remove ISM_IDENT_MASK from drivers/s390/net/ism.h
> [...]
> 

Thanks for reminding. I will remove it.

>> --- a/drivers/s390/net/ism_drv.c
>> +++ b/drivers/s390/net/ism_drv.c
>> @@ -36,6 +36,7 @@
> [...]
>> -static void ism_create_system_eid(void)
>> -{
>> -	struct cpuid id;
>> -	u16 ident_tail;
>> -	char tmp[5];
>> -
>> -	get_cpu_id(&id);
>> -	ident_tail = (u16)(id.ident & ISM_IDENT_MASK);
>> -	snprintf(tmp, 5, "%04X", ident_tail);
>> -	memcpy(&SYSTEM_EID.serial_number, tmp, 4);
>> -	snprintf(tmp, 5, "%04X", id.machine);
>> -	memcpy(&SYSTEM_EID.type, tmp, 4);
>> -}
>> -
> [...]
>> @@ -560,7 +535,7 @@ static int ism_dev_init(struct ism_dev *ism)
>>   
>>   	if (!ism_add_vlan_id(ism, ISM_RESERVED_VLANID))
>>   		/* hardware is V2 capable */
>> -		ism_create_system_eid();
>> +		ism_v2_capable = true;
>>   
> 
> Please assign 'false' in the else path.
> This is required here for backwards compatibility. Hardware that only supports v1,
> will reject ISM_RESERVED_VLANID.
> 

OK. I will assign false in the else path to explicitly express the meaning. Thank you.

> [...]
> 
> 
>> --- a/net/smc/smc_ism.c
>> +++ b/net/smc/smc_ism.c
> [...]
>> @@ -70,6 +91,11 @@ bool smc_ism_is_v2_capable(void)
>>   	return smc_ism_v2_capable;
>>   }
>>   
>> +void smc_ism_set_v2_capable(void)
>> +{
>> +	smc_ism_v2_capable = true;
>> +}
>> +
>>   /* Set a connection using this DMBE. */
>>   void smc_ism_set_conn(struct smc_connection *conn)
>>   {
>> @@ -431,14 +457,8 @@ static void smcd_register_dev(struct ism_dev *ism)
>>   
>>   	mutex_lock(&smcd_dev_list.mutex);
>>   	if (list_empty(&smcd_dev_list.list)) {
>> -		u8 *system_eid = NULL;
>> -
>> -		system_eid = smcd->ops->get_system_eid();
>> -		if (smcd->ops->supports_v2()) {
>> -			smc_ism_v2_capable = true;
>> -			memcpy(smc_ism_v2_system_eid, system_eid,
>> -			       SMC_MAX_EID_LEN);
>> -		}
>> +		if (smcd->ops->supports_v2())
>> +			smc_ism_set_v2_capable();
> 
> I don't see the benefit in declaring smc_ism_set_v2_capable() and exporting it in smc_ism.h,
> when it is used only once and only here.
> Why don't you just set
> 	smc_ism_v2_capable = true;
> here?
> 

Yes.. it may be confusing if readers only look at this patch set.

It is because loopback-ism (or other kinds of ISMv2.1) will also use this helper in such
as smc_loopback.c to set smc_ism_v2_capable (defined in smc_ism.c) as true. So I think it
may be better to introduce a helper here instead of exposing smc_ism_v2_capable variable.

Thanks.

> [...]
>> diff --git a/net/smc/smc_ism.h b/net/smc/smc_ism.h
>> index 0e5e563..6903cd5 100644
>> --- a/net/smc/smc_ism.h
>> +++ b/net/smc/smc_ism.h
>> @@ -16,6 +16,7 @@
>>   #include "smc.h"
>>   
>>   #define SMC_VIRTUAL_ISM_CHID_MASK	0xFF00
>> +#define SMC_ISM_IDENT_MASK		0x00FFFF
>>   
> [...]
>> @@ -45,6 +52,7 @@ int smc_ism_register_dmb(struct smc_link_group *lgr, int buf_size,
>>   void smc_ism_get_system_eid(u8 **eid);
>>   u16 smc_ism_get_chid(struct smcd_dev *dev);
>>   bool smc_ism_is_v2_capable(void);
>> +void smc_ism_set_v2_capable(void);
>>   int smc_ism_init(void);
>>   void smc_ism_exit(void);
>>   int smcd_nl_get_device(struct sk_buff *skb, struct netlink_callback *cb);

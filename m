Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADDB8032F1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbjLDMgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235405AbjLDMgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:36:06 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E704FC0;
        Mon,  4 Dec 2023 04:36:11 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VxqRCak_1701693368;
Received: from 30.221.130.147(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VxqRCak_1701693368)
          by smtp.aliyun-inc.com;
          Mon, 04 Dec 2023 20:36:09 +0800
Message-ID: <8efa4f88-4ab1-bdd9-5705-93d62909bfa9@linux.alibaba.com>
Date:   Mon, 4 Dec 2023 20:36:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v3 7/7] net/smc: manage system EID in SMC stack
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
References: <1701343695-122657-1-git-send-email-guwen@linux.alibaba.com>
 <1701343695-122657-8-git-send-email-guwen@linux.alibaba.com>
 <aab0905a-b77f-4504-a510-83c98f79b2b7@linux.ibm.com>
From:   Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <aab0905a-b77f-4504-a510-83c98f79b2b7@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-14.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/12/1 19:18, Alexandra Winter wrote:
> 
> 
> On 30.11.23 12:28, Wen Gu wrote:
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
> Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
> 
> 
> [...]
>> diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
>> index a33f861..ac88de2 100644
>> --- a/net/smc/smc_ism.c
>> +++ b/net/smc/smc_ism.c
> [...]
>> @@ -431,14 +452,8 @@ static void smcd_register_dev(struct ism_dev *ism)
>>   
>>   	mutex_lock(&smcd_dev_list.mutex);
>>   	if (list_empty(&smcd_dev_list.list)) {
>> -		u8 *system_eid = NULL;
>> -
>> -		system_eid = smcd->ops->get_system_eid();
>> -		if (smcd->ops->supports_v2()) {
>> +		if (smcd->ops->supports_v2())
>>   			smc_ism_v2_capable = true;
>> -			memcpy(smc_ism_v2_system_eid, system_eid,
>> -			       SMC_MAX_EID_LEN);
>> -		}
>>   	}
> 
> Just a comment:
> Here we only check the first smcd device to determine whether we support v2.
> Which is ok, for today's platform firmware ISM devices, as they are always the same version.
> 
> When you add virtual ISM devices (loopback-ism, virtio-ism) then this needs to be changed.
> IMO the logic then needs to be "if all smcd devices support v2,
> then smc_ism_v2_capable = true;
> else smc_ism_v2_capable = false;"
> 

Thank you. I will change this in the loopback-ism patch set.

But I am wondering if loopback-ism coexists with s390 ISMv1, why smc_ism_v2_capable shouldn't be set?
Is it because the SEID generated in this way is not correct if the s390 ISMv2 does not exist?

> I don't know if you would like to change that now in this patch, or later when
> you add when you add the support for loopback.
> 
> 

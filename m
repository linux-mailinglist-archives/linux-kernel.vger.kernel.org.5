Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827CD80CF5B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343887AbjLKPX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbjLKPX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:23:56 -0500
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009EEDC;
        Mon, 11 Dec 2023 07:24:01 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VyJONX._1702308238;
Received: from 30.221.130.53(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VyJONX._1702308238)
          by smtp.aliyun-inc.com;
          Mon, 11 Dec 2023 23:23:59 +0800
Message-ID: <7ff3001a-4254-0382-f8c8-6ebf2807346a@linux.alibaba.com>
Date:   Mon, 11 Dec 2023 23:23:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v5 2/9] net/smc: introduce sub-functions for
 smc_clc_send_confirm_accept()
To:     Alexandra Winter <wintera@linux.ibm.com>, wenjia@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, kgraul@linux.ibm.com, jaka@linux.ibm.com
Cc:     borntraeger@linux.ibm.com, svens@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        raspl@linux.ibm.com, schnelle@linux.ibm.com,
        guangguan.wang@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1702021259-41504-1-git-send-email-guwen@linux.alibaba.com>
 <1702021259-41504-3-git-send-email-guwen@linux.alibaba.com>
 <ac3c0823-8705-4225-96c8-ed7bc55d1bfc@linux.ibm.com>
 <9a6d57c0-f5b4-9b2c-dc5f-dc47d0518141@linux.alibaba.com>
 <fb2365f6-1237-4f22-9897-5676757e5157@linux.ibm.com>
From:   Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <fb2365f6-1237-4f22-9897-5676757e5157@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/12/11 21:35, Alexandra Winter wrote:
> 
> 
> On 11.12.23 13:15, Wen Gu wrote:
>>>> +    clc = (struct smc_clc_msg_accept_confirm *)clc_v2;
>>>
>>> Why is this cast neccessary? (Here as well as in smcr_clc_prep_confirm_accept
>>> and in smc_clc_send_confirm_accept)
>>> smc_clc_msg_accept_confirm_v2 has hdr and d0 as well.
>>
>> I think the cast is to imply that v2 is an expansion of v1, or v1 is the base of v2.
>> So here using clc(v1) reperesents their common set.
>>
>> If we use smc_clc_msg_accept_confirm_v2 for all, I think readers may be tempted to
>> check whether the hdr and d0 in 'smc_clc_msg_accept_confirm_v2' are also applicable to v1.
>>
>> And there are settings below that are specific for v1. It may be confusing if we
>> change it like this:
>>
>> if (version == SMC_V1) {
>>      clc_v2->hdr.length = htons(SMCD_CLC_ACCEPT_CONFIRM_LEN);
>> } else {
>>
>>
>>>
>>> IMO, it would be a nice seperate patch to get rid of the 2 type defs for
>>> smc_clc_msg_accept_confirm and smc_clc_msg_accept_confirm_v2
>>> and all the related casting anyhow.
>>>
>>
>> Do you mean to define only smc_clc_msg_accept_confirm_v2 or define with the name
>> of smc_clc_msg_accept_confirm but the contents of smc_clc_msg_accept_confirm_v2?
>>
>> I have a different opinion on this, since I think the smc_clc_msg_accept_confirm
>> and smc_clc_msg_accept_confirm_v2 clearly shows the difference between v1 and
>> v2 messages and remind people what is currently working on. So I perfer to keep them.
>> Am I missing something?
>>
> 
> 
> This is a discussion about coding style, readability and maintainability (avoid future errors).
> And the code works today and the rest is opinions. That said, let me list some arguments why
> I don't like the casts.
> 
> Casts in general break the type checking of the compiler.
> 
> In some places e.g. clc.d0 points to struct smc_clc_msg_accept_confirm in other
> places it points to struct smc_clc_msg_accept_confirm_v2.
> This makes it hard to find all places where e.g. d0 is altered. (e.g. with an IDE).
> 
> You say: "smc_clc_msg_accept_confirm
>> and smc_clc_msg_accept_confirm_v2 clearly shows the difference between v1 and
>> v2 messages"
> But that is not even the case in the code that this patch changes:
> In smcd_clc_prep_confirm_accept() you pass a struct smc_clc_msg_accept_confirm_v2
> cast it to v1 (even in the v2 case) and then use the v1 layout for the common fields and
> the v1-only fields. So I don't think that helps very much.
> 
> The v2 messages were explicitely defined for compatibility. i.e.
> all v1 fields are still available. It would be good to see that in the code as well.
> With 2 differnet structs you don't emphasize that.
> 
> With future changes somebody could easily make a mistake that the 2 structures don't
> have the same size anymore. And then the casting can lead to out-of-bound error that
> are hard to find.
> 
> We want v2 to be the usual case and v1 to be the exception for backwards compatibility.
> FOr historic reasons, the code looks as if v2 is the exception. I'd rather point out the
> remaining v1 cases.
> 
> 
> 
> I could envision something like:
> 
> struct smc_clc_msg_accept_confirm {	/* clc accept / confirm message */
> 	struct smc_clc_msg_hdr hdr;
> 	union {
> 		struct { /* SMC-R */
> 			struct smcr_clc_msg_accept_confirm r0;
> 			/* v2 only, reserved and ignored in v1: */
> 			u8 eid[SMC_MAX_EID_LEN];
> 			u8 reserved6[8];
> 		} r1;
> 		struct { /* SMC-D */
> 			struct smcd_clc_msg_accept_confirm_common d0;
> 			/* v2 only, reserved and ignored in v1: */
> 			__be16 chid;
> 			u8 eid[SMC_MAX_EID_LEN];
> 			__be64 gid_ext;
> 		} __packed d1;
> 	};
> };
> 
> And then only use this one structure.
> 

Thank you Sandy for the detailed explanation.

What I considered, as mentioned above, is that if the two are combined,
it may be difficult to distinguish according to the name what situation
I am in, v1 or v2?

But I do agree with your concern about the potential errors that caused
by future divergence of the two struct if they are defined separately.

I will try to combine them into one struct in a seperate patch.

Thank you.


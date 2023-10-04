Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1EFA7B7A03
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241676AbjJDI1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 04:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjJDI1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:27:24 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9F7B4;
        Wed,  4 Oct 2023 01:27:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0VtMWrES_1696408036;
Received: from 30.13.48.40(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VtMWrES_1696408036)
          by smtp.aliyun-inc.com;
          Wed, 04 Oct 2023 16:27:18 +0800
Message-ID: <bcb4f377-715a-e7c3-8798-0c766be11201@linux.alibaba.com>
Date:   Wed, 4 Oct 2023 16:27:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v4 05/18] net/smc: reserve CHID range for SMC-D
 virtual device
To:     Alexandra Winter <wintera@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     schnelle@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        dust.li@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1695568613-125057-1-git-send-email-guwen@linux.alibaba.com>
 <1695568613-125057-6-git-send-email-guwen@linux.alibaba.com>
 <d5cf999b-ec76-844a-873b-e8767be9ffb5@linux.ibm.com>
 <987f4ee8-57ab-71c2-597d-7835c3e1e202@linux.ibm.com>
From:   Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <987f4ee8-57ab-71c2-597d-7835c3e1e202@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/28 17:10, Alexandra Winter wrote:
> 
> 
> On 28.09.23 05:08, Jan Karcher wrote:
>> On 24/09/2023 17:16, Wen Gu wrote:
>>> This patch reserve CHID range from 0xFF00 to 0xFFFF for SMC-D virtual
>>
>> The current state is that 0xFF00 - 0xFFFF is the range of all virtual SMC-D devices. This range devides into:
>> - 0xFF00 - 0xFFFE is for virto-ism
>> - 0xFFFF is for loopback
>>
>>
>>> device and introduces helpers to identify them.
>>>
>>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>>> ---
>>>    net/smc/smc_ism.h | 15 +++++++++++++++
>>>    1 file changed, 15 insertions(+)
>>>
>>> diff --git a/net/smc/smc_ism.h b/net/smc/smc_ism.h
>>> index 14d2e77..2ecc8de 100644
>>> --- a/net/smc/smc_ism.h
>>> +++ b/net/smc/smc_ism.h
>>> @@ -15,6 +15,9 @@
>>>      #include "smc.h"
>>>    +#define SMC_VIRT_ISM_CHID_MAX        0xFFFF
>>
>> SMC_VIRT_ISM_MAX is 0xFFFE. Or do you mean virtual devices as the whole group. If yes i think that this naming will be very confusing in a few months/years.
>> Maybe something like SMC_VIRTUAL_DEV_CHID_{MIN|MAX}?
> 
> 
> IMO names are important. They can make future lives easier or harder.
> 


Hi Sandy and Jan,

I agree with your opinion that names are important.

I view these terms in this way:

SMC-D devices (smcd_dev)
    |
    |- s390 ISM devices (ISM, ism_dev)
    |
    |- virtual ISM devices (virtual ISM, smc_lo_dev)
    |     |
    |     |- loopback-ism
    |     |
    |     |- virtio-ism
    |
    |- maybe future devices

SMC_VIRT_ISM_CHID_MAX was introduced to represent the maximum CHID of virtual ISM devices. CHIDs used
by virtual ISM devices should be in range of [SMC_VIRT_ISM_CHID_MIN, SMC_VIRT_ISM_CHID_MAX].

I think the problem here is that SMC_VIRT_ISM_CHID_MAX might be misunderstood as CHID of virtio-ism?
Then I will change them to SMC_VIRTUAL_ISM_CHID_{MAX|MIN}.

> Your first group of patches aims at 'decouple ISM device hard code from SMC-D stack'
> Maybe now would be a good point in time to decide what ISM should mean in net/smc.
> a) the s390 ISM devices
> b) SMC-D devices in general
> I would vote for a). (today a) and b) can be found in the code, as well as the term smcd_dev)
> 
> Then like Jan wrote above:
> "0xFF00 - 0xFFFF is the range of all virtual SMC-D devices" and it should NOT be called SMC_VIRT_ISM_CHID_MAX.
> 

Yes, I also vote for a).

But IMHO, loopback-ism and virtio-ism should be better classified as 'virtual ISM devices', like
what describes in the specification, rather than 'virtual SMC-D devices', since they are intended
to emulate ISM devices for using SMC-D on non-s390 systems.

> 
> Then in many places in net/smc 'ism' should be replaces by 'smcd_dev' or something similar.
> Wen Gu, is that something you would offer to do as part of the preparation work for this series?

Yes. But I'm not sure which 'ism' words you suggested to be replaced with 'smcd_dev'/'smcd'?

IMHO, in some generic codes like SMC-D operations (smcd_ops) or SMC-D device dump, they should
be generic to all kinds of SMC-D devices, so struct ism_dev or struct ism_client should not be used,
that is what patch#1 & #2 want to do.

But in some operations related to underlay device, like smcd_ism_register_dmb(), smc_ism_cantalk(),
and etc in smc_ism.c. They works for both s390 ISM devices and virtual ISM devices. I think they can
keep 'ism' in the helpers' name as they are now.

What do you think?

Thanks and regards,
Wen Gu





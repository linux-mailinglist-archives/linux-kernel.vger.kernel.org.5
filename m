Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC5B7AD9F7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 16:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjIYOUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 10:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjIYOUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 10:20:38 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE54B6;
        Mon, 25 Sep 2023 07:20:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0Vstdfqk_1695651625;
Received: from 30.221.129.66(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vstdfqk_1695651625)
          by smtp.aliyun-inc.com;
          Mon, 25 Sep 2023 22:20:26 +0800
Message-ID: <347ebb17-a18d-e2e1-99e1-4f819fe7511c@linux.alibaba.com>
Date:   Mon, 25 Sep 2023 22:20:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v4 09/18] net/smc: introduce SMC-D loopback
 device
To:     Alexandra Winter <wintera@linux.ibm.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     schnelle@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        dust.li@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1695568613-125057-1-git-send-email-guwen@linux.alibaba.com>
 <1695568613-125057-10-git-send-email-guwen@linux.alibaba.com>
 <3febdf3e-e213-7acf-7dd4-75d177676c3e@linux.ibm.com>
 <c4ba2015-d951-451a-f96c-2946bfb9611c@linux.ibm.com>
From:   Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <c4ba2015-d951-451a-f96c-2946bfb9611c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/25 21:29, Alexandra Winter wrote:
> 
> 
> On 25.09.23 13:50, Alexandra Winter wrote:
>>
>>
>> On 24.09.23 17:16, Wen Gu wrote:
>>> This patch introduces a kind of loopback device for SMC-D. The device
>>> is created when SMC module is loaded and destroyed when the SMC module
>>> is unloaded. The loopback device is a kernel device used only by the
>>> SMC module and is not restricted by net namespace, so it can be used
>>> for local inter-process or inter-container communication.
>>>
>>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>>> ---
>>>   net/smc/Kconfig        |  13 ++++
>>>   net/smc/Makefile       |   2 +-
>>>   net/smc/af_smc.c       |  12 +++-
>>>   net/smc/smc_loopback.c | 165 +++++++++++++++++++++++++++++++++++++++++++++++++
>>>   net/smc/smc_loopback.h |  33 ++++++++++
>>>   5 files changed, 223 insertions(+), 2 deletions(-)
>>>   create mode 100644 net/smc/smc_loopback.c
>>>   create mode 100644 net/smc/smc_loopback.h
>>
>>
>> Hello Wen Gu,
>>
>> thank you for adding the Kconfig, so the distributions can decide when to offer this feature.
>>
>> I propose you add some kind of runtime switch as well. Not every user who loads the SMC module
>> may want to exploit smcd-loopback. Especially in native environements without containers.
>>
>> If no RoCE interfaces or no ISM interfaces exist, the respective handling is skipped in SMC.
>> If loopback is always created unconditionally, there is no way to opt-out.
>>
> 
> Another thing came to my mind:
> 
> When loopback is created and registered when the SMC module is loaded, it will implicitly always have highest priority, right?
> That should be stated somewhere.
> Also, if you create a runtime switch this will change, so then you need to decide about priority of loopback vs ISM device (and other future smcd-devices).

Yes. I think the question may become 'How users to define the priority of existing the smcd devices'. In the past,
all the ISMv2 has nearly same performance so priority is not very important. But now there are other virtual ISM 
devices, they perform differently.

My rough idea is defining a fixed priority, such as whenever loopback-ism is enabled, it is always the first in the
slots. If fixed priority is not appropriate, low-priority devices can be prioritized by disabling high-priority devices.

So it seems that the runtime switch of the loopback-ism is even more necessary.

Thanks,
Wen Gu



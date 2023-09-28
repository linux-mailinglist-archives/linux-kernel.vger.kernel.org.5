Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB1B7B2560
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 20:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbjI1Sf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 14:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbjI1Sf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 14:35:57 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0CD11F;
        Thu, 28 Sep 2023 11:35:52 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0Vt2945o_1695926148;
Received: from 30.39.212.64(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vt2945o_1695926148)
          by smtp.aliyun-inc.com;
          Fri, 29 Sep 2023 02:35:50 +0800
Message-ID: <22858b56-dee0-e65f-a698-b0f2090a872d@linux.alibaba.com>
Date:   Fri, 29 Sep 2023 02:35:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v4 09/18] net/smc: introduce SMC-D loopback
 device
To:     Jan Karcher <jaka@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        dust.li@linux.alibaba.com, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     schnelle@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1695568613-125057-1-git-send-email-guwen@linux.alibaba.com>
 <1695568613-125057-10-git-send-email-guwen@linux.alibaba.com>
 <3febdf3e-e213-7acf-7dd4-75d177676c3e@linux.ibm.com>
 <20230925151816.GC92403@linux.alibaba.com>
 <3f71928e-157a-748e-42ee-4de3c80ed109@linux.ibm.com>
 <e85fe903-a025-a693-906b-834ff2a2a812@linux.ibm.com>
From:   Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <e85fe903-a025-a693-906b-834ff2a2a812@linux.ibm.com>
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



On 2023/9/28 11:16, Jan Karcher wrote:
> 
> 
> On 26/09/2023 09:24, Alexandra Winter wrote:
>>
>>
>> On 25.09.23 17:18, Dust Li wrote:
>>>> Hello Wen Gu,
>>>>
>>>> thank you for adding the Kconfig, so the distributions can decide when to offer this feature.
>>>>
>>>> I propose you add some kind of runtime switch as well. Not every user who loads the SMC module
>>>> may want to exploit smcd-loopback. Especially in native environements without containers.
>>>>
>>>> If no RoCE interfaces or no ISM interfaces exist, the respective handling is skipped in SMC.
>>>> If loopback is always created unconditionally, there is no way to opt-out.
>>> Hi Sandy,
>>>
>>> After talking to Wen Gu offline, I think the real issue here might be
>>> we don't have an abstract layer in SMC, something like net/core/dev.c
>>>
>>> Without this, we cannot do:
>>>
>>> 1. Enable/disable those devices dynamically
>>>     Currently, If we want to disable a SMC-R device to communicate with
>>>     others, we need to refer to 'ip link set dev xxx down' to disable the
>>>     netdevice, then Infiniband subsystem will notify SMC that the state of
>>>     the IB device has changed. We cannot explicitly choose not to use some
>>>     specific IB/RoCE devices without disable totally.
>>>     If the loopback device need to support enable/disable itself, I
>>>     think it might be better to enable this feature for all SMC devices.
>>>
>>> 2. Do statistics per device
>>>     Now, we have to relay on IB/RoCE devices' hardware statistics to see
>>>     how many packets/bytes we have sent through this device.
>>>
>>> Both the above issues get worse when the IB/RoCE device is shared by SMC
>>> and userspace RDMA applications. If SMC-R and userspace RDMA applications
>>> run at the same time, we can't enable the device to run userspace RDMA
>>> applications while block it from running SMC. For statistics, we cannot
>>> tell how many packets/bytes were sent by SMC and how many were sent by
>>> userspace RDMA applications.
>>>
>>> So I think those are better to support in the SMC layer.
>>>
>>> Best regards!
>>> Dust
>>
>> Thank you very much for your considerations. I also think a generic handling
>> of these requirements in the smc layer would be best. Especially, if we want
>> to add virtio-ism support soon. There we will face the same issues again.
>> Let's hear what others think about this.
>>
>>
> 
> Thanks you Sandy for bringing it up and Dust Li & Wen Gu for your thoughts.
> I agree that such a runtime switch is needed and also that this generic handling would be good in the smc layer.

Right. runtime switch is necessary. I'm trying some ways to see which one is more suitable.


As for implementing a abstract layer that capable of handling 1) enable/disable SMC usage of
RDMA/ISM devices. 2) count packets/bytes of RDMA/ISM devices that generated/consumed by SMC,
I believe it would be helpful, and IMHO its architecture may be:

----------------------------------------------
                   SMC protocol
     (af_smc.c / smc_core.c / smc_clc.c ...)
----------------------------------------------
           Abstract layer of SMC device
       (define SMC device common operations)
----------------------------------------------
   RDMA device |        (virt) ISM device
   (smc_ib.c)  |   (smc_ism.c / smc_loopback.c)
----------------------------------------------

But I also believe this may require a lot of works and may be a long-term job.

If only for the virtual ISM device, e.g.loopback-ism, I am considering adding it to the Linux
device tree (/sys/devices/virtual/) to make it more 'device-like', and controlling its
enable/disable and get the statistics through some files, such as
echo 1 > /sys/devices/virtual/loopback-ism/alive
or
cat /sys/devices/virtual/loopback-ism/statistics/{rx|tx}_{bytes|packets}
(similar to what tcp lo have in /sys/devices/virtual/net/lo)

What are your thoughts on it? Thanks.


--
A little off-topic, it's currently China's National Day holiday, which lasts for about a week,
so we are now on vacation. As a result, my responses might be a bit slower, but I will still
make time to check/reply the mail and prepare for my new version. Thank you all very much!

Regards,
Wen Gu

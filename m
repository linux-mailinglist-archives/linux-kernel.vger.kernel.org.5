Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F34A7ADB33
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbjIYPSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbjIYPSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:18:35 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41FE101;
        Mon, 25 Sep 2023 08:18:22 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0VsthvN7_1695655096;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0VsthvN7_1695655096)
          by smtp.aliyun-inc.com;
          Mon, 25 Sep 2023 23:18:17 +0800
Date:   Mon, 25 Sep 2023 23:18:16 +0800
From:   Dust Li <dust.li@linux.alibaba.com>
To:     Alexandra Winter <wintera@linux.ibm.com>,
        Wen Gu <guwen@linux.alibaba.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     schnelle@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 09/18] net/smc: introduce SMC-D loopback
 device
Message-ID: <20230925151816.GC92403@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <1695568613-125057-1-git-send-email-guwen@linux.alibaba.com>
 <1695568613-125057-10-git-send-email-guwen@linux.alibaba.com>
 <3febdf3e-e213-7acf-7dd4-75d177676c3e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3febdf3e-e213-7acf-7dd4-75d177676c3e@linux.ibm.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 01:50:22PM +0200, Alexandra Winter wrote:
>
>
>On 24.09.23 17:16, Wen Gu wrote:
>> This patch introduces a kind of loopback device for SMC-D. The device
>> is created when SMC module is loaded and destroyed when the SMC module
>> is unloaded. The loopback device is a kernel device used only by the
>> SMC module and is not restricted by net namespace, so it can be used
>> for local inter-process or inter-container communication.
>> 
>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>> ---
>>  net/smc/Kconfig        |  13 ++++
>>  net/smc/Makefile       |   2 +-
>>  net/smc/af_smc.c       |  12 +++-
>>  net/smc/smc_loopback.c | 165 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  net/smc/smc_loopback.h |  33 ++++++++++
>>  5 files changed, 223 insertions(+), 2 deletions(-)
>>  create mode 100644 net/smc/smc_loopback.c
>>  create mode 100644 net/smc/smc_loopback.h
>
>
>Hello Wen Gu,
>
>thank you for adding the Kconfig, so the distributions can decide when to offer this feature.
>
>I propose you add some kind of runtime switch as well. Not every user who loads the SMC module
>may want to exploit smcd-loopback. Especially in native environements without containers.
>
>If no RoCE interfaces or no ISM interfaces exist, the respective handling is skipped in SMC.
>If loopback is always created unconditionally, there is no way to opt-out.

Hi Sandy,

After talking to Wen Gu offline, I think the real issue here might be
we don't have an abstract layer in SMC, something like net/core/dev.c

Without this, we cannot do:

1. Enable/disable those devices dynamically
   Currently, If we want to disable a SMC-R device to communicate with
   others, we need to refer to 'ip link set dev xxx down' to disable the
   netdevice, then Infiniband subsystem will notify SMC that the state of
   the IB device has changed. We cannot explicitly choose not to use some
   specific IB/RoCE devices without disable totally.
   If the loopback device need to support enable/disable itself, I
   think it might be better to enable this feature for all SMC devices.

2. Do statistics per device
   Now, we have to relay on IB/RoCE devices' hardware statistics to see
   how many packets/bytes we have sent through this device.

Both the above issues get worse when the IB/RoCE device is shared by SMC
and userspace RDMA applications. If SMC-R and userspace RDMA applications
run at the same time, we can't enable the device to run userspace RDMA
applications while block it from running SMC. For statistics, we cannot
tell how many packets/bytes were sent by SMC and how many were sent by
userspace RDMA applications.

So I think those are better to support in the SMC layer.

Best regards!
Dust

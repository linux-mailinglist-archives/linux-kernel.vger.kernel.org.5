Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4316E7C6DCC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 14:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378366AbjJLMRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 08:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343908AbjJLMRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 08:17:46 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E792B7;
        Thu, 12 Oct 2023 05:17:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0Vu-eJHp_1697113061;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0Vu-eJHp_1697113061)
          by smtp.aliyun-inc.com;
          Thu, 12 Oct 2023 20:17:41 +0800
Date:   Thu, 12 Oct 2023 20:17:40 +0800
From:   Dust Li <dust.li@linux.alibaba.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Albert Huang <huangjie.albert@bytedance.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>
Cc:     "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/smc: add support for netdevice in
 containers.
Message-ID: <20231012121740.GR92403@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20230925023546.9964-1-huangjie.albert@bytedance.com>
 <00bbbf48440c1889ecd16a590ebb746b820a4f48.camel@linux.ibm.com>
 <20231011144816.GO92403@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231011144816.GO92403@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 10:48:16PM +0800, Dust Li wrote:
>On Thu, Sep 28, 2023 at 05:04:21PM +0200, Niklas Schnelle wrote:
>>On Mon, 2023-09-25 at 10:35 +0800, Albert Huang wrote:
>>> If the netdevice is within a container and communicates externally
>>> through network technologies like VXLAN, we won't be able to find
>>> routing information in the init_net namespace. To address this issue,
>>> we need to add a struct net parameter to the smc_ib_find_route function.
>>> This allow us to locate the routing information within the corresponding
>>> net namespace, ensuring the correct completion of the SMC CLC interaction.
>>> 
>>> Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
>>> ---
>>>  net/smc/af_smc.c | 3 ++-
>>>  net/smc/smc_ib.c | 7 ++++---
>>>  net/smc/smc_ib.h | 2 +-
>>>  3 files changed, 7 insertions(+), 5 deletions(-)
>>> 
>>
>>I'm trying to test this patch on s390x but I'm running into the same
>>issue I ran into with the original SMC namespace
>>support:https://lore.kernel.org/netdev/8701fa4557026983a9ec687cfdd7ac5b3b85fd39.camel@linux.ibm.com/
>>
>>Just like back then I'm using a server and a client network namespace
>>on the same system with two ConnectX-4 VFs from the same card and port.
>>Both TCP/IP traffic as well as user-space RDMA via "qperf … rc_bw" and
>>`qperf … rc_lat` work between namespaces and definitely go via the
>>card.
>>
>>I did use "rdma system set netns exclusive" then moved the RDMA devices
>>into the namespaces with "rdma dev set <rdma_dev> netns <namespace>". I
>>also verified with "ip netns exec <namespace> rdma dev"
>>that the RDMA devices are in the network namespace and as seen by the
>>qperf runs normal RDMA does work.
>>
>>For reference the smc_chck tool gives me the following output:
>>
>>Server started on port 37373
>>[DEBUG] Interfaces to check: eno4378
>>Test with target IP 10.10.93.12 and port 37373
>>  Live test (SMC-D and SMC-R)
>>[DEBUG] Running client: smc_run /tmp/echo-clt.x0q8iO 10.10.93.12 -p
>>37373
>>[DEBUG] Client result: TCP 0x05000000/0x03030000
>>     Failed  (TCP fallback), reasons:
>>          Client:        0x05000000   Peer declined during handshake
>>          Server:        0x03030000   No SMC devices found (R and D)
>>
>>I also checked that SMC is generally working, once I add an ISM device
>>I do get SMC-D between the namespaces. Any ideas what could break SMC-R
>>here?
>
>I missed the email :(
>
>Are you running SMC-Rv2 or v1 ?

Hi Niklas,

I tried your test today, and I encounter the same issue.
But I found it's because my 2 VFs are in difference subnets,
SMC-Rv2 work fine, SMC-Rv1 won't work, which is expected.
When I set the 2 VFs in the same subnet, SMC-Rv1 also works.

So I'm not sure it's the same for you. Can you check it out ?

BTW, the fallback reason(SMC_CLC_DECL_NOSMCDEV) in this case
is really not friendly, it's better to return SMC_CLC_DECL_DIFFPREFIX.

Best regards,
Dust


>
>Best regards,
>Dust
>
>
>>
>>Thanks,
>>Niklas

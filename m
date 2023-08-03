Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D91E76ED6B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbjHCPBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbjHCPBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:01:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D058173F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 08:01:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2A9361DEE
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 15:01:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B58FC433C8;
        Thu,  3 Aug 2023 15:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691074903;
        bh=x0b7u5XFNxoM7ml5cInA0lkjUPtAMr2eoeGroLFHjw8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RKXtPuSFBEQPTmQqg+5qKMqk1wE2HgIgsj9S+WCnTVQ+nsy2VuJTAbWHxm8vhiuWM
         USuTZlTufLiXwvGw/8y2jaDLvk50AZwHM3KvpKBk+CsDCkEnjTW6Ds+cM5rjEAFF8k
         XakUgALC3Ki+6s0kzSxAI++9pQ2NjdDxnSXOjvR6eo1Z8eRJksazFcF6rjF0lnDR9t
         piRMKu7xAuHF74Eo2VSGGxjUnNmkf2w+LkA88nRCpNiOnMBl/85tNttJOpZSL2Tv3C
         JjeP25jUDHRjwhVTtUZFxzH6RQpNn1Hy1vZKNWjsJOuZgXgbRi2wrK1YMuWHZS9g8J
         HjJjaQWitqhFQ==
Message-ID: <ae2ef15a-c601-eb5d-66bc-edaae6bda1c3@kernel.org>
Date:   Thu, 3 Aug 2023 17:01:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC Optimizing veth xsk performance 00/10]
Content-Language: en-US
To:     "huangjie.albert" <huangjie.albert@bytedance.com>,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, Maryam Tahhan <mtahhan@redhat.com>,
        Keith Wiles <keith.wiles@intel.com>,
        Liang Chen <liangchen.linux@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Kees Cook <keescook@chromium.org>,
        Richard Gobert <richardbgobert@gmail.com>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
References: <20230803140441.53596-1-huangjie.albert@bytedance.com>
From:   Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20230803140441.53596-1-huangjie.albert@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/08/2023 16.04, huangjie.albert wrote:
> AF_XDP is a kernel bypass technology that can greatly improve performance.
> However, for virtual devices like veth, even with the use of AF_XDP sockets,
> there are still many additional software paths that consume CPU resources.
> This patch series focuses on optimizing the performance of AF_XDP sockets
> for veth virtual devices. Patches 1 to 4 mainly involve preparatory work.
> Patch 5 introduces tx queue and tx napi for packet transmission, while
> patch 9 primarily implements zero-copy, and patch 10 adds support for
> batch sending of IPv4 UDP packets. These optimizations significantly reduce
> the software path and support checksum offload.
> 
> I tested those feature with
> A typical topology is shown below:
> veth<-->veth-peer                                    veth1-peer<--->veth1
> 	1       |                                                  |   7
> 	        |2                                                6|
> 	        |                                                  |
> 	      bridge<------->eth0(mlnx5)- switch -eth1(mlnx5)<--->bridge1
>                    3                    4                 5
>               (machine1)                              (machine2)
> AF_XDP socket is attach to veth and veth1. and send packets to physical NIC(eth0)
> veth:(172.17.0.2/24)
> bridge:(172.17.0.1/24)
> eth0:(192.168.156.66/24)
> 
> eth1(172.17.0.2/24)
> bridge1:(172.17.0.1/24)
> eth0:(192.168.156.88/24)
> 
> after set default route、snat、dnat. we can have a tests
> to get the performance results.
> 
> packets send from veth to veth1:
> af_xdp test tool:
> link:https://github.com/cclinuxer/libxudp
> send:(veth)
> ./objs/xudpperf send --dst 192.168.156.88:6002 -l 1300
> recv:(veth1)
> ./objs/xudpperf recv --src 172.17.0.2:6002
> 
> udp test tool:iperf3
> send:(veth)
> iperf3 -c 192.168.156.88 -p 6002 -l 1300 -b 60G -u
> recv:(veth1)
> iperf3 -s -p 6002
> 
> performance:
> performance:(test weth libxdp lib)
> UDP                              : 250 Kpps (with 100% cpu)
> AF_XDP   no  zerocopy + no batch : 480 Kpps (with ksoftirqd 100% cpu)
> AF_XDP  with zerocopy + no batch : 540 Kpps (with ksoftirqd 100% cpu)
> AF_XDP  with  batch  +  zerocopy : 1.5 Mpps (with ksoftirqd 15% cpu)
> 
> With af_xdp batch, the libxdp user-space program reaches a bottleneck.

Do you mean libxdp [1] or libxudp ?

[1] https://github.com/xdp-project/xdp-tools/tree/master/lib/libxdp

> Therefore, the softirq did not reach the limit.
> 
> This is just an RFC patch series, and some code details still need
> further consideration. Please review this proposal.
>

I find this performance work interesting as we have customer requests
(via Maryam (cc)) to improve AF_XDP performance both native and on veth.

Our benchmark is stored at:
  https://github.com/maryamtahhan/veth-benchmark

Great to see other companies also interested in this area.

--Jesper

> thanks!
> 
> huangjie.albert (10):
>    veth: Implement ethtool's get_ringparam() callback
>    xsk: add dma_check_skip for  skipping dma check
>    veth: add support for send queue
>    xsk: add xsk_tx_completed_addr function
>    veth: use send queue tx napi to xmit xsk tx desc
>    veth: add ndo_xsk_wakeup callback for veth
>    sk_buff: add destructor_arg_xsk_pool for zero copy
>    xdp: add xdp_mem_type MEM_TYPE_XSK_BUFF_POOL_TX
>    veth: support zero copy for af xdp
>    veth: af_xdp tx batch support for ipv4 udp
> 
>   drivers/net/veth.c          | 729 +++++++++++++++++++++++++++++++++++-
>   include/linux/skbuff.h      |   1 +
>   include/net/xdp.h           |   1 +
>   include/net/xdp_sock_drv.h  |   1 +
>   include/net/xsk_buff_pool.h |   1 +
>   net/xdp/xsk.c               |   6 +
>   net/xdp/xsk_buff_pool.c     |   3 +-
>   net/xdp/xsk_queue.h         |  11 +
>   8 files changed, 751 insertions(+), 2 deletions(-)
> 

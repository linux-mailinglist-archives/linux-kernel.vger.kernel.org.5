Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D38F77E41C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244137AbjHPOt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbjHPOtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:49:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF08B10E9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 07:49:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 764F8669FE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:49:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838C5C433C7;
        Wed, 16 Aug 2023 14:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692197340;
        bh=5orDRygPlvZ4yVEGQF5hK8JtQyCELRkheE2WtCwrV/g=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=gtz89zNPXRQTDcGTXRk35M4L05w+jqnAaLlsIAJ1nt+JJEziAwoAkCIo56zeJpH6i
         /MekK3Q/ccbXyomfOYZY4hW9nqbr9tmAYrQ8jGkO68AftAt4mtmIkHubb53+74oZWl
         Tx59kJO5ij0DEpyH5D0nwRSw+ZDyxTtrY1pbe6IVPCaG6a3j9SDfnERGEmbvXtnOP0
         i2ZOCfSNDpOAtlSyO++T0ngAV2hHcpIoQZEY4cLX6wxp69uyVC6SRbUSiar5jKRht4
         mxz1Ru1ably6Z7zQCNDaxa0X4RTPqwQqsBp5sdA3A9XBtUy6tMuQlL0S/v0QY7Mgsy
         7rg+BYLvybQbw==
Message-ID: <d1b510a0-139a-285d-1a80-2592ea98b0d6@kernel.org>
Date:   Wed, 16 Aug 2023 16:48:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     hawk@kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wander Lairson Costa <wander@redhat.com>,
        linux-kernel@vger.kernel.org,
        kernel-team <kernel-team@cloudflare.com>,
        Yan Zhai <yan@cloudflare.com>
Subject: Re: [RFC PATCH 2/2] softirq: Drop the warning from
 do_softirq_post_smp_call_flush().
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
References: <20230814093528.117342-1-bigeasy@linutronix.de>
 <20230814093528.117342-3-bigeasy@linutronix.de>
 <25de7655-6084-e6b9-1af6-c47b3d3b7dc1@kernel.org>
From:   Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <25de7655-6084-e6b9-1af6-c47b3d3b7dc1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/08/2023 14.08, Jesper Dangaard Brouer wrote:
> 
> 
> On 14/08/2023 11.35, Sebastian Andrzej Siewior wrote:
>> This is an undesired situation and it has been attempted to avoid the
>> situation in which ksoftirqd becomes scheduled. This changed since
>> commit d15121be74856 ("Revert "softirq: Let ksoftirqd do its job"")
>> and now a threaded interrupt handler will handle soft interrupts at its
>> end even if ksoftirqd is pending. That means that they will be processed
>> in the context in which they were raised.
> 
> $ git describe --contains d15121be74856
> v6.5-rc1~232^2~4
> 
> That revert basically removes the "overload" protection that was added
> to cope with DDoS situations in Aug 2016 (Cc. Cloudflare).  As described
> in https://git.kernel.org/torvalds/c/4cd13c21b207 ("softirq: Let
> ksoftirqd do its job") in UDP overload situations when UDP socket
> receiver runs on same CPU as ksoftirqd it "falls-off-an-edge" and almost
> doesn't process packets (because softirq steals CPU/sched time from UDP
> pid).  Warning Cloudflare (Cc) as this might affect their production
> use-cases, and I recommend getting involved to evaluate the effect of
> these changes.
> 

I did some testing on net-next (with commit d15121be74856 ("Revert 
"softirq: Let ksoftirqd do its job"") using UDP pktgen + udp_sink.

And I observe the old overload issue occur again, where userspace 
process (udp_sink) process very few packets when running on *same* CPU 
as the NAPI-RX/IRQ processing.  The perf report "comm" clearly shows 
that NAPI runs in the context of the "udp_sink" process, stealing its 
sched time. (Same CPU around 3Kpps and diff CPU 1722Kpps, see details 
below).
What happens are that NAPI takes 64 packets and queue them to the 
udp_sink process *socket*, the udp_sink process *wakeup* process 1 
packet from socket queue and on exit (__local_bh_enable_ip) runs softirq 
that starts NAPI (to again process 64 packets... repeat).


> I do realize/acknowledge that the reverted patch caused other latency
> issues, given it was a "big-hammer" approach affecting other softirq
> processing (as can be seen by e.g. the watchdog fixes patches).
> Thus, the revert makes sense, but how to regain the "overload"
> protection such that RX networking cannot starve processes reading from
> the socket? (is this what Sebastian's patchset does?)
> 

I'm no expert in sched / softirq area of the kernel, but I'm willing to 
help out testing different solution that can regain the "overload" 
protection e.g. avoid packet processing "falls-of-an-edge" (and thus 
opens the kernel to be DDoS'ed easily).
Is this what Sebastian's patchset does?


> 
> Thread link for people Cc'ed: 
> https://lore.kernel.org/all/20230814093528.117342-1-bigeasy@linutronix.de/#r

--Jesper
(some testlab results below)

[udp_sink] 
https://github.com/netoptimizer/network-testing/blob/master/src/udp_sink.c


When udp_sink runs on same CPU and NAPI/softirq
  - UdpInDatagrams: 2,948 packets/sec

$ nstat -n && sleep 1 && nstat
#kernel
IpInReceives                    2831056            0.0
IpInDelivers                    2831053            0.0
UdpInDatagrams                  2948               0.0
UdpInErrors                     2828118            0.0
UdpRcvbufErrors                 2828118            0.0
IpExtInOctets                   130206496          0.0
IpExtInNoECTPkts                2830576            0.0

When udp_sink runs on another CPU than NAPI-RX.
  - UdpInDatagrams: 1,722,307 pps

$ nstat -n && sleep 1 && nstat
#kernel
IpInReceives                    2318560            0.0
IpInDelivers                    2318562            0.0
UdpInDatagrams                  1722307            0.0
UdpInErrors                     596280             0.0
UdpRcvbufErrors                 596280             0.0
IpExtInOctets                   106634256          0.0
IpExtInNoECTPkts                2318136            0.0



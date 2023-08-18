Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5DC0780F95
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378328AbjHRPty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378319AbjHRPto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:49:44 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CAC2708
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 08:49:41 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4ff9bbc83a5so1524733e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 08:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1692373779; x=1692978579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znny6fIRfvTqHyHWz1UgoG6TuClSy2elyfBuTD5U/50=;
        b=IY/SQJI1XcgdcOxllWZmm4qePwALmm0StMaaCJBx3bV4djEnsZk/dXjp3PWlGHKior
         AO6qjRVvCp8f0HXwbqLBoScaooofxq4WQXw54otCvPfytSvZ9L5ae6elZ6r+zx/SZ6rh
         rh1u7TByxCNYyxWkKw7K5eIsY+a0Oj2FHSt6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692373779; x=1692978579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=znny6fIRfvTqHyHWz1UgoG6TuClSy2elyfBuTD5U/50=;
        b=ctZ3fwNpPakLorG1SZyuJR99Ecwik1+kBpjL5mS0WlPwWnx+f4BdIceiCyEDdvA9P1
         mMId9jCs5871BAUFfgJVF4GETLg0/x82L9E/z8l4CuEmT/fLIuQFhkbsEYmUb96y7FKu
         FJxcQD5fOpNE/LdzjNz7qTBFH8NdtvTtZWW+iifFM8UJCjwHuMyuzII4cVDmm0nKO4ea
         yLpuuwrNc6G9UOHfQvMaiDV3F1KJQrrRZhqeZk19i6R2OLHE3nrJ6DlIQF55QlPEEbgo
         lY9Fh/qjmrLpiA2UUzrx2yeoTqcCWluQ/W6FK9TgsYe6D96paPJkbDHmKXZbQU2Rl1tQ
         pngQ==
X-Gm-Message-State: AOJu0YxdiyaMQrSULSTVnB4OIHEDh5lFa1aEG0by7WLAcfYEMIfnhOUC
        tb54ufrhxHROWG9PQ423p8EdnwV9svPSy86guHYiiw==
X-Google-Smtp-Source: AGHT+IFfruc+ZBLYo5S2tWVLhjbh4871yMa/mqJPqMPpLehAhjUyL+mbOL5nCua/l+8s/OFD11umZ+9v9aExokeyx6o=
X-Received: by 2002:a05:6512:3c96:b0:4fd:fecf:5d57 with SMTP id
 h22-20020a0565123c9600b004fdfecf5d57mr2778788lfv.39.1692373779255; Fri, 18
 Aug 2023 08:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230814093528.117342-1-bigeasy@linutronix.de>
 <20230814093528.117342-3-bigeasy@linutronix.de> <25de7655-6084-e6b9-1af6-c47b3d3b7dc1@kernel.org>
 <d1b510a0-139a-285d-1a80-2592ea98b0d6@kernel.org> <CAO3-PbpbrK6FAACw5TQyBxJ6jgO7_bhLFuPVAziUE+40_o_GnA@mail.gmail.com>
 <22d992aa-2b65-0de3-b88c-fd216ae0218e@redhat.com>
In-Reply-To: <22d992aa-2b65-0de3-b88c-fd216ae0218e@redhat.com>
From:   Yan Zhai <yan@cloudflare.com>
Date:   Fri, 18 Aug 2023 10:49:28 -0500
Message-ID: <CAO3-Pbp13sG7fZJj1DbwEAfKmFt46uSZb6NF-NB0SsBds-kd0g@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] softirq: Drop the warning from do_softirq_post_smp_call_flush().
To:     Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc:     Jesper Dangaard Brouer <hawk@kernel.org>, brouer@redhat.com,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wander Lairson Costa <wander@redhat.com>,
        linux-kernel@vger.kernel.org,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 4:02=E2=80=AFPM Jesper Dangaard Brouer
<jbrouer@redhat.com> wrote:
>
>
>
> On 16/08/2023 17.15, Yan Zhai wrote:
> > On Wed, Aug 16, 2023 at 9:49=E2=80=AFAM Jesper Dangaard Brouer <hawk@ke=
rnel.org> wrote:
> >>
> >> On 15/08/2023 14.08, Jesper Dangaard Brouer wrote:
> >>>
> >>>
> >>> On 14/08/2023 11.35, Sebastian Andrzej Siewior wrote:
> >>>> This is an undesired situation and it has been attempted to avoid th=
e
> >>>> situation in which ksoftirqd becomes scheduled. This changed since
> >>>> commit d15121be74856 ("Revert "softirq: Let ksoftirqd do its job"")
> >>>> and now a threaded interrupt handler will handle soft interrupts at =
its
> >>>> end even if ksoftirqd is pending. That means that they will be proce=
ssed
> >>>> in the context in which they were raised.
> >>>
> >>> $ git describe --contains d15121be74856
> >>> v6.5-rc1~232^2~4
> >>>
> >>> That revert basically removes the "overload" protection that was adde=
d
> >>> to cope with DDoS situations in Aug 2016 (Cc. Cloudflare).  As descri=
bed
> >>> in https://git.kernel.org/torvalds/c/4cd13c21b207 ("softirq: Let
> >>> ksoftirqd do its job") in UDP overload situations when UDP socket
> >>> receiver runs on same CPU as ksoftirqd it "falls-off-an-edge" and alm=
ost
> >>> doesn't process packets (because softirq steals CPU/sched time from U=
DP
> >>> pid).  Warning Cloudflare (Cc) as this might affect their production
> >>> use-cases, and I recommend getting involved to evaluate the effect of
> >>> these changes.
> >>>
> >>
> >> I did some testing on net-next (with commit d15121be74856 ("Revert
> >> "softirq: Let ksoftirqd do its job"") using UDP pktgen + udp_sink.
> >>
> >> And I observe the old overload issue occur again, where userspace
> >> process (udp_sink) process very few packets when running on *same* CPU
> >> as the NAPI-RX/IRQ processing.  The perf report "comm" clearly shows
> >> that NAPI runs in the context of the "udp_sink" process, stealing its
> >> sched time. (Same CPU around 3Kpps and diff CPU 1722Kpps, see details
> >> below).
> >> What happens are that NAPI takes 64 packets and queue them to the
> >> udp_sink process *socket*, the udp_sink process *wakeup* process 1
> >> packet from socket queue and on exit (__local_bh_enable_ip) runs softi=
rq
> >> that starts NAPI (to again process 64 packets... repeat).
> >>
> > I think there are two scenarios to consider:
>  >
> > 1. Actual DoS scenario. In this case, we would drop DoS packets
> > through XDP, which might actually relieve the stress. According to
> > Marek's blog XDP can indeed drop 10M pps [1] so it might not steal too
> > much time. This is also something I would like to validate again since
>
> Yes, using XDP to drop packet will/should relieve the stress, as it
> basically can discard some of the 64 packets processed by NAPI vs the 1
> packet received by userspace (that re-trigger NAPI), giving a better
> balance.
>
> > I cannot tell if those tests were performed before or after the
> > reverted commit.
>
> Marek's tests will likely contain the patch 4cd13c21b207 ("softirq: Let
> ksoftirqd do its job") as blog is from 2018 and patch from 2016, but
> shouldn't matter much.
>
>
> > 2. Legit elephant flows (so it should not be just dropped). This one
> > is closer to what you tested above, and it is a much harder issue
> > since packets are legit and should not be dropped early at XDP. Let
> > the scheduler move affected processes away seems to be the non-optimal
> > but straight answer for now. However, I suspect this would impose an
> > overload issue for those programmed with RFS or ARFS, since flows
> > would "follow" the processes. They probably have to force threaded
> > NAPI for tuning.
> >
>
> True, this is the case I don't know how to solve.
>
> For UDP packets it is NOT optimal to let the process "follow"/run on the
> NAPI-RX CPU. For TCP traffic it is faster to run on same CPU, which
> could be related to GRO effect, or simply that tcp_recvmsg gets a stream
> of data (before it invokes __local_bh_enable_ip causing do_softirq).
>
To maximize single flow throughput, it is not optimal to run RX on the
same CPU with the receiver, regardless of TCP or UDP. The difference
is that TCP does not have tput issue until 10+ Gbps thanks to GRO. In
some internal benchmarking effort, I found that pinning iperf server
on the same RX would yield ~13-14 Gbps TCP while running on different
cores would have 25G NIC saturated (for both same or different NUMA
case). Despite single flow throughput upper bound getting hit when
running on the same core, CPU cycles to process each packet is
actually reduced. So it is likely more friendly to the production
environment we are dealing with where there are a lot more smaller
flows. It is something I planned to test more (in the past we had
major services pinned on dedicated cores, but recently we start to
unpin to improve tail latency of other services). But with the
protection gone, it adds quite some uncertainty to the picture.

> I have also tested with netperf UDP packets[2] in a scenario that
> doesn't cause "overload" and CPU have idle cycles.  When UDP-netserver
> is running on same CPU as NAPI then I see approx 38% (82020/216362)
> UdpRcvbufErrors [3] (and separate CPUs 2.8%).  Sure, I could increase
> buffer size, but the point is NAPI can enqueue 64 packet and UDP
> receiver dequeue 1 packet.
>
> This reminded me that kernel have a recvmmsg (extra "m") syscall for
> multiple packets.  I tested this (as udop_sink have support), but no
> luck. This is because internally in the kernel (do_recvmmsg) is just a
> loop over ___sys_recvmsg/__skb_recv_udp, which have a BH-spinlock per
> packet that invokes __local_bh_enable_ip/do_softirq.  I guess, we/netdev
> could fix recvmmsg() to bulk-dequeue from socket queue (BH-socket unlock
> is triggering __local_bh_enable_ip/do_softirq) and then have a solution
> for UDP(?).
>
recvmmsg does help getting more packets in a batch, but it has an
issue of buffer allocation upfront: when there are millions of
connections, preallocate too many buffers can mount up memory pressure
a lot.
On an alternative view, enable UDP GRO seems a direct help in this
context, to bring UDP on par with TCP, and reduce the RX overhead. We
already have quite some UDP GRO/GSO use cases for virtual machines and
QUIC handling, time to persuade engineers to add more maybe.

Yan

>
> [2] netperf -H 198.18.1.1 -D1 -l 1200 -t UDP_STREAM -T 0,0 -- -m 1472 -N =
-n
>
> [3]
> $ nstat -n && sleep 1 && nstat
> #kernel
> IpInReceives                    216362             0.0
> IpInDelivers                    216354             0.0
> UdpInDatagrams                  134356             0.0
> UdpInErrors                     82020              0.0
> UdpRcvbufErrors                 82020              0.0
> IpExtInOctets                   324600000          0.0
> IpExtInNoECTPkts                216400             0.0
>
>
> > [1] https://blog.cloudflare.com/how-to-drop-10-million-packets/
> >
> >>
> >>> I do realize/acknowledge that the reverted patch caused other latency
> >>> issues, given it was a "big-hammer" approach affecting other softirq
> >>> processing (as can be seen by e.g. the watchdog fixes patches).
> >>> Thus, the revert makes sense, but how to regain the "overload"
> >>> protection such that RX networking cannot starve processes reading fr=
om
> >>> the socket? (is this what Sebastian's patchset does?)
> >>>
> >>
> >> I'm no expert in sched / softirq area of the kernel, but I'm willing t=
o
> >> help out testing different solution that can regain the "overload"
> >> protection e.g. avoid packet processing "falls-of-an-edge" (and thus
> >> opens the kernel to be DDoS'ed easily).
> >> Is this what Sebastian's patchset does?
> >>
> >>
> >>>
> >>> Thread link for people Cc'ed:
> >>> https://lore.kernel.org/all/20230814093528.117342-1-bigeasy@linutroni=
x.de/#r
> >>
> >> --Jesper
> >> (some testlab results below)
> >>
> >> [udp_sink]
> >> https://github.com/netoptimizer/network-testing/blob/master/src/udp_si=
nk.c
> >>
> >>
> >> When udp_sink runs on same CPU and NAPI/softirq
> >>    - UdpInDatagrams: 2,948 packets/sec
> >>
> >> $ nstat -n && sleep 1 && nstat
> >> #kernel
> >> IpInReceives                    2831056            0.0
> >> IpInDelivers                    2831053            0.0
> >> UdpInDatagrams                  2948               0.0
> >> UdpInErrors                     2828118            0.0
> >> UdpRcvbufErrors                 2828118            0.0
> >> IpExtInOctets                   130206496          0.0
> >> IpExtInNoECTPkts                2830576            0.0
> >>
> >> When udp_sink runs on another CPU than NAPI-RX.
> >>    - UdpInDatagrams: 1,722,307 pps
> >>
> >> $ nstat -n && sleep 1 && nstat
> >> #kernel
> >> IpInReceives                    2318560            0.0
> >> IpInDelivers                    2318562            0.0
> >> UdpInDatagrams                  1722307            0.0
> >> UdpInErrors                     596280             0.0
> >> UdpRcvbufErrors                 596280             0.0
> >> IpExtInOctets                   106634256          0.0
> >> IpExtInNoECTPkts                2318136            0.0
> >>
> >>
> >
> >
>


--=20

Yan

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FE177EB4F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 23:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346361AbjHPVDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 17:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346351AbjHPVD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 17:03:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850E8271E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692219759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8vfuTn77aRfOG4i7w9NqeclBENHFQ5LgJNDx3PV37XM=;
        b=huiYKWJXoZA980iVbiRKpYEhDjSG2aTUfCVCxgFlFg4m4hxNXgKBAwhrEHsBFEmR1XjtCu
        3/iadJHSxPTuiQ0N2RtgYKGkfH20Jr63jzCj7luo23ArI0SzC7Fq/IlD+QCgpIGhLo+fd7
        PZK/ETXL+k5ktbEK7ZM0fPj557MR1hg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-4WWfEcY8P7SARYzq1nEOSg-1; Wed, 16 Aug 2023 17:02:38 -0400
X-MC-Unique: 4WWfEcY8P7SARYzq1nEOSg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-523204878d9so4277477a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:02:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692219756; x=1692824556;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8vfuTn77aRfOG4i7w9NqeclBENHFQ5LgJNDx3PV37XM=;
        b=APpPGPVTXTD6RBlmmsNf0xEV0ZuxGW0EcVr2ylmRVKAJXYXEHQgXTHEmw6thnFDYRH
         BoZ2J28OsFJBll8rtFEmAzEKBpfYfTHV4zro9gjrWjw81lBnlWknKNZ7SmB+TXFaj/bp
         5pV6+hUUeYI05YMwm00lzaZNnHrMPHIEQRVl3xMC9h1izgf6LLb4lKBgaxY1TBPBcyWv
         F8tEgXpNuWHv98ugfY5rivebPxO73eh+RoFgQTAgj0X8vuFw5FqY5RekqXJt7TQwLEXp
         Z7IveSLueSWjDFexeWjs9Ax1extTHmC8vEz24y+YeshEzsyBobv+6KsLtcUYrA5xsjve
         4fyw==
X-Gm-Message-State: AOJu0Yy039HwWDhdspnM5cEgWyVUNDKqmNomvW0BGiE1lHwd8DqOKtx6
        739rzl/q9or8XRV2ThN5getCqYK/YAFI5nGpsa57Xg58NkzOcxGtgl2advW4qtqFO1oJqlNjFBy
        2/oqzHNzdNAPoSury8u/K8jez
X-Received: by 2002:a17:907:2709:b0:99d:f5dd:6b3 with SMTP id w9-20020a170907270900b0099df5dd06b3mr1730055ejk.76.1692219756738;
        Wed, 16 Aug 2023 14:02:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErkoW1Fhqyy9bgDHyuCqTgILOziLkBZWzsy5hlRe/m+ISD5uCx+ZSJepmO7RB+iurwBqShzg==
X-Received: by 2002:a17:907:2709:b0:99d:f5dd:6b3 with SMTP id w9-20020a170907270900b0099df5dd06b3mr1730041ejk.76.1692219756378;
        Wed, 16 Aug 2023 14:02:36 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id kk3-20020a170907766300b0098e2eaec395sm9029827ejc.130.2023.08.16.14.02.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 14:02:35 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <22d992aa-2b65-0de3-b88c-fd216ae0218e@redhat.com>
Date:   Wed, 16 Aug 2023 23:02:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     brouer@redhat.com,
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
Subject: Re: [RFC PATCH 2/2] softirq: Drop the warning from
 do_softirq_post_smp_call_flush().
Content-Language: en-US
To:     Yan Zhai <yan@cloudflare.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>
References: <20230814093528.117342-1-bigeasy@linutronix.de>
 <20230814093528.117342-3-bigeasy@linutronix.de>
 <25de7655-6084-e6b9-1af6-c47b3d3b7dc1@kernel.org>
 <d1b510a0-139a-285d-1a80-2592ea98b0d6@kernel.org>
 <CAO3-PbpbrK6FAACw5TQyBxJ6jgO7_bhLFuPVAziUE+40_o_GnA@mail.gmail.com>
In-Reply-To: <CAO3-PbpbrK6FAACw5TQyBxJ6jgO7_bhLFuPVAziUE+40_o_GnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/08/2023 17.15, Yan Zhai wrote:
> On Wed, Aug 16, 2023 at 9:49 AM Jesper Dangaard Brouer <hawk@kernel.org> wrote:
>>
>> On 15/08/2023 14.08, Jesper Dangaard Brouer wrote:
>>>
>>>
>>> On 14/08/2023 11.35, Sebastian Andrzej Siewior wrote:
>>>> This is an undesired situation and it has been attempted to avoid the
>>>> situation in which ksoftirqd becomes scheduled. This changed since
>>>> commit d15121be74856 ("Revert "softirq: Let ksoftirqd do its job"")
>>>> and now a threaded interrupt handler will handle soft interrupts at its
>>>> end even if ksoftirqd is pending. That means that they will be processed
>>>> in the context in which they were raised.
>>>
>>> $ git describe --contains d15121be74856
>>> v6.5-rc1~232^2~4
>>>
>>> That revert basically removes the "overload" protection that was added
>>> to cope with DDoS situations in Aug 2016 (Cc. Cloudflare).  As described
>>> in https://git.kernel.org/torvalds/c/4cd13c21b207 ("softirq: Let
>>> ksoftirqd do its job") in UDP overload situations when UDP socket
>>> receiver runs on same CPU as ksoftirqd it "falls-off-an-edge" and almost
>>> doesn't process packets (because softirq steals CPU/sched time from UDP
>>> pid).  Warning Cloudflare (Cc) as this might affect their production
>>> use-cases, and I recommend getting involved to evaluate the effect of
>>> these changes.
>>>
>>
>> I did some testing on net-next (with commit d15121be74856 ("Revert
>> "softirq: Let ksoftirqd do its job"") using UDP pktgen + udp_sink.
>>
>> And I observe the old overload issue occur again, where userspace
>> process (udp_sink) process very few packets when running on *same* CPU
>> as the NAPI-RX/IRQ processing.  The perf report "comm" clearly shows
>> that NAPI runs in the context of the "udp_sink" process, stealing its
>> sched time. (Same CPU around 3Kpps and diff CPU 1722Kpps, see details
>> below).
>> What happens are that NAPI takes 64 packets and queue them to the
>> udp_sink process *socket*, the udp_sink process *wakeup* process 1
>> packet from socket queue and on exit (__local_bh_enable_ip) runs softirq
>> that starts NAPI (to again process 64 packets... repeat).
>>
> I think there are two scenarios to consider:
 >
> 1. Actual DoS scenario. In this case, we would drop DoS packets
> through XDP, which might actually relieve the stress. According to
> Marek's blog XDP can indeed drop 10M pps [1] so it might not steal too
> much time. This is also something I would like to validate again since

Yes, using XDP to drop packet will/should relieve the stress, as it
basically can discard some of the 64 packets processed by NAPI vs the 1
packet received by userspace (that re-trigger NAPI), giving a better 
balance.

> I cannot tell if those tests were performed before or after the
> reverted commit.

Marek's tests will likely contain the patch 4cd13c21b207 ("softirq: Let
ksoftirqd do its job") as blog is from 2018 and patch from 2016, but
shouldn't matter much.


> 2. Legit elephant flows (so it should not be just dropped). This one
> is closer to what you tested above, and it is a much harder issue
> since packets are legit and should not be dropped early at XDP. Let
> the scheduler move affected processes away seems to be the non-optimal
> but straight answer for now. However, I suspect this would impose an
> overload issue for those programmed with RFS or ARFS, since flows
> would "follow" the processes. They probably have to force threaded
> NAPI for tuning.
>

True, this is the case I don't know how to solve.

For UDP packets it is NOT optimal to let the process "follow"/run on the 
NAPI-RX CPU. For TCP traffic it is faster to run on same CPU, which 
could be related to GRO effect, or simply that tcp_recvmsg gets a stream 
of data (before it invokes __local_bh_enable_ip causing do_softirq).

I have also tested with netperf UDP packets[2] in a scenario that 
doesn't cause "overload" and CPU have idle cycles.  When UDP-netserver 
is running on same CPU as NAPI then I see approx 38% (82020/216362) 
UdpRcvbufErrors [3] (and separate CPUs 2.8%).  Sure, I could increase 
buffer size, but the point is NAPI can enqueue 64 packet and UDP 
receiver dequeue 1 packet.

This reminded me that kernel have a recvmmsg (extra "m") syscall for 
multiple packets.  I tested this (as udop_sink have support), but no 
luck. This is because internally in the kernel (do_recvmmsg) is just a 
loop over ___sys_recvmsg/__skb_recv_udp, which have a BH-spinlock per 
packet that invokes __local_bh_enable_ip/do_softirq.  I guess, we/netdev 
could fix recvmmsg() to bulk-dequeue from socket queue (BH-socket unlock 
is triggering __local_bh_enable_ip/do_softirq) and then have a solution 
for UDP(?).


[2] netperf -H 198.18.1.1 -D1 -l 1200 -t UDP_STREAM -T 0,0 -- -m 1472 -N -n

[3]
$ nstat -n && sleep 1 && nstat
#kernel
IpInReceives                    216362             0.0
IpInDelivers                    216354             0.0
UdpInDatagrams                  134356             0.0
UdpInErrors                     82020              0.0
UdpRcvbufErrors                 82020              0.0
IpExtInOctets                   324600000          0.0
IpExtInNoECTPkts                216400             0.0


> [1] https://blog.cloudflare.com/how-to-drop-10-million-packets/
> 
>>
>>> I do realize/acknowledge that the reverted patch caused other latency
>>> issues, given it was a "big-hammer" approach affecting other softirq
>>> processing (as can be seen by e.g. the watchdog fixes patches).
>>> Thus, the revert makes sense, but how to regain the "overload"
>>> protection such that RX networking cannot starve processes reading from
>>> the socket? (is this what Sebastian's patchset does?)
>>>
>>
>> I'm no expert in sched / softirq area of the kernel, but I'm willing to
>> help out testing different solution that can regain the "overload"
>> protection e.g. avoid packet processing "falls-of-an-edge" (and thus
>> opens the kernel to be DDoS'ed easily).
>> Is this what Sebastian's patchset does?
>>
>>
>>>
>>> Thread link for people Cc'ed:
>>> https://lore.kernel.org/all/20230814093528.117342-1-bigeasy@linutronix.de/#r
>>
>> --Jesper
>> (some testlab results below)
>>
>> [udp_sink]
>> https://github.com/netoptimizer/network-testing/blob/master/src/udp_sink.c
>>
>>
>> When udp_sink runs on same CPU and NAPI/softirq
>>    - UdpInDatagrams: 2,948 packets/sec
>>
>> $ nstat -n && sleep 1 && nstat
>> #kernel
>> IpInReceives                    2831056            0.0
>> IpInDelivers                    2831053            0.0
>> UdpInDatagrams                  2948               0.0
>> UdpInErrors                     2828118            0.0
>> UdpRcvbufErrors                 2828118            0.0
>> IpExtInOctets                   130206496          0.0
>> IpExtInNoECTPkts                2830576            0.0
>>
>> When udp_sink runs on another CPU than NAPI-RX.
>>    - UdpInDatagrams: 1,722,307 pps
>>
>> $ nstat -n && sleep 1 && nstat
>> #kernel
>> IpInReceives                    2318560            0.0
>> IpInDelivers                    2318562            0.0
>> UdpInDatagrams                  1722307            0.0
>> UdpInErrors                     596280             0.0
>> UdpRcvbufErrors                 596280             0.0
>> IpExtInOctets                   106634256          0.0
>> IpExtInNoECTPkts                2318136            0.0
>>
>>
> 
> 


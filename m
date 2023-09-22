Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE897AAA36
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjIVH1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjIVH0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:26:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A17DE6A;
        Fri, 22 Sep 2023 00:26:19 -0700 (PDT)
Date:   Fri, 22 Sep 2023 09:26:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695367577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6gtB/j1aJ/v54tV0PTQ7LW78TWmuTnW88E+MNr8Zzbc=;
        b=zAUpq1Z6lwsBmAdroV/pNRDfHu6BTjZHV09Fy6xTJusAK3k7MO2EJvsNjmSiv3KmzrqYW0
        U7pxSAkcHEXMuNJJcmUsezuKhRg79S/9/g9tVXUSGTQNaNLyDfyj599Tk0EoJmQ+PaO0Ej
        xJKVkXU+UlFHTLcHkwWgatqf3GURoLkZ9+3lwyExyXwh/C0dYvyJKJskNaCUXB5iXjOeyc
        zcL9n+IK6RpvdCZfNljxykIJxZ6Vu4v8nH0z6FO0ZaEKsREOCq//KbohzBzZd/nNFx77de
        FNJd8noV/kI9Vbv3LYyZ6EMm7hibZKlCVIp3dmteJ88uOYPqWwhMmEtGCsIDgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695367577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6gtB/j1aJ/v54tV0PTQ7LW78TWmuTnW88E+MNr8Zzbc=;
        b=7Bc/A7kODDY2eUV5JhgyXJ+mE5qj9cz/GAe83+rGVd7TroDCdTEyh1lyIJeJCu04Wxkny6
        Sein6bbaGP37xBCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Ferenc Fejes <primalgamer@gmail.com>
Cc:     Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wander Lairson Costa <wander@redhat.com>
Subject: Re: [RFC PATCH net-next 1/2] net: Use SMP threads for backlog NAPI.
Message-ID: <20230922072614.aT8vDgAy@linutronix.de>
References: <20230814093528.117342-1-bigeasy@linutronix.de>
 <20230814093528.117342-2-bigeasy@linutronix.de>
 <0a842574fd0acc113ef925c48d2ad9e67aa0e101.camel@redhat.com>
 <20230920155754.KzYGXMWh@linutronix.de>
 <2eb9af65d098bb54ed54178d7269e7197d6de5a0.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2eb9af65d098bb54ed54178d7269e7197d6de5a0.camel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-21 12:41:33 [+0200], Ferenc Fejes wrote:
> Hi!
Hi,

> > If we could somehow define a DoS condition once we are overwhelmed
> > with
> > packets, then we could act on it and throttle it. This in turn would
> > allow a SCHED_FIFO priority without the fear of a lockup if the
> > system
> > is flooded with packets.
> 
> Can this be avoided if we reuse gro_flush_timeout as the maximum time
> the NAPI thread can be scheduled?

First your run time needs to be accounted somehow. I observed that some
cards/ systems tend pull often a few packets on each interrupt and
others pull more packets at a time.
So probably packets in a time frame would make sense. Maybe even plus
packet size assuming larger packets require more processing time.

If you run at SCHED_OTHER you don't care, you can keep it running. With
SCHED_FIFO you would need to decide:
- how much is too much
- what to do once you reach too much

Once you reach too much you could:
- change the scheduling policy to SCHED_OTHER and keep going until it is
  no longer "too much in a given period" so you can flip it back.

- stop processing for a period of time and risk packet loss which is
  defined as better than to continue.

- pulling packets and dropping them instead of injecting into the stack.
  Using xdp/ebpf might be easy since there is an API for that. One could
  even peek at packets to decide if some can be kept.
  This would rely on the fact that the system can do this quick enough
  under a DoS condition.

> 
> Ferenc

Sebastian

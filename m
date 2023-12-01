Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8998004C4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 08:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377706AbjLAHcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 02:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjLAHcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 02:32:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA42194
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:32:45 -0800 (PST)
Date:   Fri, 1 Dec 2023 08:32:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701415963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7JGQhu3NivPunIx5KnuuVf3R1zT5VkSIWh1vBJFWh1o=;
        b=bc2j0hF7SfZX3n+43QgHUcHlvqdJrr0GRiB22ACvz7ewq1rVn83TV9j0SU9WmtozJrBts6
        j2X3a7o9yaGnyuhmW+Gx82bdiwf1LxiYS9HYd5ke04oz8ouygh3qem1QrYjG16xQx2UL3q
        DCUfKo/f26bT5izNqMemDHoOe7FoJXzuZFHYv5KHMMy0JwofHLyqmOLtPZZ0euoZ8tP42z
        CAlaITWYlPoSHckURmRS3Qk857cF3y7E2iQC6WxRlzA1/Zlna9x+JuGgJYLgoYOt51anaM
        G4xZ/JxlsbpsfrY2nE+fEzOA2SRcLHYJu+cYroK0KE4dBFSAYY1zRpu8mVk0og==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701415963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7JGQhu3NivPunIx5KnuuVf3R1zT5VkSIWh1vBJFWh1o=;
        b=Ab0eWEnqeEJ8Um5BDNuqesjmhr21s5Ju/Kp6OKqrpjgCsi4ip7ah1ZlB8jC7ecQyWLTjq/
        mAc+BTVTvqoNAtAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Yuanhan Zhang <zyhtheonly@gmail.com>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, zyhtheonly@yeah.net
Subject: Re: [PATCH v2] sched/cputime: exclude ktimers threads in
 irqtime_account_irq
Message-ID: <20231201073240.T9bFNCkU@linutronix.de>
References: <20231127130754.3affb908@gandalf.local.home>
 <20231130094130.GA12116@didi-ThinkCentre-M930t-N000>
 <20231130120036.5EpZn4eo@linutronix.de>
 <CAEQmJ=gh8fdPiBZPo72wwwr8UWo9BDF8cG1aUS5jFsn1itXOAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAEQmJ=gh8fdPiBZPo72wwwr8UWo9BDF8cG1aUS5jFsn1itXOAg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-01 15:27:39 [+0800], Yuanhan Zhang wrote:
> Hi Sebastian, thanks for your reply.
Hi,

> Sebastian Andrzej Siewior <bigeasy@linutronix.de> =E4=BA=8E2023=E5=B9=B41=
1=E6=9C=8830=E6=97=A5=E5=91=A8=E5=9B=9B 20:00=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On 2023-11-30 17:41:47 [+0800], tiozhang wrote:
> > > In CONFIG_PREEMPT_RT kernel, ktimers also calls __do_softirq,
> > > so when accounting CPUTIME_SOFTIRQ, ktimers need to be excluded
> > > as well as ksoftirqd.
> > > Also add this_cpu_ktimers to keep consistency with this_cpu_ksoftirqd.
> >
> > I'm still not sure what the benefit here is. It says align with
> > ksoftirqd but why? Why don't we account softirq time for ksoftirqd (and
> > should continue to do so for ktimersd)?
>=20
> That is my miss. When CONFIG_IRQ_TIME_ACCOUNTING is enabled,
> ksoftirqd is counted elsewhere (where ktimers should also be aligned).
> Please review my later patch v3.

What is elsewhere?

> > ktimers runs almost all the time in softirq context. So does every
> > force-threaded interrupt. Should we exclude them, too?
>=20
> For force-threaded interrupt, it counts on CPUTIME_SYSTEM
> instead of CPUTIME_IRQ nor CPUTIME_SOFTIRQ.
> To me, it does not quite make sense, I'm also thinking of sending a patch
> of this, but IMHO it should not be considered in this patch...

Sure. I was just curious what is different with ktimers/ksoftirqd which
run mostly in softirq vs threaded interrupts which do the same.

Sebastian

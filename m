Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E0D7C04A7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343501AbjJJTcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjJJTcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:32:10 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958A3AF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 12:32:08 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-79f915e5b47so250710839f.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 12:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1696966328; x=1697571128; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F6rWOV5DfaLcoCZaQVzVowbVRnkQP9w8oQZ9fEV5VrY=;
        b=ds6fwuJFaCxNz/Y0SRhA0/k5056pWq1/s5VxZvR3wmPw8+7nC6jdM7Hr2sS+ZtNsZW
         wg5kNVy5Z17Beek9nzP3BfVs3n5crLpHBnwbTdvhR654coSDGkNKW7p4Pr7ysTW7Tl/m
         LGV53GIrTSJpBAhkcWI7unhMhA1KA0eciGEMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696966328; x=1697571128;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F6rWOV5DfaLcoCZaQVzVowbVRnkQP9w8oQZ9fEV5VrY=;
        b=l55E90vfwxf627SpWqUcVrEjl8gV9bTNiMYrODu1qHnKMPk9BHHLCp0jVWeh65+JoE
         gtA9HCUeX2P44nOWgRXtJZ16cy2hk2L+Jlr58NWABk8dKdGqaDbE45QVGZTilhyi6y6O
         4FVqB03pqtupdNIPsH/ZeEgpIssSwuPNv/vPompx0mNLg4BnRhgGAeKUWiOEVs+eJ8gE
         rFOpKp5RZkaGfOwW1YtCTM3qe/A1WQ5c7V/92Pic553s1rUf7x18xHYCPs7ZOuQm4BEJ
         1i7mINYfvwEytyTFQ5nbqVTwP8vkhN43TCTj3iMyczjx5irZfzfsArz8y93nUl34AzpA
         +w7A==
X-Gm-Message-State: AOJu0YyLUN4fKcKnpuhlWVcdIcKwdLord8jxVljMbWW4M/gmiGeZiFi7
        ftnT3JQk6okZBTCeMXHhbx7pUuwQDRj+EAtGHO8=
X-Google-Smtp-Source: AGHT+IHcBL2bL9gx89SDI4lGeLbD8s56eszm7vPf1QpsnN+XdVCtp6V7kereuMv5p6X8cyIRmINNeQ==
X-Received: by 2002:a6b:5c04:0:b0:79f:99b6:63 with SMTP id z4-20020a6b5c04000000b0079f99b60063mr22085698ioh.9.1696966327782;
        Tue, 10 Oct 2023 12:32:07 -0700 (PDT)
Received: from localhost (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id a26-20020a029f9a000000b0042baffe832fsm2989658jam.101.2023.10.10.12.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 12:32:05 -0700 (PDT)
Date:   Tue, 10 Oct 2023 19:32:05 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Vineeth Pillai <vineethrp@google.com>,
        Suleiman Souhlal <suleiman@google.com>,
        Hsin Yi <hsinyi@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH RFC] sched/fair: Avoid unnecessary IPIs for ILB
Message-ID: <20231010193205.GA4011084@google.com>
References: <20231005161727.1855004-1-joel@joelfernandes.org>
 <ZR/mvd8Uw8PG+jx0@gmail.com>
 <20231008173535.GD2338308@google.com>
 <CAKfTPtAmoG-QRs0uJJoe1Y0+MFOzH-yrqTFb6Jdrnjyo-N98BQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfTPtAmoG-QRs0uJJoe1Y0+MFOzH-yrqTFb6Jdrnjyo-N98BQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, Oct 10, 2023 at 3:15 AM Vincent Guittot <vincent.guittot@linaro.org> wrote:
>
> On Sun, 8 Oct 2023 at 19:35, Joel Fernandes <joel@joelfernandes.org> wrote:
[...]
> > One thing I am confused about in the original code is:
> >
> > tick_nohz_idle_stop_tick() is what sets the nohz.idle_cpus_mask.
> > However, nohz_run_idle_balance() is called before that can happen, in
> > do_idle(). So it is possible that NOHZ_NEWILB_KICK is set for a CPU but it is
> > not yet in the mask.
>
> 2 things:
> - update of nohz.idle_cpus_mask is not strictly aligned with cpu
> entering/exiting idle state. It is set when entering but only cleared
> during the next tick on the cpu because nohz.idle_cpus_mask is a
> bottleneck when all CPUs enter/exit idle at high rate (usec). This
> implies that a cpu entering idle can already be set in
> nohz.idle_cpus_mask
> - NOHZ_NEWILB_KICK is more about updating blocked load of others
> already idle CPUs than the one entering idle which has already updated
> its blocked load in newidle_balance()
>
> The goal of nohz_run_idle_balance() is to run ILB only for updating
> the blocked load of already idle CPUs without waking up one of those
> idle CPUs and outside the preempt disable / irq off phase of the local
> cpu about to enter idle because it can take a long time.

This makes complete sense, thank you for the background on this!

Vineeth was just telling me in a 1:1 that he also tried doing the removal of
the CPU from the idle mask in the restart-tick path. The result was that even
though the mask modification is not as often as when doing it during the CPU
coming out of idle, it is still higher than just doing it from the next busy
tick, like in current mainline.

As next steps we are looking into:
1. Monitor how often we set NEXT_KICK -- we think we can reduce the frequency
of these even more and keep the overhead low.

2. Look more into the parallelism of nohz.next_balance updates (due to our
next NEXT_KICK setting) and handle any race conditions. We are at the moment
looking into if nohz.next_balance does not get set to the earliest value
because of a race, and if so retry the operation.

Something like (untested):

if (likely(update_next_balance)) {
  do {
	WRITE_ONCE(nohz.next_balance, next_balance);
	if (likely(READ_ONCE(nohz.next_balance) <= next_balance)) {
		break;
	}
	cpu_relax();
  }
}

Or a try_cmpxchg loop.

I think after these items and a bit more testing, we should be good to send v2.

Thanks.

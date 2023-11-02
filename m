Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9E37DF74B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 17:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377024AbjKBQDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 12:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjKBQD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 12:03:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2018E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 09:03:22 -0700 (PDT)
Date:   Thu, 2 Nov 2023 17:03:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698941001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E31Rivc0vHXv+cwnNR0QYhaNHh+RRYw5uUf0+l97B58=;
        b=JDZIX+IsEts+IzBa9naikreJHN2RP4di4nlzsHWq90E0/lpN1aq56uIROvXYwhqm7zSQX6
        AbrrMeEZs/ph54+bJUkMnLbBD3uXju7pil99XsbpznQmVkSAj7Bj7myYy46PbkUq9WZowq
        vANkoWu4dkiJ1ju+OatS/LKRHsoJxs8Ypyt0P4PmzdXXzmQiGBBePYh54HUmnQUzVbEup/
        xo/vaJkwjhoJBAdvvycYdIKRb3Vhx3fDGrewgR/GgMs4yGTbHOELW+hsP2ktiXE9eUB5ur
        dboeoNN7sOlqpq7EWf0nICB6qkeFLFNfR2nrqWhOSaRW5ZoO8KFejV/OsHul8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698941001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E31Rivc0vHXv+cwnNR0QYhaNHh+RRYw5uUf0+l97B58=;
        b=CJXtuKb8JFWMSWP8NUzVNWUeyFozLZ8e1I+H39tZpMYiFLLaOuJ8dKgFT4D3KoST58Vc6P
        cAI0y0U8z02ycMBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        John Stultz <jstultz@google.com>, Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFC PATCH 1/3] sched/core: Provide a method to check if a task
 is PI-boosted.
Message-ID: <20231102160319.4rjz7ujq@linutronix.de>
References: <20230804113039.419794-1-bigeasy@linutronix.de>
 <20230804113039.419794-2-bigeasy@linutronix.de>
 <ZUNsSqHiYu8WTHBb@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZUNsSqHiYu8WTHBb@localhost.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-02 10:30:50 [+0100], Juri Lelli wrote:
> Hi,
Hi,

> Apologies for noticing only now, but I believe this is still part of the
> 6.6-rt patches and I've got the below question to ask.

I'm not sure if we want this. I do have an alternative solution in the
meantime.

> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -8886,6 +8886,21 @@ static inline void preempt_dynamic_init(void) { }
> > =20
> >  #endif /* #ifdef CONFIG_PREEMPT_DYNAMIC */
> > =20
> > +/*
> > + * task_is_pi_boosted - Check if task has been PI boosted.
> > + * @p:	Task to check.
> > + *
> > + * Return true if task is subject to priority inheritance.
> > + */
> > +bool task_is_pi_boosted(const struct task_struct *p)
> > +{
> > +	int prio =3D p->prio;
> > +
> > +	if (!rt_prio(prio))
> > +		return false;
> > +	return prio !=3D p->normal_prio;
>=20
> Does this need to also take DEADLINE tasks into consideration? We don't
> change priority when they are boosted, only pi_se changes (please check
> is_dl_boosted()).

If we want this, then probably yes.
Isn't task_struct::prio for the DL (boosted) task set to 0? While the RT
priority go from 1=E2=80=A6MAX_RT_PRIO - 1.
=20
> Thanks,
> Juri

Sebastian

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5811805B96
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346243AbjLEPbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346053AbjLEPbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:31:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAEC83
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 07:31:50 -0800 (PST)
Date:   Tue, 5 Dec 2023 16:31:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701790308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hsENTBH9k3W4U1tKsViJ4yf3sg3tGJqqvcy+jJtuHIw=;
        b=ctPBk9QZQoJlZUg/dOdzrCYaJDHs2UeXm48QFpAPnGkO3Gz3sim0CAfVOY4sJEv9aN3MFE
        +LYoFpV2Dqaifl6v8hPSG6JnK1LC0vEzsiXSX7Oa8qg+rPgYDUuzMuA0KGhaYqlyBJVik1
        9TBKloWqjbb2lT37khfNokaa02nk4mElcr0X4NCdXkwBg/U7O460z1WMGXIRChLcauNyqz
        lB2I2bjTgeK625bOQhoVjLoFfxKMme+5afbdBTCMowNwPmG438GzbrGnI9Gn2Vf4BOM06U
        /ZZLzMIl1bAesU4i81hLE34k/mfuErvpfl4xCLfT1kAtjfyX1bGnIcww97Blkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701790308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hsENTBH9k3W4U1tKsViJ4yf3sg3tGJqqvcy+jJtuHIw=;
        b=wkPYisXJSUVkJtRGEFZe1t5vpSZ3HMKLnj1knsnYBih5Xt6rD6NMW4Of57DpZJofKrkEwf
        NH8VO457eYBFjjDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Yuanhan Zhang <zyhtheonly@gmail.com>
Cc:     zyhtheonly@yeah.net, tglx@linutronix.de, rostedt@goodmis.org,
        mingo@redhat.com, Venkatesh Pallipadi <venki@google.com>,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Subject: Re: [PATCH v3] sched/cputime: let ktimers align with ksoftirqd in
 accounting CPUTIME_SOFTIRQ
Message-ID: <20231205153146.OSpCIs1G@linutronix.de>
References: <20231201073240.T9bFNCkU@linutronix.de>
 <20231201080522.GA31309@didi-ThinkCentre-M930t-N000>
 <20231201161640.Z0cJLUi3@linutronix.de>
 <CAEQmJ=jbB5ag5HRMjZqjych_wj_v6wTMLQxJbnJsgwNdn37kbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAEQmJ=jbB5ag5HRMjZqjych_wj_v6wTMLQxJbnJsgwNdn37kbw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-02 05:28:15 [-0500], Yuanhan Zhang wrote:
> Hi,
Hi,

> Sebastian Andrzej Siewior <bigeasy@linutronix.de> =E4=BA=8E2023=E5=B9=B41=
2=E6=9C=881=E6=97=A5=E5=91=A8=E4=BA=94 11:16=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On 2023-12-01 16:05:41 [+0800], tiozhang wrote:
> > > In CONFIG_PREEMPT_RT kernel, ktimers also calls __do_softirq,
> > > so when accounting CPUTIME_SOFTIRQ, ktimers need to be accounted the =
same
> > > as ksoftirqd.
> >
> > I still don't understand why this is a good thing and why want to align
> > it with ksoftirqd and what breaks if we don't.
>=20
> My motivation of doing this is to keep CPUTIME_SOFTIRQ in /proc/stat
> remaining more accurate in PREEPT_RT kernel.
>=20
> If we dont align, ktimers' cpu time is added to CPUTIME_SYSTEM when
> CONFIG_IRQ_TIME_ACCOUNTING is enabled, make our stats less accurate..

So it is only SYSTEM? There is no additional SOFTIRQ that is used?

> The main diff between ksoftirqd and force-threaded interrupt is that ksof=
tirq
> is in SOFTIRQ_OFFSET (serving softirqs) while  force-threaded is in
> SOFTIRQ_DISABLE_OFFSET (by using local_disable_bh).

This depends. If you look at a network driver, SOFTIRQ_DISABLE_OFFSET is
used during the driver routine doing almost only schedule a softirq.
Then the main part happens during SOFTIRQ_OFFSET where the driver pulls
the packets and passes them to the network stack.

> CPUTIME_SOFTIRQ serves for time in SOFTIRQ_OFFSET (processing softirqs).
> See
> https://lore.kernel.org/all/1285619753-10892-1-git-send-email-venki@googl=
e.com/

Let me look at this later=E2=80=A6

> So this leads to ksoftirqd is counted into CPUTIME_SOFTIRQ but irq-threads
> into CPUTIME_SYSTEM.
>=20
> Since ktimers is also in SOFTIRQ_OFFSET, align it with ksoftirq will
> put it into CPUTIME_SOFTIRQ, making /proc/stat more accurate.

But this only works if it is observed during the TICK interrupt, right?

Sebastian

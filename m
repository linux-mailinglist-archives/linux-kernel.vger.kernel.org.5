Return-Path: <linux-kernel+bounces-109470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7B588199B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 23:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A6301C21402
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 22:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D850B52F78;
	Wed, 20 Mar 2024 22:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jxgD4Oqn"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7430E1EB45
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 22:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710974566; cv=none; b=PoFq1Od1VVRHzY2N6tpSXImcrbWtveTM91HhIVAdaYznpVYwmDt2GyH5cpD2uDlqYZthexSBsWRQ6QsMSNXmBd/e+eLXWimYVpbo5doKxUw3e4is7ZE3aCBVEHBVse14HOLqIiVPYYRZAx69Jwej7d6RnmdPVFhF9kpDB2Qh9u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710974566; c=relaxed/simple;
	bh=Qzo0wWW+nIU5ofdBtQDFhFG5/t2jk1i61qipHXAvkK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dfZGJ02C/AXpGFRQwyXtbUpzdzJB45M0wzqRQTyt9Qg5/d4PXcvPwnJEl9zh5cSwNhKCLe+euhaHlDic3+TJV7iCdKxHxfm77fIRM/gb2JIOG8C3YcX8iYks8zsGnAFP8s6Uh8ACHIHuPZ85Ake63uFJoXlqWgfOz3TVbEVwqbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jxgD4Oqn; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41428b378b9so14275e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 15:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710974563; x=1711579363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dw6rd0m7MA8k7bHTBxP2bB2jrvpEI2pgQ/Pyev6+gzw=;
        b=jxgD4OqnCyKWcsDk/FfvSJSzm87Fl5B8tKRjRjBztEya4kHv2y+ckyVXVvLeEXvH3D
         x4hHUW0VwHvVA93fp7OYwE9EMCDJwe+/Qwj+aoyaVJhZKXB9nKU/dxutfD14g2AeSfYb
         MBAiO7+1xPMdTxVj2PJCREQEKFbUNk9ySrgyPi1n8vOoO0Yo5fC08CkX4T4+zof3tFyK
         dd4j7vV5VjLfMx+QoP4XvaAvrcMwYyNe1KuLn2wntpKJcsdWKgHbe1RVbArB/8USACGt
         FxLoxpFoi5rH4TH6xRUQSP4ZGyg1vyHlQNwaHAmeRatYh5OC+t/1r8/VhMf9dSx79O7Z
         9ojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710974563; x=1711579363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dw6rd0m7MA8k7bHTBxP2bB2jrvpEI2pgQ/Pyev6+gzw=;
        b=wJBClP1+OL95p3rVfwmkrzmYHsfWDXsgIBLeSavEAxMidEwUmZx3tPO1KVJ42xxi9i
         KBemhVdjVBeX3VbeR7PH2DkYRJ1Y1vsR+/I0XSNcWpG8hjG17aWqHXA+97xwKb++Fdd0
         Zma3/sQPK/CMMti8nRh6vuJqSEsn9hG6HLejCjMqABpPvjgNcW7Cf7f/OXQRGF0fKAX0
         2esxBSGEIv/UEBRbHbZL0BFCLrlFLhyxxkBwWovqkHPuvgtycjVelvqrBa5Mfhbly+cf
         dD7I0yT+tWhMXY5gWmvUmdBFFjnpIHd/uNac3rNSNUtO3pyPaDgVrP7JiMtTKfQzXMdP
         WbkA==
X-Gm-Message-State: AOJu0YxVEoFRBy7vWL5hRpPpw1hQLILij10OLjCLJSbWVuINHX90lHRB
	2kPEC5umN/rIqTS92bCDCJacm7xS2sCban2poAYeeGjr08nudzdekyo8YVJIJKR/CNBtlLDIoYU
	pRuP+ice7keVUoExs0uJ2lB2Yd9/zwHcM8Ec=
X-Google-Smtp-Source: AGHT+IF0tKBb7Q9NBws/Mg1rBhZwjXFB9MBeOTmCyFrlplp2kRQ2MsYqz84N78CcgdI4Kd7KNbAOFk/00FVz/KaYiUM=
X-Received: by 2002:a05:600c:1e04:b0:414:3566:eab5 with SMTP id
 ay4-20020a05600c1e0400b004143566eab5mr72998wmb.2.1710974562782; Wed, 20 Mar
 2024 15:42:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318192846.75299-1-jstultz@google.com> <Zfpy4Z4MhErKrHBZ@linux.ibm.com>
In-Reply-To: <Zfpy4Z4MhErKrHBZ@linux.ibm.com>
From: John Stultz <jstultz@google.com>
Date: Wed, 20 Mar 2024 15:42:31 -0700
Message-ID: <CANDhNCro84C8uxTo5MJ1xX0wGnTXE7_REm4nqp7jGQ+mN0wfkQ@mail.gmail.com>
Subject: Re: [RESEND][PATCH v2] sched: Add trace_sched_waking() tracepoint to sched_ttwu_pending()
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Phil Auld <pauld@redhat.com>, 
	Valentin Schneider <vschneid@redhat.com>, kernel-team@android.com, 
	Zimuzo Ezeozue <zezeozue@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 10:24=E2=80=AFPM Vishal Chourasia <vishalc@linux.ib=
m.com> wrote:
> On Mon, Mar 18, 2024 at 12:28:33PM -0700, John Stultz wrote:
> > Zimuzo reported seeing occasional cases in perfetto traces where
> > tasks went from sleeping directly to trace_sched_wakeup()
> > without always seeing a trace_sched_waking().
> >
> > Looking at the code, trace_sched_wakeup() is only called in
> > ttwu_do_wakeup()
> >
> > The call paths that get you to ttwu_do_wakeup() are:
> > try_to_wake_up() -> ttwu_do_wakeup()
> > try_to_wake_up() -> ttwu_runnable() -> ttwu_do_wakeup()
> > try_to_wake_up() -> ttwu_queue() -> ttwu_do_activate() -> ttwu_do_wakeu=
p()
> > sched_ttwu_pending() -> ttwu_do_activate() -> ttwu_do_wakeup()
> Notably, sched_ttwu_pending() is invoked for remote wakeups.
>
> Given this, I anticipate a scenario similar to the following
> occurred: When a process (P) is to be awakened on a remote CPU,
> the scheduler adds P to the remote CPU's wakelist,a per-CPU queue,
> and sends an IPI to the remote CPU. This action triggers
> sched_ttwu_pending() on the remote CPU, which then processes the
> wakelist and wakes up the queued processes.

Hey! Thanks for taking a look here and sharing this feedback.

Indeed, looking closer here I do have a hard time seeing how we can
get to sched_ttwu_pending() without having gone through the paths in
try_to_wake_up() that would call trace_sched_wakeup():
  try_to_wake_up()->[ttwu_queue ->]
ttwu_queue_wakelist()->sched_ttwu_pending()->...

> In this scenario, the "waking trace" of P, signifying the initiation
> of the wake-up, is recorded on the CPU where try_to_wake_up was executed.
> Meanwhile, the "wakeup trace," denoting the completion of the wake-up,
> is observed on the remote CPU where sched_ttwu_pending() is executed.
>
> Is there a possibility that something other than the above occurred
> in your case?

I suspect that the case reported may be that the task went to sleep
right after the trace_sched_waking(). Which could result in the
transition from sleeping to trace_sched_wakeup() without the
trace_sched_waking() inbetween.  The added latency from the remote
wakeup probably increases the chance for this race to occur.

So I'll withdraw this change for now and sync back up to check if my
suspicions are correct or not.

Thanks so much again for pointing this out.
-john


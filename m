Return-Path: <linux-kernel+bounces-127181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA5D8947C8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05956283903
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0650F56B95;
	Mon,  1 Apr 2024 23:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HTFhVXyO"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8587055C3B
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 23:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712014478; cv=none; b=jA3osgQ+Y/DmiLvv+hxbJHO7IzEzchUjkQfz2NN4Lx7PszhCc4VX4F+ISvLdeIVt9927EWUT2VtWM7nZkxN18tRqd0VL/gl7siA9sBSumwubWUsKbPfTmu+FAdHqiOp19bJbyTvPSZ5j+qbeloRGYCSonChJ3oSLOxXoSl1Ikds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712014478; c=relaxed/simple;
	bh=tfX1NHEGpLx8lwqKMsxSmdWjYVtA824r1xE6I2YQgpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0WPrKV1jh/nO6VrCul1Ki+c7bthx6SPTmdD1y/d7O6yRrj2oonF5xNdVWfKmtLyI3hnyj4Rpp/NPfzkXuhtHJOyoqk9d7ZDUS3clj0suqm0mk7xP4QdBwBkW5wM1wJRWCU6Mqhw0YUzmzVr0vRGViMB/m/VEfWquCU2PuZX7TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HTFhVXyO; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56c2cfdd728so37293a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 16:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712014475; x=1712619275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KXI5Lckd//sw4J1CfsLdtjfP4f66PrNobbRTqswo1k=;
        b=HTFhVXyOBx9pjo6agBidB/KZARGn7Gtn0CDYWQ19rA5BytEu/lVTzaYOH0hj2Fc5AG
         IBoC/JPJ0Gf2hBiLEs7tK49kMbXiJhnLbU1zLtgAcryOddkW6U1krltos1oNqPQGfkaI
         lLbeksM+h4EaKheoDbAOFcKLLA28e0dOnyy9Tc/XOo7WEjTowRe5/BHq4adaBycU2+jL
         YrVeNWYb7ZsLrx1BziVdAVgNtaIGb9vxg3Y1oUbQSGp1FkmaB8jrP9s1IbHdckYL8Bnr
         7LCqEFuGQ+6XawocByfIqT+zRQjAfvGlJ8HrYDE5th78F/378dUUeXNlmtB43ao5L+o0
         EgFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712014475; x=1712619275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2KXI5Lckd//sw4J1CfsLdtjfP4f66PrNobbRTqswo1k=;
        b=Y08nFZHRZ7EUb3ZSDIcf/IxLtea1/eMIWHmWdYSqnMMPh1XsJbOkF497zK1UxOwzNu
         a1rTYGLNauN/vstyGhqA5VyN51NzTVM6gQXTcCeaPdF5Kjsc67/c+nM9mg6/wQVvze89
         VdiHOiOnNde2qEHlvxZ7ekPXRvRYLHsBCuh4kdDbbUEgcCeJmHZhma+tsej4ND1YqA0s
         xpuDx2y8x5U2tD4lbXXnLHO1RcVtN2fVbH2ph5Xet14sAteutVaHTq5l2bpDwKtJu2Fk
         U/MQeW9K2bijyXDbaxSJPSRGfJu9cOo6Thr6B5m0UssJIwMsH+GNg3bI69TbWChzcsMO
         3piQ==
X-Gm-Message-State: AOJu0YxD2FC93iq0BTwM877W7/DKvGwyOpO8Ya58+p1lmlCvF+jT/hAo
	WRtNG9v9ALCFDt5/h89hRCSbM8PGYwY0GJFbkG/Z0t8oAOEif67WC1LluZBQiGFIbdGacuUdO8D
	CrOcyL346qJQo2GoXoEBfuiERNaat21TYz/g=
X-Google-Smtp-Source: AGHT+IFnwdifbsGHTa9+TFkDFHh+iiygHxPUyBVPA/D1nZV1REfhqigDXbEmi0f4brULa2LgRmRorG+PA4yrWQgxcU4=
X-Received: by 2002:aa7:d888:0:b0:56d:c82d:5475 with SMTP id
 u8-20020aa7d888000000b0056dc82d5475mr260804edq.4.1712014474689; Mon, 01 Apr
 2024 16:34:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315044007.2778856-1-jstultz@google.com> <20240315044007.2778856-8-jstultz@google.com>
 <496a2f13-2d66-48f4-a710-afbd90f1bfd8@arm.com>
In-Reply-To: <496a2f13-2d66-48f4-a710-afbd90f1bfd8@arm.com>
From: John Stultz <jstultz@google.com>
Date: Mon, 1 Apr 2024 16:34:21 -0700
Message-ID: <CANDhNCrW6LrXecRa0gXRhxhthzNeLkfx+UaYq-NgtQtqdsHw0w@mail.gmail.com>
Subject: Re: [PATCH v9 7/7] sched: Split scheduler and execution contexts
To: Metin Kaya <metin.kaya@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Joel Fernandes <joelaf@google.com>, Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Youssef Esmat <youssefesmat@google.com>, 
	Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Xuewen Yan <xuewen.yan94@gmail.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com, 
	"Connor O'Brien" <connoro@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 8:06=E2=80=AFAM Metin Kaya <metin.kaya@arm.com> wro=
te:
> On 15/03/2024 4:39 am, John Stultz wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> >
> > Let's define the scheduling context as all the scheduler state
> > in task_struct for the task selected to run, and the execution
> > context as all state required to actually run the task.
> >
> > Currently both are intertwined in task_struct. We want to
> > logically split these such that we can use the scheduling
> > context of the task selected to be scheduled, but use the
> > execution context of a different task to actually be run.
> >
> > To this purpose, introduce rq_selected() macro to point to the
> > task_struct selected from the runqueue by the scheduler, and
> > will be used for scheduler state, and preserve rq->curr to
> > indicate the execution context of the task that will actually be
> > run.
> >
> > Cc: Joel Fernandes <joelaf@google.com>
> > Cc: Qais Yousef <qyousef@google.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Juri Lelli <juri.lelli@redhat.com>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Valentin Schneider <vschneid@redhat.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Ben Segall <bsegall@google.com>
> > Cc: Zimuzo Ezeozue <zezeozue@google.com>
> > Cc: Youssef Esmat <youssefesmat@google.com>
> > Cc: Mel Gorman <mgorman@suse.de>
> > Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Waiman Long <longman@redhat.com>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Xuewen Yan <xuewen.yan94@gmail.com>
> > Cc: K Prateek Nayak <kprateek.nayak@amd.com>
> > Cc: Metin Kaya <Metin.Kaya@arm.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: kernel-team@android.com
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> Duplicate S-o-b for Peter.

Yes, though I believe this accurately tracks the path of development.

The patch originally by Peter was sent by Juri:
  https://lore.kernel.org/all/20181009092434.26221-5-juri.lelli@redhat.com/

Then and Peter put it in a branch on his git tree(adding another SoB
and the Link tag), from which Conor picked it up:
  https://lore.kernel.org/lkml/20221003214501.2050087-6-connoro@google.com/

Followed by me.

That said, I can no longer find the branch in Peter's tree, so it's
possible I have this history wrong, but this is what I recall.

So I'm hesitant to change that part of the attribution, unless Peter
requests otherwise.

thanks
-john


Return-Path: <linux-kernel+bounces-62167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5227C851C91
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C0DC1C21D5C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188B13FB22;
	Mon, 12 Feb 2024 18:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zt0KQjlA"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B533F9EF
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 18:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707761866; cv=none; b=Raf+zPWm3QwvfKR26iOO0yMztqV2akpeJHpZj0eBxqyjKdKSSnjJhc13+m67aDv0J6eoCI+7Rg+PQnyjVJn35yACsT5/C9OK/SzCmRWvovTZg7R+869PzfTT4OzRz1+MwyF9OWRPvnbUqZypv77b4oHamjPZMdzBrI/ViIizaZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707761866; c=relaxed/simple;
	bh=OuVQyReUhmWA7cjuqV/eaPWLWq5ZP0unDqloNtX8MBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DPg4oktAT1VdhSPi1wG0q13Wm/UUx5fYA0c5c0bMdl9gSGU0pKEQaiPok0qMTe6fsB+/uw2FfQKLYcSf7TT2p9P14wlJhL5y4UFuK5NSlsk+xgvLhV+8m2aXsUAb71WdA+tD9ByAT9EgcITDQPe+SHFzfFoNttQr/ZAQj391ocY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zt0KQjlA; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-561e9237945so989a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707761863; x=1708366663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FyLZXvCY9wm2y5DdIdleupGuCZI2JHWkk2fffy9JDlI=;
        b=zt0KQjlAewNUVCr6aGx+GVSfb+7z+Ok5oO85rRkWvxvbgJhSyxjiCofCVSmVNqT0o3
         etHlV5U76cbo1TawEu3uIKJpaN13099RksexYtu4Po4/5D+2RMNhMwZEM4C6tAnGoc59
         8e5GBpExgB4a7OcyQaS+3iW5IEXRQoVSj7batcgN3EVYs8r9wBQUsrorViNnLMfL3PNL
         nwmPgljYKtTu19fEtJ4BcqNtu3dbkqyZeN7jDoiVkfBVuqwSZcrlcevEs/PHl4hbwEQF
         Kg57DlvietJVPVsDon8w9CuZuY7cH1GNDVwF1m5cxllgf2a7VX9/rvQqwtkU63DpX+nU
         wkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707761863; x=1708366663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FyLZXvCY9wm2y5DdIdleupGuCZI2JHWkk2fffy9JDlI=;
        b=qjYKRpSZlSE/FLFwQUv1PgekXZ8yMzB9hXSEK+rSu5N9bBoi++Gek05fMIDBa4xj8u
         tjh5jLrxlp7RMC54w98YpQg9bvXTcKJF0Oay48lgWEpkZfS04UOKdo7mONsusu7qgp7F
         ezm+pLIbApvDmqE4zgugBzLo1NxjyGAUE46KIyZQBJ981tiSl6pahOV92DgZGXQil4C2
         hfv04hQJr3ZylMWhI5pjYN6FXXhg8qzxLlPZSemD13L8aQz2TifkaPj0NQnTuh1D23Ae
         xJYM2I58mrhRfVam9IsFJSzJz1hYWQNHC1xap1lewLRCc4C3V9i1IkGR/tl2IzEli0lE
         2HwA==
X-Gm-Message-State: AOJu0YwZRkU78Fc0acm+sUXRoGTboN+/bBe17m9x8xrZ57GU9ayxW4CO
	il3falKBq1li14yWY2UpngiE0LaUtoj+cayV0knNWpuBpbtAFeuqcbSeT6cj3UAz5SGaGt9x7mf
	G7HJcjQ/Obh585FdHGbChiV3Iez8AUVz+sPNQfGV43i2Z8mM1evg=
X-Google-Smtp-Source: AGHT+IGlAfPWDCSfPLGfphGq+6Jhtzs5AaCpWQ5phfDVl8jekoMJCZRYbtSXqW+sfZNPEXNCKkVDzVaU/guvvN8KCvQ=
X-Received: by 2002:a50:d496:0:b0:560:e82e:2cc4 with SMTP id
 s22-20020a50d496000000b00560e82e2cc4mr239846edi.3.1707761862719; Mon, 12 Feb
 2024 10:17:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210002328.4126422-1-jstultz@google.com> <0a9afba6-2e25-44fa-b9d2-3e57cc6708ce@arm.com>
In-Reply-To: <0a9afba6-2e25-44fa-b9d2-3e57cc6708ce@arm.com>
From: John Stultz <jstultz@google.com>
Date: Mon, 12 Feb 2024 10:17:30 -0800
Message-ID: <CANDhNCpGLZ0b9Se7P2dG7mYXePW0kqx+Be8dfkspwwvzPV6NqA@mail.gmail.com>
Subject: Re: [PATCH v8 0/7] Preparatory changes for Proxy Execution v8
To: Metin Kaya <metin.kaya@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, 
	Youssef Esmat <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 7:50=E2=80=AFAM Metin Kaya <metin.kaya@arm.com> wro=
te:
> On 10/02/2024 12:23 am, John Stultz wrote:
> > After sending out v7 of Proxy Execution, I got feedback that the
> > patch series was getting a bit unwieldy to review, and Qais
> > suggested I break out just the cleanups/preparatory components of
> > the patch series and submit them on their own in the hope we can
> > start to merge the less complex bits and discussion can focus on
> > the more complicated portions afterwards.
> >
> > So for the v8 of this series, I=E2=80=99m only submitting those earlier
> > cleanup/preparatory changes here. However work on the full series
> > has continued, with some nice progress on the performance front.
>
> I guess we can also cherry-pick 1st [1], 20th [2] and 22th [3] patches
> of v7 into this series?
>
> [1]
> https://lore.kernel.org/lkml/20231220001856.3710363-9-jstultz@google.com/=
T/#m1e6ef390bf9044ca69818549bccec1ada221cd32

That one already landed upstream w/ the deadline server changes:
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D5d69eca542ee17c618f9a55da52191d5e28b435f

> [2]
> https://lore.kernel.org/lkml/20231220001856.3710363-9-jstultz@google.com/=
T/#m638575b42057e1d2cc3a82d4bdea7308eb85b461

On this one, I wanted to get some more review of the chain-migration
logic before really pushing it.

> [3]
> https://lore.kernel.org/lkml/20231220001856.3710363-9-jstultz@google.com/=
T/#mafcb432d20c6b545998da56ba92fc51ba8a07b42

I do agree this is more of a cleanup, but I also want to try to
refactor it a touch to try to consolidate the logic, so it's not quite
ready.

So I'm just submitting the set here for now to try to get the ball
rolling, but I'll continue working on the larger series and will pull
things down as they make sense.

thanks
-john


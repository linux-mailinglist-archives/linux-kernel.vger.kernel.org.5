Return-Path: <linux-kernel+bounces-84534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B4886A7FC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 06:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBFD92844E2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 05:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247D1210EC;
	Wed, 28 Feb 2024 05:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="OmtQqTgn"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29CD20DEB
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 05:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709097895; cv=none; b=tP9rMi+UudlDkow9y1V8FjqoJxrLBAXc8Ezx1kq3usAXm3t4eFoZhxq76D6VrEjA9/Q5GfzYNjCgdYrh93B/7qC3d7IksAcs235QS1Q7lI+0lLr6v5yYEC/dD1fTs/jj773+xu5I9k3EBkvMztv0mB2fXIc4LC6Y5C1rU/9DRO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709097895; c=relaxed/simple;
	bh=ESQJ57fYEZ+NajWcMze9DsgiUSoti8Bgg/3xdShO4Sk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r6Bynn50RZQc1iv4wxrCo8F8ybnvc4+fTC4l0sRZQhibshaCGp9nV6fcIc+VrCBeFOr29VfVLMSmqkwIn0X2+9kEWPdOtB5GQsYC7ndz833QAHOpeQfFlZ02SCg5VFy+gFsn+W3vcSMq22lsAvWrUpwG/o0uayozd2RO6S1IIjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OmtQqTgn; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5664e580cb7so8003a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 21:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709097892; x=1709702692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESQJ57fYEZ+NajWcMze9DsgiUSoti8Bgg/3xdShO4Sk=;
        b=OmtQqTgnQgA2Ti9QADTxu4XPgBrNNd8l9QBCWvtN0Pm41fcml8TQa2yfo23K/zDnXD
         9yF2I7sto5QIyZuOab2Uxk4DCl6P+5mQgtX56PwFuvsGpEWKCujp6psafbjpWCtIEdi5
         1N9fsS2dbO4nWMWrmksgSZBO9q6Z5/H8tFPUYLuVrUM5oRXCmJ5Oc4HCGHs+BfL/VB21
         OZvB7PDnw1hdEPD3mz1n9d5yIt/QD7bxwOHtWDiFZZOyqOUEmQvKJRo1EiclzaeyrF5a
         STb0q2ROhmy9hh5K6wL/34lPwoG2DAwuzZm/iiH4OnVXOyLnrgxHxmpVyU03bBF7aNTa
         dfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709097892; x=1709702692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ESQJ57fYEZ+NajWcMze9DsgiUSoti8Bgg/3xdShO4Sk=;
        b=F3OlIFfJ0b7bXmX9Se0WThimUrEliCh3zQz6MVNS8ziJ6zf58XB2n9oV5SWBxrgPRd
         L/4NHDzid15kJd7FQ9z9iKFExUTWXNJYA4fb1i0GUa63xyXNvPuWcsGF0lVEYWG1TMdZ
         PtBhN4nr+LgpkXJf6yU6XGEYSDDpnbxrtA8DmAxuGSsH2ltsDr7Nu0dO43TMngFInwwp
         depwAupyDz0A27WUCVi6vD1d8/iJ6PKcETMbfgYR7EObeFo36G35zw4euCBSBlirlog+
         JI8ff1bw3c8pwUKlU46TQOqeEEfF2S9DCb3ii9qahUQUteT09a3lapLXMHWKYrNA8tvl
         +BCA==
X-Gm-Message-State: AOJu0Yy2Lo9rwRt84KQUpPlZTo2xwNjcFgc4Y+GUKkDTzTyENB1K4cmc
	/Ls54rrSY8XfX/hJUvI9dqdEd2pQ3X1PWRXH8pigiYTCP7/qFVuXpnOGs/I3eHEElyaELnqjgW6
	Y4Wj0AD4QV8ELTVTIcyJMIHqGEtmvb7QNFic=
X-Google-Smtp-Source: AGHT+IGEUOxQrPP8OeAykH1VgxSdIBVMYvMlGmamsDM9tDmDqWdgyfCQ1ZLe5KQfSPEVAm6lb+ReF6qB4c02bcG2Q5Q=
X-Received: by 2002:a50:d70b:0:b0:566:306:22b7 with SMTP id
 t11-20020a50d70b000000b00566030622b7mr2722edi.1.1709097892004; Tue, 27 Feb
 2024 21:24:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240224001153.2584030-1-jstultz@google.com> <3937e057-6b47-77fe-9440-ade079ee2cfe@amd.com>
 <CANDhNCqUrd4RNfKKMPRZj9ft1tTMNZq-XgYsU1dHpN4ixcZuJw@mail.gmail.com> <0c606d04-6765-d55d-61ec-c3625daea423@amd.com>
In-Reply-To: <0c606d04-6765-d55d-61ec-c3625daea423@amd.com>
From: John Stultz <jstultz@google.com>
Date: Tue, 27 Feb 2024 21:24:40 -0800
Message-ID: <CANDhNCpb2Ve5saKtnBgTeAQXFbaWf84G_ky-509ddsfhOhdiLQ@mail.gmail.com>
Subject: Re: [RESEND][PATCH v8 0/7] Preparatory changes for Proxy Execution v8
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, 
	Youssef Esmat <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 9:12=E2=80=AFPM K Prateek Nayak <kprateek.nayak@amd=
com> wrote:
> On 2/28/2024 10:21 AM, John Stultz wrote:
> > Just to clarify: by "this series" did you test just the 7 preparatory
> > patches submitted to the list here, or did you pull the full
> > proxy-exec-v8-6.8-rc3 set from git?
>
> Just these preparatory patches for now. On my way to queue a run for the
> whole set from your tree. I'll use the "proxy-exec-v8-6.8-rc3" branch and
> pick the commits past the
> "[ANNOTATION] =3D=3D=3D Proxy Exec patches past this point =3D=3D=3D" til=
l the commit
> ff90fb583a81 ("FIX: Avoid using possibly uninitialized cpu value with
> activate_blocked_entities()") on top of the tip:sched/core mentioned
> above since it'll allow me to reuse the baseline numbers :)
>

Ah, thank you for the clarification!

Also, I really appreciate your testing with the rest of the series as
well. It will be good to have any potential problems identified early
(I'm trying to get v9 ready as soon as I can here, as its fixed a
number of smaller issues - However, I've also managed to uncover some
new problems in stress testing, so we'll see how quickly I can chase
those down).

thanks
-john


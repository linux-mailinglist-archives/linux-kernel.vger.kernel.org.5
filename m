Return-Path: <linux-kernel+bounces-25958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AC882D8C7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E094282159
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 12:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD192C69D;
	Mon, 15 Jan 2024 12:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0VowHk1N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ajYtVmYg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9E42C68C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 12:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Jan 2024 13:16:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705320993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A63dnTEunn6abrgl1DMAdxbjpOLX71DXc8GdsI+71XQ=;
	b=0VowHk1NjlV4sPsWA/CoMJRNK0giD2At3qR0e516ghXPB/H2kHVoc/WyGV700szWe+yxJa
	+O3vZRkN/uCUTQfgbS8EjDZcfHkml7E9f8F5uMuLN25WVTnj6jL1TqmJ4U/eZKzdOwX2GH
	dlN/w9jLMj4Vh6RgaHf7v2+jfpayQfoTFuhGNVVA4mF1rZX7ffd5e6HbbQg6/VQT+TpFXz
	t3FgBWa4yQlPTAmMyz+Obvvocd99+CYu+x/jwK0QlYMx4vYBYEfmS3AJ3ICFRb+JI1UCWj
	xE0oeXw2q6VO2fUlLqEukl42KQ7UMA18iVWxh4mg2QesnvDQSIEjGDLT0MHSsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705320993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A63dnTEunn6abrgl1DMAdxbjpOLX71DXc8GdsI+71XQ=;
	b=ajYtVmYgU1GYi8NrhDWfauo3tHg7qxVMD3tXPGGm86wn+JPqYNqDIwyFUBs/MQRASWGkyH
	jX32nPdnRUzkMYAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	boqun.feng@gmail.com, bristot@redhat.com, bsegall@google.com,
	dietmar.eggemann@arm.com, jstultz@google.com, juri.lelli@redhat.com,
	longman@redhat.com, mgorman@suse.de, mingo@redhat.com,
	rostedt@goodmis.org, swood@redhat.com, vincent.guittot@linaro.org,
	vschneid@redhat.com, will@kernel.org
Subject: Re: [PATCH v3 7/7] locking/rtmutex: Acquire the hb lock via trylock
 after wait-proxylock.
Message-ID: <20240115121632.FX1P0-fi@linutronix.de>
References: <20230908162254.999499-1-bigeasy@linutronix.de>
 <20230908162254.999499-8-bigeasy@linutronix.de>
 <20230911141135.GB9098@noisy.programming.kicks-ass.net>
 <87fs3f1tl0.ffs@tglx>
 <20230915151943.GD6743@noisy.programming.kicks-ass.net>
 <4611bcf2-44d0-4c34-9b84-17406f881003@kernel.org>
 <9f75eb59-9b7a-4b49-9081-e6a3cbb00187@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <9f75eb59-9b7a-4b49-9081-e6a3cbb00187@kernel.org>

On 2024-01-15 12:52:49 [+0100], Jiri Slaby wrote:
=E2=80=A6
> >=20
> > The child in fact terminates on
> > https://github.com/apache/apr/blob/trunk/test/testprocmutex.c#L93:
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 while ((rv =3D apr_proc_mutex_timedlock(proc_lock, 1)=
)) {
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!APR_STATUS_IS_TIMEUP(rv))
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(=
1); <----- here
> >=20
> > The test creates 6 children and does some
> > pthread_mutex_timedlock/unlock() repeatedly (200 times) in parallel
> > while sleeping 1 us inside the lock. The timeout is 1 us above. And the
> > test expects all them to fail (to time out). But the time out does not
> > always happen in 6.7 (it's racy, so the failure is semi-random: like 1
> > of 1000 attempts is bad).
>=20
> This is not precise as I misinterpreted. The test is: either it succeeds =
or
> times out.
>=20
> But since the commit, futex() yields 22/EINVAL, i.e. fails.

Let me see if I can reproduce it here=E2=80=A6

Sebastian


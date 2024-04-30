Return-Path: <linux-kernel+bounces-164737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD168B81DF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFE761F2441D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD1F1A38F7;
	Tue, 30 Apr 2024 21:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vhq+JACf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E729E1A38ED
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 21:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714512412; cv=none; b=dSEjRRgksezPzy/NyeycjerCDnkf8HrAqMytjZzTMVLfmDQzIHlZIBlmk+UUSE4IHzjAltCnA/qP9arMeW09Ijs9gBn2siCJqHLLRUv9WA2rKepQ8fmXOS7Vf0qlyahmiJZV06yOydOVapb7k9JDl6y98Ys7nkF8t4xZZ36f2h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714512412; c=relaxed/simple;
	bh=SGYi5VuZR33uz63/sXp7zU6nTkfsWCA3YLBiPSt+5as=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MVZTma0tg5l4m0CtXNQodsxiiazdoqw+60iirJFshsKgLz/tmjDonlIEcuuV7SK7DQEjg2T5I1JdfrldW3KcufDZLK2GySXPv8BYkcKfPqmciBljjXQlVf8PDG352cE9DoumMkrRrLsagToo+MYCUKKj0vHdhCZhyF0JDkzAvjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vhq+JACf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714512409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JfZAEqDBfiK1JJFvF07sHM+Lm1XotY6mzbSMQdGH+h8=;
	b=Vhq+JACfIA2aBM0vMw21kmBfPgn+J+Ks/jgnDuL9lh+iW42NJIfCVhUIbTMc5XF1qWNuzS
	UT5kV01zUmrg5lRQsDR03Brdq1aBilKtyKAyZqB6u1VXwxRJ453rehFuFhbSmdNhXoQ8GX
	KGYo3jQGWy4Q3rdkF1GMTHHJPVhWSdk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-RHIpUgbQPX2jdQ93Nv85cA-1; Tue, 30 Apr 2024 17:26:43 -0400
X-MC-Unique: RHIpUgbQPX2jdQ93Nv85cA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 952488032FA;
	Tue, 30 Apr 2024 21:26:42 +0000 (UTC)
Received: from [10.2.16.177] (unknown [10.2.16.177])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5D7A840C6CC0;
	Tue, 30 Apr 2024 21:26:41 +0000 (UTC)
Message-ID: <32eecb5cec36c6766484607717210bae0f1dab42.camel@redhat.com>
Subject: Re: [RFC PATCH] genirq: don't disable BH for PREEMPT_RT
From: Crystal Wood <crwood@redhat.com>
To: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, Thomas Gleixner
	 <tglx@linutronix.de>
Cc: Vincent Whitchurch <vincent.whitchurch@axis.com>, "Rafael J . Wysocki"
	 <rafael.j.wysocki@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Andreas Gruenbacher
	 <agruenba@redhat.com>, linux-kernel@vger.kernel.org
Date: Tue, 30 Apr 2024 16:26:41 -0500
In-Reply-To: <20240415112800.314649-1-vladimir.kondratiev@mobileye.com>
References: <20240415112800.314649-1-vladimir.kondratiev@mobileye.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On Mon, 2024-04-15 at 14:28 +0300, Vladimir Kondratiev wrote:
> With PREEMPT_RT, both BH and irq handled in threads.
> BH served by the ksoftirqd that is SCHED_OTHER, IRQ threads are
> SCHED_FIFO with some priority (default is 50).
>=20
> On the test platform the following observed:
>=20
> - ksoftirqd thread running, servicing softirqs
> - hard IRQ received by the CPU. Default handler wakes up IRQ thread
> =C2=A0 and exits
> - in the IRQ thread, force_irqthreads is defined as (true) for PREEMPT_RT
> =C2=A0 thus handler is irq_forced_thread_fn
> - before calling IRQ handler, irq_forced_thread_fn calls
> =C2=A0 local_bh_disable(); it in turn acquires local_lock(&softirq_ctrl.l=
ock);
> - softirq_ctrl.lock still owned by the ksoftirqd thread, so
> =C2=A0 slow path taken (rt_spin_lock_slowlock), causing context switch to=
 the
> =C2=A0 ksoftirqd (with properly adjusted priority) and waiting for it to
> =C2=A0 release the lock. Then, context switched back to the IRQ thread
> - as result, IRQ handler invoked with observed delay for several
> =C2=A0 hundreds micro-seconds on 2GHz platform.
>=20
> This causes failure to deliver on real-time latency requirements.
>=20
> What is the reason for disabling BH in the PREEMPT_RT? Looks like
> it is more reasonable to let scheduler to run threads according to
> priorities; IRQ thread will preempt BHs, run to its completion.
>=20
> Experiment conducted with this approach, smooth execution observed with
> no spikes in the IRQ latency.
>=20
> I am likely missing corner cases with this approach, so this is request
> for comments. Input welcome

I don't know if anything is actually depending on the mutual exclusion, but
disabling BH there causes any softirq raised by the irq to run in
local_bh_enable() rather than waking ksoftirqd.  It also appears to be the
only thing causing in_interrupt() to return true inside the threaded
handler, which may or may not actually matter.

-Crystal



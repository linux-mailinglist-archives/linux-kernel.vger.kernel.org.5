Return-Path: <linux-kernel+bounces-32040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E9383559C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 13:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 665A71F215FE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 12:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFA736AFB;
	Sun, 21 Jan 2024 12:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RmsnFOvk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27A412E59
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 12:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705838964; cv=none; b=ZorzpGDNvkG3IT7YtrWOaxzxMb+oJ5oRIiwVZCtXZ+XaSu1+u0C8QRlRPNCFyPIkI+QXLtYcfe/GlUSmuHOfsLxYDcJR0bydT6zIk4xOb2JvUSpwhDnPfY4WNLGLuuWnrMxrZwNSFBHXbsKnT+occeIiGXwvaRJkP5FsGYUl2Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705838964; c=relaxed/simple;
	bh=ywucihbEZtAwUAoztcsPJW2jtsM/QNTyPlqlL77yKmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEaOoJGNtnRHfumHDSih90JgChvYP9I9aYV5ajIra3mVubX+mcTkaW8ymUNi4yjYauGfC6F24MxfJTXieKHCDmen94ErUt8kq+RUmgUvTQaLUNP60gJ1D+unXfB7niqTAwIKjA6GqSrfI9ZJugD9dvLPvKwg13+WNwAJ8knXvNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RmsnFOvk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705838961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=njG3gKc62UJc7HgDAh1SK2MaK5/xyFMyFyxaC4o9424=;
	b=RmsnFOvkTbSZ0wuiS7zMOmN5SG/mob2VXAotjVorIRXYa9/iqupTHVPncor7xSSQ6wV5hF
	m6ji/iuuV1WooOEqGULXEw5/sg/7nC5F2aAPAiHIL0vHEji+VyVsVUAIqUZdvdIMWaJtj3
	Qr0ad86hqC5ytfhiVRLqC24QVoLx0+Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-A-lisYmZO9-Us9d6ryWS0w-1; Sun, 21 Jan 2024 07:09:15 -0500
X-MC-Unique: A-lisYmZO9-Us9d6ryWS0w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC2021013768;
	Sun, 21 Jan 2024 12:09:14 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.6])
	by smtp.corp.redhat.com (Postfix) with SMTP id 7BB942BA;
	Sun, 21 Jan 2024 12:09:08 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 21 Jan 2024 13:08:01 +0100 (CET)
Date: Sun, 21 Jan 2024 13:07:54 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Dylan Hatch <dylanbhatch@google.com>, Kees Cook <keescook@chromium.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mike Christie <michael.christie@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Stefan Roesch <shr@devkernel.io>, Joey Gouly <joey.gouly@arm.com>,
	Josh Triplett <josh@joshtriplett.org>, Helge Deller <deller@gmx.de>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Florent Revest <revest@chromium.org>,
	Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] getrusage: use sig->stats_lock
Message-ID: <20240121120754.GA2814@redhat.com>
References: <20240117192534.1327608-1-dylanbhatch@google.com>
 <20240119141501.GA23739@redhat.com>
 <20240119141529.GB23739@redhat.com>
 <CADBMgpxC+BP-wfrM-wP1nbZOcRb0LbsmMDQ3LQ8hUKYsF3QECw@mail.gmail.com>
 <20240120204552.c0708fd10fc8e2442c447049@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240120204552.c0708fd10fc8e2442c447049@linux-foundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 01/20, Andrew Morton wrote:
>
> On Fri, 19 Jan 2024 19:27:49 -0800 Dylan Hatch <dylanbhatch@google.com> wrote:
>
> >
> > I applied these to a 5.10 kernel, and my repro (calling getrusage(RUSAGE_SELF)
> > from 200K threads) is no longer triggering a hard lockup.
>
> Thanks, but...
>
> The changelogs don't actually describe any hard lockup.  [1/2] does
> mention "the deadlock" but that's all the info we have.

Sorry for confusion... 1/2 tries to explain that this change is not
strictly necessary for 2/2, it is safe to call thread_group_cputime()
with sig->stats_lock held for writing even if thread_group_cputime()
takes the same lock, because in this case thread_group_cputime() can't
enter the slow mode.

> So could we please have a suitable description of the bug which these are
> addressing?  And a Reported-by:, a Closes: and a Fixes would be great too.

Yes sorry I forgot to add Reported-by. So I'll try to update the changelog
and add Reported-and-tested-by.

But the problem is known and old. I think do_io_accounting() had the same
problem until 1df4bd83cdfdbd0 ("do_io_accounting: use sig->stats_lock").
and do_task_stat() ...

getrusage() takes siglock and does for_each_thread() twice. If NR_THREADS
call sys_getrusage() in an endless loop on NR_CPUS, lock_task_sighand()
can trigger a hard lockup because it spins with irqs disabled waiting
for other NR_CPUS-1 which need the same siglock. So the time it spins
with irqs disabled is O(NR_CPUS * NR_THREADS).

With this patch all the threads can run lockless in parallel in the
likely case.

Dylan, do you have a better description? Can you share your repro?
although I think that something simple like

	#define NT BIG_NUMBER

	pthread_barrier_t barr;

	void *thread(void *arg)
	{
		struct rusage ru;

		pthread_barrier_wait(&barr);
		for (;;)
			getrusage(RUSAGE_SELF, &ru);
		return NULL;
	}

	int main(void)
	{
		pthread_barrier_init(&barr, NULL, NT);

		for (int n = 0; n < NT-1; ++n) {
			pthread_t pt;
			pthread_create(&pt, NULL, thread, NULL);
		}
		thread(NULL);

		return 0;
	}

should work if you have a machine with a lot of memory/cpus.

Oleg.



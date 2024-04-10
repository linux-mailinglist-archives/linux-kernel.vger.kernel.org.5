Return-Path: <linux-kernel+bounces-138690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C13289F916
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88BC61F2EDCA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE851607B5;
	Wed, 10 Apr 2024 13:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KqUHMNVf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CE6158D76
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 13:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757419; cv=none; b=DvOm/mpnbw1ey/eWW6Z99kEG0UH8zvQ66e4AV/aDbN8mz5CJsSH5UgAiMiHAXlRFZe83xAli7TGDC2hxbAXnbGgdV4u9Tc4RzsMclEvqsktxGDShDuKpKxS+naYDso2jDiDHWZUAPxTq8AXKMrupOzevinF1d02xCue6xBsGKw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757419; c=relaxed/simple;
	bh=a/6fPJB+6sGt2baLsQ7SF9JR4r2ue+Tbv6yypaQjgaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGbl0bomwd5gK46jEciZn3t7R1FTKTvk8L/rfYFgkaOjgTgdMPJJGQduTqiyzIsZdONMLCeIZfBivH8YcI0qKvKfZSAZM/nHqXmHdAkBUHDKu6mUF5k99ld9PTAbD9+XFsuQgKpb3t1koLSdcUQ1yASygp5z+8vCKDwhMy4bkpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KqUHMNVf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712757417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zFdmNMDYQQLVXYS/kWQ3R+qYUh/fOYpQJWGMU6aElHc=;
	b=KqUHMNVfPThlKi/IbZcevsou13qFnYa+heUIUjUb3d4/t/iz+cba04ZM4dcgKIL7nXa6mY
	PAbT/mEND9+qVsxAchKmXqebz6LwdO2rlNjqlWfZiefu4RQAvmTAyoJhYphbmdP1LaGgnz
	bmz6pzcE4+iruaWH47ZjtRUFPA1+ADM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-Yd4TuNPJPj-_4e2NFH8VpA-1; Wed, 10 Apr 2024 09:56:53 -0400
X-MC-Unique: Yd4TuNPJPj-_4e2NFH8VpA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 297C38007BA;
	Wed, 10 Apr 2024 13:56:53 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.47])
	by smtp.corp.redhat.com (Postfix) with SMTP id 459032166B34;
	Wed, 10 Apr 2024 13:56:50 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 10 Apr 2024 15:55:27 +0200 (CEST)
Date: Wed, 10 Apr 2024 15:55:19 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>, Tejun Heo <tj@kernel.org>,
	Leonardo Bras <leobras@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org, Junyao Zhao <junzhao@redhat.com>,
	Chris von Recklinghausen <crecklin@redhat.com>
Subject: Re: Nohz_full on boot CPU is broken (was: Re: [PATCH v2 1/1] wq:
 Avoid using isolated cpus' timers on queue_delayed_work)
Message-ID: <20240410135518.GA25421@redhat.com>
References: <20240130010046.2730139-2-leobras@redhat.com>
 <20240402105847.GA24832@redhat.com>
 <Zg2qFinSkAOmRHcM@slm.duckdns.org>
 <20240403203814.GD31764@redhat.com>
 <20240405140449.GB22839@redhat.com>
 <ZhByg-xQv6_PC3Pd@localhost.localdomain>
 <20240407130914.GA10796@redhat.com>
 <ZhUu0uQxPgcXmQes@localhost.localdomain>
 <20240409130727.GC29396@redhat.com>
 <D0G5OX8W9NH9.1HE33RVAROAJK@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D0G5OX8W9NH9.1HE33RVAROAJK@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Hi Nicholas,

On 04/10, Nicholas Piggin wrote:
>
> Thanks for this. Taking a while to page this back in, the intention is
> for housekeeping to be done by boot CPU until house keeper is awake, so
> returning smp_processor_id() seems like the right thing to do here for
> ephemeral jobs like timers and work, provided that CPU / mask is not
> stored somewhere long term by the caller.
>
> For things that set an affinity like kthread, sched, maybe managed
> irqs, and such.
>
> There are not many callers of housekeeping_any_cpu() so that's easy
> enough to verify. But similar like housekeeping_cpumask() and others
> could be an issue or at least a foot-gun, I'm not sure how well I
> convinced myself of those.
>
> Could you test like this?
>
>   WARN_ON_ONCE(system_state == SYSTEM_RUNNING ||
>                type != HK_TYPE_TIMER);
>
> With a comment to say other ephemeral mask types could be exempted if
> needed.

Sorry, I don't understand... Let me repeat, I know absolutely nothing
about nonhz/etc. I didn't even try to really fix the problem(s), I am
only trying to find a minimal/simple workaround to fix the problem we
hit in Red Hat.

This is what I was going to send:

	--- a/kernel/sched/isolation.c
	+++ b/kernel/sched/isolation.c
	@@ -46,7 +46,15 @@ int housekeeping_any_cpu(enum hk_type type)
				if (cpu < nr_cpu_ids)
					return cpu;
	 
	-			return cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
	+			cpu = cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
	+			if (likely(cpu < nr_cpu_ids))
	+				return cpu;
	+			/*
	+			 * Unless we have another problem this can only happen
	+			 * at boot time before start_secondary() brings the 1st
	+			 * housekeeping CPU up.
	+			 */
	+			WARN_ON_ONCE(system_state == SYSTEM_RUNNING);
			}
		}
		return smp_processor_id();

Yes, this fixes the symptom, not the problem. And yes, "another problem"
mentioned in the comment is very possible, say "maxcpus" kernel-parameter
can be less than the first housekeeping cpu. But in this case the user
should blame himself (and I am not sure the kernel will boot).

I don't understand why do you suggest to add "|| type != HK_TYPE_TIMER",
currently all the callers of housekeeping_any_cpu() use type == HK_TIMER.
But OK, I can add this check. I guess for the case it finds another user
with type != HK_TYPE_TIMER which can't use smp_processor_id() even at
boot time or stores the returned CPU for the long term.

Will you agree with the change above or what do you suggest instead as
a simple workaround?


> It would also be nice to warn for cases that would be bugs if the boot
> CPU was not in the HK mask. Could that be done by having a
> housekeepers_online() call after smp_init() (maybe at the start of
> sched_init_smp()) that could verify there is at least one online, and
> set a flag that could be used to create warnings.

Again, I am not sure I understand, but I too thought that something like

	housekeeping_check(void)
	{
		for_each_set_bit(type, &housekeeping.flags, HK_TYPE_MAX) {
			if (!cpumask_intersects(cpu_online, housekeeping.cpumasks[type]))
				panic();
		}

after bringup_nonboot_cpus(setup_max_cpus).

But I am not sure this is correct and this is another (although related) issue.

Oleg.



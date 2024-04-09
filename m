Return-Path: <linux-kernel+bounces-136919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A8389D9D9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 080AD1F21D27
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C67612F361;
	Tue,  9 Apr 2024 13:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HfAWYJOU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAF012E1E3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 13:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712668146; cv=none; b=e+ISQxltP39/kDW0PnDeO802WAwC0huy/kqRna8M/PWvhqmIm0Dg2+jfdnOkQK5tnWqqxPVl13QDe5zmNMA6fpk7nsUy+HeZgwxWEfHhAusz5lbSie3neZWIdNj2Q9OQVVmIy9kVZYqCvWGwRZmXNxSQfTaH6BgRpkp4s/TCWJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712668146; c=relaxed/simple;
	bh=YyfkRCglHo3mOCrB+ZApepkzfFGd7pYwbTakFb2oAvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBiea2kCXnvf4JFN6EiSu/kN+ITKYjcADulSggGhbXw6L4h+T6lqQxjmz7uNQc6Ez08PopqgMzDrgu4QI8b61tGfr47alauYpYdHVWiNvmEcww3qWaHwNqumHIolF9DGgRpxNMT2BVUPOGydepENZ8+SaChdzGqhPi3EPuy7N9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HfAWYJOU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712668143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=doQL+4ACpKfG0Ql9jhMoc9todtt+MGTYR4v3X2YBERw=;
	b=HfAWYJOUorGEDQ866XzFk9RgEeupZSUlf0bc+9WZSK64sKvgIpCZvFGA7nqNItvL2L99dp
	oygNto6AJ8Okw780aerpxasXCaoe2Dzi1tmmD7HAom4XNWnVEsWeIs5S4wdgpbqmTeX6Vr
	PHyhjR1+qVsfpbdTLuH31YXI97uuzeo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-D1mhsbVHOUWIHNJgfCnzaA-1; Tue, 09 Apr 2024 09:09:02 -0400
X-MC-Unique: D1mhsbVHOUWIHNJgfCnzaA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CFC92889AAA;
	Tue,  9 Apr 2024 13:09:01 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.56])
	by smtp.corp.redhat.com (Postfix) with SMTP id 4EFC21C060A6;
	Tue,  9 Apr 2024 13:08:59 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  9 Apr 2024 15:07:36 +0200 (CEST)
Date: Tue, 9 Apr 2024 15:07:28 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Nick Piggin <npiggin@gmail.com>, Tejun Heo <tj@kernel.org>,
	Leonardo Bras <leobras@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org, Junyao Zhao <junzhao@redhat.com>,
	Chris von Recklinghausen <crecklin@redhat.com>
Subject: Re: Nohz_full on boot CPU is broken (was: Re: [PATCH v2 1/1] wq:
 Avoid using isolated cpus' timers on queue_delayed_work)
Message-ID: <20240409130727.GC29396@redhat.com>
References: <20240130010046.2730139-2-leobras@redhat.com>
 <20240402105847.GA24832@redhat.com>
 <Zg2qFinSkAOmRHcM@slm.duckdns.org>
 <20240403203814.GD31764@redhat.com>
 <20240405140449.GB22839@redhat.com>
 <ZhByg-xQv6_PC3Pd@localhost.localdomain>
 <20240407130914.GA10796@redhat.com>
 <ZhUu0uQxPgcXmQes@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZhUu0uQxPgcXmQes@localhost.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 04/09, Frederic Weisbecker wrote:
>
> Le Sun, Apr 07, 2024 at 03:09:14PM +0200, Oleg Nesterov a écrit :
> > Well, the changelog says
> >
> >     nohz_full has been trialed at a large supercomputer site and found to
> >     significantly reduce jitter. In order to deploy it in production, they
> >     need CPU0 to be nohz_full
> >
> > so I guess this feature has users.
> >
> > But after the commit aae17ebb53cd3da ("workqueue: Avoid using isolated cpus'
> > timers on queue_delayed_work") the kernel will crash at boot time if the boot
> > CPU is nohz_full.
>
> Right but there are many possible calls to housekeeping on boot before the
> first housekeeper becomes online.

Well, it seems that other callers are more or less fine in this respect...
At least the kernel boots fine with that commit reverted.

But a) I didn't try to really check, and b) this doesn't matter.

I agree, and that is why I never blamed this change in queue_delayed_work().

OK, you seem to agree with the patch below, I'll write the changelog/comment
and send it "officially".

Or did I misunderstand you?

Oleg.


diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 373d42c707bc..e912555c6fc8 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -46,7 +46,11 @@ int housekeeping_any_cpu(enum hk_type type)
 			if (cpu < nr_cpu_ids)
 				return cpu;
 
-			return cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
+			cpu = cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
+			if (cpu < nr_cpu_ids)
+				return cpu;
+
+			WARN_ON_ONCE(system_state == SYSTEM_RUNNING);
 		}
 	}
 	return smp_processor_id();



Return-Path: <linux-kernel+bounces-31255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 351DE832B41
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C99261F25968
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B24853E15;
	Fri, 19 Jan 2024 14:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h8BC9ThI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F9F52F89
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 14:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705673787; cv=none; b=nDT2p6ciSmOpgvw9lh7QQEDNmmPQ1fUiJLmBElb1Ix3e76Vb+qU+pzcwg6wFn2bWd1EoScFE8TgInJdFeL0qYsDzXeer98Nq2tEnNU26m7tXQXRy58eE2ZI+gfxnfgrAL5K9K/OKLLwJuz+sUsu6/h00qH/iQU5doAsxENsaaB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705673787; c=relaxed/simple;
	bh=nv2GpNG+L8QnLw7AeDXbcdaQi7ztbj6Xlz2y/QmgdDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjU3hSrshqnhsBJUFEbNCOof/daic+kKDPMjg91TzP1Y2BFBzwZAb61AClItPVUg+o+KhT9vFJL85D36lfXconB9+YCeTbeoI9lOUzzFMlmE8WDrWigjZbcShr96NIyT7kqaGj7Y7xepKYXvdV+7OjyCrx30zcuSCtAat+4IO3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h8BC9ThI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705673785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NvEKGuuarKJEMXHUtudRSVocElOnguvaapshPozeGjw=;
	b=h8BC9ThIXVia6jKt79hHDpPePAlEZfz2/02IYqbSa5uvdyUYxG/SEMV4UbV6zbE54EvYyR
	rxjcLqgVq4vGDHx6IybSsIaKvkNipqPzdG9tswCmzWJzoFX3hNXWoYtBQaTayT14RSxmnA
	l3p+zFQJBEu4YItL6VH76ltF+JUkfZs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-73-V2RrU0_wMFujMmTaVAEtZw-1; Fri,
 19 Jan 2024 09:16:21 -0500
X-MC-Unique: V2RrU0_wMFujMmTaVAEtZw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7382C3C2AB16;
	Fri, 19 Jan 2024 14:16:20 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.76])
	by smtp.corp.redhat.com (Postfix) with SMTP id 698A42166B35;
	Fri, 19 Jan 2024 14:16:14 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 19 Jan 2024 15:15:07 +0100 (CET)
Date: Fri, 19 Jan 2024 15:15:01 +0100
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
Subject: [PATCH 1/2] getrusage: move thread_group_cputime_adjusted() outside
 of lock_task_sighand()
Message-ID: <20240119141501.GA23739@redhat.com>
References: <20240117192534.1327608-1-dylanbhatch@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117192534.1327608-1-dylanbhatch@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

thread_group_cputime() does its own locking, we can safely shift
thread_group_cputime_adjusted() which does another for_each_thread loop
outside of ->siglock protected section.

This is also preparation for the next patch which changes getrusage() to
use stats_lock instead of siglock. Currently the deadlock is not possible,
if getrusage() enters the slow path and takes stats_lock, read_seqretry()
in thread_group_cputime() must always return 0, so thread_group_cputime()
will never try to take the same lock. Yet this looks more safe and better
performance-wise.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/sys.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index e219fcfa112d..70ad06ad852e 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1785,17 +1785,19 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 	struct task_struct *t;
 	unsigned long flags;
 	u64 tgutime, tgstime, utime, stime;
-	unsigned long maxrss = 0;
+	unsigned long maxrss;
+	struct mm_struct *mm;
 	struct signal_struct *sig = p->signal;
 
-	memset((char *)r, 0, sizeof (*r));
+	memset(r, 0, sizeof(*r));
 	utime = stime = 0;
+	maxrss = 0;
 
 	if (who == RUSAGE_THREAD) {
 		task_cputime_adjusted(current, &utime, &stime);
 		accumulate_thread_rusage(p, r);
 		maxrss = sig->maxrss;
-		goto out;
+		goto out_thread;
 	}
 
 	if (!lock_task_sighand(p, &flags))
@@ -1819,9 +1821,6 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 		fallthrough;
 
 	case RUSAGE_SELF:
-		thread_group_cputime_adjusted(p, &tgutime, &tgstime);
-		utime += tgutime;
-		stime += tgstime;
 		r->ru_nvcsw += sig->nvcsw;
 		r->ru_nivcsw += sig->nivcsw;
 		r->ru_minflt += sig->min_flt;
@@ -1839,19 +1838,24 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 	}
 	unlock_task_sighand(p, &flags);
 
-out:
-	r->ru_utime = ns_to_kernel_old_timeval(utime);
-	r->ru_stime = ns_to_kernel_old_timeval(stime);
+	if (who == RUSAGE_CHILDREN)
+		goto out_children;
 
-	if (who != RUSAGE_CHILDREN) {
-		struct mm_struct *mm = get_task_mm(p);
+	thread_group_cputime_adjusted(p, &tgutime, &tgstime);
+	utime += tgutime;
+	stime += tgstime;
 
-		if (mm) {
-			setmax_mm_hiwater_rss(&maxrss, mm);
-			mmput(mm);
-		}
+out_thread:
+	mm = get_task_mm(p);
+	if (mm) {
+		setmax_mm_hiwater_rss(&maxrss, mm);
+		mmput(mm);
 	}
+
+out_children:
 	r->ru_maxrss = maxrss * (PAGE_SIZE / 1024); /* convert pages to KBs */
+	r->ru_utime = ns_to_kernel_old_timeval(utime);
+	r->ru_stime = ns_to_kernel_old_timeval(stime);
 }
 
 SYSCALL_DEFINE2(getrusage, int, who, struct rusage __user *, ru)
-- 
2.25.1.362.g51ebf55




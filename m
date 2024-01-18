Return-Path: <linux-kernel+bounces-30321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF56D831D13
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70E3C1F21E60
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBAE28DCB;
	Thu, 18 Jan 2024 15:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aW9U3Cf4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FE328DBE
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 15:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705593503; cv=none; b=AZepTDmU7Xld7N/dfRVCHCHmDC07wV72zALVffnEdcqJBriMswuaKzNBdsR8EKNRtnUcDSfYeS9G6vv7H1PZLwwYZ/xPmcOGv7kXcTUiIlZ115v01fphIdw7OiILyt+diqesITXaxR8zpTZPGwPQzM21MxJG4yE1PJBJMNvIsRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705593503; c=relaxed/simple;
	bh=8CaDs+CjLaW9DHqUml+lCbr0MBeL3UzroduzmKzDvFg=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent:
	 X-Scanned-By; b=hvbawmG3MRojDmuo+Aar1mQKmySPNAm16e6MVyIm4Oa22A7Gy1hvz4sVyxojb0I5pVD5sOOmt+vaa5naRsXiKR7bSKJ4yC93DVqWxamTOUXRwEMnw8GDmmaiMb5r5/6pPvlgF5h20xa1ZArAgO5wE8KHHXQ+oKMLXZfBImC6Efw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aW9U3Cf4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705593500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AJlRlMSn9Tux/y1MTmqum9WOCp9JOJB/R0qG6qSOtrU=;
	b=aW9U3Cf4Gz9RZ0t/mwfudRKSoQIgAr9Rb4saq6IPTAp7ES8jIh7ChIu/eJy5X6xnjWgdLc
	CAk5CN8JcfnB+hwwg84N9/5gT+g/kpzY24ZZVjbMyNcYmgPaAZomTb8fhAifvsKvwaOyfu
	X+OlWT3gfy+nZKsSLU8C8cPrOrpoLw4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-1oNEHh_KNIiebxOVhiJYUg-1; Thu,
 18 Jan 2024 10:58:17 -0500
X-MC-Unique: 1oNEHh_KNIiebxOVhiJYUg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A0A6F29AA389;
	Thu, 18 Jan 2024 15:58:14 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.126])
	by smtp.corp.redhat.com (Postfix) with SMTP id 3709C492BE3;
	Thu, 18 Jan 2024 15:58:09 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 18 Jan 2024 16:57:02 +0100 (CET)
Date: Thu, 18 Jan 2024 16:56:55 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Dylan Hatch <dylanbhatch@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
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
Subject: Re: [RFC PATCH] getrusage: Use trylock when getting sighand lock.
Message-ID: <20240118155655.GA8174@redhat.com>
References: <20240117192534.1327608-1-dylanbhatch@google.com>
 <20240117204416.GB32526@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117204416.GB32526@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 01/17, Oleg Nesterov wrote:
>
> Heh ;)
>
> getrusage() should not use ->siglock at all.
>
> On my TODO list. I'll try to make a patch this week.

something like below...

I need to re-check this change, split it into 2 patches, and write
the changelogs. Hopefully tomorrow.

Oleg.
---

diff --git a/kernel/sys.c b/kernel/sys.c
index e219fcfa112d..0728744a90a6 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1785,21 +1785,24 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 	struct task_struct *t;
 	unsigned long flags;
 	u64 tgutime, tgstime, utime, stime;
-	unsigned long maxrss = 0;
+	unsigned long maxrss;
+	struct mm_struct *mm;
 	struct signal_struct *sig = p->signal;
+	unsigned int seq = 0;
 
+retry:
 	memset((char *)r, 0, sizeof (*r));
 	utime = stime = 0;
+	maxrss = 0;
 
 	if (who == RUSAGE_THREAD) {
 		task_cputime_adjusted(current, &utime, &stime);
 		accumulate_thread_rusage(p, r);
 		maxrss = sig->maxrss;
-		goto out;
+		goto out_thread;
 	}
 
-	if (!lock_task_sighand(p, &flags))
-		return;
+	flags = read_seqbegin_or_lock_irqsave(&sig->stats_lock, &seq);
 
 	switch (who) {
 	case RUSAGE_BOTH:
@@ -1819,9 +1822,6 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 		fallthrough;
 
 	case RUSAGE_SELF:
-		thread_group_cputime_adjusted(p, &tgutime, &tgstime);
-		utime += tgutime;
-		stime += tgstime;
 		r->ru_nvcsw += sig->nvcsw;
 		r->ru_nivcsw += sig->nivcsw;
 		r->ru_minflt += sig->min_flt;
@@ -1830,28 +1830,42 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 		r->ru_oublock += sig->oublock;
 		if (maxrss < sig->maxrss)
 			maxrss = sig->maxrss;
+
+		rcu_read_lock();
 		__for_each_thread(sig, t)
 			accumulate_thread_rusage(t, r);
+		rcu_read_unlock();
+
 		break;
 
 	default:
 		BUG();
 	}
-	unlock_task_sighand(p, &flags);
 
-out:
-	r->ru_utime = ns_to_kernel_old_timeval(utime);
-	r->ru_stime = ns_to_kernel_old_timeval(stime);
+	if (need_seqretry(&sig->stats_lock, seq)) {
+		seq = 1;
+		goto retry;
+	}
+	done_seqretry_irqrestore(&sig->stats_lock, seq, flags);
 
-	if (who != RUSAGE_CHILDREN) {
-		struct mm_struct *mm = get_task_mm(p);
+	if (who == RUSAGE_CHILDREN)
+		goto done;
 
-		if (mm) {
-			setmax_mm_hiwater_rss(&maxrss, mm);
-			mmput(mm);
-		}
+	thread_group_cputime_adjusted(p, &tgutime, &tgstime);
+	utime += tgutime;
+	stime += tgstime;
+
+out_thread:
+	mm = get_task_mm(p);
+	if (mm) {
+		setmax_mm_hiwater_rss(&maxrss, mm);
+		mmput(mm);
 	}
+
+done:
 	r->ru_maxrss = maxrss * (PAGE_SIZE / 1024); /* convert pages to KBs */
+	r->ru_utime = ns_to_kernel_old_timeval(utime);
+	r->ru_stime = ns_to_kernel_old_timeval(stime);
 }
 
 SYSCALL_DEFINE2(getrusage, int, who, struct rusage __user *, ru)



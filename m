Return-Path: <linux-kernel+bounces-31256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D511A832B42
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 151591C20E0E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8461454645;
	Fri, 19 Jan 2024 14:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SBr5x5Io"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7108B53E26
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 14:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705673815; cv=none; b=rq5dO2VUDemaEz5gxsPJhchSI4FsWgTyXvsYjqT5WlUrQssl5d0bfE83hLxMzIheE3MRzN62X0cbM2UIip3LHE2chVwXLfQRBC/xl2niKH5iVxFOLqiAbHaSG2lwL8ana3oYdlvrzVqPQyDi2pfzWjFqVsrzmAvhD63eTibfZfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705673815; c=relaxed/simple;
	bh=Xbcs19ZYZcSQ22stH3DjVr44WfloaloNH9pKkDdJBnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/TG4Jz0la+nuCymwFCh1CB9AXVorO6Q1zGxWrto6iOpv0KKqu/1UlbFZPpdyEAQG65dq4yQUi161yJu05Yl/FREa2AlxnivFJz22O7yN8J/xyHk9QmPDNqkm32zyLeqEIY9qJpcwZc5fkBxn402tbg/bQtTj1qaJvOpyrNfbx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SBr5x5Io; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705673813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U3yNtjjE98uS/yDPKacBKDhjGT/OEt4ng6RXnK6CzGQ=;
	b=SBr5x5IoA1zTuGtjXteGDPpZJxtjJS5xB+NX/1FGcSpP/Vgy2MI++FDBMZJ4SccI1fzwfH
	XMmMNMCOZqxh4DIrgXfXk1Lvog2fGjt/uhbc7olXZRhdiUqXNdOe9mrxMflOfAqjq5+6gv
	tVRlHtqjHaCTzTMRVMP44DaaqmyutJo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-176-CMNhnj8rN7aJvNoXyZJslQ-1; Fri,
 19 Jan 2024 09:16:48 -0500
X-MC-Unique: CMNhnj8rN7aJvNoXyZJslQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD12729AA385;
	Fri, 19 Jan 2024 14:16:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.76])
	by smtp.corp.redhat.com (Postfix) with SMTP id 59F1BC0FDCC;
	Fri, 19 Jan 2024 14:16:42 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 19 Jan 2024 15:15:35 +0100 (CET)
Date: Fri, 19 Jan 2024 15:15:29 +0100
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
Subject: [PATCH 2/2] getrusage: use sig->stats_lock
Message-ID: <20240119141529.GB23739@redhat.com>
References: <20240117192534.1327608-1-dylanbhatch@google.com>
 <20240119141501.GA23739@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119141501.GA23739@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Rather than lock_task_sighand(), sig->stats_lock was specifically designed
for this type of use. This way getrusage runs lockless in the likely case.

TODO:
	- Change do_task_stat() to use sig->stats_lock too, then we can
	  remove spin_lock_irq(siglock) in wait_task_zombie().

	- Turn sig->stats_lock into seqcount_rwlock_t, this way the
	  readers in the slow mode won't exclude each other. See
	  https://lore.kernel.org/all/20230913154907.GA26210@redhat.com/

	- stats_lock has to disable irqs because ->siglock can be taken
	  in irq context, it would be very nice to change __exit_signal()
	  to avoid the siglock->stats_lock dependency.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/sys.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 70ad06ad852e..f8e543f1e38a 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1788,7 +1788,9 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 	unsigned long maxrss;
 	struct mm_struct *mm;
 	struct signal_struct *sig = p->signal;
+	unsigned int seq = 0;
 
+retry:
 	memset(r, 0, sizeof(*r));
 	utime = stime = 0;
 	maxrss = 0;
@@ -1800,8 +1802,7 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 		goto out_thread;
 	}
 
-	if (!lock_task_sighand(p, &flags))
-		return;
+	flags = read_seqbegin_or_lock_irqsave(&sig->stats_lock, &seq);
 
 	switch (who) {
 	case RUSAGE_BOTH:
@@ -1829,14 +1830,23 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
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
+
+	if (need_seqretry(&sig->stats_lock, seq)) {
+		seq = 1;
+		goto retry;
+	}
+	done_seqretry_irqrestore(&sig->stats_lock, seq, flags);
 
 	if (who == RUSAGE_CHILDREN)
 		goto out_children;
-- 
2.25.1.362.g51ebf55




Return-Path: <linux-kernel+bounces-33631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB305836C7D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 913611F23D55
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F70960ED3;
	Mon, 22 Jan 2024 15:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lr7zLM9F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318F44A990
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 15:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705938735; cv=none; b=Ed1KozcSlSXG7bVMCLTFoR+AMRYM1bMPEDT/c0nsxX9+sLiq02/2vyIKZJCiOo4SzdHXo+Yxy2A+0tHw3qcW3FA7S+sr0u20ggb4h29Ki0NpCLOMKmJMAGxFnO/RHcP1S/G7Y+Sd1zca48G/Uvgu5LZPhJkpLjUXOXJ3aZtQuAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705938735; c=relaxed/simple;
	bh=CsmNHVKTcv9k1CSzQhpFbPonZhTwLmv0N/4giClHW2g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=C0peafWd1rOo1nME+Muv7Pdp5tQhNo06oEjTN6o4kasRCR5b68EkYuI8FCs+jFEne1mB/qflYjmbENbR065848HqP4LWlfGEFinsURVMwjnXYCeqmBXD+f77D+EQu3t542oTuQyMFDvftS36EnpnQzHMRGWlPe/e3E89REI0Q04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lr7zLM9F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705938733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=781tGw2sMtzTYpaon8uTa7Bu933Iv40150lcLLMnhOk=;
	b=Lr7zLM9F7g/V6+BEB0sZEqaRrfPgfRH6UYhZUDsO//wdRFCzST99l/M5uG6/ZKuh/rgWyh
	oI46BgRtwDCdn5358mSW2gJBWx3cXbVRINpHtDYFt7S1BZNamcvkXiyvfJnXpE2srUWyGY
	3lMI9HL63z55XfgL3bsFH9QeiDfu8I0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-xc_GS8sQOFeHx8Yvdu85-A-1; Mon, 22 Jan 2024 10:52:08 -0500
X-MC-Unique: xc_GS8sQOFeHx8Yvdu85-A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C12885A58A;
	Mon, 22 Jan 2024 15:52:08 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.26])
	by smtp.corp.redhat.com (Postfix) with SMTP id 3A0301C060AF;
	Mon, 22 Jan 2024 15:52:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 22 Jan 2024 16:50:54 +0100 (CET)
Date: Mon, 22 Jan 2024 16:50:53 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Dylan Hatch <dylanbhatch@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] getrusage: use sig->stats_lock rather than
 lock_task_sighand()
Message-ID: <20240122155053.GA26214@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122155023.GA26169@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

lock_task_sighand() can trigger a hard lockup. If NR_CPUS threads call
getrusage() at the same time and the process has NR_THREADS, spin_lock_irq
will spin with irqs disabled O(NR_CPUS * NR_THREADS) time.

Change getrusage() to use sig->stats_lock, it was specifically designed
for this type of use. This way it runs lockless in the likely case.

TODO:
	- Change do_task_stat() to use sig->stats_lock too, then we can
	  remove spin_lock_irq(siglock) in wait_task_zombie().

	- Turn sig->stats_lock into seqcount_rwlock_t, this way the
	  readers in the slow mode won't exclude each other. See
	  https://lore.kernel.org/all/20230913154907.GA26210@redhat.com/

	- stats_lock has to disable irqs because ->siglock can be taken
	  in irq context, it would be very nice to change __exit_signal()
	  to avoid the siglock->stats_lock dependency.

Reported-and-tested-by: Dylan Hatch <dylanbhatch@google.com>
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



Return-Path: <linux-kernel+bounces-35564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64705839353
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D670286F0B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A838665BB3;
	Tue, 23 Jan 2024 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqIHx5e/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C56C657C8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024119; cv=none; b=a0XLO9FxGuY6jJDIWOtN8ZEed1yI/B4/pfUWNwLaKPfb0OlDzYCHcOTXlwCfHlS/pIUpwVkI1raTR4tAh6g0xz+4+N4k52QM8WAUrNkR0Hcmu4k6nDrTKLO4+FCzqKXYEOEN8KnlqtoE+j6idj/cZVItoVq5MBbS/6ynOIm6TTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024119; c=relaxed/simple;
	bh=c9BEPFAZqOS2AQyRU1oFe2mQJ0crzzdirNWDHZqIiqg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=c5fa3i1gzktNT0qFiXeIVWMU3ZQGq1HSiZZscJS4h/7GbnIORpcQKHw7pbsYB/kmPYKQKMYG3EU44j+A75OVf0FXPMGmqr13i93EHRu3h7tEUOjWnhKiPw5L/ZWmD3J7QN1isd2plyBsybbJR1e7+z0zQ35PReTDEi3UlrwYzwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eqIHx5e/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706024116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=zQhQsMWn8/u+MgzIhKjJc4Zf9WV6/GJZobpLAxElXGE=;
	b=eqIHx5e/MruKNzHNfw2DwDPD7lJM1cWjx+D7DTUHBkbf+/e4RpNZuqNnZzOWzDOH8g4VaM
	tJj1c7+oW5KAHpduSrjwFrDzMHI8LOmzvU2ZSPeq71QDwtuKn4vSvtfR+9839GS38kKQAL
	UOrCwFrRlGKtePv6OWghTtzc+8WCngo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-DVWFydYbPvavkDDHE0upJw-1; Tue, 23 Jan 2024 10:35:13 -0500
X-MC-Unique: DVWFydYbPvavkDDHE0upJw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 782F310B02B1;
	Tue, 23 Jan 2024 15:35:12 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.197])
	by smtp.corp.redhat.com (Postfix) with SMTP id 3D69B200E1BF;
	Tue, 23 Jan 2024 15:35:11 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 23 Jan 2024 16:33:59 +0100 (CET)
Date: Tue, 23 Jan 2024 16:33:57 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Dylan Hatch <dylanbhatch@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] fs/proc: do_task_stat: use sig->stats_lock to gather the
 threads/children stats
Message-ID: <20240123153357.GA21857@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123153313.GA21832@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

lock_task_sighand() can trigger a hard lockup. If NR_CPUS threads call
do_task_stat() at the same time and the process has NR_THREADS, it will
spin with irqs disabled O(NR_CPUS * NR_THREADS) time.

Change do_task_stat() to use sig->stats_lock to gather the statistics
outside of ->siglock protected section, in the likely case this code
will run lockless.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 fs/proc/array.c | 58 +++++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 45ba91863808..34a47fb0c57f 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -477,13 +477,13 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	int permitted;
 	struct mm_struct *mm;
 	unsigned long long start_time;
-	unsigned long cmin_flt = 0, cmaj_flt = 0;
-	unsigned long  min_flt = 0,  maj_flt = 0;
-	u64 cutime, cstime, utime, stime;
-	u64 cgtime, gtime;
+	unsigned long cmin_flt, cmaj_flt, min_flt, maj_flt;
+	u64 cutime, cstime, cgtime, utime, stime, gtime;
 	unsigned long rsslim = 0;
 	unsigned long flags;
 	int exit_code = task->exit_code;
+	struct signal_struct *sig = task->signal;
+	unsigned int seq = 1;
 
 	state = *get_task_state(task);
 	vsize = eip = esp = 0;
@@ -511,12 +511,8 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 
 	sigemptyset(&sigign);
 	sigemptyset(&sigcatch);
-	cutime = cstime = 0;
-	cgtime = gtime = 0;
 
 	if (lock_task_sighand(task, &flags)) {
-		struct signal_struct *sig = task->signal;
-
 		if (sig->tty) {
 			struct pid *pgrp = tty_get_pgrp(sig->tty);
 			tty_pgrp = pid_nr_ns(pgrp, ns);
@@ -527,27 +523,9 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 		num_threads = get_nr_threads(task);
 		collect_sigign_sigcatch(task, &sigign, &sigcatch);
 
-		cmin_flt = sig->cmin_flt;
-		cmaj_flt = sig->cmaj_flt;
-		cutime = sig->cutime;
-		cstime = sig->cstime;
-		cgtime = sig->cgtime;
 		rsslim = READ_ONCE(sig->rlim[RLIMIT_RSS].rlim_cur);
 
-		/* add up live thread stats at the group level */
 		if (whole) {
-			struct task_struct *t;
-
-			__for_each_thread(sig, t) {
-				min_flt += t->min_flt;
-				maj_flt += t->maj_flt;
-				gtime += task_gtime(t);
-			}
-
-			min_flt += sig->min_flt;
-			maj_flt += sig->maj_flt;
-			gtime += sig->gtime;
-
 			if (sig->flags & (SIGNAL_GROUP_EXIT | SIGNAL_STOP_STOPPED))
 				exit_code = sig->group_exit_code;
 		}
@@ -562,6 +540,34 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	if (permitted && (!whole || num_threads < 2))
 		wchan = !task_is_running(task);
 
+	do {
+		seq++; /* 2 on the 1st/lockless path, otherwise odd */
+		flags = read_seqbegin_or_lock_irqsave(&sig->stats_lock, &seq);
+
+		cmin_flt = sig->cmin_flt;
+		cmaj_flt = sig->cmaj_flt;
+		cutime = sig->cutime;
+		cstime = sig->cstime;
+		cgtime = sig->cgtime;
+
+		if (whole) {
+			struct task_struct *t;
+
+			min_flt = sig->min_flt;
+			maj_flt = sig->maj_flt;
+			gtime = sig->gtime;
+
+			rcu_read_lock();
+			__for_each_thread(sig, t) {
+				min_flt += t->min_flt;
+				maj_flt += t->maj_flt;
+				gtime += task_gtime(t);
+			}
+			rcu_read_unlock();
+		}
+	} while (need_seqretry(&sig->stats_lock, seq));
+	done_seqretry_irqrestore(&sig->stats_lock, seq, flags);
+
 	if (whole) {
 		thread_group_cputime_adjusted(task, &utime, &stime);
 	} else {
-- 
2.25.1.362.g51ebf55



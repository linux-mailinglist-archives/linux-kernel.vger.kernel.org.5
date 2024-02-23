Return-Path: <linux-kernel+bounces-78178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B00D8860FD6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34CD8B259D1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28ED363121;
	Fri, 23 Feb 2024 10:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UqIo4Sx9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE92171B8
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 10:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708685516; cv=none; b=GIbwmq0yJQUOC/Ihkv1TO4HVOVIiK3b58oz1DBSsIcmcLWP7rSozIuAhwXJWQTA/PmPS3C9Ci4Z5qGEgPQivcdruSRoBMfQ0p+1HXvnM4ur2Gkw4TCqiEPGFFn82Fg2XRJ4IJGMezSZtSXVZnxiGonQjkRJAehlPG2awG74hpcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708685516; c=relaxed/simple;
	bh=oof7A++FydP9At/YUbuwr3ObhSdy49ePGn9HOQeG5cY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UWKKNmM76Tu9H0QbWEEWRDxrO2rD3+JEQNy5L6Qx//2Tk8/txFPE9Ui9gHp8w5YTeXpWNtkyy2WAOqj+DLY4piro3PTVEW7vIwrp8kk2LAlH0IqCSR2397sW+TbV/ZCiidH6tOM572zUzANXmqvStVBf6KpA27yspmhZaecGyq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UqIo4Sx9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708685513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=pSmnO00mIYNIEXoWmL94MfKqzwMDUvzRTkxqzjX2bi4=;
	b=UqIo4Sx9C8tdIrKUWemM1/jcpTJ3IH1NiOFRtvt8+Ab2pdOvskQlu8HNijSYA5pGMinqwm
	EoTI0jtGV/6GC4Yi7Xk5oZLZKNXTZSsInGWLHckqPugc1sc74+gHBv5jZih8RpOZuiXF+a
	5W5YivbWag6QYFHEwLY31D5jCGjk5os=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-eQOhhm18PC-OWCo3wMLQJQ-1; Fri, 23 Feb 2024 05:51:48 -0500
X-MC-Unique: eQOhhm18PC-OWCo3wMLQJQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9FDA6108BF3D;
	Fri, 23 Feb 2024 10:51:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.151])
	by smtp.corp.redhat.com (Postfix) with SMTP id 0C08E2015DB2;
	Fri, 23 Feb 2024 10:51:45 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 23 Feb 2024 11:50:29 +0100 (CET)
Date: Fri, 23 Feb 2024 11:50:25 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Christian Brauner <brauner@kernel.org>,
	Wen Yang <wenyang.linux@foxmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] get_signal: simplify/cleanup the the usage of ksig->info
Message-ID: <20240223105025.GA4542@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

get_signal() uses signr or ksig->info.si_signo in a chaotic way, this
looks confusing. Change it to always use signr.

This allows us to simplify the SIGNAL_GROUP_EXIT/group_exec_task branch,
it no longer needs to touch ksig at all.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/signal.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index c9c57d053ce4..690982e6595e 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2727,12 +2727,15 @@ bool get_signal(struct ksignal *ksig)
 		/* Has this task already been marked for death? */
 		if ((signal->flags & SIGNAL_GROUP_EXIT) ||
 		     signal->group_exec_task) {
-			clear_siginfo(&ksig->info);
-			ksig->info.si_signo = signr = SIGKILL;
+			signr = SIGKILL;
 			sigdelset(&current->pending.signal, SIGKILL);
 			trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,
-				&sighand->action[SIGKILL - 1]);
+					     &sighand->action[SIGKILL - 1]);
 			recalc_sigpending();
+			/*
+			 * implies do_group_exit(), no need to initialize
+			 * ksig->info
+			 */
 			goto fatal;
 		}
 
@@ -2842,7 +2845,7 @@ bool get_signal(struct ksignal *ksig)
 				spin_lock_irq(&sighand->siglock);
 			}
 
-			if (likely(do_signal_stop(ksig->info.si_signo))) {
+			if (likely(do_signal_stop(signr))) {
 				/* It released the siglock.  */
 				goto relock;
 			}
@@ -2866,7 +2869,7 @@ bool get_signal(struct ksignal *ksig)
 
 		if (sig_kernel_coredump(signr)) {
 			if (print_fatal_signals)
-				print_fatal_signal(ksig->info.si_signo);
+				print_fatal_signal(signr);
 			proc_coredump_connector(current);
 			/*
 			 * If it was able to dump core, this kills all
@@ -2890,7 +2893,7 @@ bool get_signal(struct ksignal *ksig)
 		/*
 		 * Death signals, no core dump.
 		 */
-		do_group_exit(ksig->info.si_signo);
+		do_group_exit(signr);
 		/* NOTREACHED */
 	}
 	spin_unlock_irq(&sighand->siglock);
-- 
2.25.1.362.g51ebf55




Return-Path: <linux-kernel+bounces-33768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 342B6836E57
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48A851C274BB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D595F56E;
	Mon, 22 Jan 2024 17:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dq0NSfYF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F8E40C13
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705943874; cv=none; b=b6Y9rD/eDV8E9QNXAkClE2AXCQxrh9X+q7kqmUrsVm8oavHrYRyHdr5koeiwWG03ESeYi7P901K219O8lOEhSC7buYu8TI4z0ITCQOKUU708DQ1wW2BRNl2nlU5OCRkaZ8+4UTHzv7dcySagA/csAEY/IXxx9K/W+CqqhkD7S10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705943874; c=relaxed/simple;
	bh=cmr8yF5b3znopsdS7F3eRda3NyWqbTYPL2Cz5yi3QOo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SlxYE2Aiuxuucai9edTMeLybG5j/XvEm1W0IjBDXuRRRngxvmhP/0mntCDcPe4d3+EM5xX5Lh91aUD68C15Cr31yvZ6N2fRaDYNhj8fkrt0FO7dszsGXDx8tuL5hv7/1XBYkkYqs+11Lrv5tfheG0ARXtHrbAu0b4Ku4Hr56l1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dq0NSfYF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705943871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=dDzoH2ydbaG6uArVRXPWiTruxakYgLL2hFbtSHqrYpg=;
	b=dq0NSfYF5nWNz1XMCWOEIk7JE+5gBholGvbHJ/WHSp2lad5AGm6WEQwwKy8oZwB5IMPw0R
	vS6MgEleAIKqMYIT6UeSFHEW1TUXVSgWZrN09tAKXsqMLuVH4ArbW3pwvSI+Gb6ri6IY0J
	6CgI6DF/LvbKjebC91agQXSZMViZcKk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-e-6ynDVzP3GbsK1ChLXfUQ-1; Mon, 22 Jan 2024 12:17:47 -0500
X-MC-Unique: e-6ynDVzP3GbsK1ChLXfUQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 39380845E37;
	Mon, 22 Jan 2024 17:17:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.26])
	by smtp.corp.redhat.com (Postfix) with SMTP id 33E3840C1430;
	Mon, 22 Jan 2024 17:17:45 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 22 Jan 2024 18:16:33 +0100 (CET)
Date: Mon, 22 Jan 2024 18:16:31 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ptrace_attach: shift send(SIGSTOP) into ptrace_set_stopped()
Message-ID: <20240122171631.GA29844@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Turn send_sig_info(SIGSTOP) into send_signal_locked(SIGSTOP) and move
it from ptrace_attach() to ptrace_set_stopped().

This looks more logical and avoids lock(siglock) right after unlock().

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/ptrace.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 2fabd497d659..d5f89f9ef29f 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -375,10 +375,13 @@ static int check_ptrace_options(unsigned long data)
 	return 0;
 }
 
-static inline void ptrace_set_stopped(struct task_struct *task)
+static inline void ptrace_set_stopped(struct task_struct *task, bool seize)
 {
 	guard(spinlock)(&task->sighand->siglock);
 
+	/* SEIZE doesn't trap tracee on attach */
+	if (!seize)
+		send_signal_locked(SIGSTOP, SEND_SIG_PRIV, task, PIDTYPE_PID);
 	/*
 	 * If the task is already STOPPED, set JOBCTL_TRAP_STOP and
 	 * TRAPPING, and kick it so that it transits to TRACED.  TRAPPING
@@ -457,14 +460,8 @@ static int ptrace_attach(struct task_struct *task, long request,
 				return -EPERM;
 
 			task->ptrace = flags;
-
 			ptrace_link(task, current);
-
-			/* SEIZE doesn't trap tracee on attach */
-			if (!seize)
-				send_sig_info(SIGSTOP, SEND_SIG_PRIV, task);
-
-			ptrace_set_stopped(task);
+			ptrace_set_stopped(task, seize);
 		}
 	}
 
-- 
2.25.1.362.g51ebf55




Return-Path: <linux-kernel+bounces-46494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B30C4844089
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52D8E1F2C8E4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0017D403;
	Wed, 31 Jan 2024 13:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QAr2T3qJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963ED7BB03
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 13:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706707625; cv=none; b=mASPmnW8Iu4rl3DnjhgI7XR/jj29oXL3EP6TgoonuZ80rNAkZeb5N4dhGWw7XMZ4RtofypV8eqjq7YREOPFciOBJoY5rj8g/yBXADGYzdmzLEv/UTBTHWVMthRnTdpj1FhlHUGIyPLzmDk60qX6ZSZkvZ4kN6oscImws3qBS5Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706707625; c=relaxed/simple;
	bh=x2alkTFdX9GtAAjAdf9d5pBfRjBGsbqEAc0JOC49oYY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F4HH/clEBRYJrUkOQXPWQytGFPkmXGmK7sG5NsaQ6ccd/1M2wzbyZJRXPk1gd/P5gs4lj6jOOB8COoYb6A1PwkX5rB1SUEiVQg87urcLUNMTZbkiaegS4VPxdk3VoGzhz94TPVAsLMU4PDdTLhtZVAaQbMRRk5vErmrx1oaUqtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QAr2T3qJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706707622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=AEoHzKgqw9sGTXanl1cSpEXOm2keGIi49ypqIIavTQY=;
	b=QAr2T3qJ4T+rqV6FPAgKZXl+sKCdxgVaDuq730gcnGxwv1rCTuF6gPZTlzrj09wTRIdqmz
	qsOZwsDLZMfUEDsu1UEO74i8a35a2snAd5S3zDLE8V/DnWTduCXeNsQSrzkRyPjwMrO7C7
	lcAz21UGL1SSCPfoAm995Hke8j+OpCw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-ryf6m05BOHuqu6haSIRe3w-1; Wed, 31 Jan 2024 08:26:58 -0500
X-MC-Unique: ryf6m05BOHuqu6haSIRe3w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5EFE0101A526;
	Wed, 31 Jan 2024 13:26:58 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.249])
	by smtp.corp.redhat.com (Postfix) with SMTP id 0D16140C122E;
	Wed, 31 Jan 2024 13:26:56 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 31 Jan 2024 14:25:43 +0100 (CET)
Date: Wed, 31 Jan 2024 14:25:41 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/1] pidfd: implement PIDFD_THREAD flag for pidfd_open()
Message-ID: <20240131132541.GA23632@redhat.com>
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

Please see the interdiff below.

Also, I updated the changelog to document that the behaviour of
pidfd_poll(PIDFD_THREAD, pid-of-group-leader) is not well defined
if a sub-thread execs.

Do you agree with this semantics?

Oleg.
---

diff --git a/fs/exec.c b/fs/exec.c
index 73e4045df271..0fd7e668c477 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1143,7 +1143,11 @@ static int de_thread(struct task_struct *tsk)
 
 		BUG_ON(leader->exit_state != EXIT_ZOMBIE);
 		leader->exit_state = EXIT_DEAD;
-
+		/*
+		 * leader and tsk exhanged their pids, the old pid dies,
+		 * wake up the PIDFD_THREAD waiters.
+		 */
+		do_notify_pidfd(leader);
 		/*
 		 * We are going to release_task()->ptrace_unlink() silently,
 		 * the tracer can sleep in do_wait(). EXIT_DEAD guarantees
diff --git a/include/linux/pid.h b/include/linux/pid.h
index e6a041cb8bac..8124d57752b9 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -70,10 +70,11 @@ extern const struct file_operations pidfd_fops;
 
 struct file;
 
-extern struct pid *pidfd_pid(const struct file *file);
+struct pid *pidfd_pid(const struct file *file);
 struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags);
 struct task_struct *pidfd_get_task(int pidfd, unsigned int *flags);
 int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret);
+void do_notify_pidfd(struct task_struct *task);
 
 static inline struct pid *get_pid(struct pid *pid)
 {
diff --git a/kernel/signal.c b/kernel/signal.c
index 5f48d2c4b409..9b40109f0c56 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2019,7 +2019,7 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
 	return ret;
 }
 
-static void do_notify_pidfd(struct task_struct *task)
+void do_notify_pidfd(struct task_struct *task)
 {
 	struct pid *pid;
 



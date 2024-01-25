Return-Path: <linux-kernel+bounces-38882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A85A183C7BD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61A6B1F2747F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C04129A6F;
	Thu, 25 Jan 2024 16:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jb7pXFVP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1451292F6
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706199537; cv=none; b=V2Sr1HxUmfsa6KcfA6kN2yjsgc7ghbBo+vkMiEhfC+PT8u0sVlbcLhuaLsWOxTjcq3vJhXtpnK8Rqf82+SreGJKQ9ZFyOWplIfEM3vUTIxttycgJT/IskRED1wmE86wVi/5CGysQf2FRAzdfd+Q7yOPEurEWLcBqWPVxXQk/aHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706199537; c=relaxed/simple;
	bh=ZFIAD3SghRMr8naQG+00l/0n4qp68W6rM0zHBdsQstM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=juceEaM4wC9R0e/KRw7Ket1sqlRv/lof31vk5fXgR849KXNEKaEF3zHOOnofi5IJxgHBzIB6kdph4IAFGBbHS2iKAlgoTPAg+pjbtjn5dLZks92YWIAPUY/dO/hqW/1cCPS1ci8zn2A69QA/Xo9UVXONK5AeBG17BGGsYDcnf7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jb7pXFVP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706199534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=OD7tTZxtOA5L7DY6QZCt4p2wPvXLqRQRKZ25ORgLsbA=;
	b=Jb7pXFVPJ0I1e9idHv+RPXwedutdiBXeD/1CniyxMD8n9G7n9QtCltFeMN/nnUvKLEZ9GA
	hTRukgj/9mqwCx+euKBecfGajPcBedbDqKiNxYxlI4s1BTSb75fgpjGY4Uqg+EnoituqEy
	g+IkvKpEmg09FaDG+B6Cl/INQa33OEc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-V9s2GPlzMP6ScWDQD43MYA-1; Thu, 25 Jan 2024 11:18:51 -0500
X-MC-Unique: V9s2GPlzMP6ScWDQD43MYA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B4C9C83B86C;
	Thu, 25 Jan 2024 16:18:50 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.14])
	by smtp.corp.redhat.com (Postfix) with SMTP id 21126200A7B4;
	Thu, 25 Jan 2024 16:18:48 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 25 Jan 2024 17:17:37 +0100 (CET)
Date: Thu, 25 Jan 2024 17:17:34 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tandersen@netflix.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-kernel@vger.kernel.org
Subject: [PATCH] pidfd: cleanup the usage of __pidfd_prepare's flags
Message-ID: <20240125161734.GA778@redhat.com>
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

- make pidfd_create() static.

- Don't pass O_RDWR | O_CLOEXEC to __pidfd_prepare() in copy_process(),
  __pidfd_prepare() adds these flags unconditionally.

- Kill the flags check in __pidfd_prepare(). sys_pidfd_open() checks the
  flags itself, all other users of pidfd_prepare() pass flags = 0.

  If we need a sanity check for those other in kernel users then
  WARN_ON_ONCE(flags & ~PIDFD_NONBLOCK) makes more sense.

- Don't pass O_RDWR to get_unused_fd_flags(), it ignores everything except
  O_CLOEXEC.

- Don't pass O_CLOEXEC to anon_inode_getfile(), it ignores everything except
  O_ACCMODE | O_NONBLOCK.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 include/linux/pid.h | 1 -
 kernel/fork.c       | 9 +++------
 kernel/pid.c        | 2 +-
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index 395cacce1179..e6a041cb8bac 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -73,7 +73,6 @@ struct file;
 extern struct pid *pidfd_pid(const struct file *file);
 struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags);
 struct task_struct *pidfd_get_task(int pidfd, unsigned int *flags);
-int pidfd_create(struct pid *pid, unsigned int flags);
 int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret);
 
 static inline struct pid *get_pid(struct pid *pid)
diff --git a/kernel/fork.c b/kernel/fork.c
index c981fa6171c1..347641398f9d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2130,15 +2130,12 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
 	int pidfd;
 	struct file *pidfd_file;
 
-	if (flags & ~(O_NONBLOCK | O_RDWR | O_CLOEXEC))
-		return -EINVAL;
-
-	pidfd = get_unused_fd_flags(O_RDWR | O_CLOEXEC);
+	pidfd = get_unused_fd_flags(O_CLOEXEC);
 	if (pidfd < 0)
 		return pidfd;
 
 	pidfd_file = anon_inode_getfile("[pidfd]", &pidfd_fops, pid,
-					flags | O_RDWR | O_CLOEXEC);
+					flags | O_RDWR);
 	if (IS_ERR(pidfd_file)) {
 		put_unused_fd(pidfd);
 		return PTR_ERR(pidfd_file);
@@ -2524,7 +2521,7 @@ __latent_entropy struct task_struct *copy_process(
 	 */
 	if (clone_flags & CLONE_PIDFD) {
 		/* Note that no task has been attached to @pid yet. */
-		retval = __pidfd_prepare(pid, O_RDWR | O_CLOEXEC, &pidfile);
+		retval = __pidfd_prepare(pid, 0, &pidfile);
 		if (retval < 0)
 			goto bad_fork_free_pid;
 		pidfd = retval;
diff --git a/kernel/pid.c b/kernel/pid.c
index b52b10865454..c7a3e359f8f5 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -595,7 +595,7 @@ struct task_struct *pidfd_get_task(int pidfd, unsigned int *flags)
  * Return: On success, a cloexec pidfd is returned.
  *         On error, a negative errno number will be returned.
  */
-int pidfd_create(struct pid *pid, unsigned int flags)
+static int pidfd_create(struct pid *pid, unsigned int flags)
 {
 	int pidfd;
 	struct file *pidfd_file;
-- 
2.25.1.362.g51ebf55




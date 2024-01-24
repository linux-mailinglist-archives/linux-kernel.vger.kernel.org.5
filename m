Return-Path: <linux-kernel+bounces-37176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA5583AC4F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CB841C2097F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8C97A705;
	Wed, 24 Jan 2024 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPAG7ZV6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BA71350CE;
	Wed, 24 Jan 2024 14:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106692; cv=none; b=DGLvO00IOc5z/FF3520NcqcOfKJ40wssEtwiqIR702eRI3DBq8F/zINeRQKfIF7EgeZxTNRwy2sqfZGcRIp3Lcrokki4TGA3WqmYq5muYSWlK9UyuV/SctkmWlxSGG0bv3QBLs48FNqc7FFkKZVCjwalhQxX7ZdVvty7eN21oag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106692; c=relaxed/simple;
	bh=QR5cb3O4qRcYhx5UaU4c5YGWaHFckDJiaZTC1iUTjKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TnR3nUH0IIKoPsZ/fMVoF3xCRnzIhRIsLq5aZQZp4pXvSH5RkndxiCEWx1jKlrsseE5EWFTuJ2AQpMl98gwX8d6JC8WrLOppSQ0zIL3WSSRU5WmK/IEyVMhGDGFSsRs7ngN8wF0MZQTPpEeyF+4D0FQcvV96xH3qp6zhn48s1+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uPAG7ZV6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A6AC43390;
	Wed, 24 Jan 2024 14:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106692;
	bh=QR5cb3O4qRcYhx5UaU4c5YGWaHFckDJiaZTC1iUTjKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uPAG7ZV6IIocWVzaG4PvaK+jwoDT8lR6lCoj476DZiv2PENJow/QnM5N5BAXKc8fS
	 njnSInW0Ee4cadkq7fZE+K3msSVAGjLIymLVEDCBTBaMRlrd98MDv6NqMzTXmsNWTO
	 VPOEAyaIPl7ky7cYEP/Syga5G1kU3+6kWGe2O6ww6zhV3F7uqzY0cFjMLjqQbsUF4w
	 hxyGHzc385ZiMS2VMvZzsJ47GYNK5R2X3FpXtOU7g/RF4dL0h5mHnPutRHzp7bkdux
	 U4+4cZtiwtPr1wlsbuHFzK2GMMjmVvwzxYIdj5zOAsfdiP6iKgfO8qGwQ4W9K5ocTS
	 v7oyJiXLgtk9w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Peter Lafreniere <peter@n8pjl.ca>,
	Richard Weinberger <richard@nod.at>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	benjamin@sipsolutions.net,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 2/6] um: Fix naming clash between UML and scheduler
Date: Wed, 24 Jan 2024 09:31:11 -0500
Message-ID: <20240124143124.1284462-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124143124.1284462-1-sashal@kernel.org>
References: <20240124143124.1284462-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
Content-Transfer-Encoding: 8bit

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

[ Upstream commit 541d4e4d435c8b9bfd29f70a1da4a2db97794e0a ]

__cant_sleep was already used and exported by the scheduler.
The name had to be changed to a UML specific one.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Reviewed-by: Peter Lafreniere <peter@n8pjl.ca>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/include/shared/kern_util.h | 2 +-
 arch/um/kernel/process.c           | 2 +-
 arch/um/os-Linux/helper.c          | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
index ccafb62e8cce..42dc0e47d3ad 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -49,7 +49,7 @@ extern void do_uml_exitcalls(void);
  * Are we disallowed to sleep? Used to choose between GFP_KERNEL and
  * GFP_ATOMIC.
  */
-extern int __cant_sleep(void);
+extern int __uml_cant_sleep(void);
 extern int get_current_pid(void);
 extern int copy_from_user_proc(void *to, void *from, int size);
 extern int cpu(void);
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index d71dd7725bef..f185d19fd9b6 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -258,7 +258,7 @@ void arch_cpu_idle(void)
 	local_irq_enable();
 }
 
-int __cant_sleep(void) {
+int __uml_cant_sleep(void) {
 	return in_atomic() || irqs_disabled() || in_interrupt();
 	/* Is in_interrupt() really needed? */
 }
diff --git a/arch/um/os-Linux/helper.c b/arch/um/os-Linux/helper.c
index 9fa6e4187d4f..57a27555092f 100644
--- a/arch/um/os-Linux/helper.c
+++ b/arch/um/os-Linux/helper.c
@@ -45,7 +45,7 @@ int run_helper(void (*pre_exec)(void *), void *pre_data, char **argv)
 	unsigned long stack, sp;
 	int pid, fds[2], ret, n;
 
-	stack = alloc_stack(0, __cant_sleep());
+	stack = alloc_stack(0, __uml_cant_sleep());
 	if (stack == 0)
 		return -ENOMEM;
 
@@ -69,7 +69,7 @@ int run_helper(void (*pre_exec)(void *), void *pre_data, char **argv)
 	data.pre_data = pre_data;
 	data.argv = argv;
 	data.fd = fds[1];
-	data.buf = __cant_sleep() ? uml_kmalloc(PATH_MAX, UM_GFP_ATOMIC) :
+	data.buf = __uml_cant_sleep() ? uml_kmalloc(PATH_MAX, UM_GFP_ATOMIC) :
 					uml_kmalloc(PATH_MAX, UM_GFP_KERNEL);
 	pid = clone(helper_child, (void *) sp, CLONE_VM, &data);
 	if (pid < 0) {
@@ -116,7 +116,7 @@ int run_helper_thread(int (*proc)(void *), void *arg, unsigned int flags,
 	unsigned long stack, sp;
 	int pid, status, err;
 
-	stack = alloc_stack(0, __cant_sleep());
+	stack = alloc_stack(0, __uml_cant_sleep());
 	if (stack == 0)
 		return -ENOMEM;
 
-- 
2.43.0



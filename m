Return-Path: <linux-kernel+bounces-37182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD9E83AC5D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D3371F21EE7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3414135A6B;
	Wed, 24 Jan 2024 14:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJbZB/n/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152777A728;
	Wed, 24 Jan 2024 14:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106718; cv=none; b=NXOWnLVtNyCK4rfVMfo65vEJRMLigsPKe76+n0st2FUJVNIwhkeVidXRkibnk/r5q29jWLrRekpbZ0kf+OwPqvSrizrqPr1FwoUZMMmwFAEfYGyp3D2799HAt5Vd5pmTiI6seZdrj8Cfwjbinob00QDB+/4MtxGqtU3uAWvDS2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106718; c=relaxed/simple;
	bh=BBf0Tuwx4NrIr3rRhiQ+CrI7EiIN8xrZgPI5ENtuCvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SW2y+w1thvVVBpizmYky7YIIue1MeGuYZlBr6zHdQCgnEUt6TFowOFuXJAJcvoPyNXTk+ahRyj1B8/pXdNnB8iXGweGPf0XWDVHbbHhYim3V88y1nELd5zvzQIuk0R0t6SQ8oWn4u3t/os/cBcYn2C9PKbuoENrj2xYRF3jWtQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJbZB/n/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9D8C433F1;
	Wed, 24 Jan 2024 14:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106717;
	bh=BBf0Tuwx4NrIr3rRhiQ+CrI7EiIN8xrZgPI5ENtuCvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YJbZB/n/8u1AQ1xIsAk6yG1yU9pSrdwsLDn8MGfj9YpNqKRuQR1HwLn4XfggjS/UI
	 2D0AFNmlsc4BWJ6hbnCx6qjZppvBLXJm2ZbJ7tNJ6p7zjWTk1ljA4Q323QZX/jm1k/
	 HMUIAS/RA0isjC711s3q79fQU4jLf8YmDu/ZCRx1kozc+E1OCdbv0wg8pvpCUWUvK0
	 IMQPOLiLUa5TEGFBcnTi46rFG2qGDEFERz4zHP3n8w/r3dgsMqJoQoFCj1uhVZvl5f
	 YVurDL05B06YEnW2kNe0cbupYmv88E50v0mkHftmpLcNPR9/0EWpMe7OQabBT3zeVz
	 ixZdzcQOURjAA==
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
Subject: [PATCH AUTOSEL 4.19 2/5] um: Fix naming clash between UML and scheduler
Date: Wed, 24 Jan 2024 09:31:37 -0500
Message-ID: <20240124143149.1284622-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124143149.1284622-1-sashal@kernel.org>
References: <20240124143149.1284622-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.305
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
index 35ab97e4bb9b..f2da8347d5f5 100644
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
index 691b83b10649..c9d09d04d19d 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -210,7 +210,7 @@ void arch_cpu_idle(void)
 	local_irq_enable();
 }
 
-int __cant_sleep(void) {
+int __uml_cant_sleep(void) {
 	return in_atomic() || irqs_disabled() || in_interrupt();
 	/* Is in_interrupt() really needed? */
 }
diff --git a/arch/um/os-Linux/helper.c b/arch/um/os-Linux/helper.c
index 3f02d4232812..53d450e4a53a 100644
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



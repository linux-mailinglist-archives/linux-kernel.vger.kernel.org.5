Return-Path: <linux-kernel+bounces-37119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C11683ABC2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACE6A1F2A5A7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5EA7E578;
	Wed, 24 Jan 2024 14:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmsFxf18"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F008E7CF27;
	Wed, 24 Jan 2024 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106512; cv=none; b=OO7KaWomlWUcdfrwiQkL+rvsT+AiInh1bdXuU9v7JHqAq49UE2OMUkgoZSFk7U/17YM+N1Wv929ls3vgzst5UYAheVc1/cZ9RwWSsV6xRUxDvhfcE4fYeDfyTZomhbz7kBln3D0j/9G1A6+St7l3cNLflF0xb3nJ3jzyK9ynTrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106512; c=relaxed/simple;
	bh=etpqgTLCOUAl7afUyBW+a+/hEzVb1lCoYgukDD8Etvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A864R8vAIQHtzhzgQ/w5eoTodBhYS++Bwl/WJLmQbGD+VL6zxbf3/52BbFNX0qSk6ABOm8sbUmpVBFlUIK+WPqjX+XpCnV8saIpNSh/uPL6Pi8n2OzKPkoSkG+slq6PPhu2es4eC6h+Ds0AXPg+SPklF6m7Id4lGwHNcWXNjiXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmsFxf18; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47BAC433F1;
	Wed, 24 Jan 2024 14:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106511;
	bh=etpqgTLCOUAl7afUyBW+a+/hEzVb1lCoYgukDD8Etvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gmsFxf185z40p/K4xjRF3mgJUFibEE9FYW+xD30g5kWR07zbnmlC5HMmwsnVktmLA
	 H5YnUj1gx483jghKz6x9LDN9SsSJAzzsvkPO9b0/9ZUO4lr7j3h/3qFBV8WUEVa58P
	 VvuNKWBFzOAao1Ix5r/WADZAfaPCMrBKjG5mFLa4MRtdLvz5ByEcBAX6DW0qZVHGZs
	 YD5cgLAJWZbdgjszM3Eb0IHRVI2I28SwX13XVA3UewFo27oQFbbu2YQxus2Xj8AR4k
	 L4XxofvUHXUTigSLOP3z/hzzs87oUTXsCGAIcNUkTBmybmaKhZab1hhpj+oKtVaCpF
	 ftI67SONNud6w==
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
Subject: [PATCH AUTOSEL 6.7 03/13] um: Fix naming clash between UML and scheduler
Date: Wed, 24 Jan 2024 09:27:56 -0500
Message-ID: <20240124142820.1283206-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124142820.1283206-1-sashal@kernel.org>
References: <20240124142820.1283206-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
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
index d8b8b4f07e42..444bae755b16 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -50,7 +50,7 @@ extern void do_uml_exitcalls(void);
  * Are we disallowed to sleep? Used to choose between GFP_KERNEL and
  * GFP_ATOMIC.
  */
-extern int __cant_sleep(void);
+extern int __uml_cant_sleep(void);
 extern int get_current_pid(void);
 extern int copy_from_user_proc(void *to, void *from, int size);
 extern char *uml_strdup(const char *string);
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 106b7da2f8d6..6daffb9d8a8d 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -220,7 +220,7 @@ void arch_cpu_idle(void)
 	um_idle_sleep();
 }
 
-int __cant_sleep(void) {
+int __uml_cant_sleep(void) {
 	return in_atomic() || irqs_disabled() || in_interrupt();
 	/* Is in_interrupt() really needed? */
 }
diff --git a/arch/um/os-Linux/helper.c b/arch/um/os-Linux/helper.c
index b459745f52e2..3cb8ac63be6e 100644
--- a/arch/um/os-Linux/helper.c
+++ b/arch/um/os-Linux/helper.c
@@ -46,7 +46,7 @@ int run_helper(void (*pre_exec)(void *), void *pre_data, char **argv)
 	unsigned long stack, sp;
 	int pid, fds[2], ret, n;
 
-	stack = alloc_stack(0, __cant_sleep());
+	stack = alloc_stack(0, __uml_cant_sleep());
 	if (stack == 0)
 		return -ENOMEM;
 
@@ -70,7 +70,7 @@ int run_helper(void (*pre_exec)(void *), void *pre_data, char **argv)
 	data.pre_data = pre_data;
 	data.argv = argv;
 	data.fd = fds[1];
-	data.buf = __cant_sleep() ? uml_kmalloc(PATH_MAX, UM_GFP_ATOMIC) :
+	data.buf = __uml_cant_sleep() ? uml_kmalloc(PATH_MAX, UM_GFP_ATOMIC) :
 					uml_kmalloc(PATH_MAX, UM_GFP_KERNEL);
 	pid = clone(helper_child, (void *) sp, CLONE_VM, &data);
 	if (pid < 0) {
@@ -121,7 +121,7 @@ int run_helper_thread(int (*proc)(void *), void *arg, unsigned int flags,
 	unsigned long stack, sp;
 	int pid, status, err;
 
-	stack = alloc_stack(0, __cant_sleep());
+	stack = alloc_stack(0, __uml_cant_sleep());
 	if (stack == 0)
 		return -ENOMEM;
 
-- 
2.43.0



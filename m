Return-Path: <linux-kernel+bounces-155237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DB48AE738
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E61F71F26277
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FC01353FE;
	Tue, 23 Apr 2024 12:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="YpVOKfdw"
Received: from out187-13.us.a.mail.aliyun.com (out187-13.us.a.mail.aliyun.com [47.90.187.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC12126F3F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 12:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877162; cv=none; b=FOfylsEN89PETk46k4COJJwTiJhPSL7jW4jannx/PUQ7abzfOz5mECCqUy1HqohmT2nTLhmlSYhTmus0Fm1vo8XrzmV3OzAXRweIqhC7f/W2B/klUrQ6kTVj3ACGGqCBNfJKrrfFdWfEGXs+7WQnUrwoG5mIAHVKl3625SDLSQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877162; c=relaxed/simple;
	bh=LZFuJ/4FGskBf4AnZH1TT3ZTMxB4uZoW+o1jgSpMUno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rmrlQFUV9IB2vbQup20kLTTGMsBySLexQ9TjG438gslCY3W65BmqLh6z0KbzUiopEXHZf6Oc5jdEwWbfwVdF1uf9rJiAw6jocGwoCZP6HOFXl3VdADYqOoShwnv1LlLpzFJ5szDy5MiZEbQrbm7m58pnFBFUed16+fLPGCSNWWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=YpVOKfdw; arc=none smtp.client-ip=47.90.187.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1713877148; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=u2nOPuUACaHxjsvTBbK286kNs1kGaeWUIM12LDvgezc=;
	b=YpVOKfdwHeePK5h+m/sgie0Xl2qQKelgw4ORTT/J8PxOw/yIJ3wlq/8hQgyrjunBTX/qo1WAl0+ylSFIiDMfKtQOY1Z6njv2aJa9lzOjwxJrvEdtXuOCpwWs6+8wSNlJuDHFaLDtVDr5KSfD3+6U61yIYudnIKs7mhNZOVcszXw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047204;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.XJXNjSj_1713877148;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.XJXNjSj_1713877148)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 20:59:08 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v2 5/7] um: Add an internal header shared among the user code
Date: Tue, 23 Apr 2024 20:58:56 +0800
Message-Id: <20240423125858.137709-6-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423125858.137709-1-tiwei.btw@antgroup.com>
References: <20240423125858.137709-1-tiwei.btw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Move relevant declarations to this header. This will address
below -Wmissing-prototypes warnings:

arch/um/os-Linux/elf_aux.c:26:13: warning: no previous prototype for ‘scan_elf_aux’ [-Wmissing-prototypes]
arch/um/os-Linux/mem.c:213:13: warning: no previous prototype for ‘check_tmpexec’ [-Wmissing-prototypes]
arch/um/os-Linux/skas/process.c:107:6: warning: no previous prototype for ‘wait_stub_done’ [-Wmissing-prototypes]

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/os-Linux/elf_aux.c      |  1 +
 arch/um/os-Linux/internal.h     | 20 ++++++++++++++++++++
 arch/um/os-Linux/main.c         |  3 +--
 arch/um/os-Linux/mem.c          |  1 +
 arch/um/os-Linux/skas/mem.c     |  3 +--
 arch/um/os-Linux/skas/process.c |  1 +
 arch/um/os-Linux/start_up.c     |  3 +--
 7 files changed, 26 insertions(+), 6 deletions(-)
 create mode 100644 arch/um/os-Linux/internal.h

diff --git a/arch/um/os-Linux/elf_aux.c b/arch/um/os-Linux/elf_aux.c
index 344ac403fb5d..0a0f91cf4d6d 100644
--- a/arch/um/os-Linux/elf_aux.c
+++ b/arch/um/os-Linux/elf_aux.c
@@ -13,6 +13,7 @@
 #include <init.h>
 #include <elf_user.h>
 #include <mem_user.h>
+#include "internal.h"
 
 typedef Elf32_auxv_t elf_auxv_t;
 
diff --git a/arch/um/os-Linux/internal.h b/arch/um/os-Linux/internal.h
new file mode 100644
index 000000000000..317fca190c2b
--- /dev/null
+++ b/arch/um/os-Linux/internal.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UM_OS_LINUX_INTERNAL_H
+#define __UM_OS_LINUX_INTERNAL_H
+
+/*
+ * elf_aux.c
+ */
+void scan_elf_aux(char **envp);
+
+/*
+ * mem.c
+ */
+void check_tmpexec(void);
+
+/*
+ * skas/process.c
+ */
+void wait_stub_done(int pid);
+
+#endif /* __UM_OS_LINUX_INTERNAL_H */
diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index e82164f90288..f98ff79cdbf7 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -16,6 +16,7 @@
 #include <kern_util.h>
 #include <os.h>
 #include <um_malloc.h>
+#include "internal.h"
 
 #define PGD_BOUND (4 * 1024 * 1024)
 #define STACKSIZE (8 * 1024 * 1024)
@@ -102,8 +103,6 @@ static void setup_env_path(void)
 	}
 }
 
-extern void scan_elf_aux( char **envp);
-
 int __init main(int argc, char **argv, char **envp)
 {
 	char **new_argv;
diff --git a/arch/um/os-Linux/mem.c b/arch/um/os-Linux/mem.c
index c6c9495b1432..cf44d386f23c 100644
--- a/arch/um/os-Linux/mem.c
+++ b/arch/um/os-Linux/mem.c
@@ -17,6 +17,7 @@
 #include <init.h>
 #include <kern_util.h>
 #include <os.h>
+#include "internal.h"
 
 /*
  * kasan_map_memory - maps memory from @start with a size of @len.
diff --git a/arch/um/os-Linux/skas/mem.c b/arch/um/os-Linux/skas/mem.c
index 953fb10f3f93..1f9c1bffc3a6 100644
--- a/arch/um/os-Linux/skas/mem.c
+++ b/arch/um/os-Linux/skas/mem.c
@@ -17,11 +17,10 @@
 #include <skas.h>
 #include <sysdep/ptrace.h>
 #include <sysdep/stub.h>
+#include "../internal.h"
 
 extern char batch_syscall_stub[], __syscall_stub_start[];
 
-extern void wait_stub_done(int pid);
-
 static inline unsigned long *check_init_stack(struct mm_id * mm_idp,
 					      unsigned long *stack)
 {
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 1f5c3f2523d1..41a288dcfc34 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -23,6 +23,7 @@
 #include <skas.h>
 #include <sysdep/stub.h>
 #include <linux/threads.h>
+#include "../internal.h"
 
 int is_skas_winch(int pid, int fd, void *data)
 {
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index 6b21061c431c..89ad9f4f865c 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -25,6 +25,7 @@
 #include <ptrace_user.h>
 #include <registers.h>
 #include <skas.h>
+#include "internal.h"
 
 static void ptrace_child(void)
 {
@@ -222,8 +223,6 @@ static void __init check_ptrace(void)
 	check_sysemu();
 }
 
-extern void check_tmpexec(void);
-
 static void __init check_coredump_limit(void)
 {
 	struct rlimit lim;
-- 
2.34.1



Return-Path: <linux-kernel+bounces-154977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9951E8AE3CE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56B88285035
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DD47FBA2;
	Tue, 23 Apr 2024 11:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="WLc+f0Xw"
Received: from out0-209.mail.aliyun.com (out0-209.mail.aliyun.com [140.205.0.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8007E792
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871524; cv=none; b=N5YPlr37KZmnMH3IHxNiwt/q00Lsfkd8taCVRSdmJvDULmisAvhxfpo9olb9C+mePQd8jnDPAml0bXykfCB/v5DRtMpO6zcfqAOSWmBgxW3OP6hVAtMBNCw97RUbZCBBIULV0zOiIP/NS831wwesIRBgGlYQIMnnie1MeY0X/S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871524; c=relaxed/simple;
	bh=ByGcHN025QjVD6T/SJkG5sopwNFERynJs9leJtwY110=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AuIRLKboLOGm0T67G+M5KVf+Kcza/3MWDywTMwpGKOKSXDJNNyZEu9ljsezFPCqNRWhNKaPAeLolY+QcgontYD9ZEjMgbjx8e4venWbkVwCKDm+irgb6uWHfdhnLs5OlNLsDEKesM207sLy/485VaPiVsyuUfMg5goS1c+OwVVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=WLc+f0Xw; arc=none smtp.client-ip=140.205.0.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1713871514; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=f+7Dfcyc7ewnae17/TPs5HjFgj4pirZ9MfZiM8UFc54=;
	b=WLc+f0Xw7960Z1pHEPCoPQI+pbvtscvzUPc6zX+H9tGwQxHrrP16B8G6YBoRsMgILMB/DjhVwPDdDjNyeZ+S3nId+LpVlz43/OnuNqLhKoGDurb48Nw6YWJ2xmflF3apZs9njzw9CizTW7+JXj1FimkOrYkEnGpwsw1fINj93P4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047211;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.XJTUYi3_1713871513;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.XJTUYi3_1713871513)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 19:25:13 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 5/7] um: Add an internal header shared among the user code
Date: Tue, 23 Apr 2024 19:24:55 +0800
Message-Id: <20240423112457.2409319-6-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423112457.2409319-1-tiwei.btw@antgroup.com>
References: <20240423112457.2409319-1-tiwei.btw@antgroup.com>
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
 arch/um/os-Linux/internal.h    | 20 ++++++++++++++++++++
 arch/um/os-Linux/main.c        |  2 --
 arch/um/os-Linux/skas/mem.c    |  2 --
 arch/um/os-Linux/start_up.c    |  2 --
 arch/um/scripts/Makefile.rules |  3 ++-
 5 files changed, 22 insertions(+), 7 deletions(-)
 create mode 100644 arch/um/os-Linux/internal.h

diff --git a/arch/um/os-Linux/internal.h b/arch/um/os-Linux/internal.h
new file mode 100644
index 000000000000..2a0ea7853658
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
+extern void scan_elf_aux(char **envp);
+
+/*
+ * mem.c
+ */
+extern void check_tmpexec(void);
+
+/*
+ * skas/process.c
+ */
+extern void wait_stub_done(int pid);
+
+#endif /* __UM_OS_LINUX_INTERNAL_H */
diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index e82164f90288..9880cfcb9b8a 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -102,8 +102,6 @@ static void setup_env_path(void)
 	}
 }
 
-extern void scan_elf_aux( char **envp);
-
 int __init main(int argc, char **argv, char **envp)
 {
 	char **new_argv;
diff --git a/arch/um/os-Linux/skas/mem.c b/arch/um/os-Linux/skas/mem.c
index 953fb10f3f93..1b0502fb5c75 100644
--- a/arch/um/os-Linux/skas/mem.c
+++ b/arch/um/os-Linux/skas/mem.c
@@ -20,8 +20,6 @@
 
 extern char batch_syscall_stub[], __syscall_stub_start[];
 
-extern void wait_stub_done(int pid);
-
 static inline unsigned long *check_init_stack(struct mm_id * mm_idp,
 					      unsigned long *stack)
 {
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index 6b21061c431c..f920c837428e 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -222,8 +222,6 @@ static void __init check_ptrace(void)
 	check_sysemu();
 }
 
-extern void check_tmpexec(void);
-
 static void __init check_coredump_limit(void)
 {
 	struct rlimit lim;
diff --git a/arch/um/scripts/Makefile.rules b/arch/um/scripts/Makefile.rules
index a8b7d9dab0a6..b8ea5f3bb1fb 100644
--- a/arch/um/scripts/Makefile.rules
+++ b/arch/um/scripts/Makefile.rules
@@ -9,7 +9,8 @@ USER_OBJS += $(filter %_user.o,$(obj-y) $(USER_SINGLE_OBJS))
 USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
 
 $(USER_OBJS:.o=.%): \
-	c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS) -include $(srctree)/include/linux/kern_levels.h -include user.h $(CFLAGS_$(basetarget).o)
+	c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS) -include $(srctree)/include/linux/kern_levels.h \
+		-include user.h -include $(srctree)/arch/um/os-Linux/internal.h $(CFLAGS_$(basetarget).o)
 
 # These are like USER_OBJS but filter USER_CFLAGS through unprofile instead of
 # using it directly.
-- 
2.34.1



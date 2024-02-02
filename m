Return-Path: <linux-kernel+bounces-49076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD48846592
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BCF0B246AB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F8A8464;
	Fri,  2 Feb 2024 01:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bAGuPj6m"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBFC63B2
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 01:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706838669; cv=none; b=os4eQmCGWEv5YOhcFuubGvWzJAtDjndjYEXl1znQzokG87bGFu2TxpE+Hgd0ig2Z3P8eG7TIRo3jOSNN/36nsGR7TQEQhEZRySaf6TA4UrjwphLfFoIOzOjWINVQuCLOp6MXzO3UuADkIZl4oS+srWvnocVjE3mmC1CxY+DbaIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706838669; c=relaxed/simple;
	bh=5aXAcO10d+v2K1pDhHz/8i7fc2PjMJeMhkobGt2H+IE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=mknlloXMBuEOyzdadbW7/2dPTILHUz2h0KQqdWdgj4Aq84H6j1z9hCa1TumNoIlaWCriyhMkok85TYG8ZEAAIuniEn3PV03mRsJ/zTU4aMVZg5Bk0iaCY2vXGOYuK5Ao+eA8jDyi3LXaYahXHLowXeDxu7EKekXMHdqaUx9oweU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=bAGuPj6m; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d934c8f8f7so14655875ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 17:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1706838667; x=1707443467; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqnBWephPOcgF/3nIZPD08BTGD/kLDACiy8VJStmDfE=;
        b=bAGuPj6mL3oug4WloNiLxRjycl5bA+ZDUzk3HL0g8i8y9QLWjkqFrKyR8pNAqdYgqC
         N5Lhe/CMB+6t8JnT0vKXvFn8Km2H6wUDtfmVvkAIjkNRltHgTuQuY+5lqVP8FmjIN82N
         l0+ca6uHGvrl18n1zfsBCRflM8k4443IKudV22fDin+INq7FM5heOUgqwV1YAADs0PhQ
         tpDRS5JMlBb9mhjU4SbullVFSL8d3rbd4upzhI1VL3I86j/XE7Jen4vTb09k9/YkIgKW
         DtFNc57gL84rriQlItQpkgEOMOMqq1jb7xOW90s+tuTF5AjGI/0yRlVA/GlHfv4zGDkO
         aCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706838667; x=1707443467;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FqnBWephPOcgF/3nIZPD08BTGD/kLDACiy8VJStmDfE=;
        b=bWU9HNIgamq4xJaZFLzkl8fVKpUOrUmYr9qL0STnw3F2TLLfv8DzHIULCURZFqOk5S
         jO46ZyeCaCVSS8hYrd6DoHzRCnHegb25Ep8b9z9lVIGWgKyuKchwkMdAFQNyiCdPbxJd
         kuhL/E5xLrpNkbbtWZgFOTtSxce4W7Lh7ObHzQ3QzWzu2dsg7J8zx+UHnlS7rJJTu+1x
         X3UBvqqOA1LLv/Z0k2QvcMBhjc1GvW4sXQT3wjpob9GQbcV0J0yCPYywX35r0dveamHa
         DkDViViBTCf3KM9Wsn2qcPcpPb0yBShkKZuqvD6iYhKUVeeuUwB4ppr4i86UupJ97Wbp
         BwPg==
X-Gm-Message-State: AOJu0YwJ31YKR8s08HjOvW6UBRXCeOiIoj2qQK1RTrp/15zS9gJJG8aE
	LySq1r96KzurC9yt+xkjwl+fpq8XyukaL9/YjVLNg0pVsP/u51Nrw9IdDXL9l6c=
X-Google-Smtp-Source: AGHT+IF0hgUIiqQv3IMQGxaY4gG9YCv70qDehVMvnAPPjJhJIshAJENzxmEZrv2yMnFGnznuXnUHpQ==
X-Received: by 2002:a17:902:f7c7:b0:1d9:462f:99cf with SMTP id h7-20020a170902f7c700b001d9462f99cfmr4197681plw.5.1706838666756;
        Thu, 01 Feb 2024 17:51:06 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW2tLiKX2SsmbgjyRMapiCWW7+97h8aLu+T1/miad738PGaLCuwhtm3/M6PXCOA097w6DlUV6uwoqZc7Vj/xnu2tbji5GnRXX+6PwNznw+JFiZorxWm9nmkVO/4Cc4fsbCJ2tmrdQtubSNfWr7c0kwibhUWTak8SCtkGvma4ZvmoxXc2rhmuI9NvGyJpm/ODMfA0BuSE9CTm8v1S1bIVziQjI/i5YDlpeP1lTBGfR5hAjYBNK2Tn60YGOwxfWSwD1mU8nvPI1wclWc=
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902ef0500b001d8ee46170dsm475070plx.84.2024.02.01.17.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 17:51:06 -0800 (PST)
From: Zong Li <zong.li@sifive.com>
To: palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	alex@ghiti.fr,
	conor.dooley@microchip.com,
	aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Zong Li <zong.li@sifive.com>
Subject: [PATCH v2] riscv: add CALLER_ADDRx support
Date: Fri,  2 Feb 2024 01:51:02 +0000
Message-Id: <20240202015102.26251-1-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

CALLER_ADDRx returns caller's address at specified level, they are used
for several tracers. These macros eventually use
__builtin_return_address(n) to get the caller's address if arch doesn't
define their own implementation.

In RISC-V, __builtin_return_address(n) only works when n == 0, we need
to walk the stack frame to get the caller's address at specified level.

data.level started from 'level + 3' due to the call flow of getting
caller's address in RISC-V implementation. If we don't have additional
three iteration, the level is corresponding to follows:

callsite -> return_address -> arch_stack_walk -> walk_stackframe
|           |                 |                  |
level 3     level 2           level 1            level 0

Fixes: 10626c32e382 ("riscv/ftrace: Add basic support")

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Zong Li <zong.li@sifive.com>
---

Changed in v2:
- Rebase to v6.8-rc2
- Add noinline attribute for return_address()
- Add a fixes tag

 arch/riscv/include/asm/ftrace.h    |  5 ++++
 arch/riscv/kernel/Makefile         |  2 ++
 arch/riscv/kernel/return_address.c | 48 ++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+)
 create mode 100644 arch/riscv/kernel/return_address.c

diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index 329172122952..15055f9df4da 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -25,6 +25,11 @@
 
 #define ARCH_SUPPORTS_FTRACE_OPS 1
 #ifndef __ASSEMBLY__
+
+extern void *return_address(unsigned int level);
+
+#define ftrace_return_address(n) return_address(n)
+
 void MCOUNT_NAME(void);
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
 {
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index f71910718053..604d6bf7e476 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -7,6 +7,7 @@ ifdef CONFIG_FTRACE
 CFLAGS_REMOVE_ftrace.o	= $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_patch.o	= $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_sbi.o	= $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_return_address.o	= $(CC_FLAGS_FTRACE)
 endif
 CFLAGS_syscall_table.o	+= $(call cc-option,-Wno-override-init,)
 CFLAGS_compat_syscall_table.o += $(call cc-option,-Wno-override-init,)
@@ -46,6 +47,7 @@ obj-y	+= irq.o
 obj-y	+= process.o
 obj-y	+= ptrace.o
 obj-y	+= reset.o
+obj-y	+= return_address.o
 obj-y	+= setup.o
 obj-y	+= signal.o
 obj-y	+= syscall_table.o
diff --git a/arch/riscv/kernel/return_address.c b/arch/riscv/kernel/return_address.c
new file mode 100644
index 000000000000..c8115ec8fb30
--- /dev/null
+++ b/arch/riscv/kernel/return_address.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This code come from arch/arm64/kernel/return_address.c
+ *
+ * Copyright (C) 2023 SiFive.
+ */
+
+#include <linux/export.h>
+#include <linux/kprobes.h>
+#include <linux/stacktrace.h>
+
+struct return_address_data {
+	unsigned int level;
+	void *addr;
+};
+
+static bool save_return_addr(void *d, unsigned long pc)
+{
+	struct return_address_data *data = d;
+
+	if (!data->level) {
+		data->addr = (void *)pc;
+		return false;
+	}
+
+	--data->level;
+
+	return true;
+}
+NOKPROBE_SYMBOL(save_return_addr);
+
+noinline void *return_address(unsigned int level)
+{
+	struct return_address_data data;
+
+	data.level = level + 3;
+	data.addr = NULL;
+
+	arch_stack_walk(save_return_addr, &data, current, NULL);
+
+	if (!data.level)
+		return data.addr;
+	else
+		return NULL;
+
+}
+EXPORT_SYMBOL_GPL(return_address);
+NOKPROBE_SYMBOL(return_address);
-- 
2.17.1



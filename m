Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2966A7AE1CE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 00:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbjIYWll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 18:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjIYWli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 18:41:38 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F8111C;
        Mon, 25 Sep 2023 15:41:31 -0700 (PDT)
X-QQ-mid: bizesmtp64t1695681678tnvf3nwx
Received: from linux-lab-host.localdomain ( [116.30.124.152])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 26 Sep 2023 06:41:16 +0800 (CST)
X-QQ-SSF: 01200000002000E0Y000B00A0000000
X-QQ-FEAT: 3M0okmaRx3gfsSflpNrVeZ3sLICSqSaF1U3sraXTLgAlViLSauDfSqqDtpoNW
        SpJ9yhtzh6PzBUapWeOX0uRrrOAx/YDjuGcAV/ElqISXdLVJrgKYLDHpCpA9o8pTr1UJmAp
        TZpLJKkg5BgsLqXJA7AyPqGQd4uo4wJ9kG/PcrwaYQDKWoXQAHmyI48DbJyB9TrgDn6MwV1
        xAbDs/bktubgubuWpp3z5BZzxdTfsdxIyMEd653QAHjXk0VSw0QgkTt/ZwID4tddHr20MU5
        IBenNgCrBRJGf1SYzfyD/v+sJ8AofWpCIgALXUucwYI6Z1XoKE8OaZJ5OVSdOUqOPo7jhE0
        8L83kEBlrjALbS9Xe1VQFAawPyge85zIGnGGzgYOddDAkAAqjslJdveiZm9lYGNaojrQbrE
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2541803507469492191
From:   Zhangjin Wu <falcon@tinylab.org>
To:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-riscv@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Cc:     falcon@tinylab.org, palmer@rivosinc.com, paul.walmsley@sifive.com,
        paulburton@kernel.org, paulmck@kernel.org,
        tsbogend@alpha.franken.de, w@1wt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Tim Bird <tim.bird@sony.com>
Subject: [PATCH v1 5/7] DCE/DSE: riscv: move syscall tables to syscalls/
Date:   Tue, 26 Sep 2023 06:41:16 +0800
Message-Id: <c10a50ff232a15897d3036ccd7af3d6f9aa8ee29.1695679700.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1695679700.git.falcon@tinylab.org>
References: <cover.1695679700.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both syscall table and compat syscall table share some dead syscalls
elimination code, to avoid cluttering the main RISC-V kernel Makefile,
let's move these tables and the corresponding compile settings to
syscalls/.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 arch/riscv/kernel/Makefile                             |  5 +----
 arch/riscv/kernel/syscalls/Makefile                    | 10 ++++++++++
 .../riscv/kernel/{ => syscalls}/compat_syscall_table.c |  0
 arch/riscv/kernel/{ => syscalls}/syscall_table.c       |  0
 4 files changed, 11 insertions(+), 4 deletions(-)
 create mode 100644 arch/riscv/kernel/syscalls/Makefile
 rename arch/riscv/kernel/{ => syscalls}/compat_syscall_table.c (100%)
 rename arch/riscv/kernel/{ => syscalls}/syscall_table.c (100%)

diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 95cf25d48405..40aebbf06880 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -8,8 +8,6 @@ CFLAGS_REMOVE_ftrace.o	= $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_patch.o	= $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_sbi.o	= $(CC_FLAGS_FTRACE)
 endif
-CFLAGS_syscall_table.o	+= $(call cc-option,-Wno-override-init,)
-CFLAGS_compat_syscall_table.o += $(call cc-option,-Wno-override-init,)
 
 ifdef CONFIG_KEXEC
 AFLAGS_kexec_relocate.o := -mcmodel=medany $(call cc-option,-mno-relax)
@@ -48,7 +46,7 @@ obj-y	+= ptrace.o
 obj-y	+= reset.o
 obj-y	+= setup.o
 obj-y	+= signal.o
-obj-y	+= syscall_table.o
+obj-y	+= syscalls/
 obj-y	+= sys_riscv.o
 obj-y	+= time.o
 obj-y	+= traps.o
@@ -95,7 +93,6 @@ obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 obj-$(CONFIG_CFI_CLANG)		+= cfi.o
 
 obj-$(CONFIG_EFI)		+= efi.o
-obj-$(CONFIG_COMPAT)		+= compat_syscall_table.o
 obj-$(CONFIG_COMPAT)		+= compat_signal.o
 obj-$(CONFIG_COMPAT)		+= compat_vdso/
 
diff --git a/arch/riscv/kernel/syscalls/Makefile b/arch/riscv/kernel/syscalls/Makefile
new file mode 100644
index 000000000000..65abd0871ee5
--- /dev/null
+++ b/arch/riscv/kernel/syscalls/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for the RISC-V syscall tables
+#
+
+CFLAGS_syscall_table.o        += $(call cc-option,-Wno-override-init,)
+CFLAGS_compat_syscall_table.o += $(call cc-option,-Wno-override-init,)
+
+obj-y                += syscall_table.o
+obj-$(CONFIG_COMPAT) += compat_syscall_table.o
diff --git a/arch/riscv/kernel/compat_syscall_table.c b/arch/riscv/kernel/syscalls/compat_syscall_table.c
similarity index 100%
rename from arch/riscv/kernel/compat_syscall_table.c
rename to arch/riscv/kernel/syscalls/compat_syscall_table.c
diff --git a/arch/riscv/kernel/syscall_table.c b/arch/riscv/kernel/syscalls/syscall_table.c
similarity index 100%
rename from arch/riscv/kernel/syscall_table.c
rename to arch/riscv/kernel/syscalls/syscall_table.c
-- 
2.25.1


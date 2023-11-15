Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7857DDCD5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 07:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345281AbjKAGpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 02:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343684AbjKAGpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 02:45:44 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B1E103;
        Tue, 31 Oct 2023 23:45:37 -0700 (PDT)
X-QQ-mid: bizesmtp68t1698821091tvb7u4r1
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 01 Nov 2023 14:44:48 +0800 (CST)
X-QQ-SSF: 01200000000000B0B000000A0000000
X-QQ-FEAT: 3M0okmaRx3gxeEyH4BlqDeuloEyl32NdDWDCAwDSyK64HTzX/3liUnbfNDiz+
        sZcpbjY9p5B/dZFk8H1lKOIoJPxcVegVfzk/66o6v+sV5lnjG+djsJVpkmIsWpTilez6PcS
        wG3rH0s0qeISm34gMMW7Go0eab9EqbwaAlsjo94pCL5VpmuSmwp2+iwsJ5sRc0YjK2EEyDN
        4R+SsAo1eIxe5XgTejVkfuUJ6+ZT1PHSIaZss+kefmd4Xf9X2WUwuwkgOX38HUg15MtAUpP
        PZf2IJt4k0wS46++jcBsUH9D7+VWfWyVlvdL17lk8A2jZTCExwkSVprmWwImL8NK2Ejo5ZT
        kmTeZiNuWGehdme6164H/Yg2vxnQE5o7szoeegp
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1492668164630438734
From:   Song Shuai <songshuaishuai@tinylab.org>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, keescook@chromium.org, guoren@kernel.org,
        bjorn@rivosinc.com, jszhang@kernel.org, conor.dooley@microchip.com,
        andy.chiu@sifive.com, samitolvanen@google.com,
        songshuaishuai@tinylab.org, coelacanthushex@gmail.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] riscv: Support RANDOMIZE_KSTACK_OFFSET
Date:   Wed,  1 Nov 2023 14:44:23 +0800
Message-Id: <20231101064423.1906122-1-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inspired from arm64's implement -- commit 70918779aec9
("arm64: entry: Enable random_kstack_offset support")

Add support of kernel stack offset randomization while handling syscall,
the offset is defaultly limited by KSTACK_OFFSET_MAX() (i.e. 10 bits).

In order to avoid trigger stack canaries (due to __builtin_alloca) and
slowing down the entry path, use __no_stack_protector attribute to
disable stack protector for do_trap_ecall_u() at the function level.

Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
---
Testing with randomize_kstack_offset=y cmdline, lkdtm/stack-entropy.sh
showed appropriate stack offset instead of zero.
---
 arch/riscv/Kconfig        |  1 +
 arch/riscv/kernel/traps.c | 18 +++++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d607ab0f7c6d..0e843de33f0c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -100,6 +100,7 @@ config RISCV
 	select HAVE_ARCH_KGDB_QXFER_PKT
 	select HAVE_ARCH_MMAP_RND_BITS if MMU
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
+	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
 	select HAVE_ARCH_TRACEHOOK
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 19807c4d3805..3f869b2d47c3 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -6,6 +6,7 @@
 #include <linux/cpu.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/randomize_kstack.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/signal.h>
@@ -296,9 +297,11 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
 	}
 }
 
-asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
+asmlinkage __visible __trap_section  __no_stack_protector
+void do_trap_ecall_u(struct pt_regs *regs)
 {
 	if (user_mode(regs)) {
+
 		long syscall = regs->a7;
 
 		regs->epc += 4;
@@ -308,10 +311,23 @@ asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
 
 		syscall = syscall_enter_from_user_mode(regs, syscall);
 
+		add_random_kstack_offset();
+
 		if (syscall >= 0 && syscall < NR_syscalls)
 			syscall_handler(regs, syscall);
 		else if (syscall != -1)
 			regs->a0 = -ENOSYS;
+		/*
+		 * Ultimately, this value will get limited by KSTACK_OFFSET_MAX(),
+		 * so the maximum stack offset is 1k bytes (10 bits).
+		 *
+		 * The actual entropy will be further reduced by the compiler when
+		 * applying stack alignment constraints: 16-byte (i.e. 4-bit) aligned
+		 * for RV32I or RV64I.
+		 *
+		 * The resulting 6 bits of entropy is seen in SP[9:4].
+		 */
+		choose_random_kstack_offset(get_random_u16());
 
 		syscall_exit_to_user_mode(regs);
 	} else {
-- 
2.20.1


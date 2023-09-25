Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115E57AE1D0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 00:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbjIYWmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 18:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjIYWmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 18:42:43 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DCD11C;
        Mon, 25 Sep 2023 15:42:36 -0700 (PDT)
X-QQ-mid: bizesmtp62t1695681747tvn9b2gn
Received: from linux-lab-host.localdomain ( [116.30.124.152])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 26 Sep 2023 06:42:25 +0800 (CST)
X-QQ-SSF: 01200000002000E0Y000B00A0000000
X-QQ-FEAT: QityeSR92A0MQJVv5nuCC9DWB6NqRLzb0Nt00+7+ZdZFXtQd+tI7WSyL9WNOC
        fnkFG8BxSL4z+x4KtcNrcR8seOIuPOURUulAxrpJmjQqP1LnskZEYIQeAh7TqLbJQrlD4li
        3VuACOa9fnkngcsF3KIGbIynUc0D2IWpUdjKYODzIYUXgIz+zmPiduG6OYqUjSeaFRhNVQi
        R0HbuNW/24Z5vZZir3noOwSkUHoulzJ2+O4FYOOXwupxn1hyjRia4sJ2NT5RJM4nXc0e8Iv
        7hAGFtYtbhAxrGb58x8hDMLmYTvcInpLmnftQdn3m6DI7DS6SGVCJU/ULhGp1PpyhutLM3N
        Q/G4gGWqnZP9rqGdHPsdsDiBO/RURWwjE7Drreilih2jBFRvf5O1ZdfOFTpH5AMIwzf0aLr
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2348411404682298682
From:   Zhangjin Wu <falcon@tinylab.org>
To:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-riscv@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Cc:     falcon@tinylab.org, palmer@rivosinc.com, paul.walmsley@sifive.com,
        paulburton@kernel.org, paulmck@kernel.org,
        tsbogend@alpha.franken.de, w@1wt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Tim Bird <tim.bird@sony.com>
Subject: [PATCH v1 6/7] DCE/DSE: riscv: add HAVE_TRIM_UNUSED_SYSCALLS support
Date:   Tue, 26 Sep 2023 06:42:23 +0800
Message-Id: <ce00dad5acdd4aff099b289843e30c83f7e31764.1695679700.git.falcon@tinylab.org>
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

For HAVE_TRIM_UNUSED_SYSCALLS, the syscall tables are hacked with the
inputing unused_syscalls.

Firstly, the intermediate preprocessed .i files are generated from the
original C version of syscall tables respectively, and named with a
'used' suffix: syscall_table_used.i, compat_syscall_table_used.i.

Secondly, all of the unused syscalls are commented.

At last, two new objective files sufixed with 'used' are generated from
the hacked .i files and they are linked into the eventual kernel image.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 arch/riscv/Kconfig                  |  1 +
 arch/riscv/kernel/syscalls/Makefile | 37 +++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d607ab0f7c6d..b5e726b49a6f 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -140,6 +140,7 @@ config RISCV
 	select HAVE_RSEQ
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
+	select HAVE_TRIM_UNUSED_SYSCALLS if HAVE_LD_DEAD_CODE_DATA_ELIMINATION
 	select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
diff --git a/arch/riscv/kernel/syscalls/Makefile b/arch/riscv/kernel/syscalls/Makefile
index 65abd0871ee5..3b5969aaa9e8 100644
--- a/arch/riscv/kernel/syscalls/Makefile
+++ b/arch/riscv/kernel/syscalls/Makefile
@@ -3,8 +3,45 @@
 # Makefile for the RISC-V syscall tables
 #
 
+ifndef CONFIG_TRIM_UNUSED_SYSCALLS
+
 CFLAGS_syscall_table.o        += $(call cc-option,-Wno-override-init,)
 CFLAGS_compat_syscall_table.o += $(call cc-option,-Wno-override-init,)
 
 obj-y                += syscall_table.o
 obj-$(CONFIG_COMPAT) += compat_syscall_table.o
+else # CONFIG_TRIM_UNUSED_SYSCALLS
+
+include $(srctree)/scripts/Makefile.syscalls
+
+CFLAGS_syscall_table_used.o        += $(call cc-option,-Wno-override-init,)
+CFLAGS_compat_syscall_table_used.o += $(call cc-option,-Wno-override-init,)
+
+obj-y                += syscall_table_used.o
+obj-$(CONFIG_COMPAT) += compat_syscall_table_used.o
+
+# comment the unused syscalls
+quiet_cmd_used = USED    $@
+      cmd_used = sed -E -e '/^\[([0-9]+|\([0-9]+ \+ [0-9]+\))\] = /{/= *__riscv_(__sys_|sys_|compat_)*($(used_syscalls)),/!{s%^%/* %g;s%$$% */%g}}' -i $@;
+
+$(obj)/syscall_table_used.c: $(src)/syscall_table.c
+	$(Q)cp $< $@
+
+$(obj)/syscall_table_used.i: $(src)/syscall_table_used.c $(used_syscalls_deps) FORCE
+	$(call if_changed_dep,cpp_i_c)
+	$(call cmd,used)
+
+$(obj)/syscall_table_used.o: $(obj)/syscall_table_used.i FORCE
+	$(call if_changed,cc_o_c)
+
+$(obj)/compat_syscall_table_used.c: $(src)/compat_syscall_table.c
+	$(Q)cp $< $@
+
+$(obj)/compat_syscall_table_used.i: $(src)/compat_syscall_table_used.c $(used_syscalls_deps) FORCE
+	$(call if_changed_dep,cpp_i_c)
+	$(call cmd,used)
+
+$(obj)/compat_syscall_table_used.o: $(obj)/compat_syscall_table_used.i FORCE
+	$(call if_changed,cc_o_c)
+
+endif # CONFIG_TRIM_UNUSED_SYSCALLS
-- 
2.25.1


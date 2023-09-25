Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182637AE1D6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 00:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbjIYWnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 18:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjIYWnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 18:43:51 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C05109;
        Mon, 25 Sep 2023 15:43:43 -0700 (PDT)
X-QQ-mid: bizesmtp81t1695681815tls4ddg5
Received: from linux-lab-host.localdomain ( [116.30.124.152])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 26 Sep 2023 06:43:33 +0800 (CST)
X-QQ-SSF: 01200000002000E0Y000B00A0000000
X-QQ-FEAT: aBJFcW+uBGYffXzygR0k5C/WLWWZcLSCd2TbMPG0O7Tlzn1m+5D3uZe31rmrB
        aujFQULia5dBlILNDRUyEjx57EpMsxaL6Hz0UfpOimP01EPYwODfLNDt/08+rViZ0kDvJPS
        c/l6PK5eg6fwnuRPIEYFxcxK83ddGI9AWtGlJq/Ee72+sNa4MrAQ3EN8Qe34Np4jqLArABG
        JS2WsLg0nT+US7V5b/8yFqpM/D3X+G29I8CLiztdDhT1Y7JbtyMwz8ftGBL0fuh92PguYE4
        IKeAjeoyg3J6mOYoYZE003kMKygyo6u/CV03ypKigE7GsLxTYVFe5MpxCrKElLULeYxae/d
        HtHN7uvHgeUIKpoUbjQ3Dfq7OGBezfWvX3+if5KLWzLVYk17ZVHC2GUJSVYzHQJ1NQ/1p5y
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4775298546958751858
From:   Zhangjin Wu <falcon@tinylab.org>
To:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-riscv@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Cc:     falcon@tinylab.org, palmer@rivosinc.com, paul.walmsley@sifive.com,
        paulburton@kernel.org, paulmck@kernel.org,
        tsbogend@alpha.franken.de, w@1wt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Tim Bird <tim.bird@sony.com>
Subject: [PATCH v1 7/7] DCE/DSE: riscv: trim syscall tables
Date:   Tue, 26 Sep 2023 06:43:32 +0800
Message-Id: <aad452c57bce2ab7983e723d78bd2cc7b6f533c1.1695679700.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1695679700.git.falcon@tinylab.org>
References: <cover.1695679700.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: Yes, score=6.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_PBL,RCVD_IN_SBL_CSS,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [43.154.54.12 listed in list.dnswl.org]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [43.154.54.12 listed in zen.spamhaus.org]
        *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  1.3 RCVD_IN_VALIDITY_RPBL RBL: Relay in Validity RPBL,
        *      https://senderscore.org/blocklistlookup/
        *      [43.154.54.12 listed in bl.score.senderscore.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the maximum nr of the used syscalls is smaller than __NR_syscalls
(original syscalls total). It is able to update __NR_syscalls to
(maximum nr + 1) and further trim the '>= (maximum nr + 1)' part of the
syscall tables:

For example:

    sys_call_table [143] = {
	[0 ... 143 - 1] = sys_ni_syscall,
        [64] = sys_write,
        [93] = sys_exit,
        [142] = sys_reboot,
    }

The >= 143 part of the syscall tables can be trimmed.

At the same time, the syscall >= 143 from user space must be ignored
from do_trap_ecall_u() of traps.c.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 arch/riscv/include/asm/unistd.h               |  2 ++
 arch/riscv/kernel/Makefile                    |  2 ++
 arch/riscv/kernel/syscalls/Makefile           | 22 +++++++++++++++++++
 .../kernel/syscalls/compat_syscall_table.c    |  4 ++--
 arch/riscv/kernel/syscalls/syscall_table.c    |  4 ++--
 5 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/unistd.h b/arch/riscv/include/asm/unistd.h
index 221630bdbd07..4d8e41f446ff 100644
--- a/arch/riscv/include/asm/unistd.h
+++ b/arch/riscv/include/asm/unistd.h
@@ -23,4 +23,6 @@
 
 #include <uapi/asm/unistd.h>
 
+#ifndef NR_syscalls
 #define NR_syscalls (__NR_syscalls)
+#endif
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 40aebbf06880..e75424c10729 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -49,7 +49,9 @@ obj-y	+= signal.o
 obj-y	+= syscalls/
 obj-y	+= sys_riscv.o
 obj-y	+= time.o
+ifneq ($(CONFIG_TRIM_UNUSED_SYSCALLS),y)
 obj-y	+= traps.o
+endif
 obj-y	+= riscv_ksyms.o
 obj-y	+= stacktrace.o
 obj-y	+= cacheinfo.o
diff --git a/arch/riscv/kernel/syscalls/Makefile b/arch/riscv/kernel/syscalls/Makefile
index 3b5969aaa9e8..f1a0597c8b24 100644
--- a/arch/riscv/kernel/syscalls/Makefile
+++ b/arch/riscv/kernel/syscalls/Makefile
@@ -14,9 +14,18 @@ else # CONFIG_TRIM_UNUSED_SYSCALLS
 
 include $(srctree)/scripts/Makefile.syscalls
 
+# calculate syscalls total from $(obj)/syscall_table_used.i
+ifneq ($(used_syscalls),)
+  NR_syscalls := $$(($$(sed -E -n -e '/^\[([0-9]+|\([0-9]+ \+ [0-9]+\))\] = /{s/^\[(.*)\].*/\1/gp}' $(obj)/syscall_table_used.i | bc | sort -g | tail -1 | grep '[0-9]' || echo -1) + 1))
+else
+  NR_syscalls := 0
+endif
+
+CFLAGS_traps_used.o                += -DNR_syscalls=$(NR_syscalls)
 CFLAGS_syscall_table_used.o        += $(call cc-option,-Wno-override-init,)
 CFLAGS_compat_syscall_table_used.o += $(call cc-option,-Wno-override-init,)
 
+obj-y                += traps_used.o
 obj-y                += syscall_table_used.o
 obj-$(CONFIG_COMPAT) += compat_syscall_table_used.o
 
@@ -24,15 +33,26 @@ obj-$(CONFIG_COMPAT) += compat_syscall_table_used.o
 quiet_cmd_used = USED    $@
       cmd_used = sed -E -e '/^\[([0-9]+|\([0-9]+ \+ [0-9]+\))\] = /{/= *__riscv_(__sys_|sys_|compat_)*($(used_syscalls)),/!{s%^%/* %g;s%$$% */%g}}' -i $@;
 
+# update the syscalls total
+quiet_cmd_snr = SNR     $@
+      cmd_snr = snr=$(NR_syscalls); if [ $$snr -ne 0 ]; then \
+		sed -i -e "s/sys_call_table\[.*\] =/sys_call_table[($$snr)] =/g;s/\[0 ... (.*) - 1\] = __riscv_sys_ni_syscall/[0 ... ($$snr) - 1] = __riscv_sys_ni_syscall/g" $@; \
+		fi;
+
+$(obj)/traps_used.c: $(src)/../traps.c $(obj)/syscall_table_used.i FORCE
+	$(Q)cp $< $@
+
 $(obj)/syscall_table_used.c: $(src)/syscall_table.c
 	$(Q)cp $< $@
 
 $(obj)/syscall_table_used.i: $(src)/syscall_table_used.c $(used_syscalls_deps) FORCE
 	$(call if_changed_dep,cpp_i_c)
 	$(call cmd,used)
+	$(call cmd,snr)
 
 $(obj)/syscall_table_used.o: $(obj)/syscall_table_used.i FORCE
 	$(call if_changed,cc_o_c)
+	$(call cmd,force_checksrc)
 
 $(obj)/compat_syscall_table_used.c: $(src)/compat_syscall_table.c
 	$(Q)cp $< $@
@@ -40,8 +60,10 @@ $(obj)/compat_syscall_table_used.c: $(src)/compat_syscall_table.c
 $(obj)/compat_syscall_table_used.i: $(src)/compat_syscall_table_used.c $(used_syscalls_deps) FORCE
 	$(call if_changed_dep,cpp_i_c)
 	$(call cmd,used)
+	$(call cmd,snr)
 
 $(obj)/compat_syscall_table_used.o: $(obj)/compat_syscall_table_used.i FORCE
 	$(call if_changed,cc_o_c)
+	$(call cmd,force_checksrc)
 
 endif # CONFIG_TRIM_UNUSED_SYSCALLS
diff --git a/arch/riscv/kernel/syscalls/compat_syscall_table.c b/arch/riscv/kernel/syscalls/compat_syscall_table.c
index ad7f2d712f5f..4756b6858eac 100644
--- a/arch/riscv/kernel/syscalls/compat_syscall_table.c
+++ b/arch/riscv/kernel/syscalls/compat_syscall_table.c
@@ -17,7 +17,7 @@
 
 asmlinkage long compat_sys_rt_sigreturn(void);
 
-void * const compat_sys_call_table[__NR_syscalls] = {
-	[0 ... __NR_syscalls - 1] = __riscv_sys_ni_syscall,
+void * const compat_sys_call_table[NR_syscalls] = {
+	[0 ... NR_syscalls - 1] = __riscv_sys_ni_syscall,
 #include <asm/unistd.h>
 };
diff --git a/arch/riscv/kernel/syscalls/syscall_table.c b/arch/riscv/kernel/syscalls/syscall_table.c
index dda913764903..d2b3233ae5d4 100644
--- a/arch/riscv/kernel/syscalls/syscall_table.c
+++ b/arch/riscv/kernel/syscalls/syscall_table.c
@@ -16,7 +16,7 @@
 #undef __SYSCALL
 #define __SYSCALL(nr, call)	[nr] = __riscv_##call,
 
-void * const sys_call_table[__NR_syscalls] = {
-	[0 ... __NR_syscalls - 1] = __riscv_sys_ni_syscall,
+void * const sys_call_table[NR_syscalls] = {
+	[0 ... NR_syscalls - 1] = __riscv_sys_ni_syscall,
 #include <asm/unistd.h>
 };
-- 
2.25.1


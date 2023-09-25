Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F477AE1CA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 00:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbjIYWkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 18:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjIYWkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 18:40:33 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9F411C;
        Mon, 25 Sep 2023 15:40:26 -0700 (PDT)
X-QQ-mid: bizesmtp71t1695681610tqhm377b
Received: from linux-lab-host.localdomain ( [116.30.124.152])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 26 Sep 2023 06:40:09 +0800 (CST)
X-QQ-SSF: 01200000002000E0Y000B00A0000000
X-QQ-FEAT: ILHsT53NKPin+kzqQGfU4qqx5molDA0iqJ3SZWTXpJi8+ENQI9pVCgAqlBSkC
        SjaN45XpIk1N9BymYSuAA4tz+X2z3zeBDA68WsFY96RT+Gd5cHXvtB6jom5TT127giJhM/5
        NYjRyHFFjFr7/hKz8hqmz7lUIJCz8p8INNxMNWVVYxrjS0fuOZ5lBCOitOCifwkKQ2qkq/I
        nFPp5yuzK7Fnnkzj05IDOOvyimA3DAoPmo/UDJuESVDQxMoEe1bta55YWtBEQh2u0eRdKYa
        CcWdvrTVxLfhg/EvuGTLSB6+7PHrTRo028EKuirSNFGWhIltAikvPVrYhLU+GAeDrJileEI
        B81pLKgvY0EFjP/WeutX5VCs8Rl7koPFER6fhRF5u0+6q2v/AytMFxAeFoecYN84j7q+8BB
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17594093605146210017
From:   Zhangjin Wu <falcon@tinylab.org>
To:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-riscv@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Cc:     falcon@tinylab.org, palmer@rivosinc.com, paul.walmsley@sifive.com,
        paulburton@kernel.org, paulmck@kernel.org,
        tsbogend@alpha.franken.de, w@1wt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Tim Bird <tim.bird@sony.com>
Subject: [PATCH v1 4/7] DCE/DSE: mips: add HAVE_TRIM_UNUSED_SYSCALLS support
Date:   Tue, 26 Sep 2023 06:40:08 +0800
Message-Id: <3042b32a13aecbf8f3c8bedee34a4ca8c7d7cb2e.1695679700.git.falcon@tinylab.org>
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
input used syscalls.

Based on the used syscalls information, a new version of tbl file is
generated from the original tbl file and named with a 'used' suffix.

With this new tbl file, both unistd_nr_*.h and syscall_table_*.h files
are updated to only include the used syscalls.

    $ grep _Linux_syscalls -ur arch/mips/include/generated/asm/
    arch/mips/include/generated/asm/unistd_nr_n64.h:#define __NR_64_Linux_syscalls	165
    arch/mips/include/generated/asm/unistd_nr_n32.h:#define __NR_N32_Linux_syscalls	165
    arch/mips/include/generated/asm/unistd_nr_o32.h:#define __NR_O32_Linux_syscalls	89

    $ grep -vr sys_ni_syscall arch/mips/include/generated/asm/syscall_table_*.h
    arch/mips/include/generated/asm/syscall_table_n32.h:__SYSCALL(58, sys_exit)
    arch/mips/include/generated/asm/syscall_table_n32.h:__SYSCALL(164, sys_reboot)
    arch/mips/include/generated/asm/syscall_table_n64.h:__SYSCALL(58, sys_exit)
    arch/mips/include/generated/asm/syscall_table_n64.h:__SYSCALL(164, sys_reboot)
    arch/mips/include/generated/asm/syscall_table_o32.h:__SYSCALL(1, sys_exit)
    arch/mips/include/generated/asm/syscall_table_o32.h:__SYSCALL(88, sys_reboot)

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 arch/mips/Kconfig                  |  1 +
 arch/mips/kernel/syscalls/Makefile | 23 +++++++++++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index bc8421859006..8a6927eff23d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -89,6 +89,7 @@ config MIPS
 	select HAVE_SPARSE_SYSCALL_NR
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
+	select HAVE_TRIM_UNUSED_SYSCALLS if HAVE_LD_DEAD_CODE_DATA_ELIMINATION
 	select HAVE_VIRT_CPU_ACCOUNTING_GEN if 64BIT || !SMP
 	select IRQ_FORCED_THREADING
 	select ISA if EISA
diff --git a/arch/mips/kernel/syscalls/Makefile b/arch/mips/kernel/syscalls/Makefile
index e6b21de65cca..1e292a9f84a0 100644
--- a/arch/mips/kernel/syscalls/Makefile
+++ b/arch/mips/kernel/syscalls/Makefile
@@ -26,10 +26,29 @@ sysnr_pfx_unistd_nr_n32 := N32
 sysnr_pfx_unistd_nr_n64 := 64
 sysnr_pfx_unistd_nr_o32 := O32
 
-$(kapi)/unistd_nr_%.h: $(src)/syscall_%.tbl $(sysnr) FORCE
+ifndef CONFIG_TRIM_UNUSED_SYSCALLS
+tbl = $(src)/syscall_%.tbl
+else
+
+include $(srctree)/scripts/Makefile.syscalls
+
+orig_tbl = $(src)/syscall_%.tbl
+ tbl_dir = arch/$(SRCARCH)/include/generated/tbl
+     tbl = $(tbl_dir)/syscall_used_%.tbl
+
+quiet_cmd_used = USED    $@
+      cmd_used = sed -E -e "/^[0-9]*[[:space:]]/{/(^($(used_syscalls))[[:space:]]|[[:space:]]($(used_syscalls))[[:space:]]|[[:space:]]($(used_syscalls))$$)/!{s/^/\#/g}}" $< > $@;
+
+$(tbl): $(orig_tbl) $(used_syscalls_deps) FORCE
+	$(Q)mkdir -p $(tbl_dir)
+	$(call cmd,used)
+
+endif
+
+$(kapi)/unistd_nr_%.h: $(tbl) $(sysnr) FORCE
 	$(call if_changed,sysnr)
 
-$(kapi)/syscall_table_%.h: $(src)/syscall_%.tbl $(systbl) FORCE
+$(kapi)/syscall_table_%.h: $(tbl) $(systbl) FORCE
 	$(call if_changed,systbl)
 
 uapisyshdr-y		+= unistd_n32.h			\
-- 
2.25.1


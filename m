Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4707E0608
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 17:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345095AbjKCQB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 12:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343945AbjKCQB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 12:01:27 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CC1D4F;
        Fri,  3 Nov 2023 09:01:23 -0700 (PDT)
X-QQ-mid: bizesmtp78t1699027266ta08iml2
Received: from main2-ubuntu.tail147f4.ts.net ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 04 Nov 2023 00:01:03 +0800 (CST)
X-QQ-SSF: 01200000000000000000000A0000000
X-QQ-FEAT: QityeSR92A28ZPRtiE81G2IrXHWg2q27WIobMU1SAAzpzkyyfEB73YsFcjdDe
        bVIiFyAUAwy8zzKzjrseeMWj0rb6pexvSi+JMipbHYhQxpuclzEMg7X6cSFvfm0zUbuvUkH
        h53yUWwjypGaV/yCfz9llOfRSJAl345Te7BpmmwciccZriF1iTUIX3Acz0VVcqgLQLxij90
        vmo9hUQ4XmPwLxfIwOPQoqiZRoQRMntdfHYmU86oxGlguDcOLX+hQcU1iiGjDNaJ56wmm5f
        d1CU19gnS85haVh9DhVlHm0SEjXqii66p+6zMkbYe99A6q5hm0RXrwcR0y5/I8ghUS3d/Qn
        7FA36k1Kp5SCYysOg6IbHNlCGA9XQ9hupgoQtSoicunaxLd4PZDp6bU1S/y2A==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17055644200842692498
From:   Yuan Tan <tanyuan@tinylab.org>
To:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        luc.vanoostenryck@gmail.com, linux-sparse@vger.kernel.org
Cc:     linux@weissschuh.net, palmer@rivosinc.com,
        paul.walmsley@sifive.com, paulburton@kernel.org,
        paulmck@kernel.org, tim.bird@sony.com, tsbogend@alpha.franken.de,
        w@1wt.eu, tanyuan@tinylab.org, i@maskray.me
Subject: [PATCH v1 08/14] DCE/DSE: add choice of methods to build reference for orphan sections
Date:   Sat,  4 Nov 2023 00:01:01 +0800
Message-Id: <c1c9913c0974b96faaab664ef354cf8775cd7554.1699025537.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1699025537.git.tanyuan@tinylab.org>
References: <cover.1699025537.git.tanyuan@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to .pushsection producing orphan sections, the kernel currently uses
`KEEP()` in the linker script to address this issue.

Here we purpose two methods to build reference for pushed section,
SHF_LINK_ORDER method and SECTION_SHF_GROUP method.

The binary files compiled using both methods turn out to be identical,
and it doesn't produce any side effects.

Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 init/Kconfig | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index 9834dbb0ddae..9599d2de44e8 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1740,6 +1740,56 @@ config USED_SYSCALLS
 
 	  If unsure, please disable TRIM_UNUSED_SYSCALLS.
 
+choice
+	prompt "Trim methods" if EXPERT
+	default RESTRICTED_TRIM_UNUSED_SYSCALLS
+	depends on TRIM_UNUSED_SYSCALLS
+	help
+	  This option selects the method to trim unused syscall wrongly kept.
+
+	  The binary files compiled using both methods are identical.
+
+	  If the trim methods is not specified, some syscalls are kept by
+	  linker script and can not be trimmed.
+
+config RESTRICTED_TRIM_UNUSED_SYSCALLS
+	bool "Leave some kept syscalls (EXPERIMENTAL)" if EXPERT
+	help
+	  Say Y here to trim 'unused' syscalls wrongly kept by __ex_table
+	  like sections in kernel space.
+
+	  Some syscalls are kept by linker script and can not be trimmed.
+
+	  If unsure, choose this.
+
+config SECTION_SHF_LINK_ORDER_SUPPORT
+	bool "Using SHF_LINK_ORDER attribute (EXPERIMENTAL)" if EXPERT
+	depends on HAVE_SECTION_SHF_LINK_ORDER_SUPPORT
+	help
+	  Say Y here to trim more 'unused' syscalls wrongly kept by __ex_table
+	  like sections in kernel space.
+
+	  This option uses the SHF_LINK_ORDER attribute to build references for
+	  orphan sections. Therefore, these sections are no longer kept in the
+	  linker script.
+
+	  If unsure, not choose this.
+
+config SECTION_SHF_GROUP_SUPPORT
+	bool "Using SHF_GROUP attribute (EXPERIMENTAL)" if EXPERT
+	depends on HAVE_SECTION_SHF_GROUP_SUPPORT
+	help
+	  Say Y here to trim more 'unused' syscalls wrongly kept by __ex_table
+	  like sections in kernel space.
+
+	  This option uses the SHF_GROUP attribute to build references for
+	  orphan sections. Therefore, these sections are no longer kept in the
+	  linker script.
+
+	  If unsure, not choose this.
+
+endchoice
+
 config KALLSYMS
 	bool "Load all symbols for debugging/ksymoops" if EXPERT
 	default y
-- 
2.34.1


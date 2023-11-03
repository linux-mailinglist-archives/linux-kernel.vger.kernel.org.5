Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4C67E061F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 17:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344730AbjKCQDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 12:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234637AbjKCQDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 12:03:16 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60516D5B;
        Fri,  3 Nov 2023 09:03:10 -0700 (PDT)
X-QQ-mid: bizesmtp71t1699027375tdhm453g
Received: from main2-ubuntu.tail147f4.ts.net ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 04 Nov 2023 00:02:52 +0800 (CST)
X-QQ-SSF: 01200000000000B06000000A0000000
X-QQ-FEAT: NcwpCxVQ7UNhf+mNoYKTlmUzCKrTx3/uLfRK9iw8b01sSRqpsgDYV8WUoq0+F
        bEVqW3uxHwMcq7cQk2v9IJTcEH5r/B/VLMPT6wOIogDyXcUP+URvzaHAuu/LDdBPo2y2PfX
        7Mvj8Mqe2Ivk0sKa4LuqIN72w9m3gc5Lcqg/zqWO640FM0vG0kG9EircxCKhMl7uzB00yoH
        1GP93ZVIalqTmrPj4vUjf6sev/hgXIrNQSDbJHjlwx52aJ9EmGcU4IM89eMwaKIUIKHp/FG
        vghOQ3hDkGX/eU+m4e94hHqprk/L/vOU8YSOvFJylFesXI+PLvYCD4xzTz8P1EhFUlvtRb/
        xog9r+mNfQz65z8LEQVxAy/3lxXueH3B9eIMSnlsByWsQU4YjU=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14770929756585809619
From:   Yuan Tan <tanyuan@tinylab.org>
To:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        luc.vanoostenryck@gmail.com, linux-sparse@vger.kernel.org
Cc:     linux@weissschuh.net, palmer@rivosinc.com,
        paul.walmsley@sifive.com, paulburton@kernel.org,
        paulmck@kernel.org, tim.bird@sony.com, tsbogend@alpha.franken.de,
        w@1wt.eu, tanyuan@tinylab.org, i@maskray.me
Subject: [PATCH v1 11/14] DCE/DSE: riscv: build reference for .pushsection in C functions
Date:   Sat,  4 Nov 2023 00:02:50 +0800
Message-Id: <ab9af3f07b520c8679a586770e3d488cb4866e8e.1699025537.git.tanyuan@tinylab.org>
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

Add the SECTION_SHF_LINK_ORDER method and the SECTION_SHF_GROUP method
to refactor __ASM_EXTABLE_RAW, so it won't produce orphan sections
anymore.

Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 arch/riscv/include/asm/asm-extable.h | 34 ++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/asm-extable.h b/arch/riscv/include/asm/asm-extable.h
index d0be5a838242..7164d871e038 100644
--- a/arch/riscv/include/asm/asm-extable.h
+++ b/arch/riscv/include/asm/asm-extable.h
@@ -13,6 +13,21 @@
 
 #ifdef __ASSEMBLY__
 
+#if defined(CONFIG_SECTION_SHF_LINK_ORDER_SUPPORT)
+#define __ASM_EXTABLE_PUSH_SECTION			\
+	__LABEL_NAME(.L__ex_table) :			\
+	.pushsection __SECTION_NAME(__ex_table), "ao", __LABEL_NAME(.L__ex_table)
+
+#elif defined(CONFIG_SECTION_SHF_GROUP_SUPPORT)
+#define __ASM_EXTABLE_PUSH_SECTION			\
+	.attach_to_group __SECTION_NAME(__ex_table);	\
+	.pushsection __SECTION_NAME(__ex_table), "a?"
+
+#else
+#define __ASM_EXTABLE_PUSH_SECTION			\
+	.pushsection __SECTION_NAME(__ex_table), "a"
+#endif
+
 #define __ASM_EXTABLE_RAW(insn, fixup, type, data)	\
 	.pushsection	__SECTION_NAME(__ex_table), "a";		\
 	.balign		4;				\
@@ -32,8 +47,23 @@
 #include <linux/stringify.h>
 #include <asm/gpr-num.h>
 
-#define __ASM_EXTABLE_RAW(insn, fixup, type, data)	\
-	".pushsection "	__SECTION_NAME(__ex_table) ", \"a\"\n"		\
+#ifdef CONFIG_SECTION_SHF_LINK_ORDER_SUPPORT
+#define __ASM_EXTABLE_PUSH_SECTION				\
+	__LABEL_NAME(.L__ex_table) ":"				\
+	".pushsection "	__SECTION_NAME(__ex_table) ", \"ao\"," __LABEL_NAME(.L__ex_table) "\n"
+
+#elif defined(CONFIG_SECTION_SHF_GROUP_SUPPORT)
+#define __ASM_EXTABLE_PUSH_SECTION				\
+	".attach_to_group " __SECTION_NAME(__ex_table) "\n"	\
+	".pushsection "	__SECTION_NAME(__ex_table) ", \"a?\"\n"
+
+#else
+#define __ASM_EXTABLE_PUSH_SECTION				\
+	".pushsection "	__SECTION_NAME(__ex_table) ", \"a\"\n"
+#endif
+
+#define __ASM_EXTABLE_RAW(insn, fixup, type, data)		\
+	__ASM_EXTABLE_PUSH_SECTION				\
 	".balign	4\n"				\
 	".long		((" insn ") - .)\n"		\
 	".long		((" fixup ") - .)\n"		\
-- 
2.34.1


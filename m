Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5917E0619
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 17:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345242AbjKCQDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 12:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345028AbjKCQC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 12:02:57 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D600191;
        Fri,  3 Nov 2023 09:02:53 -0700 (PDT)
X-QQ-mid: bizesmtp76t1699027360tslboa5k
Received: from main2-ubuntu.tail147f4.ts.net ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 04 Nov 2023 00:02:37 +0800 (CST)
X-QQ-SSF: 01200000000000B06000000A0000000
X-QQ-FEAT: 7jw2iSiCazppqEZda0FgbOVV0oUxEDe97G1OqE9PhKq+YFsptbTaM72oSfNLr
        AD0Rl3ypOCGWEW9q28c8fe7xZFoGZTdi1QAY8K+KTMUayL9hWr96UxcaNJtLe6LdaMGwtpX
        BwHTtHTHJzq/kG3A/XX2TPtRplT1QquC/iFXm4VN4rkOTyS6xCTnYMmeMD8fweOZ6lxxg9G
        /XDXZS9Sx0O+dUqnfzgEUIbwhgPow7med1tsdccavOIHLWbUxGONnMNosCU65bCoGAryQXM
        h3QZ1PNHF6M2M5XcV0SPWLIP3Mh2iYhULZT+jJ0uhU5wY5HLI9yciZnigOQckzi1DUcDPQz
        rZgdCteRPe17Zyov/8oA0PumZTnDfvFuF3JEDkhDXY+3gdHHO0=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15807065003592512725
From:   Yuan Tan <tanyuan@tinylab.org>
To:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        luc.vanoostenryck@gmail.com, linux-sparse@vger.kernel.org
Cc:     linux@weissschuh.net, palmer@rivosinc.com,
        paul.walmsley@sifive.com, paulburton@kernel.org,
        paulmck@kernel.org, tim.bird@sony.com, tsbogend@alpha.franken.de,
        w@1wt.eu, tanyuan@tinylab.org, i@maskray.me
Subject: [PATCH v1 10/14] DCE/DSE: riscv: make every ex_table's name unique
Date:   Sat,  4 Nov 2023 00:02:36 +0800
Message-Id: <f0ee9abfd8d7b27489a4efe3196813225ce5680f.1699025537.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1699025537.git.tanyuan@tinylab.org>
References: <cover.1699025537.git.tanyuan@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gc-sections require section names to be unique.

Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 arch/riscv/include/asm/asm-extable.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/asm-extable.h b/arch/riscv/include/asm/asm-extable.h
index 00a96e7a9664..d0be5a838242 100644
--- a/arch/riscv/include/asm/asm-extable.h
+++ b/arch/riscv/include/asm/asm-extable.h
@@ -9,10 +9,12 @@
 
 #ifdef CONFIG_MMU
 
+#include <linux/compiler.h>
+
 #ifdef __ASSEMBLY__
 
 #define __ASM_EXTABLE_RAW(insn, fixup, type, data)	\
-	.pushsection	__ex_table, "a";		\
+	.pushsection	__SECTION_NAME(__ex_table), "a";		\
 	.balign		4;				\
 	.long		((insn) - .);			\
 	.long		((fixup) - .);			\
@@ -31,7 +33,7 @@
 #include <asm/gpr-num.h>
 
 #define __ASM_EXTABLE_RAW(insn, fixup, type, data)	\
-	".pushsection	__ex_table, \"a\"\n"		\
+	".pushsection "	__SECTION_NAME(__ex_table) ", \"a\"\n"		\
 	".balign	4\n"				\
 	".long		((" insn ") - .)\n"		\
 	".long		((" fixup ") - .)\n"		\
-- 
2.34.1


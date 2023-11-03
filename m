Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6FB7E05EC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 16:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344181AbjKCP66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 11:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbjKCP64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 11:58:56 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE78194;
        Fri,  3 Nov 2023 08:58:51 -0700 (PDT)
X-QQ-mid: bizesmtp83t1699027115tqmp7mar
Received: from main2-ubuntu.tail147f4.ts.net ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 03 Nov 2023 23:58:32 +0800 (CST)
X-QQ-SSF: 01200000000000B06000000A0000000
X-QQ-FEAT: 3M0okmaRx3gtg4dkowId3SRZK6iJt7bmG/bknUDKf+3ULUZKiHp/tkQ2jHTjZ
        qCAJtCYV+PBISnAzK2lTT9gQ93lFd4WLGlpACg09bFke2VMU51xGkofztcVkF64kLeB/I40
        gt7AiMXFEF2xrMMx0HrXUSXv2jHoH+pff3Xms4oos9d5sxvTKIeoM4HgumgCEXWN1DXMZGG
        mOnRKFHyB0tdauEDaWiRCJ4WkEsUYt3jBksdkZqXTIOM4Sg1erJZuCIGNrgNzHJvUOE0TQI
        qfM8VoqG8AKNC9mj7MLM6aOKtJ7PJZrzG9XhTTXhE/GAatyk3aTKEWjcCrmwWhXqp/YBb1k
        Fal2Ut2duOE5o37lshvTGlRfYJ/VnEvHOdQu3tDN7OWkjvzEFMMskq1oA1G7g==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4824966276626844455
From:   Yuan Tan <tanyuan@tinylab.org>
To:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        luc.vanoostenryck@gmail.com, linux-sparse@vger.kernel.org
Cc:     linux@weissschuh.net, palmer@rivosinc.com,
        paul.walmsley@sifive.com, paulburton@kernel.org,
        paulmck@kernel.org, tim.bird@sony.com, tsbogend@alpha.franken.de,
        w@1wt.eu, tanyuan@tinylab.org, i@maskray.me
Subject: [PATCH v1 01/14] DCE/DSE: allow keep unique bounded sections
Date:   Fri,  3 Nov 2023 23:58:30 +0800
Message-Id: <c1af88e9c5e5956f22de6b9e7e69186dfad68767.1699025537.git.tanyuan@tinylab.org>
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

From: Zhangjin Wu <falcon@tinylab.org>

The bounded sections may break the elimination of some dead code.

Some unused syscalls have been wrongly kept by `__ex_table`, we will
unique `__ex_table` for every inserting and then remove the unused ones
explicitly and eventually, the unused syscalls will be eliminated.

In the future, we should find better methods to solve such issue:

  Some code may use '.pushsection/.popsection' to insert data
  to a bounded section, use `sys_sendfile` as an example:

      sys_sendfile:

        ".pushsection __ex_table,\"\"\n"
        ...
	".long		((" insn ") - .)\n"
        ...
        ".popsection"

  `insn` is an address in `sys_sendfile`, even if no real user uses
  sys_sendfile, the keeping of __ex_table will become a 'user' and
  break the elimination of `sys_sendfile`.

All of the bounded sections should be uniqued, and we should check if
they are the last users of the code, if so, those sections should be
removed and the code should be eliminated.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 include/asm-generic/vmlinux.lds.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 9c59409104f6..ea8170e11ab1 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -103,6 +103,7 @@
 #define RODATA_MAIN .rodata .rodata.[0-9a-zA-Z_]* .rodata..L*
 #define BSS_MAIN .bss .bss.[0-9a-zA-Z_]* .bss..compoundliteral*
 #define SBSS_MAIN .sbss .sbss.[0-9a-zA-Z_]*
+#define BSEC_MAIN(sec) sec sec##.[0-9a-zA-Z_]*
 #else
 #define TEXT_MAIN .text
 #define DATA_MAIN .data
@@ -110,6 +111,7 @@
 #define RODATA_MAIN .rodata
 #define BSS_MAIN .bss
 #define SBSS_MAIN .sbss
+#define BSEC_MAIN(sec) sec
 #endif
 
 /*
@@ -201,12 +203,12 @@
 
 #define BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
 	_BEGIN_##_label_ = .;						\
-	KEEP(*(_sec_))							\
+	KEEP(*(BSEC_MAIN(_sec_)))					\
 	_END_##_label_ = .;
 
 #define BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
 	_label_##_BEGIN_ = .;						\
-	KEEP(*(_sec_))							\
+	KEEP(*(BSEC_MAIN(_sec_)))					\
 	_label_##_END_ = .;
 
 #define BOUNDED_SECTION_BY(_sec_, _label_)				\
-- 
2.34.1



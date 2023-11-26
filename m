Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4257F9359
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 16:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjKZPSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 10:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjKZPR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 10:17:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADF110F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 07:18:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04B4C433C9;
        Sun, 26 Nov 2023 15:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701011885;
        bh=V57AiXAYYy6sW7YrUCL2Mf2ENr9bgxbhEiWxZqtaB24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=djweukSrCgkARY+NJsXL5917br+cLSMzI3ixps8ZSKFhDZQcxIiSCuBwDFaWjvHR+
         hVNReRtB7dzCEQtVCvtxnv97tM13yE8ChnSJFu0AYXsGtI8f7YebzylgJuMxsdPvCD
         fMwQpf/lyGYaBfWrt4gR+++fim96obNZeAxy0NGmVlzCmblnXAsuIZM5NYiwN8r4EL
         5GV+90hEF9MAhFa+Ut5Qg7VteaSOR4zjHpU6Mmh8vLkNSDjeUN7k+dWkzaC5knIbjG
         7z8sCSShzyKWqItXchEz02Reskt/oRvsX2C2VAH8QDnyOfbYbXPI6dvetsFYoYYyVY
         ukmpSSkMQetRA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] riscv: replace <asm-generic/export.h> with <linux/export.h>
Date:   Mon, 27 Nov 2023 00:17:39 +0900
Message-Id: <20231126151739.1557369-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231126151739.1557369-1-masahiroy@kernel.org>
References: <20231126151739.1557369-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ddb5cdbafaaa ("kbuild: generate KSYMTAB entries by modpost")
deprecated <asm-generic/export.h>, which is now a wrapper of
<linux/export.h>.

Replace #include <asm-generic/export.h> with #include <linux/export.h>.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/riscv/kernel/mcount.S  | 2 +-
 arch/riscv/lib/clear_page.S | 2 +-
 arch/riscv/lib/tishift.S    | 2 +-
 arch/riscv/lib/uaccess.S    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/mcount.S b/arch/riscv/kernel/mcount.S
index b4dd9ed6849e..f46db726e42e 100644
--- a/arch/riscv/kernel/mcount.S
+++ b/arch/riscv/kernel/mcount.S
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2017 Andes Technology Corporation */
 
+#include <linux/export.h>
 #include <linux/init.h>
 #include <linux/linkage.h>
 #include <linux/cfi_types.h>
@@ -9,7 +10,6 @@
 #include <asm/unistd.h>
 #include <asm/thread_info.h>
 #include <asm/asm-offsets.h>
-#include <asm-generic/export.h>
 #include <asm/ftrace.h>
 
 	.text
diff --git a/arch/riscv/lib/clear_page.S b/arch/riscv/lib/clear_page.S
index b22de1231144..fe07ce70a619 100644
--- a/arch/riscv/lib/clear_page.S
+++ b/arch/riscv/lib/clear_page.S
@@ -3,10 +3,10 @@
  * Copyright (c) 2023 Ventana Micro Systems Inc.
  */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include <asm/asm.h>
 #include <asm/alternative-macros.h>
-#include <asm-generic/export.h>
 #include <asm/hwcap.h>
 #include <asm/insn-def.h>
 #include <asm/page.h>
diff --git a/arch/riscv/lib/tishift.S b/arch/riscv/lib/tishift.S
index ef90075c4b0a..04f858afafe8 100644
--- a/arch/riscv/lib/tishift.S
+++ b/arch/riscv/lib/tishift.S
@@ -3,8 +3,8 @@
  * Copyright (C) 2018 Free Software Foundation, Inc.
  */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
-#include <asm-generic/export.h>
 
 SYM_FUNC_START(__lshrti3)
 	beqz	a2, .L1
diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
index 3ab438f30d13..9eca131dc555 100644
--- a/arch/riscv/lib/uaccess.S
+++ b/arch/riscv/lib/uaccess.S
@@ -1,5 +1,5 @@
+#include <linux/export.h>
 #include <linux/linkage.h>
-#include <asm-generic/export.h>
 #include <asm/asm.h>
 #include <asm/asm-extable.h>
 #include <asm/csr.h>
-- 
2.40.1


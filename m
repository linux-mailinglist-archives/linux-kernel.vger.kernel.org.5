Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969727977BB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239147AbjIGQbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239061AbjIGQbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:31:35 -0400
Received: from cantor.telenet-ops.be (cantor.telenet-ops.be [IPv6:2a02:1800:120:4::f00:10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A01A76A8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:18:45 -0700 (PDT)
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by cantor.telenet-ops.be (Postfix) with ESMTPS id 4RhL5L635Xz4x8kW
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 15:42:14 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:c214:2eac:128d:f67e])
        by michel.telenet-ops.be with bizsmtp
        id j1hx2A00L2mGBSJ061hxu2; Thu, 07 Sep 2023 15:41:59 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGQ-002m85-3F;
        Thu, 07 Sep 2023 15:41:57 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGf-00CMfU-BQ;
        Thu, 07 Sep 2023 15:41:57 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Finn Thain <fthain@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Philip Blundell <philb@gnu.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Sam Creasey <sammy@sammy.net>,
        Laurent Vivier <laurent@vivier.eu>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 06/52] m68k: kernel: Add and use "process.h"
Date:   Thu,  7 Sep 2023 15:41:07 +0200
Message-Id: <6894409da1a0d8667bf74b9100067485ce3c37ac.1694093327.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694093327.git.geert@linux-m68k.org>
References: <cover.1694093327.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with W=1:

    arch/m68k/kernel/process.c:115:16: warning: no previous prototype for ‘m68k_clone’ [-Wmissing-prototypes]
      115 | asmlinkage int m68k_clone(struct pt_regs *regs)
	  |                ^~~~~~~~~~
    arch/m68k/kernel/process.c:136:16: warning: no previous prototype for ‘m68k_clone3’ [-Wmissing-prototypes]
      136 | asmlinkage int m68k_clone3(struct pt_regs *regs)
	  |                ^~~~~~~~~~~

Fix this by introducing a new header file "process.h" for holding the
prototypes of functions implemented in arch/m68k/kernel/process.c.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/kernel/process.c | 1 +
 arch/m68k/kernel/process.h | 8 ++++++++
 2 files changed, 9 insertions(+)
 create mode 100644 arch/m68k/kernel/process.h

diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
index e06ce147c0b7fcf2..d2d6a57356502e5b 100644
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -38,6 +38,7 @@
 #include <asm/machdep.h>
 #include <asm/setup.h>
 
+#include <process.h>
 
 asmlinkage void ret_from_fork(void);
 asmlinkage void ret_from_kernel_thread(void);
diff --git a/arch/m68k/kernel/process.h b/arch/m68k/kernel/process.h
new file mode 100644
index 0000000000000000..d31745f2e64bebab
--- /dev/null
+++ b/arch/m68k/kernel/process.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/linkage.h>
+
+struct pt_regs;
+
+asmlinkage int m68k_clone(struct pt_regs *regs);
+asmlinkage int m68k_clone3(struct pt_regs *regs);
-- 
2.34.1


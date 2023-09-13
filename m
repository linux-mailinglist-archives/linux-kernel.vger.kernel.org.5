Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E1679EAA8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241666AbjIMOKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241440AbjIMOJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:09:46 -0400
Received: from riemann.telenet-ops.be (riemann.telenet-ops.be [IPv6:2a02:1800:110:4::f00:10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719D51FFA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:08:53 -0700 (PDT)
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by riemann.telenet-ops.be (Postfix) with ESMTPS id 4Rm2PF3ThVz4x2vy
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 16:08:49 +0200 (CEST)
Received: from ramsan.of.borg ([84.195.187.55])
        by andre.telenet-ops.be with bizsmtp
        id lS8o2A00A1C8whw01S8oWs; Wed, 13 Sep 2023 16:08:49 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qgQXd-003crJ-CL;
        Wed, 13 Sep 2023 16:08:46 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qgQXu-00FV3p-Nc;
        Wed, 13 Sep 2023 16:08:46 +0200
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
Subject: [PATCH v2 06/52] m68k: kernel: Add and use "process.h"
Date:   Wed, 13 Sep 2023 16:07:56 +0200
Message-Id: <5e50257d8fcae3eb202ce5f439dc29c09cb6c44f.1694613528.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694613528.git.geert@linux-m68k.org>
References: <cover.1694613528.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
  - Add Acked-by,
  - Include "process.h" instead of <process.h>, to fix in-tree builds.
---
 arch/m68k/kernel/process.c | 1 +
 arch/m68k/kernel/process.h | 8 ++++++++
 2 files changed, 9 insertions(+)
 create mode 100644 arch/m68k/kernel/process.h

diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
index e06ce147c0b7fcf2..2584e94e213468f1 100644
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -38,6 +38,7 @@
 #include <asm/machdep.h>
 #include <asm/setup.h>
 
+#include "process.h"
 
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


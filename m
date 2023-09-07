Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F53B797A07
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237489AbjIGR2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243677AbjIGR2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:28:34 -0400
Received: from riemann.telenet-ops.be (riemann.telenet-ops.be [IPv6:2a02:1800:110:4::f00:10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5711FCA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:28:05 -0700 (PDT)
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by riemann.telenet-ops.be (Postfix) with ESMTPS id 4RhL6D0SZVz4x6fl
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 15:43:00 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:c214:2eac:128d:f67e])
        by michel.telenet-ops.be with bizsmtp
        id j1hx2A00Q2mGBSJ061hxu7; Thu, 07 Sep 2023 15:41:59 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGQ-002m8E-5d;
        Thu, 07 Sep 2023 15:41:57 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGf-00CMfe-D5;
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
Subject: [PATCH 08/52] m68k: kernel: Add and use "signal.h"
Date:   Thu,  7 Sep 2023 15:41:09 +0200
Message-Id: <145c95cb476f906e419dc9a16e0ae5f1efbf61d4.1694093327.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694093327.git.geert@linux-m68k.org>
References: <cover.1694093327.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with W=1:

    arch/m68k/kernel/signal.c:756:18: warning: no previous prototype for ‘do_sigreturn’ [-Wmissing-prototypes]
      756 | asmlinkage void *do_sigreturn(struct pt_regs *regs, struct switch_stack *sw)
	  |                  ^~~~~~~~~~~~
    arch/m68k/kernel/signal.c:783:18: warning: no previous prototype for ‘do_rt_sigreturn’ [-Wmissing-prototypes]
      783 | asmlinkage void *do_rt_sigreturn(struct pt_regs *regs, struct switch_stack *sw)
	  |                  ^~~~~~~~~~~~~~~
    arch/m68k/kernel/signal.c:1112:17: warning: no previous prototype for ‘do_notify_resume’ [-Wmissing-prototypes]
     1112 | asmlinkage void do_notify_resume(struct pt_regs *regs)
	  |                 ^~~~~~~~~~~~~~~~

Fix this by introducing a new header file "signal.h" for holding the
prototypes of functions implemented in arch/m68k/kernel/signal.c.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/kernel/signal.c | 2 ++
 arch/m68k/kernel/signal.h | 7 +++++++
 2 files changed, 9 insertions(+)
 create mode 100644 arch/m68k/kernel/signal.h

diff --git a/arch/m68k/kernel/signal.c b/arch/m68k/kernel/signal.c
index 459c5ff69fcfa126..e628b859ef21beaf 100644
--- a/arch/m68k/kernel/signal.c
+++ b/arch/m68k/kernel/signal.c
@@ -51,6 +51,8 @@
 #include <asm/ucontext.h>
 #include <asm/cacheflush.h>
 
+#include "signal.h"
+
 #ifdef CONFIG_MMU
 
 /*
diff --git a/arch/m68k/kernel/signal.h b/arch/m68k/kernel/signal.h
new file mode 100644
index 0000000000000000..498d84f828202541
--- /dev/null
+++ b/arch/m68k/kernel/signal.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#include <linux/linkage.h>
+
+asmlinkage void do_notify_resume(struct pt_regs *regs);
+asmlinkage void *do_sigreturn(struct pt_regs *regs, struct switch_stack *sw);
+asmlinkage void *do_rt_sigreturn(struct pt_regs *regs, struct switch_stack *sw);
-- 
2.34.1


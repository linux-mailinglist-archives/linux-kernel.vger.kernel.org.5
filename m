Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5879C797A52
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244620AbjIGRhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbjIGRh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:37:29 -0400
Received: from riemann.telenet-ops.be (riemann.telenet-ops.be [IPv6:2a02:1800:110:4::f00:10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D7810F6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:37:01 -0700 (PDT)
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by riemann.telenet-ops.be (Postfix) with ESMTPS id 4RhL6D09dmz4x20Q
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 15:43:00 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:c214:2eac:128d:f67e])
        by michel.telenet-ops.be with bizsmtp
        id j1hx2A00M2mGBSJ061hxu6; Thu, 07 Sep 2023 15:41:59 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGQ-002m8B-4o;
        Thu, 07 Sep 2023 15:41:57 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGf-00CMfZ-CD;
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
Subject: [PATCH 07/52] m68k: kernel: Add and use "ptrace.h"
Date:   Thu,  7 Sep 2023 15:41:08 +0200
Message-Id: <d3b71667fb3bd98fe0b295b318115e9776c8292f.1694093327.git.geert@linux-m68k.org>
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

    arch/m68k/kernel/ptrace.c:275:16: warning: no previous prototype for ‘syscall_trace_enter’ [-Wmissing-prototypes]
      275 | asmlinkage int syscall_trace_enter(void)
	  |                ^~~~~~~~~~~~~~~~~~~
    arch/m68k/kernel/ptrace.c:288:17: warning: no previous prototype for ‘syscall_trace_leave’ [-Wmissing-prototypes]
      288 | asmlinkage void syscall_trace_leave(void)
	  |                 ^~~~~~~~~~~~~~~~~~~

Fix this by introducing a new header file "ptrace.h" for holding the
prototypes of functions implemented in arch/m68k/kernel/ptrace.c.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/kernel/ptrace.c | 2 ++
 arch/m68k/kernel/ptrace.h | 6 ++++++
 2 files changed, 8 insertions(+)
 create mode 100644 arch/m68k/kernel/ptrace.h

diff --git a/arch/m68k/kernel/ptrace.c b/arch/m68k/kernel/ptrace.c
index cd0172d294306d10..c20d590e429703e9 100644
--- a/arch/m68k/kernel/ptrace.c
+++ b/arch/m68k/kernel/ptrace.c
@@ -26,6 +26,8 @@
 #include <asm/page.h>
 #include <asm/processor.h>
 
+#include "ptrace.h"
+
 /*
  * does not yet catch signals sent when the child dies.
  * in exit.c or in signal.c.
diff --git a/arch/m68k/kernel/ptrace.h b/arch/m68k/kernel/ptrace.h
new file mode 100644
index 0000000000000000..77018037f10f9781
--- /dev/null
+++ b/arch/m68k/kernel/ptrace.h
@@ -0,0 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#include <linux/linkage.h>
+
+asmlinkage int syscall_trace_enter(void);
+asmlinkage void syscall_trace_leave(void);
-- 
2.34.1


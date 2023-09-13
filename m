Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463D979EA87
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241258AbjIMOJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241237AbjIMOIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:08:55 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711301BC8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:08:50 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:f674:9611:cd05:f25a])
        by andre.telenet-ops.be with bizsmtp
        id lS8m2A00L3fvA4V01S8mWi; Wed, 13 Sep 2023 16:08:48 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qgQXd-003crN-DB;
        Wed, 13 Sep 2023 16:08:46 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qgQXu-00FV3u-OU;
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
Subject: [PATCH v2 07/52] m68k: kernel: Add and use "ptrace.h"
Date:   Wed, 13 Sep 2023 16:07:57 +0200
Message-Id: <b4b3577b2149ebd65c3b3c7acccebc0e7e596f9d.1694613528.git.geert@linux-m68k.org>
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

    arch/m68k/kernel/ptrace.c:275:16: warning: no previous prototype for ‘syscall_trace_enter’ [-Wmissing-prototypes]
      275 | asmlinkage int syscall_trace_enter(void)
	  |                ^~~~~~~~~~~~~~~~~~~
    arch/m68k/kernel/ptrace.c:288:17: warning: no previous prototype for ‘syscall_trace_leave’ [-Wmissing-prototypes]
      288 | asmlinkage void syscall_trace_leave(void)
	  |                 ^~~~~~~~~~~~~~~~~~~

Fix this by introducing a new header file "ptrace.h" for holding the
prototypes of functions implemented in arch/m68k/kernel/ptrace.c.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
  - Add Acked-by.
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


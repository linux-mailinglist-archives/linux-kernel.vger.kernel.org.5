Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEE279EA98
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241387AbjIMOJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241276AbjIMOI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:08:56 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F87A1BE3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:08:50 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:f674:9611:cd05:f25a])
        by xavier.telenet-ops.be with bizsmtp
        id lS8m2A00g3fvA4V01S8m2a; Wed, 13 Sep 2023 16:08:48 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qgQXd-003crS-El;
        Wed, 13 Sep 2023 16:08:46 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qgQXu-00FV44-Q9;
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
Subject: [PATCH v2 09/52] m68k: kernel: Add and use "traps.h"
Date:   Wed, 13 Sep 2023 16:07:59 +0200
Message-Id: <652cbbb1c9e339980a86068ebdd0a69362324af8.1694613528.git.geert@linux-m68k.org>
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

    arch/m68k/kernel/traps.c:754:17: warning: no previous prototype for ‘buserr_c’ [-Wmissing-prototypes]
      754 | asmlinkage void buserr_c(struct frame *fp)
	  |                 ^~~~~~~~
    arch/m68k/kernel/traps.c:1140:17: warning: no previous prototype for ‘set_esp0’ [-Wmissing-prototypes]
     1140 | asmlinkage void set_esp0(unsigned long ssp)
	  |                 ^~~~~~~~
    arch/m68k/kernel/traps.c:1155:17: warning: no previous prototype for ‘fpemu_signal’ [-Wmissing-prototypes]
     1155 | asmlinkage void fpemu_signal(int signal, int code, void *addr)
	  |                 ^~~~~~~~~~~~
    arch/m68k/kernel/traps.c:1149:17: warning: no previous prototype for ‘fpsp040_die’ [-Wmissing-prototypes]
     1149 | asmlinkage void fpsp040_die(void)
	  |                 ^~~~~~~~~~~

Fix this by introducing a new header file "traps.h" for holding the
prototypes of functions implemented in arch/m68k/kernel/traps.c.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
  - Add Acked-by.
---
 arch/m68k/kernel/traps.c |  2 ++
 arch/m68k/kernel/traps.h | 10 ++++++++++
 2 files changed, 12 insertions(+)
 create mode 100644 arch/m68k/kernel/traps.h

diff --git a/arch/m68k/kernel/traps.c b/arch/m68k/kernel/traps.c
index b3fee39f8f518c6e..d408334712f7118b 100644
--- a/arch/m68k/kernel/traps.c
+++ b/arch/m68k/kernel/traps.c
@@ -41,6 +41,8 @@
 #include <asm/siginfo.h>
 #include <asm/tlbflush.h>
 
+#include "traps.h"
+
 static const char *vec_names[] = {
 	[VEC_RESETSP]	= "RESET SP",
 	[VEC_RESETPC]	= "RESET PC",
diff --git a/arch/m68k/kernel/traps.h b/arch/m68k/kernel/traps.h
new file mode 100644
index 0000000000000000..6414b4a0e5585671
--- /dev/null
+++ b/arch/m68k/kernel/traps.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#include <linux/linkage.h>
+
+struct frame;
+
+asmlinkage void buserr_c(struct frame *fp);
+asmlinkage void fpemu_signal(int signal, int code, void *addr);
+asmlinkage void fpsp040_die(void);
+asmlinkage void set_esp0(unsigned long ssp);
-- 
2.34.1


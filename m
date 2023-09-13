Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C06C79EA85
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241300AbjIMOI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241234AbjIMOIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:08:55 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710A41BC7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:08:50 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:f674:9611:cd05:f25a])
        by andre.telenet-ops.be with bizsmtp
        id lS8n2A0023fvA4V01S8nWk; Wed, 13 Sep 2023 16:08:48 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qgQXd-003crl-Hy;
        Wed, 13 Sep 2023 16:08:46 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qgQXu-00FV4N-TL;
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
Subject: [PATCH v2 13/52] m68k: mm: Add and use "fault.h"
Date:   Wed, 13 Sep 2023 16:08:03 +0200
Message-Id: <ef004b8cfe4aac892aa0fb7714c2ed81a02a9b89.1694613528.git.geert@linux-m68k.org>
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

    arch/m68k/mm/fault.c:22:5: warning: no previous prototype for ‘send_fault_sig’ [-Wmissing-prototypes]
       22 | int send_fault_sig(struct pt_regs *regs)
	  |     ^~~~~~~~~~~~~~
    arch/m68k/mm/fault.c:68:5: warning: no previous prototype for ‘do_page_fault’ [-Wmissing-prototypes]
       68 | int do_page_fault(struct pt_regs *regs, unsigned long address,
	  |     ^~~~~~~~~~~~~

Fix this by introducing a new header file "fault.h" for holding the
prototypes of functions implemented in arch/m68k/mm/fault.c.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
  - Add Acked-by.
---
 arch/m68k/kernel/sys_m68k.c | 3 +--
 arch/m68k/kernel/traps.c    | 5 +----
 arch/m68k/mm/fault.c        | 2 ++
 arch/m68k/mm/fault.h        | 7 +++++++
 4 files changed, 11 insertions(+), 6 deletions(-)
 create mode 100644 arch/m68k/mm/fault.h

diff --git a/arch/m68k/kernel/sys_m68k.c b/arch/m68k/kernel/sys_m68k.c
index 14055d676161d725..1af5e60824676bf3 100644
--- a/arch/m68k/kernel/sys_m68k.c
+++ b/arch/m68k/kernel/sys_m68k.c
@@ -35,8 +35,7 @@
 
 #include <asm/tlb.h>
 
-asmlinkage int do_page_fault(struct pt_regs *regs, unsigned long address,
-			     unsigned long error_code);
+#include "../mm/fault.h"
 
 asmlinkage long sys_mmap2(unsigned long addr, unsigned long len,
 	unsigned long prot, unsigned long flags,
diff --git a/arch/m68k/kernel/traps.c b/arch/m68k/kernel/traps.c
index d408334712f7118b..129c89349e1a40aa 100644
--- a/arch/m68k/kernel/traps.c
+++ b/arch/m68k/kernel/traps.c
@@ -42,6 +42,7 @@
 #include <asm/tlbflush.h>
 
 #include "traps.h"
+#include "../mm/fault.h"
 
 static const char *vec_names[] = {
 	[VEC_RESETSP]	= "RESET SP",
@@ -126,10 +127,6 @@ static const char *space_names[] = {
 };
 
 void die_if_kernel(char *,struct pt_regs *,int);
-asmlinkage int do_page_fault(struct pt_regs *regs, unsigned long address,
-                             unsigned long error_code);
-int send_fault_sig(struct pt_regs *regs);
-
 asmlinkage void trap_c(struct frame *fp);
 
 #if defined (CONFIG_M68060)
diff --git a/arch/m68k/mm/fault.c b/arch/m68k/mm/fault.c
index c290c5c0cfb93a81..fa3c5f38d9894c08 100644
--- a/arch/m68k/mm/fault.c
+++ b/arch/m68k/mm/fault.c
@@ -17,6 +17,8 @@
 #include <asm/setup.h>
 #include <asm/traps.h>
 
+#include "fault.h"
+
 extern void die_if_kernel(char *, struct pt_regs *, long);
 
 int send_fault_sig(struct pt_regs *regs)
diff --git a/arch/m68k/mm/fault.h b/arch/m68k/mm/fault.h
new file mode 100644
index 0000000000000000..dab14ef7d4a171d5
--- /dev/null
+++ b/arch/m68k/mm/fault.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+struct pt_regs;
+
+int do_page_fault(struct pt_regs *regs, unsigned long address,
+		  unsigned long error_code);
+int send_fault_sig(struct pt_regs *regs);
-- 
2.34.1


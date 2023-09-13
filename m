Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABD579EA90
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241318AbjIMOJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241242AbjIMOIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:08:55 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57401BCC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:08:50 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:f674:9611:cd05:f25a])
        by andre.telenet-ops.be with bizsmtp
        id lS8m2A00K3fvA4V01S8mWh; Wed, 13 Sep 2023 16:08:48 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qgQXd-003crA-AN;
        Wed, 13 Sep 2023 16:08:46 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qgQXu-00FV3f-L0;
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
Subject: [PATCH v2 04/52] m68k: kernel: Add and use <asm/syscalls.h>
Date:   Wed, 13 Sep 2023 16:07:54 +0200
Message-Id: <80b721eeb499562cd5d49887b0eee10dd172c88d.1694613528.git.geert@linux-m68k.org>
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

    arch/m68k/kernel/sys_m68k.c:40:17: warning: no previous prototype for ‘sys_mmap2’ [-Wmissing-prototypes]
       40 | asmlinkage long sys_mmap2(unsigned long addr, unsigned long len,
	  |                 ^~~~~~~~~
    arch/m68k/kernel/sys_m68k.c:378:1: warning: no previous prototype for ‘sys_cacheflush’ [-Wmissing-prototypes]
      378 | sys_cacheflush (unsigned long addr, int scope, int cache, unsigned long len)
	  | ^~~~~~~~~~~~~~
    arch/m68k/kernel/sys_m68k.c:463:1: warning: no previous prototype for ‘sys_atomic_cmpxchg_32’ [-Wmissing-prototypes]
      463 | sys_atomic_cmpxchg_32(unsigned long newval, int oldval, int d3, int d4, int d5,
	  | ^~~~~~~~~~~~~~~~~~~~~
    arch/m68k/kernel/sys_m68k.c:564:16: warning: no previous prototype for ‘sys_getpagesize’ [-Wmissing-prototypes]
      564 | asmlinkage int sys_getpagesize(void)
	  |                ^~~~~~~~~~~~~~~
    arch/m68k/kernel/sys_m68k.c:569:26: warning: no previous prototype for ‘sys_get_thread_area’ [-Wmissing-prototypes]
      569 | asmlinkage unsigned long sys_get_thread_area(void)
	  |                          ^~~~~~~~~~~~~~~~~~~
    arch/m68k/kernel/sys_m68k.c:574:16: warning: no previous prototype for ‘sys_set_thread_area’ [-Wmissing-prototypes]
      574 | asmlinkage int sys_set_thread_area(unsigned long tp)
	  |                ^~~~~~~~~~~~~~~~~~~
    arch/m68k/kernel/sys_m68k.c:580:16: warning: no previous prototype for ‘sys_atomic_barrier’ [-Wmissing-prototypes]
      580 | asmlinkage int sys_atomic_barrier(void)
	  |                ^~~~~~~~~~~~~~~~~~

Fix this by introducing a new header file <asm/syscalls.h> for holding
the prototypes for m68k-specific syscalls, and including the generic
ones.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
  - Add Acked-by.
---
 arch/m68k/include/asm/syscalls.h | 20 ++++++++++++++++++++
 arch/m68k/kernel/sys_m68k.c      |  1 +
 2 files changed, 21 insertions(+)
 create mode 100644 arch/m68k/include/asm/syscalls.h

diff --git a/arch/m68k/include/asm/syscalls.h b/arch/m68k/include/asm/syscalls.h
new file mode 100644
index 0000000000000000..6d814ffa2560105d
--- /dev/null
+++ b/arch/m68k/include/asm/syscalls.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_M68K_SYSCALLS_H
+#define _ASM_M68K_SYSCALLS_H
+
+#include <linux/compiler_types.h>
+#include <linux/linkage.h>
+
+asmlinkage int sys_cacheflush(unsigned long addr, int scope, int cache,
+			      unsigned long len);
+asmlinkage int sys_atomic_cmpxchg_32(unsigned long newval, int oldval, int d3,
+				     int d4, int d5, unsigned long __user *mem);
+asmlinkage int sys_getpagesize(void);
+asmlinkage unsigned long sys_get_thread_area(void);
+asmlinkage int sys_set_thread_area(unsigned long tp);
+asmlinkage int sys_atomic_barrier(void);
+
+#include <asm-generic/syscalls.h>
+
+#endif	/* _ASM_M68K_SYSCALLS_H */
+
diff --git a/arch/m68k/kernel/sys_m68k.c b/arch/m68k/kernel/sys_m68k.c
index c586034d2a7ac85d..14055d676161d725 100644
--- a/arch/m68k/kernel/sys_m68k.c
+++ b/arch/m68k/kernel/sys_m68k.c
@@ -27,6 +27,7 @@
 #include <asm/cachectl.h>
 #include <asm/traps.h>
 #include <asm/page.h>
+#include <asm/syscalls.h>
 #include <asm/unistd.h>
 #include <asm/cacheflush.h>
 
-- 
2.34.1


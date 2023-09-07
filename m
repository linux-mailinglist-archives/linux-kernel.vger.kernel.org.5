Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7BC797AED
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245504AbjIGR6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343509AbjIGR57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:57:59 -0400
Received: from gauss.telenet-ops.be (gauss.telenet-ops.be [195.130.132.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085681FEA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:57:33 -0700 (PDT)
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by gauss.telenet-ops.be (Postfix) with ESMTPS id 4RhL6D02hwz4x5K6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 15:43:00 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:c214:2eac:128d:f67e])
        by laurent.telenet-ops.be with bizsmtp
        id j1hx2A0072mGBSJ011hxtd; Thu, 07 Sep 2023 15:41:59 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGQ-002m7x-1Z;
        Thu, 07 Sep 2023 15:41:57 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGf-00CMfK-9u;
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
Subject: [PATCH 04/52] m68k: kernel: Add and use <asm/syscalls.h>
Date:   Thu,  7 Sep 2023 15:41:05 +0200
Message-Id: <a7b22e7cf2c22933774a93bb5d8ca5de9a27ac37.1694093327.git.geert@linux-m68k.org>
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


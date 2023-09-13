Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073DA79EA9E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241478AbjIMOKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241397AbjIMOJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:09:32 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C951BFE
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:08:52 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:f674:9611:cd05:f25a])
        by albert.telenet-ops.be with bizsmtp
        id lS8n2A00R3fvA4V06S8n4D; Wed, 13 Sep 2023 16:08:48 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qgQXe-003ctB-6W;
        Wed, 13 Sep 2023 16:08:47 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qgQXv-00FV6A-HL;
        Wed, 13 Sep 2023 16:08:47 +0200
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
Subject: [PATCH v2 35/52] m68k: mvme16x: Add and use "mvme16x.h"
Date:   Wed, 13 Sep 2023 16:08:25 +0200
Message-Id: <6200cc3b26fad215c4524748af04692e38c5ecd2.1694613528.git.geert@linux-m68k.org>
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

    arch/m68k/mvme16x/config.c:208:6: warning: no previous prototype for ‘mvme16x_cons_write’ [-Wmissing-prototypes]
      208 | void mvme16x_cons_write(struct console *co, const char *str, unsigned count)
	  |      ^~~~~~~~~~~~~~~~~~

Fix this by introducing a new header file "mvme16x.h" for holding the
prototypes of functions implemented in arch/m68k/mvme16x/.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
  - Add Acked-by.
---
 arch/m68k/kernel/early_printk.c | 4 ++--
 arch/m68k/mvme16x/config.c      | 2 ++
 arch/m68k/mvme16x/mvme16x.h     | 6 ++++++
 3 files changed, 10 insertions(+), 2 deletions(-)
 create mode 100644 arch/m68k/mvme16x/mvme16x.h

diff --git a/arch/m68k/kernel/early_printk.c b/arch/m68k/kernel/early_printk.c
index 7d3fe08a48eb0319..3cc944df04f65ef1 100644
--- a/arch/m68k/kernel/early_printk.c
+++ b/arch/m68k/kernel/early_printk.c
@@ -12,8 +12,8 @@
 #include <linux/string.h>
 #include <asm/setup.h>
 
-extern void mvme16x_cons_write(struct console *co,
-			       const char *str, unsigned count);
+
+#include "../mvme16x/mvme16x.h"
 
 asmlinkage void __init debug_cons_nputs(const char *s, unsigned n);
 
diff --git a/arch/m68k/mvme16x/config.c b/arch/m68k/mvme16x/config.c
index b6833862ea6b1530..9bb9a33e43c246c4 100644
--- a/arch/m68k/mvme16x/config.c
+++ b/arch/m68k/mvme16x/config.c
@@ -38,6 +38,8 @@
 #include <asm/mvme16xhw.h>
 #include <asm/config.h>
 
+#include "mvme16x.h"
+
 extern t_bdid mvme_bdid;
 
 static MK48T08ptr_t volatile rtc = (MK48T08ptr_t)MVME_RTC_BASE;
diff --git a/arch/m68k/mvme16x/mvme16x.h b/arch/m68k/mvme16x/mvme16x.h
new file mode 100644
index 0000000000000000..159c34b700394116
--- /dev/null
+++ b/arch/m68k/mvme16x/mvme16x.h
@@ -0,0 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+struct console;
+
+/* config.c */
+void mvme16x_cons_write(struct console *co, const char *str, unsigned count);
-- 
2.34.1


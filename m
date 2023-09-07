Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2577977F9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241859AbjIGQiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244407AbjIGQiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:38:24 -0400
Received: from cantor.telenet-ops.be (cantor.telenet-ops.be [IPv6:2a02:1800:120:4::f00:10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90D044A7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:14:50 -0700 (PDT)
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by cantor.telenet-ops.be (Postfix) with ESMTPS id 4RhL6D05Ttz4xVNm
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 15:43:00 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:c214:2eac:128d:f67e])
        by laurent.telenet-ops.be with bizsmtp
        id j1hx2A00F2mGBSJ011hxtg; Thu, 07 Sep 2023 15:41:59 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGQ-002m8o-Db;
        Thu, 07 Sep 2023 15:41:57 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGf-00CMgN-Lh;
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
Subject: [PATCH 17/52] m68k: amiga: Add and use "amiga.h"
Date:   Thu,  7 Sep 2023 15:41:18 +0200
Message-Id: <167b484b2e2f73a23768f94fdc7b2dce91aed5d5.1694093327.git.geert@linux-m68k.org>
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

    arch/m68k/amiga/amisound.c:48:13: warning: no previous prototype for ‘amiga_init_sound’ [-Wmissing-prototypes]
       48 | void __init amiga_init_sound(void)
	  |             ^~~~~~~~~~~~~~~~
    arch/m68k/amiga/amisound.c:71:6: warning: no previous prototype for ‘amiga_mksound’ [-Wmissing-prototypes]
       71 | void amiga_mksound( unsigned int hz, unsigned int ticks )
	  |      ^~~~~~~~~~~~~

Fix this by introducing a new header file "amiga.h" for holding the
prototypes of functions implemented in arch/m68k/amiga/.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/amiga/amiga.h    | 5 +++++
 arch/m68k/amiga/amisound.c | 2 ++
 arch/m68k/amiga/config.c   | 4 ++--
 3 files changed, 9 insertions(+), 2 deletions(-)
 create mode 100644 arch/m68k/amiga/amiga.h

diff --git a/arch/m68k/amiga/amiga.h b/arch/m68k/amiga/amiga.h
new file mode 100644
index 0000000000000000..00392781442cb91a
--- /dev/null
+++ b/arch/m68k/amiga/amiga.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/* amisound.c */
+void amiga_init_sound(void);
+void amiga_mksound(unsigned int hz, unsigned int ticks);
diff --git a/arch/m68k/amiga/amisound.c b/arch/m68k/amiga/amisound.c
index 442bdeee6bd7920c..714fe8ec6afa3364 100644
--- a/arch/m68k/amiga/amisound.c
+++ b/arch/m68k/amiga/amisound.c
@@ -16,6 +16,8 @@
 
 #include <asm/amigahw.h>
 
+#include "amiga.h"
+
 static unsigned short *snd_data;
 static const signed char sine_data[] = {
 	0,  39,  75,  103,  121,  127,  121,  103,  75,  39,
diff --git a/arch/m68k/amiga/config.c b/arch/m68k/amiga/config.c
index 3137b45750dfcea7..7791673e547bf795 100644
--- a/arch/m68k/amiga/config.c
+++ b/arch/m68k/amiga/config.c
@@ -39,6 +39,8 @@
 #include <asm/io.h>
 #include <asm/config.h>
 
+#include "amiga.h"
+
 static unsigned long amiga_model;
 
 unsigned long amiga_eclock;
@@ -96,9 +98,7 @@ static char amiga_model_name[13] = "Amiga ";
 static void amiga_sched_init(void);
 static void amiga_get_model(char *model);
 static void amiga_get_hardware_list(struct seq_file *m);
-extern void amiga_mksound(unsigned int count, unsigned int ticks);
 static void amiga_reset(void);
-extern void amiga_init_sound(void);
 static void amiga_mem_console_write(struct console *co, const char *b,
 				    unsigned int count);
 #ifdef CONFIG_HEARTBEAT
-- 
2.34.1


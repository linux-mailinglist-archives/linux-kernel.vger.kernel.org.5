Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964AE7973FB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344064AbjIGPcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343609AbjIGPah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:30:37 -0400
X-Greylist: delayed 146 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Sep 2023 08:30:10 PDT
Received: from weierstrass.telenet-ops.be (weierstrass.telenet-ops.be [195.130.137.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D933D1BF6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:30:10 -0700 (PDT)
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by weierstrass.telenet-ops.be (Postfix) with ESMTPS id 4RhL534R3Sz4x0lQ
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 15:41:59 +0200 (CEST)
Received: from ramsan.of.borg ([84.195.187.55])
        by laurent.telenet-ops.be with bizsmtp
        id j1hy2A0031C8whw011hyto; Thu, 07 Sep 2023 15:41:59 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGQ-002m95-I9;
        Thu, 07 Sep 2023 15:41:57 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGf-00CMgm-QR;
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
Subject: [PATCH 22/52] m68k: atari: Add and use "atari.h"
Date:   Thu,  7 Sep 2023 15:41:23 +0200
Message-Id: <0778d9dd186928666d760d5523c7d2311f781621.1694093327.git.geert@linux-m68k.org>
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

    arch/m68k/atari/time.c:59:1: warning: no previous prototype for ‘atari_sched_init’ [-Wmissing-prototypes]
       59 | atari_sched_init(void)
	  | ^~~~~~~~~~~~~~~~
    arch/m68k/atari/time.c:140:5: warning: no previous prototype for ‘atari_mste_hwclk’ [-Wmissing-prototypes]
      140 | int atari_mste_hwclk( int op, struct rtc_time *t )
	  |     ^~~~~~~~~~~~~~~~
    arch/m68k/atari/time.c:199:5: warning: no previous prototype for ‘atari_tt_hwclk’ [-Wmissing-prototypes]
      199 | int atari_tt_hwclk( int op, struct rtc_time *t )
	  |     ^~~~~~~~~~~~~~
    arch/m68k/atari/ataints.c:267:13: warning: no previous prototype for ‘atari_init_IRQ’ [-Wmissing-prototypes]
      267 | void __init atari_init_IRQ(void)
	  |             ^~~~~~~~~~~~~~
    arch/m68k/atari/atasound.c:36:6: warning: no previous prototype for ‘atari_microwire_cmd’ [-Wmissing-prototypes]
       36 | void atari_microwire_cmd (int cmd)
	  |      ^~~~~~~~~~~~~~~~~~~
    arch/m68k/atari/atasound.c:53:6: warning: no previous prototype for ‘atari_mksound’ [-Wmissing-prototypes]
       53 | void atari_mksound (unsigned int hz, unsigned int ticks)
	  |      ^~~~~~~~~~~~~

Fix this by introducing a new header file "atari.h" for holding the
prototypes of functions implemented in arch/m68k/atari/.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/atari/ataints.c  |  3 +--
 arch/m68k/atari/atari.h    | 15 +++++++++++++++
 arch/m68k/atari/atasound.c |  1 +
 arch/m68k/atari/config.c   | 11 ++---------
 arch/m68k/atari/time.c     |  2 ++
 5 files changed, 21 insertions(+), 11 deletions(-)
 create mode 100644 arch/m68k/atari/atari.h

diff --git a/arch/m68k/atari/ataints.c b/arch/m68k/atari/ataints.c
index 56f02ea2c248d844..23256434191c39af 100644
--- a/arch/m68k/atari/ataints.c
+++ b/arch/m68k/atari/ataints.c
@@ -52,6 +52,7 @@
 #include <asm/entry.h>
 #include <asm/io.h>
 
+#include "atari.h"
 
 /*
  * Atari interrupt handling scheme:
@@ -81,8 +82,6 @@ __ALIGN_STR "\n\t"
 	"orw	#0x200,%sp@\n\t"	/* set saved ipl to 2 */
 	"rte");
 
-extern void atari_microwire_cmd(int cmd);
-
 static unsigned int atari_irq_startup(struct irq_data *data)
 {
 	unsigned int irq = data->irq;
diff --git a/arch/m68k/atari/atari.h b/arch/m68k/atari/atari.h
new file mode 100644
index 0000000000000000..494a03ddac3d16ae
--- /dev/null
+++ b/arch/m68k/atari/atari.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+struct rtc_time;
+
+/* ataints.c */
+void atari_init_IRQ(void);
+
+/* atasound.c */
+void atari_microwire_cmd(int cmd);
+void atari_mksound(unsigned int hz, unsigned int ticks);
+
+/* time.c */
+void atari_sched_init(void);
+int atari_mste_hwclk(int op, struct rtc_time *t);
+int atari_tt_hwclk(int op, struct rtc_time *t);
diff --git a/arch/m68k/atari/atasound.c b/arch/m68k/atari/atasound.c
index a8724d998c39fcfa..c38ef0e6078e7260 100644
--- a/arch/m68k/atari/atasound.c
+++ b/arch/m68k/atari/atasound.c
@@ -28,6 +28,7 @@
 #include <asm/irq.h>
 #include <asm/atariints.h>
 
+#include "atari.h"
 
 /*
  * stuff from the old atasound.c
diff --git a/arch/m68k/atari/config.c b/arch/m68k/atari/config.c
index b4fe4273ad912ebe..b48a0606a00068b9 100644
--- a/arch/m68k/atari/config.c
+++ b/arch/m68k/atari/config.c
@@ -48,6 +48,8 @@
 #include <asm/io.h>
 #include <asm/config.h>
 
+#include "atari.h"
+
 u_long atari_mch_cookie;
 EXPORT_SYMBOL(atari_mch_cookie);
 
@@ -69,19 +71,10 @@ int atari_rtc_year_offset;
 static void atari_reset(void);
 static void atari_get_model(char *model);
 static void atari_get_hardware_list(struct seq_file *m);
-
-/* atari specific irq functions */
-extern void atari_init_IRQ (void);
-extern void atari_mksound(unsigned int count, unsigned int ticks);
 #ifdef CONFIG_HEARTBEAT
 static void atari_heartbeat(int on);
 #endif
 
-/* atari specific timer functions (in time.c) */
-extern void atari_sched_init(void);
-extern int atari_mste_hwclk (int, struct rtc_time *);
-extern int atari_tt_hwclk (int, struct rtc_time *);
-
 /* ++roman: This is a more elaborate test for an SCC chip, since the plain
  * Medusa board generates DTACK at the SCC's standard addresses, but a SCC
  * board in the Medusa is possible. Also, the addresses where the ST_ESCC
diff --git a/arch/m68k/atari/time.c b/arch/m68k/atari/time.c
index 7e44d0e9d0f8a902..3453c6dc6b41d3c9 100644
--- a/arch/m68k/atari/time.c
+++ b/arch/m68k/atari/time.c
@@ -23,6 +23,8 @@
 #include <asm/atariints.h>
 #include <asm/machdep.h>
 
+#include "atari.h"
+
 DEFINE_SPINLOCK(rtc_lock);
 EXPORT_SYMBOL_GPL(rtc_lock);
 
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50C2797687
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjIGQMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238054AbjIGQLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:11:47 -0400
X-Greylist: delayed 1775 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Sep 2023 09:08:36 PDT
Received: from gauss.telenet-ops.be (gauss.telenet-ops.be [IPv6:2a02:1800:120:4::f00:11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D3830EA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:08:36 -0700 (PDT)
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by gauss.telenet-ops.be (Postfix) with ESMTPS id 4RhL534qBKz4x6x5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 15:41:59 +0200 (CEST)
Received: from ramsan.of.borg ([84.195.187.55])
        by michel.telenet-ops.be with bizsmtp
        id j1hy2A00n1C8whw061hyuv; Thu, 07 Sep 2023 15:41:59 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGQ-002mA1-T2;
        Thu, 07 Sep 2023 15:41:58 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGg-00CMhu-51;
        Thu, 07 Sep 2023 15:41:58 +0200
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
Subject: [PATCH 36/52] m68k: q40: Add and use "q40.h"
Date:   Thu,  7 Sep 2023 15:41:37 +0200
Message-Id: <16313fd669800e0e53d5aacdabd2405d6d4c99b1.1694093327.git.geert@linux-m68k.org>
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

    arch/m68k/q40/q40ints.c:84:13: warning: no previous prototype for ‘q40_init_IRQ’ [-Wmissing-prototypes]
       84 | void __init q40_init_IRQ(void)
	  |             ^~~~~~~~~~~~
    arch/m68k/q40/q40ints.c:112:6: warning: no previous prototype for ‘q40_mksound’ [-Wmissing-prototypes]
      112 | void q40_mksound(unsigned int hz, unsigned int ticks)
	  |      ^~~~~~~~~~~
    arch/m68k/q40/q40ints.c:152:6: warning: no previous prototype for ‘q40_sched_init’ [-Wmissing-prototypes]
      152 | void q40_sched_init (void)
	  |      ^~~~~~~~~~~~~~

Fix this by introducing a new header file "q40.h" for holding the
prototypes of functions implemented in arch/m68k/q40/.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/q40/config.c  | 6 ++----
 arch/m68k/q40/q40.h     | 6 ++++++
 arch/m68k/q40/q40ints.c | 2 ++
 3 files changed, 10 insertions(+), 4 deletions(-)
 create mode 100644 arch/m68k/q40/q40.h

diff --git a/arch/m68k/q40/config.c b/arch/m68k/q40/config.c
index c78ee709b45879c7..2c51c2b4a4fbbf79 100644
--- a/arch/m68k/q40/config.c
+++ b/arch/m68k/q40/config.c
@@ -36,16 +36,14 @@
 #include <asm/q40_master.h>
 #include <asm/config.h>
 
-extern void q40_init_IRQ(void);
+#include "q40.h"
+
 static void q40_get_model(char *model);
-extern void q40_sched_init(void);
 
 static int q40_hwclk(int, struct rtc_time *);
 static int q40_get_rtc_pll(struct rtc_pll_info *pll);
 static int q40_set_rtc_pll(struct rtc_pll_info *pll);
 
-extern void q40_mksound(unsigned int /*freq*/, unsigned int /*ticks*/);
-
 static void q40_mem_console_write(struct console *co, const char *b,
 				  unsigned int count);
 
diff --git a/arch/m68k/q40/q40.h b/arch/m68k/q40/q40.h
new file mode 100644
index 0000000000000000..3146679bde0dab97
--- /dev/null
+++ b/arch/m68k/q40/q40.h
@@ -0,0 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/* q40ints.c */
+void q40_init_IRQ(void);
+void q40_mksound(unsigned int hz, unsigned int ticks);
+void q40_sched_init(void);
diff --git a/arch/m68k/q40/q40ints.c b/arch/m68k/q40/q40ints.c
index 127d7ecdbd49ecd9..10f1f294e91f9705 100644
--- a/arch/m68k/q40/q40ints.c
+++ b/arch/m68k/q40/q40ints.c
@@ -24,6 +24,8 @@
 #include <asm/q40_master.h>
 #include <asm/q40ints.h>
 
+#include "q40.h"
+
 /*
  * Q40 IRQs are defined as follows:
  *            3,4,5,6,7,10,11,14,15 : ISA dev IRQs
-- 
2.34.1


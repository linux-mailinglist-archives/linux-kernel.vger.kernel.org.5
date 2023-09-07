Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA29797A2F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244000AbjIGRdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245157AbjIGRdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:33:08 -0400
Received: from riemann.telenet-ops.be (riemann.telenet-ops.be [IPv6:2a02:1800:110:4::f00:10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CCC199A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:32:42 -0700 (PDT)
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by riemann.telenet-ops.be (Postfix) with ESMTPS id 4RhL6D06zhz4x203
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 15:43:00 +0200 (CEST)
Received: from ramsan.of.borg ([84.195.187.55])
        by michel.telenet-ops.be with bizsmtp
        id j1hy2A00Y1C8whw061hyul; Thu, 07 Sep 2023 15:41:59 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGQ-002m9l-Q4;
        Thu, 07 Sep 2023 15:41:58 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGg-00CMhZ-27;
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
Subject: [PATCH 32/52] m68k: mac: Add and use "mac.h"
Date:   Thu,  7 Sep 2023 15:41:33 +0200
Message-Id: <e9f3da9b152b7d19b64d775d04e9e11b63dc35b6.1694093327.git.geert@linux-m68k.org>
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

    arch/m68k/mac/iop.c:235:13: warning: no previous prototype for ‘iop_init’ [-Wmissing-prototypes]
      235 | void __init iop_init(void)
	  |             ^~~~~~~~
    arch/m68k/mac/via.c:112:13: warning: no previous prototype for ‘via_init’ [-Wmissing-prototypes]
      111 | void __init via_init(void)
	  |             ^~~~~~~~
    arch/m68k/mac/via.c:623:13: warning: no previous prototype for ‘via_init_clock’ [-Wmissing-prototypes]
      593 | void __init via_init_clock(void)
	  |             ^~~~~~~~~~~~~~
    arch/m68k/mac/oss.c:37:13: warning: no previous prototype for ‘oss_init’ [-Wmissing-prototypes]
       37 | void __init oss_init(void)
	  |             ^~~~~~~~
    arch/m68k/mac/psc.c:76:13: warning: no previous prototype for ‘psc_init’ [-Wmissing-prototypes]
       76 | void __init psc_init(void)
	  |             ^~~~~~~~
    arch/m68k/mac/baboon.c:25:13: warning: no previous prototype for ‘baboon_init’ [-Wmissing-prototypes]
       25 | void __init baboon_init(void)
	  |             ^~~~~~~~~~~
    arch/m68k/mac/macboing.c:155:6: warning: no previous prototype for ‘mac_mksound’ [-Wmissing-prototypes]
      155 | void mac_mksound( unsigned int freq, unsigned int length )
	  |      ^~~~~~~~~~~
    arch/m68k/mac/misc.c:608:5: warning: no previous prototype for ‘mac_hwclk’ [-Wmissing-prototypes]
      608 | int mac_hwclk(int op, struct rtc_time *t)
	  |     ^~~~~~~~~

Fix this by introducing a new header file "mac.h" for holding the
prototypes of functions implemented in arch/m68k/mac/.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/mac/baboon.c   |  2 ++
 arch/m68k/mac/config.c   | 12 ++----------
 arch/m68k/mac/iop.c      |  2 ++
 arch/m68k/mac/mac.h      | 25 +++++++++++++++++++++++++
 arch/m68k/mac/macboing.c |  2 ++
 arch/m68k/mac/misc.c     |  2 ++
 arch/m68k/mac/oss.c      |  2 ++
 arch/m68k/mac/psc.c      |  2 ++
 arch/m68k/mac/via.c      |  2 ++
 9 files changed, 41 insertions(+), 10 deletions(-)
 create mode 100644 arch/m68k/mac/mac.h

diff --git a/arch/m68k/mac/baboon.c b/arch/m68k/mac/baboon.c
index a7d280220662c747..5c97a7058bcdee2e 100644
--- a/arch/m68k/mac/baboon.c
+++ b/arch/m68k/mac/baboon.c
@@ -15,6 +15,8 @@
 #include <asm/macints.h>
 #include <asm/mac_baboon.h>
 
+#include "mac.h"
+
 int baboon_present;
 static volatile struct baboon *baboon;
 
diff --git a/arch/m68k/mac/config.c b/arch/m68k/mac/config.c
index d56affefd5cabeb5..e324410ef239c09f 100644
--- a/arch/m68k/mac/config.c
+++ b/arch/m68k/mac/config.c
@@ -50,22 +50,14 @@
 #include <asm/mac_psc.h>
 #include <asm/config.h>
 
+#include "mac.h"
+
 /* Mac bootinfo struct */
 struct mac_booter_data mac_bi_data;
 
 /* The phys. video addr. - might be bogus on some machines */
 static unsigned long mac_orig_videoaddr;
 
-extern int mac_hwclk(int, struct rtc_time *);
-extern void iop_init(void);
-extern void via_init(void);
-extern void via_init_clock(void);
-extern void oss_init(void);
-extern void psc_init(void);
-extern void baboon_init(void);
-
-extern void mac_mksound(unsigned int, unsigned int);
-
 static void mac_get_model(char *str);
 static void mac_identify(void);
 static void mac_report_hardware(void);
diff --git a/arch/m68k/mac/iop.c b/arch/m68k/mac/iop.c
index 010b3b5ae8e8584a..a92740d530ac4fbe 100644
--- a/arch/m68k/mac/iop.c
+++ b/arch/m68k/mac/iop.c
@@ -119,6 +119,8 @@
 #include <asm/macints.h>
 #include <asm/mac_iop.h>
 
+#include "mac.h"
+
 #ifdef DEBUG
 #define iop_pr_debug(fmt, ...) \
 	printk(KERN_DEBUG "%s: " fmt, __func__, ##__VA_ARGS__)
diff --git a/arch/m68k/mac/mac.h b/arch/m68k/mac/mac.h
new file mode 100644
index 0000000000000000..d3d142cea3b4b911
--- /dev/null
+++ b/arch/m68k/mac/mac.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+struct rtc_time;
+
+/* baboon.c */
+void baboon_init(void);
+
+/* iop.c */
+void iop_init(void);
+
+/* misc.c */
+int mac_hwclk(int op, struct rtc_time *t);
+
+/* macboing.c */
+void mac_mksound(unsigned int freq, unsigned int length);
+
+/* oss.c */
+void oss_init(void);
+
+/* psc.c */
+void psc_init(void);
+
+/* via.c */
+void via_init(void);
+void via_init_clock(void);
diff --git a/arch/m68k/mac/macboing.c b/arch/m68k/mac/macboing.c
index 76431241347682fc..faea2265a540192d 100644
--- a/arch/m68k/mac/macboing.c
+++ b/arch/m68k/mac/macboing.c
@@ -16,6 +16,8 @@
 #include <asm/macintosh.h>
 #include <asm/mac_asc.h>
 
+#include "mac.h"
+
 static int mac_asc_inited;
 /*
  * dumb triangular wave table
diff --git a/arch/m68k/mac/misc.c b/arch/m68k/mac/misc.c
index 65107abc8848232c..4c8f8cbfa05f3404 100644
--- a/arch/m68k/mac/misc.c
+++ b/arch/m68k/mac/misc.c
@@ -25,6 +25,8 @@
 
 #include <asm/machdep.h>
 
+#include "mac.h"
+
 /*
  * Offset between Unix time (1970-based) and Mac time (1904-based). Cuda and PMU
  * times wrap in 2040. If we need to handle later times, the read_time functions
diff --git a/arch/m68k/mac/oss.c b/arch/m68k/mac/oss.c
index 921e6c092f2c6626..1641607f300d981c 100644
--- a/arch/m68k/mac/oss.c
+++ b/arch/m68k/mac/oss.c
@@ -27,6 +27,8 @@
 #include <asm/mac_via.h>
 #include <asm/mac_oss.h>
 
+#include "mac.h"
+
 int oss_present;
 volatile struct mac_oss *oss;
 
diff --git a/arch/m68k/mac/psc.c b/arch/m68k/mac/psc.c
index 0d0965b19c09b439..b4183cf66efef7f5 100644
--- a/arch/m68k/mac/psc.c
+++ b/arch/m68k/mac/psc.c
@@ -26,6 +26,8 @@
 #include <asm/macints.h>
 #include <asm/mac_psc.h>
 
+#include "mac.h"
+
 #define DEBUG_PSC
 
 volatile __u8 *psc;
diff --git a/arch/m68k/mac/via.c b/arch/m68k/mac/via.c
index 3d11d6219cdd56da..01e6b0e37f8dd0e8 100644
--- a/arch/m68k/mac/via.c
+++ b/arch/m68k/mac/via.c
@@ -38,6 +38,8 @@
 #include <asm/mac_psc.h>
 #include <asm/mac_oss.h>
 
+#include "mac.h"
+
 volatile __u8 *via1, *via2;
 int rbv_present;
 int via_alt_mapping;
-- 
2.34.1


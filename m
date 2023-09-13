Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6ADF79EA99
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241338AbjIMOJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241246AbjIMOIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:08:55 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547431BCE
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:08:50 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:f674:9611:cd05:f25a])
        by baptiste.telenet-ops.be with bizsmtp
        id lS8n2A00E3fvA4V01S8nqH; Wed, 13 Sep 2023 16:08:48 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qgQXd-003csZ-Tn;
        Wed, 13 Sep 2023 16:08:47 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qgQXv-00FV5R-88;
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
Subject: [PATCH v2 26/52] m68k: apollo: Add and use "apollo.h"
Date:   Wed, 13 Sep 2023 16:08:16 +0200
Message-Id: <d78eceb83b8dd1931be1789204898060664e23f6.1694613528.git.geert@linux-m68k.org>
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

    arch/m68k/apollo/dn_ints.c:43:13: warning: no previous prototype for ‘dn_init_IRQ’ [-Wmissing-prototypes]
       43 | void __init dn_init_IRQ(void)
	  |             ^~~~~~~~~~~

Fix this by introducing a new header file "apollo.h" for holding the
prototypes of functions implemented in arch/m68k/apollo/.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
  - Add Acked-by.
---
 arch/m68k/apollo/apollo.h  | 4 ++++
 arch/m68k/apollo/config.c  | 3 ++-
 arch/m68k/apollo/dn_ints.c | 2 ++
 3 files changed, 8 insertions(+), 1 deletion(-)
 create mode 100644 arch/m68k/apollo/apollo.h

diff --git a/arch/m68k/apollo/apollo.h b/arch/m68k/apollo/apollo.h
new file mode 100644
index 0000000000000000..1fe9d856df30354c
--- /dev/null
+++ b/arch/m68k/apollo/apollo.h
@@ -0,0 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/* dn_ints.c */
+void dn_init_IRQ(void);
diff --git a/arch/m68k/apollo/config.c b/arch/m68k/apollo/config.c
index 7afefb0191504d4e..e161ecd76035862d 100644
--- a/arch/m68k/apollo/config.c
+++ b/arch/m68k/apollo/config.c
@@ -17,6 +17,8 @@
 #include <asm/machdep.h>
 #include <asm/config.h>
 
+#include "apollo.h"
+
 u_long sio01_physaddr;
 u_long sio23_physaddr;
 u_long rtc_physaddr;
@@ -27,7 +29,6 @@ u_long timer_physaddr;
 u_long apollo_model;
 
 extern void dn_sched_init(void);
-extern void dn_init_IRQ(void);
 extern int dn_dummy_hwclk(int, struct rtc_time *);
 static void dn_dummy_reset(void);
 #ifdef CONFIG_HEARTBEAT
diff --git a/arch/m68k/apollo/dn_ints.c b/arch/m68k/apollo/dn_ints.c
index d97251fe0ab83045..ba96a92f8f18f00a 100644
--- a/arch/m68k/apollo/dn_ints.c
+++ b/arch/m68k/apollo/dn_ints.c
@@ -5,6 +5,8 @@
 #include <asm/traps.h>
 #include <asm/apollohw.h>
 
+#include "apollo.h"
+
 static unsigned int apollo_irq_startup(struct irq_data *data)
 {
 	unsigned int irq = data->irq;
-- 
2.34.1


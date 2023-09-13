Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5A979EAAA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241671AbjIMOKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241454AbjIMOJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:09:48 -0400
Received: from riemann.telenet-ops.be (riemann.telenet-ops.be [IPv6:2a02:1800:110:4::f00:10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B7D2106
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:08:53 -0700 (PDT)
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by riemann.telenet-ops.be (Postfix) with ESMTPS id 4Rm2PF72hfz4x2wC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 16:08:49 +0200 (CEST)
Received: from ramsan.of.borg ([84.195.187.55])
        by andre.telenet-ops.be with bizsmtp
        id lS8o2A00R1C8whw01S8oWy; Wed, 13 Sep 2023 16:08:49 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qgQXd-003csT-RF;
        Wed, 13 Sep 2023 16:08:47 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qgQXv-00FV5H-6K;
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
Subject: [PATCH v2 24/52] m68k: apollo: Make local reset, serial, and irq functions static
Date:   Wed, 13 Sep 2023 16:08:14 +0200
Message-Id: <d2b3a6785d3e80069fea85921c72cf0b7afb8493.1694613528.git.geert@linux-m68k.org>
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

    arch/m68k/apollo/config.c:132:6: warning: no previous prototype for ‘dn_serial_print’ [-Wmissing-prototypes]
      110 | void dn_serial_print (const char *str)
	  |      ^~~~~~~~~~~~~~~
    arch/m68k/apollo/dn_ints.c:8:14: warning: no previous prototype for ‘apollo_irq_startup’ [-Wmissing-prototypes]
	8 | unsigned int apollo_irq_startup(struct irq_data *data)
	  |              ^~~~~~~~~~~~~~~~~~
    arch/m68k/apollo/dn_ints.c:19:6: warning: no previous prototype for ‘apollo_irq_shutdown’ [-Wmissing-prototypes]
       19 | void apollo_irq_shutdown(struct irq_data *data)
	  |      ^~~~~~~~~~~~~~~~~~~
    arch/m68k/apollo/dn_ints.c:29:6: warning: no previous prototype for ‘apollo_irq_eoi’ [-Wmissing-prototypes]
       29 | void apollo_irq_eoi(struct irq_data *data)
	  |      ^~~~~~~~~~~~~~

Fix this by making all local functions static.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
  - Add Acked-by.
---
 arch/m68k/apollo/config.c  | 8 ++++----
 arch/m68k/apollo/dn_ints.c | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/m68k/apollo/config.c b/arch/m68k/apollo/config.c
index fccbb40772dca6b9..0e6801eecbaf6361 100644
--- a/arch/m68k/apollo/config.c
+++ b/arch/m68k/apollo/config.c
@@ -29,7 +29,7 @@ u_long apollo_model;
 extern void dn_sched_init(void);
 extern void dn_init_IRQ(void);
 extern int dn_dummy_hwclk(int, struct rtc_time *);
-extern void dn_dummy_reset(void);
+static void dn_dummy_reset(void);
 #ifdef CONFIG_HEARTBEAT
 static void dn_heartbeat(int on);
 #endif
@@ -107,7 +107,7 @@ static void __init dn_setup_model(void)
 
 }
 
-void dn_serial_print (const char *str)
+static void dn_serial_print(const char *str)
 {
     while (*str) {
         if (*str == '\n') {
@@ -207,8 +207,8 @@ int dn_dummy_hwclk(int op, struct rtc_time *t) {
 
 }
 
-void dn_dummy_reset(void) {
-
+static void dn_dummy_reset(void)
+{
   dn_serial_print("The end !\n");
 
   for(;;);
diff --git a/arch/m68k/apollo/dn_ints.c b/arch/m68k/apollo/dn_ints.c
index 02cff7efc8342aa6..d97251fe0ab83045 100644
--- a/arch/m68k/apollo/dn_ints.c
+++ b/arch/m68k/apollo/dn_ints.c
@@ -5,7 +5,7 @@
 #include <asm/traps.h>
 #include <asm/apollohw.h>
 
-unsigned int apollo_irq_startup(struct irq_data *data)
+static unsigned int apollo_irq_startup(struct irq_data *data)
 {
 	unsigned int irq = data->irq;
 
@@ -16,7 +16,7 @@ unsigned int apollo_irq_startup(struct irq_data *data)
 	return 0;
 }
 
-void apollo_irq_shutdown(struct irq_data *data)
+static void apollo_irq_shutdown(struct irq_data *data)
 {
 	unsigned int irq = data->irq;
 
@@ -26,7 +26,7 @@ void apollo_irq_shutdown(struct irq_data *data)
 		*(volatile unsigned char *)(picb+1) |= (1 << (irq - 8));
 }
 
-void apollo_irq_eoi(struct irq_data *data)
+static void apollo_irq_eoi(struct irq_data *data)
 {
 	*(volatile unsigned char *)(pica) = 0x20;
 	*(volatile unsigned char *)(picb) = 0x20;
-- 
2.34.1


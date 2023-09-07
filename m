Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63333797713
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbjIGQVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236349AbjIGQUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:20:31 -0400
Received: from cantor.telenet-ops.be (cantor.telenet-ops.be [IPv6:2a02:1800:120:4::f00:10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897232D42
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:16:48 -0700 (PDT)
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by cantor.telenet-ops.be (Postfix) with ESMTPS id 4RhL5L5zSRz4x4qG
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 15:42:14 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:c214:2eac:128d:f67e])
        by andre.telenet-ops.be with bizsmtp
        id j1hy2A0042mGBSJ011hyGB; Thu, 07 Sep 2023 15:41:59 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGQ-002m9E-KK;
        Thu, 07 Sep 2023 15:41:57 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGf-00CMgv-Rn;
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
Subject: [PATCH 24/52] m68k: apollo: Make local reset, serial, and irq functions static
Date:   Thu,  7 Sep 2023 15:41:25 +0200
Message-Id: <975ee6ee27cc9d41cfd9026643bd3da63546bc13.1694093327.git.geert@linux-m68k.org>
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


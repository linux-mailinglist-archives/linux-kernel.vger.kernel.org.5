Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FD579EA82
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241363AbjIMOJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241267AbjIMOI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:08:56 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E431BDF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:08:50 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:f674:9611:cd05:f25a])
        by baptiste.telenet-ops.be with bizsmtp
        id lS8n2A0083fvA4V01S8nqF; Wed, 13 Sep 2023 16:08:48 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qgQXd-003csQ-QR;
        Wed, 13 Sep 2023 16:08:47 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qgQXv-00FV5C-5J;
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
Subject: [PATCH v2 23/52] m68k: apollo: Remove unused debug console functions
Date:   Wed, 13 Sep 2023 16:08:13 +0200
Message-Id: <5da9036914a5c84c20b6af55f1801f0c734a96bb.1694613528.git.geert@linux-m68k.org>
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

    arch/m68k/apollo/config.c:111:5: warning: no previous prototype for ‘dn_serial_console_wait_key’ [-Wmissing-prototypes]
      111 | int dn_serial_console_wait_key(struct console *co) {
	  |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
    arch/m68k/apollo/config.c:118:6: warning: no previous prototype for ‘dn_serial_console_write’ [-Wmissing-prototypes]
      118 | void dn_serial_console_write (struct console *co, const char *str,unsigned int count)
	  |      ^~~~~~~~~~~~~~~~~~~~~~~
    arch/m68k/apollo/config.c:238:6: warning: no previous prototype for ‘dn_dummy_waitbut’ [-Wmissing-prototypes]
      240 | void dn_dummy_waitbut(void) {
	  |      ^~~~~~~~~~~~~~~~

Fix this by removing these unused functions.
The last user of dn_serial_console_write() was removed in v2.3.41.
The other functions never had any users.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
  - Add Acked-by.
---
 arch/m68k/apollo/config.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/arch/m68k/apollo/config.c b/arch/m68k/apollo/config.c
index 42a8b8e2b664226a..fccbb40772dca6b9 100644
--- a/arch/m68k/apollo/config.c
+++ b/arch/m68k/apollo/config.c
@@ -4,7 +4,6 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/tty.h>
-#include <linux/console.h>
 #include <linux/rtc.h>
 #include <linux/vt_kern.h>
 #include <linux/interrupt.h>
@@ -108,27 +107,6 @@ static void __init dn_setup_model(void)
 
 }
 
-int dn_serial_console_wait_key(struct console *co) {
-
-	while(!(sio01.srb_csrb & 1))
-		barrier();
-	return sio01.rhrb_thrb;
-}
-
-void dn_serial_console_write (struct console *co, const char *str,unsigned int count)
-{
-   while(count--) {
-	if (*str == '\n') {
-	sio01.rhrb_thrb = (unsigned char)'\r';
-	while (!(sio01.srb_csrb & 0x4))
-                ;
-	}
-    sio01.rhrb_thrb = (unsigned char)*str++;
-    while (!(sio01.srb_csrb & 0x4))
-            ;
-  }
-}
-
 void dn_serial_print (const char *str)
 {
     while (*str) {
@@ -237,12 +215,6 @@ void dn_dummy_reset(void) {
 
 }
 
-void dn_dummy_waitbut(void) {
-
-  dn_serial_print("waitbut\n");
-
-}
-
 static void dn_get_model(char *model)
 {
     strcpy(model, "Apollo ");
-- 
2.34.1


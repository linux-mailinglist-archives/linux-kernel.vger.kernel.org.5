Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE6379EA7D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241421AbjIMOKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241353AbjIMOJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:09:14 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E531BD7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:08:52 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:f674:9611:cd05:f25a])
        by albert.telenet-ops.be with bizsmtp
        id lS8n2A00Q3fvA4V06S8n4C; Wed, 13 Sep 2023 16:08:48 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qgQXe-003ct7-5a;
        Wed, 13 Sep 2023 16:08:47 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qgQXv-00FV65-GX;
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
Subject: [PATCH v2 34/52] m68k: mvme16x: Remove unused sink in mvme16x_cons_write()
Date:   Wed, 13 Sep 2023 16:08:24 +0200
Message-Id: <22c4d1978f811d7f4495eeb269ce06304717627a.1694613528.git.geert@linux-m68k.org>
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

    arch/m68k/mvme16x/config.c: In function ‘mvme16x_cons_write’:
    arch/m68k/mvme16x/config.c:211:25: warning: variable ‘sink’ set but not used [-Wunused-but-set-variable]
      211 |         volatile u_char sink;
	  |                         ^~~~

Fix this by removing the unused variable and assignment.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
  - Add Acked-by.
---
 arch/m68k/mvme16x/config.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/m68k/mvme16x/config.c b/arch/m68k/mvme16x/config.c
index f00c7aa058dec2f3..b6833862ea6b1530 100644
--- a/arch/m68k/mvme16x/config.c
+++ b/arch/m68k/mvme16x/config.c
@@ -208,7 +208,6 @@ static void __init mvme16x_init_IRQ (void)
 void mvme16x_cons_write(struct console *co, const char *str, unsigned count)
 {
 	volatile unsigned char *base_addr = (u_char *)CD2401_ADDR;
-	volatile u_char sink;
 	u_char ier;
 	int port;
 	u_char do_lf = 0;
@@ -229,7 +228,7 @@ void mvme16x_cons_write(struct console *co, const char *str, unsigned count)
 		if (in_8(PCCSCCTICR) & 0x20)
 		{
 			/* We have a Tx int. Acknowledge it */
-			sink = in_8(PCCTPIACKR);
+			in_8(PCCTPIACKR);
 			if ((base_addr[CyLICR] >> 2) == port) {
 				if (i == count) {
 					/* Last char of string is now output */
-- 
2.34.1


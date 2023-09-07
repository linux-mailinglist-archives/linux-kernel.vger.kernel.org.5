Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B51797A10
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243701AbjIGR2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243992AbjIGR2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:28:52 -0400
Received: from gauss.telenet-ops.be (gauss.telenet-ops.be [IPv6:2a02:1800:120:4::f00:11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEA7CA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:28:21 -0700 (PDT)
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by gauss.telenet-ops.be (Postfix) with ESMTPS id 4RhL534p40z4x6kH
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 15:41:59 +0200 (CEST)
Received: from ramsan.of.borg ([84.195.187.55])
        by baptiste.telenet-ops.be with bizsmtp
        id j1hy2A00B1C8whw011hyX6; Thu, 07 Sep 2023 15:41:59 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGQ-002m9u-Re;
        Thu, 07 Sep 2023 15:41:58 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGg-00CMhk-3d;
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
Subject: [PATCH 34/52] m68k: mvme16x: Remove unused sink in mvme16x_cons_write()
Date:   Thu,  7 Sep 2023 15:41:35 +0200
Message-Id: <cf27a52120be205ebe7a2d82b5cab99f12a2fdcf.1694093327.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694093327.git.geert@linux-m68k.org>
References: <cover.1694093327.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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


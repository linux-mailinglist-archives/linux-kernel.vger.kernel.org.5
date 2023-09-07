Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36DA79773A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbjIGQXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241490AbjIGQWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:22:31 -0400
Received: from weierstrass.telenet-ops.be (weierstrass.telenet-ops.be [IPv6:2a02:1800:110:4::f00:11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E506A44
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:19:52 -0700 (PDT)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by weierstrass.telenet-ops.be (Postfix) with ESMTPS id 4RhL6D04PRz4x30m
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 15:43:00 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:c214:2eac:128d:f67e])
        by xavier.telenet-ops.be with bizsmtp
        id j1hx2A00C2mGBSJ011hxwm; Thu, 07 Sep 2023 15:41:59 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGQ-002m8k-Cg;
        Thu, 07 Sep 2023 15:41:57 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGf-00CMgI-Ko;
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
Subject: [PATCH 16/52] m68k: amiga: pcmcia: Replace set but not used variable by READ_ONCE()
Date:   Thu,  7 Sep 2023 15:41:17 +0200
Message-Id: <4b6eaac8dd2053e14eedf957f446dc30ccfdbc75.1694093327.git.geert@linux-m68k.org>
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

    arch/m68k/amiga/pcmcia.c: In function ‘pcmcia_reset’:
    arch/m68k/amiga/pcmcia.c:29:23: warning: variable ‘b’ set but not used [-Wunused-but-set-variable]
       29 |         unsigned char b;
	  |                       ^

Fix this by using READ_ONCE(), and removing the variable.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/amiga/pcmcia.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/m68k/amiga/pcmcia.c b/arch/m68k/amiga/pcmcia.c
index 7106f0c3639bc105..63cce6b590df4dcb 100644
--- a/arch/m68k/amiga/pcmcia.c
+++ b/arch/m68k/amiga/pcmcia.c
@@ -26,11 +26,10 @@ static unsigned char cfg_byte = GAYLE_CFG_0V|GAYLE_CFG_150NS;
 void pcmcia_reset(void)
 {
 	unsigned long reset_start_time = jiffies;
-	unsigned char b;
 
 	gayle_reset = 0x00;
 	while (time_before(jiffies, reset_start_time + 1*HZ/100));
-	b = gayle_reset;
+	READ_ONCE(gayle_reset);
 }
 EXPORT_SYMBOL(pcmcia_reset);
 
-- 
2.34.1


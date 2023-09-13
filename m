Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617AC79EA8B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241368AbjIMOJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241263AbjIMOI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:08:56 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB431BDD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:08:50 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:f674:9611:cd05:f25a])
        by baptiste.telenet-ops.be with bizsmtp
        id lS8n2A0043fvA4V01S8nqD; Wed, 13 Sep 2023 16:08:48 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qgQXd-003crw-KA;
        Wed, 13 Sep 2023 16:08:47 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qgQXu-00FV4d-Vg;
        Wed, 13 Sep 2023 16:08:46 +0200
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
Subject: [PATCH v2 16/52] m68k: amiga: pcmcia: Replace set but not used variable by READ_ONCE()
Date:   Wed, 13 Sep 2023 16:08:06 +0200
Message-Id: <1436fa6b329c2212aaf020055afbb97e64b6f039.1694613528.git.geert@linux-m68k.org>
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

    arch/m68k/amiga/pcmcia.c: In function ‘pcmcia_reset’:
    arch/m68k/amiga/pcmcia.c:29:23: warning: variable ‘b’ set but not used [-Wunused-but-set-variable]
       29 |         unsigned char b;
	  |                       ^

Fix this by using READ_ONCE(), and removing the variable.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
  - Add Acked-by.
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


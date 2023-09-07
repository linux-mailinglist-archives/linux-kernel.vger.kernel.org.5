Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87947979BB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239703AbjIGRTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242996AbjIGRTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:19:46 -0400
Received: from cantor.telenet-ops.be (cantor.telenet-ops.be [IPv6:2a02:1800:120:4::f00:10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD88E1FE6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:19:21 -0700 (PDT)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by cantor.telenet-ops.be (Postfix) with ESMTPS id 4RhL536jvnz4xVNv
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 15:41:59 +0200 (CEST)
Received: from ramsan.of.borg ([84.195.187.55])
        by xavier.telenet-ops.be with bizsmtp
        id j1hy2A00J1C8whw011hyws; Thu, 07 Sep 2023 15:41:59 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGR-002mAY-25;
        Thu, 07 Sep 2023 15:41:58 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGg-00CMiW-AI;
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
Subject: [PATCH 44/52] m68k: sun3: Remove unused vsprintf() return value in prom_printf()
Date:   Thu,  7 Sep 2023 15:41:45 +0200
Message-Id: <f10d77a73043bb4acbdceb7731f9a2997d6836f1.1694093327.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694093327.git.geert@linux-m68k.org>
References: <cover.1694093327.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with W=1:

    arch/m68k/sun3/prom/printf.c: In function ‘prom_printf’:
    arch/m68k/sun3/prom/printf.c:28:13: warning: variable ‘i’ set but not used [-Wunused-but-set-variable]
       28 |         int i;
	  |             ^

As the return value of vsprintf() is unused, and serves no practical
purpose here, fix this by removing the variable.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/sun3/prom/printf.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/m68k/sun3/prom/printf.c b/arch/m68k/sun3/prom/printf.c
index b6724cc6679579bd..db5537ef12504a8b 100644
--- a/arch/m68k/sun3/prom/printf.c
+++ b/arch/m68k/sun3/prom/printf.c
@@ -25,15 +25,14 @@ prom_printf(char *fmt, ...)
 {
 	va_list args;
 	char ch, *bptr;
-	int i;
 
 	va_start(args, fmt);
 
 #ifdef CONFIG_KGDB
 	ppbuf[0] = 'O';
-	i = vsprintf(ppbuf + 1, fmt, args) + 1;
+	vsprintf(ppbuf + 1, fmt, args) + 1;
 #else
-	i = vsprintf(ppbuf, fmt, args);
+	vsprintf(ppbuf, fmt, args);
 #endif
 
 	bptr = ppbuf;
-- 
2.34.1


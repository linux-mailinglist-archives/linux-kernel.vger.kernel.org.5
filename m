Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26362797725
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241970AbjIGQVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240601AbjIGQV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:21:28 -0400
Received: from cantor.telenet-ops.be (cantor.telenet-ops.be [IPv6:2a02:1800:120:4::f00:10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09E776AD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:18:45 -0700 (PDT)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by cantor.telenet-ops.be (Postfix) with ESMTPS id 4RhL536KJnz4xVNs
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 15:41:59 +0200 (CEST)
Received: from ramsan.of.borg ([84.195.187.55])
        by xavier.telenet-ops.be with bizsmtp
        id j1hy2A00K1C8whw011hywt; Thu, 07 Sep 2023 15:41:59 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGR-002mAc-2n;
        Thu, 07 Sep 2023 15:41:58 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGg-00CMib-Ax;
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
Subject: [PATCH 45/52] m68k: sun3: Annotate prom_printf() with __printf()
Date:   Thu,  7 Sep 2023 15:41:46 +0200
Message-Id: <c2ad40d765b52387da89a4c94a96ad906df8754b.1694093327.git.geert@linux-m68k.org>
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

    arch/m68k/sun3/prom/printf.c: In function ‘prom_printf’:
    arch/m68k/sun3/prom/printf.c:35:9: warning: function ‘prom_printf’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
       35 |         vsprintf(ppbuf, fmt, args);
	  |         ^~~~~~~~

Fix this by annotating prom_printf() with __printf(1, 2).

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/include/asm/oplib.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/m68k/include/asm/oplib.h b/arch/m68k/include/asm/oplib.h
index 48cb4fd09f8d9cce..6d5ea67c65d044c1 100644
--- a/arch/m68k/include/asm/oplib.h
+++ b/arch/m68k/include/asm/oplib.h
@@ -9,6 +9,8 @@
 #ifndef __SPARC_OPLIB_H
 #define __SPARC_OPLIB_H
 
+#include <linux/compiler.h>
+
 #include <asm/openprom.h>
 
 /* The master romvec pointer... */
@@ -149,7 +151,7 @@ extern char prom_getchar(void);
 extern void prom_putchar(char character);
 
 /* Prom's internal printf routine, don't use in kernel/boot code. */
-void prom_printf(char *fmt, ...);
+__printf(1, 2) void prom_printf(char *fmt, ...);
 
 /* Query for input device type */
 
-- 
2.34.1


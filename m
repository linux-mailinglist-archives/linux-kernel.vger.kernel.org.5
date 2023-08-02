Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD1676CFDA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbjHBORP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbjHBORN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:17:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6E910E;
        Wed,  2 Aug 2023 07:17:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21428619B5;
        Wed,  2 Aug 2023 14:17:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D854C433C7;
        Wed,  2 Aug 2023 14:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690985830;
        bh=B6wokS1QD+AtP0pgfwxEUP2copic/VIFNqL65p+6WYw=;
        h=From:To:Cc:Subject:Date:From;
        b=I56sTFVX1OolflqSHCsVyzQtHsPanzB+RqXFFDGADmKF02s74FiP2eRXdLgzFbnMX
         E8rRo1mb9qwfg/HT3zvz2YbjXy/B9DmZin3LIhFBTPGYS4FXlaluZcHmm7LP9m0+PI
         oxhvuMkmipokvgmrno/0fBYQkd78VVW7HzawZmZYxw8GhwlKDhh+VyYb4pH6Weomxj
         mRa6Y3Sab9vxHFQe5QHfXtVj8CfIzkHWPb847cXGJT8XgStNq8FmdODpO5COZ+K1vK
         ITiraKkoLU0XS4AV6Ccq5VVkG67cm5VRFhUx6suxl481gb/oXlnblrAh9ppj7E6QLX
         fZtUm7vSQd2Ig==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Baoquan He <bhe@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sh: fix asm-generic/io.h inclusion
Date:   Wed,  2 Aug 2023 16:16:41 +0200
Message-Id: <20230802141658.2064864-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A recent cleanup patch started using the generic asm/io.h header from
the sh version, but unfortunately this caused build regressions in many
configurations, such as:

include/asm-generic/io.h:636:15: error: redefinition of ‘inb_p’

I added some of the missing defines that are needed to keep using the
sh specific implementations rather than the generic ones where they
clash. I build all sh defconfig files to catch the various combinations
of CONFIG_MMU, CONFIG_GENERIC_IOMAP and CONFIG_NO_IOPORT_MAP, this should
cover them all.

A lot of the sh specific functions are equivalent to the generic ones
and could in fact be removed, but it would be best to only do that with
actual runtime testing.

In particular, the indirect ioport_map() implementation is only used
for the "microdev" platform that appears to be broken beyond repair
for as long as the git history goes, so removing both microdev and the
custom ioport handling in favor of the asm-generic/io.h version would
be a great cleanup, but this can be done another time if anyone feels
motivated to clean up arch/sh.

Fixes: e41f1f7ff6c2b ("sh: add <asm-generic/io.h> including")
Link: https://lore.kernel.org/lkml/09094baf-dadf-4bce-9f63-f2a1f255f9a8@app.fastmail.com/
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Andrew, can you pick this up into the mm tree on top of the
"sh: add <asm-generic/io.h> including" patch?
---
 arch/sh/include/asm/io.h          | 24 ++++++++++++++++++++++++
 arch/sh/include/asm/io_noioport.h | 14 --------------
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index 24c560c065ec7..f2f38e9d489ac 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -119,6 +119,10 @@ void __raw_readsl(const void __iomem *addr, void *data, int longlen);
 
 __BUILD_MEMORY_STRING(__raw_, q, u64)
 
+#define ioport_map ioport_map
+#define ioport_unmap ioport_unmap
+#define pci_iounmap pci_iounmap
+
 #define ioread8 ioread8
 #define ioread16 ioread16
 #define ioread16be ioread16be
@@ -241,6 +245,26 @@ __BUILD_IOPORT_STRING(q, u64)
 
 #endif
 
+#define inb(addr)      inb(addr)
+#define inw(addr)      inw(addr)
+#define inl(addr)      inl(addr)
+#define outb(x, addr)  outb((x), (addr))
+#define outw(x, addr)  outw((x), (addr))
+#define outl(x, addr)  outl((x), (addr))
+
+#define inb_p(addr)    inb(addr)
+#define inw_p(addr)    inw(addr)
+#define inl_p(addr)    inl(addr)
+#define outb_p(x, addr)        outb((x), (addr))
+#define outw_p(x, addr)        outw((x), (addr))
+#define outl_p(x, addr)        outl((x), (addr))
+
+#define insb insb
+#define insw insw
+#define insl insl
+#define outsb outsb
+#define outsw outsw
+#define outsl outsl
 
 #define IO_SPACE_LIMIT 0xffffffff
 
diff --git a/arch/sh/include/asm/io_noioport.h b/arch/sh/include/asm/io_noioport.h
index 5ba4116b4265c..12dad91f41c1e 100644
--- a/arch/sh/include/asm/io_noioport.h
+++ b/arch/sh/include/asm/io_noioport.h
@@ -46,20 +46,6 @@ static inline void ioport_unmap(void __iomem *addr)
 	BUG();
 }
 
-#define inb_p(addr)	inb(addr)
-#define inw_p(addr)	inw(addr)
-#define inl_p(addr)	inl(addr)
-#define outb_p(x, addr)	outb((x), (addr))
-#define outw_p(x, addr)	outw((x), (addr))
-#define outl_p(x, addr)	outl((x), (addr))
-
-#define insb insb
-#define insw insw
-#define insl insl
-#define outsb outsb
-#define outsw outsw
-#define outsl outsl
-
 static inline void insb(unsigned long port, void *dst, unsigned long count)
 {
 	BUG();
-- 
2.39.2


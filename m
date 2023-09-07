Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1650C797A3C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237317AbjIGReO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbjIGReL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:34:11 -0400
Received: from cantor.telenet-ops.be (cantor.telenet-ops.be [IPv6:2a02:1800:120:4::f00:10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A9B197
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:33:46 -0700 (PDT)
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by cantor.telenet-ops.be (Postfix) with ESMTPS id 4RhL535hNsz4xVNf
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 15:41:59 +0200 (CEST)
Received: from ramsan.of.borg ([84.195.187.55])
        by albert.telenet-ops.be with bizsmtp
        id j1hy2A00U1C8whw061hyaR; Thu, 07 Sep 2023 15:41:59 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGQ-002mA9-UG;
        Thu, 07 Sep 2023 15:41:58 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGg-00CMi3-6I;
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
Subject: [PATCH 38/52] m68k: sun3: Improve Sun3/3x DVMA abstraction in <asm/dvma.h>
Date:   Thu,  7 Sep 2023 15:41:39 +0200
Message-Id: <df48190f1784b0d04a64a784839a987e5a56cd8b.1694093327.git.geert@linux-m68k.org>
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

    arch/m68k/sun3/dvma.c:65:13: warning: no previous prototype for ‘sun3_dvma_init’ [-Wmissing-prototypes]
       65 | void __init sun3_dvma_init(void)
	  |             ^~~~~~~~~~~~~~

    arch/m68k/sun3x/dvma.c:178:6: warning: no previous prototype for ‘dvma_unmap_iommu’ [-Wmissing-prototypes]
      179 | void dvma_unmap_iommu(unsigned long baddr, int len)
	  |      ^~~~~~~~~~~~~~~~

Fix this by moving the declarations for sun3_dvma_init() and
dvma_unmap_iommu() to <asm/dvma.h>.  Avoid #ifdefs in callers by
providing dummy static inline functions.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/include/asm/dvma.h |  8 +++++++-
 arch/m68k/sun3/sun3dvma.c    | 15 ---------------
 2 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/arch/m68k/include/asm/dvma.h b/arch/m68k/include/asm/dvma.h
index f609ec1de36d0d2c..d1d66d04844d3e1c 100644
--- a/arch/m68k/include/asm/dvma.h
+++ b/arch/m68k/include/asm/dvma.h
@@ -58,12 +58,16 @@ extern void dvma_free(void *vaddr);
 #define dvma_vtob(x) dvma_vtop(x)
 #define dvma_btov(x) dvma_ptov(x)
 
+void sun3_dvma_init(void);
+
 static inline int dvma_map_cpu(unsigned long kaddr, unsigned long vaddr,
 			       int len)
 {
 	return 0;
 }
 
+static inline void dvma_unmap_iommu(unsigned long baddr, int len) { }
+
 #else /* Sun3x */
 
 /* sun3x dvma page support */
@@ -78,9 +82,11 @@ static inline int dvma_map_cpu(unsigned long kaddr, unsigned long vaddr,
 #define dvma_vtob(x) ((unsigned long)(x) & 0x00ffffff)
 #define dvma_btov(x) ((unsigned long)(x) | 0xff000000)
 
-extern int dvma_map_cpu(unsigned long kaddr, unsigned long vaddr, int len);
+static inline void sun3_dvma_init(void) { }
 
+int dvma_map_cpu(unsigned long kaddr, unsigned long vaddr, int len);
 
+void dvma_unmap_iommu(unsigned long baddr, int len);
 
 /* everything below this line is specific to dma used for the onboard
    ESP scsi on sun3x */
diff --git a/arch/m68k/sun3/sun3dvma.c b/arch/m68k/sun3/sun3dvma.c
index 4b560f4d3960c2b5..f66b2413209069f2 100644
--- a/arch/m68k/sun3/sun3dvma.c
+++ b/arch/m68k/sun3/sun3dvma.c
@@ -20,18 +20,6 @@
 
 #undef DVMA_DEBUG
 
-#ifdef CONFIG_SUN3X
-extern void dvma_unmap_iommu(unsigned long baddr, int len);
-#else
-static inline void dvma_unmap_iommu(unsigned long a, int b)
-{
-}
-#endif
-
-#ifdef CONFIG_SUN3
-extern void sun3_dvma_init(void);
-#endif
-
 static unsigned long *iommu_use;
 
 #define dvma_index(baddr) ((baddr - DVMA_START) >> DVMA_PAGE_SHIFT)
@@ -274,10 +262,7 @@ void __init dvma_init(void)
 
 	dvma_unmap_iommu(DVMA_START, DVMA_SIZE);
 
-#ifdef CONFIG_SUN3
 	sun3_dvma_init();
-#endif
-
 }
 
 unsigned long dvma_map_align(unsigned long kaddr, int len, int align)
-- 
2.34.1


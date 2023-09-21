Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D0F7A9D50
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjIUTaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjIUTaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:30:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CD4AC3CC;
        Thu, 21 Sep 2023 11:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=gdqW2btEAGTjUcr6tPXF8qJKNeNz/rAyxIMM40y9I9w=; b=SWocHAyJZpAAngQ47nwB5OeiR3
        YOZKLNFRzgqPHosliGblFbf62gIeaDU6/FjBeIqe4fSke+drAQNrno+yRUjWC/8YrkDRBb3xeUVNe
        v1aa3Yx6Djf7J4Kcs+fGBg1EcU4zRp1wV91uFHEmQFq8z/7kH624JMHQZlzQSa7+ec1kksacwnOkN
        cmjYrIMBWiI9qaFkO3kRcVzdbmFhGQHki/2SDPEdpVau5CEW5xVNFRBr6any6+WhfnmAlIJJ5rbhL
        m9vVbDkwAcYJv4JkF0jSsAxvB4w/bYDTanh0v+NcFWi+jtEWbbbS3otMbbq0oDgbPgA1sAvhUi2mu
        9YNiyNCw==;
Received: from [2601:1c2:980:9ec0::9fed] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qjClk-005Eii-0U;
        Thu, 21 Sep 2023 06:02:32 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org
Subject: [PATCH] fbdev: sh7760fb: require FB=y to build cleanly
Date:   Wed, 20 Sep 2023 23:02:28 -0700
Message-ID: <20230921060228.29041-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build errors when CONFIG_FB=m and CONFIG_FB_SH7760=y:

sh2-linux-ld: drivers/video/fbdev/sh7760fb.o: in function `sh7760fb_probe':
sh7760fb.c:(.text+0x374): undefined reference to `framebuffer_alloc'
sh2-linux-ld: sh7760fb.c:(.text+0x394): undefined reference to `fb_videomode_to_var'
sh2-linux-ld: sh7760fb.c:(.text+0x3a0): undefined reference to `fb_alloc_cmap'
sh2-linux-ld: sh7760fb.c:(.text+0x3a4): undefined reference to `register_framebuffer'
sh2-linux-ld: sh7760fb.c:(.text+0x3ac): undefined reference to `fb_dealloc_cmap'
sh2-linux-ld: sh7760fb.c:(.text+0x434): undefined reference to `framebuffer_release'
sh2-linux-ld: drivers/video/fbdev/sh7760fb.o: in function `sh7760fb_remove':
sh7760fb.c:(.text+0x800): undefined reference to `unregister_framebuffer'
sh2-linux-ld: sh7760fb.c:(.text+0x804): undefined reference to `fb_dealloc_cmap'
sh2-linux-ld: sh7760fb.c:(.text+0x814): undefined reference to `framebuffer_release'
sh2-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0xc): undefined reference to `fb_io_read'
sh2-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0x10): undefined reference to `fb_io_write'
sh2-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0x2c): undefined reference to `cfb_fillrect'
sh2-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0x30): undefined reference to `cfb_copyarea'
sh2-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0x34): undefined reference to `cfb_imageblit'

Fixes: 4a25e41831ee ("video: sh7760fb: SH7760/SH7763 LCDC framebuffer driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org
---
 drivers/video/fbdev/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1762,7 +1762,7 @@ config FB_COBALT
 
 config FB_SH7760
 	bool "SH7760/SH7763/SH7720/SH7721 LCDC support"
-	depends on FB && (CPU_SUBTYPE_SH7760 || CPU_SUBTYPE_SH7763 \
+	depends on FB=y && (CPU_SUBTYPE_SH7760 || CPU_SUBTYPE_SH7763 \
 		|| CPU_SUBTYPE_SH7720 || CPU_SUBTYPE_SH7721)
 	select FB_IOMEM_HELPERS
 	help

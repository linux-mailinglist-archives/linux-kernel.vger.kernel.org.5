Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4A5761DAA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjGYPwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbjGYPwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:52:15 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BDC1FE6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:52:13 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:2d50:2ea4:d4e1:2af3])
        by laurent.telenet-ops.be with bizsmtp
        id RTsB2A0092TBYXr01TsBc4; Tue, 25 Jul 2023 17:52:12 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qOKKM-002Vj4-Ib;
        Tue, 25 Jul 2023 17:52:11 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qOKKZ-009cbZ-Mo;
        Tue, 25 Jul 2023 17:52:11 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] video: logo: LOGO should depend on FB_CORE i.s.o. FB
Date:   Tue, 25 Jul 2023 17:52:06 +0200
Message-Id: <5ab3d1fe7b67ab10e4bc1bdbc0fa7731f7960965.1690300189.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_FB_CORE=y but CONFIG_FB=n, the frame buffer bootup logos can
no longer be enabled.  Fix this by making CONFIG_LOGO depend on
CONFIG_FB_CORE instead of CONFIG_FB, as there is no good reason for the
logo code to depend on the presence of real frame buffer device drivers.

Fixes: 55bffc8170bb5813 ("fbdev: Split frame buffer support in FB and FB_CORE symbols")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/video/Kconfig      | 2 +-
 drivers/video/logo/Kconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index e5b1cc54cafa10d5..b694d7669d3200b1 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -63,7 +63,7 @@ if VT
 	source "drivers/video/console/Kconfig"
 endif
 
-if FB || SGI_NEWPORT_CONSOLE
+if FB_CORE || SGI_NEWPORT_CONSOLE
 	source "drivers/video/logo/Kconfig"
 
 endif
diff --git a/drivers/video/logo/Kconfig b/drivers/video/logo/Kconfig
index 6d6f8c08792dc897..b7d94d1dd1585a84 100644
--- a/drivers/video/logo/Kconfig
+++ b/drivers/video/logo/Kconfig
@@ -5,7 +5,7 @@
 
 menuconfig LOGO
 	bool "Bootup logo"
-	depends on FB || SGI_NEWPORT_CONSOLE
+	depends on FB_CORE || SGI_NEWPORT_CONSOLE
 	help
 	  Enable and select frame buffer bootup logos.
 
-- 
2.34.1


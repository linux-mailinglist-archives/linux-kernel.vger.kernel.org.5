Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36DF7DB09C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjJ2XIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbjJ2XHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:07:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC899EF5;
        Sun, 29 Oct 2023 16:03:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A1AC433CC;
        Sun, 29 Oct 2023 23:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620499;
        bh=kY4XyLVwrX+3H1bdvNP8pEQe+U5OaqLJ46NhUlVlTC4=;
        h=From:To:Cc:Subject:Date:From;
        b=ovX9womKt/awtKy7X//j+OImm5hO2WXk4Zm+4HTB9xkNbA7PV/Xs6JcAlRwCOGxK8
         OmPzKTafPiKuMH4SxF82mUgF9juDeYULdreIj1Fvob50RbTazjONVouD7EG8gvqUq/
         Zk6Z4yJyDAnM8xFTW6Vmqs207Y18vFcXitUtsL5zBjUDDCH+vv3S34QGBKTQ12qRYh
         rn2gYajJQvFTUzwIOPVyeXU6eW9RbiAaRaPuJFMpviD5IhGayisgxKTqvO9l2ndb0c
         ozKPhrIGwqCZRmazECjwXwR9KsQo3/p00Yl/b9G0QsRAUlJmi2XMx7pGY/d0HUt10B
         aQ1fGWkbBUCzg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Baoquan He <bhe@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Sasha Levin <sashal@kernel.org>, sam@ravnborg.org,
        javierm@redhat.com, schnelle@linux.ibm.com, xu.panda@zte.com.cn,
        steve@sk2.org
Subject: [PATCH AUTOSEL 4.19 01/12] fbdev: atyfb: only use ioremap_uc() on i386 and ia64
Date:   Sun, 29 Oct 2023 19:01:14 -0400
Message-ID: <20231029230135.793281-1-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.297
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit c1a8d1d0edb71dec15c9649cb56866c71c1ecd9e ]

ioremap_uc() is only meaningful on old x86-32 systems with the PAT
extension, and on ia64 with its slightly unconventional ioremap()
behavior, everywhere else this is the same as ioremap() anyway.

Change the only driver that still references ioremap_uc() to only do so
on x86-32/ia64 in order to allow removing that interface at some
point in the future for the other architectures.

On some architectures, ioremap_uc() just returns NULL, changing
the driver to call ioremap() means that they now have a chance
of working correctly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Helge Deller <deller@gmx.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/aty/atyfb_base.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index 05111e90f1681..5ef008e9c61c3 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -3435,11 +3435,15 @@ static int atyfb_setup_generic(struct pci_dev *pdev, struct fb_info *info,
 	}
 
 	info->fix.mmio_start = raddr;
+#if defined(__i386__) || defined(__ia64__)
 	/*
 	 * By using strong UC we force the MTRR to never have an
 	 * effect on the MMIO region on both non-PAT and PAT systems.
 	 */
 	par->ati_regbase = ioremap_uc(info->fix.mmio_start, 0x1000);
+#else
+	par->ati_regbase = ioremap(info->fix.mmio_start, 0x1000);
+#endif
 	if (par->ati_regbase == NULL)
 		return -ENOMEM;
 
-- 
2.42.0


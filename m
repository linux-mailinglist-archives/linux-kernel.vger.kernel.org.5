Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78487DB1A8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 01:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjJ3ACq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 20:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjJ3ACg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 20:02:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D56244A6;
        Sun, 29 Oct 2023 15:58:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D29C433CD;
        Sun, 29 Oct 2023 22:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620263;
        bh=JvXWdaPVGCXGPljCNPOAWNOooFCOP2wSIUJSdS6nMTU=;
        h=From:To:Cc:Subject:Date:From;
        b=e+HOEm9Dph06Y1p06hYWg27v0mMzYcikpuM5V7+aIeolERgQQrcUaNOwfipIte41U
         XxeF+3sMToFrYBC3PZQZy2suzmC1L3WVOB0aSQ8Pyy1vjfQWaVoYKxTRv8Z4nIy+q3
         RfQSSiJig5wgOyseZRpJN/y6B7WiaUgwbx+kknp3CEnQsgBSwksjH/OHQIVuTjmF/y
         6XVlGwYDTPSQqt/jUqfg+4xy4GXi48CLWHRtRi8UsirGO3Bunym5zrKVcNOZmGoX1y
         vLqEkJBZtSpUghPxCDzoQHNLVpM3d3jMyzv9v8l+b3C32RddBSc6rspdP/+zAlMlHb
         K1JHg3fqSLVvw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Baoquan He <bhe@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Sasha Levin <sashal@kernel.org>, javierm@redhat.com,
        sam@ravnborg.org, xu.panda@zte.com.cn, schnelle@linux.ibm.com,
        steve@sk2.org
Subject: [PATCH AUTOSEL 6.1 01/39] fbdev: atyfb: only use ioremap_uc() on i386 and ia64
Date:   Sun, 29 Oct 2023 18:56:33 -0400
Message-ID: <20231029225740.790936-1-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.60
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
index b3463d1371520..faaa64fa5dfe9 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -3447,11 +3447,15 @@ static int atyfb_setup_generic(struct pci_dev *pdev, struct fb_info *info,
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


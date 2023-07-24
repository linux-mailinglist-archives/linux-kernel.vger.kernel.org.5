Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336E575E63E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjGXBQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjGXBQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:16:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5961722;
        Sun, 23 Jul 2023 18:15:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D472060F04;
        Mon, 24 Jul 2023 01:15:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99C7C433C7;
        Mon, 24 Jul 2023 01:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690161300;
        bh=QhZf8toMd5+zDGE1EOIeW6wBNB1VaLLB+7VguP4KCAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OUhAWf0eKyCot2e+mbFe1KQ9YFR0jcjjhPaYFrokV/ojDoCmwWqPeCUSc23cx3kLg
         UuTj44IuTrAuCyTSajBHo2A4gHYplr6Lvb8UPqKaFj9MIF4Zc5I33ToX+8jVI+mtMx
         1g+fv93Kz+un6oZV2Zs23SpMDvqpWBKH+/LQ48aNmTesMghmXVoZVNKAJnkJ2w99o/
         BM8e2HkJpd/p5S+MwivnFg2S5qkDhj8xkZF/24T2NqR+iVXc2/mHXF1+cVhvWeyNf0
         fzo6Iwce6B4T3FCG+bfFwX+9CxhdTc+kFab1QBVVDh+vXl2pAQ3UrCqkGz3W/b4PR9
         8dxAlY8RchzgQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Sasha Levin <sashal@kernel.org>, yannick.fertre@foss.st.com,
        airlied@gmail.com, daniel@ffwll.ch, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, dri-devel@lists.freedesktop.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.4 16/58] drm/stm: ltdc: fix late dereference check
Date:   Sun, 23 Jul 2023 21:12:44 -0400
Message-Id: <20230724011338.2298062-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724011338.2298062-1-sashal@kernel.org>
References: <20230724011338.2298062-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.5
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>

[ Upstream commit 898a9e3f56db9860ab091d4bf41b6caa99aafc3d ]

In ltdc_crtc_set_crc_source(), struct drm_crtc was dereferenced in a
container_of() before the pointer check. This could cause a kernel panic.

Fix this smatch warning:
drivers/gpu/drm/stm/ltdc.c:1124 ltdc_crtc_set_crc_source() warn: variable dereferenced before check 'crtc' (see line 1119)

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/lkml/202212241802.zeLFZCXB-lkp@intel.com/
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/lkml/202212241802.zeLFZCXB-lkp@intel.com/
Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Acked-by: Philippe Cornu <philippe.cornu@foss.st.com>
Signed-off-by: Philippe Cornu <philippe.cornu@foss.st.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230515123818.93971-1-raphael.gallais-pou@foss.st.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/stm/ltdc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 03c6becda795c..b8be4c1db4235 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -1145,7 +1145,7 @@ static void ltdc_crtc_disable_vblank(struct drm_crtc *crtc)
 
 static int ltdc_crtc_set_crc_source(struct drm_crtc *crtc, const char *source)
 {
-	struct ltdc_device *ldev = crtc_to_ltdc(crtc);
+	struct ltdc_device *ldev;
 	int ret;
 
 	DRM_DEBUG_DRIVER("\n");
@@ -1153,6 +1153,8 @@ static int ltdc_crtc_set_crc_source(struct drm_crtc *crtc, const char *source)
 	if (!crtc)
 		return -ENODEV;
 
+	ldev = crtc_to_ltdc(crtc);
+
 	if (source && strcmp(source, "auto") == 0) {
 		ldev->crc_active = true;
 		ret = regmap_set_bits(ldev->regmap, LTDC_GCR, GCR_CRCEN);
-- 
2.39.2


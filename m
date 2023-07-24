Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E96475E71D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjGXBYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjGXBWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:22:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A66F19BB;
        Sun, 23 Jul 2023 18:22:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F178660F14;
        Mon, 24 Jul 2023 01:22:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052F6C433CC;
        Mon, 24 Jul 2023 01:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690161725;
        bh=QhZf8toMd5+zDGE1EOIeW6wBNB1VaLLB+7VguP4KCAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XZd/+hzLzDmDDgdgDlolWa/N65EciP5nslL1pyAlrasFVTWcW74iS8kckewop+c08
         O4ebMkurCQsmsjf0tRWKN/lbUTaOFi/flT2sX6zWmVvrKEL5Lvzy61hHoneO6IQA/N
         K5dROOZWtrOyb4GPrDdOr+WacWZyfEHX0DKeUhXkMwdrvjQXmshZNo6tmg8trgslQg
         YJfy2O8pROebtUmuW2IlYwyiic86cPm2g9rEwi53gZ1Pj+gT3DUS00vXke+E2xPdAD
         tqqzdVcnqarYDykuo3VnD1pipKfjd8rMBdQ/bvb5Y5nVl2bcteGKy68yeNUh9uBxqr
         AOftbQK1dazmA==
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
Subject: [PATCH AUTOSEL 6.1 11/41] drm/stm: ltdc: fix late dereference check
Date:   Sun, 23 Jul 2023 21:20:44 -0400
Message-Id: <20230724012118.2316073-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724012118.2316073-1-sashal@kernel.org>
References: <20230724012118.2316073-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.40
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


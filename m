Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2413D7FD334
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjK2JtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjK2Jsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:48:55 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC8132109
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=cFhWHU+t6DMgtDwgJl
        Z5+l4vJs2Iv3SA9Vi8myA7sUY=; b=nJ8bLVUQzElbyTd75mz7qF6ggFYzxuCUE9
        rBzRKyvQdch5T5D6mR4xhhP+d6+RUhzH/Ve+sJjkYI+bdLN0YciVROJkuUQA/lwT
        p5/mQSV9f85FtJAkKAFMdSS3apiD58njLT3GHLYp3Ur2C4XReiMxHLyNMQX99Vgi
        njhPVc+m0=
Received: from localhost.localdomain (unknown [39.144.190.126])
        by zwqz-smtp-mta-g3-4 (Coremail) with SMTP id _____wDn79nRCGdl0DYUBQ--.7696S2;
        Wed, 29 Nov 2023 17:48:02 +0800 (CST)
From:   Haoran Liu <liuhaoran14@163.com>
To:     alain.volmat@foss.st.com
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Haoran Liu <liuhaoran14@163.com>
Subject: [PATCH] [drm/sti] sti_compositor: Add error handlingin sti_compositor_bind
Date:   Wed, 29 Nov 2023 01:47:59 -0800
Message-Id: <20231129094759.32799-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wDn79nRCGdl0DYUBQ--.7696S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr1rKFy8Jw47Xr4rCw4rZrb_yoWkuwb_uw
        1qyrn7Grs8CF1jvw12kr4fAFyvvrs7ua10934ktas8t3yUX3ZxZFyvgF9xZayUZ347JFnI
        qw4xWFnxury7CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRt6wuUUUUUU==
X-Originating-IP: [39.144.190.126]
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/xtbBchI3gletj5ACowACsT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,
        RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, the function sti_compositor_bind did not properly
handle potential failure scenarios of drm_vblank_init, which could
lead to unexpected behavior. This update adds a check for the
return value of drm_vblank_init.

Signed-off-by: Haoran Liu <liuhaoran14@163.com>
---
 drivers/gpu/drm/sti/sti_compositor.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sti/sti_compositor.c b/drivers/gpu/drm/sti/sti_compositor.c
index 33487a1fed8f..beddbd1c48eb 100644
--- a/drivers/gpu/drm/sti/sti_compositor.c
+++ b/drivers/gpu/drm/sti/sti_compositor.c
@@ -69,6 +69,7 @@ static int sti_compositor_bind(struct device *dev,
 	struct drm_plane *primary = NULL;
 	struct sti_compositor_subdev_descriptor *desc = compo->data.subdev_desc;
 	unsigned int array_size = compo->data.nb_subdev;
+	int ret;
 
 	dev_priv->compo = compo;
 
@@ -145,7 +146,11 @@ static int sti_compositor_bind(struct device *dev,
 		}
 	}
 
-	drm_vblank_init(drm_dev, crtc_id);
+	ret = drm_vblank_init(drm_dev, crtc_id);
+	if (ret) {
+		DRM_ERROR("Failed to initialize vblank\n");
+		return ret;
+	}
 
 	return 0;
 }
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C91E7FBA64
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 13:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344694AbjK1MpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 07:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344682AbjK1MpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 07:45:14 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807BDD51
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 04:45:20 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2FAE766072E7;
        Tue, 28 Nov 2023 12:45:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701175519;
        bh=ZMbtd9WMiupIkiGjSbJtW0qTs1q9H3A+O0vlIJhbcWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ay8pftW9nEj5jELP6u1hSJNKi7DxYPH+ekBVtWYd0QA11aqkkpyerpACMcAlKyXmX
         tFbXDMpnh3MSTceU3YAxlKZtI5ELVV/nEenPgwvTEeEdJVY4mEbxfvEtNvIcI2fzRy
         mEqpNr5lFN2eVE6hjVbyOkMsQ5iorXRFC/yZ69/8uX76lbDSIZYhBDQGsr/PJih7iA
         P7kj7HA8DngAvRRuLu5uMHxOEGuP1Ee6ETOn21WeC36ogFb4uTg32zp3wCGMkQzzvG
         yamOoYZOXVAHhtlGeVOmcAcK1ARCOm8Ye8mg8OV0Y+7d3V7M9BBBkRiwmvt2DcF6tf
         3hyGpjpfMH5sg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     boris.brezillon@collabora.com
Cc:     robh@kernel.org, steven.price@arm.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, m.szyprowski@samsung.com,
        krzysztof.kozlowski@linaro.org
Subject: [PATCH v2 2/3] drm/panfrost: Add gpu_irq, mmu_irq to struct panfrost_device
Date:   Tue, 28 Nov 2023 13:45:09 +0100
Message-ID: <20231128124510.391007-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128124510.391007-1-angelogioacchino.delregno@collabora.com>
References: <20231128124510.391007-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding a IRQ synchronization mechanism for PM suspend
add gpu_irq and mmu_irq variables to struct panfrost_device and change
functions panfrost_gpu_init() and panfrost_mmu_init() to use those.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.h |  2 ++
 drivers/gpu/drm/panfrost/panfrost_gpu.c    | 10 +++++-----
 drivers/gpu/drm/panfrost/panfrost_mmu.c    | 10 +++++-----
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index 0fc558db6bfd..54a8aad54259 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -94,6 +94,8 @@ struct panfrost_device {
 	struct device *dev;
 	struct drm_device *ddev;
 	struct platform_device *pdev;
+	int gpu_irq;
+	int mmu_irq;
 
 	void __iomem *iomem;
 	struct clk *clock;
diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
index bd41617c5e4b..7adc4441fa14 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
@@ -454,7 +454,7 @@ void panfrost_gpu_power_off(struct panfrost_device *pfdev)
 
 int panfrost_gpu_init(struct panfrost_device *pfdev)
 {
-	int err, irq;
+	int err;
 
 	err = panfrost_gpu_soft_reset(pfdev);
 	if (err)
@@ -469,11 +469,11 @@ int panfrost_gpu_init(struct panfrost_device *pfdev)
 
 	dma_set_max_seg_size(pfdev->dev, UINT_MAX);
 
-	irq = platform_get_irq_byname(to_platform_device(pfdev->dev), "gpu");
-	if (irq < 0)
-		return irq;
+	pfdev->gpu_irq = platform_get_irq_byname(to_platform_device(pfdev->dev), "gpu");
+	if (pfdev->gpu_irq < 0)
+		return pfdev->gpu_irq;
 
-	err = devm_request_irq(pfdev->dev, irq, panfrost_gpu_irq_handler,
+	err = devm_request_irq(pfdev->dev, pfdev->gpu_irq, panfrost_gpu_irq_handler,
 			       IRQF_SHARED, KBUILD_MODNAME "-gpu", pfdev);
 	if (err) {
 		dev_err(pfdev->dev, "failed to request gpu irq");
diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 846dd697c410..ac4296c1e54b 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -753,13 +753,13 @@ static irqreturn_t panfrost_mmu_irq_handler_thread(int irq, void *data)
 
 int panfrost_mmu_init(struct panfrost_device *pfdev)
 {
-	int err, irq;
+	int err;
 
-	irq = platform_get_irq_byname(to_platform_device(pfdev->dev), "mmu");
-	if (irq < 0)
-		return irq;
+	pfdev->mmu_irq = platform_get_irq_byname(to_platform_device(pfdev->dev), "mmu");
+	if (pfdev->mmu_irq < 0)
+		return pfdev->mmu_irq;
 
-	err = devm_request_threaded_irq(pfdev->dev, irq,
+	err = devm_request_threaded_irq(pfdev->dev, pfdev->mmu_irq,
 					panfrost_mmu_irq_handler,
 					panfrost_mmu_irq_handler_thread,
 					IRQF_SHARED, KBUILD_MODNAME "-mmu",
-- 
2.42.0


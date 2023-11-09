Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7E87E67E6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 11:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbjKIK0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 05:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbjKIKZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 05:25:58 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860BE2D6A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 02:25:55 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6B60E6607691;
        Thu,  9 Nov 2023 10:25:53 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699525554;
        bh=mDPKNF83uvk33KrukPYl2Hf3G8HMp0A70irMrDutJLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kqsJ6nVoRmEFtUhcnVFDAjprHsWTYSDkz4ZXgM6GLZv3eMK70VxWuCQshbrnZYB2X
         bFPG+HuoXHQJraSZV26yrDXBHO+J3ANGvYawbFDqEwKxW/wAkOPZEbBx4vNs5vHLfu
         Pq9IgeN89QL9Vow0QkgqF5rMZOnIIfJmclvlVSvGJLJfLtOoZdWVzaYEyzOGXFjEQ/
         nk0BhqGKD7dux/fTnvhHOFSHBcVMpquJ9OUHFFix/MhGk2zkNKP6GnEapX1lG3lHu0
         iJPrQDzGtCh9MHPTU6RQxbpoNI6GFbWmdlR+rhwzbpOs+rLjnTTMx4JtxPi95mnLW8
         +9ZzLvLKCVXLQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     boris.brezillon@collabora.com
Cc:     robh@kernel.org, steven.price@arm.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        wenst@chromium.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com
Subject: [PATCH v3 5/6] drm/panfrost: Implement ability to turn on/off regulators in suspend
Date:   Thu,  9 Nov 2023 11:25:42 +0100
Message-ID: <20231109102543.42971-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231109102543.42971-1-angelogioacchino.delregno@collabora.com>
References: <20231109102543.42971-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms/SoCs can power off the GPU entirely by completely cutting
off power, greatly enhancing battery time during system suspend: add a
new pm_feature GPU_PM_VREG_OFF to allow turning off the GPU regulators
during full suspend only on selected platforms.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 19 ++++++++++++++++++-
 drivers/gpu/drm/panfrost/panfrost_device.h |  2 ++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index b4ddbc3b8069..c90ad5ee34e7 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -431,10 +431,21 @@ static int panfrost_device_resume(struct device *dev)
 	struct panfrost_device *pfdev = dev_get_drvdata(dev);
 	int ret;
 
+	if (pfdev->comp->pm_features & BIT(GPU_PM_VREG_OFF)) {
+		unsigned long freq = pfdev->pfdevfreq.fast_rate;
+		struct dev_pm_opp *opp;
+
+		opp = dev_pm_opp_find_freq_ceil(dev, &freq);
+		if (IS_ERR(opp))
+			return PTR_ERR(opp);
+		dev_pm_opp_set_opp(dev, opp);
+		dev_pm_opp_put(opp);
+	}
+
 	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS)) {
 		ret = clk_enable(pfdev->clock);
 		if (ret)
-			return ret;
+			goto err_clk;
 
 		if (pfdev->bus_clock) {
 			ret = clk_enable(pfdev->bus_clock);
@@ -455,6 +466,9 @@ static int panfrost_device_resume(struct device *dev)
 err_bus_clk:
 	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS))
 		clk_disable(pfdev->clock);
+err_clk:
+	if (pfdev->comp->pm_features & BIT(GPU_PM_VREG_OFF))
+		dev_pm_opp_set_opp(dev, NULL);
 	return ret;
 }
 
@@ -474,6 +488,9 @@ static int panfrost_device_suspend(struct device *dev)
 		clk_disable(pfdev->clock);
 	}
 
+	if (pfdev->comp->pm_features & BIT(GPU_PM_VREG_OFF))
+		dev_pm_opp_set_opp(dev, NULL);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index d7f179eb8ea3..0fc558db6bfd 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -28,9 +28,11 @@ struct panfrost_perfcnt;
 /**
  * enum panfrost_gpu_pm - Supported kernel power management features
  * @GPU_PM_CLK_DIS:  Allow disabling clocks during system suspend
+ * @GPU_PM_VREG_OFF: Allow turning off regulators during system suspend
  */
 enum panfrost_gpu_pm {
 	GPU_PM_CLK_DIS,
+	GPU_PM_VREG_OFF,
 };
 
 struct panfrost_features {
-- 
2.42.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DF67FBA63
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 13:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344683AbjK1MpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 07:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344636AbjK1MpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 07:45:12 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275F6D4C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 04:45:19 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C4FFF66072EC;
        Tue, 28 Nov 2023 12:45:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701175518;
        bh=/S8eup1D2CWj7TmAUaPQ57/El8xDPM8qkSVEq3I7Q4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nx7pbJULBrQbAJNvMwJ4VILLXbeYd3V0UTdDsVOZhI1hrUK8JMW9wfeWSsZRq3SzB
         Oc3WJIcntK6YtZ7v9xTw/5QZVnEyhK/l2Qghr4WsXTD/gl7dIYnFjxbigiJ+x3+L7O
         XCegF59MpXiQ6KuHv8KOBZAnecVgpAuLuqp632+LY9ewZzYUlS9CMQrom0FspGZt0m
         Ui5EQFerWwnd6DoKTrGJG6+4l8bALyWh1FI1TeuQGFNF66VVFKjFELVAp3qbOKVlo6
         TIiv09LWQkVdFD/OpTwZvSOyEmVvrQkSzYUpD7FUi6em4B/jdRsHooIhLIwra2jvC5
         CbMpcSTgWrReQ==
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
Subject: [PATCH v2 1/3] drm/panfrost: Ignore core_mask for poweroff and disable PWRTRANS irq
Date:   Tue, 28 Nov 2023 13:45:08 +0100
Message-ID: <20231128124510.391007-2-angelogioacchino.delregno@collabora.com>
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

Some SoCs may be equipped with a GPU containing two core groups
and this is exactly the case of Samsung's Exynos 5422 featuring
an ARM Mali-T628 MP6 GPU: the support for this GPU in Panfrost
is partial, as this driver currently supports using only one
core group and that's reflected on all parts of it, including
the power on (and power off, previously to this patch) function.

The issue with this is that even though executing the soft reset
operation should power off all cores unconditionally, on at least
one platform we're seeing a crash that seems to be happening due
to an interrupt firing which may be because we are calling power
transition only on the first core group, leaving the second one
unchanged, or because ISR execution was pending before entering
the panfrost_gpu_power_off() function and executed after powering
off the GPU cores, or all of the above.

Finally, solve this by:
 - Avoid to enable the power transition interrupt on reset; and
 - Ignoring the core_mask and ask the GPU to poweroff both core groups

Fixes: 22aa1a209018 ("drm/panfrost: Really power off GPU cores in panfrost_gpu_power_off()")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_gpu.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
index 09f5e1563ebd..bd41617c5e4b 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
@@ -78,7 +78,12 @@ int panfrost_gpu_soft_reset(struct panfrost_device *pfdev)
 	}
 
 	gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_MASK_ALL);
-	gpu_write(pfdev, GPU_INT_MASK, GPU_IRQ_MASK_ALL);
+
+	/* Only enable the interrupts we care about */
+	gpu_write(pfdev, GPU_INT_MASK,
+		  GPU_IRQ_MASK_ERROR |
+		  GPU_IRQ_PERFCNT_SAMPLE_COMPLETED |
+		  GPU_IRQ_CLEAN_CACHES_COMPLETED);
 
 	/*
 	 * All in-flight jobs should have released their cycle
@@ -425,11 +430,10 @@ void panfrost_gpu_power_on(struct panfrost_device *pfdev)
 
 void panfrost_gpu_power_off(struct panfrost_device *pfdev)
 {
-	u64 core_mask = panfrost_get_core_mask(pfdev);
 	int ret;
 	u32 val;
 
-	gpu_write(pfdev, SHADER_PWROFF_LO, pfdev->features.shader_present & core_mask);
+	gpu_write(pfdev, SHADER_PWROFF_LO, pfdev->features.shader_present);
 	ret = readl_relaxed_poll_timeout(pfdev->iomem + SHADER_PWRTRANS_LO,
 					 val, !val, 1, 1000);
 	if (ret)
@@ -441,7 +445,7 @@ void panfrost_gpu_power_off(struct panfrost_device *pfdev)
 	if (ret)
 		dev_err(pfdev->dev, "tiler power transition timeout");
 
-	gpu_write(pfdev, L2_PWROFF_LO, pfdev->features.l2_present & core_mask);
+	gpu_write(pfdev, L2_PWROFF_LO, pfdev->features.l2_present);
 	ret = readl_poll_timeout(pfdev->iomem + L2_PWRTRANS_LO,
 				 val, !val, 0, 1000);
 	if (ret)
-- 
2.42.0


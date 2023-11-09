Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97AFC7E67E0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 11:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbjKIK0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 05:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbjKIKZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 05:25:54 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D6E211B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 02:25:52 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 06ED86607498;
        Thu,  9 Nov 2023 10:25:49 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699525550;
        bh=jhmRrLJp8PH/G9FAfR90YAI0hEC9baxhyFV4GjT06UY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TC3Ee+3kBEGYswGdMICLfNwD55LYTBEzx3QrQ79ZJac8J0ZTY9+wynVAUNrptV6fI
         mRXK7sRtgFV4Or1ReQGtXOJs7bdtF95l/t0ZgXsrxGQ2/IB35YqaPGUJZq9p+KJGUi
         T9Rbz3uP+3DwzOhMcusBlthxvnoLymyAwrO2dDAAAae8KA+bOq455C5uu7YBshWmFw
         TEy9bm2gyeGUUYmk8uQydmub5+epdiJsed0wUZe10QFoxSgmP0Cw+6aA8N4m9U+cfH
         2rR6EOJYj8JCzFUv7NYw7fpypkC69gIxlGeZRzUOinAoNaR04QI2yPRRcizC+69Stw
         TbTs4YjpmBmVQ==
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
Subject: [PATCH v3 2/6] drm/panfrost: Tighten polling for soft reset and power on
Date:   Thu,  9 Nov 2023 11:25:39 +0100
Message-ID: <20231109102543.42971-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231109102543.42971-1-angelogioacchino.delregno@collabora.com>
References: <20231109102543.42971-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In many cases, soft reset takes more than 1 microsecond, but definitely
less than 10; moreover in the poweron flow, tilers, shaders and l2 will
become ready (each) in less than 10 microseconds as well.

Even in the cases (at least on my platforms, rarely) in which those take
more than 10 microseconds, it's very unlikely to see both soft reset and
poweron to take more than 70 microseconds.

Shorten the polling delay to 10 microseconds to consistently reduce the
runtime resume time of the GPU.

As an indicative example, measurements taken on a MediaTek MT8195 SoC

Average runtime resume time in nanoseconds before this commit:
GDM, user selection up/down:            88435ns
GDM, Text Entry (typing user/password): 91489ns
GNOME Desktop, idling, GKRELLM running: 73200ns

After this commit:

GDM: user selection up/down:            26690ns
GDM: Text Entry (typing user/password): 27917ns
GNOME Desktop, idling, GKRELLM running:	25304ns

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panfrost/panfrost_gpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
index ae3f7d97bb47..69179bc9677d 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
@@ -63,7 +63,7 @@ int panfrost_gpu_soft_reset(struct panfrost_device *pfdev)
 
 	gpu_write(pfdev, GPU_CMD, GPU_CMD_SOFT_RESET);
 	ret = readl_relaxed_poll_timeout(pfdev->iomem + GPU_INT_RAWSTAT,
-		val, val & GPU_IRQ_RESET_COMPLETED, 100, 10000);
+		val, val & GPU_IRQ_RESET_COMPLETED, 10, 10000);
 
 	if (ret) {
 		dev_err(pfdev->dev, "gpu soft reset timed out, attempting hard reset\n");
@@ -394,7 +394,7 @@ void panfrost_gpu_power_on(struct panfrost_device *pfdev)
 	gpu_write(pfdev, L2_PWRON_LO, pfdev->features.l2_present & core_mask);
 	ret = readl_relaxed_poll_timeout(pfdev->iomem + L2_READY_LO,
 		val, val == (pfdev->features.l2_present & core_mask),
-		100, 20000);
+		10, 20000);
 	if (ret)
 		dev_err(pfdev->dev, "error powering up gpu L2");
 
@@ -402,13 +402,13 @@ void panfrost_gpu_power_on(struct panfrost_device *pfdev)
 		  pfdev->features.shader_present & core_mask);
 	ret = readl_relaxed_poll_timeout(pfdev->iomem + SHADER_READY_LO,
 		val, val == (pfdev->features.shader_present & core_mask),
-		100, 20000);
+		10, 20000);
 	if (ret)
 		dev_err(pfdev->dev, "error powering up gpu shader");
 
 	gpu_write(pfdev, TILER_PWRON_LO, pfdev->features.tiler_present);
 	ret = readl_relaxed_poll_timeout(pfdev->iomem + TILER_READY_LO,
-		val, val == pfdev->features.tiler_present, 100, 1000);
+		val, val == pfdev->features.tiler_present, 10, 1000);
 	if (ret)
 		dev_err(pfdev->dev, "error powering up gpu tiler");
 }
-- 
2.42.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CE87DF4EA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 15:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376813AbjKBO1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 10:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235289AbjKBO1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 10:27:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06039194
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 07:26:53 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 84BF26607090;
        Thu,  2 Nov 2023 14:26:51 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698935212;
        bh=YtQIX3FzdJuXHKbLB+mWiM8MZF5dRqqjsu5pKi6GDpo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MDdZALRE8B7hJslAhU/2RIDb5x31cIH0sNSiNrdFukx3ZHZAlOZ9j/x7M/MpV52tw
         fOqLTV21Dih3ht0oUIjqlSCS3EOCwwZSr3qjBMKGPO1BsO/ilOFuWnXzoCWC1HinC3
         bFcuRTy/UUPl5I2aUcAtpYeSbSMBkPoVdkEtZNvAdBBZSR5lpblPAZgtwuOROylx4o
         nZHioQRwF4i1AfsEngo4ZHKgv7ubTOFE8tMzxEEXCOqsvFpylzAX8ydr7P0Zo36qbZ
         i7ly919US5lxyLIRt2fElYz3iqoO+c7JbPuKBPPP8GDBvwD+xSnm3DTNpJwDtsYjY/
         xwsYs+gU4mbmA==
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
Subject: [PATCH v2 1/6] drm/panfrost: Perform hard reset to recover GPU if soft reset fails
Date:   Thu,  2 Nov 2023 15:26:38 +0100
Message-ID: <20231102142643.75288-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231102142643.75288-1-angelogioacchino.delregno@collabora.com>
References: <20231102142643.75288-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though soft reset should ideally never fail, during development of
some power management features I managed to get some bits wrong: this
resulted in GPU soft reset failures, where the GPU was never able to
recover, not even after suspend/resume cycles, meaning that the only
way to get functionality back was to reboot the machine.

Perform a hard reset after a soft reset failure to be able to recover
the GPU during runtime (so, without any machine reboot).

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_gpu.c  | 14 ++++++++++----
 drivers/gpu/drm/panfrost/panfrost_regs.h |  1 +
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
index fad75b6e543e..7e9e2cf26e4d 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
@@ -60,14 +60,20 @@ int panfrost_gpu_soft_reset(struct panfrost_device *pfdev)
 
 	gpu_write(pfdev, GPU_INT_MASK, 0);
 	gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_RESET_COMPLETED);
-	gpu_write(pfdev, GPU_CMD, GPU_CMD_SOFT_RESET);
 
+	gpu_write(pfdev, GPU_CMD, GPU_CMD_SOFT_RESET);
 	ret = readl_relaxed_poll_timeout(pfdev->iomem + GPU_INT_RAWSTAT,
 		val, val & GPU_IRQ_RESET_COMPLETED, 100, 10000);
-
 	if (ret) {
-		dev_err(pfdev->dev, "gpu soft reset timed out\n");
-		return ret;
+		dev_err(pfdev->dev, "gpu soft reset timed out, attempting hard reset\n");
+
+		gpu_write(pfdev, GPU_CMD, GPU_CMD_HARD_RESET);
+		ret = readl_relaxed_poll_timeout(pfdev->iomem + GPU_INT_RAWSTAT,
+			val, val & GPU_IRQ_RESET_COMPLETED, 100, 10000);
+		if (ret) {
+			dev_err(pfdev->dev, "gpu hard reset timed out\n");
+			return ret;
+		}
 	}
 
 	gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_MASK_ALL);
diff --git a/drivers/gpu/drm/panfrost/panfrost_regs.h b/drivers/gpu/drm/panfrost/panfrost_regs.h
index 55ec807550b3..c25743b05c55 100644
--- a/drivers/gpu/drm/panfrost/panfrost_regs.h
+++ b/drivers/gpu/drm/panfrost/panfrost_regs.h
@@ -44,6 +44,7 @@
 	 GPU_IRQ_MULTIPLE_FAULT)
 #define GPU_CMD				0x30
 #define   GPU_CMD_SOFT_RESET		0x01
+#define   GPU_CMD_HARD_RESET		0x02
 #define   GPU_CMD_PERFCNT_CLEAR		0x03
 #define   GPU_CMD_PERFCNT_SAMPLE	0x04
 #define   GPU_CMD_CYCLE_COUNT_START	0x05
-- 
2.42.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82932771770
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 02:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjHGAFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 20:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHGAFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 20:05:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AB7FA
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 17:05:06 -0700 (PDT)
Received: from workpc.. (109-252-150-127.dynamic.spd-mgts.ru [109.252.150.127])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7D27A660711A;
        Mon,  7 Aug 2023 01:05:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691366704;
        bh=zxAsuZOqI5T9dSHzdfn9q25oiwiUf0oORASmCnorRKs=;
        h=From:To:Cc:Subject:Date:From;
        b=HRStPPOmPmcRYmy16V3Yif2MhylntUx0MSOU6dqy4iQJmQV9cpyKvwMkwidvbDDkB
         REo4Ju0loyZlofyAUGCjWxPvnu+hOxVmeYeQql5EiMLKuDJMFSlU6lG5snEKk0/HXb
         bi5WlKrP+NLd6c6/RHTn1amblRyBof4IFcXAS/wZWiOmu3KjXNH5yxwlUXkgcVMnIv
         0CAdrsmWGfNIak6gwiIieA4mvsvZg+Dr3iURPvaUBkmLZy6ybyqYjMNQyH3SdAXzJC
         mTqI+FEiR1NI1DLgoZnLMm8TxqZozMPTDd8APBphlINNeU8qIuCLfzRMQ7iL+VdX5v
         8bMouR/Y1szQQ==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v4] drm/panfrost: Sync IRQ by job's timeout handler
Date:   Mon,  7 Aug 2023 03:04:44 +0300
Message-ID: <20230807000444.14926-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Panfrost IRQ handler may stuck for a long time, for example this happens
when there is a bad HDMI connection and HDMI handler takes a long time to
finish processing, holding Panfrost. Make Panfrost's job timeout handler
to sync IRQ before checking fence signal status in order to prevent
spurious job timeouts due to a slow IRQ processing.

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> # MediaTek MT8192 and MT8195 Chromebooks
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---

Changelog:

v4: - Improved comment like was suggested by Boris and added his r-b.

v3: - Added comment to the code as was suggested by Boris

    - Added r-b/t-b from Steven and Angelo

v2: - Moved synchronize_irq() after first signal-check to avoid unnecessary
      blocking on syncing.

    - Added warn message about high interrupt latency.

 drivers/gpu/drm/panfrost/panfrost_job.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index dbc597ab46fb..db6d9a17004f 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -720,6 +720,22 @@ static enum drm_gpu_sched_stat panfrost_job_timedout(struct drm_sched_job
 	if (dma_fence_is_signaled(job->done_fence))
 		return DRM_GPU_SCHED_STAT_NOMINAL;
 
+	/*
+	 * Panfrost IRQ handler may take a long time to process an interrupt
+	 * if there is another IRQ handler hogging the processing.
+	 * For example, the HDMI encoder driver might be stuck in the IRQ
+	 * handler for a significant time in a case of bad cable connection.
+	 * In order to catch such cases and not report spurious Panfrost
+	 * job timeouts, synchronize the IRQ handler and re-check the fence
+	 * status.
+	 */
+	synchronize_irq(pfdev->js->irq);
+
+	if (dma_fence_is_signaled(job->done_fence)) {
+		dev_warn(pfdev->dev, "unexpectedly high interrupt latency\n");
+		return DRM_GPU_SCHED_STAT_NOMINAL;
+	}
+
 	dev_err(pfdev->dev, "gpu sched timeout, js=%d, config=0x%x, status=0x%x, head=0x%x, tail=0x%x, sched_job=%p",
 		js,
 		job_read(pfdev, JS_CONFIG(js)),
-- 
2.41.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B351D75DF74
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 02:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjGWADG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 20:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjGWAC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 20:02:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F9F1B2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 17:02:55 -0700 (PDT)
Received: from workpc.. (109-252-150-127.dynamic.spd-mgts.ru [109.252.150.127])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F11386606EFD;
        Sun, 23 Jul 2023 01:02:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690070574;
        bh=GUuN4Hv+kEehufgIB+sVRE0fxNfkqINjDEaKIO9+P1Q=;
        h=From:To:Cc:Subject:Date:From;
        b=AqGbeV6pC2fIb/cqylud/UkiC8DxdE0s/TJYG5HnWornI3FbcLwir3HZxPb08Rh63
         DKmQkuJyJ9/New8LCz6h5fxvTfnjGAxOJ0q2u0+27itaQXiOjHcMRpBmA8sI7KBixO
         9xnu4sVyGaGGXVMB7UFZt8Fx9irW6ZiuaWBbREuDxkmNNqULMlnUOyyoXK2us5Vfn1
         KCcMz4pTLl7k79AFBBr1QLzvPvsi92e5aMo5GjeInznloDxr2Hhjj2Jo6z7GTtMrjv
         zoHkRk+sJbFteXAi+WwSt0mNQKw9rzt2wLnups1KKQSQ2Briyf8Ujy6eh9I+sktCbQ
         7PcR+ZKCGuUGA==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v2] drm/panfrost: Sync IRQ by job's timeout handler
Date:   Sun, 23 Jul 2023 03:01:42 +0300
Message-ID: <20230723000142.206908-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.41.0
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

Panfrost IRQ handler may stuck for a long time, for example this happens
when there is a bad HDMI connection and HDMI handler takes a long time to
finish processing, holding Panfrost. Make Panfrost's job timeout handler
to sync IRQ before checking fence signal status in order to prevent
spurious job timeouts due to a slow IRQ processing.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---

Changelog:

v2: - Moved synchronize_irq() after first signal-check to avoid unnecessary
      blocking on syncing.

    - Added warn message about high interrupt latency.

 drivers/gpu/drm/panfrost/panfrost_job.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index dbc597ab46fb..a7663d7847a2 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -720,6 +720,13 @@ static enum drm_gpu_sched_stat panfrost_job_timedout(struct drm_sched_job
 	if (dma_fence_is_signaled(job->done_fence))
 		return DRM_GPU_SCHED_STAT_NOMINAL;
 
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


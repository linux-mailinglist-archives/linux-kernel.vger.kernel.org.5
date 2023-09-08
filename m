Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE29798F46
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244977AbjIHTbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344677AbjIHTbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:31:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EE31FF2;
        Fri,  8 Sep 2023 12:30:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260BDC433AD;
        Fri,  8 Sep 2023 19:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694201425;
        bh=xG9GQMOTI4mi/zgIV2y6S/fAF8a0rOXL7+eWFhaQDpk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CqNnMgiZyF0sv6oxl6GQr40oTKK1voAQBVoZH18U0mslC2qnbRtrP9I4ebVWUAsYS
         h0oYcrImhqaTBXzj2ZYW02b3jEX16PyViPVi9sZIqqVcWVNxLJSyGjaZf1Ry2wy9qC
         j+2rKVedICc4+sjWYwDaIuM2vq4sGvvihxMcwqHhqiIhwl4RgoEqJVXmICp4eLuPcw
         Ir3RuJADUJpuCe3XOXwyJ88b0ZK43NGFSLiZasVuAR99o7+Cnrnyiv0KBcLRDRMXb5
         T8zlB/2Pt+X3EGog5/5d/HIJYh8MKsFLBp+tYHPaMFdrrgtqgOHKKv7mxyxzOXBmEd
         q3b5KHRFkie0g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
        Arthur Grillo <arthurgrillo@riseup.net>,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
        Sasha Levin <sashal@kernel.org>, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.5 16/36] drm/vkms: Fix race-condition between the hrtimer and the atomic commit
Date:   Fri,  8 Sep 2023 15:28:27 -0400
Message-Id: <20230908192848.3462476-16-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908192848.3462476-1-sashal@kernel.org>
References: <20230908192848.3462476-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.2
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maíra Canal <mcanal@igalia.com>

[ Upstream commit a0e6a017ab56936c0405fe914a793b241ed25ee0 ]

Currently, it is possible for the composer to be set as enabled and then
as disabled without a proper call for the vkms_vblank_simulate(). This
is problematic, because the driver would skip one CRC output, causing CRC
tests to fail. Therefore, we need to make sure that, for each time the
composer is set as enabled, a composer job is added to the queue.

In order to provide this guarantee, add a mutex that will lock before
the composer is set as enabled and will unlock only after the composer
job is added to the queue. This way, we can have a guarantee that the
driver won't skip a CRC entry.

This race-condition is affecting the IGT test "writeback-check-output",
making the test fail and also, leaking writeback framebuffers, as the
writeback job is queued, but it is not signaled. This patch avoids both
problems.

[v2]:
    * Create a new mutex and keep the spinlock across the atomic commit in
      order to avoid interrupts that could result in deadlocks.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
Reviewed-by: Arthur Grillo <arthurgrillo@riseup.net>
Signed-off-by: Maíra Canal <mairacanal@riseup.net>
Link: https://patchwork.freedesktop.org/patch/msgid/20230523123207.173976-1-mcanal@igalia.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vkms/vkms_composer.c | 9 +++++++--
 drivers/gpu/drm/vkms/vkms_crtc.c     | 9 +++++----
 drivers/gpu/drm/vkms/vkms_drv.h      | 4 +++-
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 906d3df40cdbe..b12188fd6b388 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -320,10 +320,15 @@ void vkms_set_composer(struct vkms_output *out, bool enabled)
 	if (enabled)
 		drm_crtc_vblank_get(&out->crtc);
 
-	spin_lock_irq(&out->lock);
+	mutex_lock(&out->enabled_lock);
 	old_enabled = out->composer_enabled;
 	out->composer_enabled = enabled;
-	spin_unlock_irq(&out->lock);
+
+	/* the composition wasn't enabled, so unlock the lock to make sure the lock
+	 * will be balanced even if we have a failed commit
+	 */
+	if (!out->composer_enabled)
+		mutex_unlock(&out->enabled_lock);
 
 	if (old_enabled)
 		drm_crtc_vblank_put(&out->crtc);
diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index 515f6772b8663..3079013c8b32f 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -16,7 +16,7 @@ static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
 	struct drm_crtc *crtc = &output->crtc;
 	struct vkms_crtc_state *state;
 	u64 ret_overrun;
-	bool ret, fence_cookie;
+	bool ret, fence_cookie, composer_enabled;
 
 	fence_cookie = dma_fence_begin_signalling();
 
@@ -25,15 +25,15 @@ static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
 	if (ret_overrun != 1)
 		pr_warn("%s: vblank timer overrun\n", __func__);
 
-	spin_lock(&output->lock);
 	ret = drm_crtc_handle_vblank(crtc);
 	if (!ret)
 		DRM_ERROR("vkms failure on handling vblank");
 
 	state = output->composer_state;
-	spin_unlock(&output->lock);
+	composer_enabled = output->composer_enabled;
+	mutex_unlock(&output->enabled_lock);
 
-	if (state && output->composer_enabled) {
+	if (state && composer_enabled) {
 		u64 frame = drm_crtc_accurate_vblank_count(crtc);
 
 		/* update frame_start only if a queued vkms_composer_worker()
@@ -292,6 +292,7 @@ int vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 
 	spin_lock_init(&vkms_out->lock);
 	spin_lock_init(&vkms_out->composer_lock);
+	mutex_init(&vkms_out->enabled_lock);
 
 	vkms_out->composer_workq = alloc_ordered_workqueue("vkms_composer", 0);
 	if (!vkms_out->composer_workq)
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 5f1a0a44a78cf..dcf4e302fb4db 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -100,8 +100,10 @@ struct vkms_output {
 	struct workqueue_struct *composer_workq;
 	/* protects concurrent access to composer */
 	spinlock_t lock;
+	/* guarantees that if the composer is enabled, a job will be queued */
+	struct mutex enabled_lock;
 
-	/* protected by @lock */
+	/* protected by @enabled_lock */
 	bool composer_enabled;
 	struct vkms_crtc_state *composer_state;
 
-- 
2.40.1


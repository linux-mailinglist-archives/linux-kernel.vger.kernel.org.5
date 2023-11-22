Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0445D7F4C34
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjKVQUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 11:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbjKVQUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:20:43 -0500
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1659F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=F4k94dWeA9E9cnOAfUovq7CO/D9PnaeF/xo2VAuyrQ8=; b=nJBdGwjvU0dNBeukokNJqEIt7q
        NFXNy1p2tlY4GBZFgTcFSWqROlfrIIN6rZ7Fv/i6Rk5NFGzjEKS94pUIrnDizTttanSJQrW+0ZY2M
        0rE4g0GrVr+OO/SUHU+45K8EpMIbFv7CIrB5fN4FSl+ULA0QMv0RFyEeA5MSamvEKMYQmrrKzfJGt
        wJ2tSDKWa+Zz+uoXQixgEXr/wiRRdg+le9/bvVarqqJIkIe5atEnnnKwoIVhS7FF+hhsymFhYC1Zb
        en9mBJ6qTNWfs7I0nbkWCwX5u6V0k2A6omOOsr10aFvS56D0zR4/xJHGfY0f9Fsft9RDGzAmgmODI
        E6wV9pMQ==;
Received: from 189-69-166-209.dial-up.telesp.net.br ([189.69.166.209] helo=steammachine.lan)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1r5pxs-0061lT-RP; Wed, 22 Nov 2023 17:20:37 +0100
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
        Simon Ser <contact@emersion.fr>,
        Rob Clark <robdclark@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>, daniel@ffwll.ch,
        Daniel Stone <daniel@fooishbar.org>,
        =?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        ville.syrjala@linux.intel.com, intel-gfx@lists.freedesktop.org,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v9 2/4] drm: allow DRM_MODE_PAGE_FLIP_ASYNC for atomic commits
Date:   Wed, 22 Nov 2023 13:19:39 -0300
Message-ID: <20231122161941.320564-3-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231122161941.320564-1-andrealmeid@igalia.com>
References: <20231122161941.320564-1-andrealmeid@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Simon Ser <contact@emersion.fr>

If the driver supports it, allow user-space to supply the
DRM_MODE_PAGE_FLIP_ASYNC flag to request an async page-flip.
Set drm_crtc_state.async_flip accordingly.

Document that drivers will reject atomic commits if an async
flip isn't possible. This allows user-space to fall back to
something else. For instance, Xorg falls back to a blit.
Another option is to wait as close to the next vblank as
possible before performing the page-flip to reduce latency.

Signed-off-by: Simon Ser <contact@emersion.fr>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Co-developed-by: André Almeida <andrealmeid@igalia.com>
Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
v9: dropped atomic_async_page_flip_not_supported
---
 drivers/gpu/drm/drm_atomic_uapi.c | 25 ++++++++++++++++++++++---
 include/uapi/drm/drm_mode.h       |  9 +++++++++
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index ed46133a2dd7..de4265423ddc 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1368,6 +1368,18 @@ static void complete_signaling(struct drm_device *dev,
 	kfree(fence_state);
 }
 
+static void
+set_async_flip(struct drm_atomic_state *state)
+{
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *crtc_state;
+	int i;
+
+	for_each_new_crtc_in_state(state, crtc, crtc_state, i) {
+		crtc_state->async_flip = true;
+	}
+}
+
 int drm_mode_atomic_ioctl(struct drm_device *dev,
 			  void *data, struct drm_file *file_priv)
 {
@@ -1409,9 +1421,13 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
 	}
 
 	if (arg->flags & DRM_MODE_PAGE_FLIP_ASYNC) {
-		drm_dbg_atomic(dev,
-			       "commit failed: invalid flag DRM_MODE_PAGE_FLIP_ASYNC\n");
-		return -EINVAL;
+		if (!dev->mode_config.async_page_flip) {
+			drm_dbg_atomic(dev,
+				       "commit failed: DRM_MODE_PAGE_FLIP_ASYNC not supported\n");
+			return -EINVAL;
+		}
+
+		async_flip = true;
 	}
 
 	/* can't test and expect an event at the same time. */
@@ -1514,6 +1530,9 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
 	if (ret)
 		goto out;
 
+	if (arg->flags & DRM_MODE_PAGE_FLIP_ASYNC)
+		set_async_flip(state);
+
 	if (arg->flags & DRM_MODE_ATOMIC_TEST_ONLY) {
 		ret = drm_atomic_check_only(state);
 	} else if (arg->flags & DRM_MODE_ATOMIC_NONBLOCK) {
diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index 09e7a471ee30..95630f170110 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -957,6 +957,15 @@ struct hdr_output_metadata {
  * Request that the page-flip is performed as soon as possible, ie. with no
  * delay due to waiting for vblank. This may cause tearing to be visible on
  * the screen.
+ *
+ * When used with atomic uAPI, the driver will return an error if the hardware
+ * doesn't support performing an asynchronous page-flip for this update.
+ * User-space should handle this, e.g. by falling back to a regular page-flip.
+ *
+ * Note, some hardware might need to perform one last synchronous page-flip
+ * before being able to switch to asynchronous page-flips. As an exception,
+ * the driver will return success even though that first page-flip is not
+ * asynchronous.
  */
 #define DRM_MODE_PAGE_FLIP_ASYNC 0x02
 #define DRM_MODE_PAGE_FLIP_TARGET_ABSOLUTE 0x4
-- 
2.42.1


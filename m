Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0451777D2B7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 20:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239597AbjHOS6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 14:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239581AbjHOS6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 14:58:02 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52C41FCF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 11:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=QXd4W2wFaxhhDN1Y2AZplTF5r+QGrQy4P17x4sfG4Dw=; b=p5TQt0RmbPuevG/OlV6kpggsgz
        kIjeZ3mAlB7e4dg5Ap4ojk+DMxCKFCDhHU3h4D9p9nWnGLlwRXZp2QwjGqXRQpe4WtO40bEIarwuR
        VjH3R9bRHehsfLq+8hq3qR1rHLqnU91hG/f0nG+WXimmsvGQ80NzP928HV9ZMIWEkvnE6VYzylqZo
        geMtGYQSCRAGa+2hQ6domzcCauVvq950GsVl7Y9Ehyx2xtMxLgfsAPQT+2Hx/6WvufR1wlMjqC6ij
        7CeFXHftmO6wfwn3rd1r3t5sTecgpqAy6Lhf+BZ6PMb40QhxPfavX8wiu1byd3qIBbbYBkhOvawUM
        zerB2oBQ==;
Received: from [191.193.179.209] (helo=steammachine.lan)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qVzEc-001Ca3-3s; Tue, 15 Aug 2023 20:57:42 +0200
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, wayland-devel@lists.freedesktop.org
Cc:     kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
        Simon Ser <contact@emersion.fr>,
        Rob Clark <robdclark@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Stone <daniel@fooishbar.org>,
        =?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
        Randy Dunlap <rdunlap@infradead.org>, hwentlan@amd.com,
        joshua@froggi.es, ville.syrjala@linux.intel.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v6 3/6] drm: introduce drm_mode_config.atomic_async_page_flip_not_supported
Date:   Tue, 15 Aug 2023 15:57:07 -0300
Message-ID: <20230815185710.159779-4-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815185710.159779-1-andrealmeid@igalia.com>
References: <20230815185710.159779-1-andrealmeid@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Ser <contact@emersion.fr>

This new field indicates whether the driver has the necessary logic
to support async page-flips via the atomic uAPI. This is leveraged by
the next commit to allow user-space to use this functionality.

All atomic drivers setting drm_mode_config.async_page_flip are updated
to also set drm_mode_config.atomic_async_page_flip_not_supported. We
will gradually check and update these drivers to properly handle
drm_crtc_state.async_flip in their atomic logic.

The goal of this negative flag is the same as
fb_modifiers_not_supported: we want to eventually get rid of all
drivers missing atomic support for async flips. New drivers should not
set this flag, instead they should support atomic async flips (if
they support async flips at all). IOW, we don't want more drivers
with async flip support for legacy but not atomic.

Signed-off-by: Simon Ser <contact@emersion.fr>
Reviewed-by: André Almeida <andrealmeid@igalia.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
v5: no changes
v4: no changes
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   |  1 +
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c        |  1 +
 drivers/gpu/drm/i915/display/intel_display_driver.c |  1 +
 drivers/gpu/drm/nouveau/nouveau_display.c           |  1 +
 include/drm/drm_mode_config.h                       | 11 +++++++++++
 5 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4d3d6009838c..4b433793f5a0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3924,6 +3924,7 @@ static int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
 		adev_to_drm(adev)->mode_config.prefer_shadow = 1;
 	/* indicates support for immediate flip */
 	adev_to_drm(adev)->mode_config.async_page_flip = true;
+	adev_to_drm(adev)->mode_config.atomic_async_page_flip_not_supported = true;
 
 	state = kzalloc(sizeof(*state), GFP_KERNEL);
 	if (!state)
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
index fa0f9a93d50d..301b222c410d 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -639,6 +639,7 @@ static int atmel_hlcdc_dc_modeset_init(struct drm_device *dev)
 	dev->mode_config.max_height = dc->desc->max_height;
 	dev->mode_config.funcs = &mode_config_funcs;
 	dev->mode_config.async_page_flip = true;
+	dev->mode_config.atomic_async_page_flip_not_supported = true;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/i915/display/intel_display_driver.c b/drivers/gpu/drm/i915/display/intel_display_driver.c
index 8f144d4d3c39..f290c5c2e3c9 100644
--- a/drivers/gpu/drm/i915/display/intel_display_driver.c
+++ b/drivers/gpu/drm/i915/display/intel_display_driver.c
@@ -123,6 +123,7 @@ static void intel_mode_config_init(struct drm_i915_private *i915)
 	mode_config->helper_private = &intel_mode_config_funcs;
 
 	mode_config->async_page_flip = HAS_ASYNC_FLIPS(i915);
+	mode_config->atomic_async_page_flip_not_supported = true;
 
 	/*
 	 * Maximum framebuffer dimensions, chosen to match
diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/nouveau/nouveau_display.c
index 99977e5fe716..540895dabfc7 100644
--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -720,6 +720,7 @@ nouveau_display_create(struct drm_device *dev)
 		dev->mode_config.async_page_flip = false;
 	else
 		dev->mode_config.async_page_flip = true;
+	dev->mode_config.atomic_async_page_flip_not_supported = true;
 
 	drm_kms_helper_poll_init(dev);
 	drm_kms_helper_poll_disable(dev);
diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index 973119a9176b..47b005671e6a 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -918,6 +918,17 @@ struct drm_mode_config {
 	 */
 	bool async_page_flip;
 
+	/**
+	 * @atomic_async_page_flip_not_supported:
+	 *
+	 * If true, the driver does not support async page-flips with the
+	 * atomic uAPI. This is only used by old drivers which haven't yet
+	 * accomodated for &drm_crtc_state.async_flip in their atomic logic,
+	 * even if they have &drm_mode_config.async_page_flip set to true.
+	 * New drivers shall not set this flag.
+	 */
+	bool atomic_async_page_flip_not_supported;
+
 	/**
 	 * @fb_modifiers_not_supported:
 	 *
-- 
2.41.0


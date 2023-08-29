Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC94678BDEC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 07:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbjH2Fc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 01:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235913AbjH2FcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 01:32:22 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71471A3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 22:32:17 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bdca7cc28dso31716765ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 22:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693287137; x=1693891937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krVlbfIJg4Xwe64ktDdSsSaUeBzrUM8Oc2AR2dzOgtQ=;
        b=NtzyraengkJ4gnTGdaWWFZ8YIH5HtkzCKWcQXqKcf4PkBi8YA2kD2fgx/QOALlwwyt
         Zb+aD1ihVp+tlVUm1dbRrcAwrlaXtKL0LC6MSguZDimBdVzklOHkPeKfuOoh483etPq7
         cDaXCaHniceiiwr/pf+nX7k1O0jQhpcipUCx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693287137; x=1693891937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=krVlbfIJg4Xwe64ktDdSsSaUeBzrUM8Oc2AR2dzOgtQ=;
        b=iXEuuH37tU2ACF5Tcy7ADaqRNDo7ugAZ41jnt9LSJTzUfpYPDdfajtaFNEdDSXEx9i
         ugObBVbqbHgye+jhhEKnm3Z8io+CU6jNNQw3tdDKtzm1qQy1lL2okF3c92jVX9DZ0wDr
         RHoS+kJHBwO3vC7tLE9In1m5wgESTKtCfu+9TVGW7I0waKHMyEw5jNaoVgKy2EfeBBvS
         5nrarAM7Gt9fGW5/u0SPVfBkmOpos/Wr35/ow25gD5KaPMQFle0nTN9nzGJljQ8x0qkV
         alUcVR9bNNqtvW4BPpxAjTOCOq1mvi6lGd67BYuwP/3N9hvUa4ougaduWKWe07vhcWcp
         bjQg==
X-Gm-Message-State: AOJu0YxNIMZ1e68Dw+cN3HvbxtXMd0p08DDuK5t1o3KmZ7pltVSkRpLd
        Xx0d32TWhytm9DeXB3tsxCxhVg==
X-Google-Smtp-Source: AGHT+IHKHMCi7PMPc9vOGopzObPqQopJ8ZLqFWan++E5xZTzjQJG1eTDyyZoQXGEhk29gxK9MlzI1Q==
X-Received: by 2002:a17:902:f684:b0:1bf:205e:fe5d with SMTP id l4-20020a170902f68400b001bf205efe5dmr35867745plg.7.1693287137365;
        Mon, 28 Aug 2023 22:32:17 -0700 (PDT)
Received: from datalore.c.googlers.com.com (148.175.199.104.bc.googleusercontent.com. [104.199.175.148])
        by smtp.gmail.com with ESMTPSA id g6-20020a170902c38600b001bdccf6b8c9sm8420874plg.127.2023.08.28.22.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 22:32:17 -0700 (PDT)
From:   Brandon Pollack <brpol@chromium.org>
To:     marius.vlad@collabora.com, mairacanal@riseup.net,
        jshargo@chromium.org
Cc:     corbet@lwn.net, dri-devel@lists.freedesktop.org,
        hamohammed.sa@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, melissa.srw@gmail.com,
        mripard@kernel.org, rodrigosiqueiramelo@gmail.com,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mduggan@chromium.org,
        hirono@chromium.org, Brandon Pollack <brpol@chromium.org>
Subject: [PATCH v6 3/7] drm/vkms: Provide platform data when creating VKMS devices
Date:   Tue, 29 Aug 2023 05:30:55 +0000
Message-ID: <20230829053201.423261-4-brpol@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230829053201.423261-1-brpol@chromium.org>
References: <20230829053201.423261-1-brpol@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jim Shargo <jshargo@chromium.org>

This is a small refactor to make ConfigFS support easier. This should be
a no-op refactor.

Signed-off-by: Jim Shargo <jshargo@chromium.org>
Signed-off-by: Brandon Pollack <brpol@chromium.org>
---
 drivers/gpu/drm/vkms/vkms_drv.c    | 14 ++++++++++++--
 drivers/gpu/drm/vkms/vkms_drv.h    |  9 ++++++---
 drivers/gpu/drm/vkms/vkms_output.c |  2 +-
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 65b1e2c52106..6c94c2b5d529 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -9,6 +9,7 @@
  * the GPU in DRM API tests.
  */
 
+#include "asm-generic/errno-base.h"
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -171,12 +172,14 @@ static int vkms_modeset_init(struct vkms_device *vkmsdev)
 	dev->mode_config.preferred_depth = 0;
 	dev->mode_config.helper_private = &vkms_mode_config_helpers;
 
-	return vkms_output_init(vkmsdev, 0);
+	return vkmsdev->is_default ? vkms_output_init_default(vkmsdev) :
+				     -EINVAL;
 }
 
 static int vkms_platform_probe(struct platform_device *pdev)
 {
 	int ret;
+	struct vkms_device_setup *vkms_device_setup = pdev->dev.platform_data;
 	struct vkms_device *vkms_device;
 	void *grp;
 
@@ -195,6 +198,7 @@ static int vkms_platform_probe(struct platform_device *pdev)
 	vkms_device->config.cursor = enable_cursor;
 	vkms_device->config.writeback = enable_writeback;
 	vkms_device->config.overlay = enable_overlay;
+	vkms_device->is_default = vkms_device_setup->is_default;
 
 	ret = dma_coerce_mask_and_coherent(vkms_device->drm.dev,
 					   DMA_BIT_MASK(64));
@@ -258,6 +262,9 @@ static int __init vkms_init(void)
 {
 	int ret;
 	struct platform_device *pdev;
+	struct vkms_device_setup vkms_device_setup = {
+		.is_default = true,
+	};
 
 	ret = platform_driver_register(&vkms_platform_driver);
 	if (ret) {
@@ -265,8 +272,11 @@ static int __init vkms_init(void)
 		return ret;
 	}
 
-	pdev = platform_device_register_simple(DRIVER_NAME, -1, NULL, 0);
+	pdev = platform_device_register_data(NULL, DRIVER_NAME, 0,
+					     &vkms_device_setup,
+					     sizeof(vkms_device_setup));
 	if (IS_ERR(pdev)) {
+		DRM_ERROR("Unable to register default vkms device\n");
 		platform_driver_unregister(&vkms_platform_driver);
 		return PTR_ERR(pdev);
 	}
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 761cd809617e..4262dcffd7e1 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -132,17 +132,20 @@ struct vkms_output {
 	struct vkms_plane planes[VKMS_MAX_PLANES];
 };
 
-struct vkms_device;
-
 struct vkms_config {
 	bool writeback;
 	bool cursor;
 	bool overlay;
 };
 
+struct vkms_device_setup {
+	bool is_default;
+};
+
 struct vkms_device {
 	struct drm_device drm;
 	struct platform_device *platform;
+	bool is_default;
 	struct vkms_output output;
 	struct vkms_config config;
 };
@@ -166,7 +169,7 @@ struct vkms_crtc *vkms_crtc_init(struct vkms_device *vkmsdev,
 				 struct drm_plane *primary,
 				 struct drm_plane *cursor);
 
-int vkms_output_init(struct vkms_device *vkmsdev, int index);
+int vkms_output_init_default(struct vkms_device *vkmsdev);
 
 struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 				   enum drm_plane_type type);
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 86faf94f7408..bfc2e2362c6d 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -80,7 +80,7 @@ static struct drm_encoder *vkms_encoder_init(struct vkms_device *vkms_device)
 	return encoder;
 }
 
-int vkms_output_init(struct vkms_device *vkmsdev, int index)
+int vkms_output_init_default(struct vkms_device *vkmsdev)
 {
 	struct vkms_output *output = &vkmsdev->output;
 	struct drm_device *dev = &vkmsdev->drm;
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog


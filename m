Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB92A78BDE8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 07:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235802AbjH2Fc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 01:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235885AbjH2FcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 01:32:15 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97761AA
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 22:32:11 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bdbf10333bso31294405ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 22:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693287131; x=1693891931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbDza5IiePKcj9edkK1zUt6ifaFTEp3xjRfsYOaehus=;
        b=oeDHNiRCMTv+lSdweXO/ZvMsxk6RYBFXTz58uL1Tlb607Y5ezGi30pLq4NVY/PoYVg
         7Or0SFyEf62ug56STgF4/7ogJgn541LIN3Fv+EdndcYwLmtFkvBjW52/5S+pVQjYgMpz
         KWoNfwVkmZY5EqYPcikytl01Bh8n+K6OI38g4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693287131; x=1693891931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rbDza5IiePKcj9edkK1zUt6ifaFTEp3xjRfsYOaehus=;
        b=ctY7E2ia5bcO7zRbPGEjyOoW8E2zn2AH72GjKwqIj/Fkcig2YIsBk5wmxkV1rsEld5
         UUH0bbCtvh9K0UVT88hAItHXnrIz/qSZKqGsmYAqoxw3RXFoDfXOTWo8IBL35ts/Arel
         2qHbVAxLx1qknltZ358sxOhHND7DNqF7qT9NX6lbqyhxpajcFzO7sv4lDoYPqbEj28W/
         nJBGNUYUCNVatXnBHPSDTRbZ9IEy4z+P9KS2l3pIFM1hROCqxykHC2FudzJdTx4zlstW
         rK9iEutEBaJg77Csz6Y5DqaGQT5fVhj+5l7fg/e0826Mhda0sEHTDWtMYh+aQkj5Xs6s
         w8rg==
X-Gm-Message-State: AOJu0Yz65Oc1VcTPHoRBRGznlDIHwj2wJCwrLSajAN6/UsSe64XwlC/T
        8zg+cCCAcJcpdWgX2m9CUicNDQ==
X-Google-Smtp-Source: AGHT+IG6MLFbWE4HjvBXziHk0gW9EHyAZf8/H+nPA6ymhQnO6mZrwmDR0hdSRjmcYXB1hY8x6MXluQ==
X-Received: by 2002:a17:902:7891:b0:1b8:16c7:a786 with SMTP id q17-20020a170902789100b001b816c7a786mr26208455pll.4.1693287131344;
        Mon, 28 Aug 2023 22:32:11 -0700 (PDT)
Received: from datalore.c.googlers.com.com (148.175.199.104.bc.googleusercontent.com. [104.199.175.148])
        by smtp.gmail.com with ESMTPSA id g6-20020a170902c38600b001bdccf6b8c9sm8420874plg.127.2023.08.28.22.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 22:32:11 -0700 (PDT)
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
Subject: [PATCH v6 1/7] drm/vkms: Back VKMS with DRM memory management instead of static objects
Date:   Tue, 29 Aug 2023 05:30:53 +0000
Message-ID: <20230829053201.423261-2-brpol@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230829053201.423261-1-brpol@chromium.org>
References: <20230829053201.423261-1-brpol@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jim Shargo <jshargo@chromium.org>

This is a small refactor to make ConfigFS support easier. Once we
support ConfigFS, there can be multiple devices instantiated by the
driver, and so moving everything into managed memory makes things much
easier.

This should be a no-op refactor.

Signed-off-by: Jim Shargo <jshargo@chromium.org>
Signed-off-by: Brandon Pollack <brpol@chromium.org>
---
 drivers/gpu/drm/vkms/vkms_drv.c    | 128 +++++++++++++++--------------
 drivers/gpu/drm/vkms/vkms_drv.h    |   4 +-
 drivers/gpu/drm/vkms/vkms_output.c |   6 +-
 3 files changed, 71 insertions(+), 67 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index dd0af086e7fa..387c832f5dc9 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -9,10 +9,12 @@
  * the GPU in DRM API tests.
  */
 
+#include <linux/device.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 
+#include <drm/drm_device.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
@@ -37,8 +39,6 @@
 #define DRIVER_MAJOR	1
 #define DRIVER_MINOR	0
 
-static struct vkms_config *default_config;
-
 static bool enable_cursor = true;
 module_param_named(enable_cursor, enable_cursor, bool, 0444);
 MODULE_PARM_DESC(enable_cursor, "Enable/Disable cursor support");
@@ -96,9 +96,9 @@ static int vkms_config_show(struct seq_file *m, void *data)
 	struct drm_device *dev = entry->dev;
 	struct vkms_device *vkmsdev = drm_device_to_vkms_device(dev);
 
-	seq_printf(m, "writeback=%d\n", vkmsdev->config->writeback);
-	seq_printf(m, "cursor=%d\n", vkmsdev->config->cursor);
-	seq_printf(m, "overlay=%d\n", vkmsdev->config->overlay);
+	seq_printf(m, "writeback=%d\n", vkmsdev->config.writeback);
+	seq_printf(m, "cursor=%d\n", vkmsdev->config.cursor);
+	seq_printf(m, "overlay=%d\n", vkmsdev->config.overlay);
 
 	return 0;
 }
@@ -166,121 +166,127 @@ static int vkms_modeset_init(struct vkms_device *vkmsdev)
 	dev->mode_config.cursor_height = 512;
 	/* FIXME: There's a confusion between bpp and depth between this and
 	 * fbdev helpers. We have to go with 0, meaning "pick the default",
-	 * which ix XRGB8888 in all cases. */
+	 * which ix XRGB8888 in all cases.
+	 */
 	dev->mode_config.preferred_depth = 0;
 	dev->mode_config.helper_private = &vkms_mode_config_helpers;
 
 	return vkms_output_init(vkmsdev, 0);
 }
 
-static int vkms_create(struct vkms_config *config)
+static int vkms_platform_probe(struct platform_device *pdev)
 {
 	int ret;
-	struct platform_device *pdev;
 	struct vkms_device *vkms_device;
+	void *grp;
 
-	pdev = platform_device_register_simple(DRIVER_NAME, -1, NULL, 0);
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
-
-	if (!devres_open_group(&pdev->dev, NULL, GFP_KERNEL)) {
-		ret = -ENOMEM;
-		goto out_unregister;
-	}
+	grp = devres_open_group(&pdev->dev, NULL, GFP_KERNEL);
+	if (!grp)
+		return -ENOMEM;
 
 	vkms_device = devm_drm_dev_alloc(&pdev->dev, &vkms_driver,
 					 struct vkms_device, drm);
 	if (IS_ERR(vkms_device)) {
 		ret = PTR_ERR(vkms_device);
-		goto out_devres;
+		goto out_release_group;
 	}
+
 	vkms_device->platform = pdev;
-	vkms_device->config = config;
-	config->dev = vkms_device;
+	vkms_device->config.cursor = enable_cursor;
+	vkms_device->config.writeback = enable_writeback;
+	vkms_device->config.overlay = enable_overlay;
 
 	ret = dma_coerce_mask_and_coherent(vkms_device->drm.dev,
 					   DMA_BIT_MASK(64));
-
 	if (ret) {
 		DRM_ERROR("Could not initialize DMA support\n");
-		goto out_devres;
+		goto out_release_group;
 	}
 
 	ret = drm_vblank_init(&vkms_device->drm, 1);
 	if (ret) {
 		DRM_ERROR("Failed to vblank\n");
-		goto out_devres;
+		goto out_release_group;
 	}
 
 	ret = vkms_modeset_init(vkms_device);
-	if (ret)
-		goto out_devres;
+	if (ret) {
+		DRM_ERROR("Unable to initialize modesetting\n");
+		goto out_release_group;
+	}
 
 	drm_debugfs_add_files(&vkms_device->drm, vkms_config_debugfs_list,
 			      ARRAY_SIZE(vkms_config_debugfs_list));
 
 	ret = drm_dev_register(&vkms_device->drm, 0);
-	if (ret)
-		goto out_devres;
+	if (ret) {
+		DRM_ERROR("Unable to register device with id %d\n", pdev->id);
+		goto out_release_group;
+	}
 
 	drm_fbdev_generic_setup(&vkms_device->drm, 0);
+	platform_set_drvdata(pdev, vkms_device);
+	devres_close_group(&pdev->dev, grp);
 
 	return 0;
 
-out_devres:
-	devres_release_group(&pdev->dev, NULL);
-out_unregister:
-	platform_device_unregister(pdev);
+out_release_group:
+	devres_release_group(&pdev->dev, grp);
 	return ret;
 }
 
-static int __init vkms_init(void)
+static int vkms_platform_remove(struct platform_device *pdev)
 {
-	int ret;
-	struct vkms_config *config;
-
-	config = kmalloc(sizeof(*config), GFP_KERNEL);
-	if (!config)
-		return -ENOMEM;
-
-	default_config = config;
+	struct vkms_device *vkms_device;
 
-	config->cursor = enable_cursor;
-	config->writeback = enable_writeback;
-	config->overlay = enable_overlay;
+	vkms_device = platform_get_drvdata(pdev);
+	if (!vkms_device)
+		return 0;
 
-	ret = vkms_create(config);
-	if (ret)
-		kfree(config);
-
-	return ret;
+	drm_dev_unregister(&vkms_device->drm);
+	drm_atomic_helper_shutdown(&vkms_device->drm);
+	return 0;
 }
 
-static void vkms_destroy(struct vkms_config *config)
+static struct platform_driver vkms_platform_driver = {
+	.probe = vkms_platform_probe,
+	.remove = vkms_platform_remove,
+	.driver.name = DRIVER_NAME,
+};
+
+static int __init vkms_init(void)
 {
+	int ret;
 	struct platform_device *pdev;
 
-	if (!config->dev) {
-		DRM_INFO("vkms_device is NULL.\n");
-		return;
+	ret = platform_driver_register(&vkms_platform_driver);
+	if (ret) {
+		DRM_ERROR("Unable to register platform driver\n");
+		return ret;
 	}
 
-	pdev = config->dev->platform;
-
-	drm_dev_unregister(&config->dev->drm);
-	drm_atomic_helper_shutdown(&config->dev->drm);
-	devres_release_group(&pdev->dev, NULL);
-	platform_device_unregister(pdev);
+	pdev = platform_device_register_simple(DRIVER_NAME, -1, NULL, 0);
+	if (IS_ERR(pdev)) {
+		platform_driver_unregister(&vkms_platform_driver);
+		return PTR_ERR(pdev);
+	}
 
-	config->dev = NULL;
+	return 0;
 }
 
 static void __exit vkms_exit(void)
 {
-	if (default_config->dev)
-		vkms_destroy(default_config);
+	struct device *dev;
+
+	while ((dev = platform_find_device_by_driver(
+			NULL, &vkms_platform_driver.driver))) {
+		// platform_find_device_by_driver increments the refcount. Drop
+		// it so we don't leak memory.
+		put_device(dev);
+		platform_device_unregister(to_platform_device(dev));
+	}
 
-	kfree(default_config);
+	platform_driver_unregister(&vkms_platform_driver);
 }
 
 module_init(vkms_init);
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index c7ae6c2ba1df..4c35d6305f2a 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -124,15 +124,13 @@ struct vkms_config {
 	bool writeback;
 	bool cursor;
 	bool overlay;
-	/* only set when instantiated */
-	struct vkms_device *dev;
 };
 
 struct vkms_device {
 	struct drm_device drm;
 	struct platform_device *platform;
 	struct vkms_output output;
-	const struct vkms_config *config;
+	struct vkms_config config;
 };
 
 #define drm_crtc_to_vkms_output(target) \
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 5ce70dd946aa..963a64cf068b 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -62,7 +62,7 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
 	if (IS_ERR(primary))
 		return PTR_ERR(primary);
 
-	if (vkmsdev->config->overlay) {
+	if (vkmsdev->config.overlay) {
 		for (n = 0; n < NUM_OVERLAY_PLANES; n++) {
 			ret = vkms_add_overlay_plane(vkmsdev, index, crtc);
 			if (ret)
@@ -70,7 +70,7 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
 		}
 	}
 
-	if (vkmsdev->config->cursor) {
+	if (vkmsdev->config.cursor) {
 		cursor = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_CURSOR, index);
 		if (IS_ERR(cursor))
 			return PTR_ERR(cursor);
@@ -103,7 +103,7 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
 		goto err_attach;
 	}
 
-	if (vkmsdev->config->writeback) {
+	if (vkmsdev->config.writeback) {
 		writeback = vkms_enable_writeback_connector(vkmsdev);
 		if (writeback)
 			DRM_ERROR("Failed to init writeback connector\n");
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog


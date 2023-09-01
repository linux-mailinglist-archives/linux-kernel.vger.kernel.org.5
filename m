Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973A979043E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 01:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351325AbjIAXoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 19:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351285AbjIAXnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 19:43:55 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BC41703
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 16:43:17 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68a3082c771so340959b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 16:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693611759; x=1694216559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRgeQgzVDXmV3JVrPP8xBMX8Swv3+BcS7jAR8idQ+gY=;
        b=bcjq8jVo0Ijsz3DQFoySHvk5wqEdGVzN/pmgkQfESizm33hNnGl7+hmTCqy85FWuwU
         qguSP63ORXIla+/osCVP6bDCqrw7MobNWwldkRX4mlEw2ZTRUqQPmy8Bm1KtePVvxEWu
         Ni3/jMGgOCccZdZkZvFkjOMYKuQFoYZmVzcDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693611759; x=1694216559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRgeQgzVDXmV3JVrPP8xBMX8Swv3+BcS7jAR8idQ+gY=;
        b=b3WyTchnL2oGO9vRx4ap2uCvA+8GSc43uYCJtV+1HNNynRZfA3LQXXjNCm6RqCz/pV
         AalghPY8TTYZ1HLNowK6f80emo/0dG9jw7z/aR+/vI8dkL7vKNy+WVw7YoWwJZGF4Fvl
         5K+FBu2ljI2LYYqDAoNwa9ksAmD3xO5aaog8O3zlRRDczDxgoYVEfEz912mindND7d2L
         y00bokQKxCZldKBqlNeBkTvsTqN+h4bc4mexXXrXYabxBLKelJ1nNqHNLx3x0sbPTL0s
         P81cqbTeBhgry4FMw85WUrLcWgG4xtX0crk/cPMiRXZOuflNT7ru5tVPHlCXvzjQxjaP
         m1PA==
X-Gm-Message-State: AOJu0YwGVo+x8teMc45Lg9z1fPkp0c/O/kx1UhEzYvMxtJ/Zg/pTeErh
        PQtg8u6z5inUYbhOmkZj3azeloXiRPfKVxCzQ1AsVsXz
X-Google-Smtp-Source: AGHT+IGtmbAKHGuLHO3p7Yzikip33D41k/UMdvLiEDSJbNafsboBSz7i0yyxWsOXwhZuzfQmGxSWqA==
X-Received: by 2002:a05:6a00:4c8f:b0:68c:59cb:2dd9 with SMTP id eb15-20020a056a004c8f00b0068c59cb2dd9mr5216448pfb.1.1693611759266;
        Fri, 01 Sep 2023 16:42:39 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:8d94:1fc5:803c:41cc])
        by smtp.gmail.com with ESMTPSA id o9-20020a639a09000000b0056c3a4a3ca5sm3326390pge.36.2023.09.01.16.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 16:42:38 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>, airlied@gmail.com,
        bskeggs@redhat.com, daniel@ffwll.ch, kherbst@redhat.com,
        linux-kernel@vger.kernel.org, lyude@redhat.com,
        nouveau@lists.freedesktop.org
Subject: [RFT PATCH 06/15] drm/nouveau: Call drm_atomic_helper_shutdown() or equiv at shutdown time
Date:   Fri,  1 Sep 2023 16:41:17 -0700
Message-ID: <20230901164111.RFT.6.Ie7588ec6e0f93e8bc700e76b265ad1a7ad6b15ad@changeid>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230901234202.566951-1-dianders@chromium.org>
References: <20230901234202.566951-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on grepping through the source code this driver appears to be
missing a call to drm_atomic_helper_shutdown() (or
drm_helper_force_disable_all() if not using atomic) at system shutdown
time. Among other things, this means that if a panel is in use that it
won't be cleanly powered off at system shutdown time.

The fact that we should call drm_atomic_helper_shutdown() in the case
of OS shutdown/restart comes straight out of the kernel doc "driver
instance overview" in drm_drv.c.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This commit is only compile-time tested. I made my best guess about
how to fit this into the existing code. If someone wishes a different
style, please yell.

 drivers/gpu/drm/nouveau/nouveau_display.c  |  9 +++++++++
 drivers/gpu/drm/nouveau/nouveau_display.h  |  1 +
 drivers/gpu/drm/nouveau/nouveau_drm.c      | 13 +++++++++++++
 drivers/gpu/drm/nouveau/nouveau_drv.h      |  1 +
 drivers/gpu/drm/nouveau/nouveau_platform.c |  6 ++++++
 5 files changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/nouveau/nouveau_display.c
index 99977e5fe716..04b3a3c0b5a5 100644
--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -642,6 +642,15 @@ nouveau_display_fini(struct drm_device *dev, bool suspend, bool runtime)
 	disp->fini(dev, runtime, suspend);
 }
 
+void
+nouveau_display_shutdown(struct drm_device *dev)
+{
+	if (drm_drv_uses_atomic_modeset(dev))
+		drm_atomic_helper_shutdown(dev);
+	else
+		drm_helper_force_disable_all(dev);
+}
+
 static void
 nouveau_display_create_properties(struct drm_device *dev)
 {
diff --git a/drivers/gpu/drm/nouveau/nouveau_display.h b/drivers/gpu/drm/nouveau/nouveau_display.h
index 2ab2ddb1eadf..9df62e833cda 100644
--- a/drivers/gpu/drm/nouveau/nouveau_display.h
+++ b/drivers/gpu/drm/nouveau/nouveau_display.h
@@ -47,6 +47,7 @@ void nouveau_display_destroy(struct drm_device *dev);
 int  nouveau_display_init(struct drm_device *dev, bool resume, bool runtime);
 void nouveau_display_hpd_resume(struct drm_device *dev);
 void nouveau_display_fini(struct drm_device *dev, bool suspend, bool runtime);
+void nouveau_display_shutdown(struct drm_device *dev);
 int  nouveau_display_suspend(struct drm_device *dev, bool runtime);
 void nouveau_display_resume(struct drm_device *dev, bool runtime);
 int  nouveau_display_vblank_enable(struct drm_crtc *crtc);
diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 4396f501b16a..d8e8160cdf35 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -879,6 +879,18 @@ nouveau_drm_remove(struct pci_dev *pdev)
 	pci_disable_device(pdev);
 }
 
+void
+nouveau_drm_device_shutdown(struct drm_device *dev)
+{
+	nouveau_display_shutdown(dev);
+}
+
+static void
+nouveau_drm_shutdown(struct pci_dev *pdev)
+{
+	nouveau_drm_device_shutdown(pci_get_drvdata(pdev));
+}
+
 static int
 nouveau_do_suspend(struct drm_device *dev, bool runtime)
 {
@@ -1343,6 +1355,7 @@ nouveau_drm_pci_driver = {
 	.id_table = nouveau_drm_pci_table,
 	.probe = nouveau_drm_probe,
 	.remove = nouveau_drm_remove,
+	.shutdown = nouveau_drm_shutdown,
 	.driver.pm = &nouveau_pm_ops,
 };
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_drv.h b/drivers/gpu/drm/nouveau/nouveau_drv.h
index 3666a7403e47..aa936cabb6cf 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drv.h
+++ b/drivers/gpu/drm/nouveau/nouveau_drv.h
@@ -327,6 +327,7 @@ struct drm_device *
 nouveau_platform_device_create(const struct nvkm_device_tegra_func *,
 			       struct platform_device *, struct nvkm_device **);
 void nouveau_drm_device_remove(struct drm_device *dev);
+void nouveau_drm_device_shutdown(struct drm_device *dev);
 
 #define NV_PRINTK(l,c,f,a...) do {                                             \
 	struct nouveau_cli *_cli = (c);                                        \
diff --git a/drivers/gpu/drm/nouveau/nouveau_platform.c b/drivers/gpu/drm/nouveau/nouveau_platform.c
index 23cd43a7fd19..b2e82a96411c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_platform.c
+++ b/drivers/gpu/drm/nouveau/nouveau_platform.c
@@ -50,6 +50,11 @@ static int nouveau_platform_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void nouveau_platform_shutdown(struct platform_device *pdev)
+{
+	nouveau_drm_device_shutdown(platform_get_drvdata(pdev));
+}
+
 #if IS_ENABLED(CONFIG_OF)
 static const struct nvkm_device_tegra_func gk20a_platform_data = {
 	.iommu_bit = 34,
@@ -94,4 +99,5 @@ struct platform_driver nouveau_platform_driver = {
 	},
 	.probe = nouveau_platform_probe,
 	.remove = nouveau_platform_remove,
+	.shutdown = nouveau_platform_shutdown,
 };
-- 
2.42.0.283.g2d96d420d3-goog


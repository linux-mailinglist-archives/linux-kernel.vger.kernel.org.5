Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C322F7A9DD9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjIUTuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjIUTtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:49:33 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A421090D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:28:28 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68fcb4dc8a9so1265300b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695324506; x=1695929306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHA8WV61h1sCTUoopvu6jUmhZo1/0sc2wBZa91YnlqI=;
        b=PMIbhcMOgys27dEgkEIP5PwEsYx+RS1t9LGrN8SSq4KnKOIioLxkv6SLiGSwL8C5GX
         cRJZbVH52RhoVbcmskCJWEJpZii0wciCHY1Y2AweY67YaEKt9evu+oea4fm/WSH+y6KY
         L0gaAaaLkvf1/6cU1NkCYKI6MZhUyZ6xWmh7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695324506; x=1695929306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHA8WV61h1sCTUoopvu6jUmhZo1/0sc2wBZa91YnlqI=;
        b=nf6RLsSBZF97KvhEOx4H3u1OESMThFx079ljssjHudfRTke5nsaBbOqbtx3WvEdMqq
         hnl744WQiYPGZxOE/wlvwM46s+sCm+89DBatp187MDEVEemlvlMZeTIBOEf36U85QA8h
         ulYnakP+VQtZtEbxNm1Otuo+ad6lMrkCQ8wK4dIFr0x7pOkfDTCT6fqEd3ae5YJUdCD3
         +JTisW9MEJUwrUvWpN3FFF2Z5KGTjwRz/z8J3XUvYCdLGlhHZVSbQEajYnliOWLuHj3G
         e4inZuFPGOXyTpDQP0+j73ZeSCwsD4h+k2yi5DEbArwotSOvl6iH+dEMc5Lmay4hFASN
         8QDw==
X-Gm-Message-State: AOJu0Yxo6zO8V5fFPduoVmOkkKBO9cwxbxkvo6TQWFrEZqcoYzJMqFnN
        lFA+iLR4jyLHBixceKcoOsx0RQ==
X-Google-Smtp-Source: AGHT+IHqTEJgRF5kJ5LaOV5RP1ReQKOtcWcO7Dx6XuYKQwxO/AtAnwFW/vbvFSlG1XFJXQbmien+fA==
X-Received: by 2002:a05:6a20:3ca8:b0:15c:e0bf:40ec with SMTP id b40-20020a056a203ca800b0015ce0bf40ecmr5940561pzj.17.1695324506566;
        Thu, 21 Sep 2023 12:28:26 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:e6ed:6d49:f262:8041])
        by smtp.gmail.com with ESMTPSA id w8-20020a1709029a8800b001b9f032bb3dsm1892875plp.3.2023.09.21.12.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 12:28:24 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>, airlied@gmail.com,
        bskeggs@redhat.com, daniel@ffwll.ch, kherbst@redhat.com,
        linux-kernel@vger.kernel.org, lyude@redhat.com,
        nouveau@lists.freedesktop.org
Subject: [RFT PATCH v2 04/12] drm/nouveau: Call drm_atomic_helper_shutdown() or equiv at shutdown time
Date:   Thu, 21 Sep 2023 12:26:47 -0700
Message-ID: <20230921122641.RFT.v2.4.Ie7588ec6e0f93e8bc700e76b265ad1a7ad6b15ad@changeid>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230921192749.1542462-1-dianders@chromium.org>
References: <20230921192749.1542462-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This commit is only compile-time tested. I made my best guess about
how to fit this into the existing code. If someone wishes a different
style, please yell.

(no changes since v1)

 drivers/gpu/drm/nouveau/nouveau_display.c  |  9 +++++++++
 drivers/gpu/drm/nouveau/nouveau_display.h  |  1 +
 drivers/gpu/drm/nouveau/nouveau_drm.c      | 13 +++++++++++++
 drivers/gpu/drm/nouveau/nouveau_drv.h      |  1 +
 drivers/gpu/drm/nouveau/nouveau_platform.c |  6 ++++++
 5 files changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/nouveau/nouveau_display.c
index d8c92521226d..05c3688ccb76 100644
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
index 50589f982d1a..8ecfd66b7aab 100644
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
@@ -1346,6 +1358,7 @@ nouveau_drm_pci_driver = {
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
2.42.0.515.g380fc7ccd1-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7A47A9FEF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjIUU3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbjIUU2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:28:51 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7615D4200
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:28:17 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c46b30a1ceso11386685ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695324497; x=1695929297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NI6y381yNrtia6QcCIC7z4DDn4lzJBG1Oz9c+agvn3E=;
        b=IBzxunwtPiO3QT1Ag6NPl8BWqPJrQYjFrxL5RcPtEwAoNmoFitEAZLTtsMQ3sXrl3+
         IY/T23TICRoKdn/yFcSDzOtt7SZhBG/vqve8N3YwSyTGR7jcf9n7mKrDYaUM8B4fgo1h
         XVT5aYslG5nYLUeDccz5AUNYicDZjcg4gdJsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695324497; x=1695929297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NI6y381yNrtia6QcCIC7z4DDn4lzJBG1Oz9c+agvn3E=;
        b=fuwZhd+InpAzyr2kzNCFZ0LcJ4DuL1MXHQ+JtWtkpaXlT9VbwgOSJwdFt8tsqmBFda
         bMtYuobIVL0sh6wAuZwLefRreHwj5qRDqAzjEC6TGC7NxT2iheZVo82yn8UyhSdvMwwH
         /e34veQwK63HfijPBx/BW2tnT5CHl9+NNf/R55F3JaR/TvaXBccwo0OIzyC0v1kB2bLq
         ieCSdy2k35gBN+eV8LwKxLfYPqFUpQPjjlHFpu48mgFJ4E3U+Y2jESOZNHRlxrQnV8k4
         Xrla/yEYf2v01PkZGTxmhZeMoRlTV5oDCmEMNT7//8DBTVhAGHXQjvGR7oJH39vglM96
         Mv8g==
X-Gm-Message-State: AOJu0Yx2tbCo617PNrt96w2ki5ZCmEcy+/N2o7kk3+lYNOafPHo1rlD5
        NVtxDHIBvuus9Du7lLnc//Sf7A==
X-Google-Smtp-Source: AGHT+IEwO0wT0IFYtUWxf8dEr+TXDKdYpZSldG17COiUXE+UPVFkQVI7f6AGosPMSTOkM8sO3JyqHw==
X-Received: by 2002:a17:902:ab17:b0:1c4:4efc:90a6 with SMTP id ik23-20020a170902ab1700b001c44efc90a6mr6250166plb.38.1695324496702;
        Thu, 21 Sep 2023 12:28:16 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:e6ed:6d49:f262:8041])
        by smtp.gmail.com with ESMTPSA id w8-20020a1709029a8800b001b9f032bb3dsm1892875plp.3.2023.09.21.12.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 12:28:15 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, airlied@gmail.com,
        daniel@ffwll.ch, festevam@gmail.com, kernel@pengutronix.de,
        l.stach@pengutronix.de, laurentiu.palcu@oss.nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org
Subject: [RFT PATCH v2 01/12] drm/imx/dcss: Call drm_atomic_helper_shutdown() at shutdown time
Date:   Thu, 21 Sep 2023 12:26:44 -0700
Message-ID: <20230921122641.RFT.v2.1.I134336fce7eac5a63bdac46d57b0888858fc8081@changeid>
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
missing a call to drm_atomic_helper_shutdown() at system shutdown
time. Among other things, this means that if a panel is in use that it
won't be cleanly powered off at system shutdown time.

The fact that we should call drm_atomic_helper_shutdown() in the case
of OS shutdown/restart comes straight out of the kernel doc "driver
instance overview" in drm_drv.c.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This commit is only compile-time tested.

(no changes since v1)

 drivers/gpu/drm/imx/dcss/dcss-drv.c | 8 ++++++++
 drivers/gpu/drm/imx/dcss/dcss-kms.c | 7 +++++++
 drivers/gpu/drm/imx/dcss/dcss-kms.h | 1 +
 3 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/imx/dcss/dcss-drv.c b/drivers/gpu/drm/imx/dcss/dcss-drv.c
index c68b0d93ae9e..b61cec0cc79d 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-drv.c
+++ b/drivers/gpu/drm/imx/dcss/dcss-drv.c
@@ -92,6 +92,13 @@ static int dcss_drv_platform_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void dcss_drv_platform_shutdown(struct platform_device *pdev)
+{
+	struct dcss_drv *mdrv = dev_get_drvdata(&pdev->dev);
+
+	dcss_kms_shutdown(mdrv->kms);
+}
+
 static struct dcss_type_data dcss_types[] = {
 	[DCSS_IMX8MQ] = {
 		.name = "DCSS_IMX8MQ",
@@ -114,6 +121,7 @@ MODULE_DEVICE_TABLE(of, dcss_of_match);
 static struct platform_driver dcss_platform_driver = {
 	.probe	= dcss_drv_platform_probe,
 	.remove	= dcss_drv_platform_remove,
+	.shutdown = dcss_drv_platform_shutdown,
 	.driver	= {
 		.name = "imx-dcss",
 		.of_match_table	= dcss_of_match,
diff --git a/drivers/gpu/drm/imx/dcss/dcss-kms.c b/drivers/gpu/drm/imx/dcss/dcss-kms.c
index 896de946f8df..d0ea4e97cded 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-kms.c
+++ b/drivers/gpu/drm/imx/dcss/dcss-kms.c
@@ -172,3 +172,10 @@ void dcss_kms_detach(struct dcss_kms_dev *kms)
 	dcss_crtc_deinit(&kms->crtc, drm);
 	drm->dev_private = NULL;
 }
+
+void dcss_kms_shutdown(struct dcss_kms_dev *kms)
+{
+	struct drm_device *drm = &kms->base;
+
+	drm_atomic_helper_shutdown(drm);
+}
diff --git a/drivers/gpu/drm/imx/dcss/dcss-kms.h b/drivers/gpu/drm/imx/dcss/dcss-kms.h
index dfe5dd99eea3..62521c1fd6d2 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-kms.h
+++ b/drivers/gpu/drm/imx/dcss/dcss-kms.h
@@ -34,6 +34,7 @@ struct dcss_kms_dev {
 
 struct dcss_kms_dev *dcss_kms_attach(struct dcss_dev *dcss);
 void dcss_kms_detach(struct dcss_kms_dev *kms);
+void dcss_kms_shutdown(struct dcss_kms_dev *kms);
 int dcss_crtc_init(struct dcss_crtc *crtc, struct drm_device *drm);
 void dcss_crtc_deinit(struct dcss_crtc *crtc, struct drm_device *drm);
 struct dcss_plane *dcss_plane_init(struct drm_device *drm,
-- 
2.42.0.515.g380fc7ccd1-goog


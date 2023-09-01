Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916CD790441
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 01:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351293AbjIAXn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 19:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351282AbjIAXnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 19:43:50 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EFD173B
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 16:43:09 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68c0d886ea0so2220674b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 16:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693611750; x=1694216550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/+h1ksZof8y/lEEP6nhkNB4pCHzfTPQtm4LO74Tft4=;
        b=FdlQbxAP3ThBYl+AFQkfMCHFM3nQtldNjMXTWnQAwiu7CXblffV6hymNckLBhsNTR6
         aFwhE8YlZv/XVxNxqVab6MMnHgPKStBs9VsB6l3WUmCKK/hF4xan4duzM2qvAYukP+Uk
         dX6n8uDRZVh+g4BkRKQG5ybmlIULnv+G83Slw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693611750; x=1694216550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T/+h1ksZof8y/lEEP6nhkNB4pCHzfTPQtm4LO74Tft4=;
        b=H+5SCy73w9IRoRAnFdwjX8YYsKswU6CesyuZW+Or7u8IngoFPkwGkREfifbJT/GHVu
         hR/gc9ShjUM3S2jPLtiZRRfE3FZnuur55eKnwBheQAnk1hNdCroRxa1OktnHkePK0HH8
         62F8JhpUfMXztp4/j6HRGDedmYAC/zutem5B40ALgjEgB0zdoKGwSnFasAazc26b1GbS
         Z3wc+Z3uuEd2ytvqZHERT0ufOo3omrWeWpKU3oo8q+rWm6kjrZ2ahzwbOiwoxMwkIFnS
         fq9w4IsJrv8eV0tZ9M3nZhIvUpDVmYP/uKusZ64U+9j+4HckaaHRrfAHvFubHLArIkkZ
         p4aA==
X-Gm-Message-State: AOJu0Yx98UIJHwGbtb6pdH/1i/ag+Ij+W6vbwvxAO9k8mKYFyENNqhKE
        nBTOmyXK0TGpJgaEnTruBVbOKg==
X-Google-Smtp-Source: AGHT+IEo8+vhlzHuiA7kt4gie7hkc/892ETxj7IzgIvbEImTbdys6UWMlOfB4tKXF+g1dIUU86Genw==
X-Received: by 2002:a05:6a00:139c:b0:68a:5449:7436 with SMTP id t28-20020a056a00139c00b0068a54497436mr4995293pfg.32.1693611750394;
        Fri, 01 Sep 2023 16:42:30 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:8d94:1fc5:803c:41cc])
        by smtp.gmail.com with ESMTPSA id o9-20020a639a09000000b0056c3a4a3ca5sm3326390pge.36.2023.09.01.16.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 16:42:28 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, airlied@gmail.com,
        daniel@ffwll.ch, festevam@gmail.com, kernel@pengutronix.de,
        l.stach@pengutronix.de, laurentiu.palcu@oss.nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org
Subject: [RFT PATCH 02/15] drm/imx/dcss: Call drm_atomic_helper_shutdown() at shutdown time
Date:   Fri,  1 Sep 2023 16:41:13 -0700
Message-ID: <20230901164111.RFT.2.I134336fce7eac5a63bdac46d57b0888858fc8081@changeid>
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
missing a call to drm_atomic_helper_shutdown() at system shutdown
time. Among other things, this means that if a panel is in use that it
won't be cleanly powered off at system shutdown time.

The fact that we should call drm_atomic_helper_shutdown() in the case
of OS shutdown/restart comes straight out of the kernel doc "driver
instance overview" in drm_drv.c.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This commit is only compile-time tested.

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
2.42.0.283.g2d96d420d3-goog


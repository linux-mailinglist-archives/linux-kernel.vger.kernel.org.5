Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DA079044D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 01:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351307AbjIAXoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 19:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351323AbjIAXoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 19:44:04 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF236E7F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 16:43:28 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68bed286169so2171143b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 16:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693611771; x=1694216571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHay3IZ79gwyzzJIvA/KLviDPDyXcoAjtR8WZOwFgDw=;
        b=foiReDb///9mnd8lo5Cl6NNugH0l8Zdbx8BVAFGnPJ4FeVekCSn4vcbQ8QT3jPCh16
         36jt98myaLITcV27VVzTHbJrHG7ZEZTyral6DRmnNBx7Fc2DPB1CXt0Zw9oLt2myAQRL
         uqor6l37nFSAPEfTZdf+Rnw0wW+dP2SIFIO30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693611771; x=1694216571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHay3IZ79gwyzzJIvA/KLviDPDyXcoAjtR8WZOwFgDw=;
        b=OSInPlicBipG7ElDWWqa7bmtwrkr4iairurC6dE1DynFssbEwM9kRRlXVlLtG67U5Q
         czcXnLNWWnKRPgA7PJ1ky6WGN9Dsn90fGXmpbv3UKBt4KbbM2NpE8kLxn+oSakh79FtK
         qkmAAuhS6l5gRR/vz4GEQiiYtfQysbFAw5usgNZxxhnb6ATN2fNeU//zqDJea+amscbb
         1FMEyutcyjJTyTD8ZIc1e2z1XHQaWTmTVGV8JiGhCWET14MGUG6DvXU+ol3uSAZS48Vf
         VU2QZwV/xLQZmCNVE0bHqWCbJ5Sr3QsYDIM1Kj4xeZDY+iRsdy9ziAtdc6KtVLzw1hjq
         qs5w==
X-Gm-Message-State: AOJu0YwBB4kBAskmpIzT9vQ4m5xI/9nxG0/IicW+WPWzmfknnKofxx6y
        iLYpswroNP5tw1+NXWn2d/S91w==
X-Google-Smtp-Source: AGHT+IHY7t2zN6rtVOOQuBIslh6uo5hZExLEtoUk+kZCKL2mIpIBCiF+lomwnDGZdtLEJFAPIrODXQ==
X-Received: by 2002:a05:6a20:2cf:b0:14d:382c:f354 with SMTP id 15-20020a056a2002cf00b0014d382cf354mr3916743pzb.36.1693611770966;
        Fri, 01 Sep 2023 16:42:50 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:8d94:1fc5:803c:41cc])
        by smtp.gmail.com with ESMTPSA id o9-20020a639a09000000b0056c3a4a3ca5sm3326390pge.36.2023.09.01.16.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 16:42:50 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>, airlied@gmail.com,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        patrik.r.jakobsson@gmail.com
Subject: [RFT PATCH 12/15] drm/gma500: Call drm_helper_force_disable_all() at shutdown/remove time
Date:   Fri,  1 Sep 2023 16:41:23 -0700
Message-ID: <20230901164111.RFT.12.I1be622999c3b23f28f077fc75bb0319396a216e9@changeid>
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

Based on grepping through the source code, this driver appears to be
missing a call to drm_atomic_helper_shutdown(), or in this case the
non-atomic equivalent drm_helper_force_disable_all(), at system
shutdown time and at driver remove time. This is important because
drm_helper_force_disable_all() will cause panels to get disabled
cleanly which may be important for their power sequencing. Future
changes will remove any custom powering off in individual panel
drivers so the DRM drivers need to start getting this right.

The fact that we should call drm_atomic_helper_shutdown(), or in this
case the non-atomic equivalent drm_helper_force_disable_all(), in the
case of OS shutdown/restart comes straight out of the kernel doc
"driver instance overview" in drm_drv.c.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This commit is only compile-time tested.

 drivers/gpu/drm/gma500/psb_drv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
index 8b64f61ffaf9..a5a399bbe8f5 100644
--- a/drivers/gpu/drm/gma500/psb_drv.c
+++ b/drivers/gpu/drm/gma500/psb_drv.c
@@ -20,6 +20,7 @@
 #include <acpi/video.h>
 
 #include <drm/drm.h>
+#include <drm/drm_crtc_helper.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_file.h>
 #include <drm/drm_ioctl.h>
@@ -485,6 +486,12 @@ static void psb_pci_remove(struct pci_dev *pdev)
 	struct drm_device *dev = pci_get_drvdata(pdev);
 
 	drm_dev_unregister(dev);
+	drm_helper_force_disable_all(dev);
+}
+
+static void psb_pci_shutdown(struct pci_dev *pdev)
+{
+	drm_helper_force_disable_all(pci_get_drvdata(pdev));
 }
 
 static DEFINE_RUNTIME_DEV_PM_OPS(psb_pm_ops, gma_power_suspend, gma_power_resume, NULL);
@@ -521,6 +528,7 @@ static struct pci_driver psb_pci_driver = {
 	.id_table = pciidlist,
 	.probe = psb_pci_probe,
 	.remove = psb_pci_remove,
+	.shutdown = psb_pci_shutdown,
 	.driver.pm = &psb_pm_ops,
 };
 
-- 
2.42.0.283.g2d96d420d3-goog


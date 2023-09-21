Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AEE7A9DC8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjIUTsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjIUTrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:47:40 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F98EA627
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:28:44 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c09673b006so11154185ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695324524; x=1695929324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjE9g39gnCCj7j/VSb42AYR6J5acTdAldxrB9mluCQs=;
        b=UlFhRDpuDdoVAn1e29otD8iq6yUH4efuvBH5/2VDVbZwhVYDLQOfjPbd5Csa9nefxV
         ygeWb3u9m0lzH50UQjUpyjseYNrvueJJQSHJecEIWrDZDbP9QIphlRvU2pB2WxBOextk
         A88/4yMrcFFC0DrrDa1N5AP/nJDnBLs7XKc8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695324524; x=1695929324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SjE9g39gnCCj7j/VSb42AYR6J5acTdAldxrB9mluCQs=;
        b=ZiuD5qZ1jahOuUeRszmVZlB9FjSTJR6asSDTYhNley6NlG7/9HCfnhOo390yPV9fXW
         3vOxJ3V0d2jdVsbSLdhA/KNazd44luMHDODJ2BfOmxg0W2U/CKPVTNrutsr3z/qX2t7F
         XwcYVPt2g/FIhoYWM0jHSrxzszt3L6gLXJ4VAgID15aQGJosfnAQ1abPpMQ+VP0jF858
         v/jHDPAHKHGs/D6rzNmX3nLeEcFDNVo2ZoG9fm/tBMi6ByUeJ3A2aYWj8dDXfu3bagMZ
         cPYu44Woepdy1kAwGM3u0gV/DQ7iyVQR7guFTbbdMXnEclOpCfURa43lXY6nlUSuX4Oh
         y7Wg==
X-Gm-Message-State: AOJu0YzqBgufdCufUr0pye7DJnYhYHdwtSTbJVKjJiZZeuIH2acNBrLa
        xJV5k0RJP0DgsOgR4pP0XlkV3Q==
X-Google-Smtp-Source: AGHT+IGaL8Xuy7USK74rcVfJD2FYDrURYbnbnv1NxMU2yTzdabxZ6fmTke9TgpsR322JBCoPZAOITQ==
X-Received: by 2002:a17:902:d491:b0:1c3:8230:30d8 with SMTP id c17-20020a170902d49100b001c3823030d8mr7671409plg.38.1695324524060;
        Thu, 21 Sep 2023 12:28:44 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:e6ed:6d49:f262:8041])
        by smtp.gmail.com with ESMTPSA id w8-20020a1709029a8800b001b9f032bb3dsm1892875plp.3.2023.09.21.12.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 12:28:42 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>, airlied@gmail.com,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        patrik.r.jakobsson@gmail.com
Subject: [RFT PATCH v2 10/12] drm/gma500: Call drm_helper_force_disable_all() at shutdown/remove time
Date:   Thu, 21 Sep 2023 12:26:53 -0700
Message-ID: <20230921122641.RFT.v2.10.I1be622999c3b23f28f077fc75bb0319396a216e9@changeid>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230921192749.1542462-1-dianders@chromium.org>
References: <20230921192749.1542462-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This commit is only compile-time tested.

(no changes since v1)

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
2.42.0.515.g380fc7ccd1-goog


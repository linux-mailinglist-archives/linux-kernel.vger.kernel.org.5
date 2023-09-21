Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1123A7A9DC7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjIUTrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjIUTrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:47:36 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF12EA63B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:28:46 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c3f97f2239so11941185ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695324526; x=1695929326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNE7U3MRFdvHzy3AatqQxrB+Rii45BA8np0vc2lW0nQ=;
        b=FETYVesb9dGOgsBD2GUKMgueygA+8BJAYSOAnFW3kFNsJUQrxUB62+jlUc/bbDpQHm
         koYL/VrKtTCRll2qdEWetFD////djqBBwPPsZjNHlHK1TjXvBfBWQvehABIf7OUHYDP0
         mi/XndU5nNO0ci+HVykK/i2H5RhbMy5rea7WQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695324526; x=1695929326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vNE7U3MRFdvHzy3AatqQxrB+Rii45BA8np0vc2lW0nQ=;
        b=poey8Y4mXSk5oVRzLckI93Akf9yunp6ShFM0j/9q9hUNide3wXhOsfu+5keEgzmlpl
         k1gC2TcYkjeiUEcWrYH5K1K2dnr6oEDt0GD0Hn9T/Xuo8T6PbFMsT2i8D9Ubr5LGNfHB
         LrsvSiQzadJRV6wG+84K/FN9AAWDbMQ2DN+yhqICnRm/QBj61ljmx0qjGLtv75D437ln
         8X3SKpB3LrnL1CRIruMCrzhW9GxIi3b2lo8LfdAMsztK6E97YpbxnFHw630B7qX1+Lmz
         KzBUtjyd2IK0oDhBLneeZ77LGRJfet5FTsoRQgDv/9yLM6cJW+yhWm6m0hpMbYjIcAhY
         tcFA==
X-Gm-Message-State: AOJu0Yw5MPb10Duj9SVJwoi9ugeuBF4l4GTN/pwt3wmv2HbWF2JlOLWA
        25N9XdM3v4sB4PsFH5pmDTU2FQ==
X-Google-Smtp-Source: AGHT+IFvUfNdgD3M025ie0SSfztu5G0EGA1WZyW9KYEx3xmH/xP1cMH0WFKYaDRfvGODLOGFhzZm+g==
X-Received: by 2002:a17:902:7fce:b0:1bf:27a2:b52b with SMTP id t14-20020a1709027fce00b001bf27a2b52bmr5978389plb.58.1695324526019;
        Thu, 21 Sep 2023 12:28:46 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:e6ed:6d49:f262:8041])
        by smtp.gmail.com with ESMTPSA id w8-20020a1709029a8800b001b9f032bb3dsm1892875plp.3.2023.09.21.12.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 12:28:45 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>, Xinhui.Pan@amd.com,
        airlied@gmail.com, alexander.deucher@amd.com,
        amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 11/12] drm/radeon: Call drm_helper_force_disable_all() at shutdown/remove time
Date:   Thu, 21 Sep 2023 12:26:54 -0700
Message-ID: <20230921122641.RFT.v2.11.I022cfc2dcd30e77d4f7005a2d912dd7ab76c0338@changeid>
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

NOTE: in order to get things inserted in the right place, I had to
replace the old/deprecated drm_put_dev() function with the equivalent
new calls.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I honestly have no idea if I got this patch right. The shutdown()
function already had some special case logic for PPC, Loongson, and
VMs and I don't 100% for sure know how this interacts with
those. Everything here is just compile tested.

(no changes since v1)

 drivers/gpu/drm/radeon/radeon_drv.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 39cdede460b5..67995ea24852 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -38,6 +38,7 @@
 #include <linux/pci.h>
 
 #include <drm/drm_aperture.h>
+#include <drm/drm_crtc_helper.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_file.h>
 #include <drm/drm_gem.h>
@@ -357,7 +358,9 @@ radeon_pci_remove(struct pci_dev *pdev)
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
 
-	drm_put_dev(dev);
+	drm_dev_unregister(dev);
+	drm_helper_force_disable_all(dev);
+	drm_dev_put(dev);
 }
 
 static void
@@ -368,6 +371,8 @@ radeon_pci_shutdown(struct pci_dev *pdev)
 	 */
 	if (radeon_device_is_virtual())
 		radeon_pci_remove(pdev);
+	else
+		drm_helper_force_disable_all(pci_get_drvdata(pdev));
 
 #if defined(CONFIG_PPC64) || defined(CONFIG_MACH_LOONGSON64)
 	/*
-- 
2.42.0.515.g380fc7ccd1-goog


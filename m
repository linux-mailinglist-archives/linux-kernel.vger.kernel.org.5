Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C5579044A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 01:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351383AbjIAXoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 19:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351333AbjIAXoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 19:44:07 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D0C1717
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 16:43:33 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3a751d2e6ecso1715923b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 16:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693611775; x=1694216575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKiMaJ+cEDZwLLCxXqIHb+OBndFjgPpn6nuXSf4hrW0=;
        b=Zw5/VdPLcVL4HDNW6p2TU8oTJNw2tLikGcVSVi1SiBG3kuQ9zzprA3WkeGmYfP1rrV
         pOcfnse1mVsUygznmYDm/RnGo7BRq2sU4tFy15zP/l496u1DVBUjB1GjEuGdn4V3Ovxi
         MA0AV8ohMiXdbLZ/4YyGfSBERHUBBVdHhVB08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693611775; x=1694216575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKiMaJ+cEDZwLLCxXqIHb+OBndFjgPpn6nuXSf4hrW0=;
        b=ZeWu61zeElsVfuwbFZ3BpcIVByZl74tBGF6SetlLPr/V5kC3M6JXPf9J/bX+bSUOkn
         luMXv20xdMuJ5d8zUd3C1VbXHnZbSx0bMadJuPzm9FvYEUsvrKsyIBn9h3w6pW0KXDx4
         NjSyYzUsKNaV6qNwau05OFzQeyurSoCXWRG8/IK62qqF6qXI5vlFSgYK5zLYfoHt0yqc
         z4IqYfnh9j0eqUyBzv9ZAyo2hVovOwP5jN5UQ8FWFJwHHrRh7bb2R3V3sUAuNR2evF6g
         LvRzkZk/hOWS8Vu+4HMnfyxDiPJORDqiVKtfvVs1WTrldxBzzt1wAeLZLFCOdm9E+OzA
         tM1w==
X-Gm-Message-State: AOJu0YwSW+DysYgXuG7iQHP4hyNFqvjlPJvTmtqQuGZqmpdo3UiNHJV7
        Zp5c7fVM23WN2DOkrGGx59FKBQ==
X-Google-Smtp-Source: AGHT+IH3N6oAfydomdv+c+JnkApo3hK8ntxo9o07pRRK+2oRgBVZbVsjJxP7itMUHip6V7XJUK2i9g==
X-Received: by 2002:a54:458e:0:b0:3a8:847e:c5b7 with SMTP id z14-20020a54458e000000b003a8847ec5b7mr4071404oib.31.1693611775021;
        Fri, 01 Sep 2023 16:42:55 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:8d94:1fc5:803c:41cc])
        by smtp.gmail.com with ESMTPSA id o9-20020a639a09000000b0056c3a4a3ca5sm3326390pge.36.2023.09.01.16.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 16:42:54 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>, Xinhui.Pan@amd.com,
        airlied@gmail.com, alexander.deucher@amd.com,
        amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org
Subject: [RFT PATCH 14/15] drm/radeon: Call drm_helper_force_disable_all() at shutdown/remove time
Date:   Fri,  1 Sep 2023 16:41:25 -0700
Message-ID: <20230901164111.RFT.14.I022cfc2dcd30e77d4f7005a2d912dd7ab76c0338@changeid>
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

NOTE: in order to get things inserted in the right place, I had to
replace the old/deprecated drm_put_dev() function with the equivalent
new calls.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I honestly have no idea if I got this patch right. The shutdown()
function already had some special case logic for PPC, Loongson, and
VMs and I don't 100% for sure know how this interacts with
those. Everything here is just compile tested.

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
2.42.0.283.g2d96d420d3-goog


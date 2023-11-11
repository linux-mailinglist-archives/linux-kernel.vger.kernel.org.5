Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D180D7E8925
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 05:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345815AbjKKEaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 23:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjKKEaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 23:30:25 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865053C39
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 20:30:22 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6ce2cf67be2so1372427a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 20:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699677022; x=1700281822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UeOfKSGtUGFS1M67vt4QeOHf8NL5FRLZhzwheHOXEQ=;
        b=LnKk2JrDbW2mNNg+eVkeXPmBUHCY3HD6+gE7Ww4p9Fs8N+xv1wgrozgU01fZFm/vOe
         oozJHyy8EpbVEMnhI5Xlo3U2HXbk0zmDc4eSnaFbHtrNpMneN6Sn3q4NfL4SobbUITAw
         PQF4Jt7ECYqvkZEMbm2XP3IFra6PmTNdwZsix1uNwBLaMoOPcVw+Oi3w+BjBw5BT24jE
         J8X96Jk3Kgrz4UJ+rOhY9aEczWZ/+CKtRZ8oAh6URrs3aQpqB0Fxp6jKOmZ6dnPreYE8
         T6eZW1QTbut0V+7JtIEL1AYvDSH7MjJlFKRAdQIDqg/A9p57luUKQSRmP611JWlQCyuP
         h19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699677022; x=1700281822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0UeOfKSGtUGFS1M67vt4QeOHf8NL5FRLZhzwheHOXEQ=;
        b=nU2lRGg2fFLF6vwqNRNc5WRlwTg/3bZ+fSEk1PXJ9OXN0iJQ9IRzWq55XFnMX2oRZP
         pAXcDoLs4Bdcc6/VC25ZXr/BlJILCWjTPPgiOqT8RUzsVMXPtwAsbF2sO3P679S3c0O8
         wD0fjvB8aNUdabxuM9IFge8w3W4qIZ7rg+oPcx+yKry6FlKt/AoL8pyPxWjrtsZCagEZ
         7kWGm3enlr3EVB4l8YRfF471bEkb04/JXOBM4aw0Be5DowUposb8fY+q1vwUqyWMVToZ
         h2VnBinOuLw0dqovhNLr8J1tl6eSzrM6/cuvRd0ixHNCU0Lr9FQH2idGbcCXU1O/qGaV
         xByA==
X-Gm-Message-State: AOJu0Yyvnp25SgXv5XO3r1q5pxgf467k3lrEyEYpbLVVAO3PmRLJTykn
        k4CU8G8WwakhJGWwQ41zKaI=
X-Google-Smtp-Source: AGHT+IGqm442xKF6kqYoBxkN0ltyPIsvs6VvlDXjXkHff5Tv5uMmiXes6nVYN8UQxl3ctcJwjcpiKw==
X-Received: by 2002:a9d:684d:0:b0:6c4:a349:4b10 with SMTP id c13-20020a9d684d000000b006c4a3494b10mr1064937oto.28.1699677021877;
        Fri, 10 Nov 2023 20:30:21 -0800 (PST)
Received: from macbook.lan (119-18-27-45.77121b.mel.nbn.aussiebb.net. [119.18.27.45])
        by smtp.gmail.com with ESMTPSA id a8-20020a1709027d8800b001c74df14e6esm469672plm.51.2023.11.10.20.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 20:30:21 -0800 (PST)
From:   Andrew Worsley <amworsley@gmail.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR FIRMWARE
        FRAMEBUFFERS), linux-kernel@vger.kernel.org (open list)
Cc:     Andrew Worsley <amworsley@gmail.com>
Subject: [PATCH] Fix failure of simpledrm probe when trying to grab FB from the EFI-based Framebuffer
Date:   Sat, 11 Nov 2023 15:21:22 +1100
Message-ID: <20231111042926.52990-2-amworsley@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231111042926.52990-1-amworsley@gmail.com>
References: <20231111042926.52990-1-amworsley@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

   The simpledrm.c does not call aperture_remove_conflicting_devices() in it's probe
   function as the drivers/video/aperture.c documentation says it should. Consequently
   it's request for the FB memory fails.

...
[    3.085302] simple-framebuffer bd58dc000.framebuffer: [drm] *ERROR* could not acquire memory range [??? 0xffff6e1d8629d580-0x2a5000001a7 flags 0x0]: -16
[    3.086433] simple-framebuffer: probe of bd58dc000.framebuffer failed with error -16
...

   In my case no driver provided /dev/dri/card0 device is available on boot up and X
   fails to start as per this from X start up log.

...
[     5.616] (WW) Falling back to old probe method for modesetting
[     5.616] (EE) open /dev/dri/card0: No such file or directory
...

   Fault confirmed and fixed on Asahi 6.5.0 kernel with both CONFIG_FB_EFI and
   CONFIG_DRM_SIMPLEDRM config options set.

Signed-off-by: Andrew Worsley <amworsley@gmail.com>
---
 drivers/gpu/drm/tiny/simpledrm.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
index 5fefc895bca2..e55a536b04cf 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -8,6 +8,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/regulator/consumer.h>
+#include <linux/aperture.h>
 
 #include <drm/drm_aperture.h>
 #include <drm/drm_atomic.h>
@@ -828,6 +829,13 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
 	if (mem) {
 		void *screen_base;
 
+		ret = aperture_remove_conflicting_devices(mem->start, resource_size(mem),
+			DRIVER_NAME);
+		if (ret) {
+			drm_err(dev, "aperture_remove_conflicting_devices: failed:%d\n",
+			    __func__, ret);
+			return ERR_PTR(ret);
+		}
 		ret = devm_aperture_acquire_from_firmware(dev, mem->start, resource_size(mem));
 		if (ret) {
 			drm_err(dev, "could not acquire memory range %pr: %d\n", mem, ret);
@@ -848,6 +856,13 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
 		if (!res)
 			return ERR_PTR(-EINVAL);
 
+		ret = aperture_remove_conflicting_devices(res->start, resource_size(res),
+			DRIVER_NAME);
+		if (ret) {
+			drm_err(dev, "aperture_remove_conflicting_devices: failed:%d\n",
+			    __func__, ret);
+			return ERR_PTR(ret);
+		}
 		ret = devm_aperture_acquire_from_firmware(dev, res->start, resource_size(res));
 		if (ret) {
 			drm_err(dev, "could not acquire memory range %pr: %d\n", res, ret);
-- 
2.42.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710AF790E4B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 23:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348965AbjICVl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 17:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348906AbjICVl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 17:41:57 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C76FE5
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 14:41:53 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-500bdef7167so2085888e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 14:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693777312; x=1694382112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmanXIAkjDsl+T2r62TPHvRC1u8K+rB0oi8RTwEBesA=;
        b=xJaeyPxHFUdk6qhXVl9pcYwGIj6ry212IshkgrOmUj8Bpt76gTqX0EVkMPzv92CxBS
         /IhjvH5xnYEh/XXSKV58i57VQ5FmNCr3kkNkaJze34nn/Bzwwlgn2FaOYXzuZA/nZM1i
         G5ntCFOlvmedXZ/pM5Zwdq9lKeImg+wpNUQrLDN/HQ8WBL9Q1quW+/3Uh6ldZFo7kQie
         DhjPGSx0zL3hKimS08w0KfGPgdLvG6TbWS+f3oJz7BusF2FJq0UMNmYA98k6HMNe8MAl
         J9b5wxVt7bccJM1U4RmlhuVPBvpTgujRq82kTQ7kXcykveAYquERpExSxMtiGOQNQTGX
         mEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693777312; x=1694382112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GmanXIAkjDsl+T2r62TPHvRC1u8K+rB0oi8RTwEBesA=;
        b=hYJUULHLtsLw2dms3gWG4fPafjFC2FDU0uGKCk2paBXvB73dmFOcvySzrDedDhuHfj
         k3w2KTMtUJN3MSFYsMa13N/BBko+E/8dD1dbDU/KaquBmyRITOSv4thrgabHl85qjGEF
         /b24CIpgAZkiaYMidtoQaRipVEhKrI9DUufofUXChPxM3yGoB82LEh6vOPHJvdg6NIpY
         XrZ03tTi7SMrQalRSmhSG2ra29WSKduAcJnt9j5LvI1LtxwSimCYjDzk8SJoJdSnDrC/
         vsGze+BhT/JYs5rCtzn6r5T1WoKC7DEs8wNw81qtu1gDOqnNYE9gymEMGfwv3WVzvK2Z
         a2vg==
X-Gm-Message-State: AOJu0Yw1AcIntg9c5rYLJbgROOZaCNWZdzHsOZqa+ZqoHw7dlw0TL4rf
        ZLiXf9L6YbMjZtn2vi0s+UBt+w==
X-Google-Smtp-Source: AGHT+IEGo/yjWy7nXfptqRFFQBffjwaXXQ9l9Ri/i3/adG+D2/r7RCm9m7rFgxFD5xaJpRnQWqoXxw==
X-Received: by 2002:a05:6512:2215:b0:500:bf44:b2b3 with SMTP id h21-20020a056512221500b00500bf44b2b3mr2690899lfu.21.1693777311904;
        Sun, 03 Sep 2023 14:41:51 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id x17-20020ac25dd1000000b004f8555f7aa1sm1422506lfq.52.2023.09.03.14.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 14:41:51 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Janne Grunau <j@jannau.net>, Simon Ser <contact@emersion.fr>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        freedreno@lists.freedesktop.org, Won Chung <wonchung@google.com>
Subject: [RFC PATCH v1 01/12] Revert "drm/sysfs: Link DRM connectors to corresponding Type-C connectors"
Date:   Mon,  4 Sep 2023 00:41:39 +0300
Message-Id: <20230903214150.2877023-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230903214150.2877023-1-dmitry.baryshkov@linaro.org>
References: <20230903214150.2877023-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kdev->fwnode pointer is never set in drm_sysfs_connector_add(), so
dev_fwnode() checks never succeed, making the respective commit NOP.

And if drm_sysfs_connector_add() is modified to set kdev->fwnode, it
breaks drivers already using components (as it was pointed at [1]),
resulting in a deadlock. Lockdep trace is provided below.

Granted these two issues, it seems impractical to fix this commit in any
sane way. Revert it instead.

[1] https://lore.kernel.org/dri-devel/Y24bcYJKGy%2Fgd5fV@phenom.ffwll.local/

============================================
WARNING: possible recursive locking detected
6.5.0-rc6-next-20230816-10542-g090e2ca9feae-dirty #713 Tainted: G        W
--------------------------------------------
kworker/u16:0/11 is trying to acquire lock:
ffffce0f54bea490 (component_mutex){+.+.}-{3:3}, at: __component_add+0x64/0x170

but task is already holding lock:
ffffce0f54bea490 (component_mutex){+.+.}-{3:3}, at: __component_add+0x64/0x170

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(component_mutex);
  lock(component_mutex);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

6 locks held by kworker/u16:0/11:
 #0: ffff5b7680008d38 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x14c/0x51c
 #1: ffff8000800abde0 (deferred_probe_work){+.+.}-{0:0}, at: process_one_work+0x14c/0x51c
 #2: ffff5b76837a2908 (&dev->mutex){....}-{3:3}, at: __device_attach+0x38/0x188
 #3: ffffce0f54bea490 (component_mutex){+.+.}-{3:3}, at: __component_add+0x64/0x170
 #4: ffffce0f54bdeb40 (drm_connector_list_iter){.+.+}-{0:0}, at: drm_modeset_register_all+0x80/0x9c
 #5: ffff5b76866ad0d0 (&connector->mutex){+.+.}-{3:3}, at: drm_connector_register.part.0+0x28/0x104

stack backtrace:
CPU: 6 PID: 11 Comm: kworker/u16:0 Tainted: G        W          6.5.0-rc6-next-20230816-10542-g090e2ca9feae-dirty #713
Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
Workqueue: events_unbound deferred_probe_work_func
Call trace:
 dump_backtrace+0x98/0xf0
 show_stack+0x18/0x24
 dump_stack_lvl+0x60/0xac
 dump_stack+0x18/0x24
 print_deadlock_bug+0x254/0x340
 __lock_acquire+0x105c/0x1ebc
 lock_acquire+0x1ec/0x314
 __lock_acquire+0x105c/0x1ebc
 lock_acquire+0x1ec/0x314
 __mutex_lock+0xa0/0x77c
 mutex_lock_nested+0x24/0x30
 __component_add+0x64/0x170
 component_add+0x14/0x20
 drm_sysfs_connector_add+0x144/0x1a0
 drm_connector_register.part.0+0x5c/0x104
 drm_connector_register_all+0x84/0x160
 drm_modeset_register_all+0x80/0x9c
 drm_dev_register+0x120/0x238
 msm_drm_bind+0x550/0x6e0
 try_to_bring_up_aggregate_device+0x164/0x1d0
 __component_add+0xa8/0x170
 component_add+0x14/0x20
 dsi_dev_attach+0x20/0x2c
 dsi_host_attach+0x9c/0x144
 devm_mipi_dsi_attach+0x34/0xb4
 lt9611uxc_attach_dsi.isra.0+0x84/0xfc
 lt9611uxc_probe+0x5ac/0x66c
 i2c_device_probe+0x148/0x290
 really_probe+0x148/0x2ac
 __driver_probe_device+0x78/0x12c
 driver_probe_device+0x3c/0x160
 __device_attach_driver+0xb8/0x138
 bus_for_each_drv+0x80/0xdc
 __device_attach+0x9c/0x188
 device_initial_probe+0x14/0x20
 bus_probe_device+0xac/0xb0
 deferred_probe_work_func+0x8c/0xc8
 process_one_work+0x1ec/0x51c
 worker_thread+0x1ec/0x3e4
 kthread+0x120/0x124
 ret_from_fork+0x10/0x20

Fixes: c5c51b242062 ("drm/sysfs: Link DRM connectors to corresponding Type-C connectors")
Cc: Won Chung <wonchung@google.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/drm_sysfs.c | 40 -------------------------------------
 1 file changed, 40 deletions(-)

diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
index b169b3e44a92..06662cc8d3f4 100644
--- a/drivers/gpu/drm/drm_sysfs.c
+++ b/drivers/gpu/drm/drm_sysfs.c
@@ -11,14 +11,12 @@
  */
 
 #include <linux/acpi.h>
-#include <linux/component.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/export.h>
 #include <linux/gfp.h>
 #include <linux/i2c.h>
 #include <linux/kdev_t.h>
-#include <linux/property.h>
 #include <linux/slab.h>
 
 #include <drm/drm_accel.h>
@@ -98,34 +96,6 @@ static char *drm_devnode(const struct device *dev, umode_t *mode)
 	return kasprintf(GFP_KERNEL, "dri/%s", dev_name(dev));
 }
 
-static int typec_connector_bind(struct device *dev,
-				struct device *typec_connector, void *data)
-{
-	int ret;
-
-	ret = sysfs_create_link(&dev->kobj, &typec_connector->kobj, "typec_connector");
-	if (ret)
-		return ret;
-
-	ret = sysfs_create_link(&typec_connector->kobj, &dev->kobj, "drm_connector");
-	if (ret)
-		sysfs_remove_link(&dev->kobj, "typec_connector");
-
-	return ret;
-}
-
-static void typec_connector_unbind(struct device *dev,
-				   struct device *typec_connector, void *data)
-{
-	sysfs_remove_link(&typec_connector->kobj, "drm_connector");
-	sysfs_remove_link(&dev->kobj, "typec_connector");
-}
-
-static const struct component_ops typec_connector_ops = {
-	.bind = typec_connector_bind,
-	.unbind = typec_connector_unbind,
-};
-
 static CLASS_ATTR_STRING(version, S_IRUGO, "drm 1.1.0 20060810");
 
 /**
@@ -394,16 +364,9 @@ int drm_sysfs_connector_add(struct drm_connector *connector)
 
 	connector->kdev = kdev;
 
-	if (dev_fwnode(kdev)) {
-		r = component_add(kdev, &typec_connector_ops);
-		if (r)
-			drm_err(dev, "failed to add component to create link to typec connector\n");
-	}
-
 	if (connector->ddc)
 		return sysfs_create_link(&connector->kdev->kobj,
 				 &connector->ddc->dev.kobj, "ddc");
-
 	return 0;
 
 err_free:
@@ -419,9 +382,6 @@ void drm_sysfs_connector_remove(struct drm_connector *connector)
 	if (connector->ddc)
 		sysfs_remove_link(&connector->kdev->kobj, "ddc");
 
-	if (dev_fwnode(connector->kdev))
-		component_del(connector->kdev, &typec_connector_ops);
-
 	DRM_DEBUG("removing \"%s\" from sysfs\n",
 		  connector->name);
 
-- 
2.39.2


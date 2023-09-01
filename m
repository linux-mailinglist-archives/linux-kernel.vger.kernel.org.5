Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5AEB79044B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 01:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351385AbjIAXoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 19:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351338AbjIAXoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 19:44:07 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3A91719
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 16:43:34 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3aa14d8641cso271442b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 16:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693611777; x=1694216577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdM+lGT73cjSOBSP8IlsC1l9xDfQI2J1yvb0n4/3ZvY=;
        b=WrfUkV6fBZa/HNDQ+C+jGvmAdKnM10L7WP0qDDbOx2EdlehV0DJFZhhRU3HT+3pnzP
         scfXOaqUoKqJTTMBps7t9Sf62aaET+vtqAGk5Z4AZMm9hhmu8Enj5O9F/5R+iAr0tSO5
         wRyZ9miECUr7NapzzC/bqty/Clm8YAKw5kQ8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693611777; x=1694216577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdM+lGT73cjSOBSP8IlsC1l9xDfQI2J1yvb0n4/3ZvY=;
        b=AGbvU5n0L6/4nIdlCUFvTspMvMhdh9UOXgObdkqdF7Z04r6r53lSm9Lqh5c/XSpeh5
         EYdK8a2ZN4FgLgfbsts8WQo4X6xWbX0hyZyAQm10UT4GYXNhT6IVu7FTrit+KfBkUgAq
         MrF9cNYquMkDnqMoDvCeuQsshVgoMG0MdxvVXqapGVnno0Xbguw+OPL52E210Db3lIum
         SNAygKxDn/HtYWUYGX4F4h6aiJJmbjq8scooizwNKrmOfwF3AmA6e5kCR+5FOab+YfXJ
         bxq6yDNr9UokTa8LCb9Q2uW45ViC5MWEDWoraFf9EUW754mghNqsgTnEHMUWHbZj8U6Q
         LtIg==
X-Gm-Message-State: AOJu0Yww8jkndnLEenAtrod8AuQsotkDpxY1lLPsRJUXAsHOAop0JQFv
        GNmGjBHNJfB0XjIF27PT0bm2ew==
X-Google-Smtp-Source: AGHT+IFcdBjJJQwlyQ5ZEP5yP3QLZHGZAWqiXZ/QhDSapWZmB7jAL9+asxO5XakvnmAO3TBkPL5opA==
X-Received: by 2002:a05:6808:919:b0:3a7:46d2:5203 with SMTP id w25-20020a056808091900b003a746d25203mr4110653oih.51.1693611776821;
        Fri, 01 Sep 2023 16:42:56 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:8d94:1fc5:803c:41cc])
        by smtp.gmail.com with ESMTPSA id o9-20020a639a09000000b0056c3a4a3ca5sm3326390pge.36.2023.09.01.16.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 16:42:56 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>, airlied@gmail.com,
        biju.das.jz@bp.renesas.com, daniel@ffwll.ch,
        geert+renesas@glider.be, kieran.bingham+renesas@ideasonboard.com,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, paul@crapouillou.net,
        tzimmermann@suse.de
Subject: [RFT PATCH 15/15] drm/renesas/shmobile: Call drm_helper_force_disable_all() at shutdown/remove time
Date:   Fri,  1 Sep 2023 16:41:26 -0700
Message-ID: <20230901164111.RFT.15.Iaf638a1d4c8b3c307a6192efabb4cbb06b195f15@changeid>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230901234202.566951-1-dianders@chromium.org>
References: <20230901234202.566951-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
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

 drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
index 30493ce87419..d6dd46c925c5 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
@@ -15,6 +15,7 @@
 #include <linux/pm.h>
 #include <linux/slab.h>
 
+#include <drm/drm_crtc_helper.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_fbdev_generic.h>
 #include <drm/drm_gem_dma_helper.h>
@@ -179,12 +180,20 @@ static int shmob_drm_remove(struct platform_device *pdev)
 
 	drm_dev_unregister(ddev);
 	drm_kms_helper_poll_fini(ddev);
+	drm_helper_force_disable_all(ddev);
 	free_irq(sdev->irq, ddev);
 	drm_dev_put(ddev);
 
 	return 0;
 }
 
+static void shmob_drm_shutdown(struct platform_device *pdev)
+{
+	struct shmob_drm_device *sdev = platform_get_drvdata(pdev);
+
+	drm_helper_force_disable_all(sdev->ddev);
+}
+
 static int shmob_drm_probe(struct platform_device *pdev)
 {
 	struct shmob_drm_platform_data *pdata = pdev->dev.platform_data;
@@ -289,6 +298,7 @@ static int shmob_drm_probe(struct platform_device *pdev)
 static struct platform_driver shmob_drm_platform_driver = {
 	.probe		= shmob_drm_probe,
 	.remove		= shmob_drm_remove,
+	.shutdown	= shmob_drm_shutdown,
 	.driver		= {
 		.name	= "shmob-drm",
 		.pm	= pm_sleep_ptr(&shmob_drm_pm_ops),
-- 
2.42.0.283.g2d96d420d3-goog


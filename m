Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E365C79043F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 01:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351379AbjIAXoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 19:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351331AbjIAXoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 19:44:07 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D927C1710
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 16:43:31 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-34df502d238so8638525ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 16:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693611773; x=1694216573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzZMfYrc4MS7Ddrskta252Gk/vbJZVRLTsLEIZtE5Vw=;
        b=FN5js8Si5UfNhghP9yH/+SW5UzMm8bitbD1a4lDJppllxdRKO8GAmxnc7HpCMK25O1
         7ltQ2vY056qt4ru2BRxicNzxJq4AQX0SXZELXgL6RfyqBx+t/zT6I2X8wykNX8LhzTTT
         KwD4MLzAgaj5J7FnsR1OlERDj/rNH+4BcGIx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693611773; x=1694216573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pzZMfYrc4MS7Ddrskta252Gk/vbJZVRLTsLEIZtE5Vw=;
        b=P3zVNp/DlHFwh3HlNIzyUPTfTdUrSm0aZ/4zXrlFFdLWKcJ1LC1O8KC+BV+GyS81aS
         XRW0y0mIhMr0CF6rusLrszdV++ACRjxKPEhgixUgq4OtrpbQj5yi+jLZAGxQo8n17Bp+
         +fL8Fi2AX98nSVI1v4lRaW++eQxmm8mNa9WFxLQ0cKwoQ7JYvh3ip5Axjqsg1/E1EQ0p
         HrPOjSFixlU59iBVJcURGKlLzJqtvOlk4bBRID16b88nSIvWgRRNZAadz33dZLPIYsv5
         +U1/JOo7REp5TaoPoVrD/Xu6SogGPTrYYdN4LFKIJ9HaY/WKwZ/8LagqOAdwIbFSkQJy
         WS6g==
X-Gm-Message-State: AOJu0YyWpKu3+5CotGmXCnbTC+ulmWIikNSydbKTBfbXtrpoVgJh/ZqD
        EbmWrm9rRyzn6FekE6LdXKqX2w==
X-Google-Smtp-Source: AGHT+IFvdRCJwMr99Yb1JrwpTHYD/RaTUnsuipwnbiYPCDCcEBVC17WQxgviFC4gHISPtQjZ2Wly3g==
X-Received: by 2002:a05:6e02:1a21:b0:348:fe3b:c8b with SMTP id g1-20020a056e021a2100b00348fe3b0c8bmr5295836ile.1.1693611773002;
        Fri, 01 Sep 2023 16:42:53 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:8d94:1fc5:803c:41cc])
        by smtp.gmail.com with ESMTPSA id o9-20020a639a09000000b0056c3a4a3ca5sm3326390pge.36.2023.09.01.16.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 16:42:52 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, airlied@gmail.com,
        daniel@ffwll.ch, festevam@gmail.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        shawnguo@kernel.org
Subject: [RFT PATCH 13/15] drm/imx/ipuv3: Call drm_atomic_helper_shutdown() at shutdown/unbind time
Date:   Fri,  1 Sep 2023 16:41:24 -0700
Message-ID: <20230901164111.RFT.13.I0a9940ff6f387d6acf4e71d8c7dbaff8c42e3aaa@changeid>
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
missing a call to drm_atomic_helper_shutdown() at system shutdown time
and at driver unbind time. Among other things, this means that if a
panel is in use that it won't be cleanly powered off at system
shutdown time.

The fact that we should call drm_atomic_helper_shutdown() in the case
of OS shutdown/restart and at driver remove (or unbind) time comes
straight out of the kernel doc "driver instance overview" in
drm_drv.c.

A few notes about this fix:
- When adding drm_atomic_helper_shutdown() to the unbind path, I added
  it after drm_kms_helper_poll_fini() since that's when other drivers
  seemed to have it.
- Technically with a previous patch, ("drm/atomic-helper:
  drm_atomic_helper_shutdown(NULL) should be a noop"), we don't
  actually need to check to see if our "drm" pointer is NULL before
  calling drm_atomic_helper_shutdown(). We'll leave the "if" test in,
  though, so that this patch can land without any dependencies. It
  could potentially be removed later.
- This patch also makes sure to set the drvdata to NULL in the case of
  bind errors to make sure that shutdown can't access freed data.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This commit is only compile-time tested.

 drivers/gpu/drm/imx/ipuv3/imx-drm-core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/imx/ipuv3/imx-drm-core.c b/drivers/gpu/drm/imx/ipuv3/imx-drm-core.c
index 4a866ac60fff..4c8bc49758a7 100644
--- a/drivers/gpu/drm/imx/ipuv3/imx-drm-core.c
+++ b/drivers/gpu/drm/imx/ipuv3/imx-drm-core.c
@@ -257,6 +257,7 @@ static int imx_drm_bind(struct device *dev)
 	drm_kms_helper_poll_fini(drm);
 	component_unbind_all(drm->dev, drm);
 err_kms:
+	dev_set_drvdata(dev, NULL);
 	drm_dev_put(drm);
 
 	return ret;
@@ -269,6 +270,7 @@ static void imx_drm_unbind(struct device *dev)
 	drm_dev_unregister(drm);
 
 	drm_kms_helper_poll_fini(drm);
+	drm_atomic_helper_shutdown(drm);
 
 	component_unbind_all(drm->dev, drm);
 
@@ -298,6 +300,14 @@ static int imx_drm_platform_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void imx_drm_platform_shutdown(struct platform_device *pdev)
+{
+	struct drm_device *drm = platform_get_drvdata(pdev);
+
+	if (drm)
+		drm_atomic_helper_shutdown(platform_get_drvdata(pdev));
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int imx_drm_suspend(struct device *dev)
 {
@@ -325,6 +335,7 @@ MODULE_DEVICE_TABLE(of, imx_drm_dt_ids);
 static struct platform_driver imx_drm_pdrv = {
 	.probe		= imx_drm_platform_probe,
 	.remove		= imx_drm_platform_remove,
+	.shutdown	= imx_drm_platform_shutdown,
 	.driver		= {
 		.name	= "imx-drm",
 		.pm	= &imx_drm_pm_ops,
-- 
2.42.0.283.g2d96d420d3-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC82379043B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 01:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351275AbjIAXnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 19:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351274AbjIAXnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 19:43:45 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63480E65
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 16:43:06 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68a42d06d02so2152956b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 16:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693611747; x=1694216547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTyJ24tKFqLRbG9l9nWJNLGooQV8nSVkH6ez/jxbol4=;
        b=hkWS55RtaRYoC++pEQHfK9W4knfRv2Ux2Si/fSXi4BYjJzjTcFtb0A22nPosUZoHBT
         OzD44z2cyEIoXxfkpHIW5bok4R+AyvILSGnXsjX120WoKqxbjzoZ2IvUTkAg6ZJc5eo8
         UzHvW9IbAEVCeZGpq9uHfil0keEhPn7zsS6lI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693611747; x=1694216547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BTyJ24tKFqLRbG9l9nWJNLGooQV8nSVkH6ez/jxbol4=;
        b=dLfE0JsxNe16F55OJq3cG3bv9zbjNRqaKO+WRx1Ib10bGYSVPnxP15ND1de0SQ9bLz
         BbpCkScscWj9scKSrWe1VZRvyFGtNSp0ztWh4l4AHlrzRAqDevYoc9h1FZ1IioLhPiB+
         iv+iesEfMlodhbaAXAVNGRPz2qIS3csyx0FEkVgpv164HSCOZSYkz5xqS7HuTAFNNU8h
         K9FrI8MmtFzPT4A5qvbByhrSzKSyT+RS2P7UQfkk+mjuJaBwIZ329EUMJjAH/3Ax0CI6
         /bjd91m3OErD/2mhUa5cgPpH0TW07POOl6dFtMsRIw9VbqqfuZcI76ffQmbce/fwjjPg
         mjsw==
X-Gm-Message-State: AOJu0YzZ5YZeQWmMIsDDsEyrKiC3YBjXDPGPiNZA8givIodrbiQz0ehA
        PhNBHZj6gGBu6A3WfEC3FZEu9Q==
X-Google-Smtp-Source: AGHT+IEdOoLZSYVgu/HM3/52v8vTtHyToRKvwsbcU9nHFrr/BHqKpV2ahyit9WDnLfZWVQbJOzkyGg==
X-Received: by 2002:a05:6a20:191:b0:149:73f9:332f with SMTP id 17-20020a056a20019100b0014973f9332fmr3881021pzy.61.1693611746996;
        Fri, 01 Sep 2023 16:42:26 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:8d94:1fc5:803c:41cc])
        by smtp.gmail.com with ESMTPSA id o9-20020a639a09000000b0056c3a4a3ca5sm3326390pge.36.2023.09.01.16.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 16:42:26 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>, airlied@gmail.com,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk
Subject: [RFT PATCH 01/15] drm/armada: Call drm_atomic_helper_shutdown() at shutdown time
Date:   Fri,  1 Sep 2023 16:41:12 -0700
Message-ID: <20230901164111.RFT.1.I3d5598bd73a59b5ded71430736c93f67dc5dea61@changeid>
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

This driver was fairly easy to update. The drm_device is stored in the
drvdata so we just have to make sure the drvdata is NULL whenever the
device is not bound. To make things simpler,
drm_atomic_helper_shutdown() has been modified to consider a NULL
drm_device as a noop in the patch ("drm/atomic-helper:
drm_atomic_helper_shutdown(NULL) should be a noop").

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This commit is only compile-time tested.

 drivers/gpu/drm/armada/armada_drv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
index e8d2fe955909..fa1c67598706 100644
--- a/drivers/gpu/drm/armada/armada_drv.c
+++ b/drivers/gpu/drm/armada/armada_drv.c
@@ -148,6 +148,7 @@ static int armada_drm_bind(struct device *dev)
  err_kms:
 	drm_mode_config_cleanup(&priv->drm);
 	drm_mm_takedown(&priv->linear);
+	dev_set_drvdata(dev, NULL);
 	return ret;
 }
 
@@ -166,6 +167,7 @@ static void armada_drm_unbind(struct device *dev)
 
 	drm_mode_config_cleanup(&priv->drm);
 	drm_mm_takedown(&priv->linear);
+	dev_set_drvdata(dev, NULL);
 }
 
 static void armada_add_endpoints(struct device *dev,
@@ -230,6 +232,11 @@ static int armada_drm_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void armada_drm_shutdown(struct platform_device *pdev)
+{
+	drm_atomic_helper_shutdown(platform_get_drvdata(pdev));
+}
+
 static const struct platform_device_id armada_drm_platform_ids[] = {
 	{
 		.name		= "armada-drm",
@@ -243,6 +250,7 @@ MODULE_DEVICE_TABLE(platform, armada_drm_platform_ids);
 static struct platform_driver armada_drm_platform_driver = {
 	.probe	= armada_drm_probe,
 	.remove	= armada_drm_remove,
+	.shutdown = armada_drm_shutdown,
 	.driver	= {
 		.name	= "armada-drm",
 	},
-- 
2.42.0.283.g2d96d420d3-goog


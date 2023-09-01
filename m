Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4041B790443
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 01:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351305AbjIAXn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 19:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351291AbjIAXnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 19:43:52 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE53E1704
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 16:43:11 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68becf931d0so2105912b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 16:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693611754; x=1694216554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cc544bXmls05RiqEx12Xvv3H5cbPiv1GFPSua0tXsTc=;
        b=YXss6mMzpdVvjXsykrn+LndV+HjfcsmnWCzCgkl1+vpTTshlChiwvUPRgOkWmk6R/Z
         /D/B4thnbxmEk9680HgW6u9N3rw4gaTr12XvR8wzXwnUoU9rHtHoyNjCdVBq+vTr8Wp0
         OPuOBdD3Q9XHyuZMkow/SiqekkAVh2G2on3dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693611754; x=1694216554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cc544bXmls05RiqEx12Xvv3H5cbPiv1GFPSua0tXsTc=;
        b=jnFkiGBsFNSGFFLz7AJNjaCuPyhdmiUniOjdtm3hO/hWyiVg+E9Oz732Tr1agCC1Ko
         r3iT8/jg99280ULBPN5xUSyGE9lPHcIstqSuaht/y1WRpoPEFdG6Y1n+Vp6KVLrxrb/e
         /UZvTapJZKt3aFAzRdNTT8mgRDVhS/jOjWxvpRSEcZ2aORi2ieFQvvVmtMXC1vua+RoU
         CyyKHjIY3J3jgCfLCJ7OVT34SyTsSXz8ob5tbF10GExxMghIpCdEWbcIovxXNxreko0b
         nQOEhPYbOGMwo+KAIvV2tIvY8PAf/fKI/LLA2LEfkgIHQ4Lri6lDf+CZgBH+dyS5CimC
         zeHQ==
X-Gm-Message-State: AOJu0Yw4b+EDQ5gRxobBsD1QTKY59vcu/7kTKntUP58SiJT2A8yIpjF6
        HbGXjJuOgeakwDQvoBlfO/e4MQ==
X-Google-Smtp-Source: AGHT+IGAoNt4CxHEBkp++4gMl/OPzz+Yhylo+U5CTknKu4gd+KmH9VfQD9fB/cKCtbNNcv6lJ8N/6g==
X-Received: by 2002:a05:6a20:7da0:b0:126:9081:2156 with SMTP id v32-20020a056a207da000b0012690812156mr5068857pzj.4.1693611754018;
        Fri, 01 Sep 2023 16:42:34 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:8d94:1fc5:803c:41cc])
        by smtp.gmail.com with ESMTPSA id o9-20020a639a09000000b0056c3a4a3ca5sm3326390pge.36.2023.09.01.16.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 16:42:33 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>, airlied@gmail.com,
        anitha.chrisanthus@intel.com, daniel@ffwll.ch,
        edmund.j.dea@intel.com, linux-kernel@vger.kernel.org
Subject: [RFT PATCH 04/15] drm/kmb: Call drm_atomic_helper_shutdown() at shutdown time
Date:   Fri,  1 Sep 2023 16:41:15 -0700
Message-ID: <20230901164111.RFT.4.I20cb02bafa7c2368e4bd579df0716eb62a3a21bf@changeid>
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

 drivers/gpu/drm/kmb/kmb_drv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/kmb/kmb_drv.c b/drivers/gpu/drm/kmb/kmb_drv.c
index 24035b53441c..af9bd34fefc0 100644
--- a/drivers/gpu/drm/kmb/kmb_drv.c
+++ b/drivers/gpu/drm/kmb/kmb_drv.c
@@ -476,6 +476,11 @@ static int kmb_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void kmb_shutdown(struct platform_device *pdev)
+{
+	drm_atomic_helper_shutdown(platform_get_drvdata(pdev));
+}
+
 static int kmb_probe(struct platform_device *pdev)
 {
 	struct device *dev = get_device(&pdev->dev);
@@ -622,6 +627,7 @@ static SIMPLE_DEV_PM_OPS(kmb_pm_ops, kmb_pm_suspend, kmb_pm_resume);
 static struct platform_driver kmb_platform_driver = {
 	.probe = kmb_probe,
 	.remove = kmb_remove,
+	.shutdown = kmb_shutdown,
 	.driver = {
 		.name = "kmb-drm",
 		.pm = &kmb_pm_ops,
-- 
2.42.0.283.g2d96d420d3-goog


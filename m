Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1FD7A9DA3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjIUTns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjIUTnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:43:33 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25650F83A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:28:21 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c434c33ec0so10965925ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695324500; x=1695929300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhxODKU/1KHUMb12P9tKCTdkzqsk+8BNlEjNG+/jd3Y=;
        b=GrwNN/9hLscrK5fqkYez9DZBtBVh34oZ6q0evGTfUa1qjTjmOcYN0UJAL3gZ6d2vSa
         CjcMjsHkcTphgVmkMNtXoRuO/UJoOf1jKTBqR3DuYv2zhUvzbpIGx4Q4eNLiHhQji4/R
         y9DdgJMyGB2G+OqMNNjTWbHisHm1Afe7RZQ0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695324500; x=1695929300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhxODKU/1KHUMb12P9tKCTdkzqsk+8BNlEjNG+/jd3Y=;
        b=dJ61kzsFP248DWtpGFGEQdmrJpRk8HCrd6aaUlMTsadnOsKNn5AIlkQuuPsB/HOgNx
         zpExoZcP3ryEwgSxEPemOF+iLIDH87gsciUTId3rXpM3vBM8naJW51XXhu2vdBQGedlq
         eyI99d6dpsWGk9dHN3iHh5/IpX+T3tMkfkYf0qqKfwbZ5uZH8OLyK4AV/py70TCjcG3d
         FFCDbRxSjNt3lyfjhQrddx63hr67zGMZ5L46DRaNKYFxGykOmw0x9jaxqkjwMKGUsVKR
         hbqWwbHa/59P4ufvmHop2aFpjsxIMk0VJebucmEJFWohnwkCS2xIpSxbfOaKKohXtj+Q
         Uu9A==
X-Gm-Message-State: AOJu0YwFurivhnnGR8qeDCJIP4PKiaOvhUepLmnbW9x13nT7EG5sSsUH
        Effdk0DJc6z51789C0ycfu1eYA==
X-Google-Smtp-Source: AGHT+IHUQlNIbJeLrvAj7jWESgKPAFex7wB5VnwlWGMQsi3fiVSh6nFpJjIAzbg6QtOMH1SG8wCkdQ==
X-Received: by 2002:a17:902:6ac8:b0:1bb:1523:b311 with SMTP id i8-20020a1709026ac800b001bb1523b311mr5075598plt.41.1695324500459;
        Thu, 21 Sep 2023 12:28:20 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:e6ed:6d49:f262:8041])
        by smtp.gmail.com with ESMTPSA id w8-20020a1709029a8800b001b9f032bb3dsm1892875plp.3.2023.09.21.12.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 12:28:19 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>, airlied@gmail.com,
        anitha.chrisanthus@intel.com, daniel@ffwll.ch,
        edmund.j.dea@intel.com, linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 02/12] drm/kmb: Call drm_atomic_helper_shutdown() at shutdown time
Date:   Thu, 21 Sep 2023 12:26:45 -0700
Message-ID: <20230921122641.RFT.v2.2.I20cb02bafa7c2368e4bd579df0716eb62a3a21bf@changeid>
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

Based on grepping through the source code this driver appears to be
missing a call to drm_atomic_helper_shutdown() at system shutdown
time. Among other things, this means that if a panel is in use that it
won't be cleanly powered off at system shutdown time.

The fact that we should call drm_atomic_helper_shutdown() in the case
of OS shutdown/restart comes straight out of the kernel doc "driver
instance overview" in drm_drv.c.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This commit is only compile-time tested.

(no changes since v1)

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
2.42.0.515.g380fc7ccd1-goog


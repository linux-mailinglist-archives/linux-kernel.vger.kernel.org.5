Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9E57A9DC6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjIUTr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjIUTrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:47:16 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836DCA239E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:28:30 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-577fb90bb76so797268a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695324510; x=1695929310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjE+v7+9YV8M91Wchnv2I6StT/F66BSqTQ0jlAjsGeo=;
        b=Bz1MvDOX7w4+rP0FNtborBxKeiu3FaZeNyukwwR+dENSq0XFjkS3x58nk6JLljhkut
         9Bf5b1xmPqCpm0hKi/d5PjJfmXDqp1C++oies7+hAuEvwdeDvUD+M9+tjdhGOuIU4DWz
         mbPP0JazvVEMqW6y57JGa1DfJhLXtbTvLXRAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695324510; x=1695929310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EjE+v7+9YV8M91Wchnv2I6StT/F66BSqTQ0jlAjsGeo=;
        b=sEHVOZ55Vqy1DsHbgRndFo5jgJ5Wb4EEIs5YgE+FnsR60Svx7brQVVqUrNOEfRpWGY
         KL8T0p2xzQFYcr3Kwh2TM+FcjDishqiRXHmPnku7P3Y/YX95WfNQcWv98/MFXgIFSQQK
         WJvqArh5+anY+LEOrqYaB3OEvlhlIItOLOPLKzv1znd0h1CkVZDp2z484bwj9GcVg2xQ
         Yzdj2lKP/lcEu9C3Zw8MuWOyApD4XucqmCt/4H+PbSX1/rHR+JaR9sJfruvEgVv70F2A
         Exr0z7mkrVWbDcEj6nVxFnhjU0Hil+o8tFYYDQam5Q+WYaXl+CibaBC+2pSHYgFo4X2r
         OS+g==
X-Gm-Message-State: AOJu0YwWnkhOqGQzMnzqmbV0fLmarb7fHaa/pMJL0TPoFxM88sNdCPxf
        ubbxvJKNjQEk8LpmEuU66OP1GQ==
X-Google-Smtp-Source: AGHT+IE+we6oLujL1MkhnRpx7DOVM1KJZ/SsmSrAejYsuJZcNIFP8yRibQZNs1+sdIdQDwROK48mpw==
X-Received: by 2002:a05:6a20:840d:b0:154:6480:83b4 with SMTP id c13-20020a056a20840d00b00154648083b4mr7513077pzd.14.1695324509805;
        Thu, 21 Sep 2023 12:28:29 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:e6ed:6d49:f262:8041])
        by smtp.gmail.com with ESMTPSA id w8-20020a1709029a8800b001b9f032bb3dsm1892875plp.3.2023.09.21.12.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 12:28:28 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>, airlied@gmail.com,
        daniel@ffwll.ch, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        mperttunen@nvidia.com, thierry.reding@gmail.com
Subject: [RFT PATCH v2 05/12] drm/tegra: Call drm_atomic_helper_shutdown() at shutdown time
Date:   Thu, 21 Sep 2023 12:26:48 -0700
Message-ID: <20230921122641.RFT.v2.5.Ifb4450979b62976fd5a98847dade2e5b377d47c8@changeid>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230921192749.1542462-1-dianders@chromium.org>
References: <20230921192749.1542462-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
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
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This commit is only compile-time tested.

(no changes since v1)

 drivers/gpu/drm/tegra/drm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index ff36171c8fb7..ce2d4153f7bd 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -1312,6 +1312,11 @@ static int host1x_drm_remove(struct host1x_device *dev)
 	return 0;
 }
 
+static void host1x_drm_shutdown(struct host1x_device *dev)
+{
+	drm_atomic_helper_shutdown(dev_get_drvdata(&dev->dev));
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int host1x_drm_suspend(struct device *dev)
 {
@@ -1380,6 +1385,7 @@ static struct host1x_driver host1x_drm_driver = {
 	},
 	.probe = host1x_drm_probe,
 	.remove = host1x_drm_remove,
+	.shutdown = host1x_drm_shutdown,
 	.subdevs = host1x_drm_subdevs,
 };
 
-- 
2.42.0.515.g380fc7ccd1-goog


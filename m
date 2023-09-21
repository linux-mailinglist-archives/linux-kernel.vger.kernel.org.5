Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D33C7A9DD2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjIUTtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjIUTsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:48:43 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F3F2716
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:28:39 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-690f7d73a3aso1243638b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695324519; x=1695929319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLjLrmqx+liQMxms0HfuoarLoIvQ77Y5EZxHJFXGDMo=;
        b=LIF8E9mckttFvbrw4NDM1Sg64ux3FFvfxfpgs0S5Ciro8qeKUJGSsAXmN+fVtRh8vM
         c6c6Dustjci7+T6kT781AZZAANIJLJK5N1QLDiYayOLN/nmSSWhtwvcY+MkCz2O8IXNL
         V0UcSDcFiUCNQfM9PJJo7hcInXhEYma/Xeixs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695324519; x=1695929319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pLjLrmqx+liQMxms0HfuoarLoIvQ77Y5EZxHJFXGDMo=;
        b=gZ0W1W5iLJRuiVm3yAKBRzU33a2fP034Z7Vgw1enCo+lekIAUYuh2V8WAGsEoSqOip
         mRWdbgipJ2o9zmed9fDjiS8zFiaz2F3fNdfu0DEMtSLuBUV6TksgAFQwDAZtGQu/lely
         IwV/6lt1iq+LlT8Ftk9ZsWML+W3lTjct1tx/93zP1XeUxARGI+xFo5ptDYTZqk/2Y64R
         TU5DtENp6OiKb7kjT5unwdoDD1UKG3rMn36rPcReqZmkkmt9qpk1IZ/5dPA3DdL8ZRun
         sF4DjKz4xTFJ/ryTe04n1bPGV5SBDEXz9ze1psvNmLHLnRGT4RzSEvVyGUd7P5mo2Atq
         aa4w==
X-Gm-Message-State: AOJu0YweYGdA9n1dZ6dhy45xaGI5mL/CyxU+MFa4viZBe6claHxCSjkj
        QWmaj3TdNyNcHUb41btGQHgr1A==
X-Google-Smtp-Source: AGHT+IEoRL+LQQb5QJ020x/RBTSHvfniX1vz+zMVAHt3qEaz0AKEABZX30JR3ZV4ZtsBNVQhvE+uKA==
X-Received: by 2002:a05:6a20:324c:b0:148:6063:3273 with SMTP id hm12-20020a056a20324c00b0014860633273mr5419552pzc.29.1695324518923;
        Thu, 21 Sep 2023 12:28:38 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:e6ed:6d49:f262:8041])
        by smtp.gmail.com with ESMTPSA id w8-20020a1709029a8800b001b9f032bb3dsm1892875plp.3.2023.09.21.12.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 12:28:37 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>, airlied@gmail.com,
        daniel@ffwll.ch, kieran.bingham+renesas@ideasonboard.com,
        linux-kernel@vger.kernel.org, orsonzhai@gmail.com, robh@kernel.org,
        sam@ravnborg.org, steven.price@arm.com, tzimmermann@suse.de,
        zhang.lyra@gmail.com
Subject: [RFT PATCH v2 08/12] drm/sprd: Call drm_atomic_helper_shutdown() at remove time
Date:   Thu, 21 Sep 2023 12:26:51 -0700
Message-ID: <20230921122641.RFT.v2.8.I7a2dd349cb52bae53280d0a49e22cc27b923274b@changeid>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230921192749.1542462-1-dianders@chromium.org>
References: <20230921192749.1542462-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on grepping through the source code, this driver appears to be
missing a call to drm_atomic_helper_shutdown() at remove time. Let's
add it.

The fact that we should call drm_atomic_helper_shutdown() in the case
of OS driver remove comes straight out of the kernel doc "driver
instance overview" in drm_drv.c.

While at it, let's also fix it so that if the driver's bind fails or
if a driver gets unbound that the drvdata gets set to NULL. This will
make sure we can't get confused during a later shutdown().

Suggested-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This commit is only compile-time tested.

(no changes since v1)

 drivers/gpu/drm/sprd/sprd_drm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sprd/sprd_drm.c b/drivers/gpu/drm/sprd/sprd_drm.c
index 0aa39156f2fa..86a175116140 100644
--- a/drivers/gpu/drm/sprd/sprd_drm.c
+++ b/drivers/gpu/drm/sprd/sprd_drm.c
@@ -114,6 +114,7 @@ static int sprd_drm_bind(struct device *dev)
 	drm_kms_helper_poll_fini(drm);
 err_unbind_all:
 	component_unbind_all(drm->dev, drm);
+	platform_set_drvdata(pdev, NULL);
 	return ret;
 }
 
@@ -122,10 +123,11 @@ static void sprd_drm_unbind(struct device *dev)
 	struct drm_device *drm = dev_get_drvdata(dev);
 
 	drm_dev_unregister(drm);
-
 	drm_kms_helper_poll_fini(drm);
+	drm_atomic_helper_shutdown(drm);
 
 	component_unbind_all(drm->dev, drm);
+	dev_set_drvdata(dev, NULL);
 }
 
 static const struct component_master_ops drm_component_ops = {
-- 
2.42.0.515.g380fc7ccd1-goog


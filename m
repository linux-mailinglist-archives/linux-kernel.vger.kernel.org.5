Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DBE79043D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 01:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351355AbjIAXoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 19:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351278AbjIAXoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 19:44:02 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60F6170A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 16:43:26 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68bedc0c268so2192385b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 16:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693611767; x=1694216567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84GRgyYKdpTNARq0AeOvL2Otr8e52pcbhFdnubGKvgE=;
        b=GMEOdQfTBQielRTVFsB9Q8nNCGjgUsI2cc4mVTPT4ZzD7rKwi8SaChhlomKP9oZHPz
         11niVblCod0vRIwGRYqGc73UAcXT4rzp+QHYguoTGhpTweQoJ2ICQK0vDzACqJqJyt08
         skjLoZmi8pdTL96vROt4L+w1SvvKRPLyXVaL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693611767; x=1694216567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=84GRgyYKdpTNARq0AeOvL2Otr8e52pcbhFdnubGKvgE=;
        b=euKPEjzKcuEdX6iLGcUZEuX6R+quZ6iEE/hnDFN0jmv8SgE1gz/IqJZ82IKd6q6NcJ
         8kXffczOhkeZ4UYtubZc7A2oaoPx3JprlRDsZ1jRjFst18MplvK/OlpXyrgQJjiE38RT
         S1yZctnvLpOkLKHe3iszszSU2hpN0oJWWGhxczwRGbBFvU1HN8QVYmv/FOmhyKTUxwk1
         7J6zqgNij47O4bXl84FwHvGe1SzTDAMlJhHwu404LZRSGb/4z21PCFBmAR7w3PisVGSo
         AkAF8PbIiS69uUR6RnEy7U9Gd+QEi05ghP0RMyPDo8z8REc4eJwtC7LeB1lvjs8EGr2+
         kaWQ==
X-Gm-Message-State: AOJu0YxyUmBXI+Z53iV3wDh/HYd/If8jqqFdCxAexCBYIYFY0kLnroX0
        fufa6V5xOOpg99E26P43w5a+EQ==
X-Google-Smtp-Source: AGHT+IHMnRRZU1AoK52w/ETGomJDYboa0sUaaYzUFQVRras778aL93jg/RTp1bID3QpRqIrdbXtX8Q==
X-Received: by 2002:a05:6a20:54a7:b0:127:72c3:6427 with SMTP id i39-20020a056a2054a700b0012772c36427mr5163175pzk.2.1693611767663;
        Fri, 01 Sep 2023 16:42:47 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:8d94:1fc5:803c:41cc])
        by smtp.gmail.com with ESMTPSA id o9-20020a639a09000000b0056c3a4a3ca5sm3326390pge.36.2023.09.01.16.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 16:42:46 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>, airlied@gmail.com,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org, liviu.dudau@arm.com,
        orsonzhai@gmail.com, rfoss@kernel.org, robh@kernel.org,
        sam@ravnborg.org, steven.price@arm.com, tzimmermann@suse.de,
        zhang.lyra@gmail.com
Subject: [RFT PATCH 10/15] drm/sprd: Call drm_atomic_helper_shutdown() at remove time
Date:   Fri,  1 Sep 2023 16:41:21 -0700
Message-ID: <20230901164111.RFT.10.I7a2dd349cb52bae53280d0a49e22cc27b923274b@changeid>
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
missing a call to drm_atomic_helper_shutdown() at remove time. Let's
add it.

The fact that we should call drm_atomic_helper_shutdown() in the case
of OS driver remove comes straight out of the kernel doc "driver
instance overview" in drm_drv.c.

While at it, let's also fix it so that if the driver's bind fails or
if a driver gets unbound that the drvdata gets set to NULL. This will
make sure we can't get confused during a later shutdown().

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This commit is only compile-time tested.

While making this patch, I noticed that the bind() function of this
driver is using "devm". That's actually a bug. As per kernel docs [1]
"the lifetime of the aggregate driver does not align with any of the
underlying struct device instances. Therefore devm cannot be used and
all resources acquired or allocated in this callback must be
explicitly released in the unbind callback". Fixing that is outside
the scope of this commit.

[1] https://docs.kernel.org/driver-api/component.html

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
2.42.0.283.g2d96d420d3-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B407B787C41
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 01:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239973AbjHXX5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 19:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238207AbjHXX4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 19:56:43 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B761BC9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 16:56:40 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50079d148aeso503836e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 16:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692921399; x=1693526199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTYtN9ceXzi2tGhWn5q5e7ybJcm3lf5yDMeSzJkSqgc=;
        b=m7m5bNqRLv2ildg7ypzCSl7pzD6YQ2ACEiyr/aKLXnvX3zq0mVdsOmy1hyaXDPTLzr
         zOWOCUphWttuB6FiZXKEhy87cyNgL2D1hV6fTPfHItg17mDtCwf98piLHMJMyUgngLUp
         dgl/1kiB3BWEnz3tz1DEQozj7XEpxfJicBRXlzxlODaHVg3R7gu454pBuSToDWNJCOB7
         0+3/7VVaIH2R5TD0GzjfXnJPohKpfKbnQxmevWCZauIJDji+Hp00214wfkZhRZNb8o+P
         RFflNDxkDvkg1U9NFB2E9dOMyOWu7Uwd9cKnHxMwYJbcMXPRD7Tv60s7TxgLFmQwxzqz
         VJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692921399; x=1693526199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTYtN9ceXzi2tGhWn5q5e7ybJcm3lf5yDMeSzJkSqgc=;
        b=aSYG5KgUmj4DBkDW4URGE/4IdoSQrft8J+stORrIM7p6G5jMCfdeCaXh1Er2DTvW/O
         H2j9rNAwYif7nuPCD0kEgy9U6TbNaC10vTr/cjcq+lHknaNBe7HUoCflvkoItR6Qfnla
         N4tlABy5pokIJ/s9mR2H4FNeVdnjQm6e1yq+ik1JjMD3sbGtn1n0UvBR4XCR52zEMSzD
         ulPyRnsd1gCRw9XgYEzN4QOr0D1qiL4g3uGxZb4Tm0CyijGuDobwuUz2hn18mgY7oZOa
         h5xEz9MuGQUyLdq2vpgFpYui+vwzwfCf4MXepnrjEEXV0dbCb4oBOTg0GXOIMDufWXsP
         44Hw==
X-Gm-Message-State: AOJu0YzRi7z2J5kJSf1d/WEzNUZA6qMan4W+4k0UAsxU3nbqlLr5ytuh
        lfroZRHaBg3WdEUF/4u96viTUg==
X-Google-Smtp-Source: AGHT+IFizGXMYtPScMpdaqAAyY6sRQci93Si1x89ooTa46j60daVoKvz7MNehQcrSUwt2XRoMucG8A==
X-Received: by 2002:a05:6512:31c8:b0:4fb:9772:6639 with SMTP id j8-20020a05651231c800b004fb97726639mr13796882lfe.6.1692921399056;
        Thu, 24 Aug 2023 16:56:39 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id j15-20020ac2454f000000b004fe5688b5dcsm57900lfm.150.2023.08.24.16.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 16:56:38 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Simon Ser <contact@emersion.fr>, Janne Grunau <j@jannau.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v7 2/3] drm/bridge_connector: stop filtering events in drm_bridge_connector_hpd_cb()
Date:   Fri, 25 Aug 2023 02:56:35 +0300
Message-Id: <20230824235636.1436665-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824235636.1436665-1-dmitry.baryshkov@linaro.org>
References: <20230824235636.1436665-1-dmitry.baryshkov@linaro.org>
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

In some cases the bridge drivers would like to receive hotplug events
even in the case new status is equal to the old status. In the DP case
this is used to deliver "attention" messages to the DP host. Stop
filtering the events in the drm_bridge_connector_hpd_cb() and let
drivers decide whether they would like to receive the event or not.

Reviewed-By: Janne Grunau <j@jannau.net>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/drm_bridge_connector.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge_connector.c b/drivers/gpu/drm/drm_bridge_connector.c
index 1da93d5a1f61..10b52224db37 100644
--- a/drivers/gpu/drm/drm_bridge_connector.c
+++ b/drivers/gpu/drm/drm_bridge_connector.c
@@ -113,16 +113,11 @@ static void drm_bridge_connector_hpd_cb(void *cb_data,
 	struct drm_bridge_connector *drm_bridge_connector = cb_data;
 	struct drm_connector *connector = &drm_bridge_connector->base;
 	struct drm_device *dev = connector->dev;
-	enum drm_connector_status old_status;
 
 	mutex_lock(&dev->mode_config.mutex);
-	old_status = connector->status;
 	connector->status = status;
 	mutex_unlock(&dev->mode_config.mutex);
 
-	if (old_status == status)
-		return;
-
 	drm_bridge_connector_hpd_notify(connector, status);
 
 	drm_kms_helper_connector_hotplug_event(connector);
-- 
2.39.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E917B5840
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238282AbjJBQr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237844AbjJBQr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:47:26 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3C99B
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 09:47:23 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-690f7bf73ddso13052844b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 09:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696265243; x=1696870043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L94V/mhJvOGoqUkLJuYY9jGAmQ4R2zgqjGiThhQmT9g=;
        b=JefGiwQbiq860v2jxxr/5r0km/zz6nBE+kXPRrnZV20fte/MMEZWGwe4DmR34mh1QI
         wKsAXhNnCiJ8ow2pTX/oCbvQyhm4cqcE46V0k7pq7eKqOJL6z4yJ9F0/qS9GxJFChuyP
         iGc+2yDvcXlnZCDLsUy14LHp9Z0Gp+PrPy3aG4PJIWuwM3TKfYQtnE7HTdoRrtQmc8/c
         Qxch7+sg0UIshaKc/BQ8g+EFS4RaQhrtmcBGGSzUhqLxyyGSrF+G7fxQJKeXvkKk8axT
         W3tX/1jMYzHo4vD+LAr6+eHBKfeKgbKhbaacjCNG3ZlhvGI7HdZMU+XL6sT7mMyePhYn
         ZzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696265243; x=1696870043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L94V/mhJvOGoqUkLJuYY9jGAmQ4R2zgqjGiThhQmT9g=;
        b=pTVPNMJWy3jiSRCX6UjWg82vNFGHGNjU6Go1A9OeeNoGxMElJf9LXaRWfgCj1gRr4o
         tgRcEpHKmjb06mxJ1wg8Cavu7OVH1l3eSjG6xzQK+flXA+ZXVNlLQb8Jkh/2gD30YOX0
         9Izq+ke3NXNBeDdALIyUSOQoGY67+y92GZobPqKo71uttHGvBCndbat7K5JV0a0NqP8h
         097f1MpXJt2NiGd/c+511FL1G5Cmw1mscZBuUZnA2tpdKiMYmJ+RGkCsFPihM7OyNo8o
         Euh7M/uARThiAnvMKW2DEYvd3E4YHuzK/hpILdlxIEVmEKhCKbgK1VbqsWGapjOSL5dR
         IL0w==
X-Gm-Message-State: AOJu0Yw/W1djIE6BD3LYBcL0Qe2Yf6UtXfOw1RybeqM7Fiq62GayTfPg
        pf3lo+MXNpqaqJJoqdokT14=
X-Google-Smtp-Source: AGHT+IFMF9AwNXuXqclSP10HCKrHjq9ZIAqXU0my9R8SvXNzWzu15JV4oNo5krndhcPJOsDXG7B+FA==
X-Received: by 2002:a05:6a20:12cc:b0:138:836c:5370 with SMTP id v12-20020a056a2012cc00b00138836c5370mr12239506pzg.42.1696265243101;
        Mon, 02 Oct 2023 09:47:23 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id w12-20020a170902e88c00b001c55e13bf39sm22113356plg.275.2023.10.02.09.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 09:47:22 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Emma Anholt <emma@anholt.net>,
        Helen Koike <helen.koike@collabora.com>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/ci: Enable CONFIG_BACKLIGHT_CLASS_DEVICE
Date:   Mon,  2 Oct 2023 09:47:14 -0700
Message-ID: <20231002164715.157298-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Dependency for CONFIG_DRM_PANEL_EDP.  Missing this was causing the drm
driver to not probe on devices that use panel-edp.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/ci/arm.config   | 1 +
 drivers/gpu/drm/ci/arm64.config | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/ci/arm.config b/drivers/gpu/drm/ci/arm.config
index 871f4de063ad..411e814819a8 100644
--- a/drivers/gpu/drm/ci/arm.config
+++ b/drivers/gpu/drm/ci/arm.config
@@ -24,6 +24,7 @@ CONFIG_DRM_LIMA=y
 CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_PWM_CROS_EC=y
 CONFIG_BACKLIGHT_PWM=y
+CONFIG_BACKLIGHT_CLASS_DEVICE=y
 
 CONFIG_ROCKCHIP_CDN_DP=n
 
diff --git a/drivers/gpu/drm/ci/arm64.config b/drivers/gpu/drm/ci/arm64.config
index 817e18ddfd4f..45f9deb7c4f6 100644
--- a/drivers/gpu/drm/ci/arm64.config
+++ b/drivers/gpu/drm/ci/arm64.config
@@ -26,6 +26,7 @@ CONFIG_DRM_ETNAVIV=y
 CONFIG_DRM_I2C_ADV7511=y
 CONFIG_PWM_CROS_EC=y
 CONFIG_BACKLIGHT_PWM=y
+CONFIG_BACKLIGHT_CLASS_DEVICE=y
 
 CONFIG_ROCKCHIP_CDN_DP=n
 
-- 
2.41.0


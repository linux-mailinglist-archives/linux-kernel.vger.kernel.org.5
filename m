Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D634A7EF4F2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 16:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjKQPO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 10:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQPO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 10:14:28 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20CED56;
        Fri, 17 Nov 2023 07:14:25 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6c4eaa5202aso2089633b3a.1;
        Fri, 17 Nov 2023 07:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700234065; x=1700838865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=neKamCZO2wHDVbcksPS6RZHdFnPapK4yzUpgs5f2M5Y=;
        b=TqwlhRIu/qlRj1E2yMaU2KztJPTJAzUDVU6qbaujEogaWRUIqjKOfUbZfCNq894odJ
         IrkkPXnzxW1Hny3uCQXD2qniXz2BGnd6vNudC5PH86gpBb43M9Ad+JBFWDzAfEBdae87
         4gXLHl3EVIw6mb8HYIBsckvnDc9xWDngTeuaTAb5k8Gt5ew68RhuSMB4UeKXR+aJo6gC
         vePc338mvZssNi3B/Gw95ASvZTqEI/iWvpfMt/ufamFWZZdoRXWen2pNFxjt5vzturt9
         +H/706WOFcBj8FdWVKvHWKQCjM87Atfub92tpRbGoFuM2JUgfkMZJ1xH2yRYqX9Jpef4
         5ZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700234065; x=1700838865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=neKamCZO2wHDVbcksPS6RZHdFnPapK4yzUpgs5f2M5Y=;
        b=fKSJthGixcujM2Y7N/J/cN8jmA0oWtwRmhTjyW/OYm3HYov3kTYkgVbdWRl1Q5Q9Nm
         daAnpsZ6NwnvuPryjRvoswRqJRWhntavmEusn1ABjYYL9NVagAsJi9TVEiXxQOzfNJWz
         ROKiv35JY+vqirr8+BSGi9lMMFDl3O4PPIy65s5a5fMqLpwaqU4yQKVjtsO8DHu7H5tv
         qKt6LfcPHv2d9OvxcuamUf+bEvF32L4dGErB4PhXj03p6prxGqYjl525il4W0LgYm8ej
         8us5FOe+jUNxpMMuZnnScw3YytVzYzm5AaP6ZgnYkTPuzctDJR/OCuZp6pQhWfoF6eFy
         OnwQ==
X-Gm-Message-State: AOJu0YykajZqmG/RhYnViMNCAiME7LOBoeIPNFyB7jXILelse3v8UvyV
        laX55ULhTdEqonHJTIRrKfo=
X-Google-Smtp-Source: AGHT+IHNamJGjWsZcOgdHZgk/IVdURgF/leP60XW8Fd2vRVnOipM3gRSx8X3je7JYe506jJkwKWbDg==
X-Received: by 2002:a17:902:d4cb:b0:1cc:5a74:b1df with SMTP id o11-20020a170902d4cb00b001cc5a74b1dfmr13978668plg.2.1700234064990;
        Fri, 17 Nov 2023 07:14:24 -0800 (PST)
Received: from localhost ([2a00:79e1:2e00:1301:e1c5:6354:b45d:8ffc])
        by smtp.gmail.com with ESMTPSA id m18-20020a170902db1200b001c8a0879805sm1474315plx.206.2023.11.17.07.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 07:14:24 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm: Reduce fallout of fence signaling vs reclaim hangs
Date:   Fri, 17 Nov 2023 07:14:19 -0800
Message-ID: <20231117151420.351995-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Until various PM devfreq/QoS and interconnect patches land, we could
potentially trigger reclaim from gpu scheduler thread, and under enough
memory pressure that could trigger a sort of deadlock.  Eventually the
wait will timeout and we'll move on to consider other GEM objects.  But
given that there is still a potential for deadlock/stalling, we should
reduce the timeout to contain the damage.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem_shrinker.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_shrinker.c b/drivers/gpu/drm/msm/msm_gem_shrinker.c
index 5a7d48c02c4b..07ca4ddfe4e3 100644
--- a/drivers/gpu/drm/msm/msm_gem_shrinker.c
+++ b/drivers/gpu/drm/msm/msm_gem_shrinker.c
@@ -75,7 +75,7 @@ static bool
 wait_for_idle(struct drm_gem_object *obj)
 {
 	enum dma_resv_usage usage = dma_resv_usage_rw(true);
-	return dma_resv_wait_timeout(obj->resv, usage, false, 1000) > 0;
+	return dma_resv_wait_timeout(obj->resv, usage, false, 10) > 0;
 }
 
 static bool
-- 
2.41.0


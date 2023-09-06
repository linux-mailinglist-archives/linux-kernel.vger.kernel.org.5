Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E164794384
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 21:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244016AbjIFTDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 15:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244009AbjIFTCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 15:02:37 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CCECC7;
        Wed,  6 Sep 2023 12:02:34 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-792717ef3c9so4131539f.3;
        Wed, 06 Sep 2023 12:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694026953; x=1694631753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Shuu74iNOrUzggTrIzmIdLUSQe5OqUirbEavz/33+0U=;
        b=FFEglAkon2EdUzMQJvIeUA9aHlG/CB49Uyjr0uPSrrlB4t6T0rRiuktA448p/b4INr
         lrXJ1Rg+dWq+mMVVjiMn+RRN2Tvxq3j4GpGBIlynaKdftvSiBcMi+nnOk3d92fX2CUbh
         MXIjBvTRkoxjkIsNa7JCMy/zZxN1JxG+IE1qCL1bV1f419//UoBb0muo2jtzJBb/Outz
         eeYLajpdOC5tuj6YI0LqqgF36/aoPGhLlC7P6BdrPDdMxiXPzn+zHZCDT2FocCyYnuUO
         ZMcYdp4ytHP7sLysdlXwhw9SN/2APpRda5Lm1l/q4fr7ro7odEG+Lnhae7a6ZU+taigu
         K5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694026953; x=1694631753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Shuu74iNOrUzggTrIzmIdLUSQe5OqUirbEavz/33+0U=;
        b=iEInu+Z1xorFODkfFogcDGtj5OfLOz93500m7/hn+ZcUXltS/heCRbBy3ZoM31XnYX
         S/JxPOcDYaP8kygAWSFptBLRF+phsUJY5XBwUMwRYCE1bAhOd42Wcra8zMOzJf7LkxgN
         QnU/mJAw8EuwnnYZIYEmvP7VEe55s9ypldYDMWkjQImvsal5lYdS/3ii678OVCX/RsmM
         zQGFWgesDsCX1Wh/ah2oR/vgFMVvRNWZmhbYEjS7T0M3Y2cjqQQaaQ+QF0KHqAlycZC7
         JlBBg0j5XdaQhwmduHgvar3bmrY1KNMTCQqdebmQvNCIIvP5HVDpC5gbQQBgedmnxR76
         e/xQ==
X-Gm-Message-State: AOJu0YxpN9/rZ2/yvDr9LOcTLRHNayPYd6So/8uA3qVXjCwpkhpjTARY
        2u3UPj7Y5BK8PRAL2HSBoYTqTCnfqXa44A==
X-Google-Smtp-Source: AGHT+IG8dUwsOLP2n+Ukg0ohoD1JineJZS15vcrecPVQqbrwV1b9zykvv4DUg7GBrgG/kgmfyMJyGQ==
X-Received: by 2002:a6b:dc17:0:b0:792:8d16:91ef with SMTP id s23-20020a6bdc17000000b007928d1691efmr16839930ioc.18.1694026953259;
        Wed, 06 Sep 2023 12:02:33 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id w11-20020a5d844b000000b0076ffebfc9fasm5152306ior.47.2023.09.06.12.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 12:02:32 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     daniel.vetter@ffwll.ch, daniel@ffwll.ch, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, Jim Cromie <jim.cromie@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: [PATCH v3 3/5] drm/msm: add trailing newlines to drm_dbg msgs
Date:   Wed,  6 Sep 2023 13:02:21 -0600
Message-ID: <20230906190224.583577-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230906190224.583577-1-jim.cromie@gmail.com>
References: <20230906190224.583577-1-jim.cromie@gmail.com>
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

By at least strong convention, a print-buffer's trailing newline says
"message complete, send it".  The exception (no TNL, followed by a call
to pr_cont) proves the general rule.

Most DRM.debug calls already comport with this: 207 DRM_DEV_DEBUG,
1288 drm_dbg.  Clean up the remainders, in maintainer sized chunks.

No functional changes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/msm/msm_fb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.c
index e3f61c39df69..88bb5fa23bb1 100644
--- a/drivers/gpu/drm/msm/msm_fb.c
+++ b/drivers/gpu/drm/msm/msm_fb.c
@@ -89,7 +89,7 @@ int msm_framebuffer_prepare(struct drm_framebuffer *fb,
 
 	for (i = 0; i < n; i++) {
 		ret = msm_gem_get_and_pin_iova(fb->obj[i], aspace, &msm_fb->iova[i]);
-		drm_dbg_state(fb->dev, "FB[%u]: iova[%d]: %08llx (%d)",
+		drm_dbg_state(fb->dev, "FB[%u]: iova[%d]: %08llx (%d)\n",
 			      fb->base.id, i, msm_fb->iova[i], ret);
 		if (ret)
 			return ret;
@@ -176,9 +176,9 @@ static struct drm_framebuffer *msm_framebuffer_init(struct drm_device *dev,
 	const struct msm_format *format;
 	int ret, i, n;
 
-	drm_dbg_state(dev, "create framebuffer: mode_cmd=%p (%dx%d@%4.4s)",
-			mode_cmd, mode_cmd->width, mode_cmd->height,
-			(char *)&mode_cmd->pixel_format);
+	drm_dbg_state(dev, "create framebuffer: mode_cmd=%p (%dx%d@%4.4s)\n",
+		      mode_cmd, mode_cmd->width, mode_cmd->height,
+		      (char *)&mode_cmd->pixel_format);
 
 	n = info->num_planes;
 	format = kms->funcs->get_format(kms, mode_cmd->pixel_format,
@@ -232,7 +232,7 @@ static struct drm_framebuffer *msm_framebuffer_init(struct drm_device *dev,
 
 	refcount_set(&msm_fb->dirtyfb, 1);
 
-	drm_dbg_state(dev, "create: FB ID: %d (%p)", fb->base.id, fb);
+	drm_dbg_state(dev, "create: FB ID: %d (%p)\n", fb->base.id, fb);
 
 	return fb;
 
-- 
2.41.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0564F760081
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 22:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjGXUad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 16:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjGXUaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 16:30:30 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2575A12C;
        Mon, 24 Jul 2023 13:30:26 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-66869feb7d1so2818601b3a.3;
        Mon, 24 Jul 2023 13:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690230625; x=1690835425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5BNJAl+/HhqKVjKjPfAnVjqY/TXaSAI5ioNVIBm58zc=;
        b=V08awoeOFINLWgkwJiIGQEkxIFgOAXzVoZZVOMR0m9IvHfUx6aaoTVdGq4f7Q/yjbI
         RkEZSFPXrZgtPgWc2pDSWqMVwbTLYCs6eQ3+RjYvRRYGAvvNeqYz6oLy88lByUGsCor1
         lFaUgWaS46DPsQjFbUrhhM5quQ1n7TaFkCt1nUz+ACrhJ2YEJI68eEo492eROfD73+iG
         LNNobDyLMLOpnbYGvY6ikQ4wZhb2WprhRQ3c4kKSAVa4BreGIzXGZIDMRGmDk9H9ZMCS
         YAaoeUS3NvSvJXtTPFPJCSnbQLnmvpJCYItEnESJgDBcc9ualKvA+qS15JPe4mEWfLnW
         Rtag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690230625; x=1690835425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5BNJAl+/HhqKVjKjPfAnVjqY/TXaSAI5ioNVIBm58zc=;
        b=VfBrauHiztSD0C0ty1SWie/AIH/yuqkXiFP/I/fP4PMFD2PongLeFRvLQtUBXxkjXR
         Zx8t7G4lyJcIMfuEtyn/Hx+Ou07rrQeNYi8yUuF5Bcw6gf4Tea+auNpUpD9d1XpxKUAy
         uArPRmQJNAqdCvFxNxAB3nALuNe7XBVHqM2kFItr+sh+9dcOATamg6ReDyx5QOzfw47U
         qXbGegmhS9fw+DwKpJT0BRDR+TLo67PD+qpPSKXTLtK16YZycJtLxMOdgT2NAltkA1nl
         jdcjdGgByOG5XA45kAKmDOkxsGIcBGFEhvnq3nxr6ffIfjhBV0nwLZzyIYyP/qhewMRF
         YKYQ==
X-Gm-Message-State: ABy/qLbJqXbHJBFHklELUfdpqMOtnpmNb/Jspc0ghbdlEyptQio3p7zL
        PVfPpN4shlnwgUT+LcmRrcQ=
X-Google-Smtp-Source: APBJJlEb6W5sHnwrtOUP5D6oZIB3+ii60YRuLGHeoKQ0bJ1BZdGpTI+paNOSv1EpR4gfYJv6xXW25A==
X-Received: by 2002:a05:6a21:78a3:b0:138:198f:65ca with SMTP id bf35-20020a056a2178a300b00138198f65camr12337920pzc.13.1690230625436;
        Mon, 24 Jul 2023 13:30:25 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id v11-20020a62a50b000000b00682a16f0b00sm8057046pfm.210.2023.07.24.13.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 13:30:24 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm: Disallow submit with fence id 0
Date:   Mon, 24 Jul 2023 13:30:21 -0700
Message-ID: <20230724203021.147819-1-robdclark@gmail.com>
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

A fence id of zero is expected to be invalid, and is not removed from
the fence_idr table.  If userspace is requesting to specify the fence
id with the FENCE_SN_IN flag, we need to reject a zero fence id value.

Fixes: 17154addc5c1 ("drm/msm: Add MSM_SUBMIT_FENCE_SN_IN")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 9d66498cdc04..63c96416e183 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -901,7 +901,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 	 * after the job is armed
 	 */
 	if ((args->flags & MSM_SUBMIT_FENCE_SN_IN) &&
-			idr_find(&queue->fence_idr, args->fence)) {
+			(!args->fence || idr_find(&queue->fence_idr, args->fence))) {
 		spin_unlock(&queue->idr_lock);
 		idr_preload_end();
 		ret = -EINVAL;
-- 
2.41.0


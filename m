Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802647DACF5
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 16:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjJ2PIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 11:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjJ2PH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 11:07:56 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2498EBC;
        Sun, 29 Oct 2023 08:07:52 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6b20a48522fso3305579b3a.1;
        Sun, 29 Oct 2023 08:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698592071; x=1699196871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lt1yPiSudbjGWZyU7fD8DRkiWRaUYJwJXas2ZsoVM40=;
        b=WuLmA1toE2/Yt/cFUt+jPZqgjyC6jZuRcda8PwjdcOWsS+jPlwp/NMM4lmsScO6Kyt
         4jpHVRAYdcXzjrF+VADGXKcI7sLEfv7pH3hqn4ziqnO6+wC46UTX/MPYcX8RVBj5RnPF
         1JXJqg6d1IbC0nO8Rcs8s11RVzrhsp5WlCykYoW04Xj6Oxo0a2D2u5PBlccCfAcJdt1p
         NaJnUZrlv44RDfV9u3w4WojtkRs0JI5PY9RFLyl7LF8qWF5RmxOsgZG36+F9V71v8AR1
         UspM3eDhp1SwA0BOXjQ0Vdii0mfGwwbYYwrnbzMnnjfQsAF0WW8jAdYsY7AqwT1TId5f
         xFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698592071; x=1699196871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lt1yPiSudbjGWZyU7fD8DRkiWRaUYJwJXas2ZsoVM40=;
        b=JbyquM56QEHOQ0FH/E+e2tcn4XmxQ7wT56HdaHUSXQBOsIKaED+1HbkjkwfnKKWC5i
         tvl0CbOjiEhDBbWxyEVBDfkSf/fh+auymkToB3+Wlc+i3RXKl/Y/whgxJFBO3J0Cfyoe
         aGiaWhEgkvdD62cHqs2MoUDrabUT9ELMHaVA9crSxpcSNUv/6FwVH12d4w0X7sfx8jIn
         X0wpUtdHVsmfgubDYXIUROizyK6Iuq1rFW51c7VjMNeWTqRt/5zOmJHhYZgM5xU7OSpU
         86XOMyTQ/xFhWKYV3yyh8G3vAEsTdpp+hBbfPhD3VOMcKp9H3DFcl8fcabn/WjAS8V2L
         3xrA==
X-Gm-Message-State: AOJu0YwlslWHAcyd2aak55Zvc3rZJ1Zik1BK+TN7T3bTEera7ulyx28W
        PN0czmund9ag17B4/T3ld5g=
X-Google-Smtp-Source: AGHT+IGCMUKh34gT5nl8CUjZ566Kd2FRN3OEZw5HRLc+unyF38DiiGuQSIWjSbXNTAFuqoOsPqb+tA==
X-Received: by 2002:a05:6a21:7985:b0:159:b7ba:74bd with SMTP id bh5-20020a056a21798500b00159b7ba74bdmr5750825pzc.50.1698592071558;
        Sun, 29 Oct 2023 08:07:51 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
        by smtp.gmail.com with ESMTPSA id p22-20020a637f56000000b005b8ea15c338sm3466302pgn.62.2023.10.29.08.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Oct 2023 08:07:50 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Stone <daniels@collabora.com>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/2] drm/msm: Small uabi fixes
Date:   Sun, 29 Oct 2023 08:07:37 -0700
Message-ID: <20231029150740.6434-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231027194537.408922-1-robdclark@gmail.com>
References: <20231027194537.408922-1-robdclark@gmail.com>
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

Correct the minor version exposed and error return value for
MSM_INFO_GET_NAME.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 4bd028fa7500..781db689fb16 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -51,7 +51,7 @@
  * - 1.11.0 - Add wait boost (MSM_WAIT_FENCE_BOOST, MSM_PREP_BOOST)
  */
 #define MSM_VERSION_MAJOR	1
-#define MSM_VERSION_MINOR	10
+#define MSM_VERSION_MINOR	11
 #define MSM_VERSION_PATCHLEVEL	0
 
 static void msm_deinit_vram(struct drm_device *ddev);
@@ -896,7 +896,7 @@ static int msm_ioctl_gem_info(struct drm_device *dev, void *data,
 		break;
 	case MSM_INFO_GET_NAME:
 		if (args->value && (args->len < strlen(msm_obj->name))) {
-			ret = -EINVAL;
+			ret = -ETOOSMALL;
 			break;
 		}
 		args->len = strlen(msm_obj->name);
-- 
2.41.0


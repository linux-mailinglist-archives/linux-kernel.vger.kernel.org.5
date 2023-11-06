Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF737E2C51
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 19:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbjKFSui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 13:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbjKFSuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 13:50:37 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2033A2;
        Mon,  6 Nov 2023 10:50:34 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5bd5809f63aso1492271a12.3;
        Mon, 06 Nov 2023 10:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699296634; x=1699901434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbZHoFm5w89rbvcHzOI1Y29sJ52jYRELVKrydv1YshI=;
        b=fpRMSIh6wt6SnmbT2j6BvcV57EhpCN9gQcsVTUELuX9GfiF5dnLYYKazUdxU4Y89RR
         le9PtqWoGcFgXG8DrkmgNxAIu4SnNPJaDXGFKJcpUXoQHF1Spz9fuGXPYF6Friq3ks6g
         zEKGmZNgFCVic8NlisD+w5QtC9K1YEwYIluVOpZcdw1dovRh239uqKRg2ef0dYXN1DyN
         xKY8dYHXxfPyT0kSUSNf1ZN5m2wcgRccIN6bd38FNBH4CQ9hJMCPZM607qBTgWCQhGig
         VrV/msKmX9kh5SEC2VaLSo1mQEa+QI83f0pLEFJ3yLqcCG8ZX4Kw8SCJRbWr/+QzZafE
         aJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699296634; x=1699901434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BbZHoFm5w89rbvcHzOI1Y29sJ52jYRELVKrydv1YshI=;
        b=Hkb/zzlHSizvXhYHgdeQA7opR52r49Wn8yCGV/d1aC1lZbBrHJFfFxX97reG3HlcPn
         0e7CMV8oAHap5dbAZ/baTNuo/VnQtrCP0a4rD6Zf3ralduf0Nl705IylB5geMlkr9rj2
         G+W6AFq26ZtFZ9w1c6AAnE5jm/E9SqML0j9xCbSyybmj+p/UKkEiR7NLtGzMQvPWw6Op
         uaenywJhwaN7eMQzYZaVBY7Q7cWnkmDSTPXifWOcoeLYFU+A17ixQfP3tFf/7rWqcURW
         UU1k+Nc+WUGXeeJOC9wi5e0POLZGvwdPnEjlwC6nH8PTZIA/AmdXoWY0ukid+3X3IQ7/
         L7yg==
X-Gm-Message-State: AOJu0YynicHZJN+3nT7p4ZvCBSaQZxN+2mesCxM7Teqcujd5maEhAb+R
        7PnmLL2XBWar+c0PVoaJzW0=
X-Google-Smtp-Source: AGHT+IGhsd7dKnKkuP0PyCYSzmh3qYPVdS4aj7RxgdNyj2BgmC5mHgkGjpDmgh5vEvP9lnB6WmWyGQ==
X-Received: by 2002:a05:6a20:938b:b0:15a:bf8:7dfc with SMTP id x11-20020a056a20938b00b0015a0bf87dfcmr28118461pzh.15.1699296633944;
        Mon, 06 Nov 2023 10:50:33 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id v28-20020a63465c000000b0059cc2f1b7basm107405pgk.11.2023.11.06.10.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 10:50:33 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Stone <daniels@collabora.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/2] drm/msm: Small uabi fixes
Date:   Mon,  6 Nov 2023 10:50:25 -0800
Message-ID: <20231106185028.209462-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106185028.209462-1-robdclark@gmail.com>
References: <20231106185028.209462-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Correct the minor version exposed and error return value for
MSM_INFO_GET_NAME.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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


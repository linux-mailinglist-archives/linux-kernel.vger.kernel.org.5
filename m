Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B55772C69
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjHGRNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjHGRMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:12:47 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9199B1986;
        Mon,  7 Aug 2023 10:12:15 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-686d8c8fc65so3208615b3a.0;
        Mon, 07 Aug 2023 10:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691428334; x=1692033134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMDPDTveGL0XcUxjW8MDNhSNAkJwzlTE+WboD+rmGEU=;
        b=svVt1sgUF7x1YbOXMTb/LXp7QjBOTHtNb8DiQLjmMtrEWj4ty/S5vDIeMV8H12mp3a
         XQr2nX5ioj/beq3rDTI6+ojt44Z4DxeRpai4d7e+k7pANjjydatG2mTgT37mQT7Ff539
         uDj8V1vybkcUUTID5vu6jrgx0kyh1twMlgxmd2T/N6fPrh46TsL7aYuJY5RR87Vh4zEy
         jzL2d4hMqzqLQTjbIpnQ32lBmU9dxWSG1jGXSTvCDgrEhTokei0gJ4+/L2SorlPl8z5J
         5/grMIa9/ueGhGhxfCtjYWIE6SmxmZ1/GJCCw6ZpV3idMpjTjdntWXwxcaffTQrSCBX8
         jP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691428334; x=1692033134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pMDPDTveGL0XcUxjW8MDNhSNAkJwzlTE+WboD+rmGEU=;
        b=TuozLMa5u7CvrGQu7MOtApJlVf4UqpgoVrov2cx4Vdf/bGteLg4VXd0MlDaROj14qP
         Mo2lOSQL8AmmoRIfB2sQpW3WJkz70N3piy9jLXV5zLMFD3vRmMKZJXHwoSLyAA/PKhpg
         lznL4LaAdRP8l3ju8QVIP+wSJ6HDoYC5aqEaRtpe66UFiKBLx/M47uRUv05eIBehtUFV
         mER+VzUlCRui/PAngeWMAh2UzhahCQtxDfB17LV4jszb4qmn6dmwJwgOjE5fQ5PPD3S8
         aoWbU4d3+t+WkBcJD8OOxO1Ufqo8S27IN/ZZWMpazyUPddRwnJ0tQd5Ejmb415NHxh38
         W/Mg==
X-Gm-Message-State: AOJu0YzrfYWTMGl8Qavk/rcosl/FWe/0bk3jYmsnLPwcVZA8nyqwArSZ
        A7QMGFB0xB+2DBTB4uKoIvNZUxgTvHA=
X-Google-Smtp-Source: AGHT+IESqsFrdWXCLbRPVnpB+2WjHUyu1uvM4zg/KZaTPTkJI5DlDm8uH99nJv+r7YF5tYdcV+cexg==
X-Received: by 2002:a05:6a20:9389:b0:135:110c:c6dd with SMTP id x9-20020a056a20938900b00135110cc6ddmr10076469pzh.53.1691428334171;
        Mon, 07 Aug 2023 10:12:14 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id n14-20020a62e50e000000b0065438394fa4sm6564282pff.90.2023.08.07.10.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 10:12:13 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Luben Tuikov <luben.tuikov@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 8/9] drm/sched: Add (optional) fence signaling annotation
Date:   Mon,  7 Aug 2023 10:11:42 -0700
Message-ID: <20230807171148.210181-9-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807171148.210181-1-robdclark@gmail.com>
References: <20230807171148.210181-1-robdclark@gmail.com>
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

Based on
https://lore.kernel.org/dri-devel/20200604081224.863494-10-daniel.vetter@ffwll.ch/
but made to be optional.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 9 +++++++++
 include/drm/gpu_scheduler.h            | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 7b2bfc10c1a5..b0368b815ff5 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1005,10 +1005,15 @@ static bool drm_sched_blocked(struct drm_gpu_scheduler *sched)
 static int drm_sched_main(void *param)
 {
 	struct drm_gpu_scheduler *sched = (struct drm_gpu_scheduler *)param;
+	const bool fence_signalling = sched->fence_signalling;
+	bool fence_cookie;
 	int r;
 
 	sched_set_fifo_low(current);
 
+	if (fence_signalling)
+		fence_cookie = dma_fence_begin_signalling();
+
 	while (!kthread_should_stop()) {
 		struct drm_sched_entity *entity = NULL;
 		struct drm_sched_fence *s_fence;
@@ -1064,6 +1069,10 @@ static int drm_sched_main(void *param)
 
 		wake_up(&sched->job_scheduled);
 	}
+
+	if (fence_signalling)
+		dma_fence_end_signalling(fence_cookie);
+
 	return 0;
 }
 
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index e95b4837e5a3..58d958ad31a1 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -493,6 +493,7 @@ struct drm_sched_backend_ops {
  * @ready: marks if the underlying HW is ready to work
  * @free_guilty: A hit to time out handler to free the guilty job.
  * @dev: system &struct device
+ * @fence_signalling: Opt in to fence signalling annotations
  *
  * One scheduler is implemented for each hardware ring.
  */
@@ -517,6 +518,7 @@ struct drm_gpu_scheduler {
 	bool				ready;
 	bool				free_guilty;
 	struct device			*dev;
+	bool 				fence_signalling;
 };
 
 int drm_sched_init(struct drm_gpu_scheduler *sched,
-- 
2.41.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300C278492E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 20:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjHVSDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 14:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjHVSDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 14:03:08 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819F5E6E;
        Tue, 22 Aug 2023 11:02:53 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bf62258c4dso19637075ad.2;
        Tue, 22 Aug 2023 11:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692727373; x=1693332173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWTFCIAZmBfA/MXBTibsw5+lmGqMuDYbvZM3o5ozilI=;
        b=sIVmrjcxitFg4JJkvgu3n9lZfj+ZSoymmV8gHVUoJnc+FzgpSsasuqzAXhGRBrljDK
         DEIkTj8WkF7AizHnQWUzvOjfQJfbnSs0d/tkzbs2tK73XP+c7L0CvkBD/Y3OKA5EYVdq
         EUwL1J5uSulGu8DxFtG01OFb64dwzI57BkYCDnd1E15xGR/cKqQAxtiF89wZ1RlnkaVy
         3upuoiMg2Tl9TmjGpaPZvByfpvcu5DVWFfIY/ss86Jj0DG77M7K3kXLLUoYBu6auFJmE
         i7dUEUj7qduUDX7ihwu6sKvV9bjU+vUH44d9oAST7+HcJ7MwI0FChfLRYMMNbpDsqtRX
         AhkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692727373; x=1693332173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWTFCIAZmBfA/MXBTibsw5+lmGqMuDYbvZM3o5ozilI=;
        b=AGODe5vV9HgzVxjAH32kaSmwuU9ByWxnitDcX/PAiNjrgFnBtC0dIPYPEtap/N1lhX
         NzqOvDhz1GAXarTb5VwWVGR+e0t4evV6vQcG5wM+lXOXxMgLSleBaX+OUQFIlpOrej76
         OwZJBBY+FDADEfOUa6PKutPaVlcbqXoF2ODOJ3ixUh97HN3h0KVhYNBNv1E2AX9/k0QI
         m3NaJ9DCtblX60dwSsFIIdids4CznNPi10zG8QmClfwZwz4iSyoei0FurgR0veqjGddM
         687mE5aSysnUV8biEvpgksRlm5xrIvBUiy5kPYEBBvYVk2Ge8VJPa4IEo/+TqgaPVekl
         rDfA==
X-Gm-Message-State: AOJu0YzGjWA07XJMUaWsbL47fU3NbF3b/P8kXX70NNgRn5nQXL2Dz6C9
        gGxkNKwH1vV7/o1x5ljHtoY=
X-Google-Smtp-Source: AGHT+IHqlGWpSm+itCsmoVu7dzoE8tI7bdalCAnDaQMOyO+v4DHR0mT7LaS+Ix96c8+CTKvupoRMMA==
X-Received: by 2002:a17:902:d345:b0:1bb:1e69:28be with SMTP id l5-20020a170902d34500b001bb1e6928bemr7341664plk.42.1692727372807;
        Tue, 22 Aug 2023 11:02:52 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902748900b001ac7f583f72sm9303844pll.209.2023.08.22.11.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 11:02:52 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Luben Tuikov <luben.tuikov@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 10/11] drm/sched: Add (optional) fence signaling annotation
Date:   Tue, 22 Aug 2023 11:01:57 -0700
Message-ID: <20230822180208.95556-11-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822180208.95556-1-robdclark@gmail.com>
References: <20230822180208.95556-1-robdclark@gmail.com>
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
index 23afd70e41ea..6dda18639ac9 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1018,10 +1018,15 @@ static bool drm_sched_blocked(struct drm_gpu_scheduler *sched)
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
@@ -1077,6 +1082,10 @@ static int drm_sched_main(void *param)
 
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E27D7EF538
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 16:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjKQPYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 10:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjKQPYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 10:24:35 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4795EA6;
        Fri, 17 Nov 2023 07:24:32 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cc316ccc38so18961505ad.1;
        Fri, 17 Nov 2023 07:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700234672; x=1700839472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uBvEQIGbC4HURF/ntUyUlcav9b00XtnohKM7H7UZq1s=;
        b=OaFko0/qtrAFxBOJmfA0XFJ32AcaZ5bQvg8MUpcvjBYE8zEnHS0jZWAZ2wa/IXrLst
         e+1fgoOotAPqD/W1mQLqUmyvJY3TPg95nIn85iNj6/50ptRjlb26IXY+FHoQDhnJMoIc
         oQ1ryjkOK/Z8cdxj48G0T+sPO6A5DGIlxlGDDX0kZaVa7WNiO5ZVzcDiXPYWpeYo03Pg
         vYsTmxesQDdZuWdiAqyCaBS7RfaN3BLG/nUPAq2qDQJ5sDwCngfVQ2D9m4AHFTyG2YUm
         96hJYdvpbhdMljRUcQILB+4upC1LYvtWL7nr/hlrwDzpVqJmHf2dJWMzEkl6Fxq1Ef4t
         RYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700234672; x=1700839472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uBvEQIGbC4HURF/ntUyUlcav9b00XtnohKM7H7UZq1s=;
        b=UkgvfHVbSn7g3W1Nae9hDq/axGQbJbfo0L1+9POSeWT2Q4teqF5h2bPevfWXGv0FUF
         U/XzcNxeB9wjexERjTWg5b48gxFXCOg/MaqotJ948CLgTlwWHCYts2Eylo7EYQtdTjQa
         r8hZZ4I8bUKkPHr55uUIBavFFW3wFfIthvuoHGZ7TXikmFZKJGKDC8hfJ7A5UCDwd6Q2
         HQ8HvihsgAaGdznf8HE20Ah/I8RzjJfCxCbquSg90cOiJJbYx4lJYohwQSQiTeSD9OEm
         XaznHL+iHi3bwARzBhyr3Z61FIT2Oh9tJZwu+/LcImIYH7Pls25vnqpQLN+RUtd2QcXy
         Em4g==
X-Gm-Message-State: AOJu0Yzza17JwhK0g82NKmFRCOqnrhYkFcZF/bK2dsup1JYbs3ag487e
        cnT0g3se5zEn+WRiyNPjVAQ=
X-Google-Smtp-Source: AGHT+IGTPCDBXhcUUjrXC4Dbd4cFWutY1Bl9KA7ZGsMeXgRJUlzNmkIzq5Rli0oYI5LYgJOwaYw/Zw==
X-Received: by 2002:a17:902:e5c3:b0:1ce:5b6d:e6b1 with SMTP id u3-20020a170902e5c300b001ce5b6de6b1mr3482012plf.17.1700234671579;
        Fri, 17 Nov 2023 07:24:31 -0800 (PST)
Received: from localhost ([2a00:79e1:2e00:1301:e1c5:6354:b45d:8ffc])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902cecc00b001c73f3a9b88sm1504162plg.110.2023.11.17.07.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 07:24:31 -0800 (PST)
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
Subject: [PATCH] drm/msm/gpu: Skip retired submits in recover worker
Date:   Fri, 17 Nov 2023 07:24:28 -0800
Message-ID: <20231117152428.367592-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
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

If we somehow raced with submit retiring, either while waiting for
worker to have a chance to run or acquiring the gpu lock, then the
recover worker should just bail.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gpu.c | 41 +++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 3fad5d58262f..fd3dceed86f8 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -365,29 +365,31 @@ static void recover_worker(struct kthread_work *work)
 	DRM_DEV_ERROR(dev->dev, "%s: hangcheck recover!\n", gpu->name);
 
 	submit = find_submit(cur_ring, cur_ring->memptrs->fence + 1);
-	if (submit) {
-		/* Increment the fault counts */
-		submit->queue->faults++;
-		if (submit->aspace)
-			submit->aspace->faults++;
 
-		get_comm_cmdline(submit, &comm, &cmd);
+	/*
+	 * If the submit retired while we were waiting for the worker to run,
+	 * or waiting to acquire the gpu lock, then nothing more to do.
+	 */
+	if (!submit)
+		goto out_unlock;
 
-		if (comm && cmd) {
-			DRM_DEV_ERROR(dev->dev, "%s: offending task: %s (%s)\n",
-				gpu->name, comm, cmd);
+	/* Increment the fault counts */
+	submit->queue->faults++;
+	if (submit->aspace)
+		submit->aspace->faults++;
 
-			msm_rd_dump_submit(priv->hangrd, submit,
-				"offending task: %s (%s)", comm, cmd);
-		} else {
-			msm_rd_dump_submit(priv->hangrd, submit, NULL);
-		}
+	get_comm_cmdline(submit, &comm, &cmd);
+
+	if (comm && cmd) {
+		DRM_DEV_ERROR(dev->dev, "%s: offending task: %s (%s)\n",
+			      gpu->name, comm, cmd);
+
+		msm_rd_dump_submit(priv->hangrd, submit,
+				   "offending task: %s (%s)", comm, cmd);
 	} else {
-		/*
-		 * We couldn't attribute this fault to any particular context,
-		 * so increment the global fault count instead.
-		 */
-		gpu->global_faults++;
+		DRM_DEV_ERROR(dev->dev, "%s: offending task: unknown\n", gpu->name);
+
+		msm_rd_dump_submit(priv->hangrd, submit, NULL);
 	}
 
 	/* Record the crash state */
@@ -440,6 +442,7 @@ static void recover_worker(struct kthread_work *work)
 
 	pm_runtime_put(&gpu->pdev->dev);
 
+out_unlock:
 	mutex_unlock(&gpu->lock);
 
 	msm_gpu_retire(gpu);
-- 
2.41.0


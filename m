Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F0278492B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 20:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjHVSDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 14:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjHVSDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 14:03:04 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358A71987;
        Tue, 22 Aug 2023 11:02:51 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68a3e943762so2499617b3a.1;
        Tue, 22 Aug 2023 11:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692727370; x=1693332170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27p7IUrBUbclutUTfVSGUQESAA2avJiwqyRR2x+l1m0=;
        b=qJl84xabqxGctlufYYzZ0tK+WdNRFigoyJ87qxZpQtgmA+acOyhabn8gTemh9n05ni
         PrFKzld/dpUV6jdQXKKsGoyh37PRNJhie8iLPhyiFPcWEq46TDJEfqp8lPkrajyI02vb
         HcjSrnk3+Sb78LFi913m990ox8rpRBjj6EvC3aT626z9mBc48paFjfRvBtT+Vyx5+6Ta
         syzF8lGdPeM36rMkVtwdG+qTDIk31NAbDyzMyPKkxCiumGT0nkwDVWSkZBRo4T2DM98g
         akQz/jtPABwezTKc+bkP7VpNcSkPW93u7DkZpycYu07E5Tfgd2Zzu7KG0IOkMPvpnrfd
         Uw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692727370; x=1693332170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27p7IUrBUbclutUTfVSGUQESAA2avJiwqyRR2x+l1m0=;
        b=S5agQhC8Yry8mtwPScUoclSlpMUBJESz3qXx0CB8TCX7ywErUF9EKJ6peHn0FPebSt
         77Vy8rQOI2Mfy+d0eSuWjeJCdyqD8PSuRzig/kSMeNr455hH5SqA2v3p26GW+ByGzzWP
         TlgXo9RZeXs7etU5oOfNY/zUf7TSEgwrb0eeZubCvGAF/HfpqZ6lfZw9wgP+hNnaS+C6
         bbaKaSfEh1SLdAyeB+ki2ZayO+ovxkUfqA7iwfk52NDqQzUMU5YdAhw7Rj4HBunekDtb
         zbI01fUPaSj42KkQRSB40rw8vqw+pKrr2IhWGHlUlt3H30YqMoSd1C7IDX6dDaFS/h3e
         ZQwg==
X-Gm-Message-State: AOJu0YzU8fRdeXz/qTs0lE7b3eaAHXldTJwfQ3dcB2MWeDQ6wUOMsJfB
        73wCbBiCHyzhSoZrqcGOBZs=
X-Google-Smtp-Source: AGHT+IFbzkBQEmwWFyVgVJJbK2lNicqTu/4XV7Sr++rA7JFjJhZHCsZjniDhF+EF9SEPv+aSjlrV1w==
X-Received: by 2002:a05:6a20:7da9:b0:134:1011:8582 with SMTP id v41-20020a056a207da900b0013410118582mr12765394pzj.47.1692727370533;
        Tue, 22 Aug 2023 11:02:50 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id r5-20020a638f45000000b00528db73ed70sm8145026pgn.3.2023.08.22.11.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 11:02:49 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 09/11] drm/msm: Move runpm enable in submit path
Date:   Tue, 22 Aug 2023 11:01:56 -0700
Message-ID: <20230822180208.95556-10-robdclark@gmail.com>
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

Move runpm enable to just before we enqueue the job to the scheduler,
rather than job_run().  This has the disadvantage of potentially
powering up the GPU before waiting for fences, but it is the only
feasible way to move things like clk_prepare() out of the fence
signalling path.  Ideally runpm would have separate prepare and enable
steps so we could just move the prepare step.  But attempting to
separate these without support in runpm doesn't play nicely with
autosuspend.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 2 ++
 drivers/gpu/drm/msm/msm_gpu.c        | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 99744de6c05a..a908373cf34b 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -981,6 +981,8 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 
 	msm_rd_dump_submit(priv->rd, submit, NULL);
 
+	pm_runtime_get_sync(&gpu->pdev->dev);
+
 	drm_sched_entity_push_job(&submit->base);
 
 	args->fence = submit->fence_id;
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 243f988c65b7..819140d85205 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -751,8 +751,6 @@ void msm_gpu_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 
 	WARN_ON(!mutex_is_locked(&gpu->lock));
 
-	pm_runtime_get_sync(&gpu->pdev->dev);
-
 	msm_gpu_hw_init(gpu);
 
 	submit->seqno = submit->hw_fence->seqno;
-- 
2.41.0


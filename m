Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E377D9E4C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 18:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345942AbjJ0Q7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 12:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345900AbjJ0Q7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 12:59:20 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CB4E1;
        Fri, 27 Oct 2023 09:59:18 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c9bf22fe05so18345035ad.2;
        Fri, 27 Oct 2023 09:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698425958; x=1699030758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCHqUpshEkU4uWbTOdbsyvXx4BZI7LlABnlafBr9UIc=;
        b=Y2D3Dev0YxhSuZG7DQue0kJbsaTscjpE8ecYc9xzg6gjvPc/vaB3SvTa5Hdbwx++6M
         onswnAMpneOB+pP50r21w48VMq0IuMyji38Sd7mxtearc8e9SM5hzl1khdIccAkUR9CJ
         TUloYaROz9CVUpmO+3jBcs647220Ncwb66onAQz89LCug9Cwn0pE9D7WK+YoinkfPLCd
         3UW4t0oDjo3byqzuK9y+Vj0m0NRYYYUuDSk/y9afDHkaLQ/kZlMVtlZSGWj1ZjtbQhPt
         5Qv71FBO6509bwKAf+c5wKDsjMSeyjpCwyOqV8L7j4S9x3UdFbbE7/Nfrw3OpBDMxGKL
         GXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698425958; x=1699030758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iCHqUpshEkU4uWbTOdbsyvXx4BZI7LlABnlafBr9UIc=;
        b=T217RI5MlvPkCt/D93bt+eJZTP2eBqHcszPNkPCLcwuTpdrkpSxcvVcFhLejMO41AS
         XKS+D6daH+hVe1m1AHqTzFJ4//ixVrRAI6yrmq9wHURoOxmfkqkwSWwF/DpbmkWt/1Wf
         1sk/JQG9EGfPW30+2nISD7fNo3YORCe23pOfcIFqbQRsAERwZYF98QxOEVY6LmLT+7zD
         7cKfvbEcZxXMb2kB8FCcWFPAzj8kJddUjU0UEB5QHa9i32pSjVQCqmUws39e0KD1N2Tm
         VGbkhxZ9V9ocKHjgdQQbqPCOI2k+GWTsFzIfM5Oo+MEua4KwlQDKEgzTpdcvv8TyBFd9
         AhKA==
X-Gm-Message-State: AOJu0Yzn0pp6aJ37DICfxCoYMFXZtiMY6wrHjptTjYU1ai2EInzF4/xR
        /ZZERE2p1qgPaEi6dpO6lJc=
X-Google-Smtp-Source: AGHT+IE1CRcZ68zfn23VeMoSQ6OlsNc9UY4jVYsIdmVtGSYUiW5fTt9cYVK7YDD7M/nHh0YLWuRTjA==
X-Received: by 2002:a17:902:f34d:b0:1ca:e4b:148d with SMTP id q13-20020a170902f34d00b001ca0e4b148dmr2584344ple.65.1698425958278;
        Fri, 27 Oct 2023 09:59:18 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id w9-20020a170902e88900b001b7fd27144dsm1797802plg.40.2023.10.27.09.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 09:59:17 -0700 (PDT)
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
Subject: [PATCH 2/7] drm/msm/gem: Remove submit_unlock_unpin_bo()
Date:   Fri, 27 Oct 2023 09:58:36 -0700
Message-ID: <20231027165859.395638-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231027165859.395638-1-robdclark@gmail.com>
References: <20231027165859.395638-1-robdclark@gmail.com>
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

The only point it is called is before pinning objects, so the "unpin"
part of the name is fiction.  Just remove call submit_cleanup_bo()
directly.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 996274ef32a6..2d5527dc3e1a 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -272,12 +272,6 @@ static void submit_cleanup_bo(struct msm_gem_submit *submit, int i,
 		dma_resv_unlock(obj->resv);
 }
 
-static void submit_unlock_unpin_bo(struct msm_gem_submit *submit, int i)
-{
-	unsigned cleanup_flags = BO_PINNED | BO_LOCKED;
-	submit_cleanup_bo(submit, i, cleanup_flags);
-}
-
 /* This is where we make sure all the bo's are reserved and pin'd: */
 static int submit_lock_objects(struct msm_gem_submit *submit)
 {
@@ -313,10 +307,10 @@ static int submit_lock_objects(struct msm_gem_submit *submit)
 	}
 
 	for (; i >= 0; i--)
-		submit_unlock_unpin_bo(submit, i);
+		submit_cleanup_bo(submit, i, BO_LOCKED);
 
 	if (slow_locked > 0)
-		submit_unlock_unpin_bo(submit, slow_locked);
+		submit_cleanup_bo(submit, slow_locked, BO_LOCKED);
 
 	if (ret == -EDEADLK) {
 		struct drm_gem_object *obj = submit->bos[contended].obj;
-- 
2.41.0


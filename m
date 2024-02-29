Return-Path: <linux-kernel+bounces-86950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A74686CD6E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA7C1287666
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D51914F9D8;
	Thu, 29 Feb 2024 15:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3E1Be57"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB59014E2D5;
	Thu, 29 Feb 2024 15:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221737; cv=none; b=Xee2+uQb712IF9sddQ8k2Rz6ntFur0+6TP5GQ3o+AdZmyNUO9CaRLwSu26W0fLgnnwxJmXf1ARmmIPwpMQuyDZdDzbBnIxy/mu12f58VLHdzIvWCi32ks/dmKCx/VrU/UK7XORKiPSPNbp1ke08z9i1UCjtD2FWPYrFAyRX+XzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221737; c=relaxed/simple;
	bh=+fv1LPuaO3JTr5Lszuh69m3jbmo7lu1K9f9DlffKTl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DRVBbGl9FyvV5+LLzZrBwWbiEI7wYovreIYh76cdKiGhurA78q/Tj005Bky/4wfhWvABh6lVz/R4PoYokLLKUZMIncggpASW50UgHvXC8uYdHeqXr/VtBzCMUMgG3Y1fyvjgx+QadyR0piAj4eOURg1tTukNOE5tBU8euTT2t7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3E1Be57; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8368C433C7;
	Thu, 29 Feb 2024 15:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221737;
	bh=+fv1LPuaO3JTr5Lszuh69m3jbmo7lu1K9f9DlffKTl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m3E1Be57eLLRArCxNRg61A/O//oceVyBUTHRtMBl63v4OnH/U3v8HO0duTaaOyofh
	 rWyoombPTuixp8pYtLgk0WFvYBCNkX5oPDCl7UdCXzLwpBItvNg2ejg66lPwlcoFhE
	 N56rs45yWd+E5RJ57GRoYkl4ny534R928bggwV+eIefzq4MUegzuGsyHHxBDpkQJnb
	 8qXKcd60pQDTen0cVhvWdRI2LnkwpbsX3c8IypEUCk88U0bkEkvytpfLJ7kvXH1x1f
	 bj/58TugtMOV2kAflpybcQx5cIES8Gfed9+zXKt2yrEqk3/XIoK7zrkjGoOzb7p+4F
	 18A02WvHIa6hQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rob Clark <robdclark@chromium.org>,
	Sasha Levin <sashal@kernel.org>,
	robdclark@gmail.com,
	quic_abhinavk@quicinc.com,
	dmitry.baryshkov@linaro.org,
	airlied@gmail.com,
	daniel@ffwll.ch,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.7 03/26] Revert "drm/msm/gpu: Push gpu lock down past runpm"
Date: Thu, 29 Feb 2024 10:48:22 -0500
Message-ID: <20240229154851.2849367-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229154851.2849367-1-sashal@kernel.org>
References: <20240229154851.2849367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.6
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

[ Upstream commit 917e9b7c2350e3e53162fcf5035e5f2d68e2cbed ]

This reverts commit abe2023b4cea192ab266b351fd38dc9dbd846df0.

Changing the locking order means that scheduler/msm_job_run() can race
with the recovery kthread worker, with the result that the GPU gets an
extra runpm get when we are trying to power it off.  Leaving the GPU in
an unrecovered state.

I'll need to come up with a different scheme for appeasing lockdep.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Patchwork: https://patchwork.freedesktop.org/patch/573835/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/msm_gpu.c        | 11 +++++------
 drivers/gpu/drm/msm/msm_ringbuffer.c |  7 +++++--
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 7f64c66673002..5c10b559a5957 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -749,12 +749,14 @@ void msm_gpu_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 	struct msm_ringbuffer *ring = submit->ring;
 	unsigned long flags;
 
-	pm_runtime_get_sync(&gpu->pdev->dev);
+	WARN_ON(!mutex_is_locked(&gpu->lock));
 
-	mutex_lock(&gpu->lock);
+	pm_runtime_get_sync(&gpu->pdev->dev);
 
 	msm_gpu_hw_init(gpu);
 
+	submit->seqno = submit->hw_fence->seqno;
+
 	update_sw_cntrs(gpu);
 
 	/*
@@ -779,11 +781,8 @@ void msm_gpu_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 	gpu->funcs->submit(gpu, submit);
 	gpu->cur_ctx_seqno = submit->queue->ctx->seqno;
 
-	hangcheck_timer_reset(gpu);
-
-	mutex_unlock(&gpu->lock);
-
 	pm_runtime_put(&gpu->pdev->dev);
+	hangcheck_timer_reset(gpu);
 }
 
 /*
diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.c b/drivers/gpu/drm/msm/msm_ringbuffer.c
index 95257ab0185dc..a7e152f659a2c 100644
--- a/drivers/gpu/drm/msm/msm_ringbuffer.c
+++ b/drivers/gpu/drm/msm/msm_ringbuffer.c
@@ -21,8 +21,6 @@ static struct dma_fence *msm_job_run(struct drm_sched_job *job)
 
 	msm_fence_init(submit->hw_fence, fctx);
 
-	submit->seqno = submit->hw_fence->seqno;
-
 	mutex_lock(&priv->lru.lock);
 
 	for (i = 0; i < submit->nr_bos; i++) {
@@ -34,8 +32,13 @@ static struct dma_fence *msm_job_run(struct drm_sched_job *job)
 
 	mutex_unlock(&priv->lru.lock);
 
+	/* TODO move submit path over to using a per-ring lock.. */
+	mutex_lock(&gpu->lock);
+
 	msm_gpu_submit(gpu, submit);
 
+	mutex_unlock(&gpu->lock);
+
 	return dma_fence_get(submit->hw_fence);
 }
 
-- 
2.43.0



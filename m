Return-Path: <linux-kernel+bounces-154304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 405B28ADA81
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 596C41C20A12
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FA2180A80;
	Mon, 22 Apr 2024 23:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0o37QWh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415AB180A6F;
	Mon, 22 Apr 2024 23:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830275; cv=none; b=jCEe2ZRww5zSjIX+pJ+UkDgX2fOf3FdNDcuv2mY4W8F8DCMIHVXEAIrrDhd/NW288rm+/FoMhJ0EiJW8euF2u4YYC3JFv1EGYMvGtSzts6CLcLzFTNzJSMArPqKCBP32xraj8ggmkFHqURbmfRL+CN7iz/f4hIfPs904m6X+w1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830275; c=relaxed/simple;
	bh=olWAD/AHfkUfx+xA4BMO+g6lwzQlr5Y47Z07jul84sY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fVVNKl5RDYbLwV9k1Wo+WHTrHFnI5UTsmfekyDWTRsS5nfUwCX2ST/Er9egbJQY9W32+cxru13UkNVH7ZTN3P4YrLypSTAwFXIT64UaxxUlfs7OT4K+/Dg899WJeT2aTCuz4a/Ao3kLOJv+Ho4dn+ZSxQdPtTdoX80S54+ATgTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0o37QWh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EFCC2BD11;
	Mon, 22 Apr 2024 23:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830275;
	bh=olWAD/AHfkUfx+xA4BMO+g6lwzQlr5Y47Z07jul84sY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W0o37QWhPsUGsMY86tFU6Ld3ObtM4OodHSTnm6hG8tRV8oNFOlZR4nXbHwR+JJ+Tg
	 wolFmc4vqf/GBvPTiOo5T0NNzNYmoER6sfARIJVOxmmRUlTNNIoA/k17cdxpFJYkc6
	 iIUuXoeHeRAqEd8lsFzY/wpRCPbxym1v///151uFp2xWcKzg1KMH2vyaLCa61Hmu9Y
	 ZJRGVOYj9KzyL/vZBfwl0ycs1M6hub4gojbq/WUp72eNWzLGDsi9B72jFlpw6ZN6Tx
	 HqvwEM4GhfcHIcz5KMoklskXmf6X6FcMDr/EgtJRfIcbOHp8xhCCj6xNgJ/G171Vu9
	 63+/BsFm0oTvQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lijo Lazar <lijo.lazar@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Asad Kamal <asad.kamal@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	ltuikov89@gmail.com,
	dakr@redhat.com,
	zhenguo.yin@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 14/19] drm/amdgpu: Refine IB schedule error logging
Date: Mon, 22 Apr 2024 19:18:28 -0400
Message-ID: <20240422231845.1607921-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231845.1607921-1-sashal@kernel.org>
References: <20240422231845.1607921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.87
Content-Transfer-Encoding: 8bit

From: Lijo Lazar <lijo.lazar@amd.com>

[ Upstream commit 4b18a91faf1752f9bd69a4ed3aed2c8f6e5b0528 ]

Downgrade to debug information when IBs are skipped. Also, use dev_* to
identify the device.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 3bf0e893c07df..f34bc9bb7045a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -301,12 +301,15 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
 		dma_fence_set_error(finished, -ECANCELED);
 
 	if (finished->error < 0) {
-		DRM_INFO("Skip scheduling IBs!\n");
+		dev_dbg(adev->dev, "Skip scheduling IBs in ring(%s)",
+			ring->name);
 	} else {
 		r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, job,
 				       &fence);
 		if (r)
-			DRM_ERROR("Error scheduling IBs (%d)\n", r);
+			dev_err(adev->dev,
+				"Error scheduling IBs (%d) in ring(%s)", r,
+				ring->name);
 	}
 
 	job->job_run_counter++;
-- 
2.43.0



Return-Path: <linux-kernel+bounces-33301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E8C836824
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB9B51C22D53
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526BA4644E;
	Mon, 22 Jan 2024 15:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNSnL7Tu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942A05F545;
	Mon, 22 Jan 2024 15:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935714; cv=none; b=WU9N1Bqvq/zUYvbOhjZXnHtcd49FkzS+z/KgaMKGSisHxguKPqb+ZRYNcX9sb86kk803iIc8zeivAgy9NuGqJ441mZsrt28hvtT6qBOUBkOu3f35l4/gATNW/mgNaF4dQT021maqt2fLro3o66wEvrcVi0hppFRV5CVgCIog6pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935714; c=relaxed/simple;
	bh=ZHkEk0P2qTHLw9XhIeAWPfwmeaiiIL9Ljn+A83HLoEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KXF3J/Gt3hDS/mNMAsfSsyFAI9pq75Q8PNT5FWyxJfKAO4Q6e3bWHgmJOJoN62I5IzY3nMiCiINVSocJ4sVBlBSRPAn6s0KjF2rlKsHTJIrvuzMkWpgRe4q5ynrYfqF4NHPDB0meOOB/SmfSZIh6B8yW2BHuks8KyXruVkDRwug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNSnL7Tu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD97CC43601;
	Mon, 22 Jan 2024 15:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935714;
	bh=ZHkEk0P2qTHLw9XhIeAWPfwmeaiiIL9Ljn+A83HLoEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sNSnL7Tu8mRiE8Hr9dZlmr09mhht4QFDvrfdZ3OMr3jsKwyzFzupd06zxXfc1SPbL
	 xymGxDQ1RcNkQ29KmSONnxQt8PBTguUzfHCGfE3idRbhSNBLHr9HOe4oU9CfMoKrHv
	 UMMNKBDy36lSjYmyQnbs1EKFBJf33u+6Ge4EYYrxeaOkFYrbHYi7lgis7Z+v4arsaJ
	 UOKUg1fWUA6FpekXOb3V/WYPNGCOAJuAjNaxc8rGVd37ZOO5m/PPMw9v4seYlt3wO8
	 RxnxtUQPN+e5DPQJRSTBUyWYndWtGhy0geXWD2D/cuO0X6XD4GrV8FXphhH57XuQd6
	 iVrw9Br52n+wA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Yang Wang <kevinyang.wang@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	lijo.lazar@amd.com,
	YiPeng.Chai@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.7 79/88] drm/amdgpu: Fix variable 'mca_funcs' dereferenced before NULL check in 'amdgpu_mca_smu_get_mca_entry()'
Date: Mon, 22 Jan 2024 09:51:52 -0500
Message-ID: <20240122145608.990137-79-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145608.990137-1-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
Content-Transfer-Encoding: 8bit

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit 4f32504a2f85a7b40fe149436881381f48e9c0c0 ]

Fixes the below:

drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c:377 amdgpu_mca_smu_get_mca_entry() warn: variable dereferenced before check 'mca_funcs' (see line 368)

357 int amdgpu_mca_smu_get_mca_entry(struct amdgpu_device *adev,
				     enum amdgpu_mca_error_type type,
358                                  int idx, struct mca_bank_entry *entry)
359 {
360         const struct amdgpu_mca_smu_funcs *mca_funcs =
						adev->mca.mca_funcs;
361         int count;
362
363         switch (type) {
364         case AMDGPU_MCA_ERROR_TYPE_UE:
365                 count = mca_funcs->max_ue_count;

mca_funcs is dereferenced here.

366                 break;
367         case AMDGPU_MCA_ERROR_TYPE_CE:
368                 count = mca_funcs->max_ce_count;

mca_funcs is dereferenced here.

369                 break;
370         default:
371                 return -EINVAL;
372         }
373
374         if (idx >= count)
375                 return -EINVAL;
376
377         if (mca_funcs && mca_funcs->mca_get_mca_entry)
	        ^^^^^^^^^

Checked too late!

Cc: Yang Wang <kevinyang.wang@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index cf33eb219e25..061d88f4480d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -351,6 +351,9 @@ int amdgpu_mca_smu_get_mca_entry(struct amdgpu_device *adev, enum amdgpu_mca_err
 	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
 	int count;
 
+	if (!mca_funcs || !mca_funcs->mca_get_mca_entry)
+		return -EOPNOTSUPP;
+
 	switch (type) {
 	case AMDGPU_MCA_ERROR_TYPE_UE:
 		count = mca_funcs->max_ue_count;
@@ -365,10 +368,7 @@ int amdgpu_mca_smu_get_mca_entry(struct amdgpu_device *adev, enum amdgpu_mca_err
 	if (idx >= count)
 		return -EINVAL;
 
-	if (mca_funcs && mca_funcs->mca_get_mca_entry)
-		return mca_funcs->mca_get_mca_entry(adev, type, idx, entry);
-
-	return -EOPNOTSUPP;
+	return mca_funcs->mca_get_mca_entry(adev, type, idx, entry);
 }
 
 #if defined(CONFIG_DEBUG_FS)
-- 
2.43.0



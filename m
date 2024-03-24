Return-Path: <linux-kernel+bounces-113985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8B38887C4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 842591C26B31
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844C6221912;
	Sun, 24 Mar 2024 23:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOmWUHzg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA82E14BF92;
	Sun, 24 Mar 2024 22:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321136; cv=none; b=kB7/7CE1EvKmbZ/1EvvAWxjXlqcZ4SMmX0Z18r8aDZUYEBsrv8lu+cWJAnm39UzZ3cYRANI4kJmIGHxeLIqk9kdpb/7P0CgZyg7NREvk6Xn+ZAyDldHH2vbKbIKDJIXCEi/3n8LmFcuzeQUi0G6qOdBdbhqnqbYL4tMT3ujF94U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321136; c=relaxed/simple;
	bh=+QcmLcmnjuhqAeaN6Zyve029BFTLrip7akLENzC+Dls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kg+xTn5NGJ4q7ZkKuWTx54te3E/XHmsoK06ord8P6IpGna3Ml5RLh7V5aPEvx2NDblT6MEpfDiV1gThuDjJLZEI8bzGFJ7Y7i7WJWWMepz+fmShrzKeL4ouAN71uWaXsY2fwh8wyZ8foavwDdCzkTGsWipdhcK3g+94sL/FurvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOmWUHzg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0EAC43394;
	Sun, 24 Mar 2024 22:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321135;
	bh=+QcmLcmnjuhqAeaN6Zyve029BFTLrip7akLENzC+Dls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iOmWUHzgQl3SvGF7qCF05cUlRfkw8IJ9ZDcGqOeZqFfKiN/VxMG3fqfmyExz1DlC9
	 saYyaBOqqJA5WHpoTU86hGO5nLNfFLRoEHCA8m6Q8LbejktTivJVqLoo1Vw2jfe4vV
	 55ENByI5pqwbCFrd29/cvi42PsqHjMc88F8bddHzNwc/VsgiyHPrNuBBMxg79/OCdP
	 81wveHfrhRZv1VTi6dcpG1hrj2/WNgPLz/KJgy+rIFp4DQu1VxL97cgf/NUONKwy6/
	 kmHgVqvyWjxoO+PTtX06oYaB+YUWNwvn4HT2Fw49udVk3A2Khc9GaeBJTe3NS9KP9V
	 OTPQXwNxbsHMQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Le Ma <le.ma@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 697/713] drm/amdgpu: drop setting buffer funcs in sdma442
Date: Sun, 24 Mar 2024 18:47:03 -0400
Message-ID: <20240324224720.1345309-698-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Le Ma <le.ma@amd.com>

[ Upstream commit ad550dbe8ae4ba833371a018265c1c3ae88559f0 ]

To fix the entity rq NULL issue. This setting has been moved
to upper level.

Fixes: b70438004a14 ("drm/amdgpu: move buffer funcs setting up a level")
Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 0f24af6f28102..8eed9a73d0355 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -429,16 +429,11 @@ static void sdma_v4_4_2_inst_gfx_stop(struct amdgpu_device *adev,
 	struct amdgpu_ring *sdma[AMDGPU_MAX_SDMA_INSTANCES];
 	u32 doorbell_offset, doorbell;
 	u32 rb_cntl, ib_cntl;
-	int i, unset = 0;
+	int i;
 
 	for_each_inst(i, inst_mask) {
 		sdma[i] = &adev->sdma.instance[i].ring;
 
-		if ((adev->mman.buffer_funcs_ring == sdma[i]) && unset != 1) {
-			amdgpu_ttm_set_buffer_funcs_status(adev, false);
-			unset = 1;
-		}
-
 		rb_cntl = RREG32_SDMA(i, regSDMA_GFX_RB_CNTL);
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA_GFX_RB_CNTL, RB_ENABLE, 0);
 		WREG32_SDMA(i, regSDMA_GFX_RB_CNTL, rb_cntl);
@@ -485,20 +480,10 @@ static void sdma_v4_4_2_inst_rlc_stop(struct amdgpu_device *adev,
 static void sdma_v4_4_2_inst_page_stop(struct amdgpu_device *adev,
 				       uint32_t inst_mask)
 {
-	struct amdgpu_ring *sdma[AMDGPU_MAX_SDMA_INSTANCES];
 	u32 rb_cntl, ib_cntl;
 	int i;
-	bool unset = false;
 
 	for_each_inst(i, inst_mask) {
-		sdma[i] = &adev->sdma.instance[i].page;
-
-		if ((adev->mman.buffer_funcs_ring == sdma[i]) &&
-			(!unset)) {
-			amdgpu_ttm_set_buffer_funcs_status(adev, false);
-			unset = true;
-		}
-
 		rb_cntl = RREG32_SDMA(i, regSDMA_PAGE_RB_CNTL);
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA_PAGE_RB_CNTL,
 					RB_ENABLE, 0);
@@ -948,13 +933,7 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
 			r = amdgpu_ring_test_helper(page);
 			if (r)
 				return r;
-
-			if (adev->mman.buffer_funcs_ring == page)
-				amdgpu_ttm_set_buffer_funcs_status(adev, true);
 		}
-
-		if (adev->mman.buffer_funcs_ring == ring)
-			amdgpu_ttm_set_buffer_funcs_status(adev, true);
 	}
 
 	return r;
-- 
2.43.0



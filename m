Return-Path: <linux-kernel+bounces-113590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AF388858A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4AD31C24E1C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BE31CBE02;
	Sun, 24 Mar 2024 22:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3svRWrD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36661CBDEF;
	Sun, 24 Mar 2024 22:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320393; cv=none; b=ZVU6FhDgS8ofGzXJFIMGt0Gm3iQIrjkRwwecS4UOlKxTkiknOx5+YfjW6y++AdXFrJRQQEo1FgIvZTi/zB8tdN19EAmZVFaSJyD3M74rU6I7Id5TswB/cYanwD9A7v9g5W1oWBs4/+KrJ7+TuXbvKU7vM3pAZM2Q+74khIf61nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320393; c=relaxed/simple;
	bh=1ZKn0pFrpWmFJfE2ljTQFfIWXR54/we/a9zO/4+83TA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VNBiPO+LdgLVWdznvXHidLepmALI91zH/q3CmW4TO6Zn/7ahzrl2mCyn+lAWaa1JifdboxKKeadpW7w1JDHV/tgyRhzVvem98dkkW337lrfBxKE5SOE9I4fOvsxzqEYIu2T+pFTiIc5DOw3ueki9UrWlkmYW0/UX4HLu3wI8wAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3svRWrD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B9AC433C7;
	Sun, 24 Mar 2024 22:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320393;
	bh=1ZKn0pFrpWmFJfE2ljTQFfIWXR54/we/a9zO/4+83TA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g3svRWrDGd2KXXoB1dYb7m2vj8T9cFKf1FloWq8HiPqIukXh52xKbQ4vHnea+ljkG
	 8nBngH7saEbNXBQGRTWIDKT2F2VVf0jmlyLYA9XYV+NueG5rzScWppD7hyQXZDfn44
	 uLxEPQDTLoLhplJ7byUQ827BsLnUJW3ApzMtNvUr79eq/NuZx9SgfbRihuVaBTZV20
	 pNrtR63FtzzNTXn01LHw4xGvG/b85RKD+mH9QoLyXB+i/U8KpIawoNQnq61N2z9XBk
	 paRz1bd52UF0rCWwHHnmkkGFYgf/f+1Mkch7ZqyEW98XPTfQFZXmsJb7DnOcQjIM4V
	 5HFtZkb4Jm9SA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Le Ma <le.ma@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 699/715] drm/amdgpu: drop setting buffer funcs in sdma442
Date: Sun, 24 Mar 2024 18:34:38 -0400
Message-ID: <20240324223455.1342824-700-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 2d688dca26bed..45a67a77455ee 100644
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



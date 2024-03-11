Return-Path: <linux-kernel+bounces-99085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50928878344
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 023311F277E2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A54B605C8;
	Mon, 11 Mar 2024 15:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRKwdzFD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D96945C16;
	Mon, 11 Mar 2024 15:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170017; cv=none; b=ivM+mFeCx02vkvyOCrrr8xYdqPwoesCkdNhdHk0bmDcWSwgpGQSXSZ6ielimOuEk+2xBc92CeuK/We+oJvEnqQLDCMaTuCD5s5Xu+ZbSziKrqiWoOmfkQrgbSj/43NO2TSdr2bjBYNzQEZjry53EEeXwUEMiiySWhyUGooAWv4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170017; c=relaxed/simple;
	bh=Em+y3OczuTBhg6IrRilmQsX+jlGDdnBmeK0jNqSWFp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iNYwGwCGl2mJLGWPf07GylQ9rFm/9vVSiOPnQ5honHQcxzJJrEV9BECG6YeKoMuh5yGtBahQb34Iaz1/K7c0RH/NuAuZ2MbxN+NvXybdActgUeqzB5dkTg72eE78uHHHAY7cXIa39JyufXwPkWFHSYg04scZfCH7ObkHJ/r8M8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRKwdzFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2274EC43390;
	Mon, 11 Mar 2024 15:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710170017;
	bh=Em+y3OczuTBhg6IrRilmQsX+jlGDdnBmeK0jNqSWFp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CRKwdzFDR35tp6Fa7BDoOIHHXfkdrqE+vO2y4hzK+dJ7UUMg2xDzb74iFZrt6ASgP
	 +UKBx5lr/G9OY1bzITLF3gL0xSwDPdFZaPqSl9qX6+r5QJqTjzQ1Tq6WgLKZSfNJuB
	 i531bwtR4c+PY/YkiTKohBFKXYCLpyM4qVGXjy+ictahe/ee7OhSGAEbQ3ZwLH1RMe
	 diO74Mr722yLbLGBNgnx2LPhkkbIXJVccsbf4j/BKvEvV1Wv0PeiRsa+WyYKZ3H1Qy
	 v79MxD5d7+QPZwJF0H3WvzZXd9LCnDTFFZoJ1MSteVJr1XVCVgkedH9TvBJOpbUgi0
	 cQCq5EAd7oF4g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Prike Liang <Prike.Liang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Hawking.Zhang@amd.com,
	lijo.lazar@amd.com,
	le.ma@amd.com,
	James.Zhu@amd.com,
	shane.xiao@amd.com,
	sonny.jiang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 11/17] drm/amdgpu: Enable gpu reset for S3 abort cases on Raven series
Date: Mon, 11 Mar 2024 11:13:02 -0400
Message-ID: <20240311151314.317776-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311151314.317776-1-sashal@kernel.org>
References: <20240311151314.317776-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.21
Content-Transfer-Encoding: 8bit

From: Prike Liang <Prike.Liang@amd.com>

[ Upstream commit c671ec01311b4744b377f98b0b4c6d033fe569b3 ]

Currently, GPU resets can now be performed successfully on the Raven
series. While GPU reset is required for the S3 suspend abort case.
So now can enable gpu reset for S3 abort cases on the Raven series.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 45 +++++++++++++++++-------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 2a7c606d1d191..a41ed67ea9fea 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -574,11 +574,34 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
 		return AMD_RESET_METHOD_MODE1;
 }
 
+static bool soc15_need_reset_on_resume(struct amdgpu_device *adev)
+{
+	u32 sol_reg;
+
+	sol_reg = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81);
+
+	/* Will reset for the following suspend abort cases.
+	 * 1) Only reset limit on APU side, dGPU hasn't checked yet.
+	 * 2) S3 suspend abort and TOS already launched.
+	 */
+	if (adev->flags & AMD_IS_APU && adev->in_s3 &&
+			!adev->suspend_complete &&
+			sol_reg)
+		return true;
+
+	return false;
+}
+
 static int soc15_asic_reset(struct amdgpu_device *adev)
 {
 	/* original raven doesn't have full asic reset */
-	if ((adev->apu_flags & AMD_APU_IS_RAVEN) ||
-	    (adev->apu_flags & AMD_APU_IS_RAVEN2))
+	/* On the latest Raven, the GPU reset can be performed
+	 * successfully. So now, temporarily enable it for the
+	 * S3 suspend abort case.
+	 */
+	if (((adev->apu_flags & AMD_APU_IS_RAVEN) ||
+	    (adev->apu_flags & AMD_APU_IS_RAVEN2)) &&
+		!soc15_need_reset_on_resume(adev))
 		return 0;
 
 	switch (soc15_asic_reset_method(adev)) {
@@ -1296,24 +1319,6 @@ static int soc15_common_suspend(void *handle)
 	return soc15_common_hw_fini(adev);
 }
 
-static bool soc15_need_reset_on_resume(struct amdgpu_device *adev)
-{
-	u32 sol_reg;
-
-	sol_reg = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81);
-
-	/* Will reset for the following suspend abort cases.
-	 * 1) Only reset limit on APU side, dGPU hasn't checked yet.
-	 * 2) S3 suspend abort and TOS already launched.
-	 */
-	if (adev->flags & AMD_IS_APU && adev->in_s3 &&
-			!adev->suspend_complete &&
-			sol_reg)
-		return true;
-
-	return false;
-}
-
 static int soc15_common_resume(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-- 
2.43.0



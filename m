Return-Path: <linux-kernel+bounces-99107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A19878382
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D05C285955
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8C765BC3;
	Mon, 11 Mar 2024 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyYFcDzf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB19365BCD;
	Mon, 11 Mar 2024 15:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170073; cv=none; b=Kb/L5oa6LyXE6W8VDYNzYlFo60qBlyAISqaWcTmFMpBJKzkqRy+S9ktxKUhluaDhsvavgCRVG+Ge/rKJX1dDLd77dlUMtPRDKb4vIGyfJTVX5vYCOoA0v06Qs7qYkmCgVQeSrMKJkoGWvtXfgs70cFMheukLChh39wQ8lQKVukI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170073; c=relaxed/simple;
	bh=qRNIXQQ0NDPtwb9S2RGzhZvgH/WxePugxAeFOkz8rAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MYqeOj0OS1G+yX6CryU6GoC71lnOpsnQKgIwfXwCaDrwtmSBY3oaIgAJMKrzGfeNcNA9LL7rvsj39wPhgVqR6Ko15cqyEbdobLNfCA12jUtCy3VdSXkIrPnEZZmYaAXnTaWRH7MLaMHMfxTnETdJW5s9JFNlw7iJculTBj3FqEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyYFcDzf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05185C433C7;
	Mon, 11 Mar 2024 15:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710170073;
	bh=qRNIXQQ0NDPtwb9S2RGzhZvgH/WxePugxAeFOkz8rAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NyYFcDzfWhj8NxSBbWq9MpkDoaAhIlnYIP0eRVYfIWHlY7nswcUnHsHjq3+Klza9c
	 lle4GDQzeHhvOUjOLCCYKFMcDLTGHAVnyYqJdTnAey79/wERXUO4AO955EPhjGJVrA
	 UTCZBYnIKvlyCii+6A+8gwc2Wo8F/uWiy4kf7teIgxaI1LX/9Hujm7PyN3HzGL9FSJ
	 zW3OXDft0WPqkW6+4RuuwuWU/LcDRPyc9guTryuAOOqqcGd1mTHSVkyYO1uKFxrcJU
	 511cpQzHOBSRgkKZot7Tigp0uGDDqDXa7er9VqOC9w7MxnrBRWFLojDP5BBg5rE7My
	 0Fytgk8ImF+cQ==
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
Subject: [PATCH AUTOSEL 5.15 3/5] drm/amdgpu: Enable gpu reset for S3 abort cases on Raven series
Date: Mon, 11 Mar 2024 11:14:19 -0400
Message-ID: <20240311151424.318621-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311151424.318621-1-sashal@kernel.org>
References: <20240311151424.318621-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.151
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
index 6a3486f52d698..ef5b3eedc8615 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -605,11 +605,34 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
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
@@ -1490,24 +1513,6 @@ static int soc15_common_suspend(void *handle)
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



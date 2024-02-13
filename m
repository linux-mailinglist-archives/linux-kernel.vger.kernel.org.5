Return-Path: <linux-kernel+bounces-62624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C878523C3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 471B61F216E3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F359A92A;
	Tue, 13 Feb 2024 00:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlu4kER0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CF35C5E9;
	Tue, 13 Feb 2024 00:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783611; cv=none; b=OQI30y5AnVhmcPdDc6FDfUggjZqLCaKmnAGHkqP61LiMCm/Gm9tV+Q8oJpEwEKmBIn+VugRTxvD7YGDbX2zxcuEnVY2Ytj0OzX+BxZudpHPYI2k0kQXQs8pJYyXtrdeCHyesrWsJfUxkImg84PO42lvhxlxwUq6aVjCVHg2kBGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783611; c=relaxed/simple;
	bh=fImiPO0JbD6dApVG99i44/jHIX5F1//4n9MwoV5oT/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GxzLF4BJQYox/Q2QaqYnSuSxadWjLmRcYUTzaXRJ+OVhLkF5NpeHzkDPVYyVCqM/YZlCdTKuiATK5rtmna8Qg/zGGMHkNf0C1PuNC/ZR0I/IBAQq+IgU+PH7TWOvJF4L8V/dmOpXHY0WPLZfBUN2AyFGVHDscrzXZiTHq7PdkDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlu4kER0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F84C433F1;
	Tue, 13 Feb 2024 00:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783610;
	bh=fImiPO0JbD6dApVG99i44/jHIX5F1//4n9MwoV5oT/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jlu4kER0GK8lnANquckhgTofdFWiy7bWs2avxf6X2KmF8pkcLGHK3aM0f4sUx/Gtg
	 DrwZPi7CnOtH7SK534Sjo5sTjSMXqn93PwyHfWjITTy8uqBjxzM36SVArGlsdiXlk2
	 Tm9kmdfo55QbxqRiWCJRwJGIUukl+g2GL4ZT/Un8VIOvy/F6DOQ63qFkJRTJkwC8w+
	 6AMuaGVwVB2XkDi/APD+BoFILWZWosLSr9cutucsGd4ozD3SOT+9xlVQNeE8GRgVop
	 ShjaX0NvyTPq0OzXD0awuAcWRqdRlgBpEQAw6cYf3YkopyxAqMfWxaG1r+JnRFx7RC
	 kvfOFYK9ZcATQ==
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
	Likun.Gao@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.7 51/58] drm/amdgpu: reset gpu for s3 suspend abort case
Date: Mon, 12 Feb 2024 19:17:57 -0500
Message-ID: <20240213001837.668862-51-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213001837.668862-1-sashal@kernel.org>
References: <20240213001837.668862-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
Content-Transfer-Encoding: 8bit

From: Prike Liang <Prike.Liang@amd.com>

[ Upstream commit 6ef82ac664bb9568ca3956e0d9c9c478e25077ff ]

In the s3 suspend abort case some type of gfx9 power
rail not turn off from FCH side and this will put the
GPU in an unknown power status, so let's reset the gpu
to a known good power state before reinitialize gpu
device.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 51342809af03..9b5af3f1383a 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1297,10 +1297,32 @@ static int soc15_common_suspend(void *handle)
 	return soc15_common_hw_fini(adev);
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
 static int soc15_common_resume(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	if (soc15_need_reset_on_resume(adev)) {
+		dev_info(adev->dev, "S3 suspend abort case, let's reset ASIC.\n");
+		soc15_asic_reset(adev);
+	}
 	return soc15_common_hw_init(adev);
 }
 
-- 
2.43.0



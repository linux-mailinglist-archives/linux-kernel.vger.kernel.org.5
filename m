Return-Path: <linux-kernel+bounces-33445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE7D8369C0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1BD11F243E7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1485E4F60F;
	Mon, 22 Jan 2024 15:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSlEDuVI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC074F5FD;
	Mon, 22 Jan 2024 15:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936327; cv=none; b=TVbrkSpTa7mY3DyBaZDdQdxEUEsbW3o8eU2TI+95UwxuPCeHOfaXaRM8f6ohxfMTXrP0aewrA26eioLMIBRl5kdvmktWnCNZ4u1yCNSMGMBJda+VaT2r5oOshdaTu06F9hMEywYnAA819rJuO9fp49A00S8lyzFq0apgf0ZV2es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936327; c=relaxed/simple;
	bh=oX8dXXdE9VcWMj7gSfRvoBKndwGsFgtPgn5jA9n5IbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwcJLJkYCPUT4iprLfdwBFYQgL4cn4qK3IXaGpC4HyTktewZscHdb8PoAHY7nE2KG8m9issIDTVsWjGQNnnBBgBbeCeXSIXavVqjuxDRXDOne56p55j8xA/509MpZjUsTJcshLrplv5aaf+0boacwZgd251rEXnnnZWF/fx5Ut4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSlEDuVI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39C1C43394;
	Mon, 22 Jan 2024 15:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936327;
	bh=oX8dXXdE9VcWMj7gSfRvoBKndwGsFgtPgn5jA9n5IbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iSlEDuVIDGA3BQyHCxL8F2EcWuKQbtSRpAIRkT8BkzBbZQK2EFIJt4qtzTlltPEC6
	 In9IO4xf7hHv7rC9BnquZRqUQwKFpLMumHjEKrel6SS07n9bQTe/g9A03gfPxOssYM
	 aVdN2BIGJ9QTFeFqmtz8uQfS2bC2lNWzk+q5ZDdIGQMsCfLKUFTU1JymFN+DXc97Gj
	 8AvyE0vKQoj8/hrH6MXQpRfvSWn0GxNMuObitu1M91rV5zb1K3FRSP9eOcZab8mreR
	 uyH2W77s4k3MDmWpBJ8LkHNMjTo6zNvQ8SKkXwpfU5I6FofgyZAISwTewEBfow3IPK
	 rjQag1SpB9u+A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>,
	Tao Zhou <tao.zhou1@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	lijo.lazar@amd.com,
	asad.kamal@amd.com,
	Felix.Kuehling@amd.com,
	le.ma@amd.com,
	mukul.joshi@amd.com,
	srinivasan.shanmugam@amd.com,
	Philip.Yang@amd.com,
	rajneesh.bhardwaj@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 44/53] drm/amdgpu: Fix ecc irq enable/disable unpaired
Date: Mon, 22 Jan 2024 10:08:45 -0500
Message-ID: <20240122150949.994249-44-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150949.994249-1-sashal@kernel.org>
References: <20240122150949.994249-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.74
Content-Transfer-Encoding: 8bit

From: "Stanley.Yang" <Stanley.Yang@amd.com>

[ Upstream commit a32c6f7f5737cc7e31cd7ad5133f0d96fca12ea6 ]

The ecc_irq is disabled while GPU mode2 reset suspending process,
but not be enabled during GPU mode2 reset resume process.

Changed from V1:
	only do sdma/gfx ras_late_init in aldebaran_mode2_restore_ip
	delete amdgpu_ras_late_resume function

Changed from V2:
	check umc ras supported before put ecc_irq

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c | 26 +++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c |  4 ++++
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c |  5 +++++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  |  4 ++++
 4 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
index 2b97b8a96fb4..fa6193535d48 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -333,6 +333,7 @@ aldebaran_mode2_restore_hwcontext(struct amdgpu_reset_control *reset_ctl,
 {
 	struct list_head *reset_device_list = reset_context->reset_device_list;
 	struct amdgpu_device *tmp_adev = NULL;
+	struct amdgpu_ras *con;
 	int r;
 
 	if (reset_device_list == NULL)
@@ -358,7 +359,30 @@ aldebaran_mode2_restore_hwcontext(struct amdgpu_reset_control *reset_ctl,
 		 */
 		amdgpu_register_gpu_instance(tmp_adev);
 
-		/* Resume RAS */
+		/* Resume RAS, ecc_irq */
+		con = amdgpu_ras_get_context(tmp_adev);
+		if (!amdgpu_sriov_vf(tmp_adev) && con) {
+			if (tmp_adev->sdma.ras &&
+				tmp_adev->sdma.ras->ras_block.ras_late_init) {
+				r = tmp_adev->sdma.ras->ras_block.ras_late_init(tmp_adev,
+						&tmp_adev->sdma.ras->ras_block.ras_comm);
+				if (r) {
+					dev_err(tmp_adev->dev, "SDMA failed to execute ras_late_init! ret:%d\n", r);
+					goto end;
+				}
+			}
+
+			if (tmp_adev->gfx.ras &&
+				tmp_adev->gfx.ras->ras_block.ras_late_init) {
+				r = tmp_adev->gfx.ras->ras_block.ras_late_init(tmp_adev,
+						&tmp_adev->gfx.ras->ras_block.ras_comm);
+				if (r) {
+					dev_err(tmp_adev->dev, "GFX failed to execute ras_late_init! ret:%d\n", r);
+					goto end;
+				}
+			}
+		}
+
 		amdgpu_ras_resume(tmp_adev);
 
 		/* Update PSP FW topology after reset */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index d96ee48e1706..35921b41fc27 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -1144,6 +1144,10 @@ static int gmc_v10_0_hw_fini(void *handle)
 
 	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
 
+	if (adev->gmc.ecc_irq.funcs &&
+		amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC))
+		amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 7124347d2b6c..310a5607d83b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -951,6 +951,11 @@ static int gmc_v11_0_hw_fini(void *handle)
 	}
 
 	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
+
+	if (adev->gmc.ecc_irq.funcs &&
+		amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC))
+		amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
+
 	gmc_v11_0_gart_disable(adev);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 0d9e9d9dd4a1..409e3aa018f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1900,6 +1900,10 @@ static int gmc_v9_0_hw_fini(void *handle)
 
 	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
 
+	if (adev->gmc.ecc_irq.funcs &&
+		amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC))
+		amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
+
 	return 0;
 }
 
-- 
2.43.0



Return-Path: <linux-kernel+bounces-124853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FED7891D22
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45137282A40
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC2F1C2305;
	Fri, 29 Mar 2024 12:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbkLe1u6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E70214A4D3;
	Fri, 29 Mar 2024 12:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716295; cv=none; b=c9Hkq+Iaqqb79ulGYXXaoxR0m9iynzDYhDeAOQJmISEUB0t5O1IZvWm4ZYLONllRFmfRL60geR1b26j3fkQfoll3PoZy3YTMeFvyQ6TzZcmp2hEXhmAwachqZfva8YXr8PFcDN2JaYEwrPW0VTeIEQHke55k6uFl5Qmaats3PbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716295; c=relaxed/simple;
	bh=AoqCat9N4163RwRCB55sNuaZ5loXmqTak4HXhAlS090=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NRAn4Qhpx02IGaSFm9HUqmQnRJSlK35RaxlBNaeM0fWb86Whp8QRxzrsLyl1CIrz2Ii2Pz584emknVO8BeiGGqMDDQ3q1LwCOKCU78Nzue7pjWHHBELHmxRG+6DLp6WhPLOOXqKsq72H2jS2PQUpobKNstJGTqMeySMXEmpB+Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbkLe1u6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A403C433C7;
	Fri, 29 Mar 2024 12:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716295;
	bh=AoqCat9N4163RwRCB55sNuaZ5loXmqTak4HXhAlS090=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZbkLe1u6yHtAMMvC8WM3JDk1y4NxKCjFybthP5vmEUilXqChKhTI3/2W7KQQAjnr1
	 Vzx6hYjsb20pl+wt0g1eCC/1Mcmg075dDyImZd5Rab45m36kNukddQv8DrgjLGQjiE
	 cjW6/kJ6VkO7LbpSGDu9lyOW3XdD0QuRS2+n9IJygBVu+UsJ2xjP3zaDhabwQO8rwd
	 2spIGJncOaNngm/P7SlSmftMkr0rZQPtfPjfjZoLPBcrJqTMe8WjgQi0VE0mb6MLY2
	 6nh87nBOzcjBIBlAb+cxBCBSFH1J7H2bhg1DkA0beRhKp0Hv9wQhXzg1cUI0AIw2Q3
	 Jn/BHLjDwbgOw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	mario.limonciello@amd.com,
	Hawking.Zhang@amd.com,
	lijo.lazar@amd.com,
	candice.li@amd.com,
	le.ma@amd.com,
	victorchengchi.lu@amd.com,
	shashank.sharma@amd.com,
	andrealmeid@igalia.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 44/75] drm/amd/amdgpu: Fix potential ioremap() memory leaks in amdgpu_device_init()
Date: Fri, 29 Mar 2024 08:42:25 -0400
Message-ID: <20240329124330.3089520-44-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
Content-Transfer-Encoding: 8bit

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit eb4f139888f636614dab3bcce97ff61cefc4b3a7 ]

This ensures that the memory mapped by ioremap for adev->rmmio, is
properly handled in amdgpu_device_init(). If the function exits early
due to an error, the memory is unmapped. If the function completes
successfully, the memory remains mapped.

Reported by smatch:
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:4337 amdgpu_device_init() warn: 'adev->rmmio' from ioremap() not released on lines: 4035,4045,4051,4058,4068,4337

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 79261bec26542..d0be5e485530c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3638,8 +3638,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	 * early on during init and before calling to RREG32.
 	 */
 	adev->reset_domain = amdgpu_reset_create_reset_domain(SINGLE_DEVICE, "amdgpu-reset-dev");
-	if (!adev->reset_domain)
-		return -ENOMEM;
+	if (!adev->reset_domain) {
+		r = -ENOMEM;
+		goto unmap_memory;
+	}
 
 	/* detect hw virtualization here */
 	amdgpu_detect_virtualization(adev);
@@ -3649,20 +3651,20 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	r = amdgpu_device_get_job_timeout_settings(adev);
 	if (r) {
 		dev_err(adev->dev, "invalid lockup_timeout parameter syntax\n");
-		return r;
+		goto unmap_memory;
 	}
 
 	/* early init functions */
 	r = amdgpu_device_ip_early_init(adev);
 	if (r)
-		return r;
+		goto unmap_memory;
 
 	amdgpu_device_set_mcbp(adev);
 
 	/* Get rid of things like offb */
 	r = drm_aperture_remove_conflicting_pci_framebuffers(adev->pdev, &amdgpu_kms_driver);
 	if (r)
-		return r;
+		goto unmap_memory;
 
 	/* Enable TMZ based on IP_VERSION */
 	amdgpu_gmc_tmz_set(adev);
@@ -3672,7 +3674,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (adev->gmc.xgmi.supported) {
 		r = adev->gfxhub.funcs->get_xgmi_info(adev);
 		if (r)
-			return r;
+			goto unmap_memory;
 	}
 
 	/* enable PCIE atomic ops */
@@ -3929,6 +3931,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 failed:
 	amdgpu_vf_error_trans_all(adev);
 
+unmap_memory:
+	iounmap(adev->rmmio);
 	return r;
 }
 
-- 
2.43.0



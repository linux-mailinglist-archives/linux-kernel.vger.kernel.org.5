Return-Path: <linux-kernel+bounces-124911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7C3891DB7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 853F61F2AFE4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FF014BFAF;
	Fri, 29 Mar 2024 12:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K48CQdos"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12A629E1BE;
	Fri, 29 Mar 2024 12:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716418; cv=none; b=jFs/MBOG4Tik2dKBrPVYBKnrWYEdc9x1BpHvkdJnLgNU8asYalkOYcUrqyWsigfV6ywZaf2GcYqKqpvarytmb5AIx9bmaYeLhc8+YFY0a/HU5IX/hDdxEcyo4ecbbxb3QK83PG8XK6exf+/IeLQjpw4gEd2R9VqjqbpytnMzYyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716418; c=relaxed/simple;
	bh=5wOc+LUMfZCRy3MZnUmqxiohZmyUE+kUku580aPi7cM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UwvdprkAkQr+5vZGvuQ7BsWqAXfTOaWexx48i9MTdB8TjMk7VTX48OlMf5KUr71e6chJV28dsc0ylabFIeD1wwAE/X464tND49ZPh0cXnSr/4OH+vBr4/KFaOhGBw5GcE2ryUGnFI6rzNOJ5IyAalwuCXFEpzW+iezSUcm8I81Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K48CQdos; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EBC6C433C7;
	Fri, 29 Mar 2024 12:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716417;
	bh=5wOc+LUMfZCRy3MZnUmqxiohZmyUE+kUku580aPi7cM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K48CQdosDo9SRk5QTbGebzTok+HtVCMMqTAnVjjcK391k1vyHJ0Tnuw/cJwvrGrPJ
	 C2YaN4mqrdRD9cIe+T8+ASn7AiHYoj4Un71MgNXPdev/IYXGmeql9FA6DPmBxmBLjo
	 cnCysJu1dCe7qzG+wWe5vJkQ5s8RiehJQr3ohfJTlrLYW6ZCffnWg4XK9X0kpugAO6
	 fhYAmX09Atqcw/LOWxWVVhZInZmpNgSc33GS1+4RRzE+tORLlII9tMjtys6wT9Kswh
	 72sDOFI+SBkbpknddIpBdkubuAknNTE3hWcEWX+bTCfiQuZW+CGNKt7V9jVvG4+uhW
	 OyQNXwGbajpjg==
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
Subject: [PATCH AUTOSEL 6.1 27/52] drm/amd/amdgpu: Fix potential ioremap() memory leaks in amdgpu_device_init()
Date: Fri, 29 Mar 2024 08:45:21 -0400
Message-ID: <20240329124605.3091273-27-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124605.3091273-1-sashal@kernel.org>
References: <20240329124605.3091273-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
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
index 6a4749c0c5a58..ebca5594878dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3712,8 +3712,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
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
@@ -3721,18 +3723,18 @@ int amdgpu_device_init(struct amdgpu_device *adev,
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
 
 	/* Get rid of things like offb */
 	r = drm_aperture_remove_conflicting_pci_framebuffers(adev->pdev, &amdgpu_kms_driver);
 	if (r)
-		return r;
+		goto unmap_memory;
 
 	/* Enable TMZ based on IP_VERSION */
 	amdgpu_gmc_tmz_set(adev);
@@ -3742,7 +3744,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (adev->gmc.xgmi.supported) {
 		r = adev->gfxhub.funcs->get_xgmi_info(adev);
 		if (r)
-			return r;
+			goto unmap_memory;
 	}
 
 	/* enable PCIE atomic ops */
@@ -3998,6 +4000,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 failed:
 	amdgpu_vf_error_trans_all(adev);
 
+unmap_memory:
+	iounmap(adev->rmmio);
 	return r;
 }
 
-- 
2.43.0



Return-Path: <linux-kernel+bounces-130302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCBA897693
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B9A02922F1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C044158A1E;
	Wed,  3 Apr 2024 17:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVyzG2/j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E210158A11;
	Wed,  3 Apr 2024 17:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164678; cv=none; b=i+o/UStcMmj7CZGN+pVqkpV5vpYOfKW8yBM3XDVfPe4mbhgh8VYkjMpkrztaggrbTj6nUIsczlTCnVcwd1ki7WZ6k9BdkVej+i+ahe6D7yZR525PPq7rxztPtkZLcNGSj8VLXuZbfQUF/xtR4HJvo1Oe+TtrZOv/bbUVmKOznR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164678; c=relaxed/simple;
	bh=vNzntSBU+b6TfbGOfyJBQ1n0n6FBTCdqcV6dpTvL1f8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRdzFWlUUOvIcbZZYRl3lSTwhOzTaQ+5DJhyUc7dADUxfk+2A7Nq4uNemkI7O4VmY6gTJbJisIa1V5bf0RPvWvp0R+GjxAVSBHEzPHqGO5zP9hLSkeyW+qh3IMcf6MejIEWhxUm/QNOMweL+iqU+hNEMA5siNllnusN7D6l+ppM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVyzG2/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D505C433C7;
	Wed,  3 Apr 2024 17:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164678;
	bh=vNzntSBU+b6TfbGOfyJBQ1n0n6FBTCdqcV6dpTvL1f8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dVyzG2/jt/yjTVatHeGAd6vMH2yKsa3v7qx7Z/E3HvTlLEpGRDNgsPqSjBLn2WdJX
	 afa0ZXTbQxTCrt5BWRJfiTbvLSRANCy3PbHbLtk77t//sps/BipNU08Q4jRhW39lYb
	 9dRh8WE8x5HDrmbJexcCdFfgfaDSVFQXhhEJQPK8YzW8NnuSRQw1M5gLP5BiU555yC
	 1KG2A8GouBX8nh+LVBaDv9uuud709dekT+M+ISP3mIWF6q+6O0Jyh3hwIQAYoIHZFa
	 7Z+KbRP+yQvMJw5/i150fdM2v5MP+PdwvUlMXunBLLRul8pM3pYW6cqpWGXebXevjU
	 N/Bts6Ns0i7GQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ahmad Rehman <Ahmad.Rehman@amd.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	mario.limonciello@amd.com,
	lijo.lazar@amd.com,
	le.ma@amd.com,
	srinivasan.shanmugam@amd.com,
	andrealmeid@igalia.com,
	Jun.Ma2@amd.com,
	James.Zhu@amd.com,
	hamza.mahfooz@amd.com,
	aurabindo.pillai@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.8 28/28] drm/amdgpu: Init zone device and drm client after mode-1 reset on reload
Date: Wed,  3 Apr 2024 13:16:30 -0400
Message-ID: <20240403171656.335224-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403171656.335224-1-sashal@kernel.org>
References: <20240403171656.335224-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.3
Content-Transfer-Encoding: 8bit

From: Ahmad Rehman <Ahmad.Rehman@amd.com>

[ Upstream commit f679fd6057fbf5ab34aaee28d58b7f81af0cbf48 ]

In passthrough environment, when amdgpu is reloaded after unload, mode-1
is triggered after initializing the necessary IPs, That init does not
include KFD, and KFD init waits until the reset is completed. KFD init
is called in the reset handler, but in this case, the zone device and
drm client is not initialized, causing app to create kernel panic.

v2: Removing the init KFD condition from amdgpu_amdkfd_drm_client_create.
As the previous version has the potential of creating DRM client twice.

v3: v2 patch results in SDMA engine hung as DRM open causes VM clear to SDMA
before SDMA init. Adding the condition to in drm client creation, on top of v1,
to guard against drm client creation call multiple times.

Signed-off-by: Ahmad Rehman <Ahmad.Rehman@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 41db030ddc4ee..131983ed43465 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -146,7 +146,7 @@ int amdgpu_amdkfd_drm_client_create(struct amdgpu_device *adev)
 {
 	int ret;
 
-	if (!adev->kfd.init_complete)
+	if (!adev->kfd.init_complete || adev->kfd.client.dev)
 		return 0;
 
 	ret = drm_client_init(&adev->ddev, &adev->kfd.client, "kfd",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 586f4d03039df..64b1bb2404242 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2451,8 +2451,11 @@ static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work)
 	}
 	for (i = 0; i < mgpu_info.num_dgpu; i++) {
 		adev = mgpu_info.gpu_ins[i].adev;
-		if (!adev->kfd.init_complete)
+		if (!adev->kfd.init_complete) {
+			kgd2kfd_init_zone_device(adev);
 			amdgpu_amdkfd_device_init(adev);
+			amdgpu_amdkfd_drm_client_create(adev);
+		}
 		amdgpu_ttm_set_buffer_funcs_status(adev, true);
 	}
 }
-- 
2.43.0



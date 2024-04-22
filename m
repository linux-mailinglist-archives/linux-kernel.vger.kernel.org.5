Return-Path: <linux-kernel+bounces-154243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E4C8AD9D5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5171F2356A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3621514C5;
	Mon, 22 Apr 2024 23:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0swuiy7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5671474D8;
	Mon, 22 Apr 2024 23:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830096; cv=none; b=CzEvcz1e+Q914vHASzqjj3LXgSHQMtttZqFGj92A1aMefD1KhBCLHqElqb/cx3hPv5FstL2LKdv/cgnXGravZSKb4Xz/zLpcAz24FA3mpEnUqMa1KXOLqdxmszc/tkAaSyOIwqgmOCoslDrM1zptXANgPobA4rlVOwD4srWv3jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830096; c=relaxed/simple;
	bh=gIpt0jg6RoCpx8IHqcH5wx4Cw6Zia2ez0g7IR8/YrqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WIcY7EN2136m7TX0rkJuPTdjWIvDsTV6T7Ar0WFV/GpPbtlJIei2xiwGyNaD2yy5KBJlyrcsJWdt6oA0/MOC08W9OexJIbaXmbEJyqitJx4C+Lo11CFzVk3KF9wuPM1R711vCMvp9ex96AeP2HRgbRD6eJgb9caI4rRVMyimt64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0swuiy7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFEB1C113CC;
	Mon, 22 Apr 2024 23:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830096;
	bh=gIpt0jg6RoCpx8IHqcH5wx4Cw6Zia2ez0g7IR8/YrqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C0swuiy7/xSa8V7lzTLjZvGOz9tHiDvoEQhPATwDsiI1y/m+2D9RQ2nsV0EswQoAw
	 ptEarySgSR0Zs+f403qzx+ifqZ2uRU/iuNItCVXxlOmuJht9DZM/COywJDztPrTjWF
	 k+JrG81OzZEpeKc/AccJ6MD07j3tHIlropVPCRaQefaEZPcHHR5jJq16mnIxGf3bSD
	 F8/kbUuercVp2DUozimq06xGGttVfgcYsBSIqOpcMLs54MZ7+tqf9ssFXTSCFAv8jo
	 64Q0SMQThsfM6G3wxaSMKDbalMJoCC7rXKWEeI1qg75K2AyjEvzLjMx+Py5euVigiO
	 2NdmUKytxqXrA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lijo Lazar <lijo.lazar@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Asad Kamal <asad.kamal@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	ltuikov89@gmail.com,
	dakr@redhat.com,
	zhenguo.yin@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.8 26/43] drm/amdgpu: Refine IB schedule error logging
Date: Mon, 22 Apr 2024 19:14:12 -0400
Message-ID: <20240422231521.1592991-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231521.1592991-1-sashal@kernel.org>
References: <20240422231521.1592991-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.7
Content-Transfer-Encoding: 8bit

From: Lijo Lazar <lijo.lazar@amd.com>

[ Upstream commit 4b18a91faf1752f9bd69a4ed3aed2c8f6e5b0528 ]

Downgrade to debug information when IBs are skipped. Also, use dev_* to
identify the device.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 71a5cf37b472d..0b8c6581b62c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -300,12 +300,15 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
 		dma_fence_set_error(finished, -ECANCELED);
 
 	if (finished->error < 0) {
-		DRM_INFO("Skip scheduling IBs!\n");
+		dev_dbg(adev->dev, "Skip scheduling IBs in ring(%s)",
+			ring->name);
 	} else {
 		r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, job,
 				       &fence);
 		if (r)
-			DRM_ERROR("Error scheduling IBs (%d)\n", r);
+			dev_err(adev->dev,
+				"Error scheduling IBs (%d) in ring(%s)", r,
+				ring->name);
 	}
 
 	job->job_run_counter++;
-- 
2.43.0



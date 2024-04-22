Return-Path: <linux-kernel+bounces-154278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2028ADA34
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 947B51F2150D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFC216D9D8;
	Mon, 22 Apr 2024 23:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krPMNfJF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B3F16D9CF;
	Mon, 22 Apr 2024 23:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830204; cv=none; b=QhUoQi+S8/Tby4toCFQJcN7Z9q08Br0RskQJC186b0ws2PvQrkhB6YQ4mJ3OcLUNkaXkrpRoxnp8Z/6Hvmi6HCCYwsLCsjZ6rpSfGIDuNox1zvrtdSn1TN/tAslunybgSWUkq86DtM1IrdgPmD7hBQR0+x5EDXbaEbVBfQIBVqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830204; c=relaxed/simple;
	bh=EUGFj9Mtq+6MugVf19sjasOnoCDVrjYyF0aW0FnC7M0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X656Fm69/x8+6atggIS7c5PmiSFcSPaB3nKjBtIqCmppKRhoTR+p9RCMdYWCMPeFrjm6CQV+iGW+1h8nQTwKNyw3ZQHQruKcGEwHGRWW8I95z0agvHB05+XriCvm0LOaTr2DvRpjvRX+QWCWl6Y8IRpiiZiqqaVGf+sIKz+RDyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krPMNfJF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C802FC2BD11;
	Mon, 22 Apr 2024 23:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830204;
	bh=EUGFj9Mtq+6MugVf19sjasOnoCDVrjYyF0aW0FnC7M0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=krPMNfJFnvwsyDiRFHqqwfqvyccMWpKBPcr4mZEbhfJ5w5ZUfjf9H0L0GjPIHYTrw
	 MrsZmiT2mLWJc0j7qwM512O9/dANqdmOpozOTsNoZbbs7i2wod2kijl4Dw1p+zsl2q
	 8W3oJ5IBVCwtJ/W2Vw9rdLJx6PAJxJ3r8mdepZlbAfCnDtquVST5sK4qBSULLWcCUF
	 YzDjDd4bh4srbFICBupHU/sgH1uuWHqqUwKldEVOWMvcVpI+fSXU39CEAP1fQvzekq
	 EmnoX7/HZa2oVyZfZRB8E/OtAenUk/fY/cuexE3HkU0RCRXplos+CKaRGE1MRpszsf
	 aEL7Lxy80YHjA==
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
	zhenguo.yin@amd.com,
	dakr@redhat.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 17/29] drm/amdgpu: Refine IB schedule error logging
Date: Mon, 22 Apr 2024 19:16:58 -0400
Message-ID: <20240422231730.1601976-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231730.1601976-1-sashal@kernel.org>
References: <20240422231730.1601976-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.28
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
index 78476bc75b4e1..de9d7f3dc2336 100644
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



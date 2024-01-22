Return-Path: <linux-kernel+bounces-33302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E912836826
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FE6B1F2619D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFBA5F840;
	Mon, 22 Jan 2024 15:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvHUUYVT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDA34644F;
	Mon, 22 Jan 2024 15:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935718; cv=none; b=oC9mLC/wNBPNj31RduzndfVyc5QjOxkH16/wdhIrkRiPawxsGgeEAOEqq9dOBIkThNC9k0HUxUPUo3E3+SoE/4taGG1OKtx/dPlAWHpDbwOa4VSFguP9/zx8Pt1Mur5Wck7lszt9hkitvQwjZxOTkI/i4yxSFmNN5VIZ7xCGBKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935718; c=relaxed/simple;
	bh=hlwss65vsu1JL9eiVYuXMgPJu8Gko63+U/Dym0795eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qx2scYw7Z0qjqy3VSdIOuN/VjU1j8Adonf6kyXi63V6EKqu1C1o7aF5olBs7E0riY91N5SuA7yBH7GPEayaZOSSUjA8TmP7PIm/+U2xvYT90hogTvMHAe/QyIso4BlSZS9bUGHs8Oig60TsfNvsPvh7DrsGgG5uy/kNZb7RIzQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvHUUYVT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DAECC433B1;
	Mon, 22 Jan 2024 15:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935718;
	bh=hlwss65vsu1JL9eiVYuXMgPJu8Gko63+U/Dym0795eo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bvHUUYVTIUhEXexF1vZCsNSkKobYNJwyzlgeaBX5C0aEItr99UKqIOJ3WkHLZ7gSj
	 3Apw6VYNRAlhvvW3pYGr0DL+IcO7Di5tyuIdgxw1SRR7q1rmk6HepD1vCVNbSzbKnS
	 4RbkDvv63wlHhb4E6mYF5FoyF/VOahh+ZnZgSVbVJuVmiSkQLi56Cp153e1XKdWlhg
	 2xeLwvPXPdpQn/mm5+rJmUZock9KIZ1ybCL3oRcS6yTKPalwYGq7+Nk8ySz5DAqZUC
	 dtCLnTIDzXj964mggLqjSdQHYBDB9ClbPwlSiD6hfHxIwybveN1B7DvbgKCBnN+jr/
	 fhnL88PbNWgaA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Lang.Yu@amd.com,
	le.ma@amd.com,
	Stanley.Yang@amd.com,
	lee@kernel.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.7 80/88] drm/amdgpu: Fix '*fw' from request_firmware() not released in 'amdgpu_ucode_request()'
Date: Mon, 22 Jan 2024 09:51:53 -0500
Message-ID: <20240122145608.990137-80-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145608.990137-1-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
Content-Transfer-Encoding: 8bit

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit 13a1851f923d9a7a78a477497295c2dfd16ad4a4 ]

Fixes the below:
drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c:1404 amdgpu_ucode_request() warn: '*fw' from request_firmware() not released on lines: 1404.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index b14127429f30..0efb2568cb65 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -1397,9 +1397,13 @@ int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmware **fw,
 
 	if (err)
 		return -ENODEV;
+
 	err = amdgpu_ucode_validate(*fw);
-	if (err)
+	if (err) {
 		dev_dbg(adev->dev, "\"%s\" failed to validate\n", fw_name);
+		release_firmware(*fw);
+		*fw = NULL;
+	}
 
 	return err;
 }
-- 
2.43.0



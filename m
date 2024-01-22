Return-Path: <linux-kernel+bounces-33390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CC8836923
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7919A1C237A3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305B77763E;
	Mon, 22 Jan 2024 15:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMl9pcLZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744F74BA91;
	Mon, 22 Jan 2024 15:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936106; cv=none; b=qIaWYqBUso9ljBMJB58KR8pew1OShO3A9jaKLcw264r+YYDpQ5hvw5YrDA9iB71dz88XvelV2YoXLzf+3O8uQG3bsHk8YZrOafHmYoq93TnE3DLGAg66r+J4DGAEdqQ3yictjG6b2H1lz6qSwEGlVAEexv+kLx4L1I3FJ+U+ZKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936106; c=relaxed/simple;
	bh=w5b//J8h5GhxUfu+VtkycHarSPwgsZgDO/hO2yKIPek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZskfsdTe/8vTn+HZI16+n71OncC4kWEI+jZu1aElsS+oB3eKch/+kOEko6K6etg3epMJrSYsfhoqzEwb7MfeLSgEgOeAd/W3M2tfO5n552vcjAoWWVxZFEwnUQLVCVbR58AA5eFBckPJhLT+svxmrRrfGH7x5p0xzdazmDyEcGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMl9pcLZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A20AC43394;
	Mon, 22 Jan 2024 15:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936106;
	bh=w5b//J8h5GhxUfu+VtkycHarSPwgsZgDO/hO2yKIPek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NMl9pcLZBnpuuNQBmAT+djPp/QMfJ8ioyJJmxoScsSLa4ZpB7vbojwQxEtEv7uD14
	 13OXpQnTMLhHQq/1HbINmnMIWls40ny7EcV7wQwUhTQdayesKPqg/AEucz1bjge1gn
	 KJjWWxr1Ga4k2lQ3A2ZbKlg9XJDV/+YhaZhM4L+lAtX1pHScijSqhCazTV6uiUPA8e
	 8rbzoEYs6kd+chZ7pijMF1Bin6NPeniov2RmEe2jybDUXrSIw1B4p/hyXgHahotvQ7
	 qsZAtKSqD62wnjJP7Il7hyqxbKfY2G7StERgoqy057VSNO8kRY5ZuoMdAYBXqhcb9v
	 CTw6jrujDorOQ==
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
Subject: [PATCH AUTOSEL 6.6 65/73] drm/amdgpu: Fix '*fw' from request_firmware() not released in 'amdgpu_ucode_request()'
Date: Mon, 22 Jan 2024 10:02:19 -0500
Message-ID: <20240122150432.992458-65-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150432.992458-1-sashal@kernel.org>
References: <20240122150432.992458-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
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
index 8beefc045e14..bef754177064 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -1326,9 +1326,13 @@ int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmware **fw,
 
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



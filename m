Return-Path: <linux-kernel+bounces-33448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A31836A12
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B629B298C0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBAC4F895;
	Mon, 22 Jan 2024 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+kQpyf8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5FC4F886;
	Mon, 22 Jan 2024 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936340; cv=none; b=EMzIOhoaH8jTwf1GKPNcfRznwMBIaMTrmBnLzoQknBU5j37+6nadBysi6O1kOTWuMMwLympC8QshcLt73J6wnApAQa2v0V0ARFQhHoGEn92HRxMJZUCLG0Weg4S+P/yMdysJs8SP0QieveM8og3pwVKNonLw10LY76bNJ+oiH+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936340; c=relaxed/simple;
	bh=sd7iwprj+8LybP1sstXYWOpMSALRS7T7tigyJk1aFXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jho7htMziL0fqKVEcKblQp8LagWr3iTGEO/bTjs2Eol5qXtgIF8KfjghoZWp3z+cekvJ746JxMlfR8Xj7pmvI0JkifBUtrOXMIeZdoz/BdTFbs21E5bM6HaTsjM4MbeOSjYenpxYJRJuaDLlQtsdvhjsqSKnvy9MTmz90Z4kJPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+kQpyf8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A615C43390;
	Mon, 22 Jan 2024 15:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936340;
	bh=sd7iwprj+8LybP1sstXYWOpMSALRS7T7tigyJk1aFXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y+kQpyf87QuFc6rxIITMUfUiRx5tBggF5b5H3+fSm2mepEqekKdW/KyFLOLDUwM2Z
	 yrANlBhv8del0y4PaW5oug04+KjYwAo4KoNc36uMsilfON6BB5rrWgqGGqd3z3vm+2
	 DILan3J1DvEhOWU64XJeRxhJ1klq7DCuLDq8SGfRAMeOjAjUzvL/1l8qQzld1UnUm8
	 Xfrx44ep3rf3RwC1nzN4kg8EHLmFWHDIZKUdiBJNXV0z15bMfG2Yh3pXr91aD4Ffq8
	 9A8PmVJ/IXslHiIjL3qxomTkN8+SQW4+S+1Fvn0i6OiHsZaA9Yu7xJFd7N4Y0/QTHo
	 cAxE5DYYY2J/A==
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
	Ori.Messinger@amd.com,
	Stanley.Yang@amd.com,
	lee@kernel.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 47/53] drm/amdgpu: Fix '*fw' from request_firmware() not released in 'amdgpu_ucode_request()'
Date: Mon, 22 Jan 2024 10:08:48 -0500
Message-ID: <20240122150949.994249-47-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150949.994249-1-sashal@kernel.org>
References: <20240122150949.994249-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.74
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
index 6e7058a2d1c8..779707f19c88 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -1110,9 +1110,13 @@ int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmware **fw,
 
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



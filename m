Return-Path: <linux-kernel+bounces-41800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DAE83F7D6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 713FF1C2229C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685D44EB54;
	Sun, 28 Jan 2024 16:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yhuow47P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF1A13AA22;
	Sun, 28 Jan 2024 16:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458557; cv=none; b=ox2Lcrd4eSuWp3N45YFTG90KLXaSvRfmj42OOwPKORRe3HcV+d5dGc69kUjCtHZrCGWKdrE3zx7KgigfOIckJXY3vUHn6LgeQqJ1/QFQSmsgLp6yK3YacfgK13POhIzEZes/bw/Ll9LAQxMUvnBihjzSnDUHJirIptfu9VLd5Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458557; c=relaxed/simple;
	bh=MI288FLtEqUq5o2SIXGR0lmVO9eM8omBcvCeY3vaCMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s7rcMzsaYSBcZRwYWI7A/Hi52OWKN5uZb/C8MtOC/npl0PL7m90KstfwpPFSWek2Y5F6+PFjjabTOyq0WumQ1QsaZnpw2g1xsXbYy6PxgyNrM0TZfkV8biaFs6rpzAJbtWxuRc+M+/aoqqu5dGSfkD8RM6EGDhyVsjOoHnOiWZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yhuow47P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26166C433C7;
	Sun, 28 Jan 2024 16:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458557;
	bh=MI288FLtEqUq5o2SIXGR0lmVO9eM8omBcvCeY3vaCMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yhuow47PtqUjvvwH3aE9yHeiDxWnXpNmQCRhcckAP0TBYnRK1uT/DpSmhHEIA+W2e
	 3YvZtJxRNQfMKF+gZv3X5wNgWZ1NGjQRTnO6y49CcjfdLbt5BeilF+pu/JF9O0IT3v
	 FGPH+Dhjg07fdDj3CGOIBrNaEh8bxX0lK4Dq96hp2vNWqqLJPR99/Y6nQq7sC3NTe4
	 FoCcso3xRWCNGc+9J19Fjlb2vBKJeLskQ/a1+ZlI9DjNZRuExvgkgl4ui42JPlFTCN
	 sdipfzgeK9RdydwSnkxI7YtQXD71S+BMwIoYob9v02qyodtPSVQHYxMrJDlKXA9Hy1
	 aRY4wB9bU8F6A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Monk Liu <Monk.Liu@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	mario.limonciello@amd.com,
	Hawking.Zhang@amd.com,
	candice.li@amd.com,
	le.ma@amd.com,
	victorchengchi.lu@amd.com,
	shashank.sharma@amd.com,
	andrealmeid@igalia.com,
	hamza.mahfooz@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 18/19] drm/amdgpu: Release 'adev->pm.fw' before return in 'amdgpu_device_need_post()'
Date: Sun, 28 Jan 2024 11:15:15 -0500
Message-ID: <20240128161524.204182-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161524.204182-1-sashal@kernel.org>
References: <20240128161524.204182-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
Content-Transfer-Encoding: 8bit

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit 8a44fdd3cf91debbd09b43bd2519ad2b2486ccf4 ]

In function 'amdgpu_device_need_post(struct amdgpu_device *adev)' -
'adev->pm.fw' may not be released before return.

Using the function release_firmware() to release adev->pm.fw.

Thus fixing the below:
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:1571 amdgpu_device_need_post() warn: 'adev->pm.fw' from request_firmware() not released on lines: 1554.

Cc: Monk Liu <Monk.Liu@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 19e32f38a4c4..816dd59212c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1292,6 +1292,7 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
 				return true;
 
 			fw_ver = *((uint32_t *)adev->pm.fw->data + 69);
+			release_firmware(adev->pm.fw);
 			if (fw_ver < 0x00160e00)
 				return true;
 		}
-- 
2.43.0



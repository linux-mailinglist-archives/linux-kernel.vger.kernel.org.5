Return-Path: <linux-kernel+bounces-33546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8E4836B19
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BAE41F25E63
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BB914D453;
	Mon, 22 Jan 2024 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRV7Ics5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4FD14D444;
	Mon, 22 Jan 2024 15:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936681; cv=none; b=LP70DsCfLpXJ6RTGJnJ55A/RM/62tzLKN+D+NANw4KpAk2o/omFedOSMSK7kJrGpXUdNqwnvKgP8NN6QkkC8HujTky3WqxUpvmF1gLstF1n85VaRJEkl5JQWXvXeSc7G+Yb5ijpzBHJ9ah447FYsVOV0yYUFfe6WVumejkmGmkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936681; c=relaxed/simple;
	bh=SVpnJsIni3yL13XFNxVisCP4/jsC1U1pPMVXaLKJHPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HtExny8HQQ4Hn5a9uc9Egzr9yPOEIIqireYapJ9mo61N/4qxQ1rrRN7RrkB+siooyvdZBp22qkATYYgvnhBlerNECrOOcVGRkg8TBC9xh+MFju+Q2hYBLa7c+Sl5yDnsKh4YVsK6v+q2I3t2VpWosdVgKWP/UGuQJFOlr19ELbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRV7Ics5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B738C43390;
	Mon, 22 Jan 2024 15:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936681;
	bh=SVpnJsIni3yL13XFNxVisCP4/jsC1U1pPMVXaLKJHPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bRV7Ics5pCzYabJpn2S+ztmHJxxfxJNbGWaBiugV64xOYXMmQKDiOGLrY0tnoMs6V
	 Hw7At4BY//SYpYR6c4Fs9KC8PslzrCHD77/e7q1Jyh4ALs3r0e8ORSi7paSVOPoD9R
	 LEOthfd3jhnUD2ONR1pVMn8sxG1D/q7iKbErmGQ/rDFE7zoQm+Rj2FqVDvVu1FlxHJ
	 5j/kVjHBLd0EEJp+A8jJ1JvZPm+smXFS9EWm36e1Oq8nBzJDvQiVQs+7suobTQffIW
	 a4XNNG5kV0Wk1LjQUhMp2MWu5wlCkirDtaaYkUrN8e3AWCCk56RdFC/7zuo/ef84Gd
	 jJJQtcETDou0Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Felix Kuehling <Felix.Kuehling@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 23/24] drm/amdgpu: Let KFD sync with VM fences
Date: Mon, 22 Jan 2024 10:16:37 -0500
Message-ID: <20240122151659.997085-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151659.997085-1-sashal@kernel.org>
References: <20240122151659.997085-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
Content-Transfer-Encoding: 8bit

From: Felix Kuehling <Felix.Kuehling@amd.com>

[ Upstream commit ec9ba4821fa52b5efdbc4cdf0a77497990655231 ]

Change the rules for amdgpu_sync_resv to let KFD synchronize with VM
fences on page table reservations. This fixes intermittent memory
corruption after evictions when using amdgpu_vm_handle_moved to update
page tables for VM mappings managed through render nodes.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
index 95e5e93edd18..7e840e560513 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
@@ -218,7 +218,8 @@ int amdgpu_sync_resv(struct amdgpu_device *adev,
 		 */
 		fence_owner = amdgpu_sync_get_owner(f);
 		if (fence_owner == AMDGPU_FENCE_OWNER_KFD &&
-		    owner != AMDGPU_FENCE_OWNER_UNDEFINED)
+		    owner != AMDGPU_FENCE_OWNER_UNDEFINED &&
+	    owner != AMDGPU_FENCE_OWNER_KFD)
 			continue;
 
 		if (amdgpu_sync_same_dev(adev, f)) {
-- 
2.43.0



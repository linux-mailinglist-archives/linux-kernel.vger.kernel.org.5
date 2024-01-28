Return-Path: <linux-kernel+bounces-41719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A6E83F6F6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 097D7B20C99
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8712458ABE;
	Sun, 28 Jan 2024 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xx2Ex+HC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36AF58ABA;
	Sun, 28 Jan 2024 16:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458377; cv=none; b=aQQ/1bdUloZixQam9ffe1FfPUdWTEPdHxd8E4UomhFiBJzJqjq75qO3uJYAiQgylTkqtEMCCRCSDqucpglXQbNw6MYd6Ga9p/AFz9whPvXnSoMmq49BV8gSP6VzNzPuf3sZ0fpKbqUbAnwGrt2U374o6dkxiuWA5dIS5HbBByBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458377; c=relaxed/simple;
	bh=NkCx1mZWXernixoDQrxbLQ1qYWwLV/3EYakQ72kunOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qYoxAHTBAxqIkGR+fwpXYxFX2ctUtF8liBTcn891IO/GVBww+snJTtDzCf5b4MUo8gHl3mt3OgR3t6GDm36usgnU8OoqbUrwrz6B7uZ9DUt1ftrQrG74Y3fgJUR7cR2h+44OKCAq5fr8eZjPY/AFS3hZ3N+oCRXSJZFLdlZQWuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xx2Ex+HC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A58C433F1;
	Sun, 28 Jan 2024 16:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458377;
	bh=NkCx1mZWXernixoDQrxbLQ1qYWwLV/3EYakQ72kunOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xx2Ex+HCmiFXQRnUmv1GlOARFY+1amXL5idzCgu598FyCpBIchq2PthRctFtYBm/i
	 sUsuNEZmuHibcWol1be/3FiYuNrzjy3SanysgsDmVQc6FceF0/kfYFYMChn7xHc/zw
	 epMS/xGodGJ4sVn7Y19d0JNv4urkZyaGMyM7R4kvzsHdlB+i5SuPOIDVprYJ+iZDk/
	 0L4VRBpFqxh6cZXLAf/lVa0pH1/GLwHWMrcQ/T9tyveBZDS64vaBYxBgotVHpGavQZ
	 2yuy7w0w6Hllkvl4dPBpFZNw3PnYNw9b/uniUBnlT+/vaRnQNP7bgxq/EHCwJpOAKt
	 nZ6KFORNH53zQ==
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
Subject: [PATCH AUTOSEL 6.7 37/39] drm/amdgpu: Release 'adev->pm.fw' before return in 'amdgpu_device_need_post()'
Date: Sun, 28 Jan 2024 11:10:57 -0500
Message-ID: <20240128161130.200783-37-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161130.200783-1-sashal@kernel.org>
References: <20240128161130.200783-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.2
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
index 93cf73d6fa11..16601d039dfa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1485,6 +1485,7 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
 				return true;
 
 			fw_ver = *((uint32_t *)adev->pm.fw->data + 69);
+			release_firmware(adev->pm.fw);
 			if (fw_ver < 0x00160e00)
 				return true;
 		}
-- 
2.43.0



Return-Path: <linux-kernel+bounces-33387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDE8836952
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85A92B23C04
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDB14B5D2;
	Mon, 22 Jan 2024 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="seVONTCB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA58768E6;
	Mon, 22 Jan 2024 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936089; cv=none; b=jELLSyLt5eTbs8lXBaK1UrZQ02eV8tpw9YgYa1E9ZazrJ1+isO1T1frhvR0togT1/VP2KqUJLdtyqRcqNRtxdY0vefFZV/724BR26sWJc9pJnVHAftxRmgzkDk9fWrmcu9Q1PdrNunZIjU0xPUySpZGmfPds7q4HOl99ruGpqMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936089; c=relaxed/simple;
	bh=GiIQV0fB/wKLdgMeKTrjGy1g4IAgHmZH/YQFcJLmGaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hQeahy3NgvQok3/6vc/UkWD+Tvs+5r3I976R5Z/fy9IwIYx3ojEPLSGFIY0ztoknIPuC/58kr2PKPvlh3S80+40qPHSwABGkEAGB6jA1dPOcA2EdVPbMn0ZDELdLkxOg9gO6ZBgXIiPnEhz80J7a3VmPPE8wf8BXqLaG6bFpcPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=seVONTCB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D9FC43399;
	Mon, 22 Jan 2024 15:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936088;
	bh=GiIQV0fB/wKLdgMeKTrjGy1g4IAgHmZH/YQFcJLmGaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=seVONTCBpxBJ+lf+D/aWyLwc8IT/ZDGaN/gTgrhr3vGN86HHoss6pGUepO6RDyo1D
	 hZ0SyAugfZwnAGsCrUIMX1P+krudM83D9n3LpC8x3/6Romf0nO1hX6Y6bSKyc32Hf/
	 gUhMh9z/zDtSo7cZMEnWHYEzcvQ56lu4me1HUjhNSZoWmzqriF6o3B2BnegAfJHVar
	 TvYHgUd1NlMhjc6CqdwJRhKLKGEWose5hQJ935Lv/2sk33jgLIoGZQQqrIUIr/IMo0
	 z+/kRuJsECBBz4hgIsprkmM1yN9V4vZ8TZS8DGBUMqYjteNFt3NEYDcXgxevvE9O0e
	 gbsa7YtS9XHqg==
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
Subject: [PATCH AUTOSEL 6.6 62/73] drm/amdgpu: Let KFD sync with VM fences
Date: Mon, 22 Jan 2024 10:02:16 -0500
Message-ID: <20240122150432.992458-62-sashal@kernel.org>
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
index dcd8c066bc1f..1b013a44ca99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
@@ -191,7 +191,8 @@ static bool amdgpu_sync_test_fence(struct amdgpu_device *adev,
 
 	/* Never sync to VM updates either. */
 	if (fence_owner == AMDGPU_FENCE_OWNER_VM &&
-	    owner != AMDGPU_FENCE_OWNER_UNDEFINED)
+	    owner != AMDGPU_FENCE_OWNER_UNDEFINED &&
+	    owner != AMDGPU_FENCE_OWNER_KFD)
 		return false;
 
 	/* Ignore fences depending on the sync mode */
-- 
2.43.0



Return-Path: <linux-kernel+bounces-33571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E04836B84
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0D661F22D50
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F117154BF8;
	Mon, 22 Jan 2024 15:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4hjrzKL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C6D58ACC;
	Mon, 22 Jan 2024 15:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936765; cv=none; b=Oxpd6QjPYbhanv75EmOTGMo6jbnDlcx+vHMFg2DXkTZ1B5OKQJTtlOrfnyfbDw3tmxjzzjEwAGcHkxzpzTio+gg/JkwEtbilzMvlopbNwgYKZobPfagAx30LN1haUgwofJb/MZnP0WIMvryZ5DjLSa2xrz6yb+KWnvI9bEbsC5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936765; c=relaxed/simple;
	bh=gk3YS6kxqpkRP+59kvy1Xe8bJ8HiKKbZy+O04X2vTWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ljyyRd04BbDAiTu4l1CoR3EYXovoOzf2rNq6YgST7NuEgiMrEPgGOg09/t1RRr4MH2bVfgViXtDS+r/ps34Rz/HE+LSpNrMLCSXOaVRNRCA3wt2G8RK8ezQtQcj9T0fxV3srRmArcd7Ibx8Lbd3HuvlRjkaTJ+4m88SKjjcdMMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4hjrzKL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2948C433F1;
	Mon, 22 Jan 2024 15:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936765;
	bh=gk3YS6kxqpkRP+59kvy1Xe8bJ8HiKKbZy+O04X2vTWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O4hjrzKL3+wBSUPFzI5JdQNeWCAJIA5+FxBJukNZmcJOaFzYRbmYcY1DIw4gYjAcS
	 y+Nm4ndjt9D0xUGHJMnzakOTkp+MDnj4cQ3fwY19RQmTPedTl4h/zF9AEYHhpSzLVQ
	 Q24+0ustkwPbusKYByOZicaTI43HUqCsgoRkApdjXbNnoNXFeQnQ4/ZcyWGdsZJdhn
	 1BqR+NAMJG5A6+dzob07Qe7oc9gbIaJQrT35+z28Cehf9GqX6BzaJ9Vq6usjXbkZHf
	 tT82Gb1UYCQR28guPWqtUqAZpJOp2L+MOlINvrIbkTTRr6wNODNdhk50BQOSaTX7zl
	 3W/OANbGfLIeA==
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
Subject: [PATCH AUTOSEL 4.19 22/23] drm/amdgpu: Let KFD sync with VM fences
Date: Mon, 22 Jan 2024 10:18:02 -0500
Message-ID: <20240122151823.997644-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151823.997644-1-sashal@kernel.org>
References: <20240122151823.997644-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.305
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
index 2d6f5ec77a68..5eb8f93c7022 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
@@ -219,7 +219,8 @@ int amdgpu_sync_resv(struct amdgpu_device *adev,
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



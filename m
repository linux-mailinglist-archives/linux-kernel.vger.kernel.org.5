Return-Path: <linux-kernel+bounces-33446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED078369C2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91CB41F23D6B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4CF4F61D;
	Mon, 22 Jan 2024 15:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Em7h+skf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8234F5FD;
	Mon, 22 Jan 2024 15:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936331; cv=none; b=lZVTOyrOp2VT295+vc1ynPKQNWv1TbZNRbarc6CFrKyGNUIlmTUVVX+qsoM9DWs7TYs2qeVaKQY8tw2W1VL/gJvfzgFt36F20J1HTfGxsDLM2931qdDsDByNDbHga7OvC3HE8L7QNqqYrmr1SsGR7+K+XZOsNFuZTmR4rby+R+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936331; c=relaxed/simple;
	bh=LExyl5tzBGy0JjA375oXsxH+2E3IeErllaNkAG9dy5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zb8NWGNO9+2YOUZ+t8pawzV0ENXtOn3cU23Yv3YKpuPW5e4xyEekzejZWXmvyqGHkdip0LEyztiPS6AYqelp432lXCx+eG3ObR2xxWz4rMaU8J0R0AFWbijl6hUxkMjyL8mElf6Af6EE9dd/PgaJrb1lsfyv4Cqx+bMkad+Kfes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Em7h+skf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8D7C433F1;
	Mon, 22 Jan 2024 15:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936330;
	bh=LExyl5tzBGy0JjA375oXsxH+2E3IeErllaNkAG9dy5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Em7h+skfsnTtbRNL8/QO3DQW/f3dVih9zz+ebTlqps6t5B9fLrnGbqhdq8sR4rhUK
	 DAFt9w+777POdZ7xQTL2J0CuorACRWsH5HM9M++d/eHAuJRs/fJe1ooySizXxt5H/s
	 j7QbdBUOGC7w2kWfHkr0FaKkoVERJsP3KfKiT4CaDrVhCiKd7kvQhZkeD/e5ejJ0CW
	 EYUndSkgtqSqbFLR37ufTU3ioX/oSmcUWmJiTDbpd9rGv1SsMNACzj18ChB4lulfgi
	 DcntbqUBoeLCoj5y+ce3qXfS9qIiXrOVuUsoqLS4hVyWCInVq5XcCBGfSgBpMBDa2+
	 EvJK4gja+cS9Q==
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
Subject: [PATCH AUTOSEL 6.1 45/53] drm/amdgpu: Let KFD sync with VM fences
Date: Mon, 22 Jan 2024 10:08:46 -0500
Message-ID: <20240122150949.994249-45-sashal@kernel.org>
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
index 090e66a1b284..54bdbd83a8cc 100644
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



Return-Path: <linux-kernel+bounces-33491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7A0836A4A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84FF5288AA1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE15137C5F;
	Mon, 22 Jan 2024 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfpzfxFD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72259137C35;
	Mon, 22 Jan 2024 15:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936488; cv=none; b=hpWiop0d/oA5nX+Rk97VAyr+yp1KWeGyJI36z9HLq+bn6Dv3HrFMRRxkgljYP3eBTrDhhQM/d93fYh95nK/a64iKUIPuP344WqeaN/kETeRxpTBBDDisZtIS0Qaq5lfkULbx2+MOfmajight81QMS1i7BSiO5izfpJ6qeXq8RQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936488; c=relaxed/simple;
	bh=oqjYaQXVXeLVMMTlYPRnTAla9La0R0kljsceOMAO5tE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PCtgctK8O2LXTipOaZzsOQdWy9e/DHDZJsgDRhML4mNaP2WgQv2TDvacC5FoJIcY9N12YFjUVu5ymLjO0b+Dr8BZdIviLme3vrvtNmEj6LZNgcwxjLo6rE0UbuvSxIwiTR65yknkwWq4j+qTZd8D7WKX9Rr2u2ZGFs6Kx5W9JDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfpzfxFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A6BC433F1;
	Mon, 22 Jan 2024 15:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936488;
	bh=oqjYaQXVXeLVMMTlYPRnTAla9La0R0kljsceOMAO5tE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XfpzfxFD/vz+c0wspemcOOPvnuvzEwVU/GalK6eOZMuK0HSj/2ZBzobFruVc7wA7G
	 qAnmc4nT3x3snVThDzlnT5vrldwOU0ijdNXCxQIJgW/H6XZBcnyyKF5n6HwynB0p3K
	 1rePOXfvBZ/PK2vfYoA1HojHVhnzfPLVZDSTPLwqL5KfWLfBQG7mx1ppRKEYDyMzDn
	 D4fFhVkzGSAiKa4VDSPpA+aKQqp8EkLDSfuMh5RPzS4b29OSbtLGCs2Wb8irGFizkY
	 8k4DTDnUHoq676LHDNkFjxyaHgSIihT60BoLOgLve7rLP4C864USaMAG5/pQOxSI+n
	 ItljesNxFRDXA==
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
Subject: [PATCH AUTOSEL 5.15 33/35] drm/amdgpu: Let KFD sync with VM fences
Date: Mon, 22 Jan 2024 10:12:30 -0500
Message-ID: <20240122151302.995456-33-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151302.995456-1-sashal@kernel.org>
References: <20240122151302.995456-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
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
index 862eb3c1c4c5..494466893486 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
@@ -208,7 +208,8 @@ static bool amdgpu_sync_test_fence(struct amdgpu_device *adev,
 
 	/* Never sync to VM updates either. */
 	if (fence_owner == AMDGPU_FENCE_OWNER_VM &&
-	    owner != AMDGPU_FENCE_OWNER_UNDEFINED)
+	    owner != AMDGPU_FENCE_OWNER_UNDEFINED &&
+	    owner != AMDGPU_FENCE_OWNER_KFD)
 		return false;
 
 	/* Ignore fences depending on the sync mode */
-- 
2.43.0



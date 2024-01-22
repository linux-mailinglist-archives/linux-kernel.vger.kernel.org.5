Return-Path: <linux-kernel+bounces-33297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F560836814
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B347A1C22EFE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E005DF0D;
	Mon, 22 Jan 2024 15:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZl2jWmt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F235D91F;
	Mon, 22 Jan 2024 15:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935693; cv=none; b=pYkg1TbdVF+0TibNKEQ7z9TpX7PRilKBsjndNUYdJig0UE/OhhpAN7Iz0oLzCc2bwQqmajuJUeKVuZiz9Pt7oGEVoKfNKAT1mcZmXVm/MELTZ1ceBaQN/tNaymcJqp1/xIcEwQ4fZsq9cdk4/YaTTdRRrlmjXz+2ABmNqQUUHhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935693; c=relaxed/simple;
	bh=GiIQV0fB/wKLdgMeKTrjGy1g4IAgHmZH/YQFcJLmGaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DIzLLHjTZpFhTsOhwrq/NIM2m7iCja7qLzQ2F+7MqEM+I0NK6jaWLZKBjOwdVVotOYKq9fRWfKZRmTISf6xirGnvMjl0uhG71p8UXNRFA8Yr3jNlhfU1JRKlI12oXuSOFjP1nwp81Cp+mk2ubiBrnhUqE5wTv0QhYzSAD1pn898=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZl2jWmt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4FDC43330;
	Mon, 22 Jan 2024 15:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935692;
	bh=GiIQV0fB/wKLdgMeKTrjGy1g4IAgHmZH/YQFcJLmGaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nZl2jWmtbe7ZMJAKJGSMavvx5fi6+K4vhACQ3wBL05ZC2zVNbf1H6/aSLpM7kGbVg
	 MIan7kpt55D25lq8F4toj4gPqx+FDSqjChVodQHQ+IOjl3AyX1M4LK1oI5Q0LVCeC4
	 CMn4r8ZcY2c7fdNppisYJNpiLLeM2r6B1rn15UwjsDWjuuFs7w2+CpXnjAXKqDjnXE
	 SRhMPoqSDLpQNj8Jc5u3zB8VF/cdMlTA87vB9WEcF7oxUErhTztLjXzNGu2jhA5jaa
	 qRaM29QD+1rHKzP2VJqaqrsncVcWFd3rEjaX+aym714poPJqq8mDUEA5N3Sr9mYVbe
	 h5m2CeRwPUdsw==
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
Subject: [PATCH AUTOSEL 6.7 75/88] drm/amdgpu: Let KFD sync with VM fences
Date: Mon, 22 Jan 2024 09:51:48 -0500
Message-ID: <20240122145608.990137-75-sashal@kernel.org>
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



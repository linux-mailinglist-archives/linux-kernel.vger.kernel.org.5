Return-Path: <linux-kernel+bounces-33522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C4D836AB3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45B751C240F6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F87056478;
	Mon, 22 Jan 2024 15:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="boIM30v6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EEF56471;
	Mon, 22 Jan 2024 15:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936595; cv=none; b=XpSCLJ5sERBUX07V9N12C/RYnhUMU4eueAUK3Do2UvgtdRjAvdeeS8kUuJ/dbwIh0HwwIDogXvTZQufIdw1t/SbX7bxXWXMEDNuQ1igwVHGVEsVfe0VE+Yg2yNhIxmLxvXqYmTe19goFh510PJm8u6XuogUjG71Jix15MAQjBjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936595; c=relaxed/simple;
	bh=cxPDjimgUngRHIeDEPESfgetGWsk2vnEtf4FJ4JMjoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qYcuAyhx3KifAIx74GLdIdgczZPy44GtNjJAU12odYLbjutx29vyJRWcLslwNWQ2M4t6DHIhPTVOY/RH3q2qKHemQ3xdy1cyNJZ8iJ416z5/K8ElCvZFE9CQmfrn0k7PMdFY/R8DHy0NApmEAKKfE+OhrH/ZYPjxwmwFzQYJIwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=boIM30v6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4186AC433F1;
	Mon, 22 Jan 2024 15:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936595;
	bh=cxPDjimgUngRHIeDEPESfgetGWsk2vnEtf4FJ4JMjoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=boIM30v6tAQ7MeIzG2CGNYePoEK0sM2pcfrjlFUHhfNyBhMnIoIL6wflsQa7bP1mb
	 YnvaOkfUZFl28SXoRXJbkzaXAe7fZspcORZDcEOkZ6CqYYRTLgu8wJQt4Lj4QP9o2b
	 TvIp6oVnEPYWmqMyU9h22foW2GrNmLWCjxI6OeLI+HXW00ucMgtE0sJhQN5nCd/xXg
	 pfsQcMfY20i3VSssUgRspPfZf7mwFljT1V4F/R2NuazOsfB+10WXbnGXDJP2rL8RBf
	 CxMg7+e79+Bm5QipNznBLCyU1gEBkD1vepiYSVzosR2R+Dbs/UBHWr00fEXhzuGZs3
	 myzYX3HxLhLGw==
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
Subject: [PATCH AUTOSEL 5.10 27/28] drm/amdgpu: Let KFD sync with VM fences
Date: Mon, 22 Jan 2024 10:14:53 -0500
Message-ID: <20240122151521.996443-27-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151521.996443-1-sashal@kernel.org>
References: <20240122151521.996443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
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
index 8ea6c49529e7..6a22bc41c205 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
@@ -241,7 +241,8 @@ int amdgpu_sync_resv(struct amdgpu_device *adev, struct amdgpu_sync *sync,
 
 		/* Never sync to VM updates either. */
 		if (fence_owner == AMDGPU_FENCE_OWNER_VM &&
-		    owner != AMDGPU_FENCE_OWNER_UNDEFINED)
+		    owner != AMDGPU_FENCE_OWNER_UNDEFINED &&
+	    owner != AMDGPU_FENCE_OWNER_KFD)
 			continue;
 
 		/* Ignore fences depending on the sync mode */
-- 
2.43.0



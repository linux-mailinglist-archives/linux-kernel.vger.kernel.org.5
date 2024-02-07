Return-Path: <linux-kernel+bounces-57089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5AD84D3EF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B540AB22B2B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60AD1386AE;
	Wed,  7 Feb 2024 21:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F97xpn3s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251521384B9;
	Wed,  7 Feb 2024 21:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340950; cv=none; b=QS5lUd8Fozuh/kfhlJ9zK+BMz/p7PccU7nqi1mm2UDopspSpleLQjOdV5XNN/yNo3Rb6Cbo1Soc4qPRMyR/dfP4cI1j06bU6Tm01VtCTjXF1oAaD1xx5cwVM/28QBHLzKv94HSiL4IiCvdN62Z8rLFsinZXnKxD2drH5bvXAel4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340950; c=relaxed/simple;
	bh=Rvq5RqfGg6LJ+Ejc2gITfRUd2FPM+YREG1dp/Y9t//8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DVX3zJsy5Wl4wL6eZFt6W/7dE9digujTvmFBoMhfSu0YA9n5TP9oyjUC34QNv61RG0cH50SmCUCMR8zpl0DhvkgfRSAsSxqZQAyLeeGEdULU31iT+AVsZYH+ML1auUY36zSbN8gAiuU0NuRixaADr4WwzsEiGPQ1mLpGssePt8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F97xpn3s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A1CC43399;
	Wed,  7 Feb 2024 21:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707340950;
	bh=Rvq5RqfGg6LJ+Ejc2gITfRUd2FPM+YREG1dp/Y9t//8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F97xpn3svbg2b1PE4n7ku2I9fmW8nlVgLPvUI6H0DVTUh5/eJtUPbMHDgQUT2lzds
	 JQSFqN+Pfd4DSZAtClVxXtlaxgJoW6BZoCl5aVJowphCaZdYbg+6kg4C8dAlG6ahJE
	 IeWoIGKMjt1OSGwCTg6Nx3TntUzH9HJtUlkM/1NA8RsgIlnyxd2Dw0xOOIy0iE0pZG
	 4UvSUKiHE1lPzS+G2IT4mtdAuYi07jJzYs2yX4EpxB6GO3auUVDqnnRxT9//VyJAsn
	 2j0ERYHfuKDVa2XUIfs+jNJvzvuiKOdKarVrQzJ8vXu0hUKr0qToj0Oo8rWYz4y2Zl
	 E3iLo7cnh5CmQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mukul Joshi <mukul.joshi@amd.com>,
	Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Felix.Kuehling@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.7 24/44] drm/amdkfd: Use correct drm device for cgroup permission check
Date: Wed,  7 Feb 2024 16:20:51 -0500
Message-ID: <20240207212142.1399-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212142.1399-1-sashal@kernel.org>
References: <20240207212142.1399-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
Content-Transfer-Encoding: 8bit

From: Mukul Joshi <mukul.joshi@amd.com>

[ Upstream commit 4119734e06a7f30e7e8eb666692a58b85dca0269 ]

On GFX 9.4.3, for a given KFD node, fetch the correct drm device from
XCP manager when checking for cgroup permissions.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 28162bfbe1b3..71445ab63b5e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1482,10 +1482,15 @@ void kfd_dec_compute_active(struct kfd_node *dev);
 
 /* Cgroup Support */
 /* Check with device cgroup if @kfd device is accessible */
-static inline int kfd_devcgroup_check_permission(struct kfd_node *kfd)
+static inline int kfd_devcgroup_check_permission(struct kfd_node *node)
 {
 #if defined(CONFIG_CGROUP_DEVICE) || defined(CONFIG_CGROUP_BPF)
-	struct drm_device *ddev = adev_to_drm(kfd->adev);
+	struct drm_device *ddev;
+
+	if (node->xcp)
+		ddev = node->xcp->ddev;
+	else
+		ddev = adev_to_drm(node->adev);
 
 	return devcgroup_check_permission(DEVCG_DEV_CHAR, DRM_MAJOR,
 					  ddev->render->index,
-- 
2.43.0



Return-Path: <linux-kernel+bounces-134453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D1A89B1AD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796441F2354E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FCD8594B;
	Sun,  7 Apr 2024 13:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqzSLplr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BEB8592A;
	Sun,  7 Apr 2024 13:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495583; cv=none; b=Knok7/eFyMWu0Drkcxw9ytdPb7FJLEbWMcXsOo3TtlVcUnXiVblj65F1bHXrMtbOUbszy1MT2F2m9VngiKqVT+4Wp+Lb75kvgZjqmYa1u6TDLlFR147N8fmfn2WlZSfzBlbrTYya7piSTueJ/jmyRzkO710bFEtZYsFmD5j//bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495583; c=relaxed/simple;
	bh=GLAH2LmuRG4mp/cT4VOWjb/Q9AKIBFugEsbPjbE8YJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/abxK5TDce5QFOcc5bPSgWvS+69lD/vRj+42ky4XcrDQPFm5w+4b7HGX2Qajfyn8dMWOCgCZMN2WR0cJvuqR7x60OCrHJQ0sUC5m301SJ1s5rVLK6hIOE7Moaskc3gEIu4Q1HM1WSTBVHLno/E54z/GtvculwbPncDbqBrBcvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqzSLplr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD18C433C7;
	Sun,  7 Apr 2024 13:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495582;
	bh=GLAH2LmuRG4mp/cT4VOWjb/Q9AKIBFugEsbPjbE8YJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LqzSLplruMMqqpRi3UPcZVRu7k2iWYnQpwwvCi4N/M9OXLA37fi5BW6kYZJ4+Hpiq
	 54cRHdt7mJ4UytsWA9f1JPSP++m+ZTPNfWthgo7bdHVkLSqk5pOjF2Z6d14bDHLURC
	 ERLl4yw+JATcjzdrDKKIywB4p42gY8ZD4s+GwiEa6PE0Jz1IuftqkLaXX2Y9mtJDWz
	 NMVOJbvMky6cDXUpQvqrDhVlMq4l1gdlwACEmgrnRXpLim80+JnSus7/cFoIxOvWBd
	 dEUz+hC/5AJy+gJNLY0EUww9Ue+jxFWnEb/2pF/xzp8x2tTVPbTNslDwWUdbPd4Eqi
	 HCX3ON4k/48Aw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mukul Joshi <mukul.joshi@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Felix.Kuehling@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 18/22] drm/amdkfd: Check cgroup when returning DMABuf info
Date: Sun,  7 Apr 2024 09:12:17 -0400
Message-ID: <20240407131231.1051652-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131231.1051652-1-sashal@kernel.org>
References: <20240407131231.1051652-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.25
Content-Transfer-Encoding: 8bit

From: Mukul Joshi <mukul.joshi@amd.com>

[ Upstream commit 9d7993a7ab9651afd5fb295a4992e511b2b727aa ]

Check cgroup permissions when returning DMA-buf info and
based on cgroup info return the GPU id of the GPU that have
access to the BO.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index c37f1fcd2165b..c7933d7d11b10 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1516,7 +1516,7 @@ static int kfd_ioctl_get_dmabuf_info(struct file *filep,
 
 	/* Find a KFD GPU device that supports the get_dmabuf_info query */
 	for (i = 0; kfd_topology_enum_kfd_devices(i, &dev) == 0; i++)
-		if (dev)
+		if (dev && !kfd_devcgroup_check_permission(dev))
 			break;
 	if (!dev)
 		return -EINVAL;
@@ -1538,7 +1538,7 @@ static int kfd_ioctl_get_dmabuf_info(struct file *filep,
 	if (xcp_id >= 0)
 		args->gpu_id = dmabuf_adev->kfd.dev->nodes[xcp_id]->id;
 	else
-		args->gpu_id = dmabuf_adev->kfd.dev->nodes[0]->id;
+		args->gpu_id = dev->id;
 	args->flags = flags;
 
 	/* Copy metadata buffer to user mode */
-- 
2.43.0



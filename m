Return-Path: <linux-kernel+bounces-134430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E423689B164
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 694A0B2122E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C1D3B289;
	Sun,  7 Apr 2024 13:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I962Q8yr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8E76A8BE;
	Sun,  7 Apr 2024 13:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495525; cv=none; b=aSQVl128hV2rlDS2LmgMOSnARcyO+NYKsIOb/PPmNB+uadlsfVdpbiru+x7T46h2zQSTK/3YgDKk4rUOZyjeaEBhIYEOzTirRXUL0VuKTvNHgoE3jKmhHzCBfNRHu7OW60CdkXfxvdM/6t6n6YvN7UbIwO8rV2khhF2g5hvieDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495525; c=relaxed/simple;
	bh=dRchvoO2syoNRVVAjgj+vST9WW44gcdsEwYNqJsk+Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QrWlZm5JUrM3WX3DOOhzkygILgnlY2TjKF1WCEUIqFJU5CjmBZ1RusCCsveJUfuTPw9tHVrC7POpskddYQEyORQSV/fuKs4aVCPnC7HC6GsZm2TgKhuqFSROE/xH5xDvGAoPH8KDN0TtNS7/mCL3b//cAP2GnQEtuMLMSQEwl3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I962Q8yr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28208C433F1;
	Sun,  7 Apr 2024 13:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495525;
	bh=dRchvoO2syoNRVVAjgj+vST9WW44gcdsEwYNqJsk+Cs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I962Q8yr79kAQb89XjSGhPpDZwFWEq9P4Z5U4Sp/XGaTiLd0WA2w38G4quBx4cSNG
	 YtUxLNibKlgm8nZ4CTW9s050mzqb9XuNbQ106tHiUBqDyGN9Wxk73Ucg7je1n3TUzz
	 oHtb2oNTTn84F/Esr3pfU5GuLpA2VJjnPVhTVUWceHQnditcQul4AZIzz/kW2Hyi9m
	 8nrCovWNgMi4R1vhISGJVhMEDvO1fFi+jHp1iKvfjrGBWy74uKg59hMR58y4fKv1Oj
	 RkI8GrcDECxLpl4+14Qt9Lu23kF0cF77JDD9jO4N/8Xs2xlItpfRtg3GSvuY2g29GR
	 nx/dmYzNlOx2g==
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
Subject: [PATCH AUTOSEL 6.8 20/25] drm/amdkfd: Check cgroup when returning DMABuf info
Date: Sun,  7 Apr 2024 09:11:08 -0400
Message-ID: <20240407131130.1050321-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131130.1050321-1-sashal@kernel.org>
References: <20240407131130.1050321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.4
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
index 80e90fdef291d..9a88b35cd8966 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1522,7 +1522,7 @@ static int kfd_ioctl_get_dmabuf_info(struct file *filep,
 
 	/* Find a KFD GPU device that supports the get_dmabuf_info query */
 	for (i = 0; kfd_topology_enum_kfd_devices(i, &dev) == 0; i++)
-		if (dev)
+		if (dev && !kfd_devcgroup_check_permission(dev))
 			break;
 	if (!dev)
 		return -EINVAL;
@@ -1544,7 +1544,7 @@ static int kfd_ioctl_get_dmabuf_info(struct file *filep,
 	if (xcp_id >= 0)
 		args->gpu_id = dmabuf_adev->kfd.dev->nodes[xcp_id]->id;
 	else
-		args->gpu_id = dmabuf_adev->kfd.dev->nodes[0]->id;
+		args->gpu_id = dev->id;
 	args->flags = flags;
 
 	/* Copy metadata buffer to user mode */
-- 
2.43.0



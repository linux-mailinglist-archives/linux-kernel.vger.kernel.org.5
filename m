Return-Path: <linux-kernel+bounces-154281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFC08ADA3C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3671B1C216F4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F91416E863;
	Mon, 22 Apr 2024 23:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5worMO2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5344346B80;
	Mon, 22 Apr 2024 23:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830217; cv=none; b=J9T/EecPIezs0sIWFANZGX4PBo0Gs24fzG7Wqa8kc63Qfz++GIJLs1I4GwwirpQCgM8V3d5iRrVSoHMZdUV37Qy7MK9zmMosGhkwloGd17Q8ZIVJvzKMq5BgcChiRzpcSeEJalPMfoxYdVG+hu3eC4VZq91cLF+OUz947SItK2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830217; c=relaxed/simple;
	bh=xGDyZcsvL01giqwU9B+2OU3WWvIKJ8Cs+d5IjoK078Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N7gvCEJJcOca1HhJx1JJoSNw5IgMy7BDJfR3Lw/m5GHVKQbG1RGj86GVbq/6nJqgpC2uNRCVgyqKyTxhzYPlhNnPneDMxpzLbGdLk+3Za9oua4npAo0rCP9UbiiOv8obpWi/TJCzHRZzS2SO0h5ZnGJBQbDXp0ZQfJ7PIxmGhM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5worMO2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE39C113CC;
	Mon, 22 Apr 2024 23:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830217;
	bh=xGDyZcsvL01giqwU9B+2OU3WWvIKJ8Cs+d5IjoK078Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I5worMO2j2zK1VU3q2j7VXHUubZ3gqXGV39O4BuTblmdY6Ag3982/0NwYeAec7Bre
	 eByIonWCJzmQByguyh8Qj5BA1xMnRGLP+sGukoUDhD9WQIqP2CEhFDOLzqY0mMpgy1
	 Rq+ScSzepM/EvConhUMWQsJAf9+WSsrJxo8zwwDDxpqwzGCXC5KqnNyHP6uIMx5ZAb
	 3znnBirr8HblRSauKv2OJp/k8SaCXNA/US/tQ8q5Bq8ZQW6m8tzONymUhPiOoSIh0a
	 jahE79PyZqkoxx81lFU8Sp00it9Uwg3F/EOQvmARSoNeJfyEiJMv3KHuq6UzfN57KM
	 LbGwRDwalIB4A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lijo Lazar <lijo.lazar@amd.com>,
	James Zhu <James.Zhu@amd.com>,
	Asad Kamal <asad.kamal@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Hawking.Zhang@amd.com,
	le.ma@amd.com,
	Philip.Yang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 20/29] drm/amdgpu: Fix VCN allocation in CPX partition
Date: Mon, 22 Apr 2024 19:17:01 -0400
Message-ID: <20240422231730.1601976-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231730.1601976-1-sashal@kernel.org>
References: <20240422231730.1601976-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.28
Content-Transfer-Encoding: 8bit

From: Lijo Lazar <lijo.lazar@amd.com>

[ Upstream commit f7e232de51bb1b45646e5b7dc4ebcf13510f2630 ]

VCN need not be shared in CPX mode always for all GFX 9.4.3 SOC SKUs. In
certain configs, VCN instance can be exclusively allocated to a
partition even under CPX mode.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index d0fc62784e821..0284c9198a04a 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -61,6 +61,11 @@ void aqua_vanjaram_doorbell_index_init(struct amdgpu_device *adev)
 	adev->doorbell_index.max_assignment = AMDGPU_DOORBELL_LAYOUT1_MAX_ASSIGNMENT << 1;
 }
 
+static bool aqua_vanjaram_xcp_vcn_shared(struct amdgpu_device *adev)
+{
+	return (adev->xcp_mgr->num_xcps > adev->vcn.num_vcn_inst);
+}
+
 static void aqua_vanjaram_set_xcp_id(struct amdgpu_device *adev,
 			     uint32_t inst_idx, struct amdgpu_ring *ring)
 {
@@ -86,7 +91,7 @@ static void aqua_vanjaram_set_xcp_id(struct amdgpu_device *adev,
 	case AMDGPU_RING_TYPE_VCN_ENC:
 	case AMDGPU_RING_TYPE_VCN_JPEG:
 		ip_blk = AMDGPU_XCP_VCN;
-		if (adev->xcp_mgr->mode == AMDGPU_CPX_PARTITION_MODE)
+		if (aqua_vanjaram_xcp_vcn_shared(adev))
 			inst_mask = 1 << (inst_idx * 2);
 		break;
 	default:
@@ -139,10 +144,12 @@ static int aqua_vanjaram_xcp_sched_list_update(
 
 		aqua_vanjaram_xcp_gpu_sched_update(adev, ring, ring->xcp_id);
 
-		/* VCN is shared by two partitions under CPX MODE */
+		/* VCN may be shared by two partitions under CPX MODE in certain
+		 * configs.
+		 */
 		if ((ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC ||
-			ring->funcs->type == AMDGPU_RING_TYPE_VCN_JPEG) &&
-			adev->xcp_mgr->mode == AMDGPU_CPX_PARTITION_MODE)
+		     ring->funcs->type == AMDGPU_RING_TYPE_VCN_JPEG) &&
+		    aqua_vanjaram_xcp_vcn_shared(adev))
 			aqua_vanjaram_xcp_gpu_sched_update(adev, ring, ring->xcp_id + 1);
 	}
 
-- 
2.43.0



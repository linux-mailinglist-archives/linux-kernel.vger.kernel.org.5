Return-Path: <linux-kernel+bounces-154250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0158AD9E4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68CC01F214E7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5842615AABA;
	Mon, 22 Apr 2024 23:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CatXjEky"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B61155726;
	Mon, 22 Apr 2024 23:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830126; cv=none; b=IpbU+4N3tesTIyUijpLozRCAFOF9pFYa8sjD0v4EnPJ4toh2ZWFheYhla7bqqSRBjQIaVpMAMo5aH0U3BY44fRVnIkGyc3nECE/swLKf8DKLI/3hHM17XypEOyPvMsGYo16MEuD/BNMtzMj+uH2Py0AOwKVPBHVFcGXQi74KNRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830126; c=relaxed/simple;
	bh=lnvIOJj/IGMQDafBUv1yF33TZxFbdiH9DMsFoH1973E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PkC1cEi80rq7qVz7SVoyG0Q/o5s7EAposEMOqXGXlzya4twGaPpCPJCTIgebD4kDQUjF6s+CssrWewMRvvnXW9aaG8mJtdLUzxPKA2/EsUVYY2MKtxdxRyRVNEkALuf9yRJdpSoYUtcAQR7qyiKi7n6T5zM1iPxX5NfCY2154Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CatXjEky; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7CD7C113CC;
	Mon, 22 Apr 2024 23:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830125;
	bh=lnvIOJj/IGMQDafBUv1yF33TZxFbdiH9DMsFoH1973E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CatXjEkyKT8/nWoBp4BU1MkY+LdsZwk+P6UjUlie2MYG3ZRHq6nwNRKDasz0zxEg1
	 xSoz9v1CzxRAeKjQgGeg5gXmlw7NVmiSPDW7Eb9K4oc05N2ZydQ0kSVQ786ODxzFgf
	 z+OeUbNX2yXVt12p2/ou+FQeJZq1nnk3Y6hQmm6o4CQqa2H/+PgE6sstFKgjcTrDqn
	 2JolQTUWy1G1bHITrRm6R8+j7KP5Yw4B7Zalo0P3v4l64rKPo9/AGOg954/ANu79kk
	 2HBCxL1iI/jZPdwqwGZKMgEm9PVRkaAjuydFqzctyT3dWdzdmtpFcy0ycLIHzmdA9B
	 MYE/ebZk8OnkQ==
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
Subject: [PATCH AUTOSEL 6.8 32/43] drm/amdgpu: Fix VCN allocation in CPX partition
Date: Mon, 22 Apr 2024 19:14:18 -0400
Message-ID: <20240422231521.1592991-32-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231521.1592991-1-sashal@kernel.org>
References: <20240422231521.1592991-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.7
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
index d6f808acfb17b..fbb43ae7624f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -62,6 +62,11 @@ void aqua_vanjaram_doorbell_index_init(struct amdgpu_device *adev)
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
@@ -87,7 +92,7 @@ static void aqua_vanjaram_set_xcp_id(struct amdgpu_device *adev,
 	case AMDGPU_RING_TYPE_VCN_ENC:
 	case AMDGPU_RING_TYPE_VCN_JPEG:
 		ip_blk = AMDGPU_XCP_VCN;
-		if (adev->xcp_mgr->mode == AMDGPU_CPX_PARTITION_MODE)
+		if (aqua_vanjaram_xcp_vcn_shared(adev))
 			inst_mask = 1 << (inst_idx * 2);
 		break;
 	default:
@@ -140,10 +145,12 @@ static int aqua_vanjaram_xcp_sched_list_update(
 
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



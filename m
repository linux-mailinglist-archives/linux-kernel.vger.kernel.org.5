Return-Path: <linux-kernel+bounces-113832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD0B889060
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8AFCB23AE1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387411E7E1E;
	Sun, 24 Mar 2024 23:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnC697HX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B33129A71;
	Sun, 24 Mar 2024 22:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320872; cv=none; b=YodrcYZoWwEpbzpEiUaaak5j7qvkCB5hdGYvW31LxDcNQq7XWmV7QHREBNzd2yvDAIYC7rY3D+JYI659cDfvEYY3+UY0Z9X129qsdF10H4M6c9rO9S95IyoUBFCJp8ilKPX/B5f8eAvzpyy7evE+keo3b19NHSOA32X580qDpUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320872; c=relaxed/simple;
	bh=FeJ7rRD6Pl0PL3JQV059ZhHkAnbDL0udLtd1lvou/3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OjPiagzbgOsOZu2BNC3fRt47O52mz9E9uXjqgCpo4+S7ntFoOE7f9vDnyakjTSf/kjXwvfNiua4doKd5+DP/NdpwCwJ60E+FfaI5jEN0QgHDg5E8io9vD+BdsZpgdnpUcHIVfnIMlesMA4OcIM+4dpuY4OZzi89/WyuGP+9NPhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnC697HX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63AF8C433C7;
	Sun, 24 Mar 2024 22:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320871;
	bh=FeJ7rRD6Pl0PL3JQV059ZhHkAnbDL0udLtd1lvou/3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BnC697HXP0zQzFugApuUW4fQ+xzTH5q6mSyvrIZgjfxdQv/m5tbZg30YJZy1DQrn1
	 FpfgcEgqsKOWOI9vKVkDsdzoF5DZDCzS0npPC27qCV1wsUS5ncQx44GoCao1738YO2
	 P/egCdzSeb+XlWHUvb0uafLi5BUquPwPKKRzzXwch/FEbbraiA2vmBCyYUCaIbOavP
	 XfBrhwiADIgT8WgkTcLWEKdC8wVGtTMeWdKvpCmgAOH3L+WXCNfIeFmeqkkR0uXgli
	 8Oq/GvcREgWxVLOkJVo3X3AuvdLtCqZ93khEQwXWphOcpGWXRLEOdqx5N7Zx0h/yde
	 zFHDNJ10Iipjg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 435/713] drm/amdgpu: Fix potential out-of-bounds access in 'amdgpu_discovery_reg_base_init()'
Date: Sun, 24 Mar 2024 18:42:41 -0400
Message-ID: <20240324224720.1345309-436-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit cdb637d339572398821204a1142d8d615668f1e9 ]

The issue arises when the array 'adev->vcn.vcn_config' is accessed
before checking if the index 'adev->vcn.num_vcn_inst' is within the
bounds of the array.

The fix involves moving the bounds check before the array access. This
ensures that 'adev->vcn.num_vcn_inst' is within the bounds of the array
before it is used as an index.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1289 amdgpu_discovery_reg_base_init() error: testing array offset 'adev->vcn.num_vcn_inst' after use.

Fixes: a0ccc717c4ab ("drm/amdgpu/discovery: validate VCN and SDMA instances")
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index c7d60dd0fb975..4f9900779ef9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1278,11 +1278,10 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 				 *     0b10 : encode is disabled
 				 *     0b01 : decode is disabled
 				 */
-				adev->vcn.vcn_config[adev->vcn.num_vcn_inst] =
-					ip->revision & 0xc0;
-				ip->revision &= ~0xc0;
 				if (adev->vcn.num_vcn_inst <
 				    AMDGPU_MAX_VCN_INSTANCES) {
+					adev->vcn.vcn_config[adev->vcn.num_vcn_inst] =
+						ip->revision & 0xc0;
 					adev->vcn.num_vcn_inst++;
 					adev->vcn.inst_mask |=
 						(1U << ip->instance_number);
@@ -1293,6 +1292,7 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 						adev->vcn.num_vcn_inst + 1,
 						AMDGPU_MAX_VCN_INSTANCES);
 				}
+				ip->revision &= ~0xc0;
 			}
 			if (le16_to_cpu(ip->hw_id) == SDMA0_HWID ||
 			    le16_to_cpu(ip->hw_id) == SDMA1_HWID ||
-- 
2.43.0



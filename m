Return-Path: <linux-kernel+bounces-114287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BD4889152
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D66EB28465
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320C515F316;
	Sun, 24 Mar 2024 23:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWhS1YSF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F22139583;
	Sun, 24 Mar 2024 23:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321660; cv=none; b=m1PLdSAT5TYqZLJ3T5+UIgX4byjU8RWOuW9M/fGRGGnnQjhpfTx1Rz6qVOlHJxZnw0A7n7VTmj7uEj5E70D7ytPCZNXkoITllm5axTu064zFlh3vXc+1mbYZvGkyQV8qwG4qvrtuN3hATZRDx1wDrT0o1PQgVlQEkwBjMmqPx2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321660; c=relaxed/simple;
	bh=Im9MdAn3zB5baA9s6UZLRIj7YY+4qsbhCeNDLOZHoFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kqeSU5PDfvgKNC8dT7CtiLjBGUqUAzJbngikIkR5HO9iI/qEYCAsEY++h2mGTv2RlJJDNkRw0C6gFaWst0yy+eAJxJc9ZMLDGwjtsB0Zfjly3q9+IkvKQEgxuWA/ZQpvgiqYzMowa3/6XFXk3EM2OxWXCUUDbHlyevw0caHHS28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWhS1YSF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AFECC433F1;
	Sun, 24 Mar 2024 23:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321659;
	bh=Im9MdAn3zB5baA9s6UZLRIj7YY+4qsbhCeNDLOZHoFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aWhS1YSF6YxzPnmPJ6o3+A/w1im9rlL6qlzqNKnGwTD/11JFDAqUk8c9XOghvfBS+
	 y79JWDRnoA9c6JoDDa9vpUUpSfAYjc++KXpgiYtOoywy/QmhRbO9E2Oe93SLC1/gI2
	 QwbH312joaQvUmafd5F7wn2lmxaLtciPoTb6/9z8uGBVSA/TCA44T8ecKEbHn1Ti5r
	 kvVHY1XK9O+gTn30yEIpbjw+lEbadXGQaZkrBexRuss69lGRoWCnV0TDidA5IKcPt8
	 bLGBboMAZTwAP2uSu19vcMIUBHD/AXG4ND3Nbs8Z3/8CnOhT4JjQolCR0+Kaa4zdeb
	 l04MsG4FbJedQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 388/638] drm/amdgpu: Fix potential out-of-bounds access in 'amdgpu_discovery_reg_base_init()'
Date: Sun, 24 Mar 2024 18:57:05 -0400
Message-ID: <20240324230116.1348576-389-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 68a901287264f..cf2faeae1d0db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1270,11 +1270,10 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
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
@@ -1285,6 +1284,7 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 						adev->vcn.num_vcn_inst + 1,
 						AMDGPU_MAX_VCN_INSTANCES);
 				}
+				ip->revision &= ~0xc0;
 			}
 			if (le16_to_cpu(ip->hw_id) == SDMA0_HWID ||
 			    le16_to_cpu(ip->hw_id) == SDMA1_HWID ||
-- 
2.43.0



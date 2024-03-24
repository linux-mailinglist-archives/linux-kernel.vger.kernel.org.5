Return-Path: <linux-kernel+bounces-113293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD4E88832B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55214284265
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C956BB45;
	Sun, 24 Mar 2024 22:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRyxv8lW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CDE18EFA6;
	Sun, 24 Mar 2024 22:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320094; cv=none; b=DmwKD12U/vdQYXwQ/+buUuBF3YjBOgtIZF/sVpeYm2X4rVYVlmkjKpy8fU6lVgRto2Wrce08RQWbGe+fCJoPYkOrHqvMcINNfs8fi5T4t66WVkZWDQJm5y0dgMZnQ9IUdnjSHGvWQO045r5JO4r6iOxoWNkoLzRJIiO+7caei6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320094; c=relaxed/simple;
	bh=FeJ7rRD6Pl0PL3JQV059ZhHkAnbDL0udLtd1lvou/3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G8xVZYaSAE9s1ZRzS0yrkujF21tqlnpFXaCEqclY+ESz37gfzX3iT5ys0wCIbvVmouLIi1ygG1kgBb2Zd9dlNdL+0/EuBa+5n2WWwACy1iYJTP8LC9ndEXs5vqkYz05Nt0SOyyuCt1SrX9B0D2REMmmgsrPvNPTrpP3LJvQ6xUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRyxv8lW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3EDC433C7;
	Sun, 24 Mar 2024 22:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320093;
	bh=FeJ7rRD6Pl0PL3JQV059ZhHkAnbDL0udLtd1lvou/3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IRyxv8lWTraWrzizgJSp2x2af/I01cMFYA0j3UZNsT0LOq+cN8MEC1fFE/JvXCyY/
	 5HKM1yHf0SoxWacsmdVE4cXN85vRUX4XMYfGspvHmr8HcivUmX5Krde+WRgEoeoZXE
	 A9dABchx8AluYJUrcq2b0iBOPfW2mNOFfNz5jEYILWUsNviV++FsZIL3lWlCce8ZX0
	 bjRG4Glau1kNNqaNOpJ7lfGU9h/KIuXnRFs8lmTGlgMyeZCEQ3J9pva0g9gFsrBfG2
	 90rmaV1F7k7KMz/6YAlDk3xW20KWx2C+mbU/KL2SZUBLWbKtJ/MZlNWUyR9i5FvpmT
	 X7mjMYHUP7/dA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 402/715] drm/amdgpu: Fix potential out-of-bounds access in 'amdgpu_discovery_reg_base_init()'
Date: Sun, 24 Mar 2024 18:29:41 -0400
Message-ID: <20240324223455.1342824-403-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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



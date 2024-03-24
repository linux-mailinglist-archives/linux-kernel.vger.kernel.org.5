Return-Path: <linux-kernel+bounces-114352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E90818889F5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2671C1C28598
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32C4172773;
	Sun, 24 Mar 2024 23:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLGzaQ05"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4766214874;
	Sun, 24 Mar 2024 23:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321741; cv=none; b=tGpy5WBdzf0d+Kj1BY6VuHOrBeFBdFcyW3Yd+7MFUbo2wHwpFOeC/kiun1F82bntHJv9LYTPQIiCfhS2gRXpNvjgSzluRJOVNSLwd9guefCJmzPmZsmEzWZJBbEZYjhgT+NAqriQ+NhHW4unu+wUWQImHYgWeuj6yWnUl7B43b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321741; c=relaxed/simple;
	bh=psJ3irOLYH25g8K1Sd101K+gyJfjpXuJRvWkmQfSqCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJ7IIgbn0NU5aujslbg5WkRZpfbGjAf69QCm9v7pcc7xuZPJEO84stxHETO0UY7pbfZnKicpZuFD6SbfamX52dORfNsuR5G/j0ynJz88sYUCFQ4RIp9UurPdb6SihG+4V9Wt1Wqe3JzJkPTgvn3sobTOkByGaCZ5qsm8T+Yhw1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLGzaQ05; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8231C433F1;
	Sun, 24 Mar 2024 23:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321741;
	bh=psJ3irOLYH25g8K1Sd101K+gyJfjpXuJRvWkmQfSqCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pLGzaQ05M3tM0EWCS32H+/1HUz+iUgKLfUhQlwI2kO0F131u8Z/AIJYNYKLpbTgq8
	 ud/jpBV7i+M+86wgsGPRvyMyi+EY29HjOmh8v6c9IXz/JiUS8z7CPD1VCm698etJmI
	 Y0yu8hPkdBFz1z5nuVjI2XTwbUe4X3ziBKsWS5BsUgqIK3WC6nfi5+eXJTIqzckorw
	 Asxfwgp71Jaln7m6naiFb7mqTb0hECCnGfp5h02GcmuJInABAhzGhXHSeTeuPbNcHB
	 oeyb7Wm28Re+lK3Li1x/5PnX7vBB3Xh7YwdUYCSw/KLcEPc5AVbzzZ1wQj5tnuHZk1
	 tkVeS+Q3iDjkw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Asad Kamal <asad.kamal@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Le Ma <le.ma@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 469/638] drm/amd/pm: Fix esm reg mask use to get pcie speed
Date: Sun, 24 Mar 2024 18:58:26 -0400
Message-ID: <20240324230116.1348576-470-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Asad Kamal <asad.kamal@amd.com>

[ Upstream commit b485b899e5b8f83723833feca30a1a1e3df778df ]

Fix mask used for esm ctrl register to get pcie link
speed on smu_v11_0_3, smu_v13_0_2 & smu_v13_0_6

Fixes: 511a95552ec8 ("drm/amd/pm: Add SMU 13.0.6 support")
Fixes: c05d1c401572 ("drm/amd/swsmu: add aldebaran smu13 ip support (v3)")
Fixes: f1c378593153 ("drm/amd/powerplay: add Arcturus support for gpu metrics export")
Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c    | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c   | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 704a2b577a0e2..4c58c2cd26d88 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2356,8 +2356,8 @@ static uint16_t arcturus_get_current_pcie_link_speed(struct smu_context *smu)
 
 	/* TODO: confirm this on real target */
 	esm_ctrl = RREG32_PCIE(smnPCIE_ESM_CTRL);
-	if ((esm_ctrl >> 15) & 0x1FFFF)
-		return (uint16_t)(((esm_ctrl >> 8) & 0x3F) + 128);
+	if ((esm_ctrl >> 15) & 0x1)
+		return (uint16_t)(((esm_ctrl >> 8) & 0x7F) + 128);
 
 	return smu_v11_0_get_current_pcie_link_speed(smu);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 08fff9600bd29..5afd03e42bbfc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1720,8 +1720,8 @@ static int aldebaran_get_current_pcie_link_speed(struct smu_context *smu)
 
 	/* TODO: confirm this on real target */
 	esm_ctrl = RREG32_PCIE(smnPCIE_ESM_CTRL);
-	if ((esm_ctrl >> 15) & 0x1FFFF)
-		return (((esm_ctrl >> 8) & 0x3F) + 128);
+	if ((esm_ctrl >> 15) & 0x1)
+		return (((esm_ctrl >> 8) & 0x7F) + 128);
 
 	return smu_v13_0_get_current_pcie_link_speed(smu);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 24d6811438c5c..6a28f8d5bff7d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1941,8 +1941,8 @@ static int smu_v13_0_6_get_current_pcie_link_speed(struct smu_context *smu)
 
 	/* TODO: confirm this on real target */
 	esm_ctrl = RREG32_PCIE(smnPCIE_ESM_CTRL);
-	if ((esm_ctrl >> 15) & 0x1FFFF)
-		return (((esm_ctrl >> 8) & 0x3F) + 128);
+	if ((esm_ctrl >> 15) & 0x1)
+		return (((esm_ctrl >> 8) & 0x7F) + 128);
 
 	speed_level = (RREG32_PCIE(smnPCIE_LC_SPEED_CNTL) &
 		PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK)
-- 
2.43.0



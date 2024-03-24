Return-Path: <linux-kernel+bounces-113387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 121DC8883EC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF8AF28330F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85C11A1A56;
	Sun, 24 Mar 2024 22:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQmGjhFQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E576F069;
	Sun, 24 Mar 2024 22:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320189; cv=none; b=GHD0VRU9iwV7xb0mf1+EgodRTOCcwFhcO9EM1ca6pENig+heCQ/eRs1LbG+mJeskK1+1mEEc0SRtK9lugq0IImqtoWY8x4boq2Uq2BtY8RY9s6LRiJcHZevu42QGsm31TQCguA2Vp3Gtq3KKX6Ck/feZZfh2sr2zg3SkjtRske4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320189; c=relaxed/simple;
	bh=okEQuZP1sVnZKuW4XEr/n2UmKDYtlMnxJ+hncEvAIqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UxeLuGoA3Bn/RiJ5KoQ/bsBkxE+HcxWdt3THERQeXqWAyLRDOvSK5U2mBIrbMitQNM4suiM3Bqff0uiO3a8dIeZL4IQkKGbBfNEqhzjPoA6ixqPdRXapSRxJw6EbJIzyFB6Di2+jmk5UvB2Hmu4hciC8gszQ8TvWLTBD+GkHun0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQmGjhFQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238C3C43399;
	Sun, 24 Mar 2024 22:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320188;
	bh=okEQuZP1sVnZKuW4XEr/n2UmKDYtlMnxJ+hncEvAIqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BQmGjhFQJu85jlvisklh6j4fVZLtSUfqXWIiq5SPY+F72M08Xd2AuNZVib331iRRe
	 UoLycUH30uoEgdGRs1zUAaTkrYN305ohBNj4ER+e0XpKW91avSRIqGBWplL4Q5EjVY
	 D8F7zSn3xIe37aZF/CVzY25hLntaJUU9Fl3rA6y6tDKspOuwkop9kyvDTx2G4Dj5s1
	 n55fUWPwlcqKMyA4+6qvJUGC/H/0nW04WRA2SHaBLRp7R77U9RSfn02U8/CxiV18n7
	 CE3lVRZRwHRszeuU/Iv8MEtFwInSF0s01ooyi6fsU1naNYzhbRs84Cx/cHISRfFF8L
	 9pyqiMRW2+qXw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Asad Kamal <asad.kamal@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Le Ma <le.ma@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 496/715] drm/amd/pm: Fix esm reg mask use to get pcie speed
Date: Sun, 24 Mar 2024 18:31:15 -0400
Message-ID: <20240324223455.1342824-497-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index bcad42534da46..1d96eb274d72d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2272,8 +2272,8 @@ static uint16_t arcturus_get_current_pcie_link_speed(struct smu_context *smu)
 
 	/* TODO: confirm this on real target */
 	esm_ctrl = RREG32_PCIE(smnPCIE_ESM_CTRL);
-	if ((esm_ctrl >> 15) & 0x1FFFF)
-		return (uint16_t)(((esm_ctrl >> 8) & 0x3F) + 128);
+	if ((esm_ctrl >> 15) & 0x1)
+		return (uint16_t)(((esm_ctrl >> 8) & 0x7F) + 128);
 
 	return smu_v11_0_get_current_pcie_link_speed(smu);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index dd9bcbd630a1f..ca0d5a5b204ad 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1682,8 +1682,8 @@ static int aldebaran_get_current_pcie_link_speed(struct smu_context *smu)
 
 	/* TODO: confirm this on real target */
 	esm_ctrl = RREG32_PCIE(smnPCIE_ESM_CTRL);
-	if ((esm_ctrl >> 15) & 0x1FFFF)
-		return (((esm_ctrl >> 8) & 0x3F) + 128);
+	if ((esm_ctrl >> 15) & 0x1)
+		return (((esm_ctrl >> 8) & 0x7F) + 128);
 
 	return smu_v13_0_get_current_pcie_link_speed(smu);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 7e1941cf17964..78491b04df108 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2060,8 +2060,8 @@ static int smu_v13_0_6_get_current_pcie_link_speed(struct smu_context *smu)
 
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



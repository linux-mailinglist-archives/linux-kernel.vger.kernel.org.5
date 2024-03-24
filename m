Return-Path: <linux-kernel+bounces-113890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8E7888729
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F70E1F2376A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC71513A253;
	Sun, 24 Mar 2024 23:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Acl3KsDM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63B512B15B;
	Sun, 24 Mar 2024 22:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320962; cv=none; b=uGueHB77eZ3oGyfDQAxNmck6Wpfx7mEmPlSsGxvusxcvOCL56dbwfK2o+M52JgBnN3/nA7VJTxyfQDaayT/6hblNjW+1cS91XI4BfnHLsb9ZlsjdPgpfbrA3vnrPaOAFwy6Xs2my2MFCqDf3t/6qvX6gGWgdK+fxINg531fgpEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320962; c=relaxed/simple;
	bh=JjgH1I0oTWSVJi2GNvGp8NWya61AQPlOKWV3OhQgtSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uYYqkoqI3IVqhlIed5moPJXTpq6Ja8WMaic9qnJxdH43ouEHelJLo7EkaNXDhDofVm3fy0Tn14ePyElH7kq/6MjfJcCmkQieGyHWVaBaJ5imAMh8I6jZOC4MlhsSd/gKbVJIsja5lBQVMYYXwFHkxOWfwck6VubWAKnvxcdO5r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Acl3KsDM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B315EC43390;
	Sun, 24 Mar 2024 22:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320961;
	bh=JjgH1I0oTWSVJi2GNvGp8NWya61AQPlOKWV3OhQgtSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Acl3KsDMC7wEsPiCw2dZzV7hgFiYGb70qDsN0Ac/qI0PZZZtjQ/eQax6nHxMf721H
	 jBiFdcNqkpDFL16vCe1b2vbZjrfWclZpQ8BbsUNfdiaSsyshZ+mw9KEavSVWwtcebj
	 eyTRiOa1Is9kuTqrcstLw3E3LG/IoJqqAu8FaGTT4E94aUyeZlvNzP9WfXO1+2OuEz
	 Ctb/K6mUGTeEshyC5sX91tp5qK/m6MMbCyN9msp2Std7a93H4wxj0fjp7bK2Z7Q6EZ
	 oL6bqI1KwbshAvRXLjyvikfa/7E42sQryf39HiyzNCPITMeX5qMgfP1V/Cqz9k8aBY
	 08LSjYlsdHH/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Asad Kamal <asad.kamal@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Le Ma <le.ma@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 524/713] drm/amd/pm: Fix esm reg mask use to get pcie speed
Date: Sun, 24 Mar 2024 18:44:10 -0400
Message-ID: <20240324224720.1345309-525-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index b9c5398cb986c..294a890beceb4 100644
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
index f1440869d1ce0..e3579a8fd7fcf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1683,8 +1683,8 @@ static int aldebaran_get_current_pcie_link_speed(struct smu_context *smu)
 
 	/* TODO: confirm this on real target */
 	esm_ctrl = RREG32_PCIE(smnPCIE_ESM_CTRL);
-	if ((esm_ctrl >> 15) & 0x1FFFF)
-		return (((esm_ctrl >> 8) & 0x3F) + 128);
+	if ((esm_ctrl >> 15) & 0x1)
+		return (((esm_ctrl >> 8) & 0x7F) + 128);
 
 	return smu_v13_0_get_current_pcie_link_speed(smu);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 8cd2b8cc3d58a..58f63b7a72cd9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2016,8 +2016,8 @@ static int smu_v13_0_6_get_current_pcie_link_speed(struct smu_context *smu)
 
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



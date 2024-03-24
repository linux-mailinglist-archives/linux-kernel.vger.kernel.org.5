Return-Path: <linux-kernel+bounces-114356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 130D48889FA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 448D51C2867A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A250317265E;
	Sun, 24 Mar 2024 23:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0QCSfgl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE0A1EEEF3;
	Sun, 24 Mar 2024 23:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321745; cv=none; b=Srlw7w9oFarplnMaMPjbjYrLtVHNUkbC/W/AL7SsV8RfnVcKMNUo4vUNbjGcZ6va2CcGdYfHqGdR6Zm3TQdC1Kd/3kP3g0CATLPkHiFwKT807GP01j/YMFKBSV6Gm2Pgd/8MCCvbzVo5b4EWcaDd3nwcelitgunB+hSwXwdNgus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321745; c=relaxed/simple;
	bh=/OkvdvR70NnVfY2Fr/0spMghmmbQzum0lIGGLUM9FCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PgsxlaclU/Na0e4kM2Jyyk/R59Riq/iRxwBhquMdLujQFcDjmnoD4+X4B9ILuUVdNqXzrP5f7RAb0TLDaAf+oevV2DUGwmX2Qfqds+ZcTmhExvNQeqJokBm7sS9IMMklXXL56AwA72hPnea4wUoHU1cbN32O+6PrpAxsdl6aB/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0QCSfgl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D04C43394;
	Sun, 24 Mar 2024 23:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321744;
	bh=/OkvdvR70NnVfY2Fr/0spMghmmbQzum0lIGGLUM9FCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E0QCSfglGrO1kaxJwjX5a3KM/z+oAtzPdZrnR8N/hUCGM7ciCELiWFgakmzaND/hL
	 eywijjfzV1iwy96XUspxQJaDUNekpoQtbJ4vmHqJIXTsWB1Q1s0miRbQkJxTPhDQLC
	 jRsJ9vprFYGYuJY3KLFTyRxd6SY/gcGAJZZuO5nvm1i0QW9KRFXO9hObWaWrM9zXqC
	 28QELGlBh/i2Vqs3ClrD8nB1M4Inv/FAs3Ebn6JjNr+gOoklXOj9zI5o7dxDo5hleO
	 yZMYCF4jNl840dX27JpjmuPTaqN941vkp2mgMZS8F1unT+HMt8xnS9bLr83zcEZBLR
	 WJX0H9AkpM4mQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maciej Strozek <mstrozek@opensource.cirrus.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 472/638] mfd: cs42l43: Fix wrong register defaults
Date: Sun, 24 Mar 2024 18:58:29 -0400
Message-ID: <20240324230116.1348576-473-sashal@kernel.org>
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

From: Maciej Strozek <mstrozek@opensource.cirrus.com>

[ Upstream commit c9e1e505cde1a8ddd0968b4d54ec2ea1937dfe00 ]

A few regs have unnecessary values in defaults, change them to match the
datasheet

Fixes: ace6d1448138 ("mfd: cs42l43: Add support for cs42l43 core driver")

Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20240229155616.118457-1-mstrozek@opensource.cirrus.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/cs42l43.c | 68 +++++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/mfd/cs42l43.c b/drivers/mfd/cs42l43.c
index 7b6d07cbe6fc6..73c88ee6a866c 100644
--- a/drivers/mfd/cs42l43.c
+++ b/drivers/mfd/cs42l43.c
@@ -131,38 +131,38 @@ const struct reg_default cs42l43_reg_default[CS42L43_N_DEFAULTS] = {
 	{ CS42L43_ASP_TX_CH4_CTRL,			0x00170091 },
 	{ CS42L43_ASP_TX_CH5_CTRL,			0x001700C1 },
 	{ CS42L43_ASP_TX_CH6_CTRL,			0x001700F1 },
-	{ CS42L43_ASPTX1_INPUT,				0x00800000 },
-	{ CS42L43_ASPTX2_INPUT,				0x00800000 },
-	{ CS42L43_ASPTX3_INPUT,				0x00800000 },
-	{ CS42L43_ASPTX4_INPUT,				0x00800000 },
-	{ CS42L43_ASPTX5_INPUT,				0x00800000 },
-	{ CS42L43_ASPTX6_INPUT,				0x00800000 },
-	{ CS42L43_SWIRE_DP1_CH1_INPUT,			0x00800000 },
-	{ CS42L43_SWIRE_DP1_CH2_INPUT,			0x00800000 },
-	{ CS42L43_SWIRE_DP1_CH3_INPUT,			0x00800000 },
-	{ CS42L43_SWIRE_DP1_CH4_INPUT,			0x00800000 },
-	{ CS42L43_SWIRE_DP2_CH1_INPUT,			0x00800000 },
-	{ CS42L43_SWIRE_DP2_CH2_INPUT,			0x00800000 },
-	{ CS42L43_SWIRE_DP3_CH1_INPUT,			0x00800000 },
-	{ CS42L43_SWIRE_DP3_CH2_INPUT,			0x00800000 },
-	{ CS42L43_SWIRE_DP4_CH1_INPUT,			0x00800000 },
-	{ CS42L43_SWIRE_DP4_CH2_INPUT,			0x00800000 },
-	{ CS42L43_ASRC_INT1_INPUT1,			0x00800000 },
-	{ CS42L43_ASRC_INT2_INPUT1,			0x00800000 },
-	{ CS42L43_ASRC_INT3_INPUT1,			0x00800000 },
-	{ CS42L43_ASRC_INT4_INPUT1,			0x00800000 },
-	{ CS42L43_ASRC_DEC1_INPUT1,			0x00800000 },
-	{ CS42L43_ASRC_DEC2_INPUT1,			0x00800000 },
-	{ CS42L43_ASRC_DEC3_INPUT1,			0x00800000 },
-	{ CS42L43_ASRC_DEC4_INPUT1,			0x00800000 },
-	{ CS42L43_ISRC1INT1_INPUT1,			0x00800000 },
-	{ CS42L43_ISRC1INT2_INPUT1,			0x00800000 },
-	{ CS42L43_ISRC1DEC1_INPUT1,			0x00800000 },
-	{ CS42L43_ISRC1DEC2_INPUT1,			0x00800000 },
-	{ CS42L43_ISRC2INT1_INPUT1,			0x00800000 },
-	{ CS42L43_ISRC2INT2_INPUT1,			0x00800000 },
-	{ CS42L43_ISRC2DEC1_INPUT1,			0x00800000 },
-	{ CS42L43_ISRC2DEC2_INPUT1,			0x00800000 },
+	{ CS42L43_ASPTX1_INPUT,				0x00000000 },
+	{ CS42L43_ASPTX2_INPUT,				0x00000000 },
+	{ CS42L43_ASPTX3_INPUT,				0x00000000 },
+	{ CS42L43_ASPTX4_INPUT,				0x00000000 },
+	{ CS42L43_ASPTX5_INPUT,				0x00000000 },
+	{ CS42L43_ASPTX6_INPUT,				0x00000000 },
+	{ CS42L43_SWIRE_DP1_CH1_INPUT,			0x00000000 },
+	{ CS42L43_SWIRE_DP1_CH2_INPUT,			0x00000000 },
+	{ CS42L43_SWIRE_DP1_CH3_INPUT,			0x00000000 },
+	{ CS42L43_SWIRE_DP1_CH4_INPUT,			0x00000000 },
+	{ CS42L43_SWIRE_DP2_CH1_INPUT,			0x00000000 },
+	{ CS42L43_SWIRE_DP2_CH2_INPUT,			0x00000000 },
+	{ CS42L43_SWIRE_DP3_CH1_INPUT,			0x00000000 },
+	{ CS42L43_SWIRE_DP3_CH2_INPUT,			0x00000000 },
+	{ CS42L43_SWIRE_DP4_CH1_INPUT,			0x00000000 },
+	{ CS42L43_SWIRE_DP4_CH2_INPUT,			0x00000000 },
+	{ CS42L43_ASRC_INT1_INPUT1,			0x00000000 },
+	{ CS42L43_ASRC_INT2_INPUT1,			0x00000000 },
+	{ CS42L43_ASRC_INT3_INPUT1,			0x00000000 },
+	{ CS42L43_ASRC_INT4_INPUT1,			0x00000000 },
+	{ CS42L43_ASRC_DEC1_INPUT1,			0x00000000 },
+	{ CS42L43_ASRC_DEC2_INPUT1,			0x00000000 },
+	{ CS42L43_ASRC_DEC3_INPUT1,			0x00000000 },
+	{ CS42L43_ASRC_DEC4_INPUT1,			0x00000000 },
+	{ CS42L43_ISRC1INT1_INPUT1,			0x00000000 },
+	{ CS42L43_ISRC1INT2_INPUT1,			0x00000000 },
+	{ CS42L43_ISRC1DEC1_INPUT1,			0x00000000 },
+	{ CS42L43_ISRC1DEC2_INPUT1,			0x00000000 },
+	{ CS42L43_ISRC2INT1_INPUT1,			0x00000000 },
+	{ CS42L43_ISRC2INT2_INPUT1,			0x00000000 },
+	{ CS42L43_ISRC2DEC1_INPUT1,			0x00000000 },
+	{ CS42L43_ISRC2DEC2_INPUT1,			0x00000000 },
 	{ CS42L43_EQ1MIX_INPUT1,			0x00800000 },
 	{ CS42L43_EQ1MIX_INPUT2,			0x00800000 },
 	{ CS42L43_EQ1MIX_INPUT3,			0x00800000 },
@@ -171,8 +171,8 @@ const struct reg_default cs42l43_reg_default[CS42L43_N_DEFAULTS] = {
 	{ CS42L43_EQ2MIX_INPUT2,			0x00800000 },
 	{ CS42L43_EQ2MIX_INPUT3,			0x00800000 },
 	{ CS42L43_EQ2MIX_INPUT4,			0x00800000 },
-	{ CS42L43_SPDIF1_INPUT1,			0x00800000 },
-	{ CS42L43_SPDIF2_INPUT1,			0x00800000 },
+	{ CS42L43_SPDIF1_INPUT1,			0x00000000 },
+	{ CS42L43_SPDIF2_INPUT1,			0x00000000 },
 	{ CS42L43_AMP1MIX_INPUT1,			0x00800000 },
 	{ CS42L43_AMP1MIX_INPUT2,			0x00800000 },
 	{ CS42L43_AMP1MIX_INPUT3,			0x00800000 },
-- 
2.43.0



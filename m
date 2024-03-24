Return-Path: <linux-kernel+bounces-115515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C882C889E46
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F44AB61F35
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2361F23C3E6;
	Mon, 25 Mar 2024 02:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMxp99Dn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815E612B157;
	Sun, 24 Mar 2024 22:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320965; cv=none; b=Bq+lglHnsu13q9BNVtek8Nkr7qDyNXIVBMsYfdFsNHBDvoHs2/68iOLXaHMK8Kv5LqvTACOfRxYxbkpL3EtCzcq6zdPkfbipw9T46j/UXSKxF52CdajzygI+wPkknGBjQ9P20vwjPKyMXT4iOFdddTInWrBgWSGfVltfgrjC0eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320965; c=relaxed/simple;
	bh=/OkvdvR70NnVfY2Fr/0spMghmmbQzum0lIGGLUM9FCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IWxQTaiVPb1adhOA7nZfoTIChBB00HLuEwvCjW57QraMBx5EH+RNnyzzkThmzlPDz6mB/BDBDapIwisah6a0gdFe2JVmaqzS+YG4Myx7rn596o1A4eGQqoy3jLRM3+dp0a6p75t9o4skKvvbjVsxpRDwhKWRwbEVrl+tsHh4ljo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMxp99Dn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DA8C43390;
	Sun, 24 Mar 2024 22:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320964;
	bh=/OkvdvR70NnVfY2Fr/0spMghmmbQzum0lIGGLUM9FCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kMxp99Dn1rwawIbamka2W+sJShOIwkTHm6eysWPOxj8YAymv38+WyMva5CEzkmXIk
	 EGmovYkRJ4rltYdaXhpE4ZXOpOP9dlzS9vYLIE89Hrsavm7Tgf73mL8Pt6YvVApT8g
	 hXrUtdqXeJb/b5qUMxR4PEeOxAOBJGO4yPHNpnTqt+u0BprAf1+jHhc6e571s7FYXX
	 vhctJe/KeKGpKBv6CTDrfTwxfYpt1RWTsepLWGFo+S5DcvJpREH+OIr9ZGbBsDAaFJ
	 9BjNxjDHsiY5Jgfj5agBqacTMHbncKyTdghxi8r+iVbNK4rWPUtx0ZMqB0PilfKHBM
	 7lena1BKKav8g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maciej Strozek <mstrozek@opensource.cirrus.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 527/713] mfd: cs42l43: Fix wrong register defaults
Date: Sun, 24 Mar 2024 18:44:13 -0400
Message-ID: <20240324224720.1345309-528-sashal@kernel.org>
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



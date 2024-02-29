Return-Path: <linux-kernel+bounces-87038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F75186CE85
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D8971F25FF9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380B86CC05;
	Thu, 29 Feb 2024 15:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="eb8czAnm"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CCE6CBE6;
	Thu, 29 Feb 2024 15:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709222202; cv=none; b=Cyu3YbUS847Pz1kwdDQ2LFd9Ptup2hCpcD4CSfcSAeSuAsAckER4YeTikl86cxF/E06uMTMNH/9+QcNVFihq8SySicjAp85FkIgfZk1N/4gsQzlNQl/eC43aR62HHCt907gHXPJtK51LS2cpKJ2awQw5dmTmYyafP5oE/wlPW2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709222202; c=relaxed/simple;
	bh=iOmQTVDs9UpkKV8z9c2K0lKOA26i1Ri15LvtFNJTn8A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M+LQ5iORK+jk+4Yi5hvQe5AhwZP/Egi/liAGZtRpmdSazjBZciYWDDaBMra6DbSEQ3bbg4m+cejeyaLdloIiTIt9ZR07c2Y3afHD2exRO/19EUH0B9hbq7zb+HKSwDDXZ2Apr8ZZaVm1ZK9vJd4IBD3nH00SFMF4/R98XjqOn30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=eb8czAnm; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41TFednF032401;
	Thu, 29 Feb 2024 09:56:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=i
	ZMbhk8sFajOWu5eQuTJqb2j6jAdfI9Sm0TUstq/FPc=; b=eb8czAnmLUIYEq3Mp
	itKwz2CGsCUniyiiZjmJr43zii6sIXHyx0pUN0Wd3WooIZySTNb3KtVSfixxW8GU
	8luTD+olhfECHYXyeot2ZoaQxsacq+2/jgKBQ09TnFrhRGdKhwU5ajsRPf2I2s4w
	oZc4wsFKLGLSJk4A8n8tmKpGBC2K4xTrC5cxYlYi2X+Lgeb3doExlS82RxOVAbI3
	193Pi8NW1A8PqWgLvpH6bffIMGtOOZMaDOVjtbeZgpEfcjSk5Es8tQ1U+ECySmW3
	8N+Ip0sPds4ff3Do0iWZk4vBOIn1/7mrer45GnvmYT5UXKKEKhOPd/x6v5ZEbaZT
	LF+/g==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3wfer2xgnp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 09:56:31 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 29 Feb
 2024 15:56:29 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Thu, 29 Feb 2024 15:56:29 +0000
Received: from fedora.ad.cirrus.com (unknown [198.90.251.53])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id A6A8C820241;
	Thu, 29 Feb 2024 15:56:29 +0000 (UTC)
From: Maciej Strozek <mstrozek@opensource.cirrus.com>
To: Lee Jones <lee@kernel.org>
CC: <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>,
        Maciej Strozek
	<mstrozek@opensource.cirrus.com>
Subject: [PATCH] mfd: cs42l43: Fix wrong register defaults
Date: Thu, 29 Feb 2024 15:56:14 +0000
Message-ID: <20240229155616.118457-1-mstrozek@opensource.cirrus.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: CC-fgD8xa4r1UDu6RkNYlS7WZ_JrIDta
X-Proofpoint-ORIG-GUID: CC-fgD8xa4r1UDu6RkNYlS7WZ_JrIDta
X-Proofpoint-Spam-Reason: safe

A few regs have unnecessary values in defaults, change them to match the
datasheet

Fixes: ace6d1448138 ("mfd: cs42l43: Add support for cs42l43 core driver")

Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
---
 drivers/mfd/cs42l43.c | 68 +++++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/mfd/cs42l43.c b/drivers/mfd/cs42l43.c
index 7b6d07cbe6fc..73c88ee6a866 100644
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
2.30.2



Return-Path: <linux-kernel+bounces-113367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5C08883C3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56DBE282CB4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665CF19D8AE;
	Sun, 24 Mar 2024 22:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPE2iJxI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCDC19D1DB;
	Sun, 24 Mar 2024 22:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320168; cv=none; b=mWgFbfmIex2i7BA9XT3687av/KNqqZOJx65Wy1jUOMI+JlOkcKP/wLqMeH7yUhM0IekrwCh9gijc9OrhWfxJeNk82lByvZR2/zQL8js5lbHw2mkZXdSOUu4xw515hPCB1Dg13MRw+KprjKtFkioAf++VMcpS5MT+Jzr7dxl/f38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320168; c=relaxed/simple;
	bh=7zR0BrWM9FieUe0Q38iXkPk2VIsJeZQPb9NcsHR1SBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/jTquZcgYU6pN2bSmbvqtij/hGA3KckFPinIdYQqjmTKYSxpQPzuKqa8Wghd6gXEoCwnaGVLZTL/CikevpIU2h5xO2MTzx6XTmMIJHgvhfQowbour++c660Q6YfZZ37GAJ6fgg+hwk15gb5u3xqSv4MznzgIyPg0dLlNNkob0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPE2iJxI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6D4C43390;
	Sun, 24 Mar 2024 22:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320168;
	bh=7zR0BrWM9FieUe0Q38iXkPk2VIsJeZQPb9NcsHR1SBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gPE2iJxIWzvbzAIMsF5aCgwHqYv7G6Me68jz84/E4hmtcX0LnV07rNC8hrvEoAI7l
	 QECMugUhFwZcem8zPXTfJUhixEDB5eaAKNgqInPFjJ7GSAOqVRxl1g0TgRqfTYfEDA
	 V7WRlzHbkGyD1vn+WgXjwZ+xvCaVctIQF1Ny0S9K+hbfF5xzNsWjhsKvBbUOS75YOF
	 BmTL1XinpBB0SGQ2WMYHC/wvMOXE2musmogMpuRFJ9lrSjXOPPjwX7PmzEGhEJVOrb
	 H90mYXJOBYCsk1bbnrsMhPC5TsP+9EzODL/LmdV4Jb7U2rKHfz5cMEQBItOkkhb78D
	 reu6zryofxMlw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>,
	Abel Vesa <abel.vesa@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 476/715] clk: imx: imx8mp: Fix SAI_MCLK_SEL definition
Date: Sun, 24 Mar 2024 18:30:55 -0400
Message-ID: <20240324223455.1342824-477-sashal@kernel.org>
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

From: Shengjiu Wang <shengjiu.wang@nxp.com>

[ Upstream commit 13269dc6c70444528f0093585e3559cd2f38850a ]

There is SAI1, SAI2, SAI3, SAI5, SAI6, SAI7 existing in this block
control, the order is discontinuous. The definition of SAI_MCLK_SEL(n)
is not match with the usage of CLK_SAIn(n).

So define SAI##n##_MCLK_SEL separately to fix the issue.

Fixes: 6cd95f7b151c ("clk: imx: imx8mp: Add audiomix block control")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
Link: https://lore.kernel.org/r/1708683351-8504-1-git-send-email-shengjiu.wang@nxp.com
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/imx/clk-imx8mp-audiomix.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/clk-imx8mp-audiomix.c
index e4300df88f1ac..55ed211a5e0b1 100644
--- a/drivers/clk/imx/clk-imx8mp-audiomix.c
+++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
@@ -18,7 +18,12 @@
 
 #define CLKEN0			0x000
 #define CLKEN1			0x004
-#define SAI_MCLK_SEL(n)		(0x300 + 4 * (n))	/* n in 0..5 */
+#define SAI1_MCLK_SEL		0x300
+#define SAI2_MCLK_SEL		0x304
+#define SAI3_MCLK_SEL		0x308
+#define SAI5_MCLK_SEL		0x30C
+#define SAI6_MCLK_SEL		0x310
+#define SAI7_MCLK_SEL		0x314
 #define PDM_SEL			0x318
 #define SAI_PLL_GNRL_CTL	0x400
 
@@ -95,13 +100,13 @@ static const struct clk_parent_data clk_imx8mp_audiomix_pll_bypass_sels[] = {
 		IMX8MP_CLK_AUDIOMIX_SAI##n##_MCLK1_SEL, {},		\
 		clk_imx8mp_audiomix_sai##n##_mclk1_parents,		\
 		ARRAY_SIZE(clk_imx8mp_audiomix_sai##n##_mclk1_parents), \
-		SAI_MCLK_SEL(n), 1, 0					\
+		SAI##n##_MCLK_SEL, 1, 0					\
 	}, {								\
 		"sai"__stringify(n)"_mclk2_sel",			\
 		IMX8MP_CLK_AUDIOMIX_SAI##n##_MCLK2_SEL, {},		\
 		clk_imx8mp_audiomix_sai_mclk2_parents,			\
 		ARRAY_SIZE(clk_imx8mp_audiomix_sai_mclk2_parents),	\
-		SAI_MCLK_SEL(n), 4, 1					\
+		SAI##n##_MCLK_SEL, 4, 1					\
 	}, {								\
 		"sai"__stringify(n)"_ipg_cg",				\
 		IMX8MP_CLK_AUDIOMIX_SAI##n##_IPG,			\
-- 
2.43.0



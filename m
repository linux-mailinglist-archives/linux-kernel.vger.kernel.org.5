Return-Path: <linux-kernel+bounces-114567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E60B0889061
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22D451C2B6F1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE24E2987AE;
	Sun, 24 Mar 2024 23:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1rztALv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CBB22EADD;
	Sun, 24 Mar 2024 23:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322206; cv=none; b=Q+iLPrsEI1fvJpCs9AfWEV8JBZUtw+IT+RJGyWBU1NQhOXr7k9GhbxpccxuXaVdWMqqesh4YkNiu+Q3f5kdFc4Yw6HOUArz8IO+LOfgEmeX0oREoVbY6uSaKhRe5UgHSAoA6kAEy12itIMNuCHOOnK1t8K9Ocr5tHxEB/EilOD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322206; c=relaxed/simple;
	bh=EG9/Oj0L1ljMvDNRIG5H90uu4piB+73R/COY7CvO3Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gq6+sGD7n/hmS15heQYxnqSTFEwkVcsvkbO1mmHu8AZNTiwv5NbFlY259M4GC4bVTqryOEyRF814HWYMwhO08ximbRrVUZwW2RPu/dzdi/arI8o8hXkxdDUhs98kntmDRMrAdXFbgkR1nBf5RYNRWwGDxAAKcXUUoAky4k3Uot0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1rztALv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B146C43394;
	Sun, 24 Mar 2024 23:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322205;
	bh=EG9/Oj0L1ljMvDNRIG5H90uu4piB+73R/COY7CvO3Y8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m1rztALv6oH4Qb7ZmD1sd5JiCeGvPmVRfdoxHel1gurW2T3SbDx7SCTypJdRIATDr
	 o7qvgV+q/uT5o0VYxTjVdrzYC2h7blZphZymjf3AdC6jvCOc7Nq9mKHDT9To2IH1sb
	 eN1hyoumc29JHV80tzM8B5mXDZeZBiiNQE7T0vtAEmeLet5jNMh/JLHkBX6YhsICRc
	 Koh9yRyt4ERFNVfcWKyJZRhOeWHZWlrZBkCKcp/2ebXnq29rIqy7ADnRhExdjyOUH4
	 o6Q1PNzLr0MpPzKBxvNkSrQYS0XiaB+fuytX3dvF+yKhrUelv4/EyF+Gqb+oH33i6x
	 qMoCuScb4gndA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 285/451] clk: renesas: r8a779g0: Correct PFC/GPIO parent clocks
Date: Sun, 24 Mar 2024 19:09:21 -0400
Message-ID: <20240324231207.1351418-286-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit abb3fa662b8f8eaed1590b0e7a4e19eda467cdd3 ]

According to the R-Car V4H Series Hardware User’s Manual Rev.1.00, the
parent clock of the Pin Function (PFC/GPIO) module clocks is the CP
clock.

Fix this by adding the missing CP clock, and correcting the PFC parents.

Fixes: f2afa78d5a0c0b0b ("dt-bindings: clock: Add r8a779g0 CPG Core Clock Definitions")
Fixes: 36ff366033f0dde1 ("clk: renesas: r8a779g0: Add PFC/GPIO clocks")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/5401fccd204dc90b44f0013e7f53b9eff8df8214.1706197297.git.geert+renesas@glider.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/renesas/r8a779g0-cpg-mssr.c       | 11 ++++++-----
 include/dt-bindings/clock/r8a779g0-cpg-mssr.h |  1 +
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/renesas/r8a779g0-cpg-mssr.c b/drivers/clk/renesas/r8a779g0-cpg-mssr.c
index aace98c0c4735..e4c616921e5ea 100644
--- a/drivers/clk/renesas/r8a779g0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a779g0-cpg-mssr.c
@@ -22,7 +22,7 @@
 
 enum clk_ids {
 	/* Core Clock Outputs exported to DT */
-	LAST_DT_CORE_CLK = R8A779G0_CLK_R,
+	LAST_DT_CORE_CLK = R8A779G0_CLK_CP,
 
 	/* External Input Clocks */
 	CLK_EXTAL,
@@ -139,6 +139,7 @@ static const struct cpg_core_clk r8a779g0_core_clks[] __initconst = {
 	DEF_FIXED("svd2_vip",	R8A779G0_CLK_SVD2_VIP,	CLK_SV_VIP,	2, 1),
 	DEF_FIXED("cbfusa",	R8A779G0_CLK_CBFUSA,	CLK_EXTAL,	2, 1),
 	DEF_FIXED("cpex",	R8A779G0_CLK_CPEX,	CLK_EXTAL,	2, 1),
+	DEF_FIXED("cp",		R8A779G0_CLK_CP,	CLK_EXTAL,	2, 1),
 	DEF_FIXED("viobus",	R8A779G0_CLK_VIOBUS,	CLK_VIO,	1, 1),
 	DEF_FIXED("viobusd2",	R8A779G0_CLK_VIOBUSD2,	CLK_VIO,	2, 1),
 	DEF_FIXED("vcbus",	R8A779G0_CLK_VCBUS,	CLK_VC,		1, 1),
@@ -173,10 +174,10 @@ static const struct mssr_mod_clk r8a779g0_mod_clks[] __initconst = {
 	DEF_MOD("cmt1",		911,	R8A779G0_CLK_R),
 	DEF_MOD("cmt2",		912,	R8A779G0_CLK_R),
 	DEF_MOD("cmt3",		913,	R8A779G0_CLK_R),
-	DEF_MOD("pfc0",		915,	R8A779G0_CLK_CL16M),
-	DEF_MOD("pfc1",		916,	R8A779G0_CLK_CL16M),
-	DEF_MOD("pfc2",		917,	R8A779G0_CLK_CL16M),
-	DEF_MOD("pfc3",		918,	R8A779G0_CLK_CL16M),
+	DEF_MOD("pfc0",		915,	R8A779G0_CLK_CP),
+	DEF_MOD("pfc1",		916,	R8A779G0_CLK_CP),
+	DEF_MOD("pfc2",		917,	R8A779G0_CLK_CP),
+	DEF_MOD("pfc3",		918,	R8A779G0_CLK_CP),
 	DEF_MOD("tsc",		919,	R8A779G0_CLK_CL16M),
 	DEF_MOD("ssiu",		2926,	R8A779G0_CLK_S0D6_PER),
 	DEF_MOD("ssi",		2927,	R8A779G0_CLK_S0D6_PER),
diff --git a/include/dt-bindings/clock/r8a779g0-cpg-mssr.h b/include/dt-bindings/clock/r8a779g0-cpg-mssr.h
index 754c54a6eb06a..7850cdc62e285 100644
--- a/include/dt-bindings/clock/r8a779g0-cpg-mssr.h
+++ b/include/dt-bindings/clock/r8a779g0-cpg-mssr.h
@@ -86,5 +86,6 @@
 #define R8A779G0_CLK_CPEX		74
 #define R8A779G0_CLK_CBFUSA		75
 #define R8A779G0_CLK_R			76
+#define R8A779G0_CLK_CP			77
 
 #endif /* __DT_BINDINGS_CLOCK_R8A779G0_CPG_MSSR_H__ */
-- 
2.43.0



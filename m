Return-Path: <linux-kernel+bounces-113311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6671888350
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 146301C23105
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC34713CE0B;
	Sun, 24 Mar 2024 22:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsTq1c4E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C4C13CDF0;
	Sun, 24 Mar 2024 22:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320112; cv=none; b=RLT6CkdyEPT+ykHXSQJcq4gaO90WbON2MidYnRJeQsDWnGQuZlkJn6HF4p7DYoxHnu4y5A1rpCDo2gbVzPj6DjtmNFYkxXuyJUTT4h3fGWMObp2K6yJEzP+wB3wKMJGNbx1rKloskCcYVp12+bdewDELEI0MpJEuXzbjKyBfK5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320112; c=relaxed/simple;
	bh=BcmkAXJdCO3vpaxJG65egk0GWGGGo/vnAy5lzRVXv9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XkBXJfi0UZUbBo7GpzD1Vj8yLCJBR+68mvc73k0IrouJH5iGpVgSoThRswunRF0RgsES4Wzb8jpqcRRqnQ+bSZ1pbLqwmW7p95Kh8R4NSDQPBV6am5bP+4QIOThI5SQsFGpwmqmS9Ef4n0SDRyrXMoStuUGJ3Wjn1pJxVTHCTmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsTq1c4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77CADC43390;
	Sun, 24 Mar 2024 22:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320112;
	bh=BcmkAXJdCO3vpaxJG65egk0GWGGGo/vnAy5lzRVXv9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VsTq1c4EXFXXZ3Jr8V0kLiUIhBnXc/3q6p2ilAZv6/vNsAu9YGBDDqLTjIdn8w/AY
	 DFmnrE7Z2PEOcWZe9iAs3aTz1McvBp2q/3wKCiIgHc22nLVBAH1ERulzNyJQ/dJ8N0
	 /fALLMrUE+aCxzABLh/dHJ8cKNWh6YA78fI3GonsHslZROHWfwpeTUmEnbJlbttyWW
	 7MM01JQX21wTi2duYj7R/XM39eV6L8iHFe9ZePUEom7npLIyoqJLtGeSf91baszW/R
	 yQ9kHFpaH/wKTlQ/xzIXJLAzzoNyze257ryZ7Jg2hAY7teO58Vhnag8Ewt3OWv9yU6
	 Pd8HXNanmuwZg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 420/715] clk: renesas: r8a779g0: Correct PFC/GPIO parent clocks
Date: Sun, 24 Mar 2024 18:29:59 -0400
Message-ID: <20240324223455.1342824-421-sashal@kernel.org>
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
index 31b13c997a057..c4b1938db76b3 100644
--- a/drivers/clk/renesas/r8a779g0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a779g0-cpg-mssr.c
@@ -22,7 +22,7 @@
 
 enum clk_ids {
 	/* Core Clock Outputs exported to DT */
-	LAST_DT_CORE_CLK = R8A779G0_CLK_R,
+	LAST_DT_CORE_CLK = R8A779G0_CLK_CP,
 
 	/* External Input Clocks */
 	CLK_EXTAL,
@@ -141,6 +141,7 @@ static const struct cpg_core_clk r8a779g0_core_clks[] __initconst = {
 	DEF_FIXED("svd2_vip",	R8A779G0_CLK_SVD2_VIP,	CLK_SV_VIP,	2, 1),
 	DEF_FIXED("cbfusa",	R8A779G0_CLK_CBFUSA,	CLK_EXTAL,	2, 1),
 	DEF_FIXED("cpex",	R8A779G0_CLK_CPEX,	CLK_EXTAL,	2, 1),
+	DEF_FIXED("cp",		R8A779G0_CLK_CP,	CLK_EXTAL,	2, 1),
 	DEF_FIXED("viobus",	R8A779G0_CLK_VIOBUS,	CLK_VIO,	1, 1),
 	DEF_FIXED("viobusd2",	R8A779G0_CLK_VIOBUSD2,	CLK_VIO,	2, 1),
 	DEF_FIXED("vcbus",	R8A779G0_CLK_VCBUS,	CLK_VC,		1, 1),
@@ -232,10 +233,10 @@ static const struct mssr_mod_clk r8a779g0_mod_clks[] __initconst = {
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
 	DEF_MOD("tsn",		2723,	R8A779G0_CLK_S0D4_HSC),
 	DEF_MOD("ssiu",		2926,	R8A779G0_CLK_S0D6_PER),
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



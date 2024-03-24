Return-Path: <linux-kernel+bounces-114543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD2A88904B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 219861F2B840
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1A4292B9B;
	Sun, 24 Mar 2024 23:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQBdZ3Vc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7990314A4C1;
	Sun, 24 Mar 2024 23:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322182; cv=none; b=WIvZ5SF0Li6iWy00yIzcnYcN53Lhc+0NYIInqd7hNGNimVVX0YkQmpQE+PT6TrHJazYrzUijnvQFWEqlxGh1rP5LXiG3a1f/bnkfTcKJxpSzBg+nYkcCxrN7PvtOLCCGOPvVqr01jMq9gsBdVBmkieIES1cIXXgQJI6/Vjp1PJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322182; c=relaxed/simple;
	bh=A8pyShnWkKz8WXkGZqZYPbS0MCO6dDxzLnV4Q7sKaL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lD4OcuElAyNgxXQOKpFc9KhgIdYI6i0R8O96VYRu6gpHamCnfzyfUZKKLdaY4qQ5kmxr9i8G+81hUW/ar64MKpI+8eMPpmwKeAvpCAIT+kkMYm14XWBQBrwfsgJabw21UhBh5qzvJ238bwym2QjdHirZsj3SQI/+OXm9RmUdhWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQBdZ3Vc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3D9C43399;
	Sun, 24 Mar 2024 23:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322181;
	bh=A8pyShnWkKz8WXkGZqZYPbS0MCO6dDxzLnV4Q7sKaL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jQBdZ3VcWE9mUl78QkLKMmhTSOSsFQlCF9DFQi6T+G4MAHBPAH/D7GAc/p3lCl+7t
	 jEiKuzZ6Y7GYqY9ojFQLBY3rqObIM1N2jCpacDDBpg4i6yC4Q9OvErXUs2T4qe6Y/i
	 sQZGbX3nlXkwrkbyuHG57a3AcxHWKppXrJZmsSbepn48K2yt/lqDoVbcsB3SBNP7O3
	 qjPRNKRVUu0MoSMq5y4oeUu03nXymt/+u72nyZ85QXpl1XzsFEfZdZAt4AdJNybnjI
	 7so1gt8UU2PiZvYyKJZ75+up10Uu9IYQPjR/Ck+d1KCpXWjCRCTUDWuUHWpxeIN9fe
	 kErFC/9t5t+/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Linh Phung <linh.phung.jy@renesas.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 259/451] pinctrl: renesas: r8a779g0: Add Audio SSI pins, groups, and functions
Date: Sun, 24 Mar 2024 19:08:55 -0400
Message-ID: <20240324231207.1351418-260-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Linh Phung <linh.phung.jy@renesas.com>

[ Upstream commit b37d57e1daccbc1a0393d9207d5c48f9181fe85a ]

Add pins, groups, and functions for the Serial Sound Interface (SSI) on
the Renesas R-Car V4H (R8A779G0) SoC.

Signed-off-by: Linh Phung <linh.phung.jy@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/87bkmcang2.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Stable-dep-of: 68540257cdf1 ("pinctrl: renesas: r8a779g0: Add missing SCIF_CLK2 pin group/function")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/renesas/pfc-r8a779g0.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/pinctrl/renesas/pfc-r8a779g0.c b/drivers/pinctrl/renesas/pfc-r8a779g0.c
index 43a63a21a6fb5..14774163df354 100644
--- a/drivers/pinctrl/renesas/pfc-r8a779g0.c
+++ b/drivers/pinctrl/renesas/pfc-r8a779g0.c
@@ -2360,6 +2360,22 @@ static const unsigned int scif_clk_mux[] = {
 	SCIF_CLK_MARK,
 };
 
+/* - SSI ------------------------------------------------- */
+static const unsigned int ssi_data_pins[] = {
+	/* SSI_SD */
+	RCAR_GP_PIN(1, 20),
+};
+static const unsigned int ssi_data_mux[] = {
+	SSI_SD_MARK,
+};
+static const unsigned int ssi_ctrl_pins[] = {
+	/* SSI_SCK,  SSI_WS */
+	RCAR_GP_PIN(1, 18), RCAR_GP_PIN(1, 19),
+};
+static const unsigned int ssi_ctrl_mux[] = {
+	SSI_SCK_MARK, SSI_WS_MARK,
+};
+
 /* - TPU ------------------------------------------------------------------- */
 static const unsigned int tpu_to0_pins[] = {
 	/* TPU0TO0 */
@@ -2652,6 +2668,9 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(scif4_ctrl),
 	SH_PFC_PIN_GROUP(scif_clk),
 
+	SH_PFC_PIN_GROUP(ssi_data),
+	SH_PFC_PIN_GROUP(ssi_ctrl),
+
 	SH_PFC_PIN_GROUP(tpu_to0),		/* suffix might be updated */
 	SH_PFC_PIN_GROUP(tpu_to0_a),		/* suffix might be updated */
 	SH_PFC_PIN_GROUP(tpu_to1),		/* suffix might be updated */
@@ -2964,6 +2983,11 @@ static const char * const scif_clk_groups[] = {
 	"scif_clk",
 };
 
+static const char * const ssi_groups[] = {
+	"ssi_data",
+	"ssi_ctrl",
+};
+
 static const char * const tpu_groups[] = {
 	/* suffix might be updated */
 	"tpu_to0",
@@ -3045,6 +3069,8 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(scif4),
 	SH_PFC_FUNCTION(scif_clk),
 
+	SH_PFC_FUNCTION(ssi),
+
 	SH_PFC_FUNCTION(tpu),
 
 	SH_PFC_FUNCTION(tsn0),
-- 
2.43.0



Return-Path: <linux-kernel+bounces-115955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 375648898DD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 684DA1C3118A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B033921A9;
	Mon, 25 Mar 2024 03:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHWZBXCJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7623422EAD0;
	Sun, 24 Mar 2024 23:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322205; cv=none; b=KOOmDDR5olLOkqvWGX95nzAkWgutirtm6YH0YN4TlTYUnuOjLnpCos3IyKpcYQTKLUR+v1D4TPZ53Ht9eKRRYMNSjcUhrsRD9lbKngvCS/xKthyalyJG0qTdOBmPsUtvFYQ9ezb01Uz8ls5M6o0bkG36HMZgQqZO+hppKK4mdmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322205; c=relaxed/simple;
	bh=vLWl85vqIRepnh5IVE3ABo5oCEMmOMaVuNYOaC2oM+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/3XroRr3d+qFhlmHmETAjM2jhl0HPYkhvF0DYyXVut7RnGpn7Nlvv28WjUF5hWDJyZtkxKw+Cl/M92jjIo+oMd4YNWjlAfhkg/PrlrmstnjdeW3tCD18BdbMKZ1Neq8WflW5f9/D8MBH4uRVkiye0OEb8LzZWhVhgGZUXf9voA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHWZBXCJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B870FC433F1;
	Sun, 24 Mar 2024 23:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322204;
	bh=vLWl85vqIRepnh5IVE3ABo5oCEMmOMaVuNYOaC2oM+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sHWZBXCJ+ea+bMJzSqSlPyWt5NS0P6EmQdWUBwQqxqEOIZqFRXlG0omBr0W6DXwZD
	 +jakEXMgYJXdw47hl2E6VRLavTcgwq9lLh+t1diUuvvlv+ICeQDAwAMxP/JcmxZYY+
	 H3cdYBCWTfMBh3P5LXASoUfE2Lqn/XG40E9GYLzY6LjWASqrfdkJ9r2NJudi7C7ZV2
	 Kq898Shm+L19AHFM7tXZc/I3PUbCGrmdDKjb4wdDDnNTLON4wdmgqfJjCy/KfqEdKq
	 DtLL4Y6FAWl+jw7thuRCi4dRFpJRKgsne6qolIW3LLuykhnccBoXgDIl++1ymsl5ZV
	 uV4bwC9MorYwg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 284/451] clk: renesas: r8a779g0: Add thermal clock
Date: Sun, 24 Mar 2024 19:09:20 -0400
Message-ID: <20240324231207.1351418-285-sashal@kernel.org>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 7502a04dae0e614bc14553e31461e50499bc67aa ]

Add the module clock used by the Thermal Sensor/Chip Internal Voltage
Monitor/Core Voltage Monitor (THS/CIVM/CVM) on the Renesas R-Car V4H
(R8A779G0) SoC.

Based on a large patch in the BSP by Kazuya Mizuguchi.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/59461effd0d9f7a39e0c91352c87f2b7071b1891.1675958536.git.geert+renesas@glider.be
Stable-dep-of: abb3fa662b8f ("clk: renesas: r8a779g0: Correct PFC/GPIO parent clocks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/renesas/r8a779g0-cpg-mssr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/renesas/r8a779g0-cpg-mssr.c b/drivers/clk/renesas/r8a779g0-cpg-mssr.c
index d0e8deacdd0be..aace98c0c4735 100644
--- a/drivers/clk/renesas/r8a779g0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a779g0-cpg-mssr.c
@@ -177,6 +177,7 @@ static const struct mssr_mod_clk r8a779g0_mod_clks[] __initconst = {
 	DEF_MOD("pfc1",		916,	R8A779G0_CLK_CL16M),
 	DEF_MOD("pfc2",		917,	R8A779G0_CLK_CL16M),
 	DEF_MOD("pfc3",		918,	R8A779G0_CLK_CL16M),
+	DEF_MOD("tsc",		919,	R8A779G0_CLK_CL16M),
 	DEF_MOD("ssiu",		2926,	R8A779G0_CLK_S0D6_PER),
 	DEF_MOD("ssi",		2927,	R8A779G0_CLK_S0D6_PER),
 };
-- 
2.43.0



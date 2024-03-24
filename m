Return-Path: <linux-kernel+bounces-115953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3EF8898D2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6560A1F2B6DD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28423267361;
	Mon, 25 Mar 2024 03:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzMv1kPE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF78722EAA9;
	Sun, 24 Mar 2024 23:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322202; cv=none; b=a6dQUHB8gYadrQwCBi4dSLsvw1ZWBeZivJs4VEX+R0YiFKvYXa4wp9/jDKahd+xS+wqbAx2FCChQO4rxWNzB+iYD5NzomC5VgRte91/gRw0Nm+8KJc25VfcRJaPxhexHMS0N485+NyXhltJ7qrPznmTYdyXO72rPLpxh08mvbbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322202; c=relaxed/simple;
	bh=KRp+A+nr0NEQH9RosGC8lfVIpinzALJfOYpKT6tSyWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KEpnEq9Or7LeFNrlt7F81kAL33rh5YWOYchcplpTcQqnWol9A2vBeNp1mE8B3o0fEGXYMd3J2Fifk9F2madlF7xvMyZStWieBR18BcR5m2rPt0YQ+pwybhHbBS6yhIv048WsyGfFfqTV4xzvf9t9qFwol5tIYL1ESk6zmSv8Dmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzMv1kPE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA15C43394;
	Sun, 24 Mar 2024 23:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322202;
	bh=KRp+A+nr0NEQH9RosGC8lfVIpinzALJfOYpKT6tSyWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NzMv1kPEyg1XT3KHZSIJAsf0YoYdyz8UwubWQYz/moIocbv3zCqRnUYPfPw5ndsUH
	 ckEbZDFJvOvtJ5kBCfHW7AMCl8n3RMBLSSZ5QdJtk0CpyfDhEB+/lU8gLYEypTxxK1
	 /M0xgN5OhnMOw7r5ROJzGjLNhGavZT3xHgV/IkgvBVMhnKBwYq+UK2thghE8wDIjE7
	 6UGhmo8DQBbfDe3SXqM58ioUa8fi13YKCuADo8YxiL8yP47RqkCIo80YwcgECSv/kw
	 AdEXVKcVPxx/W54EvFVOj1X561nFJWvpg9U+KN82fJHoD2wK7xBhSJqela8/eLKo6P
	 +s0SgKQwYvsKA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 282/451] clk: renesas: r8a779g0: Add CMT clocks
Date: Sun, 24 Mar 2024 19:09:18 -0400
Message-ID: <20240324231207.1351418-283-sashal@kernel.org>
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

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit 523ed9442b997c39220ee364b07a8773623e3a58 ]

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20221104151135.4706-2-wsa+renesas@sang-engineering.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Stable-dep-of: abb3fa662b8f ("clk: renesas: r8a779g0: Correct PFC/GPIO parent clocks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/renesas/r8a779g0-cpg-mssr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/renesas/r8a779g0-cpg-mssr.c b/drivers/clk/renesas/r8a779g0-cpg-mssr.c
index d5b325e3c5398..f89cda70f2cbb 100644
--- a/drivers/clk/renesas/r8a779g0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a779g0-cpg-mssr.c
@@ -169,6 +169,10 @@ static const struct mssr_mod_clk r8a779g0_mod_clks[] __initconst = {
 	DEF_MOD("i2c4",		522,	R8A779G0_CLK_S0D6_PER),
 	DEF_MOD("i2c5",		523,	R8A779G0_CLK_S0D6_PER),
 	DEF_MOD("wdt1:wdt0",	907,	R8A779G0_CLK_R),
+	DEF_MOD("cmt0",		910,	R8A779G0_CLK_R),
+	DEF_MOD("cmt1",		911,	R8A779G0_CLK_R),
+	DEF_MOD("cmt2",		912,	R8A779G0_CLK_R),
+	DEF_MOD("cmt3",		913,	R8A779G0_CLK_R),
 	DEF_MOD("pfc0",		915,	R8A779G0_CLK_CL16M),
 	DEF_MOD("pfc1",		916,	R8A779G0_CLK_CL16M),
 	DEF_MOD("pfc2",		917,	R8A779G0_CLK_CL16M),
-- 
2.43.0



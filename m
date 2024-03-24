Return-Path: <linux-kernel+bounces-113312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D58AB888352
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F69D1C23578
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7960193145;
	Sun, 24 Mar 2024 22:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6vys+Ey"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA5213CE0F;
	Sun, 24 Mar 2024 22:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320113; cv=none; b=EVqzyaZKQWhNCVZQVnNDrhWLTd6JzllYJoP8WP8MSmSrKpRWtVF+Rlal6MLP+ZDYFy7mKT1IowY7NF0j/2IGW/D69IgZhz4xJI1yT5gewmWD7Ye3irhvLiAwBktwcnedUZwA8jh/LuVs8JWxc9TXuvFOqJKM2GcH0tFy+4Frfqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320113; c=relaxed/simple;
	bh=Amfn6nuTVZcaiQm540euLAyFmc64zyxpfQs/6v0GMEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IB3YfZlt+vxWiJrUt1wSJQ3nxqlViytAqWX8dipVNKpReCa9ypECoiLIq4XJmwZKtuPKo1fxA4yN/hVBxVRd1h0PHG0XzC4SjUkZQCs0DV5MboD7YAYmVcc6wJTWtxzNsM1XIImCAMsoT1tAUuAMM6EBUICc6mwsHx3dm9NndHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6vys+Ey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F6EC433A6;
	Sun, 24 Mar 2024 22:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320112;
	bh=Amfn6nuTVZcaiQm540euLAyFmc64zyxpfQs/6v0GMEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a6vys+EyiAidm/00MVFWMqRRCKqwUBUokeB4huLjA1U6lXTtTocPfuSAnKHjiCQWK
	 qmKoA+SbjCQKDdi0hz1IUKdAfwwi0CWqJwSS2bwIGtCvsiSPk1CjUjFyxu2yFujYUO
	 2VjnFDTiu/JLi3pFZ74pX1/w/qXj6kMY8ggMZ+riqTWA0IhAKG5nsarlnz1WV8SZ6p
	 AQe3m53nMI/93rlCSv4zFnabuLKIbyJ0z97w4UgUD51h9q4Gl5pmYTMbFSeEQqvmbr
	 QRNvUMPP2onEuJmNyufpsGqqQkJKAAXxycsmWchw8EQQcMsG4H0PuWZvMGeuhd/9Xf
	 9IA9qGtIYd6Bg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 421/715] clk: renesas: r8a779f0: Correct PFC/GPIO parent clock
Date: Sun, 24 Mar 2024 18:30:00 -0400
Message-ID: <20240324223455.1342824-422-sashal@kernel.org>
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

[ Upstream commit d1b32a83a02d9433dbd8c5f4d6fc44aa597755bd ]

According to the R-Car S4 Series Hardware User’s Manual Rev.0.81, the
parent clock of the Pin Function (PFC/GPIO) module clock is the CP
clock.

As this clock is not documented to exist on R-Car S4, use the CPEX clock
instead.

Fixes: 73421f2a48e6bd1d ("clk: renesas: r8a779f0: Add PFC clock")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/f88ec4aede0eaf0107c8bb7b28ba719ac6cd418f.1706197415.git.geert+renesas@glider.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/renesas/r8a779f0-cpg-mssr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/r8a779f0-cpg-mssr.c b/drivers/clk/renesas/r8a779f0-cpg-mssr.c
index f721835c7e212..cc06127406ab5 100644
--- a/drivers/clk/renesas/r8a779f0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a779f0-cpg-mssr.c
@@ -161,7 +161,7 @@ static const struct mssr_mod_clk r8a779f0_mod_clks[] __initconst = {
 	DEF_MOD("cmt1",		911,	R8A779F0_CLK_R),
 	DEF_MOD("cmt2",		912,	R8A779F0_CLK_R),
 	DEF_MOD("cmt3",		913,	R8A779F0_CLK_R),
-	DEF_MOD("pfc0",		915,	R8A779F0_CLK_CL16M),
+	DEF_MOD("pfc0",		915,	R8A779F0_CLK_CPEX),
 	DEF_MOD("tsc",		919,	R8A779F0_CLK_CL16M),
 	DEF_MOD("rswitch2",	1505,	R8A779F0_CLK_RSW2),
 	DEF_MOD("ether-serdes",	1506,	R8A779F0_CLK_S0D2_HSC),
-- 
2.43.0



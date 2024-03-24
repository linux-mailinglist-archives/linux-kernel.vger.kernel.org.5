Return-Path: <linux-kernel+bounces-114294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DAC8889D2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F160B23923
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6252609C0;
	Sun, 24 Mar 2024 23:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maqwZ9mY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143B420F25B;
	Sun, 24 Mar 2024 23:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321678; cv=none; b=nrF7Hco5LJMm1P343MCRYbxvGh6hgIqZrrBf72oqO80xk98S0NxiCrOCL6PHjDF5eEPcjJ8vtNAAny7A2UMHIeubBqggSrTfv7Atfoqb9Ni4AqiE81aYrmF1DYj8QIdJ1H9r0iLyDpgoneAPKIpfnzvIf9jtwgdWbZTV9JS3ano=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321678; c=relaxed/simple;
	bh=Amfn6nuTVZcaiQm540euLAyFmc64zyxpfQs/6v0GMEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r1+HWD2QPZqWmoGY8r900rIGoaLdFBZkq1CVshT6R6ILKBDPQAAIuItuhLA+ued13/guhLgW+iBqceymPf5KJ5T921Pm0T/KYb3Il/SnKdxIUVYGlJCpHMCZLYzzZf7NGYnM17SaSPpMBG7Clvg2vgLXWy8Wk7ez+IF+n6GZXrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maqwZ9mY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6974AC43390;
	Sun, 24 Mar 2024 23:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321677;
	bh=Amfn6nuTVZcaiQm540euLAyFmc64zyxpfQs/6v0GMEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=maqwZ9mYgaM8QFCSdfXdEnq/LwvpLv1F1KZzHudduRC5jRpvZvv4+d/prYrh54e+G
	 OnQ4NrByRv6kt1sip6L5XnfSzeqbL1BQSm9C+6EsDqdptkTmKv+qmAPextyh1UBQZP
	 5p+0S7DKDdLvztcPgaEkKvlfsEKEWZBwMZLY3cs+0df9UCysJmUUiofdqwxesWVDNi
	 A9QlTyl8/mMbJ+TMgs8iww2vO9H3vLaofLbJAu14rWlEscU+cblqXM4BMbldpi43oh
	 w/y+HDIdPI+uMP5lCFsrBQfVnKo5kgpVhEbTOuC/2A0/EiNriGswUSkfQ3WuR8aDqF
	 wZeM+aHjtw18A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 406/638] clk: renesas: r8a779f0: Correct PFC/GPIO parent clock
Date: Sun, 24 Mar 2024 18:57:23 -0400
Message-ID: <20240324230116.1348576-407-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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



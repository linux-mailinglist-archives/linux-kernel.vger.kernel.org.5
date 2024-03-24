Return-Path: <linux-kernel+bounces-113276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B51E888307
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3538C285E16
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C4418BC41;
	Sun, 24 Mar 2024 22:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuNGdmG7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E688C18BC24;
	Sun, 24 Mar 2024 22:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320077; cv=none; b=M+/uHI6KV8eHMXxAimHv/T8FRI2jzoIALXoMiHa0kasoKCnEdtrB2qw+zmdaWWVrfEbh3VQSxp2byZs2qFlzIVMWmpPikca/NyVX1GWD55kwk3fq0s32pY6PmBz0ef1xgBCwp9+UAg+j1k1EmRkSEZKY33WzmZnwF1bFJbNd6aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320077; c=relaxed/simple;
	bh=HKqxGiSuxgudu271ZME27j9gpBonBPZKW4BhhujDv/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sv9HmeBNffXJ3B03tckJjkrpH/U+8ltQKLhfpGxnGGa+YI8gOVVvDZBl3h86wkOJWywrulKjaLVQ/4Dl+URaHVsgH7RpLUHzo4gY4PELL38saZ+XlHohox4MagNOPE7ifYqk8/qfwhhjoWEHnHdCp3nexiCPidR0CHzy4qFm0bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuNGdmG7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5CB3C433C7;
	Sun, 24 Mar 2024 22:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320076;
	bh=HKqxGiSuxgudu271ZME27j9gpBonBPZKW4BhhujDv/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WuNGdmG7bzzJxtznpriYn//kuhE0pCj7HX6e89S1+wl6EiC+lKM5pSAK2onkaLlIH
	 NRVW3eOyS0oPo33EppxFR7wA94mNclfHVXW/dAVptkXTJmgBYbnmtBWe4k0iSL8tIE
	 ENMKaV9izvNaDSpDrMywC0v4rmzULqJJR7A0jKKv8iGVmFS6Xkz6MeIuUxofSRMTzC
	 +VJxXSpc9B7dwQ29cIxi0P71AIUUxhdiLX3qs+xvXA/56F0UoR210MmZUE3OT4Eg8q
	 U/lbrE+PjbGZ9ZBAoaaVzDG0zQYAgcHSO8/r/AW6Im7pCPKwPbsoWVN+qwISfNuMMn
	 E68mcrxOA0v2w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 385/715] clk: renesas: r8a779g0: Fix PCIe clock name
Date: Sun, 24 Mar 2024 18:29:24 -0400
Message-ID: <20240324223455.1342824-386-sashal@kernel.org>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 096311157d2a6bb8f06e28e1143e2a5de6a0183b ]

Fix a typo in the name of the module clock for the second PCIe channel.

Fixes: 5ab16198b431ca48 ("clk: renesas: r8a779g0: Add PCIe clocks")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/f582067564f357e2183d3db67b217084ecb51888.1706608032.git.geert+renesas@glider.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/renesas/r8a779g0-cpg-mssr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/r8a779g0-cpg-mssr.c b/drivers/clk/renesas/r8a779g0-cpg-mssr.c
index 5974adcef3eda..31b13c997a057 100644
--- a/drivers/clk/renesas/r8a779g0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a779g0-cpg-mssr.c
@@ -193,7 +193,7 @@ static const struct mssr_mod_clk r8a779g0_mod_clks[] __initconst = {
 	DEF_MOD("msi4",		622,	R8A779G0_CLK_MSO),
 	DEF_MOD("msi5",		623,	R8A779G0_CLK_MSO),
 	DEF_MOD("pciec0",	624,	R8A779G0_CLK_S0D2_HSC),
-	DEF_MOD("pscie1",	625,	R8A779G0_CLK_S0D2_HSC),
+	DEF_MOD("pciec1",	625,	R8A779G0_CLK_S0D2_HSC),
 	DEF_MOD("pwm",		628,	R8A779G0_CLK_SASYNCPERD4),
 	DEF_MOD("rpc-if",	629,	R8A779G0_CLK_RPCD2),
 	DEF_MOD("scif0",	702,	R8A779G0_CLK_SASYNCPERD4),
-- 
2.43.0



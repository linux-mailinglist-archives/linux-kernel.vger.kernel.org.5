Return-Path: <linux-kernel+bounces-114869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA45D8891D9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075671C2D8DB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947A72CA436;
	Mon, 25 Mar 2024 00:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldgHJ8hr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B51177A87;
	Sun, 24 Mar 2024 23:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323513; cv=none; b=Rs3ltxMn4JaPh15UviKUV9sOfvt6UJLKDF2G18BzDd2XhgT9T3mPmk/M5ykA84Rj/S/cXpcypSlkqOssn3kod+M+TRL8AcUpCiCHdg98Q31gcVSwEO02R20Rb1q6+zN2LT3icG4fJ/YLkes9xQ/f3DfolDW8u5LwSDBHocB2LBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323513; c=relaxed/simple;
	bh=9jN6vKZ98/bJPDMoRNuvk8UuWNbHvTAGirA78gAMS2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C66mneY5Q8jGTQEqlCSAQ5KhaoO3fzu9EWc2SXlF1inbXV6AD5rNIueDKP7rP11lspFJC4TsloJh+cGuNvBcaNFDG69cTMblZWlvTUZ31+8CCGWS5w1QBadq6+rEq7uf2nuAW7UnRFLOAXnBmLArqtGqae34QG1AMCguxjQtESE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldgHJ8hr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F2EC433F1;
	Sun, 24 Mar 2024 23:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323512;
	bh=9jN6vKZ98/bJPDMoRNuvk8UuWNbHvTAGirA78gAMS2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ldgHJ8hrUTAzqNJKGjrrUjI3XpccJmqvTIfvcAMSmtciJs+oaazHQ6cXx0N8ZJxsy
	 GB651bnXlj4DK8g8K1if2FH+KEiR0YKubDFyBDHcBtXiNXYZ1c6NwOpI8lmOT30iYu
	 m9CjKKOIFhq5JG28iaULv+T/kEBQ+FGIxwpPR7BHt1FyhlWtdq79DFh3CMeLFtZUIK
	 +p1caiAbeaI3mFJorhLe2HT/JZd4on2z2slogce7AxnS+hVGPVWGhis4Q2THGk5gh6
	 LOIrbrfBxOpT4jOB5QjjDmEQQ9vhOtcPJ0TFs+dBUll0R+Wv2n+vLPZqJkMdCZgCh3
	 tC+WZNdtilqwA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 218/317] clk: hisilicon: hi3559a: Fix an erroneous devm_kfree()
Date: Sun, 24 Mar 2024 19:33:18 -0400
Message-ID: <20240324233458.1352854-219-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 64c6a38136b74a2f18c42199830975edd9fbc379 ]

'p_clk' is an array allocated just before the for loop for all clk that
need to be registered.
It is incremented at each loop iteration.

If a clk_register() call fails, 'p_clk' may point to something different
from what should be freed.

The best we can do, is to avoid this wrong release of memory.

Fixes: 6c81966107dc ("clk: hisilicon: Add clock driver for hi3559A SoC")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/773fc8425c3b8f5b0ca7c1d89f15b65831a85ca9.1705850155.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/hisilicon/clk-hi3559a.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/hisilicon/clk-hi3559a.c b/drivers/clk/hisilicon/clk-hi3559a.c
index 9ea1a80acbe8b..0272276550ff1 100644
--- a/drivers/clk/hisilicon/clk-hi3559a.c
+++ b/drivers/clk/hisilicon/clk-hi3559a.c
@@ -491,7 +491,6 @@ static void hisi_clk_register_pll(struct hi3559av100_pll_clock *clks,
 
 		clk = clk_register(NULL, &p_clk->hw);
 		if (IS_ERR(clk)) {
-			devm_kfree(dev, p_clk);
 			dev_err(dev, "%s: failed to register clock %s\n",
 			       __func__, clks[i].name);
 			continue;
-- 
2.43.0



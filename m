Return-Path: <linux-kernel+bounces-113345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9833888395
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B790281331
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A60199255;
	Sun, 24 Mar 2024 22:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJD9uXbz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7EB199236;
	Sun, 24 Mar 2024 22:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320146; cv=none; b=VfkN9tgPMFc51+H8i7SBwrOgT+ktGGq4GEP/hX5HyXxw8+7cVLS8L4f3+dEW+kkYUqgV2/8HJYBqJrLUiCQOQnjYijzqs3IptDEcNDJ/P5wtwzO+ANWLvDbG+nmrB0rBTimLl7v9KObC+9h/3HDsjzOuI86qHUmwTyiY3VvtZCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320146; c=relaxed/simple;
	bh=I0ftkpg1auOYnQ2mH1Az1FoRNSu97/FiJb83KHbPwCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O+Sg+rWCHKn5R816ka2Aebv4BBECeiatKyuge0xt+P63JhyhGbgMUZI5tcZouW8aj5D+Gc+H6o6fFeXiLk4MsJnGU5vTu1cw0SIUiKuGtNPJZDJiRnRpSqaMntKpH0og3WZfiMIafo6ebJ0c0ij5Qh4HZBfNEg7igmDtzOucupE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJD9uXbz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4726EC43390;
	Sun, 24 Mar 2024 22:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320146;
	bh=I0ftkpg1auOYnQ2mH1Az1FoRNSu97/FiJb83KHbPwCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qJD9uXbzSgqdjO1V0ci6da98g+y8hgssqRoEqDk3yheIkPrFvzBO2GxjTAiuCpPip
	 Hy+iITQL3yTMysU2pzuDrX2AUOPUog/ArNZcjcGVqKt01dBAFs2bMU/6zQUUVgb0sm
	 tFQ/OnTvRA4xwoX02rKP0NvZU3zqETcgVajbpPLqI2bxI8sDGV6yp2ZE2VHpn3jAZB
	 JQ3PMauPsvXbfCgB1MRra6QRjPRw6Vi1MjVbHP+Zt/UzMjZrSx8nOTNuE35AxW5nwX
	 OWZg54Wdrpfv4fJzpIUG75OVUlR3lYsJC/gisjLzYFus2RMt8bPCUDSUqKzN+LZd2p
	 +gw5HNEV3tYAg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 454/715] clk: mediatek: mt8135: Fix an error handling path in clk_mt8135_apmixed_probe()
Date: Sun, 24 Mar 2024 18:30:33 -0400
Message-ID: <20240324223455.1342824-455-sashal@kernel.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 03c1c51eba6be49b42816af9db114553131af6c8 ]

If an error occurs after mtk_alloc_clk_data(), mtk_free_clk_data() should
be called, as already done in the remove function.

Fixes: 54b7026f011e ("clk: mediatek: mt8135-apmixedsys: Convert to platform_driver and module")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/6cd6af61e5a91598068227f1f68cfcfde1507453.1704615011.git.christophe.jaillet@wanadoo.fr
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/mediatek/clk-mt8135-apmixedsys.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt8135-apmixedsys.c b/drivers/clk/mediatek/clk-mt8135-apmixedsys.c
index d1239b4b3db74..41bb2d2e2ea74 100644
--- a/drivers/clk/mediatek/clk-mt8135-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8135-apmixedsys.c
@@ -59,7 +59,7 @@ static int clk_mt8135_apmixed_probe(struct platform_device *pdev)
 
 	ret = mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
 	if (ret)
-		return ret;
+		goto free_clk_data;
 
 	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (ret)
@@ -69,6 +69,8 @@ static int clk_mt8135_apmixed_probe(struct platform_device *pdev)
 
 unregister_plls:
 	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
+free_clk_data:
+	mtk_free_clk_data(clk_data);
 
 	return ret;
 }
-- 
2.43.0



Return-Path: <linux-kernel+bounces-114323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6148889CB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F7711C284ED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F6616F26F;
	Sun, 24 Mar 2024 23:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atp26hFW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D7F21148A;
	Sun, 24 Mar 2024 23:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321706; cv=none; b=Azy5zUzPK7f7R36WmDI3N38CvijoVoC5gQ6pNTgrdw4Rdh3Vb4y28KXm3ZYo05foz7YIdzUEJuIeutAdndf0rD9go67NejHcvMAPyUqPGGA0aym0YG35fr4zEZ6yoiQlEuT+oGOmuX569vzF58Hmd4vsFuc88D3dufeXx46rQ6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321706; c=relaxed/simple;
	bh=I0ftkpg1auOYnQ2mH1Az1FoRNSu97/FiJb83KHbPwCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGgAqIhNLq8cdhgKYJRhdu9TPyqC/H16VY9uzD5J9OD6Z1R8Hf3P0poemhmFoHV1PH5gSqz/18Eu+WJybFgDyMge1yvBUaN6g4gXmpyF/WdV1ojunNhvw4oWqn2k58ikxeGx2nybUqKyVjrZ6EwEM1D+dt9JkVYaVrRORilDPRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atp26hFW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CACFAC433C7;
	Sun, 24 Mar 2024 23:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321705;
	bh=I0ftkpg1auOYnQ2mH1Az1FoRNSu97/FiJb83KHbPwCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=atp26hFWh6Vl6Xmnhh++JFjfMZbiWgde0lFeHfwwJNdIzHMTwUwGrxuKqrU5cUmWk
	 C7KsbkWtsYGZB2i8bojSuwWdmUrk+is+qc1oJye1CyfbuPc82TvRut5HpRexk6AaMf
	 Op+m39g9N1i34X9Hr4XLNIxSBwASwXHhmOK7XoEEOD4ObXaJHLkMwEjLTq6S4dw+P7
	 xbOZjoNoSuZSchEm6pXRxUAViandf3afNiPQII9UtAf+X3F/+zhlRe6RQ3s5mLFg9g
	 qm3K1K7Ck7x4XyieIIUoCvBFoPenbpZLAtU+ZzFmULsvBnRGFA4Mnj3yj6hTEB7DCK
	 wPlJruGH5y5tw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 434/638] clk: mediatek: mt8135: Fix an error handling path in clk_mt8135_apmixed_probe()
Date: Sun, 24 Mar 2024 18:57:51 -0400
Message-ID: <20240324230116.1348576-435-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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



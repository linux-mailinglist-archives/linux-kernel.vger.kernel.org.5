Return-Path: <linux-kernel+bounces-113871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A515488870B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 457FFB217E6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CA9152170;
	Sun, 24 Mar 2024 23:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJNLIM/D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C9314882B;
	Sun, 24 Mar 2024 22:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320923; cv=none; b=MEjToMk52EJnx6BbGpGQ58kQXm2HH2m7bEsYWaxDyqzwXx31h6hiyRIugzI4PRRj7jvkd15NXL8K3sJn2r5Sb3A+3DlUgETV3pzPgAv1nIRZ5d+OWUp254Gc3WlaJumjDzM+C6mB6opKWG5TYIy4F+pm/nHegIEbc+5oLo2JCvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320923; c=relaxed/simple;
	bh=I0ftkpg1auOYnQ2mH1Az1FoRNSu97/FiJb83KHbPwCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fM707+6q4x/zDNmunyKrM0gI5ivme31NfUd14q/vy7tNs/Y1qxpq+8zy9YdeWjHRa/rPhWoslZxPwfAojNaLauwdswKLd8V0SeQPfEE7K9az30u37XGZfkz15IDBdpfiRaBjNgkux6DsO9E4DA3PxSHgUxCFPyM448UxReCMsaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJNLIM/D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1670C433A6;
	Sun, 24 Mar 2024 22:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320922;
	bh=I0ftkpg1auOYnQ2mH1Az1FoRNSu97/FiJb83KHbPwCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oJNLIM/D8BdcYZCp0cUGaxMpDZ3NH0pFYl0eJkLkC6mgPDnBZAUkQZAekGKUQtCnO
	 lUFT67Mdcc4YreinJwn4oInDXy+I4em+gF4pPAr5QDeDH8cf3xj4TBoTNv0oWugxCX
	 Ff0sm4Aw8Tx1UL+HMP+PftYvsACaFTjgSTalfQOqE+XkSmyJ6IGSZV5eNJCGw5NOYr
	 /TZuLsjeKn6aptSSDFgX4fXfvgNcWaFYgBqOgMd4sYtlMIm0x2HR7lGsDFSfmos7vw
	 FVjtmLnfCKcRm5szcKRCVWKC5wjY+WwenX2qSVqt9OHtoeTzWAG8aNBFRp9TozGdIH
	 +EiYo2e+cNh3w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 486/713] clk: mediatek: mt8135: Fix an error handling path in clk_mt8135_apmixed_probe()
Date: Sun, 24 Mar 2024 18:43:32 -0400
Message-ID: <20240324224720.1345309-487-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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



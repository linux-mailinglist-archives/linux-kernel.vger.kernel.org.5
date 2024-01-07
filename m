Return-Path: <linux-kernel+bounces-18812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B69B826356
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 09:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D8EC1C2123D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 08:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B54412B7B;
	Sun,  7 Jan 2024 08:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Vg/znhKa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE30D12B6D
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 08:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from pop-os.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id MOGZrUCWm9dP0MOGZraHLC; Sun, 07 Jan 2024 09:12:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1704615141;
	bh=LQ4ImjzjK8ZTAlmP+wrgMb7Xtb7eat0Xo8zSIFqCBoY=;
	h=From:To:Cc:Subject:Date;
	b=Vg/znhKaeNOWrDwuXPv738I/Rd4tsXNsB3ybHAJAn6l8HG91aqtwLldsMS0hRsI1p
	 oAlIJ0RAtQTEuavoIU0CR7c7E+FUUAqs1mVBt1a796Ht7OqizuXE+UTKrGT53ksWKC
	 qmjLawYBogHzgJGYEuVGVNVisyMxvujp8vtTrCRqqDUjB6Xg5T3yuoyJYJHsRCcVl3
	 LOS1VvOOPunuuAZLgbygiLQVHKAX27sNG9/FapW/BqSWzGPnKFske0RmZWBhVwVz2F
	 nHUIYZrl5cPJzgK5BOIm1tBt63CRf+klN3R+35nqVDQ18EDz1O3j7ixB1LvvKMCoHO
	 tM1uqfXx9MzAQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 07 Jan 2024 09:12:21 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] clk: mediatek: mt8135: Fix an error handling path in clk_mt8135_apmixed_probe()
Date: Sun,  7 Jan 2024 09:12:17 +0100
Message-Id: <6cd6af61e5a91598068227f1f68cfcfde1507453.1704615011.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an error occurs after mtk_alloc_clk_data(), mtk_free_clk_data() should
be called, as already done in the remove function.

Fixes: 54b7026f011e ("clk: mediatek: mt8135-apmixedsys: Convert to platform_driver and module")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/clk/mediatek/clk-mt8135-apmixedsys.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt8135-apmixedsys.c b/drivers/clk/mediatek/clk-mt8135-apmixedsys.c
index d1239b4b3db7..41bb2d2e2ea7 100644
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
2.34.1



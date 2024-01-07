Return-Path: <linux-kernel+bounces-18814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1675C826360
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 09:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02D47B219EF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 08:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E52112B7C;
	Sun,  7 Jan 2024 08:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Wr3PdlO8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9952A12B6C
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 08:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from pop-os.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id MOXDrF2CYiIuMMOXDr7vDG; Sun, 07 Jan 2024 09:29:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1704616175;
	bh=i2n3txj6/jmrhz3DYsK0OV/s61I4FvsrFPJ83pERyYY=;
	h=From:To:Cc:Subject:Date;
	b=Wr3PdlO8sT2ulzf5BARVxJrPvz+SGF+saHX7S8M3y9fKfdUhM+hu9rxBkT2l2PZmn
	 JcCuSJ5svMFqToYWc5pTW1Xx/b3341L7QRGc7xgCmHATkZt6RzSaa8dpkZ5MMg/toq
	 nDQ/yHDITr0ax3ShBOwSX5nhiB/ywbFqXdEn5X1VXQuSfarnY3N5OgJNHSCmVgVrA3
	 UOA1jN3WBX3GvKTR74F9m5AXjRyOlMtXOf+lFvHrhPHG9JZ9XCzy9QaNqK3HzlT8dS
	 1XAKtxCj+wqE+CaeIhyXKEUy2YNt0UepBJ2HDg99G6ibKE5HbKGXJocXb8egHRbTVg
	 AXyILBsppDazw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 07 Jan 2024 09:29:35 +0100
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
Subject: [PATCH] clk: mediatek: mt7622-apmixedsys: Fix an error handling path in clk_mt8135_apmixed_probe()
Date: Sun,  7 Jan 2024 09:29:28 +0100
Message-Id: <2c553c2a5077757e4f7af0bb895acc43881cf62c.1704616152.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'clk_data' is allocated with mtk_devm_alloc_clk_data(). So calling
mtk_free_clk_data() explicitly in the remove function would lead to a
double-free.

Remove the redundant call.

Fixes: c50e2ea6507b ("clk: mediatek: mt7622-apmixedsys: Add .remove() callback for module build")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/clk/mediatek/clk-mt7622-apmixedsys.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt7622-apmixedsys.c b/drivers/clk/mediatek/clk-mt7622-apmixedsys.c
index 9cffd278e9a4..1b8f859b6b6c 100644
--- a/drivers/clk/mediatek/clk-mt7622-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt7622-apmixedsys.c
@@ -127,7 +127,6 @@ static void clk_mt7622_apmixed_remove(struct platform_device *pdev)
 	of_clk_del_provider(node);
 	mtk_clk_unregister_gates(apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
 	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
-	mtk_free_clk_data(clk_data);
 }
 
 static const struct of_device_id of_match_clk_mt7622_apmixed[] = {
-- 
2.34.1



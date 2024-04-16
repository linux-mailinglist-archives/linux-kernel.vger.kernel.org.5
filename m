Return-Path: <linux-kernel+bounces-146826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F798A6B7D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF2528334E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DC012CD90;
	Tue, 16 Apr 2024 12:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dY64t8KV"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDF512C7FA
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 12:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713271992; cv=none; b=KSs1OU9IiN5p/Vuq9WN5tUHcSYsyt98p4+RS6+JsbR/7Bfbe2498wVpjkkqvrQ+AdeRh/+bkExNsrARbRmO1HR/kQJONnR/JEWgc0fbDf/SeEOFW6CU3VK2/OHLDgmLrqGHT8N8V23ZLThYgUOaRIHp4h+TKTGjL6QjgMbDKWSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713271992; c=relaxed/simple;
	bh=HVzH+f/4Onq+eKPSjAJZZx+AmOCCQWtHzdUdxMuI95s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FggAvpjlRFTRrXAHmWCiowIiSjtvm9Biavd0bKc3bKtQRU114dwo1pmQFa5bjCwr0z2pV4y0P7scz15h/rFRkVp6LboqGtJc7r399pMJnwpES26Si4y9BFldcKbCP8QvTPyE3UoXXRRsI13LkMunqxlPFuXihmQrU72d4UN8kcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dY64t8KV; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 77E912000C;
	Tue, 16 Apr 2024 12:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713271989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=07LG+D8zx6QxscnqktDKHECH7SKyoDjzNohjqBXAyyE=;
	b=dY64t8KVvXqYXN0OQsRmz2nexv5PBGQTQNhgas/mAxHCuvLMHxg/zS9km5wdJ3FQ/Ky+XI
	2VZ/7jHGdikgZvm3pQEbAzrIaU1JcEbilQ4ZSPp5OwSjbJolI1VVjLxaVzpzBHZPuOuXp8
	ZKe67o3PVt4301atrthiuuXC7vXufdw+l+SN2x8zNOJCm9IMwzPEOpcZ27mePnQJcVelu0
	ZORaXfpg3fH4kwKC8tlCiTv+5e4tRu0OOJRU0dmZAWOOLpdiwW7HGLVX57RRwvYrJjG+3o
	tIurJI4oiZNyyeU3kWByLoOErzBB6s8EtE/c2kls80p9wCyALeluq8H54LnBiA==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Tue, 16 Apr 2024 14:52:33 +0200
Subject: [PATCH 4/8] phy: cadence-torrent: extract calls to clk_get from
 cdns_torrent_clk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240412-j7200-phy-s2r-v1-4-f15815833974@bootlin.com>
References: <20240412-j7200-phy-s2r-v1-0-f15815833974@bootlin.com>
In-Reply-To: <20240412-j7200-phy-s2r-v1-0-f15815833974@bootlin.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 gregory.clement@bootlin.com, theo.lebrun@bootlin.com, 
 thomas.petazzoni@bootlin.com, u-kumar1@ti.com, 
 Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.12.0
X-GND-Sasl: thomas.richard@bootlin.com

Extract calls to clk_get from cdns_torrent_clk into a separate function.
It needs to call cdns_torrent_clk at resume without looking up the clock.

Co-developed-by: Théo Lebrun <theo.lebrun@bootlin.com>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 37 ++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 95924a09960c..e64625859a07 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -2699,20 +2699,29 @@ static int cdns_torrent_reset(struct cdns_torrent_phy *cdns_phy)
 	return 0;
 }
 
+static int cdns_torrent_of_get_clk(struct cdns_torrent_phy *cdns_phy)
+{
+	/* refclk: Input reference clock for PLL0 */
+	cdns_phy->clk = devm_clk_get(cdns_phy->dev, "refclk");
+	if (IS_ERR(cdns_phy->clk))
+		return dev_err_probe(cdns_phy->dev, PTR_ERR(cdns_phy->clk),
+				     "phy ref clock not found\n");
+
+	/* refclk1: Input reference clock for PLL1 */
+	cdns_phy->clk1 = devm_clk_get_optional(cdns_phy->dev, "pll1_refclk");
+	if (IS_ERR(cdns_phy->clk1))
+		return dev_err_probe(cdns_phy->dev, PTR_ERR(cdns_phy->clk1),
+				     "phy PLL1 ref clock not found\n");
+
+	return 0;
+}
+
 static int cdns_torrent_clk(struct cdns_torrent_phy *cdns_phy)
 {
-	struct device *dev = cdns_phy->dev;
 	unsigned long ref_clk1_rate;
 	unsigned long ref_clk_rate;
 	int ret;
 
-	/* refclk: Input reference clock for PLL0 */
-	cdns_phy->clk = devm_clk_get(dev, "refclk");
-	if (IS_ERR(cdns_phy->clk)) {
-		dev_err(dev, "phy ref clock not found\n");
-		return PTR_ERR(cdns_phy->clk);
-	}
-
 	ret = clk_prepare_enable(cdns_phy->clk);
 	if (ret) {
 		dev_err(cdns_phy->dev, "Failed to prepare ref clock: %d\n", ret);
@@ -2745,14 +2754,6 @@ static int cdns_torrent_clk(struct cdns_torrent_phy *cdns_phy)
 		goto disable_clk;
 	}
 
-	/* refclk1: Input reference clock for PLL1 */
-	cdns_phy->clk1 = devm_clk_get_optional(dev, "pll1_refclk");
-	if (IS_ERR(cdns_phy->clk1)) {
-		dev_err(dev, "phy PLL1 ref clock not found\n");
-		ret = PTR_ERR(cdns_phy->clk1);
-		goto disable_clk;
-	}
-
 	if (cdns_phy->clk1) {
 		ret = clk_prepare_enable(cdns_phy->clk1);
 		if (ret) {
@@ -2846,6 +2847,10 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = cdns_torrent_of_get_clk(cdns_phy);
+	if (ret)
+		goto clk_cleanup;
+
 	regmap_field_read(cdns_phy->phy_pma_cmn_ctrl_1, &already_configured);
 
 	if (!already_configured) {

-- 
2.39.2



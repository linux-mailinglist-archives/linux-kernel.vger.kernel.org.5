Return-Path: <linux-kernel+bounces-146830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2EB8A6B81
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63B501F22844
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F9F12DDBB;
	Tue, 16 Apr 2024 12:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pAuP0kbK"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C1312D1FC
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 12:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713271997; cv=none; b=RPznlvcC/YW/xYNFTE0HH7Tuha+dQvMpwX5aIxFQj7//kB6cDFBwcW+M+N+NEJWoWCAv1VjTEBdolWkjjCHAsQKeKebVgVpvPnqIaCrrQXCJ96VFrxMkGXg3oMXARkrMoGubVnFnp2wXzTFvkw8FTfzhla+qyXyyN0dzL5e7g3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713271997; c=relaxed/simple;
	bh=gFjxgSayQ1SfbalF5DRlC1huW5MRdAZQxlVPqDd7Vgk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pbQ+Q3TCPDK64H36uBmEslp2c8HCrOjzOyx3gfuAJJgdsYvM+wnJlRmcZ0PAsscjwxHl2/6rMfoVX8J5kU39CZELOpiCcj8ywPdAWjgEfKIdw8xRckwHiwKqDAluxjO7pw85S3WxMSEGGom8hpnvoKuFB4Wi5amNDpDoIremAk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pAuP0kbK; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0715520007;
	Tue, 16 Apr 2024 12:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713271993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ro+3bzijX1lOO7JWK3H90lUuZ5Kj2+U5keyLVtzdlk=;
	b=pAuP0kbKH2mNvyLRFchYB99mZx1lASw7r5vAd3qlB+PghI3w/X5BQ9o5f6Z1QrOjk8xrbh
	ViEcxldjzJYec6GZcX7cdivXfv56ixaS9unm0Tt3JrxR/hM+Fsf71mu3U+bNdSRqd0Bs6a
	Y10DCgt93L3AdSepW61zVNZmV5428qZuhXQDJjjm3eBMZi9ReR9PaCPgmifVzTIEEglb4t
	49CikAL7I/pEUPKKf4ivgiAub3Iv85cspsyxBRaGXY59ZJ5LjHWLZvuQL/529U/wpPJyyL
	+45DixWXo9ijBxRUEWXs/ssOC8U69ofkMYkZgV5+QV/L1uthKfYlz2LAVcxh0g==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Tue, 16 Apr 2024 14:52:37 +0200
Subject: [PATCH 8/8] phy: cadence-torrent: add suspend and resume support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240412-j7200-phy-s2r-v1-8-f15815833974@bootlin.com>
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

Add suspend and resume support.

The already_configured flag is cleared during the suspend stage to force
the PHY initialization during the resume stage.

Co-developed-by: Théo Lebrun <theo.lebrun@bootlin.com>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 57 +++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 0e3c755e6089..7e488788a367 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -3075,6 +3075,62 @@ static void cdns_torrent_phy_remove(struct platform_device *pdev)
 	cdns_torrent_clk_cleanup(cdns_phy);
 }
 
+static int cdns_torrent_phy_suspend_noirq(struct device *dev)
+{
+	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(dev);
+	int i;
+
+	reset_control_assert(cdns_phy->phy_rst);
+	reset_control_assert(cdns_phy->apb_rst);
+	for (i = 0; i < cdns_phy->nsubnodes; i++)
+		reset_control_assert(cdns_phy->phys[i].lnk_rst);
+
+	if (cdns_phy->already_configured)
+		cdns_phy->already_configured = 0;
+	else {
+		clk_disable_unprepare(cdns_phy->clk1);
+		clk_disable_unprepare(cdns_phy->clk);
+	}
+
+	return 0;
+}
+
+static int cdns_torrent_phy_resume_noirq(struct device *dev)
+{
+	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(dev);
+	int node = cdns_phy->nsubnodes;
+	int ret, i;
+
+	ret = cdns_torrent_clk(cdns_phy);
+	if (ret)
+		return ret;
+
+	/* Enable APB */
+	reset_control_deassert(cdns_phy->apb_rst);
+
+	if (cdns_phy->nsubnodes > 1) {
+		ret = cdns_torrent_phy_configure_multilink(cdns_phy);
+		if (ret)
+			goto put_lnk_rst;
+	}
+
+	return 0;
+
+put_lnk_rst:
+	for (i = 0; i < node; i++)
+		reset_control_assert(cdns_phy->phys[i].lnk_rst);
+	reset_control_assert(cdns_phy->apb_rst);
+
+	clk_disable_unprepare(cdns_phy->clk1);
+	clk_disable_unprepare(cdns_phy->clk);
+
+	return ret;
+}
+
+static DEFINE_NOIRQ_DEV_PM_OPS(cdns_torrent_phy_pm_ops,
+			       cdns_torrent_phy_suspend_noirq,
+			       cdns_torrent_phy_resume_noirq);
+
 /* USB and DP link configuration */
 static struct cdns_reg_pairs usb_dp_link_cmn_regs[] = {
 	{0x0002, PHY_PLL_CFG},
@@ -5276,6 +5332,7 @@ static struct platform_driver cdns_torrent_phy_driver = {
 	.driver = {
 		.name	= "cdns-torrent-phy",
 		.of_match_table	= cdns_torrent_phy_of_match,
+		.pm	= pm_sleep_ptr(&cdns_torrent_phy_pm_ops),
 	}
 };
 module_platform_driver(cdns_torrent_phy_driver);

-- 
2.39.2



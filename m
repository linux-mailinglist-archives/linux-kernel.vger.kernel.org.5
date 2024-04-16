Return-Path: <linux-kernel+bounces-146828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5098A6B7F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17FD1B2292E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB8E12D741;
	Tue, 16 Apr 2024 12:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="A1/F4t/v"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A525512CD91
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 12:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713271995; cv=none; b=BQ99Qfox3LFVOhbx07A/BeVtSDQV6u6MMS6DDHGj5cx4L6nGa84OJLg7NpmeDgg3LfLBt22VMmlm5yWKjTv+vCAM/F/KAHD9DOXv2/V8RiiHOjljX4+SO5GOvC/jHlTy0+edwuuyw+e+SOod7NQ4VXpp+LKv7IQSNcYju7ak07E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713271995; c=relaxed/simple;
	bh=f8C3Okw/s+xXWVTB5tLnmefazjTi4G3oMjAuSheWM1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mlaNftUmfJ4BoZ1DmZKc/S9RX+6CqjxuW3WPvMYyHpiLc2Zj2TEjlU1CY0ZEnRLGxZa8GE7rAuqAiKxmmwoHU/qYZb0s/eXF1vNJgsOK/OC4EyKjIzJ3B6PGTJVRr0+CgxUSjxJycyq11r3c+Oj2VjarkOvQDELqyilTTq8MEC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=A1/F4t/v; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5C59C2000B;
	Tue, 16 Apr 2024 12:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713271992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hw3jxUBFhu/KlEI+Ltv83Drt/dGgFaXZtN+apO8lfUc=;
	b=A1/F4t/v+kIbUoQdQJLmH3nvceEu5KWt9WdIGP2GzFrh+IyaqG+jBU6tA7T8bsoD+AHdUX
	oZUIUi5ggWNXCzhA6/tMjFcdru55BfK/+HgB1X/9WVykhP9umurMGF4T18TJNxcHrJLr/t
	JtM2AryoV+qEzjgRoHXbD5sYzZNVIHGwfamE2z366wNF1y+UZWYUFeem4UZrozzPz0RTlz
	aMfgmjnZhJYfFgxY1qUxVkfRG6S/xWRv4z4fMwPLqFlmYcUOnn22gZB4ncQRnRdnr1IUt1
	t/RZuRK8X7xBI/jVZLjFeoYIsJyphsCKwsxF30hkBj0vR6hXsnOAY9h1/NG8LQ==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Tue, 16 Apr 2024 14:52:35 +0200
Subject: [PATCH 6/8] phy: cadence-torrent: add already_configured to struct
 cdns_torrent_phy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-j7200-phy-s2r-v1-6-f15815833974@bootlin.com>
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

Add already_configured to struct cdns_torrent_phy, so it can be used at
differents stages.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 7b3a409da185..0636d5d04817 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -360,6 +360,7 @@ struct cdns_torrent_phy {
 	enum cdns_torrent_ref_clk ref_clk1_rate;
 	struct cdns_torrent_inst phys[MAX_NUM_LANES];
 	int nsubnodes;
+	int already_configured;
 	const struct cdns_torrent_data *init_data;
 	struct regmap *regmap_common_cdb;
 	struct regmap *regmap_phy_pcs_common_cdb;
@@ -2808,7 +2809,6 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	struct device_node *child;
 	int ret, subnodes, node = 0, i;
 	u32 total_num_lanes = 0;
-	int already_configured;
 	u8 init_dp_regmap = 0;
 	u32 phy_type;
 
@@ -2855,9 +2855,9 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	if (ret)
 		goto clk_cleanup;
 
-	regmap_field_read(cdns_phy->phy_pma_cmn_ctrl_1, &already_configured);
+	regmap_field_read(cdns_phy->phy_pma_cmn_ctrl_1, &cdns_phy->already_configured);
 
-	if (!already_configured) {
+	if (!cdns_phy->already_configured) {
 		ret = cdns_torrent_clk(cdns_phy);
 		if (ret)
 			goto clk_cleanup;
@@ -2937,7 +2937,7 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 		of_property_read_u32(child, "cdns,ssc-mode",
 				     &cdns_phy->phys[node].ssc_mode);
 
-		if (!already_configured)
+		if (!cdns_phy->already_configured)
 			gphy = devm_phy_create(dev, child, &cdns_torrent_phy_ops);
 		else
 			gphy = devm_phy_create(dev, child, &noop_ops);
@@ -3023,7 +3023,7 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 		goto put_lnk_rst;
 	}
 
-	if (cdns_phy->nsubnodes > 1 && !already_configured) {
+	if (cdns_phy->nsubnodes > 1 && !cdns_phy->already_configured) {
 		ret = cdns_torrent_phy_configure_multilink(cdns_phy);
 		if (ret)
 			goto put_lnk_rst;

-- 
2.39.2



Return-Path: <linux-kernel+bounces-146829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3618A6B80
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 592CF281682
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36D712D76A;
	Tue, 16 Apr 2024 12:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="po115KdO"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8BB12CD9B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 12:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713271995; cv=none; b=iomYqPywMiMGHme5rzvyJi0HYbbcsmVUmA5R9XLMe3XydO/LHH1TFtzRoloVe0kRbdz+Fotw/dFB1wywenfmvPog1hwYXzvHzk/JVfbK/xlJUMoqi7uVbTO1JBz6WCzkcZpm7kgcMeIgWiqDW5uFKTX0hpqtbH/IhBD1rSbX0II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713271995; c=relaxed/simple;
	bh=Ea8yruTncvXm5sRFL3kWVhDS9eIu8eUYRpop2ZECQjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H+UiD7VQu13y5H/mBtM0Udkd9FAt7MCtUm+m15Ch/TUlMm8+AiSHzzVLPPKGvTSVsymJ93lKx5Ro+6tycliLyx+M3xYAhLXKZJrLf9khXCjrF7SI+iU6vhvXo7qIfzGURD+SiJC47LOsys/HlTDyuVMnPwDI75OF4ydhqPVjmjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=po115KdO; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 361F020010;
	Tue, 16 Apr 2024 12:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713271992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VPItTV/Mp42ilTj6tN8/dzU8kHkSA8+8bFCV4f5utvE=;
	b=po115KdOsG3t/mmyxxa9RY7XLvDp2aOIX3CTMiymKr+XSQXWVQ2i1h8s76kSAveyvXVMvt
	z7BFVWLI//KU1SXeA/E+P32LMXKZIpd2fnorFRgLc5VLQTcEo8P/PxryAGcp+GgvSsn4YT
	csvwnDjZSekOw+PLiuThbADaGQd9ory3lGJNUvBGSTUzybBsfNsN5vr/70Dx3yNZRkV9an
	rqBHflsM1PNBXTWp7Lg3qG33dra+zG/ENGYr9bFhMrNJaqWpsEmv8oNT+Dii1BddBKqtyd
	dw/+H1fkxg6vFSBnxL49k4REYVO/r/lCq6b5Mfs0yvFStVsU8uRTt42Rc3HCSQ==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Tue, 16 Apr 2024 14:52:36 +0200
Subject: [PATCH 7/8] phy: cadence-torrent: remove noop_ops phy operations
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-j7200-phy-s2r-v1-7-f15815833974@bootlin.com>
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

Even if a PHY is already configured, the PHY operations are needed during
resume stage, as the PHY is in reset state.
The noop_ops PHY operations is removed to always have PHY operations.
The already_configured flag is checked at the begening of init, configure
and poweron operations to keep the already_configured behaviour.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 0636d5d04817..0e3c755e6089 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -1595,6 +1595,9 @@ static int cdns_torrent_dp_configure(struct phy *phy,
 	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
 	int ret;
 
+	if (cdns_phy->already_configured)
+		return 0;
+
 	ret = cdns_torrent_dp_verify_config(inst, &opts->dp);
 	if (ret) {
 		dev_err(&phy->dev, "invalid params for phy configure\n");
@@ -1630,6 +1633,12 @@ static int cdns_torrent_phy_on(struct phy *phy)
 	u32 read_val;
 	int ret;
 
+	if (cdns_phy->already_configured) {
+		/* Give 5ms to 10ms delay for the PIPE clock to be stable */
+		usleep_range(5000, 10000);
+		return 0;
+	}
+
 	if (cdns_phy->nsubnodes == 1) {
 		/* Take the PHY lane group out of reset */
 		reset_control_deassert(inst->lnk_rst);
@@ -2308,6 +2317,9 @@ static int cdns_torrent_phy_init(struct phy *phy)
 	u32 num_regs;
 	int i, j;
 
+	if (cdns_phy->already_configured)
+		return 0;
+
 	if (cdns_phy->nsubnodes > 1) {
 		if (phy_type == TYPE_DP)
 			return cdns_torrent_dp_multilink_init(cdns_phy, inst, phy);
@@ -2445,19 +2457,6 @@ static const struct phy_ops cdns_torrent_phy_ops = {
 	.owner		= THIS_MODULE,
 };
 
-static int cdns_torrent_noop_phy_on(struct phy *phy)
-{
-	/* Give 5ms to 10ms delay for the PIPE clock to be stable */
-	usleep_range(5000, 10000);
-
-	return 0;
-}
-
-static const struct phy_ops noop_ops = {
-	.power_on	= cdns_torrent_noop_phy_on,
-	.owner		= THIS_MODULE,
-};
-
 static
 int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 {
@@ -2937,10 +2936,7 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 		of_property_read_u32(child, "cdns,ssc-mode",
 				     &cdns_phy->phys[node].ssc_mode);
 
-		if (!cdns_phy->already_configured)
-			gphy = devm_phy_create(dev, child, &cdns_torrent_phy_ops);
-		else
-			gphy = devm_phy_create(dev, child, &noop_ops);
+		gphy = devm_phy_create(dev, child, &cdns_torrent_phy_ops);
 		if (IS_ERR(gphy)) {
 			ret = PTR_ERR(gphy);
 			goto put_child;

-- 
2.39.2



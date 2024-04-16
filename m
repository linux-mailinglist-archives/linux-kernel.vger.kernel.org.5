Return-Path: <linux-kernel+bounces-146827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 827AC8A6B7E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B48BD1C21AB8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA9912D1E0;
	Tue, 16 Apr 2024 12:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Yo5yI32Z"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9693112BF38
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713271994; cv=none; b=PpWjIpFaNW1rSFyB7T8ZOiIma9zbe4247tFhFUNyPIHcCEs9q7fAoSOZG9hyheJOd1tP8RPh6q6My3W9RVfRu8rLBS2o0VQ6v4gIFPV9BxxYb8GEaa1+Qp4ud/RLkgnVnUcdn9makuR4FYWHUusQB33euMiZAyAtD4TJsqqUO5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713271994; c=relaxed/simple;
	bh=+rOSG0/7rUaquvxvPvPzJ2V5TIecUPb6fosGPKU86g0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hay/xjuzsIbBS13DC2kg7c7pRtdBZ//FW30wfmcmbRKtjjMfaMwTOUrhvurj5KeTjiT8kW0HzmgMu/sLaBR2n/PAZsENn3RYvaO9X6JVNaSzd0C6rdweG3T4hHC3sVA5JD7oY7CXNhLfePV7dqh5ALGn5jykYvfi2v3nvUJYw4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Yo5yI32Z; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 283072000F;
	Tue, 16 Apr 2024 12:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713271991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GeCvzxoz401XbYRIrAa+sB5K03ywKvZQVjVxSvr6zHY=;
	b=Yo5yI32Z1dWrtaDWz9EEueR7iCWMdQUFDQHa5+JZ4T4Sk5wnnd4YnxA9rq3MDH2DJ1S4nQ
	J8TtlgobqD31mj5UjvnaPKhYWnvU06AGk6L6vISVHXDcuyeymFbJjyPPuUdh1yu149mFeY
	qi+3O2Rf98JGdQi/CbJvhw0XATlG5cPkirtOZ5HRCon5qN9jPgHMc5GTGSa+12nOMvg9YJ
	vbT6A2kN4xtqglid9D0Eix8MuSd4MKqc00OwBZQAMvmhvN6SamCbs0q9vE14MZ6xPztWHY
	n6nAaWNysX56DPUDEgExe90h2a8luhPxkXiWUdFM0Kn5qFu+aFCF2JSjf1BYYQ==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Tue, 16 Apr 2024 14:52:34 +0200
Subject: [PATCH 5/8] phy: cadence-torrent: register resets even if the phy
 is already configured
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-j7200-phy-s2r-v1-5-f15815833974@bootlin.com>
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

Resets are needed during suspend and resume stages.
So they shall be registered during the probe even the phy is already
initialized.

The function cdns_torrent_reset is renamed cdns_torrent_of_get_reset() to
make it clear.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index e64625859a07..7b3a409da185 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -2678,7 +2678,7 @@ static int cdns_torrent_clk_register(struct cdns_torrent_phy *cdns_phy)
 	return 0;
 }
 
-static int cdns_torrent_reset(struct cdns_torrent_phy *cdns_phy)
+static int cdns_torrent_of_get_reset(struct cdns_torrent_phy *cdns_phy)
 {
 	struct device *dev = cdns_phy->dev;
 
@@ -2847,6 +2847,10 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = cdns_torrent_of_get_reset(cdns_phy);
+	if (ret)
+		goto clk_cleanup;
+
 	ret = cdns_torrent_of_get_clk(cdns_phy);
 	if (ret)
 		goto clk_cleanup;
@@ -2854,10 +2858,6 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	regmap_field_read(cdns_phy->phy_pma_cmn_ctrl_1, &already_configured);
 
 	if (!already_configured) {
-		ret = cdns_torrent_reset(cdns_phy);
-		if (ret)
-			goto clk_cleanup;
-
 		ret = cdns_torrent_clk(cdns_phy);
 		if (ret)
 			goto clk_cleanup;

-- 
2.39.2



Return-Path: <linux-kernel+bounces-36795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5635983A6C2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7DB81F23AE6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC371A5A2;
	Wed, 24 Jan 2024 10:27:36 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804BD182DA
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 10:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706092056; cv=none; b=WonVkS9ORnFxZkZbb+xqEwpFC6+6QhM3DQ8fhWNWVUPwirLYWDmi3iQGXH6+7O0HFK/rw6HVyzseviNjXOOdD5YhQfMAmjwFhI9YFVr3lYTo7byYStOZlSzy+MVKb63FtdRrCSQ4VEvScKDxkJMAkuU0BBQhUikHLuXimeIwzJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706092056; c=relaxed/simple;
	bh=Thg4BMK6uSig59Zh4d2Kwh3BFWvxU3LN+ZVR1ChvhQg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HNeSYc7jt6FBqbSuP+3TxpHHQynXaFmr0V0lZkNALgTsK9ce0T6Y25uRQadEISRXnfr9SOyZj9OsQQJPztpF5+IwTmWgVYpWWaG+pardXdwacwczgAevshNOhhcsJ3ypzum2eNd3OLLYPInLtte6lOpDLbPHmICoLUf68lGfJVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fpf@pengutronix.de>)
	id 1rSaTd-0007Ts-70; Wed, 24 Jan 2024 11:27:25 +0100
Received: from [2a0a:edc0:0:1101:1d::54] (helo=dude05.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <fpf@pengutronix.de>)
	id 1rSaTc-0022Ga-Kq; Wed, 24 Jan 2024 11:27:24 +0100
Received: from fpf by dude05.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <fpf@pengutronix.de>)
	id 1rSaTc-005aNc-1t;
	Wed, 24 Jan 2024 11:27:24 +0100
From: Fabian Pfitzner <f.pfitzner@pengutronix.de>
To: Michael Hennerich <michael.hennerich@analog.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: kernel@pengutronix.de,
	Fabian Pfitzner <f.pfitzner@pengutronix.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] net: phy: adin: add recovered clock output
Date: Wed, 24 Jan 2024 11:25:56 +0100
Message-Id: <20240124102554.1327853-2-f.pfitzner@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240122110311.2725036-1-f.pfitzner@pengutronix.de>
References: <20240122110311.2725036-1-f.pfitzner@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: fpf@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The ADIN1300 offers three distinct output clocks which can be accessed
through the GP_CLK pin. The DT only offers two of the possible options
and thus the 125MHz-recovered output clock is missing.

As there is no other way to configure this pin than through the DT it
should be possible to do so for all available outputs.

Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
---
 drivers/net/phy/adin.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/adin.c b/drivers/net/phy/adin.c
index 2e1a46e121d9..b1ed6fd24763 100644
--- a/drivers/net/phy/adin.c
+++ b/drivers/net/phy/adin.c
@@ -508,6 +508,8 @@ static int adin_config_clk_out(struct phy_device *phydev)
 		sel |= ADIN1300_GE_CLK_CFG_25;
 	} else if (strcmp(val, "125mhz-free-running") == 0) {
 		sel |= ADIN1300_GE_CLK_CFG_FREE_125;
+	} else if (strcmp(val, "125mhz-recovered") == 0) {
+		sel |= ADIN1300_GE_CLK_CFG_RCVR_125;
 	} else if (strcmp(val, "adaptive-free-running") == 0) {
 		sel |= ADIN1300_GE_CLK_CFG_HRT_FREE;
 	} else {
-- 
2.39.2



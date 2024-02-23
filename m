Return-Path: <linux-kernel+bounces-78661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 334B28616BE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D48971F2508C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0C083CC4;
	Fri, 23 Feb 2024 16:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HYmO3Zcf"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02EB839E7;
	Fri, 23 Feb 2024 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704124; cv=none; b=ZPctSxAw/uJQ57Cp04qiYSbr9g4o1n/jnAMZJRcYP3Q21XJ9ktbvoTVUeeUXsSWXlcz8D5xdLdjYfgliYOIdc1m2vzU8gjrUi4Z8TNvhlATq4m2Oq33gl2qtLrVavuvVr21ltgz0xFMidnbrZH58Ww9DXjkGykBe2vLgpaFpAQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704124; c=relaxed/simple;
	bh=q8gayPiwbn3DoQkReGZdNHiZIgysS8TjOWehSXNblhI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o2l4psD7Ee2Rqta784eCTIQzknyk84ZyoVJQNoopX0HndjZFoAflDV+r6XIwSq+k9+/1eHg1qcdXoJNNWYqmMxjnbP0zGfgqt2NbLuuD7kwyrOsmDd/ClCoClQ8QFm80H0gUBkUm8eSBrBDe5KSlzahNvlEJ0U3FUh00u70ZfGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HYmO3Zcf; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 36D7D60003;
	Fri, 23 Feb 2024 16:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708704120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wuOxqHDRO4c85kOWnz8YWbV2JxBU725ZE17Xns/ymXY=;
	b=HYmO3ZcfXfkVIqM0zZfeZ4LXgyhsb578iADrwbLeuQKX6sl6blGv5LMut/OrTSWD72C5v9
	Qt7t0PgVqB8XpaIGVXg+XAYEYrluMr3OPhXehMFEYSPnS9nWQGW+loeVPNIwbVla//4v8L
	Z+XSdAalA0ZtpoAs9bKUJoB/Gk6zDhL9xOC5ngoi1fT11SYkXNikUguAOJxwRd43OcXtGa
	l3JQcP2F9x+vZY+yXX5tGDDTWM+AuHJ/jkNr9wbtZ6UxC2+B3Z296luzD9ncU0YkAU/Pd3
	XgCZE7qYrVXkQTibypvoGd8WewYSLGzUWrf+or7ECSM0mZfu3OVkpxp3+8Z8aw==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Johan Hovold <johan@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com
Subject: [PATCH net] net: phy: phy_device: free the phy_device on the phy_device_create error path
Date: Fri, 23 Feb 2024 17:01:54 +0100
Message-ID: <20240223160155.861528-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

When error'ing out from phy_device_create(), the previously kzalloc'd "dev"
pointer gets overwritten with an error pointer, without freeing it
beforehand, thus leaking the allocated phy_device. Add the missing kfree
back.

Fixes: d02cbc461361 ("net: phy: fix memory leak in device-create error path")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 3611ea64875e..2b4d04e3d479 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -711,6 +711,7 @@ struct phy_device *phy_device_create(struct mii_bus *bus, int addr, u32 phy_id,
 
 	if (ret) {
 		put_device(&mdiodev->dev);
+		kfree(dev);
 		dev = ERR_PTR(ret);
 	}
 
-- 
2.43.2



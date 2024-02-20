Return-Path: <linux-kernel+bounces-73529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC3A85C3CC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36F9C28514D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5BC14A4DF;
	Tue, 20 Feb 2024 18:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CQaKaP65"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8094A13342A;
	Tue, 20 Feb 2024 18:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708454551; cv=none; b=K6DDnlrnV8MLZXRdv6c+go4YF4yqWlmUkk+ivt/ZUC5q8yP+L6/hvO10k+vqVS318wEW1r/Txr+vxHIb1lZAIOt+qqfs+IIwMBCbJi65/21ewgIdhzDiamV6703Qmff6vURDxuXDnhFhx9cnNYYXomzwb2L62Wdu7jltZfWmfQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708454551; c=relaxed/simple;
	bh=N7zX1b9QujjnwAyXWeCiTGbJkCf6zWTLACTR9p9HYkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lllAM2X+H+1pGq51e0LJXBnxfFdzaG+gbqRwdg0Oh06AKpODe1iAGtMGmVM9XakoteQYuOT/3goW7OQHeUA/eMN5V9AftZf3DjNO8KR1mcS8n2NHQFd0fz/H93N4bf4GAhz6vXSojh+bmnACM1wMVPLMqsZLEIW4nZKqAKBTQaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CQaKaP65; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B1A746000C;
	Tue, 20 Feb 2024 18:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708454547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3aN+Do2Vm+gV4n5drRYBltMQr5b0yzMBmZzBYY1BSHQ=;
	b=CQaKaP65P5yp/NONqWPtkjATjMaSfrnTS+2jUouAx7CmbZMkW40FmRqr483l9skOD+xKV4
	q/XUWgahrkwiZoCx3PjRV1We0cH3G/xQ4X3kq+W2cuLMnpsNFrQYljSIpalii7iaKkUTvf
	X4m1BHBJ3poWjfudfaCX5lhy4hWjX9se98EFPZz+tVK1yBrE1d6eZqm4muOEqN11mG6pJP
	orBNk2zsuXNj8ZttouDL6pHUTOXH8Hc60nTuGp5bTUhQ0Uw5YWDcTr6S4RLBpE36qCe1SM
	Zg5SlIwSuGxWqGGhlwZz0xhGOa2pWbq3x+VgMVq95e2k4T0SyUHk4FoZ8tx4GQ==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org
Subject: [PATCH net-next v8 04/13] net: sfp: Add helper to return the SFP bus name
Date: Tue, 20 Feb 2024 19:42:07 +0100
Message-ID: <20240220184217.3689988-5-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220184217.3689988-1-maxime.chevallier@bootlin.com>
References: <20240220184217.3689988-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Knowing the bus name is helpful when we want to expose the link topology
to userspace, add a helper to return the SFP bus name.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
V8: - No changes
V7: - No changes
V6: - No changes
V5: - Added Andrew's R-b
V4: - No changes
V3: - Added RTNL assert
    - Made the stub inline
V2: New patch
 drivers/net/phy/sfp-bus.c | 11 +++++++++++
 include/linux/sfp.h       |  6 ++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/net/phy/sfp-bus.c b/drivers/net/phy/sfp-bus.c
index e05013aeecc3..413021619afe 100644
--- a/drivers/net/phy/sfp-bus.c
+++ b/drivers/net/phy/sfp-bus.c
@@ -859,3 +859,14 @@ void sfp_unregister_socket(struct sfp_bus *bus)
 	sfp_bus_put(bus);
 }
 EXPORT_SYMBOL_GPL(sfp_unregister_socket);
+
+const char *sfp_get_name(struct sfp_bus *bus)
+{
+	ASSERT_RTNL();
+
+	if (bus->sfp_dev)
+		return dev_name(bus->sfp_dev);
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(sfp_get_name);
diff --git a/include/linux/sfp.h b/include/linux/sfp.h
index 0573e53b0c11..55c0ab17c9e2 100644
--- a/include/linux/sfp.h
+++ b/include/linux/sfp.h
@@ -570,6 +570,7 @@ struct sfp_bus *sfp_bus_find_fwnode(const struct fwnode_handle *fwnode);
 int sfp_bus_add_upstream(struct sfp_bus *bus, void *upstream,
 			 const struct sfp_upstream_ops *ops);
 void sfp_bus_del_upstream(struct sfp_bus *bus);
+const char *sfp_get_name(struct sfp_bus *bus);
 #else
 static inline int sfp_parse_port(struct sfp_bus *bus,
 				 const struct sfp_eeprom_id *id,
@@ -648,6 +649,11 @@ static inline int sfp_bus_add_upstream(struct sfp_bus *bus, void *upstream,
 static inline void sfp_bus_del_upstream(struct sfp_bus *bus)
 {
 }
+
+static inline const char *sfp_get_name(struct sfp_bus *bus)
+{
+	return NULL;
+}
 #endif
 
 #endif
-- 
2.43.2



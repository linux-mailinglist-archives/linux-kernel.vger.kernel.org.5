Return-Path: <linux-kernel+bounces-8889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC73481BDC9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AF581C24304
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A0C634F9;
	Thu, 21 Dec 2023 18:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="J31c6vCb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E35064AA0;
	Thu, 21 Dec 2023 18:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 28CCE1C000C;
	Thu, 21 Dec 2023 18:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703181657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ITNuUCoNP4s99jBMgEvKjUP+EuwHLWosDtc700xOI2s=;
	b=J31c6vCbqoze4gmtIRgEynkkjwDAc0ukSww2JVl0+4eJuh6lSzN5FuI82RtvdR4qjZhfbd
	aL5cnQX5HHhom3E6qhvCdCRc+3jrT1gP0D514dRz0Ob9zOIXMG9fAYJO5rSu5oGwy5z0xO
	Q3CYN68+R62Ci/Ig7I8MwM9d7Xi0nkkIwUWE6r88yaA0UL/lWJutyDUH0B8NzU78lAzUdb
	cubYDLSq8/o3aCQ7LguceB0zXqOXxk7jd5ylYJ+2zAUUfOJuxSx+FCECFN4Po0mOR/OQrZ
	Jm/09zgQlmypxMv+kWBA/J8UdPBAf5cgj9+7ZC1ftCDGUFceVIKZaOPR7ayNdg==
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
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v5 04/13] net: sfp: Add helper to return the SFP bus name
Date: Thu, 21 Dec 2023 19:00:37 +0100
Message-ID: <20231221180047.1924733-5-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221180047.1924733-1-maxime.chevallier@bootlin.com>
References: <20231221180047.1924733-1-maxime.chevallier@bootlin.com>
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
V5: - Added Andrew's R-b
V4: - No changes
V3: - Added RTNL assert
    - Made the stub inline
V2: New patch

 drivers/net/phy/sfp-bus.c | 11 +++++++++++
 include/linux/sfp.h       |  6 ++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/net/phy/sfp-bus.c b/drivers/net/phy/sfp-bus.c
index 3a86c41e1235..fb1c102714b5 100644
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
2.43.0



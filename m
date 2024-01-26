Return-Path: <linux-kernel+bounces-40504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DE283E1B5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E471828370C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC93225AD;
	Fri, 26 Jan 2024 18:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OrhTnjJz"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7494D22313;
	Fri, 26 Jan 2024 18:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706294347; cv=none; b=jgsodRZgATXwToiNpJoV1H1ilDG4A+W4BbL+Yqk9YDAUrT51mCsFr/rQcu5LE2Zoyl1WsJpCZt6pY5bwxKdTVFQ9481GL+hzgKYefd6hQGD4EzLfxzlooQLmATzUWaj5QMzShYWWsoyXY/kH/d26caQXC86L3k6ldAhBVm9R1gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706294347; c=relaxed/simple;
	bh=U20RYnz8rF9juh0UmUHYKNcMfNP26AD1KmnNhJa4bf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zzud6GS5TzITTyN8YO7XQmED4BH8jP3vwIprNkTuRGRY3y4YKKMtIRZCjLzmGRk0oJawJlB7SIuFm4VrIshszYQgoS6GmavK6yHe4qRMJder2VrVotaEtXjlBfQ3W//jF78d3SbRS3lC/pzD2liNxbD164HF1gqzJWcIOjpMttw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OrhTnjJz; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A4C15FF806;
	Fri, 26 Jan 2024 18:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706294337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6LykSJuCAtTtaLaUiT8gF7SuiQuiQAaqE/9uRrER0vo=;
	b=OrhTnjJzd/oKIFDokdPhwJ3wOcnvQXYauUyAdPATEJz+P36wNhLSxnqPpo6CPHHf8O7K3J
	PiOVR+TQ/M2SW2YJsOvg79E+UjTD39lhUTDp4NAseBADFtSthttFgcgn1hX8zaYOtGSxjf
	0PtB5vWZldvuCNPPeuOrbZh4pLyRAPuvSJ6Zal5/H/94kU+7DE/v233Q9Z3HzvA/RXIR1/
	RUP2y3dKZ2DHtVCw9ThjA4VsfMe5gVug21PMIt9ZXBQLsfAVrxy6LW0HAaz5wMVZQW+lB6
	OufxbCxiX6b5ELoaZFqQ+Fg4vyEEfD87gWLL5PpxUn9z4j7l7yue9pr4Z4XVeQ==
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
Subject: [PATCH net-next v6 02/13] net: sfp: pass the phy_device when disconnecting an sfp module's PHY
Date: Fri, 26 Jan 2024 19:38:39 +0100
Message-ID: <20240126183851.2081418-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126183851.2081418-1-maxime.chevallier@bootlin.com>
References: <20240126183851.2081418-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Pass the phy_device as a parameter to the sfp upstream .disconnect_phy
operation. This is preparatory work to help track phy devices across
a net_device's link.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V6: Moved an incorrectly added hunk from the previous series to patch 0003
V5: No changes
V4: No changes
V3: No changes

 drivers/net/phy/phylink.c | 3 ++-
 drivers/net/phy/sfp-bus.c | 4 ++--
 include/linux/sfp.h       | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index ed0b4ccaa6a6..a816391add12 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -3385,7 +3385,8 @@ static int phylink_sfp_connect_phy(void *upstream, struct phy_device *phy)
 	return ret;
 }
 
-static void phylink_sfp_disconnect_phy(void *upstream)
+static void phylink_sfp_disconnect_phy(void *upstream,
+				       struct phy_device *phydev)
 {
 	phylink_disconnect_phy(upstream);
 }
diff --git a/drivers/net/phy/sfp-bus.c b/drivers/net/phy/sfp-bus.c
index db39dec7f247..e05013aeecc3 100644
--- a/drivers/net/phy/sfp-bus.c
+++ b/drivers/net/phy/sfp-bus.c
@@ -486,7 +486,7 @@ static void sfp_unregister_bus(struct sfp_bus *bus)
 			bus->socket_ops->stop(bus->sfp);
 		bus->socket_ops->detach(bus->sfp);
 		if (bus->phydev && ops && ops->disconnect_phy)
-			ops->disconnect_phy(bus->upstream);
+			ops->disconnect_phy(bus->upstream, bus->phydev);
 	}
 	bus->registered = false;
 }
@@ -742,7 +742,7 @@ void sfp_remove_phy(struct sfp_bus *bus)
 	const struct sfp_upstream_ops *ops = sfp_get_upstream_ops(bus);
 
 	if (ops && ops->disconnect_phy)
-		ops->disconnect_phy(bus->upstream);
+		ops->disconnect_phy(bus->upstream, bus->phydev);
 	bus->phydev = NULL;
 }
 EXPORT_SYMBOL_GPL(sfp_remove_phy);
diff --git a/include/linux/sfp.h b/include/linux/sfp.h
index 9346cd44814d..0573e53b0c11 100644
--- a/include/linux/sfp.h
+++ b/include/linux/sfp.h
@@ -544,7 +544,7 @@ struct sfp_upstream_ops {
 	void (*link_down)(void *priv);
 	void (*link_up)(void *priv);
 	int (*connect_phy)(void *priv, struct phy_device *);
-	void (*disconnect_phy)(void *priv);
+	void (*disconnect_phy)(void *priv, struct phy_device *);
 };
 
 #if IS_ENABLED(CONFIG_SFP)
-- 
2.43.0



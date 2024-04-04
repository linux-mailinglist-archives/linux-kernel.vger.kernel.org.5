Return-Path: <linux-kernel+bounces-131175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 049CC898409
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23A951C2616C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E7A81AC6;
	Thu,  4 Apr 2024 09:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mghyWQyp"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4389277F1E;
	Thu,  4 Apr 2024 09:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712223018; cv=none; b=lO4c9KpbdVKpmLq63gFn8yPIuOHNlCjiKqDTbQEGkrBZje1M8G+9miLBoMAw0cUrdjbOyE+n8645hO1hqlt83gtzqh5KmpkG5jFERMtErWii3m6qaI1T0SRae9If1h07O7tbf9s8S8ZES1LhAWMdeu/cdnqCr5lPSVoTJb6Y/Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712223018; c=relaxed/simple;
	bh=rK0CM1sBCffF/nr4O17g7ADAmcAbrG7D+QC0dduS4mY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UfnuFTJJVTr2GzZWpI/XVKkEhEYA4cC53f6+Mhojo646upaVj7SPeP0rYlMh0HCRFkQwuKr/8TLQNmjMlI1OhAQtyeqL4U5Ca573EBWAEOVJheERzqhHVR8YwDwnGL/AikkaPn8IwceETMhZTKTa+r/Hhaj3imHDR3kdBXwDQLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mghyWQyp; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5C81BC0002;
	Thu,  4 Apr 2024 09:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712223014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S1iLmfkC7iV/duSPnT2odwBCnUC2F5PO4YYKfwlTnPY=;
	b=mghyWQypDL3yl22J/Pwg7sqDOo9dSDbySrwwpurZqolaIutG9+ggzZ/A/equfSOKavMlKQ
	jjwhihDPFSVPhHr5yCzduSjfY1Qg3cyrhGJX/qi6BwVE4OjeNwoDQYwNircVwWivQTALak
	DsQ0Yj18KCK1znO8wyRBAlJFW8P7fbhg7jWmZB40Myg8ReWHZPbp3CyqR30nagPnbrsQBp
	NInMCWv3NtHXS63CmPvPMshOWQ8bYctAB9abqxncEuNESwJKpwxvJnvFeTsEYo7c2trsuM
	31XPjQYWyI1f0ql9l/JyIgN74WYSyjaq4tmJSv1zAqN6GecgzoLBWJ3eD/geEw==
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
Subject: [PATCH net-next v11 04/13] net: sfp: Add helper to return the SFP bus name
Date: Thu,  4 Apr 2024 11:29:54 +0200
Message-ID: <20240404093004.2552221-5-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404093004.2552221-1-maxime.chevallier@bootlin.com>
References: <20240404093004.2552221-1-maxime.chevallier@bootlin.com>
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
V11: - No changes
V10: - No changes
V9: - No changes
V8: - No changes
V7: - No changes
V6: - No changes
V5: - Added Andrew's R-b
V4: - No changes
V3: - Added RTNL assert

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
2.44.0



Return-Path: <linux-kernel+bounces-83422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C287F8698DB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 632041F2425E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E14114EFE7;
	Tue, 27 Feb 2024 14:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SPoJ3vKj"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A6214A4FC;
	Tue, 27 Feb 2024 14:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709045005; cv=none; b=V82OrKQH7ttF8UYSXlnA2lMTA+1TLQ3Jf428Im/gO1nX98DUnanq2nHiuU4rSco7HhDdqnropjtgv46zQI1nctwtE3Khsy2GAVKz85pF+0Qp5lxFYqIAqJshLD6mG1A0xLh9v4yb/9bTxmYBqm6OWdnkRqok3LwDkQYW2wWkyz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709045005; c=relaxed/simple;
	bh=n1A97LQ0bbRroHE/OmYnJJny49H5xiu5Cp8qf+fD+ss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ogckmf8jFpL3op4Dk4fNjOh4I8yEgVSgVm5UNpc8UvGcVHGtYKtHWHEHIl5+n5sSK81JkeRe+2jrt8SLd6aWgCigvkM14Of3KUFyq6pm14b9wCjAlce4cBNZ17zilNhq+AUnJGZzGW0ZQN+tKNPFqmwKlRTaquBEeB3ECbPAcKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SPoJ3vKj; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D1FDA20016;
	Tue, 27 Feb 2024 14:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709045001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1KVffl/2BFXKFyEfZdLterxW4Hdi592VhExrmfm2rMc=;
	b=SPoJ3vKjPFlrwjYHN3EgUtaotWaxeUgnTqBIsCQhRLif1la0FF5EhFqoeztfs8zUMGOP5K
	I/gdXqUvwfgP4YTKikw1KZ6+dbKX+gfC8sMeOv0R4AiwA+lLEyqo768eY60K78W7hxfmki
	hC/BdwBimnfY7TynfQOemhbOc8J1hSSKg9FeWoffjHVL06XUNB5wd3IODjucuFw8ia1sF4
	ki4xzG/HBQzUXhhvFxTOmMjMd0yNoihWREThYLhnXmwrT8hAvwnqKgDBV0Ucl4DECa8yu4
	myIpYwsZuDfzNxkbP7LRpxYOc5FWj+OfjhckOYMJ2kSBG58bz9eFKCQWJLnnQg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 27 Feb 2024 15:42:54 +0100
Subject: [PATCH net-next v5 12/17] net: pse-pd: Add support for
 setup_pi_matrix callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240227-feature_poe-v5-12-28f0aa48246d@bootlin.com>
References: <20240227-feature_poe-v5-0-28f0aa48246d@bootlin.com>
In-Reply-To: <20240227-feature_poe-v5-0-28f0aa48246d@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, Mark Brown <broonie@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 devicetree@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com

Implement setup_pi_matrix callback to configure the PSE PI matrix. This
functionality is invoked before registering the PSE and following the core
parsing of the pse_pis devicetree subnode.

This patch is sponsored by Dent Project <dentproject@linuxfoundation.org>.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v3:
- New patch
---
 drivers/net/pse-pd/pse_core.c | 6 ++++++
 include/linux/pse-pd/pse.h    | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 9124eb3d6492..a2eb9a424668 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -178,6 +178,12 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
 	if (ret)
 		return ret;
 
+	if (pcdev->ops->setup_pi_matrix) {
+		ret = pcdev->ops->setup_pi_matrix(pcdev);
+		if (ret)
+			return ret;
+	}
+
 	mutex_lock(&pse_list_mutex);
 	list_add(&pcdev->list, &pse_controller_list);
 	mutex_unlock(&pse_list_mutex);
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index 01b3b9adfe2a..522115cc6cef 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -49,6 +49,7 @@ struct pse_control_status {
  *
  * @ethtool_get_status: get PSE control status for ethtool interface
  * @ethtool_set_config: set PSE control configuration over ethtool interface
+ * @setup_pi_matrix: setup PI matrix of the PSE controller
  */
 struct pse_controller_ops {
 	int (*ethtool_get_status)(struct pse_controller_dev *pcdev,
@@ -57,6 +58,7 @@ struct pse_controller_ops {
 	int (*ethtool_set_config)(struct pse_controller_dev *pcdev,
 		unsigned long id, struct netlink_ext_ack *extack,
 		const struct pse_control_config *config);
+	int (*setup_pi_matrix)(struct pse_controller_dev *pcdev);
 };
 
 struct module;

-- 
2.25.1



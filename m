Return-Path: <linux-kernel+bounces-119129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAFE88C490
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEED01C60019
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D38412BF2C;
	Tue, 26 Mar 2024 14:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NGPKy/lX"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3B0129A94;
	Tue, 26 Mar 2024 14:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711461906; cv=none; b=al8rSiSxRxZrr8/ZTnIzaUIHG0HUdCXlAk0noStHlg10IG/fma7JyxjiHB03j2AxOQvmdus07YE7j6G/nR7P3LU4CjvHriqMPexdsbp7lOySIhSY5aXuJ74lWMiuYbRZ85v/M5iUNIlS/uVVAeEdBWEbXBorN+c0s82wk9bDUXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711461906; c=relaxed/simple;
	bh=+rtiD1ToUIGXBWPFqwrNJw9MP3ELvUpMCh05kFr7RIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UoBrC74sA/bm6SygIFNGsv0pvjlqN6E2x//DjKb1l/ni9/1rcMJNOLTsdFEdZObUHjQb7tZ6kkCe89WI2kXogLkGsHaaFj736D6NUoZAL+BLr/ZqE+p7j7yOtWAqGIjGhsEu7FauWh/WXMI92cIw//6b1elWMs3JKCY9aKf0qz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NGPKy/lX; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6882E1C001A;
	Tue, 26 Mar 2024 14:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711461902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MbDRmYduAN77h42QpA8nZn2u553fvZh3kA4TeVc+KqY=;
	b=NGPKy/lXlp0xNedE+I1Rra+azOo0XX3MQkcyUNJFYuQInYoGh13yI5Wx2WOiuPStyHtmUp
	pkP8Sk5ejTBIta5OBL5to9649XBdHEJRQ/KQ/Pm/edJV1XTMFqA4DIkMW9wXXWytYMY5t9
	eTInFmcdhzY/1flDJc0+OF2MkuSFGDJQFr7fU1MEXKJYUcN0XOLPE7SMF8RKkuxhITFihj
	0ad+d9V/6kGwFC7bnbZFjOTOEEIhHwr25f+5LEHnLWSZQrhWSht4EgcbPKzCyEdTz3xhL+
	u/aOPfCRhorXVD66XyOGwWfNLgZKdVBE9bBMU0cS5K0vc9mX0QYEarbrPsWqaQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 26 Mar 2024 15:04:49 +0100
Subject: [PATCH net-next v6 12/17] net: pse-pd: Add support for
 setup_pi_matrix callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-feature_poe-v6-12-c1011b6ea1cb@bootlin.com>
References: <20240326-feature_poe-v6-0-c1011b6ea1cb@bootlin.com>
In-Reply-To: <20240326-feature_poe-v6-0-c1011b6ea1cb@bootlin.com>
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
X-Mailer: b4 0.14-dev
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Implement setup_pi_matrix callback to configure the PSE PI matrix. This
functionality is invoked before registering the PSE and following the core
parsing of the pse_pis devicetree subnode.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v3:
- New patch
---
 drivers/net/pse-pd/pse_core.c | 6 ++++++
 include/linux/pse-pd/pse.h    | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 5d1bf197c067..78513bda5bbb 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -215,6 +215,12 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
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
index e7ac48ef9f95..caa2e9bce3a3 100644
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



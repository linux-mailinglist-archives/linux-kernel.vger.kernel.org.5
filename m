Return-Path: <linux-kernel+bounces-58123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 053A884E1A2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89B32B22A0B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC157E57E;
	Thu,  8 Feb 2024 13:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="X8x45mic"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160F07AE56;
	Thu,  8 Feb 2024 13:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707397810; cv=none; b=rLARdAnIEDPUFzdUCGIvSKF7cYQs9jK8AmeixHum4MEkyze86tH6+atVovqlc+ViwRBWrrt4R66u4fcOdfuWi9Db58UnRXvGV++6S1kBbeduOSVVvMJSsczCt4AVxp3Ho39TksXqyAXGYFO97y9aIK4y+8YfkhtuviI4BEdApdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707397810; c=relaxed/simple;
	bh=jrF+PnzsQEzVVDDK9SQnoBvJsZ9Ly+O147FRAq6rKGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=khJRts7/JXHeJxkOij+UXm/I/oQBDEkZojE7T+xwV51IY5VVKJ7Ko2Iox6F10QL+p1aVJcNrcGWFl5aw7lMhUeUow9iOJGMBzifFpA2pL98Lygefwi49nVC/CZ9+aPV1fymMdvqGMu7VLz0QRgkAUjI7uN7HoLfDHj/TBgxoY8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=X8x45mic; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 76EEF1BF216;
	Thu,  8 Feb 2024 13:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707397806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xYcoa/aoqIKwA6jwslFsD4vFR+6svXmOQrkrfKofybQ=;
	b=X8x45micSQaT3Hx5mX8sZ9VAIacllnE9BK2LlsadWY974fwau/CphIdAq2idk00ar3OxoO
	ZHHcwndr1UFBoYXfV7NtJAMVm2PQoUVSdrrkqsoiJhrRTpjT98VKoiqUIjV6LSX4KI50Fp
	VCML79F5cPmDvJgNRHg+2xfH0zMevo7DQPVmEYdKDJYyY+z8SEpjYqHNh9agFEG5ewIOjE
	w7LCI//rGGcUghn+E6ynu785CrhBaorlBW3ydHZxY+Xg27UeM85DhD29t8QQTucoqZkQrA
	E1bb33PhbtCYJwi//vSdJwOXDpcvFWQ6az1f1F83AB7/5t1eO12TKCTMxlrbmg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 08 Feb 2024 14:08:49 +0100
Subject: [PATCH net-next v3 12/17] net: pse-pd: Add support for
 setup_pi_matrix callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240208-feature_poe-v3-12-531d2674469e@bootlin.com>
References: <20240208-feature_poe-v3-0-531d2674469e@bootlin.com>
In-Reply-To: <20240208-feature_poe-v3-0-531d2674469e@bootlin.com>
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

Sponsored-by: Dent Project <dentproject@linuxfoundation.org>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v3:
- New patch
---
 drivers/net/pse-pd/pse_core.c | 6 ++++++
 include/linux/pse-pd/pse.h    | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index e03d36793d18..59427c79858c 100644
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
index 6c48668cebe3..cf0eebb3b0a9 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -50,6 +50,7 @@ struct pse_control_status {
  *
  * @ethtool_get_status: get PSE control status for ethtool interface
  * @ethtool_set_config: set PSE control configuration over ethtool interface
+ * @setup_pi_matrix: setup PI matrix of the PSE controller
  */
 struct pse_controller_ops {
 	int (*ethtool_get_status)(struct pse_controller_dev *pcdev,
@@ -58,6 +59,7 @@ struct pse_controller_ops {
 	int (*ethtool_set_config)(struct pse_controller_dev *pcdev,
 		unsigned long id, struct netlink_ext_ack *extack,
 		const struct pse_control_config *config);
+	int (*setup_pi_matrix)(struct pse_controller_dev *pcdev);
 };
 
 struct module;

-- 
2.25.1



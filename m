Return-Path: <linux-kernel+bounces-67272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 018718568F5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3206E1C23388
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA546135416;
	Thu, 15 Feb 2024 16:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dk/k24uJ"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79176139596;
	Thu, 15 Feb 2024 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013020; cv=none; b=NFqDnqsU7zvObqU2w8KprR9bkEyAdtZ0uGnRzNIaOuXwqkfDEWcZORajCRQsZp2U2ExoRzPHndBvRjFDTZ+hMo+pb2PhVRGAaclZaAygeRKRwsMxbvwAG1M4Oy9VU/OPIOVf2ZkG8c2h7Wsc23ayHDSbKOzNhCDYINk/RojdvbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013020; c=relaxed/simple;
	bh=sevRnps/Jf1AGxhs4ieE6FlD3NCWc1YYLeE6rzxuxOA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OtqOqAf+SD8J9gd0FH/SjuO74dn8BVmmoxAt/2dR/wZFj/SZtbVeT+P7uC9BWh70T6bchV6khx77lIGuz9jsctlD/n4HIpIjfMmLSdk1oQyZKQDgDF7C7PchC2SsLb3rAuaQNvtV6Ocdf1TyrgGoOx5sRNo01jDquehVc347a9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dk/k24uJ; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C2F2220009;
	Thu, 15 Feb 2024 16:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708013016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xQqskjN/xqjQe87m4lh7bm+8/0PUUsHRlazCTYp5ByI=;
	b=dk/k24uJUSBGqbwjoB3DN0LQRLx4WgZwD/xfRZdk+9B83iwadoMdUtK9HrcwTyHPILJgKj
	f7OKT/0gqFdeFrXD9lvW9ufjC6DVC37Z3KPF4FVnRSSksI/L1dxEnIgRVil+5p6+a8kwLg
	pOw0L2yvgvNvJN2tTRt7nkfS+AnVcf+ooj/JMr6RsuHaZkWZN4GnGFXAvRWFEMycpOzM5e
	vQEUtsfnuOf9jHWcAEntmWNXwznCaI5ugN7kshxs48fZHbzM7nL0aMAI0R7rA2fLzKTY94
	XIAMNp/Jzl1RqHHuWk5SMGRITY0nY5q+vtqXMlzLHL+95cf+ly5bzxqTAbFLWg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 15 Feb 2024 17:02:53 +0100
Subject: [PATCH net-next v4 12/17] net: pse-pd: Add support for
 setup_pi_matrix callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-feature_poe-v4-12-35bb4c23266c@bootlin.com>
References: <20240215-feature_poe-v4-0-35bb4c23266c@bootlin.com>
In-Reply-To: <20240215-feature_poe-v4-0-35bb4c23266c@bootlin.com>
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



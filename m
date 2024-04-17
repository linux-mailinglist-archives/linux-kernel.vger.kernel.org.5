Return-Path: <linux-kernel+bounces-148700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 961338A8662
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C74681C2061D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB126142648;
	Wed, 17 Apr 2024 14:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="l0rP7Vk5"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8C6146592;
	Wed, 17 Apr 2024 14:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364902; cv=none; b=VMqv3wttpqickOwXpOwlfyIFfwndinNKllOuIPmIA9X+nXOWAf5B+uxNXlQi3FkhDeiqxntMAkNsv9k8goFQjI0MWshnVmvO4uOjtx1wvruiolC7xtcpUa+BuEGkbsjV/8MjbTbSTlNF9nujScotZCroNeOBFii0j4+VrXr+Vn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364902; c=relaxed/simple;
	bh=u2ZvkyyevjkvJ/3k9nSvtC4QezO8DURb/I514Z0BxbY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S+1006QPk3mTCJ+BjlVauM+0ojy/3/i5dDUsNOgKmYEI4hCXo4BkDeENTIVjK289RIA4aijJmnkv8J4mwrs3Mr8i7ko77jHNTGQP1P/PhrZzYQtDINaXihu/QzBjHmDcVF1stQdFowQiWqtZTQbYUS+0cs6NRGxakE+CJnrnyRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=l0rP7Vk5; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A610F1BF20A;
	Wed, 17 Apr 2024 14:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713364898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cECuaur6xBkX8FAIGxDkH2vewSpAArLyAPPvhCHjvWo=;
	b=l0rP7Vk5lpGF2u1P3T+skPwXDF9h+ZPv339naJAFc5p5UDHkirL3yXwezTqWr6OwNStV0o
	x1EskmeOq4bWrrptWWdhsYFs6PLJWdG15hsZtpK+RqMW8QtzZbrGTF42jSi6ryvdSksnQA
	LZ0W4VGSnz9vexAYqtZpju2irFNqwpqddTWBBy0DfgUQo0q5npDNr/OmIVGHzFrIg81ViC
	/82C0ufrdqietFJHgZMKKS+SqBEj3V4Fr3UyNwBeBocQRfzHYTAQMCCfkVA1UtNCsS8UvD
	qgGW68PHd2KVbL4+TEd/H2hzai3inN68kRtAjvnJHuOLAKXWg+X3iOV6mpT0hw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 17 Apr 2024 16:39:57 +0200
Subject: [PATCH net-next v9 09/14] net: pse-pd: Add support for
 setup_pi_matrix callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240417-feature_poe-v9-9-242293fd1900@bootlin.com>
References: <20240417-feature_poe-v9-0-242293fd1900@bootlin.com>
In-Reply-To: <20240417-feature_poe-v9-0-242293fd1900@bootlin.com>
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
 kernel@pengutronix.de, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14-dev
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Implement setup_pi_matrix callback to configure the PSE PI matrix. This
functionality is invoked before registering the PSE and following the core
parsing of the pse_pis devicetree subnode.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---

Changes in v3:
- New patch
---
 drivers/net/pse-pd/pse_core.c | 6 ++++++
 include/linux/pse-pd/pse.h    | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index ca5ced8e0d8a..a7ff7676ab77 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -223,6 +223,12 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
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
index e19d58b5e777..fa0c73da0cf1 100644
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
2.34.1



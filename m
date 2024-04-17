Return-Path: <linux-kernel+bounces-148688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F478A8633
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4259A2822FF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAEC1420C8;
	Wed, 17 Apr 2024 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KcENXQdd"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EEC22334;
	Wed, 17 Apr 2024 14:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364847; cv=none; b=Wrg0pPvTxLkLDWmMIvO0JKld/9JZ3LLpRBfcc+NnK2i8NDkfU8F3A1AbtAX6ur1QLL9krkmAyXGI2J3du/WFBBynkvpy1BHlppK9oxkuZyep5BP1plXtVXNcmKKzS2ck+elnr+6Iz7U6eZNiz0uzFJLGOLy1dlc5KR+A993XMDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364847; c=relaxed/simple;
	bh=l6RblOlXl3Z4QxQayRZcnk20p3UpL2HUX+J+Gz0pkp8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nME87NdWriqYtolyyO8M3tngpSzA4aRDcbSj+wOwIFMEsTTq3ONOx7CXpdejxaKZAxjFIvLucXrvYFRuq3JoDFzbpToKauhtzZnNedeypS25FyHzxKHRuiHGN0eDwE6l24bIVbnyGbJ0aG6hhMPay8PBncolXmNo7Zo0GgI765I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KcENXQdd; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BF6CD1BF21B;
	Wed, 17 Apr 2024 14:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713364842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X+YKNUMaqyQFYcQmtzuWIvO6540fSDFP2uwDUeOGZe4=;
	b=KcENXQddMF7F7+SheJ7VFPdhq5zMyY0f9Em52VPM93SknprROw3+0ZqnUpHq1PhnEWXSDv
	ffZoRswxx6AEHGsalLmDh3GLS+Ix1XZESl/XX4/sPxu4XQ1BXyqU9Us1V6V8KLck8BzP/j
	/1gOwO6XuUX4ZJGQRCYsku/YPasB0hM/mvPvAeSb1XtpGr5AY5QuSj1sSkCiB/L5oHs3YU
	lBEacM6EkJT5SqHzYhkkJQM5HEdlR7184wGj+zflhPUNf8mk398gUNKQsOu5WDHXiWq6iJ
	DQI1P9HWhLKi9l5PHbHZr8vmNpTXdPdlm5kiQlNju+DzTfH/xaEXMEaV1tm4dQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net-next v9 00/14] net: Add support for Power over Ethernet
 (PoE)
Date: Wed, 17 Apr 2024 16:39:48 +0200
Message-Id: <20240417-feature_poe-v9-0-242293fd1900@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADTfH2YC/23S20rEMBCA4VdZcm1lZjJNU698DxHJYeoGtF3aW
 laWvruxIN1QL4fh+0NIbmqSMcmknk43NcqSpjT0eWgfTiqcXf8uVYp5VgSkEYirTtz8NcrbZZA
 KdcstSKMZtMriMkqXrlvtRfUyV71cZ/WaN+c0zcP4vR2z4LbfioimKC5YQeWFLTD7jrh99sMwf
 6T+MQyfW2mhXRNgqSnr2kQbXDDQdO6o9Z9mILCl1r9aYyTTMJtWjprvNNal5qx17T0H0mRMOOr
 6TlNT6jprsh04x5bYxKM2u879UpusAwKiN+Iw+KNuds3QlrrJGlG0lS5ylH/ube80ln9gsVlLf
 iwUayC6utTruv4ADra3qmQCAAA=
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

This patch series aims at adding support for PoE (Power over Ethernet),
based on the already existing support for PoDL (Power over Data Line)
implementation. In addition, it adds support for two specific PoE
controller, the Microchip PD692x0 and the TI TPS23881.

3 patches has already been merged thanks to Jakub.

In detail:
- Patch 1 to 10 prepare net to support PoE devices.
- Patch 11 and 12 add PD692x0 PoE PSE controller driver and its binding.
- Patch 13 and 14 add TI TPS23881 PSE controller driver and its binding.

Changes in v9:
- Fix few kdoc return description missing.
- Fix a reference leak.
- Link to v8: https://lore.kernel.org/r/20240414-feature_poe-v8-0-e4bf1e860da5@bootlin.com

Changes in v8:
- Fix a build error due to an artifact from an ancient version of the
  series.
- Link to v7: https://lore.kernel.org/r/20240409-feature_poe-v7-0-11e38efd4dee@bootlin.com

Changes in v7:
- Fix code, doc and kdoc nit.
- Fix few pd692x0 dt binding issues.
- Rename *flash_fw* functions to *flash_sram_fw* in tps23881 driver.
- Link to v6: https://lore.kernel.org/r/20240326-feature_poe-v6-0-c1011b6ea1cb@bootlin.com

Changes in v6:
- TPS23881 fix firmware management release missing.
- Use pcdev device pointer as regulator consumer and provider.
- Rename of_legacy to no_of_pse_pi.
- Add kdoc, and separate functions for better readability.
- Add vpwr-supply regulator parent.
- Link to v5: https://lore.kernel.org/r/20240227-feature_poe-v5-0-28f0aa48246d@bootlin.com

Changes in v5:
- Fix bindings nit.
- Add supported-polarity parameter to bindings.
- Fix yamllint binding errors.
- Remove the nested lock brought by the use of regulator framework.
- Link to v4: https://lore.kernel.org/r/20240215-feature_poe-v4-0-35bb4c23266c@bootlin.com

Changes in v4:
- Replaced sponsored-by tag by a simple sentence.
- Fix pse_pi node bindings.
- Add pse pi documentation written by Oleksij.
- Link to v3: https://lore.kernel.org/r/20240208-feature_poe-v3-0-531d2674469e@bootlin.com

Changes in v3:
- Add patches to add Oleksij and myself to PSE MAINTAINERS.
- Add patches to add pse devlink.
- Add TI TPS23881 PSE controller driver with its binding.
- Replace pse_get_types helper by pse_has_podl and pse_has_c33
- Changed the PSE core bindings.
- Add a setup_pi_matrix callback.
- Register regulator for each PSE PI (Power Interface).
- Changed the PD692x0 bindings.
- Updated PD692x0 drivers to new bindings and PSE PI description.
- Updated PD692x0 drivers according to the reviews and made fixes.
- Link to v2: https://lore.kernel.org/r/20231201-feature_poe-v2-0-56d8cac607fa@bootlin.com

Changes in v2:
- Extract "firmware_loader: Expand Firmware upload error codes patches" to
  send it alone and get it merge in an immutable branch.
- Add "c33" prefix for PoE variables and enums.
- Enhance few comments.
- Add PSE Documentation.
- Make several changes in pd692x0 driver, mainly for readibility.
- Link to v1: https://lore.kernel.org/r/20231116-feature_poe-v1-0-be48044bf249@bootlin.com

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Kory Maincent (14):
      ethtool: Expand Ethernet Power Equipment with c33 (PoE) alongside PoDL
      net: pse-pd: Introduce PSE types enumeration
      net: ethtool: pse-pd: Expand pse commands with the PSE PoE interface
      netlink: specs: Modify pse attribute prefix
      netlink: specs: Expand the pse netlink command with PoE interface
      MAINTAINERS: Add myself to pse networking maintainer
      net: pse-pd: Add support for PSE PIs
      dt-bindings: net: pse-pd: Add another way of describing several PSE PIs
      net: pse-pd: Add support for setup_pi_matrix callback
      net: pse-pd: Use regulator framework within PSE framework
      dt-bindings: net: pse-pd: Add bindings for PD692x0 PSE controller
      net: pse-pd: Add PD692x0 PSE controller driver
      dt-bindings: net: pse-pd: Add bindings for TPS23881 PSE controller
      net: pse-pd: Add TI TPS23881 PSE controller driver

 .../bindings/net/pse-pd/microchip,pd692x0.yaml     |  169 +++
 .../bindings/net/pse-pd/pse-controller.yaml        |  101 +-
 .../bindings/net/pse-pd/ti,tps23881.yaml           |   95 ++
 Documentation/netlink/specs/ethtool.yaml           |   33 +-
 Documentation/networking/ethtool-netlink.rst       |   20 +
 Documentation/networking/index.rst                 |    1 +
 Documentation/networking/pse-pd/index.rst          |   10 +
 Documentation/networking/pse-pd/introduction.rst   |   73 ++
 Documentation/networking/pse-pd/pse-pi.rst         |  302 +++++
 MAINTAINERS                                        |    1 +
 drivers/net/pse-pd/Kconfig                         |   20 +
 drivers/net/pse-pd/Makefile                        |    2 +
 drivers/net/pse-pd/pd692x0.c                       | 1223 ++++++++++++++++++++
 drivers/net/pse-pd/pse_core.c                      |  515 ++++++++-
 drivers/net/pse-pd/pse_regulator.c                 |   49 +-
 drivers/net/pse-pd/tps23881.c                      |  820 +++++++++++++
 include/linux/pse-pd/pse.h                         |   79 +-
 include/uapi/linux/ethtool.h                       |   55 +
 include/uapi/linux/ethtool_netlink.h               |    3 +
 net/ethtool/pse-pd.c                               |   60 +-
 20 files changed, 3534 insertions(+), 97 deletions(-)
---
base-commit: 4103ffb31295dee66eaa0deba04b36c5051a2db4
change-id: 20231024-feature_poe-139490e73403

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com



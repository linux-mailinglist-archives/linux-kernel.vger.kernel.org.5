Return-Path: <linux-kernel+bounces-58114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFE084E182
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D657528B2E0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E75F79936;
	Thu,  8 Feb 2024 13:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aFIVupUA"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A233574E16;
	Thu,  8 Feb 2024 13:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707397806; cv=none; b=a/8vWOkxboawhohvJcFWM3Q5R3jeN+jg9PG/ess151KovvwWKyznpCGS39NkcvDuAhK0GzgqXR0ZRsQkwMDIA8Bn+Jws48hN1JMzB7ckdmZLycCqmRdOVmjRIelxV19Fnh+p7iV1/Tup4ByNhMt8xsKj/TAErKwO9HwtR89THRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707397806; c=relaxed/simple;
	bh=6ljt3iLa1k5EaaTfYjzMvfAkx/XmTBtdjgtg/PsRZvI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ItAQU2AKt4kHtyKrxXHERGhjyb2xQt90wha0rGVM1f5cILvcCj6yrj5Z6AZxWxHfHCi6+iRv8njJUEUFvFaxS5NMcyCWIPrhH6aYojmkL6+Ud+48saRKLxF89vae2Dm2bIRpKQtKxpkVAdBKUj0GlYPodR4Ylo3KI5VZgemTNio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aFIVupUA; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3440E1BF20A;
	Thu,  8 Feb 2024 13:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707397792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=awG7COaY5LB3i7Ks32m7L3WnMQtbwasRGppvFBPBHLs=;
	b=aFIVupUA1IGNffKpX6lp8PcRaIZoDYSAzq6E0M+65DP/wdPoeUMLWNXeuSKqeRhIHrd2pk
	UJl8ThqeXCGkIFLF5/3mgk8QrGmhW6Yc0pc46NDJY0tSQf+Hgkpc5S2z7jOJXmkCPWQREv
	3okNTUuWecf4AZnpJVKo2fK+7pL/jgpHvOo6dofQ2S1OfY4cuP9ZgnVTcY+vnEjd9zbiiS
	6aHdgbKX1ekjGjpFJfLoX9pUG0ghHP1JN0XXa+OADazFnXsbc9q8QxQlZ4q/XkokeyToFD
	bDUCaVrjX3Mba+Rqgm5TKvkA1k28gMpjBvMVfgnQvRXixgSTjLKA55QSmzZhuQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net-next v3 00/17] net: Add support for Power over Ethernet
 (PoE)
Date: Thu, 08 Feb 2024 14:08:37 +0100
Message-Id: <20240208-feature_poe-v3-0-531d2674469e@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFbSxGUC/1WNyw7CIBQFf8WwFnN52Icr/8MYQ+nFkig0gKSm6
 b9L2JguJyczZyURg8VILoeVBMw2Wu8KiOOB6Em5J1I7FiYcuGDAJTWo0ifgY/ZImehlD9gKCYI
 UYw5o7FJrN+IwUYdLIveyTDYmH771JrO61yJjza6YGQU6oOxAysFw2V8H79PLupP271rK/G9zY
 HubF/vcjJ1WuoHWqL29bdsP7EiHvvAAAAA=
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

This patch series aims at adding support for PoE (Power over Ethernet),
based on the already existing support for PoDL (Power over Data Line)
implementation. In addition, it adds support for two specific PoE
controller, the Microchip PD692x0 and the TI TPS23881.

In detail:
- Patch 1 to 13 prepare net to support PoE devices.
- Patch 14 and 15 add PD692x0 PoE PSE controller driver and its binding.
- Patch 16 and 17 add TI TPS23881 PSE controller driver and its binding.

Changes in v2:
- Extract "firmware_loader: Expand Firmware upload error codes patches" to
  send it alone and get it merge in an immutable branch.
- Add "c33" prefix for PoE variables and enums.
- Enhance few comments.
- Add PSE Documentation.
- Make several changes in pd692x0 driver, mainly for readibility.
- Link to v1: https://lore.kernel.org/r/20231116-feature_poe-v1-0-be48044bf249@bootlin.com

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

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Kory Maincent (17):
      MAINTAINERS: net: Add Oleksij to pse-pd maintainers
      of: property: Add fw_devlink support for pse parent
      net: pse-pd: Rectify and adapt the naming of admin_cotrol member of struct pse_control_config
      ethtool: Expand Ethernet Power Equipment with c33 (PoE) alongside PoDL
      net: pse-pd: Introduce PSE types enumeration
      net: ethtool: pse-pd: Expand pse commands with the PSE PoE interface
      netlink: specs: Modify pse attribute prefix
      netlink: specs: Expand the pse netlink command with PoE interface
      MAINTAINERS: Add myself to pse networking maintainer
      dt-bindings: net: pse-pd: Add another way of describing several PSE PIs
      net: pse-pd: Add support for PSE PIs
      net: pse-pd: Add support for setup_pi_matrix callback
      net: pse-pd: Use regulator framework within PSE framework
      dt-bindings: net: pse-pd: Add bindings for PD692x0 PSE controller
      net: pse-pd: Add PD692x0 PSE controller driver
      dt-bindings: net: pse-pd: Add bindings for TPS23881 PSE controller
      net: pse-pd: Add TI TPS23881 PSE controller driver

 .../bindings/net/pse-pd/microchip,pd692x0.yaml     |  157 +++
 .../bindings/net/pse-pd/pse-controller.yaml        |  101 +-
 .../bindings/net/pse-pd/ti,tps2388x.yaml           |  112 ++
 Documentation/netlink/specs/ethtool.yaml           |   33 +-
 Documentation/networking/ethtool-netlink.rst       |   20 +
 Documentation/networking/index.rst                 |    1 +
 Documentation/networking/pse-pd/index.rst          |    9 +
 Documentation/networking/pse-pd/introduction.rst   |   73 ++
 MAINTAINERS                                        |    8 +
 drivers/net/mdio/fwnode_mdio.c                     |   29 +-
 drivers/net/pse-pd/Kconfig                         |   20 +
 drivers/net/pse-pd/Makefile                        |    2 +
 drivers/net/pse-pd/pd692x0.c                       | 1223 ++++++++++++++++++++
 drivers/net/pse-pd/pse_core.c                      |  491 +++++++-
 drivers/net/pse-pd/pse_regulator.c                 |   49 +-
 drivers/net/pse-pd/tps23881.c                      |  818 +++++++++++++
 drivers/of/property.c                              |    2 +
 include/linux/pse-pd/pse.h                         |   89 +-
 include/uapi/linux/ethtool.h                       |   43 +
 include/uapi/linux/ethtool_netlink.h               |    3 +
 include/uapi/linux/pse.h                           |   23 +
 net/ethtool/pse-pd.c                               |   60 +-
 22 files changed, 3246 insertions(+), 120 deletions(-)
---
base-commit: 05f5c48cfac2335df9bb76fb6d49703670ce8b00
change-id: 20231024-feature_poe-139490e73403

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com



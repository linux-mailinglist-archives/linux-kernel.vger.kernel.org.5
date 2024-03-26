Return-Path: <linux-kernel+bounces-119119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB41288C46E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16BEEB22EE3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042A281753;
	Tue, 26 Mar 2024 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DiEiYc2m"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EBA74C0B;
	Tue, 26 Mar 2024 14:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711461899; cv=none; b=ZFdUbRIqLL3aAiVgPc/wXOBcEDYFOMwN3vLY7dUrFou8c/CFqRkAAD4ytSJo+mbbmDYZ2xwW8420UlbSmLN7yhtIHvflo0J0SDG4mX8tvWokRO6VTK5t05J/FhaVJTLgDsYaOM9HKi3qvOP2FtSeXa12mcGA7ORwqxN8g+axpzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711461899; c=relaxed/simple;
	bh=Bht56GKwfxqVLHT3PK85DitT4MWOhPng5tzAATBDR8s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qwJzeMA9QB6bS8ahFrZZXkVOK076EsfxCU7onl64mFJsrfM4SaOW7hW2DpnQSpZyf8xv/PNvYemY4aq/qQ4E3BpfGdEbJY6EDhF9bDd8C7cRZDsNc3hSNR6FKAAZfqgo/FY89olvekA64fEisMEGvOch4lQZHiYu7yHwOXeCRzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DiEiYc2m; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 43BF91C000A;
	Tue, 26 Mar 2024 14:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711461887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mDQJ6BqK7hwq+aJhog7TsYkjrfTNYhsBctyPN0Rrc+s=;
	b=DiEiYc2mkkpVcrbkbZWV4Gd4rOxwCqep4QznxAcskGy7ztIIciskxLpTbiVt8+9VqXvtGF
	iu9WlHAOTmsjsEXSDy+Z+zawJWDmpiKTYvz5eJYp++8TyJGLbGRst5skcrCOxfPvMmAYa9
	ovKQ75wGqPM3FYfLyJlwnJmc3nx1fA47S5mjtf2m2zP9SqHluts4ajAB+TEFY4ec89YC+S
	PQxDXGDCw3uKWJR4lspppfV04p1uKTX3j0aRHzqIuyX35SnFVj7kedgKODotvNgcJj9E3G
	lpwLvAtlxVvjiw3U8kCuT6naF6M96Sa5iCofmFBjRzEfXUC+qZCbmwvanIBB3A==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net-next v6 00/17] net: Add support for Power over Ethernet
 (PoE)
Date: Tue, 26 Mar 2024 15:04:37 +0100
Message-Id: <20240326-feature_poe-v6-0-c1011b6ea1cb@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPXVAmYC/2XN0UrEMBCF4VdZcm1kMpmmrVe+h4ik6cQNaLKks
 awsfXdjQdzQy8Pw/XMTC+fAi3g63UTmNSwhxTrMw0m4s43vLMNct0BArQBJerblK/PbJbFUeqQ
 RuNcEWlRxyezDda+9iMhFRr4W8Vov57CUlL/3N6va73tRKdMUVyVBTkwDEE0eaXyeUiofIT669
 LmXVvzXCKrVWHVn5sFZZ6D39qj1nyZAGFqtf7VWM5qeyIx81HSnVddqqlp300QONRrjjrq709i
 3uqsaBw/W0oBk5lZv2/YD4r6aUaoBAAA=
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

This patch series aims at adding support for PoE (Power over Ethernet),
based on the already existing support for PoDL (Power over Data Line)
implementation. In addition, it adds support for two specific PoE
controller, the Microchip PD692x0 and the TI TPS23881.

In detail:
- Patch 1 to 13 prepare net to support PoE devices.
- Patch 14 and 15 add PD692x0 PoE PSE controller driver and its binding.
- Patch 16 and 17 add TI TPS23881 PSE controller driver and its binding.

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
      net: pse-pd: Add support for PSE PIs
      dt-bindings: net: pse-pd: Add another way of describing several PSE PIs
      net: pse-pd: Add support for setup_pi_matrix callback
      net: pse-pd: Use regulator framework within PSE framework
      dt-bindings: net: pse-pd: Add bindings for PD692x0 PSE controller
      net: pse-pd: Add PD692x0 PSE controller driver
      dt-bindings: net: pse-pd: Add bindings for TPS23881 PSE controller
      net: pse-pd: Add TI TPS23881 PSE controller driver

 .../bindings/net/pse-pd/microchip,pd692x0.yaml     |  158 +++
 .../bindings/net/pse-pd/pse-controller.yaml        |  102 +-
 .../bindings/net/pse-pd/ti,tps23881.yaml           |   93 ++
 Documentation/netlink/specs/ethtool.yaml           |   33 +-
 Documentation/networking/ethtool-netlink.rst       |   20 +
 Documentation/networking/index.rst                 |    1 +
 Documentation/networking/pse-pd/index.rst          |   10 +
 Documentation/networking/pse-pd/introduction.rst   |   73 ++
 Documentation/networking/pse-pd/pse-pi.rst         |  302 +++++
 MAINTAINERS                                        |    8 +
 drivers/net/pse-pd/Kconfig                         |   20 +
 drivers/net/pse-pd/Makefile                        |    2 +
 drivers/net/pse-pd/pd692x0.c                       | 1223 ++++++++++++++++++++
 drivers/net/pse-pd/pse_core.c                      |  511 +++++++-
 drivers/net/pse-pd/pse_regulator.c                 |   49 +-
 drivers/net/pse-pd/tps23881.c                      |  818 +++++++++++++
 drivers/of/property.c                              |    2 +
 include/linux/pse-pd/pse.h                         |   86 +-
 include/uapi/linux/ethtool.h                       |   55 +
 include/uapi/linux/ethtool_netlink.h               |    3 +
 net/ethtool/pse-pd.c                               |   60 +-
 21 files changed, 3527 insertions(+), 102 deletions(-)
---
base-commit: f81d6cec4a4ed1b6580340a43ec68f3132423964
change-id: 20231024-feature_poe-139490e73403

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com



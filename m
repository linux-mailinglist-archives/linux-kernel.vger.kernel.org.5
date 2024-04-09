Return-Path: <linux-kernel+bounces-136712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A33E589D76F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5705D2826E3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49F485273;
	Tue,  9 Apr 2024 10:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Xp/Be+KY"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F9584A38;
	Tue,  9 Apr 2024 10:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712660337; cv=none; b=Owjb9W158E63vmPiR6c+5p842PFZXLuXfsHDpBDVgcJIXI5Jn0snQy0m1We1TP2CVGBq9C20WnQCDR7GswSLvGifjnO0mdSuuguUxiKTRkisvlux+avDtmLkiw3Q2ZXetSKlT3vEUHGoE/A+xDC+WayIPyvBIPFV35XhVo0onQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712660337; c=relaxed/simple;
	bh=xgdlhQ6no+eBBAb+8ul9yi1YXZyIFcsX7DxOmNDGJJo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TfH5KlpPLoHqbXsJuyVvQ/5bVoHc9vHZiH7IWcVLk6sQ+hNOWP+M8LPV/XEEDGZIh6OYC/X/lyFaDeepIruSEy+y0kgr48cEgsdFoyfmE0GvZqcKq8JZYmykiByyeFKYt4zbX5hLP4ErVV3r55pWdpBvDjbTttAb/M0X9wuTT9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Xp/Be+KY; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 92C1BC0005;
	Tue,  9 Apr 2024 10:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712660333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6JiJoj71wwbMuDRfP0xJZk24eqUqNdtQq+lnhKdtFz4=;
	b=Xp/Be+KYhX8cLiNvgJXLYasUPgi4VJJprc8ZAxNepBYojwjLX8MujPdt/9V53aMZCMamLp
	CSsrWCA3kiRG3i6RO8s5HLaHM+DooFh9C37r+w/OYt9DeA5PTfdKqh+lW/yr6Ce418x+DW
	bn8UzDo47ShIYAjJgvrBvixmTRJkkBGXfQeQ66CzkR2at5R4/o4A6S+cU1Ksq4wOLY1Gcg
	V1kvVVFjFXrNmjF2WdaUPGQDr4vyrYH7JU2PHWjZD8I8Lcy0UiWfd0Mf1z8PArrnbd0a4T
	ZFCytKTFzfMI6QMYbBNc+Z4+/4PiCNyM2oISgcTT0TyruKGxI3qxdUPf7s3xPA==
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
Subject: [PATCH net-next 0/8] net: Allow targeting specific PHYs through netlink
Date: Tue,  9 Apr 2024 12:58:38 +0200
Message-ID: <20240409105847.465298-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi everyone,

This series is a resend of the las 8 patches of the link_topology series:
https://lore.kernel.org/netdev/20240404093004.2552221-1-maxime.chevallier@bootlin.com/

There were a some conflicts on the netlink specs, which I guess made the
series fail to apply.

All patches of this series allow accessing and using the PHYs from the
topology through netlink commands such as PLCA, PSE-PD, Cable testing
and strsets, and introduces a dedicated command to list said PHYs.

This re-send is simply rebased on net-next, with the addition of
Andrew's Reviewed-by tags.

Thanks,

Maxime

Maxime Chevallier (8):
  netlink: specs: add phy-index as a header parameter
  net: ethtool: Introduce a command to list PHYs on an interface
  netlink: specs: add ethnl PHY_GET command set
  net: ethtool: plca: Target the command to the requested PHY
  net: ethtool: pse-pd: Target the command to the requested PHY
  net: ethtool: cable-test: Target the command to the requested PHY
  net: ethtool: strset: Allow querying phy stats by index
  Documentation: networking: document phy_link_topology

 Documentation/netlink/specs/ethtool.yaml      |  62 ++++
 Documentation/networking/ethtool-netlink.rst  |  45 +++
 Documentation/networking/index.rst            |   1 +
 .../networking/phy-link-topology.rst          | 120 +++++++
 include/uapi/linux/ethtool_netlink.h          |  20 ++
 net/ethtool/Makefile                          |   2 +-
 net/ethtool/cabletest.c                       |  16 +-
 net/ethtool/netlink.c                         |   9 +
 net/ethtool/netlink.h                         |   5 +
 net/ethtool/phy.c                             | 300 ++++++++++++++++++
 net/ethtool/plca.c                            |  19 +-
 net/ethtool/pse-pd.c                          |  13 +-
 net/ethtool/strset.c                          |  17 +-
 13 files changed, 594 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/networking/phy-link-topology.rst
 create mode 100644 net/ethtool/phy.c

-- 
2.44.0



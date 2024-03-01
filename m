Return-Path: <linux-kernel+bounces-88215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A82F986DEBA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45CE01F26D1A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCD26A8D6;
	Fri,  1 Mar 2024 10:02:06 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929F86A8C7
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 10:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709287326; cv=none; b=Bpb3JGAK57/3p2qfsDlD5yau1NN930QS4UW8pxs2HNhRhKv1DlrYEXSKZNKT3jSiLnOm3ZDOaXjsiLAR/RRdiJqIETjCjbfK+myL13fNVhboXtrXwFMwImHDvyfj7pdFHdvpU5B1cPzUXcpnFgC+IzI9zNNGW4P5W719ohtvucg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709287326; c=relaxed/simple;
	bh=Hey8MTEQ+kiZtaoQeCMuLmIe0okdIVTManbNr6MNuIs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CsaFFQv+FfyYUvhU9vaGrrw5oyPI3uaWhJ1B8oVvFY7s+ixO3ChwjrzVqdmv3AE28ZDtBHC2VbEBdqAkb562AOTed6RFZ6B5i6+K3wNP0+t6GH4mqK2chMjoDWL4tCwfPYbSCxYXNaFvosj19T3KFHEfBcZJe9HWlEX5A3cZOFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rfziG-0003oc-BA; Fri, 01 Mar 2024 11:01:56 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rfziE-003kq2-Fy; Fri, 01 Mar 2024 11:01:54 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rfziE-003tMA-1M;
	Fri, 01 Mar 2024 11:01:54 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Wei Fang <wei.fang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH net-next v7 0/8] net: ethernet: Rework EEE
Date: Fri,  1 Mar 2024 11:01:45 +0100
Message-Id: <20240301100153.927743-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hello all,

with Andrew's permission I'll continue mainlining this patches:

==============================================================

Most MAC drivers get EEE wrong. The API to the PHY is not very
obvious, which is probably why. Rework the API, pushing most of the
EEE handling into phylib core, leaving the MAC drivers to just
enable/disable support for EEE in there change_link call back.

MAC drivers are now expect to indicate to phylib if they support
EEE. This will allow future patches to configure the PHY to advertise
no EEE link modes when EEE is not supported. The information could
also be used to enable SmartEEE if the PHY supports it.

With these changes, the uAPI configuration eee_enable becomes a global
on/off. tx-lpi must also be enabled before EEE is enabled. This fits
the discussion here:

https://lore.kernel.org/netdev/af880ce8-a7b8-138e-1ab9-8c89e662eecf@gmail.com/T/

This patchset puts in place all the infrastructure, and converts one
MAC driver to the new API. Following patchsets will convert other MAC
drivers, extend support into phylink, and when all MAC drivers are
converted to the new scheme, clean up some unneeded code.

v8:
--
update phydev->link value before phy_link_down/up cycle

v7:
--
add phy_link_down() before phy_link_up()
rewrite comment for phy_ethtool_set_eee_noneg()
add check for changed tx_lpi_timer

v6:
--
Reword different comments. See per patch change comments.

v5:
--
Rebase against latest netdev-next
Use keee instead of eee struct

v4
--
Only convert one MAC driver
Drop all phylink code
Conform to the uAPI discision.

v3
--
Rework phylink code to add a new callback.
Rework function to indicate clock should be stopped during LPI

Andrew Lunn (7):
  net: phy: Add phydev->enable_tx_lpi to simplify adjust link callbacks
  net: phy: Add helper to set EEE Clock stop enable bit
  net: phy: Keep track of EEE configuration
  net: phy: Immediately call adjust_link if only tx_lpi_enabled changes
  net: phy: Add phy_support_eee() indicating MAC support EEE
  net: fec: Move fec_enet_eee_mode_set() and helper earlier
  net: fec: Fixup EEE

Russell King (1):
  net: add helpers for EEE configuration

 drivers/net/ethernet/freescale/fec_main.c | 84 ++++++++++-------------
 drivers/net/phy/phy-c45.c                 | 14 +++-
 drivers/net/phy/phy.c                     | 70 ++++++++++++++++++-
 drivers/net/phy/phy_device.c              | 28 ++++++++
 include/linux/phy.h                       |  9 ++-
 include/net/eee.h                         | 38 ++++++++++
 6 files changed, 189 insertions(+), 54 deletions(-)
 create mode 100644 include/net/eee.h

-- 
2.39.2



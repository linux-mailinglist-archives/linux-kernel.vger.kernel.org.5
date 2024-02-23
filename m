Return-Path: <linux-kernel+bounces-78060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50202860E82
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E605AB2579D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA5D5EE98;
	Fri, 23 Feb 2024 09:44:55 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9B85D47A
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681490; cv=none; b=k6Uvjov9e3CI4H9n6m6+DYaLZyzCg9Ipfll3vUfIGcCCwNXFnxOwxGOnfw7DCOWnGOMtXk2KgosMwvg+wg+razfrxVwiTkdcZv5pTIEcm3SPa3u5CrycqcQK2n6HMj1P6JM1KKHbqFH62sYJQl0VF4l4yQfS4tjBOP4l6l+glrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681490; c=relaxed/simple;
	bh=eGUoNpbhiUhfaIC/5XPE9QhKDcsiwIWCzFlVBZJ3nJM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sXyuzVCdCBxpSKH0hxr1o0Ff0ECS7rW3P6BMA7Bike4YDL2vzhFZFD8vanzDpSI3WxrYlaM0G7t3YUD4s9pezbVE16+VSyTHotHnq2T14dXIc3fdO8NpJT2eQ5IGnqXtXnwGylLz3Usduz09FAjc5O8BV2kyLvOA1AZhFHrM/K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rdS6W-00080j-F4; Fri, 23 Feb 2024 10:44:28 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rdS6V-002OkR-8m; Fri, 23 Feb 2024 10:44:27 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rdS6V-002tpH-0e;
	Fri, 23 Feb 2024 10:44:27 +0100
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
Subject: [PATCH net-next v6 0/8] net: ethernet: Rework EEE
Date: Fri, 23 Feb 2024 10:44:17 +0100
Message-Id: <20240223094425.691209-1-o.rempel@pengutronix.de>
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
 drivers/net/phy/phy-c45.c                 | 11 ++-
 drivers/net/phy/phy.c                     | 55 ++++++++++++++-
 drivers/net/phy/phy_device.c              | 28 ++++++++
 include/linux/phy.h                       |  9 ++-
 include/net/eee.h                         | 38 ++++++++++
 6 files changed, 170 insertions(+), 55 deletions(-)
 create mode 100644 include/net/eee.h

-- 
2.39.2



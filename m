Return-Path: <linux-kernel+bounces-89570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A11D486F227
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 20:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 229A5283FC2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 19:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2030B40BF0;
	Sat,  2 Mar 2024 19:53:21 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B183FE58
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 19:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709409200; cv=none; b=P2zns7rE1FTO3kArNjdLmJgx1I4rX8vvz/cF3R9iHtfzZJUxi/7j4AVZptHXb+wzPbNsX8pun/j75HKO95DgPrleBv59hqcw76vDPtizABYfHgUDSnfStS9b/xZqzF9YzF1vOBVoNo9njIBxyG31DAb2lhlBog7m+1GkW0bHV4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709409200; c=relaxed/simple;
	bh=5PK6t5MK6qdLayVDxtAU5uNq0dgDs5e78IFL5zYPofM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mSOUQtl9XxvJ/mzC75ySRzpptLDc5gUR9pgPx/o5JIy2GHQFv6OkulC4Zzr09NMh/rtHrZ/NLNVrtPRg0cqIfu0pHUQ+MTHNNUuitHRcHZ/XH6aG8bZ2I4MVVpskecLuxAAp+VfF9z/wRewajq3HLdyTiO2diEw/myoOquOTprY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rgVPx-0007Gs-Ln; Sat, 02 Mar 2024 20:53:09 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rgVPv-0041mB-MK; Sat, 02 Mar 2024 20:53:07 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rgVPv-00DSTt-21;
	Sat, 02 Mar 2024 20:53:07 +0100
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
Subject: [PATCH net-next v9 0/7] net: ethernet: Rework EEE
Date: Sat,  2 Mar 2024 20:52:59 +0100
Message-Id: <20240302195306.3207716-1-o.rempel@pengutronix.de>
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

v9:
--
change dst<>src order for eeecfg_to_eee() and eee_to_eeecfg()
drop phy_eee_clk_stop_enable() patch

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

Andrew Lunn (6):
  net: phy: Add phydev->enable_tx_lpi to simplify adjust link callbacks
  net: phy: Keep track of EEE configuration
  net: phy: Immediately call adjust_link if only tx_lpi_enabled changes
  net: phy: Add phy_support_eee() indicating MAC support EEE
  net: fec: Move fec_enet_eee_mode_set() and helper earlier
  net: fec: Fixup EEE

Russell King (1):
  net: add helpers for EEE configuration

 drivers/net/ethernet/freescale/fec_main.c | 84 ++++++++++-------------
 drivers/net/phy/phy-c45.c                 | 14 +++-
 drivers/net/phy/phy.c                     | 50 +++++++++++++-
 drivers/net/phy/phy_device.c              | 28 ++++++++
 include/linux/phy.h                       |  8 ++-
 include/net/eee.h                         | 38 ++++++++++
 6 files changed, 168 insertions(+), 54 deletions(-)
 create mode 100644 include/net/eee.h

-- 
2.39.2



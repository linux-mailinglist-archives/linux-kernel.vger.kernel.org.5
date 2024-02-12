Return-Path: <linux-kernel+bounces-62105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 993D1851B8F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E4AF1F25711
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A47D3F9E0;
	Mon, 12 Feb 2024 17:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RZPStI61"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07F23E47E;
	Mon, 12 Feb 2024 17:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707759196; cv=none; b=XlERMsZZ29ijKTzA4TtwmxLEB5exQUweFlO2dT08u5Yee7lPgvsT/w65kJs8aixLDipVjYgW9GpFzIL91Bf90dVVkUZB8CGHHh4wUMHd8aA8u7jgq8lip35yqFHJE+1xF7FaMW4Uk9m3c//39RDsNQod4yf9DrfG/lbbot1au+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707759196; c=relaxed/simple;
	bh=1WNcSCm6KZePCvvEnDtv7SkkgLZFrShYbxw2IujMJ9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y56AQQYtxoXeott3WYTcAEAiq48rwUuh/z6vDFQ5fe87GM69P4EKLcGDEIcE7ln1d21HfSNpQe1eAhTent9TORUn8zi367BgxJU1f0bRXkSGZ/xmiCDfppSM3pvvv/GPAo3P/7PUXAI8p+eJoCClGmve0WDat9RtKSvFh1MdtS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RZPStI61; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CE241240007;
	Mon, 12 Feb 2024 17:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707759191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wbzP1U4QOVSgSJ9arF/G/GvzIFiIjVnmU1NWNDzC0Dk=;
	b=RZPStI61/BDuqmhNlBmVsuLPUtf0OPscoYSoNvRzTwrEuczk+LldmgFmsU5N55A4nvNCHG
	e08D4sbxqG1eZWr/+0RdJhArimCS6es7pa/x16fK+KCSnicY/YzJfzqW1jszXqqtOkvBRa
	Eqxovh4Ta6X0/Ul9AubVOjYQKVO3sP7l96u9240wN/n0KUavItVTCQUI5ZnMBX1omuOdCC
	s/fnGgDsvw48NwmVcPvdugwQXj0E6bRxNXDrV8glKAKeE0EyFS+tWyTS8n4DnHxpAU1527
	Zzb8zRSJaLBZXS90zGy/Y5nVdPAAS5awVWvMZDHeQLtukm8jfVDoq5FDiLbmUQ==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>
Subject: [PATCH net-next 0/3] Introduce support for USGMII Inband Extensions
Date: Mon, 12 Feb 2024 18:33:03 +0100
Message-ID: <20240212173307.1124120-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello everyone,

This series follows (albeit with a lot of delay) the work that was
initiated when USGMII support was added a while ago [1], through the QUSGMII
variant. One of the differences between the QUSGMII mode and QSGMII is
the possibility to pass so-called "Extensions" within the preamble. So
far, the only extension documented in the USGMII standard is to pass
a 32-bits timestamp through the preamble, but the standard mentions
other possible usages in the future, such as a MACSec sectag for
example.

This series aims at adding support for such extensions and proposes a
phylib API to manipulate these.

It includes an example using the lan8814 PHY driver and the LAN966x MAC
driver, where both have to agree on using this mode to convey the
nanoseconds part of a PTP timestamp (the seconds part is still retreived
through MDIO accesses).

Thanks,

Maxime

[1] : https://lore.kernel.org/netdev/20220519135647.465653-1-maxime.chevallier@bootlin.com/

Maxime Chevallier (3):
  net: phy: Add support for inband extensions
  net: lan966x: Allow using PCH extension for PTP
  net: phy: micrel: Add QUSGMII support and PCH extension

 Documentation/networking/phy.rst              | 70 ++++++++++++++
 .../ethernet/microchip/lan966x/lan966x_main.h |  1 +
 .../ethernet/microchip/lan966x/lan966x_port.c | 12 +++
 .../ethernet/microchip/lan966x/lan966x_ptp.c  | 94 +++++++++++++++++--
 .../ethernet/microchip/lan966x/lan966x_regs.h | 64 +++++++++++++
 drivers/net/phy/micrel.c                      | 84 ++++++++++++++++-
 drivers/net/phy/phy.c                         | 86 +++++++++++++++++
 include/linux/phy.h                           | 28 ++++++
 8 files changed, 425 insertions(+), 14 deletions(-)

-- 
2.43.0



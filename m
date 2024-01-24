Return-Path: <linux-kernel+bounces-36984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1E183A9CF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 608FD1C2181A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0299A77637;
	Wed, 24 Jan 2024 12:33:26 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6C376910
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 12:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706099605; cv=none; b=KkGjVXmU/gcfNoauWmNVXpn3qElzKlAC9u2xE3jrJVTTKrY1b7E7W3n77f/dF/JvtpCKVi0TMuh1GZWIi5KzLu7nses/4nSm7Ew+fGvCh05OvQ4SguWiiasxi1z/A4OwAFF0GQDKQYtF/ul+bHgUC+zFAMHj8CaJOacdgFJ8rYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706099605; c=relaxed/simple;
	bh=ROs5IgYB+xi6Q8VgHMvLAKH4DGo69gM3UD3lu5Nd0rI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nKYE+D1N0JQ4OhMpS0MZhQ5jPkwDoKIfo7DxzPAQFu5WQgHJbkXp3gE1PMmUe43l4Hjo/uM4AaUx30+9ZnqKW6RKNa5VSMy/C86T43X1koiig+ZapbwB1dYHfonGnr2mZzuozgkueA7I95nSIALPAZ+hgKm4az3PLYnk+v9vuR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rScRR-0000Hy-6l; Wed, 24 Jan 2024 13:33:17 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rScRP-0023bP-87; Wed, 24 Jan 2024 13:33:15 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rScRP-0035AL-0a;
	Wed, 24 Jan 2024 13:33:15 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH net-next v4 0/3] net: dsa: microchip: implement PHY loopback 
Date: Wed, 24 Jan 2024 13:33:11 +0100
Message-Id: <20240124123314.734815-1-o.rempel@pengutronix.de>
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

changes v4:
- add Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com> to patch 3
- add Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com> to patch 3

changes v3:
- add Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com> to first 2
  patches
- move ksz879x specific loopback handling to separate functions

changes v2:
- add Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com> to first 2
  patches
- make sure reverse x-mas tree is present in all patches
- add new lines between if statements
- reword commit message of the 3. patch 

Oleksij Rempel (3):
  net: dsa: microchip: ksz8: move BMCR specific code to separate
    function
  net: dsa: microchip: Remove redundant optimization in ksz8_w_phy_bmcr
  net: dsa: microchip: implement PHY loopback configuration for KSZ8794
    and KSZ8873

 drivers/net/dsa/microchip/ksz8795.c     | 400 ++++++++++++++++--------
 drivers/net/dsa/microchip/ksz8795_reg.h |   1 +
 2 files changed, 270 insertions(+), 131 deletions(-)

-- 
2.39.2



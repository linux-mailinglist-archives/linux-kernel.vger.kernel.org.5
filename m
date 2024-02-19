Return-Path: <linux-kernel+bounces-71978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 005AB85AD57
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FC70B24750
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC4F54FA8;
	Mon, 19 Feb 2024 20:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="c1B3I38i"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3AF535D6;
	Mon, 19 Feb 2024 20:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708375266; cv=none; b=HUBNxNl8b95GpAgEIv3S4UrmyULRReedDzhhy4W9BeO+a0CVDD4ecayesiGAtO8P+gfrzhp1Zw0IBUfqX941MM+VfKTloLzb8BRRHsS/aFN8mc+juuBzCkq7FuA1bSVtqhusuB8LUWh9EwvSEFE6hWqh/ws95aubyhw9BU+2xRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708375266; c=relaxed/simple;
	bh=1XKmVkJGMse2FkEHAtATkVJsddA0KnJTeeuea388y+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dT/U37PiAt3EEzALYOZEhVngetUhiaj/QBIz0AvQ9fjGcL8r+Vf70n6se9BV92U2lqnhPvabM7R5gmyBRrPqHEMgf+nRzzOh50LTHD69Jph1QEFZ3bZRryqRXwbrq5w9gv1dDnsuqzovN+M+q5ucb15SGx09uIDYUzVlGh9V6AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=c1B3I38i; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id A15FFC0000E3;
	Mon, 19 Feb 2024 12:40:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com A15FFC0000E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1708375257;
	bh=1XKmVkJGMse2FkEHAtATkVJsddA0KnJTeeuea388y+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c1B3I38iTBsxlmBH/377DLgzNqwdGKLDMPupJr577dSUHU0oWJlqYW6rpUs2LpSDy
	 IuHW8yI79NOHtNOYoRjAMXXJgO3SfCqAbk+PVe0TM3qVq4w7+mT7ZusxF9em7LTBxx
	 REU7q2dgRZuemQW2YHYs7V6qsXQTMXb5vrN01U+o=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id D3F3018041CAC7;
	Mon, 19 Feb 2024 12:40:55 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org (open list),
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net-next v2 2/3] net: bcmgenet: Pass "main" clock down to the MDIO driver
Date: Mon, 19 Feb 2024 12:40:52 -0800
Message-Id: <20240219204053.471825-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219204053.471825-1-florian.fainelli@broadcom.com>
References: <20240219204053.471825-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GENET has historically had to create a MDIO platform device for its
controller and pass some auxiliary data to it, like a MDIO completion
callback. Now we also pass the "main" clock to allow for the MDIO bus
controller to manage that clock adequately around I/O accesses.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/genet/bcmmii.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index cbbe004621bc..7a21950da77c 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -476,6 +476,10 @@ static int bcmgenet_mii_register(struct bcmgenet_priv *priv)
 	ppd.wait_func = bcmgenet_mii_wait;
 	ppd.wait_func_data = priv;
 	ppd.bus_name = "bcmgenet MII bus";
+	/* Pass a reference to our "main" clock which is used for MDIO
+	 * transfers
+	 */
+	ppd.clk = priv->clk;
 
 	/* Unimac MDIO bus controller starts at UniMAC offset + MDIO_CMD
 	 * and is 2 * 32-bits word long, 8 bytes total.
-- 
2.34.1



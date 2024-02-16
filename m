Return-Path: <linux-kernel+bounces-69195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF024858596
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 014F11C22636
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EF8149000;
	Fri, 16 Feb 2024 18:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Kosdvd/0"
Received: from relay.smtp-ext.broadcom.com (unknown [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7448212BEA5;
	Fri, 16 Feb 2024 18:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708108973; cv=none; b=pyrV7aETUWV/Vh7Mx0zZGITxZEGqpGBJbmHiEnaKDp4exn/9cQi3/5YyKrN93CD2NdMVFActXz09HayTx7EFWUCeVz1M0CLb2I4z795mqhe1dH/qnmWJhUIIsfCWzZ0Jzpe/3+axfus+dkyK1x1g4K6FgTPjg0s4hIWyp4Swjhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708108973; c=relaxed/simple;
	bh=aYVN0ClhfDjP4lyRugwKQwrba9nObMXNir2vK77i6h8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IGtzpAADf8xzhyfgh/t/NgIIMe3EBAWueffYQyjB2NLPTcrLUYRevkb/GbMhXyKs7nAukcuBirbcaN8tjURRe9gBgZxtZwP823GzwD3Db+ISgiBBWNM1I4AT7wHsw7kCXC6DMjFuCs2gtIEH3Aa+atfZQBUG7NqdYvy70QwLDeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Kosdvd/0; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 5A595C001649;
	Fri, 16 Feb 2024 10:42:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 5A595C001649
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1708108964;
	bh=aYVN0ClhfDjP4lyRugwKQwrba9nObMXNir2vK77i6h8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kosdvd/0aXFCgAb/wSbT4QkgQzw0O6+P4UZsh6g9NqKv1Z3YpNL4exLRaPQE3MhHI
	 AJ0JF7oK6feH+Bu4GhKHVOZ8LprE/GpSoOXMo6LCv/KbjCFow+ss96vYdEu77rdeTQ
	 z14x9A9PeTWqUgTG0+jmbk6rf8c12n1gWXecUhhM=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id D2D7518041CAC6;
	Fri, 16 Feb 2024 10:42:42 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
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
Subject: [PATCH net-next 3/3] Revert "net: bcmgenet: Ensure MDIO unregistration has clocks enabled"
Date: Fri, 16 Feb 2024 10:42:37 -0800
Message-Id: <20240216184237.259954-4-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240216184237.259954-1-florian.fainelli@broadcom.com>
References: <20240216184237.259954-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit eac0aac07f6af47b8ba57c8064bf04ed6df73d1d ("net:
bcmgenet: Ensure MDIO unregistration has clocks enabled"). This is no
longer necessary now that the MDIO bus controller has a clock that it
can manage around the I/O accesses.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/genet/bcmmii.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index 7a21950da77c..9ada89355747 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -678,7 +678,5 @@ void bcmgenet_mii_exit(struct net_device *dev)
 	if (of_phy_is_fixed_link(dn))
 		of_phy_deregister_fixed_link(dn);
 	of_node_put(priv->phy_dn);
-	clk_prepare_enable(priv->clk);
 	platform_device_unregister(priv->mii_pdev);
-	clk_disable_unprepare(priv->clk);
 }
-- 
2.34.1



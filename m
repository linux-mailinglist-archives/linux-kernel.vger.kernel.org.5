Return-Path: <linux-kernel+bounces-71975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6311185AD53
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D1B6B233B2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91BC53E08;
	Mon, 19 Feb 2024 20:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WA993cE8"
Received: from relay.smtp-ext.broadcom.com (unknown [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBEA50267;
	Mon, 19 Feb 2024 20:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708375265; cv=none; b=W1yPAec7knUFOvk2WZCERNxpXiAGt3nWJ/GFNhcgZwAhYo+WY3ugt77LXoJbJVkK34ZsnYcm9OEH8MF9BURa2p7ZH0cFN8TsiSxUbEl0T0UjKATx3E3xvt8r/V5CIl7/ZSzeAWNFbQUFxKbf5ksa2hJAqC71RpxuIQKhnhLGOlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708375265; c=relaxed/simple;
	bh=o0TlAjqIB1czzINK/rdoqCJ5lVeAGeS7FC7bZcSamiY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ulcD1rrm2m6bgdG21j6QpFBsh3wWyHPgDoiSJwUYdlC2WSnywrjmRVat3z5DwNSAILsZbOD7PBZtqEcY2py2eGb7u2No7t5EyO2tS8lp5mOwAWsiIIYvBAclHnHM24Y4OsIFpLcXtVrzt6iu6jLwtGK8ZHWJOZpwdvLA9e6RAdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WA993cE8; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 87A5DC003B80;
	Mon, 19 Feb 2024 12:40:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 87A5DC003B80
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1708375257;
	bh=o0TlAjqIB1czzINK/rdoqCJ5lVeAGeS7FC7bZcSamiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WA993cE8MyTCiGVAijtq+cwOqHy0emZjkb0SIvPNlCiIIBuZdvCdMA1r8ZkbShTVC
	 y83hso+wdYgRpnjeHvDrk2GTZnrooZFm4NhgzHv+t5JX2hxSpRrEK/yRXYk03yVLLj
	 nTgjAtB0SPJa01DIb5QkNYZ7eHSsdYRrOkVXfxFY=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 0989518041CAC4;
	Mon, 19 Feb 2024 12:40:56 -0800 (PST)
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
Subject: [PATCH net-next v2 3/3] Revert "net: bcmgenet: Ensure MDIO unregistration has clocks enabled"
Date: Mon, 19 Feb 2024 12:40:53 -0800
Message-Id: <20240219204053.471825-4-florian.fainelli@broadcom.com>
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

This reverts commit 1b5ea7ffb7a3bdfffb4b7f40ce0d20a3372ee405 ("net:
bcmgenet: Ensure MDIO unregistration has clocks enabled"). This is no
longer necessary now that the MDIO bus controller has a clock that it
can manage around the I/O accesses.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
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



Return-Path: <linux-kernel+bounces-94550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B7287413E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73E4228711E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919D51419A2;
	Wed,  6 Mar 2024 20:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="kFyJm9c6"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E0060250;
	Wed,  6 Mar 2024 20:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709756030; cv=none; b=Zqkw7dLTLHpmk5WawbO6tnOUsDYm+LRE7M+uqM+edCL5U4OQSD21rGj95ueQIt2HhgdAYG3ukjk4PWE3f5AFFHrTHJlRmVGHCFmEEpYHNgUgwsVdE6u9k1NqK6ZM7zJeBTnX8jKSmMxA/ZM5j+MgRbePR+Pzpkp7P/yXEqnD3nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709756030; c=relaxed/simple;
	bh=rAnJtzfRsWJZwGzIDXpwXhY4p4LSVYOL62mHk1jLZOw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JvWn68g5DrDjLETiRdLcRbd04UzcEl0dAEZ6QVGPs1CVZ0c8p2jbvxAulodl/ly/s096fmXEIYuEKLBhxciRVurxEWw/qC8Mzr05EwYyBF+er/oPA6C3BvPDiQ8wLuTWSQuSf+xYai0NN5RR8cjY2cOdHwmGvxBUPmkgEALcl78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=kFyJm9c6; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id C2008C0000F5;
	Wed,  6 Mar 2024 12:04:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com C2008C0000F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1709755488;
	bh=rAnJtzfRsWJZwGzIDXpwXhY4p4LSVYOL62mHk1jLZOw=;
	h=From:To:Cc:Subject:Date:From;
	b=kFyJm9c6s4H07GlIrjh+RboECL5o1RtQrDDT15LJhKYBFtto292h+wyC53+c5EmOm
	 k3PRkTm4uB0mH+bigf4hyG3KPBxTbiOhik1ZM9GBW6HoohOPHGfdtQ4lSTllgmt1Ov
	 +4swbldgKPtrR3PWtEi+JW2fc/ttu+GYGkSq/QiI=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id F320718041CAC4;
	Wed,  6 Mar 2024 12:04:46 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: leitao@debian.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: dsa: Leverage core stats allocator
Date: Wed,  6 Mar 2024 12:04:09 -0800
Message-Id: <20240306200416.2973179-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core
and convert veth & vrf"), stats allocation could be done on net core
instead of in this driver.

With this new approach, the driver doesn't have to bother with error
handling (allocation failure checking, making sure free happens in the
right spot, etc). This is core responsibility now.

Remove the allocation in the DSA user network device code and leverage
the network core allocation instead.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 net/dsa/user.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index 9c42a6edcdc8..16d395bb1a1f 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -2625,11 +2625,7 @@ int dsa_user_create(struct dsa_port *port)
 	user_dev->vlan_features = conduit->vlan_features;
 
 	p = netdev_priv(user_dev);
-	user_dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
-	if (!user_dev->tstats) {
-		free_netdev(user_dev);
-		return -ENOMEM;
-	}
+	user_dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 
 	ret = gro_cells_init(&p->gcells, user_dev);
 	if (ret)
@@ -2695,7 +2691,6 @@ int dsa_user_create(struct dsa_port *port)
 out_gcells:
 	gro_cells_destroy(&p->gcells);
 out_free:
-	free_percpu(user_dev->tstats);
 	free_netdev(user_dev);
 	port->user = NULL;
 	return ret;
@@ -2716,7 +2711,6 @@ void dsa_user_destroy(struct net_device *user_dev)
 
 	dsa_port_phylink_destroy(dp);
 	gro_cells_destroy(&p->gcells);
-	free_percpu(user_dev->tstats);
 	free_netdev(user_dev);
 }
 
-- 
2.34.1



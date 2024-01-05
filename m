Return-Path: <linux-kernel+bounces-17664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D6C8250E3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64638B232D0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A1024B4C;
	Fri,  5 Jan 2024 09:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="lKkhwhSr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E3224B42
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 09:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from pop-os.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id LgU0rtez5ELO0LgU7rh96e; Fri, 05 Jan 2024 10:27:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1704446844;
	bh=UNWAgG72CqrXdtBAJ+FNWG2kto2YDA/1pTgcQwka+VI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lKkhwhSrDn69hiAMrqfNEGcDBu+hjcHBHvmLgWlD3XhybkD2TMKxjZOhx8vwjYLZO
	 KDJsTMbzRhDehOQqn39m8kwvPbqjK4bAhGGNANlnYVWHtkDRx9hu4GPhZeDHKF1xw/
	 crY25q3MEt/XE5hn+HAVlT3reY4kPHVdl728AWoOKhFJm57SM+32cYJE7OUL5fIGmj
	 aJlbDtv5Q43A5M2o8E86BjYRi6mz2hfZsdlDsScOFwUqWvqzTaes8O0gx6kRsRVDvt
	 j7cV16p93jr4MN4/S0dEDaI/2RWOX7t+0sBoTtLCkJiuYAEXnIylA5NUn0EqPsx4de
	 D40rup6OL6oyQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 05 Jan 2024 10:27:24 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: alexis.lothore@bootlin.com,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH 2/2 net-next] ipvlan: Remove usage of the deprecated ida_simple_xx() API
Date: Fri,  5 Jan 2024 10:27:09 +0100
Message-Id: <216fe71e690580aede0d3def17b767d9559edd3a.1704446747.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <5adda8a3ce7af63bc980ba6b4b3fbfd6344e336b.1704446747.git.christophe.jaillet@wanadoo.fr>
References: <5adda8a3ce7af63bc980ba6b4b3fbfd6344e336b.1704446747.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

This is less verbose.

Note that the upper bound of ida_alloc_range() is inclusive while the one
of ida_simple_get() was exclusive. So calls have been updated accordingly.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ipvlan/ipvlan_main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index e080e4fc41e4..df7c43a109e1 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -605,11 +605,11 @@ int ipvlan_link_new(struct net *src_net, struct net_device *dev,
 	 * Assign IDs between 0x1 and 0xFFFE (used by the master) to each
 	 * slave link [see addrconf_ifid_eui48()].
 	 */
-	err = ida_simple_get(&port->ida, port->dev_id_start, 0xFFFE,
-			     GFP_KERNEL);
+	err = ida_alloc_range(&port->ida, port->dev_id_start, 0xFFFD,
+			      GFP_KERNEL);
 	if (err < 0)
-		err = ida_simple_get(&port->ida, 0x1, port->dev_id_start,
-				     GFP_KERNEL);
+		err = ida_alloc_range(&port->ida, 0x1, port->dev_id_start - 1,
+				      GFP_KERNEL);
 	if (err < 0)
 		goto unregister_netdev;
 	dev->dev_id = err;
@@ -641,7 +641,7 @@ int ipvlan_link_new(struct net *src_net, struct net_device *dev,
 unlink_netdev:
 	netdev_upper_dev_unlink(phy_dev, dev);
 remove_ida:
-	ida_simple_remove(&port->ida, dev->dev_id);
+	ida_free(&port->ida, dev->dev_id);
 unregister_netdev:
 	unregister_netdevice(dev);
 	return err;
@@ -661,7 +661,7 @@ void ipvlan_link_delete(struct net_device *dev, struct list_head *head)
 	}
 	spin_unlock_bh(&ipvlan->addrs_lock);
 
-	ida_simple_remove(&ipvlan->port->ida, dev->dev_id);
+	ida_free(&ipvlan->port->ida, dev->dev_id);
 	list_del_rcu(&ipvlan->pnode);
 	unregister_netdevice_queue(dev, head);
 	netdev_upper_dev_unlink(ipvlan->phy_dev, dev);
-- 
2.34.1



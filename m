Return-Path: <linux-kernel+bounces-17654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 747FA8250AE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 117001F25ED1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664E6241F4;
	Fri,  5 Jan 2024 09:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="gISJDb2b"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9FC22F17
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 09:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from pop-os.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id LgE0rfRMh6p30LgE0rFrb9; Fri, 05 Jan 2024 10:10:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1704445847;
	bh=MXdChQyNeoQudlbeZ137Nbqayn4386aGQ4NlEZhknHc=;
	h=From:To:Cc:Subject:Date;
	b=gISJDb2b89qzu7Z5Mnty4BKHTxd/WKra3CRJXdtiOLLIbGBs4Cr+SE7LjXVhFiEL1
	 zSStGSq6sHbUz06VHBCrW5/gNW8cOJ7IrCr8Ri2caA1EYQcxWri5d1ax13cjTeuR5s
	 vC9HyUY2BWkMxfTNn2uz1Np0O/QAFoQ39d9kUzyDYjpDUyA8ZjRiSDqExayAVw6VIu
	 R1McVLOF3y/C/HqSg0Ko/02vlFXTAkoM3JQ/iQzqI/BjxChv3nmpxPhlk9vKEHKZlk
	 Vhih/fuVyyQXztoaDiqrzCdyJc+MRa19G9zBXxzAI1D5zEawP5R5S92VM5U/466Jlr
	 Jxz8NMRjgJHQw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 05 Jan 2024 10:10:47 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Louis Peens <louis.peens@corigine.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: alexis.lothore@bootlin.com,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	oss-drivers@corigine.com,
	netdev@vger.kernel.org
Subject: [PATCH net-next] nfp: flower: Remove usage of the deprecated ida_simple_xx() API
Date: Fri,  5 Jan 2024 10:10:37 +0100
Message-Id: <de9e2b0be80f92dead2c8c66584bb34b9c95aab0.1704445716.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
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
of ida_simple_get() was exclusive.
So NFP_FL_LAG_GROUP_MAX has been decreased by 1. It now better watch the
comment stating that "1 to 31 are valid".

The only other user of NFP_FL_LAG_GROUP_MAX has been updated accordingly in
nfp_fl_lag_put_unprocessed().

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 .../net/ethernet/netronome/nfp/flower/lag_conf.c    | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c b/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c
index 88d6d992e7d0..361d7c495e2d 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c
@@ -76,7 +76,7 @@ struct nfp_fl_lag_group {
 /* Use this ID with zero members to ack a batch config */
 #define NFP_FL_LAG_SYNC_ID		0
 #define NFP_FL_LAG_GROUP_MIN		1 /* ID 0 reserved */
-#define NFP_FL_LAG_GROUP_MAX		32 /* IDs 1 to 31 are valid */
+#define NFP_FL_LAG_GROUP_MAX		31 /* IDs 1 to 31 are valid */
 
 /* wait for more config */
 #define NFP_FL_LAG_DELAY		(msecs_to_jiffies(2))
@@ -111,8 +111,8 @@ nfp_fl_lag_group_create(struct nfp_fl_lag *lag, struct net_device *master)
 
 	priv = container_of(lag, struct nfp_flower_priv, nfp_lag);
 
-	id = ida_simple_get(&lag->ida_handle, NFP_FL_LAG_GROUP_MIN,
-			    NFP_FL_LAG_GROUP_MAX, GFP_KERNEL);
+	id = ida_alloc_range(&lag->ida_handle, NFP_FL_LAG_GROUP_MIN,
+			     NFP_FL_LAG_GROUP_MAX, GFP_KERNEL);
 	if (id < 0) {
 		nfp_flower_cmsg_warn(priv->app,
 				     "No more bonding groups available\n");
@@ -121,7 +121,7 @@ nfp_fl_lag_group_create(struct nfp_fl_lag *lag, struct net_device *master)
 
 	group = kmalloc(sizeof(*group), GFP_KERNEL);
 	if (!group) {
-		ida_simple_remove(&lag->ida_handle, id);
+		ida_free(&lag->ida_handle, id);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -328,8 +328,7 @@ static void nfp_fl_lag_do_work(struct work_struct *work)
 			}
 
 			if (entry->to_destroy) {
-				ida_simple_remove(&lag->ida_handle,
-						  entry->group_id);
+				ida_free(&lag->ida_handle, entry->group_id);
 				list_del(&entry->list);
 				kfree(entry);
 			}
@@ -415,7 +414,7 @@ nfp_fl_lag_put_unprocessed(struct nfp_fl_lag *lag, struct sk_buff *skb)
 	struct nfp_flower_cmsg_lag_config *cmsg_payload;
 
 	cmsg_payload = nfp_flower_cmsg_get_data(skb);
-	if (be32_to_cpu(cmsg_payload->group_id) >= NFP_FL_LAG_GROUP_MAX)
+	if (be32_to_cpu(cmsg_payload->group_id) > NFP_FL_LAG_GROUP_MAX)
 		return -EINVAL;
 
 	/* Drop cmsg retrans if storage limit is exceeded to prevent
-- 
2.34.1



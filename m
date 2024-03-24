Return-Path: <linux-kernel+bounces-114388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D5C888A24
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BCAF290B50
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504AD2733FF;
	Sun, 24 Mar 2024 23:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbYh+P7P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892E11EFFCF;
	Sun, 24 Mar 2024 23:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321798; cv=none; b=bQ0BEnUGC/iA75xhY9JENSzykStFuxs8vKhouUImxlvX/4i7h6g2BBNo91vi2LLUarlcEUHNPmhTMz2s1ARF1nZYqj5sl26pkXyOdFF5stHDiDsQmQzdlIFinLfQvJmu33GONrWhGaU8FpnMOPx9RtYI7oQARZjLKUoYAJPrSL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321798; c=relaxed/simple;
	bh=BSBvgHhuRdZnX4OSUixX71vxRSdSk+SxhQsOZjZXyMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NgC6L/wWTXpl33t6z6AAns1LcU0dZ3uSnoUUfcidxqI9qCvPwAnvkZc6KImfj5Y2Q9WYpTnQiPrB5JEPWZPcD5W+gdlup137rMrlv/8tApX+J3h7SpoAUuhWcWu90Rh8FGq1PX7qE/MhJ1RAaRIwWWLvz/98HhVoeSz08G9efFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbYh+P7P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3744C433B1;
	Sun, 24 Mar 2024 23:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321797;
	bh=BSBvgHhuRdZnX4OSUixX71vxRSdSk+SxhQsOZjZXyMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QbYh+P7PkkrdXYKzclnmEFlDOrRBMr00/qWWU4vxYJxdKGsjU+DVL9GkikQDby1vF
	 K6eT2pKkCJUSxY0lTiA/Ol2rNJmQHbMfNoWtG9++Io3+nPax/rV92vJjByCVOqU36I
	 3mEuX94GLmcEW1so97Rnad8tN6PxLlfDMl4aRCX4GU0puCBasWXFJq5vXe8mRcMOnU
	 Tzo1v+WsPCCT7qSS0SnvVMKph+wjYZkOaCB11e2VaaOZ7yanT1dadaF/aE/XagyXww
	 5Rv5731GjXAu9arrKufGqCcoHw6V6MYpFXJa9xUuZPPNJnGEKpRng+3Bii+U4pVJfW
	 FbF28h7MBFIsQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shifeng Li <lishifeng@sangfor.com.cn>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 525/638] RDMA/device: Fix a race between mad_client and cm_client init
Date: Sun, 24 Mar 2024 18:59:22 -0400
Message-ID: <20240324230116.1348576-526-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Shifeng Li <lishifeng@sangfor.com.cn>

[ Upstream commit 7a8bccd8b29c321ac181369b42b04fecf05f98e2 ]

The mad_client will be initialized in enable_device_and_get(), while the
devices_rwsem will be downgraded to a read semaphore. There is a window
that leads to the failed initialization for cm_client, since it can not
get matched mad port from ib_mad_port_list, and the matched mad port will
be added to the list after that.

    mad_client    |                       cm_client
------------------|--------------------------------------------------------
ib_register_device|
enable_device_and_get
down_write(&devices_rwsem)
xa_set_mark(&devices, DEVICE_REGISTERED)
downgrade_write(&devices_rwsem)
                  |
                  |ib_cm_init
                  |ib_register_client(&cm_client)
                  |down_read(&devices_rwsem)
                  |xa_for_each_marked (&devices, DEVICE_REGISTERED)
                  |add_client_context
                  |cm_add_one
                  |ib_register_mad_agent
                  |ib_get_mad_port
                  |__ib_get_mad_port
                  |list_for_each_entry(entry, &ib_mad_port_list, port_list)
                  |return NULL
                  |up_read(&devices_rwsem)
                  |
add_client_context|
ib_mad_init_device|
ib_mad_port_open  |
list_add_tail(&port_priv->port_list, &ib_mad_port_list)
up_read(&devices_rwsem)
                  |

Fix it by using down_write(&devices_rwsem) in ib_register_client().

Fixes: d0899892edd0 ("RDMA/device: Provide APIs from the core code to help unregistration")
Link: https://lore.kernel.org/r/20240203035313.98991-1-lishifeng@sangfor.com.cn
Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Shifeng Li <lishifeng@sangfor.com.cn>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/device.c | 37 +++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 010718738d04c..db0a58c82838d 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1730,7 +1730,7 @@ static int assign_client_id(struct ib_client *client)
 {
 	int ret;
 
-	down_write(&clients_rwsem);
+	lockdep_assert_held(&clients_rwsem);
 	/*
 	 * The add/remove callbacks must be called in FIFO/LIFO order. To
 	 * achieve this we assign client_ids so they are sorted in
@@ -1739,14 +1739,11 @@ static int assign_client_id(struct ib_client *client)
 	client->client_id = highest_client_id;
 	ret = xa_insert(&clients, client->client_id, client, GFP_KERNEL);
 	if (ret)
-		goto out;
+		return ret;
 
 	highest_client_id++;
 	xa_set_mark(&clients, client->client_id, CLIENT_REGISTERED);
-
-out:
-	up_write(&clients_rwsem);
-	return ret;
+	return 0;
 }
 
 static void remove_client_id(struct ib_client *client)
@@ -1776,25 +1773,35 @@ int ib_register_client(struct ib_client *client)
 {
 	struct ib_device *device;
 	unsigned long index;
+	bool need_unreg = false;
 	int ret;
 
 	refcount_set(&client->uses, 1);
 	init_completion(&client->uses_zero);
+
+	/*
+	 * The devices_rwsem is held in write mode to ensure that a racing
+	 * ib_register_device() sees a consisent view of clients and devices.
+	 */
+	down_write(&devices_rwsem);
+	down_write(&clients_rwsem);
 	ret = assign_client_id(client);
 	if (ret)
-		return ret;
+		goto out;
 
-	down_read(&devices_rwsem);
+	need_unreg = true;
 	xa_for_each_marked (&devices, index, device, DEVICE_REGISTERED) {
 		ret = add_client_context(device, client);
-		if (ret) {
-			up_read(&devices_rwsem);
-			ib_unregister_client(client);
-			return ret;
-		}
+		if (ret)
+			goto out;
 	}
-	up_read(&devices_rwsem);
-	return 0;
+	ret = 0;
+out:
+	up_write(&clients_rwsem);
+	up_write(&devices_rwsem);
+	if (need_unreg && ret)
+		ib_unregister_client(client);
+	return ret;
 }
 EXPORT_SYMBOL(ib_register_client);
 
-- 
2.43.0



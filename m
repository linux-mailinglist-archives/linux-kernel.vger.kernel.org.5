Return-Path: <linux-kernel+bounces-113462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B648D888487
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E77021C23301
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC86F1B1FD3;
	Sun, 24 Mar 2024 22:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBsDZs8Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53C87174A;
	Sun, 24 Mar 2024 22:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320264; cv=none; b=iRk9nhpHIeYrIiyj+v2b86+HJ5eBOuqkawi50QjfFusn2QJANEal3sgcj8GQU36hMWv7wO+37hD58+mXi9kvLTTfPkfdsxieFLquIHjrov4z/ebWqc8/ZjKsk7+zixq4/EXKgbuYRQ6hPltipR4GjrsvsFgpSBJgNsTvqkPFxOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320264; c=relaxed/simple;
	bh=w9hTT74KPxpjUb9Jz1A1kgmJgCEjM1yGi+Xx/yRSAec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZno8mV0aAIS5PeKmNlSeCa4VE+z+OBc7Z+76t3NKt6hZYsN/q3tNRLU5SL2UTvmw1ZNPyiyhNc6N3YzqKQBujAmxeRM/YlA85cPLdWQXpnxZxbjXQujmb6UxV0oKJxCzFLYsTdIQ3+lK3UH8od995gY3YEv08Yw+AYQS1NiKe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBsDZs8Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE996C433A6;
	Sun, 24 Mar 2024 22:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320263;
	bh=w9hTT74KPxpjUb9Jz1A1kgmJgCEjM1yGi+Xx/yRSAec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NBsDZs8YvoThD6XRrd3NXZ2DVAbvfkI+A/Xf7rJecOHzpk7YgX5opcDjsDmyYQ68H
	 pK1HyyjJuxrj7jSmZA2jffLzy16NMUpg30IRJAQ0UY4c1vY2KHcmvDJCu8dF6ERlx/
	 iFEOb3XwZAin5e2tz4Dcgj+6ScD6KmPg2ruMPfMRLzzMyTsW2J8+qPy1Y/Ounr52Zz
	 VSHqp2SQlQWmhrMJhydaB8fmrgRQdN3WAo2kGaOrsXU/Dbtm+4CeqFAmJ8Xqzp2ESu
	 VFCBsB3JWTn0vEoeJ6wUUv/tXT39qsqGOG5u2yNTHtkmOCGOmvi2jQXOKN7cgQutxZ
	 WGi89oD6jvh8w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shifeng Li <lishifeng@sangfor.com.cn>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 571/715] RDMA/device: Fix a race between mad_client and cm_client init
Date: Sun, 24 Mar 2024 18:32:30 -0400
Message-ID: <20240324223455.1342824-572-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 67bcea7a153c6..07cb6c5ffda00 100644
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



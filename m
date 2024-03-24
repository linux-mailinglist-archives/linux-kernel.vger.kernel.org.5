Return-Path: <linux-kernel+bounces-114625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F026888B57
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1941F20F7F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB7318924D;
	Sun, 24 Mar 2024 23:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHG1UIrd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D02523450F;
	Sun, 24 Mar 2024 23:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322284; cv=none; b=uK9NAIKircSkQ/uNtOvXn2upmCC5htJNog3BumTcBOtdJ51apD9L3N6Xe74GgabxYkkbVR8KitcMV40qER112hL1kXCWx4Vq4kLJGPp/yJ4bELWJjRIrb2dZF4q7VMPrCCVfAPLrkty1UIQny3QSU0GnnCUazZ0TtJh/BD/GWKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322284; c=relaxed/simple;
	bh=/dAT7mbEKoCbSuc1yAk9d5DqRC3FGpKwwq0L/QuMFMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LIijw0HYndzYEApDlOy5CAJe67C7bVRiclb//tNOf8XpuJxiroXGnUqR0HziXCQ/6LeDlRMotpahEh2B17Z3mB8tnS12VcP0ge4XlJgx9b439Kz3Iq0xVuC+5gIwAVzT2Uoo/3JrJdPErSob5EitAI+y45hdwsVJxt+5Tn9Pej4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHG1UIrd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80FC8C433C7;
	Sun, 24 Mar 2024 23:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322283;
	bh=/dAT7mbEKoCbSuc1yAk9d5DqRC3FGpKwwq0L/QuMFMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WHG1UIrdYbAVJccfJnHrQQOW676n/bsSRtX2aHJ5o55YYsdsAf7F6BVhhMEKxq9bL
	 bJNZBWBM0mpK/hY2ePqBCLgCmp2ODteesUpLIo9OU5CGeEkM5g0KytfEG9MGrKSfZC
	 sPOzzt3rsHIVmS1h5rSl+1Bl/dZ5b9wBAKfGUK9lwWgXEQJhrGsR2aSQPKus2FjN7x
	 f1cm60vZHXf6pUDHcou/kzCeRUaMrpKYkXkO9HqU/UT1SQq2YjAWdQp4G6O7TU9iUZ
	 8lCpBItC2y7i3mEWBKIybAQJwtE5o0l21Egsbnxv5wghVTuIeP+nBbWXoRuGGuvut+
	 H9ti1cnkLOJlA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shifeng Li <lishifeng@sangfor.com.cn>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 366/451] RDMA/device: Fix a race between mad_client and cm_client init
Date: Sun, 24 Mar 2024 19:10:42 -0400
Message-ID: <20240324231207.1351418-367-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 3a9b9a28d858f..453188db39d83 100644
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



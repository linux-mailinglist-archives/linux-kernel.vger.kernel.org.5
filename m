Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B984077A929
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbjHMQKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjHMQKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:10:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D0E171F;
        Sun, 13 Aug 2023 09:09:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C316C639C6;
        Sun, 13 Aug 2023 16:09:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D85FC433C8;
        Sun, 13 Aug 2023 16:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691942942;
        bh=ue/Ai6RKwL0lcSy2kuBTBjDoCsGd2bPg7HDVZMm4BPQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hp/ZiysZVeKJWDfvjRnAUwVtmc01PYznLO9oBJPA7kT1Fv5xWVWMUs4LgtSrjBXM4
         mig5LpOtdfUiG2SQIFxHslrTfzPCXbGMgaWIp9o5McowG0Q9DPyxGWJtE4OnAW9bSE
         c5pUc7A8Zw+0Bp70g3JzZU8c+p1lFjElCZlBfFWqiRRdQ0hwah59wahXoZ2HacqzQc
         BurHPZ/tMd9Dge+K2yq+ac2KAgG0mChdwfYGOZGEiE0HQ9FVrlJuztSWZOVzlqXi2x
         SjY2NLI6fRBHq9+JHbSZ+LkInV40sSSg2E26VqlUMNbW6caKMsSWyZnwf3Az3mEszy
         LQ3khRFgi3rjw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Sasha Levin <sashal@kernel.org>, axboe@kernel.dk,
        xiubli@redhat.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, ceph-devel@vger.kernel.org,
        linux-block@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 29/31] rbd: harden get_lock_owner_info() a bit
Date:   Sun, 13 Aug 2023 12:06:02 -0400
Message-Id: <20230813160605.1080385-29-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813160605.1080385-1-sashal@kernel.org>
References: <20230813160605.1080385-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.126
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilya Dryomov <idryomov@gmail.com>

[ Upstream commit 8ff2c64c9765446c3cef804fb99da04916603e27 ]

- we want the exclusive lock type, so test for it directly
- use sscanf() to actually parse the lock cookie and avoid admitting
  invalid handles
- bail if locker has a blank address

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/rbd.c  | 21 +++++++++++++++------
 net/ceph/messenger.c |  1 +
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 189e2f74b9147..1d2ba739fb268 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3864,10 +3864,9 @@ static struct ceph_locker *get_lock_owner_info(struct rbd_device *rbd_dev)
 	u32 num_lockers;
 	u8 lock_type;
 	char *lock_tag;
+	u64 handle;
 	int ret;
 
-	dout("%s rbd_dev %p\n", __func__, rbd_dev);
-
 	ret = ceph_cls_lock_info(osdc, &rbd_dev->header_oid,
 				 &rbd_dev->header_oloc, RBD_LOCK_NAME,
 				 &lock_type, &lock_tag, &lockers, &num_lockers);
@@ -3888,18 +3887,28 @@ static struct ceph_locker *get_lock_owner_info(struct rbd_device *rbd_dev)
 		goto err_busy;
 	}
 
-	if (lock_type == CEPH_CLS_LOCK_SHARED) {
-		rbd_warn(rbd_dev, "shared lock type detected");
+	if (lock_type != CEPH_CLS_LOCK_EXCLUSIVE) {
+		rbd_warn(rbd_dev, "incompatible lock type detected");
 		goto err_busy;
 	}
 
 	WARN_ON(num_lockers != 1);
-	if (strncmp(lockers[0].id.cookie, RBD_LOCK_COOKIE_PREFIX,
-		    strlen(RBD_LOCK_COOKIE_PREFIX))) {
+	ret = sscanf(lockers[0].id.cookie, RBD_LOCK_COOKIE_PREFIX " %llu",
+		     &handle);
+	if (ret != 1) {
 		rbd_warn(rbd_dev, "locked by external mechanism, cookie %s",
 			 lockers[0].id.cookie);
 		goto err_busy;
 	}
+	if (ceph_addr_is_blank(&lockers[0].info.addr)) {
+		rbd_warn(rbd_dev, "locker has a blank address");
+		goto err_busy;
+	}
+
+	dout("%s rbd_dev %p got locker %s%llu@%pISpc/%u handle %llu\n",
+	     __func__, rbd_dev, ENTITY_NAME(lockers[0].id.name),
+	     &lockers[0].info.addr.in_addr,
+	     le32_to_cpu(lockers[0].info.addr.nonce), handle);
 
 out:
 	kfree(lock_tag);
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 57d043b382ed0..9bf085ddbe51f 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1144,6 +1144,7 @@ bool ceph_addr_is_blank(const struct ceph_entity_addr *addr)
 		return true;
 	}
 }
+EXPORT_SYMBOL(ceph_addr_is_blank);
 
 int ceph_addr_port(const struct ceph_entity_addr *addr)
 {
-- 
2.40.1


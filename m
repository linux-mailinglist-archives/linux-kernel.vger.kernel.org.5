Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDA877A84A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjHMQAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjHMQAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:00:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295581FCF;
        Sun, 13 Aug 2023 09:00:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA72F63361;
        Sun, 13 Aug 2023 15:52:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176ABC433CC;
        Sun, 13 Aug 2023 15:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691941956;
        bh=KgWKIBgLhOfCYAPVqpK0lpnnwFaJ1aaWjfZj4TZt6co=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iSoWFuO+rL3mjFwDxFh9lVY9016BU2KrN6me7plGfS3ii2uDEQVb//iGj4uoDVrWE
         uYgbMZ9bFcOS3++VnO/p5wxoz6oOqxpwa+hI2EtgeSWXOT35RS2iL3h40EZN7xHStI
         z/6vSRWPw7NyNE8vYKdR1KO7TdttUaeAeifzDHEshZo0YUaopg1kAE/JOPZ4n3872B
         o6jqIoLGYyGXrQN8KpjMZwj4Ytr8QPc/N5vJgHflXCK8dKD/YDo51Oawi9P7//SNA4
         j64vfxkSf1nSYsHZxGPdeQ90LEuwps7rSx6L/Uwf10GjUly1gJ6kxespsA9D5gojv9
         M6Omy3k/G+VFQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Sasha Levin <sashal@kernel.org>, axboe@kernel.dk,
        ceph-devel@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 47/54] rbd: make get_lock_owner_info() return a single locker or NULL
Date:   Sun, 13 Aug 2023 11:49:26 -0400
Message-Id: <20230813154934.1067569-47-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813154934.1067569-1-sashal@kernel.org>
References: <20230813154934.1067569-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.10
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

[ Upstream commit f38cb9d9c2045dad16eead4a2e1aedfddd94603b ]

Make the "num_lockers can be only 0 or 1" assumption explicit and
simplify the API by getting rid of output parameters in preparation
for calling get_lock_owner_info() twice before blocklisting.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/rbd.c | 84 +++++++++++++++++++++++++++------------------
 1 file changed, 51 insertions(+), 33 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 632751ddb2870..7c37c047dbea2 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3849,10 +3849,17 @@ static void wake_lock_waiters(struct rbd_device *rbd_dev, int result)
 	list_splice_tail_init(&rbd_dev->acquiring_list, &rbd_dev->running_list);
 }
 
-static int get_lock_owner_info(struct rbd_device *rbd_dev,
-			       struct ceph_locker **lockers, u32 *num_lockers)
+static void free_locker(struct ceph_locker *locker)
+{
+	if (locker)
+		ceph_free_lockers(locker, 1);
+}
+
+static struct ceph_locker *get_lock_owner_info(struct rbd_device *rbd_dev)
 {
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
+	struct ceph_locker *lockers;
+	u32 num_lockers;
 	u8 lock_type;
 	char *lock_tag;
 	int ret;
@@ -3861,39 +3868,45 @@ static int get_lock_owner_info(struct rbd_device *rbd_dev,
 
 	ret = ceph_cls_lock_info(osdc, &rbd_dev->header_oid,
 				 &rbd_dev->header_oloc, RBD_LOCK_NAME,
-				 &lock_type, &lock_tag, lockers, num_lockers);
-	if (ret)
-		return ret;
+				 &lock_type, &lock_tag, &lockers, &num_lockers);
+	if (ret) {
+		rbd_warn(rbd_dev, "failed to retrieve lockers: %d", ret);
+		return ERR_PTR(ret);
+	}
 
-	if (*num_lockers == 0) {
+	if (num_lockers == 0) {
 		dout("%s rbd_dev %p no lockers detected\n", __func__, rbd_dev);
+		lockers = NULL;
 		goto out;
 	}
 
 	if (strcmp(lock_tag, RBD_LOCK_TAG)) {
 		rbd_warn(rbd_dev, "locked by external mechanism, tag %s",
 			 lock_tag);
-		ret = -EBUSY;
-		goto out;
+		goto err_busy;
 	}
 
 	if (lock_type == CEPH_CLS_LOCK_SHARED) {
 		rbd_warn(rbd_dev, "shared lock type detected");
-		ret = -EBUSY;
-		goto out;
+		goto err_busy;
 	}
 
-	if (strncmp((*lockers)[0].id.cookie, RBD_LOCK_COOKIE_PREFIX,
+	WARN_ON(num_lockers != 1);
+	if (strncmp(lockers[0].id.cookie, RBD_LOCK_COOKIE_PREFIX,
 		    strlen(RBD_LOCK_COOKIE_PREFIX))) {
 		rbd_warn(rbd_dev, "locked by external mechanism, cookie %s",
-			 (*lockers)[0].id.cookie);
-		ret = -EBUSY;
-		goto out;
+			 lockers[0].id.cookie);
+		goto err_busy;
 	}
 
 out:
 	kfree(lock_tag);
-	return ret;
+	return lockers;
+
+err_busy:
+	kfree(lock_tag);
+	ceph_free_lockers(lockers, num_lockers);
+	return ERR_PTR(-EBUSY);
 }
 
 static int find_watcher(struct rbd_device *rbd_dev,
@@ -3947,51 +3960,56 @@ static int find_watcher(struct rbd_device *rbd_dev,
 static int rbd_try_lock(struct rbd_device *rbd_dev)
 {
 	struct ceph_client *client = rbd_dev->rbd_client->client;
-	struct ceph_locker *lockers;
-	u32 num_lockers;
+	struct ceph_locker *locker;
 	int ret;
 
 	for (;;) {
+		locker = NULL;
+
 		ret = rbd_lock(rbd_dev);
 		if (ret != -EBUSY)
-			return ret;
+			goto out;
 
 		/* determine if the current lock holder is still alive */
-		ret = get_lock_owner_info(rbd_dev, &lockers, &num_lockers);
-		if (ret)
-			return ret;
-
-		if (num_lockers == 0)
+		locker = get_lock_owner_info(rbd_dev);
+		if (IS_ERR(locker)) {
+			ret = PTR_ERR(locker);
+			locker = NULL;
+			goto out;
+		}
+		if (!locker)
 			goto again;
 
-		ret = find_watcher(rbd_dev, lockers);
+		ret = find_watcher(rbd_dev, locker);
 		if (ret)
 			goto out; /* request lock or error */
 
 		rbd_warn(rbd_dev, "breaking header lock owned by %s%llu",
-			 ENTITY_NAME(lockers[0].id.name));
+			 ENTITY_NAME(locker->id.name));
 
 		ret = ceph_monc_blocklist_add(&client->monc,
-					      &lockers[0].info.addr);
+					      &locker->info.addr);
 		if (ret) {
-			rbd_warn(rbd_dev, "blocklist of %s%llu failed: %d",
-				 ENTITY_NAME(lockers[0].id.name), ret);
+			rbd_warn(rbd_dev, "failed to blocklist %s%llu: %d",
+				 ENTITY_NAME(locker->id.name), ret);
 			goto out;
 		}
 
 		ret = ceph_cls_break_lock(&client->osdc, &rbd_dev->header_oid,
 					  &rbd_dev->header_oloc, RBD_LOCK_NAME,
-					  lockers[0].id.cookie,
-					  &lockers[0].id.name);
-		if (ret && ret != -ENOENT)
+					  locker->id.cookie, &locker->id.name);
+		if (ret && ret != -ENOENT) {
+			rbd_warn(rbd_dev, "failed to break header lock: %d",
+				 ret);
 			goto out;
+		}
 
 again:
-		ceph_free_lockers(lockers, num_lockers);
+		free_locker(locker);
 	}
 
 out:
-	ceph_free_lockers(lockers, num_lockers);
+	free_locker(locker);
 	return ret;
 }
 
-- 
2.40.1


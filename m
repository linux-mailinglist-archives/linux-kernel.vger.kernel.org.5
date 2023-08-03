Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417E276EA78
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbjHCNci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235364AbjHCNcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:32:03 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90581211B;
        Thu,  3 Aug 2023 06:30:56 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RGqVG6g3Yz4f3nyr;
        Thu,  3 Aug 2023 21:30:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgCnD7MGrMtkNVvlPQ--.7517S9;
        Thu, 03 Aug 2023 21:30:49 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next 5/7] md-bitmap: suspend array earlier in location_store()
Date:   Thu,  3 Aug 2023 21:27:49 +0800
Message-Id: <20230803132751.2741652-6-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230803132751.2741652-1-yukuai1@huaweicloud.com>
References: <20230803132751.2741652-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCnD7MGrMtkNVvlPQ--.7517S9
X-Coremail-Antispam: 1UD129KBjvJXoW7Kry7KFW7KrWUAr1kJrWkWFg_yoW5Jr48pa
        n3ta4rtr1rXFW3Xr17t3yv9FyrWw4kKrZrtrWxWwn5G3ZaywnxWF4rWF15J348K34rAFs8
        Jw45JF18Gr1UWFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20E
        Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267
        AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUArcfUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Now that mddev_suspend() doean't rely on 'mddev->pers' to be set, it's
safe to call mddev_suspend() earlier.

This will also be helper to refactor mddev_suspend() later.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md-bitmap.c | 43 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index f38c7f3156cb..0c661e5036bb 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -2351,6 +2351,8 @@ location_store(struct mddev *mddev, const char *buf, size_t len)
 	rv = mddev_lock(mddev);
 	if (rv)
 		return rv;
+
+	mddev_suspend(mddev);
 	if (mddev->pers) {
 		if (mddev->recovery || mddev->sync_thread) {
 			rv = -EBUSY;
@@ -2365,11 +2367,8 @@ location_store(struct mddev *mddev, const char *buf, size_t len)
 			rv = -EBUSY;
 			goto out;
 		}
-		if (mddev->pers) {
-			mddev_suspend(mddev);
-			md_bitmap_destroy(mddev);
-			mddev_resume(mddev);
-		}
+
+		md_bitmap_destroy(mddev);
 		mddev->bitmap_info.offset = 0;
 		if (mddev->bitmap_info.file) {
 			struct file *f = mddev->bitmap_info.file;
@@ -2379,6 +2378,8 @@ location_store(struct mddev *mddev, const char *buf, size_t len)
 	} else {
 		/* No bitmap, OK to set a location */
 		long long offset;
+		struct bitmap *bitmap;
+
 		if (strncmp(buf, "none", 4) == 0)
 			/* nothing to be done */;
 		else if (strncmp(buf, "file:", 5) == 0) {
@@ -2402,25 +2403,20 @@ location_store(struct mddev *mddev, const char *buf, size_t len)
 				rv = -EINVAL;
 				goto out;
 			}
+
 			mddev->bitmap_info.offset = offset;
-			if (mddev->pers) {
-				struct bitmap *bitmap;
-				bitmap = md_bitmap_create(mddev, -1);
-				mddev_suspend(mddev);
-				if (IS_ERR(bitmap))
-					rv = PTR_ERR(bitmap);
-				else {
-					mddev->bitmap = bitmap;
-					rv = md_bitmap_load(mddev);
-					if (rv)
-						mddev->bitmap_info.offset = 0;
-				}
-				if (rv) {
-					md_bitmap_destroy(mddev);
-					mddev_resume(mddev);
-					goto out;
-				}
-				mddev_resume(mddev);
+			bitmap = md_bitmap_create(mddev, -1);
+			if (IS_ERR(bitmap)) {
+				rv = PTR_ERR(bitmap);
+				goto out;
+			}
+
+			mddev->bitmap = bitmap;
+			rv = md_bitmap_load(mddev);
+			if (rv) {
+				mddev->bitmap_info.offset = 0;
+				md_bitmap_destroy(mddev);
+				goto out;
 			}
 		}
 	}
@@ -2433,6 +2429,7 @@ location_store(struct mddev *mddev, const char *buf, size_t len)
 	}
 	rv = 0;
 out:
+	mddev_resume(mddev);
 	mddev_unlock(mddev);
 	if (rv)
 		return rv;
-- 
2.39.2


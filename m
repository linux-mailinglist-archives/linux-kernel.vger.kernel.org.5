Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9EC3787E65
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 05:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237864AbjHYDOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 23:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbjHYDOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 23:14:19 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D241997;
        Thu, 24 Aug 2023 20:14:16 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RX4mj4d6fz4f3kq3;
        Fri, 25 Aug 2023 11:14:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAnBah_HOhkveEWBg--.3212S9;
        Fri, 25 Aug 2023 11:14:14 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        song@kernel.org, xni@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v2 5/7] md-bitmap: suspend array earlier in location_store()
Date:   Fri, 25 Aug 2023 11:09:54 +0800
Message-Id: <20230825030956.1527023-6-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230825030956.1527023-1-yukuai1@huaweicloud.com>
References: <20230825030956.1527023-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAnBah_HOhkveEWBg--.3212S9
X-Coremail-Antispam: 1UD129KBjvJXoW7Kry7KFW7KrWUAr1kJrWkWFg_yoW5Jr48pa
        n3ta4rtr1rXFW3Xr17t3yv9FyrWw4kKrZrtrWxWwn5G3ZaywnxWF4rWF15J348K34rAFs8
        Jw45JF18Gr1UWFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
        xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
        IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
        wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
        0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AK
        xVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
        4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQSdkU
        UUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E226F76EA77
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbjHCNcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbjHCNcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:32:03 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C0E212A;
        Thu,  3 Aug 2023 06:30:57 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RGqVK38B6z4f3l1N;
        Thu,  3 Aug 2023 21:30:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgCnD7MGrMtkNVvlPQ--.7517S11;
        Thu, 03 Aug 2023 21:30:50 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next 7/7] md: don't check 'mddev->pers' and 'pers->quiesce' from suspend_lo_store()
Date:   Thu,  3 Aug 2023 21:27:51 +0800
Message-Id: <20230803132751.2741652-8-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230803132751.2741652-1-yukuai1@huaweicloud.com>
References: <20230803132751.2741652-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCnD7MGrMtkNVvlPQ--.7517S11
X-Coremail-Antispam: 1UD129KBjvdXoW7XFWUWry7Jr1DWw43Cry3Jwb_yoWDAFcEgF
        nY9FZ3Jr1Sqry7trn0kw4xZryUtF1kW3ZrW3W3t34YyF15tFy0yFyFka45X3savFWjka4U
        Jryqyr47Xr4qkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbf8FF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2
        IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28E
        F7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr
        1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMx
        C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
        wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
        vE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAv
        wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14
        v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VU17GYJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Now that mddev_suspend() doean't rely on 'mddev->pers' to be set, it's
safe to remove such checking.

This will also allow the array to be suspended even before the array
is ran.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index a66e00b45be1..55a74d9b7457 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5192,18 +5192,13 @@ suspend_lo_store(struct mddev *mddev, const char *buf, size_t len)
 	err = mddev_lock(mddev);
 	if (err)
 		return err;
-	err = -EINVAL;
-	if (mddev->pers == NULL ||
-	    mddev->pers->quiesce == NULL)
-		goto unlock;
+
 	mddev_suspend(mddev);
 	mddev->suspend_lo = new;
 	mddev_resume(mddev);
 
-	err = 0;
-unlock:
 	mddev_unlock(mddev);
-	return err ?: len;
+	return len;
 }
 static struct md_sysfs_entry md_suspend_lo =
 __ATTR(suspend_lo, S_IRUGO|S_IWUSR, suspend_lo_show, suspend_lo_store);
-- 
2.39.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D906079E252
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238998AbjIMIi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239020AbjIMIir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:38:47 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 825E719A9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=LqGLJ
        OXO5bR3TOdCilEfQtXqdvwCC4z7Oxex9EjtBO8=; b=YQ6g3k5/Re66qHo9slAZ1
        4QwceUzWNIqWFSJg63uHdIGdygqL6nWo7AZ6BAPIv2XeVk4LI8Py/BWZRvEysoN1
        74ugaDQCXjd4KDFE9d0xJRDLOp6GaRnzXB1nVGCJ0ewCRrgwZxHkfjE6IUEaeFUA
        iIYrTPYyTD0Ajak7JfjLYE=
Received: from localhost.localdomain (unknown [223.166.237.2])
        by zwqz-smtp-mta-g1-1 (Coremail) with SMTP id _____wAnln7QdAFli8i+Bw--.56942S6;
        Wed, 13 Sep 2023 16:38:00 +0800 (CST)
From:   Ping Gan <jacky_gam_2001@163.com>
To:     kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        kch@nvidia.com, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Cc:     ping_gan@dell.com, jacky_gam_2001@163.com
Subject: [PATCH 4/4] nvme-core: Get lowlevel disk for target polling queue task
Date:   Wed, 13 Sep 2023 16:36:44 +0800
Message-Id: <006b6aefe94d73ee64931c769af4a908616439ad.1694592708.git.jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1694592708.git.jacky_gam_2001@163.com>
References: <cover.1694592708.git.jacky_gam_2001@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAnln7QdAFli8i+Bw--.56942S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr4UWF48ZryrKw47Cw4xtFb_yoW8Xw4DpF
        yDXF98Ar4xGF12gFsrZF4UArsxKw10g3WUCF9rA3s0qr9xKrZ5uFySkF1YyFZ3tFWDWFW7
        Xa4UKr13Gr1rCF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pio7KsUUUUU=
X-Originating-IP: [223.166.237.2]
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/xtbBog7pKVaEJdIJmgAAsa
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When enabling multipath, if the block device of nvmet is
a nvme_ns_head disk, then we should get the lowlevel block
device to do bio split.

Signed-off-by: Ping Gan <jacky_gam_2001@163.com>
---
 drivers/nvme/host/multipath.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 0a88d7bdc5e3..f6063600e06e 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -371,6 +371,25 @@ static bool nvme_available_path(struct nvme_ns_head *head)
 	return false;
 }
 
+//for polling queue task to get lowlevel block device
+struct block_device *nvme_mpath_get_bdev(struct block_device *bdev)
+{
+	struct nvme_ns_head *head = bdev->bd_disk->private_data;
+	int srcu_idx;
+	struct nvme_ns *ns;
+	struct block_device *ret = NULL;
+
+	if (!multipath)
+		return NULL;
+	srcu_idx = srcu_read_lock(&head->srcu);
+	ns = nvme_find_path(head);
+	if (likely(ns))
+		ret = ns->disk->part0;
+	srcu_read_unlock(&head->srcu, srcu_idx);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nvme_mpath_get_bdev);
+
 static void nvme_ns_head_submit_bio(struct bio *bio)
 {
 	struct nvme_ns_head *head = bio->bi_bdev->bd_disk->private_data;
@@ -452,6 +471,7 @@ const struct block_device_operations nvme_ns_head_ops = {
 	.report_zones	= nvme_ns_head_report_zones,
 	.pr_ops		= &nvme_pr_ops,
 };
+EXPORT_SYMBOL_GPL(nvme_ns_head_ops);
 
 static inline struct nvme_ns_head *cdev_to_ns_head(struct cdev *cdev)
 {
-- 
2.26.2


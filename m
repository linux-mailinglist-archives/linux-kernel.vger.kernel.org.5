Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B4979E251
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238995AbjIMIiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239009AbjIMIiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:38:46 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C1931997
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=SnLvL
        TWbhrC/XUz3Fy0z7AlLzfSz99Ix9EkTAMJlulM=; b=POrdJt7IONpqYhy6nJx4/
        OCwh73DXHhnA1msxdY4hErz0yZQr4z2d6cwPV8Y2kJkHo4/3tZ84KDgR7LjLjAE2
        NhQf8gDY4Jg4XcWk7ESzijr7FKn2TY8ZNrL3SW5uoAj+78H3McjObsCQ+Q9jIbtU
        HJi+GSvxmxehjGjOtvxHjQ=
Received: from localhost.localdomain (unknown [223.166.237.2])
        by zwqz-smtp-mta-g1-1 (Coremail) with SMTP id _____wAnln7QdAFli8i+Bw--.56942S3;
        Wed, 13 Sep 2023 16:37:49 +0800 (CST)
From:   Ping Gan <jacky_gam_2001@163.com>
To:     kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        kch@nvidia.com, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Cc:     ping_gan@dell.com, jacky_gam_2001@163.com
Subject: [PATCH 1/4] nvmet: Add nvme target polling queue task parameters
Date:   Wed, 13 Sep 2023 16:36:41 +0800
Message-Id: <9c3ebdd7a0411bd45512e0bc8eb60700f5bb8a04.1694592708.git.jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1694592708.git.jacky_gam_2001@163.com>
References: <cover.1694592708.git.jacky_gam_2001@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAnln7QdAFli8i+Bw--.56942S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr13tw1DJr4fAFW3CF18AFb_yoW5ZrW3pF
        W7Kwn0yr4xG3yxKwn3Gay5Jry3tw48Ca47Xa4xGw1rAFnY9ay8XFy8trWY9ryUCrW8Ca45
        JF1xCr4Uuw18J3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pNJPiUUUUUU=
X-Originating-IP: [223.166.237.2]
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/xtbBlwPpKWI0aQannwAAsV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To define a polling task's running parameters when
nvme target submits bio to a nvme polling queue.

Signed-off-by: Ping Gan <jacky_gam_2001@163.com>
---
 drivers/nvme/target/core.c | 55 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 3935165048e7..6f49965d5d17 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -17,6 +17,29 @@
 
 #include "nvmet.h"
 
+/* Define the polling queue thread's affinity cpu core.
+ *  */
+static int pqt_affinity_core = -1;
+module_param(pqt_affinity_core, int, 0644);
+MODULE_PARM_DESC(pqt_affinity_core,
+			    "nvme polling queue thread's affinity core, -1 for all online cpus");
+
+/* Define a time (in usecs) that polling queue thread shall sample the
+ *  * io request ring before determining it to be idle.
+ *   */
+static int pqt_idle_usecs;
+module_param(pqt_idle_usecs, int, 0644);
+MODULE_PARM_DESC(pqt_idle_usecs,
+				"polling queue task will poll io request till idle time in usecs");
+
+/* Define the polling queue thread ring's size.
+ *  * The ring will be consumed by polling queue thread.
+ *   */
+static int pqt_ring_size;
+module_param(pqt_ring_size, int, 0644);
+MODULE_PARM_DESC(pqt_ring_size,
+				"nvme target polling queue thread ring size");
+
 struct kmem_cache *nvmet_bvec_cache;
 struct workqueue_struct *buffered_io_wq;
 struct workqueue_struct *zbd_wq;
@@ -1648,13 +1671,34 @@ static int __init nvmet_init(void)
 {
 	int error = -ENOMEM;
 
+	if ((pqt_affinity_core >= -1 &&
+		pqt_affinity_core < nr_cpu_ids) ||
+		pqt_idle_usecs > 0 || pqt_ring_size > 0) {
+		if (pqt_idle_usecs == 0)
+			pqt_idle_usecs = 1000; //default 1ms
+		if (pqt_affinity_core < -1 ||
+			pqt_affinity_core >= nr_cpu_ids) {
+			printk(KERN_ERR "bad parameter for affinity core \n");
+			error =  -EINVAL;
+			return error;
+		}
+		if (pqt_ring_size == 0)
+			pqt_ring_size = 4096; //default 4k
+		error = nvmet_init_pq_thread(pqt_idle_usecs,
+						pqt_affinity_core, pqt_ring_size);
+		if (error)
+			return error;
+	}
+
 	nvmet_ana_group_enabled[NVMET_DEFAULT_ANA_GRPID] = 1;
 
 	nvmet_bvec_cache = kmem_cache_create("nvmet-bvec",
 			NVMET_MAX_MPOOL_BVEC * sizeof(struct bio_vec), 0,
 			SLAB_HWCACHE_ALIGN, NULL);
-	if (!nvmet_bvec_cache)
-		return -ENOMEM;
+	if (!nvmet_bvec_cache) {
+		error = -ENOMEM;
+		goto out_free_pqt;
+	}
 
 	zbd_wq = alloc_workqueue("nvmet-zbd-wq", WQ_MEM_RECLAIM, 0);
 	if (!zbd_wq)
@@ -1688,6 +1732,8 @@ static int __init nvmet_init(void)
 	destroy_workqueue(zbd_wq);
 out_destroy_bvec_cache:
 	kmem_cache_destroy(nvmet_bvec_cache);
+out_free_pqt:
+	nvmet_exit_pq_thread();
 	return error;
 }
 
@@ -1701,6 +1747,11 @@ static void __exit nvmet_exit(void)
 	destroy_workqueue(zbd_wq);
 	kmem_cache_destroy(nvmet_bvec_cache);
 
+	if ((pqt_affinity_core >= -1 &&
+		pqt_affinity_core < nr_cpu_ids) ||
+		pqt_idle_usecs > 0 || pqt_ring_size > 0)
+		nvmet_exit_pq_thread();
+
 	BUILD_BUG_ON(sizeof(struct nvmf_disc_rsp_page_entry) != 1024);
 	BUILD_BUG_ON(sizeof(struct nvmf_disc_rsp_page_hdr) != 1024);
 }
-- 
2.26.2


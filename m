Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9293813341
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573513AbjLNOhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573497AbjLNOhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:37:07 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC0DE8;
        Thu, 14 Dec 2023 06:37:13 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4CA3968AFE; Thu, 14 Dec 2023 15:37:09 +0100 (CET)
Date:   Thu, 14 Dec 2023 15:37:09 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     John Garry <john.g.garry@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
        sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com,
        djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        dchinner@redhat.com, jack@suse.cz, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
        ming.lei@redhat.com, jaswin@linux.ibm.com, bvanassche@acm.org
Subject: Re: [PATCH v2 00/16] block atomic writes
Message-ID: <20231214143708.GA5331@lst.de>
References: <20231212110844.19698-1-john.g.garry@oracle.com> <20231212163246.GA24594@lst.de> <b8b0a9d7-88d2-45a9-877a-ecc5e0f1e645@oracle.com> <20231213154409.GA7724@lst.de> <c729b03c-b1d1-4458-9983-113f8cd752cd@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c729b03c-b1d1-4458-9983-113f8cd752cd@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 04:27:35PM +0000, John Garry wrote:
>>> Are there any patches yet for the change to always use SGLs for transfers
>>> larger than a single PRP?
>> No.

Here is the WIP version.  With that you'd need to make atomic writes
conditional on !ctrl->need_virt_boundary.

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8ebdfd623e0f78..e04faffd6551fe 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1889,7 +1889,8 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 		blk_queue_max_hw_sectors(q, ctrl->max_hw_sectors);
 		blk_queue_max_segments(q, min_t(u32, max_segments, USHRT_MAX));
 	}
-	blk_queue_virt_boundary(q, NVME_CTRL_PAGE_SIZE - 1);
+	if (q == ctrl->admin_q || ctrl->need_virt_boundary)
+		blk_queue_virt_boundary(q, NVME_CTRL_PAGE_SIZE - 1);
 	blk_queue_dma_alignment(q, 3);
 	blk_queue_write_cache(q, vwc, vwc);
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index e7411dac00f725..aa98794a3ec53d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -262,6 +262,7 @@ enum nvme_ctrl_flags {
 struct nvme_ctrl {
 	bool comp_seen;
 	bool identified;
+	bool need_virt_boundary;
 	enum nvme_ctrl_state state;
 	spinlock_t lock;
 	struct mutex scan_lock;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 61af7ff1a9d6ba..a8d273b475cb40 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -60,8 +60,7 @@ MODULE_PARM_DESC(max_host_mem_size_mb,
 static unsigned int sgl_threshold = SZ_32K;
 module_param(sgl_threshold, uint, 0644);
 MODULE_PARM_DESC(sgl_threshold,
-		"Use SGLs when average request segment size is larger or equal to "
-		"this size. Use 0 to disable SGLs.");
+		"Use SGLs when > 0. Use 0 to disable SGLs.");
 
 #define NVME_PCI_MIN_QUEUE_SIZE 2
 #define NVME_PCI_MAX_QUEUE_SIZE 4095
@@ -504,23 +503,6 @@ static void nvme_commit_rqs(struct blk_mq_hw_ctx *hctx)
 	spin_unlock(&nvmeq->sq_lock);
 }
 
-static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req,
-				     int nseg)
-{
-	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
-	unsigned int avg_seg_size;
-
-	avg_seg_size = DIV_ROUND_UP(blk_rq_payload_bytes(req), nseg);
-
-	if (!nvme_ctrl_sgl_supported(&dev->ctrl))
-		return false;
-	if (!nvmeq->qid)
-		return false;
-	if (!sgl_threshold || avg_seg_size < sgl_threshold)
-		return false;
-	return true;
-}
-
 static void nvme_free_prps(struct nvme_dev *dev, struct request *req)
 {
 	const int last_prp = NVME_CTRL_PAGE_SIZE / sizeof(__le64) - 1;
@@ -769,12 +751,14 @@ static blk_status_t nvme_setup_sgl_simple(struct nvme_dev *dev,
 static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		struct nvme_command *cmnd)
 {
+	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	bool sgl_supported = nvme_ctrl_sgl_supported(&dev->ctrl) &&
+			nvmeq->qid && sgl_threshold;
 	blk_status_t ret = BLK_STS_RESOURCE;
 	int rc;
 
 	if (blk_rq_nr_phys_segments(req) == 1) {
-		struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 		struct bio_vec bv = req_bvec(req);
 
 		if (!is_pci_p2pdma_page(bv.bv_page)) {
@@ -782,8 +766,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 				return nvme_setup_prp_simple(dev, req,
 							     &cmnd->rw, &bv);
 
-			if (nvmeq->qid && sgl_threshold &&
-			    nvme_ctrl_sgl_supported(&dev->ctrl))
+			if (sgl_supported)
 				return nvme_setup_sgl_simple(dev, req,
 							     &cmnd->rw, &bv);
 		}
@@ -806,7 +789,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		goto out_free_sg;
 	}
 
-	if (nvme_pci_use_sgls(dev, req, iod->sgt.nents))
+	if (sgl_supported)
 		ret = nvme_pci_setup_sgls(dev, req, &cmnd->rw);
 	else
 		ret = nvme_pci_setup_prps(dev, req, &cmnd->rw);
@@ -3036,6 +3019,8 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	result = nvme_init_ctrl_finish(&dev->ctrl, false);
 	if (result)
 		goto out_disable;
+	if (!nvme_ctrl_sgl_supported(&dev->ctrl))
+		dev->ctrl.need_virt_boundary = true;
 
 	nvme_dbbuf_dma_alloc(dev);
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 81e2621169e5d3..416a9fbcccfc74 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -838,6 +838,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	error = nvme_init_ctrl_finish(&ctrl->ctrl, false);
 	if (error)
 		goto out_quiesce_queue;
+	ctrl->ctrl.need_virt_boundary = true;
 
 	return 0;
 

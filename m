Return-Path: <linux-kernel+bounces-4252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 681208179E5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA261C22A04
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C3022091;
	Mon, 18 Dec 2023 18:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="r+ctA05I";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="hWa+gcKQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1935D8470;
	Mon, 18 Dec 2023 18:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1702925037;
	bh=arHniq/TP/FYi3pR5hTUhKg3jdumjz26l2eJ5S8yDwc=;
	h=Message-ID:Subject:From:To:Date:From;
	b=r+ctA05INxpMxAToOnyQPIiqXYsMA9bOK/dtsQUKrOC73ANqFbSUcMv3Av0vLmxZV
	 wcY+2V/qSNTfdGmcSrJZrtRsv5EOEQgrOm/lzD0LrXAbii75eHlnv3gyZ2RHsBhq/y
	 r3lZTNuUxRxLOzfcIUlPq44RymLCzm1lxka5OMQ8=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 10F5F1280440;
	Mon, 18 Dec 2023 13:43:57 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id Kuvza7Xtm_zD; Mon, 18 Dec 2023 13:43:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1702925036;
	bh=arHniq/TP/FYi3pR5hTUhKg3jdumjz26l2eJ5S8yDwc=;
	h=Message-ID:Subject:From:To:Date:From;
	b=hWa+gcKQvRhtFQ1tdavdIVorcZykXjH2yXw2QL+IaSXo2vOFhAm+lEVr7OcklfeiN
	 aklswWQiMgH7mVToj+/IqdxQ83S8XdGO9VTYNPJQiATKUrfal2F6yadYKhNp29oXL4
	 nB+IQSssx1AeyZN7qjFDXUBKzqAFY8mra4dlZrKY=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 634E7128023A;
	Mon, 18 Dec 2023 13:43:56 -0500 (EST)
Message-ID: <6edb005530947b752d1a84c9ea69df0da6c85cf5.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 6.7-rc6
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds
	 <torvalds@linux-foundation.org>
Cc: linux-scsi <linux-scsi@vger.kernel.org>, linux-kernel
	 <linux-kernel@vger.kernel.org>
Date: Mon, 18 Dec 2023 13:43:54 -0500
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Two medium sized fixes, both in drivers.  The UFS one adds parsing of
clock info structures, which is required by some host drivers and the
aacraid one reverts the IRQ affinity mapping patch which has been
causing regressions noted in kernel bugzilla 217599.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Martin K. Petersen (1):
      Revert "scsi: aacraid: Reply queue mapping to CPUs based on IRQ affinity"

Nitin Rawat (1):
      scsi: ufs: core: Store min and max clk freq from OPP table


And the diffstat:

 drivers/scsi/aacraid/aacraid.h   |  1 -
 drivers/scsi/aacraid/commsup.c   |  6 +----
 drivers/scsi/aacraid/linit.c     | 14 -----------
 drivers/scsi/aacraid/src.c       | 25 ++-----------------
 drivers/ufs/host/ufshcd-pltfrm.c | 54 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 57 insertions(+), 43 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/aacraid/aacraid.h b/drivers/scsi/aacraid/aacraid.h
index 73b6ac0c01f5..7d5a155073c6 100644
--- a/drivers/scsi/aacraid/aacraid.h
+++ b/drivers/scsi/aacraid/aacraid.h
@@ -1678,7 +1678,6 @@ struct aac_dev
 	u32			handle_pci_error;
 	bool			init_reset;
 	u8			soft_reset_support;
-	u8			use_map_queue;
 };
 
 #define aac_adapter_interrupt(dev) \
diff --git a/drivers/scsi/aacraid/commsup.c b/drivers/scsi/aacraid/commsup.c
index 013a9a334972..25cee03d7f97 100644
--- a/drivers/scsi/aacraid/commsup.c
+++ b/drivers/scsi/aacraid/commsup.c
@@ -223,12 +223,8 @@ int aac_fib_setup(struct aac_dev * dev)
 struct fib *aac_fib_alloc_tag(struct aac_dev *dev, struct scsi_cmnd *scmd)
 {
 	struct fib *fibptr;
-	u32 blk_tag;
-	int i;
 
-	blk_tag = blk_mq_unique_tag(scsi_cmd_to_rq(scmd));
-	i = blk_mq_unique_tag_to_tag(blk_tag);
-	fibptr = &dev->fibs[i];
+	fibptr = &dev->fibs[scsi_cmd_to_rq(scmd)->tag];
 	/*
 	 *	Null out fields that depend on being zero at the start of
 	 *	each I/O
diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
index c4a36c0be527..68f4dbcfff49 100644
--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -19,7 +19,6 @@
 
 #include <linux/compat.h>
 #include <linux/blkdev.h>
-#include <linux/blk-mq-pci.h>
 #include <linux/completion.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -505,15 +504,6 @@ static int aac_slave_configure(struct scsi_device *sdev)
 	return 0;
 }
 
-static void aac_map_queues(struct Scsi_Host *shost)
-{
-	struct aac_dev *aac = (struct aac_dev *)shost->hostdata;
-
-	blk_mq_pci_map_queues(&shost->tag_set.map[HCTX_TYPE_DEFAULT],
-			      aac->pdev, 0);
-	aac->use_map_queue = true;
-}
-
 /**
  *	aac_change_queue_depth		-	alter queue depths
  *	@sdev:	SCSI device we are considering
@@ -1498,7 +1488,6 @@ static const struct scsi_host_template aac_driver_template = {
 	.bios_param			= aac_biosparm,
 	.shost_groups			= aac_host_groups,
 	.slave_configure		= aac_slave_configure,
-	.map_queues			= aac_map_queues,
 	.change_queue_depth		= aac_change_queue_depth,
 	.sdev_groups			= aac_dev_groups,
 	.eh_abort_handler		= aac_eh_abort,
@@ -1786,8 +1775,6 @@ static int aac_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	shost->max_lun = AAC_MAX_LUN;
 
 	pci_set_drvdata(pdev, shost);
-	shost->nr_hw_queues = aac->max_msix;
-	shost->host_tagset = 1;
 
 	error = scsi_add_host(shost, &pdev->dev);
 	if (error)
@@ -1919,7 +1906,6 @@ static void aac_remove_one(struct pci_dev *pdev)
 	struct aac_dev *aac = (struct aac_dev *)shost->hostdata;
 
 	aac_cancel_rescan_worker(aac);
-	aac->use_map_queue = false;
 	scsi_remove_host(shost);
 
 	__aac_shutdown(aac);
diff --git a/drivers/scsi/aacraid/src.c b/drivers/scsi/aacraid/src.c
index 61949f374188..11ef58204e96 100644
--- a/drivers/scsi/aacraid/src.c
+++ b/drivers/scsi/aacraid/src.c
@@ -493,10 +493,6 @@ static int aac_src_deliver_message(struct fib *fib)
 #endif
 
 	u16 vector_no;
-	struct scsi_cmnd *scmd;
-	u32 blk_tag;
-	struct Scsi_Host *shost = dev->scsi_host_ptr;
-	struct blk_mq_queue_map *qmap;
 
 	atomic_inc(&q->numpending);
 
@@ -509,25 +505,8 @@ static int aac_src_deliver_message(struct fib *fib)
 		if ((dev->comm_interface == AAC_COMM_MESSAGE_TYPE3)
 			&& dev->sa_firmware)
 			vector_no = aac_get_vector(dev);
-		else {
-			if (!fib->vector_no || !fib->callback_data) {
-				if (shost && dev->use_map_queue) {
-					qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
-					vector_no = qmap->mq_map[raw_smp_processor_id()];
-				}
-				/*
-				 *	We hardcode the vector_no for
-				 *	reserved commands as a valid shost is
-				 *	absent during the init
-				 */
-				else
-					vector_no = 0;
-			} else {
-				scmd = (struct scsi_cmnd *)fib->callback_data;
-				blk_tag = blk_mq_unique_tag(scsi_cmd_to_rq(scmd));
-				vector_no = blk_mq_unique_tag_to_hwq(blk_tag);
-			}
-		}
+		else
+			vector_no = fib->vector_no;
 
 		if (native_hba) {
 			if (fib->flags & FIB_CONTEXT_FLAG_NATIVE_HBA_TMF) {
diff --git a/drivers/ufs/host/ufshcd-pltfrm.c b/drivers/ufs/host/ufshcd-pltfrm.c
index da2558e274b4..db9d9365ff55 100644
--- a/drivers/ufs/host/ufshcd-pltfrm.c
+++ b/drivers/ufs/host/ufshcd-pltfrm.c
@@ -8,6 +8,7 @@
  *	Vinayak Holikatti <h.vinayak@samsung.com>
  */
 
+#include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
@@ -213,6 +214,55 @@ static void ufshcd_init_lanes_per_dir(struct ufs_hba *hba)
 	}
 }
 
+/**
+ * ufshcd_parse_clock_min_max_freq  - Parse MIN and MAX clocks freq
+ * @hba: per adapter instance
+ *
+ * This function parses MIN and MAX frequencies of all clocks required
+ * by the host drivers.
+ *
+ * Returns 0 for success and non-zero for failure
+ */
+static int ufshcd_parse_clock_min_max_freq(struct ufs_hba *hba)
+{
+	struct list_head *head = &hba->clk_list_head;
+	struct ufs_clk_info *clki;
+	struct dev_pm_opp *opp;
+	unsigned long freq;
+	u8 idx = 0;
+
+	list_for_each_entry(clki, head, list) {
+		if (!clki->name)
+			continue;
+
+		clki->clk = devm_clk_get(hba->dev, clki->name);
+		if (IS_ERR(clki->clk))
+			continue;
+
+		/* Find Max Freq */
+		freq = ULONG_MAX;
+		opp = dev_pm_opp_find_freq_floor_indexed(hba->dev, &freq, idx);
+		if (IS_ERR(opp)) {
+			dev_err(hba->dev, "Failed to find OPP for MAX frequency\n");
+			return PTR_ERR(opp);
+		}
+		clki->max_freq = dev_pm_opp_get_freq_indexed(opp, idx);
+		dev_pm_opp_put(opp);
+
+		/* Find Min Freq */
+		freq = 0;
+		opp = dev_pm_opp_find_freq_ceil_indexed(hba->dev, &freq, idx);
+		if (IS_ERR(opp)) {
+			dev_err(hba->dev, "Failed to find OPP for MIN frequency\n");
+			return PTR_ERR(opp);
+		}
+		clki->min_freq = dev_pm_opp_get_freq_indexed(opp, idx++);
+		dev_pm_opp_put(opp);
+	}
+
+	return 0;
+}
+
 static int ufshcd_parse_operating_points(struct ufs_hba *hba)
 {
 	struct device *dev = hba->dev;
@@ -279,6 +329,10 @@ static int ufshcd_parse_operating_points(struct ufs_hba *hba)
 		return ret;
 	}
 
+	ret = ufshcd_parse_clock_min_max_freq(hba);
+	if (ret)
+		return ret;
+
 	hba->use_pm_opp = true;
 
 	return 0;



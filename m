Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C54478C5D0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjH2NeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236261AbjH2Ndk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:33:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B37184;
        Tue, 29 Aug 2023 06:33:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE93F6574A;
        Tue, 29 Aug 2023 13:33:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10AA0C433C9;
        Tue, 29 Aug 2023 13:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693316010;
        bh=m5JlwWc7+7hToNy0b47zifCpGgJU/jMqlpUsgYF5Okc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KSBg2hZGhbvv6eVweWiPGbD7L34XqggPTR/kyh8Y9+v5wRUs/hhzxtjZ2oCzQaZa1
         NqYd4F6FUXSnsCHxC+8Y4xg0rN8b7LBdaH0oLz4qB8ftfvD4Oc2aGLfXJaOsclAK6a
         qimKbhGYY2gA2dXrfM6rUuTfcxgbv19BLPqU7p/gDnf/trHF7umUfA0u3zukMg2kaW
         JAV494w67b4Rhx09SGYOSexAjcqOB5al0LPvJCl6C05+3M9kiEWxMVEp9nc4Ruix/V
         vIc4mi2JFNhy9NND4QSELc8qG4ecUHUkYvtWfahHo9Cwq73ePO7SfWb4etKdkFDQsB
         LeJ3JQhHQDhtQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sagar Biradar <sagar.biradar@microchip.com>,
        Gilbert Wu <gilbert.wu@microchip.com>,
        Sagar Biradar <Sagar.Biradar@microchip.com>,
        John Garry <john.g.garry@oracle.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, aacraid@microsemi.com,
        jejb@linux.ibm.com, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 6/9] scsi: aacraid: Reply queue mapping to CPUs based on IRQ affinity
Date:   Tue, 29 Aug 2023 09:33:13 -0400
Message-Id: <20230829133316.520410-6-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230829133316.520410-1-sashal@kernel.org>
References: <20230829133316.520410-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.128
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sagar Biradar <sagar.biradar@microchip.com>

[ Upstream commit 9dc704dcc09eae7d21b5da0615eb2ed79278f63e ]

Fix the I/O hang that arises because of the MSIx vector not having a mapped
online CPU upon receiving completion.

SCSI cmds take the blk_mq route, which is setup during init. Reserved cmds
fetch the vector_no from mq_map after init is complete. Before init, they
have to use 0 - as per the norm.

Reviewed-by: Gilbert Wu <gilbert.wu@microchip.com>
Signed-off-by: Sagar Biradar <Sagar.Biradar@microchip.com>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Link: https://lore.kernel.org/r/20230519230834.27436-1-sagar.biradar@microchip.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/aacraid/aacraid.h |  1 +
 drivers/scsi/aacraid/commsup.c |  6 +++++-
 drivers/scsi/aacraid/linit.c   | 14 ++++++++++++++
 drivers/scsi/aacraid/src.c     | 25 +++++++++++++++++++++++--
 4 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/aacraid/aacraid.h b/drivers/scsi/aacraid/aacraid.h
index 3733df77bc65d..4aa7335b66a1f 100644
--- a/drivers/scsi/aacraid/aacraid.h
+++ b/drivers/scsi/aacraid/aacraid.h
@@ -1677,6 +1677,7 @@ struct aac_dev
 	u32			handle_pci_error;
 	bool			init_reset;
 	u8			soft_reset_support;
+	u8			use_map_queue;
 };
 
 #define aac_adapter_interrupt(dev) \
diff --git a/drivers/scsi/aacraid/commsup.c b/drivers/scsi/aacraid/commsup.c
index deb32c9f4b3e6..3f062e4013ab6 100644
--- a/drivers/scsi/aacraid/commsup.c
+++ b/drivers/scsi/aacraid/commsup.c
@@ -223,8 +223,12 @@ int aac_fib_setup(struct aac_dev * dev)
 struct fib *aac_fib_alloc_tag(struct aac_dev *dev, struct scsi_cmnd *scmd)
 {
 	struct fib *fibptr;
+	u32 blk_tag;
+	int i;
 
-	fibptr = &dev->fibs[scsi_cmd_to_rq(scmd)->tag];
+	blk_tag = blk_mq_unique_tag(scsi_cmd_to_rq(scmd));
+	i = blk_mq_unique_tag_to_tag(blk_tag);
+	fibptr = &dev->fibs[i];
 	/*
 	 *	Null out fields that depend on being zero at the start of
 	 *	each I/O
diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
index 3168915adaa75..c00c214a2b87a 100644
--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -19,6 +19,7 @@
 
 #include <linux/compat.h>
 #include <linux/blkdev.h>
+#include <linux/blk-mq-pci.h>
 #include <linux/completion.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -506,6 +507,15 @@ static int aac_slave_configure(struct scsi_device *sdev)
 	return 0;
 }
 
+static void aac_map_queues(struct Scsi_Host *shost)
+{
+	struct aac_dev *aac = (struct aac_dev *)shost->hostdata;
+
+	blk_mq_pci_map_queues(&shost->tag_set.map[HCTX_TYPE_DEFAULT],
+			      aac->pdev, 0);
+	aac->use_map_queue = true;
+}
+
 /**
  *	aac_change_queue_depth		-	alter queue depths
  *	@sdev:	SCSI device we are considering
@@ -1485,6 +1495,7 @@ static struct scsi_host_template aac_driver_template = {
 	.bios_param			= aac_biosparm,
 	.shost_attrs			= aac_attrs,
 	.slave_configure		= aac_slave_configure,
+	.map_queues			= aac_map_queues,
 	.change_queue_depth		= aac_change_queue_depth,
 	.sdev_attrs			= aac_dev_attrs,
 	.eh_abort_handler		= aac_eh_abort,
@@ -1771,6 +1782,8 @@ static int aac_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	shost->max_lun = AAC_MAX_LUN;
 
 	pci_set_drvdata(pdev, shost);
+	shost->nr_hw_queues = aac->max_msix;
+	shost->host_tagset = 1;
 
 	error = scsi_add_host(shost, &pdev->dev);
 	if (error)
@@ -1903,6 +1916,7 @@ static void aac_remove_one(struct pci_dev *pdev)
 	struct aac_dev *aac = (struct aac_dev *)shost->hostdata;
 
 	aac_cancel_rescan_worker(aac);
+	aac->use_map_queue = false;
 	scsi_remove_host(shost);
 
 	__aac_shutdown(aac);
diff --git a/drivers/scsi/aacraid/src.c b/drivers/scsi/aacraid/src.c
index 11ef58204e96f..61949f3741886 100644
--- a/drivers/scsi/aacraid/src.c
+++ b/drivers/scsi/aacraid/src.c
@@ -493,6 +493,10 @@ static int aac_src_deliver_message(struct fib *fib)
 #endif
 
 	u16 vector_no;
+	struct scsi_cmnd *scmd;
+	u32 blk_tag;
+	struct Scsi_Host *shost = dev->scsi_host_ptr;
+	struct blk_mq_queue_map *qmap;
 
 	atomic_inc(&q->numpending);
 
@@ -505,8 +509,25 @@ static int aac_src_deliver_message(struct fib *fib)
 		if ((dev->comm_interface == AAC_COMM_MESSAGE_TYPE3)
 			&& dev->sa_firmware)
 			vector_no = aac_get_vector(dev);
-		else
-			vector_no = fib->vector_no;
+		else {
+			if (!fib->vector_no || !fib->callback_data) {
+				if (shost && dev->use_map_queue) {
+					qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
+					vector_no = qmap->mq_map[raw_smp_processor_id()];
+				}
+				/*
+				 *	We hardcode the vector_no for
+				 *	reserved commands as a valid shost is
+				 *	absent during the init
+				 */
+				else
+					vector_no = 0;
+			} else {
+				scmd = (struct scsi_cmnd *)fib->callback_data;
+				blk_tag = blk_mq_unique_tag(scsi_cmd_to_rq(scmd));
+				vector_no = blk_mq_unique_tag_to_hwq(blk_tag);
+			}
+		}
 
 		if (native_hba) {
 			if (fib->flags & FIB_CONTEXT_FLAG_NATIVE_HBA_TMF) {
-- 
2.40.1


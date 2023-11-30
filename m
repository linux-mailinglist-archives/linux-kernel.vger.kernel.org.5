Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C595A7FE6CF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 03:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbjK3Cei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 21:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjK3Ceg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 21:34:36 -0500
Received: from rcdn-iport-6.cisco.com (rcdn-iport-6.cisco.com [173.37.86.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BFED6C;
        Wed, 29 Nov 2023 18:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3344; q=dns/txt; s=iport;
  t=1701311680; x=1702521280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K+bYj4vgqLwVjwI3l8qjOefDFoAKWmKHscRRuOenB18=;
  b=Y0xZKv3ZXT2JSNQrVMxDk9Jy8eSR3EY1aUKZ43wGoJXkRutP7fUCc1t3
   Cc7Poq/vvHExAWz7ehd5Nr4V9TZZc0GpsM/hjcyFSBc5d8HO81aWGbl5Z
   IuBts3EJag/1iticvNVdXZ+2P3g5sMdXXMzdiFNFBOjL5C0/c5seR6m0g
   U=;
X-CSE-ConnectionGUID: 8Fh9zFVPRLesI6AIyAjccA==
X-CSE-MsgGUID: ueNqbNj+StqAZCPVl21LCA==
X-IronPort-AV: E=Sophos;i="6.04,237,1695686400"; 
   d="scan'208";a="149444459"
Received: from rcdn-core-9.cisco.com ([173.37.93.145])
  by rcdn-iport-6.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 02:34:39 +0000
Received: from localhost.cisco.com ([10.193.101.253])
        (authenticated bits=0)
        by rcdn-core-9.cisco.com (8.15.2/8.15.2) with ESMTPSA id 3AU2YA44007614
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 30 Nov 2023 02:34:38 GMT
From:   Karan Tilak Kumar <kartilak@cisco.com>
To:     sebaddel@cisco.com
Cc:     arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com,
        mkai2@cisco.com, satishkh@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Karan Tilak Kumar <kartilak@cisco.com>
Subject: [PATCH v4 02/13] scsi: fnic: Add and use fnic number
Date:   Wed, 29 Nov 2023 18:33:51 -0800
Message-Id: <20231130023402.802282-3-kartilak@cisco.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231130023402.802282-1-kartilak@cisco.com>
References: <20231130023402.802282-1-kartilak@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: kartilak@cisco.com
X-Outbound-SMTP-Client: 10.193.101.253, [10.193.101.253]
X-Outbound-Node: rcdn-core-9.cisco.com
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add fnic_num in fnic.h to identify fnic in a multi-fnic environment.
Increment and set the fnic number during driver load in fnic_probe.
Replace the host number with fnic number in debugfs.

Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>

Changes between v3 and v4:
    Incorporate review comments from Martin and Hannes:
	Undo the change to replace host number with fnic
	number in debugfs since kernel stack uses host number.
	Use ida_alloc to allocate ID for fnic number.
---
 drivers/scsi/fnic/fnic.h      |  1 +
 drivers/scsi/fnic/fnic_main.c | 18 ++++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/fnic/fnic.h b/drivers/scsi/fnic/fnic.h
index 93c68931a593..c6c549c633b1 100644
--- a/drivers/scsi/fnic/fnic.h
+++ b/drivers/scsi/fnic/fnic.h
@@ -216,6 +216,7 @@ struct fnic_event {
 
 /* Per-instance private data structure */
 struct fnic {
+	int fnic_num;
 	struct fc_lport *lport;
 	struct fcoe_ctlr ctlr;		/* FIP FCoE controller structure */
 	struct vnic_dev_bar bar0;
diff --git a/drivers/scsi/fnic/fnic_main.c b/drivers/scsi/fnic/fnic_main.c
index 984bc5fc55e2..f989a5d7a229 100644
--- a/drivers/scsi/fnic/fnic_main.c
+++ b/drivers/scsi/fnic/fnic_main.c
@@ -39,6 +39,7 @@ static struct kmem_cache *fnic_sgl_cache[FNIC_SGL_NUM_CACHES];
 static struct kmem_cache *fnic_io_req_cache;
 static LIST_HEAD(fnic_list);
 static DEFINE_SPINLOCK(fnic_list_lock);
+static DEFINE_IDA(fnic_ida);
 
 /* Supported devices by fnic module */
 static struct pci_device_id fnic_id_table[] = {
@@ -583,7 +584,8 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct fc_lport *lp;
 	struct fnic *fnic;
 	mempool_t *pool;
-	int err;
+	int err = 0;
+	int fnic_id = 0;
 	int i;
 	unsigned long flags;
 
@@ -597,8 +599,16 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		err = -ENOMEM;
 		goto err_out;
 	}
+
 	host = lp->host;
 	fnic = lport_priv(lp);
+
+	fnic_id = ida_alloc(&fnic_ida, GFP_KERNEL);
+	if (fnic_id < 0) {
+		pr_err("Unable to alloc fnic ID\n");
+		err = fnic_id;
+		goto err_out_ida_alloc;
+	}
 	fnic->lport = lp;
 	fnic->ctlr.lp = lp;
 
@@ -608,7 +618,7 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		 host->host_no);
 
 	host->transportt = fnic_fc_transport;
-
+	fnic->fnic_num = fnic_id;
 	fnic_stats_debugfs_init(fnic);
 
 	/* Setup PCI resources */
@@ -949,6 +959,8 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	pci_disable_device(pdev);
 err_out_free_hba:
 	fnic_stats_debugfs_remove(fnic);
+	ida_free(&fnic_ida, fnic->fnic_num);
+err_out_ida_alloc:
 	scsi_host_put(lp->host);
 err_out:
 	return err;
@@ -1029,6 +1041,7 @@ static void fnic_remove(struct pci_dev *pdev)
 	fnic_iounmap(fnic);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
+	ida_free(&fnic_ida, fnic->fnic_num);
 	scsi_host_put(lp->host);
 }
 
@@ -1166,6 +1179,7 @@ static void __exit fnic_cleanup_module(void)
 	fnic_trace_free();
 	fnic_fc_trace_free();
 	fnic_debugfs_terminate();
+	ida_destroy(&fnic_ida);
 }
 
 module_init(fnic_init_module);
-- 
2.31.1


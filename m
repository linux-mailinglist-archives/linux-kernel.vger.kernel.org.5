Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B867FE6DD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 03:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344167AbjK3CgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 21:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjK3Cf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 21:35:59 -0500
Received: from rcdn-iport-3.cisco.com (rcdn-iport-3.cisco.com [173.37.86.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90B6D7D;
        Wed, 29 Nov 2023 18:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=4170; q=dns/txt; s=iport;
  t=1701311765; x=1702521365;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OcJECNe81v7ZCEUoq8/ceKd1781hnWAO3rR3PDQ7g5E=;
  b=fEONU7aPN4b9Tpi9KH0wKH04psoLhYD8UddNgJb5H8hD3CprCLyeyrnb
   8lriKvSRnvdbtNoI5j6/WqF85fXJBuLK7i5XLwPCz3Emow9P++GRXEr+T
   GkF5qhnN4Nv+mrnI0osRqNV7n3QfZ86bWnF3ppYhhEYD8YTJhcBKXY/i1
   0=;
X-CSE-ConnectionGUID: 3FhXZoMUSn6shXCroO+bEA==
X-CSE-MsgGUID: qJPxmgDpSnePdKBGS/YT0w==
X-IronPort-AV: E=Sophos;i="6.04,237,1695686400"; 
   d="scan'208";a="149776883"
Received: from rcdn-core-9.cisco.com ([173.37.93.145])
  by rcdn-iport-3.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 02:36:05 +0000
Received: from localhost.cisco.com ([10.193.101.253])
        (authenticated bits=0)
        by rcdn-core-9.cisco.com (8.15.2/8.15.2) with ESMTPSA id 3AU2YA47007614
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 30 Nov 2023 02:36:04 GMT
From:   Karan Tilak Kumar <kartilak@cisco.com>
To:     sebaddel@cisco.com
Cc:     arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com,
        mkai2@cisco.com, satishkh@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Karan Tilak Kumar <kartilak@cisco.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v4 05/13] scsi: fnic: Get copy workqueue count and interrupt mode from config
Date:   Wed, 29 Nov 2023 18:33:54 -0800
Message-Id: <20231130023402.802282-6-kartilak@cisco.com>
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

Get the copy workqueue count and interrupt mode from
the configuration. The config can be changed via UCSM.
Add logs to print the interrupt mode and copy workqueue count.
Add logs to print the vNIC resources.

Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
---
 drivers/scsi/fnic/fnic_res.c | 42 ++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/fnic/fnic_res.c b/drivers/scsi/fnic/fnic_res.c
index 109316cc4ad9..33dd27f6f24e 100644
--- a/drivers/scsi/fnic/fnic_res.c
+++ b/drivers/scsi/fnic/fnic_res.c
@@ -57,6 +57,8 @@ int fnic_get_vnic_config(struct fnic *fnic)
 	GET_CONFIG(port_down_timeout);
 	GET_CONFIG(port_down_io_retries);
 	GET_CONFIG(luns_per_tgt);
+	GET_CONFIG(intr_mode);
+	GET_CONFIG(wq_copy_count);
 
 	c->wq_enet_desc_count =
 		min_t(u32, VNIC_FNIC_WQ_DESCS_MAX,
@@ -131,6 +133,12 @@ int fnic_get_vnic_config(struct fnic *fnic)
 	c->intr_timer = min_t(u16, VNIC_INTR_TIMER_MAX, c->intr_timer);
 	c->intr_timer_type = c->intr_timer_type;
 
+	/* for older firmware, GET_CONFIG will not return anything */
+	if (c->wq_copy_count == 0)
+		c->wq_copy_count = 1;
+
+	c->wq_copy_count = min_t(u16, FNIC_WQ_COPY_MAX, c->wq_copy_count);
+
 	shost_printk(KERN_INFO, fnic->lport->host,
 		     "vNIC MAC addr %pM "
 		     "wq/wq_copy/rq %d/%d/%d\n",
@@ -161,6 +169,10 @@ int fnic_get_vnic_config(struct fnic *fnic)
 	shost_printk(KERN_INFO, fnic->lport->host,
 		     "vNIC port dn io retries %d port dn timeout %d\n",
 		     c->port_down_io_retries, c->port_down_timeout);
+	shost_printk(KERN_INFO, fnic->lport->host,
+			"vNIC wq_copy_count: %d\n", c->wq_copy_count);
+	shost_printk(KERN_INFO, fnic->lport->host,
+			"vNIC intr mode: %d\n", c->intr_mode);
 
 	return 0;
 }
@@ -187,12 +199,25 @@ int fnic_set_nic_config(struct fnic *fnic, u8 rss_default_cpu,
 void fnic_get_res_counts(struct fnic *fnic)
 {
 	fnic->wq_count = vnic_dev_get_res_count(fnic->vdev, RES_TYPE_WQ);
-	fnic->raw_wq_count = fnic->wq_count - 1;
-	fnic->wq_copy_count = fnic->wq_count - fnic->raw_wq_count;
+	fnic->raw_wq_count = 1;
+	fnic->wq_copy_count = fnic->config.wq_copy_count;
 	fnic->rq_count = vnic_dev_get_res_count(fnic->vdev, RES_TYPE_RQ);
 	fnic->cq_count = vnic_dev_get_res_count(fnic->vdev, RES_TYPE_CQ);
 	fnic->intr_count = vnic_dev_get_res_count(fnic->vdev,
 		RES_TYPE_INTR_CTRL);
+
+	shost_printk(KERN_INFO, fnic->lport->host,
+		"vNIC fw resources wq_count: %d\n", fnic->wq_count);
+	shost_printk(KERN_INFO, fnic->lport->host,
+		"vNIC fw resources raw_wq_count: %d\n", fnic->raw_wq_count);
+	shost_printk(KERN_INFO, fnic->lport->host,
+		"vNIC fw resources wq_copy_count: %d\n", fnic->wq_copy_count);
+	shost_printk(KERN_INFO, fnic->lport->host,
+		"vNIC fw resources rq_count: %d\n", fnic->rq_count);
+	shost_printk(KERN_INFO, fnic->lport->host,
+		"vNIC fw resources cq_count: %d\n", fnic->cq_count);
+	shost_printk(KERN_INFO, fnic->lport->host,
+		"vNIC fw resources intr_count: %d\n", fnic->intr_count);
 }
 
 void fnic_free_vnic_resources(struct fnic *fnic)
@@ -234,10 +259,15 @@ int fnic_alloc_vnic_resources(struct fnic *fnic)
 		     intr_mode == VNIC_DEV_INTR_MODE_MSIX ?
 		     "MSI-X" : "unknown");
 
-	shost_printk(KERN_INFO, fnic->lport->host, "vNIC resources avail: "
-		     "wq %d cp_wq %d raw_wq %d rq %d cq %d intr %d\n",
-		     fnic->wq_count, fnic->wq_copy_count, fnic->raw_wq_count,
-		     fnic->rq_count, fnic->cq_count, fnic->intr_count);
+	shost_printk(KERN_INFO, fnic->lport->host,
+			"vNIC resources avail: wq %d cp_wq %d raw_wq %d rq %d",
+			fnic->wq_count, fnic->wq_copy_count,
+			fnic->raw_wq_count, fnic->rq_count);
+
+	shost_printk(KERN_INFO, fnic->lport->host,
+			"vNIC resources avail: cq %d intr %d cpy-wq desc count %d\n",
+			fnic->cq_count, fnic->intr_count,
+			fnic->config.wq_copy_desc_count);
 
 	/* Allocate Raw WQ used for FCS frames */
 	for (i = 0; i < fnic->raw_wq_count; i++) {
-- 
2.31.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D2B7D9F49
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 20:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346362AbjJ0SDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 14:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346295AbjJ0SDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 14:03:43 -0400
Received: from alln-iport-1.cisco.com (alln-iport-1.cisco.com [173.37.142.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE5E1B1;
        Fri, 27 Oct 2023 11:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3120; q=dns/txt; s=iport;
  t=1698429816; x=1699639416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sjJkSqdln9qea/n4Fpj7gGInKVCSDN0znydRXK9ldtE=;
  b=MoP5bTR/OWxx4V/nBr7ZXHiW5cvGYD/Eps3uafaZ8HRTlhUQM9G9eOtT
   R3XQxQhlwaxtTaDlxQT4TMxbJvdipwOnoWgVhNYzP99SzB9fn/3g7wmVo
   h3k3EWot+pN+IXh71fgkBU0QLXzAzBkRomVDwGCxvOvkqbODU2PaKygma
   k=;
X-CSE-ConnectionGUID: J92Bq2ndQJujJBbWj40KIA==
X-CSE-MsgGUID: LsCRYOVBSN2FgKssoDhITw==
X-IronPort-AV: E=Sophos;i="6.03,256,1694736000"; 
   d="scan'208";a="187094422"
Received: from rcdn-core-11.cisco.com ([173.37.93.147])
  by alln-iport-1.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 18:03:35 +0000
Received: from localhost.cisco.com ([10.193.101.253])
        (authenticated bits=0)
        by rcdn-core-11.cisco.com (8.15.2/8.15.2) with ESMTPSA id 39RI39Oi029226
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 27 Oct 2023 18:03:34 GMT
From:   Karan Tilak Kumar <kartilak@cisco.com>
To:     sebaddel@cisco.com
Cc:     arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com,
        mkai2@cisco.com, satishkh@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Karan Tilak Kumar <kartilak@cisco.com>
Subject: [PATCH v2 06/13] scsi: fnic: Refactor and redefine fnic.h for multiqueue
Date:   Fri, 27 Oct 2023 11:02:55 -0700
Message-Id: <20231027180302.418676-7-kartilak@cisco.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231027180302.418676-1-kartilak@cisco.com>
References: <20231027180302.418676-1-kartilak@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: kartilak@cisco.com
X-Outbound-SMTP-Client: 10.193.101.253, [10.193.101.253]
X-Outbound-Node: rcdn-core-11.cisco.com
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor and re-define values in fnic.h to implement
multiqueue(MQ) functionality.

VIC firmware allows fnic to create up to 64 copy
workqueues. Update the copy workqueue max to 64.
Modify the interrupt index to be in sync with the firmware
to support MQ.
Add irq number to the MSIX entry.
Define a software workqueue table to track the status of
io_reqs. Define a base for the copy workqueue.

Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
---
 drivers/scsi/fnic/fnic.h | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/fnic/fnic.h b/drivers/scsi/fnic/fnic.h
index 9fd01a867788..f4390fc96323 100644
--- a/drivers/scsi/fnic/fnic.h
+++ b/drivers/scsi/fnic/fnic.h
@@ -163,12 +163,21 @@ do {								\
 #define FNIC_MAIN_NOTE(kern_level, host, fmt, args...)          \
 	shost_printk(kern_level, host, fmt, ##args)
 
+#define FNIC_WQ_COPY_MAX 64
+#define FNIC_WQ_MAX 1
+#define FNIC_RQ_MAX 1
+#define FNIC_CQ_MAX (FNIC_WQ_COPY_MAX + FNIC_WQ_MAX + FNIC_RQ_MAX)
+#define FNIC_DFLT_IO_COMPLETIONS 256
+
+#define FNIC_MQ_CQ_INDEX        2
+
 extern const char *fnic_state_str[];
 
 enum fnic_intx_intr_index {
 	FNIC_INTX_WQ_RQ_COPYWQ,
-	FNIC_INTX_ERR,
+	FNIC_INTX_DUMMY,
 	FNIC_INTX_NOTIFY,
+	FNIC_INTX_ERR,
 	FNIC_INTX_INTR_MAX,
 };
 
@@ -176,7 +185,7 @@ enum fnic_msix_intr_index {
 	FNIC_MSIX_RQ,
 	FNIC_MSIX_WQ,
 	FNIC_MSIX_WQ_COPY,
-	FNIC_MSIX_ERR_NOTIFY,
+	FNIC_MSIX_ERR_NOTIFY = FNIC_MSIX_WQ_COPY + FNIC_WQ_COPY_MAX,
 	FNIC_MSIX_INTR_MAX,
 };
 
@@ -185,6 +194,7 @@ struct fnic_msix_entry {
 	char devname[IFNAMSIZ + 11];
 	irqreturn_t (*isr)(int, void *);
 	void *devid;
+	int irq_num;
 };
 
 enum fnic_state {
@@ -194,12 +204,6 @@ enum fnic_state {
 	FNIC_IN_ETH_TRANS_FC_MODE,
 };
 
-#define FNIC_WQ_COPY_MAX 1
-#define FNIC_WQ_MAX 1
-#define FNIC_RQ_MAX 1
-#define FNIC_CQ_MAX (FNIC_WQ_COPY_MAX + FNIC_WQ_MAX + FNIC_RQ_MAX)
-#define FNIC_DFLT_IO_COMPLETIONS 256
-
 struct mempool;
 
 enum fnic_evt {
@@ -214,6 +218,13 @@ struct fnic_event {
 	enum fnic_evt event;
 };
 
+struct fnic_cpy_wq {
+	unsigned long hw_lock_flags;
+	u16 active_ioreq_count;
+	u16 ioreq_table_size;
+	____cacheline_aligned struct fnic_io_req **io_req_table;
+};
+
 /* Per-instance private data structure */
 struct fnic {
 	int fnic_num;
@@ -283,6 +294,7 @@ struct fnic {
 	mempool_t *io_sgl_pool[FNIC_SGL_NUM_CACHES];
 	spinlock_t io_req_lock[FNIC_IO_LOCKS];	/* locks for scsi cmnds */
 
+	unsigned int cpy_wq_base;
 	struct work_struct link_work;
 	struct work_struct frame_work;
 	struct sk_buff_head frame_queue;
@@ -302,6 +314,8 @@ struct fnic {
 
 	/* copy work queue cache line section */
 	____cacheline_aligned struct vnic_wq_copy hw_copy_wq[FNIC_WQ_COPY_MAX];
+	____cacheline_aligned struct fnic_cpy_wq sw_copy_wq[FNIC_WQ_COPY_MAX];
+
 	/* completion queue cache line section */
 	____cacheline_aligned struct vnic_cq cq[FNIC_CQ_MAX];
 
-- 
2.31.1


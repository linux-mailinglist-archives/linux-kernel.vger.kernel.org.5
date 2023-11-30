Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F137FE6DF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 03:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344190AbjK3CgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 21:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjK3CgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 21:36:02 -0500
Received: from rcdn-iport-9.cisco.com (rcdn-iport-9.cisco.com [173.37.86.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17C1D71;
        Wed, 29 Nov 2023 18:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3195; q=dns/txt; s=iport;
  t=1701311767; x=1702521367;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mcaSeiV3DCOZVPr6R0+RWxfvehrcdQLMAkhm3bXZX8w=;
  b=dHZF8JYdm3CrXixiPDlTMwB3Mwfau1t/0cIzeseu1m5Y7BImsabu3OKZ
   ec9lfNmCeyEOvFa+02d5BAhI4NkskzqXgF4HASj1Xl2V+oeyZ+iG+oa4I
   y3ABiz3umYb+k//aa9Au6A2Ovyux4RXsw8HHHkfaswJUgPWCFVL62SXbr
   k=;
X-CSE-ConnectionGUID: 59cYfSnMSe2K5avB3PAwJA==
X-CSE-MsgGUID: jeiqYSx+Qeeg79zJYnV+Iw==
X-IronPort-AV: E=Sophos;i="6.04,237,1695686400"; 
   d="scan'208";a="148823866"
Received: from rcdn-core-9.cisco.com ([173.37.93.145])
  by rcdn-iport-9.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 02:36:06 +0000
Received: from localhost.cisco.com ([10.193.101.253])
        (authenticated bits=0)
        by rcdn-core-9.cisco.com (8.15.2/8.15.2) with ESMTPSA id 3AU2YA48007614
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 30 Nov 2023 02:36:06 GMT
From:   Karan Tilak Kumar <kartilak@cisco.com>
To:     sebaddel@cisco.com
Cc:     arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com,
        mkai2@cisco.com, satishkh@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Karan Tilak Kumar <kartilak@cisco.com>
Subject: [PATCH v4 06/13] scsi: fnic: Refactor and redefine fnic.h for multiqueue
Date:   Wed, 29 Nov 2023 18:33:55 -0800
Message-Id: <20231130023402.802282-7-kartilak@cisco.com>
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

Refactor and re-define values in fnic.h to implement
multiqueue(MQ) functionality.

VIC firmware allows fnic to create up to 64 copy
workqueues. Update the copy workqueue max to 64.
Modify the interrupt index to be in sync with the firmware
to support MQ.
Add irq number to the MSIX entry.
Define a software workqueue table to track the status of
io_reqs. Define a base for the copy workqueue.

Changes between v2 and v3:
    Replace cpy_wq_base with copy_wq_base.

Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
---
 drivers/scsi/fnic/fnic.h | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/fnic/fnic.h b/drivers/scsi/fnic/fnic.h
index f4bd0e13203d..07d67fe903f2 100644
--- a/drivers/scsi/fnic/fnic.h
+++ b/drivers/scsi/fnic/fnic.h
@@ -167,12 +167,21 @@ do {								\
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
 
@@ -180,7 +189,7 @@ enum fnic_msix_intr_index {
 	FNIC_MSIX_RQ,
 	FNIC_MSIX_WQ,
 	FNIC_MSIX_WQ_COPY,
-	FNIC_MSIX_ERR_NOTIFY,
+	FNIC_MSIX_ERR_NOTIFY = FNIC_MSIX_WQ_COPY + FNIC_WQ_COPY_MAX,
 	FNIC_MSIX_INTR_MAX,
 };
 
@@ -189,6 +198,7 @@ struct fnic_msix_entry {
 	char devname[IFNAMSIZ + 11];
 	irqreturn_t (*isr)(int, void *);
 	void *devid;
+	int irq_num;
 };
 
 enum fnic_state {
@@ -198,12 +208,6 @@ enum fnic_state {
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
@@ -218,6 +222,13 @@ struct fnic_event {
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
@@ -287,6 +298,7 @@ struct fnic {
 	mempool_t *io_sgl_pool[FNIC_SGL_NUM_CACHES];
 	spinlock_t io_req_lock[FNIC_IO_LOCKS];	/* locks for scsi cmnds */
 
+	unsigned int copy_wq_base;
 	struct work_struct link_work;
 	struct work_struct frame_work;
 	struct sk_buff_head frame_queue;
@@ -306,6 +318,8 @@ struct fnic {
 
 	/* copy work queue cache line section */
 	____cacheline_aligned struct vnic_wq_copy hw_copy_wq[FNIC_WQ_COPY_MAX];
+	____cacheline_aligned struct fnic_cpy_wq sw_copy_wq[FNIC_WQ_COPY_MAX];
+
 	/* completion queue cache line section */
 	____cacheline_aligned struct vnic_cq cq[FNIC_CQ_MAX];
 
-- 
2.31.1


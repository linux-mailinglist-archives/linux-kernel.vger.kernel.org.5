Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085DC77FDD3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354400AbjHQSYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354480AbjHQSX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:23:58 -0400
Received: from rcdn-iport-4.cisco.com (rcdn-iport-4.cisco.com [173.37.86.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DA23C06;
        Thu, 17 Aug 2023 11:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3332; q=dns/txt; s=iport;
  t=1692296613; x=1693506213;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EAFmCMjCURKVOVoD03Cmoz021Qx7FN68afEqBii0SgA=;
  b=Jc7fp++knzYmrMr7VNa+2ZT3tCvzh0QK14up38tkmI0RdSrgUkomDsy3
   Q9OW4GJ2jCtkI1eKC/oMzZj1+WILZR2qDJZOzcbR+rnfdKNp+dhQv2Xwa
   5bt/GYE+NgyDt5Ah8siC/l09+M1JGprNgqpQAGlRuBD6dqB2/rVjMmlHF
   s=;
X-IronPort-AV: E=Sophos;i="6.01,180,1684800000"; 
   d="scan'208";a="102870598"
Received: from rcdn-core-7.cisco.com ([173.37.93.143])
  by rcdn-iport-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 18:22:21 +0000
Received: from localhost.cisco.com ([10.193.101.253])
        (authenticated bits=0)
        by rcdn-core-7.cisco.com (8.15.2/8.15.2) with ESMTPSA id 37HIMCar015707
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 17 Aug 2023 18:22:20 GMT
From:   Karan Tilak Kumar <kartilak@cisco.com>
To:     sebaddel@cisco.com
Cc:     arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com,
        mkai2@cisco.com, satishkh@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Karan Tilak Kumar <kartilak@cisco.com>
Subject: [PATCH] scsi: fnic: Replace sgreset tag with max_tag_id
Date:   Thu, 17 Aug 2023 11:21:46 -0700
Message-Id: <20230817182146.229059-1-kartilak@cisco.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: kartilak@cisco.com
X-Outbound-SMTP-Client: 10.193.101.253, [10.193.101.253]
X-Outbound-Node: rcdn-core-7.cisco.com
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sgreset is issued with a scsi command pointer.
The device reset code assumes that it was issued
on a hardware queue, and calls block multiqueue
layer. However, the assumption is broken, and
there is no hardware queue associated with the
sgreset, and this leads to a crash due to a
null pointer exception.

Fix the code to use the max_tag_id as a tag
which does not overlap with the other tags
issued by mid layer.

Tested by running FC traffic for a few minutes,
and by issuing sgreset on the device in parallel.
Without the fix, the crash is observed right away.
With this fix, no crash is observed.

Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
Tested-by: Karan Tilak Kumar <kartilak@cisco.com>
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
---
 drivers/scsi/fnic/fnic.h      |  3 ++-
 drivers/scsi/fnic/fnic_scsi.c | 20 +++++++++-----------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/fnic/fnic.h b/drivers/scsi/fnic/fnic.h
index e51e92f932fa..93c68931a593 100644
--- a/drivers/scsi/fnic/fnic.h
+++ b/drivers/scsi/fnic/fnic.h
@@ -27,7 +27,7 @@
 
 #define DRV_NAME		"fnic"
 #define DRV_DESCRIPTION		"Cisco FCoE HBA Driver"
-#define DRV_VERSION		"1.6.0.55"
+#define DRV_VERSION		"1.6.0.56"
 #define PFX			DRV_NAME ": "
 #define DFX                     DRV_NAME "%d: "
 
@@ -236,6 +236,7 @@ struct fnic {
 	unsigned int wq_count;
 	unsigned int cq_count;
 
+	struct mutex sgreset_mutex;
 	struct dentry *fnic_stats_debugfs_host;
 	struct dentry *fnic_stats_debugfs_file;
 	struct dentry *fnic_reset_debugfs_file;
diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c
index be89ce96df46..185142efee3d 100644
--- a/drivers/scsi/fnic/fnic_scsi.c
+++ b/drivers/scsi/fnic/fnic_scsi.c
@@ -2222,7 +2222,6 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 	struct reset_stats *reset_stats;
 	int tag = rq->tag;
 	DECLARE_COMPLETION_ONSTACK(tm_done);
-	int tag_gen_flag = 0;   /*to track tags allocated by fnic driver*/
 	bool new_sc = 0;
 
 	/* Wait for rport to unblock */
@@ -2252,17 +2251,17 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 	}
 
 	fnic_priv(sc)->flags = FNIC_DEVICE_RESET;
-	/* Allocate tag if not present */
 
 	if (unlikely(tag < 0)) {
 		/*
-		 * Really should fix the midlayer to pass in a proper
-		 * request for ioctls...
+		 * For device reset issued through sg3utils, we let
+		 * only one LUN_RESET to go through and use a special
+		 * tag equal to max_tag_id so that we don't have to allocate
+		 * or free it. It won't interact with tags
+		 * allocated by mid layer.
 		 */
-		tag = fnic_scsi_host_start_tag(fnic, sc);
-		if (unlikely(tag == SCSI_NO_TAG))
-			goto fnic_device_reset_end;
-		tag_gen_flag = 1;
+		mutex_lock(&fnic->sgreset_mutex);
+		tag = fnic->fnic_max_tag_id;
 		new_sc = 1;
 	}
 	io_lock = fnic_io_lock_hash(fnic, sc);
@@ -2434,9 +2433,8 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 		  (u64)sc->cmnd[4] << 8 | sc->cmnd[5]),
 		  fnic_flags_and_state(sc));
 
-	/* free tag if it is allocated */
-	if (unlikely(tag_gen_flag))
-		fnic_scsi_host_end_tag(fnic, sc);
+	if (new_sc)
+		mutex_unlock(&fnic->sgreset_mutex);
 
 	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
 		      "Returning from device reset %s\n",
-- 
2.31.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3E2765C39
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 21:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjG0TlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 15:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjG0TlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 15:41:03 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 27 Jul 2023 12:41:02 PDT
Received: from rcdn-iport-3.cisco.com (rcdn-iport-3.cisco.com [173.37.86.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE8C2D57
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 12:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1648; q=dns/txt; s=iport;
  t=1690486862; x=1691696462;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oTyLA368YHVV2V2TEnTOavcBXNzBkBdMAX0O2LhAFlQ=;
  b=Iy3NbNRlpdErk5vlSpp2bp28ttOGHnrpd/IbZZHEvCTJsjVKzleKQlEQ
   lqBFClMsMr1YwKlZRv+/gNR2Dx5Hc5/f4wCI/+CcjpmvGp4YNg7o4Muz1
   h6BMmMVUesCYjPQl3lsJmwlReyRkrpQiEuasjz6LlFbvb6aC1gqJDjheV
   M=;
X-IronPort-AV: E=Sophos;i="6.01,235,1684800000"; 
   d="scan'208";a="94211750"
Received: from rcdn-core-4.cisco.com ([173.37.93.155])
  by rcdn-iport-3.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 19:40:00 +0000
Received: from localhost.cisco.com ([10.193.101.253])
        (authenticated bits=0)
        by rcdn-core-4.cisco.com (8.15.2/8.15.2) with ESMTPSA id 36RJdofl018909
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Jul 2023 19:39:59 GMT
From:   Karan Tilak Kumar <kartilak@cisco.com>
To:     sebaddel@cisco.com
Cc:     arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com,
        satishkh@cisco.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Karan Tilak Kumar <kartilak@cisco.com>
Subject: [PATCH] scsi: fnic: Replace return codes in fnic_clean_pending_aborts()
Date:   Thu, 27 Jul 2023 12:39:19 -0700
Message-Id: <20230727193919.2519-1-kartilak@cisco.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: kartilak@cisco.com
X-Outbound-SMTP-Client: 10.193.101.253, [10.193.101.253]
X-Outbound-Node: rcdn-core-4.cisco.com
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fnic_clean_pending_aborts() was returning a non-zero value
irrespective of failure or success.
This caused the caller of this function to assume that the
device reset had failed, even though it would succeed in
most cases. As a consequence, a successful device reset
would escalate to host reset.

Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
Tested-by: Karan Tilak Kumar <kartilak@cisco.com>
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
---
 fnic.h      | 2 +-
 fnic_scsi.c | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fnic.h b/fnic.h
index 85ec616..87c12d5 100644
--- a/fnic.h
+++ b/fnic.h
@@ -39,7 +39,7 @@
 
 #define DRV_NAME		"fnic"
 #define DRV_DESCRIPTION		"Cisco FCoE HBA Driver"
-#define DRV_VERSION		"1.6.0.54"
+#define DRV_VERSION		"1.6.0.55"
 #define PFX			DRV_NAME ": "
 #define DFX                     DRV_NAME "%d: "
 
diff --git a/fnic_scsi.c b/fnic_scsi.c
index 3d64877..02e2fea 100644
--- a/fnic_scsi.c
+++ b/fnic_scsi.c
@@ -2156,7 +2156,7 @@ static int fnic_clean_pending_aborts(struct fnic *fnic,
 				     bool new_sc)
 
 {
-	int ret = SUCCESS;
+	int ret = 0;
 	struct fnic_pending_aborts_iter_data iter_data = {
 		.fnic = fnic,
 		.lun_dev = lr_sc->device,
@@ -2176,9 +2176,11 @@ static int fnic_clean_pending_aborts(struct fnic *fnic,
 
 	/* walk again to check, if IOs are still pending in fw */
 	if (fnic_is_abts_pending(fnic, lr_sc))
-		ret = FAILED;
+		ret = 1;
 
 clean_pending_aborts_end:
+	FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host,
+			"%s: exit status: %d\n", __func__, ret);
 	return ret;
 }
 
-- 
2.26.2.Cisco


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038907D0682
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 04:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346873AbjJTCeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 22:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235581AbjJTCeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 22:34:36 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 95F92115;
        Thu, 19 Oct 2023 19:34:33 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 793C7604C5029;
        Fri, 20 Oct 2023 10:34:29 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     dan.carpenter@linaro.org, kartilak@cisco.com, sebaddel@cisco.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     Su Hui <suhui@nfschina.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2] scsi: snici: remove useless code in snic_dr_clean_pending_req
Date:   Fri, 20 Oct 2023 10:33:27 +0800
Message-Id: <20231020023326.43898-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

return error code directly to save space and be more clear.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/scsi/snic/snic_scsi.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/snic/snic_scsi.c b/drivers/scsi/snic/snic_scsi.c
index c50ede326cc4..84973f0f771e 100644
--- a/drivers/scsi/snic/snic_scsi.c
+++ b/drivers/scsi/snic/snic_scsi.c
@@ -1850,7 +1850,7 @@ snic_dr_clean_pending_req(struct snic *snic, struct scsi_cmnd *lr_sc)
 {
 	struct scsi_device *lr_sdev = lr_sc->device;
 	u32 tag = 0;
-	int ret = FAILED;
+	int ret;
 
 	for (tag = 0; tag < snic->max_tag_id; tag++) {
 		if (tag == snic_cmd_tag(lr_sc))
@@ -1859,7 +1859,6 @@ snic_dr_clean_pending_req(struct snic *snic, struct scsi_cmnd *lr_sc)
 		ret = snic_dr_clean_single_req(snic, tag, lr_sdev);
 		if (ret) {
 			SNIC_HOST_ERR(snic->shost, "clean_err:tag = %d\n", tag);
-
 			goto clean_err;
 		}
 	}
@@ -1867,24 +1866,19 @@ snic_dr_clean_pending_req(struct snic *snic, struct scsi_cmnd *lr_sc)
 	schedule_timeout(msecs_to_jiffies(100));
 
 	/* Walk through all the cmds and check abts status. */
-	if (snic_is_abts_pending(snic, lr_sc)) {
-		ret = FAILED;
-
+	if (snic_is_abts_pending(snic, lr_sc))
 		goto clean_err;
-	}
 
-	ret = 0;
 	SNIC_SCSI_DBG(snic->shost, "clean_pending_req: Success.\n");
 
-	return ret;
+	return 0;
 
 clean_err:
-	ret = FAILED;
 	SNIC_HOST_ERR(snic->shost,
 		      "Failed to Clean Pending IOs on %s device.\n",
 		      dev_name(&lr_sdev->sdev_gendev));
 
-	return ret;
+	return FAILED;
 
 } /* end of snic_dr_clean_pending_req */
 
-- 
2.30.2


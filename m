Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456D07B5482
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237547AbjJBNvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237525AbjJBNvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:51:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BBDB8;
        Mon,  2 Oct 2023 06:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696254693; x=1727790693;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=S3iQVHA5BHkLqfd9QE4Rl6YyMeWLrSfAyfSV26Quxho=;
  b=GOEM3zb5byGmulXmCridfaiO2VinmY+8EkoJEi5r+NijkshvTc7WgwVh
   xx07dJwFsmtYpdliu+BbZKiSEBsO5xvnB8n9A6UB3ETueusXpv74X5yfy
   K+027/cYn1wC+NmHKQ5r9NOBbEdo7VFShX1+JHE53OQ2HpDWy7oN6eI4J
   fEZzNcINIOLtrq+yj7KzMGo+hRwsbHNKCVRv5qwnM/jOX4QR5RnURnBc9
   d4TqeVlBkaJqSBP1Qi0YbDAIRL4ID8VflrMhTjN23Ndpy/S4VgGIq7O62
   8dQnGGpOU2CrzojtEbFDvoNEnx4obnmghb5q9jmyzcjm0niNCrDatsrlv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="372994639"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="372994639"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 06:51:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="866500765"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="866500765"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 02 Oct 2023 06:51:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 133231A7; Mon,  2 Oct 2023 16:51:27 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] scsi: ufs: ufs-pci: Switch to use acpi_evaluate_dsm_typed()
Date:   Mon,  2 Oct 2023 16:51:25 +0300
Message-Id: <20231002135125.2602895-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The acpi_evaluate_dsm_typed() provides a way to check the type of the
object evaluated by _DSM call. Use it instead of open coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ufs/host/ufshcd-pci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/host/ufshcd-pci.c b/drivers/ufs/host/ufshcd-pci.c
index 248a49e5e7f3..0aca666d2199 100644
--- a/drivers/ufs/host/ufshcd-pci.c
+++ b/drivers/ufs/host/ufshcd-pci.c
@@ -58,11 +58,12 @@ static int __intel_dsm(struct intel_host *intel_host, struct device *dev,
 	int err = 0;
 	size_t len;
 
-	obj = acpi_evaluate_dsm(ACPI_HANDLE(dev), &intel_dsm_guid, 0, fn, NULL);
+	obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(dev), &intel_dsm_guid, 0, fn, NULL,
+				      ACPI_TYPE_BUFFER);
 	if (!obj)
 		return -EOPNOTSUPP;
 
-	if (obj->type != ACPI_TYPE_BUFFER || obj->buffer.length < 1) {
+	if (obj->buffer.length < 1) {
 		err = -EINVAL;
 		goto out;
 	}
-- 
2.40.0.1.gaa8946217a0b


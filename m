Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1261B7EEA22
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 01:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345574AbjKQADf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 19:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKQADe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 19:03:34 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123CA109;
        Thu, 16 Nov 2023 16:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700179411; x=1731715411;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=mnWDfR921z2tBGWM2mu+YHLyuTCVuHhoCnMImJjBo0k=;
  b=ROkciI2be9Qx40/WGmV48wLTDlOiRLYVPe7vuASiHdkSwBo6NiiGfyzY
   BsR+QAery5xOkTiU74jIkK1qqRm+6xi57iS786xmIzN0DCDorviQ+5nPA
   xagFw8ttU6+znVePeTBGqOI+c3RFfmcF4qOKqQ2SADsDRSz8YFEVHpswK
   U2EgVp7wOB2/D5kH1t+n3Xz4NMKF20VKf20r4m2bgwJmeG23KqrlEGhhz
   AO3wDSqllxqu/I4IveJzKCZbQl7E70VtmIdl5nQN++NBM0gNB0SOO77+l
   vEZ3aitYGwVmrBf6SM5eY573O4Y2uChINxdv8kIW5BbNVjnQcxe7YBOWX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="370561255"
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="370561255"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 16:03:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="715376900"
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="715376900"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.213.168.188])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 16:03:29 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Thu, 16 Nov 2023 16:03:29 -0800
Subject: [PATCH] cxl/cdat: Free correct buffer on checksum error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com>
X-B4-Tracking: v=1; b=H4sIANCtVmUC/x2NQQrDMAwEvxJ0rqC2Q1P6ldKDbCuJDnGLFEIh5
 O9VepxZht3BWIUNHt0OypuYvJtDuHRQZmoTo1RniNeYQgg3HOWLpdKKlbcFR2XG3A81xdzne0r
 gYSZzqdTKfKYL2cp6Dh9lz/9vz9dx/ABN0pQlfQAAAA==
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fan Ni <nifan.cxl@gmail.com>, Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700179408; l=2409;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=mnWDfR921z2tBGWM2mu+YHLyuTCVuHhoCnMImJjBo0k=;
 b=TCeMoscd1/Vjt58MoU0kO50swM+axmx58nKGj6nCHyDymNBP73R+POgZ0K9Q8CqzlsTG0Blar
 RL/rriddklcBzsur+uTntwitINXWzIle1Ya+VAXwA5qPpBqFHLJfn+m
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new 6.7-rc1 kernel now checks the checksum on CDAT data.  While
using a branch of Fan's DCD qemu work (and specifying DCD devices), the
following splat was observed.

	WARNING: CPU: 1 PID: 1384 at drivers/base/devres.c:1064 devm_kfree+0x4f/0x60
	...
	RIP: 0010:devm_kfree+0x4f/0x60
	...
 	? devm_kfree+0x4f/0x60
 	read_cdat_data+0x1a0/0x2a0 [cxl_core]
 	cxl_port_probe+0xdf/0x200 [cxl_port]
	...

The issue in qemu is still unknown but the spat is a straight forward
bug in the CDAT checksum processing code.  Use a CDAT buffer variable to
ensure the devm_free() works correctly on error.

Cc: jonathan.cameron@huawei.com
Cc: Fan Ni <nifan.cxl@gmail.com>
Fixes: 670e4e88f3b1 ("cxl: Add checksum verification to CDAT from CXL")
Cc: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/pci.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index eff20e83d0a6..5aaa0b36c42a 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -620,7 +620,7 @@ void read_cdat_data(struct cxl_port *port)
 	struct pci_dev *pdev = NULL;
 	struct cxl_memdev *cxlmd;
 	size_t cdat_length;
-	void *cdat_table;
+	void *cdat_table, *cdat_buf;
 	int rc;
 
 	if (is_cxl_memdev(uport)) {
@@ -651,16 +651,16 @@ void read_cdat_data(struct cxl_port *port)
 		return;
 	}
 
-	cdat_table = devm_kzalloc(dev, cdat_length + sizeof(__le32),
+	cdat_buf = devm_kzalloc(dev, cdat_length + sizeof(__le32),
 				  GFP_KERNEL);
-	if (!cdat_table)
+	if (!cdat_buf)
 		return;
 
-	rc = cxl_cdat_read_table(dev, cdat_doe, cdat_table, &cdat_length);
+	rc = cxl_cdat_read_table(dev, cdat_doe, cdat_buf, &cdat_length);
 	if (rc)
 		goto err;
 
-	cdat_table = cdat_table + sizeof(__le32);
+	cdat_table = cdat_buf + sizeof(__le32);
 	if (cdat_checksum(cdat_table, cdat_length))
 		goto err;
 
@@ -670,7 +670,7 @@ void read_cdat_data(struct cxl_port *port)
 
 err:
 	/* Don't leave table data allocated on error */
-	devm_kfree(dev, cdat_table);
+	devm_kfree(dev, cdat_buf);
 	dev_err(dev, "Failed to read/validate CDAT.\n");
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);

---
base-commit: 7475e51b87969e01a6812eac713a1c8310372e8a
change-id: 20231116-fix-cdat-devm-free-b47d32b4b833

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>


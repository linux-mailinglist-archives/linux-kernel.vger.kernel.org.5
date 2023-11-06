Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F607E2C28
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 19:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjKFSlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 13:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjKFSlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 13:41:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B97DD6A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 10:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699296059; x=1730832059;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5VO6DPoM2p3Mtjo0hiJP2G4WEIXi30lKtx7rB1dBncU=;
  b=d9UXBZyhnolq/Lot+/bqx5TTa5+j3Gw+GCKTFSlKhoFzlAmmuW+Nez+c
   VMRWp2tTM6UxKvcqlEhXFzRFL3fNnham3niG8NAQMQtV8uJegGXcnYVxI
   WRf/uZEVqrKXP+jR6j4F9w6hZtMzTEaJqwFKpax83vuUNfQdZT5Y8ansH
   9PXw8P3p2s0+LquLwaKSgNeDqHpk/s84fsxeKbOEnsk/xVhccUMc0cnmI
   73+WuO39EqxxCopD2wjvkNrwK2fdDbGwDE8em7/QHBgb+MpQXcD2WfDMr
   raVbsbOsmdJV32n0PpgsnmStC6Y3xuA8z1PJuOG86P8T4xc5ybe6BRhlH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="369549381"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="369549381"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 10:40:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="1009622595"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="1009622595"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 06 Nov 2023 10:40:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 448AE17F; Mon,  6 Nov 2023 20:40:55 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chen Ni <nichen@iscas.ac.cn>, linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>
Subject: [PATCH v3 1/2] mfd: intel-lpss: Use PCI APIs instead of derefereincing
Date:   Mon,  6 Nov 2023 20:40:51 +0200
Message-Id: <20231106184052.1166579-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231106184052.1166579-1-andriy.shevchenko@linux.intel.com>
References: <20231106184052.1166579-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a few PCI APIs that may be used instead of direct dereferencibg,
Using them will also provide better error codes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel-lpss-pci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index ae5759200622..cf56cd3a40ee 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -37,13 +37,17 @@ static int intel_lpss_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		return ret;
 
+	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_LEGACY);
+	if (ret)
+		return ret;
+
 	info = devm_kmemdup(&pdev->dev, (void *)id->driver_data, sizeof(*info),
 			    GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
-	info->mem = &pdev->resource[0];
-	info->irq = pdev->irq;
+	info->mem = pci_resource_n(pdev, 0);
+	info->irq = pci_irq_vector(pdev, 0);
 
 	if (pci_match_id(ignore_resource_conflicts_ids, pdev))
 		info->ignore_resource_conflicts = true;
-- 
2.40.0.1.gaa8946217a0b


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABAA7FF1DF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbjK3OcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjK3OcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:32:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0805E85
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701354738; x=1732890738;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ew2kPcLfyTuYr73yBcv/Hlg5hDX86dci/VlQ3uXRnrU=;
  b=QchrlufbQ9Li7H9gTBxf5REqh9bOjgJLLqy7qLfsdcMrQNlTaW1uYJB6
   3jjqZgAU+Rg3lfd/kAUDd1V50kRQS9072KfCk7RktWCkZ98BoZmhvk7HZ
   S0kUFo6C0bPpqLuyYRmMpiJ6avxfbrMs3Mlra/DQL4NdV4kU/eGFcaTe6
   s86+7IAjVNIWTCgs5z46uNW8vsqvvwjohvGrklITc4e+V5UaKAdqaCOrH
   /RrnfEGsgx6V9KssPPQoRP5YRDj4GaUnaHhxhhysM35GkRGs9Hk0cl/un
   PT8NrR0VlEAug8OTJhxoL6gmVKRIGVUeH3V7hd9RXZoHDX3jGBMNoVE3n
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="318489"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="318489"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 06:32:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="860210825"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="860210825"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Nov 2023 06:32:16 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B1A56535; Thu, 30 Nov 2023 16:32:14 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH v1 1/1] mfd: intel-lpss: Don't fail probe on success of pci_alloc_irq_vectors()
Date:   Thu, 30 Nov 2023 16:32:06 +0200
Message-ID: <20231130143206.1475831-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
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

The pci_alloc_irq_vectors() returns a positive number on success.
Hence we have to filter the negative numbers for error condition.
Update the check accordingly.

Fixes: e6951fb78787 ("mfd: intel-lpss: Use PCI APIs instead of dereferencing")
Reported-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel-lpss-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index 8f5e10817a9c..4621d3950b8f 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -44,7 +44,7 @@ static int intel_lpss_pci_probe(struct pci_dev *pdev,
 		return ret;
 
 	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_LEGACY);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	info = devm_kmemdup(&pdev->dev, data, sizeof(*info), GFP_KERNEL);
-- 
2.43.0.rc1.1.gbec44491f096


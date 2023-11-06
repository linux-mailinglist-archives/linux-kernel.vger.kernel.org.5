Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAB57E2C27
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 19:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbjKFSlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 13:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjKFSlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 13:41:01 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4815ED47
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 10:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699296058; x=1730832058;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yZw7GYy+N6jTZtY91G4MW52jOels4nZRd0O+FRCOOSg=;
  b=gDGfPnv4V5VgNcqEU71hGyUVFDp+K4pFd04cI5wo7kOEBm2vt4BhQaD5
   NthsbhN40h7BFt5tG4deG6GD00ANxSZV0/hleojNVxgTOWO4lUIaDIXLQ
   bxOobSiKSD77aHHZ+m5Xpa2UXONlM7WLkywyA0Ggbsk0MPT4QrAx5dLI0
   kFJT9v2OyufpVmhtBlG2ejw5qOBYmdqLdIPDGZnmxhpq6gldZ9w3RRBXz
   k/zkxViHmBWfdVThWV/5lptAwE7ygh0q+OrdAdPR3OY0WfQHEzGR5EVR+
   y3VdscWHTwTxR45V3mZ+r9FXcms0Ln5tyH3mZ5XTXj6vtz8SX7g+ItZtg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="369549378"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="369549378"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 10:40:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="1009622594"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="1009622594"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 06 Nov 2023 10:40:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 52C4B706; Mon,  6 Nov 2023 20:40:55 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chen Ni <nichen@iscas.ac.cn>, linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>
Subject: [PATCH v3 2/2] mfd: intel-lpss: Amend IRQ check
Date:   Mon,  6 Nov 2023 20:40:52 +0200
Message-Id: <20231106184052.1166579-3-andriy.shevchenko@linux.intel.com>
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

From: Chen Ni <nichen@iscas.ac.cn>

platform_get_irq() returns a negative error code to indicating an
error. All the same does pci_alloc_irq_vectors() and pci_irq_vector().
So in intel_lpss_probe() the erroneous IRQ should be better returned
as is.

The pci_alloc_irq_vectors() call and platform_get_irq() guarantee
that IRQ won't be 0, hence drop that check.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
[andy: updated commit message]
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel-lpss.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
index 9591b354072a..4c9d0222751a 100644
--- a/drivers/mfd/intel-lpss.c
+++ b/drivers/mfd/intel-lpss.c
@@ -378,9 +378,12 @@ int intel_lpss_probe(struct device *dev,
 	struct intel_lpss *lpss;
 	int ret;
 
-	if (!info || !info->mem || info->irq <= 0)
+	if (!info || !info->mem)
 		return -EINVAL;
 
+	if (info->irq < 0)
+		return info->irq;
+
 	lpss = devm_kzalloc(dev, sizeof(*lpss), GFP_KERNEL);
 	if (!lpss)
 		return -ENOMEM;
-- 
2.40.0.1.gaa8946217a0b


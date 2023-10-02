Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4697E7B548B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237522AbjJBNvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237500AbjJBNvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:51:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738C7B7;
        Mon,  2 Oct 2023 06:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696254668; x=1727790668;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Il1UW3rc7f2ltP/ooMOqPyLygbgye98+W7fo5U+PUjI=;
  b=IFkqQjFc4EUT+RZh6aYIu06O1+nXNNfmTQLHsBoMK5S3M5AavCLSTdXq
   4Ga8bbdUES9PEWdYkfUOCH4aFMw8+VbpW03/GcLLk0noQq3JrCuw2kd9n
   wgor6OJS0UebW8hy2L7MysnqS7UAiewivzafdX1u4CSxMkySbpL/M+mNa
   A9YReknAxKbxjcmSwMz4jTF/SscioTVstSH+72Wl0FtsXQikbKDCPiGfn
   gz91q96yKQMoQ/s23jiKB9lf0RnSpuNSqznu0fdDdsaT+Y7HCiX0R9pMT
   w2Y+uW80p9hXnCpbC7/pP0GjJDv19b3DWiyypcsRR67VZcCAvfQvRlJrx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="382552082"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="382552082"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 06:51:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="874361739"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="874361739"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 02 Oct 2023 06:51:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B07D81A7; Mon,  2 Oct 2023 16:51:04 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] mmc: sdhci-pci: Switch to use acpi_evaluate_dsm_typed()
Date:   Mon,  2 Oct 2023 16:51:03 +0300
Message-Id: <20231002135103.2602847-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The acpi_evaluate_dsm_typed() provides a way to check the type of the
object evaluated by _DSM call. Use it instead of open coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 7c14feb5db77..025b31aa712c 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -483,11 +483,12 @@ static int __intel_dsm(struct intel_host *intel_host, struct device *dev,
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


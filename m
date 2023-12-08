Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115B080A9FC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbjLHREf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjLHREe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:04:34 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23AF10EB;
        Fri,  8 Dec 2023 09:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702055080; x=1733591080;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VWVAoJVhNy69aBR1eMnYwRmj8xiYxr2EMDRIqEoEaI0=;
  b=mNh0BFgfbgeIC+FbCp14Dm8s0nIoYp4ddWMiEpgBD1eY7ap/uD0Oa5tz
   reAGinNZ/QjN1BlPtZI8Em1/6VUqdYBt3QlHEAdhiCw5Z4IzrOJo2BXUD
   i/lQsBa4kbn90v1Co077eMHdmfe4mucF6gvtRVpM6ToQOeZToIx6OE/3E
   w/Tm9oYDmm0d1gTJQEHSvRu9hBVfMThupjg4Q9U7dlnkxSVNAJCIGw7F9
   gMPGD7t3OADB8zJ2FFy1X0/8qIMRSkIEymqlajrLf6atIYyxzdaqgUIHV
   ThaFqS50cJUizsQ43qSPco/e2JJc2gCzFRdqrBNlOKshOxojA7jGjQXz3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="374593146"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="374593146"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 09:04:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="748401426"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="748401426"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 08 Dec 2023 09:04:38 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AE54D284; Fri,  8 Dec 2023 19:04:37 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 2/2] spi: pxa2xx: Update DMA mapping and using logic in the documentation
Date:   Fri,  8 Dec 2023 19:02:55 +0200
Message-ID: <20231208170436.3309648-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20231208170436.3309648-1-andriy.shevchenko@linux.intel.com>
References: <20231208170436.3309648-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update DMA mapping and using logic in the documentation to follow what
the code does.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/spi/pxa2xx.rst | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/Documentation/spi/pxa2xx.rst b/Documentation/spi/pxa2xx.rst
index 143f1df83f79..19479b801826 100644
--- a/Documentation/spi/pxa2xx.rst
+++ b/Documentation/spi/pxa2xx.rst
@@ -193,17 +193,14 @@ mode supports both coherent and stream based DMA mappings.
 The following logic is used to determine the type of I/O to be used on
 a per "spi_transfer" basis::
 
-  if !enable_dma then
-	always use PIO transfers
+  if spi_message.len > 65536 then
+	if spi_message.is_dma_mapped or rx_dma_buf != 0 or tx_dma_buf != 0 then
+		reject premapped transfers
 
-  if spi_message.len > 8191 then
 	print "rate limited" warning
 	use PIO transfers
 
-  if spi_message.is_dma_mapped and rx_dma_buf != 0 and tx_dma_buf != 0 then
-	use coherent DMA mode
-
-  if rx_buf and tx_buf are aligned on 8 byte boundary then
+  if enable_dma and the size is in the range [DMA burst size..65536] then
 	use streaming DMA mode
 
   otherwise
-- 
2.43.0.rc1.1.gbec44491f096


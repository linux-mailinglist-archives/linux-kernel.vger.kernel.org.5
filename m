Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A84809522
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 23:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444065AbjLGWOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 17:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjLGWOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 17:14:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA9310F1;
        Thu,  7 Dec 2023 14:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701987276; x=1733523276;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eZrxGwvAgFB0+puF74LZGetWU1/ZtE90ClSmlKQ8eEM=;
  b=PvfkDxCVK8SKvJRq+WukJ1bwWBVC9fjofUFWVJ5+0Ouyla4xqxAvudLE
   hnunuCppeuNM9is/AiCMOEJpH6aYptpXHi0OtQDljX281C2IOrDPgt9oF
   nlZxy+/9Gye1p2x3KBWByAL41lPBe4cJYuZj4/Et5ZsA/08oNs6ejK91H
   chF7d4lo5iIEYVj558fkRY4e3ywbxAS6F63Fg6CmeSE+gMRaQaxUzEUTV
   hFKafu0zuG10J8FwDcJxvRZbInLnb2K10b1IARnYvv7QRksq5fy3g8i1e
   cbhHM5FPWJ/Lqle7tThiqgx9dShhaxIx0haWnuoC33KERHcFVeNnE+0ye
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1197557"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="1197557"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 14:14:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="842365246"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="842365246"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 07 Dec 2023 14:14:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1993E648; Fri,  8 Dec 2023 00:14:33 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 2/2] spi: pxa2xx: Update DMA mapping and using logic in the documentation
Date:   Fri,  8 Dec 2023 00:13:40 +0200
Message-ID: <20231207221426.3259806-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20231207221426.3259806-1-andriy.shevchenko@linux.intel.com>
References: <20231207221426.3259806-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index b66702724ccf..61c7b9dd833b 100644
--- a/Documentation/spi/pxa2xx.rst
+++ b/Documentation/spi/pxa2xx.rst
@@ -193,17 +193,14 @@ mode supports both coherent and stream based DMA mappings.
 The following logic is used to determine the type of I/O to be used on
 a per "spi_transfer" basis::
 
-  if !enable_dma then
-	always use PIO transfers
+  if spi_message.len > 65536 then
+        if spi_message.is_dma_mapped or rx_dma_buf != 0 or tx_dma_buf != 0 then
+              reject premapped transfers
 
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


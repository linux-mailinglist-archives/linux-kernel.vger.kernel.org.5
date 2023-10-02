Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8004A7B5820
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238447AbjJBQTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238407AbjJBQTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:19:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38F91B2;
        Mon,  2 Oct 2023 09:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696263554; x=1727799554;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XIwDvhcLk2v02GLDwaCD9wqDMTdN2dYVtBOJfYJ9NN4=;
  b=Sca32JuCzuVJWhJO5+Kezum95O6TMAQrdKTUuiTlZ5nL8833nplxOEQw
   Q1BjnbentWUDyObz98qjfRkgG381BIfr4v+EUsE5uGWyDUgCwzdVzdqoO
   7eXe8g/I2epAha8oRY7MqPSsHt4RyUSKYTZ/1AJkvc/UNnS2u0OAPKlYY
   p7oVyE19SjBpxKh8rxwa41sj+/5ZeRd7Ijk4vtHm9QY6g+6HR1FCYPj0i
   sRPLdkGxmh+W+Hv8sasSwbLAWonWSAtBEDVJFvGeboj6QBFGGlapP9YAw
   O896hfnDImev1O8e9J8Ejsf/BcVvke4J8c3zAMeu9uAjrF4tkKl9pWKSB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="382588666"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="382588666"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 09:16:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="841031520"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="841031520"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Oct 2023 09:16:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7AB291593; Mon,  2 Oct 2023 19:16:20 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 09/10] xhci: dbc: Use sizeof(*pointer) instead of sizeof(type)
Date:   Mon,  2 Oct 2023 19:16:09 +0300
Message-Id: <20231002161610.2648818-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231002161610.2648818-1-andriy.shevchenko@linux.intel.com>
References: <20231002161610.2648818-1-andriy.shevchenko@linux.intel.com>
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

It is preferred to use sizeof(*pointer) instead of sizeof(type).
The type of the variable can change and one needs not change
the former (unlike the latter). No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/host/xhci-dbgcap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index 88e90c30916c..366ce3146a93 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -380,7 +380,7 @@ static void xhci_dbc_eps_exit(struct xhci_dbc *dbc)
 static int dbc_erst_alloc(struct device *dev, struct xhci_ring *evt_ring,
 		    struct xhci_erst *erst, gfp_t flags)
 {
-	erst->entries = dma_alloc_coherent(dev, sizeof(struct xhci_erst_entry),
+	erst->entries = dma_alloc_coherent(dev, sizeof(*erst->entries),
 					   &erst->erst_dma_addr, flags);
 	if (!erst->entries)
 		return -ENOMEM;
@@ -394,7 +394,7 @@ static int dbc_erst_alloc(struct device *dev, struct xhci_ring *evt_ring,
 
 static void dbc_erst_free(struct device *dev, struct xhci_erst *erst)
 {
-	dma_free_coherent(dev, sizeof(struct xhci_erst_entry), erst->entries,
+	dma_free_coherent(dev, sizeof(*erst->entries), erst->entries,
 			  erst->erst_dma_addr);
 	erst->entries = NULL;
 }
@@ -494,7 +494,7 @@ static int xhci_dbc_mem_init(struct xhci_dbc *dbc, gfp_t flags)
 		goto ctx_fail;
 
 	/* Allocate the string table: */
-	dbc->string_size = sizeof(struct dbc_str_descs);
+	dbc->string_size = sizeof(*dbc->string);
 	dbc->string = dma_alloc_coherent(dev, dbc->string_size,
 					 &dbc->string_dma, flags);
 	if (!dbc->string)
-- 
2.40.0.1.gaa8946217a0b


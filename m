Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FA47CA8F5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbjJPNK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233662AbjJPNJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:09:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DF710B;
        Mon, 16 Oct 2023 06:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697461793; x=1728997793;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lQnIe93FuRHO1a3TqxHeJWs2dtVteDAULQEqBRGV2bo=;
  b=OEg2dXdpTxdBtTvfw1urqi8SIDVuMI0YdqKf+G/wZ5SwsZM2DQGoI5c2
   yJX5eZrzdSrFNHbD4bPPrMMiglt/aFC9yZ4v7ucE1VKT0dEQXh77fT1po
   RDFZ5Wg/rUMC2Ot9zu+JIfeOlQkT9JCKckmqs8haK+Qy/pesyoeyLOGEf
   dIy7Huc8n8d6JetvU3iddy0AoA9XcAybtdou6VRPKoVDRJ+AlZ+/6eQ/i
   XXV59oLRtrhZgSAKGPKhc49xmZmr21w4l/Py44DKio68fcXk46+QRbuUP
   8Se6HmVe7s0FF6BB9Fb4BBpsjW1ZTjhWz+9rSXi6BPpQBB4DnnfeqsoTi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="4133309"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="4133309"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 06:09:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="1087067148"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="1087067148"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 16 Oct 2023 06:09:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 533B081C; Mon, 16 Oct 2023 16:09:42 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 09/10] xhci: dbc: Use sizeof(*pointer) instead of sizeof(type)
Date:   Mon, 16 Oct 2023 16:09:33 +0300
Message-Id: <20231016130934.1158504-10-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231016130934.1158504-1-andriy.shevchenko@linux.intel.com>
References: <20231016130934.1158504-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 0c9fd61e9c5b..73494d55b0be 100644
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


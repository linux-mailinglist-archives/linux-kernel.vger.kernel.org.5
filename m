Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39067F6F28
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbjKXJKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbjKXJJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:09:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F20610D9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700817000; x=1732353000;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BnL04ZlzWqqNTZ2npfUPJmBwQJ698UjGRRwRa2RQJXc=;
  b=jvX3WNbKw1NHsoLtWj6D8VQ43aqKoQhaaJMqGw7QnIft40Kf4R+lCTtR
   ubbdXZNiLej/XlJhay5vPuwGdDNMwtrVOI5S3EiAoXLmCYdiG10eV7VAm
   kX3KjTuPT/U6EYJBERuX9S+UdlcsoxLjAn8JbWe8v6NHJ/osk35E418Bm
   uchuA14MZXESDNQneb3WX25z/K1uOjMHNQ/jhGjerxofeE+Kig1uH/YL9
   Pro7StRaE7NHvSb4AZdvvR9eMpGm+3Cph1EQ2tUO3dELhn4x8/K7TttUY
   A5EcDnj0mYAK3VB0TlBlaf9bb0j1aelW78M2LwiA+Y1mSBogBUtAA9I7B
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="11066494"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="11066494"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 01:09:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="885220557"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="885220557"
Received: from mvlasov-mobl1.ger.corp.intel.com (HELO localhost) ([10.251.220.89])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 01:09:43 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 3/6] xtensa: Use PCI_HEADER_TYPE_MFD instead of literal
Date:   Fri, 24 Nov 2023 11:09:15 +0200
Message-Id: <20231124090919.23687-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231124090919.23687-1-ilpo.jarvinen@linux.intel.com>
References: <20231124090919.23687-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace literal 0x80 with PCI_HEADER_TYPE_MFD. While at it, convert
found_multi into boolean.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 arch/xtensa/lib/pci-auto.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/xtensa/lib/pci-auto.c b/arch/xtensa/lib/pci-auto.c
index aa6752237985..05fc02f9e1c7 100644
--- a/arch/xtensa/lib/pci-auto.c
+++ b/arch/xtensa/lib/pci-auto.c
@@ -11,6 +11,7 @@
  * Based on work from Matt Porter <mporter@mvista.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/pci.h>
@@ -222,10 +223,11 @@ pciauto_postscan_setup_bridge(struct pci_dev *dev, int current_bus, int sub_bus,
 
 int __init pciauto_bus_scan(struct pci_controller *pci_ctrl, int current_bus)
 {
-	int sub_bus, pci_devfn, pci_class, cmdstat, found_multi=0;
+	int sub_bus, pci_devfn, pci_class, cmdstat;
 	unsigned short vid;
 	unsigned char header_type;
 	struct pci_dev *dev = &pciauto_dev;
+	bool found_multi = false;
 
 	pciauto_dev.bus = &pciauto_bus;
 	pciauto_dev.sysdata = pci_ctrl;
@@ -261,11 +263,11 @@ int __init pciauto_bus_scan(struct pci_controller *pci_ctrl, int current_bus)
 			continue;
 
 		if (!PCI_FUNC(pci_devfn))
-			found_multi = header_type & 0x80;
+			found_multi = FIELD_GET(PCI_HEADER_TYPE_MFD, header_type);
 		pci_read_config_word(dev, PCI_VENDOR_ID, &vid);
 
 		if (vid == 0xffff || vid == 0x0000) {
-			found_multi = 0;
+			found_multi = false;
 			continue;
 		}
 
-- 
2.30.2


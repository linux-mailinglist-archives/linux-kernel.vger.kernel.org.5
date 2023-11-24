Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4C57F6F2C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjKXJLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjKXJLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:11:08 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1082C1BD;
        Fri, 24 Nov 2023 01:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700817075; x=1732353075;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UxqqJUYgDGy0V41HkWwj4VqlLP4xwU5p+Vk173/E2Ho=;
  b=CoTr3eZbZ+IHbwU8jKYiSpppSmFe+BVcqymxtRKZroKJ80OoG/+38qVq
   iebwgmsupYJbmp2Ak8xUlz34tIyZqlq4NCZ2K+4T9DfrmDoyVr0KiUE1O
   Ximfx6UELEqJ4QAGaHmwu86FrLowzfMjjSAimpojj/9o+RdL8oNq0+dnp
   rkZ4YeYFuP09XPQG6g/LBVyam+/Rj7M4L6OH1INGey/y9ntWCJUgBMHWg
   sykL8edNOq2CWY4JppyfCvfxjoAvM6cCNxoVGgo6NHbH7q/JA2vsM8+qC
   73CiMG3Xs2alXtAJtw2puv1uXq8GqOhyXDKEJi+uK82TNPox5oGBQKCNY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="5546722"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="5546722"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 01:10:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="1014854104"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="1014854104"
Received: from mvlasov-mobl1.ger.corp.intel.com (HELO localhost) ([10.251.220.89])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 01:10:01 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 5/6] EDAC: Use PCI_HEADER_TYPE_MASK instead of literals
Date:   Fri, 24 Nov 2023 11:09:17 +0200
Message-Id: <20231124090919.23687-5-ilpo.jarvinen@linux.intel.com>
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

Replace literal 0x7f with PCI_HEADER_TYPE_MASK.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/edac/edac_pci_sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/edac_pci_sysfs.c b/drivers/edac/edac_pci_sysfs.c
index 287cc51dbc86..901d4cd3ca38 100644
--- a/drivers/edac/edac_pci_sysfs.c
+++ b/drivers/edac/edac_pci_sysfs.c
@@ -521,7 +521,7 @@ static void edac_pci_dev_parity_clear(struct pci_dev *dev)
 	/* read the device TYPE, looking for bridges */
 	pci_read_config_byte(dev, PCI_HEADER_TYPE, &header_type);
 
-	if ((header_type & 0x7F) == PCI_HEADER_TYPE_BRIDGE)
+	if ((header_type & PCI_HEADER_TYPE_MASK) == PCI_HEADER_TYPE_BRIDGE)
 		get_pci_parity_status(dev, 1);
 }
 
@@ -583,7 +583,7 @@ static void edac_pci_dev_parity_test(struct pci_dev *dev)
 	edac_dbg(4, "PCI HEADER TYPE= 0x%02x %s\n",
 		 header_type, dev_name(&dev->dev));
 
-	if ((header_type & 0x7F) == PCI_HEADER_TYPE_BRIDGE) {
+	if ((header_type & PCI_HEADER_TYPE_MASK) == PCI_HEADER_TYPE_BRIDGE) {
 		/* On bridges, need to examine secondary status register  */
 		status = get_pci_parity_status(dev, 1);
 
-- 
2.30.2


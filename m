Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06567F6F26
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbjKXJJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjKXJJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:09:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B81A1BD
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700816993; x=1732352993;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dtKj/F4zR1OSHuWZtC50tt8Q6NyZniZKExIQR3zPCac=;
  b=PkxD8I+dE7xnQkKACmCEPhU8mbhaQhcQUyDT+hTymDoFvlqhnfXdUREr
   q64SAiK4KU7rM6pDjm6zYRvyipCMOasbBftTDe/keKlR+za1ZO+4kWZV5
   dnS2g7ogcj6J9ZHKaMTBdEp5+KDryEHIXeiA3aSAfNR0pbwxOp3dpHmZ6
   dxm+n9xXP6+xd/3fcQJ9ssWkZtLywEhzamQ3dyrykBr8ilHyAhRfM06OW
   3dRlhndCh3KBwfgCCxLGHWeVGuVS+jyfXsnNzZ5xWmH4iyv5zgxaU7GnA
   dA306BArNJgds5yRCg5U/EONHXHDBiwRxUKB0dARCk/KMCNYhwBAaadA7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="11066444"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="11066444"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 01:09:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="885220552"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="885220552"
Received: from mvlasov-mobl1.ger.corp.intel.com (HELO localhost) ([10.251.220.89])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 01:09:35 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/6] powerpc/fsl-pci: Use PCI_HEADER_TYPE_MASK instead of literal
Date:   Fri, 24 Nov 2023 11:09:14 +0200
Message-Id: <20231124090919.23687-2-ilpo.jarvinen@linux.intel.com>
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

Replace 0x7f literals with PCI_HEADER_TYPE_MASK.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 arch/powerpc/sysdev/fsl_pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 3868483fbe29..ef7707ea0db7 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -54,7 +54,7 @@ static void quirk_fsl_pcie_early(struct pci_dev *dev)
 
 	/* if we aren't in host mode don't bother */
 	pci_read_config_byte(dev, PCI_HEADER_TYPE, &hdr_type);
-	if ((hdr_type & 0x7f) != PCI_HEADER_TYPE_BRIDGE)
+	if ((hdr_type & PCI_HEADER_TYPE_MASK) != PCI_HEADER_TYPE_BRIDGE)
 		return;
 
 	dev->class = PCI_CLASS_BRIDGE_PCI_NORMAL;
@@ -581,7 +581,7 @@ static int fsl_add_bridge(struct platform_device *pdev, int is_primary)
 		hose->ops = &fsl_indirect_pcie_ops;
 		/* For PCIE read HEADER_TYPE to identify controller mode */
 		early_read_config_byte(hose, 0, 0, PCI_HEADER_TYPE, &hdr_type);
-		if ((hdr_type & 0x7f) != PCI_HEADER_TYPE_BRIDGE)
+		if ((hdr_type & PCI_HEADER_TYPE_MASK) != PCI_HEADER_TYPE_BRIDGE)
 			goto no_bridge;
 
 	} else {
-- 
2.30.2


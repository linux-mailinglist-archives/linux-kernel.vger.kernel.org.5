Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A78F7F2D44
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjKUMfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234703AbjKUMfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:35:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB8A192;
        Tue, 21 Nov 2023 04:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700570106; x=1732106106;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HMH5KEeZn7aezfXFMh9Smzjm5lwAV6MHWZcT0k35UEI=;
  b=NDMrL6u0A19a4BQN7FwVKiBagSxC6K90L+TAke/huAwlnLWOq+6FG/eb
   ElWMdOcuJNJRvoXHIfXPMk7hSpvP1XricaqS4EYY6Elz1yBkKNLPzgADw
   4yI5rKoSGRjlxyKN/ygbau90HVAaprERO1nitMigObYz/5SZYqsq/g4jB
   KSRP4GveBPYV3Y+ytO4ceCzv1qNVzOMTZPsDt1Kt8rPo3IRLy8oEUDvfP
   IS1PwaPiJ0TJR2LV+1UEy8tiC78u/O5KdnOFv50jQ0Mn5eTQzBwNKBgdZ
   V91dYypSOXimqahZ1dmC9hQgNc8podD20zEXc2ScLcGGxbRonHBtaZ/I/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="10496099"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="10496099"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 04:35:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="14496390"
Received: from wpastern-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.57.17])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 04:35:01 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 2/3] e1000e: Use PCI_EXP_LNKSTA_NLW & FIELD_GET() instead of custom defines/code
Date:   Tue, 21 Nov 2023 14:34:27 +0200
Message-Id: <20231121123428.20907-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231121123428.20907-1-ilpo.jarvinen@linux.intel.com>
References: <20231121123428.20907-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

e1000e has own copy of PCI Negotiated Link Width field defines. Use the
ones from include/uapi/linux/pci_regs.h instead of the custom ones and
remove the custom ones and convert to FIELD_GET().

Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/net/ethernet/intel/e1000e/defines.h | 2 --
 drivers/net/ethernet/intel/e1000e/mac.c     | 7 ++++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/defines.h b/drivers/net/ethernet/intel/e1000e/defines.h
index 63c3c79380a1..a4d29c9e03a6 100644
--- a/drivers/net/ethernet/intel/e1000e/defines.h
+++ b/drivers/net/ethernet/intel/e1000e/defines.h
@@ -681,8 +681,6 @@
 #define PCIE_LINK_STATUS             0x12
 
 #define PCI_HEADER_TYPE_MULTIFUNC    0x80
-#define PCIE_LINK_WIDTH_MASK         0x3F0
-#define PCIE_LINK_WIDTH_SHIFT        4
 
 #define PHY_REVISION_MASK      0xFFFFFFF0
 #define MAX_PHY_REG_ADDRESS    0x1F  /* 5 bit address bus (0-0x1F) */
diff --git a/drivers/net/ethernet/intel/e1000e/mac.c b/drivers/net/ethernet/intel/e1000e/mac.c
index 5df7ad93f3d7..5340cf73778d 100644
--- a/drivers/net/ethernet/intel/e1000e/mac.c
+++ b/drivers/net/ethernet/intel/e1000e/mac.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 1999 - 2018 Intel Corporation. */
 
+#include <linux/bitfield.h>
+
 #include "e1000.h"
 
 /**
@@ -25,9 +27,8 @@ s32 e1000e_get_bus_info_pcie(struct e1000_hw *hw)
 		pci_read_config_word(adapter->pdev,
 				     cap_offset + PCIE_LINK_STATUS,
 				     &pcie_link_status);
-		bus->width = (enum e1000_bus_width)((pcie_link_status &
-						     PCIE_LINK_WIDTH_MASK) >>
-						    PCIE_LINK_WIDTH_SHIFT);
+		bus->width = (enum e1000_bus_width)FIELD_GET(PCI_EXP_LNKSTA_NLW,
+							     pcie_link_status);
 	}
 
 	mac->ops.set_lan_id(hw);
-- 
2.30.2


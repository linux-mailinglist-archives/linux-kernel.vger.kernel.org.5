Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4898A7EEF7D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345854AbjKQJ6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235810AbjKQJ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:57:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0621994;
        Fri, 17 Nov 2023 01:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700214378; x=1731750378;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cnRhqRHN/FCSPFyKVdYVH7cYpVC1KUyHAWcRs58SbBg=;
  b=c1pKTN1O9RInsY149OLutR+iFZvJBfaFSkgI7cxEDUIAcWYfxgkMVisc
   lo1MI8VTFwoOuiNj6SwfaJ/3UCqdmQiakX7eLqMY+SB+BzIksewu0JtTK
   M7P7dZ6Q4o0R7bu115TOk/BDZCKesnBdIazcW2kx4X3vrzCU8Wo5RsaoT
   7LweLk2bJQunvp1jNcU3daqH6iF9hGQlSxU9Ll8mvsojvGCGT3DAjYhW/
   vg8wxZOYvUWMkhTzoDGmbNR/2pF6KLDTHgyV4o5NennzmkxuSrIMaAaFS
   LUzwXvS9bn91PkH2CfuZStzTcyy009JvXvFTWY1GXB7MzkvxiwIeodM8D
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="457767226"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="457767226"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 01:46:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="742048037"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="742048037"
Received: from rvadera-mobl.ger.corp.intel.com (HELO localhost) ([10.251.219.158])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 01:46:14 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "John W. Linville" <linville@tuxdriver.com>,
        Kalle Valo <kvalo@kernel.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 7/7] rtlwifi: rtl8821ae: Access full PMCS reg and use pci_regs.h
Date:   Fri, 17 Nov 2023 11:44:25 +0200
Message-Id: <20231117094425.80477-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231117094425.80477-1-ilpo.jarvinen@linux.intel.com>
References: <20231117094425.80477-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_rtl8821ae_clear_pci_pme_status() accesses the upper byte of the Power
Management Control/Status register (PMCS) with literal 5 offset.

Access the entire PMCS register using defines from pci_regs.h to
improve code readability.

While at it, remove the obvious comment and tweak debug prints
slightly to not sound misleading.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 .../wireless/realtek/rtlwifi/rtl8821ae/hw.c   | 21 +++++++------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
index 7cc648d49f2d..f4b232f038a9 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
@@ -2271,7 +2271,7 @@ static void _rtl8821ae_clear_pci_pme_status(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 	struct pci_dev *pdev = rtlpci->pdev;
-	u8 pmcs_reg;
+	u16 pmcs_reg;
 	u8 pm_cap;
 
 	pm_cap = pci_find_capability(pdev, PCI_CAP_ID_PM);
@@ -2281,23 +2281,16 @@ static void _rtl8821ae_clear_pci_pme_status(struct ieee80211_hw *hw)
 		return;
 	}
 
-	/* Get the PM CSR (Control/Status Register),
-	 * The PME_Status is located at PM Capatibility offset 5, bit 7
-	 */
-	pci_read_config_byte(pdev, pm_cap + 5, &pmcs_reg);
-
-	if (pmcs_reg & BIT(7)) {
+	pci_read_config_word(pdev, pm_cap + PCI_PM_CTRL, &pmcs_reg);
+	if (pmcs_reg & PCI_PM_CTRL_PME_STATUS) {
 		/* Clear PME_Status with write */
-		pci_write_config_byte(pdev, pm_cap + 5, pmcs_reg);
-		/* Read it back to check */
-		pci_read_config_byte(pdev, pm_cap + 5, &pmcs_reg);
+		pci_write_config_word(pdev, pm_cap + PCI_PM_CTRL, pmcs_reg);
+		pci_read_config_word(pdev, pm_cap + PCI_PM_CTRL, &pmcs_reg);
 		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
-			"Clear PME status 0x%2x to 0x%2x\n",
-			pm_cap + 5, pmcs_reg);
+			"Cleared PME status, PMCS reg = 0x%4x\n", pmcs_reg);
 	} else {
 		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
-			"PME status(0x%2x) = 0x%2x\n",
-			pm_cap + 5, pmcs_reg);
+			"PMCS reg = 0x%4x\n", pmcs_reg);
 	}
 }
 
-- 
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779C87F6EDD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 09:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345207AbjKXItC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 03:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbjKXIsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 03:48:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3A810FE;
        Fri, 24 Nov 2023 00:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700815724; x=1732351724;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cnRhqRHN/FCSPFyKVdYVH7cYpVC1KUyHAWcRs58SbBg=;
  b=iCPg5cI3BJ4bEttl+g8b/DLN0nmX+9ywudf7qfg10EGj1cw4RNs3IU5/
   QZH2PDY9iB8gRKFGvaunG372c/tPEECq1wurqfsrarDv7w/iffGf4IkkV
   AdxmMUyPd7UXYWcjEmru/K8MenIL8UZd9TlVPnXPbi0glYSJrq5Ai+SXR
   0tQwhOFtgVuN6TQ64e3gV1mTm9ZOgwBuOX6z+mxxA4LMX34oIZIbH/e2g
   D7rvsSbSfpByhU4E9We63oXwG4Ad8bKRrUWjkcGGIlQFmeEwYcFteUid4
   8JI3/mfnQxuZCn/nmZgpaAxzajs+2fW2s9fI3RJSR2JZ2njIN7Bi5qs7J
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="456728916"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="456728916"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 00:48:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="760900499"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="760900499"
Received: from mvlasov-mobl1.ger.corp.intel.com (HELO localhost) ([10.251.220.89])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 00:48:40 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "John W. Linville" <linville@tuxdriver.com>,
        Kalle Valo <kvalo@kernel.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 08/10] wifi: rtlwifi: rtl8821ae: Access full PMCS reg and use pci_regs.h
Date:   Fri, 24 Nov 2023 10:47:23 +0200
Message-Id: <20231124084725.12738-9-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231124084725.12738-1-ilpo.jarvinen@linux.intel.com>
References: <20231124084725.12738-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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


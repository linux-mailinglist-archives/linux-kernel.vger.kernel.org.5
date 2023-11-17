Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46957EEF80
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345779AbjKQJ6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235762AbjKQJ5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:57:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56881732;
        Fri, 17 Nov 2023 01:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700214357; x=1731750357;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IOd4p7E6WZRecHlZmv4wDM9ERugu04lZ89KnrsRyhwI=;
  b=PoPUMEGUxs90j1tRw1IVD76dteAx2YEmU8sMKYaHDqg+j3lYqdIBIFmE
   QTiwsHxJAjQ0pIhn6xk9nxPMXkFyx6Xl5dHKgES38X3N+k9wB6IgBtxTe
   CsiYgMETrr0Rj0H0taE0Pz/HJ3GgOz7w0tZe+F+NcvSsI4kVWliV0DJmb
   +FFzaxlbsDGxy8A6LI3VIIOopo5BP9vqI1CxU1Szvx3suj+iauepuJ6Wf
   jMgdVx9WwwxQ1badhAxHG8LwSd9hQOr1CMkQcNXf7C+ikHrkF318HX6oB
   6kUuTFrMefW5ugbpVJQzMHz7KCAtehsVUDIa68aXrp0tbzILgIzsOzOAz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="390123944"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="390123944"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 01:45:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="6972546"
Received: from rvadera-mobl.ger.corp.intel.com (HELO localhost) ([10.251.219.158])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 01:45:54 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "John W. Linville" <linville@tuxdriver.com>,
        Kalle Valo <kvalo@kernel.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 5/7] rtlwifi: rtl8821ae: Use pci_find_capability()
Date:   Fri, 17 Nov 2023 11:44:23 +0200
Message-Id: <20231117094425.80477-6-ilpo.jarvinen@linux.intel.com>
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

Instead of open coding the capability structure search, find the PM
Capability using pci_find_capability().

While at it, rename the generic 'cap_pointer' to 'pm_cap' which makes
the intent of the code more obvious.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 .../wireless/realtek/rtlwifi/rtl8821ae/hw.c   | 49 +++----------------
 1 file changed, 8 insertions(+), 41 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
index 53cfeed0b030..7877509c34c7 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
@@ -2270,42 +2270,11 @@ static void _rtl8821ae_clear_pci_pme_status(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
-	u16 cap_hdr;
-	u8 cap_pointer;
-	u8 cap_id = 0xff;
 	u8 pmcs_reg;
-	u8 cnt = 0;
+	u8 pm_cap;
 
-	/* Get the Capability pointer first,
-	 * the Capability Pointer is located at
-	 * offset 0x34 from the Function Header */
-
-	pci_read_config_byte(rtlpci->pdev, 0x34, &cap_pointer);
-	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
-		"PCI configuration 0x34 = 0x%2x\n", cap_pointer);
-
-	do {
-		pci_read_config_word(rtlpci->pdev, cap_pointer, &cap_hdr);
-		cap_id = cap_hdr & 0xFF;
-
-		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
-			"in pci configuration, cap_pointer%x = %x\n",
-			cap_pointer, cap_id);
-
-		if (cap_id == 0x01) {
-			break;
-		} else {
-			/* point to next Capability */
-			cap_pointer = (cap_hdr >> 8) & 0xFF;
-			/* 0: end of pci capability, 0xff: invalid value */
-			if (cap_pointer == 0x00 || cap_pointer == 0xff) {
-				cap_id = 0xff;
-				break;
-			}
-		}
-	} while (cnt++ < 200);
-
-	if (cap_id != 0x01) {
+	pm_cap = pci_find_capability(rtlpci->pdev, PCI_CAP_ID_PM);
+	if (!pm_cap) {
 		rtl_dbg(rtlpriv, COMP_INIT, DBG_WARNING,
 			"Cannot find PME Capability\n");
 		return;
@@ -2314,22 +2283,20 @@ static void _rtl8821ae_clear_pci_pme_status(struct ieee80211_hw *hw)
 	/* Get the PM CSR (Control/Status Register),
 	 * The PME_Status is located at PM Capatibility offset 5, bit 7
 	 */
-	pci_read_config_byte(rtlpci->pdev, cap_pointer + 5, &pmcs_reg);
+	pci_read_config_byte(rtlpci->pdev, pm_cap + 5, &pmcs_reg);
 
 	if (pmcs_reg & BIT(7)) {
 		/* Clear PME_Status with write */
-		pci_write_config_byte(rtlpci->pdev, cap_pointer + 5,
-				      pmcs_reg);
+		pci_write_config_byte(rtlpci->pdev, pm_cap + 5, pmcs_reg);
 		/* Read it back to check */
-		pci_read_config_byte(rtlpci->pdev, cap_pointer + 5,
-				     &pmcs_reg);
+		pci_read_config_byte(rtlpci->pdev, pm_cap + 5, &pmcs_reg);
 		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
 			"Clear PME status 0x%2x to 0x%2x\n",
-			cap_pointer + 5, pmcs_reg);
+			pm_cap + 5, pmcs_reg);
 	} else {
 		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
 			"PME status(0x%2x) = 0x%2x\n",
-			cap_pointer + 5, pmcs_reg);
+			pm_cap + 5, pmcs_reg);
 	}
 }
 
-- 
2.30.2


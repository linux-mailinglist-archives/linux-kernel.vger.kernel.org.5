Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5923D7F6ED5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 09:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345088AbjKXIsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 03:48:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjKXIsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 03:48:25 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690C41723;
        Fri, 24 Nov 2023 00:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700815709; x=1732351709;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IOd4p7E6WZRecHlZmv4wDM9ERugu04lZ89KnrsRyhwI=;
  b=TCNnlQvwSHLbi2Ctn6a+GEatEVP3nIuQ0rvY8Xd4MJZ6GMimhtc2wO4d
   +dY9oEfYlHMf5Gi9u3G+HbD4Vx7AH0AQ1t3rhOimCpzbDzuZ6ecBuBf8i
   sF+0vabZMtWFiTWH5KFCkkk46GW8bLXkWwSIUdn8gBrSSwrN63xqOG54p
   2kSjayvwT3Vui9OdLaBMvyKGq6OeHrWas4N+3zXLwdTAznsg0/553vZ71
   tX5zO0LEh4pMLrtPdvoNrsFdK+mVaOHpJJSCE4ef2CcVjHeR/iPbzJd0a
   oF2GPPZeDluAxu8otxRA7b9QAHb5Uvq9mt4XMrBfB1DWjHLZFomCYfQaF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="13945564"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="13945564"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 00:48:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="833640623"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="833640623"
Received: from mvlasov-mobl1.ger.corp.intel.com (HELO localhost) ([10.251.220.89])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 00:48:23 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "John W. Linville" <linville@tuxdriver.com>,
        Kalle Valo <kvalo@kernel.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 06/10] wifi: rtlwifi: rtl8821ae: Use pci_find_capability()
Date:   Fri, 24 Nov 2023 10:47:21 +0200
Message-Id: <20231124084725.12738-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231124084725.12738-1-ilpo.jarvinen@linux.intel.com>
References: <20231124084725.12738-1-ilpo.jarvinen@linux.intel.com>
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


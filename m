Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0507EEF38
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345816AbjKQJss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235722AbjKQJsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:48:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E933F3ABB;
        Fri, 17 Nov 2023 01:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700214348; x=1731750348;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=72smyAApKQNC+XZ0RCO6MV2sV0AG9LsieeP9S29kMNA=;
  b=HqoVB079egJsOYtRiydACWF4IHfVneaGVXwxv0HAm8FbYgieiuRFu+SZ
   v+ruecU7uhG3z9q+/7K7shJyB93g7M1aJGMXNS931fn2mcxI3O430GRoJ
   mHeAoWkviOeI8eNUYCrFHPMFIMO9TsVSt9gu+URhYl/Q3OANC7VijSjpR
   twrwLgTvM53kvsZjPgPEcVCeaEtj43VMI3gxVpZnbmOPW999LeTA6kYot
   ahv2VwKU0wrJcb4/K1G33wYBe8XxEG/IG4MDzGA087CwrzpM9tsxB/Ih/
   51Io8r45RXeczIqWvqLUff7JXW7pUOKTV4ptBxEsGYAYVdBA0st1E7Ya4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="9929563"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="9929563"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 01:45:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="909390798"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="909390798"
Received: from rvadera-mobl.ger.corp.intel.com (HELO localhost) ([10.251.219.158])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 01:45:43 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "John W. Linville" <linville@tuxdriver.com>,
        Kalle Valo <kvalo@kernel.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 4/7] rtlwifi: rtl8821ae: Reverse PM capability exists check
Date:   Fri, 17 Nov 2023 11:44:22 +0200
Message-Id: <20231117094425.80477-5-ilpo.jarvinen@linux.intel.com>
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

Check if PM capability does not exists and return early which follows
the usual error handling pattern.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 .../wireless/realtek/rtlwifi/rtl8821ae/hw.c   | 45 ++++++++++---------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
index 6ae37d61a2a2..53cfeed0b030 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
@@ -2305,30 +2305,31 @@ static void _rtl8821ae_clear_pci_pme_status(struct ieee80211_hw *hw)
 		}
 	} while (cnt++ < 200);
 
-	if (cap_id == 0x01) {
-		/* Get the PM CSR (Control/Status Register),
-		 * The PME_Status is located at PM Capatibility offset 5, bit 7
-		 */
-		pci_read_config_byte(rtlpci->pdev, cap_pointer + 5, &pmcs_reg);
-
-		if (pmcs_reg & BIT(7)) {
-			/* Clear PME_Status with write */
-			pci_write_config_byte(rtlpci->pdev, cap_pointer + 5,
-					      pmcs_reg);
-			/* Read it back to check */
-			pci_read_config_byte(rtlpci->pdev, cap_pointer + 5,
-					     &pmcs_reg);
-			rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
-				"Clear PME status 0x%2x to 0x%2x\n",
-				cap_pointer + 5, pmcs_reg);
-		} else {
-			rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
-				"PME status(0x%2x) = 0x%2x\n",
-				cap_pointer + 5, pmcs_reg);
-		}
-	} else {
+	if (cap_id != 0x01) {
 		rtl_dbg(rtlpriv, COMP_INIT, DBG_WARNING,
 			"Cannot find PME Capability\n");
+		return;
+	}
+
+	/* Get the PM CSR (Control/Status Register),
+	 * The PME_Status is located at PM Capatibility offset 5, bit 7
+	 */
+	pci_read_config_byte(rtlpci->pdev, cap_pointer + 5, &pmcs_reg);
+
+	if (pmcs_reg & BIT(7)) {
+		/* Clear PME_Status with write */
+		pci_write_config_byte(rtlpci->pdev, cap_pointer + 5,
+				      pmcs_reg);
+		/* Read it back to check */
+		pci_read_config_byte(rtlpci->pdev, cap_pointer + 5,
+				     &pmcs_reg);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
+			"Clear PME status 0x%2x to 0x%2x\n",
+			cap_pointer + 5, pmcs_reg);
+	} else {
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
+			"PME status(0x%2x) = 0x%2x\n",
+			cap_pointer + 5, pmcs_reg);
 	}
 }
 
-- 
2.30.2


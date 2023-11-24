Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6967F6ED4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 09:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbjKXIse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 03:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjKXIsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 03:48:14 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1887010F0;
        Fri, 24 Nov 2023 00:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700815699; x=1732351699;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rA32NIMWpA2vNKXCc9U/cMBVBr9d7Q0uSRc6kVF8Yok=;
  b=iboQNA41xlIJOikzUkFTA5/Nn5Pct/oWj+7TXwGKO+ZUMIYgHNGoplaI
   vAUC1TIy5aLOwnz9S1evyu2K892DdekVWhat9RpMOEyLqB9/zOjvbm8Eh
   jwg7LsKhmWYRo71fNOzC7PQ4KSQsuMdOhNq9NP5W/lHMBKzZ6HtkEINx2
   vMnNW5YjhzCDNEve1Hq6g3Vt++QGE6tMI1fFRoJu2b7Vkuc55TGq50d5d
   ywHB7xWeBa/zl9x0haM6xNh+hnRgsD8Tww/YERvluTYE9HCqOlMdGpIrD
   /GBNcfBcaXv1e+Qk3OYtydykboZWgVbisuN5taTsmKweb7O22863BcOTz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="13945548"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="13945548"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 00:48:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="833640590"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="833640590"
Received: from mvlasov-mobl1.ger.corp.intel.com (HELO localhost) ([10.251.220.89])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 00:48:15 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "John W. Linville" <linville@tuxdriver.com>,
        Kalle Valo <kvalo@kernel.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 05/10] wifi: rtlwifi: rtl8821ae: Reverse PM Capability exists check
Date:   Fri, 24 Nov 2023 10:47:20 +0200
Message-Id: <20231124084725.12738-6-ilpo.jarvinen@linux.intel.com>
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

Check if PM Capability does not exists and return early which follows
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


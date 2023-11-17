Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172EF7EEF3A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345865AbjKQJs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235761AbjKQJs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:48:29 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61261980;
        Fri, 17 Nov 2023 01:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700214368; x=1731750368;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OhgbBzthM/WTBTOWAYA/GP6MTbrtMnKaOGmStuDv10k=;
  b=bd0+kfenBsd4keI3ffwEPWClarhnqQdGCW3YxusGoQVbfMRw+q/VYJq/
   WWKHil74Ebk1PjfMZiS2AgQyg6IV4j8YY+dIFOMf+WJPj7NyLBaBPfQP8
   N2zZg0/Uj77whIdeOv3LOrnIV0FNYhWgt/cmX4+46giKPXgY/YY47GYbm
   x7d+ljQzZhKu1vCamvFgMHk70LbLB7DHxi0ULSbKptPL9pthBLqOr3Exq
   6Zbygd31rRWQ6JJdb3rgniagZ91Xaeip9YAmfQNxY/gwJesKtktMMdNbn
   OJOVzXYnQfIIYJzc0rt+izDt34VNxvrSOGMwGMj1GC6NhdTs90/yh/Dq7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="394121107"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="394121107"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 01:46:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="1012880783"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="1012880783"
Received: from rvadera-mobl.ger.corp.intel.com (HELO localhost) ([10.251.219.158])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 01:46:05 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "John W. Linville" <linville@tuxdriver.com>,
        Kalle Valo <kvalo@kernel.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 6/7] rtlwifi: rtl8821ae: Add pdev into _rtl8821ae_clear_pci_pme_status()
Date:   Fri, 17 Nov 2023 11:44:24 +0200
Message-Id: <20231117094425.80477-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231117094425.80477-1-ilpo.jarvinen@linux.intel.com>
References: <20231117094425.80477-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add local variable pdev to shorten rtlpci->pdev.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
index 7877509c34c7..7cc648d49f2d 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
@@ -2270,10 +2270,11 @@ static void _rtl8821ae_clear_pci_pme_status(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
+	struct pci_dev *pdev = rtlpci->pdev;
 	u8 pmcs_reg;
 	u8 pm_cap;
 
-	pm_cap = pci_find_capability(rtlpci->pdev, PCI_CAP_ID_PM);
+	pm_cap = pci_find_capability(pdev, PCI_CAP_ID_PM);
 	if (!pm_cap) {
 		rtl_dbg(rtlpriv, COMP_INIT, DBG_WARNING,
 			"Cannot find PME Capability\n");
@@ -2283,13 +2284,13 @@ static void _rtl8821ae_clear_pci_pme_status(struct ieee80211_hw *hw)
 	/* Get the PM CSR (Control/Status Register),
 	 * The PME_Status is located at PM Capatibility offset 5, bit 7
 	 */
-	pci_read_config_byte(rtlpci->pdev, pm_cap + 5, &pmcs_reg);
+	pci_read_config_byte(pdev, pm_cap + 5, &pmcs_reg);
 
 	if (pmcs_reg & BIT(7)) {
 		/* Clear PME_Status with write */
-		pci_write_config_byte(rtlpci->pdev, pm_cap + 5, pmcs_reg);
+		pci_write_config_byte(pdev, pm_cap + 5, pmcs_reg);
 		/* Read it back to check */
-		pci_read_config_byte(rtlpci->pdev, pm_cap + 5, &pmcs_reg);
+		pci_read_config_byte(pdev, pm_cap + 5, &pmcs_reg);
 		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
 			"Clear PME status 0x%2x to 0x%2x\n",
 			pm_cap + 5, pmcs_reg);
-- 
2.30.2


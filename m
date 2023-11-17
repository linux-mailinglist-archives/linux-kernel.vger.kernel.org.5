Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC0D7EEF34
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjKQJse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235784AbjKQJsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:48:07 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D7D2709;
        Fri, 17 Nov 2023 01:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700214326; x=1731750326;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AsU8Bf1+aKF4Ygw/JW3TR4w1gS204nj0qrDxLy53Snw=;
  b=im9rMFCLMkRKEUCgv4Vy4Zza+hqhr34G6//7uWmhEehF/nT09E4u9QBP
   0Tis+Uxr9TKs0/ZleuQ5rzi8L6IMOWJs7ABy/OJyVbyRWI9CtsMxu73IW
   zHT4LjucUlhSpX/X71WJDBeJyA8i20dqB6qma9l/YhyOKxbjdcDuYfN1F
   qVudkkBaWyn6Pg9xx7YZpJ12ZwwBWoD4xRlWXc+eGcJr0rWMnxXkWp+pc
   61/rERi84bmGuy97HY8xlzDZyyjjh533ehLvOaAhJA1uVf6QZK2hmPZw0
   HKOteVtS2OP6tenuclLYOX6+ca7Faou7s10J5lvnpwWhOwnSc+PmhI3c3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="9929542"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="9929542"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 01:45:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="909390727"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="909390727"
Received: from rvadera-mobl.ger.corp.intel.com (HELO localhost) ([10.251.219.158])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 01:45:22 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "John W. Linville" <linville@tuxdriver.com>,
        Kalle Valo <kvalo@kernel.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/7] wifi: rtlwifi: Convert to use PCIe capability accessors
Date:   Fri, 17 Nov 2023 11:44:20 +0200
Message-Id: <20231117094425.80477-3-ilpo.jarvinen@linux.intel.com>
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

The rtlwifi driver accesses PCIe capabilities through custom config
offsets.

Convert the accesses to use the normal PCIe capability accessors.
pcibridge_pciehdr_offset in the struct mp_adapter becomes unused after
the conversion and can be removed.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/net/wireless/realtek/rtlwifi/pci.c | 30 ++++++++--------------
 drivers/net/wireless/realtek/rtlwifi/pci.h |  1 -
 2 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index d67a9617a19c..0c6f03d845a9 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -64,7 +64,7 @@ static void _rtl_pci_update_default_setting(struct ieee80211_hw *hw)
 	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 	u8 pcibridge_vendor = pcipriv->ndis_adapter.pcibridge_vendor;
-	u8 init_aspm;
+	u16 init_aspm;
 
 	ppsc->reg_rfps_level = 0;
 	ppsc->support_aspm = false;
@@ -151,9 +151,10 @@ static void _rtl_pci_update_default_setting(struct ieee80211_hw *hw)
 	/* toshiba aspm issue, toshiba will set aspm selfly
 	 * so we should not set aspm in driver
 	 */
-	pci_read_config_byte(rtlpci->pdev, 0x80, &init_aspm);
+	pcie_capability_read_word(rtlpci->pdev, PCI_EXP_LNKCTL, &init_aspm);
 	if (rtlpriv->rtlhal.hw_type == HARDWARE_TYPE_RTL8192SE &&
-	    init_aspm == 0x43)
+	    ((u8)init_aspm) == (PCI_EXP_LNKCTL_ASPM_L0S |
+				PCI_EXP_LNKCTL_ASPM_L1 | PCI_EXP_LNKCTL_CCC))
 		ppsc->support_aspm = false;
 }
 
@@ -201,7 +202,7 @@ static void rtl_pci_disable_aspm(struct ieee80211_hw *hw)
 	/*Retrieve original configuration settings. */
 	u8 linkctrl_reg = pcipriv->ndis_adapter.linkctrl_reg;
 	u16 aspmlevel = 0;
-	u8 tmp_u1b = 0;
+	u16 tmp_u1b = 0;
 
 	if (!ppsc->support_aspm)
 		return;
@@ -219,7 +220,7 @@ static void rtl_pci_disable_aspm(struct ieee80211_hw *hw)
 	}
 
 	/*for promising device will in L0 state after an I/O. */
-	pci_read_config_byte(rtlpci->pdev, 0x80, &tmp_u1b);
+	pcie_capability_read_word(rtlpci->pdev, PCI_EXP_LNKCTL, &tmp_u1b);
 
 	/*Set corresponding value. */
 	aspmlevel |= BIT(0) | BIT(1);
@@ -363,14 +364,9 @@ static void rtl_pci_get_linkcontrol_field(struct ieee80211_hw *hw)
 {
 	struct rtl_pci_priv *pcipriv = rtl_pcipriv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(pcipriv);
-	u8 capabilityoffset = pcipriv->ndis_adapter.pcibridge_pciehdr_offset;
-	u8 linkctrl_reg;
-	u8 num4bbytes;
-
-	num4bbytes = (capabilityoffset + 0x10) / 4;
+	u16 linkctrl_reg;
 
-	/*Read  Link Control Register */
-	pci_read_config_byte(rtlpci->pdev, (num4bbytes << 2), &linkctrl_reg);
+	pcie_capability_read_word(rtlpci->pdev, PCI_EXP_LNKCTL, &linkctrl_reg);
 
 	pcipriv->ndis_adapter.pcibridge_linkctrlreg = linkctrl_reg;
 }
@@ -391,9 +387,8 @@ static void rtl_pci_parse_configuration(struct pci_dev *pdev,
 	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE, "Link Control Register =%x\n",
 		pcipriv->ndis_adapter.linkctrl_reg);
 
-	pci_read_config_byte(pdev, 0x98, &tmp);
-	tmp |= BIT(4);
-	pci_write_config_byte(pdev, 0x98, tmp);
+	pcie_capability_set_word(pdev, PCI_EXP_DEVCTL2,
+				 PCI_EXP_DEVCTL2_COMP_TMOUT_DIS);
 
 	tmp = 0x17;
 	pci_write_config_byte(pdev, 0x70f, tmp);
@@ -2029,8 +2024,6 @@ static bool _rtl_pci_find_adapter(struct pci_dev *pdev,
 		    PCI_SLOT(bridge_pdev->devfn);
 		pcipriv->ndis_adapter.pcibridge_funcnum =
 		    PCI_FUNC(bridge_pdev->devfn);
-		pcipriv->ndis_adapter.pcibridge_pciehdr_offset =
-		    pci_pcie_cap(bridge_pdev);
 
 		rtl_pci_get_linkcontrol_field(hw);
 
@@ -2049,12 +2042,11 @@ static bool _rtl_pci_find_adapter(struct pci_dev *pdev,
 		pdev->vendor, pcipriv->ndis_adapter.linkctrl_reg);
 
 	rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
-		"pci_bridge busnumber:devnumber:funcnumber:vendor:pcie_cap:link_ctl_reg:amd %d:%d:%d:%x:%x:%x:%x\n",
+		"pci_bridge busnumber:devnumber:funcnumber:vendor:link_ctl_reg:amd %d:%d:%d:%x:%x:%x\n",
 		pcipriv->ndis_adapter.pcibridge_busnum,
 		pcipriv->ndis_adapter.pcibridge_devnum,
 		pcipriv->ndis_adapter.pcibridge_funcnum,
 		pcibridge_vendors[pcipriv->ndis_adapter.pcibridge_vendor],
-		pcipriv->ndis_adapter.pcibridge_pciehdr_offset,
 		pcipriv->ndis_adapter.pcibridge_linkctrlreg,
 		pcipriv->ndis_adapter.amd_l1_patch);
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.h b/drivers/net/wireless/realtek/rtlwifi/pci.h
index 57174b93db83..281da0b52564 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.h
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.h
@@ -236,7 +236,6 @@ struct mp_adapter {
 	u16 pcibridge_vendorid;
 	u16 pcibridge_deviceid;
 
-	u8 pcibridge_pciehdr_offset;
 	u8 pcibridge_linkctrlreg;
 
 	bool amd_l1_patch;
-- 
2.30.2


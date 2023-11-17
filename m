Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1236F7EEF2E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235442AbjKQJsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjKQJrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:47:39 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8C010CE;
        Fri, 17 Nov 2023 01:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700214302; x=1731750302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cul/hGXCLVv6oHsahjMdpKIxcTLgbv2W/52rf1Bj6BQ=;
  b=W3tT2y3zKye6XlJnca4j6G5x9ISQtigWfEW2IySjxYN2QuqQIidwMqgv
   hy0ouFTUwGrn54PuLAecdfG5NSWmESZBcVMU5JmFaOzAeO7MAZ6CZrKfJ
   Sfs01Mo5rt3Hm1pNbHyFefZ9adkbaQBslA1HflaTxonoJM2xzMnqP084f
   yn4861BNT3B8lfUcty4UBg+aMoVoS4rJ5d2M6z6epRMax/R8TxujAZPeN
   IQgVNzJX3txLOzIHhi1Eag2nGIZZZXLCSvWXqKkOtHQJpr1fcx3HMO04e
   0RHvfkl0BJV1curF4GIBVv06XKImV5MvO+ptAUQQPU9FpHWFSkhl5lT4Q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="390123744"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="390123744"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 01:44:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="6972408"
Received: from rvadera-mobl.ger.corp.intel.com (HELO localhost) ([10.251.219.158])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 01:44:45 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "John W. Linville" <linville@tuxdriver.com>,
        Kalle Valo <kvalo@kernel.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/7] wifi: rtlwifi: Convert LNKCTL change to PCIe cap RMW accessors
Date:   Fri, 17 Nov 2023 11:44:19 +0200
Message-Id: <20231117094425.80477-2-ilpo.jarvinen@linux.intel.com>
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

The rtlwifi driver comes with custom code to write into PCIe Link
Control register. RMW access for the Link Control register requires
locking that is already provided by the standard PCIe capability
accessors.

Convert the custom RMW code writing into LNKCTL register to standard
RMW capability accessors. The accesses are changed to cover the full
LNKCTL register instead of touching just a single byte of the register.

After custom LNKCTL access code is removed, .num4bytes in the struct
mp_adapter is no longer needed.

Fixes: 0c8173385e54 ("rtl8192ce: Add new driver")
Fixes: 886e14b65a8f ("rtlwifi: Eliminate raw reads and writes from PCIe portion")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/net/wireless/realtek/rtlwifi/pci.c | 39 +++++++++++-----------
 drivers/net/wireless/realtek/rtlwifi/pci.h |  2 --
 2 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index 9886e719739b..d67a9617a19c 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -164,21 +164,27 @@ static bool _rtl_pci_platform_switch_device_pci_aspm(
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
 
+	value &= PCI_EXP_LNKCTL_ASPMC;
+
 	if (rtlhal->hw_type != HARDWARE_TYPE_RTL8192SE)
 		value |= 0x40;
 
-	pci_write_config_byte(rtlpci->pdev, 0x80, value);
+	pcie_capability_clear_and_set_word(rtlpci->pdev, PCI_EXP_LNKCTL,
+					   PCI_EXP_LNKCTL_ASPMC | value,
+					   value);
 
 	return false;
 }
 
 /*When we set 0x01 to enable clk request. Set 0x0 to disable clk req.*/
-static void _rtl_pci_switch_clk_req(struct ieee80211_hw *hw, u8 value)
+static void _rtl_pci_switch_clk_req(struct ieee80211_hw *hw, u16 value)
 {
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
 
-	pci_write_config_byte(rtlpci->pdev, 0x81, value);
+	pcie_capability_clear_and_set_word(rtlpci->pdev, PCI_EXP_LNKCTL,
+					   PCI_EXP_LNKCTL_CLKREQ_EN,
+					   value);
 
 	if (rtlhal->hw_type == HARDWARE_TYPE_RTL8192SE)
 		udelay(100);
@@ -192,11 +198,8 @@ static void rtl_pci_disable_aspm(struct ieee80211_hw *hw)
 	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 	u8 pcibridge_vendor = pcipriv->ndis_adapter.pcibridge_vendor;
-	u8 num4bytes = pcipriv->ndis_adapter.num4bytes;
 	/*Retrieve original configuration settings. */
 	u8 linkctrl_reg = pcipriv->ndis_adapter.linkctrl_reg;
-	u16 pcibridge_linkctrlreg = pcipriv->ndis_adapter.
-				pcibridge_linkctrlreg;
 	u16 aspmlevel = 0;
 	u8 tmp_u1b = 0;
 
@@ -221,15 +224,12 @@ static void rtl_pci_disable_aspm(struct ieee80211_hw *hw)
 	/*Set corresponding value. */
 	aspmlevel |= BIT(0) | BIT(1);
 	linkctrl_reg &= ~aspmlevel;
-	pcibridge_linkctrlreg &= ~(BIT(0) | BIT(1));
 
 	_rtl_pci_platform_switch_device_pci_aspm(hw, linkctrl_reg);
 	udelay(50);
 
-	/*4 Disable Pci Bridge ASPM */
-	pci_write_config_byte(rtlpci->pdev, (num4bytes << 2),
-			      pcibridge_linkctrlreg);
-
+	pcie_capability_clear_word(rtlpci->pdev, PCI_EXP_LNKCTL,
+					   PCI_EXP_LNKCTL_ASPMC);
 	udelay(50);
 }
 
@@ -245,7 +245,6 @@ static void rtl_pci_enable_aspm(struct ieee80211_hw *hw)
 	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 	u8 pcibridge_vendor = pcipriv->ndis_adapter.pcibridge_vendor;
-	u8 num4bytes = pcipriv->ndis_adapter.num4bytes;
 	u16 aspmlevel;
 	u8 u_pcibridge_aspmsetting;
 	u8 u_device_aspmsetting;
@@ -268,13 +267,14 @@ static void rtl_pci_enable_aspm(struct ieee80211_hw *hw)
 	if (pcibridge_vendor == PCI_BRIDGE_VENDOR_INTEL)
 		u_pcibridge_aspmsetting &= ~BIT(0);
 
-	pci_write_config_byte(rtlpci->pdev, (num4bytes << 2),
-			      u_pcibridge_aspmsetting);
+	pcie_capability_clear_and_set_word(rtlpci->pdev, PCI_EXP_LNKCTL,
+					   PCI_EXP_LNKCTL_ASPMC,
+					   u_pcibridge_aspmsetting &
+					   PCI_EXP_LNKCTL_ASPMC);
 
 	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
-		"PlatformEnableASPM(): Write reg[%x] = %x\n",
-		(pcipriv->ndis_adapter.pcibridge_pciehdr_offset + 0x10),
-		u_pcibridge_aspmsetting);
+		"PlatformEnableASPM(): Write ASPM = %x\n",
+		u_pcibridge_aspmsetting & PCI_EXP_LNKCTL_ASPMC);
 
 	udelay(50);
 
@@ -291,7 +291,8 @@ static void rtl_pci_enable_aspm(struct ieee80211_hw *hw)
 
 	if (ppsc->reg_rfps_level & RT_RF_OFF_LEVL_CLK_REQ) {
 		_rtl_pci_switch_clk_req(hw, (ppsc->reg_rfps_level &
-					     RT_RF_OFF_LEVL_CLK_REQ) ? 1 : 0);
+					     RT_RF_OFF_LEVL_CLK_REQ) ?
+					     PCI_EXP_LNKCTL_CLKREQ_EN : 0);
 		RT_SET_PS_LEVEL(ppsc, RT_RF_OFF_LEVL_CLK_REQ);
 	}
 	udelay(100);
@@ -2030,8 +2031,6 @@ static bool _rtl_pci_find_adapter(struct pci_dev *pdev,
 		    PCI_FUNC(bridge_pdev->devfn);
 		pcipriv->ndis_adapter.pcibridge_pciehdr_offset =
 		    pci_pcie_cap(bridge_pdev);
-		pcipriv->ndis_adapter.num4bytes =
-		    (pcipriv->ndis_adapter.pcibridge_pciehdr_offset + 0x10) / 4;
 
 		rtl_pci_get_linkcontrol_field(hw);
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.h b/drivers/net/wireless/realtek/rtlwifi/pci.h
index 866861626a0a..57174b93db83 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.h
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.h
@@ -236,8 +236,6 @@ struct mp_adapter {
 	u16 pcibridge_vendorid;
 	u16 pcibridge_deviceid;
 
-	u8 num4bytes;
-
 	u8 pcibridge_pciehdr_offset;
 	u8 pcibridge_linkctrlreg;
 
-- 
2.30.2


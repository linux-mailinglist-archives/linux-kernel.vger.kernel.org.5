Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05D37F6ECD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 09:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345144AbjKXIsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 03:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjKXIr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 03:47:58 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1D5D72;
        Fri, 24 Nov 2023 00:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700815685; x=1732351685;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k+CIZTzt+2vO07tQNaGqfZ36vMzaw9hd5OfqldzrIuA=;
  b=dSFHm9IVUGc9witI4hNUpBUczLbDtldUhpRnUMk5ur3fsvSnJVEjReVj
   UDPmU4ZQTTBYiSMlZ2fCIc9ICg+xvKQVgXJOGhW3lpC915hQ1x7yfg94l
   mNBy2bMjtLpDCFDxYLRLbv468wO5j+B1y8CdqL9eMi8tTVRPB+f+VbhAB
   YZDe+Qrdn1/7Tp0acYEKiSeQTz6eSjRUhvFV4xUdOUPSRP8u2JcxknmgD
   n+26cZhEDLOZeRycR3Fr3ZYM8W/vWD/1AdqLd/g1ve4JmEpuK46lLJlV4
   uDNKW6iTMWDBbj/Kmo7N+XxFxlurSPdetn+SzuZG3tXtXgDvtQZZjvWkq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="13945456"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="13945456"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 00:48:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="833640496"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="833640496"
Received: from mvlasov-mobl1.ger.corp.intel.com (HELO localhost) ([10.251.220.89])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 00:48:01 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "John W. Linville" <linville@tuxdriver.com>,
        Kalle Valo <kvalo@kernel.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 03/10] wifi: rtlwifi: Convert to use PCIe capability accessors
Date:   Fri, 24 Nov 2023 10:47:18 +0200
Message-Id: <20231124084725.12738-4-ilpo.jarvinen@linux.intel.com>
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

The rtlwifi driver accesses PCIe capabilities through custom config
offsets. Convert the accesses to use the normal PCIe capability
accessors.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/net/wireless/realtek/rtlwifi/pci.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index b118df035243..a29d7df6fff5 100644
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
 
@@ -203,7 +204,7 @@ static void rtl_pci_disable_aspm(struct ieee80211_hw *hw)
 	/*Retrieve original configuration settings. */
 	u8 linkctrl_reg = pcipriv->ndis_adapter.linkctrl_reg;
 	u16 aspmlevel = 0;
-	u8 tmp_u1b = 0;
+	u16 tmp_u1b = 0;
 
 	if (!ppsc->support_aspm)
 		return;
@@ -221,10 +222,10 @@ static void rtl_pci_disable_aspm(struct ieee80211_hw *hw)
 	}
 
 	/*for promising device will in L0 state after an I/O. */
-	pci_read_config_byte(rtlpci->pdev, 0x80, &tmp_u1b);
+	pcie_capability_read_word(rtlpci->pdev, PCI_EXP_LNKCTL, &tmp_u1b);
 
 	/*Set corresponding value. */
-	aspmlevel |= BIT(0) | BIT(1);
+	aspmlevel |= PCI_EXP_LNKCTL_ASPM_L0S | PCI_EXP_LNKCTL_ASPM_L1;
 	linkctrl_reg &= ~aspmlevel;
 
 	_rtl_pci_platform_switch_device_pci_aspm(hw, linkctrl_reg);
@@ -351,9 +352,8 @@ static void rtl_pci_parse_configuration(struct pci_dev *pdev,
 	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE, "Link Control Register =%x\n",
 		pcipriv->ndis_adapter.linkctrl_reg);
 
-	pci_read_config_byte(pdev, 0x98, &tmp);
-	tmp |= BIT(4);
-	pci_write_config_byte(pdev, 0x98, tmp);
+	pcie_capability_set_word(pdev, PCI_EXP_DEVCTL2,
+				 PCI_EXP_DEVCTL2_COMP_TMOUT_DIS);
 
 	tmp = 0x17;
 	pci_write_config_byte(pdev, 0x70f, tmp);
-- 
2.30.2


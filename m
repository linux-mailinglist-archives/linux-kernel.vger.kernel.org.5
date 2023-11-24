Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA527F6EC2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 09:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345046AbjKXIrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 03:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjKXIrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 03:47:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9C89F;
        Fri, 24 Nov 2023 00:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700815659; x=1732351659;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cAzCbwXnfLwA65VPrnihNlz9VygOMk8fpr5Mgo8JUJw=;
  b=KDaXmkX3NbjZl3qVQs6uRbP0fhfqsnadTUDYvURU8GgfZcBDWSw0mYv4
   5m5A3xOSBD0e35okUwqFd3KZbJjT+mYf/0veKqp4+ZwMS4PoBhbsr8lZ4
   ExLcaLmdHgOqNKxpn2StT37yRLvQAcrtilHsyonzDedO9hSnm2hV3thSQ
   FMZo4ygPg4oBE/VoyWfmyUA4NY54Qq6lOCSoU/Eot6YlKaiEqvOraVORh
   /qYnt8OyrwX2Nk3HRxckMuOqiEI0q8pRsEaU338RwKQpM8SfCKvM2YCXV
   VfW7qrUMxGUL9aojV51ajtqZTRIYy+cRxjwHvb4LXcvvP5QCWPICFvqkr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="423525771"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="423525771"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 00:47:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="802137645"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="802137645"
Received: from mvlasov-mobl1.ger.corp.intel.com (HELO localhost) ([10.251.220.89])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 00:47:35 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "John W. Linville" <linville@tuxdriver.com>,
        Kalle Valo <kvalo@kernel.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 00/10] wifi: rtlwifi: PCI related fixes & cleanups
Date:   Fri, 24 Nov 2023 10:47:15 +0200
Message-Id: <20231124084725.12738-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rtlwifi driver has code fragments that are using old interface or
custom code to access PCIe capabilities which is buggy and messy.

First two patches are fixes to problems related to ASPM and LNKCTL
register RMW operations. The rest of the patches cleanup PCIe
capability related code.

Additional note: This series provides only a stop-gap solution to the
RMW concurrency issue, the overall plan is to migrate all ASPM related
handling into the ASPM service driver in order for it to accurately
track ASPM state [1].

[1] https://lore.kernel.org/linux-pci/20230918131103.24119-1-ilpo.jarvinen@linux.intel.com/

v2:
- Remove upstream bridge ASPM code which has never functioned
- Convert more bits to pci_regs.h
- Ensure _rtl_pci_switch_clk_req() only changes CLKREQ_EN
- wifi: prefix to all patches
- Add 2 more cleanup patches for unused stuff

Ilpo Järvinen (10):
  wifi: rtlwifi: Remove bogus and dangerous ASPM disable/enable code
  wifi: rtlwifi: Convert LNKCTL change to PCIe cap RMW accessors
  wifi: rtlwifi: Convert to use PCIe capability accessors
  wifi: rtlwifi: rtl8821ae: Remove unnecessary PME_Status bit set
  wifi: rtlwifi: rtl8821ae: Reverse PM Capability exists check
  wifi: rtlwifi: rtl8821ae: Use pci_find_capability()
  wifi: rtlwifi: rtl8821ae: Add pdev into
    _rtl8821ae_clear_pci_pme_status()
  wifi: rtlwifi: rtl8821ae: Access full PMCS reg and use pci_regs.h
  wifi: rtlwifi: Remove unused PCI related defines and struct
  wifi: rtlwifi: Remove bridge vendor/device ids

 drivers/net/wireless/realtek/rtlwifi/pci.c    | 98 +++++--------------
 drivers/net/wireless/realtek/rtlwifi/pci.h    | 24 -----
 .../wireless/realtek/rtlwifi/rtl8821ae/hw.c   | 76 ++++----------
 3 files changed, 43 insertions(+), 155 deletions(-)

-- 
2.30.2


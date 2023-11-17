Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7BE7EEF2B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345747AbjKQJrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235691AbjKQJrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:47:18 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3B11FD4;
        Fri, 17 Nov 2023 01:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700214279; x=1731750279;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=He9/lnQMgXLL/p06MniYKKBwgrQR5ygjqSsFH4S6MMw=;
  b=jSNaGC/Qc9pv3+qjOBIATrOiq0GORR2y89CvKovFmshCuQ69ETv8JbzZ
   8Hs0/HBACPHUfoCaUeTqPJVfs1uBcXrbiJJBSkWkrH7p9YUlcqKdlJrGz
   hwUL1wEFF1t8B9+TQ0Z7a4+c4Po/ZWHF+5mbXQuUDRTUVTDZ5c7m7Rb8e
   x4XyC3+mG0nQqacV5nOS63/lcJKoMv9y+AfqOuS5gN40W9P3wYhU46zQx
   xH7AQhKT8UQK9LG/bb+6QaGPQS019l/eJO2OMjKaMnxTKOxkMsJR0caVi
   146l0NUYSLGynK111je6m7bMg9ec+OjXOvxR+ts3c+8Pv1qOXNmTqu2GT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="371451621"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="371451621"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 01:44:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="794788229"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="794788229"
Received: from rvadera-mobl.ger.corp.intel.com (HELO localhost) ([10.251.219.158])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 01:44:33 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "John W. Linville" <linville@tuxdriver.com>,
        Kalle Valo <kvalo@kernel.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/7] rtlwifi: PCIe capability access fix + improvements
Date:   Fri, 17 Nov 2023 11:44:18 +0200
Message-Id: <20231117094425.80477-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
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

The rtlwifi driver has code fragments that are using old interface or
custom code to access PCIe capabilities.

The use of old interfaces causes an issue with LNKCTL register that
requires locking during RMW operations. Standard PCIe capability
accessors provide the necessary locking so they should be always used.
The first patch of the series addresses that problem.

The rest of the patches cleanup PCIe capability related code.

Additional note: This series provides only a stop-gap solution to the
RMW concurrency issue, the overall plan is to migrate all ASPM related
handling into the ASPM service driver in order for it to accurately
track ASPM state [1].

[1] https://lore.kernel.org/linux-pci/20230918131103.24119-1-ilpo.jarvinen@linux.intel.com/

Ilpo Järvinen (7):
  wifi: rtlwifi: Convert LNKCTL change to PCIe cap RMW accessors
  wifi: rtlwifi: Convert to use PCIe capability accessors
  rtlwifi: rtl8821ae: Remove unnecessary PME_Status bit set
  rtlwifi: rtl8821ae: Reverse PM capability exists check
  rtlwifi: rtl8821ae: Use pci_find_capability()
  rtlwifi: rtl8821ae: Add pdev into _rtl8821ae_clear_pci_pme_status()
  rtlwifi: rtl8821ae: Access full PMCS reg and use pci_regs.h

 drivers/net/wireless/realtek/rtlwifi/pci.c    | 69 ++++++++---------
 drivers/net/wireless/realtek/rtlwifi/pci.h    |  3 -
 .../wireless/realtek/rtlwifi/rtl8821ae/hw.c   | 76 +++++--------------
 3 files changed, 48 insertions(+), 100 deletions(-)

-- 
2.30.2


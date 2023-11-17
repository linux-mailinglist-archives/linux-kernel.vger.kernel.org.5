Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DCE7EEF36
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345800AbjKQJsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235816AbjKQJsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:48:16 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC9B3AB6;
        Fri, 17 Nov 2023 01:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700214337; x=1731750337;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cuf+QXuL+m32xRWl5bc7WZf9izw1GwzkTLEiiqics7o=;
  b=XcrEsV1VIJNMVdc3imFuWGLlH4kW/vsCyhuL/MlH5NdW/7k6PSOIFZW1
   FrGgWRKCy8bo+Eca9i2xPZcGhaCyOvYep+ZQ9biaWQzfxPOepd73BS5l/
   THHuYAZiziW/Du1Vn8ZbXJ3tqOQA9eah8ATDjdsbv9OhMRF90Gy7mmIlv
   O2ql2BI1bhzIU3Vnleym8Jq/ktmH8Cs2vbuLVF+cpJ3BkzMkjg/ynifJB
   +RHtSGN9YWIDqdAMS/gt3bMqlhbh3ktJ0b4/SFx9Tswh677qeuRaVuNXC
   NjWnqjy8XSQiV5jTlutxSR0NvDRBG55EgNocRpQJwDh6P1RER5k63JfQN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="390123905"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="390123905"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 01:45:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="6972520"
Received: from rvadera-mobl.ger.corp.intel.com (HELO localhost) ([10.251.219.158])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 01:45:33 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "John W. Linville" <linville@tuxdriver.com>,
        Kalle Valo <kvalo@kernel.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 3/7] rtlwifi: rtl8821ae: Remove unnecessary PME_Status bit set
Date:   Fri, 17 Nov 2023 11:44:21 +0200
Message-Id: <20231117094425.80477-4-ilpo.jarvinen@linux.intel.com>
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

BIT(7) (PME_Status) is first checked and then set unnecessarily. Remove
the unnecessary setting for the bit that is already on and adjust the
comment related to it.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
index 1633328bc3d1..6ae37d61a2a2 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
@@ -2312,9 +2312,7 @@ static void _rtl8821ae_clear_pci_pme_status(struct ieee80211_hw *hw)
 		pci_read_config_byte(rtlpci->pdev, cap_pointer + 5, &pmcs_reg);
 
 		if (pmcs_reg & BIT(7)) {
-			/* PME event occured, clear the PM_Status by write 1 */
-			pmcs_reg = pmcs_reg | BIT(7);
-
+			/* Clear PME_Status with write */
 			pci_write_config_byte(rtlpci->pdev, cap_pointer + 5,
 					      pmcs_reg);
 			/* Read it back to check */
-- 
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF76F80C7BF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 12:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbjLKLOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 06:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbjLKLOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 06:14:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4C9C5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 03:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702293289; x=1733829289;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eR1sOFajwOwvIeX/GA/4ZbcY1VT8jr6eTmCY9IFcwD0=;
  b=kaGP9cs4yCUoY5shqJvKgQoFYlw4jwTK/bzSQPXQXQbn77adThBFMn3D
   NA5Lbqsd6rPdrPDCvIT5bXZUcStETJWQoIIcjdFFoDW3opyVUcWuwWXUr
   KIxuzfaIROaNuUMl6vHyoAxvwwX1J8U8TDs3Y9L9BAW4MpF1x44cDQXUT
   Yr1ML4UIFGwk01+pQGuQDEgro1QX5BxhjrL+gqYi/Lqn+P/4lWc4pgVhc
   3apXTfSJnGyPkWDFRqEJGMG7AynmeEjTvCjWobEQ+VzNEkXjSU50e1IyW
   K1n2uIp1G8QdP5Cc8KRm1ev5Oy5DaW4/13GLx1l+1xVyAPp3QESXkZ4gq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="16184494"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="16184494"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 03:14:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="863731670"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="863731670"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Dec 2023 03:14:47 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 627E530D; Mon, 11 Dec 2023 13:14:46 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Alex Vinarskis <alex.vinarskis@gmail.com>
Subject: [PATCH v1 1/1] mfd: intel-lpss: Fix the fractional clock divider flags
Date:   Mon, 11 Dec 2023 13:14:41 +0200
Message-ID: <20231211111441.3910083-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conversion to CLK_FRAC_DIVIDER_POWER_OF_TWO_PS uses wrong flags
in the parameters and hence miscalculates the values in the clock
divider. Fix this by applying the flag to the proper parameter.

Fixes: 82f53f9ee577 ("clk: fractional-divider: Introduce POWER_OF_TWO_PS flag")
Reported-by: Alex Vinarskis <alex.vinarskis@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel-lpss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
index 177915845ba2..eff423f7dd28 100644
--- a/drivers/mfd/intel-lpss.c
+++ b/drivers/mfd/intel-lpss.c
@@ -309,8 +309,8 @@ static int intel_lpss_register_clock_divider(struct intel_lpss *lpss,
 
 	snprintf(name, sizeof(name), "%s-div", devname);
 	tmp = clk_register_fractional_divider(NULL, name, __clk_get_name(tmp),
+					      0, lpss->priv, 1, 15, 16, 15,
 					      CLK_FRAC_DIVIDER_POWER_OF_TWO_PS,
-					      lpss->priv, 1, 15, 16, 15, 0,
 					      NULL);
 	if (IS_ERR(tmp))
 		return PTR_ERR(tmp);
-- 
2.43.0.rc1.1.gbec44491f096


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43397AE4F4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 07:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbjIZFUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 01:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjIZFUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 01:20:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D4C10E;
        Mon, 25 Sep 2023 22:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695705625; x=1727241625;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HobNRGqJUHXjsUELG2MflqrUmiEdsI1lLhoWfVAN/p8=;
  b=BCDAY/L/WYVWBl8pngiAdFcz/U1dMmcpzRk+hXQib+spNZq2mjhAFVmK
   VtP+Hy5vUYcBFV88c4byiVj8uA1F7XvwYtFXeICrcecnxM+JovEJNUrUs
   mW2qFfLZ5SStTyycXL6TqvEC4Nqgu1xLXWGHtdTU5Dq+dLDqS6qTJymUf
   vQmMnURUUVRxdzP3spGlVxilEIRt3Obd48z4egEgd81h72qgDGDeMbg4O
   SYBrWKuRj/LYLwMRa5BEIf5sWlosmW0Kl8DEZ2nbw7eDXorZy0+Wfvo29
   N8mjY6cdprFeCAdAQpE52B83WPeISDZA+APCNb/YyK0PwYrLGww65HKwv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360865684"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="360865684"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 22:20:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="748689667"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="748689667"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 25 Sep 2023 22:20:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DE9E387; Tue, 26 Sep 2023 08:20:18 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Yury Norov <yury.norov@gmail.com>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v1 1/5] lib/test_bitmap: Excape space symbols when printing input string
Date:   Tue, 26 Sep 2023 08:20:03 +0300
Message-Id: <20230926052007.3917389-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230926052007.3917389-1-andriy.shevchenko@linux.intel.com>
References: <20230926052007.3917389-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

test_bitmap_printlist() prints the input string which contains
a new line character. Instead of stripping it, escape that kind
of characters, so developer will see the actual input string
that has been used. Without this change the new line splits
the string to two, and the first one is not guaranteed to be
followed by the first part immediatelly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/test_bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index f2ea9f30c7c5..1f2dc7fef17f 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -523,7 +523,7 @@ static void __init test_bitmap_printlist(void)
 		goto out;
 	}
 
-	pr_err("bitmap_print_to_pagebuf: input is '%s', Time: %llu\n", buf, time);
+	pr_err("bitmap_print_to_pagebuf: input is '%*pEs', Time: %llu\n", ret, buf, time);
 out:
 	kfree(buf);
 	kfree(bmap);
-- 
2.40.0.1.gaa8946217a0b


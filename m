Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D557F1560
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbjKTONK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbjKTONI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:13:08 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB21BA;
        Mon, 20 Nov 2023 06:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700489584; x=1732025584;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1DDuOJefk+3o6ygYL1H6D6JOyUtWSGokeA8lulBT4/o=;
  b=js7MhCg2iKZhxWkxlLu3Q4w5+PoKPgLwl5qDj1TQxAXUiHX9IF+UG9FP
   z0dKwd792mJbcjZop+9QAsd6jto6ApdG7S03c0TFPu2+M+em/5c0M5Xng
   8Mn57W2wHU4NAPYTuqsjGA69e4gWEJuSJIHu6GQa11sc/lnNWEjSYvFAq
   1Gl05nxV+cF9l0kRBrqWWr9wcL6HasOme8GB5dSkHcHWqXFY+jEvfPfnd
   KTO6n7D1ykrzvszKPoZbus/IcLsLODlNEEDlBqA9VTaElOMlFgcEGf6qD
   c3SGQexN4V+KxlKxpMmkTWx8dj8F72xb0e8CWNPmge8TMx/ek4P4NU5nw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="458121746"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="458121746"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 06:12:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="801184237"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="801184237"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 20 Nov 2023 06:12:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2BDE72F0; Mon, 20 Nov 2023 16:12:33 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: [PATCH v2 3/4] EDAC, pnd2: Correct misleading error message in mk_region_mask()
Date:   Mon, 20 Nov 2023 16:10:47 +0200
Message-ID: <20231120141231.1638240-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20231120141231.1638240-1-andriy.shevchenko@linux.intel.com>
References: <20231120141231.1638240-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mask parameter is expected to be of a sequence of the set bits.
It does not mean it must be power of two (only single bit set).
Correct misleading error message.

Suggested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: new patch as suggested (Qiuxu) 

 drivers/edac/pnd2_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index ee7c9b024354..969fb2465edb 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -329,7 +329,7 @@ static void mk_region_mask(char *name, struct region *rp, u64 base, u64 mask)
 		return;
 	}
 	if (mask != GENMASK_ULL(PND_MAX_PHYS_BIT, __ffs(mask))) {
-		pr_info(FW_BUG "MOT mask not power of two\n");
+		pr_info(FW_BUG "MOT mask is invalid\n");
 		return;
 	}
 	if (base & ~mask) {
-- 
2.43.0.rc1.1.gbec44491f096


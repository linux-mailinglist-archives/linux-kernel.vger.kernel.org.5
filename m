Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D280E7CD2C6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 05:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjJRDri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 23:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjJRDrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 23:47:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13ADFBA;
        Tue, 17 Oct 2023 20:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697600856; x=1729136856;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=F7Gn0MmSHeTiOqqQ9clV0dh8Uz4Z4+ngsz52tZ/iPzE=;
  b=Ig+Y9OVx8Ps8+lE/6vZLEY73nr8qiAd5GWgBxW7pe+KHtHZ3H/ZkdEvz
   G3qo8F937nHHVPJ6IRolFY9BT7HJm2OA5SbSHWX/QZAYcHY5fMprAq0R0
   vN8Pfuod+F62nCy94z6FBOkxosYUO9e6y9Yyjp00FEiAYXhyJ2l0g5h9D
   nzNo/88NWip9IDTY8encCOWyQxGNbZmeJhB2P7usNc1OQhG/OGa8eTKEX
   6L8LdPAVWbpEJ0avYkfhe7WNYsVTfq0b8Ws6RPD5wNNXCHzgdlK7+bkx+
   N29wQPjPyI4zmsXuXWlQMwL0KNRsz2Y5401WRx3KXsGhN4A8BJsP/a9it
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="370992465"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="370992465"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 20:47:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="900157327"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="900157327"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 17 Oct 2023 20:45:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6CE4A130; Wed, 18 Oct 2023 06:47:26 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] fbdev: omapfb: Replace custom memparse() implementation
Date:   Wed, 18 Oct 2023 06:47:25 +0300
Message-Id: <20231018034725.1124006-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our library has memparse() for parsing numbers with respective suffixes
suitable for memory sizes. Use it instead of custom implementation.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/video/fbdev/omap/omapfb_main.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/video/fbdev/omap/omapfb_main.c b/drivers/video/fbdev/omap/omapfb_main.c
index 631076bf71f9..694cf6318782 100644
--- a/drivers/video/fbdev/omap/omapfb_main.c
+++ b/drivers/video/fbdev/omap/omapfb_main.c
@@ -1856,20 +1856,13 @@ static int __init omapfb_setup(char *options)
 		if (!strncmp(this_opt, "accel", 5))
 			def_accel = 1;
 		else if (!strncmp(this_opt, "vram:", 5)) {
+			unsigned long long vram;
 			char *suffix;
-			unsigned long vram;
-			vram = (simple_strtoul(this_opt + 5, &suffix, 0));
+
+			vram = memparse(this_opt + 5, &suffix);
 			switch (suffix[0]) {
 			case '\0':
 				break;
-			case 'm':
-			case 'M':
-				vram *= 1024;
-				fallthrough;
-			case 'k':
-			case 'K':
-				vram *= 1024;
-				break;
 			default:
 				pr_debug("omapfb: invalid vram suffix %c\n",
 					 suffix[0]);
-- 
2.40.0.1.gaa8946217a0b


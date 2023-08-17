Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA97E77FA13
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352561AbjHQPAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352633AbjHQPAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:00:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767982705
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692284385; x=1723820385;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=m0nCsdlExNwc4S+Xi7qjt1Fa5TELIAst5ks5CyFkoIg=;
  b=fgjY+kstlXJupeIQ/BFEjc/3IrokdqfTCT73aFooQJKRDWm5eo5JY2EM
   /IIXB6mg7Dc67WryHIhDcFZ+B4NUmnyaWbd8xNN8AHxJTRdiZ6wl4Qnaj
   Lzg1JaYd3VGuD2CA6l/94ZrFlqfsmjMG2yZA89g0shls/UZXqMecEyYd3
   TQ0X6QwGXCY+d3YeblM/vEzaxFD9msHsHVu1pT7/mVYw6/Ff9oMs5Z+Nv
   61mln0d7p+IUfhhJnRdF8tlmy5rVyBi56O95RvNFW4FwPR/PFrd9K1nN5
   XcBXkILXBezqIKri4GwQC0TFvdtuCl2ZgRkjSy2WKDBKEw2SnGLt0xsMM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="403815062"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="403815062"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 07:59:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="878256005"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 17 Aug 2023 07:59:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4F43DDE4; Thu, 17 Aug 2023 17:59:21 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 1/1] kstrtox: Consistently use _tolower()
Date:   Thu, 17 Aug 2023 17:59:19 +0300
Message-Id: <20230817145919.543251-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already use _tolower() in other places, so convert the one
which open codes it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Note, there is a desire to use hex_to_bin() instead all that stuff.
BUT. On x96_64 it gets +15 bytes to the code, which seems due to
exported function in use. Dunno if it makes sense to have hex_to_bin()
actually be static inline (since it doesn't use ctype.h anymore).
Anyway, this may be a material for another patch.

 lib/kstrtox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kstrtox.c b/lib/kstrtox.c
index 08c14019841a..d586e6af5e5a 100644
--- a/lib/kstrtox.c
+++ b/lib/kstrtox.c
@@ -59,7 +59,7 @@ unsigned int _parse_integer_limit(const char *s, unsigned int base, unsigned lon
 	rv = 0;
 	while (max_chars--) {
 		unsigned int c = *s;
-		unsigned int lc = c | 0x20; /* don't tolower() this line */
+		unsigned int lc = _tolower(c);
 		unsigned int val;
 
 		if ('0' <= c && c <= '9')
-- 
2.40.0.1.gaa8946217a0b


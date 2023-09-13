Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA31479E5CE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237864AbjIMLKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjIMLKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:10:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBF719A6;
        Wed, 13 Sep 2023 04:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694603404; x=1726139404;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ibxWhsbZoS6ac7vybC6BlSjsaIyivr2gyS1htHkWXmQ=;
  b=lHrL3VeCM0czN3vYDt1QoySR0A9SfI284LJwYbMJOYEwKS7xQnObwF2Z
   wQKmlx93trPBGwzLRE5jhge6BWaS5EyQjA2liltqcLQGFYM0AK7SSS3jO
   HhJbJNA0DtuScu868p+SpdCYYvMywsk5pBogHXums35bLY2yijQx9fj68
   +xSLk+voWrXyIew4KZbI8yTcOIkYkE0fT6cq5vLfzvx6/uL0CFNQK5jJj
   bu7AEGbvCl/8BBAd9/xbp3V5QiamGUC9Yhmv1sXGZiNipd0u8vuviV6b5
   J+q3gPk6rcsbrismZ1XJa43Pc9xBgfjH/fMDSAHsXBr1hb4bQhO2peXZd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="358899686"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="358899686"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:10:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="809639200"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="809639200"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 13 Sep 2023 04:10:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F1D22BC0; Wed, 13 Sep 2023 14:09:59 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Simon Horman <horms@kernel.org>
Subject: [PATCH v2 1/1] net: core: Use the bitmap API to allocate bitmaps
Date:   Wed, 13 Sep 2023 14:09:57 +0300
Message-Id: <20230913110957.485237-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use bitmap_zalloc() and bitmap_free() instead of hand-writing them.
It is less verbose and it improves the type checking and semantic.

While at it, add missing header inclusion (should be bitops.h,
but with the above change it becomes bitmap.h).

Suggested-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20230911154534.4174265-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: added tags (Simon), sent separately from the series (Paolo)
 net/core/dev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index ccff2b6ef958..85df22f05c38 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -69,7 +69,7 @@
  */
 
 #include <linux/uaccess.h>
-#include <linux/bitops.h>
+#include <linux/bitmap.h>
 #include <linux/capability.h>
 #include <linux/cpu.h>
 #include <linux/types.h>
@@ -1080,7 +1080,7 @@ static int __dev_alloc_name(struct net *net, const char *name, char *buf)
 			return -EINVAL;
 
 		/* Use one page as a bit array of possible slots */
-		inuse = (unsigned long *) get_zeroed_page(GFP_ATOMIC);
+		inuse = bitmap_zalloc(max_netdevices, GFP_ATOMIC);
 		if (!inuse)
 			return -ENOMEM;
 
@@ -1109,7 +1109,7 @@ static int __dev_alloc_name(struct net *net, const char *name, char *buf)
 		}
 
 		i = find_first_zero_bit(inuse, max_netdevices);
-		free_page((unsigned long) inuse);
+		bitmap_free(inuse);
 	}
 
 	snprintf(buf, IFNAMSIZ, name, i);
-- 
2.40.0.1.gaa8946217a0b


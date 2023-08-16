Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB33F77E2EB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 15:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245677AbjHPNnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 09:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343518AbjHPNnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:43:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C8D30E0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 06:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692193369; x=1723729369;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DDaqR8jxXrDXXR9QxQxqg4qA72d+XQzUFNNFvJlV6zg=;
  b=DK5dfPJwfbR1Tci7KqfiBz8rw5L4dmjUKjOvh5KqgcOzLRyTFg381k9t
   p782gSiUymXIU/swAZnybXEVseNXT8+nSW74ZRJe2khF9uRlGt1+b/1qZ
   UqxUuiaRMsOYzjAG3PaZXna4Gv2aYxFBo++09SBNIHu5X0JH8uMRpvtSc
   dM6aoBCU1lSBezFlOQEp5lyR1t09rZl6q6tgMxjvC1GY+jGrLzm7XE6uF
   QSzaW8QQvGe3KV1tTGIZkKunP7RyGoSDHGgKqdzVagXzhh2PNAlpSAbv3
   Lw0yRgAKQvI3nMP8VcodU3J+2JlSmvAO+GGRoc3yGP+k2EQkqK0vXgDVh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="436435605"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="436435605"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 06:42:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="711118952"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="711118952"
Received: from himal-super-server.iind.intel.com ([10.145.169.168])
  by orsmga006.jf.intel.com with ESMTP; 16 Aug 2023 06:42:45 -0700
From:   Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc:     Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Badal Nilawar <badal.nilawar@intel.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] fault-inject: Include linux/types.h by default.
Date:   Wed, 16 Aug 2023 19:17:48 +0530
Message-Id: <20230816134748.979231-1-himal.prasad.ghimiray@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Functions should_fail_alloc_page, should_failslab, and __should_failslab
are declared irrespective of CONFIG_FAULT_INJECTION. These functions use
bool and gfp_t types, which are treated as unknown when
CONFIG_FAULT_INJECTION is disabled because the inclusion of linux/types.h
is missing.

Fixes: 6ff1cb355e62 ("[PATCH] fault-injection capabilities infrastructure")

Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Badal Nilawar <badal.nilawar@intel.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
---
 include/linux/fault-inject.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/fault-inject.h b/include/linux/fault-inject.h
index 481abf530b3c..f83ab2b6cd08 100644
--- a/include/linux/fault-inject.h
+++ b/include/linux/fault-inject.h
@@ -2,9 +2,10 @@
 #ifndef _LINUX_FAULT_INJECT_H
 #define _LINUX_FAULT_INJECT_H
 
+#include <linux/types.h>
+
 #ifdef CONFIG_FAULT_INJECTION
 
-#include <linux/types.h>
 #include <linux/debugfs.h>
 #include <linux/configfs.h>
 #include <linux/ratelimit.h>
-- 
2.25.1


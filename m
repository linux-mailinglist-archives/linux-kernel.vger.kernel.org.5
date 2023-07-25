Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8122761D98
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjGYPqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjGYPqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:46:17 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AC91FFE
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690299976; x=1721835976;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+jMb/Q8IPrEdfuPHdxpVPEc85TiG5r0bGhBC6vkl8yA=;
  b=lk21L1g/m0URk+Ccl+/uYh9KAOQlTFM0WKNR31HXgr4Xx131Zt6sfny1
   5R2f6nKhB6FvaF7flcmmUjMXCF1sbUewzrl/nZ41J2DtPKunmN38/m6Hx
   jOYpLeR+3eIwWNaKNUfPnjdh6AuEXDVCVe/a7Z3DVz8iVvPKMeoja83ss
   15bI6/NQQZYbhlpMhNBHaLJrdcGR3iEEjM2KKWeLjk2ab3xtjA157aiZD
   HIQ5kRbxEZcCnWa5rusnmde5yhCbA0AfRMeHSGKjEH1Xu+tWBgxZ8zIp/
   UBwqWm+MC6qHSmo/WW4k0QSMpdhnt2dMcykff5vCa/4pAKl9/o09RqrRp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="352667249"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="352667249"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 08:46:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="729395470"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="729395470"
Received: from himal-super-server.iind.intel.com ([10.145.169.168])
  by fmsmga007.fm.intel.com with ESMTP; 25 Jul 2023 08:46:12 -0700
From:   Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
To:     intel-xe@lists.freedesktop.org
Cc:     Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Badal Nilawar <badal.nilawar@intel.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 1/3] fault-inject: Include linux/types.h by default.
Date:   Tue, 25 Jul 2023 21:21:13 +0530
Message-Id: <20230725155115.3759312-2-himal.prasad.ghimiray@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230725155115.3759312-1-himal.prasad.ghimiray@intel.com>
References: <20230725155115.3759312-1-himal.prasad.ghimiray@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Functions should_fail_alloc_page, should_failslab, and __should_failslab
are declared irrespective of CONFIG_FAULT_INJECTION. These functions use
bool and gfp_t types, which are treated as unknown when CONFIG_FAULT_INJECTION
is disabled because the inclusion of linux/types.h is missing.

Fixes: 6ff1cb355e62 ("[PATCH] fault-injection capabilities infrastructure")

v2:
- Add fixes tag (Badal)
- Rectify Cc. (Lucas)

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


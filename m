Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99770786F3E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 14:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237999AbjHXMiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 08:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbjHXMhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 08:37:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B95A1711;
        Thu, 24 Aug 2023 05:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692880658; x=1724416658;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YCu4y4VSW5d5YZsdxmOmKcQalRJ5jfj6pyX8p/LklZ0=;
  b=ZKg6wYNBLuAiPM9tMAye0rXk/7zbT+Ki2FMxVS8+br41oYtBs5xUlo1J
   qtGEdIPcZYd0btB5M2EO0z50xLAOc6ljXy2FZvRTNBXHf9XM+oqN6xEyy
   DSqQdIlB5MRfmqLG0i/SCnrBDejV1DY9up8SbuSEYO1CrGkXrT40/T51N
   0TztVbV0lvKoDhruTsyfIZvwrdsZHCFiQjwyIlHJaOkMDmohbciwwMmPx
   IHVlLXmAh/NDGnAstC/waSCnp5LKH40LKLFSRbi9Hvvn/zGLO3gQX9Otk
   O3rho3yT3dNJX0z+7/ay+FaBY/QmmOqZgM38fMQk4Pr+1fy7W91AqpbjD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="373306788"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="373306788"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 05:37:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="713959516"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="713959516"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 24 Aug 2023 05:37:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1F9A617F; Thu, 24 Aug 2023 15:37:34 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>, Uros Bizjak <ubizjak@gmail.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] bitops: Share BYTES_TO_BITS() for everyone
Date:   Thu, 24 Aug 2023 15:37:28 +0300
Message-Id: <20230824123728.2761663-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
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

It may be new callers for the same macro, share it.

Note, it's unknown why it's represented in the current form instead of
simple multiplication and commit 1ff511e35ed8 ("tracing/kprobes: Add
bitfield type") doesn't explain that neither. Let leave it as is and
we may improve it in the future.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/bitops.h     | 2 ++
 kernel/trace/trace_probe.c | 3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 2ba557e067fe..66dc091e0c28 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -21,6 +21,8 @@
 #define BITS_TO_U32(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u32))
 #define BITS_TO_BYTES(nr)	__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(char))
 
+#define BYTES_TO_BITS(nb)	((BITS_PER_LONG * (nb)) / sizeof(long))
+
 extern unsigned int __sw_hweight8(unsigned int w);
 extern unsigned int __sw_hweight16(unsigned int w);
 extern unsigned int __sw_hweight32(unsigned int w);
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index c68a72707852..da6297d24d61 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -11,6 +11,7 @@
  */
 #define pr_fmt(fmt)	"trace_probe: " fmt
 
+#include <linux/bitops.h>
 #include <linux/bpf.h>
 
 #include "trace_probe.h"
@@ -830,8 +831,6 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 	return ret;
 }
 
-#define BYTES_TO_BITS(nb)	((BITS_PER_LONG * (nb)) / sizeof(long))
-
 /* Bitfield type needs to be parsed into a fetch function */
 static int __parse_bitfield_probe_arg(const char *bf,
 				      const struct fetch_type *t,
-- 
2.40.0.1.gaa8946217a0b


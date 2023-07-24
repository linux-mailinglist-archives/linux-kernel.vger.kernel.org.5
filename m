Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA8D75F9EA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 16:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjGXOby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 10:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjGXObv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:31:51 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51686A4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 07:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690209110; x=1721745110;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+5gG+0+scvDqbfX5/L0lqS4BwovP5AcRlSaFF9Lgp1c=;
  b=fchlWQPx2n/WHU9ps3TAMGDgiDhxgrdns4ok+8ShBg9gnGLW9nzZj1lt
   /38vPeUk1pKOsyTR0RJaDne6UGl/hEwdwX/qRsiQEv/iBELVox46SQFsD
   tkW+KObP/RcU38Br3cIrHOY5g08ANyVOUa0geWfuFInTk6fVvfQWxxIm6
   1zhQIT30z/3H4yhZpz7PnxdblTCPYw3BAJ85zVbHitQM0jtcpGKGcm0Wk
   LsJrQA8J7htvyQb8ApoKKZ1n2/vqbH9WFAGV6oSkwYqRfZ2V0+TSzUG46
   0y0ofH+C1bWy1Nuf4hSyrbkpajMIbAJc1gjz9ajXiA7EigBY36ES3Z4Wp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="398362893"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="398362893"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 07:31:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="790986713"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="790986713"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 24 Jul 2023 07:31:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 08F591A6; Mon, 24 Jul 2023 17:31:32 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Herve Codina <herve.codina@bootlin.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Yang Guang <yang.guang5@zte.com.cn>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 1/1] Revert "um: Use swap() to make code cleaner"
Date:   Mon, 24 Jul 2023 17:31:31 +0300
Message-Id: <20230724143131.30090-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 9b0da3f22307af693be80f5d3a89dc4c7f360a85.

The sigio.c is clearly user space code which is handled by
arch/um/scripts/Makefile.rules (see USER_OBJS rule).

The above mentioned commit simply broke this agreement,
we may not use Linux kernel internal headers in them without
thorough thinking.

Hence, revert the wrong commit.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202307212304.cH79zJp1-lkp@intel.com/
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: fixed typo (h --> c), added Reported-by tag
 arch/um/os-Linux/sigio.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/um/os-Linux/sigio.c b/arch/um/os-Linux/sigio.c
index 37d60e72cf26..9e71794839e8 100644
--- a/arch/um/os-Linux/sigio.c
+++ b/arch/um/os-Linux/sigio.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2002 - 2008 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  */
 
-#include <linux/minmax.h>
 #include <unistd.h>
 #include <errno.h>
 #include <fcntl.h>
@@ -51,7 +50,7 @@ static struct pollfds all_sigio_fds;
 
 static int write_sigio_thread(void *unused)
 {
-	struct pollfds *fds;
+	struct pollfds *fds, tmp;
 	struct pollfd *p;
 	int i, n, respond_fd;
 	char c;
@@ -78,7 +77,9 @@ static int write_sigio_thread(void *unused)
 					       "write_sigio_thread : "
 					       "read on socket failed, "
 					       "err = %d\n", errno);
-				swap(current_poll, next_poll);
+				tmp = current_poll;
+				current_poll = next_poll;
+				next_poll = tmp;
 				respond_fd = sigio_private[1];
 			}
 			else {
-- 
2.40.0.1.gaa8946217a0b


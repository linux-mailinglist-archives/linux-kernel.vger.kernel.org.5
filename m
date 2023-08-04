Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EDC76FBF9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbjHDI04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234565AbjHDI02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:26:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E38A4698
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691137587; x=1722673587;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GrsynOg2xgorKiT0iE4UnCXSWHQ9xboHF2x1Jg9/Yuk=;
  b=LK86CKOJjzgIs5ylME9YVbqixUVTCj0xjeCMI2JA8KO7IbMutQW9YNiC
   QeHxkHvpxAGwxweQCVtdIdGMmZQoEOFrkImhi5DY12Wx0NXK4l/U4mfu7
   XJhirmGYD1mmRfEbRHp3jOMqpu3IOHpCPc/XYeIiPDAKmGnFaKqRxlCZf
   JWe+OjPeX2gE8x2KNT0c616SCEzemPAIV3+U0W9zUAJsUeZm1di9S8fyf
   h+21KmupxrB9B1TAs76ijYlHTKySjNqSxPIDtQz4bK0ARA9cyPtKn/95I
   yr1Tf8J7MEBIsmIFIdxbeCF8peZQfOerS7ZJBS4FBNxfaGTCc4ua82xmS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="433952161"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="433952161"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 01:26:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="706907757"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="706907757"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 04 Aug 2023 01:26:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8F3DF1341; Fri,  4 Aug 2023 11:26:32 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 3/4] lib/vsprintf: Remove implied inclusions
Date:   Fri,  4 Aug 2023 11:26:18 +0300
Message-Id: <20230804082619.61833-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230804082619.61833-1-andriy.shevchenko@linux.intel.com>
References: <20230804082619.61833-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove inclusions that are implied and guaranteed to be provided by others:

  compiler.h	by types.h
  string.hi	by string_helpers.h

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/vsprintf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 63afffab4249..eb0934d02722 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -20,7 +20,6 @@
 #include <linux/build_bug.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
-#include <linux/compiler.h>
 #include <linux/cred.h>
 #include <linux/ctype.h>
 #include <linux/dcache.h>
@@ -36,7 +35,6 @@
 #include <linux/rtc.h>
 #include <linux/siphash.h>
 #include <linux/stdarg.h>
-#include <linux/string.h>
 #include <linux/string_helpers.h>
 #include <linux/time.h>
 #include <linux/types.h>
-- 
2.40.0.1.gaa8946217a0b


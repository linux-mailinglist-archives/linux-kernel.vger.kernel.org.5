Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA15F77BDE3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjHNQ01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjHNQ0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:26:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3F1A8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692030382; x=1723566382;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=71NJka35PGxaNCojRiQGmwNxYzKOVeUK2drhv3jA3vA=;
  b=hkjSKNjx8bgI6AHfLOZ+9YG1FuOjtU4Xzfq2Ybvff0EfXzKA7Fi3FWuQ
   qpIVAuSGrZNOjfSz26NDN5FuFxpXcMG0EkqiHbJ1TunOxB6vAtyJhc/g5
   R3+Y8Kxd/tAAp71MsJIvZ9NnOrYrBEpwyCGTPzBrtWGRl1zAmi6I2PGpK
   LL6vBUaf2FDilWQ9zWA1P4DT9hLCDvIB9DHIQEGzniqOsQciX8hP5eex5
   ewtlk33G31+rBfEOgTiPKrRCH5bgZupqqaGHrnxlf6On6KmBGzyx93/F7
   v+4UGQsss/bKFG70HU1NTNL9vn0xjnkFMnG52+lIjGAcahqCrTWiLbfd2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="374852960"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="374852960"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 09:26:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="762991299"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="762991299"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 14 Aug 2023 09:26:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C15EB33B; Mon, 14 Aug 2023 19:33:47 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>, Marco Elver <elver@google.com>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 0/2] lib/vsprintf: Rework header inclusions
Date:   Mon, 14 Aug 2023 19:33:42 +0300
Message-Id: <20230814163344.17429-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some patches that reduce the mess with the header inclusions related to
vsprintf.c module. Each patch has its own description, and has no
dependencies to each other, except the collisions over modifications
of the same places. Hence the series.

Changelog v3:
- dropped sorting headers patch (Petr)
- added tag (Marco)

Changelog v2:
- covered test_printf.c in patches 1 & 2
- do not remove likely implict inclusions (Rasmus)
- declare no_hash_pointers in sprintf.h (Marco, Steven, Rasmus)

Andy Shevchenko (2):
  lib/vsprintf: Split out sprintf() and friends
  lib/vsprintf: Declare no_hash_pointers in sprintf.h

 include/linux/kernel.h  | 30 +-----------------------------
 include/linux/sprintf.h | 27 +++++++++++++++++++++++++++
 lib/test_printf.c       |  3 +--
 lib/vsprintf.c          |  1 +
 mm/kfence/report.c      |  3 +--
 5 files changed, 31 insertions(+), 33 deletions(-)
 create mode 100644 include/linux/sprintf.h

-- 
2.40.0.1.gaa8946217a0b


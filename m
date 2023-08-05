Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6F9771123
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 19:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjHERto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 13:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjHERtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 13:49:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D869DD
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 10:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691257774; x=1722793774;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rEpi9TPxaBsioRbO+12MR2A475UUbDQs5Dep4NW21jM=;
  b=mPOcPHfpLas4OMdog/mVAB8wYjmO4pSDvWPjFhsT7n3qa9qnuCXRzX/f
   6Vu6ZEwOT/9/8buG4Br5fVMj8Q2m0Pf5F/6BfMrm/OQkhYu1dNDHCBxWT
   EZ+VuqH7UXaUiiXZGJcdY94Vu8PaoSZ09yVelilGnsbv1H/zKLX2D8kOH
   fQFp+k/aI6BGBtarDC781RVi3PCAAXEdKgfeI8Om9xDEzT1RMbHzgFrYS
   qrfpjBCViDOB0Lbh8yw+QV87PeAqWnjJS8teiynPMrOuQ7Eai9O6Q2Fww
   onRJIMf33b/EUTi/6AFjywYr9kxghQT0G7MrMZldm6SERTajcDrSFg4o3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10793"; a="401292519"
X-IronPort-AV: E=Sophos;i="6.01,258,1684825200"; 
   d="scan'208";a="401292519"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2023 10:49:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10793"; a="820494256"
X-IronPort-AV: E=Sophos;i="6.01,258,1684825200"; 
   d="scan'208";a="820494256"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Aug 2023 10:49:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 87E94241; Sat,  5 Aug 2023 20:50:29 +0300 (EEST)
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
Subject: [PATCH v2 0/3] lib/vsprintf: Rework header inclusions
Date:   Sat,  5 Aug 2023 20:50:24 +0300
Message-Id: <20230805175027.50029-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some patches that reduce the mess with the header inclusions related to
vsprintf.c module. Each patch has its own description, and has no
dependencies to each other, except the collisions over modifications
of the same places. Hence the series.

Changelog v2:
- covered test_printf.c in patches 1 & 2
- do not remove likely implict inclusions (Rasmus)
- declare no_hash_pointers in sprintf.h (Marco, Steven, Rasmus)

Andy Shevchenko (3):
  lib/vsprintf: Sort headers alphabetically
  lib/vsprintf: Split out sprintf() and friends
  lib/vsprintf: Declare no_hash_pointers in sprintf.h

 include/linux/kernel.h  | 30 +-----------------------------
 include/linux/sprintf.h | 27 +++++++++++++++++++++++++++
 lib/test_printf.c       | 20 ++++++++------------
 lib/vsprintf.c          | 39 +++++++++++++++++++++------------------
 mm/kfence/report.c      |  3 +--
 5 files changed, 58 insertions(+), 61 deletions(-)
 create mode 100644 include/linux/sprintf.h

-- 
2.40.0.1.gaa8946217a0b


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09EE376FBF4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbjHDI0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234539AbjHDI0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:26:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B080A30C4
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691137584; x=1722673584;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sHbp61XrSGUwS77joL7G3Aw3O4HqQ1kVegd85qwztzc=;
  b=SDwioZtAZV9rmXYNFB/sV8IRxLLfRDj3q8qhwXw7UQRiXCG2F3gZwYPQ
   3YjT5RGBXE6SX7VS/W/GWzKxv6L0FKwK07Q+C4WUBwV0q9wSpvpYAxN8Q
   qYJLA5/psgmJ2KcuTZVVYUjiCsWD3IlQ5XfRZ4laYl0X1BHiplzPlc2lV
   gQXftkgfPLTaUzI3RuPtIlnOB46jlwOFdJT8fhgBDSceJB8reRRP2nuqz
   qodkOzTUo3IrJk9y41MtMdrh65Oj411Tpp+vAYgiPPimsHZqw+7IkrIj7
   5WYNsLY+qFErx19jJrv74RdQ3cy5cd2512Hkwtv0eSU9y0MuBCu6p0ZS1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="370090203"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="370090203"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 01:26:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="733132236"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="733132236"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 04 Aug 2023 01:26:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6BD6FBAB; Fri,  4 Aug 2023 11:26:32 +0300 (EEST)
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
Subject: [PATCH v1 0/4] lib/vsprintf: Rework header inclusions
Date:   Fri,  4 Aug 2023 11:26:15 +0300
Message-Id: <20230804082619.61833-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
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

Some patches that reduce the mess with the header inclusions related to
vsprintf.c module. Each patch has its own description, and has no
dependencies to each other, except the collisions over modifications
of the same places. Hence the series.

Andy Shevchenko (4):
  lib/vsprintf: Declare no_hash_pointers in a local header
  lib/vsprintf: Sort headers alphabetically
  lib/vsprintf: Remove implied inclusions
  lib/vsprintf: Split out sprintf() and friends

 include/linux/kernel.h  | 30 +-----------------------------
 include/linux/sprintf.h | 24 ++++++++++++++++++++++++
 lib/test_printf.c       |  4 ++--
 lib/vsprintf.c          | 38 ++++++++++++++++++++------------------
 lib/vsprintf.h          |  7 +++++++
 mm/kfence/report.c      |  3 +--
 6 files changed, 55 insertions(+), 51 deletions(-)
 create mode 100644 include/linux/sprintf.h
 create mode 100644 lib/vsprintf.h

-- 
2.40.0.1.gaa8946217a0b


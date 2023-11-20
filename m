Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013297F16F2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbjKTPOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbjKTPO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:14:28 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F28ACF;
        Mon, 20 Nov 2023 07:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700493265; x=1732029265;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RfU41fixaYxiF352iqz3sfz5IGykKH9mO563in4FsAg=;
  b=jYZWFJLfqfPe8m1aXMH6IkYGsx7aMEdVt7aJ9W0Ow+4gO7uFZAwCMgMZ
   JoWt+4oi7/cbEEI/ENU1P+5aB6Dlet8Jz+zSMFG6PwSmOt/B3eT1dN0i7
   E3hu0UkjGQicrO74kTh5564EkoMPcXF6TBY8I3t2Z5fuj4okmxgwP3kdj
   +p7BaFyitSkNUwPE9kZf8Tlf8S+/uShXhdDXCUhA89GHJJWarb3I7j8Ar
   i0NZMaY7MeJFVGui0o1yZOcBkWCnBNgPWTuXNga6DqLaK+lhh7lNnyG9t
   L551jB7fGG5p1/GDTD9XtSWyS9R7erTRGtOdGYV8fACmYy7RsG9IlKMf8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="422730959"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="422730959"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 07:14:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="1097766555"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="1097766555"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 20 Nov 2023 07:14:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 374E06B; Mon, 20 Nov 2023 17:14:21 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 0/5] params: harden string ops and allocatio ops
Date:   Mon, 20 Nov 2023 17:11:41 +0200
Message-ID: <20231120151419.1661807-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
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

A couple of patches are for get the string ops, used in the module,
slightly harden. On top a few cleanups.

Since the main part is rather hardening, I think the Kees' tree is
the best fit for the series. It also possible to route via Greg's
sysfs (driver core?), but I'm open for another option(s).

Changelog v3:
- added tags (Kees, Luis)

Changelog v2:
- dropped the s*printf() --> sysfs_emit() conversion as it revealed
  an issue, i.e. reuse getters with non-page-aligned pointer, which
  would be addressed separately
- added cover letter and clarified the possible route for the series
  (Luis)

Andy Shevchenko (5):
  params: Introduce the param_unknown_fn type
  params: Do not go over the limit when getting the string length
  params: Use size_add() for kmalloc()
  params: Sort headers
  params: Fix multi-line comment style

 include/linux/moduleparam.h |  6 ++--
 kernel/params.c             | 56 ++++++++++++++++++++-----------------
 2 files changed, 33 insertions(+), 29 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


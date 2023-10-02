Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA21D7B5371
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237123AbjJBMtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjJBMtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:49:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7C0A6;
        Mon,  2 Oct 2023 05:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696250945; x=1727786945;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YwAIlro9IwnHVZWXrpT/1pxHBCu++yJ5R+zkC9sbLRY=;
  b=eODZ2kHebx3ECLhzGQwZdNRVkG/bHACROm7X93P0YyIkxQCWSxQzB49I
   8CSn+IeiAMc2lDQHTXimd6G6isoInkmJH0EB72iaZrhzpXurME2aP0RVX
   VpPqolQ4O3OnrG1d9fygb8sZMDXO+PVBal2Mz3z58d83BKTThongJqpm6
   6mlc1Xwaq3qwZpfBb8QROtb9fuvM5DVu26gmSHaCRQHBrWBvaF0axxNBj
   3/nc16Jjyi11Gus3gGk0aQkkZ85jyigwXrCQxEaDdcoJQ5Gaasa5UsWVQ
   nXY1F1BDEeVitUXIJEc3tEOoXXsjO/8EueMIQLOkUwhuSK13OU8uE20Wl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="381517977"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="381517977"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 05:49:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="894127811"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="894127811"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Oct 2023 05:47:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E2AC214AF; Mon,  2 Oct 2023 15:49:01 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 0/5] params: harden string ops and allocatio ops
Date:   Mon,  2 Oct 2023 15:48:51 +0300
Message-Id: <20231002124856.2455696-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of patches are for get the string ops, used in the module,
slightly harden. On top a few cleanups.

Since the main part is rather hardening, I think the Kees' tree is
the best fit for the series, but I'm open for another option(s).

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

 include/linux/moduleparam.h |  6 ++---
 kernel/params.c             | 52 ++++++++++++++++++++-----------------
 2 files changed, 31 insertions(+), 27 deletions(-)

-- 
2.40.0.1.gaa8946217a0b


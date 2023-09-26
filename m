Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746827AF32E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 20:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbjIZSpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 14:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjIZSpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 14:45:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861CD11D;
        Tue, 26 Sep 2023 11:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695753942; x=1727289942;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wALDOfDch1TypPPb0YRrudhRYM25aDx55qWGrSyEGzQ=;
  b=guiyNTX9wWq2ZDr/h2kpebrT7/oGhhp9gIVi6tQkI1MyXKy22ry/PNVs
   2V5H+pDOZVj+tgrKrf0+CJW7IMpDnNAb3F0IgRFKpRC5XkKYp2YOepRMj
   14kCMbzAGkQ/oh3HnK/Qd9u/6ZRdAW5/cYCa4hPhlKbXFxYiuUPBl8l8H
   F+MkU9eHdgFKq14THWso8M21WC5+vazbiOSzif3Sukm9PFSUkp9i9nf20
   gSDz1sKvLtQPGyHjxPLCjb1HdCw9hLDkEgfxrNoAuwVu9h4sDZLwZxcJv
   RpQquDvdWHfs3pZ/GuxCReHBnwEzKKXdmgV/GbYVBp8V1DXKH47RiSIuG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="378920251"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="378920251"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 11:45:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="752279630"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="752279630"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 11:45:28 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev
Cc:     rafael.j.wysocki@intel.com, andriy.shevchenko@intel.com,
        lenb@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v1 0/2] Fix memory leak and move to modern scope based rollback
Date:   Tue, 26 Sep 2023 21:45:18 +0300
Message-ID: <20230926184520.2239723-1-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In acpi_nfit_init_interleave_set() there is a memory leak + improper use
of devm_*() family of functions for local memory allocations. This patch
series provides two commits - one is meant as a bug fix, and could
potentially be backported, and the other one improves old style rollback
with scope based, similar to C++ RAII [1].

Link: https://lwn.net/Articles/934679/ [1]

Michal Wilczynski (2):
  ACPI: NFIT: Fix memory leak, and local use of devm_*()
  ACPI: NFIT: Use modern scope based rollback

 drivers/acpi/nfit/core.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

-- 
2.41.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F3D7FFDCF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376980AbjK3VsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjK3VsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:48:04 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4201610D9;
        Thu, 30 Nov 2023 13:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701380890; x=1732916890;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RaDbOobfiJYe1OxnBOTOfWlMLbFDEnEv8lGngcISPOQ=;
  b=HjwrZw5bkBUHRLWg1rsNdTWZ7BvsHSwDYAne51BGTMZdDsNuJaDDVZTH
   wxJdspVcUXKt3oAKDxqirR1tabmnsUpvuxF0B5/Pq3qkZO+ARhhrcfPHV
   SjoNTFYW56CKagT0o9cKJWS5KYOgiI+v12krbzYOOfHuo0h7ztF4MQywK
   ExCJ3bMeCOB1Z0BFmgbhQjOIRu5IOsQzow+r6j99wi5hO3OBOSB7oqJgV
   d1DYwKy0nDR98Aj1AlXpXFXwusGwL8blnCHona977bM7nYVFhYxHmE5T7
   po/xEvJr7qf/bY8Ewu0PYbMFoPG4c7womnUI0eRpIrI1UPYk7b4vqlPWD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="399937"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="399937"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 13:48:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="860334603"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="860334603"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Nov 2023 13:48:09 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 0/5] TPMI update for permissions
Date:   Thu, 30 Nov 2023 13:47:46 -0800
Message-Id: <20231130214751.3100418-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Process read/write and enabled state for feature drivers. When a feature
is disabled, don't create a device to load a feature driver. When a read
is blocked then don't load feature drivers. When write is blocked continue
to function in read only mode.

v2:
	Dropped patch platform/x86/intel/tpmi: Add additional TPMI header fields
	Addressed other review comments, details are in each patch

Srinivas Pandruvada (5):
  platform/x86/intel/tpmi: Don't create devices for disabled features
  platform/x86/intel/tpmi: Modify external interface to get read/write
    state
  platform/x86/intel/tpmi: Move TPMI ID definition
  platform/x86: ISST: Process read/write blocked feature status
  platform/x86/intel-uncore-freq: Process read/write blocked feature
    status

 .../intel/speed_select_if/isst_tpmi_core.c    | 25 +++++++++++++
 drivers/platform/x86/intel/tpmi.c             | 35 +++++++++----------
 .../uncore-frequency/uncore-frequency-tpmi.c  | 15 ++++++++
 include/linux/intel_tpmi.h                    | 18 ++++++++--
 4 files changed, 72 insertions(+), 21 deletions(-)

-- 
2.41.0


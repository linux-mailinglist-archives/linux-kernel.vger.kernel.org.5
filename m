Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815BE7B3B7D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 22:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbjI2Up3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 16:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbjI2UpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 16:45:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B44A1B7;
        Fri, 29 Sep 2023 13:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696020323; x=1727556323;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=61oC0nAEclqWNX7WIQ27wAnk26gc81A2vtJ03UCtRjQ=;
  b=OnonJaR5IfeD+kIn+38zBC+mnTCfXf2lkx62NsS0uwv479+4qPfW+E0T
   nu6DDiZBeCey3jTg1XFrUTXnjmR40tomGPzBBLdP8P1+h+44TTFz3J1+s
   suJS3TIUlsiPnemuztIzevLsyPvoJcXdocPjIcxjJp1dtCCA+3/odOH+X
   odmgTwTuB6mlqKaeS3UbAXaZmDFHMRvzqDfoRgr0dJzilzioT+fXWJsd2
   DgYRN968HbAVYEQZv7qPCNSvjZ89rOKJM/1AjXplnf4OWr+AZgeDgdYPH
   ta9TxB2M5xMYDwn007dSR/BCyEwm2lQTVow3LPyUSG4JLfvh614LDpUzS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="468654414"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="468654414"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 13:28:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="893539181"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="893539181"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 13:27:28 -0700
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        rostedt@goodmis.org, jithu.joseph@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, pengfei.xu@intel.com,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v3 0/9] IFS support for GNR and SRF
Date:   Fri, 29 Sep 2023 13:24:27 -0700
Message-Id: <20230929202436.2850388-1-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230922232606.1928026-1-jithu.joseph@intel.com>
References: <20230922232606.1928026-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v3
   Ilpo Jarvinen
    - Added Reviewed-by tags wherever provided
    - In function validate_ifs_metadata() (patch 6)
        - Add != 0 to next line for clarity
    - In function ifs_load_firmware() (patch 5)
        - return -EINVAL instead of -BADFD
    - In function ifs_test_core() (patch 4)
        - initialize activate.gen0.rsvd = 0
        - use if instead of conditional operator
    - alignment change in ifs_scan_hashes_status_gen2 (patch 3)

v2 submission
Link: https://lore.kernel.org/lkml/20230922232606.1928026-1-jithu.joseph@intel.com/

Changes in v2
   Ilpo Jarvinen
    - Use GENMASK_ULL() / FIELD_GET() for bitops (patch 01)
    - Avoid mixing u8 type and bitfields in certain MSR structure
       scenarios (patch03 also suggested by Dave Hansen)
    - Expand bitfield structures to use consistent genx naming (patch 04)
    - Replace goto with do / while (patch 03)
    - general formatting (multiple patches)
        - remove un-necessary parenthesis
        - reformat commit message to use whole allowed 72 columns
        - alignment changes
    Other change
     - fold v1 04/10 and 05/10 into v2 patch 04/09 to satisfy build
        constraints due to consistent genx naming

v1 submission:
Link: https://lore.kernel.org/lkml/20230913183348.1349409-1-jithu.joseph@intel.com/

This series adds In Field Scan(IFS) support for newer CPUs like Granite
Rapids(GNR) and Sierra Forest(SRF).

There are changes in the IFS image loading and test flow to support
these new CPUs.

Note to reviewers:
 - patch 1/9 adds a bit mask to arch/x86/.../msr-index.h,
  hence x86 maintainers are cc-d.
 - patch 4/9 modifies an existing tracepoint, cc Steven Rostedt
 - Rest are localized to IFS driver

Jithu Joseph (9):
  platform/x86/intel/ifs: Store IFS generation number
  platform/x86/intel/ifs: Refactor image loading code
  platform/x86/intel/ifs: Gen2 scan image loading
  platform/x86/intel/ifs: Gen2 Scan test support
  platform/x86/intel/ifs: Validate image size
  platform/x86/intel/ifs: Metadata validation for start_chunk
  platform/x86/intel/ifs: Add new CPU support
  platform/x86/intel/ifs: Add new error code
  platform/x86/intel/ifs: ARRAY BIST for Sierra Forest

 arch/x86/include/asm/msr-index.h         |   1 +
 drivers/platform/x86/intel/ifs/ifs.h     |  61 ++++++++-
 include/trace/events/intel_ifs.h         |  16 +--
 drivers/platform/x86/intel/ifs/core.c    |  15 ++-
 drivers/platform/x86/intel/ifs/load.c    | 158 +++++++++++++++++++++--
 drivers/platform/x86/intel/ifs/runtest.c |  72 +++++++++--
 6 files changed, 283 insertions(+), 40 deletions(-)


base-commit: 6465e260f48790807eef06b583b38ca9789b6072
-- 
2.25.1


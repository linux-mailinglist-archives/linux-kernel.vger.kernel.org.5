Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB827BAABF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 21:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjJETzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 15:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJETzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 15:55:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0EADB;
        Thu,  5 Oct 2023 12:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696535745; x=1728071745;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xRdIGrMu0iispDmD5LNO95ypugEOWAVy/AAjlhz/WJk=;
  b=ewnuJ5s1vr/K9hw94XHL39wd1FtEB8uWccgSDO0ww0qi6R0QXZ7oq/b+
   7dO/1pktjRC62+XgwbEx3CQPp6ksmdZQf0Or7iuuQEHNKBWLoytKkAeq0
   WvdlMxVsox1+MHJ/jARH5CcCLjaI3Lw01c1RPmBztlE+KKaylYEthGavY
   zLFqepHC7B9ukBE1e09VX72MG+9HpLzDYuYhHwc285SDBCG/cmbslfkst
   eHTj+xxP1fut9xvJkSnOjskp56CoQumWl2gEFZ3PCA9VWfhPHZyZpaKTv
   +Sbq1Bl5FUPTOjM6CcDxNiOFiUwEz0EAdYem9q4gvZun4VqCSTGi9X7a+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="386432534"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="386432534"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 12:55:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="755600113"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="755600113"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 12:55:43 -0700
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     ilpo.jarvinen@linux.intel.com, hdegoede@redhat.com,
        markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        rostedt@goodmis.org, jithu.joseph@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, pengfei.xu@intel.com
Subject: [PATCH v4 0/9] IFS support for GNR and SRF
Date:   Thu,  5 Oct 2023 12:51:28 -0700
Message-Id: <20231005195137.3117166-1-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230929202436.2850388-1-jithu.joseph@intel.com>
References: <20230929202436.2850388-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v4
   Ilpo Järvinen
    - Changed the dev_err/warn printk format specifiers to more
       appropriate ones (patch 5, 6)
    - Add defines for array generation (patch 9)

v3 submission
Link: https://lore.kernel.org/lkml/20230929202436.2850388-1-jithu.joseph@intel.com/

Changes in v3
   Ilpo Järvinen
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
   Ilpo Järvinen
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
 drivers/platform/x86/intel/ifs/ifs.h     |  64 ++++++++-
 include/trace/events/intel_ifs.h         |  16 +--
 drivers/platform/x86/intel/ifs/core.c    |  15 ++-
 drivers/platform/x86/intel/ifs/load.c    | 158 +++++++++++++++++++++--
 drivers/platform/x86/intel/ifs/runtest.c |  72 +++++++++--
 6 files changed, 286 insertions(+), 40 deletions(-)


base-commit: 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa
-- 
2.25.1


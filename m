Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135FB7ABB10
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 23:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjIVVak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 17:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjIVVaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 17:30:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1651BC1;
        Fri, 22 Sep 2023 14:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695418233; x=1726954233;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RtVlxEmwkcaWODCTa9GTXfNYnDKymctU0EiDfOU8ZfY=;
  b=iEuFH0CoxGp4HB0R/gH9QxACf0N6QoMBBJo+Vwdyk1VcF6jXzhFBEI8B
   RIj1YKf8GhxnThjGZ/GQ9jrbBzp+EfJr4sqkdVTXxfs0XbfNAFxV8KsGj
   JaxPFJSG/dRpqBxWhCNB731WHYSV4IumG7JPmhev1sy5o58ABX6pNk1tO
   zQ+qnxrfKcBqDgkEmzKjcMlCksaEzMjVOcAtNlefobJilayyoj2FVeTPS
   I+mNFYcf1QOstxxebvxnYRv9aksm6Ew8L6gF6a3GkHeMMdRd+lK8fwgAz
   TPZHiiqqUHF4N4AJawXcmqrLhVoCmUENewnCH0nalQu6VoX4hv2OZHBkj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="371264685"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="371264685"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 14:30:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="747685305"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="747685305"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 14:30:32 -0700
Received: from debox1-desk4.intel.com (unknown [10.212.188.234])
        by linux.intel.com (Postfix) with ESMTP id 797F2580BBE;
        Fri, 22 Sep 2023 14:30:32 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, david.e.box@linux.intel.com,
        platform-driver-x86@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
        rajvi.jingar@linux.intel.com
Subject: [PATCH 00/11] intel_pmc: Add telemetry API to read counters
Date:   Fri, 22 Sep 2023 14:30:21 -0700
Message-Id: <20230922213032.1770590-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On newer Intel silicon, more IP counters are being added in Intel Platform
Monitoring Technology (PMT) telemetry spaces hosted in MMIO.  There is a
need for the intel_pmc_core driver and other drivers to access PMT hosted
telemetry in the kernel using an API. This patchset adds driver APIs to
allow registering and reading telemetry entries. It makes changes to the
intel_pmc_core driver to use these interfaces to access the low power mode
counters that are now exclusively available from PMT.

David E. Box (6):
  platform/x86/intel/vsec: Add base address field
  platform/x86/intel/pmt: Add header to struct intel_pmt_entry
  platform/x86/intel/pmt: telemetry: Export API to read telemetry
  platform/x86/intel/pmc: Split pmc_core_ssram_get_pmc()
  platform/x86/intel/pmc: Find and register PMC telemetry entries
  platform/x86/intel/pmc: Add debug attribute for Die C6 counter

Gayatri Kammela (1):
  platform/x86/intel/vsec: Add intel_vsec_register

Rajvi Jingar (1):
  platform/x86/intel/pmc: Display LPM requirements for multiple PMCs

Xi Pardee (3):
  platform/x86:intel/pmc: Move get_low_power_modes function
  platform/x86/intel/pmc: Retrieve LPM information using Intel PMT
  platform/x86/intel/pmc: Read low power mode requirements for MTL-M and
    MTL-P

 drivers/platform/x86/intel/pmc/Kconfig      |   1 +
 drivers/platform/x86/intel/pmc/adl.c        |   2 +
 drivers/platform/x86/intel/pmc/cnp.c        |   2 +
 drivers/platform/x86/intel/pmc/core.c       | 191 ++++++++----
 drivers/platform/x86/intel/pmc/core.h       |  10 +-
 drivers/platform/x86/intel/pmc/core_ssram.c | 312 +++++++++++++++++---
 drivers/platform/x86/intel/pmc/icl.c        |  10 +-
 drivers/platform/x86/intel/pmc/mtl.c        |  85 +++++-
 drivers/platform/x86/intel/pmc/spt.c        |  10 +-
 drivers/platform/x86/intel/pmc/tgl.c        |   1 +
 drivers/platform/x86/intel/pmt/class.c      |  43 ++-
 drivers/platform/x86/intel/pmt/class.h      |  30 +-
 drivers/platform/x86/intel/pmt/crashlog.c   |   2 +-
 drivers/platform/x86/intel/pmt/telemetry.c  | 200 ++++++++++++-
 drivers/platform/x86/intel/pmt/telemetry.h  | 129 ++++++++
 drivers/platform/x86/intel/vsec.c           |  68 ++---
 drivers/platform/x86/intel/vsec.h           |  44 ++-
 17 files changed, 961 insertions(+), 179 deletions(-)
 create mode 100644 drivers/platform/x86/intel/pmt/telemetry.h


base-commit: acce85a7dd28eac3858d44230f4c65985d0f271c
-- 
2.34.1


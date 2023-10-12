Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B567C62D8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 04:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376713AbjJLCiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 22:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbjJLCin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 22:38:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6CCA4;
        Wed, 11 Oct 2023 19:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697078321; x=1728614321;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WRppe0i66oHQ5xj9Q8MIDuQJPvcDYMYMD0qk7zkbO/M=;
  b=X05I0tF//c9s7JqXBD1mQ64X0OmsWcegBbT1laPDuzopvnd+h6HEvurV
   9UcQTQh4TVJjX08SQAnzQR1R9rvHb+88kz+Ilq2f1dW7Pu5fwEG6zW8pA
   VlYpE1OV7rnivbW1aokNeHPsDiDzr61aP2Njdm7eyCUzYJIRztz8NmggA
   eBoRGOxkTZ9EHBHk5GzC6yvVlUuSP4TP0ytVieCHFJOCHMhFAENAOtykC
   iSQ2T9XpOE5vRfOMWhZzOJwccqyWUyT003QeavrJ64iEqoNq2ByPqwr7u
   4AGMZwTMESc+00BSzAFRa0eB0mAhUuLXMxItlBSST2M/F4du5kZECxrBp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="3402621"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="3402621"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 19:38:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="783507852"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="783507852"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 19:38:40 -0700
Received: from debox1-desk4.intel.com (unknown [10.209.105.238])
        by linux.intel.com (Postfix) with ESMTP id A4574580D79;
        Wed, 11 Oct 2023 19:38:40 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com
Subject: [PATCH V3 00/16] intel_pmc: Add telemetry API to read counters
Date:   Wed, 11 Oct 2023 19:38:24 -0700
Message-Id: <20231012023840.3845703-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

David E. Box (11):
  platform/x86/intel/vsec: Move structures to header
  platform/x86/intel/vsec: remove platform_info from vsec device
    structure
  platform/x86/intel/vsec: Use cleanup.h
  platform/x86/intel/vsec: Add base address field
  platform/x86/intel/pmt: Add header to struct intel_pmt_entry
  platform/x86/intel/pmt: telemetry: Export API to read telemetry
  platform/x86/intel/pmc: Allow pmc_core_ssram_init to fail
  platform/x86/intel/pmc: Split pmc_core_ssram_get_pmc()
  platform/x86/intel/pmc: Find and register PMC telemetry entries
  platform/x86/intel/pmc: Add debug attribute for Die C6 counter
  platform/x86/intel/pmc: Show Die C6 counter on Meteor Lake

Gayatri Kammela (1):
  platform/x86/intel/vsec: Add intel_vsec_register

Rajvi Jingar (1):
  platform/x86/intel/pmc: Display LPM requirements for multiple PMCs

Xi Pardee (3):
  platform/x86:intel/pmc: Call pmc_get_low_power_modes from platform
    init
  platform/x86/intel/pmc: Retrieve LPM information using Intel PMT
  platform/x86/intel/pmc: Read low power mode requirements for MTL-M and
    MTL-P

 drivers/platform/x86/intel/pmc/Kconfig      |   1 +
 drivers/platform/x86/intel/pmc/adl.c        |   2 +
 drivers/platform/x86/intel/pmc/cnp.c        |   2 +
 drivers/platform/x86/intel/pmc/core.c       | 191 +++++++++----
 drivers/platform/x86/intel/pmc/core.h       |  10 +-
 drivers/platform/x86/intel/pmc/core_ssram.c | 299 +++++++++++++++++---
 drivers/platform/x86/intel/pmc/icl.c        |  10 +-
 drivers/platform/x86/intel/pmc/mtl.c        |  87 +++++-
 drivers/platform/x86/intel/pmc/spt.c        |  10 +-
 drivers/platform/x86/intel/pmc/tgl.c        |   1 +
 drivers/platform/x86/intel/pmt/class.c      |  43 ++-
 drivers/platform/x86/intel/pmt/class.h      |  30 +-
 drivers/platform/x86/intel/pmt/crashlog.c   |   2 +-
 drivers/platform/x86/intel/pmt/telemetry.c  | 193 ++++++++++++-
 drivers/platform/x86/intel/pmt/telemetry.h  | 126 +++++++++
 drivers/platform/x86/intel/vsec.c           |  84 +++---
 drivers/platform/x86/intel/vsec.h           |  44 ++-
 17 files changed, 946 insertions(+), 189 deletions(-)
 create mode 100644 drivers/platform/x86/intel/pmt/telemetry.h


base-commit: acce85a7dd28eac3858d44230f4c65985d0f271c
prerequisite-patch-id: abb063fc6746314786f443484ac711456df3e8a4
-- 
2.34.1


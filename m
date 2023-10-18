Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A98C7CEBAD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 01:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjJRXQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 19:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjJRXQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 19:16:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330A3111;
        Wed, 18 Oct 2023 16:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697670985; x=1729206985;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rZatTB+1jNamJ3WtWSkSc/lrxyn+zX3WBu9B82X0GL4=;
  b=TZTw7ZTGpDHhctMYkR9Ntq+A9hlbbjyzwsvX4Di8PR4Jf7Th06IY9yBU
   PSAXwH6MRVemMikmSaroU6b9yL2Qlq3UP6fU0QQ1IVDz/PHv6p3WYmsNW
   67muXNmBr77aoK32oGgJFZjOJnNsZcGXzakdbZIrquc44crdCqHmEDo2i
   ecR5BY9DC1iVwKzCjBNF8nHHisAM2X5xZD0mnjql/gQ9ANPkg/xEq+hPv
   jfbBh/YUelVFmxB42w8HOvOpVhmR+BAlr+MpOniH5eqYvuhJBIJGk08dC
   pvpFjLOgt89BYxTShL33yejVuNzKG//Zhj6uZKJMNMe8AkqGy4CseJGiA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="385013039"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="385013039"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 16:16:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="4730725"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 16:16:28 -0700
Received: from debox1-desk4.lan (unknown [10.209.71.91])
        by linux.intel.com (Postfix) with ESMTP id 985AD580DD0;
        Wed, 18 Oct 2023 16:16:24 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com
Subject: [PATCH V4 00/17] intel_pmc: Add telemetry API to read counters
Date:   Wed, 18 Oct 2023 16:16:07 -0700
Message-Id: <20231018231624.1044633-1-david.e.box@linux.intel.com>
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

David E. Box (12):
  platform/x86/intel/vsec: Move structures to header
  platform/x86/intel/vsec: remove platform_info from vsec device
    structure
  platform/x86/intel/vsec: Use cleanup.h
  platform/x86/intel/vsec: Add base address field
  platform/x86/intel/pmt: Add header to struct intel_pmt_entry
  platform/x86/intel/pmt: telemetry: Export API to read telemetry
  platform/x86/intel/pmc: Allow pmc_core_ssram_init to fail
  linux/io.h: iounmap/ioport_unmap cleanup.h support
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
 drivers/platform/x86/intel/pmc/core_ssram.c | 297 +++++++++++++++++---
 drivers/platform/x86/intel/pmc/icl.c        |  10 +-
 drivers/platform/x86/intel/pmc/mtl.c        |  87 +++++-
 drivers/platform/x86/intel/pmc/spt.c        |  10 +-
 drivers/platform/x86/intel/pmc/tgl.c        |   1 +
 drivers/platform/x86/intel/pmt/class.c      |  43 ++-
 drivers/platform/x86/intel/pmt/class.h      |  30 +-
 drivers/platform/x86/intel/pmt/crashlog.c   |   2 +-
 drivers/platform/x86/intel/pmt/telemetry.c  | 193 ++++++++++++-
 drivers/platform/x86/intel/pmt/telemetry.h  | 126 +++++++++
 drivers/platform/x86/intel/vsec.c           |  85 +++---
 drivers/platform/x86/intel/vsec.h           |  44 ++-
 include/linux/io.h                          |   4 +
 18 files changed, 949 insertions(+), 189 deletions(-)
 create mode 100644 drivers/platform/x86/intel/pmt/telemetry.h


base-commit: 3f720b21ec5af466e50e99dc517af267b67d248c
-- 
2.34.1


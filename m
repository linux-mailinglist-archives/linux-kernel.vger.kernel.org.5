Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFF578BC16
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 02:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbjH2AYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 20:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbjH2AXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 20:23:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3574F107;
        Mon, 28 Aug 2023 17:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693268628; x=1724804628;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hFydJnI+CKQfNJv0VsuN7MM0FGUdBjbAEGTHSs6tld0=;
  b=E8a9aWy19+Y3URpLBmJ498e2+eR2IBFlyeh46EMRHCdhi/qvDSBUeMle
   PphoC8Ga7yBlsGGFugF7wwIl3/FBzh7V6Q0mSkeJLgUPnJCMdeaEkp0aA
   TUVtlsesazbdWFKVAI6vsA4b5zI4Y7L0MHn4jJT46oHRzLLNSKNVC2BLZ
   oafcYI/PhMjV6kZgCOMkersHtNk1v7526gWFhuSlV1ofyijsjnBjn+yXa
   PEIInDFtvWT7nDjgCPtnFN2D8r760wSrI46MMSTOF4aab3A8peikf90oA
   32DbsPvV62Gi6iLE9hxRotmrwJBwCoFaAnoXg8jVRUDlc9BN82eHZ88Bq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="354754211"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="354754211"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 17:23:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="731989678"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="731989678"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by orsmga007.jf.intel.com with ESMTP; 28 Aug 2023 17:23:47 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 0/7] thermal: processor_thermal: Suport workload hint
Date:   Mon, 28 Aug 2023 17:23:39 -0700
Message-Id: <20230829002346.2104251-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
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

Add support for Meteor Lake workload hints. Before adding this support,
some reorganization and clean up is required.
First four changes are for clean up and to reorganize code to add
support for workload hint. The last patch adds a test program as part
of self tests.

v3:
Changes in the commit log
Rename of files for using WT instead of WLT
Address comments from Rafael on v2

v2:
Changes in comments and commit log
Self test program is improved to disable workloadtype notification
on exit

Srinivas Pandruvada (7):
  thermal: int340x: processor_thermal: Move mailbox code to common
    module
  thermal: int340x: processor_thermal: Add interrupt configuration
  thermal: int340x: processor_thermal: Use non MSI interrupts by default
  thermal/drivers/int340x: Remove PROC_THERMAL_FEATURE_WLT_REQ for
    Meteor Lake
  thermal: int340x: processor_thermal: Add workload type hint interface
  thermal/drivers/int340x: Support workload hint interrupts
  selftests/thermel/intel: Add test to read workload hint

 .../driver-api/thermal/intel_dptf.rst         |  51 ++++
 .../thermal/intel/int340x_thermal/Makefile    |   2 +
 .../processor_thermal_device.c                |  17 +-
 .../processor_thermal_device.h                |  21 +-
 .../processor_thermal_device_pci.c            |  79 ++++--
 .../processor_thermal_device_pci_legacy.c     |   3 +-
 .../int340x_thermal/processor_thermal_mbox.c  | 179 ++++---------
 .../processor_thermal_wt_hint.c               | 252 ++++++++++++++++++
 .../processor_thermal_wt_req.c                | 136 ++++++++++
 tools/testing/selftests/Makefile              |   1 +
 .../thermal/intel/workload_hint/Makefile      |  12 +
 .../intel/workload_hint/workload_hint_test.c  | 157 +++++++++++
 12 files changed, 752 insertions(+), 158 deletions(-)
 create mode 100644 drivers/thermal/intel/int340x_thermal/processor_thermal_wt_hint.c
 create mode 100644 drivers/thermal/intel/int340x_thermal/processor_thermal_wt_req.c
 create mode 100644 tools/testing/selftests/thermal/intel/workload_hint/Makefile
 create mode 100644 tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c

-- 
2.40.1


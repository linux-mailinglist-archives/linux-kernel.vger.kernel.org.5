Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E07756DB2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjGQTyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjGQTyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:54:07 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A68D129;
        Mon, 17 Jul 2023 12:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689623647; x=1721159647;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=55+F8jOsHvNsY85Vpz2l3HY0qmMTBWxPg4dFVbT6WT8=;
  b=fG3cDEufTzdFoM1mrxgMX02k2YdKeAMu1SwHudClO3uPskpx8deREAOQ
   2Hget0Yto9rpPyIZVgubfzsLypQFebiTdxlF0pP5iAnSZqbqnDYXZiE8P
   9gAxkhCfH40oPB2vJdQdsQCU4bK91N/7oGaTVsd77a2s+ID4Hy4YOKZjR
   VdUEIEQQ9Q5IpgbL14fuJNHxFEH2beqXlKuDOinEx9zH2v4oVfW3Vz/+b
   OrKPQ4gA2YoVwJ/RFwYq3WZaHOUBs/B1yAporkMTjQ9mk0wxFDeFMjSYB
   2VSNFTpYDyUpfDGysHATfA+TimgrZ2Pey2nK32ain/O5IO8+CtNRAd8It
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="366064449"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="366064449"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 12:54:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="788770692"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="788770692"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga008.fm.intel.com with ESMTP; 17 Jul 2023 12:54:06 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 0/7] thermal: processor_thermal: Suport workload hint
Date:   Mon, 17 Jul 2023 12:53:58 -0700
Message-Id: <20230717195405.730869-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
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

Add support for Meteor Lake workload hints. Before adding this support,
some reorganization and clean up is required.
First four changes are for clean up and to reorganize code to add
support for workload hint. The last patch adds a test program as part
of self tests.

v2:
Changes in comments and commit log
Self test program is improved to disable workloadtype notification
on exit

Srinivas Pandruvada (7):
  thermal: int340x: processor_thermal: Move mailbox code to common
    module
  thermal: int340x: processor_thermal: Add interrupt configuration
  thermal: int340x: processor_thermal: Use non MSI interrupts
  thermal/drivers/int340x: Remove PROC_THERMAL_FEATURE_WLT_REQ for
    Meteor Lake
  thermal: int340x: processor_thermal: Add workload type hint
  thermal/drivers/int340x: Support workload hint interrupts
  selftests/thermel/intel: Add test to read workload hint

 .../driver-api/thermal/intel_dptf.rst         |  38 +++
 .../thermal/intel/int340x_thermal/Makefile    |   2 +
 .../processor_thermal_device.c                |  17 +-
 .../processor_thermal_device.h                |  21 +-
 .../processor_thermal_device_pci.c            |  76 ++++--
 .../processor_thermal_device_pci_legacy.c     |   3 +-
 .../int340x_thermal/processor_thermal_mbox.c  | 179 ++++---------
 .../processor_thermal_wlt_hint.c              | 238 ++++++++++++++++++
 .../processor_thermal_wlt_req.c               | 136 ++++++++++
 tools/testing/selftests/Makefile              |   1 +
 .../thermal/intel/workload_hint/Makefile      |  12 +
 .../intel/workload_hint/workload_hint_test.c  | 157 ++++++++++++
 12 files changed, 718 insertions(+), 162 deletions(-)
 create mode 100644 drivers/thermal/intel/int340x_thermal/processor_thermal_wlt_hint.c
 create mode 100644 drivers/thermal/intel/int340x_thermal/processor_thermal_wlt_req.c
 create mode 100644 tools/testing/selftests/thermal/intel/workload_hint/Makefile
 create mode 100644 tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c

-- 
2.38.1


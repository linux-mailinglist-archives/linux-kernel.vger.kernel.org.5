Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FBC7FC3CA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346502AbjK1S4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 13:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345719AbjK1S4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 13:56:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B29410C1;
        Tue, 28 Nov 2023 10:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701197797; x=1732733797;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SKWRFSAvHQiILnXdmSeYIzw8dazAB7XEhCo2n8N+zzs=;
  b=TDCAdM9cR2R/MiRAs5ONUtiGUq8Cdta9Z2Xy3QWJb2WRuI1Ej3TTC7Ws
   3qkm7U9htu0Io+q8rOkpfkjycOKF4wrXmVg7fokYB70XQ+aZmiEI05ks3
   khS/KOs73gTuf5586dJT7sSQYe8TpdtdW22iy+FxZbzcsbW1t6FPeQiv6
   gnqk14344wDDt4LPdXfOdXjRuR/+ke7B+KhrUCPY1IKZ1mVDaxmM3uZnP
   E1c0owu6pqE96jzgggpCGQh1yXZ6kHg11AvO7Iq4fb0Fih/DvRVCs5fik
   XIk6d9o3MIgLEA1dSwL52uYlwjAZmZLdtv+kQ5mijHzeQOeT6hoVySwvK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="372366942"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="372366942"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 10:56:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="892165779"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="892165779"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by orsmga004.jf.intel.com with ESMTP; 28 Nov 2023 10:56:10 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/6] TPMI update for new defines and permissions
Date:   Tue, 28 Nov 2023 10:55:59 -0800
Message-Id: <20231128185605.3027653-1-srinivas.pandruvada@linux.intel.com>
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

Add TPMI information header version 2 fields. Also process read/write
 and enabled state for feature drivers. When a feature is disabled,
don't create a device to load a feature driver. When a read is blocked
then don't load feature drivers. When write is blocked continue to
function in read only mode.

Srinivas Pandruvada (6):
  platform/x86/intel/tpmi: Add additional TPMI header fields
  platform/x86/intel/tpmi: Don't create devices for disabled features
  platform/x86/intel/tpmi: Modify external interface to get read/write
    state
  platform/x86/intel/tpmi: Move TPMI ID definition
  platform/x86: ISST: Process read/write blocked feature status
  platform/x86/intel-uncore-freq: Process read/write blocked feature
    status

 .../intel/speed_select_if/isst_tpmi_core.c    | 25 +++++++++++
 drivers/platform/x86/intel/tpmi.c             | 42 ++++++++++---------
 .../uncore-frequency/uncore-frequency-tpmi.c  | 15 +++++++
 include/linux/intel_tpmi.h                    | 24 +++++++++--
 4 files changed, 84 insertions(+), 22 deletions(-)

-- 
2.41.0


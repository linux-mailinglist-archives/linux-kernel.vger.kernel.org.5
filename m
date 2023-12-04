Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1D380417C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 23:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbjLDWRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 17:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjLDWRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 17:17:40 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3873CCB;
        Mon,  4 Dec 2023 14:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701728267; x=1733264267;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Tg0LEBGOEm/+i42KJEjRQlUI2AXRIDHLFhFUEf1e68M=;
  b=PpRnePzwbdnB3jxLxYxpmhBu0ca7XcruEchamahUiPUzb/d+MsHC5XQZ
   Jp3BgI1PhaAY3P8iLt/HpYf7DnpecZp4rppIL+33SJr0xGAj2Pi5Jrtt7
   Z7sVIp9js9Xo0+KBhd92gvj39uiUC24yTGYXIOhVhFK0XAJOhkcMYDwmD
   nC4kcLkN+8O4+IlGYSJcKTjT28ti7W0SEyJlUkjpaFEcHcbJQCL5bxjOe
   tl1mAmqVGjhSxPzDSiH5tlqE1di3ZFWguQ/NhY7dpOphELQWMJgzgZ/ee
   3iTl+pLGIdfxLwic8DCjrzrtQXQhG/ytzAEopWPYDSEDx/3+q+8yojtZD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="480000868"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="480000868"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 14:17:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="764111950"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="764111950"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by orsmga007.jf.intel.com with ESMTP; 04 Dec 2023 14:17:46 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 0/5] TPMI update for permissions
Date:   Mon,  4 Dec 2023 14:17:35 -0800
Message-Id: <20231204221740.3645130-1-srinivas.pandruvada@linux.intel.com>
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

v3:
	No code change. Rebased on top of 
https://kernel.googlesource.com/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86 review-hans

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
2.40.1


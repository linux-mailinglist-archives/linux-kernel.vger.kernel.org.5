Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B687A9E08
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjIUTxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjIUTxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:53:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104E290F02
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695318438; x=1726854438;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t2mbJ75fInyWH5iiLT8RC4XEZIKGqU0/wfgMAXYwMVw=;
  b=GPNDU+yDyxyCruBmXr3xug8yEt4aYS5URIAZ+vvRAV/CtVa2majbFmvv
   oaQycsKpveTcBXywsxeVBGafjzdxqicn0eI3oh5jb0jo6IPymprFX7iMz
   T59AroS3QW+F2RSsVcqiAN9IgPi2sQMBAtci+rxFa271zVlxCqY3vgnLU
   RSAPzUbkQfsdJN0ZNhKWE799FMwk2+Ze/O9qho7tNAKdGRNbCXW/Y3PSI
   lVFFT7NVV0yi8t3Kin1B2huDpO0Q/yIoloux1OKSJlWUqT4eQxpnni5yH
   9dvAdUNnjPaySpVjK1qj9MwH9mpUT+sR0VsC0pBJsMBoKxD2/nSsHzQyA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="377729731"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="377729731"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 23:29:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="920606306"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="920606306"
Received: from sunyi-station.sh.intel.com (HELO ysun46-mobl.sh.intel.com) ([10.239.159.10])
  by orsmga005.jf.intel.com with ESMTP; 20 Sep 2023 23:29:50 -0700
From:   Yi Sun <yi.sun@intel.com>
To:     dave.hansen@intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     sohil.mehta@intel.com, ak@linux.intel.com,
        ilpo.jarvinen@linux.intel.com, heng.su@intel.com,
        tony.luck@intel.com, yi.sun@linux.intel.com, yu.c.chen@intel.com,
        Yi Sun <yi.sun@intel.com>
Subject: [PATCH v7 0/3] x86/fpu Measure the Latency of XSAVES and XRSTORS
Date:   Thu, 21 Sep 2023 14:28:57 +0800
Message-Id: <20230921062900.864679-1-yi.sun@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements a solution for measuring the latency of
XSAVES/XRSTORS instructions on x86 processors. The motivation for This
solution is to provide a way to identify potential bottlenecks and
anomalies in the implementation of these instructions on different X86
hardware platforms and identify when the cost of XSAVES/XRSTORS is
increasing or decreasing. And Get the RFBM and XINUSE to figure out reason
if there are any issues.

The solution enables the comparison of the latency of the FPU across
different systems from various vendors over an long period of time.

The solution consists of two parts:
1. Two new tracepoints that calculate delta TSC as the latency.
2. A user-space tool that consumes trace logs and shows results.

We conducted extensive internal testing and compared several latency
computation methodologies. We believe it could be improved. Also the script
for consuming trace logs uses sqlite3 to display statistics data such as
max and min latency, and 97% tail latency, etc.

- Change from v6 to v7:
  - Rebase patch to the most recent tag v6.6-rc1, no conflict.
  - Remove all the additional crusts when disable CONFIG_X86_DEBUG_FPU.
    (Ingo Molnar)

- Change from v5 to v6:
  - Rebase patch to the most recent tag v6.5-rc7, no conflict.
  - Add a colomn 'count' to the output of the script.

- Change from v4 to v5:
  - Rebase patch to the most recent tag v6.1-rc2, no conflict.

- Change from v3 to v4:
  - Rebase patch set to the latest tag v6.0-rc3, replacing
    ALTERNATIVE_2 with ALTERNATIVE_3

- Change from v2 to v3:
  - Move the script xsave-latency-trace.sh to folder tools/testing/fpu/
    (Ingo Molnar)

- Change from v1 to v2:
  - Reword the comments. (Laight, David; Mehta, Sohil)
  - Rename all variable 'dtsc' to 'latency'. (Mehta, Sohil)

*** BLURB HERE ***

Yi Sun (3):
  x86/fpu: Measure the Latency of XSAVE and XRSTOR
  tools/testing/fpu: Add script to consume trace log of xsave latency
  tools/testing/fpu: Add a 'count' column.

 arch/x86/include/asm/trace/fpu.h         |  37 ++++
 arch/x86/kernel/fpu/xstate.h             |  42 +++-
 tools/testing/fpu/xsave-latency-trace.sh | 234 +++++++++++++++++++++++
 3 files changed, 308 insertions(+), 5 deletions(-)
 create mode 100755 tools/testing/fpu/xsave-latency-trace.sh

-- 
2.34.1

From d9f24eb83ef259ccea780caee02abdd2db5911b5 Mon Sep 17 00:00:00 2001
From: Yi Sun <yi.sun@intel.com>
Date: Fri, 1 Sep 2023 20:05:01 +0800
Yi Sun (3):
  x86/fpu: Measure the Latency of XSAVE and XRSTOR
  tools/testing/fpu: Add script to consume trace log of xsave latency
  tools/testing/fpu: Add a 'count' column.

 arch/x86/include/asm/trace/fpu.h         |  35 ++++
 arch/x86/kernel/fpu/xstate.h             |  49 ++++-
 tools/testing/fpu/xsave-latency-trace.sh | 234 +++++++++++++++++++++++
 3 files changed, 313 insertions(+), 5 deletions(-)
 create mode 100755 tools/testing/fpu/xsave-latency-trace.sh

-- 
2.34.1


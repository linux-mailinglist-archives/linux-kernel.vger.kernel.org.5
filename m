Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F327878FF45
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 16:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350020AbjIAOfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 10:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbjIAOfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 10:35:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9ECB9
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 07:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693578908; x=1725114908;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CpTaeIf9d8VZqYE33on/+IIXfEiW3d3/Kh4IyD8hjYY=;
  b=cTK3gpxrklVLgj1WHlTXP5kgA11xN266xM1mqjKKZRb5Pb6CdvG3f/zP
   EcQCHoO6DPw6hd1P7Rg2bVV1+IPjdBpUN2H+fISLoNWZv5DB4JOuVsZZv
   tnwd9Ge25kWfYA6pB2W1q/6a1GDKgJvN/KG2PhkJen9s4L026UQGVQu2y
   4KfzVtHtE0jnXqQlhLHboqK7YM6zbRiHrwEyGzqaYln2LWPw2kF34SBLz
   5kqT/Tuk/UOydTHjyMPVjxeWCYm6ewb3xM1x4idOJHy+cwrzbzaOwcPJ4
   /Cs/9rUwCCTJJ4H63ob2rdQKTRxPP6d2JsO5ZzBUCu/gPx2apo8TyGuM/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="373627530"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="373627530"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 07:35:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="805450032"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="805450032"
Received: from sunyi-station.sh.intel.com (HELO ysun46-mobl.sh.intel.com) ([10.239.159.10])
  by fmsmga008.fm.intel.com with ESMTP; 01 Sep 2023 07:34:56 -0700
From:   Yi Sun <yi.sun@intel.com>
To:     dave.hansen@intel.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     sohil.mehta@intel.com, ak@linux.intel.com,
        ilpo.jarvinen@linux.intel.com, heng.su@intel.com,
        tony.luck@intel.com, dave.hansen@linux.intel.com,
        yi.sun@intel.intel.com, Yi Sun <yi.sun@intel.com>
Subject: [PATCH v6 0/3] x86/fpu Measure the Latency of XSAVES and
Date:   Fri,  1 Sep 2023 22:34:11 +0800
Message-Id: <20230901143414.1664368-1-yi.sun@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

The solution consists of two parts:
1. Two new tracepoints that calculate delta TSC as the latency.
2. A user-space tool that consumes trace logs and shows results.

We conducted extensive internal testing and compared several latency
computation methodologies. We believe it could be improved. Also the script
for consuming trace logs uses sqlite3 to display statistics data such as
max and min latency, and 97% tail latency, etc.

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


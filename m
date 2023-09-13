Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A1179F131
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjIMSiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjIMSh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:37:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B03CA3;
        Wed, 13 Sep 2023 11:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694630274; x=1726166274;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=m9uEFh1PK56Z7q+u6kDbQXw+ZQrWKN8Nj13N/OIjzBY=;
  b=LFjoIi0OjzDAthx7SjkiIoqaiYawOpx4ea6k200ncvS1DQ4SYjbkzqxc
   ydRdVwDTGFby8dqyZSR8Q9k5om/Ai04HYqphv8NAdYtDF47Ebo0/cxNQi
   oCHtXOImJ6Jo5pgzjRiAhlOdgfCHDrQuEMsMFmHjbSKpyrb7YPlGAYjhH
   s8Zjq3TYDqokXKsOC76ZrBcxvOcBjnwFBZmLYg1IEy6IFzKbuUuRgy/9i
   x9OHR5wvrHBCZT/VZe54k2zwLKJ8AcLDs8Tl0/T6A+PN0WF5tW3YS/uln
   oti2sL9YSy9l7EU4RBQw87DoansUkMvJwF5UCDr7MlZssgHiPJHGoh7Ld
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="369019101"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="369019101"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 11:37:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="744238572"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="744238572"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 11:37:53 -0700
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        rostedt@goodmis.org, jithu.joseph@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, pengfei.xu@intel.com
Subject: [PATCH 00/10] IFS support for GNR and SRF
Date:   Wed, 13 Sep 2023 11:33:38 -0700
Message-Id: <20230913183348.1349409-1-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds IFS support for newer CPUs like Granite Rapids(GNR)
and Sierra Forest(SRF).

There are changes in the IFS image loading and test flow to support
these new CPUs.

Note to reviewers:
 - patch 01/10 adds a bit definition to arch/x86/.../msr-index.h,
  hence x86 maintainers are cc-d.
 - patch 05/10 modifies an existing tracepoint, cc Steven Rostedt
 - Rest are localized to IFS driver

Jithu Joseph (10):
  platform/x86/intel/ifs: Store IFS generation number
  platform/x86/intel/ifs: Refactor image loading code
  platform/x86/intel/ifs: Image loading for new generations
  platform/x86/intel/ifs: Scan test for new generations
  trace: platform/x86/intel/ifs: Modify scan trace
  platform/x86/intel/ifs: Validate image size
  platform/x86/intel/ifs: Metadata validation for start_chunk
  platform/x86/intel/ifs: Add new CPU support
  platform/x86/intel/ifs: Add new error code
  platform/x86/intel/ifs: ARRAY BIST for Sierra Forest

 arch/x86/include/asm/msr-index.h         |   2 +
 drivers/platform/x86/intel/ifs/ifs.h     |  47 +++++++
 include/trace/events/intel_ifs.h         |  16 +--
 drivers/platform/x86/intel/ifs/core.c    |  14 +-
 drivers/platform/x86/intel/ifs/load.c    | 159 +++++++++++++++++++++--
 drivers/platform/x86/intel/ifs/runtest.c |  68 +++++++++-
 6 files changed, 273 insertions(+), 33 deletions(-)


base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
-- 
2.25.1


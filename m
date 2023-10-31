Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2F27DC94F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343854AbjJaJVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343834AbjJaJVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:21:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD9CDA;
        Tue, 31 Oct 2023 02:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698744110; x=1730280110;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y4GdVfvr4r3TS2jPrXzPuftPnG1qKJX1nHclPM7uF4Y=;
  b=B8h1ZqJ5LJ0kXzUMbyieDxzE9uMPKbngWyyUyqaj7szBaKtFugZH9mWO
   GemQSRSQ+SeK+sIunqhrZdDfZboNE+D8NWuY1cMzyFu0AWA3P++XJ3Vem
   53rVh1A8d0fo57ASxEFGTg8G/+5X6MRfH+jWsQr9TsdiFuu7EznvyuSUb
   IyWwjruBB615rYVFCWqk+DIXDrayEqYIT3K1GJJOMrlSVfDQ3fh/MHgXZ
   loOY7HHRT3qZCAFeFd7ZKSHqjY/aTqd3u/QaUH9Aea67ZtA7NZ2J1aDkU
   MG78U9iNpoHej9IT3hzbuHdu2qOWO+0zY7YeGj+H6fHQAJGps3+q7wpTm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="385435956"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="385435956"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 02:21:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="877445519"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="877445519"
Received: from dmi-pnp-i7.sh.intel.com ([10.239.159.155])
  by fmsmga002.fm.intel.com with ESMTP; 31 Oct 2023 02:21:47 -0700
From:   Dapeng Mi <dapeng1.mi@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhang Xiong <xiong.y.zhang@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Dapeng Mi <dapeng1.mi@intel.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [kvm-unit-tests Patch v2 1/5] x86: pmu: Remove duplicate code in pmu_init()
Date:   Tue, 31 Oct 2023 17:29:17 +0800
Message-Id: <20231031092921.2885109-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031092921.2885109-1-dapeng1.mi@linux.intel.com>
References: <20231031092921.2885109-1-dapeng1.mi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiong Zhang <xiong.y.zhang@intel.com>

There are totally same code in pmu_init() helper, remove the duplicate
code.

Signed-off-by: Xiong Zhang <xiong.y.zhang@intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 lib/x86/pmu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/lib/x86/pmu.c b/lib/x86/pmu.c
index 0f2afd650bc9..d06e94553024 100644
--- a/lib/x86/pmu.c
+++ b/lib/x86/pmu.c
@@ -16,11 +16,6 @@ void pmu_init(void)
 			pmu.fixed_counter_width = (cpuid_10.d >> 5) & 0xff;
 		}
 
-		if (pmu.version > 1) {
-			pmu.nr_fixed_counters = cpuid_10.d & 0x1f;
-			pmu.fixed_counter_width = (cpuid_10.d >> 5) & 0xff;
-		}
-
 		pmu.nr_gp_counters = (cpuid_10.a >> 8) & 0xff;
 		pmu.gp_counter_width = (cpuid_10.a >> 16) & 0xff;
 		pmu.gp_counter_mask_length = (cpuid_10.a >> 24) & 0xff;
-- 
2.34.1


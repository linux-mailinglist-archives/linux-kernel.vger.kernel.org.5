Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530637DC958
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343873AbjJaJWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343890AbjJaJWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:22:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16ACB7;
        Tue, 31 Oct 2023 02:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698744121; x=1730280121;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PuCRcyvXo/0paorC4geEOaVKWI0b7CqKhedXiIXoy0A=;
  b=KNM+3pQnGpmUUNQuHOdJcxhEJDaYVJgfWRz9AWWnmosWzV4A0ehXWcI/
   lTcQ7n0+M5pnMKJBkf7mAKGCvzPElMZkNpf5A9oZyhQsxywtri3MP8CXR
   k+90mWDkWu3TC4irj/W8bzCV+I2k/DHt5GPwcdHwI79hTSZAfusPp/HyN
   PW/VWy8IGJjj6uj0A3mLEhTsllOP8qkA/F5oCa4zIVLB4aeMhtaNtTJMv
   ER38hCNC5tuW4J9Vl35gLh/DUYqMexeTcluHlsSHkjBrOuOgz7f7D9ZQX
   u5wKjKuiKo+1MBhBytx85ub/awqH/MP194ZIgD+flMns1Ibf4ouBRS9Rl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="385435997"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="385435997"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 02:22:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="877445536"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="877445536"
Received: from dmi-pnp-i7.sh.intel.com ([10.239.159.155])
  by fmsmga002.fm.intel.com with ESMTP; 31 Oct 2023 02:21:58 -0700
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
Subject: [kvm-unit-tests Patch v2 5/5] x86: pmu: Add asserts to warn inconsistent fixed events and counters
Date:   Tue, 31 Oct 2023 17:29:21 +0800
Message-Id: <20231031092921.2885109-6-dapeng1.mi@linux.intel.com>
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

Current PMU code doesn't check whether the number of fixed counters is
larger than pre-defined fixed events. If so, it would cause out of range
memory access.

So add asserts to warn this invalid case.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 x86/pmu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/x86/pmu.c b/x86/pmu.c
index 404dc7b62ac2..3ce05f0a1d38 100644
--- a/x86/pmu.c
+++ b/x86/pmu.c
@@ -117,8 +117,12 @@ static struct pmu_event* get_counter_event(pmu_counter_t *cnt)
 		for (i = 0; i < gp_events_size; i++)
 			if (gp_events[i].unit_sel == (cnt->config & 0xffff))
 				return &gp_events[i];
-	} else
-		return &fixed_events[cnt->ctr - MSR_CORE_PERF_FIXED_CTR0];
+	} else {
+		int idx = cnt->ctr - MSR_CORE_PERF_FIXED_CTR0;
+
+		assert(idx < ARRAY_SIZE(fixed_events));
+		return &fixed_events[idx];
+	}
 
 	return (void*)0;
 }
@@ -251,6 +255,7 @@ static void check_fixed_counters(void)
 	};
 	int i;
 
+	assert(pmu.nr_fixed_counters <= ARRAY_SIZE(fixed_events));
 	for (i = 0; i < pmu.nr_fixed_counters; i++) {
 		cnt.ctr = fixed_events[i].unit_sel;
 		measure_one(&cnt);
@@ -272,6 +277,7 @@ static void check_counters_many(void)
 			gp_events[i % gp_events_size].unit_sel;
 		n++;
 	}
+	assert(pmu.nr_fixed_counters <= ARRAY_SIZE(fixed_events));
 	for (i = 0; i < pmu.nr_fixed_counters; i++) {
 		cnt[n].ctr = fixed_events[i].unit_sel;
 		cnt[n].config = EVNTSEL_OS | EVNTSEL_USR;
-- 
2.34.1


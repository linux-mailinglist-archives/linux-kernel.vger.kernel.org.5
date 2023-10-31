Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAFC7DC952
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343868AbjJaJWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343853AbjJaJV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:21:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA494F5;
        Tue, 31 Oct 2023 02:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698744115; x=1730280115;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UFdm8PB2RMdMC4FZjkejhXgoSvo9XB2tTzL2mbbsxug=;
  b=iWx4M9u/9A9OWr3wBgyb7kE2Du0NZCDOL0eH9IQaQpiwvTtQuXt6m36Q
   CSWkZWhJtmKfyZBybPIV/3riyz0IXZQqxL7fE1VnAgjX9lNEjpsra0w7u
   pKzGtHjCTjfKySWSs6wimh5WkeJ61bydumltAL4YKhs91cUwlpLrvVsBI
   05APr/LxjkdaJ5DexTyrCFVKkbiZNDLHCWW9QhuhfsDxD3QQVOy9ko8N8
   AJGlKmPFWxAHCu3fIMsKHBTvtFiG89ygXTZXDanuycdJo+VIhXrQOgjju
   7N58szOrVQf+rz3GRBj7VV+CgbRCDFvtRUSE7yXvfjAp68WZOelLyj9u1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="385435973"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="385435973"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 02:21:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="877445527"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="877445527"
Received: from dmi-pnp-i7.sh.intel.com ([10.239.159.155])
  by fmsmga002.fm.intel.com with ESMTP; 31 Oct 2023 02:21:53 -0700
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
Subject: [kvm-unit-tests Patch v2 3/5] x86: pmu: Enlarge cnt array length to 64 in check_counters_many()
Date:   Tue, 31 Oct 2023 17:29:19 +0800
Message-Id: <20231031092921.2885109-4-dapeng1.mi@linux.intel.com>
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

Considering there are already 8 GP counters and 4 fixed counters on
latest Intel CPUs, like Sapphire Rapids. The original cnt array length
10 is definitely not enough to cover all supported PMU counters on these
new CPUs and it would cause PMU counter validation failures.

It's probably more and more GP and fixed counters are introduced in the
future and then directly extends the cnt array length to 64.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 x86/pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/x86/pmu.c b/x86/pmu.c
index 1df5794b7ef8..6bd8f6d53f55 100644
--- a/x86/pmu.c
+++ b/x86/pmu.c
@@ -259,7 +259,7 @@ static void check_fixed_counters(void)
 
 static void check_counters_many(void)
 {
-	pmu_counter_t cnt[10];
+	pmu_counter_t cnt[64];
 	int i, n;
 
 	for (i = 0, n = 0; n < pmu.nr_gp_counters; i++) {
-- 
2.34.1


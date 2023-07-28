Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB086767119
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236511AbjG1Pxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236715AbjG1PxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:53:25 -0400
Received: from mgamail.intel.com (unknown [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411612680
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 08:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690559603; x=1722095603;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9MLFJ14ijpn8+9hs8W7sJ7ua9nY6RecBljF6xr+nimI=;
  b=hunCbdeW9pVgHVve+L+wHWNcXPSuj8Ht8G79i18qkXRHSvlYXNQJKCh8
   UvmLqoaA8l8t7B/x4GvMUgd93jwtO60gZCocR2TaqzHkULCDt674TCOkQ
   2iJUexuYjIO0XOwwfiesos6Q+Tnci8/PavFamZCg9M8ewfQEhxXneydz8
   ro2y4HzyX2ECGim/77vKyhYdehOdBSUt7C3cSnW34upcdR6RXOTKeBiQo
   UZgUjFVfYC31wDwHpvq6bbo/RgD9EEi+50jSVfeCaaRKezUwFQJHV07Af
   KnVCQGD27V87Qvr3uVcnGa8DZD9IBoEQrl3SLt2Mv1s/OdyMqOqOR6US4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="348911586"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="348911586"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 08:53:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="870909211"
Received: from jiaweicu-mobl1.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.249.175.158])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 08:53:23 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     tglx@linutronix.de, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, vkuznets@redhat.com
Subject: [PATCH V2] cpu/SMT: Fix cpu_smt_possible() comment
Date:   Fri, 28 Jul 2023 23:53:13 +0800
Message-Id: <20230728155313.44170-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e1572f1d08be ("cpu/SMT: create and export cpu_smt_possible()")
introduces cpu_smt_possible() to represent if SMT is theoretically
possible. It returns true when SMT is supported and not forcefully
disabled ('nosmt=force'). But the comment of it says "Returns true if
SMT is not supported of forcefully (irreversibly) disabled", which is
wrong. Fix that comment accordingly.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
Changes since V1
 - rephrase the changelog
---
 kernel/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 88a7ede322bd..050dda751fc3 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -642,7 +642,7 @@ static inline bool cpu_smt_allowed(unsigned int cpu)
 	return !cpumask_test_cpu(cpu, &cpus_booted_once_mask);
 }
 
-/* Returns true if SMT is not supported of forcefully (irreversibly) disabled */
+/* Returns true if SMT is supported and not forcefully (irreversibly) disabled */
 bool cpu_smt_possible(void)
 {
 	return cpu_smt_control != CPU_SMT_FORCE_DISABLED &&
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939777B0C34
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 20:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjI0Swe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 14:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI0Swc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 14:52:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31CEE6;
        Wed, 27 Sep 2023 11:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695840751; x=1727376751;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MQ0uyvyitsUR5wpJxHzYcH82109tYU4SRG/CvaLk8sQ=;
  b=NcwWnc/uR0AdrjhhF1+mpQuSsVfeRSzcOWTVUu+NMflN3Prn/aqdggNU
   rZkcGMnzZ9Qo5GFWmLx6oeH3CYH4AYIGxATC/mRvsEjZCK8R/CdQYsCdM
   KGkpv6e42xVx2MZhv3NagMVNEjJu1xZDSXRnaePzBj+qKPKYFxFf9X+IR
   vNJxMeJKGOIOF8Xc4eYR8c+rwubuWwPRpPvi1CwDkjdWoGlqtY+ip8WQw
   8Ds9gNfTnRDlCO9AgohQOaUoIi7+RP/x6to6N3OaXlRlbceJdbyfdt+VE
   1ztLTdfsibSs1NdgLINHMF1CC+abvip7OKTxLp1CN3ANDBfj96HrEUehb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="468186510"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="468186510"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 11:52:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="725928273"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="725928273"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 11:52:30 -0700
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH 1/1] platform/x86/intel/ifs: release cpus_read_lock()
Date:   Wed, 27 Sep 2023 11:48:24 -0700
Message-Id: <20230927184824.2566086-1-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
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

Couple of error paths in do_core_test() was returning directly without
doing a necessary cpus_read_unlock().

Following lockdep warning was observed when exercising these scenarios
with PROVE_RAW_LOCK_NESTING enabled:

[  139.304775] ================================================
[  139.311185] WARNING: lock held when returning to user space!
[  139.317593] 6.6.0-rc2ifs01+ #11 Tainted: G S      W I
[  139.324499] ------------------------------------------------
[  139.330908] bash/11476 is leaving the kernel with locks still held!
[  139.338000] 1 lock held by bash/11476:
[  139.342262]  #0: ffffffffaa26c930 (cpu_hotplug_lock){++++}-{0:0}, at:
do_core_test+0x35/0x1c0 [intel_ifs]

Fix the flow so that all scenarios release the lock prior to returning
from the function.

Fixes: 5210fb4e1880 ("platform/x86/intel/ifs: Sysfs interface for Array BIST")
Cc: stable@vger.kernel.org
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
 drivers/platform/x86/intel/ifs/runtest.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
index 1061eb7ec399..43c864add778 100644
--- a/drivers/platform/x86/intel/ifs/runtest.c
+++ b/drivers/platform/x86/intel/ifs/runtest.c
@@ -331,14 +331,15 @@ int do_core_test(int cpu, struct device *dev)
 	switch (test->test_num) {
 	case IFS_TYPE_SAF:
 		if (!ifsd->loaded)
-			return -EPERM;
-		ifs_test_core(cpu, dev);
+			ret = -EPERM;
+		else
+			ifs_test_core(cpu, dev);
 		break;
 	case IFS_TYPE_ARRAY_BIST:
 		ifs_array_test_core(cpu, dev);
 		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
 out:
 	cpus_read_unlock();

base-commit: 6465e260f48790807eef06b583b38ca9789b6072
-- 
2.25.1


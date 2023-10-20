Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5B17D097D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 09:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376359AbjJTH0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 03:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjJTH0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 03:26:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D8C91
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 00:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697786792; x=1729322792;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ydwo0c6r0LCE+PTbYHOXBNKfMzBtuYnakBz475nDoL8=;
  b=hyRvOgb4IK9cOtpdXhlRhp1B7s8YFG+m8DuoB2Y33R8DaN64FZq7kJnh
   ehWDeTwUaUMiUOrwpSO1/sxgR/9kFhHB4MuTtSUzgLcheEeB4QdiMFYsW
   YD82HivM8Y5QDdF5H6KPHsxulDGi53imdxJpzMPiZVtuV+sbZgPbmZRbS
   Wi8PfzqvDj9O1OymfeayvHfQx/GljFFVvJPQqFotOoz/c6LiHjXkn8Kz7
   g7mKyMuEnH5Y51DAOeWMMZ1OsAk1JW9RbSIvTcVYcfcrRA0f/mLPFsbrJ
   YESQbk3U9SkySRBoU8L3gbos81XAKkRbyPPnbBf7dvLkBmEdBoQqA8L6e
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="385322922"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="385322922"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 00:26:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="792309680"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="792309680"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by orsmga001.jf.intel.com with ESMTP; 20 Oct 2023 00:26:28 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>
Cc:     Len Brown <len.brown@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, Chen Yu <yu.chen.surf@gmail.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Wendy Wang <wendy.wang@intel.com>
Subject: [RFC PATCH] genirq: Exclude managed irq during irq migration
Date:   Fri, 20 Oct 2023 15:25:22 +0800
Message-Id: <20231020072522.557846-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The managed IRQ will be shutdown and not be migrated to
other CPUs during CPU offline. Later when the CPU is online,
the managed IRQ will be re-enabled on this CPU. The managed
IRQ can be used to reduce the IRQ migration during CPU hotplug.

Before putting the CPU offline, the number of the already allocated
IRQs on this offlining CPU will be compared to the total number
of available IRQ vectors on the remaining online CPUs. If there is
not enough slot for these IRQs to be migrated to, the CPU offline
will be terminated. However, currently the code treats the managed
IRQ as migratable, which is not true, and brings false negative
during CPU hotplug and hibernation stress test.

For example:

cat /sys/kernel/debug/irq/domains/VECTOR

name:   VECTOR
 size:   0
 mapped: 338
 flags:  0x00000103
Online bitmaps:      168
Global available:  33009
Global reserved:      83
Total allocated:     255    <------
System: 43: 0-21,50,128,192,233-236,240-242,244,246-255
 | CPU | avl | man | mac | act | vectors
     0   180     1     1   18  32-49
     1   196     1     1    2  32-33
     ...
   166   197     1     1    1  32
   167   197     1     1    1  32

//put CPU167 offline
pepc.standalone cpu-hotplug offline --cpus 167

cat /sys/kernel/debug/irq/domains/VECTOR

name:   VECTOR
 size:   0
 mapped: 338
 flags:  0x00000103
Online bitmaps:      167
Global available:  32812
Global reserved:      83
Total allocated:     254      <------
System: 43: 0-21,50,128,192,233-236,240-242,244,246-255
 | CPU | avl | man | mac | act | vectors
     0   180     1     1   18  32-49
     1   196     1     1    2  32-33
     ...
   166   197     1     1    1  32

After CPU167 is offline, the number of allocated vectors
decreases from 255 to 254. Since the only IRQ on CPU167 is
managed(mac field), it is not migrated. But the current
code thinks that there is 1 IRQ to be migrated.

Fix the check by substracting the number of managed IRQ from
allocated one.

Fixes: 2f75d9e1c905 ("genirq: Implement bitmap matrix allocator")
Reported-by: Wendy Wang <wendy.wang@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/irq/matrix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 1698e77645ac..d245ad76661e 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -475,7 +475,7 @@ unsigned int irq_matrix_allocated(struct irq_matrix *m)
 {
 	struct cpumap *cm = this_cpu_ptr(m->maps);
 
-	return cm->allocated;
+	return cm->allocated - cm->managed_allocated;
 }
 
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
-- 
2.25.1


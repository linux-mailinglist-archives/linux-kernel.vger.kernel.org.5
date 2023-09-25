Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98397AD7B3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 14:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbjIYMIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 08:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjIYMIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:08:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D440C115
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 05:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695643679; x=1727179679;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MPzrsvv2Ozror1usPYrvXLoMqrCYHBi+ebhQqlRDDLA=;
  b=LCi+EqcEGTtm2A0Kba/lWphdipK7djvKUoCM2Gbx2yt1KPMDyoAwRXCA
   t1ZKG5zExTykuDeXvHOnYlk4gdnTDmzQwTklmK4+L7zaoRG5jCJqrGd3H
   OJHrqH1GoCnFlHV8WXbdohkEbtTYlgHIx7eOZ8rpVyrdfi7blz/1gNHf6
   e+Hqu4MPyT2+S9RqQC8tKEUylFbU/iX2TkzSOGSThSnHNDzD3U6G0ne05
   aK1COMMDdoYm0hAYdokzVACIf2Zl8o6ONdMeAjsrRMaUzQYOZaVfDUVkl
   8v6X9c2tmX5zNtidB2MrADzflfd81Mun7rXsTAKrcJBCrPjVLDRM0TP6+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="380110414"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="380110414"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 05:07:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="741907335"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="741907335"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga007.jf.intel.com with ESMTP; 25 Sep 2023 05:07:34 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Zhang Rui <rui.zhang@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] iommu/vt-d: Avoid memory allocation in iommu_suspend()
Date:   Mon, 25 Sep 2023 20:04:17 +0800
Message-Id: <20230925120417.55977-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925120417.55977-1-baolu.lu@linux.intel.com>
References: <20230925120417.55977-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Rui <rui.zhang@intel.com>

The iommu_suspend() syscore suspend callback is invoked with IRQ disabled.
Allocating memory with the GFP_KERNEL flag may re-enable IRQs during
the suspend callback, which can cause intermittent suspend/hibernation
problems with the following kernel traces:

Calling iommu_suspend+0x0/0x1d0
------------[ cut here ]------------
WARNING: CPU: 0 PID: 15 at kernel/time/timekeeping.c:868 ktime_get+0x9b/0xb0
...
CPU: 0 PID: 15 Comm: rcu_preempt Tainted: G     U      E      6.3-intel #r1
RIP: 0010:ktime_get+0x9b/0xb0
...
Call Trace:
 <IRQ>
 tick_sched_timer+0x22/0x90
 ? __pfx_tick_sched_timer+0x10/0x10
 __hrtimer_run_queues+0x111/0x2b0
 hrtimer_interrupt+0xfa/0x230
 __sysvec_apic_timer_interrupt+0x63/0x140
 sysvec_apic_timer_interrupt+0x7b/0xa0
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1f/0x30
...
------------[ cut here ]------------
Interrupts enabled after iommu_suspend+0x0/0x1d0
WARNING: CPU: 0 PID: 27420 at drivers/base/syscore.c:68 syscore_suspend+0x147/0x270
CPU: 0 PID: 27420 Comm: rtcwake Tainted: G     U  W   E      6.3-intel #r1
RIP: 0010:syscore_suspend+0x147/0x270
...
Call Trace:
 <TASK>
 hibernation_snapshot+0x25b/0x670
 hibernate+0xcd/0x390
 state_store+0xcf/0xe0
 kobj_attr_store+0x13/0x30
 sysfs_kf_write+0x3f/0x50
 kernfs_fop_write_iter+0x128/0x200
 vfs_write+0x1fd/0x3c0
 ksys_write+0x6f/0xf0
 __x64_sys_write+0x1d/0x30
 do_syscall_64+0x3b/0x90
 entry_SYSCALL_64_after_hwframe+0x72/0xdc

Given that only 4 words memory is needed, avoid the memory allocation in
iommu_suspend().

CC: stable@kernel.org
Fixes: 33e07157105e ("iommu/vt-d: Avoid GFP_ATOMIC where it is not needed")
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Ooi, Chin Hao <chin.hao.ooi@intel.com>
Link: https://lore.kernel.org/r/20230921093956.234692-1-rui.zhang@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h |  2 +-
 drivers/iommu/intel/iommu.c | 16 ----------------
 2 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index c18fb699c87a..7dac94f62b4e 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -681,7 +681,7 @@ struct intel_iommu {
 	struct iopf_queue *iopf_queue;
 	unsigned char iopfq_name[16];
 	struct q_inval  *qi;            /* Queued invalidation info */
-	u32 *iommu_state; /* Store iommu states between suspend and resume.*/
+	u32 iommu_state[MAX_SR_DMAR_REGS]; /* Store iommu states between suspend and resume.*/
 
 #ifdef CONFIG_IRQ_REMAP
 	struct ir_table *ir_table;	/* Interrupt remapping info */
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5db283c17e0d..3685ba90ec88 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2998,13 +2998,6 @@ static int iommu_suspend(void)
 	struct intel_iommu *iommu = NULL;
 	unsigned long flag;
 
-	for_each_active_iommu(iommu, drhd) {
-		iommu->iommu_state = kcalloc(MAX_SR_DMAR_REGS, sizeof(u32),
-					     GFP_KERNEL);
-		if (!iommu->iommu_state)
-			goto nomem;
-	}
-
 	iommu_flush_all();
 
 	for_each_active_iommu(iommu, drhd) {
@@ -3024,12 +3017,6 @@ static int iommu_suspend(void)
 		raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
 	}
 	return 0;
-
-nomem:
-	for_each_active_iommu(iommu, drhd)
-		kfree(iommu->iommu_state);
-
-	return -ENOMEM;
 }
 
 static void iommu_resume(void)
@@ -3061,9 +3048,6 @@ static void iommu_resume(void)
 
 		raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
 	}
-
-	for_each_active_iommu(iommu, drhd)
-		kfree(iommu->iommu_state);
 }
 
 static struct syscore_ops iommu_syscore_ops = {
-- 
2.34.1


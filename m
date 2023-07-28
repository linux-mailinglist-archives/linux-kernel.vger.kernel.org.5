Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC2E76724D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234321AbjG1QpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235566AbjG1Qoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:44:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF69F4C13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:43:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD43CD75;
        Fri, 28 Jul 2023 09:44:30 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1286D3F844;
        Fri, 28 Jul 2023 09:43:44 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        James Morse <james.morse@arm.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com
Subject: [PATCH v5 10/24] tick/nohz: Move tick_nohz_full_mask declaration outside the #ifdef
Date:   Fri, 28 Jul 2023 16:42:40 +0000
Message-Id: <20230728164254.27562-11-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230728164254.27562-1-james.morse@arm.com>
References: <20230728164254.27562-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tick_nohz_full_mask lists the CPUs that are nohz_full. This is only
needed when CONFIG_NO_HZ_FULL is defined. tick_nohz_full_cpu() allows
a specific CPU to be tested against the mask, and evaluates to false
when CONFIG_NO_HZ_FULL is not defined.

The resctrl code needs to pick a CPU to run some work on, a new helper
prefers housekeeping CPUs by examining the tick_nohz_full_mask. Hiding
the declaration behind #ifdef CONFIG_NO_HZ_FULL forces all the users to
be behind an ifdef too.

Move the tick_nohz_full_mask declaration, this lets callers drop the
ifdef, and guard access to tick_nohz_full_mask with IS_ENABLED() or
something like tick_nohz_full_cpu().

The definition does not need to be moved as any callers should be
removed at compile time unless CONFIG_NO_HZ_FULL is defined.

Signed-off-by: James Morse <james.morse@arm.com>
---
 include/linux/tick.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 9459fef5b857..65af90ca409a 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -174,9 +174,16 @@ static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
 static inline void tick_nohz_idle_stop_tick_protected(void) { }
 #endif /* !CONFIG_NO_HZ_COMMON */
 
+/*
+ * Mask of CPUs that are nohz_full.
+ *
+ * Users should be guarded by CONFIG_NO_HZ_FULL or a tick_nohz_full_cpu()
+ * check.
+ */
+extern cpumask_var_t tick_nohz_full_mask;
+
 #ifdef CONFIG_NO_HZ_FULL
 extern bool tick_nohz_full_running;
-extern cpumask_var_t tick_nohz_full_mask;
 
 static inline bool tick_nohz_full_enabled(void)
 {
-- 
2.39.2


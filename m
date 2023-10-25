Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2957D72DE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbjJYSFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234825AbjJYSFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:05:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6BA8110D0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:05:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2CE41480;
        Wed, 25 Oct 2023 11:05:52 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A7933F738;
        Wed, 25 Oct 2023 11:05:07 -0700 (PDT)
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
        baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com, amitsinght@marvell.com
Subject: [PATCH v7 09/24] x86/resctrl: Use __set_bit()/__clear_bit() instead of open coding
Date:   Wed, 25 Oct 2023 18:03:30 +0000
Message-Id: <20231025180345.28061-10-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231025180345.28061-1-james.morse@arm.com>
References: <20231025180345.28061-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The resctrl CLOSID allocator uses a single 32bit word to track which
CLOSID are free. The setting and clearing of bits is open coded.

A subsequent patch adds closid_allocated(), which adds more open
coded bitmaps operations. These will eventually need changing to use
the bitops helpers so that a CLOSID bitmap of the correct size can be
allocated dynamically.

Convert the existing open coded bit manipulations of closid_free_map
to use __set_bit() and friends. These don't need to be atomic as this
list is protected by the mutex.

Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Signed-off-by: James Morse <james.morse@arm.com>

---
Changes since v6:
 * Use the __ inatomic helpers and add lockdep_assert_held() annotations to
   document how this is safe.
 * Fixed a resctrl_closid_is_free()/closid_allocated() rename in the commit
   message.
 * Use RESCTRL_RESERVED_CLOSID to improve readability.
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 9864cb49d58c..f6051a3e7262 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -111,7 +111,7 @@ void rdt_staged_configs_clear(void)
  * - Our choices on how to configure each resource become progressively more
  *   limited as the number of resources grows.
  */
-static int closid_free_map;
+static unsigned long closid_free_map;
 static int closid_free_map_len;
 
 int closids_supported(void)
@@ -131,7 +131,7 @@ static void closid_init(void)
 	closid_free_map = BIT_MASK(rdt_min_closid) - 1;
 
 	/* CLOSID 0 is always reserved for the default group */
-	closid_free_map &= ~1;
+	__clear_bit(RESCTRL_RESERVED_CLOSID, &closid_free_map);
 	closid_free_map_len = rdt_min_closid;
 }
 
@@ -139,17 +139,21 @@ static int closid_alloc(void)
 {
 	u32 closid = ffs(closid_free_map);
 
+	lockdep_assert_held(&rdtgroup_mutex);
+
 	if (closid == 0)
 		return -ENOSPC;
 	closid--;
-	closid_free_map &= ~(1 << closid);
+	__clear_bit(closid, &closid_free_map);
 
 	return closid;
 }
 
 void closid_free(int closid)
 {
-	closid_free_map |= 1 << closid;
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	__set_bit(closid, &closid_free_map);
 }
 
 /**
@@ -161,7 +165,9 @@ void closid_free(int closid)
  */
 static bool closid_allocated(unsigned int closid)
 {
-	return (closid_free_map & (1 << closid)) == 0;
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	return !test_bit(closid, &closid_free_map);
 }
 
 /**
-- 
2.39.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7379C8123B0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 01:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbjLNAGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 19:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjLNAGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 19:06:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C28685;
        Wed, 13 Dec 2023 16:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702512410; x=1734048410;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Owews0mavJ2oaLDoKrToW+g5JiUDjY4k3yPVLHroirc=;
  b=cG7xGXUdGMvh8mQ8PjR+ZCJhPwUm044oSvDTUEMu20aQNzs+QbUmMgAr
   mL8PrmK1bPbCpbqD5nN1Uij58V1FiHjfNISdZ3iBEO5ciq/6BKr78JX6t
   XVlkhOL6R4bMsPtjpctAW8rL48sGMBoWkIE2rIGcou7Za4dQ04iqMXfk6
   5sVga9eKcrChHlZnre+x2xMg56agPIMNW7MWJ7zpDZOw0vV4kqFo0UMbW
   xz33EA8Ze8FDZi2wKudygIyOBKS9XkeW0aiNhPcpXyZa+MizN1jhlJWrd
   +iMVQaBqvN9pqQFxYFeSJ6sLZklw7MLFgEGq5RuwnmasRGwy6O144bilo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="375198800"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="375198800"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 16:06:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="844506787"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="844506787"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 16:06:44 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH] Revert "perf: Fix perf_event_validate_size()"
Date:   Wed, 13 Dec 2023 16:06:20 -0800
Message-Id: <20231214000620.3081018-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 382c27f4ed28f803b1f1473ac2d8db0afc795a1b.

When using for_each_sibling_event() lockdep complains on

        WARN_ON_ONCE(__lockdep_enabled &&                       \
                     (this_cpu_read(hardirqs_enabled) &&        \
                      lockdep_is_held(&(event)->ctx->mutex) != LOCK_STATE_HELD))

after a simple `perf stat -e instructions sleep 1`:

	WARNING: CPU: 8 PID: 1471 at kernel/events/core.c:1950 __do_sys_perf_event_open+0xf37/0x1080
	Modules linked in: x86_pkg_temp_thermal coretemp kvm_intel kvm e1000e igc irqbypass mei_pxp mei_hdcp crct10dif_pclmul wmi_bmof crc32_pclmul ghash_clmulni_intel i2c_i801 ptp mei_me i2c_smbus pps_core mei intel_lpss_pci video wmi fuse
	CPU: 8 PID: 1471 Comm: perf Not tainted 6.7.0-rc5-linus-demarchi+ #8
	Hardware name: Intel Corporation Rocket Lake Client Platform/RocketLake S UDIMM 4L ERB, BIOS RKLSFWI1.R00.2022.A00.2101052151 01/05/2021
	RIP: 0010:__do_sys_perf_event_open+0xf37/0x1080
	Code: ff e8 ed 30 ab 00 48 8b 81 28 02 00 00 83 ce ff 48 8d b8 a8 00 00 00 e8 67 38 ab 00 48 8b 4c 24 08 83 e8 01 0f 84 56 f9 ff ff <0f> 0b e9 4f f9 ff ff be 03 00 00 00 e8 d8 74 40 00 e9 54 fa ff ff
	RSP: 0018:ffffc90001d6be40 EFLAGS: 00010297
	RAX: 00000000ffffffff RBX: ffff888112bc8040 RCX: ffff888100c34568
	RDX: 0000000080000000 RSI: ffffffff823e2806 RDI: ffffffff824023cb
	RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
	R10: 0000000000000001 R11: 0000000000000000 R12: ffff888106560800
	R13: 0000000000000000 R14: 0000000000080002 R15: ffff888100c34568
	FS:  00007f723d196c00(0000) GS:ffff888450800000(0000) knlGS:0000000000000000
	CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	CR2: 00005624c0efdaa0 CR3: 00000001199de002 CR4: 0000000000770ef0
	PKRU: 55555554
	Call Trace:
	 <TASK>
	 ? __do_sys_perf_event_open+0xf37/0x1080
	 ? __warn+0x80/0x170
	 ? __do_sys_perf_event_open+0xf37/0x1080
	 ? report_bug+0x191/0x1c0
	 ? handle_bug+0x3c/0x70
	 ? exc_invalid_op+0x17/0x70
	 ? asm_exc_invalid_op+0x1a/0x20
	 ? __do_sys_perf_event_open+0xf37/0x1080
	 do_syscall_64+0x42/0xf0
	 entry_SYSCALL_64_after_hwframe+0x6e/0x76
	RIP: 0033:0x7f723bf1ea7d
	Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 83 a3 0f 00 f7 d8 64 89 01 48
	RSP: 002b:00007ffc7118ba68 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
	RAX: ffffffffffffffda RBX: 00000000ffffffff RCX: 00007f723bf1ea7d
	RDX: 00000000ffffffff RSI: 00000000000005c0 RDI: 00005624c0efb0c0
	RBP: 00007ffc7118bb20 R08: 0000000000000008 R09: 0000000000000000
	R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000000000
	R13: 0000000000000008 R14: 00005624c0efb0b0 R15: 00005624c0efb0b0
	 </TASK>
	irq event stamp: 45697
	hardirqs last  enabled at (45703): [<ffffffff81173dca>] console_unlock+0x10a/0x160
	hardirqs last disabled at (45708): [<ffffffff81173daf>] console_unlock+0xef/0x160
	softirqs last  enabled at (45276): [<ffffffff810dab0e>] irq_exit_rcu+0x8e/0xf0
	softirqs last disabled at (45267): [<ffffffff810dab0e>] irq_exit_rcu+0x8e/0xf0

References: https://gitlab.freedesktop.org/drm/intel/-/issues/9847
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---

Not sure about a proper fix for this. At first I thought it was indeed
because previously it was not validating the the size correctly. However
then I noticed the warning is actually due to for_each_sibling_event().


 kernel/events/core.c | 61 +++++++++++++++++---------------------------
 1 file changed, 23 insertions(+), 38 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index c9d123e13b57..b704d83a28b2 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1814,34 +1814,31 @@ static inline void perf_event__state_init(struct perf_event *event)
 					      PERF_EVENT_STATE_INACTIVE;
 }
 
-static int __perf_event_read_size(u64 read_format, int nr_siblings)
+static void __perf_event_read_size(struct perf_event *event, int nr_siblings)
 {
 	int entry = sizeof(u64); /* value */
 	int size = 0;
 	int nr = 1;
 
-	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
+	if (event->attr.read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
 		size += sizeof(u64);
 
-	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
+	if (event->attr.read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
 		size += sizeof(u64);
 
-	if (read_format & PERF_FORMAT_ID)
+	if (event->attr.read_format & PERF_FORMAT_ID)
 		entry += sizeof(u64);
 
-	if (read_format & PERF_FORMAT_LOST)
+	if (event->attr.read_format & PERF_FORMAT_LOST)
 		entry += sizeof(u64);
 
-	if (read_format & PERF_FORMAT_GROUP) {
+	if (event->attr.read_format & PERF_FORMAT_GROUP) {
 		nr += nr_siblings;
 		size += sizeof(u64);
 	}
 
-	/*
-	 * Since perf_event_validate_size() limits this to 16k and inhibits
-	 * adding more siblings, this will never overflow.
-	 */
-	return size + nr * entry;
+	size += entry * nr;
+	event->read_size = size;
 }
 
 static void __perf_event_header_size(struct perf_event *event, u64 sample_type)
@@ -1891,9 +1888,8 @@ static void __perf_event_header_size(struct perf_event *event, u64 sample_type)
  */
 static void perf_event__header_size(struct perf_event *event)
 {
-	event->read_size =
-		__perf_event_read_size(event->attr.read_format,
-				       event->group_leader->nr_siblings);
+	__perf_event_read_size(event,
+			       event->group_leader->nr_siblings);
 	__perf_event_header_size(event, event->attr.sample_type);
 }
 
@@ -1924,35 +1920,24 @@ static void perf_event__id_header_size(struct perf_event *event)
 	event->id_header_size = size;
 }
 
-/*
- * Check that adding an event to the group does not result in anybody
- * overflowing the 64k event limit imposed by the output buffer.
- *
- * Specifically, check that the read_size for the event does not exceed 16k,
- * read_size being the one term that grows with groups size. Since read_size
- * depends on per-event read_format, also (re)check the existing events.
- *
- * This leaves 48k for the constant size fields and things like callchains,
- * branch stacks and register sets.
- */
 static bool perf_event_validate_size(struct perf_event *event)
 {
-	struct perf_event *sibling, *group_leader = event->group_leader;
-
-	if (__perf_event_read_size(event->attr.read_format,
-				   group_leader->nr_siblings + 1) > 16*1024)
-		return false;
+	/*
+	 * The values computed here will be over-written when we actually
+	 * attach the event.
+	 */
+	__perf_event_read_size(event, event->group_leader->nr_siblings + 1);
+	__perf_event_header_size(event, event->attr.sample_type & ~PERF_SAMPLE_READ);
+	perf_event__id_header_size(event);
 
-	if (__perf_event_read_size(group_leader->attr.read_format,
-				   group_leader->nr_siblings + 1) > 16*1024)
+	/*
+	 * Sum the lot; should not exceed the 64k limit we have on records.
+	 * Conservative limit to allow for callchains and other variable fields.
+	 */
+	if (event->read_size + event->header_size +
+	    event->id_header_size + sizeof(struct perf_event_header) >= 16*1024)
 		return false;
 
-	for_each_sibling_event(sibling, group_leader) {
-		if (__perf_event_read_size(sibling->attr.read_format,
-					   group_leader->nr_siblings + 1) > 16*1024)
-			return false;
-	}
-
 	return true;
 }
 
-- 
2.40.1


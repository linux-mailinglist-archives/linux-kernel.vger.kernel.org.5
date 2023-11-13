Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193F17EA563
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 22:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjKMVRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 16:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMVRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 16:17:08 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2065.outbound.protection.outlook.com [40.92.89.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313D0D5E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 13:17:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G74k6QveZtaeptviTOT7fkvYVoAr+ccLvrB3R8Qxl2RgfdwDCk1mNBez1lL/naVDY7OuNMmvjJ8gIdkzgl5+cwdBliCpGM4xzSPwvC9cmcN6h9Tp7hW6Km/5B+9x3MXsuHfqaZU8n+gYSaKO1HzDCkyOMo/pN5PXTpLztjExQViT+ACeI1ZqQ3tpGlDGCxqZWzitx47dDILWn6TNPLJ0zaijyWnh1/YAehYUqBA4haC/J9yMPvUl5enDs8Q33GbdylxKlWa1vC5Zo6COi77mM/Sv+CZpBuWpgdy6lNM0pIHF6zH7BAciFb7rzptRtGS4tTOUlifpwAN+WLuQHg1PSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8W6o7txNWRAo9Bt4yT7e4APxsqAQ5eaca8ndICXNn4w=;
 b=FLv36ncLIDBy086IIS3Ffp6X44xp4rlL7bC277WzLVcK54DfeOocGZmBcsTLgUkul6W1uab4u6IP82QSKp5JNifmNEJb/WtZ6UXn66I75MVxfS1LEJqo69kJPCztCgNm5IPvsepH9v+RZwqyY+H4TW1AX5K3ngiOtm4yYPWwBxSJ4zZocUu+3quCWHKV65dqGNsDUAB3YfneDthfWERqdyRDmhBXW8VmXW78x+5UeG+opMk93C2xZV71N5uGhpoABg9v2XdjIaF9oK1xbXk456vtTCtJv/HH7zyTLpkADY3OYVd2ANpS+mr82kdg9WuU86xcZ2CcsF5KnIGS03hYEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8W6o7txNWRAo9Bt4yT7e4APxsqAQ5eaca8ndICXNn4w=;
 b=ZNSsRkK1byVmBH3doCDr7dzW2lINLD7xcoxSeZobq3rrCecHwuPnPmZkBmok4hIucQsOZtQXK/AVJcqXkDwKrf6KKzZFoAWbK5jUUUw98j31wB5IULz4enlOmH8S6TpmBFIWHsIcblbxT1UW9dLhwo6GsDKoslXRQGd7oL1hBKU+xrWyU7tiqeHr6qDQ1UezPJkqLqnWNB9BakXOy4hmio84qwPW8UNCD2Hpym76vyWZZTKPlPuYdJJD0sFypFAsD1Kz3q9Q/+mNy8SMuPOl6o8plsNQzWMu1DN4cyAfWMEz2+Bk5FV53WZw1Ik74b401q3/k6polup6Mf4inNZmeA==
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:32::19)
 by DBAP193MB1100.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:1c2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 21:17:00 +0000
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::fdd2:7dbf:e16c:f4a4]) by VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::fdd2:7dbf:e16c:f4a4%4]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 21:17:00 +0000
From:   Juntong Deng <juntong.deng@outlook.com>
To:     ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, vincenzo.frascino@arm.com,
        akpm@linux-foundation.org
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [RFC PATCH] kasan: Record and report more information
Date:   Tue, 14 Nov 2023 05:16:15 +0800
Message-ID: <VI1P193MB0752058FAECD2AC1E5E68D7399B3A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [GTvegEVj0TY4D820LnUrsk3fQ8PhItCW]
X-ClientProxiedBy: LO4P265CA0214.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::9) To VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:32::19)
X-Microsoft-Original-Message-ID: <20231113211615.300951-1-juntong.deng@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0752:EE_|DBAP193MB1100:EE_
X-MS-Office365-Filtering-Correlation-Id: 088b1a0f-0883-430e-9dcb-08dbe48ddff9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5xaLOEZKp8o9uyRs4Pd5VL4fVfK4m2SY/I5kaXnuz8qZLXIGjgcoF+xyZTjbJmtNKnrQbqW4osnQbwgOXrnHuKtWXXcD6SqmRLfSfzgTCiepWE5sdCKr183AFRKLTgHATWcMxFs+qY9O3p+3xVaszJYJzuIggCeB2WZzeZfE2zJQrnz3lsp9aTlbswm9oig73B/dulSZlHLzz4sCu0/iCLkOPk06OQevtAQ/4jFdLCzuKxMyuqAMlAizrSl85hBU7MHi2mdr5EdEG4VWlomnnBgz1FHxahLvcaRtdi9Rd2znXW5dlGTOTQobi6llpsyiggJ/IqQ5XVC81B1W0DhrR8DcG/oxFeoRnY0+VKgtVknS/5QlvwuegoMa8fULSP9yQYxxhxXrTghzv8GROPJfQP0PQsjpXrRBfGxYeaCPDh7VpTULbYAJGFO4ZLVqk2v5fW0D++L8pjeP6wv+1HlUZWxkEfno7tlheid5WCfc2NFDKbndquIBGgzzL1i1gw7fqukVhc+uGrtQcEbSEEEHP6N8EgpiG+ltkD2XU2M7NJSxTLgQhRhEcWhGe439UONN
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?++HzXvZcIO+IEhp9MUsJXjnerliMijj5tHaRv7GA5G4kwaudPeu55Ur+7GJA?=
 =?us-ascii?Q?N8bn+9JlxtS6m1yrJdhU/+QW6STY0bdNxlWkaYlSE3JaSHclHs+QHWf3zujo?=
 =?us-ascii?Q?X6HeE/cPFnJ4AjkcYpWHIMakY2BSpxRVolgjh1Vd91LdSrlYJe865KjzNDur?=
 =?us-ascii?Q?77vl50D4ayrcygRVcZrBwJML7rEBhdE7AIrE0s+jTJ64sMiINYl3d33s5bcG?=
 =?us-ascii?Q?mzZ+mnFWkdmdT4BaezXwtvDLYEgdb9ckPTwDv/U4JJxQbX9PtMvlrnzaEG42?=
 =?us-ascii?Q?15wmLX73ybf/cqiufQLo5o4rLkr8s8WGJS+AWEIHs/BK9OL+UjAcyrTENv53?=
 =?us-ascii?Q?GsUCI4bctXBhjz8WT94zSs1rFPKD+qofgjT9ZPNXT/1rBYnHh2ZRNe66NSzf?=
 =?us-ascii?Q?NccFvTpTLZiV6n0h6HqVyevIgTJ2dCD2eB7CLYjF/wYnWIejC6Dq/imrp510?=
 =?us-ascii?Q?YsHN4KQfK00oD5PORq+DQ89rsfUSV/7YNkRnWuSBrciumxjZtcC7DL1jdzZ8?=
 =?us-ascii?Q?TWmsGp2Kha0ScC7+cTXSO9PPOVlhSqa+iKu2a3+EwsTtc///TNH261KEvU/u?=
 =?us-ascii?Q?YZo+e8BD+WYglJui4hHwbru1yn3rMDOOj0TxhFdPsGoUGoJurU7tVfauiywZ?=
 =?us-ascii?Q?NJpp4eXosL9TaOTpPFwkNtoUOWPfTZn9ay2VHwUFkmUd0YcbShuoO5JRMCxp?=
 =?us-ascii?Q?PPF5qssHyHPYfEN4vU/pLCzEX2qbcQQCnITOjwhOQlJSgMqBHGZieijb+XVc?=
 =?us-ascii?Q?JQfZwlh1FBt/iz0fOuiaoT+z8cMf4vOLxLyHtLbPa9sofSVxnsD1tJONFZ/0?=
 =?us-ascii?Q?OByKwSA4BOn9GUdEbgJVSeQREwplhKvXmaz1HjsfvUKRuQ4mTDz0AWjXGqlg?=
 =?us-ascii?Q?/uCiRrzM1XluH+yy9dFMISihk3A7Q0tJtZy8Ltv3QK8tPUDdFGsu2qnvsln2?=
 =?us-ascii?Q?WkaZzXWQsPpSbBc3rmWtQU8hbSXNcds2zypiakO9RH9/fUxePMw9y0XdMF5I?=
 =?us-ascii?Q?M32DaiKQ/CxWrP4gMYFjuCYbrEpEfl7j4dBnTfc+9XEmzuk/Yo4zENqFa3c6?=
 =?us-ascii?Q?v6DQ5xkyvXP2Z6s7LJXkYSNwb61bZdIqn/S5jJjgNFF1YOnVlYvWzJS/0FBY?=
 =?us-ascii?Q?42aaLVUGLroNDsPg9rt0WZxB33T21iPLL08dUvNX4fCx6x1IrNIY9A3rS1ZZ?=
 =?us-ascii?Q?312yW2X1FJgrCHbDWv2FnQoXFn8v3p5M0YvAM4fawLQa0xuzesyJcxTSspI?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 088b1a0f-0883-430e-9dcb-08dbe48ddff9
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 21:17:00.6516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP193MB1100
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Record and report more information to help us find the cause of
the bug (for example, bugs caused by subtle race condition).

This patch adds recording and showing CPU number and timestamp at
allocation and free (controlled by CONFIG_KASAN_EXTRA_INFO), and
adds recording and showing timestamp at error occurrence (CPU number
is already shown by dump_stack_lvl). The timestamps in the report use
the same format and source as printk.

In order to record CPU number and timestamp at allocation and free,
corresponding members need to be added to the relevant data structures,
which may lead to increased memory consumption.

In Generic KASAN, members are added to struct kasan_track. Since in
most cases, alloc meta is stored in the redzone and free meta is
stored in the object or the redzone, memory consumption will not
increase much.

In SW_TAGS KASAN and HW_TAGS KASAN, members are added to
struct kasan_stack_ring_entry. Memory consumption increases as the
size of struct kasan_stack_ring_entry increases (this part of the
memory is allocated by memblock), but since this is configurable,
it is up to the user to choose.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 lib/Kconfig.kasan      | 11 +++++++++++
 mm/kasan/common.c      |  5 +++++
 mm/kasan/kasan.h       |  9 +++++++++
 mm/kasan/report.c      | 28 ++++++++++++++++++++++------
 mm/kasan/report_tags.c | 18 ++++++++++++++++++
 mm/kasan/tags.c        | 15 +++++++++++++++
 6 files changed, 80 insertions(+), 6 deletions(-)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index fdca89c05745..d9611564b339 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -207,4 +207,15 @@ config KASAN_MODULE_TEST
 	  A part of the KASAN test suite that is not integrated with KUnit.
 	  Incompatible with Hardware Tag-Based KASAN.
 
+config KASAN_EXTRA_INFO
+	bool "Record and report more information"
+	depends on KASAN
+	help
+	  Record and report more information to help us find the cause of
+	  the bug. The trade-off is potentially increased memory consumption
+	  (to record more information).
+
+	  Currently the CPU number and timestamp are additionally recorded
+	  at allocation and free.
+
 endif # KASAN
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 256930da578a..7a81566d9d66 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/printk.h>
 #include <linux/sched.h>
+#include <linux/sched/clock.h>
 #include <linux/sched/task_stack.h>
 #include <linux/slab.h>
 #include <linux/stacktrace.h>
@@ -50,6 +51,10 @@ void kasan_set_track(struct kasan_track *track, gfp_t flags)
 {
 	track->pid = current->pid;
 	track->stack = kasan_save_stack(flags, true);
+#ifdef CONFIG_KASAN_EXTRA_INFO
+	track->cpu = raw_smp_processor_id();
+	track->ts_nsec = local_clock();
+#endif /* CONFIG_KASAN_EXTRA_INFO */
 }
 
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 8b06bab5c406..b3899a255aca 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -187,6 +187,10 @@ static inline bool kasan_requires_meta(void)
 struct kasan_track {
 	u32 pid;
 	depot_stack_handle_t stack;
+#ifdef CONFIG_KASAN_EXTRA_INFO
+	u32 cpu;
+	u64 ts_nsec;
+#endif /* CONFIG_KASAN_EXTRA_INFO */
 };
 
 enum kasan_report_type {
@@ -202,6 +206,7 @@ struct kasan_report_info {
 	size_t access_size;
 	bool is_write;
 	unsigned long ip;
+	u64 ts_nsec;
 
 	/* Filled in by the common reporting code. */
 	const void *first_bad_addr;
@@ -278,6 +283,10 @@ struct kasan_stack_ring_entry {
 	u32 pid;
 	depot_stack_handle_t stack;
 	bool is_free;
+#ifdef CONFIG_KASAN_EXTRA_INFO
+	u32 cpu;
+	u64 ts_nsec;
+#endif /* CONFIG_KASAN_EXTRA_INFO */
 };
 
 struct kasan_stack_ring {
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index e77facb62900..b6feaf807c08 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -25,6 +25,7 @@
 #include <linux/types.h>
 #include <linux/kasan.h>
 #include <linux/module.h>
+#include <linux/sched/clock.h>
 #include <linux/sched/task_stack.h>
 #include <linux/uaccess.h>
 #include <trace/events/error_report.h>
@@ -242,27 +243,40 @@ static void end_report(unsigned long *flags, const void *addr, bool is_write)
 
 static void print_error_description(struct kasan_report_info *info)
 {
+	unsigned long rem_usec = do_div(info->ts_nsec, NSEC_PER_SEC) / 1000;
+
 	pr_err("BUG: KASAN: %s in %pS\n", info->bug_type, (void *)info->ip);
 
 	if (info->type != KASAN_REPORT_ACCESS) {
-		pr_err("Free of addr %px by task %s/%d\n",
-			info->access_addr, current->comm, task_pid_nr(current));
+		pr_err("Free of addr %px by task %s/%d at %lu.%06lus\n",
+			info->access_addr, current->comm, task_pid_nr(current),
+			(unsigned long)info->ts_nsec, rem_usec);
 		return;
 	}
 
 	if (info->access_size)
-		pr_err("%s of size %zu at addr %px by task %s/%d\n",
+		pr_err("%s of size %zu at addr %px by task %s/%d at %lu.%06lus\n",
 			info->is_write ? "Write" : "Read", info->access_size,
-			info->access_addr, current->comm, task_pid_nr(current));
+			info->access_addr, current->comm, task_pid_nr(current),
+			(unsigned long)info->ts_nsec, rem_usec);
 	else
-		pr_err("%s at addr %px by task %s/%d\n",
+		pr_err("%s at addr %px by task %s/%d at %lu.%06lus\n",
 			info->is_write ? "Write" : "Read",
-			info->access_addr, current->comm, task_pid_nr(current));
+			info->access_addr, current->comm, task_pid_nr(current),
+			(unsigned long)info->ts_nsec, rem_usec);
 }
 
 static void print_track(struct kasan_track *track, const char *prefix)
 {
+#ifdef CONFIG_KASAN_EXTRA_INFO
+	unsigned long rem_usec = do_div(track->ts_nsec, NSEC_PER_SEC) / 1000;
+
+	pr_err("%s by task %u on cpu %d at %lu.%06lus:\n",
+			prefix, track->pid, track->cpu,
+			(unsigned long)track->ts_nsec, rem_usec);
+#else
 	pr_err("%s by task %u:\n", prefix, track->pid);
+#endif /* CONFIG_KASAN_EXTRA_INFO */
 	if (track->stack)
 		stack_depot_print(track->stack);
 	else
@@ -544,6 +558,7 @@ void kasan_report_invalid_free(void *ptr, unsigned long ip, enum kasan_report_ty
 	info.access_size = 0;
 	info.is_write = false;
 	info.ip = ip;
+	info.ts_nsec = local_clock();
 
 	complete_report_info(&info);
 
@@ -582,6 +597,7 @@ bool kasan_report(const void *addr, size_t size, bool is_write,
 	info.access_size = size;
 	info.is_write = is_write;
 	info.ip = ip;
+	info.ts_nsec = local_clock();
 
 	complete_report_info(&info);
 
diff --git a/mm/kasan/report_tags.c b/mm/kasan/report_tags.c
index 8b8bfdb3cfdb..4d62f1b3e11d 100644
--- a/mm/kasan/report_tags.c
+++ b/mm/kasan/report_tags.c
@@ -26,6 +26,18 @@ static const char *get_common_bug_type(struct kasan_report_info *info)
 	return "invalid-access";
 }
 
+#ifdef CONFIG_KASAN_EXTRA_INFO
+static void kasan_complete_extra_report_info(struct kasan_track *track,
+					 struct kasan_stack_ring_entry *entry)
+{
+	u32 cpu = READ_ONCE(entry->cpu);
+	u64 ts_nsec = READ_ONCE(entry->ts_nsec);
+
+	track->cpu = cpu;
+	track->ts_nsec = ts_nsec;
+}
+#endif /* CONFIG_KASAN_EXTRA_INFO */
+
 void kasan_complete_mode_report_info(struct kasan_report_info *info)
 {
 	unsigned long flags;
@@ -82,6 +94,9 @@ void kasan_complete_mode_report_info(struct kasan_report_info *info)
 
 			info->free_track.pid = pid;
 			info->free_track.stack = stack;
+#ifdef CONFIG_KASAN_EXTRA_INFO
+			kasan_complete_extra_report_info(&info->free_track, entry);
+#endif /* CONFIG_KASAN_EXTRA_INFO */
 			free_found = true;
 
 			/*
@@ -97,6 +112,9 @@ void kasan_complete_mode_report_info(struct kasan_report_info *info)
 
 			info->alloc_track.pid = pid;
 			info->alloc_track.stack = stack;
+#ifdef CONFIG_KASAN_EXTRA_INFO
+			kasan_complete_extra_report_info(&info->alloc_track, entry);
+#endif /* CONFIG_KASAN_EXTRA_INFO */
 			alloc_found = true;
 
 			/*
diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index 7dcfe341d48e..474ce7e8be8b 100644
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -13,6 +13,7 @@
 #include <linux/memblock.h>
 #include <linux/memory.h>
 #include <linux/mm.h>
+#include <linux/sched/clock.h>
 #include <linux/static_key.h>
 #include <linux/string.h>
 #include <linux/types.h>
@@ -92,6 +93,17 @@ void __init kasan_init_tags(void)
 	}
 }
 
+#ifdef CONFIG_KASAN_EXTRA_INFO
+static void save_extra_info(struct kasan_stack_ring_entry *entry)
+{
+	u32 cpu = raw_smp_processor_id();
+	u64 ts_nsec = local_clock();
+
+	WRITE_ONCE(entry->cpu, cpu);
+	WRITE_ONCE(entry->ts_nsec, ts_nsec);
+}
+#endif /* CONFIG_KASAN_EXTRA_INFO */
+
 static void save_stack_info(struct kmem_cache *cache, void *object,
 			gfp_t gfp_flags, bool is_free)
 {
@@ -124,6 +136,9 @@ static void save_stack_info(struct kmem_cache *cache, void *object,
 	WRITE_ONCE(entry->pid, current->pid);
 	WRITE_ONCE(entry->stack, stack);
 	WRITE_ONCE(entry->is_free, is_free);
+#ifdef CONFIG_KASAN_EXTRA_INFO
+	save_extra_info(entry);
+#endif /* CONFIG_KASAN_EXTRA_INFO */
 
 	/*
 	 * Paired with smp_load_acquire() in kasan_complete_mode_report_info().
-- 
2.39.2


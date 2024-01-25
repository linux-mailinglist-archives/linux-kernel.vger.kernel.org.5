Return-Path: <linux-kernel+bounces-38051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7B783BA4D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02BC11C22955
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE3E11193;
	Thu, 25 Jan 2024 06:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="oF9NBgru"
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2185.outbound.protection.outlook.com [40.92.63.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3092C11185;
	Thu, 25 Jan 2024 06:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.185
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706165486; cv=fail; b=KYhAwyZQv+ui9Xq/qLzM+mmn3gFEKUm4kbvOV96ZF7w5kSdh4TnPcNS+6BdYb/pr4ctlZSQaUnvK0mN8nTccHwPRQmW+YgxDvawULX/8rDrUKt9wx8uRLx3hFhHK9o+/Z79wRRBg9kLjpsObOJ1xtjC7S5xOb8IbnQPg3LIvu08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706165486; c=relaxed/simple;
	bh=v65JsODILtkZ4suT+7xXBOb5/AYFcvDovJ0WnvJAo8E=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uXuiSzb4rIU/8j1+3ETJdWyj6frKu7udYDZ9ZG8/gRpc6fpCWJFjgMf7TuklnYvmj6aWiETtLS1pS9++S7LVF5Wtq/+57F2Vr0h5lw5UeS//7ts825jg/ULtZW3sDOPivWN3XRdKTqSD+WZqR1HA+qN8XOLYqkrijNz/syLw/aM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=oF9NBgru; arc=fail smtp.client-ip=40.92.63.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwnafdOFpsnG5aN0Q6B2toyP0pjkWL9vb1C9Z39lAd0NO0yIu6KOqktnycxt1TsjclaoXGln9SnOyNr1KuKApe+wTfxdUpFIsZQq4RumVPnD5xLFzl9rhMjNDvh6tfRIiP/zxSHnf2o8Qn+uyz75bAW0kLAsXtmG+hLUNcefNXtl7VYrNxNiAVR0ADjTHxiVcUEbRl98VuMjwP4MMigVU8qgBe87PpnQMeqdoHW0suYueycEeos336cJ4xftDNxRRuNfZQiCBvCpXMNFrRqRk3gGue+G8pbFhmKfAY9A+gadAA1lIncAAnkiyLztCdv/weXFiUJXAqThXyApn173ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMbVdSNXc3vnq2dBeljNWR129Nl7FduH6MGja/4x3pA=;
 b=n21n+BowrhoBd7Pq9ucp4FgYlaT8CEhYdro+Z379pgICk6oIwTIDVOE9RuoURw6vmK1SUNdMWnzRAQBk6JND1JqIjzYme/c1Y7X7jFfNKKlTAxP7Ah+wQ/UN3vXr0Dyq7W95hcBmFYkul91aKfNvCipiWsuzQ8eVVtZetJT7hVpLK7u8ttJFvloRwYAx0LY8N8WWsuIv+tfgosLgcFIARTDknOhULk82UpASeRK/aZtH6KjUHq/s5tJh/6ETHqA91adE4i7D7uU4EhkCB1mDaHvFAlv/HHRH41DUsBkgRGddQ68L34CzhFyC1tG90KOQIOFzNmrBTgA5Ub7Ud/y0kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMbVdSNXc3vnq2dBeljNWR129Nl7FduH6MGja/4x3pA=;
 b=oF9NBgruk//2KgOWBTVKlWXyPkQHVgNfSjTv3zTZqWPx/+mycmwBwZewZcnO5EKxeVmk+snXf7IQMqt4EVgNPe/MEK7G14SwBXEX/bAmaQ9kCyORjwSX+Q5jefFZrJG42EMs+bex5NFABj7aWyk9y2QxLKc3GBl6b6Umvx3ylKbKQ8t/KG/NdZJgkVLNPoViGvb2dqpnZnT4MKPFfiecqjXg1yL3vUeNLT0cP0bcOj1jGHgoYy6PxvgnfPXPWRNviG7G9uqzn3+GI+kuX08fvo1HYRGyQ5JQ9DnFk+5xvgToD2Ppw9ns3P8egBSFkT2w3PV1AIkDetIu+43BvS7fKA==
Received: from SY6P282MB3733.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1bc::5) by
 SY4P282MB4029.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1c4::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.22; Thu, 25 Jan 2024 06:51:18 +0000
Received: from SY6P282MB3733.AUSP282.PROD.OUTLOOK.COM
 ([fe80::8179:fed2:b690:d022]) by SY6P282MB3733.AUSP282.PROD.OUTLOOK.COM
 ([fe80::8179:fed2:b690:d022%5]) with mapi id 15.20.7228.023; Thu, 25 Jan 2024
 06:51:18 +0000
From: Sicheng Liu <lsc2001@outlook.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	corbet@lwn.net,
	Sicheng Liu <lsc2001@outlook.com>
Subject: [RFC PATCH 1/2] tracing: Introduce stack filter for trace events
Date: Thu, 25 Jan 2024 06:50:21 +0000
Message-ID:
 <SY6P282MB37330995DD0808206D1952F2A37A2@SY6P282MB3733.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [KsEcB11Qt8lXl0fx7BVSdIJSk/Ee5ptE]
X-ClientProxiedBy: SG2PR04CA0180.apcprd04.prod.outlook.com
 (2603:1096:4:14::18) To SY6P282MB3733.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:1bc::5)
X-Microsoft-Original-Message-ID:
 <20240125065022.1739502-1-lsc2001@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY6P282MB3733:EE_|SY4P282MB4029:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bef372a-4bbe-4ff3-5068-08dc1d7207b5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3M33uKOBRbKpM7vUDMX9N+g2oj0wsqSxTu9O2TPeN4e2yhifTs83B0Ngx71+row5rjQF4NGdd0aqDXSkXHSat/Y4xRq9633GqAjrxC++BmB5YBvv5KjnnUxwsh94IzKpRpYTXFl79orkDwoKejPXuGtaoEmgrop3gdWeoQutIicLXMANicCuOHQM4BdlGfGKnRGU6Q2AEPCf6ZncFeTN5LKbADlSohmoxQSxbl4960GvRWfNggDBHQVnzDIVdcXGt+l0tEI9IPl2iY3Vw9LK9gqGrCaAqMS/cTRmrYJ5GzfOY+0W2UaI8Fl5pVwEjyqVgaOzXwBcFpgSQK+aN/Lt5WKTqdvi9aT0HDyWb9W8Pi7ViK7ChdU7q0hsboReGf7dHx00g+9SFdBn5qCgb69cJINaSu2dJScjk1eLapeVLWs0D/ufDGlYvXL6VU9J5J3UJgSKo207ykNbEPrI911Ml39W1pFE+MLt/8KN758kZnDjbdO76JaDRVj8eR4bdk01w4q78TObT9/eh6p4N1gVE6s+bWJfbBfZ/BJUuJQ4c61Ied4SteJ7oT0NVDHrRFKSQ11Ne/wbOnRxFcSS/+BxEkhJav4UgXiB6//JlwNhKgY=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pm5LTv5Xgf3F2MCS+drGysnS6sBbrhG/kNzW5FuxLxY/SuymhHPwjrxyz8Yn?=
 =?us-ascii?Q?Xdg9T6HBEPsbhJUJxEzc4hZbRQjEvueitFsmOUqcNRRexOzYWFwF/R6o/OL1?=
 =?us-ascii?Q?9sYWG4LIugMWMnWxQcNqGS4Q8edAFUolFwYk4EakNVHAy2OERQ6PGyqZwSG2?=
 =?us-ascii?Q?97DvXJPSPzOB96JB6pwZ/476luhyKspUFcmKVfv6wYGiUzJwvcE54q+DleCx?=
 =?us-ascii?Q?ojPB1GANlkzY6FjsE81wgrS7YlOGk05fZypSEM3MpKscRBkLZSd+89SQ4RRf?=
 =?us-ascii?Q?VP2EuTAyawJXuBigKcJ9ljLJgbyLyjN4NbOjAzgUDeI2Qf+6wmQnSVWRCGLx?=
 =?us-ascii?Q?HKWHBcnMou6otFXa+npcvFRcSkpCgirLlUS4KmyjvNu/yhRzWIn/oqZ/beF2?=
 =?us-ascii?Q?nUDCfVc3rOFCqyBCXiJwFVZ1zH8KlDJxf7eGYrrgNmw9wqI6St4Nei+VcEma?=
 =?us-ascii?Q?YmdrGrmqNhljOvH2bgdDQejm7NkTUyht/hSCQrfGCfTBxTQCi4fyMuy0Dmq0?=
 =?us-ascii?Q?lRVvK/+AI3i6ts57BruoQ/ncCHZi8ehPJztNNjCCq+i8y3aoHkzPfombSkiE?=
 =?us-ascii?Q?wQHAefsvZ4Of/9kMy8bN2xctHs0QT96BAojMrq80FlcYxs9+TAGf4JTeCyvh?=
 =?us-ascii?Q?l0osLqQdEpewELNfRCwLxBJvTCrmABMKyDu/MJiLRlx6A+1KIzDk0BFHaRR1?=
 =?us-ascii?Q?DZyQIj/1iFveKHpKpOmYF7QLQ/FZ2zcn41IvjuxNhAdTjJ4NG9z/PyqghEEZ?=
 =?us-ascii?Q?hTWGgI9SsUfM8fan5nRmJgYIwYHXC3GKsxuAm6XO+DOdQaP7GWjkIVUbkZ4g?=
 =?us-ascii?Q?/Wqtj1XCPePBgTYZXKyuj1zqR7hwqoVP8RFs4DJRlIPndelHSYDi4T7G7faU?=
 =?us-ascii?Q?jxeIlFiN8dK2s4bDBtDO/ZdWsIEq8Qy6VInpjcjWwXk4PNp/nA49hjor8+ws?=
 =?us-ascii?Q?bO2QQ59DE8ApSNIy3du/6+dMSzWMKfbW8DscFH2b1cpIJlada/ugfwUDjhEa?=
 =?us-ascii?Q?XCPOqNsa/AShQlmfsJJ/AWmcLwYFWG4GbNpFZVm91qlRwzhOl841OE03/InN?=
 =?us-ascii?Q?glLILeji1GUUCFwEOGLUL0TvgKhUviX1uq6JZDecLIfK65lmM9NYYHiBGATo?=
 =?us-ascii?Q?gxDlFSkoh3Dk4GJ2HeT7eaUq32u8AK8uuhcy1f6pyg/pLc+UuTPyRKqY1psP?=
 =?us-ascii?Q?EkQlxTGX0Asdz05ZEQUGJfoN5wSShZDR7isp0A=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bef372a-4bbe-4ff3-5068-08dc1d7207b5
X-MS-Exchange-CrossTenant-AuthSource: SY6P282MB3733.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 06:51:18.0095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB4029

Stack filter can be used to filter event call stacks,
so that only those trace events whose call stacks match the
stack filters can appear in the trace output.

A new config "CONFIG_TRACE_EVENT_STACK_FILTER" is added, if
enabled, "stack_filter" will be created under the directory
of a trace event. Stack filters can be set by writing or
append to it with format "'!'?((function|'**')'/')*(function|'**')".
A new file "trace_events_stack_filter.c" is added also.

Signed-off-by: Sicheng Liu <lsc2001@outlook.com>
---
 include/linux/trace_events.h             |  39 ++
 kernel/trace/Kconfig                     |  12 +
 kernel/trace/Makefile                    |   3 +
 kernel/trace/trace.c                     |   9 +-
 kernel/trace/trace.h                     |  10 +
 kernel/trace/trace_events.c              |  14 +
 kernel/trace/trace_events_stack_filter.c | 840 +++++++++++++++++++++++
 7 files changed, 925 insertions(+), 2 deletions(-)
 create mode 100644 kernel/trace/trace_events_stack_filter.c

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index d68ff9b1247f..fe138b5b6e52 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -250,6 +250,19 @@ int trace_output_call(struct trace_iterator *iter, char *name, char *fmt, ...)
 
 struct event_filter;
 
+#define STACK_FILTER_ADDR_MAP_SIZE 31
+
+/* A cache to speed up addr_remove_offset */
+struct stack_filter_addr_map {
+	struct hlist_head map[STACK_FILTER_ADDR_MAP_SIZE];
+	spinlock_t lock;
+};
+
+struct event_stack_filter {
+	struct list_head filters;
+	struct stack_filter_addr_map *addr_map;
+};
+
 enum trace_reg {
 	TRACE_REG_REGISTER,
 	TRACE_REG_UNREGISTER,
@@ -493,6 +506,7 @@ enum {
 	EVENT_FILE_FL_PID_FILTER_BIT,
 	EVENT_FILE_FL_WAS_ENABLED_BIT,
 	EVENT_FILE_FL_FREED_BIT,
+	EVENT_FILE_FL_STACK_FILTER_BIT,
 };
 
 extern struct trace_event_file *trace_get_event_file(const char *instance,
@@ -646,12 +660,16 @@ enum {
 	EVENT_FILE_FL_PID_FILTER	= (1 << EVENT_FILE_FL_PID_FILTER_BIT),
 	EVENT_FILE_FL_WAS_ENABLED	= (1 << EVENT_FILE_FL_WAS_ENABLED_BIT),
 	EVENT_FILE_FL_FREED		= (1 << EVENT_FILE_FL_FREED_BIT),
+	EVENT_FILE_FL_STACK_FILTER	= (1 << EVENT_FILE_FL_STACK_FILTER_BIT),
 };
 
 struct trace_event_file {
 	struct list_head		list;
 	struct trace_event_call		*event_call;
 	struct event_filter __rcu	*filter;
+#ifdef CONFIG_TRACE_EVENT_STACK_FILTER
+	struct event_stack_filter __rcu	*stack_filter;
+#endif
 	struct eventfs_inode		*ei;
 	struct trace_array		*tr;
 	struct trace_subsystem_dir	*system;
@@ -717,6 +735,27 @@ enum event_trigger_type {
 
 extern int filter_match_preds(struct event_filter *filter, void *rec);
 
+#ifdef CONFIG_TRACE_EVENT_STACK_FILTER
+extern int stack_filter_match(struct event_stack_filter *stack_filter);
+
+static inline struct event_stack_filter *
+get_stack_filter(struct trace_event_file *file)
+{
+	return rcu_dereference(file->stack_filter);
+}
+#else
+static inline int stack_filter_match(struct event_stack_filter *stack_filter)
+{
+	return 1;
+}
+
+static inline struct event_stack_filter *
+get_stack_filter(struct trace_event_file *file)
+{
+	return NULL;
+}
+#endif // CONFIG_TRACE_EVENT_STACK_FILTER
+
 extern enum event_trigger_type
 event_triggers_call(struct trace_event_file *file,
 		    struct trace_buffer *buffer, void *rec,
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 61c541c36596..2ce5c769e0c1 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -1169,6 +1169,18 @@ config HIST_TRIGGERS_DEBUG
 
           If unsure, say N.
 
+config TRACE_EVENT_STACK_FILTER
+	bool "Enable call stack filter for trace events"
+	default n
+	depends on STACKTRACE
+	depends on KALLSYMS
+	help
+	  This option enables call stack filter for trace events,
+	  so that only those trace events whose call stacks match the
+	  stack filter can appear in the trace output.
+
+	  See Documentation/trace/events.rst for details.
+
 source "kernel/trace/rv/Kconfig"
 
 endif # FTRACE
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 057cd975d014..6deeb9bffa8b 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -82,6 +82,9 @@ obj-$(CONFIG_EVENT_TRACING) += trace_event_perf.o
 endif
 obj-$(CONFIG_EVENT_TRACING) += trace_events_filter.o
 obj-$(CONFIG_EVENT_TRACING) += trace_events_trigger.o
+ifeq ($(CONFIG_TRACE_EVENT_STACK_FILTER),y)
+obj-$(CONFIG_EVENT_TRACING) += trace_events_stack_filter.o
+endif
 obj-$(CONFIG_PROBE_EVENTS) += trace_eprobe.o
 obj-$(CONFIG_TRACE_EVENT_INJECT) += trace_events_inject.o
 obj-$(CONFIG_SYNTH_EVENTS) += trace_events_synth.o
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2a7c6fd934e9..aead7c8111e6 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2842,8 +2842,8 @@ trace_event_buffer_lock_reserve(struct trace_buffer **current_rb,
 
 	*current_rb = tr->array_buffer.buffer;
 
-	if (!tr->no_filter_buffering_ref &&
-	    (trace_file->flags & (EVENT_FILE_FL_SOFT_DISABLED | EVENT_FILE_FL_FILTERED))) {
+	if (!tr->no_filter_buffering_ref && (trace_file->flags &
+	    (EVENT_FILE_FL_SOFT_DISABLED | EVENT_FILE_FL_FILTERED | EVENT_FILE_FL_STACK_FILTER))) {
 		preempt_disable_notrace();
 		/*
 		 * Filtering is on, so try to use the per cpu buffer first.
@@ -2939,6 +2939,11 @@ static void output_printk(struct trace_event_buffer *fbuffer)
 	     !filter_match_preds(file->filter, fbuffer->entry)))
 		return;
 
+	if (IS_ENABLED(CONFIG_TRACE_EVENT_STACK_FILTER) &&
+	    unlikely(file->flags & EVENT_FILE_FL_STACK_FILTER) &&
+	    !stack_filter_match(get_stack_filter(file)))
+		return;
+
 	event = &fbuffer->trace_file->event_call->event;
 
 	raw_spin_lock_irqsave(&tracepoint_iter_lock, flags);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 00f873910c5d..5986bb871343 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1423,6 +1423,7 @@ __event_trigger_test_discard(struct trace_event_file *file,
 
 	if (likely(!(file->flags & (EVENT_FILE_FL_SOFT_DISABLED |
 				    EVENT_FILE_FL_FILTERED |
+				    EVENT_FILE_FL_STACK_FILTER |
 				    EVENT_FILE_FL_PID_FILTER))))
 		return false;
 
@@ -1433,6 +1434,11 @@ __event_trigger_test_discard(struct trace_event_file *file,
 	    !filter_match_preds(file->filter, entry))
 		goto discard;
 
+	if (IS_ENABLED(CONFIG_TRACE_EVENT_STACK_FILTER) &&
+	    (file->flags & EVENT_FILE_FL_STACK_FILTER) &&
+	    !stack_filter_match(get_stack_filter(file)))
+		goto discard;
+
 	if ((file->flags & EVENT_FILE_FL_PID_FILTER) &&
 	    trace_event_ignore_this_pid(file))
 		goto discard;
@@ -1562,6 +1568,10 @@ static inline void *event_file_data(struct file *filp)
 extern struct mutex event_mutex;
 extern struct list_head ftrace_events;
 
+#ifdef CONFIG_TRACE_EVENT_STACK_FILTER
+extern const struct file_operations event_stack_filter_fops;
+#endif
+
 extern const struct file_operations event_trigger_fops;
 extern const struct file_operations event_hist_fops;
 extern const struct file_operations event_hist_debug_fops;
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 7c364b87352e..3647205f3c48 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2502,6 +2502,14 @@ static int event_callback(const char *name, umode_t *mode, void **data,
 			*fops = &ftrace_event_filter_fops;
 			return 1;
 		}
+
+#ifdef CONFIG_TRACE_EVENT_STACK_FILTER
+		if (strcmp(name, "stack_filter") == 0) {
+			*mode = TRACE_MODE_WRITE;
+			*fops = &event_stack_filter_fops;
+			return 1;
+		}
+#endif
 	}
 
 	if (!(call->flags & TRACE_EVENT_FL_IGNORE_ENABLE) ||
@@ -2598,6 +2606,12 @@ event_create_dir(struct eventfs_inode *parent, struct trace_event_file *file)
 			.name		= "inject",
 			.callback	= event_callback,
 		},
+#endif
+#ifdef CONFIG_TRACE_EVENT_STACK_FILTER
+		{
+			.name		= "stack_filter",
+			.callback	= event_callback,
+		},
 #endif
 	};
 
diff --git a/kernel/trace/trace_events_stack_filter.c b/kernel/trace/trace_events_stack_filter.c
new file mode 100644
index 000000000000..79ed9af853ec
--- /dev/null
+++ b/kernel/trace/trace_events_stack_filter.c
@@ -0,0 +1,840 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * trace_events_stack_filter: call stack filter for trace events
+ *
+ * Copyright (C) 2024 Sicheng Liu <lsc2001@outlook.com>
+ */
+
+#include <linux/mutex.h>
+#include <linux/slab.h>
+
+#include "trace.h"
+
+#define PARSER_BUF_SIZE 1023	/* trace parser buf size */
+#define STACK_BUF_SIZE 512	/* call stack buf size */
+
+#define MAX_SF_LEN 64		/* max stack filter length */
+#define DSTARS_ADDR 1		/* '**' wildcard */
+
+#define list_length(head) ({ \
+	int __len = 0; \
+	struct list_head *__pos; \
+	list_for_each(__pos, head) \
+		__len++; \
+	__len; \
+})
+
+#define ADDR_MAP_HASH(key) \
+	(((key) >> 2) % STACK_FILTER_ADDR_MAP_SIZE)
+
+struct function_address {
+	struct list_head list;
+	size_t addr;			/* some addresses may represent wildcards */
+};
+
+struct stack_filter {
+	struct list_head list;
+	char *string;			/* original string */
+	struct list_head addrs;		/* function addresses */
+	bool neg;			/* negate the filter */
+};
+
+struct addr_map_node {
+	struct hlist_node node;
+	unsigned long key;
+	unsigned long value;
+};
+
+static inline void
+function_address_list_clear(struct list_head *faddrs)
+{
+	struct function_address *faddr, *tmp;
+
+	list_for_each_entry_safe(faddr, tmp, faddrs, list) {
+		list_del(&faddr->list);
+		kfree(faddr);
+	}
+}
+
+static inline int
+function_address_list_copy(struct list_head *copy, struct list_head *faddrs)
+{
+	struct function_address *faddr, *new_faddr;
+
+	INIT_LIST_HEAD(copy);
+	list_for_each_entry_reverse(faddr, faddrs, list) {
+		new_faddr = kmalloc(sizeof(*new_faddr), GFP_KERNEL);
+		if (!new_faddr) {
+			function_address_list_clear(copy);
+			return -ENOMEM;
+		}
+		new_faddr->addr = faddr->addr;
+		list_add(&new_faddr->list, copy);
+	}
+	return 0;
+}
+
+static inline void
+stack_filter_init(struct stack_filter *filter)
+{
+	INIT_LIST_HEAD(&filter->addrs);
+}
+
+static inline struct stack_filter *
+stack_filter_new(void)
+{
+	struct stack_filter *filter;
+
+	filter = kzalloc(sizeof(*filter), GFP_KERNEL);
+	if (!filter)
+		return NULL;
+
+	stack_filter_init(filter);
+	return filter;
+}
+
+static inline void
+stack_filter_free(struct stack_filter *filter)
+{
+	struct function_address *faddr, *tmp;
+
+	list_for_each_entry_safe(faddr, tmp, &filter->addrs, list) {
+		list_del(&faddr->list);
+		kfree(faddr);
+	}
+
+	kfree(filter->string);
+	kfree(filter);
+}
+
+static inline int
+stack_filter_copy(struct stack_filter *copy, struct stack_filter *filter)
+{
+	int ret = 0;
+
+	copy->string = kstrdup(filter->string, GFP_KERNEL);
+	if (!copy->string)
+		return -ENOMEM;
+
+	ret = function_address_list_copy(&copy->addrs, &filter->addrs);
+	if (ret < 0) {
+		kfree(copy->string);
+		return ret;
+	}
+
+	copy->neg = filter->neg;
+	return 0;
+}
+
+static inline void
+stack_filter_list_clear(struct list_head *filters)
+{
+	struct stack_filter *filter, *tmp;
+
+	list_for_each_entry_safe(filter, tmp, filters, list) {
+		list_del(&filter->list);
+		stack_filter_free(filter);
+	}
+}
+
+static inline int
+stack_filter_list_copy(struct list_head *copy, struct list_head *filters)
+{
+	int ret = 0;
+	struct stack_filter *filter, *new_filter;
+
+	/* merge initialization with copy */
+	INIT_LIST_HEAD(copy);
+	list_for_each_entry_reverse(filter, filters, list) {
+		new_filter = kmalloc(sizeof(*new_filter), GFP_KERNEL);
+		if (!new_filter) {
+			ret = -ENOMEM;
+			goto bad;
+		}
+
+		ret = stack_filter_copy(new_filter, filter);
+		if (ret < 0)
+			goto bad;
+
+		list_add(&new_filter->list, copy);
+	}
+	return 0;
+
+ bad:
+	stack_filter_list_clear(copy);
+	return ret;
+}
+
+static inline void
+stack_filter_enable(struct trace_event_file *file)
+{
+	unsigned long old_flags = file->flags;
+
+	file->flags |= EVENT_FILE_FL_STACK_FILTER;
+	if (file->flags != old_flags)
+		trace_buffered_event_enable();
+}
+
+static inline void
+stack_filter_disable(struct trace_event_file *file)
+{
+	unsigned long old_flags = file->flags;
+
+	file->flags &= ~EVENT_FILE_FL_STACK_FILTER;
+	if (file->flags != old_flags)
+		trace_buffered_event_disable();
+}
+
+static inline void
+addr_map_init(struct stack_filter_addr_map *addr_map)
+{
+	int i;
+
+	for (i = 0; i < STACK_FILTER_ADDR_MAP_SIZE; i++)
+		INIT_HLIST_HEAD(&addr_map->map[i]);
+	spin_lock_init(&addr_map->lock);
+}
+
+/*
+ * Typically, the number of functions in the call stack of a trace event
+ * is not large, so we use a simple hash table to store the mapping,
+ * without limiting its cache size.
+ */
+static inline int
+addr_map_insert(struct stack_filter_addr_map *addr_map, unsigned long key, unsigned long value)
+{
+	struct addr_map_node *node;
+	int idx, ret = 0;
+	unsigned long flags;
+
+	idx = ADDR_MAP_HASH(key);
+	spin_lock_irqsave(&addr_map->lock, flags);
+
+	hlist_for_each_entry(node, &addr_map->map[idx], node) {
+		/* new value is always the same as the old here... maybe */
+		if (node->key == key)
+			goto out;
+	}
+
+	node = kmalloc(sizeof(*node), GFP_ATOMIC);
+	if (!node) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	node->key = key;
+	node->value = value;
+
+	hlist_add_head_rcu(&node->node, &addr_map->map[idx]);
+
+ out:
+	spin_unlock_irqrestore(&addr_map->lock, flags);
+	return ret;
+}
+
+static inline unsigned long
+addr_map_get(struct stack_filter_addr_map *addr_map, unsigned long key)
+{
+	struct addr_map_node *node;
+	int idx;
+	unsigned long ret = 0; /* value can't be 0 */
+
+	idx = ADDR_MAP_HASH(key);
+	/* nested critical section, not necessary in fact */
+	rcu_read_lock_sched();
+
+	hlist_for_each_entry_rcu(node, &addr_map->map[idx], node) {
+		if (node->key == key) {
+			ret = node->value;
+			goto out;
+		}
+	}
+
+ out:
+	rcu_read_unlock_sched();
+	return ret;
+}
+
+/* Require holding event_mutex */
+static inline void
+addr_map_clear(struct hlist_head *addr_map)
+{
+	int i;
+	struct addr_map_node *node;
+	struct hlist_node *tmp;
+
+	for (i = 0; i < STACK_FILTER_ADDR_MAP_SIZE; i++) {
+		hlist_for_each_entry_safe(node, tmp, &addr_map[i], node) {
+			hlist_del(&node->node);
+			kfree(node);
+		}
+	}
+}
+
+static inline void
+addr_map_free(struct stack_filter_addr_map *addr_map)
+{
+	addr_map_clear(addr_map->map);
+	kfree(addr_map);
+}
+
+static inline void
+event_stack_filter_init(struct event_stack_filter *esf)
+{
+	INIT_LIST_HEAD(&esf->filters);
+
+	/* addr_map should be pre-allocated, just init it here */
+	addr_map_init(esf->addr_map);
+}
+
+static inline struct event_stack_filter *
+event_stack_filter_new(void)
+{
+	struct event_stack_filter *esf;
+
+	esf = kmalloc(sizeof(*esf), GFP_KERNEL);
+	if (!esf)
+		return NULL;
+
+	esf->addr_map = kmalloc(sizeof(*esf->addr_map), GFP_KERNEL);
+	if (!esf->addr_map)
+		return NULL;
+
+	event_stack_filter_init(esf);
+	return esf;
+}
+
+static inline void
+event_stack_filter_free(struct event_stack_filter *esf, bool free_addr_map)
+{
+	stack_filter_list_clear(&esf->filters);
+
+	/*
+	 * addr_map may be passed to a new event_stack_filter,
+	 * in this situation, we cannot free it.
+	 */
+	if (free_addr_map)
+		addr_map_free(esf->addr_map);
+
+	kfree(esf);
+}
+
+/* Require holding event_mutex */
+static inline int
+event_stack_filter_copy(struct event_stack_filter *copy,
+			struct event_stack_filter *esf)
+{
+	int ret;
+
+	ret = stack_filter_list_copy(&copy->filters, &esf->filters);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Not use deepcopy here to speed up copy.
+	 * Must be vigilant about this when use or free addr_map.
+	 */
+	copy->addr_map = esf->addr_map;
+	return 0;
+}
+
+/*
+ * Allocate a new event_stack_filter and copy the old one.
+ * Require holding event_mutex.
+ */
+static inline struct event_stack_filter *
+event_stack_filter_clone(struct event_stack_filter *esf)
+{
+	struct event_stack_filter *copy;
+
+	copy = kmalloc(sizeof(*copy), GFP_KERNEL);
+	if (!copy)
+		return NULL;
+
+	if (event_stack_filter_copy(copy, esf) < 0) {
+		kfree(copy);
+		return NULL;
+	}
+
+	return copy;
+}
+
+/*
+ * Parse a string with the form below:
+ *   '!'?((function|'**')'/')*(function|'**')
+ * where:
+ *   '!' negates the filter
+ *   '**' matches any function call path
+ * e.g.
+ *   [1] work_pending/do_notify_resume/schedule/__schedule
+ *   [2] '**'/kthread/kcompactd/schedule_timeout/schedule/'**'
+ *   [3] !el0_sync/el0_sync_handler/'**'/invoke_syscall/'**'/schedule
+ *   [4] !ret_from_fork/'**'/kthread/worker_thread/schedule
+ *
+ * The full call path will end at stack_filter_match function,
+ * like "work_pending/do_notify_resume/schedule/__schedule/\
+ *   trace_event_raw_event_sched_switch/trace_event_buffer_commit/stack_filter_match".
+ *
+ * Call paths that matches example [1] can also match
+ *   schedule/__schedule/'**' or '**'/schedule/__schedule/'**'.
+ *
+ * We convert symbols to their addresses here to avoid
+ * changing stacktrace addresses to their names at runtime,
+ * which would greatly slow down the function call.
+ * The downside is that we can't handle '*' wildcard.
+ */
+static int
+stack_filter_parse(struct stack_filter *filter, char *buf)
+{
+	char *p = buf;
+	char name[KSYM_NAME_LEN];
+	struct function_address *faddr, *tmp;
+	size_t addr;
+	int i, len = 0, ret = 0;
+
+	if (*p == '!') {
+		filter->neg = true;
+		p++;
+	}
+	if (*p == '\0')
+		return -EINVAL;
+
+	while (*p) {
+		i = 0;
+		while (*p && *p != '/') {
+			name[i++] = *(p++);
+			if (i > NAME_MAX) {
+				ret = -EINVAL;
+				goto bad;
+			}
+		}
+		name[i] = '\0';
+
+		while (*p == '/')
+			p++;
+
+		if (!strcmp(name, "**")) {
+			/* wildcard '**' */
+			addr = DSTARS_ADDR;
+		} else {
+			/* function name (maybe empty) */
+			addr = kallsyms_lookup_name(name);
+			if (!addr) {
+				ret = -EINVAL;
+				goto bad;
+			}
+		}
+
+		/* remove repetitive '**' */
+		if (addr == DSTARS_ADDR && !list_empty(&filter->addrs)) {
+			faddr = list_first_entry(&filter->addrs, struct function_address, list);
+
+			if (faddr->addr == DSTARS_ADDR)
+				continue;
+		}
+
+		if (++len > MAX_SF_LEN) {
+			ret = -EINVAL;
+			goto bad;
+		}
+
+		faddr = kzalloc(sizeof(*faddr), GFP_KERNEL);
+		if (!faddr) {
+			ret = -ENOMEM;
+			goto bad;
+		}
+
+		faddr->addr = addr;
+		list_add(&faddr->list, &filter->addrs);
+	}
+
+	if (list_empty(&filter->addrs))
+		return -EINVAL;
+
+	if (list_first_entry(&filter->addrs, struct function_address, list)->addr != DSTARS_ADDR) {
+		/* add '**' at the end */
+		faddr = kzalloc(sizeof(*faddr), GFP_KERNEL);
+		if (!faddr) {
+			ret = -ENOMEM;
+			goto bad;
+		}
+		faddr->addr = DSTARS_ADDR;
+		list_add(&faddr->list, &filter->addrs);
+	}
+
+	/* save original string as well */
+	filter->string = kstrdup(buf, GFP_KERNEL);
+	if (!filter->string) {
+		ret = -ENOMEM;
+		goto bad;
+	}
+
+	return ret;
+
+ bad:
+	list_for_each_entry_safe(faddr, tmp, &filter->addrs, list) {
+		list_del(&faddr->list);
+		kfree(faddr);
+	}
+	return ret;
+}
+
+/*
+ * Match the call stack with one stack filter.
+ */
+static bool
+__stack_filter_match_one(struct stack_filter *filter,
+			 unsigned long *buf, int num_entries, bool *dp)
+{
+	int num_faddrs, i, j;
+	bool ok;
+	struct function_address *faddr;
+
+	num_faddrs = list_length(&filter->addrs);
+
+#define pos(i, j) ((i) * (num_faddrs + 1) + (j))
+
+	/* dynamic programming */
+	dp[pos(0, 0)] = true;
+	ok = false;
+
+	for (i = 0; i <= num_entries; i++) {
+		faddr = list_entry(&filter->addrs, struct function_address, list);
+		for (j = 1; j <= num_faddrs; j++) {
+			faddr = list_next_entry(faddr, list);
+			dp[pos(i, j)] = false;
+
+			if (faddr->addr == DSTARS_ADDR) {
+				dp[pos(i, j)] = dp[pos(i, j - 1)];
+				if (i > 0)
+					dp[pos(i, j)] |= dp[pos(i - 1, j)];
+			} else if (i > 0 && buf[i - 1] == faddr->addr)
+				dp[pos(i, j)] = dp[pos(i - 1, j - 1)];
+		}
+
+		if (dp[pos(i, num_faddrs)]) {
+			ok = true;
+			break;
+		}
+	}
+
+#undef pos
+
+	return ok;
+}
+
+/*
+ * Convert function_address + offset to function_address.
+ * Return 0 on error.
+ */
+static inline unsigned long
+addr_remove_offset(struct event_stack_filter *esf, unsigned long addr)
+{
+	unsigned long new_addr;
+	char name[KSYM_NAME_LEN];
+
+	/*
+	 * This operation is very slow,
+	 * so we use a small cache to optimize it.
+	 */
+	new_addr = addr_map_get(esf->addr_map, addr);
+	if (new_addr)
+		return new_addr;
+
+	if (lookup_symbol_name(addr, name) < 0)
+		return 0;
+
+	new_addr = kallsyms_lookup_name(name);
+	if (!new_addr)
+		return 0;
+
+	if (addr_map_insert(esf->addr_map, addr, new_addr) < 0)
+		return 0;
+
+	return new_addr;
+}
+
+/*
+ * return 1 on matching and 0 otherwise.
+ *
+ * A call path is matched successfully if the following conditions are met simultaneously:
+ * [1] It matches any positive stack filter.
+ * [2] It doesn't match any negative stack filter.
+ * If no positive filter are set, condition [1] don't need to be satisified.
+ */
+int stack_filter_match(struct event_stack_filter *esf)
+{
+	int i, num_entries, num_faddrs;
+	int size, maxsize;
+	bool hasp, okp, *dp;
+	struct stack_filter *filter;
+	unsigned long *buf, new_addr;
+	struct list_head *stack_filters;
+
+	/*
+	 * We have already been inside rcu_read_lock_sched critical section.
+	 * It's safe to visit esf.
+	 */
+	if (!esf)
+		return 1;
+
+	stack_filters = &esf->filters;
+	if (list_empty(stack_filters))
+		return 1;
+
+	buf = kmalloc_array(STACK_BUF_SIZE, sizeof(*buf), GFP_ATOMIC);
+	if (!buf)
+		return 0;
+
+	num_entries = stack_trace_save(buf, STACK_BUF_SIZE, 0);
+
+	for (i = num_entries - 1; i >= 0; i--) {
+		/*
+		 * buf[i] contains addr of a symbol plus an offset.
+		 * We should remove the offset here.
+		 */
+		new_addr = addr_remove_offset(esf, buf[i]);
+		if (new_addr)
+			buf[i] = new_addr;
+	}
+
+	/* pre allocate memory for dp */
+	maxsize = 0;
+	list_for_each_entry(filter, stack_filters, list) {
+		num_faddrs = list_length(&filter->addrs);
+		size = (num_entries + 1) * (num_faddrs + 1);
+
+		if (size > maxsize)
+			maxsize = size;
+	}
+
+	dp = kmalloc(maxsize, GFP_ATOMIC);
+	if (!dp) {
+		kfree(buf);
+		return 0;
+	}
+
+	hasp = 0; okp = 0;
+	list_for_each_entry(filter, stack_filters, list) {
+		if (!filter->neg) {
+			hasp = 1;
+			if (__stack_filter_match_one(filter, buf, num_entries, dp)) {
+				okp = 1;
+				break;
+			}
+		}
+	}
+	if (hasp && !okp)
+		goto bad_match;
+
+	list_for_each_entry(filter, stack_filters, list) {
+		if (filter->neg && __stack_filter_match_one(filter, buf, num_entries, dp))
+			goto bad_match;
+	}
+
+	kfree(dp);
+	kfree(buf);
+	return 1;
+
+ bad_match:
+	kfree(dp);
+	kfree(buf);
+	return 0;
+}
+
+/*
+ * Use seq_file APIs to read from stack_filters
+ */
+static void *sf_start(struct seq_file *m, loff_t *pos)
+{
+	struct trace_event_file *file;
+	loff_t n = *pos;
+
+	mutex_lock(&event_mutex);
+	file = m->private;
+
+	if (!file->stack_filter)
+		return NULL;
+
+	return seq_list_start(&file->stack_filter->filters, n);
+}
+
+static void *sf_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct trace_event_file *file = m->private;
+
+	return seq_list_next(v, &file->stack_filter->filters, pos);
+}
+
+static void sf_stop(struct seq_file *m, void *v)
+{
+	mutex_unlock(&event_mutex);
+}
+
+static int sf_show(struct seq_file *m, void *v)
+{
+	struct stack_filter *filter = v;
+
+	seq_printf(m, "%s\n", filter->string);
+	return 0;
+}
+
+const struct seq_operations stack_filter_seq_ops = {
+	.start = sf_start,
+	.stop = sf_stop,
+	.next = sf_next,
+	.show = sf_show,
+};
+
+static ssize_t
+event_stack_filter_write(struct file *filp, const char __user *ubuf,
+			 size_t cnt, loff_t *ppos)
+{
+	struct trace_event_file *event_file;
+	struct trace_parser parser;
+	struct stack_filter *filter;
+	struct event_stack_filter *esf, *old;
+	int read, ret;
+
+	filter = stack_filter_new();
+	if (!filter)
+		return -ENOMEM;
+
+	if (trace_parser_get_init(&parser, PARSER_BUF_SIZE + 1)) {
+		kfree(filter);
+		return -ENOMEM;
+	}
+
+	read = trace_get_user(&parser, ubuf, cnt, ppos);
+
+	if (read >= 0 && trace_parser_loaded(&parser)) {
+		/*
+		 * e.g. use 'echo 0 > stack_filter' to disable stack_filter
+		 * Most data structures has been cleared in event_stack_filter_open.
+		 * Just make some judgements to avoid reporting error.
+		 */
+		if (!strcmp(strstrip(parser.buffer), "0")) {
+			kfree(filter);
+			trace_parser_put(&parser);
+
+			event_file = event_file_data(filp);
+			if (!rcu_dereference(event_file->stack_filter))
+				return read;
+
+			/* maybe use append mode or something else */
+			return -EINVAL;
+		}
+
+		ret = stack_filter_parse(filter, parser.buffer);
+		if (ret < 0) {
+			kfree(filter);
+			trace_parser_put(&parser);
+			return ret;
+		}
+	} else {
+		kfree(filter);
+		goto out;
+	}
+
+	mutex_lock(&event_mutex);
+	event_file = event_file_data(filp);
+
+	if (event_file->stack_filter) {
+		/*
+		 * Copy the old and replace it with the new one to follow rcu rules.
+		 * It doesn't cost much time since this function is called seldomly.
+		 * In this way, codes can be simple.
+		 *
+		 * We didn't use a separate rcu for stack_filter->filters
+		 * since its elements cannot be deleted one by one.
+		 */
+		esf = event_stack_filter_clone(event_file->stack_filter);
+		if (!esf) {
+			mutex_unlock(&event_mutex);
+			stack_filter_free(filter);
+			goto out;
+		}
+		list_add_tail(&filter->list, &esf->filters);
+
+		old = event_file->stack_filter;
+		rcu_assign_pointer(event_file->stack_filter, esf);
+
+		/* make sure old esf is not being used */
+		tracepoint_synchronize_unregister();
+		event_stack_filter_free(old, false);
+
+	} else {
+		esf = event_stack_filter_new();
+		if (!esf) {
+			mutex_unlock(&event_mutex);
+			stack_filter_free(filter);
+			goto out;
+		}
+		list_add_tail(&filter->list, &esf->filters);
+
+		rcu_assign_pointer(event_file->stack_filter, esf);
+		tracepoint_synchronize_unregister();
+
+		stack_filter_enable(event_file);
+	}
+
+	mutex_unlock(&event_mutex);
+
+ out:
+	trace_parser_put(&parser);
+	return read;
+}
+
+static int event_stack_filter_open(struct inode *inode, struct file *filp)
+{
+	int ret;
+	struct trace_event_file *event_file;
+	struct event_stack_filter *esf;
+	struct seq_file *seq;
+
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
+	mutex_lock(&event_mutex);
+
+	event_file = inode->i_private;
+	if (!event_file) {
+		mutex_unlock(&event_mutex);
+		return -ENODEV;
+	}
+
+	if ((filp->f_mode & FMODE_WRITE) && (filp->f_flags & O_TRUNC)) {
+		stack_filter_disable(event_file);
+
+		if (event_file->stack_filter) {
+			esf = event_file->stack_filter;
+			RCU_INIT_POINTER(event_file->stack_filter, NULL);
+
+			/* wait until esf is not being used */
+			tracepoint_synchronize_unregister();
+			event_stack_filter_free(esf, true);
+		}
+	}
+
+	ret = seq_open(filp, &stack_filter_seq_ops);
+	if (!ret) {
+		seq = filp->private_data;
+		seq->private = inode->i_private;
+	}
+
+	mutex_unlock(&event_mutex);
+
+	return ret;
+}
+
+/*
+ * Operations for file "stack_filter"
+ */
+const struct file_operations event_stack_filter_fops = {
+	.open = event_stack_filter_open,
+	.read = seq_read,
+	.write = event_stack_filter_write,
+	.llseek = tracing_lseek,
+	.release = seq_release,
+};
-- 
2.25.1



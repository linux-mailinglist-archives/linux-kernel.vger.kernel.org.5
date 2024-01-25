Return-Path: <linux-kernel+bounces-38053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBB083BA51
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6387E1C221AD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097F310A39;
	Thu, 25 Jan 2024 06:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="h1SUt6gg"
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2178.outbound.protection.outlook.com [40.92.63.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3381311723;
	Thu, 25 Jan 2024 06:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706165494; cv=fail; b=f72NPQzZm5XqMiFQ/3yVCWHaJoK1fmAzQwSEZUSFV3UhTH+BFm8UW+CxEZHZReUtxUMm9jP5Wlko+OKERoe8Dl8Td+utXtm8rwioI6DA/itDJDf7wOpTGxX9d6U00yCtCeHh3C+K/JUyG1ppo/8RZPppXVF67iNDiyj9tb9WiiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706165494; c=relaxed/simple;
	bh=H5oo9fMDvmyRXtboYoBoDcjYLsic17ULgksQRuv3WHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hym37PbYzPCgu2BxuU755rAawkLLlyyY89yqiCQnhyySrKsq2Aa7Vb7+FOEipyM+aSJCtHQfvs8EejHmnu+D3HFzE2k4leQEcHevZR7oTw7Xv1msfqmYFl4k8s93NMZ8AFrxMBB/w7CLYoS07JIwPeBXgV6rW3mdy31L7oliNzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=h1SUt6gg; arc=fail smtp.client-ip=40.92.63.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhR+2N87aNl8pRWqVuTrefqeCt8YmOKmpjb/q+uX6/PRG/QQJ9BkSgysv73GGfNdMOp9E0H+HmIPAD3OKV6E1Mb1tUR7rWC7AAPRG+uDjfyBCk1Mj7RPcl1aAXwybPIcnmzE9mgIp5/2IJVwThCyIBDCPVOqAYTUdD4k1/gWkdIAiuq+B0wtLrnZslNOzau68dyfau49R4b0ztisOWXzYxNtW8i7+7bFU69XHtmnV/TmMCaWCYHePHrLR2AcmjhJWjrPSfvkbwzba/oElVIlvd2l9xJhH953FOTCZXOrJsy9sVQxsUwfWCdk4Bx7JVIy454rOGlW7RNga3Uvrcxt1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7W7VNPvYcuOXvUCFc8UbWTbHf04XxEKz0gfzGXcVGw=;
 b=RE+h9OrsbYDFWxxJ60EwBOQUOIGjDuuOn2ARiVqKzN7SqjulQVEtR8mJaEF38vwtTXd59FK4HWnqDFdEM7msLC2+GEQqnKoJGw+eC99TMEszMBPRnNqsS3XkLw5uqebah2wC6kC9RhdDyX4NTsG34HdE7iOxPtMdKVE0fv7NM6qig0tOFXO1q7VWjMy31u0kTj4B7bAy3RIoI5OMX/DBDFLVv+OHrRXqSYbQF0NmmtJLSquSeek3do0LyBVeGDO3n/w2JXvsoHa9noAm68sudk0NFWJWsp9ArkSfXAeFxu1swC3A8Plx7y4+mIRNs8hn1/5oTTfrWv9jVoeqGqYyVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7W7VNPvYcuOXvUCFc8UbWTbHf04XxEKz0gfzGXcVGw=;
 b=h1SUt6ggPGcDiiCBoUxX+qPnllQVwpBoTQd7fKcPaxg/AZ8uBPNxOwSt0CEJzupJ4kPYqkJSkokvDobD3it+VSlqqWn9zG5bhreXdee8LE75nq5FnARn3Y2iW0HvOjlhBtRg6Fp+D70sgPDZx3S0raNyf9BBZImgYEiWZpi2hJ7EWI2smTLxRwWK4Pv/Dzl+oJmfkcSqNhyXsLeYSzu/65dv8jdG71Dv9FTZJmI1kncXKtmY1B2LhMgE/5EQjQd7/uyjzu6wDNt6rC/4Xx7o4U5DWZgpgo58MpiNVaZnEZ9aBlV9eLkuUWv6yjKSaEhKidWVF3crRUPD7gGMjsvHsg==
Received: from SY6P282MB3733.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1bc::5) by
 SY4P282MB4029.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1c4::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.22; Thu, 25 Jan 2024 06:51:27 +0000
Received: from SY6P282MB3733.AUSP282.PROD.OUTLOOK.COM
 ([fe80::8179:fed2:b690:d022]) by SY6P282MB3733.AUSP282.PROD.OUTLOOK.COM
 ([fe80::8179:fed2:b690:d022%5]) with mapi id 15.20.7228.023; Thu, 25 Jan 2024
 06:51:27 +0000
From: Sicheng Liu <lsc2001@outlook.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	corbet@lwn.net,
	Sicheng Liu <lsc2001@outlook.com>
Subject: [RFC PATCH 2/2] tracing: Add documentation for event stack filter
Date: Thu, 25 Jan 2024 06:50:22 +0000
Message-ID:
 <SY6P282MB3733566FFFD39BAC0AC452D5A37A2@SY6P282MB3733.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240125065022.1739502-1-lsc2001@outlook.com>
References: <20240125065022.1739502-1-lsc2001@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [at4e0T06qSPJ8EDJ9/Bei1rtJij2fbNR]
X-ClientProxiedBy: SG2PR04CA0180.apcprd04.prod.outlook.com
 (2603:1096:4:14::18) To SY6P282MB3733.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:1bc::5)
X-Microsoft-Original-Message-ID:
 <20240125065022.1739502-2-lsc2001@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY6P282MB3733:EE_|SY4P282MB4029:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b781609-9b3d-4e73-1d01-08dc1d720db8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Wm7K51Q8gPfYRSGl44XQ1K4J2QBmcnMsYe0ka5X6iXGNHyt8Wnu6EZsYYYFGY8lGIMsFbLQ3Ger6FEyXMeHMIjq+l8ldVdI5ogPNr+ckMpJRglDJuuBX4Eyv0VXeeY6Gp6VNpd2GwDGlR9snUg3g9mkgf1sJBPG4Fn3HVKYWqg5Pgn9yjmWWhLfCd+ehkYwLbGwMn1ZevRjQ8K8I0AAH7Yc6Jt/LuFEI9dju/A4BEq0DADqgi8AuV9yOK1JqbHuRWyd1UMIeKao+i5/QHEdnnrcVZVLobsQ68PNKSQl7MO8MrA/I5WiK3rcRuwihpfm6ZLGZk5SH7BhKJL5Zml2V2gl8bDn7onP8qFQptTHHIaIG2PmC3EhlEdQiezFBdBQBIWEPEdjuCj1cdx9VATY+uFU4FlGw5IIJ+fIEVnHK7s6aeKI4SfMmAwY2P7mHbqjZ/oICgk2xcFIi0U9N2WcgEtYHDAVFV9tiuBwt6hg/NmbNmVEvv3VO9K3KalAjiBVwkKrPuegi45NmRqu5uNykvvC3q9AdRwnSZn6XtnUOw3D5PgSBMOjxoHdOhJ0vpk334JY2E34Kqg+nmxshgQiQwUOFQ9bwHuH8K8hqEtaZ9i7nNmRmfybUDW7gVChSu4io
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AZ8go9s4SdWVtwC0psmw313+n1Y2iI8lWb0apsg1Q69MF+pnjUsAPAsdE7YF?=
 =?us-ascii?Q?UUMY+Osn6DBfaEWOBc6wtVRQE/GbDj7jG/76Tg1+Q2cHJp/W4Nt8I/2/JpEr?=
 =?us-ascii?Q?RQHhNJ4+/q/0fD+8lghcGbXwAJnM/QrSMd/xVxE0jRyQDkd1AhGYIbi9tMYv?=
 =?us-ascii?Q?ZwPmbFT9dJt9MEE4x21cYVI2RoFPlATTu4vDZS+niU3l4ZIhq2A7u891pE/k?=
 =?us-ascii?Q?NLh7tvfTxzZ6YaPOAl8/swsndlfRQGtfJ2BqOdvan5wDZH8MdZwLPiRm8vC8?=
 =?us-ascii?Q?xyUGI10ZSDkHCMt/JA+QjgqvV+2yZyjeesjrzAIiaszgo22KJxzk8Le/TNj1?=
 =?us-ascii?Q?HiGDPg+Bt0KAhInVXpgrGPjDz8hTQqywgAjUchqVrl6K/KfnYfk9yY7T+Zl1?=
 =?us-ascii?Q?u3HlywBvjUOzx44oWFvyCqh118GP52xSAbfSP/1mvUBc7C29NrZVTtIsYZ6Y?=
 =?us-ascii?Q?O2jwJWK53xACrktsUnE4qb34BntdZ5iyVQhgtANfwtje+KsWJVAeiEai7Yv6?=
 =?us-ascii?Q?lGF4h7VCoPXCJZJeGavuzrqnnQ86XJ0zDRGas3LLUSX+WX7VLcfBsbKYrcBy?=
 =?us-ascii?Q?rijEJFb+gipFmfMMRWMuKXN+fWJqB06rb/AxRuEXGt6byzW0RO3AVPBu1QOw?=
 =?us-ascii?Q?3x9IJb5HjG7NIpnAF/gdDcFh22KUHtlTscHF8fjJScyqRcX3AiFtxv+/6NVs?=
 =?us-ascii?Q?85ZMW2Hm+AMJOj2Mg6VJJEijMI0nCRewUZO2O/9JtzTKrUgQ9z0Vfqr4fkUU?=
 =?us-ascii?Q?fZiJsySb3cUy6HuyZcO12Rf+z7OZPYfpEEoS6etkgR/ag0QvvoXBnb0ut6TO?=
 =?us-ascii?Q?NdytdlLAGerS7ltsS9iUczlm/PnWmFBGIaFytd2XcAidAgJ/refyWIKCZyhu?=
 =?us-ascii?Q?DjplEr3BP3DlPjNM83oNGCuZ0aVdYvY2YNvfnfPAdTeVC7ekGG3GsSamZ2u5?=
 =?us-ascii?Q?FLmlduuTOXp9UyltcCUz3WIMAvB6ddLseooWFQDMC4IWtsIPBGiL8BwghMKG?=
 =?us-ascii?Q?kVPeoR67YvF9SLG5wTWjWNNWMTXof7/HNaqLFs8vxnW/Utn43chRdttrQJXW?=
 =?us-ascii?Q?o3LYYaUuQV1IYcJ3Isr5/c/0Pt9cHM9HNHtq3bxugO2AcQ33H3JjowT7gH/U?=
 =?us-ascii?Q?HG2nCfFASp60PKCDjhYS+Of9vS2yC9UhOLI5ttDDXjjEzlYQON+cOfmdx0aI?=
 =?us-ascii?Q?wGJh//ufUJ1tYIKOYIScg5DuA4/T0DizHmMzFw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b781609-9b3d-4e73-1d01-08dc1d720db8
X-MS-Exchange-CrossTenant-AuthSource: SY6P282MB3733.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 06:51:27.6846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB4029

A new chapter describing how to use trace event stack
filter is added to the documentation.

Signed-off-by: Sicheng Liu <lsc2001@outlook.com>
---
 Documentation/trace/events.rst | 88 ++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
index 759907c20e75..718a6d078e24 100644
--- a/Documentation/trace/events.rst
+++ b/Documentation/trace/events.rst
@@ -350,6 +350,94 @@ To add more PIDs without losing the PIDs already included, use '>>'.
 
 	# echo 123 244 1 >> set_event_pid
 
+5.6 Stack filters
+---------------------
+
+Trace events can be filtered by their call stacks.  There could exist
+various paths to tigger an trace event, but people sometimes only care
+about some of them.  Once the stack filter is set, call stack of the
+corresponding event will be compared with the stack filter.  An event
+with matched call stack will appear in the trace output and the rest will
+be discarded.
+
+5.6.1 Expression syntax
+------------------------
+
+Stack filters have the form (in regular expression style) below::
+
+  '!'?((function|'**')'/')*(function|'**')
+
+In the expression, '!' means negating the filter and '**' matches any
+call path (maybe empty).  The top of call stack will be ``stack_filter_match``,
+which means the call path will be something like ``**/stack_filter_match``.
+
+A stack filter matches if the call stack contains it, which means that
+``ret_from_fork/**/schedule`` has the same effect as
+``**/ret_from_fork/**/schedule/**``.
+
+A call stack is matched successfully if the following conditions are
+met simultaneously:
+[1] It matches any positive stack filter.
+[2] It doesn't match any negative stack filter.
+If no positive filter are set, condition 1 don't need to be satisified.
+
+5.6.2 Setting stack filters
+---------------------------
+
+Stack filters are add by echo commands to 'stack_filter' file for a given
+event, and unset by echo 0 or blank string to the same file.
+
+An usage example (on x86_64 platform):
+
+The call stack contains ``ret_from_fork`` but not ``do_syscall_64``::
+
+  # cd /sys/kernel/tracing/events/sched/sched_switch
+  # echo 'ret_from_fork' > stack_filter
+  # echo '!do_syscall_64' >> stack_filter
+  # cat stack_filter
+
+Another example (on arm64 platform):
+
+Set up a kprobe::
+
+  # echo 1 > /sys/kernel/tracing/options/stacktrace
+  # echo 'p alloc_pages' > /sys/kernel/tracing/kprobe_events
+
+The call stack contains ``copy_process``::
+
+  # echo 'copy_process' > \
+      /sys/kernel/tracing/events/kprobes/p_alloc_pages_0/stack_filter
+
+The call stack doesn't contain ``copy_process``::
+
+  # echo '!copy_process' > \
+      /sys/kernel/tracing/events/kprobes/p_alloc_pages_0/stack_filter
+
+The call stack contains ``copy_process`` or ``do_exit``,
+but not ``free_pgtables``::
+
+  # echo 'copy_process' > \
+      /sys/kernel/tracing/events/kprobes/p_alloc_pages_0/stack_filter
+  # echo 'do_exit' >> \
+      /sys/kernel/tracing/events/kprobes/p_alloc_pages_0/stack_filter
+  # echo '!free_pgtables' >> \
+      /sys/kernel/tracing/events/kprobes/p_alloc_pages_0/stack_filter
+
+The call stack contains ``invoke_syscall -> ... -> copy_process``::
+
+  # echo 'invoke_syscall/**/copy_process' > \
+      /sys/kernel/tracing/events/kprobes/p_alloc_pages_0/stack_filter
+
+Enable the kprobe event and check the trace log::
+
+  # echo 1 > /sys/kernel/tracing/events/kprobes/enable
+  # cat /sys/kernel/tracing/trace
+
+Disable the stack filter::
+
+  # echo 0 > stack_filter
+  or
+  # echo > stack_filter
 
 6. Event triggers
 =================
-- 
2.25.1



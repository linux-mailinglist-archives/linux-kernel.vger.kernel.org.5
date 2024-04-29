Return-Path: <linux-kernel+bounces-162769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD0E8B604C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16D6E281D85
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8EA1272AE;
	Mon, 29 Apr 2024 17:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="a/wz8vQw"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01olkn2037.outbound.protection.outlook.com [40.92.65.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3236B839FD;
	Mon, 29 Apr 2024 17:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.65.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714412481; cv=fail; b=IMgeMvXpqyQPiMWWn3mXBLA5RglIS+rjk9UdIbJ9PBh/faEhyPgSb/RY/09WgO4ItMhMRUiiQgKAkd9vTPWHJ/41dLTF0UyNKGKOlsROn+0DcIUM20F2xJuDF54OM4meq3TdQ4AeI7/H0KORYdKuEIdk1NRJiMbLoYN0qz7K0KU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714412481; c=relaxed/simple;
	bh=ar9SEijz37AQCGGiKZ7UhH4kivi9dngO9zNds94VKCU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UZ9mJKaOtmb5C3BGUPeuHuBfYq7cjMD6S4j6NB1ydneTgsBNdHcYJtLhsxU0F8civOWRMp/pDlIS+mEDAEfXP/6Bi7H8Hzv5pjNn0Q+YGXcVKGZfm/Afo8F8S6hTUZancpoSOW9v9eQ/8DjDFQvhgIIJ6ZP9mH4sAVGLy74ZXSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=a/wz8vQw; arc=fail smtp.client-ip=40.92.65.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LV13rBt+eBGexJHYUeQP6fgngIsA6+itN0HjvFfQ9lrMATzAX7oJXSfjtS7nVdXbE/4yp+ernoC7pPhxchQHcpu2X6nBfRLoPPOGI1JbRGne+adg+VZ+xFprQAqscXBJVCzmkamAyZyTLiMqIYw+HqTdR7avB9tGAn2LwrUXRcU3tkvY9gVApeE90CtUVrabjvQxjjeSTqWIktoUcbJ0W2YWiL85+78aEwia4K/GHPDLRgpsIBtozJetAcHOj51/xfgnViiA8UYDBNC3ODDoYbBLhEyZzVQ7tyLi8TIe6NvF3aR2fXBa5SYkB+VY0q2X3cdxBQ8GSEfsavOSOl9q9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyxCeBAkfH7V7r0X5hT2ylzWJZQD4C6odmChAMZzx7w=;
 b=H4gEH6weHBZCQ6M8Rdc5zk37E1tJzoSOjlEsEdpqQXqio3aUA0uwafH0iNyMoCfrldj/zfI1b3Qp6MOzHczTk/ahU1G8bnVrxzVmwfeSy7TLICj5mOKrDXMajKU765Vlk7wig6bC4V/WNBHC81jw8Nu2a9jSXkap/+AzCYsZKdQLHJ5BQknsKrMGQVvJDOXurkU5zOMjEMALbJOoPOjqpu3xJCoOx5GAGkc86xj25Xng8EM97w7isCp+oiwl9xKma4jWjMrsDzN5QvnkxMS/OpittZ3JtD3B3aw9st93qDUTz/G4apuRa7CuR4LhBRo/oIqqnjXIYo23pINE4sXvww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyxCeBAkfH7V7r0X5hT2ylzWJZQD4C6odmChAMZzx7w=;
 b=a/wz8vQwYJk/OeohncC3CxCUsoGvHyhbv8t0x+Jgr3oTcMcevx/tDmIY+IZE/Fv9QwSMuR1o4y6JUV+JxG03iAYDcd1ClaBaQvUQRJBwgPqvGJNf/Pigmq261OybgQzAkQ/qOaRg1SZiEhWuVYUhNsYGeTg+s87M946s2nfyZd7tcyWg0BcYbBNyBKs/TDaA7q2XaE5cdlv6kzGrwCjFVGTDKMy9uRrQBIR4Fc4CnVL6eI4IXjCBcke/aFTP4PZYrrpHidYWvFoIP1odyuBxfocd4ve6ynzX65NT9FMI4KMnNzWple28UsmTllvQMKfkn7EupsnkoXT/uFwMjQ+6ew==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by PA4PR02MB8237.eurprd02.prod.outlook.com (2603:10a6:102:26e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 17:41:16 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 17:41:16 +0000
From: Erick Archer <erick.archer@outlook.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Justin Stitt <justinstitt@google.com>
Cc: Erick Archer <erick.archer@outlook.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] perf/ring_buffer: Prefer struct_size over open coded arithmetic
Date: Mon, 29 Apr 2024 19:40:58 +0200
Message-ID:
 <AS8PR02MB72372AB065EA8340D960CCC48B1B2@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [J6Wb+nSaPC/3xF9RT3tLFOt220DCOLhp]
X-ClientProxiedBy: MA2P292CA0002.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:1::18) To AS8PR02MB7237.eurprd02.prod.outlook.com
 (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240429174058.4237-1-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|PA4PR02MB8237:EE_
X-MS-Office365-Filtering-Correlation-Id: c1453e7e-2988-48a1-8584-08dc687391f2
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|3412199016|440099019|1602099003|1710799017;
X-Microsoft-Antispam-Message-Info:
	6VieQkeIyGYtf/20mFkp2pk/DaN75IiMstYx0rBMHDriZ8WSamXYzVYU/xv38/fyuBr1e+MjDo++EABpRPVVMN/UMWHzJR5X7xo7IFwz+RD0I6nh9hHn2dWa1QyFZ1ESe9Zw3NmHaDNDdAB8WQARivelG5UER3udojToWxNg1l1T0g3QmliMB1UcnJY60D34k4bdUpzxWPnqI3QQFQlA7vvr/vUwnDFOGHCxO8eICb7UYp/8WMsYMILj0fAK5o6Ioqdthw9lUlqjgin96jBXv8hni5o5V8k02E+JO4GSIMg44TNPE7AYEqWm1WH+Sp3udvmZJrOSvd/VdbcI01eccFV1t6u7n43w7zhSYPNhtGj73qslXpDxwRcDGjofFDlcXfk1XYBrk2nNXlLR4H3zs+wpebvmQdfMGlEXfkajlfwxBMUMuf3vt/YmPErVEBLQM0/yj0iPzhBNTK2FJAcAjN3yXk0z2EytWOQdKTPR7fGD6P7mHyAI5fd19g0MVBeoIyPnDQOStfZgaRfdivhO06bIbpSOZzGrMMF3btwm4urZIrtgMT7QcqXbcPFjyFTMH57rjYk2hNXrBsXHsfoKyXk+3t4YjuCWOXvcqdysJFDNTEHzZ5vil406QFtmHSJ6SUNi6RqPQ8LrAYFvG9vsbyRZ0MWJdrrF9Z2a4+6PpOe6tw+hotpm6J7n17BAlYOwdqTBziiEtU87mMh6RHFdOw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2NNB6JBvaSDB+Lb7z5FA5LJcjpMGSXMaUYVaQAk8Lw4s+xKYf+SsWFjJ+1r8?=
 =?us-ascii?Q?pmBN1Aft0idaA+3dOSwBEraHAO5Wo/CWOcAcEOtAtNVr/3P0BRyqOSYgvubh?=
 =?us-ascii?Q?K8kxfUNQ5icdnuzzF6il3WNVvI+ROzM0Rdk02dlIcJqA8HxA3OGYb8pO5Nkl?=
 =?us-ascii?Q?g8DrevFOgc23YZaBrnI1NHOXXNJf+wu9HAp+WdCs/UQAxy5cZ8jfGqbC/QIT?=
 =?us-ascii?Q?GT2RaXOYJ1PZG5H4/bieR/Q2rBMTO4qkHYrR3pYOPvKpaeTWOX938zyN2jfZ?=
 =?us-ascii?Q?dMimuWB1yE16ekTjdKdPJusjlZkOoRNSuez7mWWjefF2Si92UbuvfjUjapa8?=
 =?us-ascii?Q?a7XhXVA3anJQxii0mtHe/UuoZPR57hjH50PfFnFuDeWkahKa0qbRbcVPM6sZ?=
 =?us-ascii?Q?8ErHaRppJnQzG27a2zVeAWxgCK2fbRgzJAtiDX7iKk8aDtavC6tH0v5JbVJ3?=
 =?us-ascii?Q?8MfPw0dGT/ZCKFYR9dudqILGKCXuNZ33jeJ93+GrFbfIrfxBtofathWvimjE?=
 =?us-ascii?Q?jAbK9ultiYF/TtiALgNrYzc5Gq9Q1X8o7vBKQW4Suy7dyymiFBSYvmqwxNsb?=
 =?us-ascii?Q?48GicxL71mSYpczoe5tCSyorbKfzPvk5iBpIxHIokVDbL4z4WfbEMhqocpsv?=
 =?us-ascii?Q?ehJZTUcqh0GR1YQdSUpE21CuZfkX4L3jpTAd+jheZcz9ORZ7aygnTHDSBARA?=
 =?us-ascii?Q?KKYJnAbqIiIgbuvOVNq6rHY0dgHybsqTNqMnZH/hlluivwn725IyD1fogfcI?=
 =?us-ascii?Q?yzzUij21HQGRsG2GcI0G5tBts2H7b09FMmAgZurkVzuGjE8sJgjW3EPkAFCq?=
 =?us-ascii?Q?5wyktkDBxZDzsP7CDaLwXBSEjKF/qO1L3ivDDtbCUhbszgiKKZh/W18jYhQL?=
 =?us-ascii?Q?AUZ38L6b2cH6WnZwAc8G1XBBiL45vUJTLlY3at4YY6xRqjoJeVSzgJrpROG1?=
 =?us-ascii?Q?JXCgQtlMw5nS8rrvHXod2DKmucb7nT7GrA/x+kJIsJcK4KUUdWZboJ3edPS0?=
 =?us-ascii?Q?uDEFTJaWAKgfbHXaxf7Ilq+pPXZf7ix/Pb1YEjEHt+9E6LFAZOFYf9WULRuC?=
 =?us-ascii?Q?5p+QICrYsEqXAOvhiuV6y8uCBNJe6mrAQ/T1kJ7X6zlSK311bKG/+KYdmdEJ?=
 =?us-ascii?Q?GFwWu2oQG4eeOLed8UnIyxMeVJfZbi2cVcsrsKVug/v1jwxLjjCIC2ASDI1D?=
 =?us-ascii?Q?+0xiU0zlqBj/4371UuqBQRdc3rb2xxK2FMGqZRTTr4kwu22eitXv8gQEYXxc?=
 =?us-ascii?Q?it6WvH6OAHxARprumvM0?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1453e7e-2988-48a1-8584-08dc687391f2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 17:41:16.1265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB8237

This is an effort to get rid of all multiplications from allocation
functions in order to prevent integer overflows [1][2].

As the "rb" variable is a pointer to "struct perf_buffer" and this
structure ends in a flexible array:

struct perf_buffer {
	[...]
	void	*data_pages[];
};

the preferred way in the kernel is to use the struct_size() helper to
do the arithmetic instead of the calculation "size + count * size" in
the kzalloc_node() functions.

In the "rb_alloc" function defined in the else branch of the macro

 #ifndef CONFIG_PERF_USE_VMALLOC

the count in the struct_size helper is the literal "1" since only one
pointer to void is allocated. Also, remove the "size" variable as it
is no longer needed.

This way, the code is more readable and safer.

This code was detected with the help of Coccinelle, and audited and
modified manually.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
Link: https://github.com/KSPP/linux/issues/160 [2]
Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
Hi,

The Coccinelle script used to detect this code pattern is the following:

virtual report

@rule1@
type t1;
type t2;
identifier i0;
identifier i1;
identifier i2;
identifier ALLOC =~ "kmalloc|kzalloc|kmalloc_node|kzalloc_node|vmalloc|vzalloc|kvmalloc|kvzalloc";
position p1;
@@

i0 = sizeof(t1)
..
i0 += sizeof(t2) * i1;
..
i2 = ALLOC@p1(..., i0, ...);

@script:python depends on report@
p1 << rule1.p1;
@@

msg = "WARNING: verify allocation on line %s" % (p1[0].line)
coccilib.report.print_report(p1[0],msg)

Regards,
Erick
---
 kernel/events/ring_buffer.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 4013408ce012..e68b02a56382 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -822,9 +822,7 @@ struct perf_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
 	unsigned long size;
 	int i, node;
 
-	size = sizeof(struct perf_buffer);
-	size += nr_pages * sizeof(void *);
-
+	size = struct_size(rb, data_pages, nr_pages);
 	if (order_base_2(size) > PAGE_SHIFT+MAX_PAGE_ORDER)
 		goto fail;
 
@@ -916,15 +914,11 @@ void rb_free(struct perf_buffer *rb)
 struct perf_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
 {
 	struct perf_buffer *rb;
-	unsigned long size;
 	void *all_buf;
 	int node;
 
-	size = sizeof(struct perf_buffer);
-	size += sizeof(void *);
-
 	node = (cpu == -1) ? cpu : cpu_to_node(cpu);
-	rb = kzalloc_node(size, GFP_KERNEL, node);
+	rb = kzalloc_node(struct_size(rb, data_pages, 1), GFP_KERNEL, node);
 	if (!rb)
 		goto fail;
 
-- 
2.25.1



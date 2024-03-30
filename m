Return-Path: <linux-kernel+bounces-125744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F100892B8E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 15:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54B46B21262
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 14:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCC9374C3;
	Sat, 30 Mar 2024 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cYPdi3aZ"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2103.outbound.protection.outlook.com [40.92.58.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897151C0DEF;
	Sat, 30 Mar 2024 14:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.58.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711809208; cv=fail; b=ARXSU4YSV0dZl5HapNJLDDH6LrrzUvUSb8y42l0go+kyMZVck0WyY3XHTev5evh0QYm+jr+x8FLYxphCEpWqZSeRdOfT9cmlBH33DdXi87BTRRIR8548SziF7pLA1eyuanmbiBgE3bOmpZhaxJsfSq9pfsGXvqT+Du5q3nTPDyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711809208; c=relaxed/simple;
	bh=fjOi/7po1cFLdl1IihzcE8L3KZ82wBK9C17Jcdr4Llk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gCpuxniJ+J7UsOoWDFw01NsvwzZmFSzDpzdWR1K88QLz7hwUC1WrjCUMHQIBEEiQQRK/kzTU6Pkc7kGocIq9SLpiO3M7Gte8FZQ+VE+MDChMazAFjj+2QLIAImDWSvhbEBouJOKP2S5liqhl1wErUuSQ7/bBi6qGVhGcIa1kl9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cYPdi3aZ; arc=fail smtp.client-ip=40.92.58.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmBcO4zOgUwk26xSxYyiwEO3DTCEc/CkrFlzxOauoQNMHF2WQTZuMxOXWhnA2DsGoR3UMe225xvoH4BCFoze0tubnmpRTreY5mvfUfTfwVhfRx1/LRKzIv8GaqS/EHoXLC3Kr63Si3aAPXtnZU+WzXdqkQy6UR3csmbvfl70BhGOCEMJvxzon+trLnFvHXsQBsbF8H5iUKhnVc2Bg1AN7NGJTmH2sK8/3MSGgXOD28DE7ZyusCaKdvzfJC3TC8+TxglOy7O5N5z+qDfZo5pH34UVms58nTo4lIhf8C/FpndFRp5IRPSq/ZITphCXTOACAwBJ/59OLfd70l2BhpR8Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPJP9L+RwteepLTzebuTaISFted97yUiS1BgO9GNq3s=;
 b=nF0wMJmWgNjxd23JQ2A96uvmsMS5dO0ZAYWbNXQsDmCBw3mNJnnqiGZtTbdOHosf7WN4g7QkEpNqxPQrVNetaHwPG7OWdR08BX+xevkou+1sOUIGL8OMknaIFh/1yrLBHV9aqiXs2z7TQxZLsZGQU+lSQ3H331sv1ww3/qOkvU8uCoI8WrkFvdorQ9xjCqf9dCaSiqDLvFIs72WF0bR6MNGECfmzZJe6Yfk2UqGquw9T0f/CsTvxC8CXjFr0PoV51fS2CQyBF8dN5I2LLtak52bYZtFMusycemw+VvfILXHR8wixct5Fnd3WNn6oA0lJKHiSKRJ11mceIQ0s7o8eNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPJP9L+RwteepLTzebuTaISFted97yUiS1BgO9GNq3s=;
 b=cYPdi3aZr4c0B/I+pTWNM9Jd1moxAc2dTb9M2yjgrffjuP8G+EAlVAg1ZnHnyeXnUURh/7lzt/a2PNcggS0R+y8BepAorRA0nz+/hGzsLA3D4wuRgz+hLOl0lp7EEoIbqUNXFT/exlCPOTRwwlXclMikYNi6bsU0GQsCjrA2F9jE78ltw/7Hbjujk4j8V7Y+G+a3Mb9UuwIYcH+KigYF0s1aN6WqN6n7QNMKVFlOXZzB0VFGbmMSJSox5BLD5ZEpXWwhREYsu92LqI8v0GZRVTEYfFVPQaMcXziD92wbuSpqcV/XiSnw9Z+CZkHSrr0MJr+PJE+7hgidkGjf5zdGJg==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by AM0PR02MB5827.eurprd02.prod.outlook.com (2603:10a6:208:180::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.43; Sat, 30 Mar
 2024 14:33:24 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::9817:eaf5:e2a7:e486]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::9817:eaf5:e2a7:e486%4]) with mapi id 15.20.7409.042; Sat, 30 Mar 2024
 14:33:24 +0000
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
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Erick Archer <erick.archer@outlook.com>,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] perf/x86/intel/uncore: Prefer struct_size over open coded arithmetic
Date: Sat, 30 Mar 2024 15:32:59 +0100
Message-ID:
 <AS8PR02MB7237F4D39BF6AA0FF40E91638B392@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [k5TbKRqU4xqgQhk/E3+eYvk3kMxYD88N]
X-ClientProxiedBy: MA2P292CA0023.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::18)
 To AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240330143259.5822-1-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|AM0PR02MB5827:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e7713d4-d927-4284-dff4-08dc50c65ada
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NCzC4hUwZMhoMS/qbpYs282m4bKV+R5pHdnGfM+uJQc3uOT3rWQZgog4H0bx7g2B84F+69ZvKdqgjRSiHpmluJNX56mDeKWKCeEHio5fiY/f+UHLqwaUjoVY1WQZ4d8ACdEchBWchgcZJLu5DtVYMfD2H40BSowYYsxqHv/cQn1FXAowwgZ7ILZy2D/3deuLIwx8pFnWXVTT/8SamEF3wXvH7m2idaUcknOxzvCJ55vPpVtl9nWXOcnnkWdJW99tyFUKaAkxG0ALcASF3FAUvrl1JIuRgx1YufTMvZWWI+rnyv7kHJLdIUOypHKpUgDM3Tm4jKH1Tw1GzPMK7oh85iiu5GMi5cGHlQyHg3IpTXOK+kY08FtdlQGVCX2cbr4TekGjzyM2l5rrDV0kzrjrE6VzGJLIn6uYTuhYaY/oa4BOSxh22DBLQJkP1FwMdgmMNjgJZdBvEMB2QC/NZvVBGHdjMiKMNuMyAFTCfP6LS0gpSSTO1HWYh/Q16kP3dzu78UNPbAkPhH532lMtL6a6RqfVfnVnkrSHcHPeT6MNq/NlMf/5mg6cu/hYEf0jcbC5nI0X8xmucEUabU2CtCFEzuMdMtwGgYGxA3U3CCCauPX2X7qrJowCuTphfmaBojFgDrOLHJg5/7N/PS5DMupqWfe/cNYshc7E74a7PHBZRTFQQRo6ls9zh6POwnzazd5d
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UK3dsu9VTwjLPGsf7OGMySfHq+16NuV3exIt89dc+BaRNjED7qdRFO+BOBBe?=
 =?us-ascii?Q?0wLKXPUFj7TMYneQMi6U1MEOsLjoUhupBLMcoJU4M5e3J+Mo0UU0WWfytQjN?=
 =?us-ascii?Q?hHCgUoFBI2CRz5JiNzMxYMQ8WqJSaQslQgx2CAnJV/8LrMfbw2jidJJOGGI+?=
 =?us-ascii?Q?EmBMUcbpCnbdxqgi3AMLowmLqeiJZXd3i2ZpmoshsJn92cUuyWvsaOwieuz/?=
 =?us-ascii?Q?EOFCedZkQYKiGfrxOWJGH6Iy1gF7O9Soy65hlNTTfhBGlPo2AfC9fKmKaR2x?=
 =?us-ascii?Q?Zi4p86PesFz+slMab8SCnpfCv65dM4r3EIyjEfHxVL0RcuzjmDHMjSSGeVF4?=
 =?us-ascii?Q?NZMjSaMUhiIhBRgejz1JjRprwRr3XeRAlNHF2ll+RXusD4pZ8FVGhN7RcHgD?=
 =?us-ascii?Q?Ia2CST/n7mjQ9po46NG/GXe91YwkgpaQtlKYR14dbSwjvANJvmMjp7cU2eGk?=
 =?us-ascii?Q?s9YUxr1LjUl6YAVTezQOgpTeClyfqtrosmVB5K6dlf5ljv0Huw/GFSytXmH+?=
 =?us-ascii?Q?TfH5dqtRfiZAEQ47dN8TPjxM2DOPQnWdlc4wP0qyrW5IcKWmLU5hXrdVpsRv?=
 =?us-ascii?Q?IeZmaN5zqu+ORL7gyeROmzSuu5BN1tPpAs3kWYGbXCb+Oi4Rj5/5yLR8CvaP?=
 =?us-ascii?Q?TkwjQSJWtmFuuJGug4GGHKHj2YaY8p6RWe5Tf72ctWel/ugfkZil72nv4Ww0?=
 =?us-ascii?Q?z/LaZ91v0gTR1qCCb/4DaontS56sWif+mSSwZF6GuqK+anHP5GNwsTimTt9/?=
 =?us-ascii?Q?vfiiHg3oxszjFNc6NzAaEF0MF135I5Z5v9ZZ48AtcCI6QI6MA3Mu37UXJhZ6?=
 =?us-ascii?Q?yjcKzHJ0YujzrlRADJU9Ahv/6tQIIW1pFZihDBst1WfsipROmL9A+PX53CNH?=
 =?us-ascii?Q?HIlw0jkXoFjqIhwYiz2LXY4EHR0oFO9wOtkUtMOj9njm+Y4JoHK3T/r1Vg+W?=
 =?us-ascii?Q?k30PjxHapBiOaRutbbs9Bc8YgXXJ3abKCosnYPuybkGHWXCL3gMFa8Hd9pgT?=
 =?us-ascii?Q?IP00U4H/tzNpXnrCMNK9l7OTRad0mC/rHlEsyEftV5XbnhGVkoqgV2szMVhC?=
 =?us-ascii?Q?EtDEifvKRnV7++YfSCXZrjQSCYiofc9X6qxgmMNL39bSmoY4NNIkN40qnaDZ?=
 =?us-ascii?Q?pk40y5lBoFD8lS5qxy5NbRnc9hLIYqJDZuGkUOMk/gKUjVKAaRUCdfX0PPXq?=
 =?us-ascii?Q?4OBeG5ZultiRozBmU7jKQK0X+ejJ93fzFnV8W0LOC6mQTLaZNlZFAGtE4YJS?=
 =?us-ascii?Q?lKM6gWRlk4rlG80HSzAF?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e7713d4-d927-4284-dff4-08dc50c65ada
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2024 14:33:23.9457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB5827

This is an effort to get rid of all multiplications from allocation
functions in order to prevent integer overflows [1][2].

As the "box" variable is a pointer to "struct intel_uncore_box" and
this structure ends in a flexible array:

struct intel_uncore_box {
	[...]
	struct intel_uncore_extra_reg shared_regs[];
};

the preferred way in the kernel is to use the struct_size() helper to
do the arithmetic instead of the calculation "size + count * size" in
the kzalloc_node() function.

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

i0 = sizeof(t1) + sizeof(t2) * i1;
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
 arch/x86/events/intel/uncore.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 258e2cdf28fa..ce756d24c370 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -350,12 +350,11 @@ static void uncore_pmu_init_hrtimer(struct intel_uncore_box *box)
 static struct intel_uncore_box *uncore_alloc_box(struct intel_uncore_type *type,
 						 int node)
 {
-	int i, size, numshared = type->num_shared_regs ;
+	int i, numshared = type->num_shared_regs;
 	struct intel_uncore_box *box;
 
-	size = sizeof(*box) + numshared * sizeof(struct intel_uncore_extra_reg);
-
-	box = kzalloc_node(size, GFP_KERNEL, node);
+	box = kzalloc_node(struct_size(box, shared_regs, numshared), GFP_KERNEL,
+			   node);
 	if (!box)
 		return NULL;
 
-- 
2.25.1



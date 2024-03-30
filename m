Return-Path: <linux-kernel+bounces-125771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0020B892BE4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 16:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB879282E88
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 15:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B9C3A1A8;
	Sat, 30 Mar 2024 15:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ZlQ2CqeE"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04olkn2028.outbound.protection.outlook.com [40.92.73.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0A7A936;
	Sat, 30 Mar 2024 15:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.73.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711813651; cv=fail; b=N3etLIBgtSyTnlR+kDgFXMQodfi9LUeMPB3LmMS3EBrgtOWa86WAH1jk61KUV+I/OLdvOVEnGmXZARhp3CHrjSjng+t7/LhKkj1rfXY6mkKsH2/+1YlAu+GTF3V7KfMIcM72BkgeLWs3ahbK7BFvZgWGnLeX1BKu0391TsSMXT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711813651; c=relaxed/simple;
	bh=hQhK8DDo8vFlcw8efC5bKuqUHVusA+U3SuimOgY6w9E=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=d7TD85NCGqtCBifSZkm6r2Gx3aPNVkJeR/rk6iFLENGRWWT2jfpJZF/vRNSLkooEyNsT4DJBoI1igI7AJWtqLxWW5xmRffj5tAwQA2NpC6SArLlGpgaDGjtG7wDZJywp7Y4NUGSa2i2bgCKpwI8iB4DdTqt5sqCjEL9cQ5PgK54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ZlQ2CqeE; arc=fail smtp.client-ip=40.92.73.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1InGmtIYzLG9pdP78KQxTG4Q9jTI4kw94imKFNxFeLfkUc0FveHAI/mESd2LNYXLAI6IZMlUfGDKkfxoR17hK5qyZgh7s/FZqJtmNJfmDZJF3A4/abOFewieGdV04pmgjOrNged3Cb7z4uh5+ZHsHf+F1XPw2UEa780FJ/3qrUZi6+cLXgJovoDwmSm6dC4VWz7qFTVgoeqOuXp1DO8Ev1kGaxGCP7HZdpf0WMF/umfy4+rsdWG4ZL8Wj//bx9PeDs4Ofa3iAZlp/TBU+zYfI7KVYgZG07am/Yv6Esbl29byZr+TtYMg0qOeSoCVYANpwi04gS6NId7CTQeOp0ajQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=If+RXqyc7IV9zU0aYa448IBk1hQNid6O8k8iL/z6Pe0=;
 b=nn+tE86y2ApMkJbnQMXubyred0rbgcXDYqOhm+BtaJeVIEn4OHEffI+BR235oBvBf3dYuHSvzVNc/3hMpuN884njHf5aNMQmVdi/mK46NO/lVYLRhqjgl9btRdAG8jmwZW2XqfBE7UKWU1p5CAUCL7k6MvKSZuIcYYJT6d1pta7fZ01i9+Rnqj2WuHUGHgjbsAIAn5HKEfqIK1Z0JU1z0oGBPDl/CH5+DV8FqS/Ta3Zj9fq/bKzz1DHugALBqTAtQ24D1uzAtEeo2BlgisjTzVwYOOuEN41XEUUKEN021ofzr+ToXiXp7/eESLzt0PliFshTMwNWe7y8rkkF5dBlWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=If+RXqyc7IV9zU0aYa448IBk1hQNid6O8k8iL/z6Pe0=;
 b=ZlQ2CqeE30HLhKuCO+4/LXjZYr72CRQyVyh7vgP9ML8rv7PPT5klkMkvRyZaXxf0I5bqrbP7RhNuJVaPpNWvZVgN9OJZc8QG0vUBMkHMs7LDNAJZVyE2x/LGMKxG/jnX5ygCIH6Q4UeHmRW0hJ97RGwZsq8lIlEcOVGQFhSKajHJttW/XxAgDHgkuJTizaIdz38nQxstKQi1IERBGgXGMLqHmJrYFFTk/aQoHdvwlTyiije6/eBVdq2ipEqezmP/cG2wA83BLyVd6WAcRBi8WV6KdcXrIojCRp/AZHNTNUuGb37oNiZUF7hVR2zKA1zj0NGs2kny2T9c7GxyzRRMCg==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by AM9PR02MB7057.eurprd02.prod.outlook.com (2603:10a6:20b:270::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.43; Sat, 30 Mar
 2024 15:47:26 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::9817:eaf5:e2a7:e486]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::9817:eaf5:e2a7:e486%4]) with mapi id 15.20.7409.042; Sat, 30 Mar 2024
 15:47:25 +0000
From: Erick Archer <erick.archer@outlook.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Erick Archer <erick.archer@outlook.com>,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] perf/x86/amd/uncore: Use kcalloc*() instead of kzalloc*()
Date: Sat, 30 Mar 2024 16:46:59 +0100
Message-ID:
 <AS8PR02MB7237A07D73D6D15EBF72FD8D8B392@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [Gvr/LX26XvhxwM96zv0N+kIbncYlcblx]
X-ClientProxiedBy: MA2P292CA0020.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::10)
 To AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240330154659.7736-1-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|AM9PR02MB7057:EE_
X-MS-Office365-Filtering-Correlation-Id: 60dceaae-31b0-462f-03b3-08dc50d0b26b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0ngjkSwGqpw6HMAr8o0k+F0JojbUKG+s1ppJDNlhm+rDmThCNLqLoayr/h0ml/k6Kh3IC9zGPuZdBf/AnS8YRCK6PtdrMnsYi1qCg4is6wzfn1zNL4OHRP2KH+tXD2D6tAsT7nRqwFOtWg3rmhJFqZ/zr2pwqtBkOSz2zcSCfFvLFQk96psZyUQUF/3DLB+6F1UaGZcCVw2xCXQpkLIscYpKkDEzKJf+6nb+wNQPATP2s75XRCy+TNgFYbzxjcFzrCoLPFJRcjQ7tZrRkYrOCL1a+P3LrB7EiR1zIPsfw2h0TMHVTjVRZUPujaLpm46Ac0giRMGHRHYlVI71/4RIG82ZIL2r7O4WVlirOCo3bf8pn/+hOHP5LfDShmbqKZ5q1oyiBlCkmnfwpBmgYT32jSvfrcXz57RlNIga3TvuAPT5dqdWq+BeKW0AKOuQJ2bfSspLdSKJwOIH2r8hxbjefZ1t36Zf3cSESSmEV5XD4wNR4M59X3wFsHDOo9mQu5PraHHWZG6QmoBQ4rOQ+O/paWM3pbFPnZM+XqTE/rHYWf1EWFC0z7SvGYWaMEbV25g9y8cS8zNsHqHSruCOTYNQ4RLhwwU+zKduLMwvSeILmC+kZ2FOIJU3x9qKoIg/S2th+SVLMXJuDgZXbD172Uf0sSWzGnQBDMmq5fwag6DbeJ5fL71b5X8Jac0vI0+ku1Aeuw6sTzydpgZ4Fg41qUpCvg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V2gC23BDlcfXnYmDo9/DVFo4LxZV1cvnT88kwVn26sCUuFszPjAJ2tmp9O3v?=
 =?us-ascii?Q?O8e8Uux3O0SoFXAYaRAJC/2+TRfSActglq16vUxmU4EHKefi7T8kpx8totiW?=
 =?us-ascii?Q?FPDPT/SaH23MWzRNoq/za9RPOjlO0C0tK44SVImm6VLS0DYOD5V1RT/Mzvoe?=
 =?us-ascii?Q?esJPDwG+rWbLa8t513YU84reIa5KMSPigG48vT9ppbs3LsAjFStJcOEMn30w?=
 =?us-ascii?Q?tQp/nlpQas5/cyzlsqEsYBEDVe4DPr/JmKn+hzVroc2CgX1JF5nM2V2eCBUy?=
 =?us-ascii?Q?fSP+rM27sVphhTkCAr5sNuzsBDd4KUJiNBLgvXR6N8DUTevEEQ3DQbDUqBy+?=
 =?us-ascii?Q?lQmIroZ3dYKyv3oM90he+OkUA8rQoHZuVCUIfsJEnM4r/1Wa56Hx7oooiszz?=
 =?us-ascii?Q?MGQQ4jLeJstJkzvKAmu+wl8vkVbV6A39WAwL9zslRrM+xWJoot6drZWLAM4l?=
 =?us-ascii?Q?PR2Psc24Qf1bYFpsR0IDEjeeLpNd7dlajJxlW618NAb5+s6VtbdFXpFYkSF7?=
 =?us-ascii?Q?CRxaEFh4zL44RZwZ6GChBhG9unqQwAKZkCfJRqANodTLpQWolDTZHN4UinR1?=
 =?us-ascii?Q?G5W7RqEP0mCiNGqce1zvF5rDkEBGhauhMWNtcz21umPv0Qs0OcAaTxJtKhJb?=
 =?us-ascii?Q?289Hmdker5xSfRL8NyHcdwpYuU9LbR22cDFftk1qoyvb78xyyTwL8RoCd3gK?=
 =?us-ascii?Q?EewKDrpF7V2289aGRSESuf/pO86DlyUBbJRdNSBeU6BO1z1bQ476GkfbDQ9t?=
 =?us-ascii?Q?ugW7C1cNuqyoZCsjF4PUBFxko6luU/EnHFjSq0+JR22Dv2k7IK2obvVZPpmE?=
 =?us-ascii?Q?yxQvG2VLImL9JQy4N6Q9mVV4iYT26Bx8gy3BCceTgvwOAlNFTsiRKS2xnYOz?=
 =?us-ascii?Q?Q1B4Clr2DBJzYuqPYyG5auDMlycNZGZ3bQ83QNDeIHWyzTNQN9nUgk8LUe3P?=
 =?us-ascii?Q?CpB3cpjkQWMqq/qAZEJSo9rQ9QZiEvE3SHn0xm+Tl+FVD2RP18Sym1Ntjyew?=
 =?us-ascii?Q?FdffFVq6rOR2Qh9wDiQxJrfRfu3lp1tzk3tjl1MPAy08aoH08q5ERDVSg6AC?=
 =?us-ascii?Q?ao+AhSZ6LRTX4wp/nE8REnL1lbfbt302GtCMQdSbqvGEKhV03XiDcHGdFwJF?=
 =?us-ascii?Q?hxvCc8kdK4L8maqBoUNrzJNOD/8dh2+zM4PmFpHtng3ccXwEjyi3jDr8JqzP?=
 =?us-ascii?Q?b33/aBka8t0MTDUfyv2xFCUmlV7tuwU7ogLO8tZBlHeI2XJQahyjzLnws7oM?=
 =?us-ascii?Q?IjXq82Og15UWJ7TqI3wx?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60dceaae-31b0-462f-03b3-08dc50d0b26b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2024 15:47:25.8536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB7057

As noted in the "Deprecated Interfaces, Language Features, Attributes,
and Conventions" documentation [1], size calculations (especially
multiplication) should not be performed in memory allocator (or similar)
function arguments due to the risk of them overflowing. This could lead
to values wrapping around and a smaller allocation being made than the
caller was expecting. Using those allocations could lead to linear
overflows of heap memory and other misbehaviors.

So, use the purpose specific kcalloc*() function instead of the argument
size * count in the kzalloc*() function.

[1] https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments

Link: https://github.com/KSPP/linux/issues/162
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
Changes in v2:
- Add the "Reviewed-by:" tag.
- Rebase against linux-next.

Previous versions:
v1 -> https://lore.kernel.org/linux-hardening/20240116125813.3754-1-erick.archer@gmx.com/

Hi everyone,

This patch seems to be lost. Gustavo reviewed it on January 16, 2024
but the patch has not been applied since.

Thanks,
Erick
---
 arch/x86/events/amd/uncore.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 4ccb8fa483e6..61c0a2114183 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -479,8 +479,8 @@ static int amd_uncore_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 				goto fail;
 
 			curr->cpu = cpu;
-			curr->events = kzalloc_node(sizeof(*curr->events) *
-						    pmu->num_counters,
+			curr->events = kcalloc_node(pmu->num_counters,
+						    sizeof(*curr->events),
 						    GFP_KERNEL, node);
 			if (!curr->events) {
 				kfree(curr);
@@ -928,7 +928,7 @@ int amd_uncore_umc_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 		uncore->num_pmus += group_num_pmus[gid];
 	}
 
-	uncore->pmus = kzalloc(sizeof(*uncore->pmus) * uncore->num_pmus,
+	uncore->pmus = kcalloc(uncore->num_pmus, sizeof(*uncore->pmus),
 			       GFP_KERNEL);
 	if (!uncore->pmus) {
 		uncore->num_pmus = 0;
-- 
2.25.1



Return-Path: <linux-kernel+bounces-161104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6D08B472F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 18:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAF10282698
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 16:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBC614290F;
	Sat, 27 Apr 2024 16:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="F5E5y0zh"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01olkn2089.outbound.protection.outlook.com [40.92.65.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243FB181;
	Sat, 27 Apr 2024 16:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.65.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714236346; cv=fail; b=pjfEdEG8i64WPiGHikIw1I+ZGBBrRHa+Dh0d9D0Jx6Kg45k2LhA2G+2akHM+rGfSrpYT6hM3twJYlwC7san5abG5qwQSj1mpWBFvqISZMJ3PBT/DjcFcGAHOBPrxQ5TV4vdXiurLykUIQxk+3PrNMiRpay6FyWVHagj98she6eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714236346; c=relaxed/simple;
	bh=TRMvzh/RzhfGYU5LKVV4QNz8bf4mQEjiDoFtLuIlrMc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=d8l3Mkd/CXuHlva65KGu37Zf11CTu3sv99E84InFzGfeZzW0Bl30IxP9nkhMFRjJUvysUz80SR6HfBDOqHcyb+jM8M3cs+fiy/bDJCtaif4UevXaJ/w6DeWBnP8kFg/bmb3JcyBiJRJoScT3BUisqPLkfNEe6cyyaJsyOJ35CCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=F5E5y0zh; arc=fail smtp.client-ip=40.92.65.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEzBapPOcpxtA08HwXy/8D/u4aRLqnonHo6RbhvVhCDU3GuWio/b/yxf6JwZV39u6f9iHrVNmuS4LNR1A6+1ElMmn2UNgESofQsMlw3HjOLoJvQBuqFAerHjCbhiQYhAMsdhEi3+xlE+Tp1Mgs/lCk7gjspcIP7wgGe60qzZapnw88cFUdw8fosEUPckPtfyvL1Zc4qDI9Uf2WrkR50ur/BNL8lCJhtSmLQSkpDO9Tef//AOBdsS9J9oKfFAnfVET0oKrc6QYCpkFdmxO44W3/R7tTiQgO8bfaWc1gsCiMZMaq6SA3ZxIl5mzVJbxpGmtf5WJHLQPgsdGrTK4PD1EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=diTjEsi+Ok8xuZVD1ffHuw9nrbN0SZKEND7h/xSkDB4=;
 b=byf90Lsjmu57smKOeNzg5kqBScdLbHtuck4c09wVzHas+i+07nY6O5PTosVOC6hFjO/nnpTK71KF4ceZSb545qScg8QV63dh4qN1xA38/m/Ycw0q/q09MteUwltJbq9JFhZiCR95NNQRS/eq93Ll+iOQaO7vGjhee94zpJrevxo7V02gejnAwCAOXJRrYgcio+hMbbk0f9b8AkieqDxCBUFOBPRApVGTORCRV0zCbZT9N1DQEuC/M90gUS0Oi8JQNfTszOkKcVdQmkjen7jjGeSAatBHsvxEVHfScfOHF9OZd2WXgUmnWxVJ9Ctyl/bjghJdRjnS5VpiA4owe4FmYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=diTjEsi+Ok8xuZVD1ffHuw9nrbN0SZKEND7h/xSkDB4=;
 b=F5E5y0zhY7IH8h0py3YVo5jUvFRlhdf4aOVzLTS/SAzmbV1VeZZo/o2k3YIw5U1Jmraq5BCwZrS1XaOSq8uaKoMNvMkcKxglHLRqldTLcV6mGzSUNd01oeXfHaWeJrQKDIWTn4GhMJvrPaUHAw+hAjhcmiYdNGqFyh/jyarAhDETJkgCVb/0h9wAC8Oe+aCaG6Dfg4PBFYJusMWRicy2ZvAHy/OmXnq3A7IBdcvkZyfUH4bnHx2T0C18qDIIV7hi51/BUviDGofIAW+hdvUD/fTqVFoQoArqbLNRR8jZSMGPaE9GvhQ1tNax8QlOWEo3XqWIb+v+sXDMXvs+GKkkHQ==
Received: from PAXPR02MB7248.eurprd02.prod.outlook.com (2603:10a6:102:1c7::13)
 by AS8PR02MB10052.eurprd02.prod.outlook.com (2603:10a6:20b:636::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sat, 27 Apr
 2024 16:45:41 +0000
Received: from PAXPR02MB7248.eurprd02.prod.outlook.com
 ([fe80::4435:2dba:695f:463f]) by PAXPR02MB7248.eurprd02.prod.outlook.com
 ([fe80::4435:2dba:695f:463f%6]) with mapi id 15.20.7519.031; Sat, 27 Apr 2024
 16:45:41 +0000
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
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Justin Stitt <justinstitt@google.com>
Cc: Erick Archer <erick.archer@outlook.com>,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3] perf/x86/amd/uncore: Use kcalloc*() instead of kzalloc*()
Date: Sat, 27 Apr 2024 18:45:23 +0200
Message-ID:
 <PAXPR02MB7248F46DEFA47E79677481B18B152@PAXPR02MB7248.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [z9xObjUkzk9Vfw+tZx5axr++lv2R2Cza]
X-ClientProxiedBy: MA2P292CA0020.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::10)
 To PAXPR02MB7248.eurprd02.prod.outlook.com (2603:10a6:102:1c7::13)
X-Microsoft-Original-Message-ID:
 <20240427164523.10358-1-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR02MB7248:EE_|AS8PR02MB10052:EE_
X-MS-Office365-Filtering-Correlation-Id: 3910b970-f734-4bc5-7700-08dc66d9792b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|1602099003|3412199016|440099019|1710799017;
X-Microsoft-Antispam-Message-Info:
	wZCjechxZiGHOnZMJtgIimHqcjUyNu9N4RgWkuPJATV98Z+dhqPKkbHBH+7bUN9vpzPt3T02rSxYshgv7+/K902SzmS3Vklve7CAZby+//mF4BoD6UH9QrWX2e7C9oEkNCXFu4YXIymlYiUG7yQijm6M74YP2ziMhFKKcA49aoCAGpOZDRwOXW22jbEco9VC69Vue0+sieMIPRtuw7Zky8BFxF5HKL8qorFOZpvI2V9z1K6yYHncMPDRLLhFrep8JibTZfsCO+WWsgEJ1r/fkrrykrersCMrN2LSyy5FHIc5zegTL/0w/GPOsU7vw8VX8eZMLWr0ZHdIQfpxb2d91B89YOdlG1e+WvrHYmTXsXVhVjUAR/b/4ZDSIGRZtVwvnY6ORo78PogbQqpnaLa+wmT935DvHeXV9qTxR3qLM8WhTEVLYC0HWJrScMpt1JOnrO7LGyW4ncLC5/SNf/5ItEjGaFbFt6CIG6PRZe8REBWfm9Fs8PKe3NqbB0SUKAHHPjW8KIuu6rNAAVhzbgzAayFBEOunXmzTq905CS7hMQcdGGHE7bx3JEbzk4woBFCYXD7xOsAKFdFI8H8mD/3qKcWkeOy9O39HaOvyfDhiIq7Kv36yFwi4niO0hnbDrFDNqThMTQVAWfkd5qpt/KfW6wIUZhINzqcgt2CZ6fkK8advKj7fGmPBAv8Lcs9JQTBr6qdPmVscHfurI7A33rxQaA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mIm4Wm2yykxDj/uifK5d+r+c941S2uEadp3QXVjUlByP8OOqGzWVq/YstRjr?=
 =?us-ascii?Q?VQm6Z9nbDHMKhhTgLNIx7Gl7U9lzubxHkuga1MkhOB93big4x86X/9lU/GBP?=
 =?us-ascii?Q?UyIwOplUbY18gNEiJUk58igvxz5ZU9MaUxcc9sDFPrRVXDQZFQ35jw2+jfxL?=
 =?us-ascii?Q?2AOxF6/Ho7JS3PElYKmKW4lDdDm3/gliLCeJXf+J0aN8CrchLgYhMaEhNMwz?=
 =?us-ascii?Q?wcKTr9IyxGkgYyQA0yA5pVPEzYRN8hxPIJ8SqHUZ+bdgQvGp6HrJb4qZHRe6?=
 =?us-ascii?Q?pzZHkrSmCrEMEAwZf/Rl57RmD78u3rd7eDRhYWHsYGE7Ew27AJ3MA5duSCOD?=
 =?us-ascii?Q?jzQVpVHRT5NwGSnqTyosJd3yujt6j5lcpGVSofqrkd1kVQ9azeYKeklcy2lb?=
 =?us-ascii?Q?jOKEZ5mdqKc1rjswLJEKg23tqcJk+7jVB5yxhxIEA4K4czyFheXHF3QZxWOh?=
 =?us-ascii?Q?bLQKh6qhl72AhlyBHzPA0oBxY/7glSlBfxj4ER6VnzM1nwzfMbkwcrDTaVAE?=
 =?us-ascii?Q?0zWjgzpToi7VPeGOHj6UgW1bf0N0Oj02DTh+9AYeaIcgqWWTfenbPQc7fIZN?=
 =?us-ascii?Q?AlTEBaK/YASVubqjtzxfrcimn7UQwYej/SbyHbd36g/j9TvlUNO/+WwO1Ap6?=
 =?us-ascii?Q?UBn1t/6gkrQjs3AoFAyrgWukpChHc4e9FX/pTvV/ceTu3IDkrOWsVcOcBgrd?=
 =?us-ascii?Q?HjugiDmd5jLRSAfL6mlNVgV51M8C2EffMw1Cjzn/h0DbgdfWURU8TQqvTj6o?=
 =?us-ascii?Q?NSNHKgFaT2O7tEtJ6nXuAmPieS/aSGqPGhs4RiJTTSn1SgHBwi8bsSKAs4HJ?=
 =?us-ascii?Q?XkozBoyioXV4cLfqonPUssY71Frfd8Xwkkp5+vlNlyc4wPYcNTLirFVOs03A?=
 =?us-ascii?Q?3EVbOB+JgVeN8iSKHuL3B6lAmN8m4BK5eGqPtXk+6uP+zm18lVR9rHYv1NT6?=
 =?us-ascii?Q?O1XmSF6EG/ox67zQBsotFKrlkjAqbUTntSdhJ4zHJTYsW0AljfhuZtGNti1c?=
 =?us-ascii?Q?XMo4ypBpFPPlKdS8Bt9Kpea1C8AwMvBJ9BMyilHfyxkt/69Pvtz3Ku4M3XL9?=
 =?us-ascii?Q?m0QpZJQ0/ixcyN8uVvmlnLZWJ3fYoquRPE3ctb0F1HZSeikHz4gKn709AhvX?=
 =?us-ascii?Q?6ZCoyUV3HNHoKrVdnNQdcEmqrIhEzTiKO80d3faDeFZ5paD4H3qaLqkIkSY9?=
 =?us-ascii?Q?RZgPdib02UgKLoOJXH1/Ari1xb1x1CdPzgA16dM+bLAmNNQ6yRheMOp1azRs?=
 =?us-ascii?Q?FxeqD9wgqvnw5xxchBcs?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3910b970-f734-4bc5-7700-08dc66d9792b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR02MB7248.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2024 16:45:40.9305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB10052

This is an effort to get rid of all multiplications from allocation
functions in order to prevent integer overflows [1].

Here the multiplication is obviously safe. However, using kcalloc*()
is more appropriate [2] and improves readability. This patch has no
effect on runtime behavior.

Link: https://github.com/KSPP/linux/issues/162 [1]
Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [2]
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
Changes in v3:
- Update the commit message to better explain the changes.
- Rebase against linux-next.

Changes in v2:
- Add the "Reviewed-by:" tag.
- Rebase against linux-next.

Previous versions:
v1 -> https://lore.kernel.org/linux-hardening/20240116125813.3754-1-erick.archer@gmx.com
v2 -> https://lore.kernel.org/linux-hardening/AS8PR02MB7237A07D73D6D15EBF72FD8D8B392@AS8PR02MB7237.eurprd02.prod.outlook.com

Hi,

This is a new try. In the v2 version Ingo explained that this change
is nonsense since kzalloc() is a perfectly usable interface and there
is no real overflow here.

Anyway, if we have the 2-factor form of the allocator, I think it is
a good practice to use it.

In this version I have updated the commit message to explain that
the code is obviusly safe in contrast with the last version where the
impression was given that there was a real overlow bug.

I hope this patch can be applied this time.

Regards,
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



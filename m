Return-Path: <linux-kernel+bounces-109236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C02C9881691
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79D83284D32
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3246A6A329;
	Wed, 20 Mar 2024 17:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="Zr7c6LoM"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2105.outbound.protection.outlook.com [40.107.92.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588AC42057
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 17:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710955695; cv=fail; b=ni6xJwRBsOFqsR3SBWAvFwJdzLwkp/HPkZht/1Qizvjz1Xh70RYE12H4CjvW2Qg0Y1VGx2SOqREFMPvwF3E0xkD/3Ov6QW5Zk2po+zDdMtOVnct0A+r3Gh1H0WadbhJzZNBPZRNMzSGA6e2Def+b0QYrmd3W4o4YxpgsjdNva7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710955695; c=relaxed/simple;
	bh=CfUTvuGKg9oQbhx/gPgBTO9Anwq9Nm2o/Tgw3IbItKY=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=L4IOPycvCsO1ftWyFS2GPlPRr6B9+oMa6pCkSDBn5KuwAIxSzqOwYgcTN+AnhmaPCB86SPxJaCMj8Yg7fQxyjfXNPvbBdGJtcyXIIF2+DlwACeYGt0UMNQGX+S5E2Xu3wlkfYc7Gsl1O/E8kbMVKLUl2Qwq09GWzqh1n0mrOQ7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=Zr7c6LoM; arc=fail smtp.client-ip=40.107.92.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYalGKQFE4VV5kS1MV0oE5XP6quHYFSjz/33ZBD+nMGmr+kD2RMO1llp1IZHpzNn1txvRoIxRMOvrzSRJdQc8sV2fEKMmFuiYJTHH170NiM3oeaplao/eatAjR3uFyBcIaYlz7ah1qdzPFLxf9xVrBl38aqI1V9tgwrvafJ0QtN6aqj6plHWCGiAcRbwtyga1IPrlyVXZkRJ+wtUsOViq9cmffKffJz1yCWeolyUZtuSJ4ResRWJks4sJBO0GOIkUsnw0DYI7xHRadq4VK0cv1OHiHBu5x++2jfUmXVjIE4gq8SI4DdFjVTX9mJpU+SkFN3ZW19Wz9zqnQm9f53Zxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UypyJN3gcwMJaHY008LJePuBfCtCYs5THSbRpF8jIE0=;
 b=UusUL0cwbI2pKj54EoH34GLnEBBc2loOGenJvUFfjXkWNJkNfg8DNPLofj0y5if/rnHnCqstS0q8JeAym4KApOtL1rTA9ojOydmZ4mau2+SxPjNM5FuuQfnh/aHEscfn+NbQtUKMaMKv7xh7xFFqi5rZHq0aa6mORWlTVkwAgbU2nNTsU2XSb+Zec4LI/UiPsUTNb711hadeFlokk+s+s+kdAuYv+W1ncnuheDLx0AOv2Piu3ChdbLoHjJwT/p1nvj9QpeGHKkgmuXXw08doS5DgoCyBU1oYY5nWjPAPfUyeH23NeAR52PHgNyAnKPHvZyZXthupSfveqRWKdG53wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UypyJN3gcwMJaHY008LJePuBfCtCYs5THSbRpF8jIE0=;
 b=Zr7c6LoMV7S6RyiEZsykb8/8o0cpvuVccx1ssYuXxpi0n/spXlfQxkys1PqhVKjf6bbafEvJ/swJY09bmqalE9Hld9PyOz+0sFkYe/QbEMxSkjZaUBBQRT6Sgfc3aDnCL0GqryFnzZowrzug0/8yexqYTn4FIBPiaeyy4S+gZh4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from IA0PR17MB6347.namprd17.prod.outlook.com (2603:10b6:208:435::22)
 by LV8PR17MB7109.namprd17.prod.outlook.com (2603:10b6:408:18a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Wed, 20 Mar
 2024 17:28:11 +0000
Received: from IA0PR17MB6347.namprd17.prod.outlook.com
 ([fe80::200e:df84:29a9:8c9a]) by IA0PR17MB6347.namprd17.prod.outlook.com
 ([fe80::200e:df84:29a9:8c9a%6]) with mapi id 15.20.7386.031; Wed, 20 Mar 2024
 17:28:11 +0000
From: Svetly Todorov <svetly.todorov@memverge.com>
Date: Wed, 20 Mar 2024 10:28:09 -0700
Subject: [PATCH v3] kpageflags: respect folio head-page flag placement
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240320-kpageflags-svetly-v3-1-b6725843bfa7@memverge.com>
X-B4-Tracking: v=1; b=H4sIAKgc+2UC/x3MQQqAIBBA0avErBPUgqirRIupRhsSCyeiiO6et
 HyL/x8QSkwCXfFAopOFt5hRlQVMC0ZPiudssNrWujKtWnf05AJ6UXLSEW7VOkRjRtNoayF3eyL
 H1//sh/f9AJKOH7JjAAAA
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, gregory.price@memverge.com, 
 willy@infradead.org, wangkefeng.wang@huawei.com, akpm@linux-foundation.org, 
 david@redhat.com, vbabka@suse.cz, naoya.horiguchi@linux.dev, 
 Svetly Todorov <svetly.todorov@memverge.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710955690; l=3437;
 i=svetly.todorov@memverge.com; s=20240312; h=from:subject:message-id;
 bh=w5bKilvZAB+bmHjuYSw1udFPu6kifwZIWuDycj2WMts=;
 b=YMUQMHLfFXq9eLepxdCLCAewasiOivlZgBwYjH9lu6/RdOTynmxaH7GZoAB1fwOmVe5eSh6W7
 PBQWQiDX7jTAON+Lo9AggUmPwqKm8PhMtkuvqWAGqNz0sALaWd/+9MH
X-Developer-Key: i=svetly.todorov@memverge.com; a=ed25519;
 pk=bo0spdkY5tAEf+QP9ZH+jA9biE/razmOR7VcBXnymUE=
X-ClientProxiedBy: BYAPR11CA0040.namprd11.prod.outlook.com
 (2603:10b6:a03:80::17) To IA0PR17MB6347.namprd17.prod.outlook.com
 (2603:10b6:208:435::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR17MB6347:EE_|LV8PR17MB7109:EE_
X-MS-Office365-Filtering-Correlation-Id: 48fd7873-244e-49e6-708d-08dc49031da1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	39bma1ai8sCuCDiAeeuZdhYqNeYdmM9ys2zEQ/AB+PgM0NFTrJsLYUtnbkHsBRa+gA8nbRvtvhVCq/eySAIKIFUGzUGFk5ET5EYnugenVC5GvA+ydw3YOJgeVoSBss7QE2X9ik9dKR+1hUrNbWx78TTiN/KytXMF9e1f5oU7SkxCaPlaHZLnFIw4z5SVUodLu13Os6S5MSE9+TGU/IDmUW4Oa3LCeMUsXowqUZkRt1MjBcJdY7YwnGEIgkns7+M0+TLtaF+X4TtOhAwK027W36wXZu9Wjwq2BbNBIhnj8lnFPkpDWEeNORvc4kyBr2Iwi75cnPpuEnfFwWBXYDoVh64vtuIOF5tTX+yFTlH/O0VGdVv+HJIMtzXLcTG5moh2E15CJh/2wL+/p285mL5qQAl4tx9HLq81ePp/yFN9vLcgRZpnfq4SjUsD9Ivyq03Cn8O8vgKM/n9z+2bueL+zCotm2tGwFAWDB5+/h0Y1jy1Ig9Q0+v3l3TD/GGSMYT3a+uMzsP3W/MKQG/usHZ4ie98j1D9bfRu3WCo1L3oASe4S0ru8HJfloaWrYym+gUsF4aXhUcBoNDeorO1a3qCCdwVcbgQoXGWxjCy98UddKWCHDLeAgxPZ8eO3LDGutSVnCk8j7y4Q4lemzw1XIBEWxBaiX2643LtxViHgl9rylps=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR17MB6347.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODBybE9nTXROaUh3ZnZNTmQxamVGOTlQN2FkdkVZL0F1VkRNdjNaalRLLzk5?=
 =?utf-8?B?OFMxdHdpRW5ucDVwUmJud1BvMnZSWFVWTFdWU3oyS2lpNyttV25lS1FrRS9O?=
 =?utf-8?B?VldSTWFkTS9IdEpSbUViSVZ0SjRUdVd1d3IyMjB3Smc0dnpnWXFJQWcwcSto?=
 =?utf-8?B?bEdKQ3hZOURPY1d6M29TWWwvWVA5cGIyVFRXVGlSak5tZzN2aDZkSUVLbEpN?=
 =?utf-8?B?dnM2ZEhxZEJqS0tjZ3BZbHNOTFJlczhybGlsNzZ0cXA2ZzQ5Y3VpNm4rL0ZW?=
 =?utf-8?B?RmVzMGJvLy9JVWtmU2xjR29pN09KNFo3VWF4bEZWUmY3WDlrN1FnTEpKWERD?=
 =?utf-8?B?WnFZNjQrK3F5eWRRUkFJbW12cGRIMDNmd1BHMXZ2TEJHWDk2dWQyaXgyWUsv?=
 =?utf-8?B?eEVyb1lGajd2ZEIvK2lrZk43MWxnVHBwVmtLLzVLRzlLNmQ4Wm1TUVJBcWps?=
 =?utf-8?B?SnNnSXZIVUlOVVVVOFA3SklCeTdzYkVWU2tWZE9PK3JiaFBhb0xwZktBbDgx?=
 =?utf-8?B?RjdKK1BzRld4ZVl6aVI1ajlhdXhNYU9Oem5kVW1sSCtLR0xNTzllcGtrMFhT?=
 =?utf-8?B?aFlhL2RYa0NWT0xYZFJoemdlK2U2MG1zVWJDdlgxNWlCY205ZmM2TmZydlJr?=
 =?utf-8?B?UHV6UVZJUlB6WEpBS0hTSDYyQnlDZG8rem9LUzd0WHZsZlVPVHBNeHVsT2Qx?=
 =?utf-8?B?SDRSWm5ualczL1A0dHhybkd4SlBza3kvSGNGbmxlT21vcXZaRy96dEhOSnVk?=
 =?utf-8?B?cnh4dTZJQ3ExYWRnWU5IYzhBMG1Zb3IrbkVJYmlCREtXdi9yVVZ1UHpGeWhP?=
 =?utf-8?B?Vit0WG12UktQRnRIcnp3OTYrd3FWbFFtYUMyS1FhOUdyb04ydTJaa1pZUHN1?=
 =?utf-8?B?c3djbHA2S2FUMDl5eWFtT3pZTHRESnoxMi9pa0pTVEpLQThjdWcwYVhHNVVu?=
 =?utf-8?B?bldvTzBNOGQ5NTc5YlBWbDhHdEM1bWhSbWwrZFNiSUtCRFBVdDRDbDlWekFT?=
 =?utf-8?B?bWtvUEhLQTdnMmJNekJKMGVzN3B4cXQrNFhYcmZSUUJ2ZmlQYXRvdVZQNk51?=
 =?utf-8?B?aXZyNEwvbnN6V2hjQmVtTWFSWU9obElaUlRqbUE1YjFiNW1WZm1uQWNYMmZT?=
 =?utf-8?B?VTJXb2FEY2lKNmxZZGc4NmUyWkp0WlArNENvR0x3WDlsTzFkb2VUVHU0NGVw?=
 =?utf-8?B?Yi85enArTU5YdmNTNjFFVGVzRHFkUXJYSElDcUQyTzFEdHJJYklBa3E1YVRm?=
 =?utf-8?B?RlAwN001YUFuQWpsWVh5VWk5Q3ZYTlBpaFZZZW9vdzRNRk9Jb1NiTU9VL2Vo?=
 =?utf-8?B?cWg1V055bU5lalhRVStsMVNjOXVVRmNqZEhEQVRHSm9rcEd0YVRGZCtQNFNL?=
 =?utf-8?B?WXB6Yml4eDBTSVlBU214aUl4YjI0UDB0RytIVm9NOEhXRW9kMi9qMlpVSlZW?=
 =?utf-8?B?M1Vpc2pjNEQzYVFsSytkUXlLRTRlUnBnWXRVYlRRR1Y5Y0poUGk0MVBVR2Rh?=
 =?utf-8?B?N1pXZnV1TkthbGhPbkx4VGVhdlBVL0tQQUVpOG5oK2RCQTQ0aGNUeHRZRkN0?=
 =?utf-8?B?aDg2dmN2Y3U4emdsUGx2Tm14ZXZFcmRPeHFwUGNaTkhrUlZ3RmJGS1RKU3kz?=
 =?utf-8?B?dzZodWtHdFFHYVM4OTNrek9kV0gwMmZ5QTduQkFZY1ZqbUM4elh2Y2YwVU93?=
 =?utf-8?B?U01udWFFSmVzYlZPbG00bDd4RThTUGkxL0RVV0JLZDVHR3FzREZuWmxwTzdQ?=
 =?utf-8?B?MjNBbGdyempLL083SHhXZHR4ai9hR3V4RklXSkp0cmloYkZTYnBYdG5McXNv?=
 =?utf-8?B?SVRnRHVOdC9GYU4zZUZXN095WHdKbFllSC81TWw4NmlmcEtqWi9CUGpDM2oz?=
 =?utf-8?B?eXRVUTdQRVJtZzRMK0R2T3IwN0JUbHdmRFRUNjBuU2lEMkt6QkYweWFpbXZM?=
 =?utf-8?B?aThLdnZjMDlkenZpZW5HaUZDQTh4Zmpic3c1bGZMTGtGZFFOUGIzdjVqUk1X?=
 =?utf-8?B?cXg5b1I4MEFPOUNpU21kVnRqOVI4MkpiRVZBcW1OenZWb1dMWVZFYjdxYmdX?=
 =?utf-8?B?SVk5SnYxZlZSQVN0b2QzN2J0Wm1QSDd3TWxZZUR2VUpESDJLMWtGSE5nT2pi?=
 =?utf-8?B?S2ZSNFFVTUhZN2dvcXhyZnRtS1ZwZnBNcmg2alAxTEp3aHVWRlNHNEJkU3E0?=
 =?utf-8?B?Umc9PQ==?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48fd7873-244e-49e6-708d-08dc49031da1
X-MS-Exchange-CrossTenant-AuthSource: IA0PR17MB6347.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 17:28:11.1307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oULiqfVkNBBmFLaNFEfg/uPcnvU9/WvL421ekRKKDZuovLFSF1gPgPbbtz1Z9oSvIMjvp7XV084Ro9EpuSYdUJNb10FiyxSWqd0ZZtjEbi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR17MB7109



---
Page flags are now stored per-folio. Change kpageflags to report these
per-folio flags where appropriate.

Most folio flags are set on the head page, i.e. *folio_flag(page, 0).

Only three are set on the second page -- PG_has_hwpoisoned, PG_large_rmappable,
and PG_hugetlb. kpageflags doesn't report the first two, and the PG_hugetlb
check is handled by calls to PageHuge/PageTransCompound(), so no code changes
are required for these flags.

mm/memory-failure.c applies PG_HWPoison via SetPageHWPoison(page).
This call falls through to the SetPage##uname macro in
include/linux/page-flags.h, which sets the corresponding PG_##lname bit
on the given page struct. Therefore KPF_HWPOISON must come from page->flags.

arch/xtensa/mm/cache.c tests and sets the PG_arch1 bit in both
folio->flags and page->flags. So both sources are OR'd into KPF_ARCH.

As for arch2 and arch3, Kefeng Wang reported that they appear only as
arm64-specific aliases: namely, PG_mte_tagged and PG_mte_lock. 
Both are applied to page->flags via set_bit() in arch/arm64/include/asm/mte.h.
So those must come from page->flags, too.

Signed-off-by: Svetly Todorov <svetly.todorov@memverge.com>
Suggested-by: Matthew Wilcox <willy@infradead.org>
Suggested-by: Gregory Price <gregory.price@memverge.com>
Suggested-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Link: https://lore.kernel.org/all/20231030180005.2046-1-gregory.price@memverge.com/
Link: https://80x24.org/lore/linux-mm/20231110033324.2455523-4-wangkefeng.wang@huawei.com/
Link: https://80x24.org/lore/linux-mm/438ba640-c205-4034-886e-6a7231f3d210@huawei.com/
---
 fs/proc/page.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index 195b077c0fac..290470819fa2 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -110,6 +110,7 @@ static inline u64 kpf_copy_bit(u64 kflags, int ubit, int kbit)
 u64 stable_page_flags(struct page *page)
 {
 	u64 k;
+	u64 p;
 	u64 u;
 
 	/*
@@ -119,7 +120,8 @@ u64 stable_page_flags(struct page *page)
 	if (!page)
 		return 1 << KPF_NOPAGE;
 
-	k = page->flags;
+	k = *folio_flags(page, 0);
+	p = page->flags;
 	u = 0;
 
 	/*
@@ -205,7 +207,7 @@ u64 stable_page_flags(struct page *page)
 	u |= kpf_copy_bit(k, KPF_MLOCKED,	PG_mlocked);
 
 #ifdef CONFIG_MEMORY_FAILURE
-	u |= kpf_copy_bit(k, KPF_HWPOISON,	PG_hwpoison);
+	u |= kpf_copy_bit(p, KPF_HWPOISON,	PG_hwpoison);
 #endif
 
 #ifdef CONFIG_ARCH_USES_PG_UNCACHED
@@ -216,11 +218,14 @@ u64 stable_page_flags(struct page *page)
 	u |= kpf_copy_bit(k, KPF_MAPPEDTODISK,	PG_mappedtodisk);
 	u |= kpf_copy_bit(k, KPF_PRIVATE,	PG_private);
 	u |= kpf_copy_bit(k, KPF_PRIVATE_2,	PG_private_2);
+	u |= kpf_copy_bit(p, KPF_PRIVATE,	PG_private);
+	u |= kpf_copy_bit(p, KPF_PRIVATE_2,	PG_private_2);
 	u |= kpf_copy_bit(k, KPF_OWNER_PRIVATE,	PG_owner_priv_1);
 	u |= kpf_copy_bit(k, KPF_ARCH,		PG_arch_1);
+	u |= kpf_copy_bit(p, KPF_ARCH,		PG_arch_1);
 #ifdef CONFIG_ARCH_USES_PG_ARCH_X
-	u |= kpf_copy_bit(k, KPF_ARCH_2,	PG_arch_2);
-	u |= kpf_copy_bit(k, KPF_ARCH_3,	PG_arch_3);
+	u |= kpf_copy_bit(p, KPF_ARCH_2,	PG_arch_2);
+	u |= kpf_copy_bit(p, KPF_ARCH_3,	PG_arch_3);
 #endif
 
 	return u;

---
base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
change-id: 20240319-kpageflags-svetly-9faa11b17022

Best regards,
-- 
Svetly Todorov <svetly.todorov@memverge.com>



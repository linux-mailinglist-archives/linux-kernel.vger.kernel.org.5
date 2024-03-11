Return-Path: <linux-kernel+bounces-98473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66325877A8F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 06:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8977D1C21403
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 05:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304D18F5C;
	Mon, 11 Mar 2024 05:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="N64Yh5/d"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2064.outbound.protection.outlook.com [40.92.21.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E24B8BFD
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 05:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710134793; cv=fail; b=m5BKt1TAfpOQ+6ZhMlWixPxAnIcmHHrKwUbi6qN5yz+8oSwDuVuSrECi8S/r8oGEPMDlWUrMp6xf1iLEz2OuEkJi8d5JIRXaswawJ3xQqUH88tV8l4Ub8vS+Xyepj2KKFW7MYb/wNEzDHI7yO46cVhJL1OdxQFc2jgEWjoOuDt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710134793; c=relaxed/simple;
	bh=90WTCKUCHWA/+pCroQlxlVatV+v2kh6GgLskyH3mZwA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u1Wp+exiUXxtyiG9jdp7Xy5dRV3hmEw3FUDa+NJs4j4m4qfYyOqJP7cCZ6v+4k67gVG5CaGU3AdqzOqhnokVnhTev57+V6k5mw657eCmrPCJznAaE7MVnpQ8GmNkYcuPwoYtpn4aQLOY5/meOddyd9ipC4NCqlXXircv08rAUYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=N64Yh5/d; arc=fail smtp.client-ip=40.92.21.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FID6vaL5eyQn9j8frZr7sKju2X+tkpOfPnotZHT54W8PIrzBAs80UKJToQOsYZOXL0HEFv3aOyN17lsewOA2jqLGyOtqmTI6H4QYzuZEvBH927Xbkfa/O9EoD8D5fvnhGk6usWw/a0AjXgDK22uzQnOQSRy6Uw759gfE5O4m6xkSo++Bdm2w6/hPhLsOAd5yslbfUXNVRWKTQvS6KFTcvulakZoHU4GfdEGiIQTw21VL2D1daw1LwiYTe0EZ+bIhSyJFq2syx5X7VrH+PkgpbambHVqRTCkRkwKr/POu2H1nZW8ETCcfpgDCj4ZJEUXDzIQbNYiRS0xjBTOx36k7HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=En7IfXdgfuSSG0eY5mcWIbCk4JO4Y82fBa9HL5pi9As=;
 b=lc9YJifCPhHxM8blgjg8CNtOcU5Ab9x2GrEY1NUxmr8XnGE8PWd+vNtFd2mkJ5MNklC+B/9e8bz7Wrx3GYszD0YxkqPW3aoWlbWOrIQzcllVeAXyAOShy+M8T+gdIY7IATx/meLbgUJq4aOmYnXBkgB58dPgwgcsQV6167onDIz+PQR1MLQnRARR6O8eZttjGonafcpIoJBXp+eZuHZfWDKkMPE583x4HJES7/IZWvj6vTY+Zz04BksZh+SoU7GaAROYuToL1UVykISG5TStCnKYZE5VFtBLPb0fnSYhdLe0ZONITmSFKfmYaBifELDhGK9w2kgCcq4x0cFvELdMhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=En7IfXdgfuSSG0eY5mcWIbCk4JO4Y82fBa9HL5pi9As=;
 b=N64Yh5/dIGMM3e+uxMEGBacHXxeKATK7gGR1q1keNtGDG+10OINij0Kf11wChbHh5WQpG/OEDvCGTlFWBCMnYryDOMDvczmy5vWYmYqO/h1qJ9W+SI5eX4aLuqLN94TnI/KYoh7VZ4oLUrScnSL2EY6xdjTiqVGiWwnqfkmDaSjt3EDj0umh44sj2T+odZVCtkTo3p2tlALOhdmeg8bcXHY95xiZ7q19w/ZYGW+g82LotdoIg/sZUUUj9Q0d91MHR3HB2zhYUcFbzRxuKI6M5qFX6zPRTZhb4G9ycO40F41+THA82UFN040klVXXROBcG6c/Z7JRnIqgFcCiI/gtMw==
Received: from CY5PR10MB5988.namprd10.prod.outlook.com (2603:10b6:930:28::9)
 by BL3PR10MB6042.namprd10.prod.outlook.com (2603:10b6:208:3b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Mon, 11 Mar
 2024 05:26:29 +0000
Received: from CY5PR10MB5988.namprd10.prod.outlook.com
 ([fe80::11ce:fd0c:d54d:a27e]) by CY5PR10MB5988.namprd10.prod.outlook.com
 ([fe80::11ce:fd0c:d54d:a27e%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 05:26:29 +0000
Message-ID:
 <CY5PR10MB5988DFA5112EF7FA3A2DC2538C242@CY5PR10MB5988.namprd10.prod.outlook.com>
Subject: Re: [PATCH] Print also the BSP number when announcing cpu
From: Dashi Cao <dscao999@hotmail.com>
To: linux-kernel@vger.kernel.org
Date: Mon, 11 Mar 2024 13:26:24 +0800
In-Reply-To: <CY5PR10MB598826EB007900A8BE01F4738C242@CY5PR10MB5988.namprd10.prod.outlook.com>
References:
 <CY5PR10MB598826EB007900A8BE01F4738C242@CY5PR10MB5988.namprd10.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1+deb11u2 
Content-Transfer-Encoding: 7bit
X-TMN: [sSYVawI9HIQy2krxgH2olMUKGQ0Vv2td]
X-ClientProxiedBy: TYAPR01CA0169.jpnprd01.prod.outlook.com
 (2603:1096:404:ba::13) To CY5PR10MB5988.namprd10.prod.outlook.com
 (2603:10b6:930:28::9)
X-Microsoft-Original-Message-ID:
 <33362b82bae4430f2b1917b6510a19deab08414b.camel@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB5988:EE_|BL3PR10MB6042:EE_
X-MS-Office365-Filtering-Correlation-Id: 965070d3-0f27-4211-c0db-08dc418bcdba
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ynKAmNkwhXQUe5kTvIhXbfVSuszeei9Utf+0QnvYysqZZ8bQy+UTkArx4T0GqDa0PIyMuXXCT1j6KAkEwyMZWaIXEWzdH4YhBybfLWGrCCm7Yz4AZC0pTeNrxNeM04HRjLTm6DlxUAKm294mY72AMqOJLcgF4XejzLyCd+HOJZIkcOXqWii28KDpgTL5otBWU2DyopjKZRWEuMS0D/3y7LsUKXi+vXuW5JEA8wUEprzcppbdZ6dMS+Ob1Ed7k7AkFj7XlXP5wumpvcyEbLc8FXedjsrV4rUJDjEUZgDRafZM4EUBKuUtAPkXdDve+3SEHcBW1rjC61mJe7qLX15ET982ygUSDHP4pzcCDqS0QfH1zNCXOtz1PJegBM/brd5geGJwmszkxc0Eq7ndZeQKuLL4EhswbJsr7ZUTZk+0DBXR80CaKv2hyRYEJinGIg04ywU+q2W9i7m0Jl84mKI0HA0qCXGB2zWICT2txSDRAkNoJNhm8Sie+6hsmF1N4mHaoOcHSvf9BmC9bWsJAVVKEgmh8G202DEd1YclrJ9JV/7KNPmnpY05CHjBBenP0Ik9
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2tjd3BmRmk3K0NWa1Y1aTl3Y2lyT2trSXpaa0NNaU5Lcng0ZTA2NGM5Ymdu?=
 =?utf-8?B?N3dmRDQzRW1TaGZBZlkxdUsyaVpsRVgrYWppcFo2QUg3cU9NNndSZ2FPN2Jt?=
 =?utf-8?B?TERrbHVOa3pQc2tGZTJBUjBReXdXUU1laDQ0VGZNc3hDZkpENUFFTGhsR2pr?=
 =?utf-8?B?NU5ZNkpqaWdhZ1l1ajFhVlQ2bmxnbmxjMEEzck14KzlrcHZ4b3E3Y3Z1dDZp?=
 =?utf-8?B?VjVKMHM3dXlxZVoyOS9yVklNVmVTYVVmZ21WbE5MK2hYZHlqbVc4YUZnYWFT?=
 =?utf-8?B?aFpWeHMvYnJyUURRTkFoN2p5UHVNbUVnQ3FIK1AvTTJ3L3M1b3grRTRhajJ5?=
 =?utf-8?B?QzB4UWdZRGwvTklzdXc3c213RGJHMmxpMXdCb21Mb1Y0ZHZXVnJEY1pJZzNU?=
 =?utf-8?B?WmJ1MEtYd0REanN0UUtkbGUrcllSZXNxcWdONTlWNnFmRHZZMW5EQzdTemVC?=
 =?utf-8?B?ZUpzWmJmVnRaamRzRFBtVVJrQjg3YWh4b0lmdCtiUmFVZUEzTzd0Vk1DcTN4?=
 =?utf-8?B?bXhUNzlVU2Z5dUUxZXB4akRKZXl3VERZamxVN0k5SUgrS0hRZWg3WEtpS2JT?=
 =?utf-8?B?K1J6RnZxZUtPL1VJa0hCMk1wdGc0c3RKK0gvWFRxZHFEbGUyOS9mYXN0Nks2?=
 =?utf-8?B?OTI0Q25IVDhrN1MvY0N1QTNXMDR0dGcvRWpCUmRWem40MDhCQWd6S2JTdzV6?=
 =?utf-8?B?eFRNc2xGRldKMjV6Q1Fuemx6QXU2LzJWSWU1aFlQeEE3WE5tTmlCQ3RQbmlN?=
 =?utf-8?B?SkhnTEZqVlhISzZpZmU4aXVHNUdUL045eXZ6aUQyeXJZWEJvTTZOVDVzY2Iz?=
 =?utf-8?B?aXZ1Y1B2d1RYSzl6Qk0xbnVwaks5WTVxelB2b1AvNHVXWUJ1bVJtWmw1WWhI?=
 =?utf-8?B?Y1RKNzd0MlNIdlpuUGhVRWk1cXdCOTBKa3ZrNk5DZ0JJejdEMlFpbFpwYWRw?=
 =?utf-8?B?aTlUdGROcXlta21rRjU3anlkM2NUVWNLdDQ4ZEdpMzIxcTZwZi9OM3k2Yi9t?=
 =?utf-8?B?SVpzNlFQeHNIZFg3aWFPQjRqV0o5aml0UytyNjhjWEdXb1B5NEt1cDNOc29M?=
 =?utf-8?B?OVpZTVQwNFVpbFQyTGdwK0Erc0dXMG42LzNwMkpLVUoxN0UwTEFhaHFMd3Iv?=
 =?utf-8?B?UFNRSWpUTi9wdTh4S3FTazEzRDZWZzVSYkEwUWJtUjVqeW9YUEVuemg2L0xh?=
 =?utf-8?B?cWRuaEpEOHdESnpLd3F1L28ydEFuNG5hUmVwYTU4Umc0ektQWW9LOGpIWHhH?=
 =?utf-8?B?cERJU21WUVVtYytxU1VhZzZOVnpSenNUUlNrcGlWUEJ4bXJ1Zm0yVlI5TkRJ?=
 =?utf-8?B?TXg1OE90L2hITitVdEViSk9kcFlka0YxZG9ZeEp0Wk5UK2tVU05oK1NjWTNy?=
 =?utf-8?B?YWFWakVCa0dWWFUreVlQSGMwbUxldVpLMW1DVkdET1pGWEhvT1lIMnZPdDZ3?=
 =?utf-8?B?WXBiMGlucUhIemk3dThMYlhPa2hHVjMxaE5ibVNuNUErRFRXMWY5OTA2OTRV?=
 =?utf-8?B?alVEamJ6SmtpUjRMc1BmRnUyT01RTnFRZmFjNFRvK3ZTays4czltQi85NUFt?=
 =?utf-8?B?M1ZiQ0Y0UzVqdDdZMVk1ckVCL0pWY3NhVjFDZWhQcjRSNm5Zc2JDQ0J2RnM4?=
 =?utf-8?Q?U16/G/meCCAY6KSVeveMHYq0zW7nJtGP1g4XlbzkdJCs=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-926a2.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 965070d3-0f27-4211-c0db-08dc418bcdba
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB5988.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 05:26:28.8994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6042

On Mon, 2024-03-11 at 12:39 +0800, Dashi Cao wrote:
> When announcing CPU, the BSP is always printed as blanks.
> This patch will print out the BSP number. It has the assumption
> that the BSP is not the last CPU in a CPU node.
> 
> Dashi Cao
> 
I'm sorry, the bsp should also be declared as static int, not int.

Dashi Cao

Signed-off-by: Dashi Cao <dscao999@gmail.com>
---
 arch/x86/kernel/smpboot.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 3f57ce68a3f1..ef6e7a4bd020 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -931,7 +931,7 @@ static int wakeup_secondary_cpu_via_init(u32
phys_apicid, unsigned long start_ei
 /* reduce the number of lines printed when booting a large cpu count
system */
 static void announce_cpu(int cpu, int apicid)
 {
-       static int width, node_width, first = 1;
+       static int width, node_width, bsp, bspn = -1;
        static int current_node = NUMA_NO_NODE;
        int node = early_cpu_to_node(cpu);

@@ -942,7 +942,7 @@ static void announce_cpu(int cpu, int apicid)
                node_width = num_digits(num_possible_nodes()) + 1; /* +
'#' */

        if (system_state < SYSTEM_RUNNING) {
-               if (first)
+               if (bspn == -1)
                        pr_info("x86: Booting SMP configuration:\n");

                if (node != current_node) {
@@ -954,10 +954,12 @@ static void announce_cpu(int cpu, int apicid)
                               node_width - num_digits(node), " ",
node);
                }

-               /* Add padding for the BSP */
-               if (first)
-                       pr_cont("%*s", width + 1, " ");
-               first = 0;
+               if (bspn == -1) {
+                       bsp = raw_smp_processor_id();
+                       bspn = cpumask_next(bsp, cpu_present_mask);
+               }
+               if (cpu == bspn)
+                       pr_cont("%*s#%d", width - num_digits(bsp), " ",
bsp);

                pr_cont("%*s#%d", width - num_digits(cpu), " ", cpu);
        } else
-- 
2.30.2




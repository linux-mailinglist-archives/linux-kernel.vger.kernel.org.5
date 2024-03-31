Return-Path: <linux-kernel+bounces-126071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5C88931B6
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 15:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAF291F214E8
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 13:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C874144D26;
	Sun, 31 Mar 2024 13:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="U5zH/+Zx"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04olkn2013.outbound.protection.outlook.com [40.92.73.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9EA2F2B;
	Sun, 31 Mar 2024 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.73.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711891847; cv=fail; b=VAQeeb+ZH/QbkGdOr+YbMhatmvdAt3wa7LeCqKS0gXtAaaEsuwdzSeUaYC649opah5MtEQihjli6l2BIAMI1GbY5W5RfmtVLzIG+U5gXY/+3XDmbEt727ELY/N+3Xst/OaLcrqG3oqDoQmUID6Cb4EUWg3xw0PWDOmzj4gpek+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711891847; c=relaxed/simple;
	bh=jpZB9VL35ZcYJMcKmxoxGOELjzaGjMcGeh/BZQe8E50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SekergH3mx3sA3ARqiC5RwhBkg39s7UHgO4I5Q4NA8Dic3s+HO5Ap/oJk6ON0jarHnPiJGMW+QnBdibgXYsQrpxx86nb2AT1aGcpFDtyecr+akUhd7xCPGhS588QkZzHYzQoTS94cMeJ/lCHxArQM6wt3FE1KcmISP7Zqpegseo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=U5zH/+Zx; arc=fail smtp.client-ip=40.92.73.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8AWcQiCLL87r1WTRwUqroGn1PSZYINI4z9Fvecld2sO2MaJGLN7PnsW6OZTtvMPTNbi5+RnZeEdUtnVtOd5u5u1GZBNxlIBuFqCUzIQR+7tYP/ldzKB0sGz57AW7HgWWW0TruXfwARKn+6N/Zltb8bI0p1R6RKNNYBU+ZUPQuUZEzEo60Sv8Mnhprb90CwYu4tqZyIRmw1Cgm4w8mdQNK0FsHsZx/3VztMnN5aJvfGDNRicEm/LYfSyxeFZ/d9mGkIKicKCPqBF0Ne3pbMRyjN9Oar/6Qwoe2SCBKq7GYjhCp48F18fJNTYbq+0MSYjAIA+RteZdPRK9nMuVhmVRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vp0X5j1AYy8IdlVfqqaB5tqLgeJVFaGnqtThpSFv8k0=;
 b=bxiySta3MwadTdbzWI+gSHN+R5jkKLZIk6VMBIpM4Oi/H2PibNyyKyfLLfNJ2gwPBliF7GMqoHXOzLcOmwbLMiu7toTqejIl8BG7P1ViGgWkpUstelAl19qng25C2e7X1qQnSqOR/7/7RJ815JCY94WVQPnoLKR662mPVDPc87PuZangGa61cBZsqCyltOZqw8IrzBrBvR1atqlcchFWPcMHmT3MhECCUYzupxGG3Xd05OVI7W0AT8zjGkbUovwXUPZB67OH02t2Q2DQAKjVNWg1YBeTTGCJCgTosqPZLRDhODP0z0ma6mRWrK26g3Lu3WDMiOLe81uUfkPaldKtyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vp0X5j1AYy8IdlVfqqaB5tqLgeJVFaGnqtThpSFv8k0=;
 b=U5zH/+ZxSl2uarb1koGBSSLEHbXhpB+7vKQaDZCSZwGjnoHtt7mIPE0vkAi6sJYVdutPVIN+3ux7thcRf7/y6U1k1hPvJUCsctPKZwLqbJhK7VqnsnNY+e+u6DNOl/0WSNVdqaB4x7W/g/rtOy7lNiS3xJJ2Sxl7yuxubSbvlMCJGyLgH36zKrKpiAAXHDG0u0yVBdMKRl8ThT6CV7PhDGKGWiiqz4fwlN8fG93Du71tdHMzLaYMWmI/4bAPwqtGeIYJMjLyamnTs6S3cHRZqh7xohFANfMEmOpfJHVvhqn//ixLqLvS2wc61rr/GemDYDylAbZXCMmjdyTEFFNkHw==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by PAVPR02MB9890.eurprd02.prod.outlook.com (2603:10a6:102:310::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.45; Sun, 31 Mar
 2024 13:30:42 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::9817:eaf5:e2a7:e486]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::9817:eaf5:e2a7:e486%4]) with mapi id 15.20.7409.042; Sun, 31 Mar 2024
 13:30:42 +0000
Date: Sun, 31 Mar 2024 15:30:28 +0200
From: Erick Archer <erick.archer@outlook.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Erick Archer <erick.archer@outlook.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] perf/x86/amd/uncore: Use kcalloc*() instead of
 kzalloc*()
Message-ID:
 <AS8PR02MB72372CBD73E905472351EFE88B382@AS8PR02MB7237.eurprd02.prod.outlook.com>
References: <AS8PR02MB7237A07D73D6D15EBF72FD8D8B392@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <Zgh/+xSyOil37H1F@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zgh/+xSyOil37H1F@gmail.com>
X-TMN: [5r6DAPsesWsq3VthBN/Q9LGoFbr6+UFN]
X-ClientProxiedBy: MA2P292CA0023.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::18)
 To AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID: <20240331133028.GA2383@titan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|PAVPR02MB9890:EE_
X-MS-Office365-Filtering-Correlation-Id: c0ec3ab6-4d49-4d1d-bcd9-08dc5186c231
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ywrfIqpSbd9KRSzHRPly6orNFz1xi64nfkeW83R1S9oRt0IQZxmdwdkXF2Ju3qLNU4NpZ6cLLSoH/AEhfv+aIyZLI2AbWwB4zTjUCwm2XSlOey/DvRK7KhbgH/9cJlOBVylGWrHmu2VbuNFJpDsvkEic6VyregYMTEoI/0RJKWCOb7+Ws5Oh0mzU7E4Gm6fM+9sMBkec4zfIrDuvC8lK0CfZFjyuXs5p8R43EsnnhbF+suP3DeWnEtDxdmcrFEAtX45H6ite8gbdJTQ7+Zwah1nhkG3qVDWomhTyH56uTz1kQ2Uu5pQQpHSjph2m3tAFl828gfFFYaNbvyKfhPWCv/9AQw7UrUTwNFwiKwYKn+efgiqvm0FB2AM0gI0HlEtdsLASn03OeSQ/4Q9Z2naOsFXd6d5AOYUcZZg3ACs02Fpnvrw/BCzZyNFIAU8V2wTSXqdqyeo8aU3zhXVUOedPZ2qQdQkfGE3Wv2gH1J22GxYl9MFKb+DiP9pXVsJ3HE79r3yfQeJTK/hE0ZpCTHW0j9RL4oBgWss8lctLXLjt8c2O9pmB5JWg4QYYh800CZVRISTiIcun5REk+WXl8XnZYWf6MfsPBPnP8MS1JJxqHUxoyBbCdijcn5Ucdi09KQjGRZjX5r6jEYvoVD6lV3pDt/V3QSVmdng9ZysKh/+HnCwUFyxT2rTgmHzYHxsGyTwoX3HlFq4H3qZykF7AtwTa+Q==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G0f368EB0wcsP4l/IkpIw8n1IJjnEO8N/YeQThAFOCw+FsyC+D6zV46I6S5W?=
 =?us-ascii?Q?J65dz0mpRtVXyUH0UM6V5hH5MWBmRwHLXTPHk8XoFa42Na8ZT1Ymqj09taK8?=
 =?us-ascii?Q?NI5McPhPLV0bXygVdzSYN3xpqj87CZgGYeMpI+KYGe6m1KIbWSw/ulKxgmrp?=
 =?us-ascii?Q?VJjgfo7LLUHhJDIN2Okxh9EFZ5HPY+5Rcl0uO3L0FrcXt3+ZjCNGj1jmKVWZ?=
 =?us-ascii?Q?jx6el7RPWyrmyLnfRxnzTZRjWn6I3uInO5+aS7kjHgP5+U28WotZ60c9nYw+?=
 =?us-ascii?Q?V9BrwlHCLdC8OpeooHrsCgxNOhDTHyM8dJ6TsnSRzHaEqz6hbVVJkMG/4mAN?=
 =?us-ascii?Q?hzdCvpYPNDrV88+rChp3oIFJ+IrYLGiJYyMNnfMmIIWzqgULuVUpokQa6BgR?=
 =?us-ascii?Q?B2Y5weJLjGC2qBwQ2XPeeo6sKwoxWNO2B7ljA3Z9cLhNi7r5OR/xp91AFNHx?=
 =?us-ascii?Q?ieAnceuBRtbuvJJsQI88m0g4KBpyXZKUouKIXGRaatBVfFb1LcRJzixk71Qu?=
 =?us-ascii?Q?EMGHvLgjK1VUAdNWrQuarRAP7Xy/93Fe/nFNJJGMZRNPhvRH+PJWU3QT9y7v?=
 =?us-ascii?Q?WZDMSz6wYzwdetyr8B3RIyZNh6V6E9wxGMKSG5xJ/7np7lpjDXz+dup7KwdL?=
 =?us-ascii?Q?ojDZoEzMnkrDoKcJiZHHvKTO34157EIg31mQ2OXgrgiwz39CGxp3B+72lTSP?=
 =?us-ascii?Q?7Bb55Gu8HxqErBjZnUXp3PYZxXU4z3nhI7yezk4bUlQYH/JkCHy726Dm86L5?=
 =?us-ascii?Q?P4Y3jAas0+J/sHOEuVYqer+E7HMSgMAEFiAgi9ar2082Oo6QYYH3KWstGRP5?=
 =?us-ascii?Q?06Sye0Cfb5AuAwMw+HqzWiRf4VkqrGItBy1L+YXJe+Ez0VpC32dmkrY3vvXW?=
 =?us-ascii?Q?4gFfv3h2epN7IbQ5FQP/euONGMkRjqLzF1BuO9x0CaYsM9xrcMZJOEfPg6hW?=
 =?us-ascii?Q?qPExtWidp9mEao8S2/jlchGwPRhqMZvpss6g76HP2K6TOsoqeIgUqoIiRL+m?=
 =?us-ascii?Q?Fwx2lPjZO0WDv5ftosrQonGgBVM2nNR87vFGQlRRnEvJRyITSmCc/J7dcIbg?=
 =?us-ascii?Q?bFlGYBaaMlM7R/OJ0BDdTHNOy+hLt+smXEBt9sLA5Lehlg21O7hI8gbSE992?=
 =?us-ascii?Q?RnM+BB4MAjxzLJ2HsVwl/cyveQhUiIitTG6NkwW1ge0Es+NEjCdp9YKPX94s?=
 =?us-ascii?Q?vRQwI0sQuXb5JzKbc6OUJrfZeBp4Ige9fO5UMF9YyMFkfCK7OuHavDHK/ZNq?=
 =?us-ascii?Q?CZsIIKwLGDRTvxFmoYV6?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ec3ab6-4d49-4d1d-bcd9-08dc5186c231
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2024 13:30:42.3058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB9890

Hi Ingo,

On Sat, Mar 30, 2024 at 10:11:23PM +0100, Ingo Molnar wrote:
> 
> * Erick Archer <erick.archer@outlook.com> wrote:
> 
> > As noted in the "Deprecated Interfaces, Language Features, Attributes,
> > and Conventions" documentation [1], size calculations (especially
> > multiplication) should not be performed in memory allocator (or similar)
> > function arguments due to the risk of them overflowing. This could lead
> > to values wrapping around and a smaller allocation being made than the
> > caller was expecting. Using those allocations could lead to linear
> > overflows of heap memory and other misbehaviors.
> > 
> > So, use the purpose specific kcalloc*() function instead of the argument
> > size * count in the kzalloc*() function.
> > 
> > [1] https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> > 
> > Link: https://github.com/KSPP/linux/issues/162
> > Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > Signed-off-by: Erick Archer <erick.archer@outlook.com>
> > ---
> > Changes in v2:
> > - Add the "Reviewed-by:" tag.
> > - Rebase against linux-next.
> > 
> > Previous versions:
> > v1 -> https://lore.kernel.org/linux-hardening/20240116125813.3754-1-erick.archer@gmx.com/
> > 
> > Hi everyone,
> > 
> > This patch seems to be lost. Gustavo reviewed it on January 16, 2024
> > but the patch has not been applied since.
> > 
> > Thanks,
> > Erick
> > ---
> >  arch/x86/events/amd/uncore.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
> > index 4ccb8fa483e6..61c0a2114183 100644
> > --- a/arch/x86/events/amd/uncore.c
> > +++ b/arch/x86/events/amd/uncore.c
> > @@ -479,8 +479,8 @@ static int amd_uncore_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
> >  				goto fail;
> >  
> >  			curr->cpu = cpu;
> > -			curr->events = kzalloc_node(sizeof(*curr->events) *
> > -						    pmu->num_counters,
> > +			curr->events = kcalloc_node(pmu->num_counters,
> > +						    sizeof(*curr->events),
> >  						    GFP_KERNEL, node);
> >  			if (!curr->events) {
> >  				kfree(curr);
> > @@ -928,7 +928,7 @@ int amd_uncore_umc_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
> >  		uncore->num_pmus += group_num_pmus[gid];
> >  	}
> >  
> > -	uncore->pmus = kzalloc(sizeof(*uncore->pmus) * uncore->num_pmus,
> > +	uncore->pmus = kcalloc(uncore->num_pmus, sizeof(*uncore->pmus),
> >  			       GFP_KERNEL);
> >  	if (!uncore->pmus) {
> >  		uncore->num_pmus = 0;
> 
> This change is nonsense, kzalloc() is a perfectly usable interface, and 
> none of the arguments are user-controlled, so I don't see how there 
> could be a real overflow bug here.

Yes, you are right. This scenario is obviously safe, but this is an
effort to get rid of all multiplications from allocations functions
in the kernel. Surely, the commit message is scarier than it really
is in reality.

If you prefer I can send a v3 with the following commit message in
order to better explain the change.

[start of commit message] -----------------------------------------
This is an effort to get rid of all multiplications from allocation
functions in order to prevent integer overflows [1].

Here the multiplication is obviously safe. However, using kcalloc*()
is more appropriate [2] and improves readability. This patch has no
effect on runtime behavior.

Link: https://github.com/KSPP/linux/issues/162 [1]
Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [2]
[end of commit message] -------------------------------------------

Best regards,
Erick

> Thanks,
> 
> 	Ingo


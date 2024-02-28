Return-Path: <linux-kernel+bounces-84512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE3586A7AA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 05:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0B1B1F27635
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 04:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8BC20B35;
	Wed, 28 Feb 2024 04:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DEF/88ot"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2068.outbound.protection.outlook.com [40.107.96.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE0E20B03
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 04:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709095409; cv=fail; b=mhZ2i8TgBpv4bAiUDfOfLNpNhytLDMRUKZpuPUc8WmjKC7cSx0zeb87JtHYSzT7QlbcEeP63ck5x9HPUwH81O5r9pjizhc/m1PUvzkHMk9FP0V9efc6pfCIk+LL22hP4MvCAgHxues5Aw2ZoCOheW2ASnAg0/qG/Hc2kweBjfEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709095409; c=relaxed/simple;
	bh=//okZHlkjIBoK6WtIT9vbmiecCPpvaDg2Ai4du5BZCw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ItAbqId3s2YjCgg+ezDtMiHsgyRGhHpxGE3q74VqcVEbZtagyZNmhq7UPB8kGYXX1iaiTGCK0TOGv/8LFPCVSjsDMhD5udqpsOjPKkoz/faeVsa/kbv9tBNe9gFRjjU9v2BFd6RoZ1zhmmqtHzGi/U2RxEp2R/0PbGzmWlVPSm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DEF/88ot; arc=fail smtp.client-ip=40.107.96.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krRXO8JfdG+S53cmsBYXmkIvqwIZdhDGCb2WGpEZ+LIFZTntYskNEF0sVebtSykFZnW3yP7BKgMXZ6F8zfg27zaMR42XlL1h2HSQ7tGoCnQNwSJij+kbvvi0Mttfbtfixhfoa6vdloYpn9EwOYFG7KZeGkS0LyB14oYWpnUmGS+uchXccub4ntFIComDSR5pk9K+73hk/CJAWc1YFrwJU0OkVwPX/aGpMixcDbR16PmA1gHajfFu6RNDjwJ4H2w5xedADjZxkF0lGY9+S03xMFR5Ds/BA6deM0yffeMXR/VVVDqpmDc6rNqkHI+ZwlV7jN6dewi68ZVA9xpu3g6scA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvNKoIKtWJf7ZQibKUSxlPMfS1Ce+yz554G84NBh5wg=;
 b=mpHXmWg12ZCkm5FTvpuUAcecKe7KqcBiOjmj8abxt3sM76qhgWEjKQmVZHgxppjJDhx3hQGQYETp0im5a4GISrynYbZBWtRng1tavqE7RjdPF1uOSq0sVku7nLvqYfhi5cTNpVr+FGPHYSbeZxr6YpewHirGLEe6xtoQSSNTu7iUUee/Ts4gr6njFGFZFRbrugxbR9LeKIPZacN1twf0DUUC6NbfAK8nRJ5fdNpAovhfrWdXW4tanAErzwDZYPz2l9Mha/TCgqV6lwWh6cNOd3JYDkRq5vDWlhXEE1f3s74gVxzMh3aaaxji3UNe66fa+E9SX32jAHeYE7YvYtqCsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvNKoIKtWJf7ZQibKUSxlPMfS1Ce+yz554G84NBh5wg=;
 b=DEF/88otIcC7DmN6fH+3KQ5owm42OrU8+IwynWLs52O11lfsINA3q84jHqbHHOoOdLHiCdjAngt06JTCyCaFv8RlQQRKX8Y/XjMm65UUlBPjg+s9sWAod9UOBUwSajCXz6f9myzkLdpOovfL3w3BACSPAoUaDTpwbtukCFLtolk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by DM6PR12MB4404.namprd12.prod.outlook.com (2603:10b6:5:2a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 04:43:25 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::3150:d50f:7411:e6bb]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::3150:d50f:7411:e6bb%4]) with mapi id 15.20.7316.037; Wed, 28 Feb 2024
 04:43:25 +0000
Message-ID: <3937e057-6b47-77fe-9440-ade079ee2cfe@amd.com>
Date: Wed, 28 Feb 2024 10:13:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RESEND][PATCH v8 0/7] Preparatory changes for Proxy Execution v8
Content-Language: en-US
To: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Joel Fernandes <joelaf@google.com>, Qais Yousef <qyousef@google.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Zimuzo Ezeozue <zezeozue@google.com>, Youssef Esmat
 <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com
References: <20240224001153.2584030-1-jstultz@google.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20240224001153.2584030-1-jstultz@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0245.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::10) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|DM6PR12MB4404:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a6b7cb7-8fe6-4ee9-76c3-08dc3817cca6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QTtiCLG0cFjFstuSuuwlN23gWaL8tbd/luF8B6qSAZ90DdO4519nr9QptX2xUulI9xt7galIhKWOOBQCeDbYhuAxrNaXjWHkwqFQGPODjPI1sKvjhglY8WljmYbyadKwmHr2wyp36RTz+PD8pjoBlbOM9my/YPMfw94+YGsgDY1Ujl2S/PDZ6vjw7+Zdo21VtdGkWMTqa5gcyAzPfVmftAWp07Qg+PS53hEiytEC0E8gPsXNXABzhxkGIoS/VDTZD1ztE5oT/KuCG/R8jVVYGUUiNnPE2W+M+gKbafsKMSSsLAHfHjeELSQKSWlDNsjuh6r8pnVZeQ4GQ9ZZe4mJ1oVUgx1t/MwlJoZqvAOot2I+SH3PzK/nEtcLq/uPUEUEvHfpS432HmS7+W/+Xb/v5222DQrvNXoWDCdl5oi/zd12giRnnmAMjzRea89XMZU55fSQwCEVHBwpaXsu280iVNdne6ie3yWjtbfs8Ve5ZSi5f2Js9GEAcMkgdYDw4tw00wJ8yNoPMoBJjfmQrkGizI7jELYnrGbEk5WG5SamQX/WGhveH74fnNj8KhtPDkdf1txTq9tW5RFt2YVhcz9erf5YYMInKT5SbUOB0vkS4HpEv/zHyBum1mz+1ePTgBA6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vm9TZDJhZDhFMzd1cUU3NFp2Z2dtRTVsdy9XMHVkQzNHbWxaZUtDdTV1ZGtV?=
 =?utf-8?B?dHJCbGsrQnF3M29wdFBaU3gwVFBPaVJoajZpbGU4aERxdVh0amFRMCtoU3FF?=
 =?utf-8?B?TWhmVU1teE9oRzlZR3JSYnpkSEhaNDVSbGdLQ0l0SmtuampaTllFbUFzZTZy?=
 =?utf-8?B?Y3FoWWtnbmd0MTVjdE5JTnJiYTFwQk42NWVBYjZ6U3ZFRlNIOFduWkZqZlpM?=
 =?utf-8?B?NTZRcHJaS3YzWldtVkoxUkFYMmgzT2JQZURqME0zdTkwNGdQTTMzQ2QzRjFE?=
 =?utf-8?B?K1dPSW9aWkR0bUszSW10bWl6R0tPZ3gvdFFoYnJnaVFCa3RHREVGQVkxRjZG?=
 =?utf-8?B?YXpMcElZS3IwQmdtVStWWkRveCtPRUdCeVB3SkNxVEJXZmcrTHkrb1djNFl2?=
 =?utf-8?B?cVU1Y2FBR0FWUUJwdEN0QWlCb3FqUUh0MjM2c05WSXZ3YTAzYmk5MkVRM3Ev?=
 =?utf-8?B?aFZSaGlMNXovQjJ1dDFNQ20zRy9CUENFZG9zZFgzbDdZckVmR2NzTHRlUU5v?=
 =?utf-8?B?NzkrQjBqK1RZNTBLTitkRkNtaVYyUnBKSFFyM1dvdHhxeUFaUE84RzhvanFw?=
 =?utf-8?B?aDljTTZtRTBuR2x3KzUwRGRKd1Bld1ROVFUyOG5tNTlyYnNJVlI0V2V5WE5L?=
 =?utf-8?B?UDNqeGFiN0xVajNHSytBRnVCQWhVSGhYeFVLcUFyaVVIU3ZlUnc4VDNxWWZI?=
 =?utf-8?B?d1VtMW9GMWVORmVXb3RxbG54Nm15bTNjY05XYzBkbXhtS2E1OGxWRFFSUVg1?=
 =?utf-8?B?RnhPdHN0SSt5VXZKTXk1UUdxYTlHSVc0b2FxT2Z6L0NmOUVFcVlNdzcveGow?=
 =?utf-8?B?Rk41ZngxT0Fxbyt5UlBMYUxwZnBIU2xxczhscDJVanRicEVJQVFyVVZPUWpH?=
 =?utf-8?B?ZU5PdjJDbnRScUtPcWs4bFZjK3dtWGZ5U3JjdzRjcDdMdzRhckt4V1FkejY1?=
 =?utf-8?B?eHpKaGVsd0ZpZ3hidEN5ZTUxa3BRNE9iZEdaWTM0OGtyZE9xQ3NKdUZpVmN5?=
 =?utf-8?B?MHAzbmJmdjFxeEFOK0tJWE5XczdTcG9GOUFrYlRaT0cxYWNSb0VMT0o0aVdx?=
 =?utf-8?B?SzJ1TG9RUERrajNtT2hoUWtkUkNuQmRXUlN2TU9qMnJ3d09EYTZjaHFkUXpB?=
 =?utf-8?B?YlRKY2V1bDBLSVA4UmlUek5mRGE4emtubXgxVmJSZG02aVVDR1NWOUNvekZ6?=
 =?utf-8?B?WHpmd05DRDVPZkNoT1Z5QU92K01iekRqQW01ZnBpSUp2V2xEc3VuelFXUDNX?=
 =?utf-8?B?MWV0VFdtMG1YaHRkVlliSkFJQ1JrS09KV0NpUkFHSXZaa3FJSzJBTTFzYlRJ?=
 =?utf-8?B?RklSRnh2NWs0d3lUL3ZtSUJ6eVdtNDFOblNVbkRBN1Y3ZDBIZkZDdm56ZlBx?=
 =?utf-8?B?eVJNVks5Nlg4Znk3RjIvVXUxK01nVkxpV1ZpK0huR2VUYWt6T0pCYkROYzRB?=
 =?utf-8?B?M0RHUk1tdFZINUx0K2NoL29qeHl0MHc1ZEJmY1prcEtZV0hybDErZG1nOUpH?=
 =?utf-8?B?cDZhdkNLQTAzTjAxNUkxemd4cTdISWJwa2xJdnY0cmoxemFTeFhsWkhUVGRH?=
 =?utf-8?B?SFg1V29jQkJCUGJIdEg1MHhQR0ZRbitoVHBuTzJ5Z1JteExVVjJaVWFkaHJY?=
 =?utf-8?B?K2xpVlFsTGFlWGh4cFo5KzZ6K1A1d1YwRk5kWkU1cVErakFxaGtVQWU3NGhO?=
 =?utf-8?B?dlJ2anhRY2RhcEZQQmVhNmk3ajdoS3RuRE5uUGpGd1k0Zk5FeGw2WkhLOWZj?=
 =?utf-8?B?TTJyMjVDSGxMa1h2d29wMU1HVkJqaGtnYzJUamVOci85TU9OOTB2WWRIVXlt?=
 =?utf-8?B?ODVROGJTN3Qrek5mMm1aeWRud3QwY3VFLzZqY0FLQ1FTMEltK0ZYbk9lLzdy?=
 =?utf-8?B?b2pZd0xuRjNHeUFJU2IrZ3hQMzBjNzJhOUVCR05iN3U2VFhDRzZQY2U4ejBq?=
 =?utf-8?B?NVNHeGhhYnBXRGxqMlhSV1lmNWVoK0lpV1ZVUTV2akVwUTAvc0NGK0haNUFF?=
 =?utf-8?B?LzhPbngvNXdJa2hick1qbER3WTUzcUFZTXNPZG1JTkUwK2RNK0dTSWYzRDBE?=
 =?utf-8?B?c0djYWdxaENHWWdkK0NNMkQ1R2V1dlpQNjJENkRnTkQ4NElSeE0xdW0zcVVp?=
 =?utf-8?Q?QgsTVU85GYxK07sFDMs/kCjVT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a6b7cb7-8fe6-4ee9-76c3-08dc3817cca6
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 04:43:25.3459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wrigclJx0z3Kc4DZK0GekkW7H7crk27+MAo7mJR8EZRd4UrFR/u6XxYUYRLkqd2WEDY/1egw4SDsVqa2jQP41Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4404

Hello John,

Happy to report that I did not see any regressions with the series
as expected. Full results below.

On 2/24/2024 5:41 AM, John Stultz wrote:
> After sending out v7 of Proxy Execution, I got feedback that the
> patch series was getting a bit unwieldy to review, and Qais
> suggested I break out just the cleanups/preparatory components
> of the patch series and submit them on their own in the hope we
> can start to merge the less complex bits and discussion can focus
> on the more complicated portions afterwards.
> 
> So for the v8 of this series, I only submitted those earlier
> cleanup/preparatory changes:
>   https://lore.kernel.org/lkml/20240210002328.4126422-1-jstultz@google.com/
> 
> After sending this out a few weeks back, I’ve not heard much, so
> I wanted to resend this again.
> 
> (I did correct one detail here, which was that I had accidentally
> lost the author credit to one of the patches, and I’ve fixed that
> in this submission).
> 
> As before, If you are interested, the full v8 series, it can be
> found here:
>   https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v8-6.8-rc3
>   https://github.com/johnstultz-work/linux-dev.git proxy-exec-v8-6.8-rc3
> 
> However, I’ve been focusing pretty intensely on the series to
> shake out some issues with the more complicated later patches in
> the series (not in what I’m submitting here), and have resolved
> a number of problems I uncovered in doing wider testing (along
> with lots of review feedback from Metin), so v9 and all of its
> improvements will hopefully be ready to send out soon.
> 
> If you want a preview, my current WIP tree (careful, as I rebase
> it frequently) is here:
>   https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-WIP
>   https://github.com/johnstultz-work/linux-dev.git proxy-exec-WIP
> 
> Review and feedback would be greatly appreciated!

o System Details

- 3rd Generation EPYC System
- 2 x 64C/128T
- NPS1 mode

o Kernels

tip:		tip:sched/core at commit 8cec3dd9e593 ("sched/core:
		Simplify code by removing duplicate #ifdefs")

proxy-setup:	tip + this series

o Results

==================================================================
Test          : hackbench
Units         : Normalized time in seconds
Interpretation: Lower is better
Statistic     : AMean
==================================================================
Case:           tip[pct imp](CV)    proxy-setup[pct imp](CV)
 1-groups     1.00 [ -0.00]( 2.08)     1.01 [ -0.53]( 2.45)
 2-groups     1.00 [ -0.00]( 0.89)     1.03 [ -3.32]( 1.48)
 4-groups     1.00 [ -0.00]( 0.81)     1.02 [ -2.26]( 1.22)
 8-groups     1.00 [ -0.00]( 0.78)     1.00 [ -0.29]( 0.97)
16-groups     1.00 [ -0.00]( 1.60)     1.00 [ -0.27]( 1.86)


==================================================================
Test          : tbench
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:    tip[pct imp](CV)      proxy-setup[pct imp](CV)
    1     1.00 [  0.00]( 0.71)     1.00 [  0.31]( 0.37)
    2     1.00 [  0.00]( 0.25)     0.99 [ -0.56]( 0.31)
    4     1.00 [  0.00]( 0.85)     0.98 [ -2.35]( 0.69)
    8     1.00 [  0.00]( 1.00)     0.99 [ -0.99]( 0.12)
   16     1.00 [  0.00]( 1.25)     0.99 [ -0.78]( 1.35)
   32     1.00 [  0.00]( 0.35)     1.00 [  0.12]( 2.23)
   64     1.00 [  0.00]( 0.71)     0.99 [ -0.97]( 0.55)
  128     1.00 [  0.00]( 0.46)     0.96 [ -4.38]( 0.47)
  256     1.00 [  0.00]( 0.24)     0.99 [ -1.32]( 0.95)
  512     1.00 [  0.00]( 0.30)     0.98 [ -1.52]( 0.10)
 1024     1.00 [  0.00]( 0.40)     0.98 [ -1.59]( 0.23)


==================================================================
Test          : stream-10
Units         : Normalized Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:       tip[pct imp](CV)     proxy-setup[pct imp](CV)
 Copy     1.00 [  0.00]( 9.73)     1.04 [  4.18]( 3.12)
Scale     1.00 [  0.00]( 5.57)     0.99 [ -1.35]( 5.74)
  Add     1.00 [  0.00]( 5.43)     0.99 [ -1.29]( 5.93)
Triad     1.00 [  0.00]( 5.50)     0.97 [ -3.47]( 7.81)


==================================================================
Test          : stream-100
Units         : Normalized Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:       tip[pct imp](CV)     proxy-setup[pct imp](CV)
 Copy     1.00 [  0.00]( 3.26)     1.01 [  0.83]( 2.69)
Scale     1.00 [  0.00]( 1.26)     1.00 [ -0.32]( 4.52)
  Add     1.00 [  0.00]( 1.47)     1.01 [  0.63]( 0.96)
Triad     1.00 [  0.00]( 1.77)     1.02 [  1.81]( 1.00)


==================================================================
Test          : netperf
Units         : Normalized Througput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:         tip[pct imp](CV)     proxy-setup[pct imp](CV)
 1-clients     1.00 [  0.00]( 0.22)     0.99 [ -0.53]( 0.26)
 2-clients     1.00 [  0.00]( 0.57)     1.00 [ -0.44]( 0.41)
 4-clients     1.00 [  0.00]( 0.43)     1.00 [ -0.48]( 0.39)
 8-clients     1.00 [  0.00]( 0.27)     1.00 [ -0.31]( 0.42)
16-clients     1.00 [  0.00]( 0.46)     1.00 [ -0.11]( 0.42)
32-clients     1.00 [  0.00]( 0.95)     1.00 [ -0.41]( 0.56)
64-clients     1.00 [  0.00]( 1.79)     1.00 [ -0.15]( 1.65)
128-clients    1.00 [  0.00]( 0.89)     1.00 [ -0.43]( 0.80)
256-clients    1.00 [  0.00]( 3.88)     1.00 [ -0.37]( 4.74)
512-clients    1.00 [  0.00](35.06)     1.01 [  1.05](50.84)


==================================================================
Test          : schbench
Units         : Normalized 99th percentile latency in us
Interpretation: Lower is better
Statistic     : Median
==================================================================
#workers: tip[pct imp](CV)      proxy-setup[pct imp](CV)
  1     1.00 [ -0.00](27.28)     1.31 [-31.25]( 2.38)
  2     1.00 [ -0.00]( 3.85)     1.00 [ -0.00]( 8.85)
  4     1.00 [ -0.00](14.00)     1.11 [-10.53](11.18)
  8     1.00 [ -0.00]( 4.68)     1.08 [ -8.33]( 9.93)
 16     1.00 [ -0.00]( 4.08)     0.92 [  8.06]( 3.70)
 32     1.00 [ -0.00]( 6.68)     0.95 [  5.10]( 2.22)
 64     1.00 [ -0.00]( 1.79)     0.99 [  1.02]( 3.18)
128     1.00 [ -0.00]( 6.30)     1.02 [ -2.48]( 7.37)
256     1.00 [ -0.00](43.39)     1.00 [ -0.00](37.06)
512     1.00 [ -0.00]( 2.26)     0.98 [  1.88]( 6.96)

Note: schbench is known to have high run to run variance for
16-workers and below.


==================================================================
Test          : Unixbench
Units         : Normalized scores
Interpretation: Lower is better
Statistic     : Various (Mentioned)
==================================================================
Metric	  Variant		     tip   proxy-setup
Hmean     unixbench-dhry2reg-1      0.00%    -0.60%
Hmean     unixbench-dhry2reg-512    0.00%    -0.01%
Amean     unixbench-syscall-1       0.00%    -0.41%
Amean     unixbench-syscall-512     0.00%     0.13%
Hmean     unixbench-pipe-1          0.00%     1.02%
Hmean     unixbench-pipe-512        0.00%     0.53%
Hmean     unixbench-spawn-1         0.00%    -2.68%
Hmean     unixbench-spawn-512       0.00%     3.24%
Hmean     unixbench-execl-1         0.00%     0.61%
Hmean     unixbench-execl-512       0.00%     1.97%
--

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

> 
> Thanks so much!
> -john
> 
> [..snip..]
> 
 
--
Thanks and Regards,
Prateek


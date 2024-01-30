Return-Path: <linux-kernel+bounces-45231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 726D1842D67
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA0951F2181D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB74771B2B;
	Tue, 30 Jan 2024 19:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2wEg1rcq"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFD5762C8;
	Tue, 30 Jan 2024 19:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706644584; cv=fail; b=ScKjzAoa+A31lqZ9aa0+N2rA+wDqurJrKF0RaOLSwJBQfRGmXZNPV2MZY8oOeNBS6mpg7YRviFHj1dPfh5YjCQx7IdjMYBzEOaRzRg0g1/LWM2ViU7jVWEv1RcYCEF/73Oh+2nGnf2e9UEySBtvnTRsb77T4VgJLJQBZoHL8RQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706644584; c=relaxed/simple;
	bh=DTEBVvu9Tz/vGoWcn87UuZr9LX9c7+cro896WisAMJI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CfutXWwjWpgweiMusftVWQtFVClBNDEYErHUBVwP4t5uoQM29j12KnVhLv2lVYtIFNfaiGmo+gCnfVv16soIM4dejQp8J7M1OF3gQfDsOxkm3v1jAyHCmDQb+jtBkU6Gg+wxY7WLX+qp78e3i+P9BBsWoYAsPW7bB+wZ9tXIhNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2wEg1rcq; arc=fail smtp.client-ip=40.107.92.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aiO+ovrhNUGmuYR1+K4zlkDR0dYevkg6+N6bC2+Vfv5umkc4w4UhKAzohnk/ZY3oenMMIO3fLiaZgPtV6lyy0xv3gM9KPCKNpnriY61pgEtO39YYjoGK0P9ZHUV5i1X2GULJZ+6dr1z33qn+ctC/CjQzHhnEfPp8Z4K+elNgKN5RO83/AI+O03lO/aI+m/QHfaLfWacqzw8gIxfy5clU+DM4UYczjPIF8iS4dJwWx0sUSEYfOXOfcgPXFIK0c8mLsWzKufWiMDHyKRzkrwmQ1u1LbxHV/kRlK4wfkN8O8clAEb8LLQsekDsptSJ0fmmdjwHieiDQ1T1LpctKUzH58Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhIclwpaDcwVBNtrMo9xA2ZB9e723XBLG/HM5tL8Jx8=;
 b=iw0O91kVxEN29HH/CQIzp9gJfCUFWiF2CEhAY5j6EB9CwMReuoL2T2wZfRa/I2SnQ5pm3QP6qdqa8Rp+t5A/p10qh7B05JFkI+f2H1bb3vpZkvuAC17kVdnd6FoBQVA9Wejd+OH64bW31bHSkWJAKh7NkveJEjWpq4AHrWZWUgie+V5GcHqF44UAawuchHXaFtWiDjKrxrSdSEOB88biTdpoR1uUyn/tD6dLzkJluXvOTYl+TV/+2CbrwuW0qqFzrHTmUghv9+/phaysZC/f0JfNnuOVj2PWmlhKPJPGWDasU5uNOx5rwqh20vO+QER5H3cg/Vdj2hm5mr8rULJnPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhIclwpaDcwVBNtrMo9xA2ZB9e723XBLG/HM5tL8Jx8=;
 b=2wEg1rcq8RxlRJ3IeKlxs3JXgZoBwXerQV1/JT3KidgdjP2+5mXxIvhLHGEMl6JPI4zB2TMaOynXhz33033+VM/bnxb1xOsu2M/LX+Cb2xYHY3zUSom1mKCJUQ6LLBWdeYsGXK6s4CNDvTKJH3aWWtZmQ2fTZ0EVUdUWJi4f8BQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB7709.namprd12.prod.outlook.com (2603:10b6:208:423::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 19:56:19 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 19:56:19 +0000
Message-ID: <b9af374d-0e6c-447a-8aed-03f68e8f462d@amd.com>
Date: Tue, 30 Jan 2024 13:56:18 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH Resend 5/8] tools/power x86_energy_perf_policy: add
 nominal and lowest nonlinear perf values showing support
Content-Language: en-US
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 Borislav.Petkov@amd.com, viresh.kumar@linaro.org, Ray.Huang@amd.com,
 gautham.shenoy@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1706592301.git.perry.yuan@amd.com>
 <2307c615b12b9d0063ef92b7642fa0708a6b99f9.1706592301.git.perry.yuan@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <2307c615b12b9d0063ef92b7642fa0708a6b99f9.1706592301.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0200.namprd04.prod.outlook.com
 (2603:10b6:806:126::25) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB7709:EE_
X-MS-Office365-Filtering-Correlation-Id: 318f8f8e-7d7a-4d1a-39f2-08dc21cd86f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OYlYp/4st2tGwbVIK+KqyPJYmbNKZR4fS10651GbS9NGQtipJbjWJAw/C2OXIGRscgfVbb9Zxw+WSHDC7wHsDCElO2KPhYGdXsIQVM3YgHMLjDzFjKMx9F53+mnuedfXvhI1fw2aZ2P/WsagJjdAyQWZTMRvwh0N70UJLuZcnDd/i6JlVTQRR1PO6crar2OM/4SBDH8y//fOMPRUMakgCP1kAEpp0h+6cIdDxeViJOdyMMiq36EfIoDU6c8aDO9o73J51TLZWyB5J9YIsWl+bpMy2UQm9SEZVyT4UrsaffdcObNcvhjOicHnjJ8r4hp0kNM030UPI1BUr4jJOjf8confgQk2gjzTvvgjAIwlh0tA7A83NrHrMUy9nyqMA242RaJ+YphaW3NbuteygYwquH7TQEPL04KQ9qmloJYG0hmZmEixhEiWFB+NAtrcSJWsK/hP8Wvt1sRVCZEEB1rgJb9MAGQrAHvNNgXlv+2av9fBGZpxb8L3IqaTyacELgfIYoyUCm1R4GrGTK+GgwXZefGNFnh35RPpR1xcGzVQPEkLPHPc6iLR0E0MyziTtzP9dfp38L8DVvzXSwWIF28nWh3rb5FlIaiqtvwFO7DQfRuNT56e9V1vXNaUZhA18yrK8bG8+f34YnQ2iIY3c/XcQg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(366004)(346002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(6506007)(6512007)(53546011)(66946007)(2616005)(38100700002)(316002)(8936002)(41300700001)(44832011)(5660300002)(4326008)(2906002)(6636002)(66476007)(8676002)(6486002)(66556008)(26005)(36756003)(31696002)(86362001)(478600001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2ZGLzFKMlpkRXdTeUc0bGZUckxSRlNEN0g4OFlKQjNmOUFQWk8wRkVOdnVE?=
 =?utf-8?B?LzJRTHplaGcrZ2Ezc3BzOEpobWNzS1c2Tko1QWZTT3RZR3N3Ykc3UTJUeS9t?=
 =?utf-8?B?TnpYM05xMjh3em1ZMThsRmpyUU12NDViTlhGMXUweHVRVUhmTVF0TitHN1ZU?=
 =?utf-8?B?S2l1cklUMENLYjlENlM0dVlrTkU5emh1TE9pSkFkTXVQbnpiQUtXRzJlK2pF?=
 =?utf-8?B?ZVVFWW9EYTBqOHJnL1U2SURISWNjTEtnSzFGYmo2SzJ3Tk1UMkhTZzZJT2xY?=
 =?utf-8?B?dkV4OVA3bTBJblpQcjhha0p4UUhjUDFhOUI0Nk1xdHdUdjFhb2pEK3RSSnpI?=
 =?utf-8?B?WVY3MElXSDZpUWR3bjhzdXEvRkROMDNyMXBPajVad0trUkZwOFRjYWxqV1ov?=
 =?utf-8?B?NUgzeVBCTWpHMm5KdTRSTC9sT0JGSHluckdCRXQ1SjJxRzhsZG52RUxzbmZU?=
 =?utf-8?B?SEhrdVh4YStMUUtvdVVGMXVHNVN2RHg5OWh6OGFpQTVnNnBPOW1GalJab1lr?=
 =?utf-8?B?QlZvQ3dZSnNoaDlMRlovNjl3N3JhRkF4cTlyOXBWOUtVNHdVd3FZWTJEcVRi?=
 =?utf-8?B?aEFhUnl2Vjc0cUR5UXVHdzd2UDZVZFh3MlZ5ZnVjdThpTGQwUG5tYVY2UUEw?=
 =?utf-8?B?QlJQN21xL1dqdUhJK2lmdnI3ZGI5Rld6U1pPd3lnMWlYTVkvQy93bHoyQlRk?=
 =?utf-8?B?Q2xyeGttQ0hvenFZejkvMmo2TGIrUytkYzVYamFRWmFZK1BsL2JCdDd6UmNU?=
 =?utf-8?B?V2J2dGZCZXdxRDZKdWx6WWgvelVhMlNnU0szWkhLWXpqWVhFRmxsRVFiNk9R?=
 =?utf-8?B?YkkyYWRldGlVTHB6MDI5VXlSQ0ZERnVCbHllcXRRMFU2RzIrcnlyUEZtcTZZ?=
 =?utf-8?B?cWJ2M3BnRFlna3V0TEJ0R01CMW9nYWlJdkZGMHZhVWNyTUdaWVNSYWkvL2xo?=
 =?utf-8?B?WFVMYnlEUXp0M0E3V2FNaFRCMDBBZGZocHNHR2xaOVZrWS9pSFl0dXViYU9w?=
 =?utf-8?B?MERQak9CMXVEZ2Uyalh5YmJDWW5OYVlXVDEvUmFrN2ZOSDJKMkFuOC9UZ1dw?=
 =?utf-8?B?QklBTnRIYWIxdXk2c2J6aW9XYXZIeDJoV0Z5clVVZlJSZ2paQS8rc3dYWW8w?=
 =?utf-8?B?aVl0Y2VsV2VjS0tYcDhvMi9aR0psaW90QlVncjg0VC9JU2lsWnF0QTY4VXJ3?=
 =?utf-8?B?UlVtcmlZbkFsSkhONjB0TngwUVpNai9lRE9xcG1oYkFlbEZsekV4N3BreUZF?=
 =?utf-8?B?a3JhWlpadGhlcG45T0RRWnV1VU4zSkJwc0JYY3p5dTFkVFdjVkZwbDhNdks3?=
 =?utf-8?B?M3A4RVR0bEJyaXZhbUlvQ0tmblV0a0kweWRhcmQyN2hWeWs4QmVYZDJWc0Zo?=
 =?utf-8?B?RVFtNXRodEV2cFlwemhCVjBERTFjS01LaGpnOEhWazhjZzA0SVFiZkg4THFE?=
 =?utf-8?B?QzFjcSt4U1BoS0xKZGtLWWlwWUs5cXFMWWNsUURPTDY2V2JQVG1laGJ4Q20z?=
 =?utf-8?B?d3dIem1LUmk5MStvRlVsWDRDc2MreDNRV2JoT1hERWdoUVpoT0pxUVNGcFhC?=
 =?utf-8?B?ajRPRkRwbGZta0pNNDNxdEgzczRPdkZxQ2F3TWcyRzY3clpobitMQ1lJSUlC?=
 =?utf-8?B?NElwTnI5Yk1mNDY3dU9nM09qUnlBYk95VCs1L1ExT3BhWFQvS08xaFB5dytk?=
 =?utf-8?B?SUtLVDhSZk54TWUxUVVqdmdNVjRINlg0ZTBvTUkwUnpISXliOVFESVVOMExH?=
 =?utf-8?B?c0hncERIMGNGQU8wUDVtbDVUa3JaWU53U0JCVjA2UWtmM0xBeHdGZ0JWWHRu?=
 =?utf-8?B?NlFiekJtQmxYbCtBSEJyNVVDeUl5M0o2R3ErZFJGUXAvaEhUamFsWi9FMUR0?=
 =?utf-8?B?enNIWmM2cm5zT0RWMExnUUd2SWM5MjJpelBRdWVHWVU2R3RZS3pTUk9KSVAz?=
 =?utf-8?B?djRNSENKKzVzT29NRDRMNWtySjE2R2c0amhpTi9vVVFvZU1LeW5HMzlaelNO?=
 =?utf-8?B?Q1JBb3U1L0lkT09KK2txZFZqYjFRKytudVdhQ3dwZkFveWFyMEFubkhkTzNo?=
 =?utf-8?B?NzJDOStTeVRlZmxxWDBqOTYwVEExNkZDRFA2bGhwZVdES0lZb0o5RG5TT2Rj?=
 =?utf-8?Q?GL2Ing7m1R0SGP1wLFuSac2vL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 318f8f8e-7d7a-4d1a-39f2-08dc21cd86f1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 19:56:19.7042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zSQpXY0U3tqfdsLtvnI2dfWLmx/28ZLE2o8krRHKB94Wmh/bBhhVyUBqtJ4hUd2sdoSJYuDY9WUPXXfQCShGbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7709

On 1/29/2024 23:56, Perry Yuan wrote:
> Add nominal_perf and lowest_nonlinear_perf read and print the values. It
> will help user to check each core all perf values of CPPC and change the
> EPP profile as need.
> 
> cpu0: [AMD HWP_CAP]: low 12 lowest_non 86 nominal 121 highest 196
> cpu1: [AMD HWP_CAP]: low 12 lowest_non 86 nominal 121 highest 176
> cpu2: [AMD HWP_CAP]: low 12 lowest_non 86 nominal 121 highest 201
> cpu3: [AMD HWP_CAP]: low 12 lowest_non 86 nominal 121 highest 181
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   .../x86_energy_perf_policy/x86_energy_perf_policy.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
> index a08403ab219a..7bc668d22728 100644
> --- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
> +++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
> @@ -38,6 +38,8 @@ struct msr_hwp_cap {
>   	unsigned char guaranteed;
>   	unsigned char efficient;
>   	unsigned char lowest;
> +	unsigned char nominal_perf;
> +	unsigned char lowest_nonlinear_perf;
>   };
>   
>   struct msr_hwp_request {
> @@ -820,8 +822,13 @@ void print_hwp_cap(int cpu, struct msr_hwp_cap *cap, char *str)
>   	if (cpu != -1)
>   		printf("cpu%d: ", cpu);
>   
> -	printf("HWP_CAP: low %d eff %d guar %d high %d\n",
> -		cap->lowest, cap->efficient, cap->guaranteed, cap->highest);
> +	if (genuine_intel) {
> +		printf("HWP_CAP: low %d eff %d guar %d high %d\n",
> +			cap->lowest, cap->efficient, cap->guaranteed, cap->highest);
> +	} else if (authentic_amd) {
> +		printf("[AMD HWP_CAP]: low %d lowest_non %d nominal %d highest %d\n\n",
> +			cap->lowest, cap->lowest_nonlinear_perf, cap->nominal_perf, cap->highest);
> +	}
>   }
>   void read_hwp_cap(int cpu, struct msr_hwp_cap *cap, unsigned int msr_offset)
>   {
> @@ -840,6 +847,8 @@ void read_hwp_cap(int cpu, struct msr_hwp_cap *cap, unsigned int msr_offset)
>   			errx(-1, "failed to get msr with return %d", ret);
>   		cap->highest = msr_perf_2_ratio(AMD_CPPC_HIGHEST_PERF(msr));
>   		cap->lowest = msr_perf_2_ratio(AMD_CPPC_LOWEST_PERF(msr));
> +		cap->nominal_perf = msr_perf_2_ratio(AMD_CPPC_NOMINAL_PERF(msr));
> +		cap->lowest_nonlinear_perf = msr_perf_2_ratio(AMD_CPPC_LOWNONLIN_PERF(msr));
>   	}
>   }
>   



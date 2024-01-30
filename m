Return-Path: <linux-kernel+bounces-45232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3694842D69
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247911C20FFE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABB66EB4F;
	Tue, 30 Jan 2024 19:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uGyMOZJ3"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A2369DFC;
	Tue, 30 Jan 2024 19:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706644603; cv=fail; b=TKLIWgZAQXHwDn1v9NuZlkRvgolxXvPV/Lsk6GBJNeBgmjazIAGJt8Kd/nuJxvzYRjLg9TGUhUSxLA08miaYw9IiReCETfKvtqb99M+IkcJKGO83+z5evYTR81JZYQegivIEMJPsdcpWbQhmDW3epRMAlVonDOz7DVFHkcLjHjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706644603; c=relaxed/simple;
	bh=n1Q1rEOz66Jl8z64FtMZ5mGmUFwK3xq1zLmIZQs4WBk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BzqfsP9YoVcvb5YPNygCfBpoxO4m3FA1g9BbzqWJdZwZyiJOYtxnJX9GhJ6my1r6NfzfWqZARvoNq5C/B8kg+PaYow0T7y5WmO4r+GdBqggVidEfjZAi5ofT/OVnXnPYnHB0ATB6uf8/Gi9RVCb7OwugTuVpZvNhAkJ5XCtClg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uGyMOZJ3; arc=fail smtp.client-ip=40.107.93.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuNBsW5FpBKObqtP1QmVAEVfI0CKZwFxdXXyLD3488KCUZEKQTzsgsqREZ0NA5w1tILY+xNMC9jWYPhMvKMjl61rdOaY+lQXDnwtTHmWUngRMyAOqZ3CUJajUUB9r53eEZVCoh1aOni444z7nez5Ls6zoLZuGU9hwxEghHD40KcHj7LU3bZr9Qqpybc4/YwOIEGoSKl3i5ytictYR9R6bc0bxJSWdb8TNBDN8n3Q/51k/9Rar2yoo341DUyXmk3rr8TovilP7uUT/faiTznTVRsrxOlU1m+Iuk37GqjdGUu+0y2AmMQ6rETd8aqjEnwJ5ha4LzID+Apa+D2gxARfiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zT81TuMD+kZ19mnWNygjYSb7lYeHDmkYy0UvHte7qnA=;
 b=dXBdq7F0qr15qLaIx7nJXCCj4g7ggRiBmxFeaSwmkV9O/Ik/mmax52pFqDL37SN8lCJVxu20Gunh0hjhnknLH3MScBBSCSYkhB6ef0gYjv2HkAySgI7Jd/ybVFSvX3bDu5uwcqIMufomrjS7Xc2LCfttDhPY7YFgX5qhZ4IYMyqf4XA6gMAHvmF1ByjkycaMu4Sr4s0DPg8ovIElKZn+Ii1dKrulYU8dR0XKYtPxkSIy8zQeTP1/+b1bw9dEWjdLxARNbrURzQ1TzE+Dj1i6mE3+8pil79aJTEU4+RISSQG5BJJCDDejCnnYJp2ie20bActd3YdAMnH9b4XyWDa5Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zT81TuMD+kZ19mnWNygjYSb7lYeHDmkYy0UvHte7qnA=;
 b=uGyMOZJ3zvLNMFBe22zxIldjoy0ISzutBGnwhM/PEluIeIv1GUzoIlbTvgmb+8zPXtgpAUa8wBhdpzdqeBY5uNvDFE8sQ0KbjbSF9y1UpbKwTlNsMthGQjspdk8tFUADbERpAd+3T22MOU2xIf9Fr4aJpszFP3aWXaESNwKabQI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY8PR12MB8213.namprd12.prod.outlook.com (2603:10b6:930:71::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 19:56:39 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 19:56:38 +0000
Message-ID: <d57d54d4-bbf6-4b54-ace9-61ecc8ce7c06@amd.com>
Date: Tue, 30 Jan 2024 13:56:37 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH Resend 4/8] tools/power x86_energy_perf_policy: rename
 get_cpuid_or_exit() with intel prefix
Content-Language: en-US
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 Borislav.Petkov@amd.com, viresh.kumar@linaro.org, Ray.Huang@amd.com,
 gautham.shenoy@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1706592301.git.perry.yuan@amd.com>
 <3f9212ab790ebeaa36f7a3fedc4fc533f6c75559.1706592301.git.perry.yuan@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <3f9212ab790ebeaa36f7a3fedc4fc533f6c75559.1706592301.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY8PR12MB8213:EE_
X-MS-Office365-Filtering-Correlation-Id: bac3578a-fca3-4c2e-1ab3-08dc21cd91fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AasMEgHnA7QCPf1nbsNZLdaI9JW5T70LpAIs0N2Fcq1HsViDL5WCmorCMoh//uWaQtkphDJWGM7aYBkwa59gm3BYiYNMviwzmsmC3mLfvyMlrXKqJogQsRzS8ZJ9FPmvJsDaa3o8DCpzLETDgX7++88kB27R1WpKFhYs5ulsbNgwYoEDpXVPMk8fczoke0G1lAtHBoTeB9oumL1VxeLiGhXjz3K9lsxUbBTS8HR59b7Cc/niF6yYlk8bL1uyjxygSSjRZ0CYJ7RtxJWf+FwC7AygTkqv1SfoxHpECqZxHKn3D6pTLzAqYfMpC9kD8WEoNghIoT7saICTo/wVj/rAwbz+hNNrRjOixUQYYXPmv22mw8s9HNUARGpU7t+q/iHSoMw9XKCsaf+50NOTIKyxX7MX3WfQxEv6y+XJjeiEzd0qXwgAAQFbosAvVKRgiMyrldg7+r1R5vOej7qxLBARgLNH2wMUlavUKVZZxbLo5nGvrE2ZuRkTapOGSRsT0Oqx9UZ4LA0QH4qzeSCfkBgg0xxHBjh4ng4PyWyOdfibTt7PfiiSiRZJOi3ksTNNc7kzoFNm24xt61ATSy2wCXNOSlkAvxHwgSOzX2X/QI/smtFBjfNgo8gGno3WZ9HcDe83/zEfzrtnbolfnTG1YdlrnQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(136003)(366004)(39860400002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(2616005)(41300700001)(31686004)(36756003)(6486002)(83380400001)(66946007)(478600001)(6506007)(6512007)(53546011)(26005)(38100700002)(2906002)(86362001)(31696002)(66476007)(316002)(66556008)(44832011)(5660300002)(4326008)(8676002)(6636002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1V4RGtjdFVxVkZBbW9zTldEYlJIQjdHYkZzVmErR1dEczl5b2paSUI2RmRj?=
 =?utf-8?B?SWJDMm5wZnB5OVlNb094cHRqRnRCRHRwZEhvSm9iUG0wRjA1QjhOaUVDMkpP?=
 =?utf-8?B?TWxzN1cxcnJQYVhOOUY0WlBnYkpVSDgvUStpczBuZjlFS3NZNG5ydjQ1V3cx?=
 =?utf-8?B?UEJ0SHV1TVBaeVdDSVkyNGF1YlA1K0c1MmF0S3dVUFFlSVBLeVhYSWl1ZkZo?=
 =?utf-8?B?TjVDRDJENDV3YnYxbEw0eXQ3NFNiYTZzQmZBK0VnSExJS0lNdHpFaFpPYjYz?=
 =?utf-8?B?QVFwYUpBYU9wR3BFZjZSNTBBU3p3Ylc0aUUweVA2aTVKbVYzdWhrWXdueVZG?=
 =?utf-8?B?STBzQ2hkVWdwb05yWUFXU1loVDZKd0lQdWpaa2lJeVJjd1VxNTJLNWp4OVhQ?=
 =?utf-8?B?TkduSFI2bWdvQnZ0M05IUVpKSFRPR0lhRG9uWXFwK2FkTjZnS0FjaTl3d3Ri?=
 =?utf-8?B?OE9saWxyYWhyNk1WUUl2SFB5ZkNzbVh3RlZhRzNwWGtjc3VweXVRU0pJWk93?=
 =?utf-8?B?bmc3TWNJK3piNU0rWGpXZkxCSUdMMkJJNUhwZ0t0dmQxeVBaSUk5UG85SVY4?=
 =?utf-8?B?UjZOVEM0RlZQaXYycFl1ZEt6Mi9ScWxoemJTbmNRSmxuR3lZYjF1Mm9wdmlz?=
 =?utf-8?B?QllSVlk4VW9PeE9jelU2eklEQ2lmNjZwZEVMTnJkTVBlS3RkdGpQREYwa2dS?=
 =?utf-8?B?cFh1UUhxZkQzZEFpbmNwbEJEUWJYdng2UGlicDFadWJ3YmllVXZBNGwxcDc0?=
 =?utf-8?B?WC9xcDlLdThpRkxCREFIbkdGZ1BKR2VEWW5VQWNVR2Q2ZEVXb1F2aVVDUEpp?=
 =?utf-8?B?OEpRbzFCclZ4M2FtSkNHM2VjM2RFd1M0cTZkak45NjJnUzdxSjBCcGhiSkhM?=
 =?utf-8?B?SlBkam5wZlh3ek5CRnlZMno2bEVaa0FXRXZwVHJkLzFNMXlvV2tERFdZQm1a?=
 =?utf-8?B?VmtRZlo2N21JYVZnK05iTzE3R1pOd08vdFlLZERUMS9IVHYrYmNtVTd1TENY?=
 =?utf-8?B?VzNwUU9kL09uL3ZSWTB6K1RnMlVRQlEwOEcreTVSUXdBWHBCbkh1Rm9LeFhr?=
 =?utf-8?B?Qmk3VHpZMGdoTFo5a3c3cUVpbHYyS200UGJVMXo4RDVTNUVWbVFvRFV1RU0v?=
 =?utf-8?B?Y3JsOGJYRkliazhHNHVqcTBjVm5uUE1mNDBaUEVMYy81TVYwOVQ0Q1lrekI3?=
 =?utf-8?B?T2tXc2tJS3pWMXhrZUM5ek90Zmp2cW1JRG53SkVkNjlaQWpqcGI0S1IvMHBY?=
 =?utf-8?B?YXVVYkx0Q0pDTENoa3dndlJvUVZGSDRKSS9QTWNzVHVzOXAxRG13SEZwaWFh?=
 =?utf-8?B?ZXB0d2ZyT1pkd1ZJbTZsN3JnVW9EbFVtVHljbXd4RG9ybTdZYy92Mk5YR2F2?=
 =?utf-8?B?TFhpV25qYTVRRVlWRVQxUkQ2RElGbnkvTzhVL3pFd2syR2JDZW5UTmVjVVlv?=
 =?utf-8?B?UjBKSXNFWjZPOVYxV1hjTXZobUg2QW8yeTIyY0pna2F0c0VVSThoYURHYVoz?=
 =?utf-8?B?NkJKdVFoOEFrNm9VcEc0K0NCby9JbU81UFV2M3BpL1hGQXkrcGU5S29hbWRH?=
 =?utf-8?B?ZGFreksxRDVLR0tGS2VaZml4bU5kQ0tGMGNXalM1R1JSS2FnSlp0RWFKTEdT?=
 =?utf-8?B?SnU3NGNMTFp6di9nYWprTG5CdHNWOTJaSUkvb2xVeDQrZDAwM0xZTDMrOEtM?=
 =?utf-8?B?ZXZqYXdLSlN1Z1paQUFOZktneU1XSjlZOHF1eU1oVkE2dmhpWFMybzJ0Z3Rn?=
 =?utf-8?B?TzkvUVNBRHhQNkpEbjBJdUJDeStWN0pwRGt1MU5pcVRpWHJkalNZdDhEcS85?=
 =?utf-8?B?RmQ1REd0WlVCRUJPb3JIdHY4R3c3VUVVWlpTRzZndUUwVFBsbVRCRzBLd1c3?=
 =?utf-8?B?dUhVbE03SVppNmdpL2pJeWZTZ3Q3VGFEMXJ1MzlNRkJFbGRNY3U4SDVhd1RE?=
 =?utf-8?B?dy91OWhkbnhtQWUyOUhuZTBWZ3hDdDgzazErb2F4NGVDZnljMkZySmNtZmNs?=
 =?utf-8?B?bkJHWnFCVnY3RzhXYUZCcG5mVG5xb3Z6YjlFVVRrbmNWeUJjK2xjdno1WXYz?=
 =?utf-8?B?VlVNSFB1MUp4SWF4UkkxcENPdkI2SjBmZEZuMm9xNU5mTVhIQ1lIdjBEMFAy?=
 =?utf-8?Q?YO2/Q1Z1gDWuyS/RyAG4XSKKL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bac3578a-fca3-4c2e-1ab3-08dc21cd91fc
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 19:56:38.2469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Mw9BSKSBX98d/AuPp3LjeI2HBCxlrwlDmhyG4B2ZSUP9zqc7thaVEozSMBw1BehGKi3ENhfhdYnfClSPbr34A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8213

On 1/29/2024 23:56, Perry Yuan wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> Rename the get_cpuid_or_exit() function with intel string prefix, that
> will help to know the function are used on Intel processors.
> 
> No functional impact.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> Suggested-by: Fontenot Nathan <Nathan.Fontenot@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   .../x86_energy_perf_policy/x86_energy_perf_policy.c  | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
> index 3f09c12f24fa..a08403ab219a 100644
> --- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
> +++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
> @@ -1515,7 +1515,7 @@ void probe_dev_msr(void)
>   			err(-5, "no /dev/cpu/0/msr, Try \"# modprobe msr\" ");
>   }
>   
> -static void get_cpuid_or_exit(unsigned int leaf,
> +static void intel_get_cpuid_or_exit(unsigned int leaf,
>   			     unsigned int *eax, unsigned int *ebx,
>   			     unsigned int *ecx, unsigned int *edx)
>   {
> @@ -1552,7 +1552,7 @@ void early_cpuid(void)
>   		authentic_amd = 1;
>   
>   	if (genuine_intel) {
> -		get_cpuid_or_exit(1, &fms, &ebx, &ecx, &edx);
> +		intel_get_cpuid_or_exit(1, &fms, &ebx, &ecx, &edx);
>   		family = (fms >> 8) & 0xf;
>   		model = (fms >> 4) & 0xf;
>   		if (family == 6 || family == 0xf)
> @@ -1566,7 +1566,7 @@ void early_cpuid(void)
>   			bdx_highest_ratio = msr & 0xFF;
>   		}
>   
> -		get_cpuid_or_exit(0x6, &eax, &ebx, &ecx, &edx);
> +		intel_get_cpuid_or_exit(0x6, &eax, &ebx, &ecx, &edx);
>   		turbo_is_enabled = (eax >> 1) & 1;
>   		has_hwp = (eax >> 7) & 1;
>   		has_epb = (ecx >> 3) & 1;
> @@ -1591,7 +1591,7 @@ void parse_cpuid(void)
>   
>   	eax = ebx = ecx = edx = 0;
>   
> -	get_cpuid_or_exit(0, &max_level, &ebx, &ecx, &edx);
> +	intel_get_cpuid_or_exit(0, &max_level, &ebx, &ecx, &edx);
>   
>   	if (ebx == 0x756e6547 && edx == 0x49656e69 && ecx == 0x6c65746e)
>   		genuine_intel = 1;
> @@ -1602,7 +1602,7 @@ void parse_cpuid(void)
>   		fprintf(stderr, "CPUID(0): %.4s%.4s%.4s ",
>   			(char *)&ebx, (char *)&edx, (char *)&ecx);
>   
> -	get_cpuid_or_exit(1, &fms, &ebx, &ecx, &edx);
> +	intel_get_cpuid_or_exit(1, &fms, &ebx, &ecx, &edx);
>   	family = (fms >> 8) & 0xf;
>   	model = (fms >> 4) & 0xf;
>   	stepping = fms & 0xf;
> @@ -1632,7 +1632,7 @@ void parse_cpuid(void)
>   		errx(1, "CPUID: no MSR");
>   
>   	if (genuine_intel) {
> -		get_cpuid_or_exit(0x6, &eax, &ebx, &ecx, &edx);
> +		intel_get_cpuid_or_exit(0x6, &eax, &ebx, &ecx, &edx);
>   		/* turbo_is_enabled already set */
>   		/* has_hwp already set */
>   		has_hwp_notify = eax & (1 << 8);



Return-Path: <linux-kernel+bounces-45224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3FA842D58
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0A751C23C75
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6A869E12;
	Tue, 30 Jan 2024 19:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bEcUEmgS"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCD469974;
	Tue, 30 Jan 2024 19:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706644460; cv=fail; b=R2iVjCzmOXrmhT2ZX62LKjpxUg9GrxIO/WmeUyaQQqiTKSpsdfRYH9RM72b/NhiaEX5eSt/ZvYXgjdtRk+FVnaJD5mU+FxPRxdGFJSpRuGc0cIfO9iWRbI+zGUk3/yQmKeTJoPutR7nfxxuGm73MdEqNCHBgm67qG9wu/RDJ5Lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706644460; c=relaxed/simple;
	bh=tpGnhrY0W1FNWBOkI6dmQu/boPjWl4hCWrnUxI6W4aI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SrK3b/NTydP21IufxuHSpDEsL6NILGc8sy7eAszb5ES3UiMYkLJXzyI5QNLpJvidYD907oDNF0sCPVO0uDMXhhYN18cYeqSt95u0cGWWswNsm5VVLNsI98ZeJWYHdlvXtBFBBUDZ0cT4ly4inflLDRWE0kmvbG27mdzOyIGbDuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bEcUEmgS; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHTZlzKQHw4AHZInkTcBx5agfDYLSokyymhSIi3uOFjP7n3Zh7voh/Sc1yxKaIAlkTbJz5lUtAgk1ynHtzWuuNwh2VPwt7LQg/UAJ4yQlz2+0n65ReGKW9GJv6ybvci2g5Fuw3AlXdyNnaX2jTT2ANkWZT6P4qXdfKdUmeldOFmFySV7QYm/6RfpEeN35rXgbJSf1nuYNC5LH4VOg61VUtV6g4OW0RbQkhBk+J1vNDJQB57Vkj10xBMxEMUMs22QoPUV7dOMcoNdJlhxVKl0SHCedv6m89QL0OWUx9URJZ7cPFgt4X8s+R0WvRFDjZHMniXuBD3arv6W1pGkLa0F1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDz77nzyXvk4qSyXNNmKoqqXSfC9xe/gHwj65Ok4H+0=;
 b=UujQsI9nIWofJWuPD5k5kxU8DqjL+Q1iheiUWDLCQT/gZNJLLyWlYaNSumRmexvvcB3mvNO9LdqL8hAUbAbGmv3+WzzbsGkL5F4KPT/iCjQNMwAQTrFb0+ttvA4Ta85bLGK1Ct9nu2BF8vXN09kAbJWSR0UZrW6EGkIoElIZx002VnflfFcPc4G6jA58LSDqkjG67yRZL6PeIj/OmYIcQMC+6QcsoKvphbNjqfBd19rRFIp3nXt4dTzPXJiCwCYwwi3qc4WifJA0K5T5zwCLuee+fEz3Ay68fXyZNubmLj1QsvciVJNKd5OruZyTDnsvFEy+PGHFlZ+Pn7vGjdq9Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDz77nzyXvk4qSyXNNmKoqqXSfC9xe/gHwj65Ok4H+0=;
 b=bEcUEmgSsXeFD4G28YkvsoBmmTlnjjtDn6AyJoF+eHLkGiWVF4KyK9XZ/LOj7uBt6y+zx3lxglC2ftHSEK/LNCbndxV3cCl+1obhSwqo7hOzf62LNIK0m3uSjpr82U8T2PleaKlAvBmSq0kfMFSaM5cuxJUqjWcrv/jiEHkZlDg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB5086.namprd12.prod.outlook.com (2603:10b6:5:389::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Tue, 30 Jan
 2024 19:54:13 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 19:54:13 +0000
Message-ID: <42143388-4f2a-4b81-ac79-14851c6090e2@amd.com>
Date: Tue, 30 Jan 2024 13:54:11 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH Resend 7/8] tools/power x86_energy_perf_policy: rename
 some perf output strings for AMD processors
Content-Language: en-US
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 Borislav.Petkov@amd.com, viresh.kumar@linaro.org, Ray.Huang@amd.com,
 gautham.shenoy@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1706592301.git.perry.yuan@amd.com>
 <5f70fe6c01a05dc355d6a0e47d32d5e24500ca82.1706592301.git.perry.yuan@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <5f70fe6c01a05dc355d6a0e47d32d5e24500ca82.1706592301.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB5086:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eb84fb3-a7dd-4d35-fdbd-08dc21cd3bb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ezupvym4rrn+Sj8vxNq6ovJPtDRkeYJJnoEGyCOGgMko0dLIugipw+FfQCBrPNZfKpM4cv3vciGIz7GPpetogqADMsWy7Tg7pK+3AjX+QkJrk3cu3YJXYi869o6sdv1Ak4rqfhbFiFSbj1uJOIepTymF9lw06rkBMmih2NnFKYG4/R00X/W6XM6zkwl2GhDKNXAGEpbYkhyMzA0MVK8qUWpmxCcjRjgNIHw7qqjDF92WJKuySwz+4KtYaHufVZcK5lSFwn6OSuK5O7kBVY0Gp6b9e9bXjk1zUOR7ogMf1eVYN8JZxq4g2p932G+YVPd8iN1NpbRI/YHdNtFl5CJKRxVFlwXT+VNzvvtaekiCRjeSEJhf73bWak1EWJLdfmE103NS6wgiDekzJj3sPVemiNIb1ptJ9sdM0JN2uHdmBpNWWuCEj3tkX/EoXNf5CgTRcUWToDexD70E3D7fNhY+8BkG1D+XCLKqYctnmnF9I6QMqlOUnLMDimJvqQAf/yyJ4En4QtomN5rJ40liDXNphQrLJsMl+3RFE6dfPFZftnUVOUq8yeqHqkgHKrETTie212cVGLFGbtIlAS5RYvAmg37DEhrUG7EFxr/uoxWo1nsvn69VJPd3dVc34Vm1IDrUvGYF67ncAPgGPaUU5QewrA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(39860400002)(396003)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66556008)(53546011)(83380400001)(2616005)(6506007)(31696002)(6486002)(478600001)(6636002)(66946007)(316002)(86362001)(66476007)(41300700001)(6512007)(26005)(44832011)(5660300002)(8936002)(4326008)(8676002)(38100700002)(31686004)(2906002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlpVWHZyeFVvWGcyN3FSL21COWFiWXhxZUpJWk5VQXpjUTdHV3BXVVRoTWNZ?=
 =?utf-8?B?T0x3eDJsaFh1dm9Xdlp2MnltajI4SVpZS3VDNzVTYjBuaFhOYzRZK1lXMzNu?=
 =?utf-8?B?bmdsclA4Nkx1ajVmQWlkdEJoR0ZsWHArUGQ4NHFvSnNZcVZkYm5OTE9oRWV3?=
 =?utf-8?B?bTg5Z0JkdDlCemFJeStOZUhXc29vVCtuOStFRXMrd2VVVnVsYnhMTzZjRCtm?=
 =?utf-8?B?TkpSM3hETEVuNlVKSzVLSXp3RmFBZlBCaXoremlnV25YR2s2ZmxaWjhwdWRi?=
 =?utf-8?B?dHNlWjlvTU9DU3hkNnY4S0pQSHhkR083QXdUemVCelcvT0paVkxXT0pqRkFC?=
 =?utf-8?B?amVJbUtHT2s1M1Y4d013M0JFU2VoTERPS1dkamFNUU1Pd3E0WG42TVBhYnpt?=
 =?utf-8?B?SFNMRnJWY0xNR1dhUkZoTWJoQ08yQTFRRUZ5NGMrdC9uWnlHT2NFRGh2RG05?=
 =?utf-8?B?TjF2V2ViM1YxNEQrWkI4SXhKSUlLQjJmNkE0TzB5VXczcDlHTzhjbE9mZ21O?=
 =?utf-8?B?TjJsNkdlUUlXcUsxK2J4RnovOGNFZGxOV1g5OFR1WWVoUXRVSVhjWnZQRmt5?=
 =?utf-8?B?bjRVaUM5KzBvaFlub3RhYnRvdyttMlpmN1lsYXZoSVAwaWRTL2dMV3AxdEF1?=
 =?utf-8?B?dXU0MGdEdm9OemMrWjJydnNSMlVNdHVFNTFhOUpqRm1URlJ6NDFXUkExQVlI?=
 =?utf-8?B?dTJWVWNCN1R4NDZXY3BuVmJpd1Z1cERDalRRYzV2eGJoM2I2SlZ6U3lvRW5Z?=
 =?utf-8?B?K2VERFFlbWhROTJjbWtBc0s0bXV0ZWJBcFpvU1dJL01PTXdOM3loeHludFFJ?=
 =?utf-8?B?UmpyaFFSTkF4REdIWHFQQlE2MWNCQlZyYTRCRDZmdis5aDNWR0NLdldIemhU?=
 =?utf-8?B?M2hRbWFpQkZiZ0d0b3pzcWJ1RGswcDd3NFBXS0FXZ3pYTEwrNVVoRHdid1NS?=
 =?utf-8?B?VlhXTzc2M0lNc0lVS3JUK3FYc3NqOVFaMjl5a3lldlNqbTY1RzJ5R0ZlOXp0?=
 =?utf-8?B?VnRWWGFUUVJrRDVHNVE3NTFkZXg4aU5QUlNZQVdvT0V1c0RMc3BzUldQUDFW?=
 =?utf-8?B?V2ZaQ3BPOUtXTURRMmYwcXo4ak9GOTJTN1FxVXJOR2MzVzRzeTFqN25UYjVX?=
 =?utf-8?B?ZllGaTdPSEhjUmYxZnRmWlRLZzBvN3EwbzlSWWxaajBRQ3NFUER6OXNKYmZa?=
 =?utf-8?B?enhBTTN5Ky9DNDJnd255QjhaR2lnNEJBWi8yRFFzS1ZWUHZlTmVaTEVqajlv?=
 =?utf-8?B?VXg5TG90Tnl6aFZMYlpXYk9kN0pocUVHUHNRakhaU1hZVjdCWGhZT2t2Smhn?=
 =?utf-8?B?S1Z5UXF5WTZkT1R0T3B2TFBIWTFLUmVZUC95QjNPTXdGdmhYeWFRYVI2cHIz?=
 =?utf-8?B?c2NpRGJJU1ZlTnU1STJ4U0lJTUN4Y2sxSmpiRUF6YjJwUXgvM0JYNmFWU2k1?=
 =?utf-8?B?ZzRNTHV0V2szV1duYmZqR0hUTmxCRmQyZUx6YVRlZmpxZEJndldabG5jbjFE?=
 =?utf-8?B?NWs5bXZHNUtSeE1UTHFrd05tdEVMc01JV1RVNk1YZlo3NFcwTGNONndJdFhV?=
 =?utf-8?B?VHowalp5dUdyL1ZXcmFiQnlOZnJGV21mUjlnWUdjM1N0czBCQVdqRmVhNkhS?=
 =?utf-8?B?S01FbjZ1STRHbG00ZTd5ZC91ZGhqWTlZeUU2K1lKbTZzbXBHOTQvVkdBYVAx?=
 =?utf-8?B?TjVXd1FDdllFdlluVmRoZ3RDYk1jRlVNRnp0eS9YSFhrTGlSUUJsNHJuTll3?=
 =?utf-8?B?RUUvbVppTVpLWjM1T01HQkg4cmkzdTJBeFY5NjFkelR6Wml0MVlIbEM4bllm?=
 =?utf-8?B?WGxaUlpTQlFBN2hYemVyMmdraDhRS0s4VUhrRFc0ZDFlcXJiNVA3eVhUS0Vy?=
 =?utf-8?B?bHFHakV6a2c2dGtPRWhIekpxbnhjS2JhdHZoYlVCNVp2cVVNR2FJY09yOVVS?=
 =?utf-8?B?akcrYXF1ZDdHVkxZVHVHelZBL2k1T0NuNi80ZUpFZW41OE4vZi9KUldiMnBD?=
 =?utf-8?B?UkIyNHZtc1V6OVZFSks0SXN4ZnYyTk91SnRMWHFCQzdIbExRZXRsUVdxSTZT?=
 =?utf-8?B?d0sxdmtwcU9kWTRGZzVMcUNzcldGem1HWkNQTUIzWjIydzB5RDg1VzRIWlR4?=
 =?utf-8?Q?l6CYBGcw0Dlg4CjKIlQBi/R/P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb84fb3-a7dd-4d35-fdbd-08dc21cd3bb8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 19:54:13.5977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: itMe5PQc2Nvk1y0Ua76gg4ITntWiNQdcctSymd9wD0iXVhf/eiiJfcjjx2bHGyqAxFQi8OIume3Vr5DG2ECKqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5086

On 1/29/2024 23:56, Perry Yuan wrote:
> rename some perf strings using same definition for AMD CPPC performance
> capabilities.

I'm not sure I get why these need to deviate.  The nomenclature is 
clearer for everyone this way isn't it?  So why not just make the same 
change for everyone (IE min->lowest, max->highest, des->desired)?

> 
> cpu0: [AMD HWP_REQ]: lowest 12 highest 166 desired 0 epp 128 window
> 0x131497d0 (80*10^7us) use_pkg 89
> 
> cpu1: [AMD HWP_REQ]: lowest 12 highest 166 desired 0 epp 128 window
> 0x131497d0 (80*10^7us) use_pkg 89
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>   .../x86_energy_perf_policy.c                  | 23 ++++++++++++++-----
>   1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
> index ada1aaabad8c..845cfedab06e 100644
> --- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
> +++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
> @@ -864,10 +864,15 @@ void print_hwp_request(int cpu, struct msr_hwp_request *h, char *str)
>   
>   	if (str)
>   		printf("%s", str);
> +	if (genuine_intel)
> +		printf("HWP_REQ: min %d max %d des %d epp %d window 0x%x (%d*10^%dus) use_pkg %d\n",
> +			h->hwp_min, h->hwp_max, h->hwp_desired, h->hwp_epp,
> +			h->hwp_window, h->hwp_window & 0x7F, (h->hwp_window >> 7) & 0x7, h->hwp_use_pkg);
> +	else if (authentic_amd)
> +		printf("[AMD HWP_REQ]: lowest %d highest %d desired %d epp %d window 0x%x (%d*10^%dus) use_pkg %d\n",
> +			h->hwp_min, h->hwp_max, h->hwp_desired, h->hwp_epp,
> +			h->hwp_window, h->hwp_window & 0x7F, (h->hwp_window >> 7) & 0x7, h->hwp_use_pkg);
>   
> -	printf("HWP_REQ: min %d max %d des %d epp %d window 0x%x (%d*10^%dus) use_pkg %d\n",
> -		h->hwp_min, h->hwp_max, h->hwp_desired, h->hwp_epp,
> -		h->hwp_window, h->hwp_window & 0x7F, (h->hwp_window >> 7) & 0x7, h->hwp_use_pkg);
>   }
>   void print_hwp_request_pkg(int pkg, struct msr_hwp_request *h, char *str)
>   {
> @@ -876,9 +881,15 @@ void print_hwp_request_pkg(int pkg, struct msr_hwp_request *h, char *str)
>   	if (str)
>   		printf("%s", str);
>   
> -	printf("HWP_REQ_PKG: min %d max %d des %d epp %d window 0x%x (%d*10^%dus)\n",
> -		h->hwp_min, h->hwp_max, h->hwp_desired, h->hwp_epp,
> -		h->hwp_window, h->hwp_window & 0x7F, (h->hwp_window >> 7) & 0x7);
> +	if (genuine_intel) {
> +		printf("HWP_REQ_PKG: min %d max %d des %d epp %d window 0x%x (%d*10^%dus)\n",
> +			h->hwp_min, h->hwp_max, h->hwp_desired, h->hwp_epp,
> +			h->hwp_window, h->hwp_window & 0x7F, (h->hwp_window >> 7) & 0x7);
> +	} else if (authentic_amd) {
> +		printf("AMD HWP_REQ_PKG: lowest %d highest %d desired %d epp %d window 0x%x (%d*10^%dus)\n",
> +			h->hwp_min, h->hwp_max, h->hwp_desired, h->hwp_epp,
> +			h->hwp_window, h->hwp_window & 0x7F, (h->hwp_window >> 7) & 0x7);
> +	}
>   }
>   void read_hwp_request(int cpu, struct msr_hwp_request *hwp_req, unsigned int msr_offset)
>   {



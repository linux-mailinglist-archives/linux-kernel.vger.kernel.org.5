Return-Path: <linux-kernel+bounces-45234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 860C0842D6C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9454F1C223F3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821A771B2A;
	Tue, 30 Jan 2024 19:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V70SO8RP"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B026069DF3;
	Tue, 30 Jan 2024 19:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706644643; cv=fail; b=GpGMJ/pu9gtxOl3wxpehbzp5Y4kI7sN56LhHrx6gYwTol0Eqqm1n2XUXvPLr8pmAScBmRv4BGqECOxdwAvggJqRh4iRFksX7EfbNoPwo4dtPA1+y6d9Y3yAgsHn4laH4nQXbtwrjxfn8/yp35teKnvE5bVy1fz782q1r4j9/NmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706644643; c=relaxed/simple;
	bh=q4VSFu4kh7OXa+Xcpp5GbpWsumy+j4lKnl5GWsZ5rOw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fMLA12Usjb0qbOw8oI+AzbGzCA/vOCtYhLDxaynt5GAXmG1pWiwaALTqg9H2mX4oGmxR0hC1InGk4ck+ao+yJc9vA/2Bn5N4JyB7EYQkj+g4zb+QzmwruLUn5k543XTeXi/fzYPRGIB8V63P2t7kuJQPt5GeHyN7NfGGvgzzSd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V70SO8RP; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBDk/drLZEeGBYwB7GG67VZo/KtSz1TyuuUtR3I6Vkvl2zjpX8KhJUeENceXXW1gi6jJ75q3iB0OnX4EwW+EjteB8IlGx6IYITmznFvAWJYlkz3FFftu74h/SgC0C3Hkw8akNBSKkSFi/ioSiTgl4t1dqBPUP4CfoVCM3hg0f2qwV5H6zP9iynglR1vdIWnZPipbW7R2m8N61ORPSq2W3Cs6bZf3O4/VHw3teMa1zy4iiks2b6wJe6ccF//XMms+bkN7pG+yMk0WTgE5Wh107wbjuJwt9H9iActY86IRbUOC6JZXTdS/lSzF1pAxHotNewD8C5zXGiHWEt9UflWzBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNFk5Rp2XZQBG4ZDYs9SC+xYhkGqp6V7mA9B/qV0LKc=;
 b=MsEK5Uzem97djz9nE6fUxFGQUQgMNywIrq8qWWUKlZ7QxMihFALdEUVH6cGxzdObcuixKIeDXOSQiOazoAupYPorJ3wI+gB8p14DDVMn+61WT5ZGHAFHb19mOtg2rWFOpyB81HIukvQeH9kW7UFTgWCAID4cfvP2YRDieh9twySUe/rw49sfJ8jJxiwHEcw3fVOa0RWPLIUvgUznxKa639zLYZDnM5VVQr6HNHm+PNyRl7XIbKstcpwgVT5Jg1vyWRi7wxd3aj3drI+c+64LS/jk9fqz0RzRw6sy459DqZriLOcjs/YGzF0eHDcyyWV4X2DNBIvatsO4UV8d04fpsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNFk5Rp2XZQBG4ZDYs9SC+xYhkGqp6V7mA9B/qV0LKc=;
 b=V70SO8RPqaB4P/RTcOSWTNZc5RnRsevAu/YIPgdWa7I8UKaywzrYW+Ko8qaisVkUvfLVkQswTc7reiDATgIoOLX8aK69iOQjZnXxShL2aR/ZBClP7tdAi1TRUdogrNyzAvLTRSYz1EJccmjNGJ5X6VN1sm7Wbent7ouVQUOULsg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY8PR12MB8213.namprd12.prod.outlook.com (2603:10b6:930:71::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 19:57:18 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 19:57:18 +0000
Message-ID: <5c02818e-34e1-431f-91e7-53c52e43a8a4@amd.com>
Date: Tue, 30 Jan 2024 13:57:17 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH Resend 3/8] tools/power x86_energy_perf_policy: rename
 get_msr() and put_msr() with intel prefix
Content-Language: en-US
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 Borislav.Petkov@amd.com, viresh.kumar@linaro.org, Ray.Huang@amd.com,
 gautham.shenoy@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1706592301.git.perry.yuan@amd.com>
 <2fbfce6d4f39f5fb64e95a2f36641f109f2c1613.1706592301.git.perry.yuan@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <2fbfce6d4f39f5fb64e95a2f36641f109f2c1613.1706592301.git.perry.yuan@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: adbf02a8-af80-49df-40f6-08dc21cda9be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	27ISiH/VnT3JjJAJO6fie6ttepSm185+3suo1fc0Ymo/vVcE4CsTDzWR8XzrzcHuLQTqBZILYVwR2m3DIb5aSSbvFyI4X8gOtOjo9UrJKc7vQ1RIttBSWUgRZa4JRW6uRnFiKedL5KWUxvKkroDBLMr9tSBm6B7S8DRNg/+EuFGmSVmIdWAG1PpVZ5CmlmnrdQdcqWd8DmRIIxO36zptYI6hER+Qo4G7izRo0uopbudphjnWqwRSvUlmeQFWG1abYA3scfrxS7CcOztu98MuQGQf9PFTJJ0SLWY7iG22h5UoUL8R8ecu4v2mdM96ao8lAjBA0J1tEXrI90OlErmfvtpoW74AFAOG/ens6tPAZwgdHa3YDrVazANEn7DQH/BHPbNSbSGxgUfvWfY51FhwOXahibxAZvz3ozXfCDggKxHa+QWTaYIzakq6fQ7gEzvb1kGoQxH8F70adNqJzDAIaTpdx+91vk8NhDRQG2kSbemXu1g43cNm1pA5yyf7zQoQAU1qmzQtOryg9ViM2K5fqm+CzPNS4U7AaT1mSKaWeIOmoaLgOO3RTa2ckkdtVMqDp0jTw/Fs5dzNIfkjBGS8PVn85isSFVN9DU5jArOm5bfiBzqH+On+jMyLkU8homvatGzO/L2RB+wsDhuk1knlEg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(136003)(366004)(39860400002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(2616005)(41300700001)(31686004)(36756003)(6486002)(83380400001)(66946007)(478600001)(6506007)(6512007)(53546011)(26005)(38100700002)(2906002)(86362001)(31696002)(66476007)(316002)(66556008)(44832011)(5660300002)(4326008)(8676002)(6636002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGFFejlralYvcGYwQmlyVThMRDh4andaT3VRdzNGczl1ZTA3TEl0N1VlV3Z0?=
 =?utf-8?B?bHpSYnpHSHc1V1h5YzM5MENLU1k0em9hM1UzZUMzSERObllBaE1TV3BMMDVx?=
 =?utf-8?B?UG5hVVVYcFBKSFpkbVRNTFB1NXNhQmRBOW1yQTNGbkNRUnNUeXVFSmlMWVZC?=
 =?utf-8?B?ZXVkdjdoVUw0WnlSb00wckUyUjBQYlFsSUJPemhoY2FwWk5ZcnI4TVZWWGdF?=
 =?utf-8?B?TWl2TlJwWE5ydC82N0JKTDBjM25BQkZzK0FUSW91bHNnbm4wOVIvL29UU1JR?=
 =?utf-8?B?SmdiTVJFU1ovVDZ2V21iaWtkdWtTSkMrNmF1aDZ3b2hBd0UxeHlwbWd5SnBh?=
 =?utf-8?B?bncvdEJGWTIwU1RocERLclFUOENCTFEyanJDc1F1VDhaNVVYVVk1L2ZyL0ow?=
 =?utf-8?B?YTM3WVpmK2F1RDAzUTd6dzJ0N2d4a2lvNndMSHZ3SXVBVFozTFF3QXFmUkVw?=
 =?utf-8?B?WG5MUHhuN3lUM0ttbWhldWo1emkvNnRRTTJ2eUJGZHVRWXN1K2RtWlBzQkRS?=
 =?utf-8?B?cUU3RGk1ZDR3YXpkT212ZTU3NjV5c3J1WGNxVmNGZUsyRFRhdmlURkRMc2Ew?=
 =?utf-8?B?WllTT2tieTRpdnNYck5yOWJkL1htTk10WHVLN0ZxemRTTGZKRGpSMEhQVUlI?=
 =?utf-8?B?Uk42U0hNM290M2I0YnhLS0VaL0tWTEpTSWRHdmttSC9Ib2R1WTlYRDJGNmov?=
 =?utf-8?B?ZklIcVZCMmhYTGhRb21BVzZ3cndQY3k5Rm9mcHhzSUx0STBYUlE0YVVlVmVW?=
 =?utf-8?B?bHRiYUI5ZjV1Y3JkWXlJK045QTA2QXArU0o1S3RCN3IwZlFzYTZnQzl0SW10?=
 =?utf-8?B?V095UTRKMnVxSFFMSC9ZMzN5MGZiMXR0TjZoL21URWY3WjBYVlVsbFhXMGlR?=
 =?utf-8?B?dytMNFlDaGdLNUd0ZjFvdGlXaUU2cHJkRmlBTUhRaW1xQ0dnS2R0aW5ROVFG?=
 =?utf-8?B?VUhwY1FuVmtwVm9sZXJGanZSNHRMak1vb1JvUy9wNzlqaE9kcDRjN245Tkd3?=
 =?utf-8?B?YWN2Mi9uRkNIYlIxNEt1SElsQmRyRVBITEVVUmNOdUVoNDJxa0VBaEw2eDZi?=
 =?utf-8?B?b1hnUFJTRzNsSzhLN2FyeXFLemRNSmxWbTkwZEUyKzNLNGV0Z0ZzelMxaHBm?=
 =?utf-8?B?RE44L0UrejVGeGZ5YVpTaHhXNGJyWVFPdU9kWi9UeVdRMXpEMG5FR0NJR3Qr?=
 =?utf-8?B?SnNjdmZISlhIN2drcTcrU3VKUk9WajFLQmRyQ09aUEhjdmhScTYxa1lFYWty?=
 =?utf-8?B?d0pLVmJTV2hTMzZONXdBVGVhTmIyc3JvK2xNQzdjRDhKUG4zL0dTMXNSNCtt?=
 =?utf-8?B?Y2tXRkZxdHI3RnhFdERPbkUybGhzeWhlK3NpcFN5NENsdm9KdnJyQ3ZUWjJw?=
 =?utf-8?B?S0U1SVoySHlNR3YwSHJRZ2w2bGVSWWtmTmtOc1FONXlPdWhiZ1NxaUt6YWhH?=
 =?utf-8?B?LzE2WGdKV0JEUzVnT1BEcGlYRDQzazNPNTZ4RXhTSjBLSnl3c2pNaFIvWjhk?=
 =?utf-8?B?dzU5T3lUbHFxNDBPYndrVGQ2YktJRDNJbFBoUEtxckhkZlZKNGI0YURLenIr?=
 =?utf-8?B?NnlrMGJ3WkpDenl6QlZoc292NXRjS2dJbUIxSXZGN1MwTUV6L21QbmRmZ3Rt?=
 =?utf-8?B?MEoxSkYweXAzT3lqQysydm9laFlXblFWdlRGQ1JNaWYzSW5YZTlleFl5aldm?=
 =?utf-8?B?S2RGUDNiN0E5OHVQQzBkT0d0OVNqUkUrRUFvSWdaQWtMRkJFWXl2RnplU0pB?=
 =?utf-8?B?czk2V1hvQWp3YUFtZUE5NTJndHBCRXltSlFEY3hiV3BaK0lKd1JBZjlpU1dp?=
 =?utf-8?B?bE91VGRXRHVnMGovd2QybGE2WWxNSTN0eUJDSVdDTE5iNmFZSkNxdzhkcW1u?=
 =?utf-8?B?b1czZmZURWVBMmIzeFZjSi9VbUg2c2hCR3lTaEhnRU5DdzhadnNiZ1Z6L0xx?=
 =?utf-8?B?KzdOWGJVeGhqeVNibnd3M09xbnlRRVR4U2RhUEF2Wk0xalV4ZHk1TXFuWmdw?=
 =?utf-8?B?UmVrRE0wNlVOZEdJdDAzbmNjbnpQRG0vT0gxUzFrb3pRNUNKbkhpVkdHT2g0?=
 =?utf-8?B?NytUS3lpblpzQUU0RUhKSzR0RGZwNGVXcFY1UUtqU2ZoOG9vZWtTbmdobjNl?=
 =?utf-8?Q?lyA4BUhz9OVBwRSkVYvVRXhsn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adbf02a8-af80-49df-40f6-08dc21cda9be
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 19:57:18.0839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q30FIPH6/8kwczEb7R/nFP/5OFzMWGaT951+9jMI7Eu7UHw3s6OqM65skmXO8NY5JaUSaAMZ/QGMtJdM3epUhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8213

On 1/29/2024 23:56, Perry Yuan wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> Rename the get_msr() and put_msr() function with Intel prefix,that will
> better help to differentiate with other processor msr operation.
> 
> No functional impact.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> Suggested-by: Fontenot Nathan <Nathan.Fontenot@amd.com>

Maybe this should squash with patch 8 since the same lines get changed.
> ---
>   .../x86_energy_perf_policy.c                  | 32 +++++++++----------
>   1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
> index da9087873915..3f09c12f24fa 100644
> --- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
> +++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
> @@ -679,7 +679,7 @@ void err_on_hypervisor(void)
>   		    "not supported on this virtual machine");
>   }
>   
> -int get_msr(int cpu, int offset, unsigned long long *msr)
> +int intel_get_msr(int cpu, int offset, unsigned long long *msr)
>   {
>   	int retval;
>   	char pathname[32];
> @@ -697,13 +697,13 @@ int get_msr(int cpu, int offset, unsigned long long *msr)
>   	}
>   
>   	if (debug > 1)
> -		fprintf(stderr, "get_msr(cpu%d, 0x%X, 0x%llX)\n", cpu, offset, *msr);
> +		fprintf(stderr, "intel_get_msr(cpu%d, 0x%X, 0x%llX)\n", cpu, offset, *msr);
>   
>   	close(fd);
>   	return 0;
>   }
>   
> -int put_msr(int cpu, int offset, unsigned long long new_msr)
> +int intel_put_msr(int cpu, int offset, unsigned long long new_msr)
>   {
>   	char pathname[32];
>   	int retval;
> @@ -721,7 +721,7 @@ int put_msr(int cpu, int offset, unsigned long long new_msr)
>   	close(fd);
>   
>   	if (debug > 1)
> -		fprintf(stderr, "put_msr(cpu%d, 0x%X, 0x%llX)\n", cpu, offset, new_msr);
> +		fprintf(stderr, "intel_put_msr(cpu%d, 0x%X, 0x%llX)\n", cpu, offset, new_msr);
>   
>   	return 0;
>   }
> @@ -829,7 +829,7 @@ void read_hwp_cap(int cpu, struct msr_hwp_cap *cap, unsigned int msr_offset)
>   	int ret;
>   
>   	if (genuine_intel) {
> -		get_msr(cpu, msr_offset, &msr);
> +		intel_get_msr(cpu, msr_offset, &msr);
>   		cap->highest = msr_perf_2_ratio(HWP_HIGHEST_PERF(msr));
>   		cap->guaranteed = msr_perf_2_ratio(HWP_GUARANTEED_PERF(msr));
>   		cap->efficient = msr_perf_2_ratio(HWP_MOSTEFFICIENT_PERF(msr));
> @@ -872,7 +872,7 @@ void read_hwp_request(int cpu, struct msr_hwp_request *hwp_req, unsigned int msr
>   	int ret;
>   
>   	if (genuine_intel) {
> -		get_msr(cpu, msr_offset, &msr);
> +		intel_get_msr(cpu, msr_offset, &msr);
>   
>   		hwp_req->hwp_min = msr_perf_2_ratio((((msr) >> 0) & 0xff));
>   		hwp_req->hwp_max = msr_perf_2_ratio((((msr) >> 8) & 0xff));
> @@ -909,7 +909,7 @@ void write_hwp_request(int cpu, struct msr_hwp_request *hwp_req, unsigned int ms
>   		msr |= HWP_ENERGY_PERF_PREFERENCE(hwp_req->hwp_epp);
>   		msr |= HWP_ACTIVITY_WINDOW(hwp_req->hwp_window);
>   		msr |= HWP_PACKAGE_CONTROL(hwp_req->hwp_use_pkg);
> -		put_msr(cpu, msr_offset, msr);
> +		intel_put_msr(cpu, msr_offset, msr);
>   	} else if (authentic_amd) {
>   		/* AMD EPP need to set desired perf with zero */
>   		hwp_req->hwp_desired = 0;
> @@ -1011,14 +1011,14 @@ int print_pkg_msrs(int pkg)
>   	print_hwp_request_pkg(pkg, &req, "");
>   
>   	if (has_hwp_notify) {
> -		get_msr(first_cpu_in_pkg[pkg], MSR_HWP_INTERRUPT, &msr);
> +		intel_get_msr(first_cpu_in_pkg[pkg], MSR_HWP_INTERRUPT, &msr);
>   		fprintf(stderr,
>   		"pkg%d: MSR_HWP_INTERRUPT: 0x%08llx (Excursion_Min-%sabled, Guaranteed_Perf_Change-%sabled)\n",
>   		pkg, msr,
>   		((msr) & 0x2) ? "EN" : "Dis",
>   		((msr) & 0x1) ? "EN" : "Dis");
>   	}
> -	get_msr(first_cpu_in_pkg[pkg], MSR_HWP_STATUS, &msr);
> +	intel_get_msr(first_cpu_in_pkg[pkg], MSR_HWP_STATUS, &msr);
>   	fprintf(stderr,
>   		"pkg%d: MSR_HWP_STATUS: 0x%08llx (%sExcursion_Min, %sGuaranteed_Perf_Change)\n",
>   		pkg, msr,
> @@ -1274,8 +1274,8 @@ int enable_hwp_on_cpu(int cpu)
>   	int ret;
>   
>   	if (genuine_intel) {
> -		get_msr(cpu, MSR_PM_ENABLE, &msr);
> -		put_msr(cpu, MSR_PM_ENABLE, 1);
> +		intel_get_msr(cpu, MSR_PM_ENABLE, &msr);
> +		intel_put_msr(cpu, MSR_PM_ENABLE, 1);
>   	} else if (authentic_amd) {
>   		ret = amd_get_msr(cpu, MSR_AMD_CPPC_ENABLE, (unsigned long *)(&msr));
>   		if (ret < 0)
> @@ -1312,14 +1312,14 @@ int update_cpu_msrs(int cpu)
>   	if (update_turbo) {
>   		int turbo_is_present_and_disabled;
>   
> -		get_msr(cpu, MSR_IA32_MISC_ENABLE, &msr);
> +		intel_get_msr(cpu, MSR_IA32_MISC_ENABLE, &msr);
>   
>   		turbo_is_present_and_disabled = ((msr & MSR_IA32_MISC_ENABLE_TURBO_DISABLE) != 0);
>   
>   		if (turbo_update_value == 1)	{
>   			if (turbo_is_present_and_disabled) {
>   				msr &= ~MSR_IA32_MISC_ENABLE_TURBO_DISABLE;
> -				put_msr(cpu, MSR_IA32_MISC_ENABLE, msr);
> +				intel_put_msr(cpu, MSR_IA32_MISC_ENABLE, msr);
>   				if (verbose)
>   					printf("cpu%d: turbo ENABLE\n", cpu);
>   			}
> @@ -1330,7 +1330,7 @@ int update_cpu_msrs(int cpu)
>   			 * but cpu may be in a different package, so we always write.
>   			 */
>   			msr |= MSR_IA32_MISC_ENABLE_TURBO_DISABLE;
> -			put_msr(cpu, MSR_IA32_MISC_ENABLE, msr);
> +			intel_put_msr(cpu, MSR_IA32_MISC_ENABLE, msr);
>   			if (verbose)
>   				printf("cpu%d: turbo DISABLE\n", cpu);
>   		}
> @@ -1455,7 +1455,7 @@ void verify_hwp_is_enabled(void)
>   
>   	/* MSR_PM_ENABLE[1] == 1 if HWP is enabled and MSRs visible */
>   	if (genuine_intel)
> -		get_msr(base_cpu, MSR_PM_ENABLE, &msr);
> +		intel_get_msr(base_cpu, MSR_PM_ENABLE, &msr);
>   	else if (authentic_amd) {
>   		ret = amd_get_msr(base_cpu, MSR_AMD_CPPC_ENABLE, (unsigned long *)(&msr));
>   		if (ret < 0)
> @@ -1561,7 +1561,7 @@ void early_cpuid(void)
>   		if (model == 0x4F) {
>   			unsigned long long msr;
>   
> -			get_msr(base_cpu, MSR_TURBO_RATIO_LIMIT, &msr);
> +			intel_get_msr(base_cpu, MSR_TURBO_RATIO_LIMIT, &msr);
>   
>   			bdx_highest_ratio = msr & 0xFF;
>   		}



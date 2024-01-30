Return-Path: <linux-kernel+bounces-45230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D50DE842D64
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 062D81C20DDE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A027571B29;
	Tue, 30 Jan 2024 19:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WuqFnGRn"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B65D71B2B;
	Tue, 30 Jan 2024 19:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706644560; cv=fail; b=c0aCA0Wgeog46dq49rmeR2IUF/iBk3EZx5gLPqGSxXc/RGdcwJ60jr4EU6VW53AzmgQhD0IRDWnMM5SeBl0EW2ZpSpmvMdmgfwM8c4H7sd9JMd6xbGQ0Vs5qIyevFiqTFZ8nbYIp90OMtGFu+bPFiru2R9hgnNcHDcvUGSLJvwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706644560; c=relaxed/simple;
	bh=UkLeeXUZFF8xvlddJWmRG1rvgZqLAhyPSvGWyVEZnms=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UwTWfteOmGSefR1uMk8EqQCNHD6NcmK1Hyyt3PGo0nkDSVT3WPRaPT42oLeLDlg7CmULB8a7w6viAyhSMNKVulLnxT3bjGpLjRDoypRxm+fULQ4GRwxGTWYIb31mEN06EAeoBudvGikU9dfqiF0lMP66BHFzv1E6k5jp54AyqkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WuqFnGRn; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSiAZoFJS8Ue+JandCzFGuYHd2L97wAjyYzvsifaa2oLAniDUO3pOhTgIgKSu/MgyH9FbcSGzsE4jw0mJE4yZwjxAPt4+LDRwm/VzTOeVwGnwD5eR7px3ga4pRGDvsjonvlQ/d6A1hVmw9E+QrPh7zafe87AmtnDkOz2Ym+TSSBpXkHxgX3w0dnamgSFrO3mR+bT111hcjXVFW2BXfdv8qoX2ekx+NS9Prp2E9GD6GmUiJWENlCUbaES/XwUIjCauBpLnyHrxOh7WBBU/ZnQ5C+7X6EtlOKfrgilzI0a7e3WNr+LwV9eznqFjYjV15B2MiFr0NuiuYTLetEfCkxWZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7aXvg0E4nJ6YetreAxPHDWA034KuPK0TjIFSzCxely4=;
 b=Bo88X3S5quW4g9zjEeHXWJjrElLe4MajcW8gMN8JPzzsBaRHh6/FJBPoc9v33MWW5dzUAL7G6dqvYfEuqzwfggPFJjCURoh8Xr8+KMufGGPWl2+4EfP3uA+5RqD9Sh9IftcKV9TjwyVaayGQ8dya3jablK98fMzjdp57rDZxINIsMs6/s6SP7bcHofFmp8UfGLxtM7fcBfhZ0os7EEsnsuqug73IY18vLqd4r70wWUe/mG11udiier6/B+GHly7Upza8RfpoMij1IKpByfD1D7ZSsqLkjUXnlqrhXx09gWc2Zr0RKU43P7G/5Fz9NdHi5SfiwQw1+fD5IIM+xj8b9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7aXvg0E4nJ6YetreAxPHDWA034KuPK0TjIFSzCxely4=;
 b=WuqFnGRnIEqey45gXGfpd+rU1b6ypU0D1wocFe5CqrkIKeR/Otd21QkrzkeLtzFabZq3C64x5QKACFt6R5dZrc16LzDR5Hi2QRymys8c9RArqYZaplGC5jVu4ZIiLVFHsHt1ulwXMpWxxu6czOvU2I8XvOm4W6FtrT6eKpYY200=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB7709.namprd12.prod.outlook.com (2603:10b6:208:423::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 19:55:56 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 19:55:56 +0000
Message-ID: <052797eb-bc59-462f-a918-460913c302ec@amd.com>
Date: Tue, 30 Jan 2024 13:55:55 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH Resend 8/8] tools/power x86_energy_perf_policy: change
 intel msr functions to be static
Content-Language: en-US
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 Borislav.Petkov@amd.com, viresh.kumar@linaro.org, Ray.Huang@amd.com,
 gautham.shenoy@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1706592301.git.perry.yuan@amd.com>
 <6905c6ca13c5cbb513f2bf6c2a937dd228e3fd57.1706592301.git.perry.yuan@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <6905c6ca13c5cbb513f2bf6c2a937dd228e3fd57.1706592301.git.perry.yuan@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: b3fdf6f8-4937-4fa2-dca9-08dc21cd78d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Uhi4MX6evoJHm4cP2XN0CWg0MBoL9tAg/Be50ZAAT8/lovb/NPed9f35/UFqaTZzV+VPE4H0KjHb/MLBFajWFXG7PL5/zbkp9tvs5og8gw8aO8xQW7Um1vdBsgDQ3X+brveX6+gBPKcvnjP3wl93pZtPP12m0uTeuEi/ApAQtQf3jx0LDtg98l/twrGfUoGPnDdTJ0rWGk5iVCgnddCmDNOfLhEna1UZ+K4HUoUXNTL7EZs7bcFGibsKxI47NVAZC3Uq0s9JTMa+b4hWoekBgZ+NYGN+IPPYxobx0n8xYffjkbOLEm9+gZjKLpx4mM1K8240s675cWY+0HQZQsesOYHKImhR+ao+X2RQOX5G5gNEZLj7s3xRMKhcFwgm7Urck514LxIA6HyFkIXPgZ87fPOyvdyBcgyCf60cz60iiD8fRN+4p5Ss0LegpGiPbRvnVdGZMnVdhGAH9QNTSN3YUeBvjonKGHwySvtWjkC8SiA4/uDoDnn0bbgxq30yObVh/tCtpA3Dn8QQ23jXJEFJPIaTxX13/bqaDltbyy6IDBUgceUO06s6G4p18Wv53cXKU/KTYWbIkQ1ud1tJ+V/IhicA36SDLX3/NYNZFJcxaaRdZtoOj/SygNzwW74y9b/u6YKzxfFAgPZt9cfSj68M+A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(366004)(346002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(6506007)(6512007)(53546011)(66946007)(2616005)(38100700002)(316002)(8936002)(41300700001)(44832011)(5660300002)(4326008)(2906002)(6636002)(66476007)(8676002)(6486002)(66556008)(26005)(36756003)(31696002)(86362001)(478600001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cU9YenFzMERyZWlJZnUzSCtORnhUWTAydDFVdXc4aHJYTzhIbGJjL3A5TWFp?=
 =?utf-8?B?S012UGxtbGx3dEdrbU5YVkUxekF2RDdZV2ZPNkNQNUpma1ZtdWxBZnpaNEYr?=
 =?utf-8?B?RU1rTXFSWmFROWx2K2libS9DYTNOdzU1VG54WXRmaC9mL2tlV2JBU2s5NjNk?=
 =?utf-8?B?RWlQOWthc3VnSjRraG5HL0NlN0F4UUs3M1dueFMweWU3OXRqQjdaUS9DelNC?=
 =?utf-8?B?Q1cvdDNYNzlWMkJlNXhEa0krVmhEZ2ZoSW9CNUhMSk5FektjWTBNQUhWcFFj?=
 =?utf-8?B?aFVDb1ZBRGs0N1BXTS9uT29DK3VLWVFRa0tremZObkJUOWZrSnJqK1hCWUd6?=
 =?utf-8?B?czhFeUFVZGFFYlhESzlMOFRqYm94c2l3YTUyTHlIZEhTc0lmRWJVNUJONy93?=
 =?utf-8?B?Y29waVREK3YyUlB0Z3dncmVZNkNhVm5XdXVxNUFOUlBybi9BV1NQUStYQ3hj?=
 =?utf-8?B?NzZ0aklpbmUxbm9mdTZZeUh4S3hhTDE2N1ZVMk9YMmhHcGMwL21hUHk2SmV2?=
 =?utf-8?B?eTBUY0x1VlBvbm5CMDBONTgvR05DMnhPNmlhNENCQnFiQ09LaTFiZzB6RjR0?=
 =?utf-8?B?RExNTXZBQVV3d04zWWlpbDBKZFNKOG1UazJra0NUbi9UNXgxWEJoRHhUR0ZN?=
 =?utf-8?B?Vk1QWVhrWHJha0dDa3JpR2lqR3MrOFVyaGdWSVZJUStSbXBKZFJlSkNsS01w?=
 =?utf-8?B?U0l2dnR6SWtkNVl3ODJwYW1MV3E1azdSQkJNdXA3bzhrbVdQTzdMVG9tVExV?=
 =?utf-8?B?ZzlnQ3M2WWtqSWxkaXQ0c2lwYlZwYkFGdzVlM2owQmtSV1lzbzhCNHV4T3BG?=
 =?utf-8?B?MzBib05LeDlOUUlHVkJZem5DcXM3TFNkVFRxUU9vaW1IT0QrWWVRU3VHbEFT?=
 =?utf-8?B?clNlbmQ1TnhNSnl3QWhjaVFua0xDcUdhL0FoN3FXbFJIbzloYXBJRDArMDZJ?=
 =?utf-8?B?M0dwUndpSUE5aUNseVRwZk54OWNDc1ltTG03WCtuenRGcFBsTFg3RUJMZ1dC?=
 =?utf-8?B?ai8rVW5sb0x6WWtWNWs0VTNCOU9COXlpZFlSaU9BREkzUzNSaWJqeVpJOGEz?=
 =?utf-8?B?cUdvcWJmWW5taUV5amg1UEhSVWxYSXpOL29tM0xmVDM2L0hGU1FrOXNwYi9X?=
 =?utf-8?B?ekFWUWtJdmpjTDdtTVNFR1B4RkxZM1RRaVhBb29GMXdHWERkQ25GbmVTc0Ew?=
 =?utf-8?B?VWExUmhHd3BXRnl6UEIzcnlSYkJzU0N5azZzMXlycVp6RGtkMUdtRjduTEQ4?=
 =?utf-8?B?QWpjQXdzU1V2enY2VENnMUlLNzY4WnVLZ3NIeWQ3Z25pcU8vTC94UjJtOXBE?=
 =?utf-8?B?VFl4b0lRSTRDa1I4ZXdMNzY1VEpNTnJ4RWtaOURTd1plUVduREVKYWJoUGs2?=
 =?utf-8?B?ai9lbUgrS2xTN3lDeEFIQm80Tko2MDhtWmNoRDd2UWlZSnNhOWhFUit6UmxM?=
 =?utf-8?B?OHJVa05iYjJRQ0cra3NGYzFta3M2Y0k4ZlNnRk9NUmJHaXdIell2bVU4ckpU?=
 =?utf-8?B?TnJBMEVDdlVob3NpQWpwYU05bjJYWTY0RHpGNzBhUnU1NWRoZ3AvS3IxbXdp?=
 =?utf-8?B?Ry81VWVkZ0F3bDZBZEgzaUtrbUZxOEx5dEZUSVZmaGZxMzBucGFaeHhBQW9S?=
 =?utf-8?B?K01oL243bVVEOEp1TTE0RmhkRXZreUFISmhuSlhZU3EvZmY0VDFaaTVOZito?=
 =?utf-8?B?ZU9EOXhpVzNKK1RObENuK0hNbDNaQ3NrNzBvTVczdHYrL0NFNnJYbk1lOWtw?=
 =?utf-8?B?VXZWZDdGMTQxbTNVVWdWaWNLK2d1bkZ0ekNZUjM5dFNXL2Nwd3NGR2doamZQ?=
 =?utf-8?B?aDMwSnlHTGZnLzhYeVNYS1lhb3VMNjFUdFM4NkMydnl1d1JBbU1pdWNkTHg1?=
 =?utf-8?B?UkxObHgxTkJPc09sa0tmSXI4L2lTQ09ScVZjOVZnMlhoY0gzekR0U0Q3RVRS?=
 =?utf-8?B?Y3lMNktiWHQvVllMTzluMUlvSitjdENCSU45aXNqN055V0lhT0xsVnlLQVlN?=
 =?utf-8?B?bGk1ZEJjKzlROXpXd3hXcnRqQlMvUnRVM1ltbW5rQW9IaGNsT1huaXFaSDh0?=
 =?utf-8?B?TnBQUHlWNzFhOVIxZUFUL29FcFBra1I5NEZvSkRSaG94MXFaMmc4RkNHU1du?=
 =?utf-8?Q?6vALbqoJg7Bn4ujlkC7RMIbrM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3fdf6f8-4937-4fa2-dca9-08dc21cd78d6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 19:55:56.0460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJA/Fnal6oACrk/zsr68MrufnDwZrerY23Bxrg6O+n3Nx8ztyLbiMrbV5qyIh0egvIDKq95PUqZ6kozdSgkc1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7709

On 1/29/2024 23:56, Perry Yuan wrote:
> change the intel_get_msr and intel_put_msr functions to be static.

Was this wrong from the beginning, or is it because of changes in your 
series?  You already have the "what" in the title.  I think the "why" 
should be described here.

> 
> No functional change intended.
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>   .../power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
> index 845cfedab06e..a5f2f96fa383 100644
> --- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
> +++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
> @@ -686,7 +686,7 @@ void err_on_hypervisor(void)
>   		    "not supported on this virtual machine");
>   }
>   
> -int intel_get_msr(int cpu, int offset, unsigned long long *msr)
> +static int intel_get_msr(int cpu, int offset, unsigned long long *msr)
>   {
>   	int retval;
>   	char pathname[32];
> @@ -710,7 +710,7 @@ int intel_get_msr(int cpu, int offset, unsigned long long *msr)
>   	return 0;
>   }
>   
> -int intel_put_msr(int cpu, int offset, unsigned long long new_msr)
> +static int intel_put_msr(int cpu, int offset, unsigned long long new_msr)
>   {
>   	char pathname[32];
>   	int retval;



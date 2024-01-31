Return-Path: <linux-kernel+bounces-47192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3912E844A56
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D2EA1C27458
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4DA39AE8;
	Wed, 31 Jan 2024 21:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oqvT33QL"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2063.outbound.protection.outlook.com [40.107.101.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9A439ACC;
	Wed, 31 Jan 2024 21:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706737610; cv=fail; b=CRtZimDX4njUYCGkcdNScewdNCmDjXhody+EdKnY1IHoPxdgGfPTnURrDyfzBCmU6g45k0zMCgDveKBHmGkfZ/Xglil4Xij0klLK75QGOVxU/OYYFcsZoJxyZA++NMTS2eRL4phzyQvYRyNBZO2QAhNuvoK3n5Bcjt9Y8GED+f0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706737610; c=relaxed/simple;
	bh=N/iRPTiz5X32IgvurAolXbe+PozFPg2KCKi/IhW4wb8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ETe0QHdFOqHJoj2MYHDlMj5qTZBZZmLFQIAjpUehsx4lP859gPOsRlp+7zH0uO2oPLWgZXy0wx87anGgugMWia2w9R1LmD+MjUJ6mVnXbXbRWO9iePZvtW5pUD4sgrUaCgRN/zS+rVMfFVxjmgOLOFEZnX6J89A9POShIIQ/heU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oqvT33QL; arc=fail smtp.client-ip=40.107.101.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hshemR8MHR1xYKwkdSGgr4f1CSFGR7terIGVFpQxE+rQbo3hE8bXXN5IVKfIwhMtlOoLy1Qv6llxlNZVhRVX76o/LdZrpac6g4m+ezOHxFq1p3Hpf1zlVBtiD+F+QiTwfhiE6pEjEBdF1KbhntbYEbNhehBrOjEhbDE5ldFik7dTzY45uDqPfYFgcBwyAzdKSr2HGiz0nKqATFoc5hPdAPX2k/PCgKZDST3t80JWinnsGyS8I659XuFasrA/Rd8maQ0fNTFgJRjsyVF2ph+MhuBjyAGoNh3KBrXBOm0Eb8nupuZZT/3evDWoqHL6oQisIYEwRZJndxdoiBAjS6tIdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wyTv1EojV5ythkcq+L8D39ab0rR7xd2CgZ7OwY+v+c=;
 b=MP+W11OGayPMBL24QQL0v9AfDPvXkQFFy+t7gaVeiVJvAEoN0f1h9zkxkiPsJZBW1CBFn3EBZ3AHiRq2sCScrLpLfdMs5wpA+cL6P2hKPyc8fD2QAcg/gEa9fFIH/ddDlFg3AkzkBv3rzGv9YrFvXghtys2cADjkDdrURJrrrc9at/gAIJFsIjCwHffdDBMKEdZPD2k4Wgusm7yK2qIqZ/i1EGD73M8TNmF6ae+qWsfcbDBTxFvX4ohD3JI5xkt6PQkGdcGX4P1TcxQ2n4zLJGm5wMXHCewedCZe8sUSxBZbLAXr2kaQ6wF6bHNjW3W9uann6fa3152sWcdb1isB4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wyTv1EojV5ythkcq+L8D39ab0rR7xd2CgZ7OwY+v+c=;
 b=oqvT33QLTnoDlDM3Et2Cz7BmjsXi/RCx6kxpDPmUQxKSGh2GuuGGsnVi7y6R3Ph4ztjQU0LEql7vzZGOxRYp4jxD/UNK6ENooTaKVBMNISTQ4UPpYH3JBAcY7hZ5Pn+oPiMyioLTMJF3xXStcaL7yWGA9UM+izy56nhb+MqFI1o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB8538.namprd12.prod.outlook.com (2603:10b6:208:455::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Wed, 31 Jan
 2024 21:46:46 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64%4]) with mapi id 15.20.7249.024; Wed, 31 Jan 2024
 21:46:46 +0000
Message-ID: <a7d69dc6-a4b3-4d30-a666-66328e10fb89@amd.com>
Date: Wed, 31 Jan 2024 15:46:45 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] cpufreq:amd-pstate: fix the nominal freq value set
Content-Language: en-US
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1706690577.git.perry.yuan@amd.com>
 <0c7a38077a19e5055926947ea6ed64bfb7686345.1706690577.git.perry.yuan@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <0c7a38077a19e5055926947ea6ed64bfb7686345.1706690577.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0071.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB8538:EE_
X-MS-Office365-Filtering-Correlation-Id: 73149032-f602-4ab5-086b-08dc22a61f2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	M26Fr6VBM0XIpbvm1tD8YkT5P9VLMTsqBQxraKiANxAwXwRGr2ggY93P/6X2QwwkG0Bc0vEbK6MUqha+RuELIrOoGTw3GMuuZ7TuXnLICWpORrO0/i/htU4uGnXe/YQ+CJpmJiq+yx79/NGAYczsgf9r0TOheoq3i4+51DF5p5MLwL95Pvg030/IBcrU5eBnVGZCTAXm6da0m9KlDmzPxqe9yNJf2BHphWSR+wUOSOJxvCrNgYHfYQP51gZWvRVt0OJDVkPNHXNmEWx4GDwDqo0ZMZQu8SsGKuq0JUWzN0EJuGFjP43di5csDi/xQMbuZMWJP2XkFFz1heZFRmInl5QKfFUTVhWcjrBF0EbIktQNyfGAtLw1F0V1DMf6uiiXcJ0UZ4oAaP0FFMq4UQ+1LoQ3+APtuJMu0FRQntA18Z1D0T21jLiZpD5HUiwQuBWQfxGa0As2hTrT2k8bj3sgz6OgPlP5osobXgISzRf/3MfHsL/mA4JGJAhBCCc17NktvnyC7dS8IRrYfdmpsL2ADPFvxODf4+HulE9CM5Kl3Rrj8/0hxRdAge0EZDTPgRTU6YblNWifZL2yudJ26yoYhLjM+P3RAjiZ4ehY3ggN5TocJW9Y2RkTIZlA9RODaeFg3JTq9rIAwkzRmaGihr/CGA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(136003)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(31686004)(83380400001)(41300700001)(86362001)(31696002)(36756003)(26005)(2616005)(38100700002)(6512007)(6486002)(53546011)(316002)(2906002)(6506007)(478600001)(6636002)(66476007)(66946007)(66556008)(4326008)(44832011)(8676002)(5660300002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3ErM3UvUHRDTUJpTWwxVTZ5aXkwbGR5RnRWeE5YZnVCVS85MUZUVTRhNnlU?=
 =?utf-8?B?YWFCR0ljRjYvNDFrNktnSlV1RExSZWRzcFJYbElMTTdydzVNZ2J5MytNS29O?=
 =?utf-8?B?YTNhYVdBT3ljRmlhdzUyMUxHSmxsdGNlTG9MdTlrNFJ0OE5pQVMwZFdBcGdU?=
 =?utf-8?B?YjFoYTlOWmEwTTRzNG1HOERKOEM0d0VCTDBxd0YvdkNyV28zRWN5NVBSSjBs?=
 =?utf-8?B?SDBqczNTc2R4dmtyY0gxcStJLzd4RjRQb1N0b3d5dWI5M1RmVGYzbzA1Nmdt?=
 =?utf-8?B?aGwvc1UwT2RIYUgrcURRTnBSa2dCdGJZQ2FWSW1CenhQVGdPcmJCZGMvTTNl?=
 =?utf-8?B?dVMrNDUrZ0dTZVB2S2d2aHZod3JUL3BNcm1ZRThRbmJwbGdQdVovNzJQVEJS?=
 =?utf-8?B?cElkaGxGTlJIUVRmTHJ3LzRqYjFvM3VmdExXNUxoanhscEhTUDZ4SC8zSUtq?=
 =?utf-8?B?V05naXVaRXJuWkoySU9YUTJBUnNZNGY3c3Y0K09IbzVEMk1adm9UM2U2dSt0?=
 =?utf-8?B?eVNzMWJYZkJIREZhcm83K1Y5UDFUV2RlNlhZWjk0d1FnSFh1WmhRdlpKc2ZY?=
 =?utf-8?B?NytPRHNtN09xb0w5Y2o0VUdITTJwcnJDa24wbGJJTmQrdmJBRGVpNGNtN3BM?=
 =?utf-8?B?K1RacVVYL2tQV3lxZWc3RHQyN3h5dWxZaVBxNUEveTJGNXA0d09EclZRSE5o?=
 =?utf-8?B?Q2gzV05iWnRTNk9JYUx3S1MrMmtROGNLc3RodlQ4eWppTGp4Rk5YUG42S3pw?=
 =?utf-8?B?eFNtNDZ5NDBEQjcwRXJnY0tMSVRrUjRyZFFQQW1ueERja0VIeGl3UE1CcGFS?=
 =?utf-8?B?R3FPMGdXVzNzcXJsa1R0Zm1lRW5UWWd0TEVtLzRtcnZsbFJjOTdJZlZUNU9u?=
 =?utf-8?B?Y3RBVjZjSlhTMGFaRFBCT2M1NHVCVUQxdWRWbk0rUDFrVlNTL3hsSzhJK1pH?=
 =?utf-8?B?V1AwcjFqYXJvM2cyWk9MYktmY3RzZUptQkszcDJvazdLYW4rU3RYK3NITThy?=
 =?utf-8?B?dlJaMUZMOWZ3cWVlYlo5VjFBaHNVSW84R0xDbnJLUVdxYUY5TEZZU09aeXFt?=
 =?utf-8?B?QnE1QkpqMVJ5M1Bta3ZTQzVUUjFxckJlQ1ovYmtvVkorSnRTWTY1UElEKzNM?=
 =?utf-8?B?eXNSbEYxS2F6WGxJZXBtSWRIdW4rNHUvdkJUQkpDZE1GQWZicEJ6WVRUNWFk?=
 =?utf-8?B?d0daNmhZVEcrSEJKaHhCcXV6bmV3RmhaY1doZFkrWTJtMEd3MDJtd0s0cXJE?=
 =?utf-8?B?RmpYa0ZlSEI3ejYzUGJYd1JmU0Z6dU9EM1czcHNsMGU2c3Y4bUM4eFp1V1B0?=
 =?utf-8?B?a0VuWHNyREY3TlZ0SDl3MXhLaVFlcFZqKzIvOVAvekE3cm5FY0NKVU1zODFK?=
 =?utf-8?B?SU5UUUNQR1JhNkhkVGpZSlFvVE5WNmJLYTZGNklLUEJTOXVLRUUxekZvWEIv?=
 =?utf-8?B?blFucnpTaytMNmkranpXWnR5RFl0dmRReEpITlZHcDBBcWpDL0lZV25CUDI4?=
 =?utf-8?B?RlRGME5xOCtVRmNMSCtKMEJieHVldGZFN0VaanZ6UHlqUEp6bDFkY0tKbFlj?=
 =?utf-8?B?MG9jcEtiVFBVUUlXYVlIR1l4M1h1N1BLQURJZkJ5TEJEMnB5a0RLN1gwMFdE?=
 =?utf-8?B?U1lNTHFNYTY1MU1acnpYNkg0MHpyeGZZaU9mNXdxdUM1UGJhY3FVNHRlbDFK?=
 =?utf-8?B?aDVkRWR3Ukg3SGs5TENVemJ3bzRDVWR5RmphWGdRVUp0YW9oUE9VYWh3SjJP?=
 =?utf-8?B?bnRUdVowSURUNTNNb0duSTJYZzNXbUowbHlrSUhXbzl6N3pmN0MzdjlZTWRS?=
 =?utf-8?B?c2NBcHRvVVNGWjRQWWZORTFiYy84cDhyN3FjVWZoOEJFNVBpNytKSW14ZFBP?=
 =?utf-8?B?MTg3djQrOGVMWHVKejVQWTdJLzFYQ1JDZFFzczJEMms0WHNwS3UvQlA4QVR2?=
 =?utf-8?B?ZnVVOFVjKzN4QXUrK2RYQmtsM055OVNqLzNZei9aMFA5OHBITVIzY3NERjZ6?=
 =?utf-8?B?S0NocVdlYzZQSFdoM09LdVY5OEhYckhPUDlxRk82bXQxcW5QSjlMYk9la3JI?=
 =?utf-8?B?bWk1SXhmbkJSNjB3TFhiNWl5M29UbmZJbTJLRGRmQ3JwUnowdGVGYkdzUnJX?=
 =?utf-8?Q?eUTiICfQJCP3WY+ERPOEkOgxI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73149032-f602-4ab5-086b-08dc22a61f2f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 21:46:46.4074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YSMcn5XhPnJdas+bZmr8uJYduOsSXLWo6Dn6KI02re/CjRuKRul4VtxE5bQ4wZErUdlOvHv6tJoME/jUd4VYqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8538

On 1/31/2024 02:50, Perry Yuan wrote:
> Address an untested error where the nominal_freq was returned in KHz
> instead of the correct MHz units, this oversight led to a wrong
> nominal_freq set and resued, it will cause the max frequency of core to
s/resued/reused/
> be initialized with a wrong frequency value.
> 
> Cc: stable@vger.kernel.org
> Fixes: ec437d71db7 ("cpufreq: amd-pstate: Introduce a new AMD P-State driver to support future processors")
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
One minor change above.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 2f8656f75a1d..9291a22bd3cc 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -625,8 +625,7 @@ static int amd_get_nominal_freq(struct amd_cpudata *cpudata)
>   	if (ret)
>   		return ret;
>   
> -	/* Switch to khz */
> -	return cppc_perf.nominal_freq * 1000;
> +	return cppc_perf.nominal_freq;
>   }
>   
>   static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)



Return-Path: <linux-kernel+bounces-55272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED2784BA2A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 507C0B30907
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EFE134721;
	Tue,  6 Feb 2024 15:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Oo4xhbWk"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2066.outbound.protection.outlook.com [40.107.101.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C263130E30;
	Tue,  6 Feb 2024 15:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707234355; cv=fail; b=urLbBmxXHPMsDeX7lEfgUVAPBUg2N0TXdGyuZfM3INUJlBLBAS0DZzHG5LuF+/gNqEEoXgBNDd8UdsPQm9kw4JRYL1z0ZvEpO2Uyk3JHBprRUGAfL/QQP8zkKPlro6ZxH7V1e028RTZB+oWHVp28KDR2sjffV8fnTjotU6BxwUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707234355; c=relaxed/simple;
	bh=tvEZVM81awavjsa1g3nQL0EvvrzRsFOpMDvWq0rFe0M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J4Pc2jktIoM0LRvBnTdna7GVK1wI1g3rTuuY+IUXXscCoA9AB5e0KT5YjyQVIA5BjXyPNmuIodb2hjSw/Aj4U22f5n0WcnufBlnsrRl76lg/HNSkDsGg+JpCX4ZfUPEygVYKQ+Jyt32CAbLlWdsq3mrrPGOXaaCfeOawjrZqkmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Oo4xhbWk; arc=fail smtp.client-ip=40.107.101.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmGKdcDqzgb+nk0HKV7IKesxJQ+bJHAcYnm7bYtTDs2WwueMrEPy7aQKwhc2/id/zeIdoUGIqrwe1e/1/T5K16Rj1pZuNCDyMpjKJqX0nqG+ZGkb6iYuqqHRSG57b6JFpPIOoJjNGUVH9ryk7yuTYhYPMPYKw2cUzp5Ne6yKWFEbr/JLExCv/bIIaXhA1o3rNQ6dWBJAyDvXJ3Pjc2AWz5+9k5Psj/9Z721TTWfXrnJ/SFAtUivINNVMK+KPR6wOnyWRpt7gwwsun/dmY1JhERCqlmvRcpmRrUEqaqzYFiX2NHUaWh9KKW2Nh5WmHsen4toJ9KB3DWpRm6c4iR7gFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ifn3ClyEG00ViJ7aB3qDSWWmoXUaazplkaXEB7TZLSE=;
 b=iWj9v6JuHDtrrf4NIQROjo/uK8OuTY7WR3ThPygcCKVZzvOu+V5S3FL9F39/bJa/N4B+1mgiEGACVlhvQGPgx4iYDABLiwQULWjG7AfKshkDd/NJufmA9Hz3v3fksFWnrfs558j4LJbGwwBBj/pEAC5F5ZNyqkhnP9HEsZB4QTtq5DRQCd6WOgg9Q3ZdlOdTyfcZzgdi4I3PvBoPC964TViDvPrHhWqjPGxFhtlc44hjcobLTy/xnkOkRfCctJTxzU4+iYUjxvzjOLJjsnFnHz1+t5gxVnh0jGXoVfCTfVCj2CCbrbNrNrC3/5AaRVMfU/PbZFwb+ENfmeTCT3fyxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ifn3ClyEG00ViJ7aB3qDSWWmoXUaazplkaXEB7TZLSE=;
 b=Oo4xhbWkauG2o7V3pKKHakXqaENANgy+Mlrr3wWXgdzdLMGu+q3KuYrlxzoUSiXQpODVpX+iiHNfp2o3SQCftFPwDXCU9tu8jbri2v8Jd3wLyyth52YTiX/epYNeEO7KY6I0mPeSlI7loN5VXp+7U0DrPW8e7D2cA4lnXONiU98=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4545.namprd12.prod.outlook.com (2603:10b6:5:2a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.15; Tue, 6 Feb
 2024 15:45:50 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f6d2:541d:5eda:d826]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f6d2:541d:5eda:d826%5]) with mapi id 15.20.7270.016; Tue, 6 Feb 2024
 15:45:49 +0000
Message-ID: <80c4a2fd-d24b-468c-9aae-1a4ef509babc@amd.com>
Date: Tue, 6 Feb 2024 09:45:47 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] cpufreq:amd-pstate: add quirk for the pstate CPPC
 capabilities missing
Content-Language: en-US
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1707193566.git.perry.yuan@amd.com>
 <4626a4aff50921be3b7a0345ae51e5aa246504d0.1707193566.git.perry.yuan@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <4626a4aff50921be3b7a0345ae51e5aa246504d0.1707193566.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0119.namprd05.prod.outlook.com
 (2603:10b6:803:42::36) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4545:EE_
X-MS-Office365-Filtering-Correlation-Id: e5654c96-eb62-4c07-edeb-08dc272ab152
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jrC6WYyua0ih1IUcSJQpBHU3BEhZDvZcku7XdYvmR9csSWCZpA0IupvWVffpdoShXvS+LBqzRu0YGBMbkSSnFB2e6+U5b+berrEvcpaj6+vC33G7NZijAVY3i+UjJjshDcJP1p/krLIpYMhEq/naZa05dHsUAJix8OeNoBqcMbyytaoif+zDiPeVtOGzc0pUnwgH+FlxllpsKhunEAi8Rq9hAKl+Be7UFR0le6kT5w/Wv+Mz8c5onPdxZFeSuX83iUuF1xl5IrQHMvrHLaBgcylO9I+NWeUukWnSrWLJAuz14+LyKaSa3TvoUkodMoBGOn3VrFCZ+dOcRTvT1a/kFvdaEqF8PpQ95E1RCdnpTXWg52YYL9g1J6KKWyM7ZtqLniGiSvx0qAtMGj8XS4Clex859ygNoLK25VnAvWcgtim2cX9hQ24DG5yrEyj6e+kodZrpz2OeYeW0i33XKRdBZXg81LCBUukhHpJp0gP+bxB0JBEOh3ByxsXMp0VkrECEf+MbpMLRBu/qRHQsL38cYNgRgMR8m9lLkVAMCfYGF7bi2Rri4lOdOmAbX3sahz0a/5RnK09o2fUd+0YlEyUyHqWY/JGIMePs1PG06kv56xXBwfCBLHurJaBb0LCiKaGE3fMGoaLfBcRXcpYJbY8oRg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(376002)(366004)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(2616005)(26005)(31686004)(41300700001)(66476007)(38100700002)(6636002)(316002)(478600001)(53546011)(6512007)(6486002)(83380400001)(6506007)(36756003)(66556008)(66946007)(86362001)(5660300002)(8936002)(4326008)(31696002)(44832011)(2906002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUUxUHJZMDRieEFnVVNOUS9LaDJQK1JjSWdNV0RTcUdBb2U0RitzbE1id014?=
 =?utf-8?B?NUFFNFpYVVJXYlBmeDNIci9iT2dPQW5LYno4OFRLMUhFUnVqRUdHNVNIY0Qv?=
 =?utf-8?B?N24wa2xQdXNZK1dTM1V6LzlWb0p1ZlIyNFp6RmZQQWU1c1l6YlJNeUVSdS9M?=
 =?utf-8?B?dCtPRFJaZjMvNEo1WjFJOW9RNHJxQzFKUmFYSjJRZXNPN3VVYktSdGRxQUM1?=
 =?utf-8?B?Nm1OeTlOWW1mTy96OURXQWt4b0dwcHJlcUpCcmFoK0p0UWxzNEJrdzVSeXlC?=
 =?utf-8?B?TGtucTlQYTRZd1A3RHpJUitxdnN1MUhtTURpd2ZoaXZsU2o5bmNqU3RESGYy?=
 =?utf-8?B?S3ZWeVBuUVpTKzg0Y0pTMWZDeTNkNzY3cnBHTitqYkV2YUNTcTdQZXRXdnBi?=
 =?utf-8?B?TVoyb08wbSs5dVhQNjUyRUZScldiYjJaYmhqcFFRTHhlalQvTis2K1JqWmJa?=
 =?utf-8?B?SmwxYmw5SG5jci9xWkxCZXB5eE9UT2JTcTcxQnUvQ3h1cWFWOGpldmVKYXpI?=
 =?utf-8?B?bG1LZEhtbmFjbUZURWFXaDQvclNrcjdRdTZMWkgyRTJhRlYrKzR0YWxYZldK?=
 =?utf-8?B?aVdlTTg3TFNGbzBtbXNCYlIrdVNCZ1VLa1l1QVNzb1lCd3hlVE5CL1pIeWg1?=
 =?utf-8?B?Q214MUdocUZBNDQ4b3BOLzRHV3R6RExpblY0aXJjVHEzVldiZUQ0RmZXSThG?=
 =?utf-8?B?akh0VkR5cksrQWM0dmhxK2hMbjNvUnFtNlBlU241d0FHbFNMTHNqS2ZCWXkz?=
 =?utf-8?B?NktDQk56SzBUY0tCSWpFQVVjd0xjMHM0d3kwMXlGSzhLSGFKQVFhU0h3S2l4?=
 =?utf-8?B?Y1Awa1NlVGoxcGhwSDlFazNnNWJnVG1HT3l2Rmp4NUIyUmVLcGJ3ZmFnQnRn?=
 =?utf-8?B?SW9VNjhYZ1ROTitCV2ZQUWxBS3FFMUtqQjJPSEtOVUlTMUZzaW9LK0w0eDFJ?=
 =?utf-8?B?WHBHZlEyS3VGVjQrQkNibEdacmFySlEzT0YybzZBM3Z4QjcwemR2dW01TDhk?=
 =?utf-8?B?VStDNjFBSTZ1dHd0dXJvZXVOcXFuMUxWVHoyYmNyZjBaTFl3VERiR1RVOGtC?=
 =?utf-8?B?cWNFckhrYkc2cG9kb3FucXZtSzB3NkhzTCtGNG5LdjBXWi9OZGY1Y3Bwckcv?=
 =?utf-8?B?dmloT3l3RlZxRUdSQkhadDZsQldDZEtlczdTRnNQa3Y3T0NUTklXUW52eFFL?=
 =?utf-8?B?ZkZwb1ZGV2lZRDdLbUJ4UUhRUm55am50UzBidVlNNWNydHIrbU04bGljeCsy?=
 =?utf-8?B?ZFNjQ0NUU0d0MlpDaG12NlNjYitQOEdRWHdFYkJrc1lpeFJlNDhGRE5wTzRX?=
 =?utf-8?B?bis0WnVDZ3o3TmxNQmtKUjg4N2FraVFOODV0VGRPN1JTazRkUGcwb0ZSemVs?=
 =?utf-8?B?RzFWNE9XQ0IxbDBDRHpCZEMzTDJ3Zk50MlZCTmV2YUpIMmVoM09rUlRsdXZG?=
 =?utf-8?B?SlEwN3V5UjJncU4vbC85RTZCV3pCYm9FazdobjRUMjBSbnVzR1VDL2ZhSC9H?=
 =?utf-8?B?WmExMlh2Nk5uMm50WHZsT29uc2ZHRmJKUmFJMzFSMkIrSkMrRFRIUk8yOVhU?=
 =?utf-8?B?MEI5WGV0MTlHZGtEVGJ0cUk1SkdKSXJCNEwyb3hsY2t3ZTJtTTJNSDkwZUhz?=
 =?utf-8?B?ZzVZVWNLeVRYbTE4Q2dmZnFUeXNGOElxSC9mSlRacXR0a1c4bVZaZmwzVWpH?=
 =?utf-8?B?V1ZmVjNMMGpRdlkvOUx2U0RWTzRnSkc0aFcyYTNYTnVubUgrOHBkSS90YlYw?=
 =?utf-8?B?cmZnY3lCb0RvOG8rWTBsbkNaOUZTZ3ZHbWtKbndMSGpIRlJRbXhMZWdzVnlP?=
 =?utf-8?B?TXJldjloSjRpaUs4VE1ZWURyZW5qd1A0S2hqVWtGa3dsUmdBcHNkazNsRFF3?=
 =?utf-8?B?NmNWUUNCTUxaWjNIcStRem9wRVhLWGtGOTNGdmhiU3FOU2FHeFdFcE15bzc5?=
 =?utf-8?B?NEZXVnFZU0V0WWRQTGFEUjgyc2Z0d0VLYUUrWnBDRzdhb0tTd0NvbGFHa28r?=
 =?utf-8?B?VVFkekFjSUlEV2JsMVBVTFV3UUlUVW9RK0tBRlhFWWdvSlpaYWgxRG5xS3M3?=
 =?utf-8?B?ODJFSG1iTG9pUEVGNXJzUzkrLzNjRXJ3c3h3NE0wekNWbjdKQ1VocFdFRUM0?=
 =?utf-8?Q?LE5Lu1xkGLDuZRFe0YUZWM3HW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5654c96-eb62-4c07-edeb-08dc272ab152
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 15:45:49.8609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VMkadMLja2VBeO5XAm1+m5sOg2e8KsvKkUXHMMVmA81wQfmu+OlfFGIfmrRxDwWOIqQonPgZXhP/2x8tvl/Y5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4545

On 2/5/2024 22:33, Perry Yuan wrote:
> Add quirks table to get CPPC capabilities issue fixed by providing
> correct perf or frequency values while driver loading.
> 
> If CPPC capabilities are not defined in the ACPI tables or wrongly
> defined by platform firmware, it needs to use quick to get those
s,quick,a quirk,
> issues fixed with correct workaround values to make pstate driver
> can be loaded even though there are CPPC capabilities errors.
> 
> The workaround will match the broken BIOS which lack of CPPC capabilities
> nominal_freq and lowest_freq definition in the ACPI table.
> 
> $ cat /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_freq
> 0
> $ cat /sys/devices/system/cpu/cpu0/acpi_cppc/nominal_freq
> 0
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 59 ++++++++++++++++++++++++++++++++++--
>   include/linux/amd-pstate.h   |  6 ++++
>   2 files changed, 63 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 77effc3caf6c..874d8b663790 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -67,6 +67,7 @@ static struct cpufreq_driver amd_pstate_epp_driver;
>   static int cppc_state = AMD_PSTATE_UNDEFINED;
>   static bool cppc_enabled;
>   static bool amd_pstate_prefcore = true;
> +static struct quirk_entry *quirks;
>   
>   /*
>    * AMD Energy Preference Performance (EPP)
> @@ -111,6 +112,43 @@ static unsigned int epp_values[] = {
>   
>   typedef int (*cppc_mode_transition_fn)(int);
>   
> +static struct quirk_entry quirk_amd_7k62 = {
> +	.nominal_freq = 2600,
> +	.lowest_freq = 550,
> +};
> +
> +static int __init dmi_matched_7k62_bios_bug(const struct dmi_system_id *dmi)
> +{
> +	/**
> +	 * match the broken bios for family 17h, model 31h processor
> +	 * broken BIOS lack of nominal_freq and lowest_freq capabilities
> +	 * definition in ACPI tables
> +	 */
> +	if (boot_cpu_data.x86 == 0x17 && boot_cpu_data.x86_model == 0x31 &&
> +			boot_cpu_has(X86_FEATURE_ZEN2)) {

I think you should use one or the other (17/31) or (X86_FEATURE_ZEN2).

> +		quirks = dmi->driver_data;
> +		pr_info("hardware type %s found\n", dmi->ident);

I think a better message explains what is happening.  For example:
"Overriding nominal and lowest frequencies for %s\n"

> +		return 1;
> +	}
> +
> +

Only need one newline needed here.

> +	return 0;
> +}
> +
> +static const struct dmi_system_id amd_pstate_quirks_table[] __initconst = {
> +	{
> +		.callback = dmi_matched_7k62_bios_bug,
> +		.ident = "AMD EPYC 7K62",
> +		.matches = {
> +			DMI_MATCH(DMI_BIOS_VERSION, "5.14"),
> +			DMI_MATCH(DMI_BIOS_RELEASE, "12/12/2019"),
> +		},
> +		.driver_data = &quirk_amd_7k62,
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(dmi, amd_pstate_quirks_table);
> +
>   static inline int get_mode_idx_from_str(const char *str, size_t size)
>   {
>   	int i;
> @@ -600,13 +638,19 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>   static int amd_get_min_freq(struct amd_cpudata *cpudata)
>   {
>   	struct cppc_perf_caps cppc_perf;
> +	u32 lowest_freq;
>   
>   	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>   	if (ret)
>   		return ret;
>   
> +	if (quirks && quirks->lowest_freq)
> +		lowest_freq = quirks->lowest_freq;
> +	else
> +		lowest_freq = cppc_perf.lowest_freq;
> +
>   	/* Switch to khz */
> -	return cppc_perf.lowest_freq * 1000;
> +	return lowest_freq * 1000;
>   }
>   
>   static int amd_get_max_freq(struct amd_cpudata *cpudata)
> @@ -635,12 +679,18 @@ static int amd_get_max_freq(struct amd_cpudata *cpudata)
>   static int amd_get_nominal_freq(struct amd_cpudata *cpudata)
>   {
>   	struct cppc_perf_caps cppc_perf;
> +	u32 nominal_freq;
>   
>   	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>   	if (ret)
>   		return ret;
>   
> -	return cppc_perf.nominal_freq;
> +	if (quirks && quirks->nominal_freq)
> +		nominal_freq = quirks->nominal_freq;
> +	else
> +		nominal_freq = cppc_perf.nominal_freq;
> +
> +	return nominal_freq;
>   }
>   
>   static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
> @@ -1672,6 +1722,11 @@ static int __init amd_pstate_init(void)
>   	if (cpufreq_get_current_driver())
>   		return -EEXIST;
>   
> +	quirks = NULL;
> +
> +	/* check if this machine need CPPC quirks */
> +	dmi_check_system(amd_pstate_quirks_table);
> +
>   	switch (cppc_state) {
>   	case AMD_PSTATE_UNDEFINED:
>   		/* Disable on the following configs by default:
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index d21838835abd..7b2cbb892fd9 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -124,4 +124,10 @@ static const char * const amd_pstate_mode_string[] = {
>   	[AMD_PSTATE_GUIDED]      = "guided",
>   	NULL,
>   };
> +
> +struct quirk_entry {
> +	u32 nominal_freq;
> +	u32 lowest_freq;
> +};
> +
>   #endif /* _LINUX_AMD_PSTATE_H */



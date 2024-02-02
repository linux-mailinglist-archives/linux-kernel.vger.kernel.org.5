Return-Path: <linux-kernel+bounces-50004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 095D18472E1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4B222935A6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3363F145B23;
	Fri,  2 Feb 2024 15:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gXQF6E+Z"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3038B145B0F;
	Fri,  2 Feb 2024 15:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706887014; cv=fail; b=SE5hcnU+Cmy713ztLTZFcaiksBRVEW4eG3G1b+CGnMI/rZIQKJDKgjWJZNkbBx1AvsFqJ5Dr0jxklo/8Hrz4rfcVLvH2KoSoQAJ2NDBRdfl+1Z22+1y5wpgj4ZWSkBwcxQuo8mcELckf2/+9Yj+5DxgaU/X7KDPelkrdt4pf0es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706887014; c=relaxed/simple;
	bh=sXCWs7NHsYw+pxkRimrL3wpx/XYbMeb8+Zy4vGBb8Es=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OtJlIoC3wkWbFQzK19krJEXhKZVzqCw/xHue36lMKED5pNutb3v/RP2hfI0gLPStuspXe3zOcLub5L4iR885F1CEuIZizXMZilgQ4SiyO9TDc4JfJAijFKPuj8iQbq631ITZBBIHv/9vCOlFbpeoLtAF+GHI1HvgVXldLI780Ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gXQF6E+Z; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVFu2czoRqvn/uEwVkfNf73ZnvC5ETZ1g4HtlrqPL6FHOoF8w+79YCgyluCY+EELu5th9F5tfONyBbNqe7uTNus91kBp/yrTT498xOxWI3DuV+ZpGb341l7R5mqU97wRWgQwnMHYtsC1o4v5noG2XlUOdAOfcacab/jUmu4nH1Wa/Oe0TS5gFsA8sRbNN9dcqcSyfqyoZWTNJx1649knOJ7oUZlbrChlL7raUXWwIwK6OqRZg4US74UzLulzUsgUbdbq4ng0Rm773arTVw3Hfxjozfs/CjfXNLBbW9DMJNpB74mFPMUy/pWqVsFvas8hYLus4DzAifbOh+elfNRHEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LswVVhrC8AMrWjvCBxNmi1+B+ESvXnZ8Fptllrukoaw=;
 b=FE+UcWnqj8IJYdmns8fYNFUb+YE8igJQxe/VDD56bgnPjU9V3YGm1IJ4qvMQjOsxQr3GWz7e3MzXCvtolprzJAH3dlM6uMeg9uYupUh6+QmS+qsi09odmVP/HjDB0CJSmAk0O97dAgtlQnUMi168CQQouKMxAGd/B07W37XdR6NaxWbMTZGOGjbd6MYo1+7ULMzt46DRsDEpFZufcyrBFz4lQqCGgS4MNMbZ/oUDK26McGjSbFuqtEd6XvnzQBdYDJx3iYvCth0tdJ7pdV2JDxjEMJXKnNLS0CGxTGcNSLVQv9Eo/htnL2d1+ZtlIXk8/uY/n4oUxXhyo9J7ceeVLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LswVVhrC8AMrWjvCBxNmi1+B+ESvXnZ8Fptllrukoaw=;
 b=gXQF6E+Zljgp5tgTtkAbS3wInoc5R+vtOXba+KvkzVO2Dw+C+MSqlrBFq5L1N3u6nd+YDHV8UDqILAnGKdHLd61gjG4iNFxQDo9PhCGFgPc8awXb+1S2eyOGOo3BK7pnR8XTI8imJ3ek6bm4NHKIO01lkUDfP+FomyuMv10S1fA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY8PR12MB7612.namprd12.prod.outlook.com (2603:10b6:930:9c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Fri, 2 Feb
 2024 15:16:49 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64%4]) with mapi id 15.20.7249.024; Fri, 2 Feb 2024
 15:16:49 +0000
Message-ID: <097c6d94-2add-4c59-9ab3-8e8dbc7605c7@amd.com>
Date: Fri, 2 Feb 2024 09:16:46 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] cpufreq:amd-pstate: add quirk for the pstate CPPC
 capabilities missing
Content-Language: en-US
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1706863981.git.perry.yuan@amd.com>
 <8a55135d10cfc906616d3cd4530f9aac487c5034.1706863981.git.perry.yuan@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <8a55135d10cfc906616d3cd4530f9aac487c5034.1706863981.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0208.namprd04.prod.outlook.com
 (2603:10b6:806:126::33) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY8PR12MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: 12468d41-cdd3-402c-babc-08dc2401fa70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sJQGLdPWqAwYu9JRDOP6lvP91S/JMPHyXqtP46DD5e/IeYsJD9KXLhSBx/BZZsw0n74U9IZskPwmTefPjJR2IEDfT97Loz2LvwGYJAFI+g3h1iOfy2P6ENCCujIylISFu5geL6xGSMP5/1bvJBnIfr3QBZlQ5hus4PsF+J8p7GWo8rTCmjoPlD2Wpnmo/98b4v9uVAHmtSxBqlTB78f5LBLf3ZnnLkWJCMDVRwo25RwOcPuLX0Ttf3qBZFr6qbAu9R/K4IZ3ka9nhASCbKgYbXyFiJct2Vqd4ONdLx7j1VuCAClNyM1Wr7zqBMYehPwUEkLOofYrjjamkbE5aLbWEYRCRDnMsrIVW/D6C3McrmgPP0axn8zcAyO81na1rXWAfVWMCe3lt/bJppZFXn/SZXBEk2xpPTWPK+Yho98W4Bwc1qvUCoNfvQuqGrAeB3GGgCgH/yRatCVBUuMEBU27u64i+pAss4hW9LgkmSnsNDpD+8lzhhuaaSI2CpUpppysxAA0nVPn+R9tNdHaB4l/GeMO3cGs1/TsRVYX/gsKeM5jecDCrvKIq8d1YGeVRfosI+vqkkzfzWjRt4ZghjDMXeqrETbWzfI4T/qAJ6MiQ7Z3uYBZBleTASj4cBveq4/i6LpKPvWDyRlsAKBN1/vpGg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(136003)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2616005)(26005)(83380400001)(6486002)(478600001)(6506007)(53546011)(41300700001)(6666004)(6512007)(36756003)(8676002)(4326008)(8936002)(31686004)(66476007)(316002)(66946007)(44832011)(6636002)(2906002)(66556008)(5660300002)(38100700002)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDF1K0xweVVjOXIzMHRJUUVtYWJmUjNnbmxCSE40OWJpUkdpUlk5Z1h2enVn?=
 =?utf-8?B?WU54RXorVGtuZFVoV0VZV1YwNUdSSmF2RmNSbmRXbFZ1b1AySy9JMm1TcWp2?=
 =?utf-8?B?QjlnR3RqejNnWjIyM3VNYUlseisyUTd1VHhpU3haQ21abTBuQlNidzlQUHl3?=
 =?utf-8?B?RXVOczcrOC9tdjlJSEcxbG9nQmZDWkREd1VFU3M3QVRBSVMzRzJIbWwvemhZ?=
 =?utf-8?B?U2k1TzAxbndzR3F2MHdJM01pQU1id2EvVHI4VjE4dFFHdjFtcmpSN3QwQkdL?=
 =?utf-8?B?UzY5VnlHQjdiYkY2eVN5aVpSMERkWENkRHRqbEVtcTZ1cFpNem5zVlBHeWNy?=
 =?utf-8?B?OHFSQ1B1bUQzUW5UQ0c2c0k1ZnBtS21pM0g1TjNSOUowSjZnTHZxMnhFUjdG?=
 =?utf-8?B?a0FJcXVHTHZ6bnVaVWVDL25mbW1ncUZHSVU3a2lkdzFvNTZ3a0NsbTJqVU8w?=
 =?utf-8?B?ejc2NWR0RFJDSFVzSzVxd2c5b29zdGVBdXZLRThSdVB0ODMxZVpFSlZXUXVQ?=
 =?utf-8?B?WDhOMUsrRGRRZDRZVGcrdHpYRnY5eGpNNlJVYlNGaGlOZ20vRDAwelU3SHdP?=
 =?utf-8?B?b2JMM1pkb3UvVUZWV2ZLU3lLSTBFN0RhcW0vZE1YTTZXQkVDWFlvMjhEVnJn?=
 =?utf-8?B?QVFiOWVCZnljREpvL2FGaTNHeVlMck5meXpMdEpqVC94bjV5ZXA1a3ZRSDg5?=
 =?utf-8?B?SEovd0U1dllWdXpwRnhkK1UrZXY5d2ltR0xTTmhBZnRDOXhCdEFHMHBvSDl0?=
 =?utf-8?B?N2xEWjdZVkptRHI5WHdjeDkrODVTSUdoVFZJd1FYMlErN3RGNkY5dzcrRG1y?=
 =?utf-8?B?akcxcWY1RVNwWmNuelF2Z0JMYTFNRGVXa2VjN1RsZzVFVTJEb2tZL01CSkNG?=
 =?utf-8?B?b3B6L2hzbklGWE1JWlJXeU8yY1J5VXlsRDRmZUNlTC9raG84WGZjQlV5akRo?=
 =?utf-8?B?TndEcFBqY0o2d2YwQlJ0cDlzcDhZYWpBQk1GSnh2U3FkZzF3RCtHUXc2VWVs?=
 =?utf-8?B?alIreWlWeHJOeWI4US9NSmQ5Z2EzbnBqTlFhcGNBODlhSXd2bzBOMjJkRzhq?=
 =?utf-8?B?VHd5QUhZODA4TVRuQzJsTHcrV3I4VHFqdHJ0UnBWRmYvRGVOQTJnblUrQTRR?=
 =?utf-8?B?T3ljaEVBOFZFVDg0cTVUTkE0YkFCZnhLQmFwb0F5MjF6Ukt5ekdDdUxJRHg4?=
 =?utf-8?B?K0VLVE1uSzJTVCt0ZWdGSUJBZjlWTG5IUG43ZURQSWFjVm1uQWRMZ0hIZzdU?=
 =?utf-8?B?SkhPaFpDa2dsOU9ROXYwUzNqbkxaWWpPcW84VWtvQWpESk1KU0JtYU9qL0F0?=
 =?utf-8?B?LzhFSENPd2JjeUlzVU1OSjhVQUJ1RHhPVTlrS0k3aU4wUzNQOExIY1lkOVhj?=
 =?utf-8?B?VitiVUNnMHNsZ0hwLzNha213WjNEanF6Qnd1WUJMcmNmMWVGalNqQzBFVGpO?=
 =?utf-8?B?WVFXQ0doazR5SStLekdrWG0xQXdheGVFQ0ZmNmdRTUcrR1ZJc0pYSXc2THd4?=
 =?utf-8?B?ZVM3c1R6T0l5dnZ0Q0ZSZU1yQVk0NERDOGxHeElDdDBuNmNwV1hmcC80ZitK?=
 =?utf-8?B?THBFUFJkSHEvaU9OMVhVQVQ5amQreEE1ZUg4NmlSd1BsOXBoamVYVGdZSzky?=
 =?utf-8?B?bFU2OHNCOXROaGZCV2NMR3ZlWmloM3pDSFNFZlI0NXY1aU9VZkZXYWRKbWVL?=
 =?utf-8?B?cHBkR3EvWjVMSm9pcUZQYUUyQlFYTWxONnJpZlJ2MXY4N29sV1pURUVTcUJH?=
 =?utf-8?B?UkN1TjQ3Zm5kNEwwaUhuQm5Na1lucnQ3bkdKL1d0T1lNeEUrZDJEUkljZVVQ?=
 =?utf-8?B?N25ucTVlKzhycURxdEMyNGQvVVoxWUJpbUZwK3NLRnUvVWtyc1dCbjQzbm1E?=
 =?utf-8?B?NzBzTmJOSDFoenZpMlUvMmpCSjRHRnBIeG85VjByTzdvcEFqZW9IeDU5NDkw?=
 =?utf-8?B?clV4OXBqczZuR3hyUTl6cFFUWWhMQ3l3WUdHZzVBTXpPV1Jzc25mM0JhT0hC?=
 =?utf-8?B?NVBtdWtNRlNXM2wyVnlzTUo5RUdJeXpLY0czTFZBakhkNnQ3d3hlOTNRUndX?=
 =?utf-8?B?eTdBMG5KaU9TZUdRZ0lDK05pWEpxMGdMajMrZkc3bTcxNjRQcUVGN1MzaC85?=
 =?utf-8?Q?D1SPT3dACi7O4c9jw7US2CXzA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12468d41-cdd3-402c-babc-08dc2401fa70
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 15:16:49.6251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D8CHMmB+GCm8AiqD+Juz1LrCn28t1vLsSvTLjoOrEvojJew21hlYOMV61TNZrN8z+XXh64/C6+CwPTONOgMJ3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7612

On 2/2/2024 02:55, Perry Yuan wrote:
> Add quirk table to get CPPC capabilities issue fixed by providing
> correct perf or frequency values while driver loading.
> 
> If CPPC capabilities are not defined in the ACPI tables or wrongly
> defined by platform firmware, it needs to use quick to get those
> issues fixed with correct workaround values to make pstate driver
> can be loaded even though there are CPPC capabilities errors.
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 49 ++++++++++++++++++++++++++++++++++--
>   include/linux/amd-pstate.h   |  6 +++++
>   2 files changed, 53 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 77effc3caf6c..4d426516abb9 100644
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
> @@ -111,6 +112,33 @@ static unsigned int epp_values[] = {
>   
>   typedef int (*cppc_mode_transition_fn)(int);
>   
> +static struct quirk_entry quirk_amd_7k62 = {
> +	.nominal_freq = 2600,
> +	.lowest_freq = 550,
> +};
> +
> +static int __init dmi_matched(const struct dmi_system_id *dmi)
> +{
> +	quirks = dmi->driver_data;
> +	pr_info("hardware type %s found\n", dmi->ident);
> +
> +	return 1;
> +}
> +
> +static const struct dmi_system_id amd_pstate_quirks_table[] __initconst = {
> +	{
> +		.callback = dmi_matched,
> +		.ident = "AMD EPYC 7K62",
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "C1"),
> +			DMI_MATCH(DMI_PRODUCT_SERIAL, "FX19911000028")

I saw your response to v1, but really this is too narrow for upstream.
It's literally applying to a SINGLE system.

I feel the rest of the patch is fine, but we shouldn't be adding single 
system quirks.

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
> @@ -600,13 +628,19 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
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
> @@ -635,12 +669,18 @@ static int amd_get_max_freq(struct amd_cpudata *cpudata)
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
> @@ -1672,6 +1712,11 @@ static int __init amd_pstate_init(void)
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



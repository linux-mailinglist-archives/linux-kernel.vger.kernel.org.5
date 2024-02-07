Return-Path: <linux-kernel+bounces-57050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A12A84D353
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C1E11F2376F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 20:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71BA1272A8;
	Wed,  7 Feb 2024 20:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aEeFp8Kv"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20711D697;
	Wed,  7 Feb 2024 20:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707339503; cv=fail; b=ITN3utFfdRbzXQCFdvw7O02JwBBIvBlmzkAzdsWm2oryQf4IQ40oPmv426fpaFZlf5FJf7yiyJTL3br83IPKMlnc+srKTzzYlz8tKTAEjaeN7QCxR3gIaW742nDq6kpi2F2FqTLBO8E5ADxWd2xqICinHtSxadkgfSwe7bvmL2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707339503; c=relaxed/simple;
	bh=hVbK6Q64o2hYKVc8PNe0Pck6Dcnlztvmal4Hl2A4yHs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W/HnGqxSqMOhFMIRLu8w9eE+/JMRRQahYwP3cwU3j18H//Yb3KDszIfQ1/1Ju46eH9j/jEZx5OOdVOCuS1wxRK5xu0RltSH09QCM6Ju7w7paUp30pK+7Q3qVUg08ZmECpqKETFaXa+gpgllxOnjnQR/IWHJU8+wFnmWuSyQOU+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aEeFp8Kv; arc=fail smtp.client-ip=40.107.92.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cf5WUgePpUdmPU/7sDiD7tiDCKLQXlsozs67YNGUPm+rvyGNu/DgVKBRpDxKwWhTrtGmZz+CCaSKJFRukhXYPcBx5FC7QJmG8sI7hltYrTXLxcTXunN74hWu/x0CWHXHtq/vPn5Ee9NlOq3yanaZ3gdiaRepm2MbsPe5Tx5gA8KHHhG5pCkq0Zqq8ev3Q4glYPJ7XYj+5CcY7zcaiCCWCjJb6/VOJZSmfIan1XW0THy4zycYis9ICUwIEh+/6Rnv5UdhFBy1mQSVb0z7yWZATabbFbGCq/sJ4feTbxgKABXPNWJiuMR941ShElpD3GN4bJ00Hp1ilQwv9/s2FUf3Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9UFcnKmtH9ZoJDcI960n08d1IqsQR1bO57GFMcerrw=;
 b=luw1j7efEG2qeHy3nedydfix333geqLXDCvuYRHKqpA2ahnqa7LJue3gBDy0S//tbOz5Ub2p57+R2Pq+djnB8lXWqOwucY0bDXwEnkZ0Zhbq4dgByF+BGu8SpzvBQthyvFlxC0Rfhrk0fe3ewAfn5wjAAdzpzTbtIpHCefjbxMDPGsXVWtjT+NUgzkh3BVOv3hZ/lerzlx6AxW4WGL3tr0Mk9p07JD5RhNMWd4jQsFnjIJF9ONgYbEvfOk9/r4GAnsr1QwiDM0ml4DEWw9S3dXXPZm5P8CnoWYTEczWX+hlNzImW2yJiYRAvHAfzN6Z133/K7SPvMb0v9A/hkQC5BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9UFcnKmtH9ZoJDcI960n08d1IqsQR1bO57GFMcerrw=;
 b=aEeFp8KvAesT1czpCALWb2XuB0jT97sZOL7BWUrgA8Qcjs2OGbrCJ4FipGH7yyuVI08b4nsYq3w2Ah5Toosd9T2bU1HTqLsjoBorTRU7Qo1q5zaORUm8Bw+sSiGWmv9cjsLNy3cvLL65sEMabbZKb8gXmoQZjHhQKmd59IDr29Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB5214.namprd12.prod.outlook.com (2603:10b6:5:395::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Wed, 7 Feb
 2024 20:58:19 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f6d2:541d:5eda:d826]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f6d2:541d:5eda:d826%5]) with mapi id 15.20.7270.016; Wed, 7 Feb 2024
 20:58:19 +0000
Message-ID: <c1d10162-af8a-4900-91a2-14f80f669abf@amd.com>
Date: Wed, 7 Feb 2024 14:58:17 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] cpufreq:amd-pstate: add quirk for the pstate CPPC
 capabilities missing
Content-Language: en-US
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1707273526.git.perry.yuan@amd.com>
 <ea6a2fcf27703d40957a53608d48813cb07f094c.1707273526.git.perry.yuan@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ea6a2fcf27703d40957a53608d48813cb07f094c.1707273526.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0090.namprd13.prod.outlook.com
 (2603:10b6:806:23::35) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB5214:EE_
X-MS-Office365-Filtering-Correlation-Id: c6df5fd4-58fa-4a93-2ae0-08dc281f8347
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UYoEiQPQaS4nc7FYk9S0yspM5UMonXEROdMuN5KsPvjwtym9N0jEFikC0IvTa4LhKvHXk/ctx1z0BcovrrGqwxTeZVLdgjzw7601XWfFVPbVAGQHPJZdEQgzAmQ3wtmrNyduuWV9xpJRq9RHFqf5gIOtjw7eGEaJQ4iMwLxNDs7EmMuuU6+f4H/ksui11ui07mTXstyxzg4KRTd+fmH/ODTsVhQowBakfw731LrEG28vZI/wyWTxinJayea15ifcYbYMIFa7y/daKp3TxCm5iYP9cIaVSVxzN50cOF9devTJ7QNV7knj7+FpIXxRwE0dAFGuOn5vc0OxbSbiYmoeo+PHPBqvUFAyUTUHEEcRhqjuy4lSp1GW1zlPmVHsLtViCNBS9aLQYjBkwnICdJ/Oz7yhYa1DTIlCyX0Gdkj44GkZK5OxgN7nu+vlbFTcU25SoVjQ2naXt85YnWM8gYJm6ob781vHcMhsZgyDwK+MY3igp2ZO7BzQ4A7yuFXE8ji16YetEABpkgScmSLEGw4gINBe9/36XBwcBGn1Ea8H+NizYeE/u7FMXwK2sIUXfB23
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(31686004)(41300700001)(26005)(478600001)(31696002)(6512007)(53546011)(36756003)(86362001)(66556008)(2616005)(2906002)(316002)(6486002)(5660300002)(6506007)(6636002)(66476007)(66946007)(44832011)(83380400001)(8676002)(38100700002)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U01TTVRFbjgrUWs4cUxpaWhha0FHZlJnaVJJSjJBL3JkZ0lESmgyRUt1OWZ2?=
 =?utf-8?B?UElyN21ScS9zNmJQTXBPR0ZCRnI2WDRLcnNiSW1rUEUzMVFZVzJZc01ncWIy?=
 =?utf-8?B?S3ppaDZ1b3NRb3djZDJ5Z1Q0VDdmbmFDWDBBaDRabWJyQVhnT2hrbUQ1T0FF?=
 =?utf-8?B?TGZYVXVjOVpkNUVJaVpaR1A0TkNEWkJFNnAvL3hLNGJ1WjVTamFReXdXelVi?=
 =?utf-8?B?TVBvOVJlOGVBN2pXQ0xUYXRKVE1hZjE2dFNtaTV1RHE0NW1pVDljVkRueGFJ?=
 =?utf-8?B?d2R1ekJGTXhlaHVoaDRLeC9XQzB5OWp2YUpxaUY1a2ZFOXVXcjcxaUdrcmVy?=
 =?utf-8?B?clRyQUUySkZnS01Ram9vUnJ4U1RxbWRaOXM4dkR5dXpWUGUwUWdHdkxQVjFJ?=
 =?utf-8?B?d054RnJ0Rzc4L3NDR2MxZ3pOSk1EUzNEYXp2bEZML00vQ0lyNHNoaFJMTVBU?=
 =?utf-8?B?bVdJQUt6dUhKNkNGTXg3Q3NtZTNOemJGT1QvdnhQR0ZoTlhNeCtEM24xbDZF?=
 =?utf-8?B?QWs4TkFoZVhseDBtbGhzc0N5T05NNTlVdWlVVVZHamF5aFlDZDVyQ01UWGZt?=
 =?utf-8?B?SHEwU2IybE9DdllKSVYvdXcrRlJKWXFITDNwVGRsYXRmK1B6Tnl3RFA2cDhq?=
 =?utf-8?B?THJ2cEk1VEtUd29uWXYxdWE4RmFKRGZuZlVzOVVscHdpY09lanBtbmhKbmhY?=
 =?utf-8?B?T3pzbzE4cDFhTDFVK1Y2ekVsRko3ckR5VjQ2eTE2d1VjQ1BmL2ZkaHVCcGxy?=
 =?utf-8?B?QTN3Z0xiNlJOaUJOd1VzY203THdHaFNDRlBrdTZuVUVrUnQ4NlowU0FVbElH?=
 =?utf-8?B?UUg4Mlp4N2JyNG0xTDdTenYyTUROeCtOK0p1MHVWd0VVU1RxV1JqazlyT0Iy?=
 =?utf-8?B?aHB4ZlFMQ0RFV2tBc01tTG9wRXFqMkdMT01VWEVpeDk2V1YveGdOSzZGdDEz?=
 =?utf-8?B?TThIVEErTmVQNlZFbnhmVkxBaG92TTU4cDBMVWFSalNsYmVzWWlMM1AwYXY5?=
 =?utf-8?B?VmZ6bHBldnhXN0sxVUVUTGJHZWUvcUV3YWZEb2JJVjRaWlA1Z2RCRzRQdFow?=
 =?utf-8?B?MUhhTnFKdHU3ei9laE1XZDcyM2NtcVFMNHFaQTNPOWo4NkF2b0tzZXB1Y2NK?=
 =?utf-8?B?dkFkTWJqN0RLWkx4dDZIVlVhR1cxcEIvSzNGbjhnZzhWWlVvenpPeS93M29z?=
 =?utf-8?B?cnpsZkJLT1E0ODlUMVoyOWZtTFQwVEJzV1o3ajlXWjd4cjQ2cW5SYUhBV3VX?=
 =?utf-8?B?a1FiQk1FaGlwK1BGZEptZmpwbjBPT0VsS05CNjBHTkUxYjhoMk1OQWJQN1JR?=
 =?utf-8?B?ZU0zU1FVeUtWU3VpTFN4M0VzYmRxZnhJUmtMcFhVUmdiL21GNXBFaFZRaFpS?=
 =?utf-8?B?QkdOVEZXbDRMNzcvVklkdEhuZWtOZTVmZE9iT0o0dlc4anZoQ1VTU2FKenRP?=
 =?utf-8?B?SGV6ZXgxVlNYRHI3MkpOaDQ2aFhzaHRLQnAyL2lENk1Zei9NaWMyVFdxUmpz?=
 =?utf-8?B?NUlvS3owMzUvUjJCMUxneko2NWZuZk9nNUpybHdOQ0JwUElwQTRndGpuZGlv?=
 =?utf-8?B?QnFNeVBIelo5SSthL0RLcno5Qnk3K0J1bVhrOC8rYkdOajlxSzdvbm9TTmlo?=
 =?utf-8?B?TDcwR1RreDNnUXlFWEtrZVM0RzgySGlrNE10WDN2SEs4eFZOSVVJUDNhMFpR?=
 =?utf-8?B?Y3BnSmtHZ1JBRkFoMUJ5NVVoaVFZZldNRDBFa0xuVzBqcW5LUGMraWxmd2RK?=
 =?utf-8?B?dytkNWtxYk5MbVBSb2tia3MrR3dsMk9CREc2TzNrRk91S09GVTVOMi93dXRo?=
 =?utf-8?B?cSt0QndWVjl2Y25iQkJScUg5MTREcytHYnYvcWlBZUVwVnZra0Nvc21SUTU4?=
 =?utf-8?B?cUNNYU44dDE4SWNTaE11MCtLaDhKMURHNVZmOE9aNWlPd3dpQkc5ZDFXcEYz?=
 =?utf-8?B?eDM2RlQ4a2pDRldvTlBRNHpNYjl5czVUZld5SGpXVWYrT2VYSGhzTXNhQnA4?=
 =?utf-8?B?Sk5ZSUowVU16RW1XeC9VV1NpQVVIVGJNUHFYVGk3a2pZOWx3TXc3TXlSbUta?=
 =?utf-8?B?dk1NRk5jaGt1OUxoV2RuSUQzTlgrWG5HWmF2OUNSMW1HaHZTcEs2UXdlanZ6?=
 =?utf-8?Q?CWyu03Fe2uylpHjH4cbA2WkZg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6df5fd4-58fa-4a93-2ae0-08dc281f8347
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 20:58:19.2896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V0qL66aMCnTwN+3PD5ILzjdUUfep7V7DuMUXta/POv+FbwYVHHi6zVD9Btl5Z/v2kDLdMw1g2jQy4ENDJjJftQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5214

On 2/6/2024 20:46, Perry Yuan wrote:
> Add quirks table to get CPPC capabilities issue fixed by providing
> correct perf or frequency values while driver loading.
> 
> If CPPC capabilities are not defined in the ACPI tables or wrongly
> defined by platform firmware, it needs to use quick to get those
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
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 57 ++++++++++++++++++++++++++++++++++--
>   include/linux/amd-pstate.h   |  6 ++++
>   2 files changed, 61 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 77effc3caf6c..ff4727c22dce 100644
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
> @@ -111,6 +112,41 @@ static unsigned int epp_values[] = {
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
> +	 * match the broken bios for family 17h processor support CPPC V2
> +	 * broken BIOS lack of nominal_freq and lowest_freq capabilities
> +	 * definition in ACPI tables
> +	 */
> +	if (boot_cpu_has(X86_FEATURE_ZEN2)) {
> +		quirks = dmi->driver_data;
> +		pr_info("Overriding nominal and lowest frequencies for %s\n", dmi->ident);
> +		return 1;
> +	}
> +
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
> @@ -600,13 +636,19 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
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
> @@ -635,12 +677,18 @@ static int amd_get_max_freq(struct amd_cpudata *cpudata)
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
> @@ -1672,6 +1720,11 @@ static int __init amd_pstate_init(void)
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



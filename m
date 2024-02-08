Return-Path: <linux-kernel+bounces-57782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7969684DD64
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0441C268E4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5306F09E;
	Thu,  8 Feb 2024 09:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AQTSSLsH"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEA06F07C;
	Thu,  8 Feb 2024 09:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707386057; cv=fail; b=hKe0Z8MqtwjptUI5Fcv467Zy3ds6LFw2qdkqUbl96llUrbaHfROPAL8BigNveGINZBGJ08vy3qEE0y42lCp635sTTerP71nhuY63naXhp4ucTz9nAoIggM+8DfwKbYUTBE3bFZvNBDHQJTRLcBMpa3ym5oPKj6Sk2Zj+CpjTWP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707386057; c=relaxed/simple;
	bh=fyOywzczBJWWZ0MAvU6OE9X7PK9iy+OPCsKJFH/NQ/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mlKdmK/TeC6nS/Ug7f3sNEKZh2SQ8NH/nULQtmver+IzyPSBlMg4xu3YHkxvT36jusQFoaMvD+f78XOM8o6SgwtQhMSpfHkqByOxn/4ElQ2QU+Thnj0ylT9iNiNQNzyXOkXLvA8thf+E9OrxDzEGDqpAI92M93InIYgtxVGm6UY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AQTSSLsH; arc=fail smtp.client-ip=40.107.92.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKJEY8KcTxzJZqBNEClRqumrifaphX0p02q3v1F2SdWSDH2iKEyhT+BKiLe4LKucAl38Keev5yZf9KBpmdCtl6GX7rxJ0tIFqN96pRA/AAIvFce0S9+ih7a8u+XrtEzRqiaoC3DaQku8mWmbw6eBTb7cOBMLQ7bOaQOkbcFlLduW8iwsDYyj0kEjYKUON8elgMNB5o+DTRZU3ZaYfIwzziUfdGg4g6RXWUpAIOVZ9pQaGHh4AU7a0CW6h9PL0JwmNz1i0mgU13ESH3mzc2swFHHZ3sxm23hgtrCrqgRdu78NqbVRTNnAfyR27NPYj7HVbUhJqK+27Rjg3tjEMB5J8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vkz6DvmLRLQ1FCs7E+hX96lck53sYII2U0FDW94i6BI=;
 b=IrF7zFly15U8V22S/eWkAf5k0qkxC1lrztXsxKBNg7+dg8cimZ6QCMA3iRo1U4RFm84Z5G29JhCKrhLVHlgtOPEhDw1gfe59eU7pfJN65CnAgVQ0Kh1C+By4J9l9ZV6NgHptSnewGC0BKhlNEyVnqc4rhegIKN0lT53KZQ5J5QkC2nSXwRWSwmaR1ygNM7D871hat8fsbE+m8oAu6K+3SgKFQpFmupG/czE/GhWO36U4Qa4fVJkBPuZJMdNMI+//G+HCtyuN5uR5DwZUqDgqtoat0dNfldj2xZ3XLDqtDIn0M/GL6+w2kV2+FlnIzMX9xldE3Y3bnMFHxlMB5lsGBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vkz6DvmLRLQ1FCs7E+hX96lck53sYII2U0FDW94i6BI=;
 b=AQTSSLsHCg2Apuh02UH6YbXit/pw/cALX0tCdvlhpEQO3PTsP9b8gcdqCFVRSr8nLwNvrLEirBHiooGXcyWxFKZLydlwNZ7D6It79TH9dWt6AyX39wdqZBfnTBIop2a7xbLA+7IQVxoJITjygsyJB0Uql13EATIthhFb93OSERQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH8PR12MB6866.namprd12.prod.outlook.com (2603:10b6:510:1c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Thu, 8 Feb
 2024 09:54:10 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::80bf:841d:6c75:64de]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::80bf:841d:6c75:64de%3]) with mapi id 15.20.7270.016; Thu, 8 Feb 2024
 09:54:10 +0000
Date: Thu, 8 Feb 2024 15:23:59 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Perry Yuan <perry.yuan@amd.com>
Cc: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com,
	viresh.kumar@linaro.org, Ray.Huang@amd.com, Borislav.Petkov@amd.com,
	Alexander.Deucher@amd.com, Xinmei.Huang@amd.com,
	Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/6] cpufreq:amd-pstate: add quirk for the pstate CPPC
 capabilities missing
Message-ID: <ZcSkt+bMLkGdLcY8@BLR-5CG11610CF.amd.com>
References: <cover.1707363758.git.perry.yuan@amd.com>
 <f091a19752e21545dabecefb3037b244b344e000.1707363758.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f091a19752e21545dabecefb3037b244b344e000.1707363758.git.perry.yuan@amd.com>
X-ClientProxiedBy: PN3PR01CA0057.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::8) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH8PR12MB6866:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ab4f5eb-02f3-4da8-9c50-08dc288be5d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6MkJ6Jsn45k5PmtyDjzcNOwzUOOOl9WG7N9UZU4snKhkClr7mzQH2/y0HskBp9zmqs1p8XLprRkqxHV8Y/269HHkvS0GOc7BKxKvG6Is4wZ/D4mMDSaP7YRCNjEABiUw9jIZ4UGg6ai7p3xxloXRVSQXiI4bScBeRRaXiKsfS/EZDKaIfW6rJ2RE+nBsBwBZfEkO+u/Xxtn50AqwHSkZmqhJlqwQChmsiHzcC/lsPLN3QQSJEUGDmXxv3kPIuwv0blGDAHuL6cOpGObQFn5qqycEBdNtIxdQc5eAyTZxvfEWUZoxYHT2pp3lqVauWy412QRQXqYyV2FymFt65NLD0JwPBmHwdtFxNsFBNc5oexwuk9+T/KLS2nvFsZtb3R4i0hPSZWOt+be6o4LMIW3jA/x6UAazhVWu2XbhYwMazBTmYgfy4dqxUpP5yD1AHv02hCHQneGdu5d21EI65I3lrXqWscRHOMHfBeWnKjVUh2mzDyiSuIfV58NnBmz+/pL22WK2+w/W7BStpJ4yPBFjD3nbtQ0PSkp0WIYjzkvVpobzA9fM7UmKa/SXtnvo5ZZr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(2906002)(8936002)(66946007)(4326008)(316002)(66556008)(6636002)(6862004)(5660300002)(66476007)(8676002)(86362001)(478600001)(6486002)(6506007)(6512007)(83380400001)(38100700002)(6666004)(26005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sR9xSXaN6afehZC/2fo8VorDh7bywZc+txbKKrmDAtp/JDQJ0FP8L512soPo?=
 =?us-ascii?Q?8F3H6A6KyT3kjnp/c14X9u3bbFMGwn5zgK3aG90gNG2AT/yLvZsx3y3x9FQR?=
 =?us-ascii?Q?QTFycCHdwlEEp/nTCzloKP82xPeTWiXb2rWKioS69czeAu2zf+O9BUCm1hO9?=
 =?us-ascii?Q?8B0S34wNiJLSNUPiuzOzzzG3f8nQq5A5waQmZNAXLEJt9I2sNubGiinCr73b?=
 =?us-ascii?Q?2R9Rj6AzCxzp4SzNW7ns7O6WmZK7Vm8s0eRw/ejvGfdNP+qr5wM9RxIFregM?=
 =?us-ascii?Q?Q1whjzCgZ8Jg7zwfLr0fL3xVoCwJMuWiNqaX4PRCZZi3MY7fotI0DtUPTEB8?=
 =?us-ascii?Q?bMywFUtGi1aD/NxvtCHNTjFIJjHq7ci29HuT6TDLfU6rdKVEqfohvXoriMRP?=
 =?us-ascii?Q?JVv5bhmemRGHvepIVBQUvt6omyzXuPCNWSejhdaYeuRH+LItH+BE+Izl3QQ2?=
 =?us-ascii?Q?khUa8aFKWHlmNCyv+/NuSLaHwayFz6fIT6k7qwA1flwqtT94tuOuF+/hbuAy?=
 =?us-ascii?Q?aDdIj8KIBWVjnXmGGLLA5E/TgPmliJCOI/9tUIXjLhbafGu0zMXMVSodOuNB?=
 =?us-ascii?Q?3ouRbrq/+xM73SD7IwlibCDnr3qGqLvl2k+3MmO4SJd9xn5YtU+JbN2Ltx+1?=
 =?us-ascii?Q?3gqzXEhgsntJ3Ff/aSWKt/Qf9ylt3P/xBsQHqXHqPAniukmBRGLFQWKAG2Yw?=
 =?us-ascii?Q?bWV8bDx5/xsX7edHcgDRWTTCxa3HEcx1zQpijEnYDK7b5Rlnf0c0C6iABYqd?=
 =?us-ascii?Q?xaMBmN2Yz8QN7x948ywFQ/uKxbQPbY+62qFV1NYXSPKgLrWqNdLNkORQgWtB?=
 =?us-ascii?Q?UA51cfnGmDko6IRMBQDKqGIjYb/3phI1/U2zW2D+dZsGXG3Y+FDu50boKbAp?=
 =?us-ascii?Q?Gnd2Y2dIiRZlnLL+5vc/fANVtWtHXVStUBq+i9bjjoJPvy+DNypzRLBuoS1C?=
 =?us-ascii?Q?SKDAepzzD1jT96QyY72QzAzeoQCk2ojdiZVBqJh1Pfa6T/83rgOjwLeES3gY?=
 =?us-ascii?Q?btIpuu3RqJ8Pg9wuhWV08v7H1Y6ntFPSBpJx2bvRgnH/AEtRvvTKeaKlYZc9?=
 =?us-ascii?Q?ymKIaAJIKWpNP9gl4ZewkFajIsaYhG+I6zMdWxPNZZQLrMdUQJjUT6P4sGPx?=
 =?us-ascii?Q?WFCG7eK5hnuJoc+CqHPaRZrl4bXWR+lC0FvvNzr5Lvrxk7J3rJN/7Rq1TVYx?=
 =?us-ascii?Q?iPp3iXdW3DOWkm38+Tw5prZ+/U99nxVSQDvg7onYG7tkdjUfZ9VMFVRJC13O?=
 =?us-ascii?Q?wYuZIe1Z+aJnGCMMm/zEeNGR3tGRqrqmYxuFtxw6ArimRYzCfkVjGS9Tb7zs?=
 =?us-ascii?Q?R4XPwUBfs6gWM6t0MqA20J8XRwgSQrPMYESKj06DQC23ri0DA/N5TRCAmG+9?=
 =?us-ascii?Q?8vFpuPYjyYg6hnjHAg6cw6bo7v+Ta0PBjZ/fe0mKMfPECTrTC12dsbxu9dxT?=
 =?us-ascii?Q?aI92MgTLmkm2t7h9r3+ci5jxzLGi1DaKQpQD0s3WAbEn2i5diqhL/Zc6k4Gl?=
 =?us-ascii?Q?c4mZBrB0J4orKsY6Pgqiy61VWxX1HTT+beATDpuxrrDtC20GG5PYaF3MkLlw?=
 =?us-ascii?Q?VJVgIZ96fvur5JBetG7bJ24/DX5wU+gA0kXonoEy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab4f5eb-02f3-4da8-9c50-08dc288be5d4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 09:54:10.5696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: blT1Yu7tOZserraE6h2yDri3kpS6kU1vLQgo6L+MJqkKvBzvNGIZs1Zc78H5Nw630HF9iDNh/ZlmTKASvFuryg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6866

On Thu, Feb 08, 2024 at 11:46:33AM +0800, Perry Yuan wrote:
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

I am ok with this patch as it makes the nominal and min frequency
values explicit for older BIOSes which do support CPPC but only v2.

However, it can be noted that even those older BIOSes are likely to
have the ACPI _PSS data. From this we can look into the P0 frequency,
which could be used as a stand-in for the nominal frequency (We
already do that in acpi_cpufreq_cpu_init() while computing the maximum
frequency). All the other frequencies can be computed in relation to
that.


Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
--
Thanks and Regards
gautham.

> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 57 ++++++++++++++++++++++++++++++++++--
>  include/linux/amd-pstate.h   |  6 ++++
>  2 files changed, 61 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 77effc3caf6c..ff4727c22dce 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -67,6 +67,7 @@ static struct cpufreq_driver amd_pstate_epp_driver;
>  static int cppc_state = AMD_PSTATE_UNDEFINED;
>  static bool cppc_enabled;
>  static bool amd_pstate_prefcore = true;
> +static struct quirk_entry *quirks;
>  
>  /*
>   * AMD Energy Preference Performance (EPP)
> @@ -111,6 +112,41 @@ static unsigned int epp_values[] = {
>  
>  typedef int (*cppc_mode_transition_fn)(int);
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
>  static inline int get_mode_idx_from_str(const char *str, size_t size)
>  {
>  	int i;
> @@ -600,13 +636,19 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>  static int amd_get_min_freq(struct amd_cpudata *cpudata)
>  {
>  	struct cppc_perf_caps cppc_perf;
> +	u32 lowest_freq;
>  
>  	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>  	if (ret)
>  		return ret;
>  
> +	if (quirks && quirks->lowest_freq)
> +		lowest_freq = quirks->lowest_freq;
> +	else
> +		lowest_freq = cppc_perf.lowest_freq;
> +
>  	/* Switch to khz */
> -	return cppc_perf.lowest_freq * 1000;
> +	return lowest_freq * 1000;
>  }
>  
>  static int amd_get_max_freq(struct amd_cpudata *cpudata)
> @@ -635,12 +677,18 @@ static int amd_get_max_freq(struct amd_cpudata *cpudata)
>  static int amd_get_nominal_freq(struct amd_cpudata *cpudata)
>  {
>  	struct cppc_perf_caps cppc_perf;
> +	u32 nominal_freq;
>  
>  	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>  	if (ret)
>  		return ret;
>  
> -	return cppc_perf.nominal_freq;
> +	if (quirks && quirks->nominal_freq)
> +		nominal_freq = quirks->nominal_freq;
> +	else
> +		nominal_freq = cppc_perf.nominal_freq;
> +
> +	return nominal_freq;
>  }
>  
>  static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
> @@ -1672,6 +1720,11 @@ static int __init amd_pstate_init(void)
>  	if (cpufreq_get_current_driver())
>  		return -EEXIST;
>  
> +	quirks = NULL;
> +
> +	/* check if this machine need CPPC quirks */
> +	dmi_check_system(amd_pstate_quirks_table);
> +
>  	switch (cppc_state) {
>  	case AMD_PSTATE_UNDEFINED:
>  		/* Disable on the following configs by default:
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index d21838835abd..7b2cbb892fd9 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -124,4 +124,10 @@ static const char * const amd_pstate_mode_string[] = {
>  	[AMD_PSTATE_GUIDED]      = "guided",
>  	NULL,
>  };
> +
> +struct quirk_entry {
> +	u32 nominal_freq;
> +	u32 lowest_freq;
> +};
> +
>  #endif /* _LINUX_AMD_PSTATE_H */
> -- 
> 2.34.1
> 


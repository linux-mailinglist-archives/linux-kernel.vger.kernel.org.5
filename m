Return-Path: <linux-kernel+bounces-108859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C08881103
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC2B71F21DD4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA083EA64;
	Wed, 20 Mar 2024 11:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BhLT9UaF"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D453D995;
	Wed, 20 Mar 2024 11:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710934352; cv=fail; b=ST/YiACaNNcImUsJlSLiEadXl062dEAuBQ5jnQyKq9LZ/kj7GP8aql0b8y3DsjIMNuslJzcR6d/GMcFgOVj2JDeXIn1HGvC2HNfsTEMpATvhOKUyF6ekGpI+3qA00NnZZgFr7UUH1dlAP8qXrveJA32RuP7oClABMWaVfjn7ais=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710934352; c=relaxed/simple;
	bh=HtRaMtsVeiEqVGPvyWIcfRWwVH+Tx/4Jg0H1W9lvrnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qyqSaZzPjrgeP4pLBJIvFJJYu07QlqYusm8/fazoy/u3eP5A87DlG8eGN4XgLIzHtIVY9zPZAd6MB9Ar+PjQSrsgOSIGA77H440+Or7+N69CE825omIQbZAetrWrH0Pbm+7SzmfKTyTDz5UBioHP3tw8FjqLLelSuVcn3+E4IrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BhLT9UaF; arc=fail smtp.client-ip=40.107.94.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpWIG7UtuAw+Vaz1/DkFqkfJsvSawp/CntiFRUaA59M+rbzfbvOm41zSx6MaM5ZFyAACmYSBJd2UL843RACRNblkgpMuPIWnHatGW1BqUA7MlS+j+AeFPoamSP57ZpciW2UWtMZG/EpEiZmLg89ugq3EBQxoG1XWv4q2mmS38/f+627XrqyI4VjbAJweg1aCfy2OFqABvmH7IfdD9ZoJNcR8tX23wJgI4zbM1pyRHzJ2ODINH9CodnzZulpONDPQ8RyU+XU+PZytpuwgZQRMSH1XC5mmxljKhYELOuJ1j2+Gp+hdG+p8eoTPIy6XYgEc4CL9rWCbTH20DySvZYKk2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Sko9nWyIv2iq8QErvZ7LyTgzKDZoVRooGGAFzTZ/oI=;
 b=SSLuGPEG0uvRF1DM7D4vrfOmVyxvoOcxukOjRI1Y83yEsZIW1sF6sb6w6gNh02H8sENU1khWK5Dt1sd7yb782YR0fSUhua1rfTUVZrYBKg0MvxeI7vPVOPJjmrpmJqaFFsA2FwbOmbDk9me2BpoRNygyvV/nziG7cXvDjPGXYVxZ7eIZHnIRkfVOPBDZv1fa3IR8Ba/NGsrmIZsvmx01BucBMFAobuiw8VdnPsk2mWW4NsxVWSiuFfmM38SgN+UhFBhlNgnHOYST8tqxwQP1VpDxMhDRWf+fB4H0ZTdbc95uCvGX/NiSVXZpoJPcFyO60neDiqdx7GVnugwXT0lUTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Sko9nWyIv2iq8QErvZ7LyTgzKDZoVRooGGAFzTZ/oI=;
 b=BhLT9UaFm5ICI8OhM699m9dld5YqQKbOvrk8E8IxZEfgiHz0RlCgmuOWeBog02cLmgGQTiI6+IBzAn8v7y9AvgZ/dRm+5tb4AL5h2KM6lxilBrMD99WSfl0craB7/nxn2GztJ3gVOj8W0rSW2enqEqaaWQ2Wlv0+InCz8NKNqoQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 IA1PR12MB9032.namprd12.prod.outlook.com (2603:10b6:208:3f3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Wed, 20 Mar
 2024 11:32:28 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::d725:ec0f:5755:769b]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::d725:ec0f:5755:769b%3]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 11:32:28 +0000
Date: Wed, 20 Mar 2024 17:02:16 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Perry Yuan <perry.yuan@amd.com>
Cc: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com,
	viresh.kumar@linaro.org, Ray.Huang@amd.com, Borislav.Petkov@amd.com,
	Alexander.Deucher@amd.com, Xinmei.Huang@amd.com,
	oleksandr@natalenko.name, Xiaojian.Du@amd.com, Li.Meng@amd.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/6] cpufreq: amd-pstate: initialize new core
 precision boost state
Message-ID: <ZfrJQF4z9i/yj1bp@BLR-5CG11610CF.amd.com>
References: <cover.1710754236.git.perry.yuan@amd.com>
 <f43f48b02d42a651028f0c4690caa6e953e8bf45.1710754236.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f43f48b02d42a651028f0c4690caa6e953e8bf45.1710754236.git.perry.yuan@amd.com>
X-ClientProxiedBy: PN3PR01CA0183.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::8) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|IA1PR12MB9032:EE_
X-MS-Office365-Filtering-Correlation-Id: 90088bf6-7f15-46cd-4e93-08dc48d16c22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ak0/31AHD91dvANefzBvuUvvXDRgRg84WbD04MsDFvlo3GXJhEA37nSwBZZbkivTiGXA3s12eQEYc1JNmIKeEWEnvyGI1O2pC6e8Vpp/a2gJGw3oCTfceRiz9S6qqJzxcLCexK03QrP2x1eD2THB8xqJmjVfX0m8X/+i5Aw0qeKwfZ16/FkW8n0o/t17b9cX5CO0VsyvPNCNw2GFaNHg2GW+AxSTbQNKpz3O5p9EXdrDN9AyAh2XlZ4547yxf4WUkKuOjA49cxLjIJHys1dX3fzyg5z4t7fQi7TY2997GFJqsmZZeoJmYFFsSI+718Od9ioQC69YHj3GZk498Tq35UWfvtN37qjNjKM9hbMYwr6iefdUr1dYentRxTjxZXgwJiyk3Q8osXrcpNgNSFaazGxt0zwqjFNdssWqkmrcMmqQFOxFpKuA+WnbEslJ7FrnkfExkhQJ9DRC1D28VWgRyIkBoa1bYKiVtmYYdbcRGDv71iIltSR+l+Lxjpin3J7AxMvuvjjVmngIjCb+Px6QdJJ7RMP8rvSArhbk6mCakDPj51JpufKaNpcdgNNBWp5ZJeCwlyGqJfzoS90WC8pEoduB/F24MsQScwOEG02AL/M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zy0CKkO0A6Gq7funjKcjfl84UEE7fU/dB0NOuAEEILoDr1cpptfJDra+3wv9?=
 =?us-ascii?Q?aWS343MOmK37ipmkxZPMUF+a8f9AKy7F4dWw9+yNfb757tBOL0beNYSrhScb?=
 =?us-ascii?Q?gIzKZri00bSM/7x6V/t7RalqIUAqezs7LGzzG6CtrRL/d1gpJQXPpJ3HdsQR?=
 =?us-ascii?Q?CW1J4mK+wyMNF5FUMXFi394ImhKdU/geiwYndHtu/ytT0urddKfec6IPOWnK?=
 =?us-ascii?Q?mjit2Q4HrHsNi/uTfciTzcgraHYLTbqY1htXkl6mrwOcEsxjvLbxoTxalAQw?=
 =?us-ascii?Q?smCmFy0+Od43rbjys9BGh1dndyM8ROfMrqiLO90DYEhckTZ0bPCqkjZKSdiM?=
 =?us-ascii?Q?hx8zv+t0rcsmrWdZrG1wwCRUMwEcwdCdewmSUt7fqjG50ExDmODJBPxB/YMN?=
 =?us-ascii?Q?bbOsVZorvGH3JTKX20LdZYuBPlbHTyuWtHQFYldjFUQpvPsi61lGFjSYP7YC?=
 =?us-ascii?Q?WUwxmIcv+6e8qw9TWEE0+C5T71jOWaNX1twvxUAqMPHvo7iC40mRGVUcSAi8?=
 =?us-ascii?Q?qzhIfKc7Z+4BMqR3V6gibzEJGnOf81RIzXXCl4pmON9b6fLhknfM4AkRxbMA?=
 =?us-ascii?Q?Ol6kYiJ8grfsT4wwFb/UVSActVBb1+9zA+FnEr0bH87ghpVYDQYX5qVa0Ced?=
 =?us-ascii?Q?6lPBPNfqkLvVGmil8iJr7DfPnjwJzlU5ZulYan0s7MPm9S2q2H5KYKLPHOFK?=
 =?us-ascii?Q?Z2F6Ds8lq2mbk3X9vndZj3aIyaa9XN2N3HUjE6dtejN4uPhCEq6TtvZe0YtY?=
 =?us-ascii?Q?qEUbSxRzP3t5v5HfW4xFQaa38RIYFz2XSptcl63+GQgqTdUd1n967o4SDVnH?=
 =?us-ascii?Q?SIrGPwFLPTO/z4zCnopO7h/JbTSpsOMXR2MJxcvx5uF7aFEEacfjUS/s1DJX?=
 =?us-ascii?Q?aTir7/iYcn/xAEU9OUwdmyUpZodL9RKbxOafSXWOX9tNnSrwEjpRZsv7+DZE?=
 =?us-ascii?Q?/MtU8o/w7qUQnCvV7P51gbJq114GgLs5Qh+kOj6rimT4B5eQ1p7aftpOUiG8?=
 =?us-ascii?Q?dASsUvA6JdVJ7cZ/DDXzNfim9bh+nqjm3KbIZYCxUTQdFkXF3mVKI1t6FEo+?=
 =?us-ascii?Q?/9ezQeMwNIEwZk/GtpNIHJ6X+B0rK3MBtbdjpCk9t0M7V+hvxKF9yDyQ0mEl?=
 =?us-ascii?Q?YZwlzcP0pskuOHjX0FdzDCBgQv5OlKANn2ro7rH8Krw4WxwavU+TZzosq9SB?=
 =?us-ascii?Q?Hn/RjF7+COtktuARvU7ROkiJAO+53Rc0aFU+xeQea3qwzC69LAgoHpU6vv3K?=
 =?us-ascii?Q?ST0ojg3iF1cninvRcu37tcx4OhQQrdIKzommwpO8/LPNST1YocH2zZaZ3Jx0?=
 =?us-ascii?Q?KsiSP05aa/4wBMATgyGVHvNhuopNSmVM7Pg9jX5mD+CQ8a6eMCzHpCCm8tYS?=
 =?us-ascii?Q?sRWSOCII8dwnHqaTyfv7/jZCArSKhMQSUA1NiSMtSZXsbX9PWWQRyzYSBHfy?=
 =?us-ascii?Q?SwD6ViCeny6Jk6KLP7RUQB+erMixFn/mR1gfh9vg3jmi1hrIXN7ipRvsenyk?=
 =?us-ascii?Q?zMZvPT0P+xRyN6PLFyOH70HUlaAwn52W4jKJeZp97HqaB3YY9xe+uKNgG/dw?=
 =?us-ascii?Q?evGQfQ8CTTuChNOen3pR85wmx+Q3PBpS9Cr8R/GF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90088bf6-7f15-46cd-4e93-08dc48d16c22
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 11:32:28.0996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GC+u7afqAK4tPVCAjvPbOVFARp4Sk4A3Wq54uEZOOoINN2LdrIU47eGeeqImc3LIl1UYxWJPk+13fhJTVpFtAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9032

Hello Perry,

On Mon, Mar 18, 2024 at 06:11:09PM +0800, Perry Yuan wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> Add gloal global_params to represent current CPU Performance Boost(cpb)
      ^^^^^^
      global ? 

> state for cpu frequency scaling, both active and passive modes all can
> support CPU cores frequency boosting control which is based on the BIOS
> setting, while BIOS turn on the "Core Performance Boost", it will
> allow OS control each core highest perf limitation from OS side.

Could we reword this portion along the lines of the following:

"The active, guided and passive modes of the amd-pstate driver can
support frequency boost control when the "Core Performance Boost"
(CPB) feature is enabled in the BIOS.  When enabled in BIOS, the user
has an option at runtime to allow/disallow the cores from operating in
the boost frequency range.

Add an amd_pstate_global_params object to record whether CPB is
enabled in BIOS, and if it has been activated by the user."

> 
> If core performance boost is disabled while a core is in a boosted P-state,
> the core transitions to the highest performance non-boosted P-state,
> that is the same as the nominal frequency limit.

> 
> Reported-by: Artem S. Tashkinov" <aros@gmx.com>
> Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217931
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 39 +++++++++++++++++++++++++++---------
>  include/linux/amd-pstate.h   | 13 ++++++++++++
>  2 files changed, 42 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 59a2db225d98..81787f83c906 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -68,6 +68,8 @@ static int cppc_state = AMD_PSTATE_UNDEFINED;
>  static bool cppc_enabled;
>  static bool amd_pstate_prefcore = true;
>  static struct quirk_entry *quirks;
> +struct amd_pstate_global_params amd_pstate_global_params;
> +EXPORT_SYMBOL_GPL(amd_pstate_global_params);
>  
>  /*
>   * AMD Energy Preference Performance (EPP)

[..snip..]

> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index 6b832153a126..c5e41de65f70 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -134,4 +134,17 @@ struct quirk_entry {
>  	u32 lowest_freq;
>  };
>  
> +/**
> + * struct amd_pstate_global_params - Global parameters, mostly tunable via sysfs.
> + * @cpb_boost:		Whether or not to use boost CPU P-states.
> + * @cpb_supported:	Whether or not CPU boost P-states are available
> + *			based on the MSR_K7_HWCR bit[25] state
> + */
> +struct amd_pstate_global_params {
> +	bool cpb_boost;
> +	bool cpb_supported;
> +};
> +
> +extern struct amd_pstate_global_params amd_pstate_global_params;

Will this be used in multiple files ? If no, it is better to define
this in amd-pstate.c

Otherwise, I have no other issues with the patch.

--
Thanks and Regards
gautham.


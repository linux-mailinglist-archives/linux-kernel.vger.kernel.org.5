Return-Path: <linux-kernel+bounces-144454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE728A469A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 03:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE51FB20D54
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 01:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D5CD29E;
	Mon, 15 Apr 2024 01:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tsyY0Xar"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9BA4A24;
	Mon, 15 Apr 2024 01:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713145164; cv=fail; b=HfT0qtEJ7Q8ju4y1AsLSdvi8yho1L3F14LpuaA77tnyBSYuerMi9PbUhqpqq1u7I0Ep0L4Y/q1adjHPzG5CIR3NBKXMLY4rZ9sHAYgPcyFiNUayrjAcn5vPTdB9w06oNTEofXVatphZwVO6WMwTCSoH/++b/dMSUlycH2EISBEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713145164; c=relaxed/simple;
	bh=sWjUQv9nMPt1eH/AqUcQ9PoVU1YXrubpCfjISlxBmgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ouu4oBZdVv6LGhdU2LpIVNvpWVbDRfDz9ARX346ihRKmMryDRDTyqLu+oR+4dRmzzSYrDga60s+yktWwwjifb6BtoZ8fUA3A4Za5q5ztS5cecsf8+WQezNoDhKwlx8KTCS+wIdXLnY5zQfAJnqzjERDdf5i9lvZH36R/phpapss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tsyY0Xar; arc=fail smtp.client-ip=40.107.92.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Js4BdayIV8cNmmw3OYB8yHlcpJMs6GTnZl9fcgXa3KchVYkfOIAvCnQ8ug64nsBW7/CMKdIr1v+xJ0z2m9pTP5KeAtHGowaJETqUC8mF5EMeF/QASZv2+JxUjfYFsbxHbipp2AJVsLe1GUZ/0f+p6bHljCQyYi3akPWlGccsjdzpt5T7RlfItBqrXqDACj7ktbzzwyNJhi1sU+7Ez44WjRogTOhv2hTKY+GIvEoML6HAX/r4pqsJmvxd6IFURnjngrTbstKqjSIbqQqqIkxhDMBmYvbCAKTJow5llTVWIFQCKzLRti5xkCRa2p89GDLRJHZ47kynVoWqNzjK8ePi3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVJCBLUkeqZj/vAvNvAotM7q7KnVww5+PZmXzb7qpX8=;
 b=Uhxk0km1I+kUrJx8EzrWObSpxj6V9ybjtD1kwdh/TiIsbzLlgM3X8uBDCx+wdzi7NO5uxKcR/VsEoTkkPXcl9ehZVlEkhWlKfZWxz/QrbuRsJnTLcDiOLf7wCO9TXMVPbH1473/TFOuUDQulaqp+gxSlCvzYZqNiYvyIy9G8WlAscIveEfCJcnMxGFTj5G3Q7+bNLBomDgMNGMXC6LhkUwvN0LvyHqFYWkXocgjb1T188FYJs9pqN4GZgUJyGnhcUVVl8hKMhZWFJXYKyriiSnNGwWupX3Y54aWfLIX+E/jW9ljDn/ACrUU6o9iaoaMoRyizO5Mmb69ckvkxg7EynA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVJCBLUkeqZj/vAvNvAotM7q7KnVww5+PZmXzb7qpX8=;
 b=tsyY0XarKkOdgLh/Hikoug2W7ne65BhX+HPeth9vlxzOZrYikggfNmIJUTkYXhq9SEBDsAXaejQeF0NZGUbFr9qTWMSDwRn/3qY+TzJdUwoJsYqTC8N986lxZmJ6HgvLCfcA9kPEp5V2QJUnPwIVjVxTmzIsFhRpC/2tCLZXngY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by SJ1PR12MB6028.namprd12.prod.outlook.com (2603:10b6:a03:489::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 15 Apr
 2024 01:39:19 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::e7a:5022:4b7d:ade1]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::e7a:5022:4b7d:ade1%7]) with mapi id 15.20.7409.042; Mon, 15 Apr 2024
 01:39:19 +0000
Date: Mon, 15 Apr 2024 09:38:58 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Yuan, Perry" <Perry.Yuan@amd.com>
Cc: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	"Petkov, Borislav" <Borislav.Petkov@amd.com>,
	"Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Huang, Shimmer" <Shimmer.Huang@amd.com>,
	"oleksandr@natalenko.name" <oleksandr@natalenko.name>,
	"Du, Xiaojian" <Xiaojian.Du@amd.com>,
	"Meng, Li (Jassmine)" <Li.Meng@amd.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 2/8] cpufreq: amd-pstate: Document the units for freq
 variables in amd_cpudata
Message-ID: <ZhyFMiYffSEBcJKi@amd.com>
References: <cover.1711335714.git.perry.yuan@amd.com>
 <87c6aeb265a0281b3abebd07ba2069d80da21944.1711335714.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87c6aeb265a0281b3abebd07ba2069d80da21944.1711335714.git.perry.yuan@amd.com>
X-ClientProxiedBy: SG2P153CA0027.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::14)
 To SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|SJ1PR12MB6028:EE_
X-MS-Office365-Filtering-Correlation-Id: 034dbc8b-55da-4630-dc43-08dc5cecde43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3bbc4WHuifo8TUJMtr15vvotkp5hDLgb8tBpvGq7JYGgjQ62SDzpov0zqbdyrdzxIuh2ZCpzxCnHswXBa3e0iWFmzUE/VtuZwwCPyhUkz+E7inB0I3IEIdQA1azXzsxTiYBDDiHhgNCsjme4rLTaSUDPMD0/SHcigymZEaIJbqDXLVSO8buCeDul6Ea580v+dFGoq+cKs9m39/cfhpl2sNsozYLKeXJmTshYfB9cArbcBj4z0R1fRlBhPfZlNSbB6c5jKfM1jMT4oVVy5Yx4LqPZDfvtpPZLOYZ5uNokmo0p9GlVMITcMEQXWzfQUrSh5ixE+ao/u3bCWue/liw23c96XnTxKFxWItGEMEE51FfSragKjgrqGgTaSAlHUpzMqEIuoKDINDsFQk3AcO5lnObZbkQgR4LZXL/8P1vw6ioDM9auTTcL5DylIPGakvElz5OLH94IIcMi6A0E2L9sLgLdisbmgvYUMgyZMiR2exPuMQPSnNG9ht1prhRHtG9cGIbC+fgrsoI9NKQrmNtz1OPfokiqGZ+ob9UldQ6j04qsrxHCmzIJKgxENgH+RmuwTKcxfzWM0LuT9YpLAeR5QnPyEpSZejizw9y0uaZuNju6xFeqsX8cPf8JADlUeY4i6YR4saqdACp+g1LrnfRBpD8c0CaqWWCsD6d8Qr3zR4c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8690.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kxWM+Dsb4VoCsHRsjOYgzy0+pcd8ioZVKvSAdI8oyDtFrv8rpeEce269qak+?=
 =?us-ascii?Q?1lCsq74YN9Z4eF+cn2OVsurNF8+TyEP9NdswOm6Wszw+TsVlXx2ePB/6Ws9i?=
 =?us-ascii?Q?KhSOTzT6ebneUQ1djT1BSRpcGNOKV7Gf8pC/DOvWW/yQCOGFzJYD2Vhx6eEX?=
 =?us-ascii?Q?EYW5D+BKuuQmP+/0tlBGB2oAIws0dGNOBDboPv127wXChDFWx3wuIeUUylMv?=
 =?us-ascii?Q?ZYq8xi33Iktz5pYRUJI+lBxEHkJpXVecoycEWqQ4qkxxgTlSPNXRps9g+gQ1?=
 =?us-ascii?Q?kp/gqWTmsqT5JNrM2h9u5PAt5wyNVgA7jPqyk3O4lZnR9b9K4xCSYNJfphlf?=
 =?us-ascii?Q?aLSjzl+8s4/uzCbYK42tw9AGZtXkn3RkmhjvyOWm6knX+ARXBVr2unCCljSC?=
 =?us-ascii?Q?ygLC8vjHfI0aOOBrC49UHmcHRt3ywnZOsZMrEAKEqGyXinfFaBWeKtF3qlYQ?=
 =?us-ascii?Q?L+qVezeyuIds+dQrxbzKEuLiRJpOMZNf2IIWyFZawRzU1ESeR1CPhm5RwMSx?=
 =?us-ascii?Q?ATz478gF6oeE9bPZr3t4mbp11vjg4Z4PwoLZ/MmcbRlwmA3PLL1hjaBrlaO0?=
 =?us-ascii?Q?E6D0d/6NwsOWltAm7WHYEZDLaVvuGcA3aX+wo6wlJtkrdB+lN+qQLadgPPAU?=
 =?us-ascii?Q?LmXdSZQYrE1KcmaAzUGQ5j9wvvt3WoNQIwFX20afz+ZsPvq0pwznLh5pGNfD?=
 =?us-ascii?Q?8nTlfx0n9xGTYMzBxZFQPlGTlqaWG33JzUJDOTaz7ls9RwHlu+J+UBSJ0gW6?=
 =?us-ascii?Q?k2u2nyQfmc9CfSXbP9JcZh9AQX84V2Bcfqq3ViTDSvhymqStftGsNXwiEJzK?=
 =?us-ascii?Q?vDmNMzDjm5v/3o8Md62WXgx9WdWsnbXT6/MdNTWWdKK5Ss9jg3FJC4gEcvdT?=
 =?us-ascii?Q?J1jyIX30vPJG5vzIXamDerXUsJhrSiwN1KZeRTfCKjXr/e6HqJc70hcPlmqo?=
 =?us-ascii?Q?vcvkKYdnxUx0JF0omFl+4302MnNa4eCG/uP42YTk312F4o0nnw/VpBSPui3Q?=
 =?us-ascii?Q?Qzgw7Lp8O2G9A7dbXpqfALY+43EDwGHmo3zCa0tWa6KVNJ5+AogQ+8fJYcIp?=
 =?us-ascii?Q?1wYtbSSeFnuzMU8thYsic94wBamD8Ps7TCosujqxy5ubYszjIBFxfaEkcSpp?=
 =?us-ascii?Q?L+1XBerkgv5wniqk/3pGz+vWwJ7U8OrqYFjAumL9jw5+8tLmmWS/9/pMLy6f?=
 =?us-ascii?Q?KB0ftffcFlPunPLCVfJMOLgojF/fVSrv7fIs19wG9NEDfLqL92TB/n/zocnU?=
 =?us-ascii?Q?+0DOjaurMpgeij0dQyKK+6IqVFdP4oKtfhqBMkT9j2RiAdCmIUFqsSTdleZV?=
 =?us-ascii?Q?vwdpg06rwHrF0+78ondDUQw9IUxU972MjoHfLYTWv/z4OXESOkebWWWNeSs8?=
 =?us-ascii?Q?1G9dRlXwM1fsdRn9JRMB2I+LrNAzGEww7A5zkVWY72riB/OVl+Qrux5/SpHM?=
 =?us-ascii?Q?JJFEkMZpP4lz8Y0zlknrEXQ2ei7f1E68XuwmoiGwNbotwe7qwjF5u6RZ/xUw?=
 =?us-ascii?Q?z5PRK6X2pWnDhCQ7J4/vLDbD45WFU1wVJQFKvX7gQWx/4IduA5twCdsUL52F?=
 =?us-ascii?Q?Xdr2oK/kJN3pcywZbD1rZilio2xTaS+v3Yb8pWjx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 034dbc8b-55da-4630-dc43-08dc5cecde43
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 01:39:19.2369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sNs1lfjdfaGFbJfF+AFRT0bZPcQLKuZJuj3KI5yq0MPoLKtwngkl8ndf13V9lPMPJwbqZFjppQhasvr1T7FSsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6028

On Mon, Mar 25, 2024 at 11:03:22AM +0800, Yuan, Perry wrote:
> From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
> 
> The min_limit_freq, max_limit_freq, min_freq, max_freq, nominal_freq
> and the lowest_nominal_freq members of struct cpudata store the
> frequency value in khz to be consistent with the cpufreq
> core. Update the comment to document this.
> 
> Reviewed-by: Li Meng <li.meng@amd.com>
> Tested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---

Acked-by: Huang Rui <ray.huang@amd.com>

>  include/linux/amd-pstate.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index 212f377d615b..ab7e82533718 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -51,15 +51,15 @@ struct amd_aperf_mperf {
>   * 		  priority.
>   * @min_limit_perf: Cached value of the perf corresponding to policy->min
>   * @max_limit_perf: Cached value of the perf corresponding to policy->max
> - * @min_limit_freq: Cached value of policy->min
> - * @max_limit_freq: Cached value of policy->max
> - * @max_freq: the frequency that mapped to highest_perf
> - * @min_freq: the frequency that mapped to lowest_perf
> - * @nominal_freq: the frequency that mapped to nominal_perf
> - * @lowest_nonlinear_freq: the frequency that mapped to lowest_nonlinear_perf
> + * @min_limit_freq: Cached value of policy->min (in khz)
> + * @max_limit_freq: Cached value of policy->max (in khz)
> + * @max_freq: the frequency (in khz) that mapped to highest_perf
> + * @min_freq: the frequency (in khz) that mapped to lowest_perf
> + * @nominal_freq: the frequency (in khz) that mapped to nominal_perf
> + * @lowest_nonlinear_freq: the frequency (in khz) that mapped to lowest_nonlinear_perf
>   * @cur: Difference of Aperf/Mperf/tsc count between last and current sample
>   * @prev: Last Aperf/Mperf/tsc count value read from register
> - * @freq: current cpu frequency value
> + * @freq: current cpu frequency value (in khz)
>   * @boost_supported: check whether the Processor or SBIOS supports boost mode
>   * @hw_prefcore: check whether HW supports preferred core featue.
>   * 		  Only when hw_prefcore and early prefcore param are true,
> -- 
> 2.34.1
> 


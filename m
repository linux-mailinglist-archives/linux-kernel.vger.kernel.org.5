Return-Path: <linux-kernel+bounces-154924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F1F8AE317
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E470B22B35
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FF1612EB;
	Tue, 23 Apr 2024 10:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bfheesVl"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69D164CEC;
	Tue, 23 Apr 2024 10:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713869537; cv=fail; b=CvobZ+A9pngVnQHXDRv9JmF9URXa7JVcklov2l/baKdGXhPbz96nO+7BayZMT7TJKbpWIVYCZ4IOZ1jwn0r+ST7LKtaLnv9KmWP7MssuMzqZtzxg/au6dcsnDMlz3T2TdxdkgVNkOIqUQLEduHgSRiUk0R325JYE2KAdvbMf3NQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713869537; c=relaxed/simple;
	bh=D+8JtQALm7hpsSkirBQqgIlAFe/RjHocykU2Yi2Oabk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uOukvO0xhFkIK5AGxrALoKNBwTT/l/cG3qwU4w7qznNY1xH2ydFY/3BKrA1KnWE58CjYXYJYMYgOj3uMwwcxQtIi9FcGlrd6RDoL4R5Z9TVm8wSMxA1V+1jyZsWUqdxXx18OvqfNPEOhgPDObyBFTaVFxMa5wmZLUXyHvAfiqMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bfheesVl; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Da9nsL9StenoGJq4EPuKQH9aZeTei2G7Do3r+H6F2jqC9pcKz4M6cOTk0JHEqQlTKav1oKJ5b9LkC7e9p5mcB53NzOGlsGw+vsIVuYvxaBvnlnSSZkxYSTQSXwtwFhmPoIDWzJso1R3rJ73kbZtriPuqTyY67iS92uNlkekZdJKn4NiJZQF42lmu29eKNymAIG4Njti9mrP6Z2yjX1sJsCnOl8ICHjYUcLdLioGFCFZYn2EtFQB3zIgO2FoMKwQYlywIq6wjaWVCuBwUcx1wiHQPa5Q3ORUtsAWPndbE3VHjg+I4h6wVNS/5fwu+E6iXjXy30efhIcKYF9/GQ5rkQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/CV0Ai1zHgp6wyYqoPnyF8G9I4FfCInpQcuFRc9bJo=;
 b=KumdlgreSLnRHzIR39xYRGO7vJAyxIlucW0KyYqn1DijzN5rQiIpHhbsY3HGs2g+Vy+Poi3bUgldAaCGyfEDKEaDqZKcDvGS9nL5uktZgo5cgxRB0UGJNSAZMikcJ16VlxxTHgXfmqvQ2b8MN6D1SLr0P8BWy224VxdgbgLRy66tgniqWw6qXBfqu2SfRlkoqZ/UEP1Zp4fXnzusqHKmVHrxgdVE8eh089BeByDkENWpNd9Djx0JEAx1393APznXpKzFaU4NXirH10qdcPMl2HdtP+1AeaKmYinSnSnCUTxtf/5i9O6t+YFDyaZnDCJ8RGIcQuhagPy2wlWpqI5gGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/CV0Ai1zHgp6wyYqoPnyF8G9I4FfCInpQcuFRc9bJo=;
 b=bfheesVlK4oTGLuTM2bs1hwacAnno7/UjcTXjYt4eoewUgg9XsLxqSBqFKEsmXRQghtKITSxy3vvpgzv9DQHPOVWH1ZMOGqkurHbNx/b5x5puUC36Va7ND1Cc2rVDtlesHOzn8dakHYEp18gR5wZ5Cjrj0deJlnwPZwTQBDG7Zk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by PH7PR12MB5806.namprd12.prod.outlook.com (2603:10b6:510:1d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 10:52:13 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::966e:5ccf:b22b:d972]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::966e:5ccf:b22b:d972%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 10:52:13 +0000
Date: Tue, 23 Apr 2024 18:51:52 +0800
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
Subject: Re: [PATCH v7 2/6] cpufreq: amd-pstate: initialize new core
 precision boost state
Message-ID: <ZieSyM1h6lA8fCwO@amd.com>
References: <cover.1713861200.git.perry.yuan@amd.com>
 <5754a2e7a93a048431fa7a745582e62ba67df4e9.1713861200.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5754a2e7a93a048431fa7a745582e62ba67df4e9.1713861200.git.perry.yuan@amd.com>
X-ClientProxiedBy: SG2PR03CA0090.apcprd03.prod.outlook.com
 (2603:1096:4:7c::18) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|PH7PR12MB5806:EE_
X-MS-Office365-Filtering-Correlation-Id: 2129bc32-2e36-4d4d-6ce2-08dc63836ed1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cRRdulz95+lJUElrkNDQtvHSVn5H5FcEdb1MCHBOetfCOoTIc7bYeu2vO14U?=
 =?us-ascii?Q?NhbnNapUNVE+5vDpvkgzr+O7r1Db8WsOb7JkwJfD/JoKj+dghe/a2agG+aVN?=
 =?us-ascii?Q?JeT/HzoO1CrIoL5VeTgZBO+2tQHufkh9r2ITc5nTU9sMcq4YBKBdOUSSUikW?=
 =?us-ascii?Q?ORHAL3KzrCjjfkzs+ZSAjFwav0p3j/4Ub8/nPYjIQg1F36UVRWiR+XOQCBDV?=
 =?us-ascii?Q?4oC2Ta6CWrrJBrNP6qww/3D9itsZNFchkwXLKdlX/OaqzyeoWQFMoHDINtL/?=
 =?us-ascii?Q?fZ8x7x1BahkvbvjYyYX2IypFgnwyme7IWj1steQuzmFbDP3tJtkevTZCIxlK?=
 =?us-ascii?Q?1+UwsJoA2vw4iu94e63UOlWjd4qwyU9LM758lPorHTSV9bsuxcTHE2xMTZ8e?=
 =?us-ascii?Q?4+T7O5WxgsQhUpz9o0CanS0I4hH3HOmf1fz50pl8G7ovIMA26libpCa7jlSs?=
 =?us-ascii?Q?wru15nISdJTzedliSvQMnDQKyS83lm0ekSYJb/heuK1dnrnWpzyoTACLVg85?=
 =?us-ascii?Q?tPwP3laJ61cOHnsEuyvCJ6w9SmxXlJuLbYYRTOIVMg6lqgW5l16GV5rAJ9Pq?=
 =?us-ascii?Q?lGXNOVK93c/ZWeOWbyMRfX/Z+71HDb+whg9nISpJAIPeeF4eBoGN6pk0DWM3?=
 =?us-ascii?Q?z+nUfhWyaQa+djeAOOFvFj8LoBDiAmUyMDKlxwKyQQtf+Y4CsE0YI88Nf8qP?=
 =?us-ascii?Q?3H6zLJ+zT0G6ZBZtbb/j36zv/M2fW14rcpt7afaBK38OAiBodpZe3HfNNSl4?=
 =?us-ascii?Q?IUTQnjsweG/BlsCeMWHsrjLETY6p/xizAb33rLH/fX2ezTB1/6F2oY6YM6jz?=
 =?us-ascii?Q?DY4d96Chtw450vjSXcbjraJ0sJ59v/+4DMVRyVyj7a7vugH1srnZphC5VnOn?=
 =?us-ascii?Q?+0RbTh8yhAWXYgmSgGu+JJ4YmGlONE7Q+1iUrtxsVcFk2ygG6l3woKF96FtY?=
 =?us-ascii?Q?A0TkrscYugW7+2rIP20xFZeMmKfoRRo9n+4tm6QRxvpCwONQI/XZNfbc4Gdf?=
 =?us-ascii?Q?fwkUjAFsdTZkogs2G6gUK3ySwEFcmIwz/CoMuQhfCla7PcItuKaBkSQDV0v2?=
 =?us-ascii?Q?+iPDToDbi6Gj5L/DEDY6bq1ffv7O2I8WzKC4OUxD+bSs2meN31WAaNvly4Bl?=
 =?us-ascii?Q?mgQMdgSmdBjnzf0l8cBkPEM1XhbLlDrZ2OqiPQtlGKg+9OWyKWMdVcFkfwRr?=
 =?us-ascii?Q?l2+bSdW8QytQgp5ik7No6vD7JmAg1QF7LMoj4yFkuqvgc0EBk0Cpt+iybayL?=
 =?us-ascii?Q?pCSz/PxXsLhQ7u/4uraS649TSY0tXr9bxIAZILFWgQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8690.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pbxt3LULzqgDKUVG5/hMGqmmaC2/5fP3lXTvSRI9Ihf4kaTq7Ki63wprTnHH?=
 =?us-ascii?Q?7+lxfwEWhR7sf+7mMBS5VNMW1FRPBbPx29TOR1ey9L0zcFXLIv8qU/rBetNs?=
 =?us-ascii?Q?tKau8NK4pdQeJB7mDCAACguopxKpXKjrSbaGydukArushC9G6RahN/YRfnF+?=
 =?us-ascii?Q?E2h3SZg/+RP4NY+Dt8Nc4XzaaL0rxp8aQiHYHxIR3utgIuFGsQiekNulMpSI?=
 =?us-ascii?Q?8h64tjO+aEaeEUaXWQYc+C0O/gbH2nQTp1tPq2byzqHrKxh3iklf8S1kvUWU?=
 =?us-ascii?Q?zrDamSbimFhiA7PrS5l0OmOxs+yC2HOPKHmZ2ai4HoLKn8m9paB2HuOrcraT?=
 =?us-ascii?Q?WKUe8I0ygBaLi9xnyn5fBqWCjTGre4CJvVru7WGp3j60RTM2/u+XwLGIVJot?=
 =?us-ascii?Q?iwRsJnvynYeqkuAYob3SVhueXrA4XM0i9SSBnLWrPpwcYNUXbJkqjXmgjMW9?=
 =?us-ascii?Q?WU5pn2dDOBhOQhrMRXZ1X7eYpvOsu/XsVBLocCZgWLbu8TDeAH1B9Ry4q6/f?=
 =?us-ascii?Q?jOGt82ZUkJMji7egW91B/Ji63qHMkjGrxZBGmVA8I/HfWNvSR65F0WFU/L+j?=
 =?us-ascii?Q?w/qad1rVGgUSPaj4WiYHF+SEDMaWFEC9mNM52Eoq1rym+q3Re5yBdPW35M+X?=
 =?us-ascii?Q?WWv4ZdCWkQscwPHjjp68kmcc6qOH4/TosI4OqRX6bjoSNAG5uiw/AYOdMpQH?=
 =?us-ascii?Q?dXij1dtSyCSwvSizvax6tYNQBPRP8On3wrrvgP6A6t7aWXqeeHCvv4JzsED6?=
 =?us-ascii?Q?HZdyGDyryFcAD1pdpA7Cf33GLH1pBIKuM3r9TvMOtOYVR4+ehD0PAl5OZTj3?=
 =?us-ascii?Q?+PlrOI9nWmVxVHFrshWCsz7PwS9QOFCcWtZlX8FzeGLYxMZJ6N/HCRzOP8mm?=
 =?us-ascii?Q?Uz5bhEMuHXnZc7M3gBmpx1SkT5QBJCfptEznnwqi6egxVBtGojUtcT93MD3H?=
 =?us-ascii?Q?bjCk7aaIe+UvkvVKTTUpbQte/4l0ChuYjtI2FSLyABwjf6hce+moyavCgubM?=
 =?us-ascii?Q?EsDub9bJw5U7t0FqWL50APc+MmpbCRkT3IMAriA//14cJL9nhhuK1Hegqmdy?=
 =?us-ascii?Q?G1/GZPKYJEVv9pEtRqn9Ry+rPtGpNYn+SFBS1jzEokoVAre+uBBFnmEkYft3?=
 =?us-ascii?Q?N+ZC+Sf+S0WCdXctV8cm7GskguJMLciV9rsuko7JxFAhNY46SIRPzj/a6DA7?=
 =?us-ascii?Q?Rgo03jmY9P+D/Ba0MCsdZhF8w8fPSIEqka0M05bpVWldjXTeYc2uYXk681gh?=
 =?us-ascii?Q?y/POOkv9PqTcYhzfFZCnN63MwLLRDmK/prUB+WXm0MbE+1v9+55gp8eYkfaq?=
 =?us-ascii?Q?FK2XzneYmyUqf0m24wE4nYDUIhD3MSb20ed11OJOD/IpTQNFOG4v38ceODid?=
 =?us-ascii?Q?Rm5IXn8nVT4yKWYJGqRDYcc3rnAUD3tRHfEtjOT56o4m5xcrb3kIJF7WtxFl?=
 =?us-ascii?Q?VfGmJuBScC4Ttk/QHWlWnXFXklnUVeTI9VvxIknaDRbiVOcCZCqmW40Jx6MX?=
 =?us-ascii?Q?RvagZFd9LYS+OPCKhOIMmCDdWUh4DHHk05TXovqoTyNn/BVF1YJGP6xOlBTI?=
 =?us-ascii?Q?8UcEiekRiDmFhFHPorrnqG4n6oo4nI747z0JjbMf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2129bc32-2e36-4d4d-6ce2-08dc63836ed1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 10:52:13.2517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wSkMvlVdKsAYbtWPc+324SuPuVkTAn+qFcPAQC5+dx1G8VTqjNi2d4ikEOgVu57RLGd0xjHTYun91xyBXeX/gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5806

On Tue, Apr 23, 2024 at 04:40:55PM +0800, Yuan, Perry wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> Add one global `global_params` to represent CPU Performance Boost(cpb)
> state for cpu frequency scaling, both active and passive modes all can
> support CPU cores frequency boosting control which is based on the BIOS
> setting, while BIOS turn on the "Core Performance Boost", it will
> allow OS control each core highest perf limitation from OS side.
> 
> The active, guided and passive modes of the amd-pstate driver can
> support frequency boost control when the "Core Performance Boost"
> (CPB) feature is enabled in the BIOS.  When enabled in BIOS, the user
> has an option at runtime to allow/disallow the cores from operating in
> the boost frequency range.
> 
> Add an amd_pstate_global_params object to record whether CPB is
> enabled in BIOS, and if it has been activated by the user
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
> index 83a29b257794..3d86cd7c9073 100644
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
> @@ -665,18 +667,27 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
>  	return 0;
>  }
>  
> -static void amd_pstate_boost_init(struct amd_cpudata *cpudata)
> +static int amd_pstate_boost_init(struct amd_cpudata *cpudata)
>  {
> -	u32 highest_perf, nominal_perf;
> +	u64 boost_val;
> +	int ret;
>  
> -	highest_perf = READ_ONCE(cpudata->highest_perf);
> -	nominal_perf = READ_ONCE(cpudata->nominal_perf);
> +	ret = rdmsrl_on_cpu(cpudata->cpu, MSR_K7_HWCR, &boost_val);
> +	if (ret) {
> +		pr_err_once("failed to read initial CPU boost state!\n");
> +		return ret;
> +	}
>  
> -	if (highest_perf <= nominal_perf)
> -		return;
> +	amd_pstate_global_params.cpb_supported = !(boost_val & MSR_K7_HWCR_CPB_DIS);

We have a X86_FEATURE_CPB bit to indicate whether current processor to
support boost. It would better to add a check here if amd-pstate need
forward support.

Thanks,
Ray

> +
> +	if (amd_pstate_global_params.cpb_supported) {
> +		cpudata->boost_supported = true;
> +		current_pstate_driver->boost_enabled = true;
> +	}
>  
> -	cpudata->boost_supported = true;
> -	current_pstate_driver->boost_enabled = true;
> +	amd_pstate_global_params.cpb_boost = amd_pstate_global_params.cpb_supported;
> +
> +	return ret;
>  }
>  
>  static void amd_perf_ctl_reset(unsigned int cpu)
> @@ -900,6 +911,11 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  
>  	amd_pstate_init_prefcore(cpudata);
>  
> +	/* initialize cpu cores boot state */
> +	ret = amd_pstate_boost_init(cpudata);
> +	if (ret)
> +		goto free_cpudata1;
> +
>  	ret = amd_pstate_init_perf(cpudata);
>  	if (ret)
>  		goto free_cpudata1;
> @@ -956,7 +972,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  
>  	policy->driver_data = cpudata;
>  
> -	amd_pstate_boost_init(cpudata);
>  	if (!current_pstate_driver->adjust_perf)
>  		current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
>  
> @@ -1363,6 +1378,11 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  
>  	amd_pstate_init_prefcore(cpudata);
>  
> +	/* initialize cpu cores boot state */
> +	ret = amd_pstate_boost_init(cpudata);
> +	if (ret)
> +		goto free_cpudata1;
> +
>  	ret = amd_pstate_init_perf(cpudata);
>  	if (ret)
>  		goto free_cpudata1;
> @@ -1417,7 +1437,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  			return ret;
>  		WRITE_ONCE(cpudata->cppc_cap1_cached, value);
>  	}
> -	amd_pstate_boost_init(cpudata);
>  
>  	return 0;
>  
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
> +
>  #endif /* _LINUX_AMD_PSTATE_H */
> -- 
> 2.34.1
> 


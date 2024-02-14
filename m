Return-Path: <linux-kernel+bounces-64794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF788542ED
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527341F26FB1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267FD111B0;
	Wed, 14 Feb 2024 06:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JXLwKqGK"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16739612E;
	Wed, 14 Feb 2024 06:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707892638; cv=fail; b=kVOJORqBTqJ03KxDUBsPb48uEPaop28R2LWEpdAW/iMZVnp+IsgphkhCNMuRfyY+1SfJ2uoZ+MCqFQxKt23H69khyb2UUEJ9J28WlOfn5Na7pGBvkJ8EunGhjBalh9yMaVvSbIVV5ZPDm9+XiA7Jre+hPmECy8tf9sq6roVRuuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707892638; c=relaxed/simple;
	bh=HS9L/Yo1nr/KzbdeQwwO48+IGoE8AyYMPWpq5GV9t2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tij5bZC284cGQOEPp397ZhFyMdntXIKObN8q5hral8gJsfyQo4zmldS4mzyuDgH1wzMn8RfCtYKw+3wryOf4hdeXPXSF0Um/e1pi7JTw5TemDKSeXlEVpahH+mASAEE6DEtpJ6MOrsZTUe4VoKv9J8h+X/ISCkb5K+41gGOSfW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JXLwKqGK; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vkz+pAJueWWnGJ7aUkWx7PS07WfM44V/knRJ1pqF0y9PF/KhAywhGCbsT6nDAtSQrQCc+Sz86DtY8Jnr6GSFJL6GQdkJ5Sw3bVlFiLuTLDGKihnOasslp42IE44ta+XhRf3oFtSks6Sk6JYS4GsZ42elpL7Y8T3MrqEpbq19BMBi7gf9eT3mxXIEh3tGhegRpUYQSwSVqz8oqXe5qrUzMQBbD6zEsTyQ1bshHC6BqpJO4enWe8uCMdnhNNnfRmX351PcLCLmuY0jBHw+9WP0Ej/gBLzrFKWAfYaU3j6I7OqL8YW/pxFW6vMsczJMaNqwfL7SmZHNiG73tBW+6lHsHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFoqR10m1Zq8ZhQBKXFo+wG0RaOjCX6tRR6Cb30mPOM=;
 b=Km9FTXRwMjFl4JF7QLSuDrbB5sGgtW8p61FVOQZOF9L92V2i6JLHriW48oni+lKeHp5F6J77mHqxoKpxHreweLc+7XUPV/fi10/QTQnTt4MbPcx2wesWL8MDzRfqlFffxpTt2afxewJFQadnZy/u4FM9uJECTjQ2IZden5/uiE5fFHccIxWGY5WJ3pKEalOqtPLjhbxLDyVcj8SQVPHEsUDpFCGpLzoTmMFF2VSdN/Umt8PdDcfh4QRB3Jj/l+Xhavq/ZQu69xZ1ZFA1htEIL1yTcaZdX0kXUuatSt2wKZ0nusMI+DemE1ar9boYJ+0nPzUnfCc2wWNHdm4/YUm4iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFoqR10m1Zq8ZhQBKXFo+wG0RaOjCX6tRR6Cb30mPOM=;
 b=JXLwKqGK7wyWtSPLD3xc+sXjYj5zxaJ28MQb5wLMUCv0efudXqUE6wHShxykP61gsep0e51gs72nEjwg1kIGFuAODTUkaUN/hLspmc1yBI91iThDGoOQDd9vAHZcaX6qxAVEU171obNBakcr/BGNBC8oN++HQDg62ldI0NjxhVk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH0PR12MB7862.namprd12.prod.outlook.com (2603:10b6:510:26d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25; Wed, 14 Feb 2024 06:37:13 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::d725:ec0f:5755:769b]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::d725:ec0f:5755:769b%3]) with mapi id 15.20.7292.022; Wed, 14 Feb 2024
 06:37:12 +0000
Date: Wed, 14 Feb 2024 12:07:11 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Perry Yuan <perry.yuan@amd.com>
Cc: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com,
	viresh.kumar@linaro.org, Ray.Huang@amd.com, Borislav.Petkov@amd.com,
	Alexander.Deucher@amd.com, Xinmei.Huang@amd.com,
	Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] cpufreq: amd-pstate: initialize new core precision
 boost state
Message-ID: <Zcxfl7Pqob70ghDi@BLR-5CG11610CF.amd.com>
References: <cover.1706255676.git.perry.yuan@amd.com>
 <0409d40c500eeb8d4d84ecb028b73f2eee147822.1706255676.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0409d40c500eeb8d4d84ecb028b73f2eee147822.1706255676.git.perry.yuan@amd.com>
X-ClientProxiedBy: TYAPR01CA0190.jpnprd01.prod.outlook.com
 (2603:1096:404:ba::34) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH0PR12MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: e23a3aff-e523-4563-cb33-08dc2d27607a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Dp6+ZBHvFGIxB3IptN02D7bUzbSIRrIXOGG5aA8g3v5KBoFn5pQFz2N6+ADj7zjYzxHLeAGAULfCo2QLGEI8DXUSdQR+ugdOcDWyIEJLbICr7C+7YsrbSxr5ZPwY59zR0gdTEW3pXNFHe0q0dyai7Msg+8EL+6X6Jv8YmF/0Uu5TgLiebshP9cIvZegTfHWXhexNeaaOI5ZyTPtgAD4qifyRedrja2R8mnmQao0kWO74wFbmyJXKiIgIi8jrs8saFCYO6ZvtXvkx3q6THNP+MJ+i+b48+2UIHhLA2GoDlSblQcQ1AyA2Mgk7CYdnLc2F+yIsAYFh8y13N4Lg9kSEJtuphBmJLlobJswTiVUDt++ZNrIfxIHGGMhAl2a5e/JAfzEYfS10mhyXmfUa4Wn4wod25AD2iPjWrvH2m3K5JuCxM9rx9fNa/Zb52dxilYgp7ahMqEAdWqMLXmd3T5IOoQRtEcbA4ha3zpSPTQlTxH+kwNGiaoIA+P6ewhdD5lkFp9UqHBE/Z1WFXHHkDh6z8wCMxWYBkS8cRqIFGJC+DcvGJfOPoWZAVzH8qY6t1jCJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(366004)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(6862004)(86362001)(5660300002)(66556008)(6636002)(66946007)(316002)(6486002)(478600001)(6506007)(2906002)(8676002)(8936002)(4326008)(83380400001)(6512007)(38100700002)(26005)(66476007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1w0z/tXvVXyHMI5ho6dwOWBMPvFk6BhxEwSHJPHqZAl4N+zm56rKUUX40WbS?=
 =?us-ascii?Q?WyUXsLuewXgTXGM4cdsMxA04HmFrtGe/xLBa1P0oF9hc8qw6KEKsBGwo9md0?=
 =?us-ascii?Q?T1lHRMDExIMg/zDBNq1LaaHifPGQOCy/W4VxDI2716gmmTjSa+VI2Ql1bD3x?=
 =?us-ascii?Q?72sV985VTsejFlIU9wqbPrqyDtmYrsdWNAYRogAQGnOSI/ikemdpxFDbJBrr?=
 =?us-ascii?Q?CLx67xflL/07pEL2f4PN/dmqro9oVq17krIQw5tH4ywJb0JAUr0ZuC7KQiDE?=
 =?us-ascii?Q?Tdc86iQw/qP497J3Yftxv+6O7rQv3xaOUUnQzk2C6Y36EB9Ti2ojiiGXgrHB?=
 =?us-ascii?Q?JNFlg7h6K3qa9TdjnVVwk7yUYL8AK3YC8OY7t3EXGJQf54NkEtdtqUzybd9y?=
 =?us-ascii?Q?N811VA86sH8F+0c1UXTXGbyvlIkq1ZtYZSNxiSMAbtv+00DrYjraMeLdVjxu?=
 =?us-ascii?Q?yokTp41U5Uc3p1h9eaL6TjvOXSm0uVowNKCB0UIgHgOsnzvdYn5KRGDL4sp/?=
 =?us-ascii?Q?Wf+KXtiupKdx/o08w2uqOC1PV/rKZ//fDSmQKgDHGWzG76wsx25ahyItRE+C?=
 =?us-ascii?Q?OutqSxGL0kbmq1YOadEougqms7nHQRbp9FX8rp3VQ/mSJYTPxUx5njD20fNM?=
 =?us-ascii?Q?rj4j/hEP6zw+HsUdmyCUoZrfV5bEndPj2Sc47ZG9Je6CO15dat7YsZa1TZ79?=
 =?us-ascii?Q?jq+QL/rTTCA/k+RcWwDMz1mGhXZl5+eq37hu3LYd1Q9JeeJqoqjwUx2hBlrZ?=
 =?us-ascii?Q?yhUydqj3Lu97UazK9as0jjBHQdwH/rCgvFm5H+8+rvrFBwTLM+2B/lUQqwlY?=
 =?us-ascii?Q?DB5KyVCf4NatgzHhZRYzfqBrSmDq9QHcVjLW2HMMZVWSqOtgRF6coqeT6ZyI?=
 =?us-ascii?Q?KJq+zjYSFbpmEcCz6YttH5OxdUTI8FiVxvdZyXZwUgLgeQVl/nTikE/CMPVW?=
 =?us-ascii?Q?sL/KQogT1varl33lxECDXZ8WQ8b+Pc/LEsjZH4E8yH8IxFar9gLsgDgGx4sT?=
 =?us-ascii?Q?mx1XREFDGI0OnLwQkNt57PWYXDa+zU+vvzAegtGTERXZv670+AjfipfD8vx4?=
 =?us-ascii?Q?s/2XGgZvY8a6RAMXlwf39E6kNqB88jnfMosx6DGG4XxMWlalYD3c/bWtULsK?=
 =?us-ascii?Q?wNfFKR94heo+mau6+G2ObNkS5HKQGOI0ccFKDnIKnXPB37N283Mtrj44bSE+?=
 =?us-ascii?Q?N2U5G6psS8J9lXv6/ahT/sDDNaEHqjxlpIF+PbIk3W4alHIJyV33y+jT9jYz?=
 =?us-ascii?Q?PvIuOrBXTYJQylPuFOEv0Wy8uGlo7Cqcq4PmoqkPj4u4+BUr6bhp12ATBbcv?=
 =?us-ascii?Q?ERX+EakYdBkZ89Ce9vC+r2zVy5+1icNkOfi4CxKl/R2O+Wc+hXfnT6uWsqKT?=
 =?us-ascii?Q?GIuOgMeVM6UdWvO2n//U+YLex7SSZpos+agPkDBlRkDGZRE3mSUMJ2FY3ncN?=
 =?us-ascii?Q?WuYzcV7XNTF8wDskdAU9Hw7SIQoTkiUu7zaBLR4QmUlFvQ2KOJR154e/wo+P?=
 =?us-ascii?Q?9JJeunJpaW8jS+XWUG9b/2Qh8MMSm+RRhKga03iTU9msb4N+OG6sySK0rjdT?=
 =?us-ascii?Q?mhlQooYSt6IozysKvlOWQY4i5iHQ29pTafxbRu7J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e23a3aff-e523-4563-cb33-08dc2d27607a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 06:37:12.7974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PB/5w2w8i8KU8N+ycb/SlNVAzoNofwGfb3CHG3JoABgsW5gB3iolK6wgLXlyeBtcSYfrPwo8HBLYfpWBatnkkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7862

Hello Perry,

On Fri, Jan 26, 2024 at 04:08:05PM +0800, Perry Yuan wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>

[..snip..]

> @@ -632,18 +645,27 @@ static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
>  	return lowest_nonlinear_freq * 1000;
>  }
>  
> -static void amd_pstate_boost_init(struct amd_cpudata *cpudata)
> +static int amd_pstate_boost_init(struct amd_cpudata *cpudata)
>  {
> -	u32 highest_perf, nominal_perf;
> +	u64 boost_state, boost_val;


> +	int ret;
>  
> -	highest_perf = READ_ONCE(cpudata->highest_perf);
> -	nominal_perf = READ_ONCE(cpudata->nominal_perf);
> +	ret = rdmsrl_on_cpu(cpudata->cpu, MSR_K7_HWCR, &boost_val);

Use hwcr_val instead of boost_val ?

> +	if (ret) {
> +		pr_err_once("failed to read initial CPU boost state!\n");
> +		return ret;
> +	}
>  
> -	if (highest_perf <= nominal_perf)
> -		return;
> +	boost_state = (boost_val >> 25) & 0x1;

How about the following ?

        boost_disabled = (hwcr_val & MSR_K7_HWCR_CPB_DIS);



> +	if (!boost_state) {

        if (!boost_disabled) {

> +		global.cpb_supported = true;
> +		global.cpb_boost = true;
> +	} else {
> +		global.cpb_supported = false;
> +		global.cpb_boost = false;
> +	}
>  
> -	cpudata->boost_supported = true;
> -	current_pstate_driver->boost_enabled = true;
> +	return ret;
>  }
>  
>  static void amd_perf_ctl_reset(unsigned int cpu)
> @@ -676,6 +698,9 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  	if (ret)
>  		goto free_cpudata1;
>  
> +	/* initialize cpu cores boot state */
> +	amd_pstate_boost_init(cpudata);
> +
>  	min_freq = amd_get_min_freq(cpudata);
>  	max_freq = amd_get_max_freq(cpudata);
>  	nominal_freq = amd_get_nominal_freq(cpudata);
> @@ -725,7 +750,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  
>  	policy->driver_data = cpudata;
>  
> -	amd_pstate_boost_init(cpudata);
>  	if (!current_pstate_driver->adjust_perf)
>  		current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
>  
> @@ -1093,6 +1117,9 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	if (ret)
>  		goto free_cpudata1;
>  
> +	/* initialize cpu cores boot state */
> +	amd_pstate_boost_init(cpudata);
> +
>  	min_freq = amd_get_min_freq(cpudata);
>  	max_freq = amd_get_max_freq(cpudata);
>  	nominal_freq = amd_get_nominal_freq(cpudata);
> @@ -1143,7 +1170,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  			return ret;
>  		WRITE_ONCE(cpudata->cppc_cap1_cached, value);
>  	}
> -	amd_pstate_boost_init(cpudata);
>  
>  	return 0;
>  
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index 446394f84606..66d939a344b1 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -80,7 +80,6 @@ struct amd_cpudata {
>  	struct amd_aperf_mperf prev;
>  
>  	u64	freq;
> -	bool	boost_supported;
>  
>  	/* EPP feature related attributes*/
>  	s16	epp_policy;
> -- 
> 2.34.1
> 

Otherwise looks good to me.
--
Thanks and Regards
gautham.


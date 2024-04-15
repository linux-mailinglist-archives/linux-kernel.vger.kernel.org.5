Return-Path: <linux-kernel+bounces-145405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3550C8A55CB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69B06B21175
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61663757E5;
	Mon, 15 Apr 2024 14:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wOQItSH6"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2078.outbound.protection.outlook.com [40.107.96.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A80474400;
	Mon, 15 Apr 2024 14:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713193184; cv=fail; b=NDZ7bLTWshbz65zLrVW9HH0dvc6yiyf+LhvOxEXUHdvaDEOMYyqrOPr1dPOHVu2Go1aYYPjU+Imh1SvmS32zhiVEfbqQ9PEHobitX5ySgBbCvEIa29oa7CVKxe3cDD2v/Rbv12ne5QtmWjjsr0hzb3XxoeAonETA/3btOl7dWrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713193184; c=relaxed/simple;
	bh=X6DADybGQMFI7ACbTSmFVuzV/rtXehVLiYPJpQlBbqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ui1YwIkoq6s8jrnCQ8Ve+yoVNjDi36rO31eoF62G6RVfAewI5Pe+Yl6bBf7VJeztUoI+q3NVmLi7j++q4/2fw6autbknx2cW5EYHbqL42nN2f+xdNoHyXYlWcnrdM9+yLyeWRrLNzuoxPSVu048FpPyAocvr6OEePFyBCTG6EQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wOQItSH6; arc=fail smtp.client-ip=40.107.96.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9N5RbEDSO66Oo4uq6zAqfyoQdSjUkR87ZrYm5gw7KXFiQK9XrZWd8+98sjRqZ3gPbbWQFk0JDt94tEN2DraYAgtNX65A9iyTRaTygECdqprRxGVjCtJTwZCJZjgh2CWlrXheJ51ROzFAf7v3cd1GhjjsE29aPibqoI2lTzmURPePqf0di5F4KJqJcb/31lU4rLgKrgE0nxkkr+giMlc1FILZpFBdmrcNk55N2MkbiThE0CZE613rOfBOXTu5oXFJ5WFVKi3aikti107FpQdpoK5Ryadr2l2BwAFoZbFwJkdk4Rd4tKAgoI1YkGETf/kKjgQnUgoaqQDFrFKheiLYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMRyVaPRm3rZqm/QF26Y1YmDs+KBjRQGYJrrF9hhjDY=;
 b=TpKsOTnlBlVDvqIkT+9XDB2AXiM4urvt8kgiSacT/nC1rVMHP/zyqXbJdB6mVX3J5BBqsk91Bo7lNv6lCo0hGG+7a58zowE7cYkveX3cjWNwSg0nlbJc+sbgOEndp3RM3uOIzo0GRXFWl1cLAeDTcYZdodoUWJLyXfvdNPQy8UExcmVA7eJrpVHOsSdXrgdP4Kslz+kRaAteKUAkhYVddLcLngspcrRwDIONRHpjYB1KKJX3zIGNoyYQMtW3edMCz3pn84xLYholopF7x8SfFpo9jnAoungc8fbtXaVpwZuN2jFLiinrFdK+HJyHC8rus4wjgqml4ZcgYdjV4Y6mqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMRyVaPRm3rZqm/QF26Y1YmDs+KBjRQGYJrrF9hhjDY=;
 b=wOQItSH6txVLl/zV6n/hqmS+MCU7z5f8MzVJBCDKyy/ppW30EVyZbRAMLwS9T3LG+un9XniJN/t/fMBRs82hzAJgm9sZncT7CfjF4pswiNSyehhISYd6jigaklxHl6NAVTsgnweqJfoaMAGknnW1juUlf03jvQLpGZaWgCyEQeQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by PH8PR12MB6964.namprd12.prod.outlook.com (2603:10b6:510:1bf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 14:59:37 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::e7a:5022:4b7d:ade1]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::e7a:5022:4b7d:ade1%7]) with mapi id 15.20.7409.042; Mon, 15 Apr 2024
 14:59:37 +0000
Date: Mon, 15 Apr 2024 22:59:14 +0800
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
Subject: Re: [PATCH v10 5/8] cpufreq: amd-pstate: Bail out if
 min/max/nominal_freq is 0
Message-ID: <Zh1AwtnewmweX3zr@amd.com>
References: <cover.1711335714.git.perry.yuan@amd.com>
 <c2809391c877dd5842389aaf87bf2b5fce5dc866.1711335714.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2809391c877dd5842389aaf87bf2b5fce5dc866.1711335714.git.perry.yuan@amd.com>
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|PH8PR12MB6964:EE_
X-MS-Office365-Filtering-Correlation-Id: 07eef7e4-0122-46c1-4c73-08dc5d5caafa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UrqltS6wYpTbUsszb5dobj7vaPv0IykrWXXpWFVXSCk0psv9Sh/UfR5CGDWe8ueaoS/XBh98akkuPGzkPhbRK41UR00cnxpEk8R+Xz8iAFlTjo8ecUkWBgo/reT2P3xxjn/a7JInPDVbDFu4YSjuLg2mhf13mdRJHEJ1WIDSsrV4CVx3BtK2Z9gG2PeZxPWZMWfG7cSiOEEDwN06YES+B4Za8IN9eFqFYtmg9NYy0OKLuk6VIeqAjRcXB43UgCAPXKCss5utnEJj9+Oafi+SOgQ/upTRKmvWkD/fjQgnzFvuG1KbogI+7nWDaqBpqu/JyLB+jaWgISVWzei2Bfqr4nxBRUFqmxVcdL15S5rYO5fzq5gCLltc+9EzyKHNAIeg2EVy8t3pv33M6xPfhwx1BeRNj6HuIB45IcH+Kv7slb35JQb97ZkR6XJOCtzeYuv5aroVIpxQnVOsWmvQYskWk2f+dBBfdivEAFzW7GGhIAhFGBbn9ALzB2QNwocW/ahj03fKM5+WkeX+hJmASYId7TnEG4HwJKA6a3/Y9SCheloamsQXVa1X9glB4yVOX5sD2gUgnZ7un//FXLPtOCSG4TxhNr+BavZCut6W1Kiv5qRJ+Z1hUekdPJeECE7kO2w5IN79ZLROm1zClLwEkX9vX4gehFwQ+1YVrgRzZEfg4M4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8690.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NdKtTBljv7zQ2IJwjOTN6O9GjUhQQc5WVdGG9sx2RsnwKYMV7/vmyxH01/vI?=
 =?us-ascii?Q?FOoKLBi1BvT4g8Yv8WUn8NuAG40UIGko4zGzEqdfe1CJ4C9id4DQ2v64WZKA?=
 =?us-ascii?Q?gPex1L9QQRDVPI1w7uJy8uqdMfjizAd/vzvcObTo20pXR8zoROGJiwOBm+t+?=
 =?us-ascii?Q?/H0cB2wdvJrr01WilmcEgekXqn3Gqdsvs/TsMPd6f3bTimJ4LvhjRqTrVPZk?=
 =?us-ascii?Q?xFH75kBJ62uZCQuMuab1UD/EKd2W4HO5C+IQylA7dWAEFC94JilJ8wMW2XvX?=
 =?us-ascii?Q?kMwuDJLduZixx9eeeVc6UFBlQZYyvzfUgQbur6sD2dvsVpMP0VKKLTR9izzq?=
 =?us-ascii?Q?ZwrRf7b/HUyQ22cQwaFyE7hxcHzTtbBeEzZvnZW2zZ9u6dGNjC99/W3Bj65O?=
 =?us-ascii?Q?XNrhu044FJG9UExBeRf2TYmakq5A1TWIhK9Hk9NHc3HFNp2MyYgK9d0f9cug?=
 =?us-ascii?Q?peQacdjHjKj68639Oki6xXcFQ/l8bpBxyLWrTtaqfyhqs/z27P9JBxoHe20T?=
 =?us-ascii?Q?iH427j6cY36YdG5/BR0GhtjTZXnWZzRMgc/lAuAcex9ObCFBRNBFlNuKr+A7?=
 =?us-ascii?Q?rZdR+4YWdRBe9qhHUzhZWPu2pCsVSKnCG0p/vJTi8bFBAgBN5ce2hDt5s7o3?=
 =?us-ascii?Q?+fDr10iqGI60osV9fWQbSB3QrM3+PxjZDcQJeNNjFDm6q7L/5ow0Pk25/HAI?=
 =?us-ascii?Q?ICune0qwumKzKymkrIURAZZWQkXS0ERcPYDzmp9c0Thkhd1QAS+fPWhlSWbu?=
 =?us-ascii?Q?kX+tTRKN0GcmT7j1SEJtOPNA/isRC9DSK2zuVL5JhtN+M0SC9S34oZ95NJ1a?=
 =?us-ascii?Q?OpuyefZ8GVCcIMc03dcZnR4ijnVdrRwhaR9LG1Oa7g666k/qEGLvYgWCAWPD?=
 =?us-ascii?Q?J6WtR5E7ihwVaF8MeYVnWFFLR27DTwJUJKu/nMOBJQ+/hRqW98TJmtedju4T?=
 =?us-ascii?Q?cdlRuLnCfW1s1c7gitxxd5MwBVBDQwDWa7tCxNmtq2tGG6acEvTq2BYgTpmt?=
 =?us-ascii?Q?QAuJQz/b7mn+kjcgHloydDWatuZz+NFNykLuwlmHYV5dblgr0TM9oQ6t1Nmn?=
 =?us-ascii?Q?jF7kw+4km1lPtTciYNgQrrWm+E875EaZxGWwy0zuT8HadPl1qkypNr7ba+4p?=
 =?us-ascii?Q?a+TjNUiHSGt5McmnESTfl2gj4fExQf0bFzna4t62ZOsJ3h0N5aTiZW5WYzkd?=
 =?us-ascii?Q?6JKonZFKtkx7jD1yDm8oHkj9fDgfjNaC5PAyuw5egvZMwdhhVdXl5uqFlNOn?=
 =?us-ascii?Q?QFpzognV3caT2fcmoYUzSnJU91lTTTVRE6n94wgEBEedSDm5p53m9fyzmcx4?=
 =?us-ascii?Q?eOqtnLXLDJfezTsEW4DUKc3BMBCFTsR3c03slgDmteZ4yOHZmZE4tRAOUfv8?=
 =?us-ascii?Q?esT2vbljgfG7WPGDlr4RH2+rSpkLZ3fratBR2l4tRRIVbW5Fl04KpnPwaa3j?=
 =?us-ascii?Q?a1+aJq8vR48yQXjWiPuzGkb1MV67wI3wPO+Nj3qUuKlDw7poYq3/T8XUNXBV?=
 =?us-ascii?Q?0oB5fV7lbBa8ccWGcz1Xp5x3Iqp7Rbme4Bz7WI3QvADHtbb+oZmvzc1Qe26J?=
 =?us-ascii?Q?YL0QQD9tCFZ3/DcgAKCHHjN1MreeAFog5r9tunzb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07eef7e4-0122-46c1-4c73-08dc5d5caafa
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 14:59:36.8664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4O4i67jA9E6zHSBNRBTlfawZtYzMWrrhLawSDjv/DWX18ne3q+dEpjXhJh9w7wTIQkvQH+mctc1iSSCp2HqvrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6964

On Mon, Mar 25, 2024 at 11:03:25AM +0800, Yuan, Perry wrote:
> The amd-pstate driver cannot work when the min_freq, nominal_freq or
> the max_freq is zero. When this happens it is prudent to error out
> early on rather than waiting failing at the time of the governor
> initialization.
> 
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Tested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 132330b4942f..6708c436e1a2 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -839,9 +839,11 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  	nominal_freq = READ_ONCE(cpudata->nominal_freq);
>  	lowest_nonlinear_freq = READ_ONCE(cpudata->lowest_nonlinear_freq);
>  
> -	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
> -		dev_err(dev, "min_freq(%d) or max_freq(%d) value is incorrect\n",
> -			min_freq, max_freq);
> +	if (min_freq <= 0 || max_freq <= 0 ||
> +	    nominal_freq <= 0 || min_freq > max_freq) {
> +		dev_err(dev,
> +			"min_freq(%d) or max_freq(%d) or nominal_freq (%d) value is incorrect\n",
> +			min_freq, max_freq, nominal_freq);

I suggest that we add one comment to remind that should be the error of
ACPI table or BIOS.

>  		ret = -EINVAL;
>  		goto free_cpudata1;
>  	}
> @@ -1299,9 +1301,11 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	max_freq = READ_ONCE(cpudata->max_freq);
>  	nominal_freq = READ_ONCE(cpudata->nominal_freq);
>  	lowest_nonlinear_freq = READ_ONCE(cpudata->lowest_nonlinear_freq);
> -	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
> -		dev_err(dev, "min_freq(%d) or max_freq(%d) value is incorrect\n",
> -				min_freq, max_freq);
> +	if (min_freq <= 0 || max_freq <= 0 ||
> +	    nominal_freq <= 0 || min_freq > max_freq) {
> +		dev_err(dev,
> +			"min_freq(%d) or max_freq(%d) or nominal_freq(%d) value is incorrect\n",
> +			min_freq, max_freq, nominal_freq);

The same with above.

With that fixed, patch is Acked-by: Huang Rui <ray.huang@amd.com>

Thanks,
Ray


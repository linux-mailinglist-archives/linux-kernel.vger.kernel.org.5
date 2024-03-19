Return-Path: <linux-kernel+bounces-107357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A24F387FB63
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 171901F2278D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B0A7D414;
	Tue, 19 Mar 2024 09:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yF9nk5UJ"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2097.outbound.protection.outlook.com [40.107.94.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27927D3FE;
	Tue, 19 Mar 2024 09:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710842275; cv=fail; b=mOWtU6F/cmDbPvu/ebDVtImh5xP7Pbp3pXkVNAcNxETYgxBSKjsa/8Yi1qf82ySnuyXQt6GWgEMRCRF5znIjcDKobLIXgNmUge9HTXlMUTQI6pUbV3ZDAK52shP3RatfztvI2tYxJSFlypYOVoSEBiwPS5DyGjmxUX73fTjJgfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710842275; c=relaxed/simple;
	bh=JT6ZcDzf2LsEdFspfvC3YuGNO/6l11GUgp1VxSJOxyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fFF1KR7WErLYRmB0fIidBQin2YDCQPlJ+AOkWu0biZCjUo4OG0fB8WgaW3Od/25Bl+3p39VS096wd8kMn6DO7GUjUrsCkfIpgKOehd+NYzu9iQJZLI7Q68DkyOT/JNv34kmDlkMmmsQKRLScpf5dKM3+RjX49PpVqKIDJh7Q4kY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yF9nk5UJ; arc=fail smtp.client-ip=40.107.94.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUd1Y4kIWEHf1UkySIPyhEDVPTw40Dr4ZZGupxdBDTtgcXfbs6tOQAgY+FPJS1mOrbN2w08608bBhY+d6bvBnEH/A20HTs6Jiuj1vJEpMvQMiX/aloBKW+1rluSKhYEtLsBJvXd6xyo/7AqyFRuMBATqQh48zTvk8jrJKbF/nY8ckcDDKdV8jmsQgCyBvpqdRC3OK02BR0N4F0X2r3c5OsBPZqYTg58pHqY0gf1SiCIHfotdWIGwYr2QopJAXvdu/0LOPRaO3nGX1waPNwazTt30YMZiCTn13FPxWB/Jd7beVse0wEdLsdvbPPiPT3VjmPjB/dOrWBFJpXCyYAakSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpccb4TZ1YsR6KWpBSoeWK251G+bnNq+QOaR9+z9260=;
 b=QJAo1yURVw19yYSs3VY9ETb1zgZxmxm4Fd42SNrTbYrpzA03/jSPpqehTm8ik8axlz6j6GNRI39yLCNupYUS1zHQ3SCmn1HKkRnJwJVRFIilmLNAd0WOp/Ouj6zlhVAdnYStsWjoXWsAYNOOwte7vBAHpbfS0oQ14pqYjRvSry84pUh2T4fZCeChE+H1Zoxh+OTydIc+R5VjnO/i84PNW9isH2GfJRotJmtvMMfY+SM60hLUav8BToZX037est7sAxKEMu2REsfNsqnUwUwT66YcbSCR/I7245c4f6pepTjoUaioCxSTiXfZEnCkGQ/A2rSQUzO/M7fyglbMO8eQSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpccb4TZ1YsR6KWpBSoeWK251G+bnNq+QOaR9+z9260=;
 b=yF9nk5UJyYyLkSRzSrqQOmfkU7jkVciOKs6kD3DT4cmyd7ER+JPYU9Wskql3IPpCfbVnjzhZafp+w1NjmtC5dghjL558SqIQXwB05ZySSLOCPRwZOFfl63T/sB4N95OKOpQ1ESFB6BmDsJKgUxCzICtpxRQDnZjxkd/l7ZR4k9Q=
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 IA0PR12MB9011.namprd12.prod.outlook.com (2603:10b6:208:488::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.30; Tue, 19 Mar 2024 09:57:51 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::d725:ec0f:5755:769b]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::d725:ec0f:5755:769b%3]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 09:57:51 +0000
Date: Tue, 19 Mar 2024 15:27:43 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Perry Yuan <perry.yuan@amd.com>
Cc: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com,
	viresh.kumar@linaro.org, Borislav.Petkov@amd.com, Ray.Huang@amd.com,
	Alexander.Deucher@amd.com, Xinmei.Huang@amd.com,
	oleksandr@natalenko.name, Xiaojian.Du@amd.com, Li.Meng@amd.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 5/8] cpufreq: amd-pstate: Bail out if
 min/max/nominal_freq is 0
Message-ID: <ZflhlzoGmWCkZjnn@BLR-5CG11610CF.amd.com>
References: <cover.1710836407.git.perry.yuan@amd.com>
 <884cab991815707eb10b720e6f72978cbb5e54f6.1710836407.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <884cab991815707eb10b720e6f72978cbb5e54f6.1710836407.git.perry.yuan@amd.com>
X-ClientProxiedBy: MA1P287CA0009.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::17) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|IA0PR12MB9011:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bifZoVAyqd1NjAJUQt9mVOkNCXCsYNDr8/UKetL8vQQOZjQtSOht1ULZMqkTwzTGxayRPHKm8oRSg4ybh4101ticCU/sdQ6ERA0gQCgbXUEEkFvSac1zCN1CXoXIKWz9rh1H9T03k/iKKFYREdv4xXHk0xiMSOAakx8e/ZOQgiQEGDIIJYxfZtx4WHWtOH0ZWJ8tpWD++kohPLzot29Cf+A+KziiFMQfXCKGKJqDOfYtWadlF5gw4epmCweJ08vv1Kmh+LIF4mJtTUfrJFute9zwOhfqUit6vNET/xeiqZPsoq43u/oNkbe2864VK9tf+gAr2lNMjfV5UDVUSMRSSuUPFnC+OLYm02H7Tr2nGGxGOtcC0plhKfafkXl3t+o94iFulHR34Z03yUcNYAbxwU5RBhpJbT8beJXhvIir7RfFnFUuRjKjbJ4KZHru2gD4Ah2doqVizaEyAmV+yrZ8RlMpDRxWGAJ/ba6RND0CHXvjCsKtUsN1+zlv7eGGdYnL39aU9585xE3UMxMN46j7V7RK4JXOe4O+KVrxcH/wVmgbV1svt9Lz75I5GCOLE4en0c21Y1Ntn6NteCcwObM5ANkdtHitoNlRXGDOZLZANRbXRsXDtghq02RK2Q3P+thCCkZI+r+EERysiVap/Hf0Bn5a2k/aRTQcR84JG2aUWYA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sc1VtjpRmo/cQ9LEL1smkLoV7bnCIDh8KN0VjRMTDswPGyUtnBPj+tSMBce0?=
 =?us-ascii?Q?nTDU4bEc1r3HC0uPfdf0kfRWLKaa1GjF6sBG/BqBW8FZylHJvrIGotp0TKZL?=
 =?us-ascii?Q?7NWbpAVEFMwUXAGlv/cep0iBLTBD6GfLUMWhxQDN736CBVHMU64jDuaVd7TA?=
 =?us-ascii?Q?XE2u4QwZhCpjdWmcFL5r+mWVCcqggwYsCplfwkIe3Jr+1w5WP+cC7d7+xv+r?=
 =?us-ascii?Q?YRzfzMu5fk1JEo8HC8VJoHTYMkwg0aA1wAwCnzXji9Pw3VsO6K9gN15iNSYi?=
 =?us-ascii?Q?PMYiLIPf0h1k8/60TnbKu3fc6JuRlOPS7/wYJLxyalTzjW7k9FCgZhi+svCj?=
 =?us-ascii?Q?RKhGmeN1tFiTC3BrPyl5rG3aWHwfMJxhfnTPV/1f/9WcIopm0gwZgvHiChz+?=
 =?us-ascii?Q?kpUPTFEzUCS6IQYUsZY/HfeuRBObeSXbFjGwGpfWVpgRXdgtIGobovTl6qPp?=
 =?us-ascii?Q?F+gz31+oRNUw5oHdTzoJNSpm1uqqlgpYm8jhfyxb2f4DG0JB7mL9oYTvWnLa?=
 =?us-ascii?Q?EAzlQglmO83GIDpQSpjHVeEn3Mcqrw9KS2eLKeDlYjh2V1WeilggwXWCGMU3?=
 =?us-ascii?Q?xGP5t5EozeAzI3XJDTwLyY7eQmmgwTg2feSxpfA+CNOechZUElaVfT3Mudxg?=
 =?us-ascii?Q?QYdaWpUnfqHGVJtAV6Aoj8+aw1+vNJOqO+Hrf9u3r5XrJK/W+yDg5vuyTwTP?=
 =?us-ascii?Q?DumXZ+I+TxO8QSKAOFSQjTHTWbPDWoPc6nFppLBuxCPIlkYkyVAlmdcJRpP2?=
 =?us-ascii?Q?K1lRn7tx4WYSl9GnX88dg9OBXgD+toXeJ4J1nJDtFs/UbESz/TZPSBLE9w+5?=
 =?us-ascii?Q?rYcMLREffnmes9RUp0lNtTSs+Vcn79QWrTT/WzBPNReKtKEf3RPEdMuPhYR1?=
 =?us-ascii?Q?vPYlUOR653Z30Jgrb2CUmat+yuamoxQZRtRktrNqKndLUn+c/gOcaBxEgbWa?=
 =?us-ascii?Q?/DyNabQ//1Vfy0+NdbgEz1NlBn20Xkgr5KVu9Lc124g6SVw5+IbWO27eh11d?=
 =?us-ascii?Q?g89EJUftXYVrAsEEMDvEnTnJMH5KdlXYhlC1VjJfdkVCQrUjf1Yal0/Qp3DQ?=
 =?us-ascii?Q?lFlCr/x1wcnBILchQlNEEEcA+vIRRfkY703J29NgZCXnq+42MrvP7cdNliCU?=
 =?us-ascii?Q?7mXFVUEXiLmXLSSiVoXOZhpe/ntHeY2NDzmdE5qMEjadVkaqqIDbh2RLHD81?=
 =?us-ascii?Q?whjwV3mccrA5rfjshOksmy8rpZQMlwVskcT8Q9SKJeaDcjrmeIT21z50LGmg?=
 =?us-ascii?Q?cegq/OX7PONmwQ7mFLoYl2eSnYV8tUJF18zNK11bjWjwTVhHWQfeJkumNHPM?=
 =?us-ascii?Q?ABb4BAkDsG7DXJ/8+jj9nrIAPhwOa0SRFsPVRQ2MEfuAWZ8LXaOmJ6qq//qU?=
 =?us-ascii?Q?x8Mxi/E3XGDs0mBq/vKUve9jt1xI/j0UOYJplDWyV1FbilRVHydHHtT8E9YL?=
 =?us-ascii?Q?l4N2ETr9UbREIvlPT0pHT3Lz5cpWafstJMS9lp8tJhceGxrzYfLYOTS/KNp2?=
 =?us-ascii?Q?jFZZrgOMj/L/yLgBUVbyUja1L+XNgWpo0fbQC++FMFuIrw4N1v9KP7W4ja42?=
 =?us-ascii?Q?DHmG2bbaI8CLc6D7iUCyPDP6rv7P7shoee7e4iFF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54be2efc-76fc-4b72-30aa-08dc47fb0a16
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 09:57:51.4840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uj78nqUgEJo8P6Lhp8CcO1vxXynHqdhOaP1Dsq8D/3icpRHb7baU0RNQNdsJItblleL5elyeJ+/jz6EaH7yvGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9011

Hello Perry,

On Tue, Mar 19, 2024 at 04:28:40PM +0800, Perry Yuan wrote:
> The amd-pstate driver cannot work when the min_freq, nominal_freq or
> the max_freq is zero. When this happens it is prudent to error out
> early on rather than waiting failing at the time of the governor
> initialization.
>

This patch looks good to me.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

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
>  		ret = -EINVAL;
>  		goto free_cpudata1;
>  	}
> -- 
> 2.34.1
>

--
Thanks and Regards
gautham.


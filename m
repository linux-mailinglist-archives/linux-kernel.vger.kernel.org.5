Return-Path: <linux-kernel+bounces-154944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1314B8AE359
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37C7A1C21E0F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75A675817;
	Tue, 23 Apr 2024 11:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gnBmmiEA"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466EB4691;
	Tue, 23 Apr 2024 11:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713870323; cv=fail; b=Axh0YdZyeCri3PVPOapJKD8FMRm20IOQfl5C1MMVa2x8dHcilrQiZgMqnJIfoKFVsOMIOAgEtwzTOpJmRrv6yfRxa27/cKJJ4RuSENSX7tCsVfKS98QY9cKAlS2ECjqOadtZNN/mEtww1rOZxrOiEqfv337gAudVx8vh6330ahE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713870323; c=relaxed/simple;
	bh=bhGmgZhiP+BXXkGi41XPkJMJ6fdQrggSMb8MQ+ak9zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pp2RUBlhAjin58eBBC/GcR4NEDuzkZfbRSWLzug0N8HzPoEQvisazP2TT+LhsynfIkV/zX0UJIE0+1RYiSe0YBLrtDsoLbovBWi8cB6M8QL2HGyxsk8m0c/lxBE6eUM+gz7kzjUYAtQ2AVEwSlA6GEhCdPD6q43Oy29WPh1MEy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gnBmmiEA; arc=fail smtp.client-ip=40.107.94.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqjnZee055PvfuSIULAW+Z18rpEr6jkLsV1Hyq6ZInCQsd2ICij/7jjZJIbLLQO8l06O0LevevsD9M9t7SZMkykUcBwIIcAdNBajd0gbsi9jSfz0rFB4+VXgElzY0GzZkMwtmM7oFg4Gb+Woo3lRhBtjJzOn1CGMPFJSuxv/1GJkTtwg03df8VDfVkt/1pt/oOYWMkIqEZHrdC8/TtUS6mhmNr1WZdlFntqlGTgWnvIpEIjOtxw+8/Sc7mmqxPzyGiUhv1O0crmSf3ToC9LNxEqH61Zui458VoS9tQt+qvlXb3LIXmQ+UhcvpyU5dJiIabOT5+B3P3qZwdaHZ4FlKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9ni5bApERoTu0pp2bS55Yzxu4ZnNT+MasxTbqH+bH8=;
 b=WQFcvOB6vg54oyboZWpWeqUmgml7vGpRqsFXfcQ6RuKUKgPDg41WZXNKTMWGDMmgITOzY1VC7Wq0ZMh3F+lI7iybsEIIc3lvEKN0ewveq1rIwVZ1RqYu2MP6uqyIWRejT72a9OOHekkyNXnBKRh3WjtxluhB3o2bfRCTWUhxlP8ino70b4zDhUMY6OJw5ets30B76TxyjQGCxLMG2IFmUaaOid4R268PhWxUz/mqWY9wV52e0cq/10XNMWh+E/kwirNW1m6Akk44ZSW0u35uXvfeC5w96T+cX4jstB7655yLQQASsoNnQTN1YpsGOfDOL2Beveue/iLnC7hK7lo+7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9ni5bApERoTu0pp2bS55Yzxu4ZnNT+MasxTbqH+bH8=;
 b=gnBmmiEA3FoLcnZMvJy1pE68B0DgtgD+XsthAx7JT+V5iVl/rK8WG8D0U2tZbre5cAhSutpKw2v8PBte8xN2BdFg0/3DqWXlaRSbTJGKXYA6ai7F/gp6aeqDcXQpfdvdJ0rm2Qp9q72c17XNdTdPNtcrCFhncRq+d17rYOWEgII=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by BL1PR12MB5756.namprd12.prod.outlook.com (2603:10b6:208:393::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 11:05:19 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::966e:5ccf:b22b:d972]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::966e:5ccf:b22b:d972%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 11:05:19 +0000
Date: Tue, 23 Apr 2024 19:04:57 +0800
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
Subject: Re: [PATCH v7 4/6] cpufreq: amd-pstate: fix the MSR highest perf
 will be reset issue while cpb boost off
Message-ID: <ZieV2ZgVh0LZISuO@amd.com>
References: <cover.1713861200.git.perry.yuan@amd.com>
 <3548a1e1056d9d08286da8ca1c68da23c6672ee3.1713861200.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3548a1e1056d9d08286da8ca1c68da23c6672ee3.1713861200.git.perry.yuan@amd.com>
X-ClientProxiedBy: KL1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:820:c::9) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|BL1PR12MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ceb0ae0-4ff2-4e71-80d9-08dc638543a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xv8qfjyv2Eao0V8h9xNW5c+ZI1E+bsV50N7q7D9ZiGDgBEKG+NwVvtzF0GgI?=
 =?us-ascii?Q?KPdLbaGgDfslm+iNzV3D9wiiT6KJN45imyAmA6myBjv5Y5lMiRUJ/3qXgymX?=
 =?us-ascii?Q?yGXRgvZh4ZKs4Rrb+9SlfHt2+as/r0O04SHYu0bCFT+907dOaGVoadey+Mpt?=
 =?us-ascii?Q?qclNZdZ0ZrPgsJOVQbyEdJ7V7JNttGxUBpEst6acEdJ3wYHQ5QaeT7Rvyw9r?=
 =?us-ascii?Q?CR9yy9Z86OMuLLN4H0DMNdeSfNSIRbdfCvAUl9UKrVCbDYt/d2WCSGe/WtpU?=
 =?us-ascii?Q?6ADgXZ8bubCu/xnxp/oCeuCG60r5cH5U7nkQGLMw9FcqhCVwWusGNDPebY4M?=
 =?us-ascii?Q?X3HudRTOHamlbPC2YMpjBDTsue38b9RLmpWx1bozxr4m02/pldCpxi4GlYhL?=
 =?us-ascii?Q?tq2SFn8j4xPUSCd6DwcDoSw0sUt7skEvEsU0IChh5QZofyT8D03OzvIhMP9R?=
 =?us-ascii?Q?cRV75HIUdb+8lu0t/S6h+aKCzw01FFaIfk3jqn8nukAc0C0l0ciTELw98clt?=
 =?us-ascii?Q?zC9VgZZKyJqe1Z4TJEP703XvnoMu2n//Yf9HTkyl9vPKElFnJYTOoob4g0VP?=
 =?us-ascii?Q?YZ+oQG/SOEmR6TFMn1t3sYL8X8K83cZJb4VbxzGYOhe17cs5oTIplLHcIGRb?=
 =?us-ascii?Q?Oz0BNGxR9fHJy88Y4pJjW9oBocOmVU/PUFUyrt+0LAHCb/5EbVz2lDBMeW4F?=
 =?us-ascii?Q?hlkT7owGi3e3zZuDe+7XM8qkRq59EhcE+mENOZN8mjMGLcgVQ6OXma73Ma/9?=
 =?us-ascii?Q?Mdzum3D8wgdlkCsIUgjs7bnANrhgASeFb/+oVJFgcdkWKwwS95NAPEktqr9M?=
 =?us-ascii?Q?9dfv9yCVK9273yZR9nec5oiUYGTM+atUYaZ0q4sVxVE/AeDDdb8QoAPR5F3y?=
 =?us-ascii?Q?TR61XmnDUgi5mhkK0iq9cibBW4TOJ8mb7kFtXoO+BxxJc9vAoSkSfnv12144?=
 =?us-ascii?Q?Myq8YHHcTXOn7ymrxn8DkkG2ITbWbiE1M8Zc1vbjJUuIY9XdkcPaVR1R4Hp1?=
 =?us-ascii?Q?1lWzQmJfoibajTjQnb/fMSA90uvXiWO6ujONuwalcjxkukemcHPaBBDwooTI?=
 =?us-ascii?Q?5fHGMSgyFgtZeb6sF92MhFq/K3BhheqHLy4nME6uHrbcUFNBSVXEYeMKQUme?=
 =?us-ascii?Q?7uu/FjUMI1ftLdKxXOtadnFh0xSETq4i/zTyc/Oe9qj04DoCAmqeNAvv4AJo?=
 =?us-ascii?Q?DwymdFttauh62ucGratQ3eZ1/lv5uRBfkm18cDMJofsG+0eRMsoNv4sJXCq+?=
 =?us-ascii?Q?WRQRBTgI/G7bVkDFtGuxAEUJJ0In3ISg3ZsGhV6/Wg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8690.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CnO0FdP9jLsJDsKFxxcuRalDGmIpC8PVWH6kDxbnHtmkWV8zj4CsfZO4Vwbg?=
 =?us-ascii?Q?+UchQvgDz1q6N67f/6g+ee483Ksr+C16i+yJa/KiRLuX/VyeeyIYmHzol/3E?=
 =?us-ascii?Q?fOBZlIa0zBZOp69pie01ZMlEoKpOARn1oI5DP/UwWb31AXeuUMX1zbFfuuMP?=
 =?us-ascii?Q?m/O7qVkEX0QtNHdy2HcrWEH4+S8Xb2JZcIqBdf2ASgPFsHIY6jEDKVh44Rn9?=
 =?us-ascii?Q?a571Rt6XXZpiadQmO99xrOpInTyOd1JI7b3kv6aIJwYlsBN1CwZur7ztTSgD?=
 =?us-ascii?Q?MO7e1I8uRlQy2aW7CQxyPirHEoyLA1c86mpBpwX47/kjsaWBtdHfT8+fW9m7?=
 =?us-ascii?Q?ZhddpEpPhv5jlhC6IdseXL0O7e7QF/Kj+1U19qASCO5e9bsLset93M90WycL?=
 =?us-ascii?Q?/uLJYgg7c76Y95DHMSjVxsycZ1G7nDQFFSPZ8TBrb/DqbpLr2nRCfsdhd4l6?=
 =?us-ascii?Q?WYRBCj1RdCsye5+PINnEjLoXUKwwcsEPQw6+FuAr7BBB+/FNoAbcQiKma0Mq?=
 =?us-ascii?Q?CqntHAE28SvpkspH/WoT19f7x4vtWrb7dmFxtDtT+W9miQ0vDRkJJh3KFyOW?=
 =?us-ascii?Q?gBMOB1Z1aft7det0Xu00CHiPSJGAJMx7gc0ShRVK5VKMMuMgT36xaADXHBy1?=
 =?us-ascii?Q?a8rZCRdXlgsUCDKMl0VklNYu9q35jlVnYSPYmei5dxkayNF/wG/tU3wh9qiu?=
 =?us-ascii?Q?EcQrwL8+xeRCSzzuOsXwdoaPx2Yyy/v6Uvc611pmA6d0IJYV7V+8E95hsCZS?=
 =?us-ascii?Q?hdZir9iNOh4KRyaVYhx+fnOuz9Jg4fj/e/T9I1WSU7g8+PPf3sKw4DvJq5Yn?=
 =?us-ascii?Q?dt3IDPZuAZSflh4HtLaHbvX7Fs9QHPqYqPBibO3x1KlovGZ04qM+agATS6S5?=
 =?us-ascii?Q?cEWNS3grSqa6J70T5wXhnuDnYRgnhkqlLP1FA70yPP33NvF78X0z84p7O/QP?=
 =?us-ascii?Q?rXpr1tRafOI6b/rDC+WwNwypIBKdn243rrrfESvZJW6h29ngityY1PlruduW?=
 =?us-ascii?Q?/jCRJk0nexclo9zsyJKQKv8BItav9YnkbolFWI6dpuVrj9kEmb2Kp2USDdYo?=
 =?us-ascii?Q?KHg5TwB6w6C1EOm1tQR11AhH/L5rZ/uN4QBOJAKI6dKISjQJOnGSp/Lg2hvk?=
 =?us-ascii?Q?goPJEwKliBaFkAqhQjeDbuXb1ei8QQjXveKpFpZOcdoGUweEjBxKAj5ZHVSF?=
 =?us-ascii?Q?I9jHE80qzOvphd5B/GetSxFzkQO3fKgHNd9VY0gLqTWZEES6dP23B99eUqpO?=
 =?us-ascii?Q?JoZrStE89NCIetBxGWjWxJ8r1C/V8HZZLu0MbjkQ77ofhqycAfDtVvQo7Z5N?=
 =?us-ascii?Q?Egum9fmp1POrxb/CqWt011A/U68NNJy9pJ34imXOTZyswmzEPsLm9ZTGkdqZ?=
 =?us-ascii?Q?VmmVijMYLT9dMstrM4w9lmcOp835fHzgYZWhb713wz/kWxqHJ8QG9t+xYo19?=
 =?us-ascii?Q?nZDSUVSGZnYKmqoKRaL1C9JfBXkM59i2ZklscL+4nIdhCNMazBd1CGOr/gYX?=
 =?us-ascii?Q?Zj7/+Uom7VR1UvzHAQ2MJUZ1yzrWDCGAHK7jBtDSZVimhCLCC7hHzBb84xRz?=
 =?us-ascii?Q?wKC73wGWDdGefknB8oj7ReSMlGPA1wQPJ11gAGyL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ceb0ae0-4ff2-4e71-80d9-08dc638543a2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 11:05:19.7973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3cjuk/2kmBgjHAx0UAGFE/IA8OsZI8u8cOgnMspBCkqII6gqNSeMenApwbsverOYIQi7wv8I8i6XvD/FsDDiEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5756

On Tue, Apr 23, 2024 at 04:40:57PM +0800, Yuan, Perry wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> Select the min perf to fix the highest perf value while update pstate
> CPPC request MSR register, here we need to limit the max perf value when
> CPU boost is disabled in case of that highest perf value in the MSR will be
> reset to original highest perf value which cause the BOOST control
> failed.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/cpufreq/amd-pstate.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 49eeb38fcf20..22e5b84dbe28 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -476,6 +476,7 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>  			      u32 des_perf, u32 max_perf, bool fast_switch, int gov_flags)
>  {
>  	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
> +	u32 nominal_perf = READ_ONCE(cpudata->nominal_perf);
>  	u64 value = prev;
>  
>  	min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
> @@ -495,6 +496,10 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>  	value &= ~AMD_CPPC_DES_PERF(~0L);
>  	value |= AMD_CPPC_DES_PERF(des_perf);
>  
> +	/* limit the max perf when core performance boost feature is disabled */
> +	if (!amd_pstate_global_params.cpb_boost)
> +		max_perf = min_t(unsigned long, nominal_perf, max_perf);
> +
>  	value &= ~AMD_CPPC_MAX_PERF(~0L);
>  	value |= AMD_CPPC_MAX_PERF(max_perf);
>  
> -- 
> 2.34.1
> 


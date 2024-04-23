Return-Path: <linux-kernel+bounces-154948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6537F8AE36A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6841AB2441D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E5776C61;
	Tue, 23 Apr 2024 11:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uauq6dbL"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2069.outbound.protection.outlook.com [40.107.212.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4556CDCC;
	Tue, 23 Apr 2024 11:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713870461; cv=fail; b=izoukesfJDTgeXCWn16PfCjAUGTXu61Ug6P4mvuc6EfmfDzx1M3z9ZcroVII3JgpFaiifTNgdpJQcZQKxa8mB5H8nomjkP9kB1I6GgyyadTaP5lwmq/OhgydwIXiavaOwGKjsk1m2pr5tArqkDCWziV/90AeZGAyJDWkT7qA+HA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713870461; c=relaxed/simple;
	bh=JosERm6nJ9ODomcQN3GjYHdkgVzb/qEGcCH0fLSwokQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZtalrsS03yMxjoqaKj8aISlgTUSELRcBQz+PNhVzmkjdZFqU9e1M1OVpBa5UaZOY2Wu0vZQDm9vJ5fiNwiDpKEf8flBY428fQKAnUbQN7Adzk4lhJZThahkD1B1sdpC4s5VkQC27ifLNBSyHuXAcKf1vMh11f5hQ+PriwTouBtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uauq6dbL; arc=fail smtp.client-ip=40.107.212.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzUpBxNfwMmfcgmMB3JIRRM/S/ZrF49U3tkiiWE5QqS62oxzDkH++tpyBRsyvfz0UJDFJ6djmk9ePpG3xYhW5ryXrFETGsCNpe4a8HufLe+PhNtq7X8/HZob7zXvfB+AHDUxiyPyJbUiugOu79I8QFraAUp2qGHYZaNt/ZKSIOMOuFWseRtd0j6+5uhAGZGmtBIuBFAoXvkrRCVdSGlFP/d9YeD3kSGyyoT75KhiRFryJcl89eY/lRXs7F+mt96/iixnWUL2wFqT1zIt8udIrY6L2be366MM4iI5cZiBK1mRuOfuSj7EkYis7Yp+OEeDZvjPSrQb4iGWao7hHpyPAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3Uf7hfjOzGuSG4d8WyJZJEqZhp07Y25u6UOyEBUwcc=;
 b=G03m1x0HKzXI1P+4jmzmhAVHbmWXH7LYwqRbPCa9KCNCgZdjFPDkGj/lMkFBjf+rIe/Vbi8GG5kYiZh+/BUxWx38CGX2CXfJkWyQZmqGGUE5N5ke0yfiWzMYE6PJRpHEGJdEyF1zBfFNbKBmMuIu68GmEdviOvIphfnxNMIQOtSLopzrp0d4LG63T65yMeZpwgD8b4iAU+c+rvL8dP4jZDva7qXx+fNz9N2W+Mi90Jl76KfZ+ldnXqTDnsW6Vor5UdIouG4/GSy4br8gb0JNA3KeyVoBCt8JtT8OZBpC7eNwwdinTJa2JJ2qThOVaiy0ZAhWAjq8LkWoC+MCFx5KcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3Uf7hfjOzGuSG4d8WyJZJEqZhp07Y25u6UOyEBUwcc=;
 b=uauq6dbLWIH1wOqzuEW0v3eOlXvmhBKqEDbehk9dgH5BwVscIFLtb3ScQUrsuV4lFnvoixJMY0TdX10cMw42ouEtLhH1S5dUlO1BPFjaX5RF2/68JfcLkwtx13dDen93GtIKzPjHgSftbFIsRecdm7MIQd4YzVLeke03X3z2C3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by SN7PR12MB8129.namprd12.prod.outlook.com (2603:10b6:806:323::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 11:07:30 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::966e:5ccf:b22b:d972]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::966e:5ccf:b22b:d972%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 11:07:30 +0000
Date: Tue, 23 Apr 2024 19:07:09 +0800
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
Subject: Re: [PATCH v7 6/6] cpufreq: amd-pstate-ut: support new cpb boost
 control interface
Message-ID: <ZieWXSG4MY5QJSl7@amd.com>
References: <cover.1713861200.git.perry.yuan@amd.com>
 <fff9a75f745ef10a4e7e9b0a9b383655ebb0cfd1.1713861200.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fff9a75f745ef10a4e7e9b0a9b383655ebb0cfd1.1713861200.git.perry.yuan@amd.com>
X-ClientProxiedBy: SG2PR06CA0243.apcprd06.prod.outlook.com
 (2603:1096:4:ac::27) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|SN7PR12MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: 0699af97-9bf7-4883-5692-08dc63859165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ISXKaMexEk4DR44Wkei5aswrARI6u26msIl841FKGAcywKik+vmwjDroCuFP?=
 =?us-ascii?Q?itCjahpD8c/Odh4kYqwOU2eFgeRbZkZQestYBfPz6Gpz+vb1TMuqN6XQOAA7?=
 =?us-ascii?Q?C4aiFdGRHgMMeWgQA0DsQhX/oWmb7emmQa3cNTF0Sx68SXcrYdxJH+MBHwUd?=
 =?us-ascii?Q?mnWEGvekB2q+V+UUMPxfbImqOcoZdh+5/TJue2DYcVjuNGGi6/KCznHCUbNn?=
 =?us-ascii?Q?/KpNQ6XeqMWKYBCKUIws6ayNq1kOh9QZ13x5bEiKZHm9aAn0wQf4Oi2sbhIY?=
 =?us-ascii?Q?LK2vMnCPeKdmC2YgAO444LLnYHYckWp7RozxlyzuhpDvUyeLUr5t1DQ8lgct?=
 =?us-ascii?Q?t6bnALtJDqIRYPJkXxFThtaV33OUWMagVrLqyD9xE/svHIIRiCi1zeIyJ5AZ?=
 =?us-ascii?Q?4sirkO5GDVWjLBEl1W5T3kQFJZv03VhWcmlmQL3dIWtYSmXei2cYZq9nTNYj?=
 =?us-ascii?Q?HkX46s/suiQ1Rt13lp0iBcz/bg9DE8nzn3a3TKvriGplpe4UMsKBqBhakudW?=
 =?us-ascii?Q?n96RUcljY5K8MKYLaJ75aPd+1uppXA+x+Ox/YIUrr8FrzoPseUqiq+Nu007Z?=
 =?us-ascii?Q?03ie3QnUy76xeEzbnNO7zjNc1KHeKEKrpt3sTVyHOYxfF9Q3dxUNT8QeJsZO?=
 =?us-ascii?Q?c6b+bmS/k/P1XR6tquu3nePuo9E4XbkN9zYuFbXjHLsfDugmly0WrpRZwAcQ?=
 =?us-ascii?Q?eZWATe3cKGfk2cRIcaMPoHwRAuJW9prCw5yjaMbOarsRwGXWM/wb27feCbRN?=
 =?us-ascii?Q?kv2ChCBHk203pzfjxcBSvJVbw+GDce1acu72xYZ61ER6UxYnUEpcxecCcQk8?=
 =?us-ascii?Q?nisdcXe0mto5C/mhbmIRzQhpcqsoI5Jiu00ZNTuunv9fMeS3XEPDLSZUEXZj?=
 =?us-ascii?Q?qO9iakFw/LV70ifcEKnk0/5GYXJZwG4RBU2j9fYigDgIPu1ADBftlxtQcaNJ?=
 =?us-ascii?Q?2mMhU5FJatvebCu1E5uuDNsD8BbrkzbxfFMajHzRYOQM/r7NOzrXpZyCDGbs?=
 =?us-ascii?Q?JBQm8eGngfkVhrN7H87QHDZtKyy7BUM186AFZbHmhU33hQ3XOsZNtu92Z5kY?=
 =?us-ascii?Q?5GgAP1XWD9EVGcBgl0gcsbycSFuPh74oM0u7GlBmZeaxdK4NNRMpGg52xZTI?=
 =?us-ascii?Q?UOz0v3rV3p+ybtYbA1/7Kd6D0AsmDFB/zVB/D5YNmeyNfAabuzOzttUlymax?=
 =?us-ascii?Q?3e+CA13Pe6pqKK7jEtnTqpEW1oXu1HTmPaulZPS2fWMCGk+7NVkrQapEl9CO?=
 =?us-ascii?Q?ZFTsu3xVD3g3Mx/WXjXbjfOwFfwZfF13ygRBDn4WXw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8690.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6tzPRY8h+Wn2+aED+bDjm2z5EaVTSWDb/RnSjuXN2R+/to0WcInuy2mPFwBc?=
 =?us-ascii?Q?GubLQIOuG++YwA2tApWgJRyDJVAp0bDZudcL72MooZLuZVrzkWyb3/gPWCVA?=
 =?us-ascii?Q?gKtQJTzunyMT9pB30GrvBAnU7JP04GBv8ndKn2WPOQemU0nmj5XuJEWuT3w6?=
 =?us-ascii?Q?9PZ20uej4QP+XRpGX8QZJ+7xL3ym0remhQ/uMW/r2dRNoB7oDew2YTmDit1O?=
 =?us-ascii?Q?RTUXo26JvKdx08/cBCOOREjZ35hDOIS8Q9DL1qzfhe5x2f0ecnSaqamYICbs?=
 =?us-ascii?Q?JgciGc8RDS9tSWYRTd96O8mb5TjsKBZiYSAKu8Bw4s+EalZEfctLEE6IH+82?=
 =?us-ascii?Q?FlatfI+c6Vopuxed4fjy5YU5pj98ie8MN4ab4qZjDS/8sSaETfaqIlUEg7ko?=
 =?us-ascii?Q?DkHkvASm6vbnv/mzHwTBtig6rGSx1Y9EUcXxsooatj+wNb2+6KRAEEO/Zle9?=
 =?us-ascii?Q?06/IOCaZ4U/dEEoRmle/k/nV6s1+SN2npmemFNjXk9g2pbc7+WXVzxh6ViMP?=
 =?us-ascii?Q?T+9el2hr28S6mymMYZhpqsjjuodoUrItSLO8uk7PAP25ylzPRDaQMkKNXqfr?=
 =?us-ascii?Q?JwDDp+fB2l1F/A+6AumXThmY1LdMbDL0Em2cqiUMmSI8RaHG98aBVaOmWzXS?=
 =?us-ascii?Q?I3BoFM9j29s8hvs+G7TkxveO/8YtWZaZT5yqs+IzlqqdbppaN5hfxQzy8c2f?=
 =?us-ascii?Q?K7v9zlrN9bEeXywBygpwl821ogKLhcikdofWbzyJvDiPo0L7NCTm8Ar3pjjo?=
 =?us-ascii?Q?JvfW6VSl2H1NyX/ICV8vZI73+TWE6gMCfrhiQfT+RztFiIoCrXaPu4fTGC9W?=
 =?us-ascii?Q?MkvbsGllO00uykSH82nn2ZHX0X/hoheOw2Nh3uMXLiIvH5J5PQlHGFwWOn32?=
 =?us-ascii?Q?xA4J+pYeC29q/ZY29Q+aiYNym6BBTpLnCVqDcMcFLFvIq3f/ruNl5SNAK4fp?=
 =?us-ascii?Q?SpXLVZbPssSpOO/yA+k3GxWwhs08iwGB9EiltEaHZASTdrhn3CQPuLM6+k+g?=
 =?us-ascii?Q?YPtZhFeFsXBCNHw+AhJvZWtZ5k5BXdfi0XN7OoNefCFG0WeIqUMTsFXUGj2F?=
 =?us-ascii?Q?uMEe0W2LOOY4t/JRWAVQLpLdCpTTMaBEZgAlgEsTnQy0cKz/dfyyk1zHOzap?=
 =?us-ascii?Q?0HoI4lMQZLiBR9MQ4MI7LAdLrM7gR15P0rnQA9BsOaRocfeVvDBpV3W8ddNQ?=
 =?us-ascii?Q?4D4eHBMcbQ4UwcTokuxYwBPsxS7j8oDCUj5wNtN5o1QEc51HME+F4obqcJxL?=
 =?us-ascii?Q?9B6h1FCA/qOxF0J5hy7h0TAR2HOKWC8OtaRT/OihAFT6eP/idfCMhzSw33aQ?=
 =?us-ascii?Q?+0DTnR2MxtCTq3Q20ILfOvk4/6LNTMuDvNPdjsm5g1jF1HQWzi8A6tGvUxQS?=
 =?us-ascii?Q?k76Aw/Se+o0i/2TdV8ujBfy1WGJLIZDn2OuAbuw+Up4u0LrRFlSYYlf4qaV9?=
 =?us-ascii?Q?uohVTzO53yOyglayX8M7DQA279uvJfeaUFkIWkyVoDYSUfK2E6u6HX0ZTMjB?=
 =?us-ascii?Q?qvTNgQoXiPf4emdRk4w0PDotyU00xpSFrJXq9LSsw9ipA2z4F6ErAnXLTVcp?=
 =?us-ascii?Q?cyN4vBZjLQpjpdwbmdmz3+ScpfZ/I/yeQMiVF3id?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0699af97-9bf7-4883-5692-08dc63859165
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 11:07:30.2409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JqvZRJ6QBEUkZkvigsrMBGEyUUiiU0b/JcmKVhrOVhRMiJolg2ygckaAq0bfEGyi/hANxSAqtGAK1zGfRhC5pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8129

On Tue, Apr 23, 2024 at 04:40:59PM +0800, Yuan, Perry wrote:
> As the new CPB boost control is enabled, pstate unit test needs to remove
> legacy `boost_supported` check and start to use new CPB boost control
> interface `amd_pstate_global_params.cpb_boost`.
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/cpufreq/amd-pstate-ut.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index f04ae67dda37..b3601b0e6dd3 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -226,7 +226,7 @@ static void amd_pstate_ut_check_freq(u32 index)
>  			goto skip_test;
>  		}
>  
> -		if (cpudata->boost_supported) {
> +		if (amd_pstate_global_params.cpb_boost) {
>  			if ((policy->max == cpudata->max_freq) ||
>  					(policy->max == cpudata->nominal_freq))
>  				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
> -- 
> 2.34.1
> 


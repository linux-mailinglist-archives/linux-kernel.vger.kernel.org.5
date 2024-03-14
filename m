Return-Path: <linux-kernel+bounces-103089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 799E487BAE3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1264FB232DB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726EF6DD08;
	Thu, 14 Mar 2024 10:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Co4ufkhm"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E897A6D1B5;
	Thu, 14 Mar 2024 10:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710410561; cv=fail; b=MZl7lDRsXpQh1e+8pa04khlazPKxIXMWAy8F7QJTcUbP/LpHI6CDJaaWK+EUKdeEtR13HlLM8wo6CC6gdKofa9D8JmhCw1BG3nU9BSkzAPOZMNFuhn0eKQQKR7aFUkP1cL3DuuzPFdHOwhBHQscdl/UWfEFhYGvCxb278SzYSIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710410561; c=relaxed/simple;
	bh=aZ7cCVAi/xo4GZTShR9Kh+jhb/dINtdLHIV6l2roEyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ti2qhM6Ja61qZI8qYXQTrKcr5QAnWU0SjQrxz3/j3CrtLPQ1LDbAw1g+6aMdN+19qlyjG1tDjD5XwxAXqzucM0rW63QJj90rM38U+EVZqKwvKesdOvjdaMZurKqG4KtGQOI+yaJJObSHQMC0sT2CDMFur5ftd9Ops97jmJdlGWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Co4ufkhm; arc=fail smtp.client-ip=40.107.92.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKUnbraRP9kTD3iX2ZBTIFvLxDP7SVLiBBkKDNJErJhJ3Zi6HrrKANKDaaitXJnYugZFahMzCOXAothLWQe4+UvQlYSNaGM09AMyB8vShCyMi1sQYIjjMVXfJfILH0G86uL7Dyw0HvTV89fiCUMYxNc2CG7+kK9C/oVXV8ht8zFngfNR3DtunFSEZOCsI/C2LvaDTV/ikgunD2zmjkz/Zkj6w38LxmHO2kkMmjLicLK0I4CzBqy4Z+RNhBzJEw3CTa82/4gYSYruXdQimC0iypNgYdbZow8xlT9BaR7FBNugb9eJzktU/UvPkAIGaccRuuxgOq5OcXtS9wCZy5vgMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TDLKBxaistb/nRzpTbU7DdreRNt+t97NsLcJaLCB/o=;
 b=NXOusTjmlaijm8e73Y2WPFR5PLdvZC6y3WsVgIyDEdDtGUmVwDATby0IqSTWs6ci095niiiJSr8alvowetad7zVegAUVK1bZ+Q/oZFeJsT6zZkH7aVIJ82ZzSNFcYEBmuXu/oxmPrHL8mAUEwWo0cAWh4BgDwglW4K0UE9C3X+PeOmUXfL1um9CaITd/nEPanKxsWgahCWeRHIr8dpecSfqthMjPKiKadm5Ht++zz6dzQkTyv+6NkCstclbEgEEeZTxsUtnbuXlzmEcGpyg9EHOe/X9evn207NF7oLVmMCi1F7qQ0oPiqVFgk8czXDyaJbNteEtQzMcVlPElQpLAWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TDLKBxaistb/nRzpTbU7DdreRNt+t97NsLcJaLCB/o=;
 b=Co4ufkhm6MRWSgmYHZQ18kHHNpPpV5cx8xptmQBBKHmTyFPUsiCNqcEB0lKKO9e4sqs7hRyl/F1JlRT33/BUJXpaMaEPVJw4PNFj0swBIaD89nDcM3j37ip17vblXpM3XmAQWAPaMCtbhPNjDTzcLfH+3+3Miyj1dNL6SW4D+pI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SA1PR12MB8947.namprd12.prod.outlook.com (2603:10b6:806:386::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.20; Thu, 14 Mar 2024 10:02:37 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::d725:ec0f:5755:769b]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::d725:ec0f:5755:769b%3]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 10:02:37 +0000
Date: Thu, 14 Mar 2024 15:32:27 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Perry Yuan <perry.yuan@amd.com>
Cc: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com,
	viresh.kumar@linaro.org, Ray.Huang@amd.com, Borislav.Petkov@amd.com,
	Alexander.Deucher@amd.com, Xinmei.Huang@amd.com,
	Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/7] cpufreq: amd-pstate: fix the MSR highest perf
 will be reset issue while cpb boost off
Message-ID: <ZfLLM6IUr7vJB6Xt@BLR-5CG11610CF.amd.com>
References: <cover.1710322310.git.perry.yuan@amd.com>
 <faea296aa8eb87374d1980e68d4fc314a48b1453.1710322310.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faea296aa8eb87374d1980e68d4fc314a48b1453.1710322310.git.perry.yuan@amd.com>
X-ClientProxiedBy: PN3PR01CA0081.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::20) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SA1PR12MB8947:EE_
X-MS-Office365-Filtering-Correlation-Id: 12b7846e-e43d-4e7f-c615-08dc440de04f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2M1shFVPRZohoVRTzUXEfW4VVwoJcaGGmX39s6qlZbigX0dzIZebgoz65mA99MVk+kBZs+cuEeNyF+Gz+x9W1z8v3rG1D0HL3K+ghbTgwpjiMcM8z+UHgUfloo/q6vTeHBgQWSzQkWsvxB0551K85XBHHvatThvyoEbeCXPjd/5KGsuLBGC4MnPSTwqkJdx6gHFXrx4XGPFdhN2uXkHIsqDlTRkeI9x+qZy1S/DCfT+4Dd+aGANGW3OHDpxQ6CEol9Hv6LMkA9UQ5gKWtnLFoEXvLCQ3m0Lb95pxLx4/rRoyg3whulbCNCTmSriqtx7brf24+INdFMGzx5sVyzmSEvy4lKHlhlAy5NytptQl/cbZCzhDb8PXr7SNKCf5QxTbnDjnytj75ICLMEgChAjag7w85Yb0qwYlcrNNnwxFVRPtbPVOaG4AN4VdwGdpWqUN/eq80WRLYvdG2hMF9YQlOvIt7uKv3Mq1pq6Ni6WjdszS0WuWf4/zhGhT65G+dDL6NTYjE3DW3bxOPAkwvXVoCET7/TC+5PQtMgU8CL8eOLOSo/ipXbcHgleRSUXh9Z7OLb/nllx0GxVtzavC4hlqV5eLerkyx/FAyBaRiXZ9DreNwPu2uOdG3h+DANNHYlB2pZlZV9HoVGE7V4ZMm+HAc5CV4MeFwHOpdsxnZfrjkDc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ajf9JnUE163yuPSINAzcOQknAtC0HFCQGYrxk5jcs890V/8zY2Y0VE9iSqq/?=
 =?us-ascii?Q?SmV9f0QuwjBijm6flZJpsfSwn19VGPOyq1ib2pq9fBHyhze+v0orgC/hv/2D?=
 =?us-ascii?Q?NA/O5D6bRGfVXir9VZ8RbL1VqsS0qdOfjhgBK6r+OOMbuo0StZ5hHsIgOojv?=
 =?us-ascii?Q?ON8OHQJGLE0FLl4th7MKgOTJNdyONTWM1HosEVfO8hsEZkncVRLAc3crPTFU?=
 =?us-ascii?Q?F959zj0YqJBsF+BAVnyqGV6O6hGTjH/pUuKFNF0Mp+gLZc3vu+ZPzjRzRoCI?=
 =?us-ascii?Q?TTSDYi93AiBRPdmpc/YPxTWUivSqxeya91ysedrCsjHRaBTeOBy5J063qp5F?=
 =?us-ascii?Q?9ECUhaXWbX1ubHGGQv3WAH7z65x54XHjKH71bQSBzYEZ6t9CIXnfffTw1ijN?=
 =?us-ascii?Q?sgGqnj0i5V/Arjo3M3wkPheHeqLOc2c3E3VgO9U2AbHZTuKZWM/YVp8wVrjL?=
 =?us-ascii?Q?3w8R9lyS9JTdjCOlfbxNgb6YCOUcWRbB8kSah5nvd0m246XmX3qHHc8BZVnD?=
 =?us-ascii?Q?XLl3q+QLCkvjpHSzSCElDvUZLeahiwcqvcV2d3YIfaPhB2sKaC3KxUVRt4lX?=
 =?us-ascii?Q?cOdPIEjBVmxsaRyCxEkT3ppJErtWBMxD5FbFkH420x89fy043NKSYNRNwIyQ?=
 =?us-ascii?Q?DSJ9lfeBNuLGhLhxvKC68lKDaEbvFbxQM/BJsW6V6TxPIFJxmXNARZFWiHHR?=
 =?us-ascii?Q?RbWhxXGfaoKmVnpqeM8SHACojI5TFAHLjy7l6v//zKSHjwPaCPhClElGxWqS?=
 =?us-ascii?Q?u1KO8s/1MCv+Ji2ScC3PHQWNIP/oD4gaTdWTKhvXlFjgGu9hpxsL2iaX9A3o?=
 =?us-ascii?Q?eq9yHZh+khQdVUlaS4+4UxD0d57qweWCAhmZOkQ9/pnWZL1AKBK+5wO20p4m?=
 =?us-ascii?Q?hWapVV9sM4P9vi4GvPCerEJk7HUKRaRfWTM6Gw6MSPte5VSdFbjJITzuHOKb?=
 =?us-ascii?Q?YgnEVVJ65tsFL3wEn1XaPpKp+xxvQxtyHDDQclHKchbnsNOoEeIAPSWVih/s?=
 =?us-ascii?Q?y6J1aHTFf7JZuoCr/ZkpoopWqHASYgrWpTx9RqIhpVEvAKm32iz6PRY/HkDY?=
 =?us-ascii?Q?L6/8FufSd9ugQk74OBqIvIUeHOuAO43vgfSiz180knj918qZcsIE168QaqsP?=
 =?us-ascii?Q?J5EyTIHyKj7P6Z+c24bbU/2s6qf90M1fBrGw3M2iNCF0MDbwcfGQ38UgwHWY?=
 =?us-ascii?Q?aA3zll9XPFUXCwn+v/TjQoChUbzfTM9t8JSbN/7qdZTIW+uUV55Wemvxe4Ka?=
 =?us-ascii?Q?DR4tLl2oE7JRwieF9HD8cErthV7YSFPX10n8jnZsF1RihWZNhjD3wwqKpGi4?=
 =?us-ascii?Q?4rBoG2cYEk9/6XaYfr0My0NXJ2/l0HDJ9Bvl9YfepJz3nX60flznexDO3qS0?=
 =?us-ascii?Q?UikNv4mJci2oESHUttqxGl3Sf260IwNLPNbhiFiTR5hCUq7mp8tAYj1JUr51?=
 =?us-ascii?Q?9JloE8lcsj62z5omAjZVEAg8nZA1d4Bsblf1nsnphtWPq3NhCuC467mjw4Mi?=
 =?us-ascii?Q?XlXmHUwJ5BLC53ZEsId4j5TMnVUaF//WvT3dxgCxP3ClcilP6wBG1yOa4h3m?=
 =?us-ascii?Q?Z2qN+cUowKyrk1JWWOFecsohTWSFRh8LhTxVuqb2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b7846e-e43d-4e7f-c615-08dc440de04f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 10:02:37.2158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9tI+WV8f5FXIK2FIIfWOU7Oq2ELg1FMjWNHBT9Wd18NfHBYYLVL72ChbuADDr9VL4JeEATAyvgkkumORHdacNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8947

Hello Perry,

On Wed, Mar 13, 2024 at 06:04:41PM +0800, Perry Yuan wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> Select the min perf to fix the highest perf value while update pstate
> CPPC request MSR register, here we need to limit the max perf value when
> CPU boost is disabled in case of that highest perf value in the MSR will be
> reset to original highest perf value which cause the BOOST control
> failed.

From the code in this patch, what you are trying to do is limit the
max_perf value to the minimum of the highest_perf and nominal_perf
when boost is disabled. A question : Why not unconditionally set the
max_perf to the nominal_perf ?

--
Thanks and Regards
gautham.

> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 0965fbf660dd..d7afbded6e3d 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -440,6 +440,7 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>  			      u32 des_perf, u32 max_perf, bool fast_switch, int gov_flags)
>  {
>  	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
> +	u32 nominal_perf = READ_ONCE(cpudata->nominal_perf);
>  	u64 value = prev;
>  
>  	min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
> @@ -459,6 +460,10 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
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


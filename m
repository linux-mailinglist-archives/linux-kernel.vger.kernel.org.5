Return-Path: <linux-kernel+bounces-83640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B471869CA3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A57B11C23F04
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A0F200DE;
	Tue, 27 Feb 2024 16:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bUYJW9la"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E991B1D698
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 16:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052337; cv=fail; b=tGQW7fvIetpEHYNJeIV0k/ZNJWGrp1FQuSRpEMV5Fr+CzqXXCIhO7WIw00ho7hO5Pnm/rCSltgGSSZma7UoS+7fLH39eL2Klc3fugSdMUyB9oWd+9cBX93KrkjVCcUkP8/AyWSRBMEDJHB9GEdn7QosXqjg7lgLu/ZUhfx4GGAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052337; c=relaxed/simple;
	bh=dih6bjlTtugnRZTjrZOaSW0ioFcrfoPNr7mrE9/4PfI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bpyPHkdvzrdYGP4TJKJtFYBdcFQw1TkhsqvWllfCFRcvRd5t4GexAzGnDQmCqs8UX2d3gq6b7gmr+vswXmvElTa4d/DDAi4KxHLBdbJLvmlvVnWDK9hG7lRF22FQDsgYGDvvf9r94Mghif2Zdk02DoqTG/GIQLcKToIgeYnehvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bUYJW9la; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709052336; x=1740588336;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dih6bjlTtugnRZTjrZOaSW0ioFcrfoPNr7mrE9/4PfI=;
  b=bUYJW9lahoAjsWO+leI5MvksR9rWJ+bkrdEH0v82P0S0eymcenM+e7XB
   wKgeiVqzPPsMO2e1dAeQMZxshgoS4+ZmmhK/Wm6JadjzxSVnu7LCpiLwo
   O+E24pUvE6U4ke1VsFKLjTzFnOSH3x2D5iPmV51TbwbEgXbBOMSTRCpum
   SB0AwHOaurOdLHIf9AVVO0lMZF2sCH7Zk6JpQnuNyf2MOACS1MR3wliAO
   BZcz+Ha/zD6BpC2sXFJZgS+9VIYlB4imO7lWvScN52Xv5NRsXM4NjuGRl
   x8UHXYpGs16XpFfQ+wNmP1luSORWyQ3Jlp8x8vEy3a4eYwk/dsPCSy0Cq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="7187339"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="7187339"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 08:45:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="7059590"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Feb 2024 08:45:33 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 08:45:32 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 08:45:32 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 27 Feb 2024 08:45:32 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 08:45:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rm978DuiV/bAhQBcbE+iXpvCPuw+EHh+iyYwIoZ7/rgkoHs8Q7LtUD7cOM4gUUDvbklpoamoAY2Z567nJW/WIlp+XdMphnTXLmM3/9sQ28Ccsb7H7GueSkok/wBlrcefZiQpuZy5a16ovwjibtSlp7V4mbghh7lMGt8Lmar6k7gKrpsz8E1Oh0ovMSfPLZcA9R5iY3ZE9PlsgKPS11FKZXYHRHC06FmIidzROwXTos2+5kD4tPnGR3ZeUEEPd9G5OW6V2gOMwFL+6TiqxRa3kL/MLIxKB2VdB1JKDMg0ARyU3ByZaSB3qH6e1QYxdJ0spyBDy4E3FuBo5VZXZsoKcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBeuBVICSCkkjulW+d43wXSq9ZmBlPH2OW+c+5JPqJ0=;
 b=Ub1Fsz3SIPJcyZtfju2W7nBLv62lO4t5/gEZLoMX/9g1TA6uGui2yhmCFv4WVbnciY1gbLAohw6DiZ2GlcMWNZocXny9STKvpuwOKahxFNtGBr+L7f7h7OkV9P8ifiGzAB0aNB91jKhLRIvzppSSPTlRlapcq+84HtyYRdFy1hICDLpyzbazUbwBMujAcidmCYRPXZOyFRavBHANZywnCR05O84kzNE2TpnByweaF9ANx3puDEWqzXdJy3fw8Qwdgw+v7wntC49ta11vYgMw6KcjotsWn/fmNDroQeO3NLtdVP5/AUNvUWn23R0ipb0yk/Tpqk8LaSxXHMINcRSctg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 BL1PR11MB5956.namprd11.prod.outlook.com (2603:10b6:208:387::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.23; Tue, 27 Feb
 2024 16:45:27 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::7ab1:eed9:f084:6889]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::7ab1:eed9:f084:6889%4]) with mapi id 15.20.7339.024; Tue, 27 Feb 2024
 16:45:27 +0000
Date: Wed, 28 Feb 2024 00:45:08 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
CC: <mingo@kernel.org>, <peterz@infradead.org>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <linux-kernel@vger.kernel.org>,
	<nysal@linux.ibm.com>, <aboorvad@linux.ibm.com>, <srikar@linux.vnet.ibm.com>,
	<vschneid@redhat.com>, <pierre.gondois@arm.com>, <morten.rasmussen@arm.com>,
	<qyousef@layalina.io>
Subject: Re: [PATCH 1/2] sched/fair: Add EAS checks before updating
 overutilized
Message-ID: <Zd4RlJJfruTs4Kiu@chenyu5-mobl2>
References: <20240223150707.410417-1-sshegde@linux.ibm.com>
 <20240223150707.410417-2-sshegde@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240223150707.410417-2-sshegde@linux.ibm.com>
X-ClientProxiedBy: SI2PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::11) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|BL1PR11MB5956:EE_
X-MS-Office365-Filtering-Correlation-Id: b385a321-ee5d-49e9-d76b-08dc37b3806a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I9wUYz8Qyatix3Ht+UAyYocyIwgLxNW/WQvQtwcwgnwfClPjO7M7RUJA2JivGcIoNeY+ysUUEqrqIQMGIRpNMFu4fgMBOXTSZPFFTsNf3r0o+ALd/NyGHMiNcldLmL1NAO+YBQ4t0jTFFVDIHx1PcuO9a49yZrtvgF/2p9W0bJmATxRtVPRkpY9F0Ua4v3IMw3HMzEtcOjKKxW+OvIgoSUqD/AdIRkjZXYXX1IJOUKOVaBav9ajYscn8+2nJiXZp8GZjQV03BGEZSaNFrMWuIDeHxd1T2/JWiXTdeHFEgb+AREw6jNeft9U8E45AVXiCF5zIik7ITbWDC3irJWjiE4tBSoHWZdeoi8dHsX5pwVUqIohkYqCSdmisNwIcQIxEYW4kdx3Vd+X0EGa+oh1xP5h896A8SLF9CT8dzIAHZ/jj9nJRYiMTmyFG918EAcTmwWuo67bILfRgTDFVbVwUOiLEEZDjdXmsvUnAVmrCid7GEVfEIgtPjqPAYjHhQbAjZTRBNsdG0/WaWTm974MiPzp5+Thg79sx+fhsNxMWvOOdnY0OGIPueXgxtTUQ7rhqPRPF8iWCXkka1mBhPTYNfyU4yvGforRty4zYk0xZGuHt2+QRzrfKyEZRPV+4kSw0WoEXIMs9AdIJkHJCP651cg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8Mhi+bNCQc10Grgde82oUlZ1zC5Hzs13CUaZUg7RxzOC98yay7m0QAE3EZyX?=
 =?us-ascii?Q?3DTG50FvEDp3gbXTtJNnz/Tfg+2IvvXYatx1zkBBKDM5VVPzAm32/38X7hXL?=
 =?us-ascii?Q?KlRSNHmQIowv5i7LsYem1VxEpumMkRYCnf0IkMUBUORxShNU222nF7kMW1Dn?=
 =?us-ascii?Q?Zt24h/9/MUnNbyuyHRmwIgQhtv9teHvu/xRSM/p9p7+AwVndtgB0+9Ps8Ofw?=
 =?us-ascii?Q?bw1R0U+NJctD2Lu278VprZK7iVYW2O4AHT0rty9sOmqGrraGVLM2LVNVVohX?=
 =?us-ascii?Q?5JwnW/HuBbKfwEv9S043SkpUerL+5c98g+UoSE/oOl53aAT0Z/acoa1TlUxh?=
 =?us-ascii?Q?xk4aUck5sjvtzf9aUsnGu3FkPxItOzaJ5Zs/BMhe1a/MMAh6DnVceJegzS8Z?=
 =?us-ascii?Q?ZhDuwcb5q4MfKw/3OdGEljKq4PyG4beqWFXLQzsiQX2TJBt85s5ec6j7FXgX?=
 =?us-ascii?Q?bU8gYCUd/4ICZLDf2kE6j1mXdKsS1ya8ir04GZWBOQZv3L4jW6ylFReYsjZy?=
 =?us-ascii?Q?kkW9AFP9PtKWiFAcNN/+Uk0TATmtPSUS7usrHXGjyabA2sDNILFdAkUzg+hi?=
 =?us-ascii?Q?xKTHIgn2uFzAe0ky5dhBfgfDNtiCzTeZ0ONtLpAL4eeFIue6CvZ4mnRdO93o?=
 =?us-ascii?Q?wtGTZqsR4zDicAWeLb0shm12s6VDe/Ku6+s9vDVEbqzseTQVvqGhMDx+Q059?=
 =?us-ascii?Q?QQh7cFdNkXhOR6H9toL2Z3tUzDWZaC+623+t2g5kAjdINjEqxqbHTVnNfVV/?=
 =?us-ascii?Q?5EMHFz7upELN5IUxuicZkUGjOKthOwKDKL1trPgIO86p+QbE1j9X30HkCaEz?=
 =?us-ascii?Q?k1tYbqBm1CX7OtZbaPA0y1+UVcaF2kDU7AMTBBWRwnv+7f/NUsG9z+waakwW?=
 =?us-ascii?Q?17mCYKEvNjNSPGlGIswc52CWOgZgeClDqzkUyWss3Tiu7QoAne8Gf0UkzWsX?=
 =?us-ascii?Q?ft1tCADIqFyxJm6FjancFGK5VfgmVgb8GS+NAsfvb+nVrdebIMcuq6BY3yDo?=
 =?us-ascii?Q?jRHfG2T73GIAPpaJKvogJiHDebIHKP1wJDcgbiK1RxtkF9m5N46oQ3MLV5El?=
 =?us-ascii?Q?oHmm39Vr7Dea9RHCBWerVHDGGay+0uxOFRxssIBR/CQUx77Lht9U7aTePFt8?=
 =?us-ascii?Q?2AcZyRa01OeuF/rN+CfKOMrCdXC7VWEvfonPeZUTvMGAPHitC3f6xTfwZxlm?=
 =?us-ascii?Q?m8rN5sW9ywyTRnzAxMQFPn1hnDUy+qm9pzWsUOL8sU5Szjdaratre5MDjXTa?=
 =?us-ascii?Q?LdK/XlkWGOjD46NqW4qhm+s0a9sYDDNlL4k6PeCuN6LdLSKS1QnBk/o3gG8x?=
 =?us-ascii?Q?Qgm9ZHNq1Q8yBh0C+8H286OosTQ+wbgwSONzjvr5xYqK0BKdRAmBNIIibGRx?=
 =?us-ascii?Q?lfWMlHW97ne2rc8yboB0rQKtqCN2Cmd1q56VCh11G1+rw0OyWzhcUh5khnGj?=
 =?us-ascii?Q?YV9EC+F3hnZsKsnBkNya7EvfPuRo82WbnilwWmFmZRAv+imLG+4rec6IUedr?=
 =?us-ascii?Q?mWBCUEJADGpJGCGvfpT4w27Ev+q/PJlrfl7PnCDyd4957jtRE+OSe+6Hike6?=
 =?us-ascii?Q?RX77MBs+Y9ZRzLjDl6thIO53uZsK0Qe+KZQeDk0q?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b385a321-ee5d-49e9-d76b-08dc37b3806a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 16:45:27.4416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pGzsJwjFpdm0iZAcFF4jlclmPzMy8r4Q82UhPHvVzAqhIOvshVkU2ycNqJRFoE9CBiN3ui7utUU1RBfxjNuWuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5956
X-OriginatorOrg: intel.com

On 2024-02-23 at 20:37:06 +0530, Shrikanth Hegde wrote:
> Overutilized field of root domain is only used for EAS(energy aware scheduler)
> to decide whether to do regular load balance or EAS aware load balance. It
> is not used if EAS not possible.
> 
> Currently enqueue_task_fair and task_tick_fair accesses, sometime updates
> this field. In update_sd_lb_stats it is updated often.
> Which causes cache contention due to load/store tearing and burns
> a lot of cycles.

Looks like a typical cache false sharing: CPU1 updates the rd->overutilized,
which invalid the cache line when CPU2 access adjacent rd->overload.
This changes looks good to me, just some minor questions:

> Hence add EAS check before updating this field.
> EAS check is optimized at compile time or it is static branch.
> Hence it shouldn't cost much.
> 
> With the patch, both enqueue_task_fair and newidle_balance don't show
> up as hot routines in perf profile.
> 
> 6.8-rc4:
> 7.18%  swapper          [kernel.vmlinux]              [k] enqueue_task_fair
> 6.78%  s                [kernel.vmlinux]              [k] newidle_balance
> +patch:
> 0.14%  swapper          [kernel.vmlinux]              [k] enqueue_task_fair
> 0.00%  swapper          [kernel.vmlinux]              [k] newidle_balance
> 
> While here, Fix updating overutilized as either SG_OVERUTILIZED or 0
> instead. Current code can make it 0, 1 or 2. This shouldn't alter the
> functionality.

Just wonder where 1 comes from? In current code we either write SG_OVERUTILIZED
or sg_status & SG_OVERUTILIZED.

> 
> Fixes: 2802bf3cd936 ("sched/fair: Add over-utilization/tipping point indicator")
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  kernel/sched/fair.c | 36 +++++++++++++++++++++++++-----------
>  1 file changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8e30e2bb77a0..9529d9ef2c5b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6670,15 +6670,30 @@ static inline bool cpu_overutilized(int cpu)
>  	return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
>  }
> 
> -static inline void update_overutilized_status(struct rq *rq)
> +static inline void update_rd_overutilized_status(struct root_domain *rd,
> +						 int status)
>  {
> -	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu)) {
> -		WRITE_ONCE(rq->rd->overutilized, SG_OVERUTILIZED);
> -		trace_sched_overutilized_tp(rq->rd, SG_OVERUTILIZED);
> +	if (sched_energy_enabled()) {
> +		WRITE_ONCE(rd->overutilized, status);
> +		trace_sched_overutilized_tp(rd, !!status);

Is this !!status intentional? The original one is SG_OVERUTILIZED = 2,
now it is either 0 or 1.

thanks,
Chenyu


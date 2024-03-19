Return-Path: <linux-kernel+bounces-106918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D436187F566
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A39B1F21D44
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0430651B9;
	Tue, 19 Mar 2024 02:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l5DunYe5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB751651B2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 02:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710815109; cv=fail; b=HyrjZLDk3fnTz+6qyOe5SSEHQvaD1uH+RdsE31QtezJJn6IgroZaR1KZvRX+RA+/8YscaVmZqjA+yU778UjF9PflGirAcyBzarLIuhea16KMIh8XbSpxP0kZ6T+CiDx8SZk6aCvh9Slpq13YKE5FrVezP2TxglrmMLWz0xSATW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710815109; c=relaxed/simple;
	bh=XRHMust1hJtKoHsM117uaRs8wQhpSiiF9HhDt/mcWKw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ujczWbr7DTPLhX1kzTAoonNktRbqG8aQ4OUi2GSV9e6n+n4X/jy1Fl0IRHrrolqJQ6+dG8ol1VDOXbiEA37fQPMV2HT7IQhzXiDNZDdB9ZuaHCBDIi6NNvjkq0g/52bg2IeYTcbBLhoBa0y+X9QCPHynoG4ZTasYbKAHZ1w9fas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l5DunYe5; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710815108; x=1742351108;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XRHMust1hJtKoHsM117uaRs8wQhpSiiF9HhDt/mcWKw=;
  b=l5DunYe5wVV7Dkdc1XtBndTNnoCrmGjto6F9XM3TFCk/wMUuR+SNtiVt
   hygCeUka1OVq3tJ3X7C1Mv4YbJeexsK193jiq5hUQzuuTHSXgeu6rJHEg
   +Mgmighl9Zo015xWKHkYKQkGYPotKlnCWIWbMRNLSA/QBpYkoz+tXjkyr
   LOL56Z8wX0fGDaP6qJIc1Px1HbOIj8ekvQZrEcwXj9USUX8IC+qszB/Z9
   zLgKz6yWSImMpw7fMIp1hRjWdZQdrS9ObRu/ncXx1oFMsWjME0P2tGE+T
   qDE4jGaOOODw4lVh5uXnOR2k3DqjGphhrngsAQJ3P9lGF9UwI0xvLmNAp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="17063588"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="17063588"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 19:25:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="18385336"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Mar 2024 19:25:07 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 19:25:06 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 19:25:06 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 19:25:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KkTZgnUuRoVHy51+kvjP9tWL8SRIxqHLwb8XayPftBvMRRVXx3DZMH1G+MSJPwNS5aKA5W4kut78n+brgVUQHTp3/5vioWMZtFdPa6+HwYlSjdgWmUaIE07ztndsVcUcsPaLZDc6BcOZVfeqddZL1omRPi3AtP7IzhRNF0QuuNVyUjG4zYACgGCl5/9muN0N++YflhohiGIr7WHPyNa+lcziG/2JFkKKGARwlmKOHmsKM/9+221laxcg6nDVr7vvB50YmpNFZs8dYCEnqGZyP3kfvubGE9ePIO9PWPXfzQUXuKtMdnUctJ7M2uWG+MlZp51LITQlQeZ6utCqQcD84Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnrF/h4odIQoVmm5QJzG5IOYWLZdHVQNGHwZjBNe2+E=;
 b=W595CNUdeVNsQh3ZRJ+KC3hJmU10eLCtIocvbj79lmuYi3Cp4FxB71sueP0Ux0GfH/JzOIwURRli8blV9e8Pv8QSiDHdGZqmMrmJcoa0w+g9litMosx5ZLBHm0yB4QrmwKDuBLYyWmDsjJP+ae/JLEVUgRSYD6B93quk4ACKt3F7+MK8S8qU+1gNKWUxjrqvDGgO1DqpogfRv9VnBxBFAD3uM3q/ahjg2iOYtytpAThlmUigkCyysGEwRRERgE9BhX/5ISixRen3RNiMTXuf0HOYelOzGZljZchBj5m2qDY/2T+1tDv2mydoch2ENYfQNzsHO7ZWEnzXq0hhbE3fzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by CY5PR11MB6140.namprd11.prod.outlook.com (2603:10b6:930:28::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Tue, 19 Mar
 2024 02:25:04 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::4d4c:6d3e:4780:f643]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::4d4c:6d3e:4780:f643%5]) with mapi id 15.20.7409.010; Tue, 19 Mar 2024
 02:25:03 +0000
Date: Tue, 19 Mar 2024 10:11:06 +0800
From: Feng Tang <feng.tang@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, "Peter
 Zijlstra" <peterz@infradead.org>, <x86@kernel.org>, <paulmck@kernel.org>,
	<rui.zhang@intel.com>, Waiman Long <longman@redhat.com>,
	<linux-kernel@vger.kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] x86/tsc: Use topology_max_packages() to get package
 number
Message-ID: <Zfj0OvSG8Ox9x8Tj@feng-clx.sh.intel.com>
References: <20240315112606.2248284-1-feng.tang@intel.com>
 <a2f38451-5c20-43f2-842e-dd4c2c038e1f@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a2f38451-5c20-43f2-842e-dd4c2c038e1f@intel.com>
X-ClientProxiedBy: SG2PR04CA0163.apcprd04.prod.outlook.com (2603:1096:4::25)
 To MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|CY5PR11MB6140:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p5xMPNOxLimjl7MLqJuJIBFGX2BmuJgYDABcDu3hErQq4UpmBs8mrM1/loZnREx19jSgADERbpjb6ESQDeSZqQahuRH6KZpd1EUQzJkjsSVmC2KJj6CDNjWAW9LNf0CIWn99zHAGF1hZ2lq7A++zbnFHu9kE3SMFXXe8spxYN/lSq5m6LfvsswfGg+wJU4av6O7L164T1BMgWNZ/HYsdiN9cgFKYAXfYFGPIzbou6ztKSvMIKlgiIylwjv3DoRMuZiQXS9GYcAr6scVfUrCr5AWtrBJpeKJSAKFc/F6NqOMXTeZ397rDqGI6j1ut8qVqDv+WCvmvTqfjlpUCcxQ3WiIcs5wtm3o53pFQoOjqiv7ZEmOQwhOkIuJptDliOAr4Sx/zXOjbsyl+bMJz3vdsRv00H0WplxO5kGjNvM4YujwNy5RPIrOmYqQg9dyFGHswJiwlhtmPlep6La58sGyMHgNU+ejbPAE83QqyDdSz8ph3xspk+h3Cg+0Q4ZIWWd4dfU0bWbT3mha15wLuLesqjir7QGTw//jiPLVXbZsR4YzYXmfiDmd6px5xEENKdnm5NpEm9kS0h/kV50YF6TcQGH1AcsisT4b9JnmjEabNuPaQMS523S2opokGuI33csiqTk8rA9VH1v1FBWITOLEDuWvPPMDBJKlofWlXg3a/ip0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?szLilWyR2SgMZSvwtKaveSw1sD2J38D0k9u5Ml+LNM9n8tw0P+BE6SlxGSdC?=
 =?us-ascii?Q?Y1wKbnbGnNSKrdTXfT5LuBIo+v9UcZL/3lsJSqQ0+SY6f9rHEGrUW4z2YZdc?=
 =?us-ascii?Q?mWavPtGtLuRHgiNkFTtvTbKPCxzzkS4sv7G7SQeQxkMhLr0vX55gQbEs5sIb?=
 =?us-ascii?Q?09NXWynBfAmkokR7n+KB2j0eHe44wQthb7i+PEARKjFVylsPIiZfwfrruyq5?=
 =?us-ascii?Q?utp0l6PcIHvoxEkIy50GPSfUkzRx0J315VmwPuu/PNPHApbXKiQw5nYSltDJ?=
 =?us-ascii?Q?zZaRzE1EMzggKerKwfUHAGSzX9a6LmO22+kQk9KNlkw1E3Rg7Z9UAs5KL0ee?=
 =?us-ascii?Q?OivLRieSGUIsxAKkU3AUiNDdib/2oRkfo6n2D25lq8QmZfkBv3vXKUTh8W8p?=
 =?us-ascii?Q?HASrOd47ANORCamNTP7OwvzqL7mcn/bxps0Lj3VEGyepdybofZ81YtMJzL8d?=
 =?us-ascii?Q?zeooMWxIeqf7Y3BbH820MggPT5W2GJbQeQJdRFMXexdzIDy6kDmafIOfmOCo?=
 =?us-ascii?Q?bDcMwIypOq3QA5RkOAmCzm/HzAckEJr8FOJHV5p0kzYcPVyLJjpCLjGIhgWy?=
 =?us-ascii?Q?HfYaTvpY2WutkWyFqTzeyb+rcgidYs3gd459Aey4qNJx1436xzIREJ5MpltW?=
 =?us-ascii?Q?D+z3+rsZ9FAs5IRwDJd/RTrqZzh7s33Xnx1KyJxtuVNkjuo7+cyLoaUqrj0i?=
 =?us-ascii?Q?Mw8ZwoiJrd19P8QVyZRICbH7K6eZzN6qS/aR3DHtCqJdsj2Zp96YDkVDgK/S?=
 =?us-ascii?Q?rsB/VWlartEU6b4DLcHYO7pG9jE39tkC623EP1jYtT51G8uHbnjM2M9XGSiq?=
 =?us-ascii?Q?Zs6CvRtY3oguKVTo/+pge016a18FU/cd1IZKp48cakl6Q8vTO28H0/lK7mE/?=
 =?us-ascii?Q?Jca15FkXpPmiWi3meqLCT/bHCdYhVunXGeg3vTZvwf8gsBUvz5Jo5FIxSL9w?=
 =?us-ascii?Q?Ps5jY1OLcsdrPp4FV1P7V71x+0xPhTuGIlCg693KZgIkpEnQ3aVbVfbuo9cZ?=
 =?us-ascii?Q?f0psqe2fnxaC9Jx5HTIFVAA77IkG6A1uCB0DAZ1xLdHHinR5hygpGHkdg9gq?=
 =?us-ascii?Q?oDehwmhUQBelFQKcqLBSwtnlGPEhhuviUJHSwu6dr9HQQaU9d94YXp33PjZQ?=
 =?us-ascii?Q?IFsZSsMPF/mX+0lbC2aQlyTHshOB74Pa09c5mjW0Dc+UT3+KiShNRiCAIlS+?=
 =?us-ascii?Q?MzZQlBa2ntDXP+4paRHv02PyoaZdMDPYrEt9OwgLj746cIjHSTwt7VCTEM2p?=
 =?us-ascii?Q?jN3jT2W2ZgtENm1Lw735Xo1U9KxHzjTtA3wLjCFD2tPK2zx+6JpE9Ug1Jj0E?=
 =?us-ascii?Q?lt83HZCUaYC1LI2JmgCWlyAS3hmis+/Krc0c8IqXfBLzk4zKS648ohezlOvm?=
 =?us-ascii?Q?0MnkmjXrw7WUYoOOYC0JcPpUYQKnh93/F1HLtVO+hzbxh8gLLb+J3tfeG2+N?=
 =?us-ascii?Q?roEppiMgrdQsrpgmjYWfkzykA2cOGocuzoVlev1lj/fqHrxT3tpOGJwzsPSu?=
 =?us-ascii?Q?7U7vhCElIhL9rPYVjR2L4Z4GpbZFEHTFrbkwYr7P2EA1zSBk/j1zRgEXJE0J?=
 =?us-ascii?Q?TUkTbAIcIkLMPXdDdFuu4DtIt25yuRXi8cjE+gZk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e147af3d-bbce-45a5-2c81-08dc47bbc8f4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 02:25:03.7061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fdfydA5IIv4p9x3LLSxYbTDC2Gdrro808LhaocFeaTjrS5HndInVp0EAUUtMcaJlwUcMTCGWLFDa6TkAoYOTGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6140
X-OriginatorOrg: intel.com

On Mon, Mar 18, 2024 at 09:35:57AM -0700, Dave Hansen wrote:
> On 3/15/24 04:26, Feng Tang wrote:
> > Thomas' recent patchset of refactoring x86 topology code introduces
> > topology_max_package(), which works well in most of the above cases.
> > The only exceptions are 'nr_cpus=' and 'possible_cpus=' setup, which
> > sets up the 'nr_cpu_ids' and rejects the rest of the CPUs, and may
> > cause topology_max_package() less than the real package number, but
> > it's fine as it is rarely used debug option, and logical package
> > number really matters in this check. So use the more accurate
> > topology_max_package() to replace nr_online_nodes().
> 
> This is a lot longer than what you have in this changelog, but I hope it
> makes sense.  This is retreading some of what Thomas's set does, but I
> think it's worth re-explaining:
> 
> The boot CPU iterates through all enumerated APIC ids and either accepts
> or rejects the APIC id.  For accepted ids, it figures out which bits of
> the id map to the package number.  It tracks which package numbers have
> been seen in a bitmap.  topology_max_package() just returns the number
> of bits set in that bitmap.
> 
> 'nr_cpus=' and 'possible_cpus=' can cause more APIC ids to be rejected
> and can artificially lower the number of bits in the package bitmap and
> thus topology_max_package().
> 
> This means that, for example, a system with 8 physical packages might
> reject all the CPUs on 6 of those packages and be left with only 2
> packages and 2 bits set in the package bitmap.  It needs the TSC
> watchdog, but would disable it anyway.  This isn't ideal, but this only
> happens for debug-oriented options.
> 
> This is fixable by tracking the package numbers for rejected CPUs.  But
> it's not worth the trouble for debugging.

Will steal it for the v2 :). Many thanks!

> 
> --
> 
> The only thing that comes to mind is if we need something simple like:
> 
> 	if (topo_info.nr_rejected_cpus)
> 		pr_info("TSC might be buggered\n");
> 
> ... somewhere.

I think logically this should be together with the package checking
code in tsc.c, and we need to export the info from static data
'topo_info'. The other thought is adding in topology code:

--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -460,8 +460,11 @@ void __init topology_init_possible_cpus(void)
 	pr_info("Num. threads per package: %3u\n", __num_threads_per_package);
 
 	pr_info("Allowing %u present CPUs plus %u hotplug CPUs\n", assigned, disabled);
-	if (topo_info.nr_rejected_cpus)
+	if (topo_info.nr_rejected_cpus) {
 		pr_info("Rejected CPUs %u\n", topo_info.nr_rejected_cpus);
+		if (__max_logical_packages <= 4)
+			pr_warning("TSC might be bugged due to these rejected CPUs\n");
+	}

Thanks,
Feng


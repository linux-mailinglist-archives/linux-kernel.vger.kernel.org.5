Return-Path: <linux-kernel+bounces-49314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9893B846896
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B63D1F26614
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8F71757D;
	Fri,  2 Feb 2024 06:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZLUpnKrC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CE41772F
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 06:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856957; cv=fail; b=aYgDO01uJcs5Mq/EmwKQM4yNnWGTaMNLC2ochlexGrv8HnX/Z3qKnxUnfOrPcfG5IEIPP8Gu66LfXyW7VA1Jis0trS67no8jyeOlVyu5LapunU4v8eZxuAyR33v+KgKmP2Gz/I+MUe/c/ObXB1CMmqrpEDZoNIISuTYFclkJgPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856957; c=relaxed/simple;
	bh=J1wdNcAC0TM7X3jhrq7LFkkVWRbGcdbqKM1lIKrEy+c=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=BKJoPT/r+yfV1XfdO6yDjtQw2B+LMYQx0rtFkxAX2Grx0ePX3WavqG0krdwiA2WNcET590SaLMu80gMlmtpw3RZRNfwjz46jDbNjIJk+JW5ureFyxlxsz30KXklDR2x4JyEB0xqvfvriCzqvYsmUTP7EKm4Mz8Su8nfoC7PyXWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZLUpnKrC; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706856956; x=1738392956;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=J1wdNcAC0TM7X3jhrq7LFkkVWRbGcdbqKM1lIKrEy+c=;
  b=ZLUpnKrCR3EsNTpESsijvIyvEzXe/60UD68eMlVpPpg2PD0zppONhX4P
   53QHL//dSibTDIyoU1NNWJAcjzUYht2oCJOraH01Rt7IOxIlPdDg70vmj
   TZAKyjyeAzJhtuEnMu8j8jVtnyGW0foT0ls7OT0NT1ituHCmYIP58jGoV
   NevZ+Eb7w66CeXQ8a7l/xybYoOKEjryWQff6b6koPzZxJG85uSFosq9Ha
   fCH6gSJPVEPWs/OPiNwluUSpp0APnKfh3R6VRo4DTF16Mn6ITobNALgVc
   k1FaPHxIfpUU3+fZGmncIfsG/NIN1HkNcPUa+i1wQaa9NTgaIba6YQRyj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="9095"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="9095"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 22:55:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="932394965"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="932394965"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Feb 2024 22:55:54 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 22:55:54 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 1 Feb 2024 22:55:54 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 1 Feb 2024 22:55:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1SJqTbUaj3gWqgsVo980bAc3Nm/bZKchsSgTINR3zTyuLZKu0V5V1jq3c8WhRfGXgUdKZ/Zs+zldKneCxTASAiYbir/Dk1Y2qRytS4W3cLWubGWdJz5qky3aDsLpTcXsDqsdplRRuP5VSxlzR0qmQ5jilSEwxyQ/eQolgN+Q5t+rNOzelu4rezm7/QGbldRcsjhsFI43hpuP+G/EVOC5PFY5r72Q/fB6k1zy/FCqgE8JTsTwDfVGm0DmHTrIFXIjcEEKbAzvhWF1RSxe8+jy3LA+K0jaRtR4gALMRHAyWcfQehwj989DnVJxcben/j+0/YIxwYo9pR5IQ2XJh4frw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7l5YHxx+k4QbIR9ZZ0PAQcnKvkdcrgperMkq4SrdbHQ=;
 b=m7klHJ+LXnEaNttBaLL/Y5dwvi5BtYeku+yinypmCZSCjKKyDA7P+n33RegHySfpyDH0bQC4ITHv6GkYtji32mowLzX0hBxGn8gOxG4XAON2t3EpSfvs/hTpbclYUZ7WzqJ+b3eoxbsxVrKuZyr7/H4+a77M43I0UhihjtMyIYTjDYasjok1Zflk9mPKGt88OMPCUZkkenVxsNcwjNH8ZSgaYDYNj0L3yyImewR0dDsfNhuTUCmRNhXbjVLXLCjN6jxkLYDoHozJR7bTb+OkDEnMnx+hV8A6sWWk9sFm/wm6CcC+tEM5/NBgJrHjibdxx8uLeG6d8ppCh6qWzMSmag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 DS0PR11MB7383.namprd11.prod.outlook.com (2603:10b6:8:133::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.22; Fri, 2 Feb 2024 06:55:46 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::a83c:a9dc:f30d:507]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::a83c:a9dc:f30d:507%7]) with mapi id 15.20.7249.025; Fri, 2 Feb 2024
 06:55:46 +0000
Date: Fri, 2 Feb 2024 14:55:33 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ming Lei <ming.lei@redhat.com>, "Rei
 Yamamoto" <yamamoto.rei@jp.fujitsu.com>
CC: <linux-kernel@vger.kernel.org>, Sasha Neftin <sasha.neftin@intel.com>,
	"Lifshits, Vitaly" <vitaly.lifshits@intel.com>, "Ruinskiy, Dima"
	<dima.ruinskiy@intel.com>
Subject: Managed interrupt spread based on Numa locality
Message-ID: <ZbyR5RCFWDORmkBk@chenyu5-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2P153CA0033.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::20)
 To DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|DS0PR11MB7383:EE_
X-MS-Office365-Filtering-Correlation-Id: c7838dc3-cea3-4c2d-8e44-08dc23bbfb5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fd+71cZzHKbaOpkXrT/Ypdta41SLwjmZI/0bV6bGb+3bCfgr0UNLpzV4DlnBW5599xviZJfQs3oq9pFSM6UwRMYJYsjIHB+3XEOoOOedmbLwq5e8oS9IJUotPsDqHisl104j+mJ3csBgzjLWBvmUHx/lve8db6jOEFjDa74beQbJISvWwxsp4dH2Z8lt2UtDS6VUnpmc/x7X7p9BKL8LHaVqbvk+slo1vZ5wBuPNXKXdAd5SaeXB7n6wMMtZ0rv1BLsHeUrlyS4cwqFWjjdwDkS6mBewF+DrJZ/vOjqSi1BBPa9V3e2F0rxWTke8RHgi3F6uMZ0fJZUmrdYWhkOdjINJUKAbNZXGoN6PzMoYTUfQbRyY8xex/hpAwAA+xC4zX98H16oCXtsFT3i4rYzmbv3BEZ9o67I6XV2E+Pa/kCvOrsfFakg0oqKNC3FbmN6iob1ayjkKDVVYW1hyGxYAUE6wZGtEFAyZ2UAeKkY0IbBwXr/MDk4lpHeOxDfpuucK6ecxAimG/3ANCtbnWOhlHZc3gaHuwmMjMkDYfn/8Z3wV53g9BFfP1KAIW54xBQOrglaGT6t1vHYt0ovXdEKUnXJcQsC512aRnIa1qvvo6Kw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(83380400001)(41300700001)(82960400001)(86362001)(5660300002)(38100700002)(107886003)(9686003)(33716001)(26005)(6512007)(6666004)(2906002)(66556008)(6506007)(110136005)(66476007)(316002)(4326008)(66946007)(8936002)(8676002)(478600001)(54906003)(6486002)(60764002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pj9mq2X+aON1MVRIqzbL14vA3BcXeL7+zUZMQyKPpu3f7q7vOx/KyarkuUko?=
 =?us-ascii?Q?k/Muw1R5W6hwt0H1Ys4HAUaGiKmWLOnFLyqqZ+X+K/FQ2sL6w6Mhc24SA7SC?=
 =?us-ascii?Q?yzwAIhCSoqKQXAacZlxOtutnte57wgxSb0UMvROO0E6pp2Ji1lw4kFo/Esk3?=
 =?us-ascii?Q?lI+Ubf/MyNB4V8shC7wZoGzGVIqbjGLTvbiIaMO3592Pv4zdF4ZDNobTDhkz?=
 =?us-ascii?Q?1ZILbfXy1CrBYIxkRn3/Eb2cv4PZPnqn83sBhRpaO0FUF1CdNl8wyeEdkzNP?=
 =?us-ascii?Q?TXWbYEuJJhIVHDyAa6+Y9iAo5DJJLJPsRa0GTF57j7cneOe1brQXcbFMGHGa?=
 =?us-ascii?Q?GZRe2Rtpf0kLGEMkjPoaB3OX4wUrwefW43uwgi1/MBVQSSSV3gO5CYGov2V8?=
 =?us-ascii?Q?vjmXgsGjWPCkxXlo3Qa2CW/HjlslVQIRsI7dfkHoudIfyJEx37DKKdYWF2IB?=
 =?us-ascii?Q?IvLx33XGqGwq2uwN5bQTC2FICoo27fUZLUmF1+ICSEHoYFhweZA3zW/JEzvd?=
 =?us-ascii?Q?7aRsnB6YSwUyKIagPphFJHGcFzvd/bPzZ+RUh/21nMhcPtdtikkxhVzPZFCh?=
 =?us-ascii?Q?tM0i7jfnYf9SRgR/76Rl77vdA95ItqRwKltkAZrA9RG+Y08PMlt+CmE9ZX5J?=
 =?us-ascii?Q?0ODvbBtPJjzOADEm3CDHeG77eymw7FSNRZnKrwu/e2eI7ooWoFCDwT+6fYuP?=
 =?us-ascii?Q?8Q6u8FhpM6JmjwOs3rpnGAUM5sUNMLtL1RfjS1ZCul28eCmAABYjK/8uJR4o?=
 =?us-ascii?Q?mR4K0U4tXrrfoggLlZ5CxNBnJj9uCSJBAXVImt+1tXlmM7Pge0+X0IyX+5Zl?=
 =?us-ascii?Q?SQlhgdYkxgKKyi3BUaWT8t11rhzXBxl82TP4f3ZRj1ZAH7K2xJ8dOivZ/daS?=
 =?us-ascii?Q?6xsRRdDIJKYDUtzpj8eFZvyDHecZ99U+dg0JhBOczXAhZ8Hf+q5+XMDOkKhc?=
 =?us-ascii?Q?CYh8jwCZhyUnVMMBrJt9hzXldWhIcRyXfI8z+YFmnAkRXidY4F6HZneEOUr6?=
 =?us-ascii?Q?yf4V6wtEABg4YUZvacYa8MyqeAAHE2P1I/nYl45HRtQrIZw935hfXSrY5jWV?=
 =?us-ascii?Q?uUzIr13Jf4GPOOvpC6sHtGTCyOsRav5heCaE+QOG5p0Hg5iSa5B5CNyZTOsD?=
 =?us-ascii?Q?eCozamB0kvNZGCW0rz26+oaNPpiVsVxyMxGQETJ2WY25o3A0wpSQJNYm5pUx?=
 =?us-ascii?Q?6F4wih5ZLfz0k4jlZUnPwvYt05outQ8D1g8xFaG5a0iBFB6Mi8U+SaT6Jyf6?=
 =?us-ascii?Q?SlNRrCLmPlimhqJBJJApbOPac++pRi8vj/qHp1WLYqpXFhxpxITdtkIg+vlI?=
 =?us-ascii?Q?maLGoln5cbVnV27apm4QLyZ4BIejSEag2O701SMC4WsxkIia4IO7lQw3M7UX?=
 =?us-ascii?Q?jGVhAk4ll9ilHC3TG4LxcwvgqWzlEMIdqzekJNritURbGXq5dn3s0QARIqD4?=
 =?us-ascii?Q?prhobxREbBNYMvHdhdwp6ZdJUWE+jVACrorHJxSCAuUHpIgO99pF3YBbLtNJ?=
 =?us-ascii?Q?jSr4VUIDFlBH4F3rSLH8t/m74bpmNqqx6FcZi2SDS8AVREldmxyIl3miYkBy?=
 =?us-ascii?Q?87Ts9DmyW5QJASL7VpbIFKIhPkXUNV0tmRzxPpLz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7838dc3-cea3-4c2d-8e44-08dc23bbfb5d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 06:55:46.3866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sN+Y2ihbasSrYs2sa2wQmcKzzYAcXYu6VW5qGv+dDOinWzHYuBavMz0KZic10F6hQit44lodcY3ehbKweswKdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7383
X-OriginatorOrg: intel.com

Dear experts,
 
Recently we are evaluating some multi-queue NIC device drivers,
to switch them from conventional interrupt to managed interrupt.

In this way, the managed interrupts do not have to be migrated
during CPU offline, when the last CPU of the cpumask is offline.

This can save the space of vectors and help the hibernation put
every nonboot CPUs offline. Otherwise, an error would occur:
[48175.409994] CPU 239 has 165 vectors, 36 available. Cannot disable CPU

However after switching to the managed interrupt, there is a question
about the interrupt spreading among numa nodes.

If the device d1 is attached to node n1, can d1's managed interrupts
be allocated on the CPUs of n1 first? In this way, we can let
the driver of d1 to allocate buffer on n1, and with the managed
interrupt of d1 delivered to CPUs on n1, the path of DMA->DRAM->CPU
->net_rx_action() would be Numa friendly.

Question:
Does it make sense to make the interrupt spreading aware of numa
locality, or is there existing mechanism to do this? The driver can provide
the preferred numa node in the struct irq_affinity->node, and passed it to
the managed interrupt spreading logic, then the interrupts are spread within
that node.

Thanks in advance.

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index aa3f6815bb12..836e9d374c19 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -344,7 +344,7 @@ static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
  * We guarantee in the resulted grouping that all CPUs are covered, and
  * no same CPU is assigned to multiple groups
  */
-struct cpumask *group_cpus_evenly(unsigned int numgrps)
+struct cpumask *group_cpus_evenly(unsigned int numgrps, int node)
 {
 	unsigned int curgrp = 0, nr_present = 0, nr_others = 0;
 	cpumask_var_t *node_to_cpumask;
@@ -370,9 +370,14 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
 	cpus_read_lock();
 	build_node_to_cpumask(node_to_cpumask);
 
+	if (node != NUMA_NO_NODE)
+		cpumask_and(npresmsk, cpu_present_mask, node_to_cpumask[node]);
+	else
+		cpumask_copy(npresmsk, cpu_present_mask);
+
 	/* grouping present CPUs first */
 	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
-				  cpu_present_mask, nmsk, masks);
+				  npresmsk, nmsk, masks);
 	if (ret < 0)
 		goto fail_build_affinity;
 	nr_present = ret;
-- 
2.25.1


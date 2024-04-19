Return-Path: <linux-kernel+bounces-151103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3008AA922
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6012B1C20FFB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3ABA3FBAF;
	Fri, 19 Apr 2024 07:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EVIcQw32"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBF079F9
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 07:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713511673; cv=fail; b=SuP9SAsnnya/J/IrLs26sINjnSICEExWWq6tlzENcFd70H+s4KK0mu1rRD1dqvLpwp0UZxQRUqwyCtRywKGhnIq9myjyDyeCCR03AbXFXCWCoxItzXOr+tLHBTqNj4mcQAWhPRiFpDcag/0dYjlgCVu/t5Ii2KH4DGu6Qo3SIJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713511673; c=relaxed/simple;
	bh=wToKu5voSAVOe5iUNNMUjfhCBQCsJUL8WD7W3I73DYE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hXVUMju4+U3A46T6TGSiVjSf9wcf+qRUcsuc00lmPG6fcmh6t+HUeUDehnxMsi53o0fX/TVJ7oaTJQ11hBaW6wO1bP9/mgc8azaNIYoakgG3MvfrPo1ihCTYgdbrIOxeyr/j2b53dM40NsQgQHwpnNmNGhT071CbvMh1uzOVF2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EVIcQw32; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713511671; x=1745047671;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wToKu5voSAVOe5iUNNMUjfhCBQCsJUL8WD7W3I73DYE=;
  b=EVIcQw328FyAa29sx8Y1DKLPI3DaMGbN/w1kmJXfdmqsT+17Fv9h3jgA
   QIXf9FoIenZVMlkyIcWzOBYyvDag/YpEfD+ZDHCWE83uz79t7VXHzDTag
   fEZactEZWYQ9rFqsHWVY7GRJtBNgPAFc8yzs6MYdFwYupdBTCur5ZryRG
   RRiJXy/uYSsiz1OxwFWdy4fPNISA7lqp9zo22ZJLwBh+0O4kGZ8dMV01D
   PlBt21r47bI4fe/M5gDqp1FiJIrikuApg7vlCTQ63bJM7pJVKqd9ZJMnj
   XH/cEN1exVpqYhOLmSqK0KSDSSJt3R+y3UnIwCGeYHKV7+K3z+BzIfSYS
   A==;
X-CSE-ConnectionGUID: 9gfBUHnKRByjsVjTAJw6Rg==
X-CSE-MsgGUID: Wif2x9g2RdOUnM3BO01jDw==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="34498214"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="34498214"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 00:27:50 -0700
X-CSE-ConnectionGUID: HdR/uBYIQSOQ+aLq1Hiq7Q==
X-CSE-MsgGUID: dKKRbFEqQBSvKET/MT+LQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="60683699"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Apr 2024 00:27:50 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Apr 2024 00:27:48 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Apr 2024 00:27:48 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 00:27:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtktHe57VxQYsB1t4Iv5wxN4YyXLMGe2tww2mdDPap3LO54R0N3HNdWYsCF9bdIgwyFI2YTLivZ9OcXnxTMhAd3irm9Hwea215/joD72PVHbo6IxnP1OfVJg2NtakFoD1WzAsWi0TFWjIFNP31SNlrE8+OowyvTx34SiH3uo70JHdLZ/Aq7Dq+PPvRrLhMGPywNry5ZeHglrW6c6aYun0TWTvNteZCLTwn/mmhtDAgMaHk7dhL271L5xPxkVV35n92FykegVJPTVwGpSYoipmH7kLEEPteAIjUWift3pJaM32UvZTKBFqkHbp9bUtB30xd/nIAzS+SI8CFHbFhY0jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6SLm/cNpu28+bOH/d9Rwb8JsAO1OjRkiMvwcQpNBtQ=;
 b=MAZ5D5Bwi/hNOWNDOc3Ujbwl97YgFVfDMPt4FCqEl7pp+9zjH5rWFSTApM59e5pKJSHT83/Dx3253G2HciowIH9Q6Uh18L5XO4qEngqOJeaKpsRC6NO2zBJCKSUfYhPPgaL9MSDPP4K01NrDCaEtqWAEowEaTjuOM7wBX4DkoLkkGXpaPGKvvGCLmJw9HPIJsJe0Fsstmilie82r7Al0zDrwj8Dr/+WGNOVnFABW5aa7zmEb4kOXwDF0btush5okGG1qj5saabiCE25oXgOA9jzZUKZAEfgQTnlPvpHPU9S4uSrooeiTyGnVAgP5/020NjlkgV6jH1vWoF3iIjuWGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 DS7PR11MB7860.namprd11.prod.outlook.com (2603:10b6:8:e9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.37; Fri, 19 Apr 2024 07:27:47 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::5c31:7f0b:58b:a13f]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::5c31:7f0b:58b:a13f%4]) with mapi id 15.20.7519.010; Fri, 19 Apr 2024
 07:27:46 +0000
Date: Fri, 19 Apr 2024 15:27:30 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Tianchen Ding <dtcccc@linux.alibaba.com>
CC: <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
	"Vincent Guittot" <vincent.guittot@linaro.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, "Daniel Bristot de
 Oliveira" <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
	"Abel Wu" <wuyun.abel@bytedance.com>
Subject: Re: [PATCH v2 0/2] sched/eevdf: Minor fixes for reweight_entity()
Message-ID: <ZiIc4mU/RcSPI+WV@chenyu5-mobl2>
References: <20240306022133.81008-1-dtcccc@linux.alibaba.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240306022133.81008-1-dtcccc@linux.alibaba.com>
X-ClientProxiedBy: SG2PR01CA0115.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::19) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|DS7PR11MB7860:EE_
X-MS-Office365-Filtering-Correlation-Id: 183b6b11-6766-41bb-78c6-08dc604235ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0BSqksUqRp8Lu7ipCySV9To3jxWXisexvaF3cpHDUewnrxh9nQoxmFRlSuTod4Lhp71XdkLo6IqGhI0Sscdup7j4saX+PRKeg3JwcmbgjH06Lj3FQyxO4HZrHD+1f9NUTm54wDP8jFTNBbGC7W0Sys0A1/I/QsEt3o0cl3Tu+k6lPxMjAOzdN9+mTcxJfwZAui+RFWoWzJfv6/4G+jxxClEphAVP9e/fxl3+jewgJD571RncNGTl1VQ6eJyo/ZgZ8gN3p25ufYsyMzZjU9PTFPcU3aRtcD263EzooKdMymGH7FzzxPy2S4BeK0Oe+GE//ZFGIK+uyljle0VcEP+Nycg0IEw5lE5LK1jVpA1GIm1Hu8E95vVhsHeBoHOqW1SIjQUy9JrLehDYJCsWpJCZIaAdFyy4rXwSR5PPxuFBcriDO87unZ/I6GpS3+WmnNtFH6B2t1pe0v+nL6sTLseLkXmMVbuUZhKqBTVF+RWo31zDx8tWeciDgM6YP8Bej5qVQh6WxL2+2b+9UqLcKcka9XGNIZTVOuxhEFtQWIbBQz5s6hKeuyc0saqECDdaT6VDLrUAQ7AbTjfMZ9z+wYdJVWfETNx6PEk5pTk2nORuBfwHsETEYyKiL/sjuz6s44AWn2xRn3mwGreyON8DeeRf3lyt82N5KS/9zU8IIehkbII=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6YQkxgJfl07ZXPDEO+a2O6xkU3RWPgTKngBKim2JGa5zB7QPYPly8/GDRI32?=
 =?us-ascii?Q?UflaAsmw5NKjNokzJMKYbkiNCJr16O2JGK5ZK5cm9Ysg72nVfAdfWkePIg+V?=
 =?us-ascii?Q?HIFudNcyOGd/V22TyGDpdh9AFyz49gPe0rMSCF4JN/opai4//26unpaoIbAG?=
 =?us-ascii?Q?16LQKuKgBohKnlJ5zwLej563qko3dLN/DttGnBzEZHtd4ChsZvQCWkFOd8Ku?=
 =?us-ascii?Q?Cg/7rYsUwxyMjha0u5WQW7cNyAogiW9NwcSK3kL6/7Dc4abwhwUJh7vOSDJL?=
 =?us-ascii?Q?hoZH4/nHZlVuaW/TgYNhKCWj2JVHSPMWfPMM3v5b6wEA0PTg3YXg7NumZdWR?=
 =?us-ascii?Q?AjiCM0hQ+7UJH9k1Y6i0fqiZToUnoLOx3aTQQ2C/3vJV+DhKV2BW5DBRElkz?=
 =?us-ascii?Q?uJ79KNMAUdUarbo3QWhCI/9/iUUHuXBDiWXg69Fj4nXKbGdq/pdHw/AmXBUm?=
 =?us-ascii?Q?kLWSAoJx+l3DAvI/ukpTKDLD4fDmTdKKbG5uwtuGjLr71mO0ZI6P3q9oD0AO?=
 =?us-ascii?Q?Hg+uW8MeN4bZgq75fT7777ooXWOFw1ILoiatHk8Of9pawwrTiF2bMr2pN7KG?=
 =?us-ascii?Q?sdFdrZ8NQC+tAKLomAHEyB/ok6GZzHBwOiHNanLWml8T6hSAyFwxBC+hU8vK?=
 =?us-ascii?Q?EgMIJrS3vfzXwuW/vW+AJRQBG/Veb9E6rSd8uvUXxJ1SsB4vmC9LZwq8qnyA?=
 =?us-ascii?Q?Z7zx0LBL+0azjn4TSvjmuwhO1dSo1LsjMyOmpqAD60eIWuqK936uAn5dfk+4?=
 =?us-ascii?Q?PsHg6YbsKRISbCcJFbMsL4ottHQnK461TINbHYp0dxD49qex65zY7CSgyjor?=
 =?us-ascii?Q?ccf1vEVgXeDd3dNzBoHMBXjQL1oF46hVomGVp3EEbA8vN+PBtjiRBAKOsiOl?=
 =?us-ascii?Q?lBJzWRxNM2kYKl7Tuhq/1I1cltORAppyng3/azaNmjxw/GrSVILS0VqRU2s0?=
 =?us-ascii?Q?vxhI5WMRGdNI9Ptd7XNOX11ttVFJyM1fOI/Jr+1vNth+ZsuCf/Ir3Mm+je0b?=
 =?us-ascii?Q?7O9CdmJTrs1btoKeYUXo2s8rMrtSI6ZfhtUMOYSDY1VTEW+mxvQXhdVo36Ou?=
 =?us-ascii?Q?p3KuV+kWW38eU1XUulyjGmHWrUxvPD8mXGfO2KQw5CjaMLGj3Dq4Z4dmYNxB?=
 =?us-ascii?Q?Ei2VGc28iN7gXeqd6FLiHv16oBsxq6O3aTyPRB0lrIeE09NBHdBF9IrVTxsI?=
 =?us-ascii?Q?Cum+qbFAtpmEa5SUQKB9othw3aiINETh5gPTQTF0HnnjVIYO+ZpdDJojpxRS?=
 =?us-ascii?Q?E+tkscIlKvHdMaCiBLq9K1Xeuv2hrsGo3t4LvuZ6HD5ehAHUPF36/DjCtFVB?=
 =?us-ascii?Q?bKgK0evd3bcdRkYEUzRlhwKz6tIqTYY9AF1D2Lz4dYs/0yECwWlFHxZRn7HH?=
 =?us-ascii?Q?3X71tAFSgN+BJDkFghJmrXV9CMkX09xu48M50DJlLP9JN2sL7y0E3hT5n/ev?=
 =?us-ascii?Q?egYbKZvRtiDsmum7AhKG6TlNWxDOWD5tOTr4cUdW0H4VvhjDBm1+I1ILVlK4?=
 =?us-ascii?Q?uhbHhiYaQSfG2XqkWQZig30cmqrtU16+3gpIJ3E77LWO9rChn/Dyj1UIvVYE?=
 =?us-ascii?Q?EflZ9UHjggnO6CobmRVj7l7G7Jd8IRIgIsv9Dhe7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 183b6b11-6766-41bb-78c6-08dc604235ce
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 07:27:46.8802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: THGkOjkd15R8G3N+XX+YsTlrHk5CWmH8f3NWQAsqOXWgGvWVUubdqdX6Ekc+gBU9os0v/yBubk1olPqKwhb34Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7860
X-OriginatorOrg: intel.com

On 2024-03-06 at 10:21:31 +0800, Tianchen Ding wrote:
> According to the discussion in [1], fix a calculation bug in
> reweight_entity().
> 
> [1] https://lore.kernel.org/all/59585184-d13d-46e0-8d68-42838e97a702@bytedance.com/
> 
> v2:
> Add fixes tag to the 1st patch.
> 
> v1: https://lore.kernel.org/all/20240304030042.2690-1-dtcccc@linux.alibaba.com/
> 
> Tianchen Ding (2):
>   sched/eevdf: Always update V if se->on_rq when reweighting
>   sched/eevdf: Fix miscalculation in reweight_entity() when se is not
>     curr
> 
>  kernel/sched/fair.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> -- 
> 2.39.3
>

Applied this patch set on top of the reweight_entity fix at
https://lore.kernel.org/lkml/ZiEaKOQwiNEglYtS@chenyu5-mobl2/
it has passed 100 cycles of trinity test without any issue.

For the whole serie,

Tested-by: Chen Yu <yu.c.chen@intel.com>

thanks,
Chenyu


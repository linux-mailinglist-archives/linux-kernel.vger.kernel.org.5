Return-Path: <linux-kernel+bounces-71324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AA985A38C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACF481F2420D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DEC2E644;
	Mon, 19 Feb 2024 12:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q/+4RPAD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC682D04B
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708346140; cv=fail; b=fS3b03zNmomyqfOrV6oAlYUJ6stY96pAmCBJGYEyVv9jeELg/jCJVJSSzLz+854oJOZYM6dmF5BrELrZDTh4dAnHesQUYeeBLa/Qg07775Sm5YinnljgtyuwZLn755EPRvCK1arQpiiLk7QLns9r21mLzy9ic8ZGHclem0piQkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708346140; c=relaxed/simple;
	bh=hGipp/Ss72lTQoMCErGV/E9GwjRUh+TA4icL30kCi2c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ceyx0wMz2qCiX2SToMuvLmE3vDyBi8Cm86TAIrlZVLn+MjngH9d4gJ91pSQ9IW4BXiyACVnfNO8K/+bPC0UrwQece0EKZe6mW5CuSnZyAVnVEdfJwbOHVEqssLjiRATY9AIDyXMtPkyIyEeonWiqHzm5WrW4Eycw98pmqpVKMNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q/+4RPAD; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708346138; x=1739882138;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=hGipp/Ss72lTQoMCErGV/E9GwjRUh+TA4icL30kCi2c=;
  b=Q/+4RPADqC0uWJfJUbtBVNYvt8aTl2nBut/vTuJbV/9fJdZnU3DLBbCX
   U6fohXlBI8Z6YA097Sb+Xrn+gtdtzS7ZX2/JPd6kiFIX2QeBE7T0UNluh
   T2t2nFtSQeYJ3JwaZbLWza9MNrEsKhZMjSVSNTkFKZxBcdpRSCdrTdXts
   ZSsEK9604y0qnIwR4dP/2PO0bjajeM1KAEMp05SrIKi6GpMWBTDkVGDdC
   zoTMUF1MJcOKduwn2PF6Jme62QUKMd0IXmdC/sTsh9AGvs7ODv1Atg6Pl
   i4V0raswWgRmYcKO2yEMbO124KU3gumowuo/+Kb53+DRvTHcyKe6yTrn0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="24880180"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="24880180"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:35:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="912868582"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="912868582"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Feb 2024 04:35:36 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 04:35:36 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 19 Feb 2024 04:35:36 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 19 Feb 2024 04:35:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9I+j9gEkOxFOT9fBC5yS5ZEZ9e2430ABcXTge0kovcU28P1fRti24vnFfpcWBitaY6GbexWl4ycGDqV61Hwb/SAkVS3VfjfCk6lwHgV/6nhni99ZuPYdsXNlJ1DBpnkPyRiEZEmb2EUNQcvxWYDZxIT05xKUej+vYtZXu7rkSOSr980zJGP94lwB0Yg7MJBZxsesYizPIifCduROmqOeyKSw0HFd/pLbyuIq8M5hEqxmAJQBzhcfzeBgDiJdcomZt+WT8SW1QUzzanZ9GbVGgLHIWzofSimV3CIeJBw8H6zxAikX208PVubj+Yqc3APsCRqXovuVVY+p4vZewJWcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCXiuCzwstxVogLfKfN1XGFWAXfno1OlRcFhdYhlOBo=;
 b=UFXbcpVgOqSmzbIM3AUqFTZzOMsGp+nTsyIOiLx/gsRrGoqq6fhlc8iwOMiBe/ytDsW93NpwBaJ8tKyeStdvskfsXHhJcK3CLlLQlDMGtPmKdbv/HfB5XBb8MO72dP6l9XFdKvJQ0rKV2vY4hXjYLbrwdIAfj6J4jY+w3stygzDx1bCsNmJTpYrPV+HxUS2O2l/15/FmpMUB6mrxRxsvUu37ISrsHw9Lckm69D4Fhl7L1wKnz3hBV/lVi3XoVIafNNE6jJEXcDVZHeul9uXfhgmykN6rCqcXxx92uHwoxQ3JzgaL8SRy3NNgQnoVCDk8yyeWBIkYfffS6ezFVtoZ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SN7PR11MB6851.namprd11.prod.outlook.com (2603:10b6:806:2a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.37; Mon, 19 Feb
 2024 12:35:33 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::a83c:a9dc:f30d:507]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::a83c:a9dc:f30d:507%7]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 12:35:33 +0000
Date: Mon, 19 Feb 2024 20:35:21 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Abel Wu <wuyun.abel@bytedance.com>
CC: Tiwei Bie <tiwei.btw@antgroup.com>, kernel test robot
	<oliver.sang@intel.com>, <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	<aubrey.li@linux.intel.com>, Honglei Wang <wanghonglei@didichuxing.com>,
	Aaron Lu <aaron.lu@intel.com>
Subject: Re: Re: [linus:master] [sched/eevdf] 2227a957e1:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <ZdNLCYnJzPM2Ih2j@chenyu5-mobl2>
References: <202401301012.2ed95df0-oliver.sang@intel.com>
 <23cbb613-c8a2-4f07-b83b-fa3104bef642@bytedance.com>
 <8b21e697-c9b9-49aa-a7ad-e88a5d7f9c92@antgroup.com>
 <5f8f4222-a706-45b1-8eb2-fd4553cc57d8@bytedance.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f8f4222-a706-45b1-8eb2-fd4553cc57d8@bytedance.com>
X-ClientProxiedBy: SI2PR01CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::8) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SN7PR11MB6851:EE_
X-MS-Office365-Filtering-Correlation-Id: a1389e30-9e07-4b67-2d4e-08dc3147440f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JLALp+O/NS84AAfVTMVeLQDH65NPJixR7Xawc0dvenr957X6Xh20RH9no38BjEccXQFDV2n0ZEvnGQur7UxkvGj7UerL6n5LMzjazprVxVqsYnOS0iWPo5iT6vrMAnIAFMveEMHej76XtRjU0WizFu17QZmJqjFd6/6aoGLLg89KGFeyd/MunlxeYVUSHD0SZnlxetbGDhkKH60dpCn4RHA0n7nuzlJm73NDB73YAxpqYZfxbT4uixF1RhJf1B7seJbFLtvb2ftBEivhByo+hWdJcrD6u1RPDi1rdv9zsMgU2FqP5gYL6jgKbL2KV6NL0uPb/FO19ugyXx1HxBJrGEVzuuijZAOOJsAelUtouFmekvsaD8MPTTUR996MTdXEl00zJ67g7TdCo36ZsO5ABB8CA87bTR8vIpJRSF8oYY2V2YDOxlQ0VnXnfyC/9NH+h5gfmFB97LlxeJ2OUMZj9+WilsReMIExE07jtMh31kHnICMosIJx+ztcu0Kfqe1DK6I79juo88uqF9QJYIFGVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?yxdNL2kU1Yur6PBZkD/xKwR+YIzhOiihem/L0oXuMxxJC/MCrQA+vWhHnL?=
 =?iso-8859-1?Q?bROCCYeySQafhpkRC4DSjYhSgIy0CyBENvMw+4XfKHFuRU/8lk98NMEcVq?=
 =?iso-8859-1?Q?3aMi0ztweA1KRze07HxsbfOEMy/3AxodoGAmdfMw1y93JYVdKfuvUKHwTL?=
 =?iso-8859-1?Q?zCuQj5yK65HQ//XvXTssvh58Os1ntpO15KOf1Fx1RgBJ1f+N9ZVrBVXtlU?=
 =?iso-8859-1?Q?E3Sd2SjKTUjpO+IzvG95hTai77+in3Yxa9d1rdwsSVJH0hEBDm4F+pa1LP?=
 =?iso-8859-1?Q?VrRT0biIBbePgNS3hFQnibOqlrjHgauE4u2/+78zJzoYhTB+lX94pmlbd0?=
 =?iso-8859-1?Q?Sug7JPuUb80M38T45lRB74SW7XO2PY/+NhmjxYQzwu16ay53GWn8HjEbVq?=
 =?iso-8859-1?Q?0oKNIsf5wE/rI07ZFucUkkssNZyZL+rkJbnhdyi6LXI++xrx7L8zqq9oQc?=
 =?iso-8859-1?Q?h+HKQMexh9yj9tSEuiooucgGmZ86AWIcxuZ2M6+MQYawmnaGRPfTV2xk0r?=
 =?iso-8859-1?Q?zfUCBW0a42thDO7gqCKOIweL35crf3fHOXO4BhVI7bMgU5SDNAfqsR+Jla?=
 =?iso-8859-1?Q?lin6uj17zpe67ZEPr8aMJHa5OFOpVuU0n3ZeAyNFk1Uqs3Xeg04tGSqQG5?=
 =?iso-8859-1?Q?sxFXKw1eljHe/lMWVFhe05fz2f403q4fnTOYxou/KwLJX0SMT9tAbywnWm?=
 =?iso-8859-1?Q?g1rsqB/dUK9NSQQSeRvhNN86GQDRPqZBNGbuq5MMyaAQ0lIiRg0aAozp5g?=
 =?iso-8859-1?Q?4D+gCzEjprX9mPRK2dyjXgfRXyRjXCeGg9FDdGnUseOIvXytPk9rn6t48/?=
 =?iso-8859-1?Q?hXGaDTx25O/rIxGe5XOGSdFWn4n831VICEC0hy+dDqmNYhNQ2VwnrrvZG5?=
 =?iso-8859-1?Q?p0YeOhdaUqGDTbKw/lVGM3cXVICIrnnrE0R1v43JThH62PbxXmQ91HpGuH?=
 =?iso-8859-1?Q?01yevoWeIhItuTr+/Hb+9sYLlIfsj0jo+7A2HrxeHOakY7C2GuSyvBvzI5?=
 =?iso-8859-1?Q?uici6P7zYH/pXIE/ZJI/uJSn7oEnXHxkfUmEQV8ayRkLkp9XYvDmQNOOAB?=
 =?iso-8859-1?Q?A79hk1+Q5MptHszSbCYNWaAusQKQvKDoAIYeXcNZjAhA23DIF2O60yc7Bz?=
 =?iso-8859-1?Q?2C7p62H8s4wdaDiy/D8Z84r7trIvQ1nzL0497vhZU4NE4EShpdV+B2utNq?=
 =?iso-8859-1?Q?XYPhA97vb+rMRwK2tqL74xMJVuskuh2ytLTcrF1DQqo6TLhyJNpADGxys4?=
 =?iso-8859-1?Q?Ia8aHmvMdl1fEei1nNMdVMN6UFL4ENBVXv68oen6/TVD7hq+Zm01pBCDVg?=
 =?iso-8859-1?Q?UlHY7O7+arFaVDLfZhtpdDd8ERHEeX17Rhe5sNxbNEeXToXugniR74jGJm?=
 =?iso-8859-1?Q?h+LQVMqryFXCHI/ykT01iwfarxU22hE1Vya0wBQ9Zrn8FPfLzztkayOz0o?=
 =?iso-8859-1?Q?24+RKSPHpJNsoZn1Cj5vzu3L2mkaX9enWjG5xzro43WYZQiRtJdmg08BnD?=
 =?iso-8859-1?Q?HPelnz7i7Ie++QPrHiXa4z5uoZdWsdaQZQJUoxnRy1z5cqYW58WUvlOUjD?=
 =?iso-8859-1?Q?OaVL7RR/AP6feznQuzk68EzQjEvacztDcOH9+dPsoOzPS/OE37J/G+3duH?=
 =?iso-8859-1?Q?iJ1tXMjwR9VW989vXWud9EmhjJLi8gDuMS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a1389e30-9e07-4b67-2d4e-08dc3147440f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 12:35:33.5195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FTJ4BvVhCSx85cPiQQ9tS9+XXCAiMmaJ7vkfyX6gai2woOBGJaq7QKL6J0CNXsmOckuXfHWiyRwg8QNl5Kj3tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6851
X-OriginatorOrg: intel.com

On 2024-01-31 at 20:28:19 +0800, Abel Wu wrote:
> On 1/31/24 8:10 PM, Tiwei Bie Wrote:
> > On 1/30/24 6:13 PM, Abel Wu wrote:
> > > On 1/30/24 3:24 PM, kernel test robot Wrote:
> > > > 
> > > > [  512.079810][ T8305] BUG: kernel NULL pointer dereference, address: 0000002c
> > > > [  512.080897][ T8305] #PF: supervisor read access in kernel mode
> > > > [  512.081636][ T8305] #PF: error_code(0x0000) - not-present page
> > > > [  512.082337][ T8305] *pde = 00000000
> > > > [  512.082829][ T8305] Oops: 0000 [#1] PREEMPT SMP
> > > > [  512.083407][ T8305] CPU: 1 PID: 8305 Comm: watchdog Tainted: G        W        N 6.7.0-rc1-00006-g2227a957e1d5 #1 819e6d1a8b887f5f97adb4aed77d98b15504c836
> > > > [  512.084986][ T8305] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > > > [ 512.086203][ T8305] EIP: set_next_entity (fair.c:?)
> > > 
> > > There was actually a NULL-test in pick_eevdf() before this commit,
> > > but I removed it by intent as I found it impossible to be NULL after
> > > examining 'all' the cases.
> > > 
> > > Also cc Tiwei who once proposed to add this check back.
> > > https://lore.kernel.org/all/20231208112100.18141-1-tiwei.btw@antgroup.com/
> > 
> > Thanks for cc'ing me. That's the case I worried about and why I thought
> > it might be worthwhile to add the sanity check back. I just sent out a
> > new version of the above patch with updated commit log and error message.
> 
> I assuming the real problem is why it *can* be NULL at first place.
> IMHO the NULL check with a fallback selection doesn't solve this, but
> it indeed avoids kernel panic which is absolutely important.

I tried to reproduce this issue locally but with no luck. It might
be related to lkp's environment so I'm thinking of adding the following
change into lkp's test repo to help narrow down: when the pick_eevdf() finds
an NULL candidate, print the whole rb-tree, including each entity's vruntime,
min_vruntime, deadline, etc. So we can figure out why we failed to find a proper
entity, thoughts?

Example output:

[  325.425017] cfs_rq avg_vruntime:-798130176 avg_load:8192 min_vruntime:29296269335
[  325.425247] current se 0xff11000105858080 is on_rq, deadline:29299081075 min_vruntime:29296537185 vruntime:29297356572, load:1024
[  325.425514] Traverse rb-tree from left to right
[  325.425635]  se 0xff11000101a28080 deadline:29293835648 min_vruntime:29290835648 vruntime:29290835648 eligible
[  325.425876]  se 0xff11000113113000 deadline:29298566205 min_vruntime:29290835648 vruntime:29297726206 non-eligible
[  325.426121]  se 0xff110001036cb000 deadline:29298613981 min_vruntime:29290835648 vruntime:29297094477 non-eligible
[  325.426358]  se 0xff11000118148080 deadline:29298616409 min_vruntime:29297255015 vruntime:29297255015 non-eligible
[  325.426597]  se 0xff11000111523000 deadline:29299066492 min_vruntime:29290835648 vruntime:29296949653 non-eligible
[  325.426836]  se 0xff11000106173000 deadline:29299152426 min_vruntime:29296537185 vruntime:29296537185 non-eligible
[  325.427085]  se 0xff11000105f03000 deadline:29299269335 min_vruntime:29296269335 vruntime:29296269335 eligible
[  325.427322]  se 0xff110001043c0080 deadline:29299707737 min_vruntime:29296707737 vruntime:29296707737 non-eligible
[  325.427558] Traverse rb-tree from topdown
[  325.427648]  left se 0xff110001036cb000 deadline:29298613981 min_vruntime:29290835648 vruntime:29297094477 left half eligible
[  325.427917]  left se 0xff11000113113000 deadline:29298566205 min_vruntime:29290835648 vruntime:29297726206 left half eligible
[  325.428171]  left se 0xff11000101a28080 deadline:29293835648 min_vruntime:29290835648 vruntime:29290835648 left half eligible
[  325.428440]  middle se 0xff11000101a28080 deadline:29293835648 min_vruntime:29290835648 vruntime:29290835648 eligible
[  325.428679] Found best:0xff11000101a28080


diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 533547e3c90a..ddacb3dc91b9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -856,6 +856,69 @@ struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
 	return __node_2_se(left);
 }
 
+static void debug_print_eevdf(struct cfs_rq *cfs_rq)
+{
+	struct sched_entity *se, *curr = cfs_rq->curr;
+	struct sched_entity *best = NULL;
+	struct rb_node *node = cfs_rq->tasks_timeline.rb_root.rb_node;
+	struct rb_node *n;
+
+	printk("cfs_rq avg_vruntime:%lld avg_load:%lld min_vruntime:%lld\n",
+		cfs_rq->avg_vruntime, cfs_rq->avg_load, cfs_rq->min_vruntime);
+
+	if (curr && curr->on_rq)
+		printk("current on_rq se 0x%lx, deadline:%lld min_vruntime:%lld vruntime:%lld, load:%ld\n",
+			(unsigned long)curr, curr->deadline, curr->min_vruntime,
+			curr->vruntime, scale_load_down(curr->load.weight));
+
+	printk("Traverse rb-tree from left to right\n");
+	for (n = rb_first(&cfs_rq->tasks_timeline.rb_root); n != NULL; n = rb_next(n)) {
+		bool eli;
+
+		se = __node_2_se(n);
+		eli = entity_eligible(cfs_rq, se);
+		printk(" se 0x%lx deadline:%lld min_vruntime:%lld vruntime:%lld %s\n",
+			(unsigned long)se, se->deadline, se->min_vruntime, se->vruntime,
+			eli ? "eligible" : "non-eligible");
+	}
+	printk("Traverse rb-tree from topdown\n");
+	while (node) {
+		struct rb_node *left = node->rb_left;
+		struct sched_entity *se_left = __node_2_se(left);
+		bool eli = false;
+
+		if (left) {
+			eli = vruntime_eligible(cfs_rq,
+						__node_2_se(left)->min_vruntime);
+
+			printk(" left se 0x%lx deadline:%lld min_vruntime:%lld vruntime:%lld %s\n",
+				(unsigned long)se_left, se_left->deadline, se_left->min_vruntime,
+				se_left->vruntime,
+				eli ? "left half eligible" : "left half non-eligible");
+		}
+
+		if (left && eli) {
+			node = left;
+			continue;
+		}
+
+		se = __node_2_se(node);
+
+		eli = entity_eligible(cfs_rq, se);
+		printk(" middle se 0x%lx deadline:%lld min_vruntime:%lld vruntime:%lld %s\n",
+			(unsigned long)se, se->deadline, se->min_vruntime, se->vruntime,
+			eli ? "eligible" : "non-eligible");
+
+		if (eli) {
+			best = se;
+			break;
+		}
+
+		node = node->rb_right;
+	}
+	printk("Found best:0x%lx\n", (unsigned long)best);
+}
+
 /*
  * Earliest Eligible Virtual Deadline First
  *
@@ -937,6 +1000,9 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 	if (!best || (curr && entity_before(curr, best)))
 		best = curr;
 
+	if (unlikely(!best))
+		debug_print_eevdf(cfs_rq);
+
 	return best;
 }
 
-- 
2.34.1

thanks,
Chenyu


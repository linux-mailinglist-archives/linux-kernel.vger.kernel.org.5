Return-Path: <linux-kernel+bounces-126134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC388932A1
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B93EE2825AB
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791A4145344;
	Sun, 31 Mar 2024 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EUiNhQgn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E8422079
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 16:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711901591; cv=fail; b=ffxdabHcOxS5+5zgLWfzFtshbEIj7m+nRQ/86J02PAji+AyBmdS0x4/r3PuNd/6dfua6oPenHx7i8nYbOy8in4z5iMwEuWeAFeXD0PzxwxSnjN9oH1ovJIOnIXys36ylzo0PuYd25kLrbWVHJLYpNP8/WCNCDscrS368vbxMml4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711901591; c=relaxed/simple;
	bh=bDVFUdlhJSdTwfZ5EfKE69xICWv9xX29IMO/Gznlqb4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HWGrhAQx3fVZqF5twuIouvdw3Ra0iZFhpKNHU0zQzXZyfrlGhb0K6qqj+7rDJmHQL9gJ4nPBV1CbPsFuU4ROSDhJFktnI8hOdQbvP+5LYLUCORxPCi8tyy2WpvRS/hJx/ppw7C4jz3V525ACiy9Tb5513aYuRA8iwQ0KK6EjOv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EUiNhQgn; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711901589; x=1743437589;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bDVFUdlhJSdTwfZ5EfKE69xICWv9xX29IMO/Gznlqb4=;
  b=EUiNhQgnQ+D/0E4v1jzObF3yDiAsGbB0m9q3HVj83qnVyCYp6Do8lHQY
   2mW+YRvkOyocwbAwuGqjfquf00DVDGlmE3IeRyZkImd3VbeCFWBPk0iE7
   u5BwGX38kKwq4zn5b3vjnWlRzzi7gCKNfO8GdWZDQ98it86mdl9m4U4Q2
   BZFA6HAVgPBc6+5zLRxvjg3NIiPOzcKPl0KOqMwMbV8HD68MuSHn/zWpz
   i7WcaDQes6cEtAaOEBYfT7cFqEKbRxzXvhwQDNVU1C2ijOiyN5vLRXerb
   JDqtweyaS4TEKh3htdpY1MNu/3/jzN6gIPJaXMhnSQh9pVPUSSOl8Yomu
   A==;
X-CSE-ConnectionGUID: kZPHbgE2RaSgnU5cnbELtg==
X-CSE-MsgGUID: N8qWAkulTsugICV7EDVdrw==
X-IronPort-AV: E=McAfee;i="6600,9927,11030"; a="7626187"
X-IronPort-AV: E=Sophos;i="6.07,170,1708416000"; 
   d="scan'208";a="7626187"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2024 09:13:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,170,1708416000"; 
   d="scan'208";a="22223849"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Mar 2024 09:13:09 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 09:13:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 09:13:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 31 Mar 2024 09:13:08 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 31 Mar 2024 09:13:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8ngHVA2/Q1Kal7QVXBbCVyU/UKxN/8jCZbkyqoCJdQklcv88x/Ya9165J+fiNKYEyTFP8zLmobCVFiXjxm9VtZgyYUJydi0Q7+7Bq2FD3J8/6FvPGfXE9bQkPRfMv+Xv6OMIvE5WBCB8eUCOI7CwzFvsbTip8PnZbMVh5a7tjOxmazBNoaXL8PanrRioU+8I5ggOc7xw8kI0Dzeh3f+u6X+Ra/Hx+HIPenX5Z89aibo60FL3eDsfj/YfF6MMpj14nO7LeyCTHMpWdtxjk1A+S/MAE7VDKgJJuGr1dtd6wGpfhE4qXFm38U1liszgbezcm9dCtt3Ahdr+WHzQq7a+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bccxJOOt8wP1MsD59COGipIZolXf7r3yRDI+vy0kANU=;
 b=nAi+j/WkT3h5QkNRc1ZPSZOmNi7blIgPvTh1uQU93uJuP35liA2pRofiI8qw8CoaqheeMdgz3sSJmxILzlutnULcsNzUNQjLkfIqNFvh0EScTNjiP9AX7glyxKzGYiU6eWZhUyiezM4ZTdX+e/ASABApx34uvtqr4idZaKXQvBh/8orCKlwLGkUrvCQQ5IMy4oAu5eWASkHweaTO+N6zHs0SaTVqmjurCpi1AH+NAl7++BFWC42b1eYCjhDeTRb0Q2zmkrLgZhjQveIb7kn+jGXiVhygfJnzPiK5w67gQF/+qYu92eh5c0/uqO2xYzV+FGMF8T+v2T9l6e/KwZZ8jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by SA1PR11MB8476.namprd11.prod.outlook.com (2603:10b6:806:3af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.41; Sun, 31 Mar
 2024 16:13:06 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::7118:c3d4:7001:cf9d]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::7118:c3d4:7001:cf9d%6]) with mapi id 15.20.7452.017; Sun, 31 Mar 2024
 16:13:06 +0000
Date: Mon, 1 Apr 2024 00:06:26 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [paulmck-rcu:dev.2024.03.27b 61/69] lib/cmpxchg-emu.c:24:11:
 warning: no previous prototype for 'cmpxchg_emu_u8'
Message-ID: <ZgmKAil/a3+av1E8@yujie-X299>
References: <202403300508.Xz7XNp71-lkp@intel.com>
 <e4b7ecac-719e-40f5-80b5-7a1c63e72b33@paulmck-laptop>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e4b7ecac-719e-40f5-80b5-7a1c63e72b33@paulmck-laptop>
X-ClientProxiedBy: SG2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::9)
 To CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|SA1PR11MB8476:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /xUubxW7/QtgNVzH5wUb2AmEIP1tsyk3cIHk4RP1OnI01+FY0jnptzZXgN7Ie//PEIklhaulmnYP9oQCnV3uexXD+ek3hwfPemczHA1p8X1kTeD+/vdfdzOsNXW0YBufJSKHwO4FAcTczpMffnrYY9qHX9ZNoCwQ8l/ZvKQK2bbnAPFmWG+9wpLC6uVW9Selg/MQn9hnjMFnafRjZw8nJDgreIzwe5c3O51wVYQdfCzn7C5EU8gW9UXHyE46OLkDCe4ocJWQ++R1RQaOd/JWqCTHy7KfxF3394wjbMDKIGPLxO77zCKdcEUYxZlplW+s1dD6cJUgqs3lqXb4hTCvb0+hUblgFsUQYshk3xvzb307EpmMzpVqd5XLso+f2uXrXcXo4qHXFwKJBoQOwHGdIynsGNwuY8zJbJ6l2I83rnsNl9LC14YRHyV5IWuPZGTEP35eQP/hLhnemQpqxHE5vnylXe949Tu6z80nTb1ric5m53uQdcDnsgPWS71TsLy+AzdUwPudtWLJ+9Sq9s9gdZ3YkqQxa70DtRyjXhkrdv7iXr+TRdqlq8oOhe9a9rlW6CVcV8tM7W5v9nJ25f3+FJbEQ0QtZ3iwu5XUipTwaHtTVWTxfJwSwgTD6wh2GkGV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FroNJKV8UMkTe25UWjEwx/t8Egvz5clnrR1Yea4I59atea41nkYa1xDt/L/0?=
 =?us-ascii?Q?Qrvlo9BhHZtCs7Rpz5Z/xzaWR5ModuXDMSEpnsVYLkLzbHVUA+ozXxnc4cXs?=
 =?us-ascii?Q?S1SB4f+WjrQGeW388I/P0rx/HpYXoHOqIqBI89urRjuUC0/r7wkv4gbzPi5X?=
 =?us-ascii?Q?voC7myyoJImv+RcyPLOKchaynMjokHmVlhH4Lcv37G0zJcCyc7uQyDvyh7MZ?=
 =?us-ascii?Q?y8fPWNwWU61NTRWFZU4cP/eAhADTk7IG5GH/F92/8YIj0fAjw5vr6eOV+9Vk?=
 =?us-ascii?Q?YQUldObzRQqIlucWDOzN8Bdzy9c1ABNyyS+CZ1bB2W54lglv3rmVJiwwxz5H?=
 =?us-ascii?Q?mYNXr7GpaL0kNn3q/xji9kVdVAEH3Sulug4H0Ge3jzXX3ex24O0r0Rl2gfP2?=
 =?us-ascii?Q?u+r0C2oaketCMvNVTfwxnKCGfyM3ZgEIuXgJc9npiIfauFma3fu5sJRprI4d?=
 =?us-ascii?Q?ML6DBKWkvDYl6yAfXEb/UgQO64y5YxFzHmCg3tylh6sLd6vCUfJtSBdKidbL?=
 =?us-ascii?Q?zLyqC7eXe6WHyUEMmrUZ/sB4c72C0AAqsL1Mm4pqh/OD+swZYZoj82kltnI9?=
 =?us-ascii?Q?YMRMeC8o95fc8qzlTWTxsEUCSF43uJ5JzM8TMwVJdTwLeM8d8Y2kivVujNW0?=
 =?us-ascii?Q?rlcwza00tfPJB3ECjjuAL1j+N3gi4/NNy7ad9Oo5aSry7VfyUVpTjKNYk5EE?=
 =?us-ascii?Q?SCz9QoGE9Jmz5BNbGbf3n5To8gPzGxYToxXXIctrL3hnBPvhBGQHs1xKWzbY?=
 =?us-ascii?Q?3C+4Nw8AUyQPHl3L2clENBHgxOI7gvkBJZdmLc0PXCaCa6sNyLhBdkMmYI9V?=
 =?us-ascii?Q?rjQ6MmSM8j+7AAk+obij/uJoXmkjhaeMHID2hPz8zR/UGd6p0uGr+Xp+dNAf?=
 =?us-ascii?Q?KUAAIp5sy9+IqqRDRoQWWktFmiBYCSEIyn6pjQcDNwIiLFqCT7XqDtsH9Lhj?=
 =?us-ascii?Q?ofALF3VUjFDTtjQn781O4Xf/RItsxbTrL7kma/cvQ0iKzF0Y+rAALoOCFKS9?=
 =?us-ascii?Q?IDqr8MMicPA5ZSPcFlr/+TJg1fctIsZrmi778EqSylhz92yV//5Jdu53h7YK?=
 =?us-ascii?Q?zIBH4+IV6Gi8Fomc3hQVl0LW/u67h44qFLkZBanYqc82PSNUx1jVHPqdXeGp?=
 =?us-ascii?Q?sFfWz0z/o8NxFnG3TQhP99E9nGP+yEK/cqSRPfGo2totOM7gDNfb4CcpgB9J?=
 =?us-ascii?Q?yG554z/ElGPvKcgQZv8Ee68Irhh6eSoauVv3V5uhnbpIFasyKNprneyKz/Mz?=
 =?us-ascii?Q?tXLFT1GNdh9j6b78s8Qn8WyhJaAtPxOWgPd3zUbR+CoktfLeV8v01Ib8qsJW?=
 =?us-ascii?Q?qHWtb5dL7WkcN1XM5rkrFJKyYlULYBoNqG7XibBma2jXzVHdelHCMTpiXfry?=
 =?us-ascii?Q?vwOgYem6pyz892gvbTpF7+TPQ6R4U/ykzgmxgCeDNGINdJYP3qtEJYKhs17D?=
 =?us-ascii?Q?4igYCuLt/s6kDja9SaNcH1kifR0Ys2ikgjWPctUB/Gm0Lnm2Cj+N3SfRkxqk?=
 =?us-ascii?Q?HvpeuSvTVFquwDG6w2/8k7rGrCZlFdzrKg9JoRFn84LxAgFOo/5qO2Pj4wrY?=
 =?us-ascii?Q?7AQUmJhc8Byhko/gMh5gnn3lWODncIiZwihLqNgi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 56eedc98-eb07-446a-5211-08dc519d7332
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2024 16:13:06.5866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PzsVzvsKxMXqfe+W0VXw3pRJ4noXqpPNU/2Dy4fV6yCK/iBoTKuRo5pMvuiyDn40qVglG2gf58QomQaIDLqAxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8476
X-OriginatorOrg: intel.com

On Fri, Mar 29, 2024 at 04:08:10PM -0700, Paul E. McKenney wrote:
> On Sat, Mar 30, 2024 at 05:26:12AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.03.27b
> > head:   786fab3085d764055a78edb54023420920344333
> > commit: b48ffed4c636b96d2be7a93806870772ce34961f [61/69] csky: Emulate one-byte and two-byte cmpxchg
> > config: csky-allnoconfig (https://download.01.org/0day-ci/archive/20240330/202403300508.Xz7XNp71-lkp@intel.com/config)
> > compiler: csky-linux-gcc (GCC) 13.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240330/202403300508.Xz7XNp71-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202403300508.Xz7XNp71-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > >> lib/cmpxchg-emu.c:24:11: warning: no previous prototype for 'cmpxchg_emu_u8' [-Wmissing-prototypes]
> >       24 | uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new)
> >          |           ^~~~~~~~~~~~~~
> > >> lib/cmpxchg-emu.c:51:11: warning: no previous prototype for 'cmpxchg_emu_u16' [-Wmissing-prototypes]
> >       51 | uintptr_t cmpxchg_emu_u16(volatile u16 *p, uintptr_t old, uintptr_t new)
> >          |           ^~~~~~~~~~~~~~~
> 
> Again, good catch, and thank you for the testing!  Does the patch at the
> end of this email fix things for you?

The warning is fixed by the patch at the end of the mail.

Tested-by: Yujie Liu <yujie.liu@intel.com>

> 
> 							Thanx, Paul
> 
> > vim +/cmpxchg_emu_u8 +24 lib/cmpxchg-emu.c
> > 
> > 0bbce967f3ecfc Paul E. McKenney 2024-03-17  22  
> > 0bbce967f3ecfc Paul E. McKenney 2024-03-17  23  /* Emulate one-byte cmpxchg() in terms of 4-byte cmpxchg. */
> > 0bbce967f3ecfc Paul E. McKenney 2024-03-17 @24  uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new)
> > 0bbce967f3ecfc Paul E. McKenney 2024-03-17  25  {
> > 0bbce967f3ecfc Paul E. McKenney 2024-03-17  26  	u32 *p32 = (u32 *)(((uintptr_t)p) & ~0x3);
> > 0bbce967f3ecfc Paul E. McKenney 2024-03-17  27  	int i = ((uintptr_t)p) & 0x3;
> > 0bbce967f3ecfc Paul E. McKenney 2024-03-17  28  	union u8_32 old32;
> > 0bbce967f3ecfc Paul E. McKenney 2024-03-17  29  	union u8_32 new32;
> > 0bbce967f3ecfc Paul E. McKenney 2024-03-17  30  	u32 ret;
> > 0bbce967f3ecfc Paul E. McKenney 2024-03-17  31  
> > 0bbce967f3ecfc Paul E. McKenney 2024-03-17  32  	old32.w = READ_ONCE(*p32);
> > 0bbce967f3ecfc Paul E. McKenney 2024-03-17  33  	do {
> > 0bbce967f3ecfc Paul E. McKenney 2024-03-17  34  		if (old32.b[i] != old)
> > 0bbce967f3ecfc Paul E. McKenney 2024-03-17  35  			return old32.b[i];
> > 0bbce967f3ecfc Paul E. McKenney 2024-03-17  36  		new32.w = old32.w;
> > 0bbce967f3ecfc Paul E. McKenney 2024-03-17  37  		new32.b[i] = new;
> > 0bbce967f3ecfc Paul E. McKenney 2024-03-17  38  		instrument_atomic_read_write(p, 1);
> > 0bbce967f3ecfc Paul E. McKenney 2024-03-17  39  		ret = data_race(cmpxchg(p32, old32.w, new32.w));
> > 0bbce967f3ecfc Paul E. McKenney 2024-03-17  40  	} while (ret != old32.w);
> > 0bbce967f3ecfc Paul E. McKenney 2024-03-17  41  	return old;
> > 0bbce967f3ecfc Paul E. McKenney 2024-03-17  42  }
> > 0bbce967f3ecfc Paul E. McKenney 2024-03-17  43  EXPORT_SYMBOL_GPL(cmpxchg_emu_u8);
> > 0bbce967f3ecfc Paul E. McKenney 2024-03-17  44  
> > 0bbce967f3ecfc Paul E. McKenney 2024-03-17  45  union u16_32 {
> > 0bbce967f3ecfc Paul E. McKenney 2024-03-17  46  	u16 h[2];
> > 0bbce967f3ecfc Paul E. McKenney 2024-03-17  47  	u32 w;
> > 0bbce967f3ecfc Paul E. McKenney 2024-03-17  48  };
> > 0bbce967f3ecfc Paul E. McKenney 2024-03-17  49  
> > 0bbce967f3ecfc Paul E. McKenney 2024-03-17  50  /* Emulate two-byte cmpxchg() in terms of 4-byte cmpxchg. */
> > 0bbce967f3ecfc Paul E. McKenney 2024-03-17 @51  uintptr_t cmpxchg_emu_u16(volatile u16 *p, uintptr_t old, uintptr_t new)
> > 
> > :::::: The code at line 24 was first introduced by commit
> > :::::: 0bbce967f3ecfc6da1e7e8756b0d398e791b8dee lib: Add one-byte and two-byte cmpxchg() emulation functions
> > 
> > :::::: TO: Paul E. McKenney <paulmck@kernel.org>
> > :::::: CC: Paul E. McKenney <paulmck@kernel.org>
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> 
> commit a326496eb88936b291adea830c2e59e74ca1d373
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Fri Mar 29 16:06:45 2024 -0700
> 
>     squash! lib: Add one-byte and two-byte cmpxchg() emulation functions
>     
>     [ paulmck: Apply kernel test robot feedback. ]
>     
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/lib/cmpxchg-emu.c b/lib/cmpxchg-emu.c
> index abdd451767220..a88c4f3c88430 100644
> --- a/lib/cmpxchg-emu.c
> +++ b/lib/cmpxchg-emu.c
> @@ -14,6 +14,7 @@
>  #include <linux/panic.h>
>  #include <linux/bug.h>
>  #include <asm-generic/rwonce.h>
> +#include <linux/cmpxchg-emu.h>
>  
>  union u8_32 {
>  	u8 b[4];
> 


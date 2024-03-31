Return-Path: <linux-kernel+bounces-126130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3879B893288
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 136621C21D93
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF3F1474B7;
	Sun, 31 Mar 2024 16:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jl7Y9ors"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CD71465A2
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 16:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711901273; cv=fail; b=fMDxn5wnoMbUFkBHbULfwqd1+KcaC6asrc5oKJyfHUbQzIEa2JyyOgCOU/t9Ef7GNZxtC52XQ55nhmJAPpNOODvSm9DqKBXE2P3/8xO9Zn3sNXBD/zJd6+5CFDfdUjwlI6lHM5p3jFhS+q6bYZe5mRJA7bV0Z4Apy59Fma0HzIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711901273; c=relaxed/simple;
	bh=ROUD/NtB2afjyy4nZ+HTeQn33ckLP6ZF+S2OGUYMlcY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FE0iWeohonm7c/Aqb659sCdwZFSsoK7ts8zi1PhZ5JWZxbFW+U4vq4tudNZzIRZFVEIiLBsNxQ45Vqj2FWGFKMmQUjorw5RlxWsCoejje6PAY8QxqL6iH1JQKx/b+XQHiyOyXyJmLJ75Db+wtGvTuujmfYrMe1RFTiiMVjZHh3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jl7Y9ors; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711901272; x=1743437272;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ROUD/NtB2afjyy4nZ+HTeQn33ckLP6ZF+S2OGUYMlcY=;
  b=jl7Y9orsZe5aHcYKciuqZNRfBHQEWTQqUSOCWtycqUQ2G6/pt4vdQQPB
   cHlqI4u/qSggE2tdYD6cnKklPiS0YpPD8LILFuYldmx8TLtofTdVAMi1C
   8uyTDRNmThtfXuMTCkmm8hVv1wBGorqj5gNeGkvAumjKOZAAZ7lidep9+
   jPfZjUCMSazWW2FUTbHBTjDhe2kLrZxHVOY3SmBk2SjBiFvy5Hb2UOec6
   E+gBzhuAKL79ThCl/0wb8wtSpxN8z7PPZfuz4qZIkIyCHRVGLnqSZpeTD
   oK8GNLX5qfMq2nto29d+cM9fD8XxDHZaU1qJHwYUAci84i4L1tP3isAqG
   w==;
X-CSE-ConnectionGUID: pMTOkiDxSEqK8nj2A3WP1Q==
X-CSE-MsgGUID: YdZD9237QLmH7fuqD93dsw==
X-IronPort-AV: E=McAfee;i="6600,9927,11030"; a="17598099"
X-IronPort-AV: E=Sophos;i="6.07,170,1708416000"; 
   d="scan'208";a="17598099"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2024 09:07:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,170,1708416000"; 
   d="scan'208";a="22170039"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Mar 2024 09:07:51 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 09:07:50 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 31 Mar 2024 09:07:50 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 31 Mar 2024 09:07:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqXkXmVAFeHGKt9BLiArI3T77Z4TOfFuoJCTRPnbQBjZLKFud78djb3G2MQSUdy9QTVoXUwnx50Hy1n4Q+aL5awX8soBaHO/Y7bft3otxyZLZ9Bh+idH/wljI1RqO2vcZwzixNoApeqCZjGihWnFH1UthMANv0b28IjvYPr8hrc999Q9PRcgTMsqX1X910SAsOzHa+Pm8AoDN4jrkRGsRX1sg9MfzguFrF9mSpdEuKV2+h8L+vCIyHA3CU88YMgF6wsQv8ti6uuAtlJe9WiFJ/+t6nWxBIvOwwf5WXRmIorQAOxgl48q/h5uyOcZCdpcf32+sJOIhdhNdccNa/dHJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAMU3ZjsN04fgM1duXRbRPWZa6mRQ9V2UGIp6sFTb38=;
 b=lIBdyKBxMBGh17MG3948rguQ6LMq8L61UyDxS9m93t4zuF1dAPZ6bqmwftQpdyJJ4Cb27i29zyicMvLvXB1B2X7MSnyfXqDNl17ypdeeGeWQAVVbhkkf9DgnrQwUDGuIE2PtjEiSiahPBFR2jqU8HFZG53JrNuUiBHzmndunGS8bmejItyCI7aS0spg9NWoQiH6iS3Gy3sSdNNWIxe4rKqPqDwX4W6Jsbd1fp8AlQY7BYlRVht9m9GNhZz9/koCxeFz7wZI1gG2qovhzB2DAEkqVMOmaRYCeii61AkjpsgKLV4/q3wVB3gUTzBoS1ZVvqomF2wiA/kgLYIa7KFfB4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by SA1PR11MB8476.namprd11.prod.outlook.com (2603:10b6:806:3af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.41; Sun, 31 Mar
 2024 16:07:47 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::7118:c3d4:7001:cf9d]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::7118:c3d4:7001:cf9d%6]) with mapi id 15.20.7452.017; Sun, 31 Mar 2024
 16:07:47 +0000
Date: Mon, 1 Apr 2024 00:01:06 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: kernel test robot <lkp@intel.com>, <llvm@lists.linux.dev>,
	<oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [paulmck-rcu:dev.2024.03.27b 66/69]
 include/linux/atomic/atomic-arch-fallback.h:2026:9: error: call to
 undeclared function 'cmpxchg_emu_u8'; ISO C99 and later do not support
 implicit function declarations
Message-ID: <ZgmIwuxCR9+pK8MP@yujie-X299>
References: <202403292322.bwguovKc-lkp@intel.com>
 <45452057-6655-4bab-a27d-38f2dff018e8@paulmck-laptop>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <45452057-6655-4bab-a27d-38f2dff018e8@paulmck-laptop>
X-ClientProxiedBy: SG2P153CA0005.APCP153.PROD.OUTLOOK.COM (2603:1096::15) To
 CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
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
X-Microsoft-Antispam-Message-Info: QYrZbh6rkHsbVp0R8f07NmPsrIDyyvUbU4XieDYsNczVZTtSAU6ZtT0wPHQsXbTAx2LFXqPvp9k2hhKi+6ZTqSKmxtivYpEYc0l1wzxe2nZXBA4uOd5Qd05ExyCqdfAhO3UlTzcHJYRR8mDAv8jorzfoR9P9ppPZZjgqBDlUkQvj7l4nhlp1QYc/TlHRxj6xTcr0NLfcFaueGG0m/ihCwB8uiuUw8n8beWkRYdj9kghhaNQ/pkQEKOKyinBc98eVK1CyBgxPvaFUzynBi99vVyOuRw5Eh8DhKjYtvEb9VdzqvHWsPJ0abjV9m4/A7OTJxNWwlf4+NGb31eFfsQhsNo/A4/TrUoZzqE8cFnC7YxFxB67eDXM9yPoUlLI88Jgc8EqXKBbPswcDqxE4T+SPprD8uv6wSKAb9UIueY7iNKH8j9BvY5dCL67L457Fr6CkCt4EyOhK2ZJ5PsHSF0TyF46rbpnlACkYnHl2NwInFX2TR4W0VoFhEraxlMDB6oWehZcVxzz8XF3uzwihcYnRCkqALfspuT1J26LPb0RidPx6TZr5nkDaOtkGiUOSGq4WJoeigmhduJU++K+2Nr80du54LQMv4N+LYbfZXvIjvhDP1tUhLeRPcKJ0NHn0dmY6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zYLoD0pEZNCXPC0puETLQVkM7EaxpzK4JoG6zA6olE1qEvYLN3zpjitS3+Jl?=
 =?us-ascii?Q?pj/kl9PAW0UAxL/EDTLbnpEArTwiyDVQ7kQ9yAm4s7dlJcFfYOcM71n2JkA9?=
 =?us-ascii?Q?5NMwAxKJXypqe9u0guu64HUFhrH0TJVbiSAQezKdcXKk+WUUGbFYdcGoDUNR?=
 =?us-ascii?Q?feo57s2u882QIsHkOUQPVST8SU/j0i0EO3zcPotzyru2gHAG5WsRKIyEXChB?=
 =?us-ascii?Q?Y60EPBi21rLdo02/bZ2ouadyGTrHWOpytbj3yYnxfPzSoMA8imfZ8qMj4kNq?=
 =?us-ascii?Q?wz9MytsrOFhFr77anFXYf1+WiJb1CYZBI6Ctqgu9nL0L5RypOQ2bYkWQfC0J?=
 =?us-ascii?Q?G2kQKzMO2CEM9JHIxinsIHL8pOjwbpT9nHCSc+u3W/CC3HG0mbzhhm6T9QOR?=
 =?us-ascii?Q?nxNcNEPIGnHoKv6qGePFvySGNe9j/rTKZYAqa3+Lg29s0TTvzdribY9A97LK?=
 =?us-ascii?Q?kvQHte0lZFiXFju345FvTszrYqrgy7aKK3GLYJgxO/ugPKEDYpozTRajXsvY?=
 =?us-ascii?Q?0SgeNlFOtweOmMFACtkOtDyxn1egrpBpPnyDJvgmNUUOXNb3JlOJyRS009cM?=
 =?us-ascii?Q?yJ/mR92hv1L3WrmixAU7AMYMhg3T1MgpexpEWXG/TaS9SsIC/a6zDsa9VZE1?=
 =?us-ascii?Q?T/oPXRdxsPQSNgLczwJBBjMzC2gFLZc41PZQ2aZQKVuouSDvbYy4AHJnIHVd?=
 =?us-ascii?Q?LwuqQPZ53DnUtfrWxgBsayHFZ0KrMHcd1jnD64H2rgRXPQYX1kyx7zzaMlql?=
 =?us-ascii?Q?a/c6R0riPTj17z+NEqr20uuubfHs8QBMcTRqyLdkMKuRt8kd+2a6Pi05ikbd?=
 =?us-ascii?Q?x471ccdHOATRK8Pns72NEVEW6mENF8uau6qHbxiKJYt3kbbYCCvVmZO0UFE/?=
 =?us-ascii?Q?qRivLowDW2DJSr/0k1tr5i3kZNVeUPpqRdTbhlVHn1DTkVmJAZ6r2hyZ68cP?=
 =?us-ascii?Q?lDd6RFu8rmCxemX/FsUlhu2NbhKzL7m1xgigTizPMPdUzrF3kLVVNvtPupKL?=
 =?us-ascii?Q?1e0mmEJXXut1QFK40zl8bR6aHucVBUKZ2ahi1SDpS0KiCKhIRq3lVw0L8YSo?=
 =?us-ascii?Q?WJsXPpCUCjlLMQdpqyOxUUlTCjTCETR60csLyMH2pU0QmtaOX1HkRyDgyXtO?=
 =?us-ascii?Q?aM1RLMxbHRFk0U49Mzp9roBSynxdReRuA1Vpq2uAly+ben6Bu7oSX6FxGml1?=
 =?us-ascii?Q?8QA7DFb8M72bj45VPGYLJh0GZLf6st0YxBAjNsjpJyl89tIClGxbLhct/dmH?=
 =?us-ascii?Q?9MVs8L5gvTv1tAln5q9smKyTJItvu04DYXGxDfOt7q1fsEMUzBZc+bGlcHi5?=
 =?us-ascii?Q?NwRB6C7gkfCFJiI2qJetulyLprBXEjtwTVl6OLT4LaLhHQNndelvtFFPmZIP?=
 =?us-ascii?Q?ZLUtGxTMQOgnQx+m24beZUmADXXr6Z14xHB7BfM/bUKlKnwUHDU28cpfrWlv?=
 =?us-ascii?Q?cFzQ2KP5S87DXSlwzZooHiRGdJyvdSMbA7PT0pUvoNJNIVEiBYSO6qwEmaZC?=
 =?us-ascii?Q?vYdHzXQumuHinH7wkrQas10VwlUn0OzsNguC7qLY8TuYSFxWlfvamI3PC/qz?=
 =?us-ascii?Q?dcuhnnTlFnK6adhLtA1GVM19IFLyn3WYvIhFDoFN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a5363d-3e0b-48d0-9411-08dc519cb4c2
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2024 16:07:47.0825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +RbyVRM2cnU9TE6xqNhVcx0wDmN5n9b7LMfwGZmr4Czm9d13f0PiWyysqX6uDf/6FZZCCIqw/qpOFoZ5UkkKpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8476
X-OriginatorOrg: intel.com

On Fri, Mar 29, 2024 at 11:52:16AM -0700, Paul E. McKenney wrote:
> On Fri, Mar 29, 2024 at 11:08:05PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.03.27b
> > head:   786fab3085d764055a78edb54023420920344333
> > commit: 032d9f7e1213171131a3f45c5c532ea5d11b4b9a [66/69] riscv: Emulate one-byte and two-byte cmpxchg
> > config: riscv-defconfig (https://download.01.org/0day-ci/archive/20240329/202403292322.bwguovKc-lkp@intel.com/config)
> > compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 79ba323bdd0843275019e16b6e9b35133677c514)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240329/202403292322.bwguovKc-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202403292322.bwguovKc-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    In file included from arch/riscv/kernel/asm-offsets.c:10:
> >    In file included from include/linux/mm.h:7:
> >    In file included from include/linux/gfp.h:7:
> >    In file included from include/linux/mmzone.h:8:
> >    In file included from include/linux/spinlock.h:63:
> >    In file included from include/linux/lockdep.h:14:
> >    In file included from include/linux/smp.h:13:
> >    In file included from include/linux/cpumask.h:14:
> >    In file included from include/linux/atomic.h:80:
> > >> include/linux/atomic/atomic-arch-fallback.h:2026:9: error: call to undeclared function 'cmpxchg_emu_u8'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
> >     2026 |         return raw_cmpxchg(&v->counter, old, new);
> >          |                ^
> >    include/linux/atomic/atomic-arch-fallback.h:55:21: note: expanded from macro 'raw_cmpxchg'
> >       55 | #define raw_cmpxchg arch_cmpxchg
> >          |                     ^
> >    arch/riscv/include/asm/cmpxchg.h:367:23: note: expanded from macro 'arch_cmpxchg'
> >      367 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
> >          |                              ^
> >    arch/riscv/include/asm/cmpxchg.h:328:11: note: expanded from macro '__cmpxchg'
> >      328 |                 __ret = cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
> >          |                         ^
> 
> Again, good catch!  And again, does the diff at the end of this email
> fix things for you?

The error is fixed by the diff at the end of this mail.

Tested-by: Yujie Liu <yujie.liu@intel.com>

> 
> 							Thanx, Paul
> 
> >    In file included from arch/riscv/kernel/asm-offsets.c:10:
> >    In file included from include/linux/mm.h:7:
> >    In file included from include/linux/gfp.h:7:
> >    In file included from include/linux/mmzone.h:8:
> >    In file included from include/linux/spinlock.h:63:
> >    In file included from include/linux/lockdep.h:14:
> >    In file included from include/linux/smp.h:13:
> >    In file included from include/linux/cpumask.h:14:
> >    In file included from include/linux/atomic.h:80:
> > >> include/linux/atomic/atomic-arch-fallback.h:2026:9: error: call to undeclared function 'cmpxchg_emu_u16'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
> >    include/linux/atomic/atomic-arch-fallback.h:55:21: note: expanded from macro 'raw_cmpxchg'
> >       55 | #define raw_cmpxchg arch_cmpxchg
> >          |                     ^
> >    arch/riscv/include/asm/cmpxchg.h:367:23: note: expanded from macro 'arch_cmpxchg'
> >      367 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
> >          |                              ^
> >    arch/riscv/include/asm/cmpxchg.h:332:11: note: expanded from macro '__cmpxchg'
> >      332 |                 __ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
> >          |                         ^
> >    In file included from arch/riscv/kernel/asm-offsets.c:10:
> >    In file included from include/linux/mm.h:7:
> >    In file included from include/linux/gfp.h:7:
> >    In file included from include/linux/mmzone.h:8:
> >    In file included from include/linux/spinlock.h:63:
> >    In file included from include/linux/lockdep.h:14:
> >    In file included from include/linux/smp.h:13:
> >    In file included from include/linux/cpumask.h:14:
> >    In file included from include/linux/atomic.h:80:
> >    include/linux/atomic/atomic-arch-fallback.h:2055:9: error: call to undeclared function 'cmpxchg_emu_u8'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
> >     2055 |         return raw_cmpxchg_acquire(&v->counter, old, new);
> >          |                ^
> >    include/linux/atomic/atomic-arch-fallback.h:65:29: note: expanded from macro 'raw_cmpxchg_acquire'
> >       65 | #define raw_cmpxchg_acquire arch_cmpxchg_acquire
> >          |                             ^
> >    arch/riscv/include/asm/cmpxchg.h:263:23: note: expanded from macro 'arch_cmpxchg_acquire'
> >      263 |         (__typeof__(*(ptr))) __cmpxchg_acquire((ptr),                   \
> >          |                              ^
> >    arch/riscv/include/asm/cmpxchg.h:224:11: note: expanded from macro '__cmpxchg_acquire'
> >      224 |                 __ret = cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
> >          |                         ^
> >    In file included from arch/riscv/kernel/asm-offsets.c:10:
> >    In file included from include/linux/mm.h:7:
> >    In file included from include/linux/gfp.h:7:
> >    In file included from include/linux/mmzone.h:8:
> >    In file included from include/linux/spinlock.h:63:
> >    In file included from include/linux/lockdep.h:14:
> >    In file included from include/linux/smp.h:13:
> >    In file included from include/linux/cpumask.h:14:
> >    In file included from include/linux/atomic.h:80:
> >    include/linux/atomic/atomic-arch-fallback.h:2055:9: error: call to undeclared function 'cmpxchg_emu_u16'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
> >    include/linux/atomic/atomic-arch-fallback.h:65:29: note: expanded from macro 'raw_cmpxchg_acquire'
> >       65 | #define raw_cmpxchg_acquire arch_cmpxchg_acquire
> >          |                             ^
> >    arch/riscv/include/asm/cmpxchg.h:263:23: note: expanded from macro 'arch_cmpxchg_acquire'
> >      263 |         (__typeof__(*(ptr))) __cmpxchg_acquire((ptr),                   \
> >          |                              ^
> >    arch/riscv/include/asm/cmpxchg.h:228:11: note: expanded from macro '__cmpxchg_acquire'
> >      228 |                 __ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
> >          |                         ^
> >    In file included from arch/riscv/kernel/asm-offsets.c:10:
> >    In file included from include/linux/mm.h:7:
> >    In file included from include/linux/gfp.h:7:
> >    In file included from include/linux/mmzone.h:8:
> >    In file included from include/linux/spinlock.h:63:
> >    In file included from include/linux/lockdep.h:14:
> >    In file included from include/linux/smp.h:13:
> >    In file included from include/linux/cpumask.h:14:
> >    In file included from include/linux/atomic.h:80:
> >    include/linux/atomic/atomic-arch-fallback.h:2083:9: error: call to undeclared function 'cmpxchg_emu_u8'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
> >     2083 |         return raw_cmpxchg_release(&v->counter, old, new);
> >          |                ^
> >    include/linux/atomic/atomic-arch-fallback.h:77:29: note: expanded from macro 'raw_cmpxchg_release'
> >       77 | #define raw_cmpxchg_release arch_cmpxchg_release
> >          |                             ^
> >    arch/riscv/include/asm/cmpxchg.h:315:23: note: expanded from macro 'arch_cmpxchg_release'
> >      315 |         (__typeof__(*(ptr))) __cmpxchg_release((ptr),                   \
> >          |                              ^
> >    arch/riscv/include/asm/cmpxchg.h:276:11: note: expanded from macro '__cmpxchg_release'
> >      276 |                 __ret = cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
> >          |                         ^
> >    In file included from arch/riscv/kernel/asm-offsets.c:10:
> >    In file included from include/linux/mm.h:7:
> >    In file included from include/linux/gfp.h:7:
> >    In file included from include/linux/mmzone.h:8:
> >    In file included from include/linux/spinlock.h:63:
> >    In file included from include/linux/lockdep.h:14:
> >    In file included from include/linux/smp.h:13:
> >    In file included from include/linux/cpumask.h:14:
> >    In file included from include/linux/atomic.h:80:
> >    include/linux/atomic/atomic-arch-fallback.h:2083:9: error: call to undeclared function 'cmpxchg_emu_u16'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
> >    include/linux/atomic/atomic-arch-fallback.h:77:29: note: expanded from macro 'raw_cmpxchg_release'
> >       77 | #define raw_cmpxchg_release arch_cmpxchg_release
> >          |                             ^
> >    arch/riscv/include/asm/cmpxchg.h:315:23: note: expanded from macro 'arch_cmpxchg_release'
> >      315 |         (__typeof__(*(ptr))) __cmpxchg_release((ptr),                   \
> >          |                              ^
> >    arch/riscv/include/asm/cmpxchg.h:280:11: note: expanded from macro '__cmpxchg_release'
> >      280 |                 __ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
> >          |                         ^
> >    In file included from arch/riscv/kernel/asm-offsets.c:10:
> >    In file included from include/linux/mm.h:7:
> >    In file included from include/linux/gfp.h:7:
> >    In file included from include/linux/mmzone.h:8:
> >    In file included from include/linux/spinlock.h:63:
> >    In file included from include/linux/lockdep.h:14:
> >    In file included from include/linux/smp.h:13:
> >    In file included from include/linux/cpumask.h:14:
> >    In file included from include/linux/atomic.h:80:
> >    include/linux/atomic/atomic-arch-fallback.h:2108:9: error: call to undeclared function 'cmpxchg_emu_u8'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
> >     2108 |         return raw_cmpxchg_relaxed(&v->counter, old, new);
> > 
> > 
> > vim +/cmpxchg_emu_u8 +2026 include/linux/atomic/atomic-arch-fallback.h
> > 
> > 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  2000  
> > ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2001  /**
> > ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2002   * raw_atomic_cmpxchg() - atomic compare and exchange with full ordering
> > ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2003   * @v: pointer to atomic_t
> > ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2004   * @old: int value to compare with
> > ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2005   * @new: int value to assign
> > ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2006   *
> > ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2007   * If (@v == @old), atomically updates @v to @new with full ordering.
> > 6dfee110c6cc7a include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2024-02-09  2008   * Otherwise, @v is not modified and relaxed ordering is provided.
> > ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2009   *
> > ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2010   * Safe to use in noinstr code; prefer atomic_cmpxchg() elsewhere.
> > ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2011   *
> > ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2012   * Return: The original value of @v.
> > ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2013   */
> > 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  2014  static __always_inline int
> > 9257959a6e5b4f include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2015  raw_atomic_cmpxchg(atomic_t *v, int old, int new)
> > 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  2016  {
> > 1d78814d41701c include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2017  #if defined(arch_atomic_cmpxchg)
> > 1d78814d41701c include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2018  	return arch_atomic_cmpxchg(v, old, new);
> > 1d78814d41701c include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2019  #elif defined(arch_atomic_cmpxchg_relaxed)
> > 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  2020  	int ret;
> > 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  2021  	__atomic_pre_full_fence();
> > 9257959a6e5b4f include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2022  	ret = arch_atomic_cmpxchg_relaxed(v, old, new);
> > 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  2023  	__atomic_post_full_fence();
> > 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  2024  	return ret;
> > 9257959a6e5b4f include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2025  #else
> > 9257959a6e5b4f include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05 @2026  	return raw_cmpxchg(&v->counter, old, new);
> > d12157efc8e083 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2027  #endif
> > 1d78814d41701c include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2028  }
> > d12157efc8e083 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2029  
> > 
> > :::::: The code at line 2026 was first introduced by commit
> > :::::: 9257959a6e5b4fca6fc8e985790bff62c2046f20 locking/atomic: scripts: restructure fallback ifdeffery
> > 
> > :::::: TO: Mark Rutland <mark.rutland@arm.com>
> > :::::: CC: Peter Zijlstra <peterz@infradead.org>
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> 
> commit da6c6c7a30e5a5015a2995b2119053ca3d12b7a2
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Fri Mar 29 11:50:32 2024 -0700
> 
>     squash! riscv: Emulate one-byte and two-byte cmpxchg
>     
>     [ paulmck: Apply kernel test robot feedback. ]
>     
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> index b4cbea69ad2c8..a5b377481785c 100644
> --- a/arch/riscv/include/asm/cmpxchg.h
> +++ b/arch/riscv/include/asm/cmpxchg.h
> @@ -9,6 +9,7 @@
>  #include <linux/bug.h>
>  
>  #include <asm/fence.h>
> +#include <linux/cmpxchg-emu.h>
>  
>  #define __xchg_relaxed(ptr, new, size)					\
>  ({									\
> 
> 


Return-Path: <linux-kernel+bounces-89444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B85F586F074
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 14:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CD871F21E3D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 13:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E400C17548;
	Sat,  2 Mar 2024 13:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hiTmzgmr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791691C16
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 13:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709384448; cv=fail; b=HBAaz7R8vaG9+dYsczs1p3Z9MFeBppHNLtNNSDwUI0ojp5tK1ZQP6hgtMHNJPs2dDisgAXZM59qa3bQUkhwR1nR6XgnBKlCTd3LYKbwuGmFbYl/7P9vl0+IDCuDpuTQJNPPG1YpkRALVYxvl/I3kwLSjvTejNJAux1Lhi0FN/pI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709384448; c=relaxed/simple;
	bh=WGa8G2L63CxI7Stsfm1t4NZXQao6y8b7dWxMfyhxCgY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sbno9Ilym/tCeEgGhss16odzD7QM4kSyYcWINECtopKPujug/KgEdU15Fmv0GeqlBXxPkhCHdzoQCHv5GL8AKS8572+vu5A67g9SxU6qNjLGlReJjNhuUhPUviZbrUrpTVDcYUD4vL11sBVnlU9POBE4SZ/HXXPgDFkvq7jZpsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hiTmzgmr; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709384444; x=1740920444;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WGa8G2L63CxI7Stsfm1t4NZXQao6y8b7dWxMfyhxCgY=;
  b=hiTmzgmrJU8Vto65UTu8QtZCYg+bkwUw5AxHTvNdkQGci/d2ne/6KD3S
   F4Q0iVS9SIUhwwC/9Nx29N3eGrQjqwKcDfQ2WLcFPF/+K+T2BLspS68nr
   wBb8b/ceSUo5miDwyeU8+3MlP2WgoTaPyvMTuBc14tGdiYQyPfsrKI8qx
   uBQMConZdJeB+t5QIVGOxvlxmeFekwVJYYbOMCJaK78dPkOhWs62R9YQw
   I41n0Z/ic9uXv5etSZ8ItERRuC0214LIfxXpf24KDqxp0l5cZATczdi2/
   bKDtAqvBdtlIbKttjUZbo93xDzJy45w7ZAreK/lZ8pO/34wWZkLbhDaQj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="14571097"
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="14571097"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2024 05:00:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="8373717"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Mar 2024 05:00:42 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 2 Mar 2024 05:00:41 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 2 Mar 2024 05:00:41 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 2 Mar 2024 05:00:41 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 2 Mar 2024 05:00:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9SU0xd+a8C6Fbm9gMtgqxSJHV8j93GwXBe+HdRegxLM4e1ZWZgZXMIN3NTNY+8ai+txydAhBCI3J5qlkqffUkfrjFD+o4AYxvo9uy/ysYFbjS/45uE5UyGE/rNHDP8IXT7s8O6rXIrBmg2xFLxyk50FHZt+uBfbumjSqLmaxgqQgp1nkfezxX9ZzRy2dMYGrAQG12G/S8VjdRM1xXn7+nuaZ3lstq9ry7pUWx+YazTVgSpyNsHGd9FM8I0uYvg81PXIskdxnP4jwmVe80IANr9BAVeSlg1BQSqLao79T8FxxndIMV+jQ5Ao7RQcTLTaOdhAc8roa/gDRPDy1zcVcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmAWyFLdwC78ppcYMjCZVN/jQ37Gr3L0IkCm88GmUMw=;
 b=f4Y/VyD/ZCPaDIFreKCaqr+o0xm1vtBZDQ6H9CNqCODyiuKGMGzjgoFoi584NmL/6JtgfjgfjaS5lGtmKP7LExBV6m27edITFDxmo0CWEwbuy+VXUuNoubVA5Pu6RCXBB2I6iWRxvz0QJmUDUuJyU3UStnPtIMnYsYrvrdQFpbPK1KTqFKyK4kApMdfnVMINXl96ZF8a4cWyHBruFgi4v5IgimudSSm3muHLCy1AObWSOyEQpnJ15rSB27gtBOEZZ7VkSwH/X/bus1AtVenJ3dFOq46Xqv+OVuZagQFh12hu+/wxacUFjYIZ6GI1kefZM4RjqELLlY8dssl1RIPPUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by PH8PR11MB7967.namprd11.prod.outlook.com (2603:10b6:510:25e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.17; Sat, 2 Mar
 2024 13:00:39 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::7118:c3d4:7001:cf9d]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::7118:c3d4:7001:cf9d%5]) with mapi id 15.20.7362.015; Sat, 2 Mar 2024
 13:00:38 +0000
Date: Sat, 2 Mar 2024 20:53:48 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: kernel test robot <lkp@intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: arch/x86/include/asm/processor.h:698:16: sparse: sparse:
 incorrect type in initializer (different address spaces)
Message-ID: <ZeMhXCcawJiar389@yujie-X299>
References: <202403020457.RCJoQ3ts-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202403020457.RCJoQ3ts-lkp@intel.com>
X-ClientProxiedBy: SI2P153CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::10) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|PH8PR11MB7967:EE_
X-MS-Office365-Filtering-Correlation-Id: 793e1cda-eb37-4dd7-f769-08dc3ab8c240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ufxTyE++m7T5ZTh6aJv5c2i9n/mSMhjq8yM0W6217ty6JBQNPFne/dUtIHnUXBd1aGJB1TQZ4R2Nuw5HxUWg0MPsKnvuzcU3v2btxwf0a23fvtsJUGjfgEoFOaiWpqWFGkZWa3J9qTCsEM8Fngep71OTD6Pl3q3nz5HpCEuY5ZgmNhtVFoul6V8GfeY4TixK0kFnOFdwdVZc6pvtNOsYTBBxOiUqZdslGp/Vle/JUtOGOZHbcNe6ZSp0H6gXiXthER0CX8yJ0aeDJ8KUTrW6nxXR8mLXB+VdD+OZNF+YuxlS7ll+fX99vRliN0q2rwbNGaoEX74OrFMhdZLQasApxGadILXvJI7yfzvPuCJExFXAHMzbJEJUzyQthDo5W5NZalDlc3iRBkaKkQcXYw1xmleYoJi8t43VB0PBBKTThTxLonqDNAavY1V+0pqevyt3oefneSAdO6IHI65OJPzjcFeZxrXO8OIUXujgR5pGowTeu/v42lWiF7mFGMBO/Rl5hPa3CM5jBWHkblzhjYFi+sfjAd1JVu5RJ5wl+jpzUf/3MNVTHspuCN5ULoZnx0WlSR0k2bepNudPN5WZ0z6zflZHJyjx4NJKU5/1rubkK8VTv8qNwO5o0iK40+wiT4pj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WWK93jz3/0WXKGFZ4S6Xas5MZBx+re7IJkHlJFtXRWjxi7U5jP6Env3/gyGI?=
 =?us-ascii?Q?XyiVAThrtnPsLXgjLUM0wc5OGOmuHFRw5yiASWkhHZnfSI5qyi08JjdpTvRF?=
 =?us-ascii?Q?mtJPkjU4BkENEqwFIJbQBfM1bbq8LPZl/SUHg3hXtnAlpqIH7GlI+S+4ECzh?=
 =?us-ascii?Q?wGyCuk04og1RjlKo51SLhGTf7YDj0gckayG9Vj4MXL6vVyOfaICvoNZ2Lsd3?=
 =?us-ascii?Q?s1ihueMZ9y9eWMF6MGPodDmwPeFrWOOhgw1a43czobVpGe9CjIV/K2GDqlKO?=
 =?us-ascii?Q?QM1aEmhcEpz/sPFYgaOl7l8KZP5WL8/INGtwv6WjRdA5MfGaqVjGsPq6tEkj?=
 =?us-ascii?Q?X4X97WgmKcmmf0bsq4yyRT7JNbDDVZj0uW+zRoK+ciqdPvvtVpbFduaTQBWC?=
 =?us-ascii?Q?IoJJ25Iyc9rmKBfV/JjFIURjX4gRh8BuA0mY+t65sdADmHkp77HP4PtDIWcX?=
 =?us-ascii?Q?GaHhhNTuQvawta5iK2dhTU2dnRfCTB/vMVeKp2x4obCslhDdMyp4yYN04UK9?=
 =?us-ascii?Q?+F0kIv4c+2onkgoHtN1mMrf7rDIVgRzTL78iPYPbvwVRGW1T6nh98NZiErwn?=
 =?us-ascii?Q?msocsjdzwy5Jc/LBMO9mFFyvu1LKiY2zmHUq/U63+d0p4bHdKqsMGFo2AOC+?=
 =?us-ascii?Q?L2d6BPWdHisC2M3+k1R40xosXcgJ0KvoFS4Xq3bKxOdfnbDCZT0U9wJSFoq9?=
 =?us-ascii?Q?Yxg/5Bb6g8P/2BMnaGJmSqmIDQ0TO3u25lrU+7HLmfkDsZ1migFTxFgag+Xu?=
 =?us-ascii?Q?qotFjb+7bmGpRKSD9rELlptNtjZqRf1FyuScxRIkS7J5Rf1VKxXeaoIqdpaH?=
 =?us-ascii?Q?NPKtcRRzEIO4+B8BOvdxxGxJYVuryy2JTk4dY/XX4m+HcMsLBEl/Gjcfn8XF?=
 =?us-ascii?Q?Guv+xr0LgtELFrJAsHr6ucgLdhRUGMN3yDXSDCbeXzFEEICXrLrKTzOMW0Yk?=
 =?us-ascii?Q?kAI/9/dEUfovZ8+sRZ+tCoHdsKf1wIKY8UOWds3dp4weVFblo9ns2iNFQOEQ?=
 =?us-ascii?Q?7e3YLHqhxbCh/5xODWxUbSUj/sJ2Z5HhSCvupfGoh0E1zxwRldAbhKSh/VO3?=
 =?us-ascii?Q?+sMfEavK5TH6I4sF7pRXcg90m2FovlegErJQvirmKDJUBeOa/9CKgK8ZuWnB?=
 =?us-ascii?Q?0SAuMYrCgT/BB7iwizp3FztS9uIVXGAM4W6iJLQVSSdGY2S7m+jpPJJl5sFC?=
 =?us-ascii?Q?kfx4LkIE3cB5NtAe9MES3W1iF5Wnf2xSpTzrstBGEDsEcFMGwK8/iZdpokEj?=
 =?us-ascii?Q?a3fJFJmFmFSfa40vo403Budj/1chF66GA/xTQDzZ/Y78Ifu122mF1Cp4Rnbu?=
 =?us-ascii?Q?Xfw8zSalyqdV8cTYm2sM1adAYhoyrAZqZroOP4YEZlFBcYpfwSYbFguNc5qe?=
 =?us-ascii?Q?QLiBjsifJUkEIuH0oZXJZJk/yVtTsXQgGzjAwATdpObRN/fo3VPZMr9fTcYN?=
 =?us-ascii?Q?tqqAs3KyBzgYcOCvpMI0vhnxlArpxBOsq/XwzuxcHdx4MiIJAl5T7/UyBBby?=
 =?us-ascii?Q?vwANVmHlDajQwQ+ZDlZ46kylZb49GGKWqRXh9rhDivWG/rJqdQNebOL/+uTP?=
 =?us-ascii?Q?2m7+GCkJroTcHNKjgkCvxmqe3mQFzEMRU8/aCmDv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 793e1cda-eb37-4dd7-f769-08dc3ab8c240
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2024 13:00:38.8615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qnRnPRhfGscJeVLWz5ag74wAWh2QTqyR3gTsDxLTnCrwJsPEO14X9X+mF1NA70ObfcuhYg+2CdTFSjemiItVuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7967
X-OriginatorOrg: intel.com

On Sat, Mar 02, 2024 at 04:12:16AM +0800, kernel test robot wrote:
> Hi Thomas,
> 
> FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   87adedeba51a822533649b143232418b9e26d08b
> commit: 6e29032340b60f7aa7475c8234b17273e4424007 x86/cpu: Move cpu_l[l2]c_id into topology info
> date:   5 months ago
> config: i386-randconfig-062-20240301 (https://download.01.org/0day-ci/archive/20240302/202403020457.RCJoQ3ts-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240302/202403020457.RCJoQ3ts-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202403020457.RCJoQ3ts-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)

Sorry for the empty warning here. The actual sparse warning is:

arch/x86/include/asm/processor.h:698:16: sparse: sparse: incorrect type in initializer (different address spaces)
arch/x86/include/asm/processor.h:698:16: sparse:     expected void const [noderef] __percpu *__vpp_verify
arch/x86/include/asm/processor.h:698:16: sparse:     got unsigned int *

> 
> 
> vim +698 arch/x86/include/asm/processor.h
> 
>    695	
>    696	static inline u16 per_cpu_llc_id(unsigned int cpu)
>    697	{
>  > 698		return per_cpu(cpu_info.topo.llc_id, cpu);
>    699	}
>    700	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 


Return-Path: <linux-kernel+bounces-122443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7BD88F791
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93D5FB20BDA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 05:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44A14CE0F;
	Thu, 28 Mar 2024 05:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DZzHO1qd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C674D2E622
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 05:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711605444; cv=fail; b=qFSlP+67xUAAaSNcQn6LVqW2QgtGKhUwI2PTQUO903WGx5ikugbOdZi2vNC3d1FXTCE2512lZvdHhR5/6pWq9uuUMFcmHdXteSVtKNrMy+PPKOojJqbDOooJxYfj3Q5ZdfaYTvlMWY1eclKK1Cy0JhORpyiBsVeMMakiHe6NQN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711605444; c=relaxed/simple;
	bh=QKAxJIvgzy3iFY5B56quEpax8KcbLNGtzNmeAGV4jl8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aMrmK0RLI8OSZH35gzEB+sKC2KdE1suXHQf8bUHS3LbxjQxPRGURzYYWADKqHEhm3wEJNz/LhtvTKeKGc5Ym2KyoRDDVNXHns5KrSAz2Cf/cD4v52Np2xRreUEd6iwPNblAGhAjxM53vqV6X8pfseDsFxrVQubgbkzQkb/9jguU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DZzHO1qd; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711605442; x=1743141442;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QKAxJIvgzy3iFY5B56quEpax8KcbLNGtzNmeAGV4jl8=;
  b=DZzHO1qdsXuCVAEv1vsX2rmIRYXLuvgW+rsTot4lNWmWiFccS/SYJnVU
   g/UNVlyRb0nTOo69Pu0vlSP7Wa3skDyRs3ApfHCkBdiioH+Q6HZB2LWP2
   Pr7kV6zhKFMqi0OYP0wZBy2HakQktT4qMdNE9pegn+vbjKabPuNd0sznz
   gHAQlP98awaql2WZn0DFuMPn9UDdB9RpJ/xWMPKZ+AHiVcpgqWTmgrBHo
   BgTiDHiin0hgalHSHDkxT6ie9uevibSLSvtDnbeOlQo5/EkjYeB3zOiiR
   4d/ARtODexUskL4aXdeZ/a1cGmeKdY4W1fPBAkgxS1mw5m0nTRdXHTTLI
   A==;
X-CSE-ConnectionGUID: +k2EDVf7S/KYDqO4i0GMYw==
X-CSE-MsgGUID: UFBCnw0xSEeWgEdDQUK4FQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="10533678"
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="10533678"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 22:57:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="47737175"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Mar 2024 22:57:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 22:57:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 22:57:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Mar 2024 22:57:20 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Mar 2024 22:57:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O95aFb4YWMNeuH59ZfrcYoxo5SGuqn2sqIvvAl5iX/pOBW01SubM9oGzNjgNIqSiIGHgP+Lg1pVPcLeOaMBAY2YQKsNPtG0pqmE56ka79h0T6c1LcNKF2OoXI12/jjNUXEUJH3ARB5CBwJeDioClBkxHPOoCxdCFwjCganX0d+TF/GSlyoBhrQB0TQC3X7ryJ4R1V2gOMlYSIO5kdGNxtpJCFJKZzo20xN/KtygGLlhT3TamrJIbhtMosB0ILd42Z9O43e3kftskFZaB9BTGv5zbWsYIx2g3kXG4f9OO+Px2SqXczC/dxT0wn5Wosr9NLJXmIpI8+NnIgUKujd6nyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WiEuiD0uqXmFbbm0ONGx2+RlcechISY58XaN5BUwW/0=;
 b=TusICuTUd3NtmSLPprrNRalpfByqRWZ0DW+LNq+SghY4igx1L67nyCYaD6LtoA46AeMTwOzfU6AquwBpx/lQWeZkFW2JEOfOlL/SJ+VAD8P0D8VFTmTk1Wk9yVq098YeNQsnBrcUXB2P+da7ia/z0IPp9Dsg2MsPlNpx2B+BnCDk6IIBwnhN1MSxc2rS9wXr88lsFEczTw6RjrLcQjzK2fhzm+JyGHggNq1ljNMB/IE02wKw3U+xreMqIQlXb6GSF1tT+dtoi+I2p9JbRCY+kwqTQyUsJh9a5m4ZAW9D3OcyJL85NwZT/0I/N4f9gvCpD73z+PjqN0YvHeuCh0ZQ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW3PR11MB4604.namprd11.prod.outlook.com (2603:10b6:303:2f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 05:57:18 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 05:57:18 +0000
Date: Thu, 28 Mar 2024 13:57:09 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
CC: Borislav Petkov <bp@alien8.de>, <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-kernel@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>,
	<oliver.sang@intel.com>
Subject: Re: [linus:master] [x86/sme] 48204aba80:
 BUG:kernel_failed_in_early-boot_stage,last_printk:Booting_the_kernel(entry_offset:#)
Message-ID: <ZgUGtcJ1ZtQMhSHg@xsang-OptiPlex-9020>
References: <202403221630.2692c998-oliver.sang@intel.com>
 <20240324142532.GAZgA33M_u1lW_E_1n@fat_crate.local>
 <CAMj1kXE97o_T61AJ6wRAOpUvzon-45fnsT2dGB0GBP1x7bfGaw@mail.gmail.com>
 <ZgKH0LbdN0aDyvRe@xsang-OptiPlex-9020>
 <CAMj1kXG2D8cwtXTqjepm30B9X9KQD_q2XMDAA522mv9z-5_-ug@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMj1kXG2D8cwtXTqjepm30B9X9KQD_q2XMDAA522mv9z-5_-ug@mail.gmail.com>
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW3PR11MB4604:EE_
X-MS-Office365-Filtering-Correlation-Id: e694c24b-93b0-42e0-d70b-08dc4eebeca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2HJSRRkQPePbLZ9oa7u+e2wmHKs/lkuvmZ+zbCOIyvbQ/reqK0S+Xw8ZSHBzJv2PglVu+4EyfVke82xA2BZw/4SlTua2D5bc7wJxMKq244wPkJ/gxetUVqtkKFCF+L8+5UDRpLazleV4VsR9OaGsHtzwLlx7TMBaD5H4DXgo2qHS/zWxPY2WjpEtHCQBGRIgmI/R6Xx6oHwiajPmoQ3+IjbSKXeg4Yh/QvQpapVTyhDY9TOnvn3fh/1jIBl/+uuwaiUQuzd60sZrq/OwnVurWvhEjFHzFnuphmLhyWxlzuKgaUciGSHpW3NuDLyMWMhML7uTI7sRdFrMbimF1yL7iJ1Ua6Y8wctMxc1Nyhe24GximKYqGmikjdrtp6rouxX5uEPuSinvcZfZsWJiuKIsnHmiwmRNLrGt3Em9aOM60EfZIsM5Jwnrg2g3LCl74ndrpr94SsYZFPQbRvSZg21hMQN1mjRk3PT+1n1SF29ogFYsvAk/Hvd1njCbUZCsgPBPAh2sx7Sn2b1KzayRK1xGmOhBbY/x46Bht8V7Q1+loq80XAeCLqOQChoXbQy02mBEaN+EQEmJqf1mW22WqrfVcm8OOh/hB6O5Ay/r0gOaTRwI0IeG8DGuma1PNqNIrLCf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mSGilpACv1teV4xpqsj6eUckxoHiM+ZNquoJfGw6AyYHuix/ACX1QKEIUI5o?=
 =?us-ascii?Q?UCDFykhoVMmaZ13IbMDuX2izrNjRx5mAMY1/YXHiKBQYs/rjnBFENjU8y5FI?=
 =?us-ascii?Q?4QkxG1qXpxA3Smak98z4UttIHV9CywVM1pttqt8WKrov+9gn7zP+vGSlEWix?=
 =?us-ascii?Q?DAWBA0NPG+xFNO1ebc4BzsAP+nkG5MKmCAxlm2tgwFw6L8Xp+DyZKhXfNCoG?=
 =?us-ascii?Q?ABNZivbeaKKS1FzZeeiAKvNdXgvcmomSvYbSJ5NCHi2hwJGUJvfXfyEysacF?=
 =?us-ascii?Q?xf+V8gro7YDwdNZQHz1LcPNygdzmactDjoP2DoBt1U0xBHxOru1OzR63jlZQ?=
 =?us-ascii?Q?a/X3Hi1HWEHTx5G3+4ouzeeVYUWBxRS9EgtVowaDfdBE4jBk6aAJlXiObq8K?=
 =?us-ascii?Q?6tUM1Smlz/rg4pvWnHRCIYHjpmV8OkaaxU2m9kVQoCE90BarFzqFpyKYtuX4?=
 =?us-ascii?Q?gPu15skgdTglHyOM5bp7CitN9NAf0IsCcdcmtJxyQtRcVVqAbbF9prMW6BN+?=
 =?us-ascii?Q?qWc2lTQURuhc0C2d1X6iDFCtI/ZEBvjIO09Yv/GFu3/YxWa4tmoWTNPTEUq0?=
 =?us-ascii?Q?evn5jIg3WKl2HBPSbjE0N3cz9Jp7kIZhZOaPR1rXSc3p1OUi2+JcBHZMUOKv?=
 =?us-ascii?Q?qjuCdQKK6oylkSSuzFCiTDYNaer97ncnC79kC4/vOWE4mueZ0e1alR5jj+rQ?=
 =?us-ascii?Q?pMkHNP8dtPa5T9OUDxQizx6VG0vwnCcOOcDlQakuRh81pJNIL4t6AV7bkL/m?=
 =?us-ascii?Q?4eX8VvPmHmC12trSMRCLhLcIQQtTMzV/0vrh1KdAmJBP3+2a+1LMuPUrPh1o?=
 =?us-ascii?Q?Lm4m3Otrds+BDa6Fg1rqgjULNOnVt5I4w76NTSKF/9KJAtl3pdv3c8ykCvYa?=
 =?us-ascii?Q?Mq1XLDrldQ025+7TCtgR1Nne6QvMfXC5cIpMMbvLpD0nDqU6mzNmwVyze5Qr?=
 =?us-ascii?Q?iFK1IxAMxcAs8R1VtjOb559IvG022jzHHrqwzjsADmkW3bf2zpjSBtWr4Ouk?=
 =?us-ascii?Q?wiAGaYdGHJbmpUcQRKSEW3XMHkH84RSV8K/bgAqjDNwGl2o0wqk/RQrGTmrR?=
 =?us-ascii?Q?LIiNSL+y1s8IWFKFspZTaWd6hH6A5uIxIhdczN3H68pzuws8b6Bv0pmbvtTC?=
 =?us-ascii?Q?irUTnGlgrR74CqcvI5C8ghCAzXWEtBGD+s30oBqYlO6m2k5RZL4f3Q5Rt1gV?=
 =?us-ascii?Q?r/Zugqil7oYfr9GG7Aq8OIQzeUdbkpatdMurpN5JKdso4xKqcsyebAfaR0pC?=
 =?us-ascii?Q?3HS8K4jrMWvc0CRx9fa2rgWCmgg9dnyoDM0Fp1jBFZ2MZrq1ilMMYs7xU7x8?=
 =?us-ascii?Q?VYDi0CgglryNXJSZfIcYgH9a0hGF5N8qH79TqRuHi2u0SBxWnZjXadp+rpkO?=
 =?us-ascii?Q?pVkntQyasqoOPDkSfk43K2oADlyIC9Dndfbvmfj0jflXFmPk5cHxNhuAiUf+?=
 =?us-ascii?Q?CUoWJWqs8XdYYQT0XC/EZv6xH8DfdxIHkweu5BTY+pY/andWWh11NpLN8iCd?=
 =?us-ascii?Q?hTKc2xglHWnl38hqYrFB0p39JYSO9YaizStb3qlt8ziuu++4hQieL7DSgSXn?=
 =?us-ascii?Q?aYTO/lT1bmJxMxcw/X7u/N3wQYm69C8mXZBGHf6nQrVkCeVuiLAwJssKQBT3?=
 =?us-ascii?Q?dg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e694c24b-93b0-42e0-d70b-08dc4eebeca3
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 05:57:18.1705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pnt3Ooixaa4rphgOGnJXcXddY+0vW7ZqUZbynPuJERtIBPooGB0V2ZuPpjHlyLWZb4ayFdNC7jhTB81Qe6T9Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4604
X-OriginatorOrg: intel.com

hi, Ard Biesheuvel,

On Tue, Mar 26, 2024 at 10:59:04AM +0200, Ard Biesheuvel wrote:
> On Tue, 26 Mar 2024 at 10:31, Oliver Sang <oliver.sang@intel.com> wrote:
> >
> > hi, Ard Biesheuvel,
> >
> > On Mon, Mar 25, 2024 at 04:39:26PM +0200, Ard Biesheuvel wrote:
> > > On Sun, 24 Mar 2024 at 16:26, Borislav Petkov <bp@alien8.de> wrote:
> > > >
> > > > On Fri, Mar 22, 2024 at 05:03:18PM +0800, kernel test robot wrote:
> > > > >
> > > > >
> > > > > Hello,
> > > > >
> > > > > kernel test robot noticed "BUG:kernel_failed_in_early-boot_stage,last_printk:Booting_the_kernel(entry_offset:#)" on:
> > > > >
> > > > > commit: 48204aba801f1b512b3abed10b8e1a63e03f3dd1 ("x86/sme: Move early SME kernel encryption handling into .head.text")
> > > > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > > >
> > > > > [test failed on linus/master 741e9d668aa50c91e4f681511ce0e408d55dd7ce]
> > > > > [test failed on linux-next/master a1e7655b77e3391b58ac28256789ea45b1685abb]
> > > > >
> > > > > in testcase: boot
> > > > >
> > > > > compiler: gcc-12
> > > > > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > > >
> > > > My guest boots with your .config and SNB as CPU model:
> > > >
> > > > ...
> > > > [    0.373770][    T1] smpboot: CPU0: Intel Xeon E312xx (Sandy Bridge) (family: 0x6, model: 0x2a, stepping: 0x1)
> > > >
> > > > Artefacts like:
> > > >
> > > > -initrd initrd-vm-meta-180.cgz
> > > >
> > > > or
> > > >
> > > > RESULT_ROOT=/result/boot/1/vm-snb/quantal-x86_64-core-20190426.cgz/x86_64-rhel-8.3-bpf/gcc-12/48204aba801f1b512b3abed10b8e1a63e03f3dd1/3
> > > >
> > > > I don't have and don't know how to generate here so I can't run your
> > > > exact reproducer.
> > > >
> > >
> > > I ran the reproducer using the instructions, and things seem to work fine.
> > >
> > > https://paste.debian.net/1311951/
> > >
> > > Could you provide any information regarding the QEMU version and its
> > > BIOS implementation?
> >
> > for QEMU version:
> >
> > $ qemu-system-x86_64 --version
> > QEMU emulator version 7.2.9 (Debian 1:7.2+dfsg-7+deb12u5)
> > Copyright (c) 2003-2022 Fabrice Bellard and the QEMU Project developers
> >
> 
> I tested the exact same version.
> 
> Does it reproduce with -cpu host instead of -cpu SandyBridge? When
> running under KVM, I suspect emulating the actual host uarch rather
> than setting a different one is a more reliable strategy. What CPU
> type does the host have?


we have a machine pool which has machines with different cpu models, we deploy
vm on them to run various boot/fuzzy/func tests. to avoid subtle issues, we
couldn't use '-cpu host' directly.


> 
> >
> > for BIOS:
> >
> > We don't specify bios option for qemu, my understanding is we just run with
> > default bios for qemu (the seabios). Extra info of seabios
> >
> 
> Today, legacy BIOS boot is only used by a minority of x86 systems in
> the field, so for better coverage, it would make sense to at least
> start testing UEFI as well.
> 
> On debian, just install the ovmf package, and pass -bios
> /usr/share/ovmf/OVMF.fd on the QEMU command line.
> 
> And given that you are doing virt based boot testing, another very
> important use case is TDX boot (as well as SEV-SNP, but that may be
> more difficult for you to organize). But please explore internally at
> Intel whether TDX can be added to your test matrix as well.

thanks a lot for great suggestions! we will investigate these.


regarding this early-boot failure issue, by more tests, we double it may
relate with 3 configs. as we shared in [1], they are set as below when the
kernel run into early-boot failure:

# CONFIG_INIT_STACK_NONE is not set
CONFIG_INIT_STACK_ALL_ZERO=y
CONFIG_GCC_PLUGIN_STACKLEAK=y


the early-boot failure issue will _disappear_ by making either one of two
changes:

(1)
 CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
-# CONFIG_INIT_STACK_NONE is not set
+CONFIG_INIT_STACK_NONE=y
 # CONFIG_INIT_STACK_ALL_PATTERN is not set
-CONFIG_INIT_STACK_ALL_ZERO=y
+# CONFIG_INIT_STACK_ALL_ZERO is not set
 CONFIG_GCC_PLUGIN_STACKLEAK=y


(2)
 CONFIG_INIT_STACK_ALL_ZERO=y
-CONFIG_GCC_PLUGIN_STACKLEAK=y
-# CONFIG_GCC_PLUGIN_STACKLEAK_VERBOSE is not set
-CONFIG_STACKLEAK_TRACK_MIN_SIZE=100
-# CONFIG_STACKLEAK_METRICS is not set
-# CONFIG_STACKLEAK_RUNTIME_DISABLE is not set
+# CONFIG_GCC_PLUGIN_STACKLEAK is not set
 CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y


[1]
https://download.01.org/0day-ci/archive/20240322/202403221630.2692c998-oliver.sang@intel.com/config-6.8.0-rc6-00057-g48204aba801f


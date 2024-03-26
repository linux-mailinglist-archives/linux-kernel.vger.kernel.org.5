Return-Path: <linux-kernel+bounces-118547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B4F88BC7A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25D021F3B200
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4711E1C36;
	Tue, 26 Mar 2024 08:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VA2Z0UQ3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431A6184D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 08:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711441898; cv=fail; b=TcJMEDL5BRJrYt4fmqs6xwFFbcnTCPFxJ+iokCXnmZFZSVlWkPJ+H0q4C95hPOt5s2q1z15CT4M/LAlgnTMHYTveEbk93WPQaCVQN/yq9bovquVNBuNmCe91KgGeSBNXwJ/qD1t8rw2E4wO3E6GZbROxpAWbuzbdIhaqcm0z4Vk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711441898; c=relaxed/simple;
	bh=s8387OUOayUETxja4ZeANnsWVXyvjmUCUmBQ1YEgJeY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d0CnviVRAGZtXg2mLopNTI+DF0Kx64NqloJnOnVJLZ3FxeqnKsr38CtWxyCVBn16mvulfRf8gR43DeQoVuKQAo4jrg2rzaEfH9+zAKq9FLPP4XaxUdSEoGTcPN2fMWbN162eorqsxIoKNppKhmCMGeCsbIbg1AjXhr9goi7d44s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VA2Z0UQ3; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711441896; x=1742977896;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=s8387OUOayUETxja4ZeANnsWVXyvjmUCUmBQ1YEgJeY=;
  b=VA2Z0UQ3QsYSvNz+FWkKn0uO1Zf6gbNWWIv2B/hx8RhDzatXh3aV6Ufs
   BxHMIAK9nNBrTfSDLhAfS+h8BBfJpkqPAgFQJDtexW2Xpz7rsh9mAdnnf
   GlXUYtB4Qlfk/uxk0GaPuNEuHgMm1HMuX7uspH5NpdMC8J0gdjWJG2jLw
   Jss023MMN6nHEfODqwf4fX1yxw44NC9Y6d1KiJJEpe8byL3xWV8x4fP3S
   MO/yz3x5gR+fDhKLQ+q7O4EYCc91ABj/DP1nB7ol26w2ilHmv8rpVqBM1
   iCQsFcmuNiWCuFagLuLNAhMFMIQPfIjj/ubvGYKn8oYVxhSfN0rpSo++F
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="10273375"
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="10273375"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 01:31:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="15953619"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Mar 2024 01:31:23 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 01:31:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 01:31:22 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 26 Mar 2024 01:31:22 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Mar 2024 01:31:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aoPQR+H3s4JkBIhBHVUfdSCdXlGU+T4IidsCabOA5VEqvqxtkn7rWapHaFsXXu5FSA2CLyNacHARcNYFZ/3DjLHxGaJdttemmVwrMog8P87xbUHdpc6lNrvFjtkJvP9KANITTjcj4eBs4U5qHiWR+kCnjme8Dq7148SgquXTbkW71dlDymfp827oKvhf1XNl1OrcsBDeGfKItCH/6HsGmogPPnkQanKOMDuUCA1QwCxjELh+OoE83nvxEep/4mDcEm5ZOWCh+c4dQaDczO/f0jOzyTa+hzhx9ApxIpT3WD+J0d4obADjHMssy30x2qarSt7IuCqpP/FtMrMy/pJHBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ooIfT8z4y4aMPUUf1keFoi04hVNSDFQBMKI49kCm1M=;
 b=iRnE/u3do36rARPrMTmhTICI6gb+SP7ysGW+IMWuwgoPErZSe0nGpLL8dzblGClha1F/u+HKG0zr2IoImXuIPZivMU/CsQhrbxBofLQJsqXnrjBjneNje72wo0yFrShTw4M8R4y9rkbh7TK8WHpWozWBBF8g4wTj7Y2wMHVZv4uLVHgEl39RhvQutvBihoZMgNQQJawvJNBeekChP1jt9hWBNJr5ubKnGzDOfRLTAx45tKGItKqxCgumfYrZX9qS4Roj1J6wAXtEP1KOSUbup0iVEgErbAnEFVTf+xQe/TMqiO3X4yE2rcOTVmqZL6Kg7C/o/KAPBLK+Fh3d6jN2Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB7447.namprd11.prod.outlook.com (2603:10b6:510:28b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Tue, 26 Mar
 2024 08:31:20 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 08:31:20 +0000
Date: Tue, 26 Mar 2024 16:31:12 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
CC: Borislav Petkov <bp@alien8.de>, <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-kernel@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>,
	<oliver.sang@intel.com>
Subject: Re: [linus:master] [x86/sme] 48204aba80:
 BUG:kernel_failed_in_early-boot_stage,last_printk:Booting_the_kernel(entry_offset:#)
Message-ID: <ZgKH0LbdN0aDyvRe@xsang-OptiPlex-9020>
References: <202403221630.2692c998-oliver.sang@intel.com>
 <20240324142532.GAZgA33M_u1lW_E_1n@fat_crate.local>
 <CAMj1kXE97o_T61AJ6wRAOpUvzon-45fnsT2dGB0GBP1x7bfGaw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMj1kXE97o_T61AJ6wRAOpUvzon-45fnsT2dGB0GBP1x7bfGaw@mail.gmail.com>
X-ClientProxiedBy: SI2PR04CA0005.apcprd04.prod.outlook.com
 (2603:1096:4:197::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB7447:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ju55KxJ42uX6m4KXZKDpRe53xBMupDBD3+JdfCxQgQpuAp2WnGyJre6ruWLZ4LpwqIBiNeskd1+4HiUYxJ5AQKB05611D0Xmn4qS46rgsIUaEdsv36r/9HGyf7Km0tWzenz8GPBggu86jQ40EJLVLOju0HkUaiEUk25yCB7nHhTNw7lpYoFeQ+B1m1BKWcvpHPEwufLE8q8ec3RV2PUXmL9aGPnonNcJYXgIlmYP02TiDcVm82+tpLIw6K6FjXPYKeWv73QCmzuMKycQRd15GmhhqPMYZNlFahm0XjzDYTpnVnTQffAHvDxTOCE8f+R3YcCQqCVgMlPbpiYsLPKnHlj1UtCAaCu4D8N1pzwN3n9RPAfdnRK0LqKF3UKc17Xw5mWfzJcX4+4TCQIPm1PTGWj+P3XY6c0gxyg1e3CzvD2h95aD63BXsGqFYP39i53uIh+jJtejqvoYY130IDOeB8X0VV0AZdTHphXGuFaSfzbR3G/BiXtL0Nrd/ywYIngd9Zl36lJwS0IDPCd1mwKxinuDbra6vMt2IKyV8CMQstf7UlXLe7HjI5ygbVcpYuvgJcw6r0bIt0rKu98BG442aRZlGGGkAv7cQMVP/Uj09c4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?75lekt+bTPJuijNmYuEzBn0133hS0stZsVPeKHNaYqMFPkgQDcZ7Hx2NpBC2?=
 =?us-ascii?Q?NBK76xuRKitEqSPspOTkEsB/Tjanye2EhxsjbYpTPE5RM9buD9K4QT0WlylH?=
 =?us-ascii?Q?hS/iQle0R/7hX8v4ERLquM2V10Vf2fdBRMbrs8YGmQIoz2lCo4KX9jMGvMXE?=
 =?us-ascii?Q?qydY5BUiaxxrZR+8EfXB0+MlUmwAK/ifZhv6OeV8Ua3LPVQYgJApkWY4bvNI?=
 =?us-ascii?Q?ePwijot4RWm4+PpU3CgNLshxrwBCKmlADvr/ztiuZpEBwQl8ipqLSjJbGdOv?=
 =?us-ascii?Q?VOenRd7oAMkz5i432tEUHRQM/Bj+WWVw/kbuMHQPTwB5o02BZDgmWPiWJ0RR?=
 =?us-ascii?Q?NmJHim5Ko9s4SM169YczlkIh540jlL9NH5W7ttE9fopK0tF48KqsXq2ojLYY?=
 =?us-ascii?Q?fXC8xiyD70z8xn9mVdmhcqkAv2+lw23N9Gtn5A8VOSkJ2cnFYGOmK/Gv+EmW?=
 =?us-ascii?Q?bLPggz9v8t9V9KlFLPYcKNi3mM1ImMoYZJyke0mOJakEkFEbYtBvnmEclo7X?=
 =?us-ascii?Q?FRZ9AzE3JokfBl//6YeuqGLsCdjWp02YWEFyt45LleBh1locbh3466k5SmVF?=
 =?us-ascii?Q?Yxwr83gLvVd3FN2SjeVtr6d659PTMYTK7QMKkZwnsmrTwYrIfy7j9q2RLF4h?=
 =?us-ascii?Q?CkQPQKI0unZ8zy34jr7FbOC8eE5W0yGr4T4VbH733ZK4V+/n0ZseCQm06WIk?=
 =?us-ascii?Q?2VymITehIO28RU/UgtVolOL76cHqWNbFFhQQK2AIbJEBTpUmrW6SQzbV8fvW?=
 =?us-ascii?Q?s+G6P+NYbTltf49CYSHMBAbffwlyuNm+T1KIbajs3xAoxbILbNYw1FL8H9pC?=
 =?us-ascii?Q?zzzOB2YnvU60ZO/wq6ThU5IqHzxz0syxJ5bxrPemYYLPtTAaudCCuB56UrL4?=
 =?us-ascii?Q?CCb9BkftRRxfjWy1fvja4wxyza5o6npoSSSr+0dh9FLzN6a5UmQjX4dqoZrC?=
 =?us-ascii?Q?lh0EVzfKbikj5351TIXXSwL9ftxfCpMR9h/jDJgSPUkMSKeMU0VF51yvQS1Q?=
 =?us-ascii?Q?38tPJO5klnAqvECHEX8bKWJPtvOb92eMpohZOfH/f9zTXNPfnCAkTQyLmNCm?=
 =?us-ascii?Q?bwv+fMb/OtBLfQhScy+Jxx925ZuRhIabuO+CD/ncwDQ3IYSmswPokZhk/RGh?=
 =?us-ascii?Q?aZ+VKL9KkDOnzqT8R1SekpHjkW134OrAkvHryQZt7oXmTT6hyVsG7gZpJflc?=
 =?us-ascii?Q?iE2Rx1HUpYXvCgssOWkvUg/tvuNQShg78/eylaEgsqqGHzowdfsyqPFfeaxz?=
 =?us-ascii?Q?PeGeHWzYTxHEVGH8N7gV2MhMYGf93RqxT1FevSx66MV1QozJ3rAAromZdU61?=
 =?us-ascii?Q?1DliY5Oa2d2DLbK5uyhmrLiq5iyRhswWVCeDTgqrbEtRsB0Q5LTp1gQ3Jf6j?=
 =?us-ascii?Q?Ct0N8WTyCq4W0JlPxBQy0Rjv/fvWd5VX7wgaT1NGjVBK7ZYmEFimKBB50bpO?=
 =?us-ascii?Q?p+hJ5KAZar5fe7VQSoKjei92kJJ71rPxSjAeqW/Q0R+JPz1vzEZ/53TA5TL6?=
 =?us-ascii?Q?iE6AjMyoyN+EuC4OxCLYngmr4ETZVAPgAO1LZ+/028aEHGht0P5tW+fcdEaT?=
 =?us-ascii?Q?Drnk3i+zxj0A/sPOC8VSDd8eyehwp333z97+yxbJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d14f4e-c576-4ea2-94b4-08dc4d6f1cc5
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 08:31:19.9914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +eO4sQK4LhkLWOnrI590NTCSmAfd8Uk1Wnbi7wZfhWX0IxYw7gKj6tlPv7lYsnBlwjXzlutZ6k83De12G0t2Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7447
X-OriginatorOrg: intel.com

hi, Ard Biesheuvel,

On Mon, Mar 25, 2024 at 04:39:26PM +0200, Ard Biesheuvel wrote:
> On Sun, 24 Mar 2024 at 16:26, Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Fri, Mar 22, 2024 at 05:03:18PM +0800, kernel test robot wrote:
> > >
> > >
> > > Hello,
> > >
> > > kernel test robot noticed "BUG:kernel_failed_in_early-boot_stage,last_printk:Booting_the_kernel(entry_offset:#)" on:
> > >
> > > commit: 48204aba801f1b512b3abed10b8e1a63e03f3dd1 ("x86/sme: Move early SME kernel encryption handling into .head.text")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > >
> > > [test failed on linus/master 741e9d668aa50c91e4f681511ce0e408d55dd7ce]
> > > [test failed on linux-next/master a1e7655b77e3391b58ac28256789ea45b1685abb]
> > >
> > > in testcase: boot
> > >
> > > compiler: gcc-12
> > > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> >
> > My guest boots with your .config and SNB as CPU model:
> >
> > ...
> > [    0.373770][    T1] smpboot: CPU0: Intel Xeon E312xx (Sandy Bridge) (family: 0x6, model: 0x2a, stepping: 0x1)
> >
> > Artefacts like:
> >
> > -initrd initrd-vm-meta-180.cgz
> >
> > or
> >
> > RESULT_ROOT=/result/boot/1/vm-snb/quantal-x86_64-core-20190426.cgz/x86_64-rhel-8.3-bpf/gcc-12/48204aba801f1b512b3abed10b8e1a63e03f3dd1/3
> >
> > I don't have and don't know how to generate here so I can't run your
> > exact reproducer.
> >
> 
> I ran the reproducer using the instructions, and things seem to work fine.
> 
> https://paste.debian.net/1311951/
> 
> Could you provide any information regarding the QEMU version and its
> BIOS implementation?

for QEMU version:

$ qemu-system-x86_64 --version
QEMU emulator version 7.2.9 (Debian 1:7.2+dfsg-7+deb12u5)
Copyright (c) 2003-2022 Fabrice Bellard and the QEMU Project developers


for BIOS:

We don't specify bios option for qemu, my understanding is we just run with
default bios for qemu (the seabios). Extra info of seabios

SeaBios
QEMU, by default, uses a BIOS called SeaBios. It is a pretty good option and
most can be used with most bootloaders. 4 And naturally, every guest machine
is loaded with the SeaBios and you don't have to do anything. However,
you might want, or need, to use UEFI instead.



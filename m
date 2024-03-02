Return-Path: <linux-kernel+bounces-89448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E80BF86F07D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 14:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 860CF1F21BE4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 13:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDAE17562;
	Sat,  2 Mar 2024 13:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EJehuYSd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B719C812
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 13:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709384961; cv=fail; b=TyxuaiyXkNP7vLudO9aqQbszFAQrRCMj4a9Iq7AQNBOAhxDOIRXhpqk5DXETm2fVeoc7Un9mFujFWZZRrU0PUpMlEp21kEpUuFui+n1YTBtLj5nYlor76fOAh49Lkh7D3k3YkuTlyBBiD84KEIDMsl06hET9Yi/gthdkNiRm3xU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709384961; c=relaxed/simple;
	bh=2wAu193P6rR8+zVzSvtwh7o1WPuA8kw2beTwXcaYA7g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cyplpP8jPTftdZwbRGg5q3K+aAeIqBy0Wzn5N3pC1JLHiR0L78cQPznAaq7WadSMMAp1K1kxozMtVMvsm40vbAUmwLGcFAumXELr4hB6FFgtXclOhlTDRE4i3o4FQKaURimaNnEcpgBdH9UNANet4d4Ac4D1OaWHVhO8GMytZvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EJehuYSd; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709384960; x=1740920960;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2wAu193P6rR8+zVzSvtwh7o1WPuA8kw2beTwXcaYA7g=;
  b=EJehuYSd8QyU0wSK2lLNTCOXYNmd3SMvlVAWAOL6doaQmufaMl7k7me1
   a+Fl/8SxOMD6BeF7UcM3hS3zcbNGwHKPt7EMQ93QrHRz6UyZUWBKn5mZD
   ehqoV4nYSPv93zKTu9hNttAzvy1ojMRC8HuxHoHbvxquX8s8xO5FYWGAd
   3ZkuBxUxRRB3pHpOQXJmOlu6gQiN+dSvDfEh+Oxw16nHmRRtKX79rtHOj
   SUy2dz560TJzvmbCDFidf7CGt+ZVRXP2+92gmTijF72ID33xn8ehDibNG
   jQIYNwDB4W7CleNaQJy2xV0hW7XcAnqydfr+8VDT9ylLoclPCDNWbsUzi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="4094703"
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="4094703"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2024 05:09:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="8919475"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Mar 2024 05:09:18 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 2 Mar 2024 05:09:18 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 2 Mar 2024 05:09:18 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 2 Mar 2024 05:09:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfg6ZZKJEgz/nOBMIY/t9p1+1oFEDJeqknj529ULeDRKLOE6XsfIF5hA3kCZegJlaTo+y07sZyubM4iuN0MSdiEAr+1RACEMw9OTgz5PnldZ+cwJODubETgppE2wetOr+mysaNfV2HlnNAEbaRnwm9GnwFAIq6JIDtZxm6ErurvC/Ng1ocY/Agthdoe2A9IW9YfkhFkzVjYujDXiNjj3zJwPCIyBc6LAlXmvpRnB9ErTXrHrMN/+OqZ0VN4AR2LDzcCTe2I6Ei1zdd7j09XhKcb9OUt74YIr0MK+WL+/CKGfsbLK9O7W+r6D0y5y0tWVSpuoBTxEd18Yylp1R+YIhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbeoCq+1us0ibr2q+3NsbezamQp6S3S+SqQaomJkeOM=;
 b=FtAJr+SQFZtPIiPA7MVQDSo8H0jlag8No632xkz3H4pQIUV+7W664RSbkEG97KstkfRLfSeD4q7bcqZMo04YQz5K4FfiavRtz1kWs+gO+Fi6g78dD8i9Ackm6mSsi6Ge69BnnzZA69tB40gX1KP9hwfec0zaSzwb0UaTVQFdA+j4AUaKwFeOK24BbvJn9Vt1d0PZnamKsmDgGeX8LJBahiUHAd6TZk6sGqHHaXHscR4Dk9/IEIYNEvVya/TEZFd5at2i+RnbiosChmJZIBM7nSsqFsNJeMUiRRjqtg4o5aNCGUYS+I89f+/qFWzDiPMlalTYbvpu4Mrb4hEIhd6uJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by CY8PR11MB7242.namprd11.prod.outlook.com (2603:10b6:930:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Sat, 2 Mar
 2024 13:09:15 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::7118:c3d4:7001:cf9d]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::7118:c3d4:7001:cf9d%5]) with mapi id 15.20.7362.015; Sat, 2 Mar 2024
 13:09:15 +0000
Date: Sat, 2 Mar 2024 21:02:25 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: kernel test robot <lkp@intel.com>
CC: Brian Gerst <brgerst@gmail.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>, Ingo Molnar
	<mingo@kernel.org>
Subject: Re: [tip:x86/boot 9/9] arch/x86/include/asm/desc.h:54:16: sparse:
 sparse: incorrect type in initializer (different address spaces)
Message-ID: <ZeMjYfAUs74ey0oi@yujie-X299>
References: <202403021605.gg6Sr3yI-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202403021605.gg6Sr3yI-lkp@intel.com>
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|CY8PR11MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fa3a0e7-4a6b-4b74-e452-08dc3ab9f627
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mev289WpYn7xgYDOjc2xWGJ1XLMWcZxjjPXhG57BWcbr+qWJq4lGZiQeo4b7VhaHtDaqTSux6bxJ6BMv1TDCt5sU/eGiNnznnfvsK/7UuPp6p1bOgBvITA4795MnIOc7xkXELZaQKMxhdo1LC8Is1hF18OAkrPRUBoBXkKHfrdlTQl09a2oo+3KZZvbHbAX3y+TQdsL24BY8lHVd8lyF5YairABZjtiQIIuBE7FyFcDGGiujD7EYeVXEySe1d/O50EAzksN/6XoXyZH4ztiw63wxn6H4NJoa4QnzvZqUNtFSUJdcij4NuXfYWe4cdttQqiU4c4EIHCPgxEPJW7ZekxZ8y+iSx1zUbp3apwgNq1uV4p+zKa35JYL2amOLXOMMtsnqHprgrrjtQl7pmxxr2/XdIk+dZi92F1B8gElahmR/sTAVAKi6iyYE6y1DlNM1FrdXq0ltoHHp5HkBuahcZMmYX89E4QSMyY2fQcZcBTba2NipUgnDJ712j72Dz6EQiJdJ6iV/6KgQR1cjmclYYPD946ovigIxlxRiIoyL0w7wxxEmfRNMoWcetTBZKo3VraqoFtZN4nyQFISZdl8Jpsowvm6iNTWPv7IJJLTnvgnruJUscVh8+4WwzdUVYiLj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?znQNw4WRCHqMnQPGvBiZSdH39BRaKGUOHvv3JASNFH2KLxiLL8rbslIL3bCE?=
 =?us-ascii?Q?0mJf0HoAH53pf3DbQrjDhBO6FfJxXUDyIglt3fY0iJb5wiHM1Uuw2UE8ZMf4?=
 =?us-ascii?Q?WRG+0YCh/52zVPc96ANhcb6dRDAjMliTQYrgPmHBwYdsO2eWIw8omLlfnqbM?=
 =?us-ascii?Q?YNRAr4ISsIqNHyo6TNEoBgYagbj3ulpOtGsTdFP8ELJJ2FJoZBxtKPtre8r+?=
 =?us-ascii?Q?Ezuv2TI45jTwV9xJ4QP7ECcI1OP38+ELgUbnnbFwOl1prKdCH99L4PWDffFq?=
 =?us-ascii?Q?Oz3H5UMrbg7pfcQJzkVvoDJZ19qdRYEfsGylm2vo1UrTAml92RIkO5Jcxxhq?=
 =?us-ascii?Q?H3VuKd0CI/p276k8cLHxamLTrQmofFEhAQax6jssHvhk4HXbiyK3Xojh7urk?=
 =?us-ascii?Q?0EFlwUgpeILDNmW6y84LeoKfKNriKIobdY5mqyUUpzj4dvTfDwvoOcc7XyRw?=
 =?us-ascii?Q?sA79gduRCrndx7SHzN4Q108XKe3EvBLHDymNQrzB02LmKaQMu/yhgBnub+N6?=
 =?us-ascii?Q?4ZCosUNBS7CcIxcW1kgsQ6+WoMD08T3OVPyk3lbyHRejaHHy6/p3llRA5Wg9?=
 =?us-ascii?Q?RwpmdBfu84g8SaWz3EPxxbzDVl5YEgRpA/gBy2sjLA2lUdEhXLK9DGhK1oiv?=
 =?us-ascii?Q?0qHcQMeo+CQ3hMlxitvjv+kdTHJZ8o8+e11PiM6PO/MxAumqZSeEkPYitB2i?=
 =?us-ascii?Q?OWAeBOsvHF8GJeLPw9XfAQ7Z8ywL/6wDLzYov/k22Bwk/K1XGP30sL+K/F6D?=
 =?us-ascii?Q?zy6Kh/Vg+cSOgh1R49JR4QO99eXzh6kebDDO/UfosFtdHO0lfsnm8ecD11my?=
 =?us-ascii?Q?Zyy03B6FLCoc4k0h4y0Dq2vO5BVtrBNd9034UaPIH085rnofEyl2iahJrnwi?=
 =?us-ascii?Q?7sDE0Ev2dt+5925nMqpPfuiYvhKUWigMX9fR3+AIz1P2bhqqomzd4pflxpb3?=
 =?us-ascii?Q?sw5uh7l+ix5ZIGv17pn+kgZgz09YphKa/2q9AkSaTpBwKqPvIzPmao3/CoRh?=
 =?us-ascii?Q?u9HVwOt14pS4F/HrgDYAqihxDimglyUJTvooF00P8c8sLblaKdSaNyAB2ld8?=
 =?us-ascii?Q?Sln3U/PzdFM0eym7x/S18YhpoI4PfXd7YjVyZCWTMWJTnJz6ED2aeQB/pBzv?=
 =?us-ascii?Q?+4Wnjq7N609RqBSLns8ZJGMP5pQ+ziLogKkozO+WzNXcGp3eajh2x/iWM0dp?=
 =?us-ascii?Q?GELY44jTk3SccDUnqsQPsDI0PryzwoeH162mduGESY9ZdIA7M309nHmu6ZNV?=
 =?us-ascii?Q?J7/26uo0xjZ4zdkvcG/EIR5fEAVE6tjKrYIQCIQLDgCjqOSM48ES7Abxe/Hz?=
 =?us-ascii?Q?er/Wb6YorIz9/tId1sJwwik4CgggTCG+NL6eIlGfAnDrDg4IuwED/FnpfcQ/?=
 =?us-ascii?Q?bS7PBrhsmXF+RxMlinhFv+Np9pBrTGKl43zeI5XZ/zEYuiauAGhWtyqNk7CX?=
 =?us-ascii?Q?y4drkfW2TaH7LX94Db6sZ5HJEHFCHMm40KImpQavPDgYhBh4VhwLPmvdYVBe?=
 =?us-ascii?Q?H3ZgqFVZr2ycujh4DIjEddiy7U1wWtxQucd/XO5/FCJyPMJahxJcUkWnACdZ?=
 =?us-ascii?Q?pBZTRvU+G8AIPpBTO8w4BVCHQxRhAEEcc7Iz0+TN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa3a0e7-4a6b-4b74-e452-08dc3ab9f627
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2024 13:09:15.5678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZRXybfun9CAu1lvTDHP/FH7V/yAOm6U4fQS26YCx1H9q4ILj+PdRcS16a6FFMDPaaE6c/QLFqGBkV6IqUTPcNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7242
X-OriginatorOrg: intel.com

On Sat, Mar 02, 2024 at 04:19:58PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/boot
> head:   721f791ce1cddfa5f2bf524ac14741bfa0f72697
> commit: 11e36b0f7c2150a6453872b79555767b43c846d0 [9/9] x86/boot/64: Load the final kernel GDT during early boot directly, remove startup_gdt[]
> config: x86_64-randconfig-121-20240301 (https://download.01.org/0day-ci/archive/20240302/202403021605.gg6Sr3yI-lkp@intel.com/config)
> compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240302/202403021605.gg6Sr3yI-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202403021605.gg6Sr3yI-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)

Sorry for the empty warning here. The actual sparse warning is:

arch/x86/include/asm/desc.h:54:16: sparse: sparse: incorrect type in initializer (different address spaces)
arch/x86/include/asm/desc.h:54:16: sparse:     expected void const [noderef] __percpu *__vpp_verify
arch/x86/include/asm/desc.h:54:16: sparse:     got struct gdt_page *

> 
> 
> vim +54 arch/x86/include/asm/desc.h
> 
> a939098afcfa5f include/asm-x86/desc.h      Glauber Costa  2008-05-28  50  
> 69218e47994da6 arch/x86/include/asm/desc.h Thomas Garnier 2017-03-14  51  /* Provide the original GDT */
> 69218e47994da6 arch/x86/include/asm/desc.h Thomas Garnier 2017-03-14  52  static inline struct desc_struct *get_cpu_gdt_rw(unsigned int cpu)
> a939098afcfa5f include/asm-x86/desc.h      Glauber Costa  2008-05-28  53  {
> a939098afcfa5f include/asm-x86/desc.h      Glauber Costa  2008-05-28 @54  	return per_cpu(gdt_page, cpu).gdt;
> a939098afcfa5f include/asm-x86/desc.h      Glauber Costa  2008-05-28  55  }
> a939098afcfa5f include/asm-x86/desc.h      Glauber Costa  2008-05-28  56  
> 
> :::::: The code at line 54 was first introduced by commit
> :::::: a939098afcfa5f81d3474782ec15c6d114e57763 x86: move x86_64 gdt closer to i386
> 
> :::::: TO: Glauber Costa <gcosta@redhat.com>
> :::::: CC: Ingo Molnar <mingo@elte.hu>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 


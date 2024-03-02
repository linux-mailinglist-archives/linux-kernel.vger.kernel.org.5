Return-Path: <linux-kernel+bounces-89447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEED586F07B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 14:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B6C4B224ED
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 13:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704D11755A;
	Sat,  2 Mar 2024 13:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mao9ixmk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97126107B4
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 13:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709384682; cv=fail; b=XobaVKW1by1Ie8au37yuIzkdmimX4cBmp37HXlLRjaZnARL3lk5djIIQ4J+xEaDbOrFeFaOp4/8RNk1+gJb2/qnIXWa4D6cOOsFx9YZHRcD14nqHNPgH8/JUJfSGGh5imV7I7fv3d7nN6+n3yVgumpokZggaV9yChh53sj22u2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709384682; c=relaxed/simple;
	bh=nGN0YjZL4KNtc0PzSvZ4y0l0vQ90dVHLZxYV65hvxyU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iunXxlJJhM8v4PSlY83P8Fp7czji8asHDZ6sQ75DyIzDguwhBkHSfL+YLflw1mDEeHgSefGL2A9Fk4l2lF8LrhGiq2JdvoWruvl0MDfVsvIV+r/YBgBfCsjN7MS9TvEz9X9Z911+4XJv/M2kelt5EFPKk4dQVuLsRHZwd0T0e0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mao9ixmk; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709384681; x=1740920681;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nGN0YjZL4KNtc0PzSvZ4y0l0vQ90dVHLZxYV65hvxyU=;
  b=mao9ixmkbj2WV8tOHdcfvkunmz4wdbHuv2sCet5DnAVA3em8nruT4uLg
   sOVyFIF7EwuSMHw9jr3vlC0Zj4pjncL9b8IjWACuzkEAi+h12t2AdPvPo
   FeS6K8uAFjTBLAtMlOzY15B9GRfXqxtuerwbcjhnmilCXWk8aSSvvTpRm
   awrHlgpCIFaBrG0QHocWsqpw2Zfxt1cN297wbZqjBlY/qaiD+SXsm49/s
   m10wtKw25qYNLQsrkoD4ZH53PvA5qmh8BIE2dWu3/gIF+Pqz2iOZD8cIb
   XPAaq6weX9cE7JQUNzcxCRDdQwnaLkfaYtusroUy7G2eBUJvHfeyOPQ46
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="15366498"
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="15366498"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2024 05:04:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="8429362"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Mar 2024 05:04:39 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 2 Mar 2024 05:04:38 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 2 Mar 2024 05:04:38 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 2 Mar 2024 05:04:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXO/lWi+sNVKu7Fzt5uhSAkmd7BeEAsy5u2yUGTga9snrp3ntD3K6+7DTpFMi+xiInlYBq00LR1DgQJP6nZvnK9PdLl/mSY8o1z8/MJVvqMfBaqsXt+N+8IJvMwDu9tyyQbjcC9vSimeFPFvBGf69mvX4Ufa/uSN4NqRQdOjztRTDd2PKY5aywkmpdzU/hTDs2805k7aUPdNYCVMFTuHKysxzgMSxcaIBqt9ATzgs8JJpEK/DW3B3Toigc+AORv7caTQ5LD6K6dsB79SMSd0QQzkzFTOWWKpShfRMhXULO+GvOWVZdwt2Z7mqxfmBMxgGvNlZfQuJTah3M6iHM+vgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hw2MNctKXl248Re6KtiuvbdDg/MIZ50Pz9cQq0Ols7M=;
 b=NLy6qDJHNal4otqOW31y2mNrxedeDprTd38szcLZXcWjPZqRwjiFwydNwrKVQIPKBc7v/dm1FzmP9iTXLf/ne8B4SZK8/0leslBVfJoORgUhH0kAb+FZXMWSWW3Em9zSKtkVaOv+quyq9DyrjwrUEifp+ZHWPZ7kXjnmFsRF+NYTmk2ZRRPswINhKD1Y2o1n5ew1uH2UfxvEsOI8iV6yJCmS/RpWecpmXB8a/hfGJ5JrfFAH7XE/9geKORSkt1fPIFGUUDzst/C31WX+naoy4RPdJkbGFFz/hbUusDApLJ/2ZlpCTIaSeByZ95+4LrbN5rpn2hXc7kFLwPexBkc8Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by PH8PR11MB7967.namprd11.prod.outlook.com (2603:10b6:510:25e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.17; Sat, 2 Mar
 2024 13:04:36 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::7118:c3d4:7001:cf9d]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::7118:c3d4:7001:cf9d%5]) with mapi id 15.20.7362.015; Sat, 2 Mar 2024
 13:04:36 +0000
Date: Sat, 2 Mar 2024 20:57:46 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: kernel test robot <lkp@intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: arch/x86/kernel/cpu/debugfs.c:11:33: sparse: sparse: incorrect
 type in initializer (different address spaces)
Message-ID: <ZeMiSs1GNinmfpp/@yujie-X299>
References: <202403020747.CxX5V2dB-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202403020747.CxX5V2dB-lkp@intel.com>
X-ClientProxiedBy: SG2P153CA0044.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::13)
 To CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|PH8PR11MB7967:EE_
X-MS-Office365-Filtering-Correlation-Id: 28ffd289-90f8-41a6-1a3c-08dc3ab94ff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tsdy3+xwcCnur/ySIwKvT9LU2+d+ERD2rF6BRnyOVEPs6ghlZUqBbkmgcljiy2iI30ku9kc19d+6UJQGmoRfITvIDTmjaHP6HO2yA3X9IwnzgJS8D9GHH0PrSsew5/r9DIHsaW3GknXYY9GXqV3LD7yFROl1X3iS33ArW3u2USOyWMDsJwXDov+BQuAisVOoqSjQsEydlZaON+Ikxe0LCL7XBo+IlXX+lrRkH3Kot6cAqDFsHfeG8tFoGORLKjTexyf0X4n/thn/mub5ESKxfJ5eqvp4IewQoHAXAkin7843qiatcj2hqvh97et5M6oSKFiOEcL3yfwaUAYIRtaVDE/+2Ol/vzpEHefrbd3b/Bi1UMbJSUmYsV1hjt5q3vsUMqLoPn2QDp86qhKwV3p8OeVsyvWu9ZQxb4oKFcFfSgK17E9QcEeVCHcnTqagWRMRET+STILps7ZnzFWtDqNlyetkzFNwhV9BSpvs7WNjFo3cXJcEYQtcICTgy1yszeWZ2TiQEbZ1/WRMg4cln99gvAdLUhm443LSd1QeBRJPaMQQbogSuA41DfuKumXRM87tvtX7tdfKX+O+vK0W0D6Glkm6O+O99lfqcnQg/5MFsjEHY33qtlcOtMQsJtj/d3Hs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?335nTNYMsJ59i36vvxI5XTD7BxP9I+PHGFbpbpanZKgFSL2dqcPQocolstoW?=
 =?us-ascii?Q?rRwYfsZLvpm557BJLmWaCiTK+fygDJjo8ZMl8ITnW9ir9qT3OkIyLTr39UD5?=
 =?us-ascii?Q?z00faYqaDjj0z57nDV7slZBIt1jj6kmM8JH36oKuoAZetx/sZaE5IWjypz/C?=
 =?us-ascii?Q?2UhAs55J5eUSETUisuEpyE/Ptk6AcmNz0Xi+f7rJab+n6R+U1QqPVjXbvzrG?=
 =?us-ascii?Q?g6jdzvVlCVQbDZr661Ag2JiEIfdJ2xuGaWr9/sYhrS8WniKgqnfApCwts+jm?=
 =?us-ascii?Q?7Kzlp/q/3XRtwMBPCBRM9WpBaOqfnWXj/du6Rx8IjkzxsdOkjl9FT6swk4sG?=
 =?us-ascii?Q?vWxGi6W3fI1dKjYJz9hnVveEHeGAPGkyT94xRHCKHka4GlCWg9pBl5g4F7yE?=
 =?us-ascii?Q?UeLEQArihJN7Nfby58YHhVlPZrWM5rJoyYWx3FyaJ3SXFqMb1sqv2jI1c+f3?=
 =?us-ascii?Q?KlEhFtpqXaO+kE9DjKGvtN7E13b8z1BZnfVMSUkEBMoEo5ipEKAH5yKfxCuD?=
 =?us-ascii?Q?HdyXw3Ife2CziZ8N9sOSYzkQAN++yxPf5XEruNyfOvI21qR0vuNXqhbBpf2Q?=
 =?us-ascii?Q?QZNIN8ahw0Wl9cHHiBjcVqyQ2OhhpQDNPt0ivvCs74o4S36V3KttVRvzvNTG?=
 =?us-ascii?Q?OBF7xcXRMz0ZSvApWr+ULH8OsW8Cty9hvu4Om2pQra4otqTAjbTk5XN5Cxn4?=
 =?us-ascii?Q?cNZ7smD+92AsRFXKBYJibd213SOSvbEHztEeG3jTW5Z6M8ToNttkJg1IvkPD?=
 =?us-ascii?Q?RXfarPlj5P7sKuHIPwFMvqD5wlypOOeUZAcpbh8YWzkxbksHo+LKjIPEcxiC?=
 =?us-ascii?Q?crclUFaIUMEraZ0vJxIryRjGqSepxyXLOnzYzOHm63pThuMBTV4m7xQJuqDM?=
 =?us-ascii?Q?3PuRyl9nz7XKwB+x6KCLg7V301SOXTT09NnBOmzZlLeWxOwdP88dWoapOI9N?=
 =?us-ascii?Q?0sh2LKscMDz0mAJhQRYfkITJ4zdfB4oA+48nHe5obpWh9J7OEfFvKypOyv1g?=
 =?us-ascii?Q?wTkUWfZrWqPk2b+ueNYdFt87Qz0ZwSKQkfsZufBkBi/WPPvS6MZO9aXV5wPV?=
 =?us-ascii?Q?5B8mQvWJFXL0KBg/uTVYE9Mf0D5KCT0PBoCDOHGZYeSl2on5GZRZnniOjtwe?=
 =?us-ascii?Q?AvXDzPkYBei+4UcqzfhvOSSon8BklCcQu6XjNmyEFLSZ00cmoWhBnBTrozzs?=
 =?us-ascii?Q?avrxEAUlcOrCMkRjqfWj4tMYySzkT2NkhIsGIj6O8pPZNqX9IH7fGdaApILJ?=
 =?us-ascii?Q?kYNivqeOjWw0LO8ou9JWBLlBiKKMuvX/i4i9MMbMkJ8k+/4+/D+OzMwIVbSt?=
 =?us-ascii?Q?NPbxsmkRg9m++mpzQgkDs1npaVnsB8aSX6OPiNWhEPWIzY/rFXvPJ7e6ysfM?=
 =?us-ascii?Q?Fs7U97ET9yTmv2O1rcmew3t3hUM9hmWvp147rhwb4snNS6HM85ZP8USMBZcy?=
 =?us-ascii?Q?vLStPMoIWthTXB+C3O6nxrkfTT5N+vqxcoK+hxnQE946qRndQTpeajWfoSlC?=
 =?us-ascii?Q?xkqtLN2CmoXZp802LXHkiYBXJjg5E2I2HN9T310pc05z3tQKKHO7zHu6Vg5t?=
 =?us-ascii?Q?ptAYz/500KSZhdkChyzxXy+o9ST4uVGtuZnciZiI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ffd289-90f8-41a6-1a3c-08dc3ab94ff3
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2024 13:04:36.5320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JO/+lwvd8ItPmuNhvQq9uYsolv9ETUiIR79ItCtopZ3vt+/zcFvu2WcNzZM33ETlqQ8buA8GwB4I3bjiWJlxUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7967
X-OriginatorOrg: intel.com

On Sat, Mar 02, 2024 at 07:38:31AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   d17468c6f1f49e6259698f6401b8d7a5b90eac68
> commit: 48525fd1ea1cfa059a580e77b10ea8790914efa2 x86/cpu: Provide debug interface
> date:   5 months ago
> config: x86_64-randconfig-121-20240301 (https://download.01.org/0day-ci/archive/20240302/202403020747.CxX5V2dB-lkp@intel.com/config)
> compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240302/202403020747.CxX5V2dB-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202403020747.CxX5V2dB-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)

Sorry for the empty warning here. The actual sparse warning is:

arch/x86/kernel/cpu/debugfs.c:11:33: sparse: sparse: incorrect type in initializer (different address spaces)
arch/x86/kernel/cpu/debugfs.c:11:33: sparse:     expected void const [noderef] __percpu *__vpp_verify
arch/x86/kernel/cpu/debugfs.c:11:33: sparse:     got struct cpuinfo_x86 *

> 
> 
> vim +11 arch/x86/kernel/cpu/debugfs.c
> 
>      7	
>      8	static int cpu_debug_show(struct seq_file *m, void *p)
>      9	{
>     10		unsigned long cpu = (unsigned long)m->private;
>   > 11		struct cpuinfo_x86 *c = per_cpu_ptr(&cpu_info, cpu);
>     12	
>     13		seq_printf(m, "online:              %d\n", cpu_online(cpu));
>     14		if (!c->initialized)
>     15			return 0;
>     16	
>     17		seq_printf(m, "initial_apicid:      %x\n", c->topo.initial_apicid);
>     18		seq_printf(m, "apicid:              %x\n", c->topo.apicid);
>     19		seq_printf(m, "pkg_id:              %u\n", c->topo.pkg_id);
>     20		seq_printf(m, "die_id:              %u\n", c->topo.die_id);
>     21		seq_printf(m, "cu_id:               %u\n", c->topo.cu_id);
>     22		seq_printf(m, "core_id:             %u\n", c->topo.core_id);
>     23		seq_printf(m, "logical_pkg_id:      %u\n", c->topo.logical_pkg_id);
>     24		seq_printf(m, "logical_die_id:      %u\n", c->topo.logical_die_id);
>     25		seq_printf(m, "llc_id:              %u\n", c->topo.llc_id);
>     26		seq_printf(m, "l2c_id:              %u\n", c->topo.l2c_id);
>     27		seq_printf(m, "max_cores:           %u\n", c->x86_max_cores);
>     28		seq_printf(m, "max_die_per_pkg:     %u\n", __max_die_per_package);
>     29		seq_printf(m, "smp_num_siblings:    %u\n", smp_num_siblings);
>     30		return 0;
>     31	}
>     32	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 


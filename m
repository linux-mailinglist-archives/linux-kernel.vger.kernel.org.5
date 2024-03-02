Return-Path: <linux-kernel+bounces-89402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 100FD86EFE3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 10:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 641FFB228CA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 09:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CADA1426D;
	Sat,  2 Mar 2024 09:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RYCB06YH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF891426A
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 09:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709372637; cv=fail; b=MFIqcBLS9r1OpZBX7WAJvki7Eo6p3Rq9vrV6Y1bcWCWsWkXiEVqeYyjuE9faRbmw9bbkMHfkbXcqazs/Bb0Otyj7kWobDxyAqV6wZSfFKsf1g0g/dPlQkp6vLSflj2CrKPUfdTVx0DVqwrIC5QsMQRlFBxRLVrrIFsZtMumT1CE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709372637; c=relaxed/simple;
	bh=AjskG7r3pHOUPapnMt6riyucDy9bXnMPhsod7QB8gZ0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AjzbGVMUvQCnfCIdrpgrBUBeRfrY3teqkRywgYRAscEuJh+PiQmphEYMXJmofM3ZUqXZkpYZRGOuFKXvhzMZxZ9kNNRdw1nSvX44cTyZUkV/1pZdxxwBAy6yiLYasTmcUT/gLmdg7A1Cuv+dd+7KP/TqtQpRYzLSUWhRRo9Fi88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RYCB06YH; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709372635; x=1740908635;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AjskG7r3pHOUPapnMt6riyucDy9bXnMPhsod7QB8gZ0=;
  b=RYCB06YHyLOXe+e7L3vDtdd+QcHE9nIKQmzcnQl+I8C8E0SBxwdo4FNd
   XAaAq4SQ1q/iS1CPb9g++5BuNFZarJ1BT/kMzNS1Da0SvRJTgIO22DQNp
   2imDXWvUFZfG9UwKwiPzthYhNxfC+tcsZINILMFAR7Yfhf/qfsa6wzDmT
   f0g8/JvQj16fi4UltGHX4AFg05jBqbz+oAIHHRgYRoacB72UcdeuuO8wa
   e9Y2puiMhOAAKp1GzvC2gCOPT+ASPr8VroI05eaJ9tkWKxisTRBSdU9tO
   YrqWdWdxmjjuQXfEe9EVpaM7GSDcX/0NWnT7R1xGpGfuSBR4auMCE50HB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="4088487"
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="4088487"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2024 01:43:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="9002489"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Mar 2024 01:43:55 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 2 Mar 2024 01:43:54 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 2 Mar 2024 01:43:53 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 2 Mar 2024 01:43:53 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 2 Mar 2024 01:43:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ecPzi0P7KoNlLKFvfMqKi9ewd3AmIOxoJBqHVUc31fBlt7wGykh5iVb3aKnzMMreoqrMlXAgtOqJwwVRUe2/5bv1B3lKwfBK+dOJppO5rMlTdZlkD8pWySZEPU5DYnpH1zOO5Ca2PvuAqwSByPrjInsxMmF89oO4dRQnT0DgvV9Dp7f1NjQANLRYUQpG9jigl1o+IMc6QK3b8hRJgzfZdilgRVtFB26sh3SvkzoMvqlbJdudy7nLtyTzcU2wz0PpitNyHLhNXFBSwCplOKXNtbnM2fbCI0Gvwoat7eMUIhb7uBoKdAmrUltIpmgouQ/y/9WPdYlCButSf5lF5ZSbmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNKSXJk5jdEUBZLOIL77rBWSrieitIRcq3mPVDC1CkM=;
 b=QjS9qXnkAQZGK6Z+0+59fhiYWkoUqaOhWwETsN86X7VIBX56Cl/h02m0Jy4fSJMl6SKTXdzbhW9l6EYrlUE31FhL3LDByNtG6Ml8Jr45OgZEdjutgd2OG2e1/0bQHrLSqi/nb0yX0o8B4twGJiPHTgXGuoiqt1vMOTUrlkGiPYqZD8UVzPyZPkkiCurQ+/xiwZizfVKbRkE8WOu1s0oT3TnuuhLATXLk4uY7RUnGZCZZUYaRrCPQErr7rIouPG2qALvAJyxNwqp2Ib/nDp0xzl+G85DlzkbMffb9/prhgiVSAxJQJDI0mz9ropc5dzHZYsZOjqL/XC0LAB2ypTJxaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN6PR11MB3230.namprd11.prod.outlook.com (2603:10b6:805:b8::29)
 by SN7PR11MB6994.namprd11.prod.outlook.com (2603:10b6:806:2ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.10; Sat, 2 Mar
 2024 09:43:45 +0000
Received: from SN6PR11MB3230.namprd11.prod.outlook.com
 ([fe80::df02:f598:edc:808b]) by SN6PR11MB3230.namprd11.prod.outlook.com
 ([fe80::df02:f598:edc:808b%5]) with mapi id 15.20.7339.022; Sat, 2 Mar 2024
 09:43:45 +0000
Date: Sat, 2 Mar 2024 17:43:38 +0800
From: Philip Li <philip.li@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Arjan van de Ven <arjan@linux.intel.com>,
	<x86@kernel.org>
Subject: Re: arch/x86/include/asm/processor.h:698:16: sparse: sparse:
 incorrect type in initializer (different address spaces)
Message-ID: <ZeL0yknB10isSkQF@rli9-mobl>
References: <202403020457.RCJoQ3ts-lkp@intel.com>
 <87edctwr6y.ffs@tglx>
 <87a5nhwpus.ffs@tglx>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87a5nhwpus.ffs@tglx>
X-ClientProxiedBy: SG2PR04CA0174.apcprd04.prod.outlook.com (2603:1096:4::36)
 To SN6PR11MB3230.namprd11.prod.outlook.com (2603:10b6:805:b8::29)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB3230:EE_|SN7PR11MB6994:EE_
X-MS-Office365-Filtering-Correlation-Id: 94139713-19b3-4f93-3c08-08dc3a9d40f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wtc7StBsux2CiyjSSAc/eq5e8ZkdIdOTjd/aVhEfKr3wBbH7lJ4cLRjJbkuzc3v/h1cSgdMT7C3gbEUasFCCMUD7QYKAJ5Pom02+29huPK8A+N9k6/jLjZTDpy+Wt/8Jx1uJ8SAeu2fRj8QneoCd0kHHb+Yr09BGcutmPaRcQH2ucIafqGV2u+Y6tfW0y3Z1GpLO/+i7mwyRZIS3wkda6dloNDZLx1W2JXhtGGBaFBwK3WciGgtgXTxWyWpWpFR415z+bSPxyA/3CpT7PPRWF+9H5bh5Yt53eYcNP6lgwdadWq3AayTyV1ZkU/duqkeczZ5qzBLXt7Uv/0s9VL3nY17YHz64Oej4FuGcmsITp14Gdm+KM62i7TwzAuw1qigbvejT9LGYKpGIa9WuR0pNKy75S0FKrj3Q2DBSmqXaBNvmiMUV0gSrixHDn6vso39mYc+cCACyEa+UKFmCnYx2tV4BHoW0jUs5CpxXAp1yXnYtKgqe6ZkUDujagOAhaGNiMZlQDRGfNwQfVbe1fchKraRiEQ6cZjlPfKhy7vmb25SnCK5tZ8YGMwz3+zlrmiOnCR8dEsqvowMx6DH3g0N9b4VBO140HHPS3jLTFvDry5H7+vD2y08MmDE4Y0kpR3yf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DKxBobJ4qxllUsJ37lspI+X9d9NKc/NF4Je+y7Ya50xUdqXXA+An6p2n4Y90?=
 =?us-ascii?Q?wnJDPNQHdggSdxXtOLA1p6+XXArGzhDxWA5bF71lzwu6LuZKh6XZSbwZyyzF?=
 =?us-ascii?Q?OvqrxCVhJdL2Bf7qw/6pL231AVCx6hM0vRPCu0AWJlBllVyWI5n8h6wu3e1l?=
 =?us-ascii?Q?CJzDnmSFvw7GRnIFO8HiR9fMG3zbKLyPU6Pm0Oxml246d3WJZYYO7EhFZE2o?=
 =?us-ascii?Q?PhDZe2l55MHyGj9mkjoD+OmPz23qiXZ/BcGCdBHrG63VEmJLhB+n3IwlfXCr?=
 =?us-ascii?Q?cQ6zIBrFl8BVpurgDPPXrzen8BlG1q4A7qPjUWlld5oCZs/vFeY5Ddusiw79?=
 =?us-ascii?Q?efcyt+4dhAHJHYB3YxWQMzb/j0BLQ5T9xaUTZ1tt5+dkcE5lx+YqOV/3+iLs?=
 =?us-ascii?Q?OWpst3zStJja1WUCdMn7jgLodDxngtJq8zB/z3km3nCZpu6E3xEBdGVDNugI?=
 =?us-ascii?Q?3bUuR89nWIhRfpy6MSs432bBqe0BBQPKAwPvFIrg35J/WKdZ9dhmj5XbWhvP?=
 =?us-ascii?Q?g37eg7wQ2oUxMj9q1fK5awC94iEvmBdZWbMQtmpJ89EcY20hdtC/9ufrhpWt?=
 =?us-ascii?Q?P3wwmdnRJC+St/CpADr8FAX/ZX5d0shLDJL7Vp5Ka4vF9OsrCST4DoiFfQni?=
 =?us-ascii?Q?SYrNORFnwQPD28E2cCOUrSm0mRpDS/s7A56gVTlGxfTGukT1xj4x+J/RnQN0?=
 =?us-ascii?Q?k6SfHwiXp4wtuAEnF7Pa9pgLJT9HFEKJdlYc0a9S25Orw7nNYEBgyF6VHeKH?=
 =?us-ascii?Q?9sGPe9pdXHDg7CzDuUvw95bTgeBMSiD6XZ4KhBVUQg6LUsREcqwqfZi0ON93?=
 =?us-ascii?Q?2W3unnyZ48/kuGEeFBrlzIBA9uAdD/PL4VMmYQIb/6s34o0t6nlg629kiI5C?=
 =?us-ascii?Q?SaEzQdDuEF+xcbECcPtGiLgpVXMNeQdbwFq4Id0qNP6B/g+RThrYy+PVvkqO?=
 =?us-ascii?Q?tK5KkYZMl8L82GeCr36KdeJdH/YKKDf/lJbJcnZ2bR9pIJsO5oETfCYjvbbx?=
 =?us-ascii?Q?xInFclqAFGBPN09aFapiZixHll75dQw4lQdZZ8iJcgPi8FWfMiTFScqF8y30?=
 =?us-ascii?Q?9yDT+zRVUBGf8Lvd+r8wKaCITyMYqKlBXx5vP3CaI5dZdAKoKnpvUD9wr3wf?=
 =?us-ascii?Q?dj+SedMiCzChhwLkGlz9LUMY/OXul4RqKreKpE0ThdcMPOA49LN88VKfOz1Y?=
 =?us-ascii?Q?6LvRGIfbgMfRhWYlPv2AP8iRdrsR+a9zbS1/SmWuoNisSZd9YxwZWyKtuLF5?=
 =?us-ascii?Q?XVSUsdCoY51bBuMMSrl+0S98c9F7WpROsBb/sPQEo0/HBz9KFW3m4tXvdNSf?=
 =?us-ascii?Q?n8iUqsQ0yQ/38oFoVB5fcykm4JMrL29yLYSx1t/uZt4rb+s36evIrn2YsfIs?=
 =?us-ascii?Q?+VPa5LSnUxjFb/gE7sxFgRtqHT+O1xgsZ0nYAixv/lfEXGL35cqld+P9x2KC?=
 =?us-ascii?Q?2vVzH7tLaCO7N+u8cM/eQDDO3M56kNh6g62ph9jQuZ0jhLMfLFA/+cCSElDb?=
 =?us-ascii?Q?lvh/Ekd9AucF3b7eoTuKjzFTOpi70BmzaBvycj+C7Kcxp+AqJbXljv7KN5Ua?=
 =?us-ascii?Q?SuCePTtSa1jMb/HzzYTii3ETLGN3kMTGWkGlxtIE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 94139713-19b3-4f93-3c08-08dc3a9d40f6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2024 09:43:45.7033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q83B+54Bp8JmQlr+EWkdKnP0OsF7x+XrVpd03F0l0Y19ohNFKwYIM0ToIT3EKggCWMX3HNrqQ9qcIeCJ3myhxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6994
X-OriginatorOrg: intel.com

On Fri, Mar 01, 2024 at 11:26:35PM +0100, Thomas Gleixner wrote:
> On Fri, Mar 01 2024 at 22:57, Thomas Gleixner wrote:
> 
> > On Sat, Mar 02 2024 at 04:12, kernel test robot wrote:
> >> FYI, the error/warning was bisected to this commit, please ignore it
> >> if it's irrelevant.
> >
> > I have no idea to which previous thread you are replying to because your
> > mail lacks any references.
> >
> >> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> >> head:   87adedeba51a822533649b143232418b9e26d08b
> >> commit: 6e29032340b60f7aa7475c8234b17273e4424007 x86/cpu: Move cpu_l[l2]c_id into topology info
> >> date:   5 months ago
> >> config: i386-randconfig-062-20240301 (https://download.01.org/0day-ci/archive/20240302/202403020457.RCJoQ3ts-lkp@intel.com/config)
> >> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> >> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240302/202403020457.RCJoQ3ts-lkp@intel.com/reproduce)
> >>
> >> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> >> the same patch/commit), kindly add following tags
> >> | Reported-by: kernel test robot <lkp@intel.com>
> >> | Closes: https://lore.kernel.org/oe-kbuild-all/202403020457.RCJoQ3ts-lkp@intel.com/
> >>
> >> sparse warnings: (new ones prefixed by >>)
> >>
> >> vim +698 arch/x86/include/asm/processor.h
> >>
> >>    695	
> >>    696	static inline u16 per_cpu_llc_id(unsigned int cpu)
> >>    697	{
> >>  > 698		return per_cpu(cpu_info.topo.llc_id, cpu);
> >>    699	}
> >>    700	
> >
> > This is bogus and I looked at another related bogosity today:
> >
> >   https://lore.kernel.org/all/202403010704.oGQZPu0P-lkp@intel.com
> >
> > which has similar complaints.

Really sorry about this Thomas, the empty sparse warning in the report is a regression
caused by latest bot change. The impacted sparse warning pattern is "incorrect type".

We will fix this ASAP, and reply to each bad report to paste the raw warnings. Sorry
for the trouble and time waste.

> >
> > So I went and downloaded the config and followed the reproduction
> > instructions except for one detail.
> >
> > The only difference is the sparse version:
> >
> >     1) I had the regular debian variant installed.
> >
> >        Version:  0.6.4 (Debian: 0.6.4-3)
> >
> >     2) I updated my sparse clone and rebuilt
> >
> >        Version:  v0.6.4-66-g0196afe16a50
> >
> > Neither one of them exposed the problem, but you are using:
> >
> >        sparse version: v0.6.4-66-g0196afe1-dirty
> >
> > which is obviously based on the latest upstream tree, but seems to have
> > some extra muck on top which I don't know what it is.

The extra change is mainly to make "incorrect type" kind warning more bisect
friendly to join multiple lines together to output, and the change effect is like

Turn raw output

        net/ipv4/tcp_cong.c:300:24: sparse: warning: incorrect type in initializer (different address spaces)
        net/ipv4/tcp_cong.c:300:24: sparse:    expected struct tcp_congestion_ops const [noderef] __rcu *__new
        net/ipv4/tcp_cong.c:300:24: sparse:    got struct tcp_congestion_ops *[assigned] ca

To below format

        net/ipv4/tcp_cong.c:300:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct tcp_congestion_ops const [noderef] __rcu *__new @@     got struct
tcp_congestion_ops *[assigned] ca @@
        net/ipv4/tcp_cong.c:300:24: sparse:     expected struct tcp_congestion_ops const [noderef] __rcu *__new
        net/ipv4/tcp_cong.c:300:24: sparse:     got struct tcp_congestion_ops *[assigned] ca

Sorry for the confusion here for -dirty version.

> >
> > Does this reproduce with an unpatched upstream sparse for you?
> >
> > If so then I'm really curious why it does not reproduce here.
> 
> Sorry, my fault. I can reproduce now but it still does not make any
> sense. The code is correct...
> 
> Let me put something together which the sparse folks can digest.
> 
> Thanks,
> 
>         tglx
> 


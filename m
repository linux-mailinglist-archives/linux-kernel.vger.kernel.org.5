Return-Path: <linux-kernel+bounces-88410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BFA86E13B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 251CF1C21719
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E113FB81;
	Fri,  1 Mar 2024 12:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FE525cLE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BE422318
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 12:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709297054; cv=fail; b=Q4lwpFrYrYc76Us+3HCRkT2fDv78vEVryZU4qlRSOwvGP1AEizezv1rruWKBKwnxbkEZkXbbilQ8ODg31Xz57X9OGpBH4lvuoclyM4BzuGMLnRfI+YgLc5T80B3aVrTMs2Jb5w0MVlVgihO9Jsx/2AeI7waMb2AdaNmLztJNx2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709297054; c=relaxed/simple;
	bh=JK8W0x/YqNS46AXzxg+TBA2NzwmsI4etiDSONDEuXvA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a/02erfJVcU0S8T0y4mGTXSsF9H4OvZZuLemb4IQb2iyY2lFsMLlNwWSzhSKLmVNDc3VSPS+yRZG5hinMnzkbUz3aMFUO/l1Xqd/AxUNFCiRMaLV/669GUhD6plMqrUSOBRdlBKd3CSLtiD15Jh0k+iWGqLV8QtjhSxipdiReJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FE525cLE; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709297052; x=1740833052;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JK8W0x/YqNS46AXzxg+TBA2NzwmsI4etiDSONDEuXvA=;
  b=FE525cLEdowvcKYk1IrczwD7UPYN4A/n34mMeckrSDE79TOYwEBgCe+O
   awalGsC7L7Ex4yZ5p4rhOqSHOqKP23Q8HHR/NrNjBDddDqZxVxtN1RtIM
   8BhoyLqzB0PKiQztCKzrktmhNLHIcHtDNi3U1g8ljoBlCbzClhJ/5B+S0
   1NYalQK2WjoNvxwIwyiujj+VWwDMZYiuh/vp+sQ+DrsoswK3CxEjAC78s
   t+KBRAoeTWbDXjWyGlxNiIKXX6Wi5fSvct2UKSx7tQbjY3oqW4Dmx/qM8
   BCCN1tm84kiLaKoFcZaTlln54I1xVLJDkZA/XFeSnrT0ynMEehBidDHW9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="26295280"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="26295280"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 04:44:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="8252287"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Mar 2024 04:44:12 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 04:44:11 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 04:44:11 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 1 Mar 2024 04:44:11 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 04:44:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjCPuyh3xjDplQa4B2SELu6Sk6kC+Yro516G4nAYhZS92dQjjhHTNVZmSYUexjTuTe4Q9ZlvXXtXbSwnRTPQgo5Ph6HxfF6SB+g/Zyfi0n5BrzQ9ybj/SahqczhCTugTjlOOGYbirBNtvpms96Ljgzti01sywlPbltxnpyLEaBcwCinjonwZn+DVE4lw6BS//NrBi0hFGen6MbnMmpYkJoZAZ3SKAeOViZsXadyObeKOFhHwZZNOLJ7NXe79/jPL6yaXVsO7yJ25wIE16uHLeDDIxbaGFwSV91y9JwpZJgWjy6pF3Xed6FUvjAeIEo7bfSs7nfnkRhRFV+6aD4H84A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/vVVzVn44MbetLonYqu2oSeqq8unCBcSrluUQ95Q8k=;
 b=FmWG9nQwlNMazaX3Be2cy6ltk0o3gssbMSKUDxpQRw3TUExkEo01mmxJrfk5tjYuhZbATZHZJCZHbYgXBfSuFGlYKDNLn/8JPBqeQZx5ZpdChCYNxCqnR8Q57p6Npi3RAasqaQA54kuRTrDB853G/E7JxYznTkUhjP7Xwu0lcLQ8cfRSOZzzGqIkYFYbPhzz6Ii/YJIWGd0Ro1og5FVWj2fQGq/k67KS6GIJJRnR3lZ9Wm4mHok/9/J6nmEsl+rx4V3zAxWNWzCpUiypBaJYG9o3hSNdV6OpuKLdjnm7D2wOqfekAyypBNRFyp+og+GtzpPWomCu1QocnWzmo5jrQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN6PR11MB3230.namprd11.prod.outlook.com (2603:10b6:805:b8::29)
 by CYYPR11MB8332.namprd11.prod.outlook.com (2603:10b6:930:be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.16; Fri, 1 Mar
 2024 12:44:08 +0000
Received: from SN6PR11MB3230.namprd11.prod.outlook.com
 ([fe80::df02:f598:edc:808b]) by SN6PR11MB3230.namprd11.prod.outlook.com
 ([fe80::df02:f598:edc:808b%5]) with mapi id 15.20.7339.022; Fri, 1 Mar 2024
 12:44:08 +0000
Date: Fri, 1 Mar 2024 20:44:00 +0800
From: Philip Li <philip.li@intel.com>
To: Nathan Chancellor <nathan@kernel.org>
CC: kernel test robot <lkp@intel.com>, Florian Westphal <fw@strlen.de>,
	<llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: net/netfilter/nf_bpf_link.c:186:33: warning: bitwise operation
 between different enumeration types ('enum bpf_reg_type' and 'enum
 bpf_type_flag')
Message-ID: <ZeHNj//1o7R8BMx6@rli9-mobl>
References: <202403010842.hhJY5TFK-lkp@intel.com>
 <20240301035059.GA577965@dev-arch.thelio-3990X>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240301035059.GA577965@dev-arch.thelio-3990X>
X-ClientProxiedBy: SG2PR04CA0152.apcprd04.prod.outlook.com (2603:1096:4::14)
 To SN6PR11MB3230.namprd11.prod.outlook.com (2603:10b6:805:b8::29)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB3230:EE_|CYYPR11MB8332:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eb8bdeb-de52-4fcb-157b-08dc39ed4928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lRwnrvlO7UONXLjXB+xsuOw1uK3kDhPUovBgSegJsMKqFZFlnSx8p3TCFqLlPZEQTf56HeI2OFdbiKe43UtZO1v1MiJqIjzhdnG5ElKWylHJyEXipLxqZbMqzvih3RAyGlGtLTb1sF0DTfZ7hsdcaaZYMV89CrQlIKnmsdiXRQyw57nnGSRYhH9kel6+bd3T4hNrsFKHl2sIRZYxDir1tRGCyajSN6zquHHo45WuOrbU2DzRVpX4owWEatQ5f4P5bVl5R/8aztzRuAYrQujVFjgJT5mQ1R9pq6nwiLEnPTLmAwsU4rLu2b1R5jzBcZPSIhMCEaL/P+hh1n0xPQJQ5484MmvPSQYErxWW0q5GpHGgmKEKJtN0Ou8ECtt6lOl7icogUyWVHAqz4mrVuShvm7naBF/b9kuBdo50XY3wvj1Dcrq6gk8ejywYI7UHJFXtWLREK3F8dDl3NnU5YPjMbmnVXePOgDdZC99GPT2LNJ50AeHw+11901Hpl39V0AEhXCRsDzq3W6ePqqRb+7TRtp1tTTHC1A4nk7l6AZW3DGuyntV/nVIGapz8XaaUmDpzI5XeS4khm6SsdnYWdhc998U0O52CH+rpZcEdq7UZhI4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DWd2pCAG6Aj6ZOQ1MhiOc9jPX8KC7L1Wlz8C5muBHnBbkK2RhzswHyrZvM13?=
 =?us-ascii?Q?vX7kM4AnNRiE3ZGtl0h3cuCJEUKblh3m0Xt7aHNlcG66AWrdU9JmiVahdX1h?=
 =?us-ascii?Q?t8aNNRRrPlLpUhmhMmzJDPiS7hMDoz7g4WkVH6StIMojLFciuWE85JZoS+uG?=
 =?us-ascii?Q?Jq7sLT4BNBY9B3QkZu+jmR3/X3UU7tEQOk4kOB83jcGNRzXc4/EnJKEqVQGE?=
 =?us-ascii?Q?48JvIrYBqtlrOmWC3kvuaiMrGvkM2IMZbwKVrxRkAT9/d6GheA9kCqx7jF4H?=
 =?us-ascii?Q?j7zjWcUsJ+CvU2LSAlSz19x2JUrBFWaktPbTcrwYcEbzEsqDm8Q0tGeSTZnD?=
 =?us-ascii?Q?e22HkjEaVeIVq5sxwohTGf+Rd5x5D/F9YItjgsqSK0eGf22zgvqUhYn+tS2U?=
 =?us-ascii?Q?8itz4P5WjKlhktfpLtnpVYyEUcfGkVRaanwcPRBPr82SHvWEHZ3K12Ab3iVq?=
 =?us-ascii?Q?SjLYHupMFzbjEsuJA6dyW+M4nijorRN01bBKkUP+3t9xgbs1N1mcmWT/mgm4?=
 =?us-ascii?Q?Ug/Y9AoDSQZVoAFhWN/1gpRvh9h+Mum601mRxgBS0rO+I5pFiw2C16haMW8v?=
 =?us-ascii?Q?oGt2veOBPn/t5z9oXCdYMoDyRl+t2VU1qdKAzGRA6cqPpOqH1iNG/72GlDUU?=
 =?us-ascii?Q?4RWNSm8Wp2Cp0dWUgGawSOdsnOAU01DrCxbbhAVMEooGYHoQ2VmsbbgqPMi1?=
 =?us-ascii?Q?oOnN/n3FdG3+aaTtd+LNMfh2ksGEofORGoPFP1itNJSpp5g5qilm6xOvrSWy?=
 =?us-ascii?Q?OdRWPGPhKZlvJQYOS97MkFDx6/3KhRGxPVh4wRKXSulkV8kcugZK50zq1f8a?=
 =?us-ascii?Q?lpzkFVpECYVPLwxjv0WQ/a8o70q6ctZH+uLGBVvjW6gaFmIaXxO4US3fSoyQ?=
 =?us-ascii?Q?8x4Uc7lpwZ6NTDckvvlHVsfkTBSOwHLucLSjpjPDMpTLUcgP0hbTABFMm8Eq?=
 =?us-ascii?Q?WGRjj1eQACtmE1JAUUuXtyD0rPgclCPuwtP8zoeMYQZU3J3OVKP4E7oj0BIJ?=
 =?us-ascii?Q?AA8hOd0kbd0ScpJ9omjGb08gtzxGIGAX0UL1haMrJRl3imhKG54BkDqczgnX?=
 =?us-ascii?Q?SWoruoDaukR7GecXgFYLva/q8VIIs3/wB5oWp/q8RuydH0zdphgsog1NDYxE?=
 =?us-ascii?Q?5klhTPNTEUNV1FQEGGiXyCbRbWGGyMdu285HwJx32Oan2i1bUqLQVaIWark4?=
 =?us-ascii?Q?tDTFaE6ld1vuZ2NurQnyRFgbgsLA5Qxd86Ph8X7bJky7aKF+cPwxJ6WrESNi?=
 =?us-ascii?Q?8Ac9dFZ18funPGojrP44RoVyWvF4q8ke7bNMi+V1pefpzbWKVJFxL+Cbu1Vi?=
 =?us-ascii?Q?pKsPj7lGN7OMnjQOm/jnjvYvC0JcIG3snci5qf5s64MgL1XUKDgK8X6sYIxI?=
 =?us-ascii?Q?S7gip0m5SvwYm1/5Da4bfrCjx5F71BZsaJv192ESUU2QkhVbZjsvdYiX5PJf?=
 =?us-ascii?Q?EMupwM4ByWJy6QvULHBBE95ns1E86/jm37bFc9cAX/0cA6Kx+jbBK458Wblf?=
 =?us-ascii?Q?FfCx2qCfTxpGEhIm2KI8pkzGRl/rroh2FcizhQO0tI2NN/62FPAwytqlFwTq?=
 =?us-ascii?Q?qXNZda6eQy0U/XzTfowDACvdTtt1mfl0OXTbQOWY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb8bdeb-de52-4fcb-157b-08dc39ed4928
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 12:44:08.0810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6lCSVpz1IupS0IsFBW8WNaGca6ivZi9KaZ9pnsaQlr2dioYPiJDqc/6mWJHBbarSwOZ1lXnA5x0bsgXLm+yZrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8332
X-OriginatorOrg: intel.com

On Thu, Feb 29, 2024 at 08:50:59PM -0700, Nathan Chancellor wrote:
> Hi all,
> 
> On Fri, Mar 01, 2024 at 08:57:56AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   87adedeba51a822533649b143232418b9e26d08b
> > commit: fd9c663b9ad67dedfc9a3fd3429ddd3e83782b4d bpf: minimal support for programs hooked into netfilter framework
> > date:   10 months ago
> > config: riscv-defconfig (https://download.01.org/0day-ci/archive/20240301/202403010842.hhJY5TFK-lkp@intel.com/config)
> > compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project edd4aee4dd9b5b98b2576a6f783e4086173d902a)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240301/202403010842.hhJY5TFK-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202403010842.hhJY5TFK-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> 
> <snip>
> 
> While this change may introduce an instance of this warning, it is
> actually a change on the clang side that causes this and I am still
> looking for input on what to do about it:
> 
> https://github.com/ClangBuiltLinux/linux/issues/2002
> 
> I think this report can just be ignored for now. The Intel folks may
> want to consider sending -Wenum-enum-conversion and
> -Wenum-compare-conditional reports to our mailing list only until we can

Got it Nathan, we have updated the bot to send these 2 types reports
to the mailing list only.

> sort this out. Sorry for the noise.
> 
> Cheers,
> Nathan
> 
> > >> net/netfilter/nf_bpf_link.c:186:33: warning: bitwise operation between different enumeration types ('enum bpf_reg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
> >      186 |         info->reg_type = PTR_TO_BTF_ID | PTR_TRUSTED;
> >          |                          ~~~~~~~~~~~~~ ^ ~~~~~~~~~~~
> >    22 warnings generated.
> > 
> > 
> > vim +186 net/netfilter/nf_bpf_link.c
> > 
> >    170	
> >    171	static bool nf_ptr_to_btf_id(struct bpf_insn_access_aux *info, const char *name)
> >    172	{
> >    173		struct btf *btf;
> >    174		s32 type_id;
> >    175	
> >    176		btf = bpf_get_btf_vmlinux();
> >    177		if (IS_ERR_OR_NULL(btf))
> >    178			return false;
> >    179	
> >    180		type_id = btf_find_by_name_kind(btf, name, BTF_KIND_STRUCT);
> >    181		if (WARN_ON_ONCE(type_id < 0))
> >    182			return false;
> >    183	
> >    184		info->btf = btf;
> >    185		info->btf_id = type_id;
> >  > 186		info->reg_type = PTR_TO_BTF_ID | PTR_TRUSTED;
> >    187		return true;
> >    188	}
> >    189	
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> > 
> 


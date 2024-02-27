Return-Path: <linux-kernel+bounces-84059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 780FD86A1CC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3031281C76
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915A914EFF8;
	Tue, 27 Feb 2024 21:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ex1uKo29"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69F114F960;
	Tue, 27 Feb 2024 21:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709070130; cv=fail; b=tJ4tY1Uu0SgP2piIoIFbTEWqsXDTzeaDnzVGM2VZlFbbsbs6QtSTKTiLaTcb2aQ1+0+TcuAvmSeSBVrbhixP+eE9gAqNHXrRQWljx7guDecBvABbFNiVqJmkxB2DBRoKA6zjM4Vfbo6Q9pERfPyAJCr/X8SSCM6Oex/bMepL7Rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709070130; c=relaxed/simple;
	bh=8ScOA56kOdrCA4yYVefA0FsFYz9O/mYzEjsXr6NPtvA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BkR6FXH2Z/SXvJiop1koNM45VTsmpw29JC9bcTxeaGbzdXn3oHsnc5g91vOmakfvbBxJ5JS3k1sXatle+s1+4w3a65q3MBVGzJXG5kjSE5FK1ddOstcCA5p159M+l7WIUJgaallDjJ79GpL5hiLbQgax/BcKAqDUfHp6ELBWLus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ex1uKo29; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709070128; x=1740606128;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8ScOA56kOdrCA4yYVefA0FsFYz9O/mYzEjsXr6NPtvA=;
  b=Ex1uKo29amF4IrpgtCqR5B/GtlEDphbHK5Sffy2S8+Zzw+BeHWs+Tqg8
   CQQZvNeJvzr7i6byzLpYxhzwGxCBhA70m445l02r6HOnFH+KQIMzUS3V2
   QbwW9gz+5LP5ZJYUnUBqFqSyAS8jYpjaZ/6cRr8Rcz1FYOamqTav2Mejc
   PN1qpHW7RYlkIT4JhHgnN9DG9JBABs5AXd0AMe+H7CKXtA1PnK8TpCYdp
   w8LCWCs0eyxsspx/SQ3Fxe9tPTpFSdQ67i2nzYg+3N74Ik5rrrQCMmDD+
   VRjfoL1kZeq7Dn8rIrsaqHYFAlDXxDB9ioMLeyq9zeL/zIdMzpTR0v+a3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3286034"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="3286034"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 13:42:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="38229574"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Feb 2024 13:42:08 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 13:42:07 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 27 Feb 2024 13:42:07 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 13:42:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDrz/d567NCpEcV9S/oq+FPxddlMeUhoAxWmbihMoIqx9ySlrpbNm3EnUxUcPa19ONK3+k04JxgP0HH9C5Xa5kCPBq0pegfQlYkKPFbN3HHTFmQd7JDy9hWFFqvk4b8iWkO7nYwK0jA7bCdyetMGIN7SZxiMHNghaz+uISksmQP1Is457CU7+WBnmRyCs4HpccGpFpr5lER1uyBY1OEXJWfw4lQpzu8EKtb0EWDtBkshuuPYOVsJwkMU4jKU3cXNpZ6D3/NjXhnJ6eeKcd3vcFAFdsQahGt77+fOogA5jNS9MumqgmFiotfD+SrTERjZwlUfIDlRKV84nkAP+Ez4UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avgMl3kl4aPkfiID2Dd9ml3Md1mYUJS7EVQ9p2LTLqE=;
 b=VDXPoV10InK1c4SSOjg86fvvDpf9WNMzN/bRbeCvDfc97br/NM5zbJAo25fn8aBYWfppXuvNbLUgB8LgEpvCOUZROViBUgyFgO7TaHguMy8Giul/geDDFS8tjFHrtGACuYmo228nz/jvwYpZPdrCpTaavNSJ0Gd//Zy43fDz3WKFLsIguW/mnTsxbqy88Hg6rhTGBO78HMhGgBM/RynfxEvpg2WAAZLZHUopUZooFdkjSBh3WVW9+RPWSESaKoDPimTzC+NtORuvWvPmYbyBaXgJWhU23o/iWpFZF06zjTdO6b/twbYaCPbazRZAoNcQP/Pt/iOHsIdEn7EId3/i2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7108.namprd11.prod.outlook.com (2603:10b6:930:50::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Tue, 27 Feb
 2024 21:42:00 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7339.019; Tue, 27 Feb 2024
 21:42:00 +0000
Date: Tue, 27 Feb 2024 13:41:57 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: <peterz@infradead.org>, <gregkh@linuxfoundation.org>, Ira Weiny
	<ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, "Fabio M. De Francesco"
	<fabio.maria.de.francesco@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/3] cxl/region: Use cond_guard() in show_targetN()
Message-ID: <65de5725824ba_1138c72948c@dwillia2-xfh.jf.intel.com.notmuch>
References: <170905252721.2268463.6714121678946763402.stgit@dwillia2-xfh.jf.intel.com>
 <170905254443.2268463.935306988251313983.stgit@dwillia2-xfh.jf.intel.com>
 <CAHk-=whBVhnh=KSeBBRet=E7qJAwnPR_aj5em187Q3FiD+LXnA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHk-=whBVhnh=KSeBBRet=E7qJAwnPR_aj5em187Q3FiD+LXnA@mail.gmail.com>
X-ClientProxiedBy: MW3PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:303:2b::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7108:EE_
X-MS-Office365-Filtering-Correlation-Id: 4621d142-fde9-4829-361c-08dc37dcedad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tNz/Smcqst7JyonUxfHRXasKchDE5+evvT06jKBvlLk2Sx2xb4Vlv5ZMxVwUEhBRgkiqRa2xTnM1JjrxleZ+LpSp5LMYxWotXQxuZ4Y9kCYf+ZMn5F10OnlbAm6MCG5MR1qiCiQQ1es+SSTFlSD+KQFMFq4Vm2fWAQmc1V8hZb7Sin6mMoMsuyFXwr6w7Qe02pulFHLjQolnIdIL/8KrlvOssmhe1oXM3sSRlZiup9QjdOJCxax1rfZ98tePCY/Xm3xZh6BQP92gP+46OmN3lr1yI20FH/ZB5ykrAXZG1vIlB6KqG9LkZrHa81O/IUSODV/9RFHWhBzQsB0GgS1WOqFs6nQ2oEhQqvu5Vrvt0kLkv+828xx3gAJteXRoZMV+rGCR8QqVFpkkZ6Mp3Xinsc3bie72Ytz5/ly2nTl/Cq4ZsWTxuOxbpvbSH9x5UL0/KWG3L+kl+gNFcXsruBmn+C7SKah/HG3wNTlQdkACqzEzmzltdNbrW/QGwbPKLTz8zDDw5FOX+0U81TN6BNZnALjNT7VUhnbZ2d3VWOsXSwblHh8BHfk3D/hQR5vXFu6MndAcw3yxwIj0sh5+nOH/Yoo1BU7LCCi8ojgfCeAmPPFbEB3J1EbV5JBLQagNjX4WvaWAXby8+hNiKkbTBTseNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qZB33h2pA78bfWnJ5bAT5Vhk649LEH2IxvHhfesx2Q3eZwROzkN8W4jlW8Nv?=
 =?us-ascii?Q?6hcCDmmVhaH9CB2qDgJblwhQsSLqiNzzOTc55oi7zoAtp975LCt5UvdNtuLI?=
 =?us-ascii?Q?pcqdUR/STOurdnEI0uTgbQ+2rujzXMR/HEEMzPUHU+lK+MtGapFD+b65PbRe?=
 =?us-ascii?Q?H08sZp5uAnunojii730nIEFitr4N/N+eFTziHm9/5BCia7WrqNNQlVNvXGYC?=
 =?us-ascii?Q?pgNGdGoxLB9GDuihn2aon0GadCMkd87tlBP1f+sgZx4T5HKfaMYLRtWaNrni?=
 =?us-ascii?Q?jreG7yQV3z9ZG06PzW/E0tBbwNNpHFL4m+D1XWp1FcgFAyR8TzLeP7bkH6+1?=
 =?us-ascii?Q?Bv9FVrU84jZF2mKdx+FPWg4xWH6mzgDobnZcgV6F9G7eJIfyaKD+Qj9GbDlL?=
 =?us-ascii?Q?pOAx4PU4raMNsXMmQw7+yrtAMQPUBL9s2235+/3fSOnbTLpXbct9ZPSi3jI+?=
 =?us-ascii?Q?izoHRDskwVUDmSn65uMkxYpRD0B6MNS5IFpDaZSM+vTJBVR9EQT7jJuY452U?=
 =?us-ascii?Q?5FF2ABokRKyy/s1O2CLoV+1r2g7FHyvVEAeLStsw4hzbtcZbs7/Xh8QFNlNb?=
 =?us-ascii?Q?wLGYM8K+6BTP/rvhxyjMbVsq/km97YfqLmDSiPsw/fq6djW1Bh3d6p3zS1cJ?=
 =?us-ascii?Q?Kmc0weaPw6t0Y0e+e6NEwSfqThQQ4/CjM6dhntEy9GsvgGpa/JS3ivdKanbH?=
 =?us-ascii?Q?s7QjKuzweUnYhjZMg3Y2VDzqsAvlNfFOb1JiyrqEqj4B4p0pSDysSpVVFTKw?=
 =?us-ascii?Q?n7Jp3aZ08Nj2MLM93FBHDusO2ZfsmMkHD1n1m6bbI73uWsGLMMwbqgRSlLj4?=
 =?us-ascii?Q?7+2WKPkxB8A55mQfTd+NaKcfUmCeHgG3UJvF53JRW4XqewiW7djA7DILrFug?=
 =?us-ascii?Q?7yXAnZ6VR5qXK67cps/LdQ+lGys7WxvC8lESYslhh8aqKhhE/k+MSKTv4TMg?=
 =?us-ascii?Q?SuNG2E/l6ulfNBrTmT3jIEQiZkJTsMJzauIOddJXkdbFYgQZbnHm8FSwPOok?=
 =?us-ascii?Q?6d/jhDos1EmoulGSntnlE85BnpH+LCnYRhi7Z8yzgUZ6qGxY8S7RbwAaMDx3?=
 =?us-ascii?Q?RwZE399aXMgaJWc3LHVQCswGZarVHjEJZo3CwjAqZC1twezVhVKWIwW9GsBT?=
 =?us-ascii?Q?ICLB+oTuExt5/UJ5/uB3sxPz7w0xQSAmcyf089nOqzdHYPbI9qJRs79HGDCs?=
 =?us-ascii?Q?rcfEtC6xOMNel3tCqu19OnqNX7nykReThTWl/QL6+lHDNJv3Mp32AqZx3Lc1?=
 =?us-ascii?Q?Ucz50p68j1T3tNsa+BY5MIhAvWhfYmV5xDjmh1r4uv92Z//87FYKLEspPiLt?=
 =?us-ascii?Q?JXBgd8VYaDu7mDQShVXQdzYEllZYmMUXdCYXkE+lf5+w21NWWt59IGw6xeS4?=
 =?us-ascii?Q?XS4FOoG9s7T4tbSwABOpsTWgYvy2GuLBPTzIA37+mCuTgNQ0WGZbYQNZ14QM?=
 =?us-ascii?Q?kFMRVNmRjBpHsJHu/k3K8Fwo/uskIxpwPYAHQuScKYJaperbKNObLDgRnP9U?=
 =?us-ascii?Q?iHOx2v27IhD6SUOjHe3cC+SKHwh4rxAY0R0HWoPjxSio6Snb/jSfj7zgB3ER?=
 =?us-ascii?Q?g9HLQdg9omlnd8igdx2uAveiGpxQ8NzWEQjOmdnwhVroASwPjzxqTmPgkzqm?=
 =?us-ascii?Q?aA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4621d142-fde9-4829-361c-08dc37dcedad
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 21:42:00.1047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7G8F+Iereq4QE5w+6odsOVMFPTNfmznxDzq2ocQyN5mY4mkSOOE30vfyX4TfPn9njQB5m2/iaDmy75LrF+A9L7FaLwI7lil4w7b3jPGTO6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7108
X-OriginatorOrg: intel.com

Linus Torvalds wrote:
> On Tue, 27 Feb 2024 at 08:49, Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > -       rc = down_read_interruptible(&cxl_region_rwsem);
> > -       if (rc)
> > -               return rc;
> > +       cond_guard(rwsem_read_intr, return -EINTR, &cxl_region_rwsem);
> 
> Yeah, this is an example of how NOT to do things.
> 
> If you can't make the syntax be something clean and sane like
> 
>         if (!cond_guard(rwsem_read_intr, &cxl_region_rwsem))
>                 return -EINTR;
> 
> then this code should simply not be converted to guards AT ALL.
> 
> Note that we have a perfectly fine way to do conditional lock guarding
> by simply using helper functions, which actually makes code MORE
> READABLE:
> 
>         if (!down_read_interruptible(&cxl_region_rwsem))
>                 return -EINTR;
>         rc = do_locked_function();
>         up_read(&cxl_region_rwsem);
>         return rc;
> 
> and notice how there are no special cases, no multiple unlocks, no
> NOTHING. And the syntax is clean.

Ok, I took the wrong lessons from scoped_cond_guard(). Consider it
dropped.

> Honestly, if people are going to use 'guard' to write crap code, we
> need to really stop that in its tracks.
> 
> There is no upside to making up new interfaces that only generate garbage.
> 
> This is final. I'm not willing to even entertain this kind of crap.

I will also note that these last 3 statements, nuking the proposal from
space, I find excessive. Yes, on the internet no one can hear you being
subtle, but the "MORE READABLE" and "NOTHING" were pretty darn
unequivocal, especially coming from the person who has absolute final
say on what enters his project.

I have been around a while so I take this as par for the course, and I
appreciate blunt feedback. I have had dance teachers tell me my "dancing
is shit", and sometimes that level of bluntness is needed, but that was
also from somebody I have worked with for years. Fabio has not been
around that long, and nothing about what Fabio did was crap, he carried
through on an idea that I asked him to explore and it did not work out.

So Fabio, keep going, thank you for patiently working through this
investigation and my takeaway is that we have successfully discovered
one way this mission to cleanup usage of goto in the CXL subsystem can
not proceed. Back to the drawing board.


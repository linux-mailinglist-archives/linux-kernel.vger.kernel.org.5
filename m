Return-Path: <linux-kernel+bounces-53994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFD384A8F1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82C381F27ED9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D44F60278;
	Mon,  5 Feb 2024 22:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K/ASEdAk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C569605BF;
	Mon,  5 Feb 2024 22:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707170572; cv=fail; b=jwx4kEeJEFnKreAH2ncIJyaVbhYDA3fDVPnFr28MfR7FBF7dkFdok8x5JXtoPL3IdGdo7Ormxyf/MlE7NYhnfCMP0/r/Ls+pPTnjFynzP4eCqGH9qUYxD4PQK2fgocivCzLl/71cJuYl+UxSDJRMDdGecbNXxxN99+/3yyfSchA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707170572; c=relaxed/simple;
	bh=gIrwgJZb7qmvz7siuh4HcErS6uyHlw5Eo++QQ6yVNIE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f/brpSeFNh2CbbUFs7w5sLssEwCfyQWER/ET8ABx/LS3zzTMOL20tzbXDjjnlibvUfg6L51OUpcJwYuZxi0ItQ7XihD1MQC+VEPZHYYr0bdPaJLb90bNikzbJVoM/NIVbcF2LdIXiWQLx0BCYRxydUTRmtKMBwvvFZ99xj/5mws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K/ASEdAk; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707170571; x=1738706571;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gIrwgJZb7qmvz7siuh4HcErS6uyHlw5Eo++QQ6yVNIE=;
  b=K/ASEdAkgy/qeOLl9M7aSvJzMc4MfhuaGDStdh8cld+sF3RRgsU8hX7c
   EIVrTEtA1gmkZ2dcRO4Koap4ccarmaL7oklRhg9uzOPStstwFSa839Uud
   PiH3vrTOmnaElgsmNrQmp5zE3DPIDgkbtnCgyIgSijIPHI+2LBzwUpQ48
   y7z8LxLkhvJdwAuUN2tNsu9Paut6OhM2O96OMl/2GN5qUvmrvg/NV7BZY
   BlB9i6qeEhp/aP11CymTA+WFemy0Mcv/2g9wEitvQy7RqRGisA4igbUWV
   8Iy83/+HADn8jH7ssR3EFS5ES5PmnhsvB4hUi4/0F6b8hx4pisML+8koO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="23095621"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="23095621"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 14:02:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="5443961"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2024 14:02:48 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 14:02:48 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 14:02:47 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 14:02:47 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 Feb 2024 14:02:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4NQNUcZ2f010mO7FzOrFQMMlj2Bo1wSoPqvD+empvDygYUE2IdGw7FqAfM0A6oNinPISPC2d8thzvm75kfHIFWNwniwKBA12ZqzJ9vmbfNvR22NJp8wP6wu85JvIUcyPo4AJHIF/7ai8xmpIIRtQRSZbxjCoAB4FVk/0EwVIMHEekZlqksK5OgvVDjSn69d2JWoDHUSbaf1nuDOKvFytDc9QwJM9PSAGm2jykwFx1vK9fuMQ9I2/f0bpaF7LhbaBl7/1OuVld7op0TXFtl4d5AUyK4z7S67+NHt3MW4I4p8t1KjBXCc0VwSrAcGDbuAG+Z6OPkA3LTd6ngnfO+fZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/4wNLT2+IqekGihQeqTz3HYlqQWoDPXGryGaxa+HkI=;
 b=M3ONuvhxFTQSYGP50wSggdNopYbro5Carr/EHcG4zmpbCSPWdza024YcoZ5rkYCuQkf+NipvnIUnWk5UBw2x+Ljo+OgVudHSZ/5gDLeIPm/x4jR18T6mWGYpZ31ieq3y5NTHV3TGzB37DfIXBdlW6SEu+mHsQV0Lj7E0hHtkF03/HjcwXUPBFEc9UdSerQ1uctkfDIFyKmCaGH1Y2PfabbpPEf2/gJdyHACqnHA18LgjbtBUeL3VRUlZ9mydDdC5NR/uYv0fcnYYHwSYF5OTSCv93bIZpdSm+k6kEg4ZSBEV2calSLABn/apkumZliMgx8BKdNU8UGw6VnUi9eD4sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB5626.namprd11.prod.outlook.com (2603:10b6:510:ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 22:02:45 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::9f17:e1f3:d6f0:3d59]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::9f17:e1f3:d6f0:3d59%4]) with mapi id 15.20.7249.035; Mon, 5 Feb 2024
 22:02:45 +0000
Date: Mon, 5 Feb 2024 14:02:42 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, "Fabio M. De Francesco"
	<fabio.maria.de.francesco@linux.intel.com>, Peter Zijlstra
	<peterz@infradead.org>, <linux-kernel@vger.kernel.org>
CC: <linux-cxl@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, "Fabio M. De Francesco"
	<fabio.maria.de.francesco@linux.intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: RE: [PATCH 1/2 v2] cleanup: Add cond_guard() to conditional guards
Message-ID: <65c15b025484f_3744792942a@iweiny-mobl.notmuch>
References: <20240205142613.23914-1-fabio.maria.de.francesco@linux.intel.com>
 <20240205142613.23914-2-fabio.maria.de.francesco@linux.intel.com>
 <65c130d7c4c52_4e7f5294d3@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <65c130d7c4c52_4e7f5294d3@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BYAPR11CA0055.namprd11.prod.outlook.com
 (2603:10b6:a03:80::32) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: c44461a6-a19f-4bcf-5ffa-08dc26962ee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /000mo9ujqBV1rZVm3In+WSDbe4D4cGfauMU0WuSXpzKeiRj/kWAdBE6h4JaBuDHjOE91Ss/fdFErHTUfGonqaBfEdmMlZFckUCT9V4xeOwu9BAfAu5WkBb00xM8WVY70h/i3NQ91CaULLgrfr2mrOikBmPYpPTCwswbXY8/Pj4TFQC74YPyGU/kTW/V9iKdKE2f93FbuZf2zcbjlVtjAHelpJQrJKOPHIwbS/1jIMu+unr4gp67Xhxtnxbm4673tERZiZVGVRKScfaxvKWpi1hdWmxvpChZ0fOduCIGfRuczQzn1svHjJ7OmcF9W9QFrc3+vd8QU3dTprIyE6mQQRb4XIk9ssBvycugbnwxxvVyj8DEVN1ixktguedlHlLzQaqdL5mVw+odaLH+i77T7E/IEjQ8AZobP+EahLK4T1py+tATf+Ib+lQzsDzDEO21xmaa55rBp7+FwWw2ug2Kuo5wvuyrOWeYiCMLrbmTtgPGkt0WorZfcZ1/MmotO6aVdHzuhDtujqCMsl4MADx5LEViYAbPNDLnY6hh3CjsB50=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(86362001)(6666004)(2906002)(26005)(6506007)(6512007)(9686003)(41300700001)(44832011)(83380400001)(82960400001)(316002)(6486002)(66556008)(66946007)(478600001)(66476007)(54906003)(8676002)(8936002)(5660300002)(110136005)(38100700002)(966005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m0hdJGtMG6PjRkUchRoY35u2WfGNM37O9FE2RemmH8haF9AKYBKnBEoypkvk?=
 =?us-ascii?Q?iu67rId73b6L3FcEjyCVwjKycKHjvqnDUfotE6ts/NjenU/p0x02jRnwtFQi?=
 =?us-ascii?Q?fjAr2rnBSXalS+YUkTwzg0oiS/b3wrvMr/lv2ljoiXDargttxPAf9l97ZlvW?=
 =?us-ascii?Q?+FbGRf5WJ2FquBR8iwBrltFoyi7cAUWA8BFcyKxpZ+Fh8zGOT0SQaZGmIHsL?=
 =?us-ascii?Q?CrXXCBM37aHBkissaZOPtt+R7Q7clEy6MXi1XtEPT563mBvhOtm/g7IcOvSr?=
 =?us-ascii?Q?wNefe1r535GH0bp/FTTRLICo4ETc+K4wOWCM3H22eyZtoch8lsa4SrjtK3mu?=
 =?us-ascii?Q?sOA2C6+waFsQOqqtrsFpdFv29JQN7C2yQYy+DkL5aXDLB3JqdC6ObYyZ0J3x?=
 =?us-ascii?Q?7glA/yraJtAWm7ZyvU0P635wpf0y2NVdN1UEWN943URdLK8IYAAhWbVxl4sS?=
 =?us-ascii?Q?h8+Zt/fN/zVYGY2rhlaywuewXMWtidgkPR9Q+B0b56W1l7CBx1YnXW1Qzbw0?=
 =?us-ascii?Q?ytBoouc/fyVOt9cSjQn1v6Q2G779KVtIVTxgjYny7u8SDu6bT0S3GtGkc5uK?=
 =?us-ascii?Q?yagan9kaRICcoJAfncYj9HBiwrCehHkC0U9d0xdA0o0EFTpk6+SJ8zlk0hKy?=
 =?us-ascii?Q?BkkQHc1nLOJkTZNzVR/MFYZdGb8ZzlYWl69pos0w2cMryKIqxb539ja5wIqV?=
 =?us-ascii?Q?QrBWf5wV+BsghbP9cm7nDus4Vp8KW7KJRpyYK3RPHlKD5S0C0BiOJBmx7oJd?=
 =?us-ascii?Q?FhjU/G8o+FWdv1Rs/Bv13jKL3aVP99GaWg70QnxRfkNFKTiWuxXUv7xeO8Vu?=
 =?us-ascii?Q?U53XmVINa7+PP3dDM+5eRGM+bMMWb9h0Ch7jn+hT884h5jlyO9OwBL52/lJ/?=
 =?us-ascii?Q?c2X81XYcvDoeYzz0O9gFinxLTlxrjQ887Gw+/dA/FeiuWZILngT0flXIN/+K?=
 =?us-ascii?Q?ySO5Sj6a6k1Yv7Dhfvd0DKTxioqHo5768CMh5djKLZ1KcemmfAEWYkQgu3+x?=
 =?us-ascii?Q?6jOjf4Ue9cQdBaB5Fsvugp4xKXSqcVNoy2iPyNQQfa0LNA9V0R8gJoIRpl1i?=
 =?us-ascii?Q?81L/ePgn5aRgpeVZjKu+IY5VhkYYCJ4ADHLv33qYJubmq9yfSnoZUjcAEAW7?=
 =?us-ascii?Q?0gTSIaQAv/yP2zkn2uFaiEdZq217k5G+rPHazjmKvTUq5ZAqsQTH137gzCKa?=
 =?us-ascii?Q?2Grk5t4hpQuti01e8swxGao8vDoGpxqHf0ZcrqD6i+RLj/OPuaOhfsxUQlkD?=
 =?us-ascii?Q?CL+wsajE/zc9WRhUomvags6VESrbYLA4vw+C3WDwHHK8eAAy7mmp0s1uzIHc?=
 =?us-ascii?Q?jAD0S8koPI7wMaofUB8Zz8tmjSJMFDQj6MR5LQzZSq5rijbyubqQ+ENLv4v0?=
 =?us-ascii?Q?dK1Rc0eLEIzCafk5xE6y+tjULNNoOVJCRGZfKGgCmNylMywfq1td+yQX3Hnp?=
 =?us-ascii?Q?+wLpnQc3YKFKFTnSCbvPj7LZpEjtK9vDe3j2qLbZj25Rwv0PLQTg+3YdI3qM?=
 =?us-ascii?Q?jKlcLOBRfQX5o1Mt1GGZ0hb1dsdK/gDga5P+aCxxWmMP4r26eiJWvkuORO1/?=
 =?us-ascii?Q?h8sq4PkI4lFPaPnbIPu/023txN04y+qJQlCgQhyG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c44461a6-a19f-4bcf-5ffa-08dc26962ee0
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 22:02:45.4852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ck0A8Ew0kg836atBSvUsYNkX41ymIwedsI/C96hfpaHGfEQkuFsNR5wwh6sM1mI8y2G9gIAu5DVWbPu609IiaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5626
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Fabio M. De Francesco wrote:
> > Add cond_guard() macro to conditional guards.
> > 
> > cond_guard() is a guard to be used with the conditional variants of locks,
> > like down_read_trylock() or mutex_lock_interruptible().
> > 
> > It takes a statement (or more statements in a block) that is passed to its
> > second argument. That statement (or block) is executed if waiting for a
> > lock is interrupted or if a _trylock() fails in case of contention.
> > 
> > Usage example:
> > 
> > 	cond_guard(rwsem_read_try, { printk(...); return 0; }, &semaphore);
> > 
> > Consistently with the other guards, locks are unlocked at the exit of the
> > scope where cond_guard() is called.
> > 
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>
> > ---
> >  include/linux/cleanup.h | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
> > index c2d09bc4f976..88af56600325 100644
> > --- a/include/linux/cleanup.h
> > +++ b/include/linux/cleanup.h
> > @@ -134,6 +134,16 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
> >   *	an anonymous instance of the (guard) class, not recommended for
> >   *	conditional locks.
> >   *
> > + * cond_guard(name, fail, args...):
> > + *	a guard to be used with the conditional variants of locks, like
> > + *	down_read_trylock() or mutex_lock_interruptible. 'fail' are one or more
> > + *	statements that are executed when waiting for a lock is interrupted or
> > + *	when a _trylock() fails in case of contention.
> > + *
> > + *	Example:
> > + *
> > + *		cond_guard(rwsem_read_try, { printk(...); return 0; }, &semaphore);
> 
> That _fail argument likely needs to be a statement expression for the
> multi-statement case.

You mean ({ ... }) as discussed here?

https://lore.kernel.org/all/65c1578c76def_37447929456@iweiny-mobl.notmuch/

> 
> > + *
> >   * scoped_guard (name, args...) { }:
> >   *	similar to CLASS(name, scope)(args), except the variable (with the
> >   *	explicit name 'scope') is declard in a for-loop such that its scope is
> > @@ -165,6 +175,10 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
> >  
> >  #define __guard_ptr(_name) class_##_name##_lock_ptr
> >  
> > +#define cond_guard(_name, _fail, args...) \
> > +	CLASS(_name, scope)(args); \
> > +	if (!__guard_ptr(_name)(&scope)) _fail
> 
> No, as I stated before this is broken for usages of:
> 
>     if () cond_guard() else if ()
> 
> The 'else' in the definition is critical, this builds for me (untested):

I did not test Fabios work directly but I don't understand this example.
It seems like your suggestion does nothing useful.  The cond_guard()
becomes a single statement like...

	if ()
		cond_guard();
	else ...

.. And can't protect anything.  NOTE From my understanding of
cond_guard() as defined, the ';' must be used as part of cond_guard() and
should complete the internal macro 'if' statement.

I think this would work:

	if () {
		cond_guard();
		... do locked stuff ...
	} else ...

> 
> diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
> index 88af56600325..665407498781 100644
> --- a/include/linux/cleanup.h
> +++ b/include/linux/cleanup.h
> @@ -142,7 +142,7 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
>   *
>   *	Example:
>   *
> - *		cond_guard(rwsem_read_try, { printk(...); return 0; }, &semaphore);
> + *		cond_guard(rwsem_read_try, ({ printk(...); return 0; }), &semaphore);
>   *
>   * scoped_guard (name, args...) { }:
>   *	similar to CLASS(name, scope)(args), except the variable (with the
> @@ -177,7 +177,8 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
>  
>  #define cond_guard(_name, _fail, args...) \
>  	CLASS(_name, scope)(args); \
> -	if (!__guard_ptr(_name)(&scope)) _fail
> +	if (!__guard_ptr(_name)(&scope)) _fail; \

Building on what I found for scoped_cond_guard() this should be

> +	if (!__guard_ptr(_name)(&scope)) { _fail; }

And drop the else.  The else needs to clearly be part of an outside if in
your example.

Ira

> +	else
>  
>  #define scoped_guard(_name, args...)					\
>  	for (CLASS(_name, scope)(args),					\


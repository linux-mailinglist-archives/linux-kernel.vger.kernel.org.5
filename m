Return-Path: <linux-kernel+bounces-90212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 626FA86FC02
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30E81F22B97
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101D919472;
	Mon,  4 Mar 2024 08:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VchoKE0R"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3EF17731
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 08:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709541446; cv=fail; b=frULQ6w/lA6OR0YLQZga3MdGZEDr8uMG3DzXOcEeliwR0MrReSDkgk4yeoEkrxO17LvDmtEX/ZOB5xdpXTy8s0NfJBGDHomg30ucmIn4xDmbwM+aQ4NAAPtI+f4BZ2jPu0bEZ50riCCYJij7ZQmSgFqMxIgtJy3W2RmypFXVn8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709541446; c=relaxed/simple;
	bh=1dU+DZNzj2hxIVC/aag9K2mfyHK4rXLdqCCdRzJHEjk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FNIU+NTPSdH8jBYVaogLDK1MOpqU5jtGHK4w+XQXI/VQ/Scv9wP4AeCYypzndiNZWcKWLfbPN8fPf4UmMk5q0DNWrA+Oo+CASY6SbPUKGtH1mzV9mD3wdz4OTAXoFx5HrTD82laq2ovtEHPzv8mZUksWDtU1xIFk+nTxxwFiWkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VchoKE0R; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709541444; x=1741077444;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=1dU+DZNzj2hxIVC/aag9K2mfyHK4rXLdqCCdRzJHEjk=;
  b=VchoKE0R95PTW61ZKWTUEWD3sC7uFPI4Y8DLcyHW5J4rnTQod1M5kciD
   VNplxEC3WIPwVS/WCN82STsA93DiBATd+wUpLIKSGFaktF8d6ezrjvElQ
   TA4VeK7mcSRUfsoxhfjBbBBkEVisBon188RQEfS3y7JtnwOt19QWER1dG
   vPc7adDzoJEC+sb0QtDf6xOOzGvk3Iw+NjGmkFeR3xTMTHleS7fVNsOyQ
   dU5p2hoIQHMUZVFQpQ9l11cvnGAnlN8ebycCK54rZO6HWtXSWlpY0jBVq
   /G4URggH+ZUrXz9Zi9+GWIJiTg+Ap632OjcFe1NzgiIoiuWSFOMV963+0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="3884022"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="3884022"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 00:37:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="13479837"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2024 00:37:23 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 00:37:22 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 00:37:22 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Mar 2024 00:37:22 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 4 Mar 2024 00:37:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dH5RnbR7mVsELBjMrumAPibUaGF/Je3ooNBdM2EWIgcgL7ku6tJb+YUVUMXoeIsqt2y6bU4sertFwO4qy9M9GJtfnz6bYmFPz+s73ksKmsjQSBdxDGY4ZWFbnM/kz/gY7oDsAoy3u+Ju/x2oBDeV1L+1MoHXJJ3ZlSxQaaqIFEeysBSjCiQV7z8Uvjs+YcZG4e/QUUHWxdzbY7npwjyua44oQYkyuEZqGfOsLpF/5F7Kw8xIkiG/OES8ImVKPBYUFyUsWveVC0c6dj6qIgeqZmAU1LC+GZ4441S/hLhZv9GarWggfh3Al8cZIv8SWdwDMVsMw1UPh21vNuOA7JCfxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fb5F4+r7HA0WeyGOauSclOleuspFep7l2lY74PSZ9tE=;
 b=WifU8NqzX2XewkLJoQ3kPGLImUNj9H6HYby+vBK5jJbNkOI7oOtgwNONtJEhA1/zo6swVfe9zsQzOpGfGmhPmGm+CuO5h6IE+U6M+ewOQYPwWEnjz4W/M3bs2oIW6MK+2TqkcCgzpf/78CICXelm2NStuY4nmP4EaMEllyWvSg5efPTskopINLH5v1uRp+uqVhsvrfpImaGVkCmwfaEqWitZPLHMhSVCfKFfQ2Sh/BCqmMs77PCUCsEesA7pBSLRWlpc9tyc+rdURJRhdzhv6MlWqgV4BBkv5GwUERdT5o+853Fqy3pSjn7gcCRNm+saSiFimd2NhLNJcYNBqTsJ5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by BL1PR11MB6003.namprd11.prod.outlook.com (2603:10b6:208:387::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Mon, 4 Mar
 2024 08:37:20 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::7118:c3d4:7001:cf9d]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::7118:c3d4:7001:cf9d%5]) with mapi id 15.20.7362.019; Mon, 4 Mar 2024
 08:37:20 +0000
Date: Mon, 4 Mar 2024 16:30:31 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: lkp <lkp@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "oe-kbuild-all@lists.linux.dev"
	<oe-kbuild-all@lists.linux.dev>
Subject: Re: drivers/opp/debugfs.c:48:54: warning: '%d' directive output may
 be truncated writing between 1 and 11 bytes into a region of size 8
Message-ID: <ZeWGpyXXZBeYjnGW@yujie-X299>
References: <202402141313.81ltVF5g-lkp@intel.com>
 <20240214055836.c5i3zmkhdllldwon@vireshk-i7>
 <b41c6cdb78c96d5f4a909fc13c253ef0d8576c86.camel@intel.com>
 <20240304065411.w34vbaeg2rlq6z5k@vireshk-i7>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240304065411.w34vbaeg2rlq6z5k@vireshk-i7>
X-ClientProxiedBy: SG2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:3:18::20) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|BL1PR11MB6003:EE_
X-MS-Office365-Filtering-Correlation-Id: ed163f1f-f641-4899-638a-08dc3c264e43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kgbyMExlkPRPS37l8ipCXiQWkGwEiB0vu5lGl3Lo7KVVl3PC5HVb7TINs+R0Tm298cQCO9vYH3UQv9mD2vS4o0K8+dMC8/i2dYbovN9z+SlGS5NkFpklPGTwdQvDh/CWGsiJ6CEf7jhSnwFevgGG0ffV5bwyjpYrNKisOao+rM4zeY6u0xXReWfeXMV2efruPTqysXSwV76kSy8VZ3oyXmTmoJqBPWd5wYpVtLdrLaJUY94jWf8vxRn2/2fRo2/7zL2fU4IbtHnFHyaSQ0lXVEd51aocAOAWEzEJSe+ApaPQOMvlsucV7pdYUpLuynksRO/kgcbox5KOgJ1JMTdygvdhO88ykVvV+atbWc8YdpIQQkBC5FNP9F//PEke65e9QYRi4X8AD9ypXomRFAsDXCdSZEuB4iPdSbGySVg0yqVISXbvkf35XvTNMfmJZymNcXcij9BAsddtWAW1jsHvJ4oftms6dahDCrHERxwC+Ig/+EOqEdSTntB93EjS7Q4ZxdX/NEnJUaTIQ04w9Go8eUpYGxpckhi43p0MxIrkQGfGAw9x50XMFMwtVizviATogxFy8tQO5tMwXQQRtIwyLxWBL5g504AFZUAoEItwomx1H2JGmGXFneqigUHX+me2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?G4Yj6emP1uti8wkDYZRphT8ZQ/vVlA5jcp3ht70UJNMCbgpnbhw2kiq5Fs?=
 =?iso-8859-1?Q?SLto1Q3TcdFjdg08YfMqwbLj4+7uR+vM+q24SnLrAXXmUJfe/WOh5S+iz5?=
 =?iso-8859-1?Q?kL1Yx2SGS0sKpN2KYkGqFCGczOahzkxA+lyVibHcZtC6i3lLWGd06aHptt?=
 =?iso-8859-1?Q?HYGNepgK8RtWDbAsYnLOVrPO1uhljQAU1rTTsCB242kTysm3puPV+nlbrW?=
 =?iso-8859-1?Q?WxWVzQEQQqsiNNJzj1j8HZ9dCvDbtDYKlRFA3g4a78uJi7Psgmv7Dngb/S?=
 =?iso-8859-1?Q?Ylt8q/qUQ124cSrxHDzBpvJQog86UWNpLOn62ODXM64WUZ3cRrXr2H6p9E?=
 =?iso-8859-1?Q?Pcu4vsucJL3V+HaS4T3xwlXcI8+X0Gg38G78NYkQTeYeURydfUFKF8IYRM?=
 =?iso-8859-1?Q?HkCRvEMFOxubza/hH81KLeKz5EcS2Pq667Y/vFWmEWnTgSSG9PDEFVI4Kv?=
 =?iso-8859-1?Q?qDJtYGOsndDjZ9MjVliG7IoWadHfuAHsAgGOTX2DC1s6fIZBW2p3TFmK2d?=
 =?iso-8859-1?Q?QbKFJy9Q0oWmNgnthpKGOr4QX9OLPKgZGk9cOBYEoU3IpTzme/IK1A8k8z?=
 =?iso-8859-1?Q?8OihNIPqt/omkDinOSQSBZB6Z+J1IEKgk5OL/F7GYBxwqs93S4bsV3YbDp?=
 =?iso-8859-1?Q?Jxiaa17LrgjbuIZsMZo2VKjgLSLf6+73jVS9DLcxXl0wHEegZ9+n3IXBs0?=
 =?iso-8859-1?Q?GecPElAkXmautxtMtuzcaaUtqJyEHClpWHHw/SFSPqYssgJF4miXMRVuZK?=
 =?iso-8859-1?Q?5JjX/dB21aevfJ7YQoizE2UuV+eZL73IfTCC0tB55AX+qhP67w1f+AMkG5?=
 =?iso-8859-1?Q?8uRbO5hSQ/uPQAyBji7NknSXkcDO3GiAOR4RB7a9iXGip6eDpEOEia6IEa?=
 =?iso-8859-1?Q?RwNLjKpWs+ZcBuhd3UPOY/vuMXfdzvFd/DwPoyECFGlVbUXztPwCEFkjAv?=
 =?iso-8859-1?Q?BYcwrXJJxTYFo6tnZqn9wlauFAduA+vRiJcj2rhq7Usz+/D91+n1Rf7iL/?=
 =?iso-8859-1?Q?P7sv5Rbps+YjHG0+ruIh73Nx82PPuuu8GS5iXQxUxG4GIp04kBIZjffh7B?=
 =?iso-8859-1?Q?LEmNV8i0ngkaj3LBQfYCijYs8gHadIi9UzARZGnvxb31f4yXTFJnwHXu6b?=
 =?iso-8859-1?Q?Q2d0T/O2iYqkHrPB6VHRK1adO5YpDppuOEIO2kJ7iXP6xg3UloGGOsI17O?=
 =?iso-8859-1?Q?Do9bz9wqJ8hoZyyS9eTIU6qgoaLxpUPQ0rG4hD+AZU+112LFBy/Z73x5fr?=
 =?iso-8859-1?Q?qg/rUKjh4SreURiSDGv3KfC6ADNNysY1Eis89ui+R2+YHEUq289lgeWunW?=
 =?iso-8859-1?Q?fn7uMsufyj1lv6sTem4lxBvsQxY1Ms0OejMiC9oi3oQVwM6cbBYkoZbS5F?=
 =?iso-8859-1?Q?v8q38iW/GYUWaY8IjsobT7f46Wr5pIVeu/wisJqqMsaDRlXvInk0ikyyLc?=
 =?iso-8859-1?Q?25mBcmJXDxebJ6rB5AATlWuDwnlC/Fdu+Tajh1+eDGs524fFfG6Xffsjri?=
 =?iso-8859-1?Q?UnmAgsmm7fo/rOkHN/527XwusIws/Ha2hh0wXE+l/XKqOQ7FwKjJj5UEyG?=
 =?iso-8859-1?Q?PlTtvheCmGIWexbjlusAnqxlOxXB+3cuZK/e37pIhF+f37aPKndkrExOzA?=
 =?iso-8859-1?Q?SY8kkW13vnN6U1iI5L2C3j7lk7NokV/k8w?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed163f1f-f641-4899-638a-08dc3c264e43
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 08:37:20.2667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQ7ZpyRsG26E2baADjuo6Km0HRB4dRGAFkbPw7KoEgzLM8eWivxVmTdJS0WoKvnhLN5u2JrQHSz2ip2q6ACVpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6003
X-OriginatorOrg: intel.com

On Mon, Mar 04, 2024 at 12:24:11PM +0530, Viresh Kumar wrote:
> On 21-02-24, 06:01, Liu, Yujie wrote:
> > Hi Viresh,
> > 
> > On Wed, 2024-02-14 at 11:28 +0530, Viresh Kumar wrote:
> > > On 14-02-24, 13:43, kernel test robot wrote:
> > > > Hi Viresh,
> > > > 
> > > > FYI, the error/warning still remains.
> > > > 
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > > head:   7e90b5c295ec1e47c8ad865429f046970c549a66
> > > > commit: 46f48aca2e5aef3f430e95d1a5fb68227ec8ec85 OPP: Fix missing debugfs supply directory for OPPs
> > > > date:   5 years ago
> > > > config: x86_64-buildonly-randconfig-001-20231012 (https://download.01.org/0day-ci/archive/20240214/202402141313.81ltVF5g-lkp@intel.com/config)
> > > > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240214/202402141313.81ltVF5g-lkp@intel.com/reproduce)
> > > > 
> > > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > > the same patch/commit), kindly add following tags
> > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > Closes: https://lore.kernel.org/oe-kbuild-all/202402141313.81ltVF5g-lkp@intel.com/
> > > 
> > > I have informed this earlier too, this report is incorrect and applies
> > > to a very old commit.
> > 
> > Really sorry for not responding timely to the questions in the
> > following reports:
> > 
> > [1] https://lore.kernel.org/all/202311061847.BOtfUmbQ-lkp@intel.com/
> > [2] https://lore.kernel.org/all/202312170608.s9xI4TQb-lkp@intel.com/
> > 
> > We see that this still happens on the latest mainline rc regardless of
> > x86_64 or arm64 arch. Please note that this is a "W=1" warning. In our
> > tests, it can be reproduced with gcc-12 and gcc-13, but not with other
> > versions of gcc.
> 
> Okay, I have a different version of gcc. Can you see if this change fixes it or
> not ?

This fixes the warning for "supply-%d". Seems there are other remaining
warnings as shown below. Would you like to take a look as well?

  CC      drivers/opp/debugfs.o
drivers/opp/debugfs.c: In function 'bw_name_read':
drivers/opp/debugfs.c:43:42: error: '%.62s' directive argument is null [-Werror=format-overflow=]
   43 |         i = scnprintf(buf, sizeof(buf), "%.62s\n", icc_get_name(path));
      |                                          ^~~~~
drivers/opp/debugfs.c: In function 'opp_debug_create_one':
drivers/opp/debugfs.c:90:55: error: '%d' directive output may be truncated writing between 1 and 11 bytes into a region of size 4 [-Werror=format-truncation=]
   90 |                 snprintf(name, sizeof(name), "rate_hz_%d", i);
      |                                                       ^~
In function 'opp_debug_create_clks',
    inlined from 'opp_debug_create_one' at drivers/opp/debugfs.c:162:2:
drivers/opp/debugfs.c:90:46: note: directive argument in the range [-2147483644, 2147483646]
   90 |                 snprintf(name, sizeof(name), "rate_hz_%d", i);
      |                                              ^~~~~~~~~~~~
drivers/opp/debugfs.c:90:17: note: 'snprintf' output between 10 and 20 bytes into a destination of size 12
   90 |                 snprintf(name, sizeof(name), "rate_hz_%d", i);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Best Regards,
Yujie

> 
> diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
> index ec030b19164a..986c08e18d05 100644
> --- a/drivers/opp/debugfs.c
> +++ b/drivers/opp/debugfs.c
> @@ -100,7 +100,7 @@ static void opp_debug_create_supplies(struct dev_pm_opp *opp,
>         int i;
> 
>         for (i = 0; i < opp_table->regulator_count; i++) {
> -               char name[15];
> +               char name[19];
> 
>                 snprintf(name, sizeof(name), "supply-%d", i);
> 
> -- 
> viresh


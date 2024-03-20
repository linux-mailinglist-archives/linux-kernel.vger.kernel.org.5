Return-Path: <linux-kernel+bounces-109372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52567881832
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D52191F235BB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1653185926;
	Wed, 20 Mar 2024 19:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M1PcAfVb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2793869DF4;
	Wed, 20 Mar 2024 19:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710964728; cv=fail; b=JrE0LnGym/vRm7xe1at0+9NeSIfofQYV3kadjsatlPPhvF3glIB5VpTvbfacN19EeygcSRowUxrenlyX8RjFvfmxWdcj7+BGTPqQwzGFrKcj0zUjw8l01xq4m6tEcFe5E5OUOdDxP2huqMpiwllO1rQmLMpqESseMnSiuGweyhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710964728; c=relaxed/simple;
	bh=+tWpOOyxLnRejN5AfkZjhuzWqu2EaYr2eAuZ4NePc9A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X8VjUobNpV0DA8OA9pnCWpZv3KxfO9OBEHopKqodTkrHWtzWyzd2ICzZ9hFvdSTmBQCrZcOhzexmg6xHTZ/rHePC1InSPZxQ76zxYBAm8eeXGQSNlOSyXWE/Y/LdOmfCejBDghQ7SnrfTNNIWQ+vovtoqgw6VVJA5Xt/rcTUqak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M1PcAfVb; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710964726; x=1742500726;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+tWpOOyxLnRejN5AfkZjhuzWqu2EaYr2eAuZ4NePc9A=;
  b=M1PcAfVbkvH9Lqv7ZxMKYNFVZgBOtaLneUqVXou6bAFK1BLi43pMLNzu
   OvMyHkeoXx+lQtnjmRH/u0cLiKo6OocaRVM0WdAqcaMZoxm2oimYIZw52
   YPKDMnm7H9epzU5VxXDFd1wZx+QEMkwnaTsbl2TEJJpQgINg01I911tPP
   gI/Q82kbHxKooESdfdyWj9HevDXgLBr9fwAQA96r5KKAqgRn9OcYvEu5I
   8c46eaLW1+V+t4ipGCBvSb3TKGrALm+mHbFbS0uiovCZBS67IYy/netcG
   fF2mH1dVLtbprcFWAPvC9VZhSBdfeZh52MfkqCQDM2QDh7OGUteRUXtPj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="9686607"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="9686607"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 12:58:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="37374873"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Mar 2024 12:58:45 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 12:58:44 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 12:58:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Mar 2024 12:58:44 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Mar 2024 12:58:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLAG8TedCNLTl2FGDxJXXRPME2BrYPnRZtgik4C7xBzUNLSp192XIV68VbWhtk4TUGBA70RFe27kmpwBWzOaI/TqT/cEuk/CdWi/aD+pJyvp8L+3TFaHzzWnNLX+eEqI0/T4CtGLCu0/pyCD7yzCHfIXTSeLFqavhq/v2RlyeVWRUSPYujqxxwnwMk+oITpDCGWOg4AuA5f7Z6zB9jkAT2u2NIegcnzYMcD/56EaG47FF/Oxv9Qwn9ioSxFhl8Gtt1zYqjXBJ271xykonAjblKAk+tbdkP7JYnx3X0eC8mOScdIIgtfSPeCnhYIg7FZMZnp3OA6VL6ncxGLXlpcmhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Il8zg5TbzAru6/a44bKMNZA4HG6sqHntTSMymH/+bY=;
 b=nHZOYswmoAgBlnJGY1yyurDMKKWroCnpWGjy1D/NRc9F8mTc0yN+aUAbhWYtiqdFnh7f1coak5rpNxOnsaaqBTlh+zoG6o9sAUVAZEOVKLW9PnCce6GglKlgXOFyqFVhYTvepFbcqPMiE/FoC6AWXhZ28A8fumZsTaorbGSFK0zukq5RYvRR3F5IV33W6k9EdNUqimoYlKOXaCK+KlCCXHzn5qYwej3AjpnOD3JpCfgB625+2hm3323R9BObES21BUyw2hv2R68CAiNDU75BM+vUpSdZtw72LjT0jM9E2TX2AYR8brWSBXOVLFV0Mz8kFDP+K5kpm+dYTrmJ+H7Mnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5103.namprd11.prod.outlook.com (2603:10b6:a03:2d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12; Wed, 20 Mar
 2024 19:58:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.010; Wed, 20 Mar 2024
 19:58:41 +0000
Date: Wed, 20 Mar 2024 12:58:38 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Arnd Bergmann <arnd@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: Arnd Bergmann <arnd@arndb.de>, Len Brown <lenb@kernel.org>, James Morse
	<james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, Borislav Petkov
	<bp@alien8.de>, Avadhut Naik <Avadhut.Naik@amd.com>, Shuai Xue
	<xueshuai@linux.alibaba.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] acpi: EINJ: mark remove callback as non-__exit
Message-ID: <65fb3fee96ec7_aa222949b@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240320180302.143707-1-arnd@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240320180302.143707-1-arnd@kernel.org>
X-ClientProxiedBy: MW4PR03CA0124.namprd03.prod.outlook.com
 (2603:10b6:303:8c::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5103:EE_
X-MS-Office365-Filtering-Correlation-Id: 53e4d2ff-5be6-4ff0-ceca-08dc49182424
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RCN3uhBLHVr2GK3xUedrEbaJzkANOUn1kfiDwGR8aMq1NJ4Tv+n9EnyxxZ7fBElOyZC/0TxZe0YosVUey30mrThi9Ls5NogAq2TLpdk7xSW8dytpTr4Rvz+oVub0aPn+t+ieW9yVy53o9QmBCQ0Ti9uCuY8hneQnIoEQNfgHBr5IkiIcfY51INFEgfCjMWtnCBgAi4v5az7JAq4gZsX2ODwiTLN5tNC4lI0UbER78sqgtkTBhHG64D52xLNuVj4ECsP8dmLOFu5XX2O1BdKinbTIUyeVP6RVRpcy7f3jMi4HF2+xY/7Cq6p68/BkzNjnbCqdWkrkQ0yea6HPCAQaUUZbyWp225o34lQaYSQ7MnTABqYADqHfrFFUfDwL5CffdW7ztKnOiAzKZc9WTqCHvp+95CXw/VWX3AVAeK9IfO9oD0WYQJxAcF/TqM0iGutV8PA5fs7zBNpr+ooq46mTvEqcV6m7d/b54czDw1B9pvkW9WhczT30zhg39MNDaWWViDPVvNSUJ21eM+slN0td0wRQhTEwPyZtn3mSfVqzVHhFWvBvyPDB5+wm1nk0HRWBKosg4F6Az19wwJVKMublQWWHZJHQiaqdal4IhFzX0beMPEtSWzX16B0enn2Q7Ya8aLgCs2yla6uOCCz46MdXEcngHtjQpm1PwV4j4Xcej7w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sBApVTIMjb9SRp4HWll00t1XoxsyiKTqe9s80suHZ1ARGpUqHn2IPG5Syfrq?=
 =?us-ascii?Q?xCK8qfnM3jdJ4k7xlJNT0qC28GuMDCJ9rU1IjkXANRThWkMJh6Ov+9CyqdDP?=
 =?us-ascii?Q?vDr8l35YQZrP4/D2Vqx6g3opPaP4YfXHuhokvDqvwDC/XJpvVOptVSsv6sgP?=
 =?us-ascii?Q?63Clj1wFTDPj5z3HqSPaZVPqgdARMCV2ehSAbBpBWbMTzB1d4xl/gsJ5sfNT?=
 =?us-ascii?Q?cVqEQdJanVfeHsRjCjMyiqjEJJT1GSGUVU24zeETb6ZITQSxqwebUGUmsEAb?=
 =?us-ascii?Q?8aCiTV+G7lYgm0uwrvtgbyRLY8EOXI/am/rKaE+zSBW3cVKw38enSTOelJ2a?=
 =?us-ascii?Q?dcz7sZnpFUWmR6phwKsi+EPKqhtOWGdnwJbmGVjYZgCJmlwF11fRT3RRSY8z?=
 =?us-ascii?Q?7Wt6hyL0QpUexd+hbe8R2ydstsMV3gGh4Q93pMdILJ2el0sDz9iXzL2soXQi?=
 =?us-ascii?Q?EHvBdZDQKYqSXOxms8OIPRWfM/UWRC/LsnA9XeHVj8KuAo9mop1/NyCL7Sfq?=
 =?us-ascii?Q?zVIg/6hZ4QTGJqbuWt8opYscjP/UKUghoSuZnATzb2OcD3Jegt+vLMRSUfq5?=
 =?us-ascii?Q?hKbtGb9PSLsz7NWvnbmJ8E1zzDBEH/f3mDApqXRT/GMQ8y6euLcjv6zuE/ax?=
 =?us-ascii?Q?5ihsB3hNtt6uA0g6g4PeogQx+p3Q2w9nbuiJVmVZxpDCpDJro3GV33o0tVKX?=
 =?us-ascii?Q?N62e4ot2bAKd6YzfZJiFKa2MEYSaq3azcKmDVkZmRhsm4YSAZCc9QAsWLMg2?=
 =?us-ascii?Q?mdKnYNYOaA4guLNAdUMmlAD377UQ7NCCGFBBsnUq2MGhY2OdqWpBZ5uzBTw9?=
 =?us-ascii?Q?uMrnul9OdG42gemEsodCMNaWaywID8ZOCm5+b30smS26P94WY5D5jmorMD7g?=
 =?us-ascii?Q?XFEUomkjh8Kqg5d3QV805DATkMZBQrEyytpcGoya/okv675yjD8orXQUsjlE?=
 =?us-ascii?Q?yHKCIJB2t83TW7aUJs+k2mGUrtYZtLnZyM6rEOKK4Bfnh8+P/6Dx+xz0cz5q?=
 =?us-ascii?Q?iyUS765kiHcV9nP+Pd2xbXq8OYx3jpuFnnvDNkOp7r1MUNtxaIYIZckeruE4?=
 =?us-ascii?Q?3exVCM6P5wAsP5pPCw2eEvvV1JMFWpmCnr9JpbT+mabpmPmLMmZyIuqgkuEq?=
 =?us-ascii?Q?/+MFEb0FmhRBjyqqEN3Z6xFX/seTcYYXAtZusxs7LBQTNiGS8MoHtFOEXGPx?=
 =?us-ascii?Q?bvwxXKTvPBAm37vcHzLnXnakPetokN8ZAjdU30oQ4rJ0bz+68X10vlAXOulU?=
 =?us-ascii?Q?WRByMJmfsTMcgsaygSXcJU91tmLTwJv7IAV2MWcXeM6WctsusaJe9zKDxrn7?=
 =?us-ascii?Q?NGn30uIlct+rFd0n1nxi1KZ+pz/cgVJcQsojhdhkuTkgqwUoJ3ZFzTzFc22T?=
 =?us-ascii?Q?77HNkC2bqcJ+pY5GdGG9UfSY5+V8x2ILwoj/FT4OzQvxN4FcIJcswOu6V3Ut?=
 =?us-ascii?Q?fuhyAYOyFRmvpL0hycjOs7sSPooUyCKMqlQ0rPYFiv1dDOv2Sz82yuC02g7S?=
 =?us-ascii?Q?W3a3tdOBYVDkw4bpOndg9evNFn8gi+eVGJ8hMxOnlv2BhPj2+F1Jgp+6G9c6?=
 =?us-ascii?Q?SmizPijtFksHFs9lynSJKXE+R2rRVettzP35RH/NoNlZhbNXwoyHMKAqFBUx?=
 =?us-ascii?Q?TA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e4d2ff-5be6-4ff0-ceca-08dc49182424
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 19:58:41.5607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WcqJXtO8lnMfclXPLs09KwFHbnsyf6m0LeUFwbjavLCFxIQq8qBKEyte3ozihaUuYWVQUIxIuc9mv4ao0XSxi7N4xJmn45SDtD5q+my7cRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5103
X-OriginatorOrg: intel.com

Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The remove callback of a device is called whenever it is unbound,
> which may happen during runtime e.g. through sysfs, so this is not
> allowed to be dropped from the binary:
> 
> WARNING: modpost: vmlinux: section mismatch in reference: einj_driver+0x8 (section: .data) -> einj_remove (section: .exit.text)
> ERROR: modpost: Section mismatches detected.
> 
> Remove that annotation.

Looks good, not sure why the build robots missed this while this was
sitting in -next. Yes, this was a side effect of reusing the former
einj_exit() as the device remove callback.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Rafael, can you pick this up?


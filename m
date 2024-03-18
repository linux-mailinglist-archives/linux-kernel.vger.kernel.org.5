Return-Path: <linux-kernel+bounces-106702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F1D87F226
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64E2B1C210C1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D669C59140;
	Mon, 18 Mar 2024 21:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="STRZuGMY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871EC43AA3;
	Mon, 18 Mar 2024 21:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710797420; cv=fail; b=kGy8J0aqG/dBmpOrgwyJcjrxs3xOCthyi/ShS529nkF9XcaSfMx1o+lTESA+jkPxc2jUdGjSJwu8ISoGnH4UAl/N7cdJ9sKrAIaNi3jE4tvQMYB/N37hBirOKbYPUJkU392W5P+HuXu4dmKl2Zxkh9L9mI3/ShVjf6yuDeknS8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710797420; c=relaxed/simple;
	bh=XGxuNIZ2BdZhhPzlA9EQqBTQ+qqOzNHLf2P6P9C0LoY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BI07z7MRCev22xU3PKniihsTdNfb62Xn5e4tycDdNaAdDppFrHv60D/0iBZVM6G7GGywTaXOIsvs2iqpYvNzjf+ySoQDLAmfpWhr8zJIKefP6klzCaVjrqpjkJQRYgQ7PbqgpE2bJZgdIi4z/U7iz4T3d5YYtSUEZNUUlF/1Fnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=STRZuGMY; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710797419; x=1742333419;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XGxuNIZ2BdZhhPzlA9EQqBTQ+qqOzNHLf2P6P9C0LoY=;
  b=STRZuGMYB/RIkmPsiL5hGx7A/9NicS3fsUgPEGTeh1qeCFKdRn0jqo9y
   3Yg/S5nDSUuxNd4RPA4MuK8fkTIXynVHfXHR7ecT3KBInisofWlMJghM1
   tkapLFZvs9/6xV2tIlLcl+DLVRPIhzytQC1W3Hcwj6O1i1Sec27S1L3rm
   Uczsi1GHTsKxdUqZTsFLpEZCO7RCk9fZVyC/sl2WOQlTfIsDmGbRayvvB
   PDt1gd41F79EBnkpAFcXcD9GMQOUENbbAudDthXj3OqXTk/DOYrbfRV7d
   HtkqB4Q2YEvpTWBhvWJeUo7577plzy0VmYs/3U/TVUCulM/Cb2CtbOqg0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5764327"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="5764327"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 14:30:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="13555384"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Mar 2024 14:30:17 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 14:30:17 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 14:30:17 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 14:30:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUXYw6dp4NZAVInJ+zOMff/IiKOTK9y9Cz+HTkDs0S42N48rTvoLCvoDz+UsqZCzAZrBNpUwKBn8aIYKDLtwsGwrVWy/CkgfBkADxe31NOUHv8/1Fxd8mFq9fJ2Lafdr5VoFNFBgyccBH87vUHuRPjFdUL6E6hFyZ/qUj3kx1EuBKPdMNtrMuiqqTPO6ZIO7BN469JhEy2IKFTJq67/lUxzRNdC97pAFu9PdXWnpR1yvbQsXGwfQbLO3AvgjOlTJ4fovzXFxqAyIh6j+o1KjJD7EJ/uJyRYm54Rv72I3GsS3V80lfDWRmMVSIBuQTbeTZDB4KQrZldzqRS3BDzTyUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGxuNIZ2BdZhhPzlA9EQqBTQ+qqOzNHLf2P6P9C0LoY=;
 b=HQp6YKArYbx7p5nDcmCwCoV69mZ9bGRnlEed4HIdGruyjf4Y2PgxYg3owrEbOKSu2T4w89fsMFM7hzYoXpzMiJN7r+blDpohIZVMhwwBhUcWF7AAZBG8tfgpEjPZpUn/xYSVeazhpds25ka90+WvK3yApFsMoQb5G8gN3tMgVpCbDr9+BbUigeUgS+4tuDZAPicDh8Pt/j2pysCLDjC0dMLNjme9N3OY6y73e2SkpfCR/sdKE1rRomNukSOPTMA+n0PzV4T0kMFJnfu4TY8ApdsiIxAKZdZYfuauUyRCsrDWl9Sw6VqR70Y99jAAdC+cKWEsePzRutn66HIF1oKIOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12; Mon, 18 Mar
 2024 21:30:14 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.009; Mon, 18 Mar 2024
 21:30:14 +0000
Date: Mon, 18 Mar 2024 14:30:11 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, Len Brown
	<lenb@kernel.org>
Subject: Re: [PATCH 2/3] ACPI/NUMA: Print CXL Early Discovery Table (CEDT)
Message-ID: <65f8b263bd757_aa2229444@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240318210904.2188120-1-rrichter@amd.com>
 <20240318210904.2188120-4-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240318210904.2188120-4-rrichter@amd.com>
X-ClientProxiedBy: MW4PR03CA0163.namprd03.prod.outlook.com
 (2603:10b6:303:8d::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL3PR11MB6435:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SCOjFH/FbF+SaSoIfyebfvb8Alu+c6GdYBsjtHXionHiQnSFhFmu72+OrMQr8+SOKPAWHz/+mGVg6syACStXC3M2rxbfhaKh/aOc8fpAeZNueFcE/q4GBi/CrzvY9BitXsttgMEX/1fe18V4mIclMKcPxDwfeRmAhn+R5UlN9PBfs8eYKKmxyrCqX2IgrDcrtg6LzkgjH2e6XmfHLkAzUxWivWhUfQ9AQDJ9tqRzpArrbiPYWJW76HW77wIcg5yX41yCygaY70ojyZw6bsxE02tT8wUc3aEDUZpt6LarTzQUO+3L0NOst6n7YNjHCOQfuDMRh7WmwIHdW61FDUdrlGm9RDjsYMch4OI1J9TEo7mYlK8CCQ5og+hBx2mKvuowIZ46MP0qvcJCwA5PJfqM/u2uIw8nd6/2RYlfYRk3JywV3qIEJSGOdZiCbc4TB+PXaAVezUfbYSRC56k3JfXJNruWKU+l3itwKM2f8lpJguhT7zhEs2Bn35pt2iLgQpyE7y4AQWra1ROHYBXCBPS/atXQ+BlLORY10eIMXxSir38UVblwLhrpAnoc3+QE6xGB+SNrcBfc4QI1vmc6eFvWs79flk/11HxIgtdZckqkO2D0t6acLLrZvOdATsQSlxMEzqHNCEvALXO6CDhoud00PltS3WwbAmy/UXXOfZiTc/M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x1rer/eaNBkD2QsxnY1niEzwYGK6n4pAoMEB9/BTusn+OF5sgIWu21mGsRip?=
 =?us-ascii?Q?YS5y4Asy7f4XJaOs/9+LD7bxb5Y7wIdWLSRz2F40Xuxags+fbjNRtNH9myud?=
 =?us-ascii?Q?nFOzdLKLORTe1U/5f36z3OoSA6YnOSAJHMotI4ybBM3zGV6bKYrN/nBzjJmc?=
 =?us-ascii?Q?U1pzjjY1Q+ewFwf80bcr+422EhfchJ8VqvPrApACqwzKDn7vvWgEj4wgo/UP?=
 =?us-ascii?Q?xvLxKGa3zpWJ/pZO0U/eqYenYPA3cnp1lN3Obvm28owytTBaL4t0KZFHBhrV?=
 =?us-ascii?Q?PRslVpEc6XjF8xlN5pTzn5g8Y0e+1ACY7oSYxoKaQCkMNS1x55m0sUdCUguj?=
 =?us-ascii?Q?5/Wxtz7yReHQH/8Zmn30Jwy0eaLIQlHOXpHHlLungNiZ0EBq5uNy2nCyH3V7?=
 =?us-ascii?Q?HODfzK1Usp1oOX4HJ4b9oImCMF4b59lpaBzks6/V5hBlRbIv/4d/Vno1CNzP?=
 =?us-ascii?Q?E/0FNXY4VLxYZzZXouNCK9zER8fAzgtmkk8GY/9F3PRSygW3pdJ2OCaIzv6x?=
 =?us-ascii?Q?93NRqhF9dZYO523eWeE3WgCGtW7nxWhgzGEshXNV/QnYJt7yml6KA+AkbCOg?=
 =?us-ascii?Q?u2WVuf1vfmMod7jBhrkhPmkeqIYXcRDav52qgFMjx8Oqgp0T8ZUU96K1ixML?=
 =?us-ascii?Q?ylEWVXBe2AIkSAZE6Dfqe5YbCGMDSS8nCgqUBnzMg3zW0LRzZu6UkxYMzEvN?=
 =?us-ascii?Q?Uum0Qs5v6DK9VqPJatedN5EhvoT16zYEEpHUZRm8UNT8U/RXP8zpZiRGWu8J?=
 =?us-ascii?Q?kaKAb48ZEna5RhDL3fqa2hqSDadJSDY+bcANkiZfuvZIMjG4OgVmHzI0Bl5u?=
 =?us-ascii?Q?BM9fP5PiYZVmXLqGp1YXiNsnAkPKC6+0zqf0CrKxQw/XLnDR4Nu4gGCaXFQL?=
 =?us-ascii?Q?DzA/ooPNnRsAG+iTL7HiRggY7+2yBSZ0OcwAY9CP+nmeodX0oFLb1vZSfRiS?=
 =?us-ascii?Q?Nbi69m4T7lyesoCFtPsKTKg07XFFPIKLNrarPjpIOglN0Xn0SWBgxhmOu3DM?=
 =?us-ascii?Q?vZ29Z/vpZSJEqfTVUeEjtVYNZYzsJNQbtnlflhmJsBaDciMDSMCc3RGHtHl1?=
 =?us-ascii?Q?ypTnapOqUSyrR6qkXwMCsyYI1UibnheFQl8a9GIgCyDXlXfb1HxZoWgREH6E?=
 =?us-ascii?Q?yAEvAujdt4UnDvpecG98Mz1eBm9y975XLOl9reqdwf6cf/NzKcYpKrlEA1w2?=
 =?us-ascii?Q?mxtYVyhBrp2hpuTiGtkNBtMlfRs5Ubj3BpUM5/kyf4PNqEP2YV/oE6klElJT?=
 =?us-ascii?Q?z6nULxuXnTDSq63xzBMF0gsqimcznYvou8U1XBrP7f7Jg/hckRtrDyl1XUIh?=
 =?us-ascii?Q?RtAgR/GgAxTy8mdr6TfaPnMgVwlzS5PlKGU6ZZ3otHlPnZHFzZftCTJVE3ec?=
 =?us-ascii?Q?YOvnB2RCrqw+peMX9rPHSOktwMBH/w2RntzjouibrFkiPDhpNuXopY9MHiRo?=
 =?us-ascii?Q?Zp/oab+/RlQtBGnE06dMxXtvJB5Lc+wPHFJWUgtvpug7FOl3oBhFKG7Uszw8?=
 =?us-ascii?Q?zCd8ykLCa/+B1LRYmgru2BnMPU4XqBLsAg64nzL3vYm9osO2N6ihLB6bsw9m?=
 =?us-ascii?Q?ntRokjkgyEwy21cJEPn/AAUI0claA3K/PFh3ZTw3Xz+jUAwfVpC/PYR87uOY?=
 =?us-ascii?Q?Qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26250ca0-c26d-4e0c-3be5-08dc47929954
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 21:30:14.4276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +TOUX40g92bLAg7C+FO7MCVnT2jmMPcmnXjGGjNd+d80KrnnkybmijMMgZNYEtKcpox8aNWynzme/zO07EEoHKQTDHRogSEiiJeyPOF5zWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6435
X-OriginatorOrg: intel.com

Robert Richter wrote:
> The CEDT contains similar entries as the SRAT. For diagnostic reasons
> print the CEDT same style as the SRAT.

I will defer to Rafael here, but with acpica-tools, cxl-cli, and
/proc/iomem is there much value to adding this to the boot-up logs by
default?


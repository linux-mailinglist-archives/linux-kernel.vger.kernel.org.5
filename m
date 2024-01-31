Return-Path: <linux-kernel+bounces-47030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 717F5844837
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2798F28F4CB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADEC3FE4B;
	Wed, 31 Jan 2024 19:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BvXHKNsU"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909303FE44
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 19:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706730192; cv=fail; b=rdr2gYmK1AStYrK2jpSCOFzhDycwKRzVw+/MK5ePxiNvc70IUI2yv7rWmvCFjkZm6flPhJtDw5mmjhw5xLYVW5av12vU6k1mn2gIUXRv32UHmh6DkdcUie/DcEu4ZZSRlFMICai01faAgAMLdmXy+eVkVWmxX1u4tETf7ZUOqNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706730192; c=relaxed/simple;
	bh=mDMdtnd6HrGFMQGnJgvQECAflqaEhVqVbLViysxuCSQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SyLv4DsA7Ygvz8FgwI9VJnEEPVWJpy2Bvw0PeuyWzbsT4rQoA3qOdrQyCht6dqMoa6tXPT2BrmolGfnUOUWhElRcjoP8u479bmFyPAad15UiG+FPoi5pFNU/XQvqogCrggJW2lLE6ihMAY+idSQRU0ptcMzQxJr74d/E2XDqNFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BvXHKNsU; arc=fail smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706730190; x=1738266190;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mDMdtnd6HrGFMQGnJgvQECAflqaEhVqVbLViysxuCSQ=;
  b=BvXHKNsUIuhq9j20aqe3OsUCRUwGVde4VWXR/sPPdUK99BlepQ1pwXU1
   bd1BXJOuI+yvxGvRIACBdrg4ps7SmNwC1i2ww8m48FU8O7jhGA239mRnO
   gFj+Jp4uckFpOYSYKoGgUPXA6aJZM3AAMKN8X3dkY44/bBxW2P7Po3f78
   FS7ftJYJvOHnKjkeCATMuNNHBOG4jEaISY+lNT9ST4tmqCNlTA0vBdOUr
   DZcG2vvGNvnRfGJRWq87Ezg8dg6c/ZZa7OHJW4UWajbh1XB+R4XA+X2qR
   fw844P3DdFWQWQByuy4qRrjZxQA48Q4n06+/7k8aiH53x4Cq0ilhhqKop
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="394148482"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="394148482"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 11:43:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="858913860"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="858913860"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jan 2024 11:43:08 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 11:43:08 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 31 Jan 2024 11:43:08 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 31 Jan 2024 11:43:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZmA2WlZp/njmzKVUNOI88iiBJApbCaA0AqkAxV11eTRyDX6NpqVrJR/E2LNSfjs6VG5nYO2IWi0d/cBLjuNLZfugHA066/Iyhzdt430ecYSLAYOWRe1aBcIvHdX6eTccc3jtEtHIbeCNtM+59gNzgPTNHErcir7K0TKxDDQ6Or8BtquOB76CI8DC/C0hMR9t9Zw8SAK5P9IWKjwrj7oNxOLh9D2eM8yul9iQ94f5cWf4DyIDgQOPyMG+VauSShov68jDGqXesoLAlEyoBBAEeQFWWCnSb9uJdcgO7b4vYwdgf+ehTD2/4xzBSqA6cxn9SfZUewKm+HjmLDFbwG3Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yovYUAz3/l3tVC9+h5RRvb6g8L2uy1wCSjkyOX7E+LQ=;
 b=EjFYTxlZtc4UZPGpearKpQ98PoRk2fB5v0sfk93/eGQlFjd2/pZOGkgRzJa1mG4gJPJbQaEw0NpkYDVF2qZM/Z6yCZuJb9hBlZ3sSNJzm3RdynZHjDYMXDIdCs5dwEbwToCz8BRG5KW/Xj75j1qo4BWI5R+fS/bsa+/5pHv+ZUPOKF5tPF3bfnxmdR0vaF8OA5vtlwS1EP0KjnW4Oa5yk5js4tjVEkXN1sZ9MliEhtJYGTkawmauB+EDavFPfQB6yuUktCQj/ivSQJUA0QkDvUf02w6fxLt2kikompSUsLFXD5elJdqh+ik40OzikAsWjMaKOGBr4LWlcw4H1y+PDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB5934.namprd11.prod.outlook.com (2603:10b6:303:189::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.36; Wed, 31 Jan
 2024 19:43:05 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 19:43:05 +0000
Date: Wed, 31 Jan 2024 11:43:03 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <alsa-devel@alsa-project.org>
CC: <linux-kernel@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>,
	Vinod Koul <vkoul@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH 1/6] sysfs: Introduce a mechanism to hide static
 attribute_groups
Message-ID: <65baa2c754e8d_37ad2941f@dwillia2-xfh.jf.intel.com.notmuch>
References: <2024013025-spoiling-exact-ad20@gregkh>
 <2024013028-deflator-flaring-ec62@gregkh>
 <b93ec9c2-23f5-486b-a3dc-ed9b960df359@linux.intel.com>
 <65ba8ca5709fe_4e7f5294ce@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <65ba8ca5709fe_4e7f5294ce@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4PR03CA0147.namprd03.prod.outlook.com
 (2603:10b6:303:8c::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB5934:EE_
X-MS-Office365-Filtering-Correlation-Id: c16f26a6-de3c-46ca-66dd-08dc2294d820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bm+apFxiSLvv6mY4XYIttzBeF+rhm786I9ZWglkHAiInSdPX6b13HJlrJ5aNvn3DSPMydUEdJZG40myAt5SQ1hL2W5YRc8JE274Yykeb07je41pKEnjYu2EiD5ReTMAav5xMThqK8eoVAe3wWGEPFGDOYKZKALHpj5eGbsBBCsKrgwcwfVo4M47f3wjtQB518KpkxowuySUXnsPdwPe7sR6haYh2or2BwQDq6k2RiExAmXYxxCRvUZ7S28/NkpcpkzBb2q2HsbGLPj2i7u3NGN1orb30cMcUVocnieH0wTStLqtkywXPlV43G0Uwpk4VN2z/1Hl4ObAn8Eh9iE/7EGRCc0sycpka/GXw1bsfROBc5EykD2iHd20S1uGOdV3KC8cxJVluywHU6qtyaQNTaMD2K72Awp0CAeda88eZoc1RkuhfW0TAl5iLAptcY4jSayU6dCyBuKVwGCQfHyrYZIPrIFvJjP9fdGUPHjggSbcJ8EKOyky4qfIYp2N9zzw8DKnSEKcgGOw3SsLMQwERHJIrBhczzqqzQTDA6fna5ZIR6nOC2VlYVCYyXwSq2I34NY/qL9VuQCVM/5yBjPM/5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(136003)(396003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(26005)(83380400001)(41300700001)(478600001)(53546011)(966005)(6486002)(6506007)(8676002)(6512007)(9686003)(8936002)(4326008)(82960400001)(316002)(66556008)(66946007)(66476007)(54906003)(2906002)(5660300002)(38100700002)(110136005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E9y5caEjxDY4Io3FVZ1qrPlIof3bvbXIcbEMa7/XBUXCUA0tXjBiBLGHcHnv?=
 =?us-ascii?Q?CmYZMP+1LDDuprQnFt+DXL9pt8Z9ufm1M62cX3QeDWunKjyd6HUWckFocJBv?=
 =?us-ascii?Q?rTou1CDWcsWYYJNdSZ6PrKxdBMbbrm0K8iCqkswdla5oIaYr/zbhRXruJI/X?=
 =?us-ascii?Q?DP62lsTkI82OVV0PEdiUkEPvy8l1zO14SFlsaxdKAq1vL6lTt9eHjjOa6i+n?=
 =?us-ascii?Q?tliZnXQsoqE46eYkGuWyoK4WxaK7n72HmH0Oi6yDRLsI/RIFulXsLG/wjwG+?=
 =?us-ascii?Q?JCNibvNF3QOxnur0Zq1xWJ+UYHgUlwlIXRD7UDBcdqJhhCOCQBqTZyjlUslp?=
 =?us-ascii?Q?8ugk6af3MdZ7PM0AwFjHwuXa93Xb1sednUM/4kxKerXsqT6GBb7sUxAtLk1y?=
 =?us-ascii?Q?0wB99esJSNurkzF8cfSBGTVjaVCSCNfG3Upbq9z3nyh1KsnxleZHbHC6+iiT?=
 =?us-ascii?Q?byqNmFmzp9FJ3+WB934KkrMGPURJCNcXDsIyJLUCOx4IEFlRaY0HUvUBix6c?=
 =?us-ascii?Q?9v3JOO7t30IgnarQA5TCX1rcbiemW7bBwvsii19A+0vK2Vipcm35m6b8Z/UY?=
 =?us-ascii?Q?sc2Ev1vEoAidU/NU+H3vLajx9ttN7nIvJP7hqNAP/MhZ8K6/Fd2n3Irh1iVo?=
 =?us-ascii?Q?Sk0iwR7+vpB1YtwiAxAbrpH6y8j8YCCEk/ZMzTDvctCLVMF8l6igSYMl7zNf?=
 =?us-ascii?Q?UC/e5y7kiT32TBd7ZrjYHrIAZ81f4bZlskaoJaRD5QC4Zb/r6UMtpSzWgc4R?=
 =?us-ascii?Q?VpAJn2yZQnDPb8BL3N0JGmySL4aXvNWDSxwMoZCsrgcDMrHr8fRbTugz2A0a?=
 =?us-ascii?Q?EFS0rHgG+ZyvKoluHLaIme6R9JybLekvRg+S/kYEZLIXYYVLVq82FMWT8pi/?=
 =?us-ascii?Q?WAOndOb/fvy/bydzo6TtTibmleNUo0V840SdjKaFgtBcFZAIQaWCivyZpcle?=
 =?us-ascii?Q?4L3q7E2a9X8/pAaeuNPVv5zKeD7MsCLYYF6SfKdnKSK8CE10B1PuccXAddJ4?=
 =?us-ascii?Q?NsktHcjyrH+Amaes71W3Dn8m8R1xPX07eqQDMKPHV1xO0EBLkA6/XyA/szQZ?=
 =?us-ascii?Q?pwEprc89eN32aSgGWs8zsHu2LSHsw+t9Js0ckR0EaJ1YrwSC6YvkaSfgXNTi?=
 =?us-ascii?Q?ykeRQiPBAu95p/JK4hsa7dRa39FwzZ5paq8OcPESAAhNLhqgnKRJz9eKVF43?=
 =?us-ascii?Q?HO9mEfFC06Dxl4p13DWQhKL9hFzy3ZTpyHGD3YF9CQip3CVnV9QsBfGexAqG?=
 =?us-ascii?Q?qM539Z66BNktTioZ/FKnu8LvFQYFP0hhG1HrZSOpS+JDhKy1DOhEVVp9Cofh?=
 =?us-ascii?Q?VtZskoVz/mxAAu+bdls+G2lRpeFyPRsscGGSPsJ7oWl8DyA8OZLsWcmZBcuH?=
 =?us-ascii?Q?A7rhqKaqib59R9spKJ2hYmKt32ALGMxkIYRoqcENl4P4P1eybI0QWUSaJp7h?=
 =?us-ascii?Q?x/8hBIHEuHqY5hhunBnLgVCIYASThoMiNUD29lRLdKzD/08O+uaSjDgmxYCL?=
 =?us-ascii?Q?t9U/UuhFZhifEPgTr3gY3jGClVEHSiInJ1jiVeH2WwtS0UgIqZPhrTzrIYES?=
 =?us-ascii?Q?4YHQ34qC7a3yBWT8mHMM+A7HThRCqL8btWk+0x98ITu6YMWQW9Dw9JZjGd60?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c16f26a6-de3c-46ca-66dd-08dc2294d820
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 19:43:05.7515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WI6EzjQIvAoL6bgLf5tQ20/v7TtOC+b2vZEdhJaQnUmv3u1JsnqZ4yam5orLU4IZ4QTjaj/WM+nQQFk48cnpJYNBQVE0cuV1ytAbYkDeTM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5934
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Pierre-Louis Bossart wrote:
> > 
> > 
> > On 1/30/24 19:46, Greg Kroah-Hartman wrote:
> > > From: Dan Williams <dan.j.williams@intel.com>
> > > 
> > > Add a mechanism for named attribute_groups to hide their directory at
> > > sysfs_update_group() time, or otherwise skip emitting the group
> > > directory when the group is first registered. It piggybacks on
> > > is_visible() in a similar manner as SYSFS_PREALLOC, i.e. special flags
> > > in the upper bits of the returned mode. To use it, specify a symbol
> > > prefix to DEFINE_SYSFS_GROUP_VISIBLE(), and then pass that same prefix
> > > to SYSFS_GROUP_VISIBLE() when assigning the @is_visible() callback:
> > > 
> > > 	DEFINE_SYSFS_GROUP_VISIBLE($prefix)
> > > 
> > > 	struct attribute_group $prefix_group = {
> > > 		.name = $name,
> > > 		.is_visible = SYSFS_GROUP_VISIBLE($prefix),
> > > 	};
> > > 
> > > SYSFS_GROUP_VISIBLE() expects a definition of $prefix_group_visible()
> > > and $prefix_attr_visible(), where $prefix_group_visible() just returns
> > > true / false and $prefix_attr_visible() behaves as normal.
> > > 
> > > The motivation for this capability is to centralize PCI device
> > > authentication in the PCI core with a named sysfs group while keeping
> > > that group hidden for devices and platforms that do not meet the
> > > requirements. In a PCI topology, most devices will not support
> > > authentication, a small subset will support just PCI CMA (Component
> > > Measurement and Authentication), a smaller subset will support PCI CMA +
> > > PCIe IDE (Link Integrity and Encryption), and only next generation
> > > server hosts will start to include a platform TSM (TEE Security
> > > Manager).
> > > 
> > > Without this capability the alternatives are:
> > > 
> > > * Check if all attributes are invisible and if so, hide the directory.
> > >   Beyond trouble getting this to work [1], this is an ABI change for
> > >   scenarios if userspace happens to depend on group visibility absent any
> > >   attributes. I.e. this new capability avoids regression since it does
> > >   not retroactively apply to existing cases.
> > > 
> > > * Publish an empty /sys/bus/pci/devices/$pdev/tsm/ directory for all PCI
> > >   devices (i.e. for the case when TSM platform support is present, but
> > >   device support is absent). Unfortunate that this will be a vestigial
> > >   empty directory in the vast majority of cases.
> > > 
> > > * Reintroduce usage of runtime calls to sysfs_{create,remove}_group()
> > >   in the PCI core. Bjorn has already indicated that he does not want to
> > >   see any growth of pci_sysfs_init() [2].
> > > 
> > > * Drop the named group and simulate a directory by prefixing all
> > >   TSM-related attributes with "tsm_". Unfortunate to not use the naming
> > >   capability of a sysfs group as intended.
> > > 
> > > In comparison, there is a small potential for regression if for some
> > > reason an @is_visible() callback had dependencies on how many times it
> > > was called. Additionally, it is no longer an error to update a group
> > > that does not have its directory already present, and it is no longer a
> > > WARN() to remove a group that was never visible.
> > > 
> > > Link: https://lore.kernel.org/all/2024012321-envious-procedure-4a58@gregkh/ [1]
> > > Link: https://lore.kernel.org/linux-pci/20231019200110.GA1410324@bhelgaas/ [2]
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > This patch seems to introduce a regression on our Lunar Lake test
> > devices, where we can't boot to an ssh shell. No issues on older devices
> > [1]. Bard Liao and I reproduced the same results on different boards.
> > 
> > We'll need to find someone with direct device access to provide more
> > information on the problem, remote testing without ssh is a
> > self-negating proposition.
> > 
> > Is there a dependency on other patches? Our tests are still based on
> > 6.7.0-rc3 due to other upstream issues we're currently working through.
> 
> The only behavior change I can imagine with this patch is that
> ->is_visble() callbacks get called extra times for named attribute
> groups.
> 
> ...or if an is_visible() callback was inadvertantly already using the
> SYSFS_GROUP_INVISIBLE flag in umode_t result.

Are you able to get kernel logs? A before and after with this patch
applied might highlight which attribute does not appreciate the extra
callback...

diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index ccb275cdabcb..683c0b10990b 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -33,11 +33,17 @@ static void remove_files(struct kernfs_node *parent,
 
 static umode_t __first_visible(const struct attribute_group *grp, struct kobject *kobj)
 {
-       if (grp->attrs && grp->is_visible)
+       if (grp->attrs && grp->is_visible) {
+               pr_info("kobj: %s is_visible: %pS\n", kobj->name,
+                       grp->is_visible);
                return grp->is_visible(kobj, grp->attrs[0], 0);
+       }
 
-       if (grp->bin_attrs && grp->is_bin_visible)
+       if (grp->bin_attrs && grp->is_bin_visible) {
+               pr_info("kobj: %s is_bin_visible: %pS\n", kobj->name,
+                       grp->is_bin_visible);
                return grp->is_bin_visible(kobj, grp->bin_attrs[0], 0);
+       }
 
        return 0;
 }
@@ -62,6 +68,8 @@ static int create_files(struct kernfs_node *parent, struct kobject *kobj,
                        if (update)
                                kernfs_remove_by_name(parent, (*attr)->name);
                        if (grp->is_visible) {
+                               pr_info("kobj: %s is_visible: %pS\n",
+                                       kobj->name, grp->is_visible);
                                mode = grp->is_visible(kobj, *attr, i);
                                mode &= ~SYSFS_GROUP_INVISIBLE;
                                if (!mode)
@@ -92,6 +100,8 @@ static int create_files(struct kernfs_node *parent, struct kobject *kobj,
                                kernfs_remove_by_name(parent,
                                                (*bin_attr)->attr.name);
                        if (grp->is_bin_visible) {
+                               pr_info("kobj: %s is_bin_visible: %pS\n",
+                                       kobj->name, grp->is_bin_visible);
                                mode = grp->is_bin_visible(kobj, *bin_attr, i);
                                mode &= ~SYSFS_GROUP_INVISIBLE;
                                if (!mode)



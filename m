Return-Path: <linux-kernel+bounces-104780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 962CB87D37E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52E732842D4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D764E1CB;
	Fri, 15 Mar 2024 18:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="APsW7JUY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D77C1B810;
	Fri, 15 Mar 2024 18:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710526911; cv=fail; b=GWXwtlVZvG5YdTU9HJcJdqAAxnhbUGpnE2lQWqlI9xiPw8rmmDkNxhBsJz2DPXwNrO44xHmMrEdh45jlpadaKAzu/DXdgZ+AHkuQH8mBTFE/FtFmYCbwfoJcpVFZOI6zl/PB9djMY6B0grDDmUl/6H7MqBO98v50CEnpwpxmDDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710526911; c=relaxed/simple;
	bh=qZ3om0HFEJKy/6ctTb0uKUlPsuzAC1oHff919RCK1KY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CBmtu76wZMMLutv+3He8etnZEzJajbEnBcWerDD5g+UKotiAjCS71tz03NNetsDrCvrPPp4FxAzAF5zm4yAMwDkwkH0ekJHvkeyVYTbpAEk8hF/J/BOKn2cRkiNinfGSHTlMkGdd2Q7hWsQvZoznaBMiNQSv2H1iy9ai6xZFbKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=APsW7JUY; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710526910; x=1742062910;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qZ3om0HFEJKy/6ctTb0uKUlPsuzAC1oHff919RCK1KY=;
  b=APsW7JUYK5AKIRgkNPrci1bWfgU2djpgS5ekG47rKWkBgLXLiSsq3sTA
   /226yOgyFQfMnAQfrqqi0Wd3rC+Hg25iiQ73gv1NUiuQo4xkAaFFIdzuG
   kumURWWkEu6ND8lHbOivg5QzyTD7x/NpvOi03SDngxxY27N4s8UgMOjXH
   1RVlDrdBkGnhLfrrt4bYPyrVhBVCX5ONa+428cQgpCaU+F8gbxMCZ52wZ
   e45zP9yczhaPU6yGyeeQTB9eEirGIEubCDuwXUhqLjHkf9M2R5U1XMnSI
   cWz+JZvUqk12oBpCqx9IbxaH6AMdXca0vQ+AtuwnyiRTMG7nNgeNZHqk3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11014"; a="9246089"
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="9246089"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 11:21:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="12710647"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Mar 2024 11:21:48 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Mar 2024 11:21:47 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Mar 2024 11:21:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Mar 2024 11:21:47 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Mar 2024 11:21:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnKMrRcCYAN70SuZOEmWC5XSZVGfCGxqZ2vXpF6srU6ZlARILqSoCNevV4uLOqZSOSuLa9bJaVTakvLeItKKp8c+Y6Pv8ykieawtsFFzLz2qIXmuNkuXxWHJSTq4gH58F0kNcPWpP6QmCVETk6bjpvY21aPmlLdbeCsAicp2BSV9pL4eBOSkmA7LVNDhno57/XMaSCiJECAHgyxfwk7ZH53xcS6nmIDkM4JnTVr8AlgMDuIGdbr5K09OxabJcNdpyRuj1Hs2ADL8hp9nmkUvVX5bTuOeStlrHD3C/XWZrX+eDsBuop2M/6txh49gZVqZwKntwbLn4yjnS4hWFNibcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsygNwAiKlH0c1vZfskg6RE6NWLy9V2N4lbZWEvrHV4=;
 b=ofMZAO46ZL0Qf2Ia8ICRTgvbJAQQ2CmBNbd7KxsKNmEMkyCUI5Vkbu9bVjxWA+dQ8gjwRz+vGMRZL6IIDVseZRfFg0uSvj552ZlewQbAdWjyBOe86FO8PwCu5dEFZ6MVLCtEWYAp8l5kGoaUtWYBk5hTYwCKRFNjv4O+yAzl4IvjK/ql3N29muV7nD6L5A0leAJ82Qli4ZzKskClgJZJ9R8XdRvWXWzKdETqrUM7uca/gkJWpNO8p0q22hH/w88mZRJWDu0fJ9BL1jQKPgjcsTLIoujta4XE6tkiWccVj4Hmfkgrm0RzyAif9MyBvpp6aupcvhkeZPCH2qhcutAnEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB8062.namprd11.prod.outlook.com (2603:10b6:510:251::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.17; Fri, 15 Mar
 2024 18:21:44 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7386.015; Fri, 15 Mar 2024
 18:21:44 +0000
Date: Fri, 15 Mar 2024 11:21:42 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Li, Ming" <ming4.li@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	<rrichter@amd.com>, <terry.bowman@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/6] Add support for root port RAS error handling
Message-ID: <65f491b64f15a_aa2229497@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240313083602.239201-1-ming4.li@intel.com>
 <65f3a842988d6_a9b4294f7@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <16ab732d-a009-45ee-a438-3faf048c7acd@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <16ab732d-a009-45ee-a438-3faf048c7acd@intel.com>
X-ClientProxiedBy: MW4PR04CA0066.namprd04.prod.outlook.com
 (2603:10b6:303:6b::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB8062:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c6dfee4-69bb-4bd0-f924-08dc451cc4e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vqlqFpVeCvf/t2eIyeN/+eH/rcP8tP91OSbUFHSaY3+Wotq3sCNFfmXuB0TtteuluZfNhooHDjCgdHtPub4IZ/+V7p/NfI8KyAqIhQv5OQAmlknxsQk4VO01lwib8WPbT1LDTBjas/uEithU2PB33ZkJvkldYYGzyuT9UyEwP0uFWmj8Pz7PYVte5OFUnmVem4EqecnWzqbN9TM36fQcEQAZ2aGdy1zVsJdznSAK3QHGECZxX+bCk28nPLVFAh/1rNXbCvWWTkKSClPnmdM2rYJKL56Gmdsz9tkKlpQjL+cNxfUkLN99LD1qZMOecLZun9LXRa/9Q+5jwz+z4T1VTxNkCJ+L/mvDH7+kG6vAxH1LsGk1T7Ece2sdlKpOhLz6CC+zWDtI0C6xfGpEoHP9tlHYA/Di1ci6hpEtToxcWwrYyAjBCbLGT9eqhDDILy/91X+Es5W+MToxunTe+DWVnH/c7b8LpfDlQ1MnC9XiGGtELKn3M0gou9CxBOPIOxuEfebassy5DjNpDz2gib1qufWx3T1o48cauC4aUXkbl3U1XLli+yKYdqopjT2ShlBluzihKTJ6lrWIg8XBc6jZJGKqs2wXAvdCXnziQAd/cT1JAoXT+CrDHyinsmHCWxmjMDkhYVUo9teGJ/hnYTZBKoHC7hnIRGFAJf8KhiKzXZY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SMmxtxadEkI0f3IUlfF8NvV6ok6tFLHC/LUKA87CwzR+4wezzjbq8Q1jnqdS?=
 =?us-ascii?Q?c80Jphv8aE1EMu3SptuX3Qbtk2duPTKJXRhJTN/4ifrPQstCyhBdOSLFOjqC?=
 =?us-ascii?Q?zthyNTzb0VWxWg+UP3v+kRW6n3tSBeu79c5cSFJhRFu8PGVBAxaqMEnHI/lK?=
 =?us-ascii?Q?mQBympOC5WLFdV/2Zl6qLn1dyGSPBioUI2d/zucfeSEjxlaihhJmf/PyvXvH?=
 =?us-ascii?Q?DBt2sDFmGcyvepIVM2HM5hU6Jd50BwJZ3kh0gByBA7S2bJzSnmiWSrXRZR5l?=
 =?us-ascii?Q?i08yCKX+nC0V2mqHs7WmuJT/MCGcqN1PnqBt3sR8WxD/DScLEfkL3I//7usx?=
 =?us-ascii?Q?EGFORDr8KfkGMNVzv9I6BXE4NP21mJVntwn1CTc03V4MYWDN4oYyv/yOsoq8?=
 =?us-ascii?Q?YDwfgSbIY0UVpiNb6TMvP/NsM3nU70xp6CXom26Pv2JQEWmftJqKiaySipBZ?=
 =?us-ascii?Q?3lBAI3kjuMrFv+PQZtjN9ge3Tyj2dbqRYP0RxGeQ+M6G75BBxRLvvPkL6Wqw?=
 =?us-ascii?Q?p4igD9ifSG4Btmza8EplcvWve+qTCK3DuJ4twXKLqtgq9QewL1syozNgsSZh?=
 =?us-ascii?Q?krkQfYab0oxn+RLqkVdJSnMYc6DSbTc7cQUtWqW4Laa7g7Gs9B1O0fm62rx7?=
 =?us-ascii?Q?bb/Xe3uLt/UkTJbIHTNoenCrZMIjTlORN9Qqjeou3IjXuMx2umVZZzR4b/iv?=
 =?us-ascii?Q?3gG0ubuaccQvjlRtuINK+lrHdmjWkt3QS+VhM55xcxQovYRIwCvyQafNM2JO?=
 =?us-ascii?Q?5Jn+Pwum5RVChm84lUKvvYx0GIawpthWHSR86BFAS8znyNy6mRAcyx2mRI4g?=
 =?us-ascii?Q?16skq1qasVyl4ZV2Gzb/I+nlmrg0njSCDJZdmKsjRprs6VINgMsjfqMmoq9L?=
 =?us-ascii?Q?jvauQemJATgZ5F/RkgKOoHj4O31K8YqyyWjnRtCzeTIfzDkNy58+ibjeVvFH?=
 =?us-ascii?Q?0K2FdTM/wadD3vPyDqC5G1sk/1hoDBZhk3ZWmY9B2kFa2NyANk6uIv909YGO?=
 =?us-ascii?Q?r8svT9MNj0Umce3ometVSitzRW7rGRkmom2W6kRFQC6OBVkdQy7fTZDq4Nyr?=
 =?us-ascii?Q?5+ZYOAZ1gUuEsyINPs8xSSfv2n/ZJgNssfJEmFEsZCtEQDZ7zamevjHV83kv?=
 =?us-ascii?Q?YeDRYYuYSCQIyruVhxZ6xAECYxgkheWSUxmcZJGvVTkp3DUOzseX4TKP7WSL?=
 =?us-ascii?Q?kjb8HxpnYmxYboohT26H4jupeIZ2iZnAn1M5mCkVOCuIyQUM5ItZJwvRUSZi?=
 =?us-ascii?Q?IJi8lF0JCTZwhot26q2z02SqL17eEJgLqP9tGwBsRtLWd506gkaNQOb/RmD5?=
 =?us-ascii?Q?DjWo6grOitdbbSuiT4A672nGgtIcHF0s7tPQpIXu0L/Mo204eXtnojjJKKZ9?=
 =?us-ascii?Q?N5BJVygPABfbDDudlxTksGGudvKin8zliCzeZ0qRMR+L4zoclA7yJhE945VT?=
 =?us-ascii?Q?+grH2koSaxVsKYw1aoNuxIqJ6Igp9+yviRq4saIOAu2NxTDg7f30LKT6eFzy?=
 =?us-ascii?Q?JNGwNowi7xVXPzBP7eEJqBWiiENGYbCpGNqdjnjDL0MmG7ZvFg3SISgQ6YV+?=
 =?us-ascii?Q?2GWwt+P/KEBUoP2SNpc2yjUaacYQOuwO/jp4Bcu2/WmZut19zhABMmQXciai?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c6dfee4-69bb-4bd0-f924-08dc451cc4e2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 18:21:44.5805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HGhSG9C8ElOGuZFxr9a/RuKJ7AFDlCXtxVztmEtUj4KkOZx1IsCdnT4+AOiFLLwGCcLkZaZVet7V2w4Az++aPJl3JIXGUrOHNFqqMWKWw6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8062
X-OriginatorOrg: intel.com

Li, Ming wrote:
[..]
> > I do expect direct-attach to be a predominant use case, but I want to
> > make sure that the implementation at least does not make the switch port
> > error handling case more difficult to implement.
> 
> Hi Dan,
> 
> Currently, A rough idea I have is that:
> If a CXL switch connected to the CXL RP, there should be two cases,
> 1. no CXL memory device connected to the switch, in this case, I'm not
> sure whether CXL.cachemem protocol errors is still possibly happened
> between RP and switch without CXL memory device. If not, maybe we
> don't need to consider such case?

Protocol errors can happen between any 2 ports, just like PCI protocol
errors.

> 2. a CXL memory device connected to the switch. I think cxl_pci error
> handler could also help to handle CXL.cachemem protocol errors
> happened in switch USP/DSP.

No, for 2 reasons:

* The cxl_pci driver is only for general CXL type-3 memory
  expanders. Even though no CXL.cache devices have upstream drivers they
  do exist and they would experience protocol errors that the PCI core
  needs to consider.

* When a switch is present it is possible to have a protocol error
  between the switch upstream port and the root port, and not between
  the switch downstream port and the endpoint.

The more I think about it I do not think it is appropriate for cxl_pci
to be involved in clearing root port errors in the VH case, it only
works the RCH case because of the way the device and the root-port get
combined.


Return-Path: <linux-kernel+bounces-98782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FC6877F53
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97BA9280CDE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3EE3B7AC;
	Mon, 11 Mar 2024 11:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l8d2YwNv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342C529CE4
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 11:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710157823; cv=fail; b=FW337s3xcwGE2I6PhefWXEWs+g/hzvzttphER7oOBm6WTulihpR55pQARIEtyOrVgGAX3wkH/9edwetT/nVb6ekLJxbwAA+TJTrPQ5z8iN1A1q9erJNLkEicYvAWaA5XbPq8nqDQ6o/akfmSOsw7Xn01W1GMudn6ETEVpate+ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710157823; c=relaxed/simple;
	bh=U8IQ6Dbr4LWDmJGsiaBEPjnkgjkYHgYUZC94XJXG1rk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XVeVzDzVCE7QdN6MEjIm4qsDuPopffZdOhjpI/ykc1ObnWvc+kD/kA7sTIxmXkp7Hsx/j6Q3gJxsjaG9FvmRgUrWRGtYRFMRs2NIa/Ks16LaiCfTrQS9VLItdg2ed1ObBd+U4AYVuTdgUUBfuZrgvLv38jkAVk0+EZzoNlo/Eco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l8d2YwNv; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710157821; x=1741693821;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=U8IQ6Dbr4LWDmJGsiaBEPjnkgjkYHgYUZC94XJXG1rk=;
  b=l8d2YwNvCBHo4T13oicGtKQdPi2sd8Yo/vS0NNS8a3nvWes/3NhCv8jm
   Otyj62f8KDsrjNQtl88mFib2LHOl8f4p6RBe9W6UVRaoMinekCVqamnX6
   qJW/ULRpqdRzGqK1SptGbM00aawxI2pYQfRSz9nVvvJ63ZEkMnNdUCO0T
   YYD8qw6a2XUasT30T0P/2Pwg7pjZTUNby5s6HXda/FLhx/9q+TKqji3XS
   rWfI0KtR/wtyYWQfNgPKuZUzMVJ8SumL4XbnzWGcGZ+cfTyWdOYpWwHHR
   2aRy+jOgd+Z3oJ3nOETmBIiAf/FdGym283Z6AfSSJmj56Y/cvj3Nlgokj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="22335472"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="22335472"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 04:50:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="11235906"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Mar 2024 04:50:15 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Mar 2024 04:50:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Mar 2024 04:50:13 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Mar 2024 04:50:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdyl2KA8/eD8z610KwZT2if5Fhg2FD72DBEgcrw1OLwqBIx9ifqPtENrb74/dkFsFRTmhSHZau5ETu5SjjQ8QhKMH196Cnno/3eoN1IYBjAgWnhladTAWLSiX+TOslQfklKZNXfTCMZZbyhnfHak7+kG4jJYdFXfS61+3f2NuLY2pRlMCswC2M1J3kxiJtOaXDyJURZra34ivuBe8sOXo+uNSOjcis8lSDUfmXAq71paIHmtY+HgrHbf0E4W2Fm7ecKXWZJ5SmLtBOOFu4rkPXHS8qhrBDKVC1B925/4JwU77enql0hWrmHGJRPz/eDLeKg3tfyVtr3ozRXOb4BLCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4wIKiys8jdcGGoWU0578CuSttNMdowLfjGSvGiOXGo=;
 b=iK8B1aEbt6rgwQVFiSf3djLsytgSjmV0YjcZ6URyZF4atxEZTyVIxNwux2N1P5kKRbgly3XSCeHjN610r2ziBSfSCgeexBOB+PJuDDqeWYg71mKKunZ0go4J4FM2uroQ5iyZi4ER9CT3LPsCzy+bV08G/7534h+ZkgADT/GUqV7PSqvEU90ACgQYrDFvB6SPi954ZsEk3bW00DIp71m8gvVH45/2m3LbDS4abOIldAaJrECuuhWKygXDhh6ayHndG9uCVqech4uTSoDN1MqybGO9flU7A3hJ0dknD3RHX3F6tHFVhWIifehLZIXLW7jNXoqC3a+2z+BuukFVPFbyuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by LV3PR11MB8694.namprd11.prod.outlook.com (2603:10b6:408:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.16; Mon, 11 Mar
 2024 11:50:12 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6440:4b82:c32c:9eb7]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6440:4b82:c32c:9eb7%5]) with mapi id 15.20.7386.016; Mon, 11 Mar 2024
 11:50:11 +0000
Date: Mon, 11 Mar 2024 12:49:39 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Rex Nie <rex.nie@jaguarmicro.com>
CC: "james.morse@arm.com" <james.morse@arm.com>, "fenghua.yu@intel.com"
	<fenghua.yu@intel.com>, "reinette.chatre@intel.com"
	<reinette.chatre@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Liming Wu <liming.wu@jaguar.com>
Subject: Re: =?utf-8?B?562U5aSN?= =?utf-8?Q?=3A?= [PATCH] fs/resctrl: fix
 domid loss precision issue
Message-ID: <3fjeeggediya7cl26snya5o5oif6x2xfd26qmsvroe6jygtufu@whanfahntydy>
References: <20240311064822.891-1-rex.nie@jaguarmicro.com>
 <2u7eg2khp2zrcmbfpnh6ighxqbttv2w7giwdxlkndeywpgq2bq@2lccnqwkbo65>
 <KL1PR0601MB577303C9D0B1247436BB06F8E6242@KL1PR0601MB5773.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <KL1PR0601MB577303C9D0B1247436BB06F8E6242@KL1PR0601MB5773.apcprd06.prod.outlook.com>
X-ClientProxiedBy: VI1PR09CA0126.eurprd09.prod.outlook.com
 (2603:10a6:803:78::49) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|LV3PR11MB8694:EE_
X-MS-Office365-Filtering-Correlation-Id: 7934a4fa-3a48-4f82-26bb-08dc41c1686a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6WfgiF3+RJsjnjTjpb9Tp3isOqJr1QTdbQvCQGo7k8ERsJ8emvpVOApS+3nBhFMutBKVHGYyZkEUEMpklNG5teh3InvzaS38v0upyrZ3ArquyDoW5eGkg/3h2dVRYRZfMVzAIwux61JIS1RZP0/wdN1eQ2XY890bJ2O/qOi7dDYJ4uiW98g6c4e0kaPqi3xr7s7heT3gfeJ8DrxskepqXR3YmYAQQWqadjzKKx/ylI5x0KZfsd9zEP1sz+ZB43EprcTAWKkivwKTaMu6220VEyjqTP/dMq9nJd9LNY3BDk5huaHi0qRwWVzd1z1clwWYwjMOUnhL6kBLLeMF8QmgHRa/YtmOVPpC1fY9LD4us6LAHVWwiBelHkMvECepYbcFTOnFK0OEpoaUGzXL5heuSf15oHv3OaTE5kxoly5L+i3ceunILu9n/adqFzN6iqVnZCuEj4dWnijei6wYchVdZq/So5fDFAto6GX//QoIf6rmKAA7fkSI0L/wueFvEd4d9/j+yULFx10bMV8W46VNiQ8NFJ+fpH3BxUqeZLpL4s/dQJdwa57lZoa7QHz9wVw9Ijp3l2PZX1XFiKyulVc3ZbjYt/6Of0tAky5CrrtFS/Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?5CJjlWX+N+TH81QzBFBW8pF1EE1V7aM73mZzHU8dTtU+5uB1M/nftTfezy?=
 =?iso-8859-1?Q?hoIM6vxTIumz1UFRrQaBu4TIRi2eKwoSrPmef7+DDKIOELEBnVtbfv+rod?=
 =?iso-8859-1?Q?Oo/1f22s4zsjLHcdvuWGqsSHxQ8K5+ec5FgrvWEMphl52B536BNfRuDKsw?=
 =?iso-8859-1?Q?RHF03aTK3gWFAyuOgvF9wFYy6y+ZfCmho7pMP+dKB8gYu4wRpgak36ApMr?=
 =?iso-8859-1?Q?GyZqbgZ64mVHzMFjUdTDrACpMmZP6NJrIp4/oM8mpCRsIN5QDwxy9Z8HfQ?=
 =?iso-8859-1?Q?Eswjkw/Z5Thm+aVbOWK6bVynnYZCk43kh0JvzqME9hdkLSSl+1FoMA1qLK?=
 =?iso-8859-1?Q?DXZU3c2PAs8qLihnm6TFr/7uZpy8ZDAIUs7lwHyCZVHHywC3heiWw/t8ec?=
 =?iso-8859-1?Q?JLqI/bxB3WX3v/mQx9bnaFrg+bU/GNfY38VRewGqojRAGX0G3BoVhZM9JK?=
 =?iso-8859-1?Q?PdLA/VOwfj4BGZgQAQ55urXaD21wurGjcWSlGXcJW+STf8YMFs1GxUxkcg?=
 =?iso-8859-1?Q?KKiqw1A9wEjwd9rRydMqTFjEkajaId0M+X4rsnpN5mAf8IaM4MjTabk47K?=
 =?iso-8859-1?Q?oN3qCNptQyiHCmtabLvOuRA4uTSnD+TNQYzjQ3eeRAtcxN4Y6cCFXpN4nx?=
 =?iso-8859-1?Q?Qtc6PybRhsi/oxzMn7ftRcopRkFdQZEPzdzLpYFtCfWiwhkTihTJGKUbEG?=
 =?iso-8859-1?Q?W0nDtibb1/gunrckybKesTSIh9Lzh8mmMHZVQKSG1zi45E552NArHlFckX?=
 =?iso-8859-1?Q?4Ys7kZORgkdLgUeBnjgvEhLS4yGu/8R7+OJKCBtlg/wrBA7mpA68Avt5RE?=
 =?iso-8859-1?Q?lu/dbEpDZekpx1kHtEFQv6Eg9JG0au4M3qB03CxzxixxdrBcg/N1rcUteu?=
 =?iso-8859-1?Q?6+Fl68il4AOURNDyzijWocEjnO9FE/fMtnIt+rN0tcuAqsR8GThNWKsXxy?=
 =?iso-8859-1?Q?rI+AvkfUxMRQWK+yX9+wUzK0oMgjbArmm+722v6ph4xqFYvIWbVKAuufm2?=
 =?iso-8859-1?Q?LbJzZRggdeD4OoAXlRGehT86YoIr1kusjGQ5ja6Af8B/aH8Ipyn2aQNuLs?=
 =?iso-8859-1?Q?kyTZC2nzVY1RIA8uBjJlUb/0tI0xtNwz+9sR4MUjB1jgshtoqAlDfd8vSb?=
 =?iso-8859-1?Q?Oxj9Rbdv+DYkBCSsqNRV+kWRtjBqJu1otMBrnC1kw9sgd/3kO8PFP7BMb9?=
 =?iso-8859-1?Q?NIwcGAXVhxEThLzLcHbCKZgOd4qY3jJlVDi9AzAylyqJLT98kk4uZc3/5B?=
 =?iso-8859-1?Q?QctI9Tij54kLKIDNFDpn/tmS154Ro4em9N5m9cZ2o2f/BLQMrphh1ZdSvS?=
 =?iso-8859-1?Q?rUJ31keL0CtWGp2lVNjJCw4I2wgqkt17i5CteKYYmArViweg+wVSQS4ZbQ?=
 =?iso-8859-1?Q?yUjRkiqcmeMj6Q7o8gfLOmkammc6V68NRheLbKDcTE3j6EgVF8xFZuAPHE?=
 =?iso-8859-1?Q?QDxIjq1IjHma3SfkmNWZ8tqaMZybwZTFEUVrGMXk/b9rWibiW8wQqPVcjU?=
 =?iso-8859-1?Q?d9NzAQYaVxQmosiVcepYsAt5Szl2f0C8a3vRfQNBabjXqSw18IHUyHOtNo?=
 =?iso-8859-1?Q?vxU0GgwnAUxFWYUvVNIvbywBWyPf1wXN+YxbE/SAZQylWWaLY6l237Mffl?=
 =?iso-8859-1?Q?eVJfRaYL1lSrNKKcbM6Tfm2ENQGuyShyqiAVDzHr8RFZCXMMPPmqRPSusG?=
 =?iso-8859-1?Q?FaDkNPTBKcnB4Om9btk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7934a4fa-3a48-4f82-26bb-08dc41c1686a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 11:50:11.7771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SBGpUj+QFeip+F9UhhKWRLi2JF52E3XqiIiSMmWJ+M1k2G1H1ZzlSy3I8I4WA7ecTUNq8I8qcvneMWM8tqlPaAIYCTKpSsl8SdgmgLUbovE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8694
X-OriginatorOrg: intel.com

Thanks for the reply,

On 2024-03-11 at 09:37:37 +0000, Rex Nie wrote:
>Hello,
>	Please kindly check my inline reply. Thanks.
>Best regards
>Rex Nie
>
>> >This will cause below issue if cache_id > 0x3fff likes:
>> 
>> Is there some reason for cache_id ever being this high?
>> 
>> I thought the max for cache_id was the amount of L3 caches on a system. And I
>> only observed it going up to 3 on some server platforms. So not nearly in the
>> range of 0x3fff or 16k.
>> 
>It is exactly as you said on X86 platforms, but cache_Id on Arm platform is different.
>According to ACPI for mpam, cache id is used as locator for cache MSC. Reference to RD_PPTT_CACHE_ID definition from edk2-platforms:
>#define RD_PPTT_CACHE_ID(PackageId, ClusterId, CoreId, CacheType)         \
>	(                                                              \
>	  (((PackageId) & 0xF) << 20) | (((ClusterId) & 0xFF) << 12) |              \
>	  (((CoreId) & 0xFF) << 4) | ((CacheType) & 0xF)                        \
>	)
>So it may be > 0x3fff on Arm platform.
>
>Reference RD_PPTT_CACHE_ID from edk2-platforms: https://github.com/tianocore/edk2-platforms/blob/master/Platform/ARM/SgiPkg/Include/SgiAcpiHeader.h#L202

and thanks for clearing it up for me! I browsed some MPAM patches but didn't
notice cache_id was used differently on ARM.

>
>> >/sys/fs/resctrl/mon_groups/p1/mon_data/mon_L3_1048564 # cat
>> >llc_occupancy
>> 
>> How did you get this file to appear? Could you maybe show how your
>> mon_data directory looks like?
>> 
>I found this issue on Arm FVP N1 platform and my N2 platform.
>
>Below is the steps on Arm FVP N1:
>mount -t resctrl resctrl / /sys/fs/resctrl
>cd /sys/fs/resctrl/mon_data
>
>/sys/fs/resctrl/mon_data # ls -l
>total 0
>dr-xr-xr-x    2 0        0                0 Mar 11 09:24 mon_L3_1048564
>
>cd /sys/fs/resctrl/mon_data # cd mon_L3_1048564
>/sys/fs/resctrl/mon_data/mon_L3_1048564 # cat llc_occupancy
>cat: read error: No such file or directory
>
>Arm FVP MPAM: https://neoverse-reference-design.docs.arm.com/en/latest/mpam/mpam-resctrl.html#memory-system-resource-partitioning-and-monitoring-mpam
>

-- 
Kind regards
Maciej Wieczór-Retman


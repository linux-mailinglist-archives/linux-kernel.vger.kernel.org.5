Return-Path: <linux-kernel+bounces-118312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D58DA88B78F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 054121C37BFC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2AD5D726;
	Tue, 26 Mar 2024 02:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e94FCiGp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821ED127B5C;
	Tue, 26 Mar 2024 02:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711421056; cv=fail; b=d9AcslqS/G2j44msJL8vqPIHMj2+glBItCPq73fXGK7vnxyZXQ6hKg+PkQeS3ycn87uzZpKWcVYfi3miCMvxIaaCxfUyGw4lkwdqcymHy9lp4SP1xAaQERhj4AqOeo5Uj5KuTV58QbYfx9KfF9F4ll5c2XcfIC3j9gXfOGwuVfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711421056; c=relaxed/simple;
	bh=/YHjzYeoeKEsDHobkRKcBaIhCGl1f1sxzvvdH2krtqo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bHG9co3UrQPMRLzeVgdTxlIdab8pH3FyHEREKv/j1ya02ck+gwmOgzEMiIoDMpNUE9N0X61jJcCZ1eG83SRL5v5d3+LIfWFjtSy0oQG6RmelrDLcYIgl3GGQE/HoSihYjY5pgalkksDQ8Qyu3626JfR/V9Ui/Arb0SXUVYw5X0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e94FCiGp; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711421054; x=1742957054;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/YHjzYeoeKEsDHobkRKcBaIhCGl1f1sxzvvdH2krtqo=;
  b=e94FCiGp7DLahEe7KDEvS1rZPqPatq1VeXiu+zGl9nEhzq7O0ixzsa9T
   dc7ksGg5DiYuK/kZGimVAsu7xMzfciGXGRJZOydydELtyQa1uFzLwzlXc
   UtHsTN/ezx4WDT20NhMUh05Ofki3yS6hrQnVA+ecjCSJ7+EL/flqs4CRl
   2/KBrD2seE9tFABfvT1ufpMnS0+7Yor1H9tjlmWYjQmf98+n8/E2FsxpQ
   9g6bwuHYbFeMp2WbbEcqTt3h/aC1uRuORMFtr713B2HSJ6bsjKGj5q0M7
   SlE4zjOiecj+JUgdX6QHYRBkUgLwn9LFkRHGyAN/BGkZ8QJdIl1XherPM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6564086"
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="6564086"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 19:44:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="15688857"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Mar 2024 19:44:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Mar 2024 19:44:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 25 Mar 2024 19:44:13 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Mar 2024 19:44:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6KWoUytuuz0xd1wtAcEKilaIkZjuXiLrocRrVLeZvik1bM3THI9jD6GRxEElWeNGLxTav8+c+GB6RbVUxsEi3H/iLnihHqLbpahYHh9k2dwSPKAeHPxwp+zUQu2uqZmgHeEIz+q/iUUZe4Igyzs2J022QQgQ75XrCz4WeQIiqozuCAF+nFmEj/cS1oe1Wc45h1fUxDxG/E7HCJdlH+6MTExZhukny/EDlSPFRGDnNe5jfoqk+37IM+p3ap3dI/WHf7O8I0AFFVauwtTcWbWSASqrieq+4oQMU6MIDdq9Fg/xMBBaqNH6RXB0PsSEX2C/9y9zHqGSn1hnzWcN8jRDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2Fztq05o36b8ylT02MKdJSMd4/8FTFMe4FH94O/epU=;
 b=CpFQtPGqlac8isw8/l99Ps/HhI0nwxV3t9p41hbQ4f48UuR6fGynKdMlesQhbS6TAP/vIIGi96l2Yy+hjjTzgif7sAFUlfpYQTf+AEInESPcWiTOvyGwOpzn3TibdZO28mxacrNXoSD5rHr88P+H8wqT1r+L6btzi34IycU3TU37ELpkttvcqUg5ZEO7ltxJ9s7hhN5MuxH239VSjrjxyBz9OeVXBp++GffRPQ5d5Qy0RrQF2Zj66RFdJVE1aRhaiL4YagEtEZfxpigX1ZRFZbkGfyVAFhFAt/UVb5Up7Mq/PVn9NAjLuV5L4ZOIMQtfzlgbFh4uSX2BK7CWrQfVWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SA1PR11MB6686.namprd11.prod.outlook.com (2603:10b6:806:259::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 02:44:05 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::4d4c:6d3e:4780:f643]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::4d4c:6d3e:4780:f643%5]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 02:44:05 +0000
Date: Tue, 26 Mar 2024 10:30:10 +0800
From: Feng Tang <feng.tang@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: Andrew Morton <akpm@linux-foundation.org>, "V, Narasimhan"
	<Narasimhan.V@amd.com>, "linux-next@vger.kernel.org"
	<linux-next@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"Aithal, Srikanth" <Srikanth.Aithal@amd.com>, Dawei Li
	<dawei.li@shingroup.cn>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Yury Norov
	<yury.norov@gmail.com>, lkml <linux-kernel@vger.kernel.org>, Vlastimil Babka
	<vbabka@suse.cz>
Subject: Re: Boot failure with kernel BUG at mm/usercopy.c on next-20240325
Message-ID: <ZgIzMqiZzqUmqEOZ@feng-clx.sh.intel.com>
References: <DM4PR12MB5086E76CF24A39017DA8567189362@DM4PR12MB5086.namprd12.prod.outlook.com>
 <20240325125017.GBZgFzCXVxeF50uGVE@fat_crate.local>
 <20240325113433.e04c2b508ac325630cd113c8@linux-foundation.org>
 <20240325203714.GJZgHgem2TR1aVAVlU@fat_crate.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240325203714.GJZgHgem2TR1aVAVlU@fat_crate.local>
X-ClientProxiedBy: SI2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:195::16) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SA1PR11MB6686:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R/lgShEGuKdUJ5HC+EUvne5QozLFPqMzb4mXnDjZgP5cYS2LXTgGX6vI/AfzO/p4aqG/SDoCt4980OJX28T7EaGuFx9Fcw15ggxiVxl2f7yLWx5AM1pKy/eOtQgW18OS2fhOxFMFh6vdxQqgqWSlO9VWmPqR7fH3x2wmuR5NC1WYNvIwRW6oMB548KIeMvePtZKgGBoe/3qfL4R0Hz2+1yXumMhA+eVQS9anMmIVsdBgQt8NjJL0D1jah54WDX7r8mvzz6I08ktm67NrVbkdE+IwriS/IJiw5dYsC0qb+F/9RS81VtGgek9QD53TK4kMkjyfB4u+4xMqpzadHQnV1V1rTb4xNGxkNMEpeCPKaxmtAW176TIBWP6oKAOjom5tjt9QV70m9T5J/UZA2cBm8/UbqmjX2OmcPAwPJLX4c4X7YWN8RbR3/Qtxu3jFQZwGCPt/JIftdRgTU2fHPMQS/qshELZ/908s2RuTEVqp/3H8Il4J8Cb0QqSD+hwEsz4AkrcQCW52ol0icHbFsq4LdZP/XEPM3cXT0dY+5sat+tti+h7jtu2Xmn4XpT8fSsr59bWoWQ9FK2E36WwFZ1jcdix1u8AfUeiyade4jGQUsMY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VyQEKjmCLUze7ybw6uMC+qW9xkskH9jnFhRnwGJ/a/5PZGcCXWGmXbImRqRm?=
 =?us-ascii?Q?hy4kXF29lMhCdCNi8S9gpH3IxMtyMr6CXOHOjOJ/S/ez7LzqfFDOYn48k44f?=
 =?us-ascii?Q?kYsYRmeHB8cNzN5tBuHIjcmJCgU3SIN9lidGlJ2QiflOOAefg8tPSXKa1YB2?=
 =?us-ascii?Q?UQBOqWMV8pOxYG0Zkj7kFG6qWL09JGPrffAtvv22KdBm2E6WnamV3kj6z8Uk?=
 =?us-ascii?Q?f/Ez6QIYwmj8ccgi6qJfTL5L8qcFj3nbsrlfqEhEe3xz2R47TOgIfCxg9a3z?=
 =?us-ascii?Q?Ab/y2Un4d2uwxdrZU67u8ZQgCQr/oR2JmvIiJWRUKLvYNDcAKpsywc8Kz7xQ?=
 =?us-ascii?Q?cIE0uu72pUqvhQN+edBy1136QZVwQBSDME9SgSEPmLqao30hU8Benf0P6X6C?=
 =?us-ascii?Q?tno7uR4h0umzByPzvfEuwkXmlEzd1/7P20DRk7GBtpz+fwta1KdG8MqPt2cR?=
 =?us-ascii?Q?PFemmi36KV0bVF8GW1WO8t3opH6Z997qaoOeaRPxQqBHx0ZuI7JV2qfRKzq3?=
 =?us-ascii?Q?o0vWdPn6G1iQR5aPO41D7oTRBlaNRWL2WdJn0Cce9Vt0B0+Qz8m9HiawXUgL?=
 =?us-ascii?Q?LRAwSMqo6Kg+XO2NrUTRypSDiLxBfOEvDPi5KBFsdXJxecju+PmGCgcYqkwO?=
 =?us-ascii?Q?NAJI/qKlT5GjsJLvojvJGe0HbHjFynjPKAMtBMB2c4zpxHeA3TPmL/dctEZO?=
 =?us-ascii?Q?ZiCryzzpeMl+DHYvInxSNvfqg42fHp4Yzo3ZLJXZbEkpbhYzeJIerQuBeHZr?=
 =?us-ascii?Q?7drpmft8DMeC7BVixi+KsBOtwMi8vg9S5u7Gb7rfoPK54i1FkCK+98EQW7vn?=
 =?us-ascii?Q?oPQxTxd4q9W6/mNmWcaMxsddZysskM3bawZOfI4OFMPQYgpzEdCnPIOYVvLh?=
 =?us-ascii?Q?kgIHb3EPis0aPm4QOJs/ylz6Ci6IE8rwm6pHSkAUe4wDH+RMHNm+AqGghkak?=
 =?us-ascii?Q?jLzcetpD+AosW6VAth28YxQJyo/wAY7QOgyA5jXeBMkxDr+iYzUBZHWUu8vQ?=
 =?us-ascii?Q?1Klh4AhX6S820mA5lMXqRRZn1OzzGCFMrVw1DYWtikGYfgKDMZtBJpLl6GE1?=
 =?us-ascii?Q?NypVI46V461/Nv9+IkD/lpI34xnQt5yJR8o9OIz3BBjNAUuNc1BGQLSb0c/3?=
 =?us-ascii?Q?qkUUWG/5Crc8B3P9lhbGrULNR5C8hYN8fZ+c9VaBb+T5c8cNzhQJvRSZA89U?=
 =?us-ascii?Q?zfiucouNBAMDu4hwd3CLBmpWc7VQjbqN0AJWe+A3paXBogwSFNZJ4uGVabfo?=
 =?us-ascii?Q?zofkaT5mMdf0vwabWPJ0zKQMmYwN6NXRsxqU5z641d55kFGLuxGHNg8Id/fz?=
 =?us-ascii?Q?ySupqAyuS3Jt7nSWnfIXyMDNPeY91a3cS27CC/nl968gta7DEKhqCMwpKj5H?=
 =?us-ascii?Q?UnqOCfUsMf1I5p2oiAI+f70NgCvrb/QR9FGS+/Xw0ulv83vKToIHQxItAHqZ?=
 =?us-ascii?Q?WrVveRQMztZCG3YaYbKwElueFH7K6GJ7NBIThwaZFwZzPpGkOwcc14gaq8vo?=
 =?us-ascii?Q?no+m77uX+moGBuMSsBrDFYDOs0ZS0scbNn2P3sFgN8uhbx/xMvagTyNKwAgw?=
 =?us-ascii?Q?qqjescHn3znk6jDZAAn5j0MwzHbdCt076fHeyLvT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd474de0-87ca-45ef-300d-08dc4d3e9a74
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 02:44:05.5507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2cHAO5EhvE7lRMIcsHu+HLWff8YdzkpuTLVHXpC9KGPEnYNBaDAVWhDHbWx1nuw3EKSKiVCPKuHzbiOfsv53Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6686
X-OriginatorOrg: intel.com

Add Vlastimil for slab related topic.

On Tue, Mar 26, 2024 at 04:37:14AM +0800, Borislav Petkov wrote:
> On Mon, Mar 25, 2024 at 11:34:33AM -0700, Andrew Morton wrote:
> > Thanks, I'll just drop the patch.  It didn't receive a very favorable
> > review reception anyway.
> 
> See here:
> 
> https://lore.kernel.org/all/DM4PR12MB5086B9BDBF32D53DF226CBF489362@DM4PR12MB5086.namprd12.prod.outlook.com/
> 
> folks still need to learn email. :-)
> 
> Anyway, apparently there's some fix there.

The original commit 328c801335d5 ("cpumask: create dedicated kmem
cache for cpumask var") has some benefit, that there are CPU numbers
which are not power of 8, like 144, 288 etc where it will save
some memory. 

And 'slabtop' on a qemu-VM with 16 cpus shows it is surprisingly
non-trivial and has the third largest number of objects: 

22350   22350 100%    0.13K    745       30      2980K kernfs_node_cache
 11172  10693   0%    0.19K    266       42      2128K dentry
 10240   8222   0%    0.01K     20      512        80K cpumask

Andrew, if it is worth merging, you can folder my fix into the patch. 

Thanks,
Feng


> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
> 


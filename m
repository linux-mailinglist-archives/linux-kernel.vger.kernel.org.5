Return-Path: <linux-kernel+bounces-73264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5147C85C031
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA9791F2441E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E9A7604D;
	Tue, 20 Feb 2024 15:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VaFiqMyX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B301767C4E
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443696; cv=fail; b=pi3uLpdyNnYKFI/hnKDeF/3S00Roh3vkk3GERRwBnTbyIuZ1YKlyT1FGDfL5zGEpOkbjJu6eWEaZWXyFiIFTWwzlrX8250T1Jh6Hfc2D4thKodIPyLK09rEHYY6K5gJyRg+gVIzQF94z4rjJT+c4aDtKIqZTArL5jY8T8ZoPlc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443696; c=relaxed/simple;
	bh=cqkJ8dQlsbDTU9w3wStgIX0kL6geuagRjqiDLEsGdVM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HiSBYdxAH/pXBx5tPQgKHdqHsKKLou1Ge8p072b3iyuYeJaY0ZBQuMwhHfxiPz+eeJfMs4daJXrJ8hrs1uk69A8JcGBRiyBBW8ahr4L/PfmVO9lmELavna+6ycQViTP0u3+eA3OD3lyw4LpxhCoPmSYsOJGPgMsXbVIYDggom5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VaFiqMyX; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708443695; x=1739979695;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cqkJ8dQlsbDTU9w3wStgIX0kL6geuagRjqiDLEsGdVM=;
  b=VaFiqMyXrwM+KIkY9JT8vBJJ0anyAfeXUEWN7re9gZ0zD+o+IGRVdMyN
   mEwtWHq1YfU1aJzz/1by0GvtwT0DKjVXuXpSJos/pvzjClFg9N8FwhVnW
   E3I9Cv9elqaQUOMwwJlMse4spMNw/5f0FZzodMSfrrhWL1h1Ok4gQ9glY
   oYxU5rOciyzGb8AWYU2CABfPIGwZphxL+aBprIBqGUnVNFqNRxZ6ml2q7
   b2Pc42MEh0QefxIjeb/CriI/Cw9DpN97bEUXywSuQ9OnKI/+Ge0ew7RGb
   L0VZgZKowSAfC5myLTDtYXHd2lOMzWTd4wn+Tw1QdNPlhIaCxT8HJLz96
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="6370121"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="6370121"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 07:41:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="9416976"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 07:41:34 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 07:41:33 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 07:41:33 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 07:41:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsUVCof26RWKUudsaFQRvfyFCRgnMz08Z/dqNAw5WezgLBH4Gczfh5Nb55WDQM8XEg3qLTWkhglLkADt97MXluC5W5lcZ9bn+yxh6cv8yCmC2Y4Lh8FyD0nyxZcY2XnPdpNwuEX4oN6QnjCqA/ZAWMI49HrUV3X/9T+ZqiKUiaIywS5sR+E0nKicxnuTE3rXZbKfP4aBY7nqbr+L/mIC9L7IX809iYUw8YngXwh1Kk38Hbpcckp3AXB3UVcs7PNtWWjNkfPD9zYznDk+IK3N5z3lGI62CcZ8tCfCUCImCSCGMesd1mt6boPxf0is6/CnI3SBipvhyRIl2GpC5X0y9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vU+SX5rW0+7sFnQ6qfC/7O+R0btOD2h2S5us0HPXPg=;
 b=KPxXnwhBih66xk9jnhrspj7hh+wH4clCY8zRX2RomPVW6g2pPFVVOpUefL75ThCwGi/2Rdr4V8LfCvvIsFyF1oxKc30LRKW+MNjwRDZ5kplaI+BWAppbJc2eQHC4QIMNdy/2NG4ndxpVOSS/8HcVI0db78YvDaaezJSXRhU0B/vW7LRjwMPpNCeD5uVyi8Itts4V+ZMD5JHYH3rwWos8e1UMwxQCL6AvQVvQsGGLUq/xiAcLUdeMEXS119wjlvCB7dur0n54vwTw9kPZa5PyREyJRudzRe6B7h4BYY4jhMkL/0fNvJ30/7lhIWUaAWnBZ5V0HLtG0QObRPV5PH1nvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by CH3PR11MB8094.namprd11.prod.outlook.com (2603:10b6:610:156::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 15:41:30 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::4d4c:6d3e:4780:f643]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::4d4c:6d3e:4780:f643%4]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 15:41:30 +0000
Date: Tue, 20 Feb 2024 23:27:21 +0800
From: Feng Tang <feng.tang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: Waiman Long <longman@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, <linux-kernel@vger.kernel.org>, Jin Wang
	<jin1.wang@intel.com>
Subject: Re: [PATCH v3] clocksource: Scale the max retry number of watchdog
 read according to CPU numbers
Message-ID: <ZdTE2SzO1pZ0QjUn@feng-clx.sh.intel.com>
References: <20240129134505.961208-1-feng.tang@intel.com>
 <87msrwadvu.ffs@tglx>
 <ZdNnjdNTjtvpbGH0@feng-clx.sh.intel.com>
 <388686b2-5305-43d1-8edf-19ba66d52727@redhat.com>
 <0b7833a4-75f3-43ba-9d87-6f83cf4faa5a@paulmck-laptop>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0b7833a4-75f3-43ba-9d87-6f83cf4faa5a@paulmck-laptop>
X-ClientProxiedBy: SG2PR02CA0100.apcprd02.prod.outlook.com
 (2603:1096:4:92::16) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|CH3PR11MB8094:EE_
X-MS-Office365-Filtering-Correlation-Id: db82b271-f221-4481-67f6-08dc322a6899
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GTKiUlSFSPR52mlBKKoj/aPRnDZEnsEFPqUtcYmEMlexAftq3SNmrSBp68rZUci4v0JPYixTg1IGxtKKLIyBAmDepkwPcN+83RDQnLcRi8zjfZlLFKI9tTOi3L+i0Og9jxS0QcBSghjotpXWi0o6KmD1QCxHsr9GEC+yQOpm5ZBMeKoh8ZKJEtN3vVoxaGyHcxY4iU8rEZLcb5gxcIh5xlYqrT99SLd0loEespkpQ69Mz9xSlVmWLFlEsztuOl/QmU7FbY+SF+bTK9gNRSeHUBZEUx9q479ViGV+rMZf4+Tw+hLAQYj7ZzuLvBt+ZUZJ+F5MnWfr7gMRZVj51Z8jMZZyhLI4BdFxbjHk5KiljulhjRpcKuEbXy5QKXQ/so6Ai5LvdTB65IwBaZS5GSfT6jXEN0G2v1vCqzCgxNNntaTllPs0xmkOOurSkcgzwyykgIlw0W93PiNIp4uDOfpPgklgs82dJahA+0n41PBxbOmVPD+8QeD38zJMXt717b88ZJYx2kbKIeg0pkeJqQ57BjEBTKubtMc8C9AlDO4Obuo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E5nGaBenukb1wrrA6R0KEN9uVqXMaPRu6IHrpMWzioMAcMXl7g+8NNJe5yrN?=
 =?us-ascii?Q?RSGRSkW1qRseXkWIAY4fFaCRJsaDqf310TtOIkrrEO5RyjVF779Ea3xdSDFu?=
 =?us-ascii?Q?kk+QsGkZviIEAfvgUR6FHu5mCOMqfH6ndtE5wdStniuniEMFS7Z1DyYYwjpQ?=
 =?us-ascii?Q?zYARtcQUUpvv5pJyKO1OOX+YrYiEwb6r0WGBvDHtp2/wxOIV38a2jVPKfMoP?=
 =?us-ascii?Q?s4vcb+5/XmTE0qaEjg9mnj13EK0OOxAm6auT6uZ/8rKO9EszusJ22UbBfOxe?=
 =?us-ascii?Q?/HIr0vwJD6EsI5KsY8pRiKpCX6ptYVaB3ieLLH0+F35MoAZKxLCRkrB7Y8DV?=
 =?us-ascii?Q?bGVuCsbPBvmrPzacRXHOQNNic8FTHbZUntqXlCMOIO35PUkVC8YHILL8dtdz?=
 =?us-ascii?Q?H1S75UUJvnZ47IeR4SLxxu/Xtz06Rl+NVF1aGebWWwZuq9IreYIlgjkBfh0p?=
 =?us-ascii?Q?dos9mDRzc7dc3l0TJ3vYZ76wCimna2hI1d3PhXj3DkJFjXPvdy7/Sn1OtbRD?=
 =?us-ascii?Q?CPagCf0s4U13+4EtgdednCB6LCrSYcpu0Vxy+1CRM3AEkFFgJPGHsgg2zgo4?=
 =?us-ascii?Q?3IXTpXlDGrEx/ZOH8AzsTylbmNkpyvnhGouWj+4fKZMAcPdSLHZzWRDNGXlx?=
 =?us-ascii?Q?o4owWX3EETSjzAndDytIREJuI4a5juaXasuJBqMNHEbIL0kPqko1suBzTENG?=
 =?us-ascii?Q?SVfgtueCJmtsBnMLobeMjGMkasNTbB3YaLxagiGwGfj5VfMij3f62G3RZ2nf?=
 =?us-ascii?Q?eS2ZcxwApghfUFknaIxA3ul0nQAX059qsNLtRqdpFF+4msbbAr6A4gFFRqXo?=
 =?us-ascii?Q?ZishBD8PDrG+caq1fwQ4rjCa2A4ifTQSJqP0k/SjtpBY0aJvYQiwwFj9akHi?=
 =?us-ascii?Q?M2KtT1c6oWYuARX7MpU9qd98i9KxcSNKy6oUvmG1iI+SVRidWA7o1VOUJCL2?=
 =?us-ascii?Q?o0OTH7zJFDeN3YFz+yij2wUEktLQYl5c4pSMQI9L/p1EPGhpAZ4hC/1xcCaN?=
 =?us-ascii?Q?VmBLT9ViV1FFNN7uvGMJZFlGnP6uKwXXN4OuBefAefJIJmaYtp6KcekBH/O7?=
 =?us-ascii?Q?7nj8e4Japd968Ul/8CTG6LPiaOkCeK2L/c9Hc3jChodGMnrDE3JPOSoi/hdr?=
 =?us-ascii?Q?cUpsIbUXQT9TCHnU5Su2T6IODMaBJwJxyH0LSp6HHjMqVK577a/HFeOCb+br?=
 =?us-ascii?Q?nmceCC6iaKbbcWJ5O/9mSDnbMl10IQu95m7ElMmkqJCTyQXBFjfm8fSciuRJ?=
 =?us-ascii?Q?9935of+6hrN//WypH6Cj1bYfnqxxNq8gDcH3AJoLpfc/c3GkNwZ+WmwthDHt?=
 =?us-ascii?Q?iY7ZDcYjpTyrkNT1qH0ji0onhZ2qXNbd+0zSfzo6MGV5WSntpxjhTBa/9zI1?=
 =?us-ascii?Q?9tddmHmGRrF8uNsjbFhZqMWI+G4ClIrqqQ8Og6CjRlYK61sFAXNrv2QlQmAT?=
 =?us-ascii?Q?rmU4IyfEL2xUxaqvv1Q5Lwud53iFzcLXVSQhS0XsIJZNFWv2VQ0jvMtKua//?=
 =?us-ascii?Q?nHsanf6YBsEBZiZi6dOOogSpOwhaQqPEvwu86ic1JFwhKXs1cLSG2eQIOdT0?=
 =?us-ascii?Q?rpcQamdzwNGpHrQOQ4EHYC5ie5pPcnLRsqi57cXQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db82b271-f221-4481-67f6-08dc322a6899
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 15:41:30.6019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6dasKC7BrWORSAj5W/nnfrMurHceP5bsMT3xkWxmtssQ0mt4yjC6sgdZIwd5qgvmFR8Ax7EiWAlp91XhVvIjAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8094
X-OriginatorOrg: intel.com

On Tue, Feb 20, 2024 at 07:24:27AM -0800, Paul E. McKenney wrote:
> On Mon, Feb 19, 2024 at 09:20:31PM -0500, Waiman Long wrote:
> > 
> > On 2/19/24 09:37, Feng Tang wrote:
> > > Hi Thomas,
> > > 
> > > On Mon, Feb 19, 2024 at 12:32:05PM +0100, Thomas Gleixner wrote:
> > > > On Mon, Jan 29 2024 at 21:45, Feng Tang wrote:
> > > > > +static inline long clocksource_max_watchdog_read_retries(void)
> > > > > +{
> > > > > +	long max_retries = max_cswd_read_retries;
> > > > > +
> > > > > +	if (max_cswd_read_retries <= 0) {
> > > > > +		/* santity check for user input value */
> > > > > +		if (max_cswd_read_retries != -1)
> > > > > +			pr_warn_once("max_cswd_read_retries was set with an invalid number: %ld\n",
> > > > > +				max_cswd_read_retries);
> > > > > +
> > > > > +		max_retries = ilog2(num_online_cpus()) + 1;
> > > > I'm getting tired of these knobs and the horrors behind them. Why not
> > > > simply doing the obvious:
> > > > 
> > > >         retries = ilog2(num_online_cpus()) + 1;
> > > > 
> > > > and remove the knob alltogether?
> > > Thanks for the suggestion! Yes, this makes sense to me. IIUC, the
> > > 'max_cswd_read_retries' was introduced mainly to cover different
> > > platforms' requirement, which could now be covered by the new
> > > self-adaptive number.
> > > 
> > > If there is no concern from other developers, I will send a new
> > > version in this direction.
> > 
> > I see no problem simplifying it.
> 
> My guess is that we will eventually end up with something like this:
> 
> 	retries = ilog2(num_online_cpus()) / 2 + 1;

Good point! Initially when writing the patch, I did try to search if
there is a 'ilog4' api :) as the ilog2 of that 8-socket machine is
about 10, which is more than enough.

Thanks,
Feng

> 
> but I am not at all opposed to starting without the division by 2.
> 
> 							Thanx, Paul


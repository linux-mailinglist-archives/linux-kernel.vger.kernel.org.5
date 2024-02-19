Return-Path: <linux-kernel+bounces-71509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1786685A669
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70A26283737
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6ED25614;
	Mon, 19 Feb 2024 14:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hWIfrRFn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D9F1DDF5
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708354288; cv=fail; b=so8prh0Xesrgr97xgz5R2iYEInF7xZrmrRvZdSjkEHRxUj1HqfpO2qH2kJ/D4HT182vXdsBIz1yD1eXGp4fWTm+WHoyEH1uE5x3C3EQhjzc3ZEMOqlyzWU1OqLlPwhVc98LPF7YjMJrGHUh3O/vvdbVynphc4Kt+0rHjpeWTG+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708354288; c=relaxed/simple;
	bh=BoLKEqQGsLvUE/dKa3QTEY7V8p1CIe7DHtivg6ZIPlU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CCPxtIcauwPuIPffMMAMoX5W3u1EYLNkE/w3V6D2XWe4NUcDwj2BmHwTH7GbPVEyx9zY3J9TXzCp1rFZ3z/fMfwwQh03bNl78/wjb05tJAWfxqMukLRcdleyBl9sIuFpDiD9N2VsPKMfCPHIi7AAGPCMLSNgZ0/sHjfcd+fmkHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hWIfrRFn; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708354286; x=1739890286;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BoLKEqQGsLvUE/dKa3QTEY7V8p1CIe7DHtivg6ZIPlU=;
  b=hWIfrRFni18lsaNnnlhqyhl3yfI/49+WHkZuSBzZLaSpFXoyXX3Us8rT
   37g1SOib71zHGNbOYcX1YjDRhERe942vuulvRrL9m7QCzNPEk8Wlt8Yeo
   BmesmwZdGmHtHbjbfSm3gBW7gs0LNjieLeFYTYAJ62GrhvSGS24/toKCm
   J9efr4Cr2Fx0LW+aBZGq98V1wTbArWI1qaLIEKulpnXTZclNa7tzI89ck
   S5Vs1Z8osHOFlHk8Oq3LERAuwT0xtoCnqwIx1EBx7vb5zS2+rg82SpXHM
   64tqJWqeCg1JEiSB9EEUG54V2bgeLvdKYkXfmOMR5EiLYzljEIK3fBd0b
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="12985527"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="12985527"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 06:51:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4798820"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Feb 2024 06:51:16 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 06:51:14 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 19 Feb 2024 06:51:14 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 19 Feb 2024 06:51:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jfctll+SlZgOnLi/nE7LzdB2obak4tn4douO8fnPgcjDHl3GfPGgsiCY1sH9kWrtJLLROLHWpneaDfwbX8FfimEKfVTM91odgm3tL+yfPQp7q58gRD4Y41mugzz/IU5xBOl1y7sioOKq/eTfvVCCExnC7l16mJh8HWTV8SnFB5y4YJb5fGGtAxWIY3tuOjtmQOL4YnmOe5PAyHuXrK9WWCET2gqard/dtiZUzWq9WTog1+x22/OdL5pcooJsF28GEnPoWvvt+iCTMlgOrSeY7Y6sX1KBJRwAG/KS5vLSJb882zmZNEoER6rSZSB03zdchjDwf6+N/Mt7JZi6z7dN9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INNPU6i3KBWhdNk+izTLu2RTYMGn4GqE9oMDZnPooFk=;
 b=HAx2sTzkwUAK6j2lpqSr1PXjFnsRTZ8POKDjdPj8OPFhFh8mQnrecjzCJpb0YtAYXH5QhQY8iLHnl/F/nAIguCD689T/VEBVwkjFCjm3bWZPtBg1fSvlQsemRCU6e9LBCbD+vcH+LQAXoxhTQCZ2a3GIHmDUjiP0bS0sfq6nAQoskC5DGO7WRmG43DRnNXpcYRnlPu/1TFs5MCzvX7g3/naWrLg+pVXBpGI9aEmwi01LMTH52DgiobrdZ++IjxDPlTlvb1zH5PWzVyX7kWd7d1aQ53Nvn1mg6paGbQ58fomHkeOJ+GiAYRyyVSGrpX38qp+cdvihGMosSShYMD5F0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by DS0PR11MB7801.namprd11.prod.outlook.com (2603:10b6:8:f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Mon, 19 Feb
 2024 14:51:12 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::4d4c:6d3e:4780:f643]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::4d4c:6d3e:4780:f643%4]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 14:51:12 +0000
Date: Mon, 19 Feb 2024 22:37:01 +0800
From: Feng Tang <feng.tang@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	<paulmck@kernel.org>, Waiman Long <longman@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, <linux-kernel@vger.kernel.org>, Jin Wang
	<jin1.wang@intel.com>
Subject: Re: [PATCH v3] clocksource: Scale the max retry number of watchdog
 read according to CPU numbers
Message-ID: <ZdNnjdNTjtvpbGH0@feng-clx.sh.intel.com>
References: <20240129134505.961208-1-feng.tang@intel.com>
 <87msrwadvu.ffs@tglx>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87msrwadvu.ffs@tglx>
X-ClientProxiedBy: SI2P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::12) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|DS0PR11MB7801:EE_
X-MS-Office365-Filtering-Correlation-Id: 804d5def-c0e9-4770-057a-08dc315a3721
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 41J7yWn5dhsIADNSHmQAy3fYvOWbxgBPziwvcFsyK9kajIqVQvvAda7q9RF4QHaaq+AZ80amAGJ6YfxHY44KkzVbcMOS/NBczfWHMpWNSV8uramiQIOCNvZf42zUGXnCGV1PEIYc+cRICNd4BSygkhBaQmar+eRl/r0oJ9gmofNZObYnD+wR1XZU7clhRZx+XVvTNML3axqifbcnTI1aTaBZsdvPQZhPjkvT+/4KFB5FUaJWhZk8XXh/hR5tHZ+45/hymCOLovnrCqzlS+UuBtpP2y8tUWYHFHMMeYYz9p4gZ1NS2ZBp/1bdo9jrZ00SaQtkzLi4XsJj1U+JTMjsDCmcr4SCgGqgpOorau0ahtby/dt+zatpmKJlw+b3VGyraCqS2hlRfI87nH5igvoLmC+pTfcBlvR47fueJujFZlq7kXMHzHNc6jHAuWX4NDax0wgfK8129KTdDnniGr04rXopuiZyOXhN1hmTu5wrZGf5F09lPmU0zDByQnIHwyR6TIx1p869XrdvS+OCnnqBp+rsOixTkWZzT0llD28S2Kg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tRE0qgXyisMSGm1Uc6+VV3gW5hrUXWbEXyRCKMdFvVBVySZSFSleZL1OI+7M?=
 =?us-ascii?Q?+9dR3yE4DzdAoaS0dnRZEVD9wpIWHUFrGHBy7jXfKQWY+xdveqKqRqsbQlmU?=
 =?us-ascii?Q?kfWH8aiNg52PhciEGMfrsIrN8zLxQUKE6bi2xJ2qzNauJ43AD4f4N7Zm9cql?=
 =?us-ascii?Q?/HUOR0LVj0sBvC2AWVKgLFibX+WAjiQ+MPPTEhltE7oJ2TtUzgDtBDdjjsy6?=
 =?us-ascii?Q?8CsEk8igUYpTKsomouZE1Ukmfiilivjf40RIoY0RTL99AVLhTbIM1noV90iM?=
 =?us-ascii?Q?v7ZtwiOThQ5LxH2nj/lJVSsJWVW5f/sfIpZi+1A1LNLLKno5WISNf/goyllr?=
 =?us-ascii?Q?CSKXk62wk9w4G4GT6NwHQvjXeQueR0gbbTckyN2StGjEGgMUzjga29RbjNB5?=
 =?us-ascii?Q?sTo+USzs76pSUoG5ClmZ6KCh2d7e3RMKdyJYTt2j/8n66SBvtEE87TZvtAmQ?=
 =?us-ascii?Q?vdqRUwAgMiq8wxx61BkVFLaY2xbQhMlNopmPuYfDdo4TZvUgYox/3P61Uw75?=
 =?us-ascii?Q?CkqvbZCsXsBCiab9r5f/hR1Z7J2nldZ+vAbVzlnPR6aRlc4Wfyh/VyQm0h6G?=
 =?us-ascii?Q?BngQXbeeK1VkcQHzKZXQaBlQzN68mHWKHHN/VW41C3h/SgReQyUTXm1adZDR?=
 =?us-ascii?Q?UQKSI1E4wFYUI6YrMmZ0m5wbC7cPZHOAHwvAt/gpNRACR/9MOk9YHNsPqCBH?=
 =?us-ascii?Q?K9r5v26LjHys5nWAi/KghzMe7ESCsmRmkXKl0WQ4ZdmPdfdy+TpWKDbluNWG?=
 =?us-ascii?Q?jca51hf5yL5Yxgtc7ZSy86fyu9FCuvlqaVeNCpghd+9fZtve09v1+itXR1l8?=
 =?us-ascii?Q?fUtlw2YkUxqkUsm8VeqMMd3/esdiwO1NyxudzylFhYeeIFgJX14C7ubnbtqy?=
 =?us-ascii?Q?frwlEeJYZwScbqxE/k0usCmh9cOd1Z7Nr6XHERr7hqv755vvaqM1w323YxEU?=
 =?us-ascii?Q?LT1qDtODHSdIhkA8V6FiiYa76/wGsV8423BP//viebzUtWta7YDjs2xaLd4G?=
 =?us-ascii?Q?4NhInmZPjBctTwR0JwViG7SWYDIeimraK8VwCwnDoO7H26zSfu6biUGJRjwu?=
 =?us-ascii?Q?Q4RKDLCy/3Fju2kZPZzlGbqn+bl+QftP4B3zj89nzKXA4FcHY95dtumt2lrC?=
 =?us-ascii?Q?hBTll0CUuA6MZxzUZsoLbGIQOX9Tqr4sE+eoXnLd7+hucdASlfhoQqcluCXl?=
 =?us-ascii?Q?370lZJ+xiCHwM6AI4jgF7ZOJ4pL4lzpB/bijEV2vTpRq9BjhaaEPm+aErbVN?=
 =?us-ascii?Q?pDYuAFs+ADY1P9ol9dXGu3QXP3hQ8RGxTUKrfwydfdh7QkTwazSJSLRssIJv?=
 =?us-ascii?Q?pzKGtkFSdTx+WX0TOEfiJdZe9JgOHsfiRvL5wz8kZsCOMP9DVYcgTBnu6QFR?=
 =?us-ascii?Q?J8lOW8Sz4JB7uYuTK+PqdmpNhCds3Nrz3nE41805lLXMn9dVQ1kp2PyHtIva?=
 =?us-ascii?Q?ETFiarnxG7Nl2RTu6eLkOkC/h5SEhaoNBrAtdHdtRSWs2aJPQYFmwjvfLZN+?=
 =?us-ascii?Q?0idR9D2DlCvgWneNgY4+2dSv71tZTBJoE+v9YmlAwz1K9uY1yIi0vbOKnahY?=
 =?us-ascii?Q?XpLhRi8ZFsKx/KaLSN+aegTA37Pb73HxPHKfqVLz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 804d5def-c0e9-4770-057a-08dc315a3721
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 14:51:12.2456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lteaOfpBcvkvf2QWxyVIw+4ZS20lI0r31qg1p2GcZUuGQWQhXxz/gi4eqYYqiUa8lwBM5hiHTBEyr3of6vbazQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7801
X-OriginatorOrg: intel.com

Hi Thomas,

On Mon, Feb 19, 2024 at 12:32:05PM +0100, Thomas Gleixner wrote:
> On Mon, Jan 29 2024 at 21:45, Feng Tang wrote:
> > +static inline long clocksource_max_watchdog_read_retries(void)
> > +{
> > +	long max_retries = max_cswd_read_retries;
> > +
> > +	if (max_cswd_read_retries <= 0) {
> > +		/* santity check for user input value */
> > +		if (max_cswd_read_retries != -1)
> > +			pr_warn_once("max_cswd_read_retries was set with an invalid number: %ld\n",
> > +				max_cswd_read_retries);
> > +
> > +		max_retries = ilog2(num_online_cpus()) + 1;
> 
> I'm getting tired of these knobs and the horrors behind them. Why not
> simply doing the obvious:
> 
>        retries = ilog2(num_online_cpus()) + 1;
> 
> and remove the knob alltogether?

Thanks for the suggestion! Yes, this makes sense to me. IIUC, the
'max_cswd_read_retries' was introduced mainly to cover different
platforms' requirement, which could now be covered by the new
self-adaptive number.

If there is no concern from other developers, I will send a new
version in this direction.

Thanks,
Feng

> 
> Thanks,
> 
>         tglx


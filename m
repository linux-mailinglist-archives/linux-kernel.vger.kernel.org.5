Return-Path: <linux-kernel+bounces-153074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6278AC8A8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7AFE1F24910
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA2753805;
	Mon, 22 Apr 2024 09:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kaCVNVGq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8974C66
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713777374; cv=fail; b=RWk+w0Epi+D3AQwKP1ck6q/bi0boUvn7cL6EKKfoWIR2ZWJ5G5mN265AZFxwkNmK/QvDSwYLyfjnnAFGRqSEIJxAiqBCiAnXcNORF4qA7msO3cSJdh6hxJYgyamC1peqrGI1g9KEd8h8h45xJ5baZnag2SygZ8Zle50e/sSLmfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713777374; c=relaxed/simple;
	bh=qm2JS5Vtvf2Ls2+vbfbcnoYWRD+SsMyvNcluxz64UoQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tyVfjY263CwITUO1Be0lvYEP2xkWOEhsSQPoJWN3+ljSZSZYRYmbpk9LDqzOjgyScTqHjZhLPwe+xsn+1OjopVKe0z9n5ux4shvF8pQEjKxNKuvNFyR+OnwCNb/nrSrW+Mb5h0Jk4cu9bo/ah+rhNZvSnAN/DGwpvwJ7An9kuhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kaCVNVGq; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713777373; x=1745313373;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qm2JS5Vtvf2Ls2+vbfbcnoYWRD+SsMyvNcluxz64UoQ=;
  b=kaCVNVGqs66oqUli95dKBbtUSJ2WErfDN0g9rDnzyy1jJXIZQhFoDFvK
   uTZmxC046p0MZIfy50eslBevc/dU/7GvA5uO6WJbEmEnXyg7vtMUBzDFA
   SAVCn+iZtjJ6y5+OyTOGPbJgFsBxZ+/Jg8NwtCr4gGxt+2MFnU84vP0ib
   /MkDT55+v92zGpvkVVo6/5ie8CYdYQ/S5DemnLpKPn3NkcUd9BVh2w7qH
   DTCQMcj1tHjOEM0J4Z15WFcMUXuA6gEJB9F7BmR6z9FAWwxnl2ZDU4Pab
   cw/VGp1ktpXgI5eBDzTbSo37xUVuxHW+SYR0yXClotxgFjoeuetyg7+Gr
   w==;
X-CSE-ConnectionGUID: 9gbN4AZsT2u9/9iXOY5wkg==
X-CSE-MsgGUID: qIQORS0fShKss8rRas8h1w==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="9222973"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="9222973"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 02:16:13 -0700
X-CSE-ConnectionGUID: XHYp7S1RTKKApWWSXfI8Hg==
X-CSE-MsgGUID: AG++uJbwQPmRu5+QBa1jfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="24006739"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 02:16:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 02:16:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 02:16:10 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 02:16:10 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 02:16:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOTbdL++me31/ybaI64J3DeysG13zI5JUnYKwrAqwVjEgtgva//U3Jr3dNc/YYq0yOU1EnZCwhQZFQ8UkRLCVoAEYaQWoM/f2HdcUStS1JAb4qn2ihzqnqNmsJzjZ07ZTct9Ri4+0/XGGhc3j3h1RiG1/5z4u1TEqEz5v+JVgA1pKSIcAXoHQ5h1kdlcU7uYHpnIyJkUwjiZyttYPfaPavVBjz7TadxGekybo+FscJyqM8ySAofSsS61X7zUbvpgWgmdLnRbZsqNK9dKY8ZrdPR6rwvwrijpY21JDKxXuHObh69gve4umvnHyERldzhZVQ/kbKLB9aWUu1YBRDK1kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRBk19xCcdfuFCiaVSRQMf4FuLdr1xy+cuIAlj51lbE=;
 b=A5Kmndi9HGU67RI+FrfWlE5CTDqVhmaJ2LQuY64eqXMp+E5dKn6kfCQFZ6Y6YnF87vW3nCXfc1F9C2uMBdxNzMdfDJQHsn4pXT6rttvdzTkc3BJ4WZovmMIgJmsL0owtA0S0vILIqK+siPLVM/stUGT854iOOj2wGcgDYETIIX4XV5Bcv+vBnuz3pVIO1XHH6IGzTDBvlIKareF+MOd1AHsRLRqhg2th/AoYxLgWQRHCLv7xYQWFxeEVPaN6AQQjru0OKeEFQV7AANQ+Mx+Hs8YgP+KVOMA5M3VPJx84CJIEfrM8Gyx1BAKazu/VHh8CEgYUiHkNNl0TGnE2zT/XaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21)
 by DS7PR11MB7931.namprd11.prod.outlook.com (2603:10b6:8:e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20; Mon, 22 Apr
 2024 09:16:03 +0000
Received: from SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::c0cf:689c:129c:4bcd]) by SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::c0cf:689c:129c:4bcd%6]) with mapi id 15.20.7519.018; Mon, 22 Apr 2024
 09:16:03 +0000
Date: Mon, 22 Apr 2024 17:09:31 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>
CC: kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data23'
 from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data23'
Message-ID: <ZiYpS07hAGbGUkrU@yujie-X299>
References: <202404190642.z54cLsGE-lkp@intel.com>
 <b6ae1121-a900-499c-85e9-07ce0d6739c4@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b6ae1121-a900-499c-85e9-07ce0d6739c4@intel.com>
X-ClientProxiedBy: SG2PR04CA0184.apcprd04.prod.outlook.com
 (2603:1096:4:14::22) To SA1PR11MB8393.namprd11.prod.outlook.com
 (2603:10b6:806:373::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8393:EE_|DS7PR11MB7931:EE_
X-MS-Office365-Filtering-Correlation-Id: 272c148f-db4b-45f8-20b6-08dc62acd56a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nH1bldq6yR75kv7WWIA0xhVYwudNSAcUdFwOrctIJo6vn9CronIqifI8+lGB?=
 =?us-ascii?Q?P/J0SvgpVdHHfqoQENJNzMW84iCDBFpd9Ph1iy3/U+XFtakpY5dxvRgh9FUS?=
 =?us-ascii?Q?3hUlA0iMikuYa3Df9eVQhOHh4qPG+22a6DUOZmduHp3ZwHgJa79S4xqy46lD?=
 =?us-ascii?Q?qegfRq9zg8PqX0FuqBTyXEzbAglIfdnxbjK6Lqt3UM7yok1C8GSPAqV9JFTH?=
 =?us-ascii?Q?6e1lOK/4TfF9YT7NfwKLkM4Ad+nu9ryY3GeGlHPIqXqrOAH4k3/pKyrs8AQP?=
 =?us-ascii?Q?AIRK/1Nw2EwWdFZ5oLXSt8BpNVL2CbzbzMEBfmiIyaRk7XEWq40EqTVmOsTP?=
 =?us-ascii?Q?uVi7YYEkV3oT6WybUtg8SKMVNiWiYL+C1/crBlRHiWhPoFAppckRyx+5QcUa?=
 =?us-ascii?Q?iYL0wutFdY1TRtlFT3sJtWJI/+8/6Y+yLsrS7quMxPU6+kQ1CcCLigwu1lo6?=
 =?us-ascii?Q?FWPpz0GmxaEkUnK6mTD+8ywdD9FyxRcHHJiNhnB9mGpzNKTly72v/ENqgio/?=
 =?us-ascii?Q?5qjxflkcD1mDlzvhykdANNfC1sgjp1z1CMuaNem19Y0ie5CKS9U4Oul6JLgf?=
 =?us-ascii?Q?ZsjWj+OtrqixvLjblRF/zN7KXQL5SfC85yVp2xuCIeL6eoDzTgbWrWOcVVyv?=
 =?us-ascii?Q?E6f7DE7oqKFkQ65p42QHWFRU6H6o1M9hMAoxs4UdXD8i7g8LO2fOv7GQcIpU?=
 =?us-ascii?Q?sRDviK6K30I1wk3ERD8wmYbG2Aw1nHRufhP+dLYPQRmYMEgDLPEcHythpVZM?=
 =?us-ascii?Q?4zz0VyfTRI5kfhzblE/GCeUaqu9IQ/rpfU/tX1cDN4SFgc0Z8ZlXLip81pcT?=
 =?us-ascii?Q?y2uj8davr2P5aPoNg01WqcbsyTmhrZ+5IeXkQZk3Bujvn/YS24A12xxvpjdP?=
 =?us-ascii?Q?ZwbAp+EPlktxRyvT8cI/lb3uaptdrvuMuM240/FxJqc31EttfHtn2mM8i9BM?=
 =?us-ascii?Q?owvtx0g9TLyYyPHJ/0fZL7hjOTJQChWh9CMWPpsckbrcMaWcmFYjhqh9AH1o?=
 =?us-ascii?Q?i/VCZtorvRIL5zSR+yfdM5zMf+ovSIo1KGZosGps4NeoHrn8ZkX6ZawVTuqB?=
 =?us-ascii?Q?jN+W5wLjfdnGlAyLWe8bPtILEWitNOe0iWzmgtkNgjYKFq5HVlu0ZG1OrUPa?=
 =?us-ascii?Q?xs/7Nw2FvAcMaounKhr72uOhrumd4oisRZCJbJoDL30diAkE8e9QuImcSJY+?=
 =?us-ascii?Q?KF5cSqDPPkOFYujUhJypRfw7/o3n0oh1k3xypVhNW40yUypWRBPORmVvo+8?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8393.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zU8nyMg1cWuFwDP0yPFuPlDy/teX7NEk1Ggkle3gUFqK6/zr7WCi2Vn12EKX?=
 =?us-ascii?Q?bVSlmhVne5bL6JyzkG+w8zT2ORc6EuwX1oRuIoH0tt4r8SpAv1ZZD0T+ure8?=
 =?us-ascii?Q?ko+/kUv86jSUGuufOQH7QdLn+g2mHfb4VcCEfTN9VWPV9DsJvKDykjAFuWfk?=
 =?us-ascii?Q?xjFGGb+LoqHDCHxjlj0FYxFR5/cL9efsTQpxDEec9QbSraOJ+W2hQRmrF3w0?=
 =?us-ascii?Q?29p039MtGPL+1nPSGO3IEvhV8o2WL6kgx9LC7wWKnLMGPjQ6rvTcH5SondIl?=
 =?us-ascii?Q?Ty7S1SJ1kixc81rD8tghBBPLL6RYZ4yaMKInkgVh05LXaztwDnmQcxQWctDU?=
 =?us-ascii?Q?CN+44t7RuUr18ZlhyfMKROdsa79dQr15p9ocakP3Mw+6wgZCjfEXm9CkfspJ?=
 =?us-ascii?Q?DxYc9ASdS4L2W0ZYAVhVOyOjdES7v8soRDNMy1DlodmsS276sPBiloMV9+NG?=
 =?us-ascii?Q?UpjzrO9zOfLmwm6gVj8//vBvHBbTLYcUl663rNEpqDd1xUErZ6h6VOMdqgCU?=
 =?us-ascii?Q?1SxeddmEy5YNZnzh2mOcG8Tkgs6cIAV9jZA7rWL7roDpXkESvv6EHjn/m9hv?=
 =?us-ascii?Q?yHdLXCd9Zw7JKBsbmxhG+j5UlZY9mBEdemHh1DU6EbDvKQLatuTr2rWi34DN?=
 =?us-ascii?Q?mpt2fg1zsQVXsMogi/nPD01jE7yoFFCl1sNC5Ubt+z3ImLfWc55j5x4XztAY?=
 =?us-ascii?Q?852SadIYKaUqWkrkiXNfQ8dviMk4RET3j3O4iS3OAHKjxqsqn098P4SZhSUU?=
 =?us-ascii?Q?acHTswk3xaBaEH++1B5MWNxkrhKmgCqg0AJDD4ifP2qYX9zg/bacPbct0OLY?=
 =?us-ascii?Q?x93S4/oAVj+R/wZU9fjuz4WAl6AvDs0o1zabD0fxpO5OdN2hJtJY78LRweEK?=
 =?us-ascii?Q?EijXKkbpP03t6nAKT9Cj2YPwkLyGe8M3NZ+DqsTiH9/FQjMyTQaeT+heIO7O?=
 =?us-ascii?Q?SsIn7l3aeUUj3QK98xonW/8rRpTWIj8TGUoAqwdlBvuRM7OHlr+mw2nOjutW?=
 =?us-ascii?Q?ESz4CrZ8Zpx8nXR+DTTTBDOq3NJgrxzYxVlnA9mEYKy/LiOXa9Vf738VZTKk?=
 =?us-ascii?Q?CXxsa2P5SPqQ1zRyzY6qy+8O45qqG9cdTCgHP/Kf1lKRlNjdi1TYVJMugFeU?=
 =?us-ascii?Q?3BfWMB/oqOPgaXD0VMcRO9TmuONaUqu85069v08RBG4Ovkl4YFursd0Pw9eQ?=
 =?us-ascii?Q?oRoDfN4rauIXCNaJQsl8jtKQJlmB5za2xUuoSuqOqBkW6xOl2+Z/+nRo2vjg?=
 =?us-ascii?Q?abKxW5oApZU9aWimuJjTrFMj+VrFIw36kVkoZScOEnJhzfQHsTicRbs6pz7f?=
 =?us-ascii?Q?7/pdeBDs8AQoTiNU7eUwjuDXGVI8X3aLKdPi5RTaZG4OOUb64k35sE6ILCwe?=
 =?us-ascii?Q?UcKcx9aWyBtfMD6gI/tYcWtx/UAvISW9KN1/VjBMJFNrYaZjFCCpK6MCdaa1?=
 =?us-ascii?Q?sq76L8A9voqC5kv/hUwF/tLGWqh3cqluGo6nAYhRPLPqXHzQbg4LSnM1i9RI?=
 =?us-ascii?Q?qzD1/9H9ExPbSpcmI/9P0TIM6k/g6OyYHeL7387GPKNAv9zHGZqNmGSn5gzi?=
 =?us-ascii?Q?Rpp/IiTk7THCTCGocfAn96tNFw13UMUJBQQWGvQq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 272c148f-db4b-45f8-20b6-08dc62acd56a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8393.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 09:16:03.5223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4qzQxRBTkygO4atWQvRWTqXN8ApQchdmtPh396uzW2ghs9Y3yNrkYu9LXnVV2itjMXBIlC2kjyjf5aL5Xglc2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7931
X-OriginatorOrg: intel.com

On Fri, Apr 19, 2024 at 10:42:18PM +0300, Adrian Hunter wrote:
> On 19/04/24 01:22, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   2668e3ae2ef36d5e7c52f818ad7d90822c037de4
> > commit: 5284984a4fbacb0883bfebe905902cdda2891a07 bug: Fix no-return-statement warning with !CONFIG_BUG
> > date:   8 days ago
> > config: powerpc-randconfig-r033-20211126 (https://download.01.org/0day-ci/archive/20240419/202404190642.z54cLsGE-lkp@intel.com/config)
> > compiler: powerpc-linux-gcc (GCC) 13.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240419/202404190642.z54cLsGE-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202404190642.z54cLsGE-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> >>> powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data23' from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data23'
> >    powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data18' from `drivers/cxl/core/port.o' being placed in section `.bss..Lubsan_data18'
> >>> powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data23' from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data23'
> >    powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data18' from `drivers/cxl/core/port.o' being placed in section `.bss..Lubsan_data18'
> >>> powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data23' from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data23'
> >    powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data18' from `drivers/cxl/core/port.o' being placed in section `.bss..Lubsan_data18'
> > 
> 
> The same warnings are visible in v6.8 that does not
> contain commit 5284984a4fbacb0883bfebe905902cdda2891a07
> so this is not due to that commit.

Sorry for this wrong report. The suffix numbers of the bss symbols may
change on different commits, so the bot wrongly treated them as
different warnings.

On commit f87cbcb345d0:

   powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data0' from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data0'
   powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data1' from `drivers/cxl/core/port.o' being placed in section `.bss..Lubsan_data1'

On commit 5284984a4fba:

    powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data23' from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data23'
    powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data18' from `drivers/cxl/core/port.o' being placed in section `.bss..Lubsan_data18'

We will fix the bot so that these warnings are correctly treated as the
same warnings.

Thanks,
Yujie


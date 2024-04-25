Return-Path: <linux-kernel+bounces-158417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DE88B1FB9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6527B1C21B52
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF30622EE9;
	Thu, 25 Apr 2024 10:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hvFXEUns"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF24E20DD3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 10:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714042636; cv=fail; b=iU8SLF9llS4NeS/agDWmWGTU4tJo+jbGadEwGPtigkIcZq0axmr+vKF0/E5FW+JioppD2cKJW1vPH+gSpe+tYjGKaXiP+0UekqSmIlVsYL29U+eoTVrHMaySd/JbP8IJzr43K6LCHnxlkpwLdNfs2lR3wDX6xdBqdIe43L93YeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714042636; c=relaxed/simple;
	bh=kyAT/R8jpoo5EMt9/zynglQ3HEBOeBNFF466oCj6M8o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fbuCRzFOIxoq3JAi9QMfLOl3eeXDu4jQrqaJXJvdDsIDGEpNcfq2WgZNo+lxDc89DS2WTR4SFnvQlslRv/JXVT/ryO+WNO3Bt+pM1ZF7W+5O3ISIjyfCnBJI3usWgY948cwcwypp89+TRTrzLoJdgX4Fb6bct/NWif2pRPWd35I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hvFXEUns; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714042635; x=1745578635;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kyAT/R8jpoo5EMt9/zynglQ3HEBOeBNFF466oCj6M8o=;
  b=hvFXEUnsRAfKpQJnq8x01Tv1beZOuHi8aApiHZMbBAsGRs43ZBhDAjWD
   uLN/Ba5J9PUrwmaC3qVUr9xl5PHRGhlW+8wR2GuR5pfnn0AZ23xzAw8Qb
   CkJxFXmimmI2d12zCOaJmPlTRu4lPO97r8kIrxl2xrfqlynCEfuyu29PH
   +wndnD33aca2pQ49Q4DWchENFTOmhpx4yYjS3nhaAoGh3VVmmliqy6PLO
   BPo1j1GDvF5oqMl3yyPUPYOa+dfZedDbvA9fCL9qIPvJyNgmsK9sXum1f
   L/w654mmCro+3tw00T1yyMx4IWMdE+KWtfkfPbo6ry1VmpVnfrjGQxYbl
   g==;
X-CSE-ConnectionGUID: kYoyRjwnQtCcWHRvDdx20A==
X-CSE-MsgGUID: WfDHu2HJSJurLb6Vg8Ab8g==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="10255197"
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="10255197"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 03:57:14 -0700
X-CSE-ConnectionGUID: P7Y3bKRMQdmF2voN87qPuA==
X-CSE-MsgGUID: E2FwcGQSR3Shl/BEvS6FAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="25096895"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Apr 2024 03:57:14 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 03:57:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 03:57:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Apr 2024 03:57:13 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 03:57:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIEuf+8v8nl4L13AMGC9haQXu4RfFdmJJ81Gfl0yxw/lBoX77JN4siF/7nuDsg2qk+aTadbioAGR4J8ye0ATSJqHf7Q3sgIld+zcxxasFRjpCpwuY2zu+h8K8Y7bWS19QYXBxi1ikLLf5StstqbCZIaL++8jAe7/4h6IS5OubR+qi5IfHIpbwilm0iXQzdV3XIv77xOOM69o5FbZSjH6F10rcuY1Ao8DIpZVknOic5TYd72yw2t1uGTWTRwnZPexE8r11wmtGvqrL07Paq37Hdvtg5/xu/CRJ1BDZm7Oau4EQ9PJddrT2XVeM8eyXSOVgR3rSHhxofNWiKMNmJM7Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktjEX3zYgBiWv6gYTiuuuNMw/T/i0SywM89+okAoodc=;
 b=M+Dbu+yK6d3PNiKeKLjF/52uToEcevAPoBLwFcecLGh7pbd67MaiMCk+YpYijt3Ew54fLz2Vx9i3FggMn27DpDHBIy/JQr6kVgXtZ2lgUtqPxSYyzkEek6vr2V5HPkGxVKlUGCHxozvLDh4PQn3myVZPnn+71d/UlBXsB3wwWd2robZXmzNWp1O0C01HddCNcGqFxzh/C+Mox5rzOMUTX97QH5gI0Q4TVoXBz+lhOakMQLd2P3DaYglRHVfZp3SYF5bKPiCrqxH+/E2XRvQsLpOgAeKFNcODt8GRDcHYAUf5FUNrKmgE2zyi8JR+bsstq5ShJfPcf5QqrIg7loTBxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21)
 by PH7PR11MB6723.namprd11.prod.outlook.com (2603:10b6:510:1af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 10:57:11 +0000
Received: from SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::c0cf:689c:129c:4bcd]) by SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::c0cf:689c:129c:4bcd%6]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 10:57:11 +0000
Date: Thu, 25 Apr 2024 18:50:40 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
CC: kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>, Ingo Molnar
	<mingo@kernel.org>, Qais Yousef <qyousef@layalina.io>, Lukasz Luba
	<lukasz.luba@arm.com>
Subject: Re: [tip:sched/core 26/27] drivers/base/arch_topology.c:204:17:
 sparse: sparse: incorrect type in initializer (different address spaces)
Message-ID: <Zio1gGgpl0FJ4qPg@yujie-X299>
References: <202404250740.VhQQoD7N-lkp@intel.com>
 <CAKfTPtBmhCFWmeb7oaM3t3WMb0_RUwY32gzgVzyruYaP9VpfUA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAKfTPtBmhCFWmeb7oaM3t3WMb0_RUwY32gzgVzyruYaP9VpfUA@mail.gmail.com>
X-ClientProxiedBy: TYAPR01CA0216.jpnprd01.prod.outlook.com
 (2603:1096:404:29::36) To SA1PR11MB8393.namprd11.prod.outlook.com
 (2603:10b6:806:373::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8393:EE_|PH7PR11MB6723:EE_
X-MS-Office365-Filtering-Correlation-Id: a800a79f-ec8a-471a-11c5-08dc6516756f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ycwAVX1fwtBX2vvkEE1BxKwPJZ0MO7Mo5IFoWUbghnYinQmewluEP4W+Rz0L?=
 =?us-ascii?Q?cXHbKBAwHh8+rXS8fk0kHi+kJJm+8OpWNo+wDrPq/ByvYrZ2WqoX21MJgsWe?=
 =?us-ascii?Q?PNa4wNbm8JWk+jRf5m6EunOX0WtnLK+e6sWaiLZy+b/r9FKvAx/yWR5vvXB1?=
 =?us-ascii?Q?MlJrAoK3UqDNQNSOugyjnY6OxUo1s8pbNo/haUem2pSPJut1hmRUo6NLVO1i?=
 =?us-ascii?Q?R0TvhTeTvoE+pkYjykYRmzWZ3SnzBQiKknVfgYN/lHmz4dVTceNOsug59Zmb?=
 =?us-ascii?Q?w3CpjyjP0ExXA7/EDEOUPqizLijxtG/pz3xDx+nZlSuFT0opLUJHK9RwOcEK?=
 =?us-ascii?Q?70d2SeByx0lnCD1RorCb6rLPXffgWiPwVeqe4RMzt+O2NBlH9+FPkV0HhaNO?=
 =?us-ascii?Q?yBLnroQj+/KH8FmQKjIV6q1Gl/WXxXnkyLYISQ8m+6v3OOtKaGOrixp9GxRy?=
 =?us-ascii?Q?ogk0SGFi+Lxj6sb3eNZHlpxPNAooOpsW/vAilE8f6WCGSgf4SVStJdITI1Dd?=
 =?us-ascii?Q?L2d8UdlP+sasf7i++s2Dcp4GFymGPgasu1aKHgTPr3kPRfVwVB4qH/8ayGYs?=
 =?us-ascii?Q?x+YdSTLO/AVoJnGCJG+MzkvyskdifRcxZv4L54XVUqQ94AYgElHZBOhLOjJR?=
 =?us-ascii?Q?C9SV0uputR1oSHAUmCuw4JTyCNPRTQUyl+9xj4++XieDZrH/DP9ZdYB7/ptp?=
 =?us-ascii?Q?zofj/NfrwPzQxpCYZmE0WR4JObsUhdlszxohfldTUY6ay2IpZ3661I+W3DeI?=
 =?us-ascii?Q?fgxBVUeo645l8nl1FunmUGodLRGCvQ4da4zMoBxv87yBctD2k4p+eaFuEhq6?=
 =?us-ascii?Q?uPQXmK+sutfFRGj2SClJjuAkPhM8E1Wci32ryhwmQodAl1wm/Rp4p8OIMM9E?=
 =?us-ascii?Q?zWA1QUh5Gdt3VqIddt2Z3fEE+YOgpBgetjqXwWLEmZZSNXda9pqYQb7Lb8RG?=
 =?us-ascii?Q?evQdV9/zxI6U+D2PTZGQjVyMU3K4yZAS2oOIMr8bGOFIE+/BjZGy7ldFTqme?=
 =?us-ascii?Q?tCSbrcgzdwym0cQsXbMX/LuQexDWxxxqaWTjG2nNFfd9Z77CmxeZwjXxUWw6?=
 =?us-ascii?Q?X2oPyg5jHINJ7/ISf2IJD0eKt+b1iq/DIctq7dswlZgmGTJcpl5f84fTO29+?=
 =?us-ascii?Q?9uEkqiwMEVZ0ZX9IMn0DqkLqGBRyCa8SJ01BULkjnXvGYPTVOI1yk6hDnRV+?=
 =?us-ascii?Q?gHqA53RVUU/xnxcKYnQG+cpr5tr80GTGni42z1bCb5g2cZKJRQILLJCSyrs?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8393.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IXBquSmPLgBzUV3udel03hM6k/M8VEBZk/URJOkIHIG8GypRj7c6GxioNCn2?=
 =?us-ascii?Q?UUVgIlRNbz1CBWlvDm8BF4R96uZQYVZmU0GQoP/b9LFh9oMwgowOp5++uctj?=
 =?us-ascii?Q?6dUu55xH986+Cb41M/dGQ19E1iB1BfivoyBqadgmQUVFT+mYwLokerVWZ997?=
 =?us-ascii?Q?00qYvB7QgVW04xP6labY0UupBPsumok58puf0RRGu8UCk2VgBtTDp6fKtllL?=
 =?us-ascii?Q?3GCwtQIp0WU88EqUsjiS0eB9aAP1iJ0jzL2e6mZJZqICNhIAYkBNaLBbyDAx?=
 =?us-ascii?Q?1HaGMIrovm4mSoEPrWk4fvioVv+UFVugGPON/qGD+E0gFR6yDDVEjD2b8YNJ?=
 =?us-ascii?Q?71WXnax4F4zgBJfk8J6redEQAGY3C0kbZwh4oDvz9ggkDio/Fen93iSU5QQp?=
 =?us-ascii?Q?2m4ZMIXb7h1uYxuIHSMivwCchtNaC8ZRULwTlQ+Wqvzs0KKbJZTdK/fWPqrD?=
 =?us-ascii?Q?rhPQAd8Rr3/S5vO7q7raYvuZAE51tFql0CIDfwFa/M9NkU3YRU15qvgoPoox?=
 =?us-ascii?Q?No1tsK/Wg3OvwdoJllQcRVyOXOhIZPhIKiLFBrtSKsOnkCKBtBuZ7JQWmiLO?=
 =?us-ascii?Q?sgg+us1nMUvRVmR2w4yY9LrMdNXNEL4wCP+EEcPJKaBop+e3lsxttrkuAj1K?=
 =?us-ascii?Q?72eMfCQ0J+KH+QmeiHqAw9fZu0Em2ohpnhXxZscm3qnlNcrdzp7BuFESinDQ?=
 =?us-ascii?Q?GTcuz7sVzhO6KPgf3tHlboMMNbTEYHSS0tkRGVf1h6Wb2glMDi+qFCrZG4v+?=
 =?us-ascii?Q?zwO7U/i5+gDSY29gW2iNdOCI1AiKBvs7AYApelIVPeYJ9Zm0j8PA/uEI9uQL?=
 =?us-ascii?Q?UMxF0EdCrYnEUp2gxTwrAZYgVrixZ2pRdPVN8OqSXBDRwUncSUeDFpxJ5TNU?=
 =?us-ascii?Q?T9aofcnzoncLEBNkv58HyuEm0UadeMqhdJ4kVWSncvaZC+qHhmCjctL6kwtd?=
 =?us-ascii?Q?c7CWOjn2iMO/HlOoInRpEsTiThK+1Eg34pZ+6Gfh0SnWxZ7+O17NfquRSTvo?=
 =?us-ascii?Q?NdtCibaJ/Xq1cnGwVzf5LJNqhmRxW8TqCHnOz0mlbUHh/XPjSU23mYQmn/S2?=
 =?us-ascii?Q?ShRLvTT/klNZlutOv54kY7JqHgZzakqi4kcakjVsXf41hoamfirbmCFWO+/t?=
 =?us-ascii?Q?YTdiY8kS25G+Hj547UUEKQ4bUSgwohaKyA/6WJEshrBFukfUaJLPBbos6e2z?=
 =?us-ascii?Q?w5G819WHWyS0UEyRgS9VlqlFepJYHQBhAbkqj86EkA9HFD9t9n8JwZNp/27w?=
 =?us-ascii?Q?fGXqaeA7JCJvpyqrFYeM6/RxnKhBAUuu4DAhSk4T/PnJNN9OORsiE17Sx4Hz?=
 =?us-ascii?Q?TN95BPi3n4K0p0X/ruZUPyS4QYBnQJ+t3FU3Kvursio6YhGUTcDlXewWv3l7?=
 =?us-ascii?Q?hYlEySoYZgLze9r76p6H8wWuDC2DLeYVIr+eBluU9JvtkW4Ss9fxFfftya/a?=
 =?us-ascii?Q?PsIaUhcjZsSMactsd3oMtz0WgecqrP/+slQu8zm9/QqpvpGDzJmauJjvLgj5?=
 =?us-ascii?Q?hWWcumAndZ/isu0ANcs7x2MLmo0qh0dPtzUiwT0gU0k9K3DX/MfuG/3SzloV?=
 =?us-ascii?Q?B6rfr89kNyCOH+6hNtuqLn6L9Cfs5x4U509d3gfC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a800a79f-ec8a-471a-11c5-08dc6516756f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8393.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 10:57:11.5474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xiDgwjG5GV4+hQ7bMKNdqnc/fLirBhxkYZ5IpsmaMo0+niyASM4vUF866T/ySyvaPul/O4jjUnYqJomITMudOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6723
X-OriginatorOrg: intel.com

Hi Vincent,

On Thu, Apr 25, 2024 at 08:36:31AM +0200, Vincent Guittot wrote:
> Hi,
> 
> On Thu, 25 Apr 2024 at 01:22, kernel test robot <lkp@intel.com> wrote:
> >
> > Hi Vincent,
> >
> > FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
> > head:   97450eb909658573dcacc1063b06d3d08642c0c1
> > commit: d4dbc991714eefcbd8d54a3204bd77a0a52bd32d [26/27] sched/cpufreq: Rename arch_update_thermal_pressure() => arch_update_hw_pressure()
> 
> I'm going to look at this more deeply but this patch only rename
> "thermal_pressure" by "hw_pressure" so unless I miss a renaming, this
> should not trigger anything new.

Before renaming, there is a global "thermal_pressure", and a local
"th_pressure" inside topology_update_thermal_pressure function. They
live together peacefully since they have different names.

DEFINE_PER_CPU(unsigned long, thermal_pressure);
                              ^____

void topology_update_thermal_pressure(const struct cpumask *cpus,
                                      unsigned long capped_freq)
{
        unsigned long max_capacity, capacity, th_pressure;
                                              ^____
..
        for_each_cpu(cpu, cpus)
                WRITE_ONCE(per_cpu(thermal_pressure, cpu), th_pressure);
                                   ^____                   ^____
}

After renaming, the global and local variables are both given the same
name "hw_pressure", so the local one shadows the global one, causing
this sparse warning.

DEFINE_PER_CPU(unsigned long, hw_pressure);
                              ^___

void topology_update_hw_pressure(const struct cpumask *cpus,
                                      unsigned long capped_freq)
{
        unsigned long max_capacity, capacity, hw_pressure;
                                              ^___
..
        for_each_cpu(cpu, cpus)
                WRITE_ONCE(per_cpu(hw_pressure, cpu), hw_pressure);
                                   ^____              ^____
}


We can give them different names as before to fix this warning:

---------------------------------------------------------------

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 0248912ff6875..c66d070207a0e 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -179,7 +179,7 @@ DEFINE_PER_CPU(unsigned long, hw_pressure);
 void topology_update_hw_pressure(const struct cpumask *cpus,
                                      unsigned long capped_freq)
 {
-       unsigned long max_capacity, capacity, hw_pressure;
+       unsigned long max_capacity, capacity, pressure;
        u32 max_freq;
        int cpu;

@@ -196,12 +196,12 @@ void topology_update_hw_pressure(const struct cpumask *cpus,
        else
                capacity = mult_frac(max_capacity, capped_freq, max_freq);

-       hw_pressure = max_capacity - capacity;
+       pressure = max_capacity - capacity;

-       trace_hw_pressure_update(cpu, hw_pressure);
+       trace_hw_pressure_update(cpu, pressure);

        for_each_cpu(cpu, cpus)
-               WRITE_ONCE(per_cpu(hw_pressure, cpu), hw_pressure);
+               WRITE_ONCE(per_cpu(hw_pressure, cpu), pressure);
 }
 EXPORT_SYMBOL_GPL(topology_update_hw_pressure);

--

Thanks,
Yujie

> > config: arm64-randconfig-r132-20240425 (https://download.01.org/0day-ci/archive/20240425/202404250740.VhQQoD7N-lkp@intel.com/config)
> > compiler: aarch64-linux-gcc (GCC) 13.2.0
> > reproduce: (https://download.01.org/0day-ci/archive/20240425/202404250740.VhQQoD7N-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202404250740.VhQQoD7N-lkp@intel.com/
> >
> > sparse warnings: (new ones prefixed by >>)
> > >> drivers/base/arch_topology.c:204:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long * @@
> >    drivers/base/arch_topology.c:204:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
> >    drivers/base/arch_topology.c:204:17: sparse:     got unsigned long *
> > >> drivers/base/arch_topology.c:204:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long * @@
> >    drivers/base/arch_topology.c:204:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
> >    drivers/base/arch_topology.c:204:17: sparse:     got unsigned long *
> > >> drivers/base/arch_topology.c:204:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long * @@
> >    drivers/base/arch_topology.c:204:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
> >    drivers/base/arch_topology.c:204:17: sparse:     got unsigned long *
> > >> drivers/base/arch_topology.c:204:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long * @@
> >    drivers/base/arch_topology.c:204:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
> >    drivers/base/arch_topology.c:204:17: sparse:     got unsigned long *
> > >> drivers/base/arch_topology.c:204:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long * @@
> >    drivers/base/arch_topology.c:204:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
> >    drivers/base/arch_topology.c:204:17: sparse:     got unsigned long *
> > >> drivers/base/arch_topology.c:204:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long * @@
> >    drivers/base/arch_topology.c:204:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
> >    drivers/base/arch_topology.c:204:17: sparse:     got unsigned long *
> > >> drivers/base/arch_topology.c:204:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long * @@
> >    drivers/base/arch_topology.c:204:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
> >    drivers/base/arch_topology.c:204:17: sparse:     got unsigned long *
> >
> > vim +204 drivers/base/arch_topology.c
> >
> >    164
> >    165  /**
> >    166   * topology_update_hw_pressure() - Update HW pressure for CPUs
> >    167   * @cpus        : The related CPUs for which capacity has been reduced
> >    168   * @capped_freq : The maximum allowed frequency that CPUs can run at
> >    169   *
> >    170   * Update the value of HW pressure for all @cpus in the mask. The
> >    171   * cpumask should include all (online+offline) affected CPUs, to avoid
> >    172   * operating on stale data when hot-plug is used for some CPUs. The
> >    173   * @capped_freq reflects the currently allowed max CPUs frequency due to
> >    174   * HW capping. It might be also a boost frequency value, which is bigger
> >    175   * than the internal 'capacity_freq_ref' max frequency. In such case the
> >    176   * pressure value should simply be removed, since this is an indication that
> >    177   * there is no HW throttling. The @capped_freq must be provided in kHz.
> >    178   */
> >    179  void topology_update_hw_pressure(const struct cpumask *cpus,
> >    180                                        unsigned long capped_freq)
> >    181  {
> >    182          unsigned long max_capacity, capacity, hw_pressure;
> >    183          u32 max_freq;
> >    184          int cpu;
> >    185
> >    186          cpu = cpumask_first(cpus);
> >    187          max_capacity = arch_scale_cpu_capacity(cpu);
> >    188          max_freq = arch_scale_freq_ref(cpu);
> >    189
> >    190          /*
> >    191           * Handle properly the boost frequencies, which should simply clean
> >    192           * the HW pressure value.
> >    193           */
> >    194          if (max_freq <= capped_freq)
> >    195                  capacity = max_capacity;
> >    196          else
> >    197                  capacity = mult_frac(max_capacity, capped_freq, max_freq);
> >    198
> >    199          hw_pressure = max_capacity - capacity;
> >    200
> >    201          trace_hw_pressure_update(cpu, hw_pressure);
> >    202
> >    203          for_each_cpu(cpu, cpus)
> >  > 204                  WRITE_ONCE(per_cpu(hw_pressure, cpu), hw_pressure);
> >    205  }
> >    206  EXPORT_SYMBOL_GPL(topology_update_hw_pressure);
> >    207
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> 


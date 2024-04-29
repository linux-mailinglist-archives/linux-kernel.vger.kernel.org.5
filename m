Return-Path: <linux-kernel+bounces-162651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5938B5E95
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33EE3284421
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D9684D1D;
	Mon, 29 Apr 2024 16:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="it+Gvx5L"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0B883CAE;
	Mon, 29 Apr 2024 16:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406772; cv=fail; b=Z4+vlo573zIP+19kz0DwaDDbBn5Y76pJQ8gNLnsMPzkiGsPCRD4Hp6LT8w7JBHaj9NVFzmdMEZ+N7UKrAfYs18DkV7GIDjpf8ENL5Fu9cyKWaCzH+2hvgGeZJvBKr2pi+JThgKZYFNTYYerlAGkcIDnZnh9sPtr/xcgOVytQyqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406772; c=relaxed/simple;
	bh=2PW9UsRkyoW118RUvPJVZxQ6wOUZEUTW543BGQMuf0c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mF2pMvNEYLKFNb8czwdZTIevQLsTWQmSCJdGBgIbCLqlUo9vQhU/AttPwUzSqu+TpR6H/38GLgxrCsxqi7ZG6NQkLP28hqFAF0Xo53urO+vz9EKGZO36DKqfZGQrNcDbXP4whYDYh0x4OBv9ZdECP9KN0x4bnl+LCsZ8bu8yQ5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=it+Gvx5L; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714406771; x=1745942771;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2PW9UsRkyoW118RUvPJVZxQ6wOUZEUTW543BGQMuf0c=;
  b=it+Gvx5LdFhX8Zz16fo93Zv03hEewtTP1dDDFoCpOsd27E2CkRyJg466
   HTaJhMGGHYu8/tdjiWv+YHNi39BT7RBjYqZVJANsvlS4y1aKnqLsHX4Rk
   25DTr58dTQy72dEXVXeCv+T3r808q8O0cVtz646Ckh6GHOKjlPa4t3kEu
   YegeFAUA2cJp7NxgNtq19mgQUl6c1KqMt9k0efDnvNPKS0FbSbysFLi0Q
   5OU/j+rlxANFQWsHKJL4u9c1PBt7YFW+KaMNirjNo7O2pGn5gDfscdCsw
   nmV0Qc4VnixeS4zChJXM2uhMrN93pbsM+fURIYUao2flRTf66IJspnfNT
   Q==;
X-CSE-ConnectionGUID: bxcfjHqkS7ihQoUQ8fa4xg==
X-CSE-MsgGUID: RXhOTbf9T36myZUnKSoX+A==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="9908022"
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="9908022"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 09:06:10 -0700
X-CSE-ConnectionGUID: TOIQ50AZSu69NSYspRbbkw==
X-CSE-MsgGUID: hCWMcPsvRqamK/45iuMSig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="26026467"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 09:06:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 09:06:09 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 09:06:08 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 09:06:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOiHvyGvVuojIO/xGXQus/mm/8JYKUoXvokBiyYOH6/pyB2pWKUqsRaRf/5923CAeIfXWaHXzfWAvl8U+E1bh+mfq2P/NqFRa7bW1s3+mLDtfwqcA0gielMsRZIcaVjKkdQfC+q1d/suIOsMErEVcrvnEHKpLEsmliNLqlsQuUJvztQUMGdAJadKwfeJ/dIP1pvqXpZiDsgmmIruMz73zhFWmSaSFQcl5EZkFRL9Igv/6wHaWzyWBahLvPYrUpJPA8WDspb74vnpukj8VVpYHfaW5ksAbUqYISwzt48OGmVqQ6IgN4suAe4j89Q6wz+TfVoEFmIRj3tpy8O2P0TKDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2WcQog67XKUVnkB9rGwBCstajYtnSDN8UzjMdZ+waLk=;
 b=F7zTqt4gIKaxtCoHMUaH8RLtyd1uw3oxidFb6OMXOeHjGeDvAw1ZYsOvd9rVsgHiSWX02B8MutLRvRwfZrqZp9ygNw9DhcFo3pn4hJT6slm1WkudHNnLw2C5+48fPBhEi+OJJZ0F6vnr6mY4QFdqp8+AThqC+Pjd30hryNKALqAuFJSH7wdkAr+l9L/6g6ANWuMfAKHLJ2l68MKVfgzoEBwDLQw+ydngsvmmRhJ0BxB+A4DbFZb4u2gJnGDgdFHR1kWAJa2oYqnJEjVs72zDaUoW0Y+EDRtjjUQUP4WZGHhsEj9JeHlv4Nq3XnjtORYaLWktZ9ITMWXMf6v6ad5Mfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB6712.namprd11.prod.outlook.com (2603:10b6:806:25c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 16:06:00 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 16:06:00 +0000
Date: Mon, 29 Apr 2024 09:05:55 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Li Zhijian <lizhijian@fujitsu.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH 1/2] cxl/region: Fix potential invalid pointer dereference
Message-ID: <662fc563c6bb2_19ca3929485@iweiny-mobl.notmuch>
References: <20240429013154.368118-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240429013154.368118-1-lizhijian@fujitsu.com>
X-ClientProxiedBy: SJ0PR13CA0066.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::11) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB6712:EE_
X-MS-Office365-Filtering-Correlation-Id: ec9ba319-2662-4dab-d3fc-08dc6866432b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iqYRi+E8tSXcvt5L8C2K68MmM1I29GvyZK2Ad8Hu9ZxOZKCioi/7wUtoeQJK?=
 =?us-ascii?Q?l+hYht8zgbF2z6KOnfDbTUaagtI5vM8qT0zxfU7HQeRtjEzOU9h17Bzd6r7b?=
 =?us-ascii?Q?cUzrDMtSfDs51mPuQOiXutfC2XcfUtPgs6T7VaelQjcsN2ZFpE01ZmxYRTIh?=
 =?us-ascii?Q?+It2/qq6GTPrljSNbhA+qKihHkPGvgCntzDwxxDu7D6DYVxHnrHze2bD2SMI?=
 =?us-ascii?Q?8XdyZt3N7B5ITwC79KRxjz1nVJ06L47Q299ui+T1Hxcq8Fe3ReCU5fdF9mSI?=
 =?us-ascii?Q?zLuaA/QjggzsJkCH4QZ0b+NjsT/DHojb2Rdo220X3VSNZxN4MOIs3jp6soA/?=
 =?us-ascii?Q?JkTRF349LSWZN4+G05IR5FKxUHsmOddvIH6ww51gAL4dXug4XtNFh3dFYGva?=
 =?us-ascii?Q?aYe07AltokQUUzhkEuNmse87hFg851xLZz7LmVM+Mv4WlgECEWvMAfT/vv6u?=
 =?us-ascii?Q?/4edzo4/m6PyWKZqXoGFeT3mrG5ir/BtJFy0YjapzyuzIgCSRKdooaCz5wpr?=
 =?us-ascii?Q?dzv2PCDGlps01AhQOL/dOve6Xx5bWEKFs6UoM6Cu71YRlxtW/2YAL2iJQ6lA?=
 =?us-ascii?Q?zziNXKdJu/cI8nZK0Ui5ZIPi456wNzT2wxg5ZcVoxskbnNOEX51CjcQPSKq+?=
 =?us-ascii?Q?Dv0i3vZLqiCv/8bYXWDItYy73xwDl1UDMtyPgP4b23wa14bP84xMdMd6r4ma?=
 =?us-ascii?Q?NBXnKeZegv+eabHEjLB6E50Hh4x6RrtgSM/4oh4215SLCkhVHga8EDBJ0Uyc?=
 =?us-ascii?Q?dxgUxO+JYvg9FRf1teABBOpr+BUsnHENJ2U6m8EjRdDyRTHQjaZnlFGAL5pm?=
 =?us-ascii?Q?uRV/wq8ekkW1SFOqUTu/RUjhlEby2Cyt1z3OggKr5xSlqlHlOOny2H+S56Om?=
 =?us-ascii?Q?ARRcSlr9H9A9zBZX8Vmp6yuTCpLxObi9E3zPV/+pnXDTRcA4GEh7N+bUBmYe?=
 =?us-ascii?Q?49FFP0t2zm3mG9tBndXEV0nx3KAOsAwOj2xD/1xhjlE0OT40aYxbwas9XT7C?=
 =?us-ascii?Q?X8QcSpYy0eWXBj3hWXoClwfsDs+XawmwEfgHR7iLWv1VfrZ8zvwYSCQZEXVM?=
 =?us-ascii?Q?uD8lRQvX1B3zNVppSO+mz4lrGgD3WqhAoXNdrUu86JwFhKghVyXIq/4isbTQ?=
 =?us-ascii?Q?eW9fjR6mD5Cv2+7/+gCHGxdV5CgsYnSHKbiwt9e0OSz8T9pnoIdcxWmhek/W?=
 =?us-ascii?Q?FIp0+GhK8zc9zult/ITsOtxiaGlK9Ls9118CgGEyivu4sst0dGJaW7o40LvT?=
 =?us-ascii?Q?QovUY+6ej0FCP35P2CkaA3cLZ8QmqH1xPH2Ovy6B0g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hh66XJQJwUsMwubIdKTVXKSSbhn9hBjpJjyQcosBahEdAhat8vukyZsmsrv/?=
 =?us-ascii?Q?t6cJtuz439IyXCqQho9eP7u5UG3lH14L7nNz64wVq/CCPQCakL86n+cl+CkD?=
 =?us-ascii?Q?dw8QDUgZCNp+FPD4Y95vh1SCyCTOnMeAS9MqhD4YiHbsWDLG3K+0v+JVynfJ?=
 =?us-ascii?Q?yRPemgvRNarxGK6jNBYvVHvv8k8MDNuAiTr8gzkujJRrARoKZWPVIpLNZfE1?=
 =?us-ascii?Q?07X+fjwqQBiVrnLVNtjD6sjh/QJj1r9C9bzDTkCFyIxIDG68GUYDXO/1DIyn?=
 =?us-ascii?Q?wmrixGb1cJBOc0buaUGi5pgMg8PoZAR8xeaeGII04rgjPkc4+PaYzbYBc/nw?=
 =?us-ascii?Q?PjhCEMrEmDHP/OpR0KPfJAGN6+7q+P0qfqgRw1aPV7oZfWznUbwZw0p1zG+K?=
 =?us-ascii?Q?nLtdySoHw2/NR3lWDPdojuHE7psrTekVJLmBDkkpTv+45hyuIBoROZciP+0u?=
 =?us-ascii?Q?kX8cde9Nh3AwYjLg3evwKRNcbQCXJXspYs0X+kVTzl5DMUKFr5YQZqzeDjMR?=
 =?us-ascii?Q?IPp8LlovOu+1YoAhQ9Svy82hpNhbsY+3iOlmqNlVkNgFLBG1qMOEWSMTaGC0?=
 =?us-ascii?Q?bxZ5eGfkAATuOqM8H4zZyJMuTa7OWFgFybWeC8vAmHviXzdNmT/8yulrI7vc?=
 =?us-ascii?Q?rvHm1ImvNlgpx3qM/zz/YUsNXTaS6HZsM345milQEkkHfyojPVh4anmnyJLk?=
 =?us-ascii?Q?AA6QWPpMYSVqZBZ+RiyD6o7OaGhuFOCIF/ftLhLNdK5nd7/FElsNwZV7fB3s?=
 =?us-ascii?Q?ng4YCGJm0nIjXDw1rkfNeB/MnaHaLJ+iD1XzAti9rKMgmAqRjyz6OgAyPNSU?=
 =?us-ascii?Q?kL2akjCYMds7GaHkuE8hKZ2+szKI1q8RVelcA6RJOGhetMCb/gZxIHSzBuES?=
 =?us-ascii?Q?6ayroFEB8IChWeOMO6bGNQQ891I/qMxbJZ/lU3y8yeStgXZuDsd7nFzfwzaB?=
 =?us-ascii?Q?wz1FbA9vnpQNkKZxOUxlPvwaQp3x7vR84lUHVctqN5FNW2uo+ZztSB8VQHDB?=
 =?us-ascii?Q?HNH+FZe3voOQ8V223JXooK+NhqC1iOypf19Lp6C9L3mnWxuuOlJ1VZ1Rvhdf?=
 =?us-ascii?Q?aWc6PU5B4vTVD/1PfTna7N0ahtLeA/uhkoqKAqbur26YFO78DRK0HSpfJsMt?=
 =?us-ascii?Q?9e/diXrRWOzRFxaGh3Csj1qL/0iW7IKjT/1/bz1C6qrpsADL4JMDCVO90c2Z?=
 =?us-ascii?Q?9tJDQB6D5SdMfSLQAU4A136GETRHrX4KsjvFEtQbfdelqAn488TBPWVc+IFg?=
 =?us-ascii?Q?VT1E4fAHNmUfGKYB0z2Y08ZBHBInHKFrV0ZDlCBhwLzE41PWMFtEulvH0r2R?=
 =?us-ascii?Q?EP0BXIUXNY/RNLd5678C2pC2mfO7nGNY+5NKqjD+OTWxPQnXnte+mwTaJN1g?=
 =?us-ascii?Q?M2JwYr+M6rfKUTLGW1IyjAC7G0bI4r8JzfKT537UdBvMCIK2VH4/85m3MkTm?=
 =?us-ascii?Q?h+Ij3OyWhkhqfUYqMZzO7zcUU3ycZAsYlGVU1Od4+2cWUfh1sHcQLDmM4Igb?=
 =?us-ascii?Q?ZNn3xkD8c9Jhco6IdMDeQxCWM1tqnYizmOtu4iIOFV2X9HTexMCL9BquE9nM?=
 =?us-ascii?Q?bh7x482kKDfgKhWmJ1YytW/NaLLSXEvlByxGGljF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9ba319-2662-4dab-d3fc-08dc6866432b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 16:06:00.4705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nbLu/BrhApfKMTgB6svLJPhH4ZZebLMgbOXwh0UN6z8Q3qYNtQW0Nc7IYGwWnOH/vw0dE8JGCevQJ/lVZR5//g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6712
X-OriginatorOrg: intel.com

Li Zhijian wrote:
> construct_region() could return a PTR_ERR() which cannot be derefernced.
                                                             ^^^^
                                                             dereferenced

> Moving the dereference behind the error checking to make sure the
> pointer is valid.
> 

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  drivers/cxl/core/region.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 8535718a20f0..3c80aa263a65 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3086,10 +3086,9 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
>  	mutex_lock(&cxlrd->range_lock);
>  	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
>  				       match_region_by_range);
> -	if (!region_dev) {
> +	if (!region_dev)
>  		cxlr = construct_region(cxlrd, cxled);
> -		region_dev = &cxlr->dev;
> -	} else
> +	else
>  		cxlr = to_cxl_region(region_dev);
>  	mutex_unlock(&cxlrd->range_lock);
>  
> @@ -3097,6 +3096,9 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
>  	if (rc)
>  		goto out;
>  
> +	if (!region_dev)
> +		region_dev = &cxlr->dev;
> +
>  	attach_target(cxlr, cxled, -1, TASK_UNINTERRUPTIBLE);
>  
>  	down_read(&cxl_region_rwsem);
> -- 
> 2.29.2
> 


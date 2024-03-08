Return-Path: <linux-kernel+bounces-97685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F6A876DC9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 00:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B9411F22674
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 23:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7C53BBC6;
	Fri,  8 Mar 2024 23:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HTIaxKOO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE963208CE
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 23:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709939301; cv=fail; b=jfNy15D4gDPHSxrLBQh+6+EE2StWiVTigIDm2EflxYiwnrC8v0dXxijyQsy+NUtE10GI9+6FDrV7IfMKco7GwuJLZEQjH01c36uR/gQtdvYM963px2jjXUovxBOzIX+nDPQpUiMtCXphux8a3LbJm9Nld0YbQGYwe/x7NGHMXL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709939301; c=relaxed/simple;
	bh=9fFlhexp9NWycQ8/IqUF6jfrRUaJZ/uLfchkwBJT7Z0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kmOrISRY3fl+XTYliUq9/hmItoZEDRwL0JAd0cBwrm1KqegxRKjDI3JAia0V8mIa46iO3NJZddcqy41ulXVfoTy8FKNrBkHiDdwVKBx3eodDCP5PP3H+dHKD6STp2X4gaUAwWp90DOr4NwoIHAi5AEzk3v6ych4V6GmtetQBSEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HTIaxKOO; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709939299; x=1741475299;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9fFlhexp9NWycQ8/IqUF6jfrRUaJZ/uLfchkwBJT7Z0=;
  b=HTIaxKOO85hLny+fxmMPI5gsrvEi5O4/DlhgLMzq+bizM+NokJ6oTX09
   TspnOam19wGFLq0QkKFld/2Gm9ENl5bgl5RJYAWE8OqBipwdyiRl7+HBl
   gSgoseHrNd1NoTlH2uqO12KOrFuzBfqrSKWl0ux/ViKmgpSKoxIywuqs0
   8b7S/WBaAGi0z0jYrihPjUFjm4BNd2h/c4OYobw1BWg6arDYwqEh2FOom
   8mtAvOVQ7ap1itklGZ1nxwMjNwozSzs8dzrLcv1wCpb/sl3vx26bilST2
   GZVoSEHa1YySIfoqEVeHqLnTfkVXyTW89K+fGXW9JCpd1GNgaPzuCKQmG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11007"; a="22133868"
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="22133868"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 15:08:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="15199970"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Mar 2024 15:08:18 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 15:08:17 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 15:08:17 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 8 Mar 2024 15:08:17 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Mar 2024 15:08:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipqRYkvQcbkVm/bjxMNomgTzCji/8epMMxviMGxYC2N2brnsBbwcNWVOrKllWiGtCtiZEH5QvGrZl5sHDOYDtyudpwbFzzmPlazNzi2MTy7uycDoWNnD2TwdMR04+CEu71rSjqM53fL1BQn2wIXnqHmrDxq2Js2/uQKZjutSQV4pJSO8c17LGtL2dhNVTLqsm0tHSD6FWLDFzZB/H1rduOIMD8h/ZqSl5lGTPTjNAPLOCm2UdSIzkYFVwS2b8mteezGuvMB2HID0R8+bveXj6vmNPiI+KjLsSp3Uj9zKFMsDA5CWdRQ/T6h6UmJziFOkk+3WugvyKlvAQLwEorbTKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kno4gX8qhkehaYiqY0zYCwNHHKoV0QhMRfnYlJlDafs=;
 b=jGR09hLQfMb95jjYbahiRuJuZu4PptXx1ypED27dXLkDB/7VKNTwNi8BYsthQuQYQ3rnsFhxcTw25TZO/eNPN62nEAYoIv69+c/Uyo67MaFHvj7ER56sdN9cN1i+a10EUJRUSAPD/APFjcujQ+8bTE9IoRICbhwp1sJ3n+Eo2SRJdlWYeMPa+nn6ZHUWA6iEZolGz/1LQTD5IBAaK7SmvbUTpOgy/jnUEFTl9XLTHDLpmfdTgZrCypGDN9y4VK2a8zbVNg5fq7zdzSIo6VbJeTOPKHsZ3NCdmDU89rM/KEQNumMPwekCfmlU9I5td4BMvUHLu0zJOeK2cf2o8DCbOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH0PR11MB5300.namprd11.prod.outlook.com (2603:10b6:610:bf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.6; Fri, 8 Mar
 2024 23:08:15 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7386.006; Fri, 8 Mar 2024
 23:08:15 +0000
Message-ID: <55b868e8-6fdb-44a0-958b-892170a33f0f@intel.com>
Date: Fri, 8 Mar 2024 15:08:12 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] x86/resctrl: Pass domain to target CPU
Content-Language: en-US
To: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, "James
 Morse" <james.morse@arm.com>
CC: Thomas Gleixner <tglx@linutronix.de>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, "Yu, Fenghua" <fenghua.yu@intel.com>, "Ingo
 Molnar" <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>
References: <ZdZPht8hY4J9uIOz@agluck-desk3>
 <20240308213846.77075-1-tony.luck@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240308213846.77075-1-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0020.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::25) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH0PR11MB5300:EE_
X-MS-Office365-Filtering-Correlation-Id: 562c197e-dd06-4097-abb5-08dc3fc4a251
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rC78ErbL8tJGwjhTRpVcuJAQ+JRpejd8F+hyEdUcgv0Xsm7+fzK43Q9CSkf8/5vEYZLoKtU6AY72/3ZY8upsfE/jF8+iLVjPyinp3Hnq02/36VwCurvWIIQYYpQ6ZrjXP/YpCXpXh2JmCxrOM/Rwx1oOHBrivfZPSA3NEWzqZYIf6i1Nhw/1gfxa79AhhptsdNZiYjS6P4qbta9/FjPar0Nif2hFQWx/tu/HxTR65GfUZGmnSya7CHA65MoZEUyyGkYr43IBGB5rX9BJ8AobpsiRa2f1FvH9ww+SiGnMk1VWPcQVJVfa1k7VSUAglRdOGjmvVgulVNyZoxFr3dACrJVN9ElVKGnvd5NruRa0bGEmJ3EHtXQkhpXcDrI4lIIaAg9RoBTdV4CEJodvQVggIndsm/jL3k6GdiXLbVexMjla5SP86JSRp0Des3UmjkqYwX3OOcivkvgQvGnbMQ6JUsBw4+B+bfREBkvbFuDNe6MlK8WqKNr7HpZbE29x3qCjfGtG9OMDHIszG0VYui6lCszFXvsRNJcrsehtq4Uxbs2MICB3HH5iy+9RaonpHjqYiEcCFbDQgYVyyxvxXOg8ddDkLrH43qBdKk4fyUFT1OTGLOjGVFscrdL2rACvjb4y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWo4blVENGJYekowcGZOZ1lUdHM2WTVwZGhwRHd3aXpWVUtTOWdZN3NraHF4?=
 =?utf-8?B?M1dXVVpubnArTy9Qelc3eWhlSHNVN2QwS29GRGp4UmU5TndjOHkyaG1XK2VL?=
 =?utf-8?B?K1dmajY5SFRqWjgzYU5ZejVkS01lWWVBMStGekwyajJ5Y2g5c3JzTzYxRSto?=
 =?utf-8?B?b1dtMVFQWXF4WENmckVyV0QyNnhrblVNL1M3MytlSFBBRGU1dWtVc1FPZjdU?=
 =?utf-8?B?ZEdPRXlXSnRIWVMyc0o1QWw2Q2VEWlZEc1p6QlBaQ0taWThVT1djb2dkY2lE?=
 =?utf-8?B?U1dONjhxMy9pZ0ZWazg0KzRvNEdEUTVzTS9JY1ovbTFrY0dHR1paVG9tcG9M?=
 =?utf-8?B?dmNWY2doN2pCSmRMR1JGK0dWRzBaSDNmd0xPSytsZk9vcHN6bHc5V2hFVWpD?=
 =?utf-8?B?Qnk4VmVrYXI4YjlrNkVIektLcHYycTNlZmY0dVdzL0xJYU5nR3lZcjhsdXJp?=
 =?utf-8?B?bU9HZ1pEa2RFWlh3NU96SlRwOEtDVlVmSzlnY0VCa2pmcWRBWGZGZ3RObko5?=
 =?utf-8?B?YUlzZVlDS0gwT1NvY1hzazdoWXJMSUR5NGYyamxtRTNVckdiQmxDQTlyQndw?=
 =?utf-8?B?a3FyN2tXajhLVkRGeDlKaFREZCtPdmJYcnc3N2VJc0pXRGppRWYyVVJsTHVZ?=
 =?utf-8?B?Z0drSUZib3hyWjJnUFp0eTQyVk9hc21sYjlENGNFWm84enZMaWxVTzNadDEw?=
 =?utf-8?B?SkgzS0x0Q0RmSnRjTnZDR2t0TlBQbFhaOTc0Rzh1MkZhblQveEVYKzc5RVVk?=
 =?utf-8?B?Qitva1h4LzRVOEJPK0VuRDdKMVBmQmF5L0VUOHNDcHFRNjR1MzRPaXFYUVp4?=
 =?utf-8?B?L2tTdTVYbVdqVkZXL3RSOWNUQ1FWcG9jMy8xQ0VlcExGUVlEaGJyRnhocHZL?=
 =?utf-8?B?am5xQmo5b1pEV1F2RlJiNm13a3RXMUJyQ3hBbFdac0pZWnJiRUE1SVN6YW5E?=
 =?utf-8?B?WkloSXVaZW0yU0ZxRmFSbzIzZ3huMnJ0Vk91b3BBbnE1NjVZUzkrRy9wZys2?=
 =?utf-8?B?aktlZUxNS21GWnJjU2VkNmZ3OUJ1cGs2ZE42cVZEZjE1UVNZWGtGbUhDQ2NJ?=
 =?utf-8?B?MTcxdVVNdEUwRjRGUWlaMWkxZlNRQTJCYWd1VlZJU1YxK3V2NTlJM0hlakNh?=
 =?utf-8?B?UmhWV202T0hiNVFmNGdRemNHZys5QW9hSUhVR1Z3UzhRYk43UHJLb3dyVFhp?=
 =?utf-8?B?Rkd3SGpNSTJIT3FWa2hWaUkzZ2pQWG4wV2NsY1ZmWFlvUlRuNXF6R05KZUFx?=
 =?utf-8?B?bXVXZElkV0xnWUdvQkx2RWhYZjZUcmRhWE5ISk9DNU1HRi9SMGU3eVN0NHFw?=
 =?utf-8?B?ZXdPeWhkNS9iYWpNdjRKaFR0R05oZWlSRjFMWXZ5c3NOR3YvVERJL2hUc2h4?=
 =?utf-8?B?ZlFJLzlReStoaHIvWTJhTE56UGNpdnBMaWtxTmhaeGFkSDhSWCtUc3lxdndD?=
 =?utf-8?B?RTJYNmV4YldJaVl0dnMwYkFGalhOK1hYS1ExOFM2VSt6Rm8vWXZVRzF4Q2x0?=
 =?utf-8?B?Y2p2QzVDazdiM2RlTVJwQWVvV2ZCcHVrNmtkODFPVTRoMmttcDVtU2hEc0Vr?=
 =?utf-8?B?SUdNd0NVQXdJSXQwNUs2bEJlbGtWbkVlbDdVdXF1M3k0QkI0eHJreFd6OHVO?=
 =?utf-8?B?ZjlzUHF6eU8rQStBcnRwYWVXYW5sSGU5VWFRQ01kWWJJejRMUGxVY1JOa3py?=
 =?utf-8?B?QldyUDdiYnFaRGhBS0FnTXRUZEFYMHBFRXVjMWc2MngxYVdacFgreHhUcFFl?=
 =?utf-8?B?dGVKZGRsMGl6bmFqTWRuOVZEMVRaM0I0ZURHSXRmMC9XMGkzSVhpY2VSTml5?=
 =?utf-8?B?Z2lDMWVtZlZLZ1FOdGlreGkvTjBMbUxmbitjdm1qVDdFYVI2YTkzS2JONHMv?=
 =?utf-8?B?SEVGMFhmellPUHhYZ1dkTEFIUEhxTFE5blRKTFVtTEVla0JkVFhqcjJCVEtJ?=
 =?utf-8?B?aDNTSkRJVTd2cUJBMXpnMnk5UkYxZUo1NUFxd1lVYmQ3YXMrNk9MeExJK1BJ?=
 =?utf-8?B?ai9xZncrSnJ3Z01CamRSb2NabFF0WGNyQnJWNk10KzlvQXp3cExtdEdQaXBW?=
 =?utf-8?B?NFdkQVY4RG9XQXdiVTh4UnpwY3hwSkZDa2JsSkh1bmFnVEYwYWtQdGZxYmRJ?=
 =?utf-8?B?MmhVUXdEQjdudGN0OTluK0ZqQWRrRlR6QWJnVnR2RktuZHp2ZmhJRXA5SVV2?=
 =?utf-8?B?d3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 562c197e-dd06-4097-abb5-08dc3fc4a251
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 23:08:15.0340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9CsflgAcVoIvQaa7C8rwuYCX6QGAMiVGzLlvsw1cfXTHAHrPfPH1R6PnYHU8qg111B1TkXyoNYJjFpHeoi/9+Wy85SOgROkeRqaxOBjKY7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5300
X-OriginatorOrg: intel.com

Hi Tony,

On 3/8/2024 1:38 PM, Tony Luck wrote:
> reset_all_ctrls() and resctrl_arch_update_domains() use on_each_cpu_mask()
> to call rdt_ctrl_update() on potentially one CPU from each domain.
> 
> But this means rdt_ctrl_update() needs to figure out which domain to
> apply changes to. Doing so requires a search of all domains in a resource,
> which can only be done safely if cpus_lock is held. Both callers do hold
> this lock, but there isn't a way for a function called on another CPU
> via IPI to verify this.
> 
> Commit c0d848fcb09d ("x86/resctrl: Remove lockdep annotation that triggers
> false positive") removed the incorrect assertions.
> 
> Add the target domain to the msr_param structure and
> call rdt_ctrl_update() for each domain separately using
> smp_call_function_single(). This means that rdt_ctrl_update() doesn't
> need to search for the domain and get_domain_from_cpu() can safely assert
> that the cpus_lock is held since the remaining callers do not use IPI.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> 
> ---
> Changes since V4: Link: https://lore.kernel.org/all/20240228193717.8170-1-tony.luck@intel.com/
> 
> Reinette: Only assign "cpu" once in resctrl_arch_update_domains() [but
> see change from James below]
> 
> James: Use smp_call_function_any() instead of cpumask_any() +
> smp_call_function_single() to avoid unnecessary IPI in both
> resctrl_arch_update_domains() and reset_all_ctrls(). This
> eliminates a need for the "cpu" local variable.

Great catch, thank you for doing this. 

Also, could you please stop referring to previous versions (in this
case it even follows v3) using "In-Reply-To:"? Although v5 here
follows v3, not v4. You previously [1] agreed and did so for v4
but not here.

Reinette

[1] https://lore.kernel.org/lkml/SJ1PR11MB60839AD3BC4DB15BF5B0BBE0FC562@SJ1PR11MB6083.namprd11.prod.outlook.com/


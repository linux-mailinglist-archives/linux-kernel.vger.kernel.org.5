Return-Path: <linux-kernel+bounces-101582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FF487A8FE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA5B01F24B70
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC4F47784;
	Wed, 13 Mar 2024 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e3iIjrj1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9092046535;
	Wed, 13 Mar 2024 14:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710338627; cv=fail; b=lqpxecwsbFBPqa9ZMT8ppQQGUuTwgjqsWlv4sj9vkPTHtmFVEZvr6WYAo/x/LYs0PvZjIBI2N348YwEcqA17bHQbbGaukONnTC3GKQCA7+PGcUwoPafTNeu8TVY5XuYyTuYoNx/kbfWMyMFVNr6OFkJiLhDH6pFS6dcqXK+v2E4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710338627; c=relaxed/simple;
	bh=wLpo94qKWsozoRr6V7V4egX0OkLI9crZTtr3whCeS3E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XxB0OdnNHe+ik76y2zb3+kHNl1RXEeTRbV00b+Szz6MR3gDp9fry+ActBVun1QnPPNTdv330fS/tPi6DKkHCwugoiln487XhzNXXZesPpFJysa8CzOO0ldVhUYBEbO9NGCGqs2P1AfG1eErqCZweHwrYSUp0jlzb38/8NLV+7kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e3iIjrj1; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710338626; x=1741874626;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wLpo94qKWsozoRr6V7V4egX0OkLI9crZTtr3whCeS3E=;
  b=e3iIjrj19jfqQrnv/RLGQ2uTCSleCRqFiKkcRJmy1b9dbMqXulb7dN6a
   O+sbzvQz8ciWS2xil/rlhMW9LGh2josua+IOFpMwkqOP1aqQ5xo7PHbIh
   +0kJBn2L8PyAw73sdfOT6l9CpM+sBeTQJGY2iSuxd+0VNgl2d28zc/mtM
   zzqQ8zMRC1m6MSz6n3gY+GiXDFXXzWkn+IfG4PaGYdEjmWHEo7iWVsW7G
   jkPa/NuikejOArMYB4CiLKysscL0JLQYhA5NgifKIZzspm4Mwn0D1s309
   AmO7h5PsewkqdgRP/yZQEbxcQzOtDhwK0iNbu1p3u9zyiR/5f8prrZ5sn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="15738009"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="15738009"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 07:03:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="16660867"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Mar 2024 07:03:44 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 07:03:43 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 07:03:43 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Mar 2024 07:03:43 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 07:03:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dgpv8ogdjqVj5f5e2Y4HgeCBd49+84yi5lcIgGKVyxngFGDgQbiY8mPKWr7nEIsPqO9CEF8J/6fzjGBJJBWTM+r8z9gsacoktWcpaeVC6RvlmeqNO3AUsHfjNhPBZjpz1oa1fEm5neAFAkeSpFeUGFXX4y5AbUsueBO/wa7LljQ/04Atepb00BsTgGmuH1ibUqNo/SA6MepQeeuVppG4QugJn5T65aMvxDrMFQAubQrS9Hsq8GuH/a1i6Qe1f65qemeQGRhne3BcLgrBfpRXyRydc5/f8y4uMDWQpKMAi7CIi3eBkxY5CBRijLio24R7Tdg9trvFprCqIrXpON8nlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5avEZhcFGBy9GEpP/gOVRgwFi6MJFE6zD5pjqqbTEQ=;
 b=ERUqxH1E7kMJvcXHQfGdVfVIx1Q8TBLXYwGmOODV8awzm1aQAvxVdozs4703ji9js9LRuUcuqhIlpNFgh2xg1b4P6flnWhL1eoOUku5ntaYuCxCndUkwpruIENw19Lk6+Ex7v1j8ZvuKm80hGUC/40xhRE/v4+EdEztxD0Yc2yqBbLXNNi1qhJ7mUt0LzkOTUdNFmFNcjIk7ruMCG+dv0CcgJFiXpVYeT1CVfWE+g4kqp0f4tjss/wrzBPWz0FSI2zwizxIQzOm54JL8YGmWZ1HelLICc5ghl8LdHQdXkU+CJ/9WRrbrjIUK76S8iyCT9yylMk7Y90RVyXn26Jp8pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by MW6PR11MB8339.namprd11.prod.outlook.com (2603:10b6:303:24b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.17; Wed, 13 Mar
 2024 14:03:22 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::d48a:df79:97ac:9630]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::d48a:df79:97ac:9630%4]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 14:03:22 +0000
Date: Wed, 13 Mar 2024 15:03:16 +0100
From: Michal Kubiak <michal.kubiak@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Ignat Korchagin <ignat@cloudflare.com>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel-team@cloudflare.com>
Subject: Re: [PATCH net v2 2/2] selftests: net: veth: test the ability to
 independently manipulate GRO and XDP
Message-ID: <ZfGyJMSWbZCqqFlM@localhost.localdomain>
References: <20240312160551.73184-1-ignat@cloudflare.com>
 <20240312160551.73184-3-ignat@cloudflare.com>
 <ZfGN6RTBCbEm6uSO@localhost.localdomain>
 <20240313065725.46a50ea8@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240313065725.46a50ea8@kernel.org>
X-ClientProxiedBy: DB8PR09CA0002.eurprd09.prod.outlook.com
 (2603:10a6:10:a0::15) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|MW6PR11MB8339:EE_
X-MS-Office365-Filtering-Correlation-Id: 77540b13-7aa6-4c30-7b6c-08dc436657d8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yLD5ztcxXcqa3/7j65ebJXUa4PxIN/hp8U4MOiS+x/eSzG7Qjaqee/HwWy08MgCK5Ea6dm4IfiCdrHczHQfYFbaBeQ3j/XpPa55Ix8A8XU7ifbYw3x9QwPNd8z6wlW7u5ZHGfrWNN5SPEDx7FGClTsXhW+w/KE4oVarRxNbmsE6ZW8QN6D31398zv+/vytW6mwQUOrTKNbUljun0mo8S7qo69K5gqifTCedDoIY34ENVbshztpM6Nre8CoG7D9twqCqDKDXEZ6faCu57NGWEphF/aUPOM/fiEtX21NP1gtYTNdQXMHzqbXPfwt/dHHsgggH4AY76K++ZOsYwcxSx7qFZKDyxmm0Ss0+iQecMblMdOAy8vh0LuWj9/1VkBHKrvgv7Rx2KY+ZY18j8St9DJwV0BSTC3lo9ti8SNfPy0W7EZpq8KRa28FuhylGa3zny33bugJuhrH1UXH5jiULkDivSESaZzwOvCLHsgCSqI6EI6yhy8kXbV5XLTwfOLf0HbW0bmXrJTopJTLmbgR0YH+oqRqfGrIrj6l2U2PLEXOGGx6d391nCO5iZnMow84yHrab63m1rVr8UxF1inyJLiPogKT+jTmI+zn4UveYf/n4Bo7cMOAbrYcWgYryc1sIaMJLe/Sb5vBPWH40iir1YqMSk26p39gZwn5s8yFeTYTw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v4IWkHiwfmHl/sD+uFCauHo47oEAoC7KoRSyogbHlNP8Nb4VjYE9j6Ecv1PA?=
 =?us-ascii?Q?7g5xUV/bVFeAnDcE1sbkUGmiMeZw8DTEvSqgoI1OYD1KHRI+eB/dgWIi75DQ?=
 =?us-ascii?Q?T4iartl68WIx7SrsZ9+DEy/EqHhsdrVg/vxc8sI66y6Ad9+Khezb0i8tz+EP?=
 =?us-ascii?Q?6GLIiWnkzOBfdRjPknHMcrx53ANOGHWoqoVsqoccSajxNtNvMPkgQtjTvFzl?=
 =?us-ascii?Q?/16JhwLrBnpJ1pkSLByDdF1MtXtek5wuWk7a9C1NjPZXF4msT/m2LagP6FPi?=
 =?us-ascii?Q?KHOgpMTjgEa7m2jYUt9LKrDUcWfiVD8Kj+Ywr1B2C8bEOe8Cxw/pRCIVCAx9?=
 =?us-ascii?Q?PK6eYjL1mNneFeA+6vjBkAlxmDsYGtLy3eLEKXN0DX8KlY7KAN8Vfiq9f/8v?=
 =?us-ascii?Q?lqrr270RR/x+ZpS7IdQUWYmQBYhsVvgdL7fK/TaS9Ijxs0wE6yTgvgXhnUsq?=
 =?us-ascii?Q?PC6Ht1XWsRUlJIkmRFNjQTEb+ullUsDJkoei2+CkB1KTs3mq+BT1u89EhMZU?=
 =?us-ascii?Q?Cu4+FK3pvWh4URgb5lDGwaKky5ynqae+OyHjCrk9Q0LZExcDTxGEv1Utw5mk?=
 =?us-ascii?Q?Avf+5EORoeWnd/w92MUOVWGtihWNeIphLS2IeiO5wo0mPf0wGko/e74PTWN7?=
 =?us-ascii?Q?0vsiCLK0uXFmh12CGD3ok2SrF1+gCZl365XNqvhn0/8nZ3TIftMRbQD4aI69?=
 =?us-ascii?Q?sM6hoWmNIew5l3lYGWhOiJcEEVUaYgIVNH5BSh+Av5E3eVIgxzW1fQo0j0Zq?=
 =?us-ascii?Q?ET4vQbZpp+PgtJAGlnTb75lkratYKWWyqAhiCtWoqa8HFM8JaeO5S4Z4D8Te?=
 =?us-ascii?Q?BBbOmtYeSc/vNIT6vXzeYrRGF3sZK0nwWY4ospaAalySsCIjK8eSeOvv1RWB?=
 =?us-ascii?Q?WmTIElKx/oxn8Y8io4KhCVZvibjG+zz2PJKWkYkwPr3Shdiou5EH8PJ+3e6w?=
 =?us-ascii?Q?vWCGIytDKyGXLjJXJLfZ/WVritr7ByMYDdyfrvCjXl0ou8roRBJelDfoz9j3?=
 =?us-ascii?Q?hX0sr2Dq3AuLNmSvQcvmQOQ1MB+GY7ZwBIDWp0zBdRDoaSFtldcDyuVE2sVg?=
 =?us-ascii?Q?REhNpRtOslSJLL5lOTZb/xS5CyTYegLnA3t0mS9gzx9XINBVz1lX5UCA99Co?=
 =?us-ascii?Q?zh+O+Mp7Traya3aXv2YtGkqlJFtULZ45y5bhOGDhyNu1CTKNzQ9+XEqjDT8F?=
 =?us-ascii?Q?IlVnjsBoxTT7CMdQMC7l3J3FJ6hss4UpInFmlkT0Z20WuzPk4ckdraWzokQo?=
 =?us-ascii?Q?VapIu7PWhigrkeXrWnKHpC91DL/96ImxrktEKL+nhqERyBh1XEKrTPKEnmsW?=
 =?us-ascii?Q?eqtqRJwQxrwarma+9/wfoniuWaNS5Z6KgpAVABhC9CoZxmfXuCFMxXMzgeSt?=
 =?us-ascii?Q?nzgiecrtoAxP7LTPLxj6/bD4eqWtRNBKeyyREMvY6zC0LpIUjWsW1BS5Imyc?=
 =?us-ascii?Q?ocfWXT9VbpNiPvKGV9h6zJO2AQ5i7G6qcjXDnjavSCmlxsmRvZYQLhzf0qP5?=
 =?us-ascii?Q?pI4tR/D8VjhKUnmFtE6eU8d8JfwDCxbOsAyhaAKVNUu8e3vNyqVNpgPKWF5K?=
 =?us-ascii?Q?YunTsg6nM5lUKKeLUXnhxgRLpeq8TYk2LDo4kjxbefQHQxrNcjwK9Ye+YYrh?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 77540b13-7aa6-4c30-7b6c-08dc436657d8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 14:03:22.0601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mTIt6nJkb5AgVN4VqU4rut5dCekNANwfjhymJIhLp/NkSBFNWf/d4X7ltR5nlfD+xvfp7gtb+O8SpQnF2J1FjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8339
X-OriginatorOrg: intel.com

On Wed, Mar 13, 2024 at 06:57:25AM -0700, Jakub Kicinski wrote:
> On Wed, 13 Mar 2024 12:28:41 +0100 Michal Kubiak wrote:
> > On Tue, Mar 12, 2024 at 04:05:52PM +0000, Ignat Korchagin wrote:
> > > We should be able to independently flip either XDP or GRO states and toggling
> > > one should not affect the other.
> > > 
> > > Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>  
> > 
> > Missing "Fixes" tag for the patch targeted to the "net" tree.
> 
> it's adjusting a selftest, I don't think we need a Fixes tag for that

OK, sorry! My mistake, then.

Michal


Return-Path: <linux-kernel+bounces-89186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 722EB86EBB8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81DAF1C22785
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAA15915E;
	Fri,  1 Mar 2024 22:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jZi9RuId"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEFB5C8EE
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 22:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709331492; cv=fail; b=RR//94/dc81KUuZHyHKthzCsnmrQZqRZWK+werJjQQo0fmUNYVe7ElqHKExfeSDAnRbxkwcnd67N22SgKF0r3xCOZjjT1m3abvXgLSxFpbakU6bTMYBznNL3q7RBbaBqnKNT/oRY35PK+LXCRXCYUlgb7cgKgzTQHkPBHiZ6YAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709331492; c=relaxed/simple;
	bh=HWe/vR8jWJ9hc+pbNDjxogz/CyO1LqDgaqyFGij/PyI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QzFDU5g5o88iqs62+HhUHV9aD5BMkXYMkhzp/7PeyQBPihLDifyFAR3V7idxLSkTjKNiPHDIsHcKSqBehFeLsTRFixkqZ2HNcEN9M0V1cX3j4MBnctvOwvXAFS5K9Od9jOwDMKTZg8LQDZyAuQM5O+V52uyEXQyLpzIsx2SffBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jZi9RuId; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709331491; x=1740867491;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HWe/vR8jWJ9hc+pbNDjxogz/CyO1LqDgaqyFGij/PyI=;
  b=jZi9RuIdHxwhsemDxsT7E9SRkWUf0iH6f/vhqE9ORZOvJiEG0vxMxon6
   OxTV88Fd9qjvpz4ZEaMHmzC1mnKx5W0j4ARdRVOieavR5i8TeGd75YVOB
   390yRodS8MjMgXeEnc5GNUapj9T1bXRxcktRPdP7H2Q4meVLgvx07ZIRU
   g/uZJRwrWloqTpJIw9rLSQJPguWMzmhFVl3kDeFQh9jjb1NZq11byH17d
   XH6IZyeLndM+TBa7kZIIay5OM4TiFdUj0o1Q7gqX9N2Wt0RX0w34z+4YE
   rUa1bdS8fTXYagoWpfIe1cujXb08LcHERdnNJWQaegFWgJR+udV0HE9vm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="14531084"
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="14531084"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 14:17:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="8467184"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Mar 2024 14:17:47 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 14:17:47 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 14:17:46 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 1 Mar 2024 14:17:46 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 14:17:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yted9wYAP8XBcwu7S4l2Z5pE5rpIalCOjEv/+f/3CC/4jD8XRiHJYvGrJb+8IQWxAQl6UWmWCaaf/AsW0INkQ0oF7pbb3gp+H63xs3SnsruL4aqfcnvex1SmNlXoZWYe2t0qtPkjia319cBA7P3QdbQl2J61IZ3p5pxGH8RNlfMPzN0LZa/F6NEjShd8wbnq9Mxh148tooGJ8tmH3NK/Zh6jb10GSt40TcFjooChKD9SeOFeWCtfxdjxGN4QOerOoQpaWu8+6DCr0nmKhWQkaBVoY1sozn7t8DIIzaCWeVrNltNoQp6DdZWbImwMw1wWQ+BnPj5xaqcDOTIrV5tDmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hD1q/bIMHRMN5b1UPSJCLmBLr03cw1SqfHmDBNkBvA=;
 b=NmCx29abt3P6phptWoK2hW/8sE7++lVcWHAmy1lavn+3nWxln2cQRKrxiAkWlXTF6dTcxrjQMNOHI8FwCDTHi9Y7Tak5dYJYH+LEyDxconP+cyuDlSUYRKBxVOV8U0oP1uwuBl2LN8ZYFd9+KYzd/bf26qqPWC17Vxoc6W7ANoEJFB0bRBNVBBMx8ooeWuZggbw0664g3Fj2I4XjAx8aKTJWNMfTJ7ZVc1MweXakTxzaeiv12zI8BA26HcKafcG7QktxipbICc0MCRO77DzrfGcH4zLfdpLeIpPgvR2PywEOdh0lKPlCUiaV5Vh+HULPZrvzva/Y+wNMACN3M89M+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB7915.namprd11.prod.outlook.com (2603:10b6:610:12f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.16; Fri, 1 Mar
 2024 22:17:43 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7339.019; Fri, 1 Mar 2024
 22:17:43 +0000
Date: Fri, 1 Mar 2024 14:17:40 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Hansen <dave.hansen@intel.com>, Mark Brown <broonie@kernel.org>, Ingo
 Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Pawan
 Gupta" <pawan.kumar.gupta@linux.intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dan
 Williams" <dan.j.williams@intel.com>
CC: <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
	<gregkh@linuxfoundation.org>
Subject: Re: x86 boot issues in -next
Message-ID: <65e254047fbce_2bce9294cf@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <05a45cc8-e0fc-422e-80d2-596ed63202a3@sirena.org.uk>
 <71f9b0b7-190f-453c-b55b-c842db4a825d@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <71f9b0b7-190f-453c-b55b-c842db4a825d@intel.com>
X-ClientProxiedBy: MW4PR03CA0037.namprd03.prod.outlook.com
 (2603:10b6:303:8e::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB7915:EE_
X-MS-Office365-Filtering-Correlation-Id: 096b4c52-22f9-4065-5d1f-08dc3a3d6a3e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VfsMKL2ytC8p14yhSACtJV9JC7NEB+oe9kqddZRWSc9A2rhLvqF3PUlecBO16D3tLqOw1H/yw8Ufq+nSwDKQUs6sVvkp8ilxI5zGMBvC5JWh9LMhnZt0zh5NYakGtk/PLkW29xiIpgg+HxZeb8XW6KrSo7T2vUuaUYIRzdd9SLcoHnYQpGhPA6KvkL6pWQ6zBPtKJFKIxF89B2cpQqzEARa7ZgliZ1coSPfr+tMKvPgzLYXpKxLHIWs7W2utl5KvO8oh4xZzUROo5FDihNDbx7EiMMTeDQf2lCjxb8BITcwArec30SIsfn7i0GoppUgpXNt7XC30BYe0UFsL8rYTeYrfRQptWJ/zus3Re8eKPyP0d17ZnXGN3XwSjiGGNTecefZFg+d7U7KdfMQOhbr8mk6QXzd2tuOCu9huKxfqmrsJbuewEg6RMBLV4TgpjcS9yWR2coo2ot1rAopCvAenOf8ubJp6T+i59oVbi5JmmJotmJ+uAj9LT7WiHs6C3+JEMnzNStQqPQ0czMl8QBcCczm76F9nqzQEiFM1QhVVu8RGkOoM8ERVZRncxUB7FD4kQyLKy5QAADVKn9c0V6yk0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cG58tuvRpjloUJXjKEHHUyL6Ta7ygOlQSTQoEd0s1ITn1wYdX82Mfh8bBlE/?=
 =?us-ascii?Q?6ZDzLTmEzKlOTvDxWa4VRs+TTGmJZhiy11Ok4/IVm8EydAEAqvEWoUJtWy16?=
 =?us-ascii?Q?cLSewXFb4XCYCvhFIOhUQHZsopCCIUqgbuAg6t/VK7hUOLDWkTY5grnCcbBT?=
 =?us-ascii?Q?ftY6a/IPNDQK7BgLx7uraoADfLCPss6xbJOnClA5zpo4u2c4Suu1fJXIf3NM?=
 =?us-ascii?Q?UGs7bxxrZUOBT5jSK4stomPtHxzqnWVvINTWCdxgY4AdCV4QOE/g8jnrfDmP?=
 =?us-ascii?Q?sh3pV7pZKmcRWQnflSHpcgTeLtSDy5JqfSnKt6z8QRJWkZfX7PHNRq93Kp7d?=
 =?us-ascii?Q?uwR2kcaKolo2P3pw8E1Bp+UZedtl1MAuJvLvcuW4FfK3zkeaCIdkkSBreUyM?=
 =?us-ascii?Q?sRmrJRPHAw1+1IA5QazygpOfAzIZEr5OKrpTm2EYfKpE4i5Ny+diCiY5DNWZ?=
 =?us-ascii?Q?Osex5LzJaJLIrJUoF2o7CJi9R3pSw6Pwpe52mK+s9gcf0S7/n8uAfYwrSwoI?=
 =?us-ascii?Q?bVtQpCYYy/ZR3kdY984RPuHnIqqCTk9aFBqE6QhE9WxpESvBaELjI2CmHmm/?=
 =?us-ascii?Q?aNxNzV3QVM4Luhb/ZGmwt5yo/WwheNMDaZYNMNejI133fNnlZM8OO/0lLsa4?=
 =?us-ascii?Q?KejXNIYMvaEtjlGpDPHBNFcNgake4iZw3YkVeQErVGJoaru8VEC+KcWqK1yB?=
 =?us-ascii?Q?L/qzxARbNQlEY8YqonHHHsRAP91EZBz9skUOL2X9mF5FY4bFFepheBwTfdUt?=
 =?us-ascii?Q?WB2zt1fANEz43OAxanIKhlE2LPGF41wbslP3aGnv+zZ+cXXMGXMtS1eGbWsb?=
 =?us-ascii?Q?3dV+NV/vyEvZOqAelpkgTFkgiSaQzY+p4JCi2NAqemRrqpUsEh2HBfpH+Sku?=
 =?us-ascii?Q?KoP5iWH52+lgflTTtYmjyXqc9FuI3jYXPRtWiM9aZAld3mIlh8zjhnYMgcBS?=
 =?us-ascii?Q?sxFdmilmHvbtP67RUgAzbH7FMNFbWemSjQ5ZOV8xpmb2Fcdvk0B0+enQchI4?=
 =?us-ascii?Q?bYx+TDDif6HVLxL3F9ganxMD/xOZ/I0bS2Uuo33PgMI9Ap7Vl9r06GAzQSsB?=
 =?us-ascii?Q?R5lJ22tiwSIJoK9XIVnm2sZrikExH+d7QrhT/sIenMOlm4S1JZxz/X7yeWZZ?=
 =?us-ascii?Q?9uq9anS5vujEXdlcPUmDBTymlHN+bK4qG8eLz7M8kSBSOyWXmWy6G+60Dw35?=
 =?us-ascii?Q?MQRyEBLnI5EOt73o3e+UwcHZ8oWQUmv+tpJWDYk9WC7z6BC/h1T4uVuuAdR7?=
 =?us-ascii?Q?Ffj8BxvmPrxKnjLLfGNDxuXdlbUYlkrjFr4sUImTBNEPBUykI8msvPCvhgiI?=
 =?us-ascii?Q?0LtvMeXio+JTaVqJRQwMd3q2GSfRQ26agUWpj4LYjWWsFESvm5RtMGjjUcTI?=
 =?us-ascii?Q?1Y3gwww6lEUNRKk/3AOjz43Y3O/1pbTYzRXmT9qbMwlrxyg86F1z9b0qgD62?=
 =?us-ascii?Q?AX4dSg/z8BVpGFVMgI5ydHgQTxELn2z5WayuKZBN9ROLUCpX4FgkIgvMIzu/?=
 =?us-ascii?Q?EzcA1c+MKP3wiMkROceyM8ljKeLt6hb7MLC4agvgXPb8GhYh9mSiEj8gvCmZ?=
 =?us-ascii?Q?0TF4onNBQ64IH28WLJpnE4LrVyRjNqOGXuSIPjoXnKwyloRPqF53XS7jFZE6?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 096b4c52-22f9-4065-5d1f-08dc3a3d6a3e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 22:17:43.0983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ABkqACVmWVNwngDLKmF075uIHQVpVmgKh1Fq31KJzb9H99916QH6XTvtLhN5Ixn5ibqZyOHbWaXR3Q3Wy11BdwWACindFQxxKl0YbTM/Klc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7915
X-OriginatorOrg: intel.com

[ add Greg ]

Dave Hansen wrote:
> On 3/1/24 13:29, Mark Brown wrote:
> > For the past few days -next has been failing to boot an x86_64 defconfig
> > on the x86 machine Linaro has available in their lab.  DMI says it's a
> > "Dell Inc. PowerEdge R200/0TY019, BIOS 1.4.3 05/15/2009" and the CPU is
> > described as "Intel(R) Xeon(R) CPU X3220  @ 2.40GHz (family: 0x6, model:
> > 0xf, stepping: 0xb)", it's running happily with mainline and
> > pending-fixes.
> 
> This wouldn't explain the bisect results, but there's been a crash fixed
> in here:
> 
> > https://lore.kernel.org/all/170863445442.1479840.1818801787239831650.stgit@dwillia2-xfh.jf.intel.com/
> 
> that looks pretty similar to your signature.
> 
> Could you give Dan's patch a shot?
> 

Hey Greg, this indeed looks like something that will be fixed when you
update driver-core-next.

http://lore.kernel.org/r/2024022342-unbroken-september-e58d@gregkh


Return-Path: <linux-kernel+bounces-99398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E9B8787D7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 156D01F253B3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFF960864;
	Mon, 11 Mar 2024 18:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bosDVG6w"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88003604BB;
	Mon, 11 Mar 2024 18:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182292; cv=fail; b=NU+ZCftVunisiztkiGAiVU+84ZZF6CcgmRwHbuw76gWGo4u5AusIrHUnNXZoewPEdYim/pfZLsQBr4xwtrvDHhepm2Gzl5f9/xLSIn/AXq+W/hrAPrv8zxsrePeO3/9YF4iG8qUm6wMX4fM3lFu/+x93KkwSM207o+TfwFrYXns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182292; c=relaxed/simple;
	bh=NCrCQZogk2lXp4a07dTMNNbms+OkcMMceEwyGzU8gtI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m99y6UXLDpP0lyU5d6fG25chFHBNQBvgHiMoFQ6QhcM0/vW6VXhCDDy5AhOn9AYsJm91miC3IbGP0bUMlZrSx2/zg0SGaXrQ2xVUOWYWwb6nyhxujXiATq/qdZsskQXVR4WuGT1ms05iPR+wQ+O7BNRgAV1enRBhJELcLH/SghU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bosDVG6w; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710182290; x=1741718290;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NCrCQZogk2lXp4a07dTMNNbms+OkcMMceEwyGzU8gtI=;
  b=bosDVG6wJPURwpHK8sBToRgt16niuFVnuiSRvCTI6vL+K8FAWkVPzBg7
   iUZB5wwPL5qCbF530Omxqga5l7lf4MoZS8LzUahagNPYkZwCQhPhmucny
   jIR/wg4uF7YUl83TeM1WkRjDmGAdPKuw5i07BahCmZg+p9NrxgnrWmDUj
   0QFXeOvAMDafTBQ/Qz0aPhv4SBoAfivEWf/POgv18sKrNXNLeORr354tc
   nm3GNASI5FlzOkovkXjxr/sO94O26H55b+7okVzYbZtYoelx2RX3lsOq1
   YfZviXCb2RD8cFZYwFNhgkcL33TsZxyU2mqf75k/zP2LrZaTEhLCWmO+s
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="8621781"
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="8621781"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 11:38:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="15911351"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Mar 2024 11:38:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Mar 2024 11:38:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Mar 2024 11:38:08 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Mar 2024 11:38:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuMez9hvp53hhWZri+GNhEBjWbuTs6HC0iLoYYzVMvLiH+QzXkIE+G7lHrTvBlIRKngg1yY679ZhAKCydnGkatzRM+VmEFO22JVeI6WrPOY9+wQHx8kIwSD2Ch/P1LK35z3lmbgHnMyknWeyzdxE0i2PqBxTjpImsOSguT+wOhTY+4LhORGaFnIrFWzE5kMV8xzbaDFY8bO8Wx5cmcHwo+xqUfGykrdhhlsu+wBmH3/9mXcbsKJwz4PgDZzAH9OUDx7elpN/vy+cVux1g7r06gMvp6BAy5jEEaFqkvksLktc36OAgOJOv9YkBKrkJjShzA1P+CeiOgP1bh27MWeKyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MNcqMzyG+vPZdeMfebpeDVJd0gVBkUkdZPs//JWVxM=;
 b=Jp9NhacdWAic0jE4Addk9J90M3r0fzdBPORKoMJnCFhrR6Da/kXoJ2GiHS4dph4p4JDDENMjvgY5Q8UedNVIndLWMTXJN/4COq6za2svfqo6Z2uqg/hY1yMuaFVkLu+dYpSUMu4GV99j8UimssmdED5S68t4Xm0d/zdY0HPfOcx8bFOKXj1CBA/AJQE382Bole8G/LKX0+n+SvbbZQCavZPQkGYgN2Pgg7/i1CtnhW1wfBeyvdDEF8M6su8vWymaq3dPhFmnolRwzgXAxkdEhprQJk/uOrGO2NOHLIt3pCkuptX31yp87KnkHge6izLsCngzzHl2AWurMacyKrQQ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by SA0PR11MB4752.namprd11.prod.outlook.com (2603:10b6:806:99::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.17; Mon, 11 Mar
 2024 18:38:06 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::9c80:a200:48a2:b308]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::9c80:a200:48a2:b308%4]) with mapi id 15.20.7362.019; Mon, 11 Mar 2024
 18:38:06 +0000
Message-ID: <97ca4f90-8468-238c-43cb-b0a64a4d6f41@intel.com>
Date: Mon, 11 Mar 2024 11:38:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] overflow: Change DEFINE_FLEX to take __counted_by
 member
To: Simon Horman <horms@kernel.org>, Kees Cook <keescook@chromium.org>
CC: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Jesse Brandeburg
	<jesse.brandeburg@intel.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>
References: <20240306235128.it.933-kees@kernel.org>
 <20240308202018.GC603911@kernel.org> <202403091230.ACF639521@keescook>
 <20240311092813.GJ24043@kernel.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20240311092813.GJ24043@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0353.namprd03.prod.outlook.com
 (2603:10b6:303:dc::28) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|SA0PR11MB4752:EE_
X-MS-Office365-Filtering-Correlation-Id: daf72890-a5f0-48f3-9e21-08dc41fa642e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ujERMpr+SJZLocFLUGgmx+IayAp6OReLvy4iBntTONJATPsljHIqngGx3pHa/yBEUEZp7G/fKHeMs2Jj1G3Bwo885suGP/YTCiw+ja38OPcy/+81SWXJWD0aUHsq/5V7nofkmsrzrD9RYCy2A2b7ox43VJRZP1e+sgYCH3L7WyhIlRQTJXiGSuztkjwq4VlCIWErG4dqNSJJUdaCA0NcI/blirByudqnhy/lq0YZyUa+xhyFfqaaBa6Xb3jy5+HkyWzfrSNMm53Xw+34eORKjWy73QZ6A04O7lJFRkSGISxXNUWnoZTjXI+MAn085YvILM7IXVUHc6rUaZHOlTdjcWoRIaTahQjAGh5YPK3wRzTQgwwL/DiefUIai+NcVFLGcOxMCvfYJaMskcAcvfqq7gDq9fSi9y94gtel3B/IFmR4tw+2oqn3tk1wMS/1Uv8zKrJSPQpIyemUdRNJGQFtyY1C9V0jAgc8YBw1RrDnDYgK+brTV3pMiGvKH7wLIXBksHYOtlJ27xgXqoPk7OY2krurcScEOOfBq5dg6Heu6wAyOxAGOPLoyliBjLAPE0CxPDaEvX/2yX7GSf9m814KU+BQ97B06j5D7LPlOC2RBpqyTL4e7G+1LhMH7kdbqoa/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzRla2VPdE1CcTBWVENYRGZQS0VmWWYzMkZvMkxkeGFSMzh1V2x6TU1Lai9B?=
 =?utf-8?B?Z3JTelFYTFZkOXp4VlZGS2VOYzdubEZZa0dhTXJXY3Z2eityTEZCRnFKemRF?=
 =?utf-8?B?bzV4UkFlU3dxTEtHRFBzM3Qwa0VOdmJsM0RkeE5LRUZpeUZTMXBYRDNHc210?=
 =?utf-8?B?Q2libnZxWXplYlRwSkxQbmNKVGRqZVpJaTRhSGxMdXpJaWhsclczVEgrYkMy?=
 =?utf-8?B?ZzFkbEZpL0FDT0wwMlNpWEYvMUxyN0kxNzZhamtxaytyM203aUFnc1JGTUNp?=
 =?utf-8?B?aGdMOXQ1elIxRTJvSTUwcmExSk1QaDZVcHVVK0EzZ3VwdGJ0cnY3NkxDbXkv?=
 =?utf-8?B?QmpLV2tSaHhCUk5RbnhFYkE4TEZvaElRRW5lVFQzMEVXb2xXTzJ1TGJld3Uz?=
 =?utf-8?B?dFBVcm9ndnJpb3FlK1BaaW05Ni83N20wemI1a2hUQ25OSWRiMko3RWtXUXlV?=
 =?utf-8?B?MHhJL0ZGUW8wYmRRYnRqN0crNXVwSjJITXVXeUt3a2YzSGpzWXkyY2JwSnFj?=
 =?utf-8?B?am5nb0tNTFJCVXVmanhPMjZXbWNHQXZoUXowbmw4TWJBTFJtRjM3L1VyMUdw?=
 =?utf-8?B?MFNrSll6dlFocFhrazVVd21Na29lVzJ1UVVnblBjV3MreXRCSWs5ZDFGbjkz?=
 =?utf-8?B?NDFTT01rUXEyUXFwR0J3UjBkRXhTa2hnV1BuVFdzVGc1WHFWQ2hpSVl2c3hD?=
 =?utf-8?B?a000cUJPaUJDc3BoZEFXMHRabjI4dkRFMnB2WDFTMi8xQXZBUGxmUHZXQ0hh?=
 =?utf-8?B?OFRON2NFOXdyeXdUNVIrekZKTk9WejdPVXZIdkFwakVEZVpRY2NBYUhPOWk5?=
 =?utf-8?B?bnpxenVFdlU1S3Z1OFExZ2oxUG4wdlc1MWwwNDhZN2t2cVp5emRYYWs2K2ZF?=
 =?utf-8?B?eVJTSDJJRGxrMkhEWDNoT0g4NnRndXZTMHhheXRGUVY2ZkdjbHY1MkJoVVFG?=
 =?utf-8?B?WkdkRXQ0ZUJCRFlheXFlTGJPTEVJakhSbTl6MGFWZEtsaFNjWU9GQ0dXcG5K?=
 =?utf-8?B?TDdYc1hScVY0bnFEWGpDZlBJUm1MaWZ3ZGg5Q1JoWHcxM0t4YnJXUGIwWkZP?=
 =?utf-8?B?QUxWWXZ0dDE1Uzdub1VjN01mMVN0YzNMOExHSXBPeWhDaS8wYTloVVh5T3Jn?=
 =?utf-8?B?Q3hDM2hiemx2OW5Xc2ZDM2Z4aXBwMmx0TDFURTFjZmtuOW42VHl6Ym5XcWVU?=
 =?utf-8?B?TFFVdlB4WEdRK2xlWEkrUFNGa0JqK1RWZDdPU0hZeVJyNVEwaWk2dUVZNzBJ?=
 =?utf-8?B?VTlBUnZuM0ExSUJxYklEZmNtNVNyTFVnNHF4dXhJK0lNek5XdTQ4Nlh2ZnVj?=
 =?utf-8?B?dDRidllFVnZXRHl1VkFIMDc0QXNSTHY3SWJvT3Y3MHc0QVZaeE1KOFE2aTU0?=
 =?utf-8?B?OWtQVU1pMkNxVXpNOS9ybnZ2ekJLOXJZeVdPNXV6U21rWEx3YkcvQzY2N21H?=
 =?utf-8?B?bUlWV0RGSkk1cVVwTGpwZHBKTUFIQnBBQTBrMXZ4RUNKeGpkNms3R3RDOFB5?=
 =?utf-8?B?Q2VtMzFMNS9tZWYxejVGby9iNmlFWngrSUhqb1NZM0NWVm9oVmZwczAvekRt?=
 =?utf-8?B?TjNUTENiSGZub2FDUy8yMzZqU3FhemN6S0tFd1RMZ0ovRmdvZWkrZ0E2RzZv?=
 =?utf-8?B?SGphdnZGNXMxc2RpenlhRjJHajlUZGdlVGVNRkJLeUV0Y1NrMTIwSnRDL2cw?=
 =?utf-8?B?dWN1TkxVVUM1RlB2ODFoTDdKZU1BclUwVkszRGV6c3NQS2crcTBnM05TZm5U?=
 =?utf-8?B?OVZmM3pMWWZhaXNiNWhvbm8wb3phbXZ6eS9QYWRvS0VWejQvWUhqaDdXVG5C?=
 =?utf-8?B?c3lOZXFDejl2dER5RmU0MFZyckdJeDFFSE9VNEIvL04xQkdwbXdGZnBYaytN?=
 =?utf-8?B?QWpZclNmY0hwcmlIdExUZ2w5U1pWV0tId3RlRS9BemFLQmpyQVF2TExtZEV4?=
 =?utf-8?B?RlFBMWljcDBUaU5kaldteTZHMndJVVlQUjRMdno5M0d5ckdWdU5ONU1hNENO?=
 =?utf-8?B?MUZad0llT3l2ZzRKalVHaTJmMFRUWXJnb0JpVzNSZWJoc3RERFBaTkdpczFE?=
 =?utf-8?B?cnZhVHlBY25jaVRCM28yTU1VeEpFUWpTMngzQzh6Y0NIcXV6Z3JPU0ozYm1F?=
 =?utf-8?B?amUyWjk0YzhSZGN5b3hsVmcxVU1vaUNUYUxoeWdYV3dzd2hLeUFVTGthYmdL?=
 =?utf-8?B?SEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: daf72890-a5f0-48f3-9e21-08dc41fa642e
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 18:38:06.0235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zsb/NQj0JtIaJPz7NrKtYlXV0ImJsGj7LgbG9TUyEo/y5VOQ6u6VSznxT3fAaNeq3Sw+59y8wTe03JG7g5OzgwoHbaD0DSJHkIuCM9xLsAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4752
X-OriginatorOrg: intel.com



On 3/11/2024 2:28 AM, Simon Horman wrote:
> On Sat, Mar 09, 2024 at 12:32:45PM -0800, Kees Cook wrote:
>> On Fri, Mar 08, 2024 at 08:20:18PM +0000, Simon Horman wrote:
>>> On Wed, Mar 06, 2024 at 03:51:36PM -0800, Kees Cook wrote:
>>>> The norm should be flexible array structures with __counted_by
>>>> annotations, so DEFINE_FLEX() is updated to expect that. Rename
>>>> the non-annotated version to DEFINE_RAW_FLEX(), and update the
>>>> few existing users.
>>>>
>>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>>
>>> Hi Kees,
>>>
>>> I'm unclear what this is based on, as it doesn't appear to apply
>>> cleanly to net-next or the dev-queue branch of the iwl-next tree.
>>> But I manually applied it to the latter and ran some checks.
>>
>> It was based on v6.8-rc2, but it no longer applies cleanly to iwl-next:
>> https://lore.kernel.org/linux-next/20240307162958.02ec485c@canb.auug.org.au/
>>
>> Is this something iwl-next can take for the v6.9 merge window? I can
>> send a rebased patch if that helps?
> 
> Thanks Kees,
> 
> I think that would help in the sense that from my POV it would
> be more in fitting with the usual workflow for netdev patches.
> 
> But if the iwl maintainers think otherwise then I have no objections.

I can take this through iwl-next. A rebase would be great and if you 
mark it for iwl-next ('PATCH iwl-next') so that everyone is clear on 
target tree. Just to note since net-next is now closed, it would be 
going to 6.10.

Thanks,
Tony

>>
>>>> @@ -396,9 +396,9 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
>>>>    * @name: Name for a variable to define.
>>>>    * @member: Name of the array member.
>>>>    * @count: Number of elements in the array; must be compile-time const.
>>>> - * @initializer: initializer expression (could be empty for no init).
>>>> + * @initializer...: initializer expression (could be empty for no init).
>>>
>>> Curiously kernel-doc --none seems happier without the line above changed.
>>
>> I've fixed this up too:
>> https://lore.kernel.org/linux-next/202403071124.36DC2B617A@keescook/
>>
>> -- 
>> Kees Cook
>>


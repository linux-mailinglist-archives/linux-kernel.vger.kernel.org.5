Return-Path: <linux-kernel+bounces-79180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBE2861E89
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 519ADB21672
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4A7149386;
	Fri, 23 Feb 2024 21:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PFKE5Eml"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D454146E6E;
	Fri, 23 Feb 2024 21:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708722531; cv=fail; b=JSC8RyEef1I5Pod3NaerGXwY06yize5k3VKUlC0L2f/WTtyHRoEpynn3NonkpbRbhlFaySQ17eOuS5vxLS0cmPnuMxtOTmTuVg9oJqUXpxbL9tMAdVP6dmacde+PtejTI/DpwdCco0qLyAlydF1/MWPRG2a7diB9ae9y/Gebywk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708722531; c=relaxed/simple;
	bh=hJhlZbX7lys374KjC223/i9Iz9iFpDO5773DtShsqP8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GppH6SINtqyHxIRCa4iBplKdbi+3kRhU88dn4zdRqihM8HHnbNCLUrygGyQOPc3zDRi/VHx6CEnRXRGhoyJsqCu9hLhG1AqP0ul3pjTjJQigrlv33Fj/azy+e759SfSuAh829JcGh6Fq3GQfpsHyJWUhR/t6Mw2E2ZdXPqVUtwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PFKE5Eml; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708722530; x=1740258530;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hJhlZbX7lys374KjC223/i9Iz9iFpDO5773DtShsqP8=;
  b=PFKE5EmlxWRxw97zDW5EZuYvS/Prfc4iZl/gx7Z1n4CG97tKIa3uWrG7
   n66I4jQy//ET+BBDk3RVcQ/fp7qKVJ3OMB/4jbm4E3O/pVn96/x3ezrmh
   RENq/U1mteCuPsRGqyjzYmZxKItSzoa1NB8Pbtajlj5J5pYtyWm+TOejL
   cC2pVxZE7g3Z0U4rkJ8YptJP/K0TZYwbu+JEQSR6dtypbBE+TuSbLMx08
   ZzU4msrbZGMSNEoyiepFcjaTLo/ogSKe5CmpK33VnU1r2ZlMfuKf7Fm3q
   B7gbVZzp1DZFcIM3Hj9QxDhbJvxwA3kO4sPOFF6CcTJ2DVUDe2GWgIez0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="3573573"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="3573573"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 13:08:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="43483388"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Feb 2024 13:08:41 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 13:08:40 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 13:08:40 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 13:08:40 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 13:08:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckp2ld1BXJ7H0AqFTgDiaiFRj2XeE5tafgZU7MOz1R9V+qjCHRPS29hHN0Xv5WlSG+OIMYZZ2LAO9hJZdzi7argk6YZb97DFUVntOwNCb4XCb7kN11LuiFlJ82m97k6/b/NEYz8LLMm7CTQTOcPYpS/NFk2W3P//eIJ/Pz4oHcfjt9siJnwjEftSqOqtJ213ve1KabyyrEcP5VURaXgWc3aHbemVUpW+cLlwo+xZNMFTKQAdqVTzEKFxtd3cVdu//yR4Xgvsqpka6SOM1wWr0tj1TNccqtx+lKzfBJcMoFfBefdb7Ut4uVT6gE3tdN+KqvT4PqVK6qD2/rnQ8bqAJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuJMuBzTB/P4m+Lmj/tQHzA/0YIKYsVpzWr7j2hnDeY=;
 b=G/AsxEAYR9TMty24C1Q0iV/3lZi4gfeTM63faIYw0/ETOM8+1DtHPjl8cu0s9oT0oZvSbV2ookcutrhKqiuzByLezSEcWES7jFphoQynttZYzjUeWU+/wgOEbJsKZycRtYW82WH53bySgro33L8tSfxNBkwai7DX/o83c/qs/RIDrVp40j0bxGPk9ln6f6KAoMiM4CZ1R+tswzRqAZjZ+gJFn7KzxPVqQR7bT+HaQuBWL6y6s9ED8crYLyBa4WBQmnW0gSbzoMqQDRfWjOoYZV+2JeHkw1Um1TpdyuN4SKy8uGVkfE1qM00SIPFl+buxV3tbkTaGZ0zM2QPZ+pPLbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA2PR11MB5100.namprd11.prod.outlook.com (2603:10b6:806:119::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Fri, 23 Feb
 2024 21:08:37 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7339.007; Fri, 23 Feb 2024
 21:08:37 +0000
Message-ID: <6e0a725f-3bd8-4e14-afda-860f1e4c1dc5@intel.com>
Date: Fri, 23 Feb 2024 13:08:34 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next v1 5/6] tools: ynl: ethtool.py: Make tool
 invokable from any CWD
Content-Language: en-US
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>, Saeed Mahameed
	<saeed@kernel.org>, Leon Romanovsky <leon@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
	<corbet@lwn.net>, Richard Cochran <richardcochran@gmail.com>, Tariq Toukan
	<tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
	<hkallweit1@gmail.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, Ahmed
 Zaki <ahmed.zaki@intel.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Hangbin Liu <liuhangbin@gmail.com>, "Paul
 Greenwalt" <paul.greenwalt@intel.com>, Justin Stitt <justinstitt@google.com>,
	Randy Dunlap <rdunlap@infradead.org>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Kory Maincent <kory.maincent@bootlin.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Jiri Pirko <jiri@resnulli.us>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "Dragos
 Tatulea" <dtatulea@nvidia.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
 <20240223192658.45893-6-rrameshbabu@nvidia.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240223192658.45893-6-rrameshbabu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0376.namprd04.prod.outlook.com
 (2603:10b6:303:81::21) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA2PR11MB5100:EE_
X-MS-Office365-Filtering-Correlation-Id: 451c90bf-0ee7-48a4-fe4e-08dc34b39a99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SIfSpevkp/rMfw3zVFJgitJm5LI+LoHFqYW+xCtPiON+jAggi0ksZzJXJJSZ/+ImimunfVb2O1fn513kIr4FNH1VsF26yITQZ2Ov7mNgoMR/8Sp0x7ryxQzCtTxpHcVtu7VZJiBMdf/g61oao7ToZ+989Xk3YF4QEPzYjc8d4Np1B1vVh6cQmyXl2x5TXJ5grYaO4FOyAtJl/aaiXw5xJ9e8uaIstcqdOSr7Xv+/kNKtvOQgM69ROB8TDjL6i83nKzcpBN5IL+gpL2a/OJRlHDzriDXhapedPk4EfoVZsPql/Sc/38lAohrQhj5FfPHRuyJUHzn8haKwPvL8btB65EljCnro4SB9+B2Vvm9E3ObYez9gGxof47o9av+UmZqjK5X/ndTUeMtqxWy6ELC7ZudFlBia10GatbbxWafQodATK+w0UG//Tx3T35I4X630ppzH3PIoiPeccinbIvVMaY9FA+OPatsNRXHHzt/mmTcdszom+coaSukPKqSiORwTnb1rtENmgY2rhn3eiwfq6VnXoktaREZ6CFxrl1i4lQwo+gLag1aMuhtfk+OtkZ2MOur9Q7TFcuiOAcHV+Eqs30ZX/VNlpxCKkUsF5JeHm7s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlF5Q25xOUZjN24zY1JqelNSOUZUM1lvUFBVSnBCMTdNYTcycTlhc0VrdmlR?=
 =?utf-8?B?NVp1bXM0Q0RzUkl6d3U0RDF3ZmRKelNNYzBNdU53Vk5JOFhOaWlDd3ZDQzVE?=
 =?utf-8?B?ZVNFcGlWT3lDSHFDN29obzlyWE5jc2dNWXJNUldYWkJmcENYd2M4dW9rdm84?=
 =?utf-8?B?bUtQZzBDb2RVb0ltcUdEbnRrdmxXeDY2MlovMTh4UDFxYS9WcmI1a3dMNVRa?=
 =?utf-8?B?MW1IWkZpWEo5THhOQ0V4R3BLM2d5S21tZDVTRCtuTFQxM25nRVN6WnlHQmMy?=
 =?utf-8?B?bzZhRGNxZWdWSVkzL0hwbmkycW9WRStYMzMxZkVUZTlXTll3ajhDTlZKam1o?=
 =?utf-8?B?czdWajJrZ3locHlzY3M3c1M0b2ZWRC90WmV4YnFheUFpTjcyWDNCRG14alB4?=
 =?utf-8?B?Y3lDSjc4Sk1pVGErMi9zYlJzcEw4dTM2U3R0bTNaL0NWRUkwWk53K0FjbUJ4?=
 =?utf-8?B?Z3RlazZDaFQyWTZJM3gzTTNsaVBkTDRZeVpQRG0wZkU1aCtJT3pUdlpnRDBp?=
 =?utf-8?B?Z3N4Yk9sNnZZb1dnd0tpNE5IZkFDZktEV3RaTG1Cek1ma2d3RXVERzFtQitm?=
 =?utf-8?B?Ti9OTlRZcVB5cjBPRjg2VEJJMzdLVThsbmhTbzErUC9HekFVMGRZZVdTc24x?=
 =?utf-8?B?ZjRXWWN3YTdRaUErYWUyQ0F1WG41eUJzdFIxSU5wVDdEU3A4WUJOOVdHamd0?=
 =?utf-8?B?b2RVaGdGMHRLQm9jTVBKTWk1V2pvanZtRWlKWElrTFVqOUV2ZWczdEovS25N?=
 =?utf-8?B?OXpKclVwVmJXdlF0REdMQ0NsRTBmeUVTOGtiNVBTaEJlTktTc0JNQVpHT1lB?=
 =?utf-8?B?NmlzNnNZanNSUnNDWUlvWmE1d1ptSDdOc0RSb3B2TDBhTURoMkRUZ1NXZlZU?=
 =?utf-8?B?RDR1RkFIdkNqNkxGWXliRXFjVmVkd0Y1elJ0NW9XdlNoTThLTUFoNkpEZVE5?=
 =?utf-8?B?dG1nanpuYm9TcVNLOVFnK05mYm9xYko3MGhJemNMbzFFcFhDRzFWdjVJUXMz?=
 =?utf-8?B?TTRLemJsWWx3Z3FjTHpEYk5iNjlORTk1aExFSkoyQlMrcHVQZnVqUS8rNjhI?=
 =?utf-8?B?eVFweGt0OXV4YndYTUJYeVdPSWdjQm9oZWFicmVOMUgvRDZJMEVMT1FUYy9L?=
 =?utf-8?B?YjhFVEoyMDAvVGU0NitVWXRIZi9LNEZETjd5SkE5RjhkMitvYlFyaFZvaHVm?=
 =?utf-8?B?YnB0UTZkSXJBZFpRWjNWRnIvdnh4YTdWTWVUTDRSZlZuSytiayswdWdvNzdL?=
 =?utf-8?B?K3JPNHlLWC9nVzJYNURnQkRvVEhMQnk5b3VmaXZVREZMZkpaaSt4cS9UYmJv?=
 =?utf-8?B?cHVUaHZtR1JYMUpOQWllM2JLTXBlRHM4bWMrMjhnNnQ3WEhqbktGOVVMckxD?=
 =?utf-8?B?YmVTK2dNME9YelgwRERZZi9LL1ZKeXFyanVwZ2pxeUxyZnduYkp1bjRXa0Vx?=
 =?utf-8?B?SkdXaFRQcDNkZXAwd083WXJwS2V4RC9JeFdWTTJqcDRyakFrS2tWaFVnMWpV?=
 =?utf-8?B?Yys4bXVQS2kzU3FrcnhMeFZKUUl3SkkrMkhZZU9EWGVDblBBWUdueGtSQlBs?=
 =?utf-8?B?aVk3NSswb3YzbWpVaG5pR0ZuRVNoU2thMlBCVEVlbVB0dUhrMW40WUxaWjcw?=
 =?utf-8?B?L1FiSUNlY3dLbDhsYzlKUjNDQjhCT1JYRG1VKzd6ZDkzNzk0MXRZaWQzSEhU?=
 =?utf-8?B?aUhWNHVzcHcwTjlWMVhxUE1PK2d3dXI1MUZ5QnllUjk1NWVvRTdlT09rcndM?=
 =?utf-8?B?L0ZwZDc5ZW00cXpHeVlxTjZXdDdVci9vNVY5WEZQbUluNWxGVDArUk1KcmFr?=
 =?utf-8?B?WmkwamNmeTBhb0xBV3AwSmFpa2s0ZFE5MWlQRnVCWmdCam4xTXJzcXU4SGtS?=
 =?utf-8?B?QURCb3Faa1k4YXlZUjFyQTI2Rk9mL09JTHZJNFpTVnRrMzUweE9qR2NRMFhk?=
 =?utf-8?B?WGI2RFo3Nm1CcGxQR1dLVHlsL01rbGkxY214TWtWUlpTMnRWSlIyQVVwUnpa?=
 =?utf-8?B?YmNmNTBBR1pDVzBScVZwVW9Weis4cTA2aEF5MzRVWWpKNWs3dkVjdEtGblgw?=
 =?utf-8?B?MkhLbVR5dzJWZ2NnOXZ1N1VWOWZob0tUZzl2eGVleWhHVkxmMytxOWwvY2tp?=
 =?utf-8?B?cUxMeWhZQnVnQUdiWDg1clIwWUFob2FQZ0VPaFlVU3VKeWV1Tm5Xc3ZscEJz?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 451c90bf-0ee7-48a4-fe4e-08dc34b39a99
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 21:08:37.8174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3OjcYAveRmts+3ql+cPy1tjatbkOD2PEubD+ixhydgRD0illOzEpxyCHQo4SlU9Us45uhrQJlZO9uWrENA19Bx+DtVz/178yOtUhbrqbbcg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5100
X-OriginatorOrg: intel.com



On 2/23/2024 11:24 AM, Rahul Rameshbabu wrote:
> ethtool.py depends on yml files in a specific location of the linux kernel
> tree. Using relative lookup for those files means that ethtool.py would
> need to be run under tools/net/ynl/. Lookup needed yml files without
> depending on the current working directory that ethtool.py is invoked from.
> 
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  tools/net/ynl/ethtool.py | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/net/ynl/ethtool.py b/tools/net/ynl/ethtool.py
> index 6c9f7e31250c..44ba3ba58ed9 100755
> --- a/tools/net/ynl/ethtool.py
> +++ b/tools/net/ynl/ethtool.py
> @@ -6,6 +6,7 @@ import json
>  import pprint
>  import sys
>  import re
> +import os
>  
>  from lib import YnlFamily
>  
> @@ -152,8 +153,11 @@ def main():
>      global args
>      args = parser.parse_args()
>  
> -    spec = '../../../Documentation/netlink/specs/ethtool.yaml'
> -    schema = '../../../Documentation/netlink/genetlink-legacy.yaml'
> +    script_abs_dir = os.path.dirname(os.path.abspath(sys.argv[0]))
> +    spec = os.path.join(script_abs_dir,
> +                        '../../../Documentation/netlink/specs/ethtool.yaml')
> +    schema = os.path.join(script_abs_dir,
> +                          '../../../Documentation/netlink/genetlink-legacy.yaml')
>  

This seems like a worthwhile improvement to make the tool more usable.

Thanks,
Jake

>      ynl = YnlFamily(spec, schema)
>  


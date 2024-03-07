Return-Path: <linux-kernel+bounces-95451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E82E9874DC8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F7C228318F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C6312BE97;
	Thu,  7 Mar 2024 11:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YgveHfsP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336D5839E3;
	Thu,  7 Mar 2024 11:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709811709; cv=fail; b=cLGKJETh+pXvle3HJ/qtYOzYub6bLpn5yl+tmkY1ZhKur/xLJCZ5bmERd3BIIoMYXrVnBR/L9+Zov3wUPhTRfzlVZn5fQFCt5mQW4KsklmiYMkJGgyqofL+5/xZbuO5rXiISr8AQNdGwVhO/C9IvZUS3tPsf3jG6EyB61kWcn/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709811709; c=relaxed/simple;
	bh=X+pl/SgtKqtiOqn8C0tfIJa2+yPx4ktAcGgiCTya0gw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XhGFXgVrz5kFp51FNdCf368Ou1Nqb/FUqVc761L/v3JMtN9bUXkIvF8KJ7a9CxAMATftohX/k/Mzmw05/YNmufp5f4u+Sl2Nd6byXqcsitC2fEXQ3zI1AkN4hXFx+0phvWXALbgEzyo4LVaUpxMSNuZ+Gd1a5xK47saU2gFf4lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YgveHfsP; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709811707; x=1741347707;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X+pl/SgtKqtiOqn8C0tfIJa2+yPx4ktAcGgiCTya0gw=;
  b=YgveHfsPpVzl54NtgATM88BLRNwiZC266tvy8l2NeJ7Ja+Hr5JhW4oXt
   2+9c09PqR1F/GwjfJi2okKKF1PgS7Wq+aohjuHJAJswxz93Elo7FNmeVb
   5ja7hwgR9MAFph2dTVvScrN5uITa/VeWvsVMGXPlZFY+BHmvqUKh/zYz1
   /EOL1Yfe7F2KG7Cof5WHAKUAWWiDSmH5+0QF7dLWT5lNiFl8RqMX5S31H
   nixFJgT0D7qZOLGHOLih29tsjfL0vOAROAYvFGuxp4VoVjUV+2JnsnZrI
   p0tNLD3Ay0DqykZfTd7aE3yjw37A57gtVgTXpos0j/gj/GMmIxyO4cy0W
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="26950692"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="26950692"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 03:41:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="14752421"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Mar 2024 03:41:47 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 03:41:46 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 03:41:45 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 03:41:45 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 03:41:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XC5FoyyD4+B8XpAa/Ui48JaWJRQ8HOiGc8kmzorKOpu3q5tAsZ4OhXE4/dji4QREqjhst+waF9un+D3jj5bTYYW8Nov6b4VxtkVgeaT9xfktUtPHKsUBZG0FkV8YBTGoakTmY20NcmocXWsWmy8hoseCq1xSjwk04nzhCjHoBuT/f/EJe7K8erIUnCsSneh+N0+tRwO4e9G7a65T2OJaSE6IT9PrqkoQfkqaVKDLa2bkKGlUfj3otyeKxgc9FYvpnWnJxk/NvjIiUZL+MNEqOq9NVKPopDdLOUyZ4OvsSdNeLh38KxR6lDieCf7VdFYx9/Me2V3tXrul/YZ4K+mgtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pL7osRhrmaOM3TJsE7oZ9J2+veBO+L3UCCpW0/jqEYM=;
 b=X8frVa8+71Pxzs6n+GMEyaonmtHky6c5ReI+fsuueG7MxZWDPHLCOGnhyWEz9AWbNgioL0StsdlhTdttBot3dljJzMdLZeNViVKYbHM8Bhf8V3f8UtUbTHgQatJnRhI/XCdSl07U6sIZYKsZSRTA/OP22LLZx8Yy/+MQLU2J8Lxj40l0DkBET+J7IdsBh6b8qDMBjywXDQxeADg18uqc9w3mrn4J4Znwra0eVfFAdwXVuvLBqnL7/e+rZ4w5MdVtBgH0mV99atDgMa89bh5rEVIMZM9b/Q1toDaQy33OQq0XHMS6eG/0hnpgLX8wUrAQXsafF11eN7UNoIK7SpTTVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by DS0PR11MB7192.namprd11.prod.outlook.com (2603:10b6:8:13a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 11:41:43 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::8079:6172:11ca:5fe9]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::8079:6172:11ca:5fe9%3]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 11:41:43 +0000
Message-ID: <8628b57e-3087-4fb5-9e8a-03a1b4b8c31a@intel.com>
Date: Thu, 7 Mar 2024 12:41:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: hsr: Provide RedBox support
Content-Language: en-US
To: Lukasz Majewski <lukma@denx.de>, <netdev@vger.kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, "Florian
 Fainelli" <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, <Tristram.Ha@microchip.com>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Paolo Abeni <pabeni@redhat.com>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>, Simon Horman <horms@kernel.org>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Murali Karicheri
	<m-karicheri2@ti.com>, Dan Carpenter <dan.carpenter@linaro.org>, Ziyang Xuan
	<william.xuanziyang@huawei.com>, Kristian Overskeid <koverskeid@gmail.com>,
	Matthieu Baerts <matttbe@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240307113352.345388-1-lukma@denx.de>
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240307113352.345388-1-lukma@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0023.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::10) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|DS0PR11MB7192:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c19b408-551d-4245-5ddd-08dc3e9b8fea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YgSBmAby4gLrdew/oHJGc07PeOhmhG+mTh/litb4ZTrHhKOWCuScF5g+cdl0P/czjo4anOvUmd35wYtOwHzIjsKOO3CakF+LhthzpiSMUv07PlMYXsmX9kS3dX0T3mdG1LfXUnAVK8LyDKsc1lL3rnQX19VKAU9NmohXc5NnBG673hjjXJ39DE+5JPtFjtiP9RPA3wPi7Xuu7D6+DNkVhyxTCQrwzwHID8H+HDHT8ATetZdWqQcQB7uuSs66wQpTxEekVHaMahDQePN+y4IV3mfnS2M+r0kBSgH+AVa/OuyO4glWzXJTwfuntqpnWOquQlPCySGZNHdt0saYapZ1fz+f7tzq4iiKuidL17+/xnV02N1H6DEHIgdZluboPbQ/rsBvvFvZPfAJKZKwhw5kAJJWXRN+MvQx2GX3Dx8TdjIhu7C+eyM4/xBRz+zQngVj4ubBbATwdevz+ym7m+ZqkZskD8W4QZygofFf4wZPZ+aak4+fZT4xaAf+zTOWBSTpGH4/xNdgeZ2WgkjuqwnhDL8z4kK7QIEaUmPu4JSx063fqv1W4D6w9OnnFYfJ0zT/Ys81mR8emchXxd8fS29XXidAnaJH0Rwn/orMDzCi7cw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTY5Zmhiai9nVWt2YlBSaFFTeDhFdlkyOXFaMDN1R3BZbDhUZjBpT1lnNnlj?=
 =?utf-8?B?RFFOd3RDUUlobFBoTm5MVWJxNWcyRkxnN29yZEgwclJwbUpualdmQm5Gc0tI?=
 =?utf-8?B?eEZUUjZqN2ErYThwUm9kRWlKYkpLeFZpcnBuV0xJVWhTYndFVVZETlNJTEp3?=
 =?utf-8?B?OUpja1hxUTlpNExqeGRmb2VuWEl5TGxDMGhPaFM2dGhXcDhBcU5ka0luc294?=
 =?utf-8?B?NDhLSzNrcjErZGNIeGttVEt4K2Z2dStLZXJoQnVaL3RXaFhzN3BzVDRqNUZD?=
 =?utf-8?B?OEtzaFZmanJ2VXlDOUZ4empvK21QaUc2cG5KaWhaZG5QZ25ZWlBkeE9sa0NW?=
 =?utf-8?B?dEVaTWxSQlNRdXJyemEvTmdGM25sckdsT2lRTGV3dkFXY1YwS3hJWG5XY0ZN?=
 =?utf-8?B?NS9SRjc0blkxeXJWZURkUmJTNVc4djE4djJ5MjhvNmlQaFR6TWFzWUJ4ZzdC?=
 =?utf-8?B?TEVUTUx3M2VxVmdlNVJQRTJjYTF6ZU9xMmF3c25MSDZEanhtRzUybC91QVM3?=
 =?utf-8?B?VTUvRERIU1lsMWFVUXJqZkQ1bmhDaU5xMmJCY2lQKzNpY1UvT1VIT3RKUTVZ?=
 =?utf-8?B?TWhVZVgzdm5oRnhsR2VxK2c5em45TnpNQlNRd1V6YkRaek1FV2ZleHpKZFNU?=
 =?utf-8?B?b1B2elNOelVDS2dyalFWTW9yTStaN2cvYnEzNG1sN3FpbGptZXhZZFFiNU4w?=
 =?utf-8?B?NnQxN2kzRUgwRlZJOHc4cnBQMzRIZVRkRVZlbDMrbFhvRE95a3FVZGEvZmxJ?=
 =?utf-8?B?WlZ6R0o3K1VmbUJ2MGhJa3owWlFCd2tNRVlzSmJ4SVlPK1RUZ2pmeGRwL0J6?=
 =?utf-8?B?TWdzNHoyeWhjSXRvdmpMTG9SV0pQODFTc3dkdU5ydWQzNTBEKy84dmFEclM5?=
 =?utf-8?B?dGxZbUlHQ2tDQ3RLdkhYaEtDUmkyVGpOQXA5Q0FEOThYdTBBYlI2QTdjYVIw?=
 =?utf-8?B?UmhzcFdpSlBLTit2ZnZEUjVWWWxOeXBOYktFUVpVMzdqaHV4SFBvblFoeUEw?=
 =?utf-8?B?bmEvY2IzZzIwdUZDRGQxM2ROMjA5Z2ZmUHhFNi9DNEFHV0hqNHJpanl0MHZp?=
 =?utf-8?B?YjFaTHlkNldvenpVNklKWkFhUkd4MFUvQ2c1anl5a2daK0tuWVBNem1MRW50?=
 =?utf-8?B?NDVzSDQraE0vYXdDYy8zNEovNkhuNnhiaVRQQzZDWWpvU2VKdHRpam1ndThG?=
 =?utf-8?B?MkhpOGJOYTdwbUR0b2JmNVZOVnY4Mk5GK1NFUVVpSVQyblh2YWE2eVl1aVNh?=
 =?utf-8?B?c1NUcWtaOTh1aHQ1MTJ6ZUZlSEZoNzRGblJKTmFzRU80bCtJNVY4WTVzSGhB?=
 =?utf-8?B?MmhPQmQ2bFpYNkpRV1A5QUxWUUduWlJKR2lJK0hzTTA1OW1DYzZ4TzJsQlRY?=
 =?utf-8?B?NVo5NlJJcWYzY3h0aDZkbUt5dko3TE5mR09laXN5MXdiUVZsSlQwL0NhVHJR?=
 =?utf-8?B?dVJnVTdNSlZYSXVZUDk0cXRESFF0WUpWekl2L0NhdzVLd1BHM1NMSXdpcmhv?=
 =?utf-8?B?Nmt2Y0M1UDFLR0RBSjdKMjZtK2l5OG83d3VLWjVEbnMwcFdtZ1VkbGFSbDZ3?=
 =?utf-8?B?ZnlMeXlIc2tRdlB5aWhLQlpqSFpxSHNLZmh6ci9qTUhlWE1PZFlnZVpRZkEr?=
 =?utf-8?B?dnhPWHJ5aitRTnQrdkFQMm80RlpFbC9vUTJqeHpGbmxwTzJKWWVKM3QxbUdz?=
 =?utf-8?B?UnR5bDNZazFpZ1RyWlNZelJLSGxDT3VCYlNEOXlKMytvczVaSEd5TDZwNnlK?=
 =?utf-8?B?Zi9HR1Q0SlZxS2xXckdkdm9GOEZLclpOL01NcWllcUFmNUxGMUJPWks5V2tI?=
 =?utf-8?B?eXdGeFNjeFMvZjUrcUprQUdIckNFUkVRUGhDRDRscElVNUZKTE82L0huWjNP?=
 =?utf-8?B?WUtmUldRcVYvSDJZOFZBdFExR2NoTnQzRGR5R28zOGp5eU1OWFlyQ1hpRklx?=
 =?utf-8?B?em93TlMyWFB1OEYwYzV6anJ0SnM2NFFweEhybUdTeVhnNzQxL3BaSHpYeXBi?=
 =?utf-8?B?d3hLVkRtWHcxMWYyYXpoR1c3Uk4yZlFMRXB0YjN2ZUxVZW01NjBuSTczazJV?=
 =?utf-8?B?bkdtTG0zUVVjYkdBMktKcGFFUmRvOHFQMk42aDNEdEVYckRMTUVMK3FHWVMv?=
 =?utf-8?B?ZjJaeFM0OVFxM2l4cXlIa3J0R3h1UnlMRElua3ZLeGJMa0d3VVZTS09tZ21K?=
 =?utf-8?B?VUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c19b408-551d-4245-5ddd-08dc3e9b8fea
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 11:41:43.7527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Spb4x7/J0AjAKM50O+CKZYRaZTc2XZ9mC4enBYvK/yLfUIgH9V2vsp32WLqxUn37u2Z7mDwRHikwsIMORC2SfHVCHMVv+lfleTIMsk5K2VI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7192
X-OriginatorOrg: intel.com



On 07.03.2024 12:33, Lukasz Majewski wrote:
> Introduce RedBox support (HSR-SAN to be more precise) for HSR networks.
> The 'Mode U' has been implemented without optimizations for traffic
> reduction - i.e. only sending HSR supervisory frames to Port C and not
> forwarding to HSR ring frames addressed to Port C.
> 
> The corresponding patch to modify iptable2 sources has already been sent:
> https://lore.kernel.org/netdev/20240226124110.37892211@hermes.local/T/
> 
> Testing procedure:
> ------------------
> The EVB-KSZ9477 has been used for testing on net-next branch
> (SHA1: 709776ea8562).
> 
> Ports 4/5 were used for SW managed HSR (hsr1) as first hsr0 for ports 1/2
> (with HW offloading for ksz9477) was created. Port 3 has been used as
> interlink port (single USB-ETH dongle).
> 
> Configuration - RedBox (EVB-KSZ9477):
> ifconfig lan1 down;ifconfig lan2 down
> ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 supervision 45 version 1
> ip link add name hsr1 type hsr slave1 lan4 slave2 lan5 interlink lan3 supervision 45 version 1
> ifconfig lan4 up;ifconfig lan5 up
> ifconfig lan3 up
> ifconfig hsr1 192.168.0.11 up
> 
> Configuration - DAN-H (EVB-KSZ9477):
> 
> ifconfig lan1 down;ifconfig lan2 down
> ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 supervision 45 version 1
> ip link add name hsr1 type hsr slave1 lan4 slave2 lan5 supervision 45 version 1
> ifconfig lan4 up;ifconfig lan5 up
> ifconfig hsr1 192.168.0.12 up
> 
> This approach uses only SW based HSR devices (hsr1).
> 
> --------------          -----------------       ------------
> DAN-H  Port5 | <------> | Port5         |       |
>        Port4 | <------> | Port4   Port3 | <---> | PC
>              |          | (RedBox)      |       | (USB-ETH)
> EVB-KSZ9477  |          | EVB-KSZ9477   |       |
> --------------          -----------------       ------------
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

> 
> ---
> Changes for v2:
> 
> - Add deleting of HSR_PT_INTERLINK node to hsr_del_ports()
> - Rewrite handle_std_frame() to awoid code duplication
> - Fix reverse christmas tree in hsr_prune_proxy_nodes() as well as
>   remove stale node indication as interlink doesn't need this detection
>   (only check if node is inactive for more than HSR_PROXY_NODE_FORGET_TIME
>   is required)
> - Rewrite commit message
> ---
>  include/uapi/linux/if_link.h |  1 +
>  net/hsr/hsr_device.c         | 36 ++++++++++++++++++++--
>  net/hsr/hsr_device.h         |  4 +--
>  net/hsr/hsr_forward.c        | 58 ++++++++++++++++++++++++++++++------
>  net/hsr/hsr_framereg.c       | 52 ++++++++++++++++++++++++++++++++
>  net/hsr/hsr_framereg.h       |  6 ++++
>  net/hsr/hsr_main.h           |  7 +++++
>  net/hsr/hsr_netlink.c        | 29 ++++++++++++++++--
>  net/hsr/hsr_slave.c          |  1 +
>  9 files changed, 178 insertions(+), 16 deletions(-)
> 

<...>


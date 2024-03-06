Return-Path: <linux-kernel+bounces-93996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCF387380C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06B77B20DFE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472AD131749;
	Wed,  6 Mar 2024 13:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M/mp9KqA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ABF54905;
	Wed,  6 Mar 2024 13:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709732710; cv=fail; b=oT8WprG92wetukMIgAONHH4WzUbzijsLYT/86MD6DJtFRa2zQpaj1EU2H9w3/Iv2Ig6jvSibG1EE3Gp+zYaDmPhnhHpz7R1GaJFQ7AN4q9QrDICKFrZ+i3zoS9OvvC8HOKj5DiYzYWW6KY0X1EWcDAjVBbgsyxhrKaBo7MnWl1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709732710; c=relaxed/simple;
	bh=X+JnHZEsTVtVzO9b/+c6Ue8IeLdrSxuYsLg7f+zFFSk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U1MSwh3otqxSfumX5/gKpU0O/czSzIFI64c6pJO/l1ituR/uGhXHh16g7IA5+eEQg4oUVAXkqPql+H/DULGqjMqblysLZrXdXqjnOIYo7Yo1CFzg4KlBT0rV6jk19Pcm9zmYI4Ed6CJzMoA8dyRfkl3JxEm1gW3AFr1LiWEc47o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M/mp9KqA; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709732709; x=1741268709;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X+JnHZEsTVtVzO9b/+c6Ue8IeLdrSxuYsLg7f+zFFSk=;
  b=M/mp9KqADzbmyPCsj3pFILNwenREXtxekCP5RFb7GGjXz1YdEyrwKzzK
   vIQzTKYKXVXDGzaubnAvqBUHon4sXMpXzxliIAOV7TwDzkeGmWQYSjlid
   xqKny68XSKWbRcoMYviczHWRbwEzGdoIyl523PNWkJ6ebhL+Use/TBFJU
   osDhvMqpPzZKaxa/2bsTYeCYAUWJnNhYm/e1YKBkK8kjxppoiaf4TF6WX
   Zog1shbwOQWukqA89udsKBtSR50nHA+abWIy7oIv6iDE2Q3lWigScFK3d
   K1uSJ24iTPFvvPda4ONLzlmTuA03mc7Vi4IOBsYnHTX9hUB11qrIvatVY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4525344"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="4525344"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 05:45:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="14319819"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Mar 2024 05:45:08 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 05:45:07 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 05:45:06 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Mar 2024 05:45:06 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Mar 2024 05:45:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3ejKajW7XQeYwHA7OMhEhP5cZMKSMcpyrQLceatl6WMMaY7672Fi3yIVNXehp3qCtWOlqEfYAS/O6d1lS0Q+Im80cXhaDfJB8G5bFbk0GsBAUlrN9j46kGg2gm7rnrQqvOQtHjyUvfEhmRVjMRohWH8KFoe1nuA7ehJy8oclKdYKI2228fZVt41R3OVeH/bl7n2+OGpZ+O5I5a4OE2sPS8aOGnxPaNjVdY7gTpFdJlWTT97Tyy1UUjh78QTew0WMCja3Y+ORuD0DaCZCJgKAFNAaMCB7tvW6Qz5lWZyKhmR4f8WigBXEfGszY2xt7VZq+hdC4HG/j/p/nMUg2DgVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/llhbAuRZzUZqwyqT+FzLfI/IjyZ7U6tjhbjbw2jYo=;
 b=Cx5oHgMKyUmKYKwE0WuStzxy1XmdIneLyVLZZEkaneRXq06nh0S4DpSLRmOGURqVxNx3QU872g/MdSuj6mzGL47WBOtwrGZt+WPcpZTRiXBXxy0vyTh6wPgoFbd+A86vpn32Op4tqnzTi5O806La0xCEGY/ttJHe6LcKtsitkMW+1pwUJhGZYe8bc0gDTfyc2448UbI/Ee3fvCteKyVEZzRnIV5RFRHWImcV/iQF5HTyKBpQjnuzTPewYskPAUB4Ze9++11nk7nmZhHUEkny9BLV3+13dn3TFObgPAHx2zvMkfkweDjnhTmqgbahZIith6BTQCHI6P1xTPgDU9Vcsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by DM4PR11MB5309.namprd11.prod.outlook.com (2603:10b6:5:390::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 13:45:04 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::8079:6172:11ca:5fe9]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::8079:6172:11ca:5fe9%3]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 13:45:04 +0000
Message-ID: <5fe277d9-56a9-4105-a915-bf178e556a22@intel.com>
Date: Wed, 6 Mar 2024 14:44:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V3] net: pds_core: Fix possible double free in error
 handling path
Content-Language: en-US
To: Yongzhi Liu <hyperlyzcs@gmail.com>, <pabeni@redhat.com>,
	<shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jitxie@tencent.com>, <huntazhang@tencent.com>
References: <9c4da99a83bceb4680aac9588151cc8190ff07e0.camel@redhat.com>
 <20240306105714.20597-1-hyperlyzcs@gmail.com>
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240306105714.20597-1-hyperlyzcs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::6) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|DM4PR11MB5309:EE_
X-MS-Office365-Filtering-Correlation-Id: 75c66c65-7db3-4559-2dc6-08dc3de3a0c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TDJPUDVNOPEA9gYe3dn0YmhoBOJKvEOeixD0uOiQP869PMusDi8Pf4W+JlYAHtJxLDjnst5JFoAAKV9eBAGmxIgdk9PtHzo6qJEDc2VM3x2HMAm7bHJaZPerPtUsn2wDbEu72Mg6XTp8V6z1auIuiEMSFdsmcf6KZslmoQ+dyJEVcTR9WtNeYVW3/i+2MI8Nb2dyKS5eD9N4Hd1ty40QeIADWolDwIi3sc08tDjfJ3RIaCgxv23hnwAxrwgOuI39aGXrHWMej9UczShq5nyp+c9OksrfhGSexLvo8M+7xHQdX+vnmqulgBqkbLntjfF9KZ0E1rY0TJSpZA/MulECJqUaG794LRJZY1qMRO/ZB6gRxpT1hBvyoWBLnBO06QvyfYXKMcijb11ICR5IPX/QWTGx1+WGZv8Kk3E4H8aZWRrMNV+onoXSdF8y0nAzF9b4KHl6L/zeTpJxNad+W9QVGJ9ZY/nA5pt4Dol3H5WFrB/GchRVslSsL3GKboNN1eR5keOC4PwtQFV1Fu95+gCeXc+m8JVRCLQzo7KRkP2vKMdozlVbJdSBnliLp7AiqjXICdkLYkWmLWKmiMazinlhIAs0vk0I258/quxb5WNQPfVzmNjpqw+/yZbcucWKK9lOdppI1AbA1342Sca7KhOFqkZ1S4chuJ2tgtlns4X7zNk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFFmS2ZMQ3VmTXdRbGNLVjBJK3pPTmp2eVZIQjN3a0hsanBWbWJPUXJYV0xW?=
 =?utf-8?B?TVlyRnNqS3locjBLM1J4dnJVSEk3cjVhMjJUOUE5OXBSbW1oS1YxMlBzamx0?=
 =?utf-8?B?WFZhUGVhbUNnK1R3aHhDN0hEbXVhUFVmZURQRS8ybW1lQmVkd0I3WDg4cWZa?=
 =?utf-8?B?ZmNGaVU5RVNKTXo3bE9hOGUvSGpOWVpFT3VvWFdmT1o2TklnaVFjd2s2UVhr?=
 =?utf-8?B?aTNHYzNQMzBTNDhVRWhieEM5ZDM1OHJ1TjFaeDljMGxMZTdHdWM5TW0rRjdD?=
 =?utf-8?B?U0hjYzBsajg2bWFCaDQ2cjVzOW9VTTRhYjhQK2haZ2pVemNzYThtak96OC9M?=
 =?utf-8?B?c1RjWlUzbUE2RjFxKzh1bUp6dUtiajJhRnQ0WlBsZk9IRXdVTVdONUFoZ2dX?=
 =?utf-8?B?SHVQRjdRTjU1VHZERllGNnpLWHdKK0ppNEFNb3BwdS9taTRqOHptaVp4SWl0?=
 =?utf-8?B?eUdER0Q4aVpob3JHQmRNMzRxVkw1UTlScEFtNGNRbndBTDJHN2s5MThubEVF?=
 =?utf-8?B?clR1VnBiSUxPS3A2d0RMbE5TR3F0Zmd6TnpMNFVFaU1nV2FWaFAySDhNVFQ1?=
 =?utf-8?B?T0NLeFF3elRIWGVveHpvYlF5djAvWi9aSUc5c2dHWFNSeGNacDJ6MXFKOWdh?=
 =?utf-8?B?TnR3M3QzNjd6YktIQVFNRHhERlYrWFFLSm5mQ2dwQ1FyR3YvTkc5dVcwdlBs?=
 =?utf-8?B?Z1k4NTRnMFV3cXFtMUxPSDMxM2lJR25Va0FLeVk1cGhyK1NzRDk0VVFhWDNE?=
 =?utf-8?B?Q2hZcmJYdUVkL1pxUDNaTzBDVG5YNVFjbno1WitxRjBOUU14U2EzOTFCdFpM?=
 =?utf-8?B?NTUyaDBFRk5PNjFzWndEQThKaVZLOXdsRWlRMC9oeFgvTERENHpLUWFzVW10?=
 =?utf-8?B?UWk5UFZrdXlnUmNLWW9aMEp1cGZFcXd1TUE2ZFlsSnprMC9ZcXEwY21kcDVm?=
 =?utf-8?B?WUtIc2VFVkRsYzM0QU02WFYxQ2g2dHR3NkZsSkhoTlI2T3BVREtIZUdrR0xW?=
 =?utf-8?B?aW0yODVSczh2dzNlNFlQWmdMRWxvZTM5M2tEK2NrK2JOWGlSMUo1anI5Y3F5?=
 =?utf-8?B?ckhZYlJDRlV3Qk5CNmZLVUMwNEZNY0w5UEVJbldVb04reUhUOVY4TVhIM2w3?=
 =?utf-8?B?bmwwbytscU13RHV0SXp3OHY2QzR1MTNkdVFBT1NSb1d2RTBMWTVqUlFZNWtt?=
 =?utf-8?B?ZXJPY3ZmeDlvVngxZzlwUktxbHNNcGRhRkxmMGM5aVYyakYyNWlpNFpCaGV1?=
 =?utf-8?B?aS9vSTdINXhsaU44a0pEZ3FFOUlaeHJwOTZEOVdQWXYzQWMyNmpLanhtTXY0?=
 =?utf-8?B?Z1k1U2VFRU9tK2dBaDk4RHN6RHh3aTd1REZkRndLY0JzZCtSR0FEN0VIa1lW?=
 =?utf-8?B?VWQrVkx5MkE2am1VODdjMW9BNmN1cll5WTNkakhxM2F1N29XZmFSTGxKVWps?=
 =?utf-8?B?VXMwVlhPYVVqQm1PU1JOOWd1Ry91em9PR0k3NitqNmdsek4vZmpYdTNneklp?=
 =?utf-8?B?K2hDdkE1dklsM1pmZGliZUdQK2VxYlpNTUVzdzhCMkxzZ0hEbk55ZEdXMVlh?=
 =?utf-8?B?eHczUmViWk5jN2JEOGZlbTNOMXFzczg2RUlRQktudllOdSthS2hNZjdtazhU?=
 =?utf-8?B?dUtqTEdlM0orYVRzYzVLODIxZ3hDMnZWZmNQbU05cWdVcXJHUTJNeFpyVHlx?=
 =?utf-8?B?clR5Qzl2RWVnSlhXSlFxUUZwSFRzWDh1bS9HaG55ZHl3Yk0xaFBkTkVIaWN1?=
 =?utf-8?B?dlZ4bzFwd1JRWEJPZjZndGI3RzVOK1dXWW5lMngzTlVvU0dwL3NDZmdMRGtx?=
 =?utf-8?B?bkM5QVpQTHhWc0xkMEJWTkt4R2RDU2hka1czVTJXSHJsWGZ5V3BnY2hJYnBy?=
 =?utf-8?B?SEQ4aVNFVm9vdHYyWk05eGdqNkEwTXo1dllVbmR5N1VtVkRubVpxVHRWV3NO?=
 =?utf-8?B?Vm1IT25aOXNINlV3SUF4Z0t6STJxS000RnB0RU9wbTdQd0ltc0VWbjl6OWZj?=
 =?utf-8?B?ZDB2WFdPZjZtU0lUM1c2Q1lUZWdsK0UvSU9pYTZxazZDNm1Ic0FEUlRMU09u?=
 =?utf-8?B?a29yUXBmWkZnenNaSE1TSjJYRE8vUUNpdG9id0E1REFpR2RRa252NnRiL2gv?=
 =?utf-8?B?aXBoVStVNURNaEdheGlvaWNkU3BMNnZiL3Z3cDU4cEMyUFBlY1JDOFo4MEsy?=
 =?utf-8?B?WlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c66c65-7db3-4559-2dc6-08dc3de3a0c8
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 13:45:04.6387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uPNGp9snSBZLi7OBFdeE0oFsL+MOte+Q8yWJcFNWPx6ucZ0oMPOI+nD0c/AVEgGrRdloGMZOO6FmNqsRyGz91kK88HDWleIzos2/Xbllf5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5309
X-OriginatorOrg: intel.com



On 06.03.2024 11:57, Yongzhi Liu wrote:
> When auxiliary_device_add() returns error and then calls
> auxiliary_device_uninit(), Callback function pdsc_auxbus_dev_release
> calls kfree(padev) to free memory. We shouldn't call kfree(padev)
> again in the error handling path.
> 
> Fix this by cleaning up the redundant kfree() and putting
> the error handling back to where the errors happened.
> 
> Fixes: 4569cce43bc6 ("pds_core: add auxiliary_bus devices")
> Signed-off-by: Yongzhi Liu <hyperlyzcs@gmail.com>
> ---

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/ethernet/amd/pds_core/auxbus.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c b/drivers/net/ethernet/amd/pds_core/auxbus.c
> index 11c23a7f3172..fd1a5149c003 100644
> --- a/drivers/net/ethernet/amd/pds_core/auxbus.c
> +++ b/drivers/net/ethernet/amd/pds_core/auxbus.c
> @@ -160,23 +160,19 @@ static struct pds_auxiliary_dev *pdsc_auxbus_dev_register(struct pdsc *cf,
>  	if (err < 0) {
>  		dev_warn(cf->dev, "auxiliary_device_init of %s failed: %pe\n",
>  			 name, ERR_PTR(err));
> -		goto err_out;
> +		kfree(padev);
> +		return ERR_PTR(err);
>  	}
>  
>  	err = auxiliary_device_add(aux_dev);
>  	if (err) {
>  		dev_warn(cf->dev, "auxiliary_device_add of %s failed: %pe\n",
>  			 name, ERR_PTR(err));
> -		goto err_out_uninit;
> +		auxiliary_device_uninit(aux_dev);
> +		return ERR_PTR(err);
>  	}
>  
>  	return padev;
> -
> -err_out_uninit:
> -	auxiliary_device_uninit(aux_dev);
> -err_out:
> -	kfree(padev);
> -	return ERR_PTR(err);
>  }
>  
>  int pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf)


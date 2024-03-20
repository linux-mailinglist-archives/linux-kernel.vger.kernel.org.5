Return-Path: <linux-kernel+bounces-108737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D886880F5A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A2F31F2312A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FDD3D541;
	Wed, 20 Mar 2024 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rf+Geptr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B113BBE3;
	Wed, 20 Mar 2024 10:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710929426; cv=fail; b=KMA9TM2g4LAYsMdZbZhVEg2DHM49CH2/sHUJXHqwzrtF6Zt51pLJe3a/+90jV9yMNylk5Yw1r4vnaYXMeY8Ke4d0mbndxkFzs5bMHqOp5gurretSwvMUvs2qm7POtnAq72UvkSDD7A3spty+VSUKZ1usLbB7O0Pp57wn83oDBiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710929426; c=relaxed/simple;
	bh=EVp7g9wtJGUVcceWGBmBi+JBR4nt01UINtucOAeFTic=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uWcXapkwhkoTRSCAUCttNlRjO8XLgJBd4koA2+ft7il3DfcFZsqMA3V1BdafmTcmXdlJWVcSd2iDW/pguDwVV1gdStAtBFX1HEOMulDXQYU9qCW7GYlFlYp3AqC8HAHBH8HSpnAwImHUpzKbmnRbDLrRHQAHGgsVc4QqBpTq+3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rf+Geptr; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710929425; x=1742465425;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EVp7g9wtJGUVcceWGBmBi+JBR4nt01UINtucOAeFTic=;
  b=Rf+GeptrZ0uH6eS0pAaqJ1xOUa23rbCsX5U4eXqUryCZnFCFaNXD+pMU
   hZdJwMsiirr07AaBF/+M0Ts81V4/Wg5MHGYdsfi5NkfypYiSy1FrgCwaF
   50/q0BBmrMp2f5qneaJ6euLPkiB0nxV04h1/LIMtVFOWzmpcXo3f3qsEV
   IhmA8utjZ3V7//MVZ3tva6qmpACjjvn/mkX6zmcAiNRZveXjw2wViEQka
   hZFk7zoKPxdisdvyZ2bffGZ3JonJY8h3mjtrTU8NvakQOBMOUxgS8WcjQ
   eNfX82PnmFWHp9xEIMTvGFYhR6xuugDuZ0JiJ6o3BkpOnedLHVcCfsGEL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="23344810"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="23344810"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 03:10:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="14181712"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Mar 2024 03:10:18 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 03:10:17 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 03:10:17 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Mar 2024 03:10:17 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Mar 2024 03:10:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3Sg+2Aa/ziUwIWOvFUWZItibpJ/sq5DvGcGfaCZeX+lhGk0c27PeHz/CBiyn9oeoQiHcLRlRew1Bs1ng4SggV8ZP8rlHR2eW6Io+PamwKLYyR7ZFiHeAT22Sp5dpRuxpmNSToPjREcbMkA4va30F4V0SNP+udRq8JjJptjTyBvm8cP56asozBDxvnCBZ1a8VkwYbCieIOQNFQtBygIZyXWiEJUKVDFHIUG4GluDlmwwHd5zFggo5W4PUfHTTH5aw2bxKocmE+oBwwIXxcQLAY7CyZgaAk3ErYpPAgMcssM7Y6E3gPAAbEy0R7TdBm6pXBra7Uf8VNMeCRSund95YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2ybXOpUAXQD41T49rzcYC5m7iogLhZ4804Bi3FVamI=;
 b=UZfvI+f/KJG2v6yKpUn1qVl/KtVb/t5E0IKTGQeGzgKthr5JgSHlqVCSzkmbHzCzTUZbpEz6CZzIP75EpCF+6TNbuuXvo6dE3ssfbljW5ZYTUXsfq/S3tNc66i2RM6HFafeNDI2ZWH2AL+P3SaSvDac1RHHL7YdjvQWP18qldIm4nYRe5Mq1gvkZVxpI0KedXJ4Mc3E+eXWrVD0fbdbm8zBcz23dBSzbjaSBYIyRfxyDi07mPNACVj4rNR4ODZ4T5p6W7QmHTFG0NjBKr7n8EInVf8BV7Hj7Iywot34INzURDqSPpAj8ZYVhzZ7MybPvgUfw+K0bt2eG2zp5onaALg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH0PR11MB4982.namprd11.prod.outlook.com (2603:10b6:510:37::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Wed, 20 Mar
 2024 10:10:15 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7409.010; Wed, 20 Mar 2024
 10:10:15 +0000
Message-ID: <058f6e5d-369e-48c7-a5ea-976eccccaafe@intel.com>
Date: Wed, 20 Mar 2024 11:10:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC kspp-next 3/3] idpf: sprinkle __counted_by{,_le}() in
 the virtchnl2 header
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, Simon Horman <horms@kernel.org>
CC: <linux-hardening@vger.kernel.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>, Marco Elver <elver@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240318130354.2713265-1-aleksander.lobakin@intel.com>
 <20240318130354.2713265-4-aleksander.lobakin@intel.com>
 <20240319185718.GO185808@kernel.org> <202403191442.219F77E672@keescook>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <202403191442.219F77E672@keescook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0021.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::14) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH0PR11MB4982:EE_
X-MS-Office365-Filtering-Correlation-Id: 35c30941-74e5-4006-c468-08dc48c5f005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YWYGI3c1zu2K/s033kfHrb51WXO9jzHb5hVP3CdcrUmd71b6G0QSqSu6xg14eGLPX8OJpkRPLEQGzDaFgKqps1FCDsSv1CGVuu4ABzJyFlfA+4Shp9UI4IiaIAFLpkK+6xjcj8rSrlxO82PZTSbzUa9AihgpZPIlRLAL8q78H4IcHHBjWqJndVu91Ugi5G6lDbJdrijU00b6AdkhT4RTXQiP4tmqEDs5etdeyNqdFqlJwo/U5yuuViT+HOQZgMl7RtDFDFvBsTqSZ1e9s38pdu1cMxqtSaYT1DnBOvQx/r9tenLW0bREsT2UJbJ0e27B/qzUUpI+xvb6ghC+vSSz1f9ZZ3a0Uk/YtwpSVCVgbsTtuIjVzuf2ci5cKnrW67VWeVbdulhioknf9zKmyYeWwvdNAIsTl2dPhy1bMyC+R3Vk/Ho95DlbaH5kjBJoemQWBHNJ1GVI3eOWrPD84htNrBnpUsX0/Fz4IHl+iHHrGfRkHT2dmukcUjWrnUvKF1UHi5MocRSkuwrYYzCRnZPOF8iENZOAWJBOx9YtHRZFn9N/OUS4nos5jqH8t/uVuBLI3m+H0iicDLCMHtmXIBmwABMX4A/UQV3vL8sxNtLVhGj4kM1lSja9E0wtv9Ow4ayF8e2gsmkXqpuza7LqD6+6nZqsgGVoTYZA5P8U+gfwj4c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3JBSmJTZHFQVkoxN0ZMbGdpU3h5NnFtVWtjNGxNOEp1aGNvdHQrWWJkeG9u?=
 =?utf-8?B?Y2szaVVPL1N4ZHJWK0pkY083ZXNRVzdOQjdVWUZkM0Q3bjhuN2xVamxYcEIv?=
 =?utf-8?B?UzV6bnhxK0ZNTG54V3FQbWplWm9JRzE0TyttNWhMb0ZRNkJzV21VQlNFeVcr?=
 =?utf-8?B?R3pud0dTN2kycWJCV1piNmQvUklaOWh2Tm0zNXFZVEc2U2p6SEtJWU5QdGNH?=
 =?utf-8?B?S3dSenlpc2s3WHR6anY3aEhmdWpwQ2RVenlaWUkyOFRpNkxMWlcrcXVxUk5L?=
 =?utf-8?B?VWJ0Skc1Q1ZhMUN6TjhkZmhWeU9zZmcxOWFuWmZGdU54SndMYmNIRHBGYmg0?=
 =?utf-8?B?YWJlTWNlQlBqdXYxRFB3SUUyTDlMQTBqYlB2S0ZrcU5HaFNndFpMRDVwYm9v?=
 =?utf-8?B?U1hid2p0U1lPRk9FZUVxZEp4RGszakk0dHdLbDFzMkZDcU5jTUMzT3BhMU0v?=
 =?utf-8?B?cXhra0VmVU1sejE2dDY5OVloRmRMM2EwWk52c2F1S3hRdnpFd2RpSE5Oak93?=
 =?utf-8?B?ZndVKzJueDE4L3VBbGFLZ3EzL3MxdE14UzJ6dzVGQ3o3NS9DcWFDRERhRW14?=
 =?utf-8?B?ZHY4WmRVamltYldsMFdLTXRzbXBubmtwZEI1SG03WkVBb3BlL2VTWXZMcGN1?=
 =?utf-8?B?QlBOUk4rREx2WUVCUk91OHMvRlBMUFVNdGNxT1VRek9WMWZVUEFBVE5JR2pN?=
 =?utf-8?B?VHNMcm1VdnlzVEo0aVlzVUZNUjI4TzJnWlN5b1JaaVlhUlRLQ2Vhc05qRVdv?=
 =?utf-8?B?YldEYk4vbUJwa2VQczdEOTRlU016VVB6Wmd1c1d5K0w2bmd2cE9WM3pWRWZM?=
 =?utf-8?B?Q1hWZnE2NThUT0dGU291VUcxdm1UUWN0cEdaaG50K0U3L2tIQS9CY2huWTFD?=
 =?utf-8?B?dWs0bXBmdnZ4SE45UVFwZU1zSUY0MGR3dk1iQnk3Z1p3My9ycUdFZzNSTEt5?=
 =?utf-8?B?MHN3OXlMRE0weWY5Y3I5cEsxY1k2SmF3bUQ1Y1ZxNnRob1RvZ0lEWGRUaTdw?=
 =?utf-8?B?MDFSVlNCM3JPOW42dGRrc3Fac2NDZytmODdiRU1pcHkxYmdlMHB5TkF2dzVu?=
 =?utf-8?B?MTh5MEpRc2ZtcTZJai8xWnpNZEw1Y25XMzRsWGc1R3lxalNOcU00ZUoyZG9v?=
 =?utf-8?B?U0g2L3UwbE44MEhDWGlkaUFOR1h3WGU1aGl5clVHZ3Y1bC9kRjBPb0grUDUx?=
 =?utf-8?B?SlRaWGZvWHk2YlVLU3pacVYzRkNtam9zdXZ4VVVlUUw2UDhCY3pIUW1ha1Nj?=
 =?utf-8?B?WVFvSnlNZFRnZWM5ei9LMU10ZVJQWDJ2dXVDTDVmSlNCNDVRcFBSM3c0ZVBV?=
 =?utf-8?B?bHJmL0dyalloNmxEVlk5a2ZXMnhOSkpURlRqNjQxejVYVnU5eUc5cmpsdzRh?=
 =?utf-8?B?UHVhcUh3Z0NqZXFNbnR1a0EwUU05ZXZINWpjZ2I1NlExOWltMFJlRVBZeXZN?=
 =?utf-8?B?RTdJWlhpeU0zb1dxTWpJcmpha0EzQmNJNlQwcEtid2FjMW1kQWc2dW15K2JN?=
 =?utf-8?B?QnB6ei8rTE9GZ1pxVVhRRlFoSTQwU0M2cklzQ3hmSVBpY3dMeU9nSnRFWjJK?=
 =?utf-8?B?SjVPVnk3ZEI0T3pWTE5RSSszWjJMN3RmUmxwRzZ6TngxMlkwWm52VlFFaTRB?=
 =?utf-8?B?MFVoQTJLV2xHNTIrTzY2RU5MMVRreTNaMUxZdCswbjNJcGh4RGN5Y1RodlRP?=
 =?utf-8?B?UlgxV0tVc1dUUUp3ajIvNWxkTmMrMGR5SlBIWmUzV05LRVJYRWFJajNaaTd2?=
 =?utf-8?B?eXVpelhSSE1sMFpya3MrTDc4d3BJZHU5K25EbWpyc1NNV2JjNUlGN2pjWU8w?=
 =?utf-8?B?NmVlRTErdE9GZTRLRWFPekgvSkF4b2FBVU5ydXpuSTdlV0prdE9XczFpM3Bu?=
 =?utf-8?B?R00zWDdyRjlRMmhFQ2dUcW5xSDczbEMzb2Rwank0VHp6MjVvcVJiUEhhUldy?=
 =?utf-8?B?NlV4ZzRKditKSkNKTVVZOGhOUnRxd1lTVDBNQVhGbEt4QnZhQktzNktMdkxY?=
 =?utf-8?B?dGowNmJ5Z1NhNFpUQjZvV1IxczQySFZHdnlPRW1ES3I1NGdLWXB6RHB4Yjdj?=
 =?utf-8?B?dkVReGdDVFlRaWpUVTRhN2RCUmtMUjdYTFppR05teFhCdlZJRDF2RnBrS0NU?=
 =?utf-8?B?dlZZSmU3VitkRTVOQXRub3YzLzJId3JjdFh3YXNsWFB4T2pOQzMzVFlUVEtM?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c30941-74e5-4006-c468-08dc48c5f005
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 10:10:15.3291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MFhaYBSf3b7JqziS7DSVHVLjpwjj5IZOFSRuYg67oCTfD1ynRtvRqd83K3WNTJSxfcRaOCAzWfSNA0rTK/NI/wNQhwZHhhqooJwA+nf1Fi8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4982
X-OriginatorOrg: intel.com

From: Kees Cook <keescook@chromium.org>
Date: Tue, 19 Mar 2024 14:42:56 -0700

> On Tue, Mar 19, 2024 at 06:57:18PM +0000, Simon Horman wrote:
>> On Mon, Mar 18, 2024 at 02:03:54PM +0100, Alexander Lobakin wrote:
>>> Both virtchnl2.h and its consumer idpf_virtchnl.c are very error-prone.
>>> There are 10 structures with flexible arrays at the end, but 9 of them
>>> has flex member counter in Little Endian.
>>> Make the code a bit more robust by applying __counted_by_le() to those
>>> 9. LE platforms is the main target for this driver, so they would
>>> receive additional protection.
>>> While we're here, add __counted_by() to virtchnl2_ptype::proto_id, as
>>> its counter is `u8` regardless of the Endianness.
>>> Compile test on x86_64 (LE) didn't reveal any new issues after applying
>>> the attributes.
>>>
>>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>>
>> Hi Alexander,
>>
>> with this patch applied ./scripts/kernel-doc -none reports the following.
>> I think that this means that the kernel-doc needs to be taught
>> about __counted_by_le (and __counted_by_be).
> 
> Oh, yes, I should have remembered that need. Sorry! It should be
> addressed by adding them where __counted_by is already listed in
> Documentation/conf.py.

Oh, thanks to both of you! I'll do that before sending v1.

> 
> -Kees
> 
>>
>> .../virtchnl2.h:559: warning: Excess struct member 'chunks' description in 'virtchnl2_queue_reg_chunks'
>> .../virtchnl2.h:707: warning: Excess struct member 'qinfo' description in 'virtchnl2_config_tx_queues'
>> .../virtchnl2.h:786: warning: Excess struct member 'qinfo' description in 'virtchnl2_config_rx_queues'
>> .../virtchnl2.h:872: warning: Excess struct member 'vchunks' description in 'virtchnl2_vector_chunks'
>> .../virtchnl2.h:916: warning: Excess struct member 'lut' description in 'virtchnl2_rss_lut'
>> .../virtchnl2.h:1108: warning: Excess struct member 'key_flex' description in 'virtchnl2_rss_key'
>> .../virtchnl2.h:1199: warning: Excess struct member 'qv_maps' description in 'virtchnl2_queue_vector_maps'
>> .../virtchnl2.h:1251: warning: Excess struct member 'mac_addr_list' description in 'virtchnl2_mac_addr_list'
>>
>> ...
> 

Thanks,
Olek


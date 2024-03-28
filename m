Return-Path: <linux-kernel+bounces-123122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFC7890270
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B43D21C23CC1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBE612F380;
	Thu, 28 Mar 2024 14:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VVKXCD/g"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A2B12F368;
	Thu, 28 Mar 2024 14:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711637878; cv=fail; b=rLiBobZVNppCQiWQ0Hf56T5dA1QI3oRriclQilhPGiIg1065BstSCy/8oNP0h3tJQIbeXGmJD0x1/RX+AyUbt0b1JSZXPxNcZMRjMOeS3wGkULZLXF5XH216qnibLEy7o+11CuNrGEUIwic0gWqU3b2lE5Xdf0dvbRbgbv7l2Fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711637878; c=relaxed/simple;
	bh=+pkyuUiiRFXGPp6FbUDlUiywND6YSqwNnfWEn4UDP4A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=geHwq2SCv76g+s16fcBZfMpEUtdgfp4aC0lM6vKrS5BPAI09vMBTGTCah/wecOdSQeoNLjy2spcLzHWqoZjmuv4U0T1ZB4RS43qiDsHAlvh0JAWVxyy1b3pOyiZWuGyv8v6+Zsh3nDtDCiox3DO5v4UJeaUfzqr6GEdEVynfRIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VVKXCD/g; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711637877; x=1743173877;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+pkyuUiiRFXGPp6FbUDlUiywND6YSqwNnfWEn4UDP4A=;
  b=VVKXCD/g/Z0RgN2BLNJq0kmzgXOmhZW0CFmAtRROcI+zxucau9ekt0OP
   tPWprp4fF4yVXjgL9vEkXlTQsfTzg6gc9L1oYi2m0VY6pc/eEN+YkExye
   hCJJhe4lSXR2fbcspuD6OYnwcvPmZrFrWfW7k5CxpT1R510FVdJflX7fW
   WsFzNji5F7BRfI8OPGktGpCxdS9fF4W5bXtzP0te+Nm4KuiiVVnW7T8h8
   ftYAej26MSRykE25jZD0j2klP6K5rnr4RT0bKcRlMNtolWMN312yIAOW1
   gSp2AekZjs8XB6chJYcKaWIGUHW89ubgbwhLhUf5PLr5HoGYvH4ugi3gw
   A==;
X-CSE-ConnectionGUID: LbWk0N84QHqFk7L4PoBPng==
X-CSE-MsgGUID: rZARjwWQS12yzdWt7ay1Gw==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6648335"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="6648335"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 07:57:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="17310519"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Mar 2024 07:57:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 07:57:55 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Mar 2024 07:57:55 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 07:57:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hupCt941E05SctM54XWtOlqVEP+sdO3Iyr4namKbRFtM/9Itja8xeZYHAYo36RFjfVa0KK6J1zv6AN2b3AOJXOAtGwWPYVOn9F/zIGSM3wBvlfxp/shhobG1srA9X0iMr6R4/ZLnB1/nGRZ1XdFr0QNrZ+TxIFfI4ov76sdXPFiLqRLPpb9lDb608lesu7amCp87lP1WBJlfRxMjEl0uD6JzWgyJhXvgKzE/9iq7JAaokyyz1mmLPaAU4Zcg/Uh8lILXOH8EX/xZG9/3rBFmpdrSM8BLufhcQXLycr4BeoDoU20bdrGdnR7NozwRH6ZcSjW7j49bH5Kx8XPFFgjwwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHXPo4gNyuuMk2lGfjaXNvHC43wSBHok+B3Yg7p4Zy0=;
 b=msVvGw3O4tMCCESTC4z4aS77Q7LIIWYTAT9dxJwHhsUTx7w0EpU4CtsEfsUcOH7cEoNxd5BLYZBXBqWbpUp94oV3YdSo5DYmWUcePFyEnnzbN7okQdlEt7zojmeV2xQzJy99yosOFz7syK/I4rhCcSTtQU18hOxyY2+6AxvUABmS2ETMGN/cClTDCkcq7clEzTa4QXDs5YIDrvkurrnIGg0fkoLnhmRMyGpkqjPjhTRxr2QiMPA3rpOaVNR2jHtSzouneZ53txyYmdXGKWml82l/CjGp3EBFHtUxMdlxE2LMDwNNu4RLNF8QV0ljQ6NR//WoGSDEsYKcahmkc7KZHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ0PR11MB4894.namprd11.prod.outlook.com (2603:10b6:a03:2d4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 14:57:52 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 14:57:52 +0000
Message-ID: <25a2266c-8ae4-41f5-9b80-beaf174043d1@intel.com>
Date: Thu, 28 Mar 2024 15:57:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: create a dummy net_device allocator
To: Jakub Kicinski <kuba@kernel.org>, Breno Leitao <leitao@debian.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	<quic_jjohnson@quicinc.com>, <kvalo@kernel.org>, <leon@kernel.org>,
	<dennis.dalessandro@cornelisnetworks.com>, Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Coco Li <lixiaoyan@google.com>, "open
 list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
References: <20240327200809.512867-1-leitao@debian.org>
 <20240327161731.6b100cb8@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240327161731.6b100cb8@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0007.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::18) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ0PR11MB4894:EE_
X-MS-Office365-Filtering-Correlation-Id: b2e3aeaa-23aa-41c4-a291-08dc4f377186
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fo0OzjEVNRpWSCEQp+QT02W33xT35ySG84Kewnh/lYzEzpZreF7M8NN8l3SfITFCTbiFQuEzQ743l8osej844VX7nDOB/8MjZACQY168whN8xbD++tcog7DGdPcNnPDY0ZSBrn+Gb1VJ9gtShZ2QSedmdCtAGQAqinWGHMVRRK8ukbaln9gDHIvAxMzy5hWAaDTvIdzDQnglYCZTA7tHyHg8NnCuvEGFyiE/4bOJeV6SfZne6zg9Ywrrv/mf89wlkx6rtolr/JMIYC/0nrsKzmhuMFsf11h6PYCXpwva3BD8xeKjRVW08Sh5Ou+iu0vXO/tqp71h6UPDepyZ60F4Vl3Cg0aLiZsegclu5uKAlvHWgIYEJeyQ4k6Szl9VNJryfk1R2n2vloSzpml9S+ihl42OOYAPoyAgmc/jOeOKz7zOINXJGx8+ajmA2VEXphqzNwEL6hIXftlzTRKoI+2j7NLUvCXOD74nf/A/iQTdHJnIKN3qJQdrOa3e036Fegg7kp96VgXHk0gPBaZIzsz9KtJPwjbBkZFnm/x6pqWjBOYyhwyVe8VUJhmliN/mpOtwwnFpfmX95e8wPSTjrdnUx58f80z/+GQHFk6ZgVp3Dg49UzjsePw4ku7H32u9WZxG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFIrOGFBclAxc0FKM1MxYnNCT3hleGUxVnVHdHk0QkhwM0ZBRkVBeEsyekNy?=
 =?utf-8?B?aGJpRm5FNVBkeGVsN0Jqd1kyRXI0Q2s5dFJwczBsUmFLTFpTUEQzSFoyQi9C?=
 =?utf-8?B?YTV3cTFDMmhsSmtIVEdxczlFU0loWlhuRjFyLzFyaml5ZjdhNlpvdG9heHpZ?=
 =?utf-8?B?MlB6ZXlOelRzMm5RWHpTYTNhdm10Szl4SnNldDlldjQvRUJrMlV0Vmo3ek03?=
 =?utf-8?B?ZDQxM2NPUml1YkVNQTdCUDI0c1JqWWhNTGVCVkxEQkdPdDgxTVc1RFZMcnBT?=
 =?utf-8?B?NElBOE9sak5mM1l4TEhOelp1WnoxSXc2SVU5NlJPZWtpdXdPSDd0ZWZnV2dJ?=
 =?utf-8?B?eDB0YnV0VGUyWVpNdDQvR3JtRkRzdUVoRXE0bkRCLzgrK2cvWGMzZG8zNHdN?=
 =?utf-8?B?RVFLdkhUN2NmN1lFaUkyQmo5Ylo0aG1DWVdzRksreExnUDNBUUNueW92eG5z?=
 =?utf-8?B?RTkzR0JWRlpVQmxNNjY4UDlab3ppRjNVT2tQejVMdmlGUjVwY3MwaXM2K20z?=
 =?utf-8?B?dFovRjRFL0NwTXZsWVVlckM1clpZeGR2a0lvendaalRsR3dBdHIrbTZRVWZn?=
 =?utf-8?B?MHdrcFpqTEMvRkwvdWpsMU9EMGlLM1JtZmlkWjBhL29ob3dPNVpUc3VkeUZV?=
 =?utf-8?B?dHBFMHR5ZmIzVGdZM1hHeE9xQTUya1B2WVByWjBHb1BFRWpqdmNkWWt0TDdS?=
 =?utf-8?B?TlhKUDNDU25EQzBKcC9RT3VieUc2RUhiT1dOcnNBcnZJYWVKakpRWVhaQWM4?=
 =?utf-8?B?aTNZZkp3VDkyOGRVaFFtNnRiSXZaM21WdjBDZVd1VVluWTJNdDhLYThMbjJ3?=
 =?utf-8?B?RVI2YzdlN0IxWHkxSllueXNXS1R2YlNRczBWbVRhWDNSbVo0R2NqZEsvZllz?=
 =?utf-8?B?MGVrbkh4eEswc0dROWVleVV1NUdnV3I1OUFWaXorTWJkYnNBN0lvSWtEWFJn?=
 =?utf-8?B?ZDJwOXhoNDV4bVFSZU5NMUltZzBCbWJncFBtUkplSndvT1FhaTA0bWZIYzMx?=
 =?utf-8?B?Zi9PenFXZkpyQzg2R2Z5S3E3czZmOUZzL3I5UkMzSVlSR3pXRWdudXU3TlNn?=
 =?utf-8?B?ZmFTMUFqRURaVGFZMFFGeWVqT1cvdDFnSUpUclBmWGV2aUcyTmViSjVkY1Ba?=
 =?utf-8?B?czcrK3UwWTNaMDBZOFgzbFJ6dUJHRFVzM244NDdIYkdpMmlWd0I0SWgrZGUz?=
 =?utf-8?B?STBlUFArUjRta21wY1ZHTUdZcTB1TXRiYW5uMEhjSnZmVGhBOTBrY1FhRTJR?=
 =?utf-8?B?bnhiR0FvanUydHZlQXFWU1BKTU1oU1lGaWJpamxQdnUzNVpnVytlN09hcFBK?=
 =?utf-8?B?c3RiWFhZUjVFVk1XTFY3YUordml5M212OFdxemVON0pKZ0cxNURvV1dTNzBP?=
 =?utf-8?B?eGFkWThpSlVRT0JGRlVWZXBPc09RR1JlbXc0cmdhOFpxbUJ4KzVZQmxhZnQ1?=
 =?utf-8?B?ajFEendpR21hdEI3UXlWUjcrcTBjNXNUUGk1MTdLdUNKMnZoZnNuZjdxMDB2?=
 =?utf-8?B?V2ROb3BBYm9hazJURTRobU1sd2p2a1dFK0ZLRmh2VFRyTG41VU44ckg1VGNS?=
 =?utf-8?B?WFZUOXVUUHNDanZQdUMxUGNYOE5xLzlhOUFnS3g4aldudDF3YktTRW9MdGFt?=
 =?utf-8?B?YWhMMmhwYWdwUkRrT0NRWnR0THA0c1VBaWJRVE56WXBCWEtOTjRjN3phaUV1?=
 =?utf-8?B?Skk0Zm90V3FXR3c5cW1FejZqUllDWkN6RjA0cUZZd2Z2WDJ0Z3lCVURkQnMy?=
 =?utf-8?B?MWFZM3M5Y29wUG5oT2srRU1UVmNxRlppNUNzOVlNaWYxbGpyUVJreGRjZy8y?=
 =?utf-8?B?REVEY1pZeVVtM2lDejFVMUI5Vm5YcVdUOXd2ZDRxbXk2MUtvaUE4U2NSQ09x?=
 =?utf-8?B?YlFCU2JqWVo0TjV2R1lac1ZnMXQ0NitYTUFTc1kyc3pBcGdnZzR0elhQREpH?=
 =?utf-8?B?Z0VSNU1qTzc3RkV2RkNXdlpXNmpzcFYySlJ5dFZDNFdrV25UU1plK1EyRjAr?=
 =?utf-8?B?QndTRGtKWUw4ek5yb1ZXNGRyUUZaeHdRcG5FUTluSUQ3L2t6MDBPVkgrRXBh?=
 =?utf-8?B?ZkVXcFkyY2VCZFQzcDc1T2VoSXNDZ2FGb2FicG5oTk8yYVVNVU5HWmpDZGcr?=
 =?utf-8?B?bU1mdzRKYVl0MnRObFRZbTdaakVrMU5zWmhELzBuS1ArK3BDVWFiYzl4L25J?=
 =?utf-8?B?M2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e3aeaa-23aa-41c4-a291-08dc4f377186
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 14:57:52.7598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9PxfWDhcaupilirAgSrQng2wV6KhqAPjqebvMZGv094XswZ2m5Fmmu9iO63fEA5xk0rDEvD+2qgMhFK6jbAAKkihrjilfsgAlbsobxWrvEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4894
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 27 Mar 2024 16:17:31 -0700

> On Wed, 27 Mar 2024 13:08:04 -0700 Breno Leitao wrote:
>> It is impossible to use init_dummy_netdev together with alloc_netdev()
>> as the 'setup' argument.
>>
>> This is because alloc_netdev() initializes some fields in the net_device
>> structure, and later init_dummy_netdev() memzero them all. This causes
>> some problems as reported here:
>>
>> 	https://lore.kernel.org/all/20240322082336.49f110cc@kernel.org/
>>
>> Split the init_dummy_netdev() function in two. Create a new function called
>> init_dummy_netdev_core() that does not memzero the net_device structure.
>> Then have init_dummy_netdev() memzero-ing and calling
>> init_dummy_netdev_core(), keeping the old behaviour.
>>
>> init_dummy_netdev_core() is the new function that could be called as an
>> argument for alloc_netdev().
>>
>> Also, create a helper to allocate and initialize dummy net devices,
>> leveraging init_dummy_netdev_core() as the setup argument. This function
>> basically simplify the allocation of dummy devices, by allocating and
>> initializing it. Freeing the device continue to be done through
>> free_netdev()
> 
> Ah, but you need to make it part of the series with some caller.
> Maybe convert all the ethernet ones?
> 
> $ git grep 'struct net_device [^*]*;' -- drivers/net/ethernet/
> drivers/net/ethernet/cavium/thunder/thunder_bgx.c:      struct net_device       netdev;
> drivers/net/ethernet/marvell/prestera/prestera_rxtx.c:  struct net_device napi_dev;
> drivers/net/ethernet/microchip/vcap/vcap_api_debugfs_kunit.c:static struct net_device test_netdev = {};
> drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c:static struct net_device test_netdev = {};

There are much more of them unfortunately. Pretty much every user of
init_dummy_netdev()[0].

I would prefer *replacing* init_dummy_netdev() with
alloc_dummy_netdev(), so that we'll be sure there are no embedded
&net_devices and we can use a proper flex array there.

[0] https://elixir.bootlin.com/linux/v6.9-rc1/A/ident/init_dummy_netdev

Thanks,
Olek


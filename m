Return-Path: <linux-kernel+bounces-67962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 777598573A7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 03:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA19E1F23A3E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 02:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7306DDDC;
	Fri, 16 Feb 2024 02:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JemcIGnp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E24EDDC1;
	Fri, 16 Feb 2024 02:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708049113; cv=fail; b=WITgYAnErA56E39BUY4ucXCo/CjHMk9l3DtIml6XO58XNrCMgzXN9kNOW5/9m2ifrOJPLIHNQAWysj9hhMJRFiELLP0qU1WNe7HWbYr+dKPAHJuHtvrVqCiCPx0iej3dDN8t3zuJERwejb+JXKElN4eoSqaVgTewN9UDED8hkds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708049113; c=relaxed/simple;
	bh=PNwqU7Fg3Rvx7/MqzGlIHhrb1D6QjnNjS7p5Wq4HElU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dwZx2WZl7zv196lrbW2C0cwbv/lWHPWnZD4rCAlKcKjsRaq0K7j9HXXnhzLI9rnAnqxuvAInmmO8gg2bDengEnVOU43w8YNxYku0LEUxKs+iC8HLtT2illuycf6+t5ErcaEOjjzve0QHii6QmyXNpqmgF40DDEoqDa7JEmYGmWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JemcIGnp; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708049112; x=1739585112;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PNwqU7Fg3Rvx7/MqzGlIHhrb1D6QjnNjS7p5Wq4HElU=;
  b=JemcIGnp2YGQsGIh/HNE0WQpHBdeT3dVnxQWtOdc7QRm4DqKazlPr//S
   CMHPWfCx7yRUPw4Mo5IbhBcCKaog/yqCIncDplRdo7Wa9VFQNrDBUmwcp
   WpyfE7H4dIHVVNRw3OcMb3NyYZBjUz14Gt9LO5qTKGsmnNcpdgqVdww5i
   ZWA4VchrgTiup99Yy1F4YjuTREd8NtebBRjsJbEyvu2SEXhfWRI++5rg6
   g/AJRt7JMJIu/PpzNu1A/yxi9PXIzZ9kEOxpHxiNUblHf5oMKxQbG6z1w
   rt96Dkdi2T4QHyQsYs7gBEN/qPZRgQzZCXz7S1pHt4K4VUbyGHvC2HVXJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2573459"
X-IronPort-AV: E=Sophos;i="6.06,163,1705392000"; 
   d="scan'208";a="2573459"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 18:05:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,163,1705392000"; 
   d="scan'208";a="3733263"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Feb 2024 18:05:10 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 18:05:10 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 15 Feb 2024 18:05:10 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 15 Feb 2024 18:05:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvInAnbDWWykqbqY8RoaVv/oq592fUx/689J5XGDIQTynUF8MB0vFFYCw4WPhksbrw4TOCZE2X9km9h3n2doV4p+DJPKZ+dXpHP0KHUcMJqrcUHGc67TMteCRASCfkCd91RGEEfqvkLhT3A2qxsBfGEGZu8ON1I7vEnackmNtVDwirxger8DxXXVCJfRnCLsPPeLp6gzn8/2RMgUb6pwRg6zVwWT6SXebs9M6vg9jR5E+7f3MrDOpDjVIw7FF/UezBieexGX/x2Iu9VYmeSFCfh7aPi56QLqdMHOvk3GhwA+mSKA355xtBJ9GFLeUvcCdutYJwCZD5Nng/zbMD+qzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlBZHyt/rP6AbarfeFdwzM1sjLVc6aJLJOg0HbWWkYQ=;
 b=LYZisbmkkfDdZkNHAgvYEEVi6gDnoI2khXpUgjSAcQmkrSGjOSWgSou9Z84i9TPPxGQDW/TyDsaoMYAhQ0tojO542Bbtgw1wtatLEYeLjTQ7FN6GKgQpQXDitfu7dax9chsvFAfiXFHgTEbqVVu33oIdZI9RIcUNUW+ooKSTAJrgqCr7l2PzfEN4YUuVEqDMDWWdl7OH4gds6RCNXCnMKU2Lby+SGFO1bBpg5xEU9F7iQYcSnvsqWU6HT4vjOClVWIx1hxNkdF/hDeQJpeyRWfMYbf0TYMTgI4xFPSuCss9f0F0cIjKoXTgCCfebUlQ+9I/542ZiA1vhC3iMcP4e2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) by
 DS7PR11MB5968.namprd11.prod.outlook.com (2603:10b6:8:73::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.28; Fri, 16 Feb 2024 02:05:06 +0000
Received: from DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::52c6:33d7:27be:28c5]) by DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::52c6:33d7:27be:28c5%4]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 02:05:06 +0000
Message-ID: <fe77c42c-7a61-49ee-b729-abc87ae6e352@intel.com>
Date: Thu, 15 Feb 2024 18:05:03 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/4] tsm: Runtime measurement registers ABI
To: Dan Williams <dan.j.williams@intel.com>, James Bottomley
	<James.Bottomley@hansenpartnership.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, Dan Middleton
	<dan.middleton@linux.intel.com>, Samuel Ortiz <sameo@rivosinc.com>
CC: Qinkun Bao <qinkun@google.com>, "Yao, Jiewen" <jiewen.yao@intel.com>,
	Dionna Amalie Glaze <dionnaglaze@google.com>, <biao.lu@intel.com>,
	<linux-coco@lists.linux.dev>, <linux-integrity@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <b8140cc8-a56b-40f6-a593-7be49db14c77@intel.com>
 <fe1722c3618a8216cb53b8fd3f1b7cbb6fdff5a0.camel@HansenPartnership.com>
 <65c2e4aa54a0_d4122947f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <22088ed3-51a4-415f-932c-db84c92a2812@intel.com>
 <527da630-4952-4b1d-80c0-5a87997ff9fd@linux.intel.com>
 <332775d7218843d6cc168c963d76e6841eab5d5b.camel@HansenPartnership.com>
 <65c691e13a50d_afa42948a@dwillia2-xfh.jf.intel.com.notmuch>
 <226df539-b3f4-4099-b6a6-293fa200c536@intel.com>
 <982e19fcd71c41a162ba664281eb0a68d9dc960c.camel@HansenPartnership.com>
 <ef770532-6db6-4262-8225-2d3ee09b7d23@intel.com>
 <65cdabb4be63a_5c7629420@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Language: en-US
From: "Xing, Cedric" <cedric.xing@intel.com>
In-Reply-To: <65cdabb4be63a_5c7629420@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWH0EPF00056D0F.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:11) To DS7PR11MB6269.namprd11.prod.outlook.com
 (2603:10b6:8:97::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6269:EE_|DS7PR11MB5968:EE_
X-MS-Office365-Filtering-Correlation-Id: 60f92834-77f2-49eb-6cd6-08dc2e93b23c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cT55URBUxerqwEcCB7KqRdX04KqSbSnJ2LeAccb9Mj/LSzJNXfI1F5x7RjMPmR0Wb1tsxMgNEFHKOel7yBa3P+qOvw8eKUEXC1+VtrSRgLoJM8V99M/yOw43grvzfjAqToflVNKii+or90BZ18yInlNPEajXezvcEbp1y9huGR80cYO3oJzxL7felFyx2RFbZoDx5HnxrhvPSXArg/grGEeQGxanBpUrIoBYA8feXnjMTJH0uFGA4kJdH38I736veqtk2dJVWqzmE6rLoR9VyvcepAn87bOvhN50BBk9hiD8iLAlHZdVRyzbK5fJUJJYJHHAQp2Dgm11SWuSpHrbNk3lRkn7j++IVyU2b79hR7eI8WY48EohyU1KneSlxbV+GldseCn2lmNvLCsBs4JeRPUswqfvQgfaOzLAWaXEv4jeZpZ+ys8Se3Dj6WqnnwhFQxpHIcIww8ywuG3AIXJ/vRtaN9s5UWK+whr79w+Ieohhb+78dDWBG1QvMEuLCRmDCBaJmcFuq4iV62r0x/byys2mT3fKCBEQ3fvXh5+U/kk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(136003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(6486002)(6512007)(966005)(478600001)(31686004)(41300700001)(2906002)(8676002)(8936002)(4326008)(5660300002)(66556008)(53546011)(66946007)(54906003)(66476007)(6506007)(316002)(6666004)(2616005)(83380400001)(31696002)(110136005)(82960400001)(86362001)(26005)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0pFcnZ5ZFF0cFdsUVhOWFJ2aWhWNWQ1ai91UEZUNEQ5dEpFdXNBTlBCcXBY?=
 =?utf-8?B?WjJQMEhYYjNGRUdFU0RmNUNtendjSW9Mbjkrb3pKV2hzVC9yOUpDQ1c4WVRx?=
 =?utf-8?B?WG9EckxYZWg1bzV5N3hiam1OdFd2K0VaL2trY0JSdmJBOTV6bFdsajNvUElP?=
 =?utf-8?B?VFk0UXNGY2l6Uy9qaUdsVEhhZ0QvNHNDYXp3bE16UktnMjNHaTltMWU4N3JW?=
 =?utf-8?B?K1dFR0czQWhhOXBMaVRyTHFyQUZIYmlFbjlPZlNoZDI3cXpVNHpIYllZNUEw?=
 =?utf-8?B?U1c3VnR3NEl1UngvTWVuMHVhNllVWlVTZ0Vjd2J4MEVGQytaMTh1SWNzWndD?=
 =?utf-8?B?U0pGQndIV1RWcWdBem91bnNXQXJXK2d5SDhCaFdjOWdwNEZ4WERRM0dEK0NR?=
 =?utf-8?B?QmJHRCtKTVcySnZSRFFkOHpuUENtQTRFa2pVTG1HTW9wejlDOE9aWUxLVmE2?=
 =?utf-8?B?Z2gvMVpFY0dod2xJbFVCRGtwOE9aeEtsVmJFWFNydFRjMXUzV21NYzFBdDdW?=
 =?utf-8?B?bWYvMU9TaXA3SHR4WVpsRlVVeEhmRDlBQzlwSFBqRFZDUWdNS2NDMUhGbkVL?=
 =?utf-8?B?TnpybDZ4NU5JdGNMbG1wQmFaOXBZQVI5aGFTYXQ4UFNYQ2RQbVpKWXRScDlu?=
 =?utf-8?B?K3JXUWk2N09JY2Jaa0xMSEpsSVc4OFB4dlFTLytheWZ0YmE5T041TnphUmZj?=
 =?utf-8?B?T1lOSHg3SEFSYjZPRkkzc254TmFtbEo5VldVSkpjN1U1ZXJySGZnQXJ0KytS?=
 =?utf-8?B?VWpKQzN4VlFPM2VaQmw2eGhXUFMvNFRacllNUWJTdVJRMTFmdUY2R1RFMU0y?=
 =?utf-8?B?ZWRLMEdKZWpZT2YyaXRNT3FWYWVCU1RlZ1o0ano0a1hPbTRXTTlTMFJoZTVa?=
 =?utf-8?B?cjJrNC95cGJaZjNlZVNISTZxQlROYzRFLzZLL3FBdmhCV2M5S1dGc2ZGUEFM?=
 =?utf-8?B?Uy9ZTlQ1WmVSNmt5Sk9FOHFnLy8va00zb3pnWGJwVGVWeXFQWUZvTGFYTWlw?=
 =?utf-8?B?NlN1cTVxVDNocW95cmExWTlhQjlqZXIwd2RVeUphY3hneERWZVgzRkEvUWRo?=
 =?utf-8?B?Rm9hdEFLYlZ0L1JhY0c4Ym1rQXJJV2ppYWkxNERsbGNKS1grYlU4UlpCbC9k?=
 =?utf-8?B?RVpGazRUeWR2TzVneXlSYUtmYWN0QklxeFlWODdNSWlWcE9NRVpHMHdVOXpv?=
 =?utf-8?B?VnpPcCtmNTc4dmVGMlF3UGR2WlBDMlJTWWtHNVhQcWJ2SVJIK3cwbFg2RVc2?=
 =?utf-8?B?cWM5aFZwcXllTnZnL1Y1eTJoQ1hVYUFWK1YyU2RGWnZaSXNRQVVrY2ZKL0lr?=
 =?utf-8?B?c3E4a2hwdWFCQmJnd0IzSTJpZHI5bGc4T1hOSWJ6VUdXWEFWeXAyMUhHTk9v?=
 =?utf-8?B?WVA4QmlmR001b25ZLzdMMWxaMVR3MTAyUEt4OXhMYm4zQzFzUVY5VWM4aXlq?=
 =?utf-8?B?T0ZjRmY2SDNXRkQ3SE9qRkgzUjBtNnF6Z0ozT1BhMjF2RzcyK3VSZXEyWVpT?=
 =?utf-8?B?TE4wVjlnbzAvTTFSZnl6SFhCS1hOWXM2WU9nYk54ZjhXSTlhZjJHRlNyTkd4?=
 =?utf-8?B?K1lEUG1qU0owSVZXOWZUSmxQLzVMM2p0N3dvaXdIKzM2d2ljVXpoYXloSDhZ?=
 =?utf-8?B?dWp0TnlRSndWOWw5ckZ2THBodzZHNnhoOGs2cWF4RlExWVhibzNqWkE2UC9V?=
 =?utf-8?B?aWh6VTFGd3pnTlBlNlBiM2luRVFWNEYvTElDQjYvZjlKczNWa1JRQ21vRkNX?=
 =?utf-8?B?RjcrbG9PRy9EbS9PcDBCT2x3RXNSc0tmUllQTWJLd1k4UHhnWUx2T1lrUmor?=
 =?utf-8?B?ejlteXdPT1dTeWVQSlZhcGhRTkJ5allqUDFHdzRXck5WMkJSYXVNMkNBcTZ4?=
 =?utf-8?B?aWNNVG56MENIWFdRNVE0bVhMQXNEQ1VSY3hCQ2tJR1ZvM3hsZjc3eEE4bkVT?=
 =?utf-8?B?YzZWQVJvY0NzWUN2b2x5SHZOU3h6OWNHdTQ0ODdRbVNvNG5FWTNKamRQZlZQ?=
 =?utf-8?B?TCtuZk9JK3pNdFhFcGhBRFYrMGk3Z1AxVWVJemdXUEE4SnRqWUhiVXZ4cCtu?=
 =?utf-8?B?bXluUXg5K3NYOHc1QUVpRFlHbFZKbi9pKzdwc1MxNDZ6TTlSUHl2cTFyeTlB?=
 =?utf-8?Q?VEG8xdP07xYONbYKVz2X942dF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f92834-77f2-49eb-6cd6-08dc2e93b23c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 02:05:06.6995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s4f2JU4cmTy6mn+uAjMcHdIF0KHXVwJNJhQWUgoic+riHjEDmS5ZoIUOZI/ztHmBL+4pOz+IdbQiZZDURl2/9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5968
X-OriginatorOrg: intel.com

On 2/14/2024 10:14 PM, Dan Williams wrote:
> Xing, Cedric wrote:
>> On 2/13/2024 8:05 AM, James Bottomley wrote:
> [..]
>>> The TCG crypto agile log format is
>>>
>>>    index (32 bit),
>>>    event tag (32 bit),
>>>    digests array,
>>>    sized event entry (up to 4GB)
>>>
>>> So an IMA log entry can definitely be transformed into this format
>>> (providing someone agrees to the tag or set of tags).  The slight
>>> problem would be that none of the current IMA tools would understand
>>> it, but that could be solved over time (the kernel could use the TCG
>>> format internally but transform to the IMA format for the current
>>> securityfs IMA log).
>>>
>> Hi James,
>>
> [..]
>> Another problem of CEL is that NOT every byte of an event is
>> hashed/extended. CEL spec has defined for each "content_type" the subset
>> of bytes to hash, so a verifier must understand ALL content types to be
>> able to verify the integrity of a log. In other words, the integrity of
>> a "systemd" log can never be verified by a CEL conformant verifier.
> 
> Wait, James said, "crypto agile log format", not CEL. Crypto agile log
> format looks more generic, no "recnum" for example.
> 
If I'm not mistaken, "crypto agile log" refers to the same format as 
"TCG2 log". It's "crypto agile" because it allows a plurality of hash 
algorithms/digests (specified in the "digests" array) to be extended to 
one PCR - each algorithm supported is called a "bank" of the PCR.

CEL is also "crypto agile". I'm not familiar with its history but it 
seems emerged after the TCG2 log format, as CEL's information model is a 
superset of TCG2's. Specifically, CEL's information model covers 3 
applications - "CEL management" (owned by TCG/CEL), "PC Client STD" 
(owned by TCG PC Client WG and equivalent to TCG2 log), and IMA. 
Supporting any new applications would require expanding CEL's 
information model - i.e., by changing the CEL spec.

> [..]
>>>> IMHO, we don't have to follow TCG2 format..
> [..]
>>> https://xkcd.com/927/
>>>
>> That is funny :-D
>>
>> I can't agree more, so "no log" I think is always an option.
> 
> So to me, "no log" means that instead of going from 14 standards going
> to 15, the kernel is saying "whee, infinite userspace log formats!", an
> abdication of its role to support a stable application ABI.
> 
If we look at how CEL is defined, it separates information model from 
encoding. Information models have to be contextualized within specific 
applications, but encodings don't. The reason for 14 standards is 
because there are 14 different applications. The 15th may be able to 
combine the existing 14 into a single one, but probably cannot 
accommodate the 16th.

So I think the only practical approach is to abandon the information 
model and focus on the encoding only. For example, JSON is just a set of 
encoding rules without an information model, hence can serialize data 
for all applications.

Coming back to the TSM log, the real question is: Can we just specify 
the encoding without an information model? The answer is yes and no. The 
kernel does need to know something, such as what to log, what to hash, 
and extend to which MR, but does NOT need to understand anything else 
about the event. So a potential ABI definition could be:
   - Take the MR index and an *encoded* log entry as parameters from 
user mode.
   - Hash the whole entry as-is using the same algorithm as used in MR 
extension, and extend the resulted digest to the specified MR.
   - Append the whole entry as-is to the log file.

The key difference between the aforementioned and CEL is that the former 
takes the *encoded* log entry as a single input to alleviate the kernel 
from the necessity of comprehending the logger's information model.

> The job here to define a kernel de-facto standard for the tags that this
> configs implementation of a cryto agile log emits, right? As James says:
> 
> "(providing someone agrees to the tag or set of tags)"

I don't think we should define any tags because that can only be done 
for existing applications but can never address the needs of future 
applications.

We don't have to maintain a log. The existing TPM module doesn't 
maintain a log either. systemd on the other hand is an example of 
keeping measurement logs in user mode.

But if we agree that a log is indeed necessary, I'd recommend the 
aforementioned approach. We can then focus discussions on the options 
for encoding log entries.


Return-Path: <linux-kernel+bounces-63051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D58852A2B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B1601C22834
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CDC18044;
	Tue, 13 Feb 2024 07:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XEpDjf1G"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30CB18036;
	Tue, 13 Feb 2024 07:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707809803; cv=fail; b=b195OVIU+7GHM0w/ApIPfJ06ZbonDs3Ns+OTMFOjgPMZvsMTo9y+0W8qSuqn86ppZaBhudiJl6AJjJxa2RUWPaT/69/9tYmVoKDHXKtpSisfK/MWJiy6yi84+l8Zl1nyG81oK6yULlyirG1BfHSRV/nUuSM/gYfoQQu943cwjp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707809803; c=relaxed/simple;
	bh=o+Ym1X+PUcL5wtW+h0SzUgqjXHscmV3mQ9Yg7x5huRM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EYrMkVPfFag6HllZ8hCKrIt29cJhVxwRHeRcNzLjpU2NGOS10uLo77VPeu4KIGIcB7iX3eoamibCQnAD6bvhYTb7ZsAWful54kwvpF727i2skIzT1JOkNWfBeLiZkgx2C2YZQPQUyDvthsjJztxpc76S6qzHZx7+Fwa4tuxkc2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XEpDjf1G; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707809801; x=1739345801;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o+Ym1X+PUcL5wtW+h0SzUgqjXHscmV3mQ9Yg7x5huRM=;
  b=XEpDjf1G7TAs9WGFw8wDHOcvlW4H32xnkXMb5oXyn+KUlh6yyDexTPXT
   hUSRKdVQXQhAo35qrGt034kuHwIw9AVV1oT2BNndZW8C/kgP20pxM+0og
   zA9S1oj9Re2pDluFWLb4ck2B/w/uEL9tNiHEwLfgDR55S13HTjCG5lL5V
   9QSHzjluahD5CUeOVI+Am8VhcuiLPdoaJyj/9Wy3L/oEqBLz7+hYu9F5b
   sl2W0bucjLh81xJ8inkEslQi6H4JvFFsV6t4JFvRgMeHN+ELBaaaezXwq
   i0wDhn5fHUF8XQjsaEjf3nMcfDTu4fsTDYyzmFlteh49Luf3ugdVj8xT7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="13200191"
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="13200191"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 23:36:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="2798426"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2024 23:36:41 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 23:36:40 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 12 Feb 2024 23:36:40 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 12 Feb 2024 23:36:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1juu1ZV0YqhtK4Og9pMBawTXtG2mAkRbldA2EX3rPChljBCpbDkfZItODt5XQrApoZFveTWaadvzVzhSX8lHCb+3fXPKVfd192ZRI/xWnwXRm91H0SXXMfad5Yzk7GtNPhK4flgtUKWrp3URrLGFWgsVXjSM830GECsZWJe+0QGKsuyJiCJ6FihKmWIqp0cJdoe6NM/9VlgKQVX53K2h6lcPMdCA1H9TK6T9/Cn63QsyZ4MN61Mx3lN0hvc278Gaa0o4UBTmVt07MXdLAIBpH5+9+AuM02VibkZOlKMTPTeERtJXhedmjas0oaJZo28sYiMUvxCRqt0rGrCoj9zvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8oNtDF9SQJwk044lJZHOoQdqH2QT6KU6GxDQi2KxqbY=;
 b=F5Didko4odIsoATl3ppNZicngZ9fIqw6YUms3gYOqHtRQ3mugsIS5My5My2oPlfv9nDtO6lNj9eflfhM/uR0mEpAphypi3jOZOlmZIyrnh242YChAn3CPnM4A28A1+1rc/pZt+mkmUB9qY8vJAkahgEUiBf2Pb/j7n4TqHKvPpGVElb3bZv+l9GZHXB75qIFJsZc/cXjpOV9UgSEk2sHN4/oQQT9GA8HMAds9C3zZhEgnfYK3wmLcMGI8nW0PMoPFzCEugvLfCrEdzdeyv2NTfxGGm8ty9meR9fBz9xrPZnRdml0g4qw+XPdBu05+278Dsjw6GKQSHmRUsk18BSJJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) by
 BN9PR11MB5449.namprd11.prod.outlook.com (2603:10b6:408:11e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 07:36:37 +0000
Received: from DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::52c6:33d7:27be:28c5]) by DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::52c6:33d7:27be:28c5%4]) with mapi id 15.20.7270.033; Tue, 13 Feb 2024
 07:36:31 +0000
Message-ID: <226df539-b3f4-4099-b6a6-293fa200c536@intel.com>
Date: Mon, 12 Feb 2024 23:36:27 -0800
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
References: <a255bc36-2438-41b7-b304-bcf7a6628bef@linux.intel.com>
 <42e14f74d3819c95fdb97cd2e9b2829dcb1b1563.camel@HansenPartnership.com>
 <1557f98a-3d52-4a02-992b-4401c7c85dd7@linux.intel.com>
 <85b7a4a679eada1d17b311bf004c2d9e18ab5cd3.camel@HansenPartnership.com>
 <b8140cc8-a56b-40f6-a593-7be49db14c77@intel.com>
 <fe1722c3618a8216cb53b8fd3f1b7cbb6fdff5a0.camel@HansenPartnership.com>
 <65c2e4aa54a0_d4122947f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <22088ed3-51a4-415f-932c-db84c92a2812@intel.com>
 <527da630-4952-4b1d-80c0-5a87997ff9fd@linux.intel.com>
 <332775d7218843d6cc168c963d76e6841eab5d5b.camel@HansenPartnership.com>
 <65c691e13a50d_afa42948a@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: "Xing, Cedric" <cedric.xing@intel.com>
In-Reply-To: <65c691e13a50d_afa42948a@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0327.namprd04.prod.outlook.com
 (2603:10b6:303:82::32) To DS7PR11MB6269.namprd11.prod.outlook.com
 (2603:10b6:8:97::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6269:EE_|BN9PR11MB5449:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aae3c99-2643-427b-cef7-08dc2c667f4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6RWzMuCCrNo/tBAEUr2HUVMD29n1bNidXvzbcnDbVZEXLa0cDq7BSt7veXnTasp/KyM1DjWAsmc/uBqLify56TKRZ/Zu3HtPcGAZfkGhyjZV3k/zeRKNUhJdGZRoxQ1RZnGz27TrL0bNcxHhubhVCLyBGCqzFH4l8ZDWQ+TiPcdSmDeYZ5XYvu0ZffVIfPQSESOiKSK3hxpewRh+KRt1FO3RM8uFz1bhzgSOphKob5L2bCKoAlfoaNt8LIeT296ToQiuyOdbJ+rIJsV8kJne9NvSBWYvTZl8XhIsMpaYUfPb0C6+QtBjYXPQ5oCl5Cpq9ZkF6+2XIo0xFWFZTZFwMzJBrY1pcHH6V3p1rd81YlumDM00z46hQ/QLsi4V/ouliBVyXzPWUTPFrbRwCLcL6JZ+r7+toLHUfgC/1T5UYs1U3VUSPwqGUYNxfhP/1e4AVURCiPPRoxt7i12J692FII9U15phL83RAOX/ZriGWSZVkMH7sWI7Jf9ZJGBSJn2NaVMXUSXdwoM6M7Czme50zPOzTVUEkl6EDA/8bU/8SEE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(366004)(39860400002)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(83380400001)(86362001)(31696002)(110136005)(66476007)(316002)(66946007)(66556008)(2616005)(6666004)(6512007)(6506007)(54906003)(53546011)(478600001)(966005)(6486002)(5660300002)(2906002)(8676002)(8936002)(4326008)(26005)(38100700002)(31686004)(36756003)(82960400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cytzNWZod1JpNjZ2VFV6SGJ6ME9haHQxbHNnOThONElWb1g0Wk1aemMrUVhx?=
 =?utf-8?B?bVJHd1hrTTJHTlRVVkdMb3hTcTkzWStJTmRRZmMvTFRHMEllQ0hqVjBKaDFB?=
 =?utf-8?B?Y1dBd3JjazRYaWNENllIZGczbWhiWHlNYnhNWVFUajhXRXJKc3M4K2RseDFU?=
 =?utf-8?B?TTFOWXVwMFBCUjkxQ0lOY2dtU05aNE52WjBvQVZCbmxQb0RVRitacktiM2cr?=
 =?utf-8?B?ZkdZT3puQ2huWmRSTExWWUFVRTlGc3Yzai9sblBiN2RLSVcwK3cxZWhIYTI1?=
 =?utf-8?B?UUtsWjMzWmV6V0tBZmxKOE9sUDMzaGxHTm1RSXhaN0ZBNGozY3hnbVdnWHJ1?=
 =?utf-8?B?ZWRUWVFpVllHRWJKMWJPKzdMUW54MC9qSG1kU0pvS2czTC9KcU11NDMxM2Jr?=
 =?utf-8?B?ckFsYlpTSks3aDMvTWlMUSt0WkVKY0JpbGQ4MXhaaktLaldkeGhiNTFpNVZE?=
 =?utf-8?B?dGcxbUJ1dVQ3QzJhUWtVL00rbUZUZ2RIckJkQ2lRZG1zd1FGQVNYR1ZzQkt4?=
 =?utf-8?B?S2dPNUY4K056bXMyejFxNHBkMjBzYm52d2hGdlZ2TkxVQ1VMY0dDemtlNnhT?=
 =?utf-8?B?dWU5dlNXaXpRRkVoNzlUWUhzOXJqVjVFRWp0NThveHMycnZVMVh6T1Vsdm94?=
 =?utf-8?B?TzVxNHRLT2pNWDVmYzlCc2x3bEpKMFhWcTRaMXhYSms5cFl1T29VZ0tndzV6?=
 =?utf-8?B?V21qV2p2Y256TGxVNnQxMCsydURPd1RQTUFBRlVDM1NNNk9Wa045RHZGMHRq?=
 =?utf-8?B?TkZLak9hUENGZEhGZmNaR0F4SjRLY09mWVhzMDFDS1dCc21RdkN5S0w0dUwr?=
 =?utf-8?B?cTNXWHhESU9oQ1ozSXlJbUZ5NTA4dzUySUZKM1JwRS9WWFlHQ0U1djRCRkti?=
 =?utf-8?B?eG5BdlR2QWU4Z0c0T29na3YrbXYweWd2SlJDSVVHVHBCS3lIS0l3YmFhS3Az?=
 =?utf-8?B?WEhWSXNtemlodDdiTFhOS2RXZDNnUDAyQURiaXAxdzl5RG5KM1JaaFlnMk5l?=
 =?utf-8?B?YTRxZzcxdTNZa0prVjRuRURBSzdkRVpMUWpDWG9OekdoNno3LzhxbDR3QmxK?=
 =?utf-8?B?MWFLckthRFVHRDVWVUtGb3lBZUt4QURFTTd5OTlUTU1CMWtiak00bmNMS0Q0?=
 =?utf-8?B?WTQ3MVNhd1JiK1ZWb3IzdUlPcmRTYjJBL3hyaXdHdnkrSm81L2dTbjdxN3dV?=
 =?utf-8?B?S08rOFNpYms4UmVDV1IyWGcxV1JpOEtBS3YyQlRxMFpEakN1L1BIU1RXZzhm?=
 =?utf-8?B?MWd0dzRFVDVMRkNiSW50VU16b3dTRll2MHQxZlNZMXlWZG1kZmt5ZjRqNUto?=
 =?utf-8?B?Nkg5OEVQZDAzc1R4NElDMTlCdFVBMTRuWmtBVHMzL2FoUUo5VEpFRUVmYVU2?=
 =?utf-8?B?VkhMUjVTYVo0ZFhRMm1zK2U3cjg5RnRaaDZDQ2ZTeG16Ui9BM1VlaG44UE9q?=
 =?utf-8?B?SG4zMDhZbS9qbjA0QjRrR29aMDVrYk43QmxjekU1Vk51WDlOZ1kxeGdxSWdz?=
 =?utf-8?B?TC90WHVtTHh2bFhvZm5mbytEaGlyYTArei9UeGhKcXZJMmRVN1M4UXJMdEIv?=
 =?utf-8?B?alpsaW5LeG9GRnA0Z2gvLytJbUJyck0xUERXOHZBTVA5UWl6VTNTd1FncUYr?=
 =?utf-8?B?a01hQUNIWC9oN0tIS0hqcm5rUGhJUnQzODcrL0hLSGpXSUNyb1N2ZGVIbFkx?=
 =?utf-8?B?U2xwVk1tVVdnNDQ5a1JuM0JtWWR2WTZFeUhHWUlwZlIycmFJQlVLa0ZjZjBm?=
 =?utf-8?B?N0tmYjlOMzFKTFJiSE1LYTVUbmh2MEJML1RuLy9lRU4vWmpvUERSN2d3eWZ1?=
 =?utf-8?B?R1V5Z09weXpsUk9GWWFFSHprSlNzTytabHdXRnMwdStXYk5yUUZuc0t4VXl0?=
 =?utf-8?B?NTVGTUhlSTl1TitTQ2xWbHBIdWRGWVU5eFVENHFnb3p4TUNzMGliMDI5TU5u?=
 =?utf-8?B?cG0vbUpOQkloSE0rd3VNNlJqQkNSM1UvbzZtd2FuSGNVZHRVYXBTSkRyUS8x?=
 =?utf-8?B?ekpzVHdDZTFOaXhoQ1Y4ME53Q2l3bG9PQjc2bHVvekU0R0ozS2VRNFJBQzlX?=
 =?utf-8?B?THM4UnJHSWRJK2JlbHZwdW16MWRpNWlIaFprUnhtMlMzeWFkU2lwRTArM21v?=
 =?utf-8?Q?I22w9/I4a3LA+nm8piXe8HDeA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aae3c99-2643-427b-cef7-08dc2c667f4a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 07:36:31.5480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Fn9UQY+fUEhYtv9pa2t3baamWoM8Ry3RKhQ2o2oImCpQcYf/zJKMxoQGgcYoYtHV9dylGJnDkoB4vsvN5O+Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5449
X-OriginatorOrg: intel.com

On 2/9/2024 12:58 PM, Dan Williams wrote:
> James Bottomley wrote:
>> Just to correct this: IMA uses its own log format, but I think this was
>> a mistake long ago and the new log should use TCG2 format so all the
>> tools know how to parse it.
> 
> Is this a chance to nudge IMA towards a standard log format? In other
> words, one of the goals alongside userspace consumers of the RTMR log
> would be for IMA to support it as well as an alternate in-kernel backend
> next to TPM. IMA-over-TPM continues with its current format,
> IMA-over-RTMR internally unifies with the log format that is shared with
> RTMR-user-ABI.
> 
I'm not a TCG expert. As far as I know, 
https://trustedcomputinggroup.org/wp-content/uploads/TCG-PC-Client-Platform-Firmware-Profile-Version-1.06-Revision-52_pub-1.pdf 
defines the event types for TCG2 logs for firmware uses only. I cannot 
find a spec that defines event types for OS or applications. We may 
reuse the firmware event types for Linux but I doubt they can 
accommodate IMA.

IMHO, we don't have to follow TCG2 format because TDX is never TPM, nor 
are any other TEEs that support runtime measurements. The existing TCG2 
format looks to me somewhat like ASN.1 - well defined but schema is 
needed to decode. In contrast, JSON is a lot more popular than ASN.1 
nowadays because it's human readable and doesn't require a schema. I 
just wonder if we should introduce a text based log format. We could 
make the log a text file, in which each line is an event record and the 
digest of the line is extended to the specified runtime measurement 
register. The content of each line could be free-form at the ABI level, 
but we can still recommend a convention for applications - e.g., the 
first word/column must be an URL for readers to find out the 
format/syntax of the rest of the line. Thoughts?

> ...but be warned the above is a comment from someone who knows nothing
> about IMA internals, just reacting to the comment.
> 
> 
>>> I am wondering where will the event log be stored? Is it in the
>>> log_area region of CCEL table?
>>
>> IMA stores its log in kernel memory and makes it visible in securityfs
>> (in the smae place as the measured boot log).  Since this interface is
>> using configfs, that's where I'd make the log visible.
>>
>> Just to add a note about how UEFI works: the measured boot log is
>> effectively copied into kernel memory because the UEFI memory it once
>> occupied is freed after exit boot services, so no UEFI interface will
>> suffice for the log location.
>>
>> I'd make the file exporting it root owned but probably readable by only
>> the people who can also extend it (presumably enforced by group?).
> 
> I assume EFI copying into kernel memory is ok because that log has a
> limited number of entries. If this RTMR log gets large I assume it needs
> some way cull entries that have been moved to storage. Maybe this is a
> problem IMA has already solved.

We don't have to, and are also not supposed to I guess, append to the 
log generated by BIOS. The kernel can start a new log, and potentially 
in a different format. I think the BIOS log is exposed via securityfs 
today. Am I correct? For the new TEE measurement log, I don't think it 
has to be collocated with the BIOS log, because TEEs are never TPMs.


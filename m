Return-Path: <linux-kernel+bounces-82739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D49B8688E0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B158D282B44
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7B853378;
	Tue, 27 Feb 2024 06:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hb7gn91b"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23BF5336E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 06:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709014499; cv=fail; b=fjCgHUZM7VstIx0VUMBQGpkJbOKiq7wSKu8XL1s/At0/q1ettCJAhHFniOT/zTJ6Eztkdd8O7oUGYC1T76/6+SmY3DGQsyNU2vW9ZMGNJFbMCQeMTQH8/83ir8kLjk3ydQky+xjrSUMt3twBxSOv+HvNChX8e3zIENE3llpxgOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709014499; c=relaxed/simple;
	bh=24prcu9Jzt8I83YNhaWgEwK4jQqD8Y+9XhW8RFMgRZ0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NbR9CUif5z8IL3nPtuj7VvHAXzNTfaAlbZJhJ2xK0s9Gph8hfHoSjC+3nlTGNTA6Ko9DT00xUbGsYAqDGKR8eUgHf2OCwIvVU9Bteh2Qed9WHNttTBUF8Gd7OkN8QpI57adACsG7kkMMtu4SmrgK4Kn1A4t9mkg5sUPFm+er5qA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hb7gn91b; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709014497; x=1740550497;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=24prcu9Jzt8I83YNhaWgEwK4jQqD8Y+9XhW8RFMgRZ0=;
  b=Hb7gn91bmzd3Oa6FnS3lSgjXBWZSwxb9oF62z/yA6uI8PhCMx/dbeqZd
   eLVqvzRSlskOTLnEkGB5Bjfteqx2lgnPGMyAHipEWZGgYMkkK7JvwtLlC
   1EykQ1bJCCdc9Rovs1aG/URKxt2m/OuBE85qeuJqOrr2gQvmGjLJ7LexO
   KfVdC/aOuPaCKH37pFD0XFxKZR37QX/9dbSsTcLs0KFZezOqEmXlXwEKX
   ZUQzrD9goN7hV3jvmni9tWupGBBtVp1DQNNalQvLwM8zKuBRCKIfZTpyj
   LtSSkNZdzsW1i/picVfGr745ZLo7jgQL0Sv4PLC/AGwzMCCkMV5BRTWE/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3500557"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="3500557"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 22:14:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="7476347"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2024 22:14:56 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 22:14:56 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 22:14:56 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 22:14:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LalF6wSusukItbaAqh4R+MQzADnOiTyLI1Cb15RCfxFLEL8PdWIWG5wjOYn/NAqImU3SrThkTMve7XxpVUJTNrJl3wQ4PKkOVrcAJGMb0hj66zxW+C1nnXfEOq1ArCLEA78sODhHViW5a0Wl03VY8rrHBa9B+5T+zNj1Avr1QDbEPHDrwky5cu3s6UannPNw7oljFkmNPoIaYoGIcLlpsuXOlFE+JXDBuRm+YVIfyhZu6AWqfn0otm7+KYToyMiLq7WPT9J5j6wXgBWGZC9aUKDYTNxrpz+BIUQdGEkoKNyQSKSt4RUFYsILSEJDV3kxmpsdq9I5JAnswm8kMvhUSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebavmyW8IHE5ubf9K3sFcPX9Q7ot1fdnaGOU5MhwkzA=;
 b=E3v7Ah3XdLR9F0ChBjWSmD5wCdzrQFoeBo3cRhQeKLgWFoeXxy+mRE55qD3YOlxTB7Zs6hX4EqcjvLcfy7ueEATE/3hUgkK7FmORGO/wg3ztSGCJM81GQ0iLYlcxwpYr74VJRR7HufMKlt6KorXZxDqsP5ZHYIGADl8AU+U4b7ffjbzqnjIqxfs5QLDsdxa3CcaWrnoo5TYxI3kUMN5IxiXK91IHNYhWa39DrRGTueTM/fH7u+Sd/41MyVfkL6tA7DYfwuC3RGrzH6rGJPkbK4cnQeFdHlS4wR/05/+dT+fApqVQbFklgCyX+7ANgqG/mFc8AhfKEbFX4pJ+oZkL0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CY8PR11MB7171.namprd11.prod.outlook.com (2603:10b6:930:92::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Tue, 27 Feb
 2024 06:14:49 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::65ce:9835:2c02:b61b]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::65ce:9835:2c02:b61b%7]) with mapi id 15.20.7339.022; Tue, 27 Feb 2024
 06:14:49 +0000
Message-ID: <3c56d7b8-b76d-4210-b431-ee6431775ba7@intel.com>
Date: Tue, 27 Feb 2024 14:14:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/madvise: enhance lazyfreeing with mTHP in
 madvise_free
Content-Language: en-US
To: Barry Song <21cnbao@gmail.com>
CC: Ryan Roberts <ryan.roberts@arm.com>, Lance Yang <ioworker0@gmail.com>,
	David Hildenbrand <david@redhat.com>, <akpm@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <mhocko@suse.com>,
	<minchan@kernel.org>, <peterx@redhat.com>, <shy828301@gmail.com>,
	<songmuchun@bytedance.com>, <wangkefeng.wang@huawei.com>,
	<zokeefe@google.com>
References: <CAGsJ_4zera4+bWuXHKjdU3QdiR3sqcUQB3gF08DPD49OCT4S9w@mail.gmail.com>
 <20240226083714.26187-1-ioworker0@gmail.com>
 <9bcf5141-7376-441e-bbe3-779956ef28b9@redhat.com>
 <CAK1f24mdwjz2J5VmeYSDwb4jMbrXUVCSF_0pOcWSVt1cfa0FhQ@mail.gmail.com>
 <318be511-06de-423e-8216-af869f27f849@arm.com>
 <CAGsJ_4z+0yXUDYwxKNAqYwxAAYpfKpKd2u_dVTDP3b-KPOQT1g@mail.gmail.com>
 <19758162-be5f-4dc4-b316-77b0115d12ce@intel.com>
 <CAGsJ_4wx72KOazANBvnGcjdZse8W9+PW5_fspP9=QuX3X_7msg@mail.gmail.com>
From: Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <CAGsJ_4wx72KOazANBvnGcjdZse8W9+PW5_fspP9=QuX3X_7msg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::16)
 To CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CY8PR11MB7171:EE_
X-MS-Office365-Filtering-Correlation-Id: a8a5a7b4-32ef-4a98-5c48-08dc375b6714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ID5SavzSnjYjbzAAgok6xX3cMwmR88L6Va2kBM+FMSHq/4le2d0ibVLXZFiI68x7yi0/jDKQlDg7PNof8g7XdMezcKqnu2ZaaVoNh2fMu2oMDpiMzpJ1ZMLB6PWp0CUh6qsAWDhXQlwCOckMXfQjjEteEqGZ1mrQY6G9W6LxgW4r9IuzUM2wrSTKXmQhb6nX9axYBV4npNjWl7FYyQQMKFgL3wG1M9LAxP8gGX4OeAdYEN98JKieXBtKYJ7f0EfE1V5Bo8vZIWxRF8Gp6fnbwpCVpnSblQ4aVuiSLHumeFtbEg2/2m+iJsRxKBBtFkSxO5+g32sHSVSMFuObQu5nLsSx1h/04oNBKSNnz7qaVdPpWSIGKuEQ35Z7RmDSF4VHjoFYXQEFgF0AEB0hus6aB2b5ww4w/OV68zehRAlC+H4Gp0ZVP/NsH4KGqHtxmHwTswZhrEwpzijfEdAKPp63JvhVZWHbh6vpg2otp4xEik68i52CYFkEl0hUWO7KKiaB1nSFH0nWW5x7mr8/d4PZ5iLuCxt9JLYfphjJcvwuskWb/+U+lTFVebFwNUiv+8Bvn6WSoae3C+61rPM0GHJY9D1AFYKoXwg9vciOUg5jx/+2oEvRH2zg0I1rbP4cmc8PZ7PE1VIDdZ8y9NfsIXsC1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0hwa004djlWZ0RDeTg2cG1IdWtQV1dlZTlLNDJkQ21lRWo5N1ZHNXVqQmNs?=
 =?utf-8?B?YnVIQjBCc1Rua3hZYzVybU5iZzlXQkVlOU4vMWc2Qkt2UG5PV1hKSG40Y1RM?=
 =?utf-8?B?VEZ4R3pZVFBxQTB5Qitldlp6bG41MERzQzZEbXlJOGxNK3UvU1JtdW5pNVBa?=
 =?utf-8?B?NHUrTWhycURDZkxKL1VjSUVOTGJwaE0rSmQ4VTYxR3ZhZ2hwOHFMbVlmc29u?=
 =?utf-8?B?ZVB1ZTJJdkdEVzlHUXpqYzBaMEFKaUU3eWJPQ0NYVWVxalVzdVJqVndBRWFr?=
 =?utf-8?B?dmhqb0phZFB6eC9MV2I3Uy9YK3pRSTVwT2VOOEYrUE9rWm5pOXpJck03RUdI?=
 =?utf-8?B?WnhobXZETWROVlFqaDlUc0IrdVlZdjR5dU94b0ZUT3dQQldHeFNkNXQzM0lk?=
 =?utf-8?B?bXVhTHY1WCtMQ0lUbWNwWGwvR3B6WThKOUFRRmxvT3pmcmlscDdFZVIwN1RR?=
 =?utf-8?B?d1RBWTl3cWlHVU5KRUdLTXAzNEJqWEEzOHFKSU44cjZrNXd4Vmd3UkwzWFRt?=
 =?utf-8?B?dUh0V3k3OVJLWVhhNkc4U3B4OXA5dXVtUnJLanE3ZjZubEUrMHNtanhnUjRJ?=
 =?utf-8?B?NGlGM2NWeHc3Qlk3UDd4eWtONDVWNCtkc0psVTZmVXR0QU1IT3VPY2YraG9m?=
 =?utf-8?B?SnBYN0JkK2ZFL0VjVENaY010SW5SbFpHai9SZG4yNTVUVnM0S0tqQUdoSlBj?=
 =?utf-8?B?N1BuL1hud215dVcvdTNyVVdTN1pJVDJrQm8xUy9PdU1QYVFCT053QmxmajZt?=
 =?utf-8?B?cGtEU0pGZWE2WjkvSHMxcVZZdmhnQk9FT1Y4a0pCcndKcnM5bWRaNHdpMTVm?=
 =?utf-8?B?MUV1TmJ6bFVpSEhqamxMWWFKQnhTVHJjZnQ5aFNBZEdkd25BWlRPNGFTZ1Ev?=
 =?utf-8?B?RTBkL2tidXpSMjlKTmdicWVHTFkzbVNMUEVPWlVNVFZrd2l5K1NxVmhlQzdZ?=
 =?utf-8?B?clB2OUJFcE9yM0NnYm0vSi9xMkZiNGJTRFVFY3ZVbWpVVEoxUk9XdDl1VnRX?=
 =?utf-8?B?OWhvbzQ3Tk5JUmxLR1dsVnVJa1dhanMzM3dhNjBaV0VVVER5a2tmSTdQVlRH?=
 =?utf-8?B?T1FtbWFGbjVWbnVkKzQ2c0pBeURGWmpUOUVFNDhxUTRTQnE1MVBLY3JsY1lU?=
 =?utf-8?B?TE1yenk1cTcrRU1nUWl5dTlrRlV0MjhTQkltdDJNZHFpZzd0WWdBY0dDK0RW?=
 =?utf-8?B?aVF6R1BscHlvTEVUU3g0K2ZuYjVXOVd5ai8vUWh5U3Jwb2tQSnAyYXNtWm4r?=
 =?utf-8?B?eEsxdWpud3pLc085dEhkaENEVXU3dDhjZVBSaTRGYVcwY2NsdE9zRHYrT05a?=
 =?utf-8?B?dk1ZcmtXU1J4bFIzMXlkdlB4ZS83VDN4aFJLS25CTVYvVk5UeG1RRnJvVGxL?=
 =?utf-8?B?T1IrdE1uNW9Wb0xRSHR2dGxGcWVhUXZWbENZMXVjQzlnQmJZVm44a3VCQURq?=
 =?utf-8?B?T3greksxeEZQb3kyWjhnM2dYaU91TnQ0RWxPRkppbVlCMU4yeXpCbkFobmlw?=
 =?utf-8?B?VjFqSEQvZlQyK0lkTDg2SWZHWmtEby9XNW9WeFRVV3hocnlaeTlpbEF0K1BH?=
 =?utf-8?B?Q2UrTWNlQjVjM25NLzRjMkp2SVlDQ1lBSXZNTUFWYS9XeVphRzc1SUVwb09u?=
 =?utf-8?B?UHJ0MDhTZVlHbEF3Q3E0WDdBd2djZXVsZENsNWpqcGs0eEV1ZnpzNHZTdGdx?=
 =?utf-8?B?b1BMNGtWamh5alZDVnVsQzB5dnYxcHpBenpXSi9lcUlIcnZCOFYyRGNTYVFW?=
 =?utf-8?B?Q1FwcEVGSlhFWjF0VHNkWmU5RnVVYjIxUytzVHV1VGw2TFFTbFl5eCt3cTVT?=
 =?utf-8?B?ekxLNEZZUzhiVXZQWDVLZXBVSXFreGZTRmxQbmwxRWM5bjZRUng3UTVwMVZv?=
 =?utf-8?B?dUoySFFCRUM0bVozdjFlV3o1bEJ3dVFMNVhialRKenB1SDlsLzMvRUJTNUVZ?=
 =?utf-8?B?QWY0ZWZkeDBLZDJyR1RRenRSSlNMdE90M3lPeXMyQ0oxK2x6aGF0VEY3a3M1?=
 =?utf-8?B?U2ZDRjJ3dC9QeHV5alJwUUlXa01qVFczbTZNb0FkdlRZRExrQ3drRTNhMStB?=
 =?utf-8?B?dzVoU0paZktFd2M5WTRUQzZkV3p5NmRwVmE4UmtOUG5obEh6NFgzZmtFMTBa?=
 =?utf-8?B?RU9Bc3QwckRTTmlHSTRZUElDbVFiaG5Fb08yZnVReXdqN3Nnb0FYSkFIby9H?=
 =?utf-8?B?RWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a5a7b4-32ef-4a98-5c48-08dc375b6714
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 06:14:49.1735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jetsw9LEd9mqEaeS0IO2yVDJrEuANDvpQ3UEKv+hQnySLGkol/H33NPdk6DhdkZNAk+3WjgbkLoGZBR5WkrEdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7171
X-OriginatorOrg: intel.com



On 2/27/24 10:17, Barry Song wrote:
>> Like if we hit folio which is partially mapped to the range, don't split it but
>> just unmap the mapping part from the range. Let page reclaim decide whether
>> split the large folio or not (If it's not mapped to any other range,it will be
>> freed as whole large folio. If part of it still mapped to other range,page reclaim
>> can decide whether to split it or ignore it for current reclaim cycle).
> Yes, we can. but we still have to play the ptes check game to avoid adding
> folios multiple times to reclaim the list.
> 
> I don't see too much difference between splitting in madvise and splitting
> in vmscan.  as our real purpose is avoiding splitting entirely mapped
> large folios. for partial mapped large folios, if we split in madvise, then
> we don't need to play the game of skipping folios while iterating PTEs.
> if we don't split in madvise, we have to make sure the large folio is only
> added in reclaimed list one time by checking if PTEs belong to the
> previous added folio.

If the partial mapped large folio is unmapped from the range, the related PTE
become none. How could the folio be added to reclaimed list multiple times?


Regards
Yin, Fengwei


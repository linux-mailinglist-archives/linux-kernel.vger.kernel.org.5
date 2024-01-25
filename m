Return-Path: <linux-kernel+bounces-38977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D9383C943
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120CE1C2577D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44A6137C3E;
	Thu, 25 Jan 2024 16:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hJw3q3nc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9CA137C3D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 16:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201840; cv=fail; b=VDdHFoJxk4nREjSSVufeNBjiELKxy8CZ1Ihj0A3TPtHINOAQDYpaUFjns11DIDrhiALSwGVFqPSGN0NdSGZDWYI+FGczQGEi9EDrMOBzzOEH5Kl3QBZ0qNqDN0hZjjUhxNbP1rJqjONym8cuuwdu/ENVnAKBuv6VaOPFXTNopcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201840; c=relaxed/simple;
	bh=0X8oXN2aKbbexN5SnkMQc8fJ+YJ8a+zMLQxraPWIiqo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mXzZaDHEbFLXYwYgv5KzDYsmiRkkJJZq/U2OZffQdxNcxGln5vARfuXxOxe3col7SH+yukndqYpASzOxKpo43bCTgfYL7wc2GyAKFLQ+RL3NrvXlL28SkTmTPO658r0yJ3GBxysmQZVuqBd4OePCO0s2GKAcbtgfEEfApjUYOeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hJw3q3nc; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706201838; x=1737737838;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0X8oXN2aKbbexN5SnkMQc8fJ+YJ8a+zMLQxraPWIiqo=;
  b=hJw3q3nclMr7Zqj+WzY5iktkzvWDb6Ut+bR3vDtMLtmcnDiCS/C76LMd
   ip7+DnYd/ouQvVMYkforyHu9wG7nQIxD6zc+HDju7L2XiCFuXqaFNZfc6
   LaSf4lvwJBiFZ8OFeB8wkYRjZYTbDY15ZZYbVeFHi5Caiiqj3+3mr79xA
   gBJUux+x3sjaKZAteXOx7fKY98miuva95oA+f7yWN/EcbHkGpC7wMeRFl
   /QVQKloQt7p7ARSS3PPUs5n43OAmuCd9bmHnWUr+4RU7OZJF8pJ7rZn5U
   ZtJyqI34VPFE/PB4ROyZzK3y2cRZWeNsttwoYThtOpGdHG4tvacGPLDf4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="23682171"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="23682171"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 08:57:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2307104"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jan 2024 08:57:17 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 08:57:15 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Jan 2024 08:57:15 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Jan 2024 08:57:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmPtSh8FyttIzbQbB0gVwuzPauT1uLSG7A9w5xOk/zFpcyDmhLpR1/Zsx7jJehIS0RXZ451LBg7DhbiOrv/OGok0UrYEI+hm12MggoVjBOcQ0SFM3StL10XyQ7nWUbBjUq8gPcqreOvNpeW5xjHHZuJ4KoM6AZjtAT7jScHezSjSF8QmsGYsKlRl/eVY+3Fya3U8yG3huNSm88n4YuL6ribdXj9NJNSOZ7Ptos13S91UYrOJj+UnoTISMaYZczqBCi3WwlrsJLP4iq2kbGJY2eVadxOh9GSbSrHddLNdzo7JSYKjubgPaDQ6uOsuoW0pz0NWpp8jV+2q9iH0cS8KHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5mp8IaNJPHWnfcq1LtR9IkBqHWXnE++xnZk5ikvB4P4=;
 b=JXHiCAqsEvUA4x44djmQwKQX+5zFWC3NAG8C9k/UEg9535I7EIMM81InwZh9o0hqzAgZjw+sVZHbFM3m+HmYso05cHBUAnLkFL+MRV28myAXDgl0GKS9VaYV4KpbvwL0AVUwSE5B8Ae6rQ91NLpHteUrdbjHZWmimtX7t228KhdBDBGHPQN17RKu7Bt5ioZVrbm4eBhteq/7GvZB7/2GumlHcxnTREZ0+oZL9iIxUp5lN1Gbi9SLH+9Tf/7Ax0Zb9G0MOnd7XL1G1EikdgB2TRtKgh7ZnzXapQVcTcskLGfOqK10qgxKq8cTdG6EZOcOz52FjiBtkwJyqy84x19/lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB5375.namprd11.prod.outlook.com (2603:10b6:5:396::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Thu, 25 Jan
 2024 16:57:11 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7202.034; Thu, 25 Jan 2024
 16:57:11 +0000
Message-ID: <f441b3d1-e8f3-4cae-b4c1-d7829d4d52c5@intel.com>
Date: Thu, 25 Jan 2024 08:57:08 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] x86/resctrl: Display the number of available CLOSIDs
Content-Language: en-US
To: Haifeng Xu <haifeng.xu@shopee.com>
CC: <fenghua.yu@intel.com>, <babu.moger@amd.com>, <peternewman@google.com>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240123092024.1271882-1-haifeng.xu@shopee.com>
 <6fb89a6b-031c-451e-80f7-58c277eda265@intel.com>
 <7e30ea7b-60ac-4c9e-b676-f354e9228ad1@shopee.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <7e30ea7b-60ac-4c9e-b676-f354e9228ad1@shopee.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0002.namprd06.prod.outlook.com
 (2603:10b6:303:2a::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB5375:EE_
X-MS-Office365-Filtering-Correlation-Id: c6dbcd0b-754c-4735-6e83-08dc1dc6ac21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jDrdz8YhCAx6bbEnL1QrbYBvcxLtgngLtex+kMIVdAvNuQ5YeTPSki7dnYKKb0pm7bBUqUDjJ6aS4v6EiAZd0JzmEg7eneM5Ff9iixVJLckliRVDw8WW2NFKH6Cg2Zz5CgnaofDQUofmmV6OZ9NG9FtsmcP4W7Af0/UK3UxdK7hSuL1fuS3mJkLeKxQXbVQy7uugeSC2FbcEZGto5FJEjNpcCBXct384iZ0NA/6BSezloaST7vlHoD/hTomQ4efC2GKvsfCR/0+Jfeg/PXky3KAmTbAheCXT/dM3KunSiSRS1CQZMXmMVB6i/z++cCY24BaJ++QSLrW/KdEz6iTLrgLGMWKPTOFxHY4tf6mA1GGAgWE8J9gtajGN3quZ5dCxNSecgqBN7fuB5RImhL+SwHTNXFPHHDpV8aFpkByxjRvdr0hhknXG/qz8ESnKFROQRWT+wQCLYVIWekVBGW/huHGdfKe1R+X98GOKrmWi08p3QMCAozRjzwDSLWQQLplCeHoDYAVUt6yWK12E7SibfNoxiH6mjUl6KEWI6FdpRAyGhODEEqf2w3zz0TEg14QToy/iDtko73XU7W4Pa+S2kTvH6b9kidqAyG5V0XtKWSAXtSfuutfd/+d57dogK3S3pbaJM4tPNGwOR5o8O/7h4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(346002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(966005)(38100700002)(2906002)(41300700001)(36756003)(31696002)(86362001)(82960400001)(66476007)(6916009)(316002)(66946007)(6506007)(53546011)(66556008)(6512007)(478600001)(6486002)(4326008)(6666004)(83380400001)(5660300002)(44832011)(8676002)(2616005)(8936002)(26005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUZBNXVTRnlwYzM0U1Z1dGlTbVNOM0pQN0xxWWJYZXNUWFpJOWV0Rnh6aGMz?=
 =?utf-8?B?ZW9jR3JaOW16WHBnS0wrRzRRNEQ3VDRVdUxnbmtZNFlyeE0rZEhpYkNxbVR4?=
 =?utf-8?B?WWNYTGo5eWVvYklyV0R3QWpISXExQjBrQUttOWw3Z3pFejkwbUwwM0xMQk1Q?=
 =?utf-8?B?T1RKRGNQQ2lteGVTUTJPbDZ0cW5HbCtJVWpTU1ZGSUN3MWljYUhpa3ljN1I5?=
 =?utf-8?B?ZExtY2w3RjR5TFUyL0pyb1FNaHljNVlQVUVvNUJBNjBOelRGTWtqdUpkWmpa?=
 =?utf-8?B?OWF6bXk5ZkpEeGJrbkVXV0lqQnRhNlNmVnoxNS9hQ01HWDF5UGtQTHBRZ0dU?=
 =?utf-8?B?SmM3T3ZUUmI3aGgwb0toV1NoNVdpM3RULzdrM0FuWTZxNHFYL1RGM1JHQkRr?=
 =?utf-8?B?MWk1bmJqOHJjMVZpc01HVllSZEFXajBPTm5YTFBvMXppUkhST2l3RVRhQ0tM?=
 =?utf-8?B?VXpvNlVPeG9hR2xrM0I1R2xYQzdNVHA1SHB4OU9jTkxURHpROHpuS2k2eTV5?=
 =?utf-8?B?TkhLeWkxZXZEVFBtL3YwL09aYlBEL0RNN0xoeWtPWmtlRHhuN0ZVeW1LVFpJ?=
 =?utf-8?B?VURkbVJIbzdoU3Z0VGkzdmJiaWw0SXpuc0tEWk1IQ0t0SlJMMVBCZ3MycEJE?=
 =?utf-8?B?TkpwT05wV0VTUERjMXZ1aFpHNEpGMWFDb21zNXE4WkE4UlVGUzczWUg2YURj?=
 =?utf-8?B?dFp0Wkx6TWpZTnpvVXk1R3d3K29qTFJxYXVEYlZ1SjBPbzVMcW1JR1JXb3J4?=
 =?utf-8?B?dmRPOXNTbjlGdG1zbXZCU05MRG43L25pVVYvL3lHSkxhRjkyaEVRY1BCK2h0?=
 =?utf-8?B?enY4THNHbys5Rm5aekIvKzUwQUVJekJzUHZYNHdvWkh3c05SVkdLUEE0d1Fz?=
 =?utf-8?B?SzlQbm40SzFsWEpuNENzRHRla2dOYitMY0VIa2RFZytFcE8vNkpNanFEeUxQ?=
 =?utf-8?B?R0dwRlplZU5SWXcyN3NOTi8rQ0RsV3hCRCtMd1BkTFpocGZna0p5ZTVGY3c3?=
 =?utf-8?B?ZDl3cmtPUVNUQUd4TlhQbnRqYXhKb1c1UzRwYmpKMlhra1BCSVVlS1pnT0Nm?=
 =?utf-8?B?blhadzBnbUMrUENSd2ExbjdFWWViNmRMdjhkUkRFSEtMdUJNUC81SFNLZzNl?=
 =?utf-8?B?elNpZU9JbHl6b29KdFovd2M5R1hOS2RJS00vUklaRCtXcFFlamViQnEzQjJF?=
 =?utf-8?B?LzhZS1U3bE9KMldpMkVUR0dsWmxWQ2RLdGdCM1d4SkJPU1NZcThSYjFaRzk1?=
 =?utf-8?B?NldFeVI2VzNPWEdJMFJoSFdCVjVraDEwY0k0RjcwZkNkK2lCQTZTNm1jZVFF?=
 =?utf-8?B?bktZNlhxc2J4OHEvcFhKdUlRT1I0U2FmcUVqeENYYWZsTG4rWXdrYmtUVWdr?=
 =?utf-8?B?aFd5aG1RSEt2REpRbE9RRXIzOVU0SnhIenB2bDE3bXc1cFljSHczMEs3aE9R?=
 =?utf-8?B?bGZnb2pMcFNxRGlSQlBmQjByWXlYOUpWUjk3c2NaUGN1YkJkRWMvRmxSempi?=
 =?utf-8?B?R2gwU1NEY0dTb2pCS1lrTjVnWDRYNmZUcks2MHVFcXJMOVZhdXNJVGVYWmw5?=
 =?utf-8?B?S3hTOUZmS295dnd0REdKWFM2czJOMnRZelcycDF0R2NmeVJvN3k1clNLbEty?=
 =?utf-8?B?QVdXK0p2eVhZV3gwMWp3NE5GRlJFSjRSY0EybU5QT1pkdVNsMjlhK3A5NnpB?=
 =?utf-8?B?YWR6dkFTZVJsdnJRd09DYW5nZWRQZHJ6UXJaQWsxUFh2a3hUUmJYUDVCUzdn?=
 =?utf-8?B?Q0UxM3RqY09hdm85N0NyQzcrWmdnR1gxQWR4T2ZRRzA3aHliS2VqRXZDcUVT?=
 =?utf-8?B?N0NCdUpQS0szRmVtazQ3QzZiRWVqbU5vZXBqY3kzUG43NnFoa1FlSnZuK0o2?=
 =?utf-8?B?K2EzYnZXMUZQYlpnbFdlOHJaZ0JNcWk2N3JBZXdiL3NFQUx2bnRheDQrYVZG?=
 =?utf-8?B?cXpOSi8vOXIyTEZWSGlYeTJ5MEg0czNnQkwvdUp1OXdLZWRMMkRVTWtUbWxH?=
 =?utf-8?B?YkpxM25QaW94NFRwVWp5VmtKR1lEaE41ajFJeERPZS8vSXpLZ0ZyMDkvcTRW?=
 =?utf-8?B?TTVDK2xJUjZXN0NvLzhqYUxnYS83cEVWOExrTzdVd2FkVDh0R3IxeFZ0V1Iz?=
 =?utf-8?B?Sk43N0thTjBYSmRJZlUybXZKSGhrMGl4VU0xZUdwM1QzVWlEM1o3MWg1bU9o?=
 =?utf-8?B?OVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c6dbcd0b-754c-4735-6e83-08dc1dc6ac21
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 16:57:10.9569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E/Q4eNmdQQme+jcAK5YrKvKgiZLeLBbSx2YQATN48r5ghc7YsS/6/vVVu7sSmUiHorSQ6w6yREprqMbvknMzP7qjVX5wPCFKX6S3NBa7uy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5375
X-OriginatorOrg: intel.com

Hi Haifeng,

On 1/24/2024 11:44 PM, Haifeng Xu wrote:
> On 2024/1/25 06:23, Reinette Chatre wrote:
>> On 1/23/2024 1:20 AM, Haifeng Xu wrote:
>>> We can know the number of CLOSIDs for each rdt resource, for example:
>>>
>>> cat /sys/fs/resctrl/info/L3/num_closids
>>> cat /sys/fs/resctrl/info/MB/num_closids
>>> ...
>>>
>>> The number of available CLOSIDs is the minimal value of them. When users
>>> try to create new control groups, to avoid running out of CLOSIDs, they
>>> have to traverse /sys/fs/resctrl/ and count the number of directories.
>>>
>>> To make things more easier, add a RFTYPE_TOP_INFO file 'free_closids'
>>> that tells users how many free closids are left.
>>
>> I do not see this as a change that benefits the kernel or user space.
>> It sounds to me as though user space is planning some behavior based
>> on what it knows about the current kernel internals and requesting
>> more information to peek into these internals to make it easier
>> to do so. The kernel can always choose to do things different
>> internally, but it is required to maintain a consistent interface to
>> user space. We should thus always take great care with new interfaces.
>>
>> From what I can tell user space intends to use this "free_closids"
>> to mean "how many more control resource groups can be created". This
>> is not a contract that I think we should enter into. There has been
>> discussions aiming to disconnect the number of resource groups
>> from the number of closids (effectively letting resource groups
>> with the same resource allocations share a closid). 
> 
> Is this feature merged into latest kernel or just discussions?
> Could you please provide more details?
> Last time, you mentioned that a monitoring group can be moved
> from one control group to another.

It was the original proposal that started a discussion [1]. The discussion
about the problem needing solved instead led to the feature where a monitoring
group can be moved from one control group to another. This solution only works
for AMD and Intel though.

> This is something
>> that the kernel may still do at some point but sharing "free_closids"
>> knowing that user space intends to use it as a "number of resource groups
>> remaining" counter would make future enhancements like this difficult.
> 
> OK, thanks.
> 
>>
>> Could you please provide more detail in why this is required? User
>> space should not need to keep track to know how many groups can be
>> created, creating a new group will fail with ENOSPC if no more
>> groups can be created.
>>
> 
> User space reports alerts when failing to create new groups. If no one tell them that
> closids aren't enough, they will keep trying to create new groups and the number of alerts
> could be very high.

When user space receives the "no space available" it should be expected that
any more attempts to create new groups will also fail (until a resource group is
removed). It is futile for user space to keep trying in this scenario.

> 
> So we want to know how many closids are available, if it's zero, we give up creating
> new control groups and those alerts will disappear.
> 
> Maybe user behavoirs can be ajusted. There is no need to create too many groups, especially
> for those groups with same resource. Or as you mentioned above, we can reuse closid.

Reinette

[1] https://lore.kernel.org/lkml/CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com/


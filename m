Return-Path: <linux-kernel+bounces-48335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67043845A8D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A1EE1C27F40
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13025F48F;
	Thu,  1 Feb 2024 14:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WV5rLOym"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADF85D497
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 14:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706798884; cv=fail; b=bUOMJvKgqYRJ7YAZnNLkv0WF2TZo7tA2zvrdtJv2hIhGkqO9h5DHqFwKS0EXwPn6IMlNqQzlNkZv5Pgt53RYdGo6vd6EO4eZB5DkMX4VODhJnWJFlMmcUJPvyUyqLJS3kAj+IFHgGHJL9qfIGzWMZfBGl+DrQCUhCsGpip9oZmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706798884; c=relaxed/simple;
	bh=q8E7otBrwFFlkyZyJ/Xc1PLqFifrddl8+O7qm2eNaYg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UdS1FwaJD10BM7LRGcu4T3GseZQnwNmzeB4+hJyY/CkKRQ0B8Mwd2a52iQGaMI5wvm4mwV3fnMW5Wb5pRzXWnuXhpbc48yXX6YapxUsZ8F/UrGMzZB2QnVqRlZVCt6DNJo+vy/ORxS/cFTOtWyBuMlHm6Qhw8Jv+3hHV6CtrJEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WV5rLOym; arc=fail smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706798883; x=1738334883;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q8E7otBrwFFlkyZyJ/Xc1PLqFifrddl8+O7qm2eNaYg=;
  b=WV5rLOymq0I+FWr2wvAn38wcZc/RSO5dDwA7IwXymKNvq/Z0ukNM/paq
   Cxrj3MwL8PJMbE5dZyqMX2wUjraaarZQXePbwS7GYVRJkn1FcE/nDiwnp
   KC9t7puVfrzNIaU8fQBqtUNsn/PBIxaQSUKoAxGcGP1M4yWoUFwXm4uns
   1pDNCtnbVAyFpYmimJbRG9dtSb6BOe5P6KlCHnZN2kwdg7fwI4IbHy0at
   gCIgY1VvTUpeSxxnz74dvMjSJ/a6I+siaJL4Dn2n0d2qCZRPzXxbxh1LB
   rW4atTNtZJyAVWuPDy6LWH6qYX1Sbdho08L2qpl58SmoByuhII6upv/Uq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="407626694"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="407626694"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:48:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="4395044"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Feb 2024 06:48:02 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 06:48:01 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 06:48:00 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 1 Feb 2024 06:48:00 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 1 Feb 2024 06:48:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Crh3sN0NALlrrEDi5KtU2Wa6YY62vtxz+u9/XesqCE0kkOsIi7G3ko5A4ML5As+hah/cMnRcMqFpr/Lrpd6rY5itDb4T5/use8xjvkOnVoklrfY+/ObPNB5DJMW75qXgR7VUyxX7av9B+IJzY7TfN8PQRoIHMjQdZwvHEp+BIC4eefuf/dqr2aY6jVKADWobAaG7zmhwOlWIjVBmcVpHLrigrMGgASVD3IiYcOlQLFoph0CLPQdBMZKfnLgFJdPPXinRr1QuuUfBXwvHSFMI5OFZ0PjdC3e5egnxyDwWEh8Jb6C5OtV+HYg21ZMKIARG3mD49ij3hxFHunPKlmm6jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CdpIEvABZrxet0IoTHfQ/Mtf18jr1SPXbVy8iDh0yik=;
 b=df2N6ptyMonvkUMBMXWSHWYLS9bbPyagkOBAaZZQ22zHaVYhJo7Me8ltc7wTTaUacysj5Wey4zy/RJzpy5rAok5mYEg2Ss/rPHmF6VEfFCIF+33nmNUyKcLR3Hp2MmuaTRh0+zSUCf49ZMLI41lAZ33Lr94PDsYp/aTFXmE5ERuMsguyFeEzhLNt4sI2o15xKElqB7XdCl3EUtzwnkqNbz3/SsFnoW5Qq+U7BqNATwn5JS9T8jtv9nfWFyUziXwEHTBISBBuycGQwuFc6bln9RvwyxRjINMlRRrS0S2J+Pt/If2GppQ57K7E5wAwDfhfzFa5nkJV/LsVsW+qA5Ndqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM8PR11MB5607.namprd11.prod.outlook.com (2603:10b6:8:28::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Thu, 1 Feb
 2024 14:47:55 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ff69:9925:693:c5ab]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ff69:9925:693:c5ab%6]) with mapi id 15.20.7249.024; Thu, 1 Feb 2024
 14:47:55 +0000
Message-ID: <d9ee41dc-c2f5-4c5f-9b07-126c14bfc798@intel.com>
Date: Thu, 1 Feb 2024 22:47:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] x86/kexec(): Reset TDX private memory on platforms
 with TDX erratum
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC: Dave Hansen <dave.hansen@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <tglx@linutronix.de>, <bp@alien8.de>, <mingo@redhat.com>,
	<hpa@zytor.com>, <luto@kernel.org>, <peterz@infradead.org>,
	<thomas.lendacky@amd.com>, <chao.gao@intel.com>, <bhe@redhat.com>,
	<nik.borisov@suse.com>, <pbonzini@redhat.com>
References: <cover.1706698706.git.kai.huang@intel.com>
 <b52ed259e0d487b3a968b98da91cb4f55a28ae82.1706698706.git.kai.huang@intel.com>
 <12a927df-e437-40ff-ba4d-ceca5446c5b1@intel.com>
 <l3uo3n3li27czehll2wz34xxkcv5j2vcshgp5a6w7u4h4aidpu@4oe2cwye2e6z>
 <0c990c7d-4df9-45c1-8c03-980d9842b963@intel.com>
 <ixp6wj4763kc5vgpmipyrijddwnxblhdn2v7hio7ze756w5f2x@6uyc7hwtrbbn>
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <ixp6wj4763kc5vgpmipyrijddwnxblhdn2v7hio7ze756w5f2x@6uyc7hwtrbbn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0215.apcprd04.prod.outlook.com
 (2603:1096:4:187::14) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|DM8PR11MB5607:EE_
X-MS-Office365-Filtering-Correlation-Id: e743b15b-042d-42c3-d42f-08dc2334c62c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QAe0w1nZPbwo7m/kVPjdzCMkKnoMJPaMyxaO3cq0wAa8jzemGn3qf5slz5t1dVMyQ4UPXUVEDIEWVl+/zBEQoxmsFTvT3Mu/Pca2pUzGwhSjdl8e7tbLnIduq+u7PuEtpEO2Cdm3E+Us/ejHKAbBg06lxz8C8r+1xdYOI3eDiVoCbs0Am/ujFigfDYi76eGm3i8lzyAJM4xOp5GMPNo/8jClF3u++MpNhagVQEY0/EbjqyN76x5rNg5DjM+dm1zyTOR2VOhrh9w6S1x0sjdnp3AXaMAYp7zFmJjpaKPMPMpay+bry+de95UfoJ9xE4Me87Ms9LdI7tuARZ+15guZMlB508/9s84pj1q6AG+/nXxg88KCqczLVWwsDL48NtrP2Ech12u3Sby4fTsPP8BVFzrr0QKyypqmb2Rg+wEdX4JtDbBV1QBZTZggxz7uP6BAAZChjtLS5R1NM8j+6ZQUbtzKCx34fgSkoUtwOUfODmi5dro6BfwkZg/Gu1P+HJBIkyDOBp8bFuKvPRzTExnMfUNxARXBHLILZHbbBqwknivj6UN5gQkpeJKdeCgbC652njgTrQsfFYNyi7h10of9BwCo/EWbmxRiwxi7va37jUEV1L75/mMDtyHTQKHehY7lDWP1Ssx9NMv3MD1HP+4eeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(136003)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(26005)(2616005)(41300700001)(478600001)(53546011)(6486002)(6506007)(83380400001)(6666004)(66899024)(8676002)(6512007)(4326008)(8936002)(36756003)(316002)(66476007)(6916009)(66556008)(66946007)(82960400001)(2906002)(31686004)(7416002)(5660300002)(38100700002)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUVrWUxRdG9nRFB3U2dId0duZGZvZ1V3RHl1YzUzdUZvVkdNV3g1RnNYSGxZ?=
 =?utf-8?B?TlBRN2Q1UlU1ZEdkcXVqSVJIQVhyamU2b2lJQlNSdUtlL2pyUFlkdFhFOXBS?=
 =?utf-8?B?bjJXQkRqNjYwSXVmOE9TcTlaSG81MXk1UjBzZkp5Yk5TT3NPZWZHSzRMWG9M?=
 =?utf-8?B?NVJWQWhLYmlkRjFTSS9KVFFUL1hQV0V5RjFqZDk2M2hjMkdOOE1PZGwwMXB6?=
 =?utf-8?B?d3NIMlRSUXhHMWU4R05OSm5GSnp1TkJYVnNFR3hrOE1xamtHWjd6TXhyeDg4?=
 =?utf-8?B?N3ltenU3SStyVWtiaVlidCtTeHM4c3FLSUZZcEdVRERoajlZTWp1aTNDY01T?=
 =?utf-8?B?VkFrdTRhU1djTjRZdmk0Mm9TbkhaQkNFVTBnQkxTM3piRlRTWDlEZU1uVS9P?=
 =?utf-8?B?Y3UxakhJTStoRFcrdCtlYWdqQjdxQ0lTNlJyeVlOdkFabERrRHY1bEdqZzFH?=
 =?utf-8?B?N0ZpcDJrbUMxRHVNUGhvaEJ5UU9qTWI4SmxxSHNsUkNvR2haZzZ6SDRpU1Yr?=
 =?utf-8?B?ME5DdUZJMW9aR2FyVHVFZlZmbFA5cG5vVVo2U1RMVEJuR1kvQThRa28zdDFO?=
 =?utf-8?B?YkV4UkxYK0VIUDhMY0RMdnM3cklUdVBDR1kwNHJpdklIR3ppSFU5RlkvTEZX?=
 =?utf-8?B?QnI5YXBUeS9sV21xVCszaUdyVUVNZjVMWmRIZ0xzTGJHY0VkSThZdVU0UzBT?=
 =?utf-8?B?MzhCVUgrZW1XOEtsc20wWVp2dm5ueHdvRS93RGZTWUJZa2pvR2k5cU1YZWs0?=
 =?utf-8?B?RWJjSjF3OXZ2K1hsZWluNWltSGtjWnNhR3F0T0NHakFYK0NGUTZCY2VKZUor?=
 =?utf-8?B?cUMySEZ2b1VDMDk1Wi9xQk9GZGpLSklncUNldmhhTGRuOEp5VUUxbTZ0M1pT?=
 =?utf-8?B?OU1DZ1hqQVJRNEVIbU11YWUxYXp2SHpLUXA5aWM4Y2pLallwWGpENkcreXMr?=
 =?utf-8?B?czFFRGtBa1lHU2pJdnh4NzR3YXdCa3dYbWZERWtKREZpdW5BTHh5bmtHOE9K?=
 =?utf-8?B?dGNPV2lFVkwya3JkSmVCYXA2QWFzSUNVTHhMNUw2R0ZpaXg5Q1RBbnNnTjB5?=
 =?utf-8?B?bnV2NWFvNFNiM29YS2p2L3BTSmc3YS9qbHZsVlhLYTJJaGJRQTJQWDJiRDhw?=
 =?utf-8?B?S2RncFZ4Z1dzWHNXKzVSdDFJZ0hoeWFVMnZZM0lsdUg5QkwxL0tvOGtXTWhY?=
 =?utf-8?B?QWc1WDNzWWk0UHNWbUl6SkxiR2VjWDU5MVl3d1p2MGJoN1h4Z29Ib1BPSHBv?=
 =?utf-8?B?ZnNpS0FqakZETFVBUHlDd0JrZ3B0YXBWbUtOWnlHT1NtdGExUFpxRUtHVnho?=
 =?utf-8?B?R1J2akFZOXlsZnFZcjZGRC8zdDlBL3VuTTlVRStCWEpjSVYweHN1YzdJaVpm?=
 =?utf-8?B?ZkpLb05Gd2xXUnVRczBrSzFrYXpGK2RaODVmK1drenpFNjFEek1UaHpsUHdM?=
 =?utf-8?B?K1ZtQUZrU3Z0RUtKUm05aXY0YVd2WnN6SUZvZkhYVzlzSFB2c2xyaFA3OHpy?=
 =?utf-8?B?R2xuVTU4QVBOL1dxMW5jZGplSDVJQmdYU3RPRXZsVSs1eDFWeFZCWDMrWXZu?=
 =?utf-8?B?YmdNTXhaRGV1Kzg5aWhWUkt1K3BmdzdMSlBrNmplVkJwYW1aSGpCU2JXTWFo?=
 =?utf-8?B?dlBYbEJ1ZHFtQUlyUkU1WUJ0R1FIZVV2cC9pOVRhc2NDZm5xUnU5ZTdvVWdo?=
 =?utf-8?B?dGFMcHNLS0VqTWN4SXJsb1U1Sk1wdStzU1k1YkhNMlNMV3BreEVSK284R2hW?=
 =?utf-8?B?NGJmZVVvMzAyQ0dLa1RpM2puU1dvKy80dkFqU0dYeGF6cndXVDRPbldaYmJC?=
 =?utf-8?B?Z2dBUDVxbXpmem9Zc2NCcnFkZnNvOEYvNmNBUVpFSmJBeklLY2EvYm5xN0tL?=
 =?utf-8?B?VllobXNibjR5MURWOWxsM200VStBM21yQ0FPYnVSUnNXeFBhQ2tNVzBYWnRX?=
 =?utf-8?B?VHkzdG5sQ1EvUDJRVGRydHdONStwQis5WEtLUnpMRitMQUJBaitHMHlwT3Bl?=
 =?utf-8?B?a0RNbHowNStJVElCZ3BWYlVZeXNxRDNvMnhXWlIwVjRHZVZGLzFrQlAwNWFk?=
 =?utf-8?B?azNUbmp6OGpkazNSWjQvbFlCeTV6Z25qenEwanhONTVGUVM3MlU4dU1PSDhI?=
 =?utf-8?Q?Fzwja2f8vwDLogQw0ADj2DUYO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e743b15b-042d-42c3-d42f-08dc2334c62c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 14:47:55.3737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYPiM/S8uSgYIXk8W67CXgYsGk9sk2/w/L0L3iyzCOJ950owy8e+kfzsn8SqIxFqxIgMfinpE1AHgYCUBDU6iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5607
X-OriginatorOrg: intel.com



On 1/02/2024 10:39 pm, Kirill A. Shutemov wrote:
> On Thu, Feb 01, 2024 at 10:22:18PM +0800, Huang, Kai wrote:
>>
>>
>> On 1/02/2024 6:03 am, Kirill A. Shutemov wrote:
>>> On Wed, Jan 31, 2024 at 01:21:39PM -0800, Dave Hansen wrote:
>>>>>    #ifdef CONFIG_KEXEC_JUMP
>>>>>    	if (image->preserve_context)
>>>>>    		save_processor_state();
>>>>> +	else
>>>>> +		tdx_reset_memory();
>>>>> +#else
>>>>> +	tdx_reset_memory();
>>>>>    #endif
>>>>
>>>> Wow, that's awfully hard to read.  I really wish folks' gag reflex would
>>>> kick in when they see stuff like this to get them to spend an additional
>>>> 15 seconds to turn this into:
>>>>
>>>> 	if (IS_ENABLED(CONFIG_KEXEC_JUMP) && image->preserve_context)
>>>> 		save_processor_state();
>>>> 	else
>>>> 		tdx_reset_memory();
>>>
>>> save_processor_state() is declared under CONFIG_PM_SLEEP, so I guess your
>>> variant might break build in some cases without updated suspend.h.
>>
>> I tried.  If I turn off both SUSPEND and HIBERNATION in the Kconfig I got
>> build error：
>>
>> arch/x86/kernel/machine_kexec_64.c:325:17: error: implicit declaration of
>> function ‘save_processor_state’ [-Werror=implicit-function-declaration]
>>    325 |                 save_processor_state();
>>        |                 ^~~~~~~~~~~~~~~~~~~~
> 
> Moving save_processor_state() declaration outside all defines would do the
> trick.
> 
> Something like the patch below.
> 
> But finding the right spot for the move can be tricky. I don't particular
> like where I moved it.
> 

I don't feel I have enough justification to do such change.

As I replied in another email, how about:

#ifdef CONFIG_KEXEC_JUMP
     if (image->preserve_context)
         save_processor_state();
     else
#endif
     tdx_reset_memory();

Not ideal, but looks slightly better?

But I'll leave to Dave to comment.


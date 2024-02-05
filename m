Return-Path: <linux-kernel+bounces-52220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C933E849592
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEB79B2456A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416F0125AD;
	Mon,  5 Feb 2024 08:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JhL/Icsj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EEF125A4
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 08:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707122440; cv=fail; b=Eq87Cj06nMUQKHAEXHgmB5bhscodLDBiXcYLySNLHl69MLSzy1mo9NpX5bklNfg0mQFUF8uHw2A2jtj0j7tvNoa49ouxyc/2/FgYakLSCSif9uKQ/CBrn0GfXBQcY6uX7LkqYgolYzZSEiiVHSxl4ycMzeuN+tJx/4Ns35JVP4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707122440; c=relaxed/simple;
	bh=ERXOABV27wEIRZD1aIdUBNuhGKhAUzN3ii/AaDe0AJ0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LByzCXPU48WQi0nnJbQb63FTNDCc9Hd+MmxJgqlFuT41efLyRvzPUyvjSW/kxRQQe7EeyFsr/t1bZ3z+1zEcpvyPRTOEAXFzp51sFbiixdg2prdAqf5WdpAEZVt5gbm6j1AQB075voIlJQh/t3Xsy7gwPSvyBVNnQr5ctUUKjZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JhL/Icsj; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707122438; x=1738658438;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ERXOABV27wEIRZD1aIdUBNuhGKhAUzN3ii/AaDe0AJ0=;
  b=JhL/IcsjXvKrVMSxgKQ96uVmA/ScOGi+au/d6kOyMl8ZMYqi56d4/kQ3
   8h7lz5G8VkEikj4sHxO8qYnmpSDHnUPzPMmKlofYIBM3FHSfDl+mX8ONw
   8JOiH0KnUSAu0BsDyW2ZrSj0rwD60PtCMY6DmqkKbmNvdcXoad8CtSfvH
   AHbENzV2hNQv97b2DkpLqLrawQT63vbyzX4U+oX9iR/Hr2ydHxsbvZ5JB
   N7px7b95juZ4ozczgtAe3xV2c+uxYECGKJ6aZ2wNscn8pbpv+Sstb1168
   SgjYf/LRC6frt5uUawmTRIjlZYlQYIxmI9hm8Qtx0SBEe8DnE9AAJ35Rh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="11569732"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="11569732"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 00:40:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="657541"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2024 00:40:37 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 00:40:36 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 00:40:36 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 Feb 2024 00:40:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/w0koRdBzdIMwGZ9Ngo5XCsMa0Gb02TSaHpx9vxF842V7eKkOqaphe/ae8MTWVmfkZMp0iCZz3ntaozQ6b2AMWZe/H4m5uiX3xvBJhXTBMnxLfOlHSVrCju1VdGBrEl4qiOgDyavim2w9ssXnRpB2VXPL7r2zXFzjaO3LjPOq9INrghDwkunEB0rnUVW1Pq3vw0TuqKfXpXv1GoyR22PE7+JJ6NoD/FjuLYZt+aEENhgtAvww1Vmq6Uo0IB2XKXqbKe/pzFEJfy7FCdNQh9c3c1WABCE2D67pBoC1k0oLZYFr0+dHPs3PIrJCo7Aw9OTsCStk8tJeTImUq9pLVuSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DpXTXI7OrymtECuLxZA2c+pygWNMpTk1V17X3kSqP/g=;
 b=i80X5INsSKxo1n1VApaNpa8twIEZGpdM3joP+R8veydaQqsGtwf6LnQIEKR3RRv+rwKAvmQrpEHmfV7Xm8Qbic0tvRefVzsCVDCXu3eXYAAKddHHZA7YZ+hSoYyGPoWyUL3mkYTMsjk/SAm+Sxn8nbv178xfPGFMoZxroT3GB2HKoXLr/cm6ZfgDQ/4YvUcvc8tE13ILOfVGrNt8sZC1gqQpzE1Sq1n6IDDcPkx3kW4uy7WLEhSOa6ZZXlb8RCYS/AbdtqLOfeVBWwDCiXWvbyAQxhfTmt6hZSNwohOzLZlyLWCDVtNfdWNpaqvYfvAlrAEVkRqCv52GFoT9a+Mphg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CO6PR11MB5569.namprd11.prod.outlook.com (2603:10b6:303:139::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.33; Mon, 5 Feb
 2024 08:40:34 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::4647:3802:133d:8fc]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::4647:3802:133d:8fc%6]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 08:40:34 +0000
Message-ID: <07e5ee4d-e0b7-4799-80a1-cccfbab2dd4d@intel.com>
Date: Mon, 5 Feb 2024 16:40:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] filemap: avoid unnecessary major faults in
 filemap_fault()
Content-Language: en-US
To: "zhangpeng (AS)" <zhangpeng362@huawei.com>, David Hildenbrand
	<david@redhat.com>, "Huang, Ying" <ying.huang@intel.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<akpm@linux-foundation.org>, <willy@infradead.org>,
	<aneesh.kumar@linux.ibm.com>, <shy828301@gmail.com>, <hughd@google.com>,
	<wangkefeng.wang@huawei.com>
References: <20240204093526.212636-1-zhangpeng362@huawei.com>
 <87zfwf39ha.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <85e03dd9-8bd7-d516-ebe4-84dd449a9fb2@huawei.com>
 <87mssf2yiv.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <25de8872-ad79-e5e6-054c-9ac5e7191416@huawei.com>
 <1a967b8d-7218-4d3f-9dd2-ae1c66f626c7@redhat.com>
 <e6eaac81-f957-0f03-0907-4448c7065b5a@huawei.com>
From: Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <e6eaac81-f957-0f03-0907-4448c7065b5a@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0082.apcprd02.prod.outlook.com
 (2603:1096:4:90::22) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CO6PR11MB5569:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bb5e78c-7a3a-4d60-f61f-08dc26261e50
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CVYCMF8/2jdTunlVjNKH7KNNhVrhtcNiA8rrPfIOp2KIXyo1iGUgWt0t7FcB5+1QPCuFMGVyOF1Ebdi3w3J34Xgstt4pml8PhlvMucBlnZ0dCACh8AmrOmnb/5cY48Ab7vaqbinopMxqaY4se2SeYwLlenzjg6Q/S0e1tqM3bhr9s68bqfoLXyoUCmneAZqxEHXXyI99dG+gfI5d/iQmM7JkX0DzMlHlMXC1n8DmCPuskuZi4dfNViJzv0xaUXbecjH7c50Ite1AbWk72IR/iLG362o1BMkH5v2T//b1x2/2WuGGEWlmddLYn5gq8Ih2AyR984eIg3pGGMYToE0zWYjJofp+sy17FuayZ6G95IsnP3bwywOHe42x0t4wzL0UITimKt1jfZKBzu5BaDMoE6bEOgrfOBxoaR0/05m7qIavQ/g9NSEkQtUDH87pmjlpBIvNYHeK7kFW0P+K3ffhh4mdZGQZWTce0b+5s7Vw2gCQe7bQb4M6JicXh0O+SdR0EbWrB+KYIBa5hYNg/lnZrf2pKRQJf8jM4LN4H4Ow6TSt+4khPAgi9CTmkv/hbE77+dDkG4seYq+bPgHiBa+dEMRGvJe8nQJ6X7fd5xzHaM0tbgfp3XmSx8Yh/jGrf/MycMwzYMTEhZoT2QSsHkdtQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(396003)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2616005)(26005)(41300700001)(31686004)(966005)(6486002)(36756003)(6512007)(478600001)(6666004)(83380400001)(6506007)(82960400001)(38100700002)(53546011)(6636002)(66556008)(4326008)(2906002)(5660300002)(110136005)(66946007)(66476007)(31696002)(86362001)(7416002)(316002)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVk5bkRjL1lyY3g0akhPSk1rcDFtdFV6RzBrVjltdWpuNHJTbDVRdzdEZGZO?=
 =?utf-8?B?OSttS2V0Z0ZBamU4QVkrZ0ZtZmU3ZTFOY1FXd0ZxZ3c0Vko0WHA3OVVqQ1Nn?=
 =?utf-8?B?ZkZwWTc1bldHbEMwVDFhS0F2ZHpVeDVlc0FLcGhqQWpQT21CeUV2RVc0b3NZ?=
 =?utf-8?B?WFBrcXh1aHQvK0hiaFpWSHRNMXhGTDNHaEdhZ3dPUElVZjFxQ1ZQUXdlUXEv?=
 =?utf-8?B?bWN2RHo0TXBFL0JRQjd0ZS82dEFVRk5BTnZaOC9FQ3Vld2NHemk0L3Joa2k5?=
 =?utf-8?B?dXJianBKM3N4TGx6UmRpaTcrRVJsTGtLa0ludVNsVFY1NFB2aW9KZ2RZM3Jy?=
 =?utf-8?B?allvSjUzVFJBWCt3Ry83V3F0S3BnVFZKS01ySFRvMmVxQVdvT01lNUljNHZs?=
 =?utf-8?B?cVAyZDZoZ1g0TmlOZWFLWlJKU3Eza2txUjc3T1hPMitpdDlIRTJqZmNyNjdw?=
 =?utf-8?B?U2wzaWhCSkRpQmdRMDRPNStOS1RyaDNFbHh1OUlnMnJqNXVDQmRHUUJBZmF0?=
 =?utf-8?B?bmptWldPRGp5U3IxOVhnREdvZU5lakcxVkVML0lZcElSYWVxSDBpRURqbVN4?=
 =?utf-8?B?RTdMbmplZjRyd09iSGN6cnJzTllicWZadUs2dUoxaVFyN3JrL3FyS2FwOEMx?=
 =?utf-8?B?Z0lJRjlVUm9QQmNGY1hHNDgrT1BuUTFOMG4vRHdmWjN6d0djY1NoMURPMzlx?=
 =?utf-8?B?b3FFYktMMExTTUY0eXA2SUpJNzNVbnN0QldBaDFaNFc3czFrejQwZEhVZXl3?=
 =?utf-8?B?ZDZGOHcrakJvRzY4MzVhR0RPdEdqSlc4blRjeEJPUXgwNFdnZEViODh2a0sx?=
 =?utf-8?B?dDg1bnVWU0FsZ0FqM0xicUdJUlNuZnhmTkdFV3hNRnRYdnpVeFA1S0ZWY0Na?=
 =?utf-8?B?MEVIbCsxUm9jQ0xPcytiZ1VaTElSVkxqbXRIeWNrQ2luUXowMFpWUjMzL2FG?=
 =?utf-8?B?YVZuQnA2MmkzQlp1ajF1S016RFVkbzhjWGFiNks1Mlo1OUdjdEJBM3FQMmFG?=
 =?utf-8?B?ZmJRV01YMmhzVVd3Q2xDcHlqWVBnNDVTdURrT0p4cStsQU9VTzNlMFNBYkVy?=
 =?utf-8?B?R1BudHp5T0dEbXBLRHFCRHgxQk96dzl2NXMxVXNJUnEyMTdRcEdRd3JPZDBk?=
 =?utf-8?B?Z3pLcHl4eEdja0F4TmRxeGdpbi80VEF4bVRYT2N3Qk4xTTUyOTRWM3FMd1NB?=
 =?utf-8?B?TmZmaEpBQVdtNkJxa2gvS2wwbE1la1RUTk92WG1VRnZESnNMTkdFYmlvWXBL?=
 =?utf-8?B?ZmpNS2NUUmk0WmFmQjd1NFFMMDdRbHBPckpHS3FIUTZkUGNTLzhTeU5KOGVv?=
 =?utf-8?B?WGJseHhISlBJRFZqMm5Nd2lzcjZacVhNTm1OSytRSjVnWTV3WGU5V3cwZGFP?=
 =?utf-8?B?S2tJU2tNdXlEKy9CY084VHRNM2hKaU5aSmg0Wi92ZVhpaEV5U0ZQNGwxLzVi?=
 =?utf-8?B?UGNKK1hhV2oyUVRjc0x2RHMwdngvWEh6TkpZSDNjaUU1MFA3QllKaFpKNklV?=
 =?utf-8?B?N1hucUtaK0dqK2xZWkFpVGo1dCtHTzFFOXQ3ZHBPb0VoWGJQUVNTWGZ0R3BC?=
 =?utf-8?B?R3BwY3ZGemRUTDU5VmtZV0RXSHRiM0poU01uUlBCN1RJYzA4TnNVbkMrbzVn?=
 =?utf-8?B?RDNGYmZLaXJXQzM5QUZWc25MNU1taFVkWHo5REE1ZDgzRVhCMm93b285UFNR?=
 =?utf-8?B?VjJhbHVRek10UUJDSVUyd1FZeFVrQm5wa2Y1Vll5Q0o5WlljSW9PMGhvTkJa?=
 =?utf-8?B?emsvcElVMjJUMEVrTm1HZ2Y3dW83dFFuZkpEdEFpWERFa3h6QTFHckVUYUll?=
 =?utf-8?B?bE9DUGNaMHZXSW8wVUI2T3c3aWNNbjFjSnFRU1pKYkFUMGFrSWwzWGQrSHZU?=
 =?utf-8?B?dVhoZW9mUEF5bzkzTGJCb093bmlGY201VW9ZdC9lc1I0V2dJNkZuUzJFVWR3?=
 =?utf-8?B?QllSQ3N5ZVpoWEdUZHJteU02R3RTRVh6V2NSa2pMVm9Wdk5XUGlSMmpHTmxQ?=
 =?utf-8?B?eldaZVJlLzZaMzJjQVlDS2xPSVJOd0lsSHZFTTRNbkMxQTl3eEpBY1FicE4r?=
 =?utf-8?B?c0hBQWlReXQ5eUpxaVJEVVppV1RFN2NYUHRhM3NnS2V1UUhVOXB3MkV1N2lI?=
 =?utf-8?B?TTgxMUNMZmZrVys0VnRLcjJibSsxYVduVlJmVzd4dmx5ZThadTQ1TUIxZGVE?=
 =?utf-8?B?TlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb5e78c-7a3a-4d60-f61f-08dc26261e50
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 08:40:34.2357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PUqVugpe6uHMDaligyT9qPQCjQvQiuQwuQz+f4L2NNUQSzEUuWvVc/EO/vWtJtuSbj/4cNWySk6iBDgecyTLGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5569
X-OriginatorOrg: intel.com



On 2/5/24 15:36, zhangpeng (AS) wrote:
> On 2024/2/5 15:31, David Hildenbrand wrote:
> 
>> On 05.02.24 08:24, zhangpeng (AS) wrote:
>>> On 2024/2/5 14:52, Huang, Ying wrote:
>>>
>>>> "zhangpeng (AS)" <zhangpeng362@huawei.com> writes:
>>>>> On 2024/2/5 10:56, Huang, Ying wrote:
>>>>>> Peng Zhang <zhangpeng362@huawei.com> writes:
>>>>>>> From: ZhangPeng <zhangpeng362@huawei.com>
>>>>>>>
>>>>>>> The major fault occurred when using mlockall(MCL_CURRENT | MCL_FUTURE)
>>>>>>> in application, which leading to an unexpected performance issue[1].
>>>>>>>
>>>>>>> This caused by temporarily cleared PTE during a read/modify/write update
>>>>>>> of the PTE, eg, do_numa_page()/change_pte_range().
>>>>>>>
>>>>>>> For the data segment of the user-mode program, the global variable area
>>>>>>> is a private mapping. After the pagecache is loaded, the private anonymous
>>>>>>> page is generated after the COW is triggered. Mlockall can lock COW pages
>>>>>>> (anonymous pages), but the original file pages cannot be locked and may
>>>>>>> be reclaimed. If the global variable (private anon page) is accessed when
>>>>>>> vmf->pte is zeroed in numa fault, a file page fault will be triggered.
>>>>>>>
>>>>>>> At this time, the original private file page may have been reclaimed.
>>>>>>> If the page cache is not available at this time, a major fault will be
>>>>>>> triggered and the file will be read, causing additional overhead.
>>>>>>>
>>>>>>> Fix this by rechecking the PTE without acquiring PTL in filemap_fault()
>>>>>>> before triggering a major fault.
>>>>>>>
>>>>>>> Testing file anonymous page read and write page fault performance in ext4
>>>>>>> and ramdisk using will-it-scale[2] on a x86 physical machine. The data
>>>>>>> is the average change compared with the mainline after the patch is
>>>>>>> applied. The test results are within the range of fluctuation, and there
>>>>>>> is no obvious difference. The test results are as follows:
>>>>>>>             processes processes_idle threads threads_idle
>>>>>>> ext4 file write:    -1.14%    -0.08%         -1.87% 0.13%
>>>>>>> ext4 file read:         0.03%      -0.65% -0.51%    -0.08%
>>>>>>> ramdisk file write:    -1.21%    -0.21%         -1.12% 0.11%
>>>>>>> ramdisk file read:     0.00%    -0.68%         -0.33% -0.02%
>>>>>>>
>>>>>>> [1] https://lore.kernel.org/linux-mm/9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com/
>>>>>>> [2] https://github.com/antonblanchard/will-it-scale/
>>>>>>>
>>>>>>> Suggested-by: "Huang, Ying" <ying.huang@intel.com>
>>>>>>> Suggested-by: Yin Fengwei <fengwei.yin@intel.com>
>>>>>>> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
>>>>>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>>>>> ---
>>>>>>> RFC->v1:
>>>>>>> - Add error handling when ptep == NULL per Huang, Ying and Matthew Wilcox
>>>>>>> - Check the PTE without acquiring PTL in filemap_fault(), suggested by
>>>>>>>      Huang, Ying and Yin Fengwei
>>>>>>> - Add pmd_none() check before PTE map
>>>>>>> - Update commit message and add performance test information
>>>>>>>
>>>>>>>     mm/filemap.c | 18 ++++++++++++++++++
>>>>>>>     1 file changed, 18 insertions(+)
>>>>>>>
>>>>>>> diff --git a/mm/filemap.c b/mm/filemap.c
>>>>>>> index 142864338ca4..b29cdeb6a03b 100644
>>>>>>> --- a/mm/filemap.c
>>>>>>> +++ b/mm/filemap.c
>>>>>>> @@ -3238,6 +3238,24 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>>>>>>>                 mapping_locked = true;
>>>>>>>             }
>>>>>>>         } else {
>>>>>>> +        if (!pmd_none(*vmf->pmd)) {
>>>>>>> +            pte_t *ptep;
>>>>>>> +
>>>>>>> +            ptep = pte_offset_map_nolock(vmf->vma->vm_mm, vmf->pmd,
>>>>>>> +                             vmf->address, &vmf->ptl);
>>>>>>> +            if (unlikely(!ptep))
>>>>>>> +                return VM_FAULT_NOPAGE;
>>>>>>> +            /*
>>>>>>> +             * Recheck pte as the pte can be cleared temporarily
>>>>>>> +             * during a read/modify/write update.
>>>>>>> +             */
>>>>>> I think that we should add some comments here about the racy checking.
>>>>> I'll add comments in a v2 as follows:
>>>>> /*
>>>>>    * Recheck PTE as the PTE can be cleared temporarily
>>>>>    * during a read/modify/write update of the PTE, eg,
>>>>>    * do_numa_page()/change_pte_range(). This will trigger
>>>>>    * a major fault, even if we use mlockall, which may
>>>>>    * affect performance.
>>>>>    */
>>>> Sorry, my previous words aren't clear enough.  I mean some comments as
>>>> follows,
>>>>
>>>> We don't hold PTL here, so the check is still racy.  But acquiring PTL
>>>> hurts performance and the race window seems small enough.
>>>
>>> Got it. I'll add comments in a v2 as follows:
>>> /*
>>>    * Recheck PTE as the PTE can be cleared temporarily
>>>    * during a read/modify/write update of the PTE.
>>>    * We don't hold PTL here as acquiring PTL hurts
>>>    * performance. So the check is still racy, but
>>>    * the race window seems small enough.
>>>    */
>>
>> It'd be worth spelling out what happens when we lose the race.
>>
> I'll add what happens when we lose the race as follows:
> /*
>  * Recheck PTE as the PTE can be cleared temporarily
>  * during a read/modify/write update of the PTE, eg,
>  * do_numa_page()/change_pte_range(). This will trigger
>  * a major fault, even if we use mlockall, which may
>  * affect performance.
>  * We don't hold PTL here as acquiring PTL hurts
>  * performance. So the check is still racy, but
>  * the race window seems small enough.
>  */
> 

I believe David was asking to add:

"...but the race window seems small enough.

 If we lose the race during the check, the page_fault will
 be triggered. Butthe page table entry lock still make sure
 the correctness:
   - If the page cache is not reclaimed, the page_fault will
     work like the page fault was served already and bail out.
   - If the page cache is reclaimed, the major fault will be
     triggered, page cache is filled, page_fault also work
     like the page fault was served already and bail out.
"


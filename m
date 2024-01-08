Return-Path: <linux-kernel+bounces-19833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A33A98274E0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EEA02841E4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FFE52F98;
	Mon,  8 Jan 2024 16:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SyJXV5Ji"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B23E524C7;
	Mon,  8 Jan 2024 16:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704730655; x=1736266655;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l+b2VWXMXu0dxhgQw9xHI0EcgUxtZ66qo/mjF3UnYUc=;
  b=SyJXV5Ji0U5Gcf9ibZO4S6Yzs7LEMaj2aKYzYHGUT8BwTn8vgTfvo5ia
   Pin6c5E9PjMrQFAtaqBGX6WvMatJgfsjYjlfTwlMshztpU+w1wr5mMkhT
   BRNHdla46h03+7xiP+lqBP7o7QEZtU5heU4hx3hBEe2ViUpffAvM36CjJ
   +BuRkva5g9QRhyrHvEn3gNuaSrT9zFGtQKgo+q7XXJvgMQ6Sge3JYQ2sS
   RiyoPHw2xWm+LSrJ7Zpr2mxsrp8wTLuM3AZFiUF7qifufzxsRFAbw+keO
   YkOXDn0lNlyl7WePsRC2LLcYUYmoQS2qw2N9K6IQyUnkPl8rOiobpsEpY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5295522"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="5295522"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 08:17:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="904846354"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="904846354"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2024 08:17:24 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 08:17:23 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jan 2024 08:17:23 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Jan 2024 08:17:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDW9SBwcL1acsbuu6PUxb18SWM682tCrH9H6iIwZkKa5udhVZYN3PhqDm/QS9rCkjI8LEf4eIvTNK+rk/s3thbQaU1HAb+06bCJ37RTVEZzU/yhE1KgelRlj7T+VRT6IyIXXdrZvg/PJYkWWy0Np09kuvJ2EdZ/ACAXB3bmSn97cMf8E9hamBE3QHzNEzBsXgeQXJ6C4hIU4DoXi9vrKLWyD7Zd4YyvOF83yP9zTsytzIOZk6ouBwdi3UusFhfRPpjsQsw14Z6oMdRQcbv/2z4P5X5z3Mn6OaWRXRpXD7Vyrp4R1OjH9nkXrwPiKy3dOeMvNPlxlxUkzCYC+Qzyvmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxJk2qK27NfXuv7FkMZIRORcdRMsz1rz2rpLgQZ1NyA=;
 b=UE2kTL2PuFbkKH0K6BuWOEok5gblsQkMxA+w7aZxhRotupLSulEx3DQ9Gq1UfsA+xsXngDYhlKleTdEi5OZGWpD70X/ft49irANIAB75TmAWxzu88UdzkkJuL/KNzXjKWp/zRhBlLNNf/PLoYQNdzCiRDZW+TkjUGDeePIq5X4wxtGIoDB4bYW4EYxTHAtcQDG7WByS8y4hhQEUHLNrDd/4DhJa8IeovY6kC+oVqxKmu6L8i0oCBGheWKXcCLbkB1NCTBEc09tHtf1TBHfcImcRvHwlsZXMyZ8GLnEL8ZtdNpXidx3ZynJKNAzerfr9K37YDc2fytA3RH9LYSZTdTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by MW4PR11MB7102.namprd11.prod.outlook.com (2603:10b6:303:22b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 16:17:20 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::8760:b5ec:92af:7769]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::8760:b5ec:92af:7769%6]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 16:17:20 +0000
Message-ID: <c4afc32c-e9c7-47de-9bc4-243df95644a3@intel.com>
Date: Mon, 8 Jan 2024 17:17:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 05/34] idpf: convert header split mode to
 libie + napi_build_skb()
Content-Language: en-US
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>, Larysa Zaremba
	<larysa.zaremba@intel.com>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231223025554.2316836-1-aleksander.lobakin@intel.com>
 <20231223025554.2316836-6-aleksander.lobakin@intel.com>
 <658c4328425f7_a33e629412@willemb.c.googlers.com.notmuch>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <658c4328425f7_a33e629412@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0270.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::16) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|MW4PR11MB7102:EE_
X-MS-Office365-Filtering-Correlation-Id: 69e66824-8b88-4005-55a1-08dc10654a35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b+E+t/UzM/2HfYSkK1Kt+rPWDgWy+pMnTOLGTN4/fUbCjxzAka/tw0OmIfjaWGFfnnXs3oiJa3vVKfHfpwUb2VP7JMzpduDE2wc+Ba3kGSROWi4Ok5Q0m4usubAzYw7trQFfAkmo3TML9MsdPqeTgNL1/B2RUH+UHDZ6oO7wfuSbTsjvzjsH/4eEvsvwERr9o6+kFRRXEFdol44Tu8DqNFiYA+t2QHWfmLhcQ4+ZcbOSrE8AVCi2Zdg4c86GWc5BaPnzOipJNoE0oZl11ZTtTaOW9CLNxqofOfSSHexcEx3GXBZOLjjqla4Nu94aPcji1+EgPCfeN/NgyrOo4xEw9qRver3m5L94/1f/t7YbYyXhYGsvHHqyc14ViT/y7HrgGK6UK4mC3GabqtvNauAxsOFaznm/ZG1zgPirZ4bP0rUqam6fHCdBBIOS8E8yPpGngQGTSG3Qic5zWZjiDhW4mIFfiSmPv/oNhu38hplm+yovW0NAwxVkY79m+AAMGTuwwu/sv0zxdzORZU0GlRAmjt0JMaYvGHDkGS8n6JykYjL80PopLCKPoteosrf9NCowOoM3ebfgN9J432Ox29lCmwL9hCbmB/SavegAyxlAB5aKKBPic239Q0eu2HJHv2m+4Ogl2lckR3bj26jS2MLytA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(31686004)(26005)(2616005)(6506007)(6666004)(478600001)(6486002)(6512007)(38100700002)(31696002)(36756003)(86362001)(82960400001)(5660300002)(2906002)(41300700001)(7416002)(83380400001)(66946007)(54906003)(8676002)(66476007)(66556008)(316002)(4326008)(6916009)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUVGZmtVMWowajF2enhMcUs2bmJqRlJVWVptSEdqM0RIdEJmOUljc1FWMjZH?=
 =?utf-8?B?L05hWWVGOW1iQkRKYUxOcHdtd3AwWmxkZjZ3Zzh3bVNxRDJCc25zTnlQVVQv?=
 =?utf-8?B?cVN2Qm1Ib3RhNG9DMkI4TFUzdXJNUHdtMXMzYVdBUGxkQTV3bUs3U25PK0dG?=
 =?utf-8?B?cUx3QzdkSHNlN2dCOFhMLzZUQktVUC9CZ04yU203L1NiUlk5Y0pDYnRDcFo0?=
 =?utf-8?B?eVVxWmhjWFNGZTMvVHgyYnh2ZG1uN05qWjdHZGdRakJJRG5LSzZRQ1dWMWNo?=
 =?utf-8?B?WW1nREV4YlNicXUvNGZVL2dLQksrY0FRSXJrM1FqaEYvRE1Vb1lPUGFISGlS?=
 =?utf-8?B?WTFjNit1Z1hXc1FlMU9DcjJKQmlXZ1lHeUNzLzNNdU1qb0MvZ0lOWnByMWg5?=
 =?utf-8?B?K0dKNml2T0M4U1J2UjhJWHBxeEJiVXpaTjU2aU5XM284Tzk5WVVBK0xjZmhX?=
 =?utf-8?B?WGRTSm54UDdwbURPTXVBSEJUVXBNMkVWVFQyaXhjNzB0c0YrMUQvUmhWc0da?=
 =?utf-8?B?KzlGamNrWGxsTUlkbFdQMTNNZGxkTkw1NW04eldCYkdPcXdXZ2N3RUZnZjNO?=
 =?utf-8?B?cVlQNTJpQll3dVVpY3BkNDVtVDRGckUyY25xSTNVUmVZSkJLZmhCWjdHTGdJ?=
 =?utf-8?B?NEpONWIvRVdFQVZQbXY1ZGtrd09WalFnTm1OMitldjd6bFhPa2ErMEZNRC9n?=
 =?utf-8?B?bkRweWVBNHZCK1R1UXMzSkQvVmtZRWFXcHRVWmJmOGZoS21jUTdXRWhqZy9y?=
 =?utf-8?B?UFRoU0JUQTJvWE8xR2hIVUxUWUtudWRBNGhxdHI4QU95K1Z4cGtiMHliQTFa?=
 =?utf-8?B?WXR1bFZ6clpQOFBleTZjT29xZ1hYVHQvTTA5VmJ6SEZodkpQUU5jZUttc1la?=
 =?utf-8?B?NHpOOEFJd0pEZG1SdFYwamFXNDlZcFZrVGpSYWVWa1hSY0pMT05KSHBlSXhv?=
 =?utf-8?B?V2k2K1djdnBmSWZ2bXZUekRid1B2eHZVYkRyZFlmTExoOWRkRXhqVFZwSHZm?=
 =?utf-8?B?ckNlM0tBMlovSXo3U1c1SEZHVmtIUVhTZG5vUWNvSVI2T1hlYndFaHEvdG1v?=
 =?utf-8?B?UjdBbVB1US9qbWtQT0lFdHd3OHd3S3RvKzR3MzgrTWhVWkxyU2I0N1BzNVNN?=
 =?utf-8?B?REF2aHBPQS9DNEpsNWdsZzlFUkpyNHdudHZtajhMZnZmTU1oSWllYy93YTlE?=
 =?utf-8?B?U3hPWHNSa2NoNVRuS0VINXJXZUZBSWlmSVBkZ1BkWU1wRUZhUGpDckErbHBh?=
 =?utf-8?B?eFgxY2dVaEJiVXBZSHVobzFMMmNibHV3WHdpSEFvOVZPZWFSeUlmVmNYUm1s?=
 =?utf-8?B?b2dmN1JMbk1WemRnaFFZN3piWWZOYm5QdGZEWlJIRUNvZkRZbXg4Z2ozYzZN?=
 =?utf-8?B?VEJJUEd0SEFKZTNSaG53eU1PeDM3Tk1nMVJTL3pvK2pFYTR3QVMyRTBhdFhr?=
 =?utf-8?B?VmRibGpRbzF4cHhzb0xIdnRhT2xSdXlXbEduS1hXMTcwZXFpeFVwR0l0TXc2?=
 =?utf-8?B?TWM3KzBTbndpMWN1Zjk3d0dMRlV2UFp4YXNZVXRaOUl3K3BkYm81bmRCWUtW?=
 =?utf-8?B?UXhTcllmSUc4dkhvVUsxdzRFN0RVNFBPbEtybjRWNlhneGxSSmpzQ3k2MnYz?=
 =?utf-8?B?L3NuNGIvYVM1ZVlnR3FQd1Z0OTBkSG1VaUV0UHNCcEZEMFlDejd1S1RwL2k3?=
 =?utf-8?B?NFMrY0p2Y2FYQjczNDlYS0pkb0g1c0kyZEpZMlErZ1dOc21HQVg1cEtzdmJK?=
 =?utf-8?B?TFphWHJOb2ZFSmhUaEhmYStLNnl0SE1DcUkvWFdTLzBseklFR1hYY2VDMmp3?=
 =?utf-8?B?NFFQYW5aSXJxNEkrbjEzTWNjaFZ2WU9ZcHhxSmp1TU0zdlNWaVp3M3dFQTdT?=
 =?utf-8?B?MkFtWkRrVVNpcFV0NU0xSVVMRlo4dmlKT1g2YUdvcFdYMVMxUmZ5aVBrRkdp?=
 =?utf-8?B?cDlYeE45Z0NacEF6RzNaVWtDZEtXTTNNdlhsd212cklOSElLeG5TNXlSd0dq?=
 =?utf-8?B?MW5ubnlXYS9VYkNZUFNwa0l5R05CQU1neGNoN3NMTm5VZ1BaNFlnTkJmRnZR?=
 =?utf-8?B?SUF3aGtLSVE5REtiamY5RCtCNlF0ZGxFLzdOZURQN08vNTg2RUtONS9CRXov?=
 =?utf-8?B?U2NFdG1BVFZ6aXJZRURqcjNrWXZEMldtZmN1T1ByUm5vV2phcjQ4eUJtZEsv?=
 =?utf-8?B?OVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e66824-8b88-4005-55a1-08dc10654a35
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 16:17:20.4941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5f+/8jELiLHDw3zcnCmt4HdUAa9u04rQDmbqOih41b7HfdDwQrQGBtVMoayz1SLkWLFfrVB6KU1N02V731l1Vuh1vDEkiRVLGETCVV1MapQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7102
X-OriginatorOrg: intel.com

From: Willem De Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 27 Dec 2023 10:30:48 -0500

> Alexander Lobakin wrote:
>> Currently, idpf uses the following model for the header buffers:
>>
>> * buffers are allocated via dma_alloc_coherent();
>> * when receiving, napi_alloc_skb() is called and then the header is
>>   copied to the newly allocated linear part.
>>
>> This is far from optimal as DMA coherent zone is slow on many systems
>> and memcpy() neutralizes the idea and benefits of the header split.
> 
> Do you have data showing this?

Showing slow coherent DMA or memcpy()?
Try MIPS for the first one.
For the second -- try comparing performance on ice with the "legacy-rx"
private flag disabled and enabled.

> 
> The assumption for the current model is that the headers will be
> touched shortly after, so the copy just primes the cache.

They won't be touched in many cases. E.g. XDP_DROP.
Or headers can be long. memcpy(32) != memcpy(128).
The current model allocates a new skb with a linear part, which is a
real memory allocation. napi_build_skb() doesn't allocate anything
except struct sk_buff, which is usually available in the NAPI percpu cache.
If build_skb() wasn't more effective, it wouldn't be introduced.
The current model just assumes default socket traffic with ~40-byte
headers and no XDP etc.

> 
> The single coherently allocated region for all headers reduces
> IOTLB pressure.

page_pool pages are mapped once at allocation.

> 
> It is possible that the alternative model is faster. But that is not
> trivially obvious.
> 
> I think patches like this can stand on their own. Probably best to
> leave them out of the dependency series to enable XDP and AF_XDP.

You can't do XDP on DMA coherent zone. To do this memcpy(), you need
allocate a new skb with a linear part, which is usually done after XDP,
otherwise it's too much overhead and little-to-no benefits comparing to
generic skb XDP.
The current idpf code is just not compatible with the XDP code in this
series, it's pointless to do double work.

Disabling header split when XDP is enabled (alternative option) means
disabling TCP zerocopy and worse performance in general, I don't
consider this.

> 
>> Instead, use libie to create page_pools for the header buffers, allocate
>> them dynamically and then build an skb via napi_build_skb() around them
>> with no memory copy. With one exception...
>> When you enable header split, you except you'll always have a separate
>> header buffer, so that you could reserve headroom and tailroom only
>> there and then use full buffers for the data. For example, this is how
>> TCP zerocopy works -- you have to have the payload aligned to PAGE_SIZE.
>> The current hardware running idpf does *not* guarantee that you'll
>> always have headers placed separately. For example, on my setup, even
>> ICMP packets are written as one piece to the data buffers. You can't
>> build a valid skb around a data buffer in this case.
>> To not complicate things and not lose TCP zerocopy etc., when such thing
>> happens, use the empty header buffer and pull either full frame (if it's
>> short) or the Ethernet header there and build an skb around it. GRO
>> layer will pull more from the data buffer later. This W/A will hopefully
>> be removed one day.
>>
>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thanks,
Olek


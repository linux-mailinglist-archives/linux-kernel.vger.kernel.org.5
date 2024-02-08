Return-Path: <linux-kernel+bounces-58134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4030884E1C4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC450283792
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FE478B6F;
	Thu,  8 Feb 2024 13:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qHjsmuxY"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C9F79DBB;
	Thu,  8 Feb 2024 13:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707397888; cv=fail; b=E0YMq1HmTb8hpbobzAmXvA0fozmBgbmIU4yywsU7Vas+iFLwCAqWGDe+tXmI4oXFuFQ8dCAT4WM4kqiOe4AFtQ1fAEtlvPXkoRTLv/xHGRN4t5YCR7gNuq3UcEDq66gjYmC5906nQxuKdTwKhfIMoSztK7egZp/7H0nqTi0PHOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707397888; c=relaxed/simple;
	bh=bQFn4AMFxgeQLT/QI7IVCbRkvjomFJE9zODdyOAtVMg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VSTpKB1OmhI0kuEXDRZVE0hq3Y9aKK/Fg1oD1Lsh25PL2SrNrzQYya2NtHonNmaNZJGQHVPOD+PMIzVmzbf8lXn7ZxAQfINLim+HlwxHilq0cVHTWGB8lZ+UXT0aqMPTyPSXjJQ3++5aCzrURz7teNPiPF2cOpFH5gcrW36kJGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qHjsmuxY; arc=fail smtp.client-ip=40.107.244.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgE/pIr3Ua1fTvmpf2nQJtMWGLExlnQmU9XIqgsDM3D66ksiQtPPRipBvtG/E9Z55EY1O3YJxNyNTYoGC0Q8xBbfUguY1NIlDVDwES0Y7fTbHcyGL77nUv07MYq21sXehKOXqG+igEshjOHklXpY4ugxTjqfEx1PveUNtR1FGobcwMLS8XuSImDbJ3niHXyUceDvoxc0n8ugNURegxEZa7IEgCXXms+7adKoYxZWxE31w+JFm370ELQzbEgfToHbRuf6d3mOg3DBc1Jblv2OS4VDIl6GEerGMPgDnYbVN+2BZmM58YGfIYo0vXoP0HbZTrfx+qv1T8uvCe4mnlaxSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4cZe1neRZxfs2zXEPKcKT+oGkYRs+UIVw4Hmf4KZt4=;
 b=if7VWZiG5U6Aib9/XyMpJZr98Q63cP+QXtzuQ1CN4rn4Q8PpOPuJAi5PlQPPHYJRUzCYr4HGdLwq+rOv4Bfj+eouCZIpVegE5P0pIASs1p3cn6rmSQ9BTA8t47rRZ7pYfuQBAn1Fe7cAk4LAkgF8PAkB1N/8y5O9YZRDpDYtrItttxSDg5wxAyc1l5Qeno7Wwoy2RUxBAi9WFTdbh0Sr6JXP4Lywg/S/kd0ljRPWKkHZOKPfvuzxXcfC2OSf4zwkh1v9nMXX/8yk/rVdNhtIIl1+OLImK0zXcZYT4ZzGlQKC22bxdOmZ0t1Ww+Hms3FgiFqe2RMowagmaOClG/NCaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4cZe1neRZxfs2zXEPKcKT+oGkYRs+UIVw4Hmf4KZt4=;
 b=qHjsmuxYr5XVbwVIpw5rgwSBvngHT4MeWVRm68cXsZJN3b6aK696dclxpoy3/2q6OgFbWjhTo9odPCyMJAe8NjENEj0q9mFxrcyjMNVHC+l9FloP+w5oVTW6no5tCs6P9L47GQIjln9E+33PEjq/eDMupKKqOcotc48QH83HtQQdGum1xwnRFkyPby3OTFFFlgpjtOb4LpvKiycrVaVX/0S+UYubuthbQodKkyC7jdoSUFjTHG7/gUIoxLHum6+yQ7cLuLhWZ2IW+p/KdBDdIVPtn0M3GrjWK2ZDXDanZN6q7uU5+3/cvdX6ufzKgJHrO4/vN+9FOAIzo8b0JQmd2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 SN7PR12MB8792.namprd12.prod.outlook.com (2603:10b6:806:341::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Thu, 8 Feb
 2024 13:11:23 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::acb6:8bd8:e40b:2bfe]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::acb6:8bd8:e40b:2bfe%3]) with mapi id 15.20.7270.016; Thu, 8 Feb 2024
 13:11:23 +0000
Message-ID: <d46a4d9c-7253-4318-90b7-08646493e7db@nvidia.com>
Date: Thu, 8 Feb 2024 13:11:16 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] net: stmmac: xgmac: fix handling of DPP safety
 error for DMA channels
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: Furong Xu <0x1207@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Joao Pinto
 <jpinto@synopsys.com>, Serge Semin <fancer.lancer@gmail.com>,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 xfr@outlook.com, rock.xu@nio.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20240203051439.1127090-1-0x1207@gmail.com>
 <c25eb595-8d91-40ea-9f52-efa15ebafdbc@nvidia.com>
 <20240208092627.GP1297511@kernel.org> <20240208095348.GA1435458@kernel.org>
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20240208095348.GA1435458@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0257.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::29) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|SN7PR12MB8792:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c0bdc5b-67f4-4b1b-8cc7-08dc28a772c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	J7A4Gov4qrSP53GBVf/J55Gzu1yAPS6IPXbR1eXZSN/73ZO4H8FlFd/8YJlEuCRNnJ0jrWbNwADxq2CSNSfHlJRhr4iMovru34uA6Mm9wlQIhjR4TcYg6H/FnTgAtX/+nOIYyUoGRLAeA5VDSJsITJwck8XZIjx5N6T9pp1rZWyuvN9aP+rFW8LGGhH0jUxFWiljxPioYRU9vYwHPYzI1gk3al/SPxWG2notYZL9K+WTadmn3xCfOZxO86JaBAfYaQiifTYO8Ko3E3j9Y6/YpikQmAqV2GI3oUZi+zXKbvsEJLQjs/NJnMtSVzf4LSbxuQetYRymaBGdmXpzrVt0Do8OLdqEVyUZFvjg9qJHhmx/0ikMkic3sCOFDdJbnL8y6gRCEhNLIXY/Kfwz48/07EkAIapDXhf3wEjF2b2ofv8GoBVEPgm7Z/phB4JlEXCMo6xDSepHwA0rrDy4er+YrqG1xyk7THg8TJTCVg8mdnHpZ2q1JdgP4Qhkm8Zw7Q4EG7/DOFqYqt4d4rJ6mBL/6ohMZEuIppWF7ZaRAHLnlJITJKy2Ao+k6zdVRECfAqlst58DxLrHEVWjArRRJYHZi2+jVYPGoZaqFL/jvlXtFwRAu6l0SjEo9eRXxVqt0Aws8K9x01o9XQ4R47NTAPLR3A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(39860400002)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(478600001)(966005)(2616005)(66946007)(53546011)(6506007)(6486002)(6916009)(55236004)(26005)(6666004)(6512007)(38100700002)(7416002)(41300700001)(2906002)(54906003)(5660300002)(8676002)(316002)(66556008)(4326008)(8936002)(66476007)(36756003)(83380400001)(86362001)(31686004)(31696002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFArS1BsSzF2SHZMYXcwMGNpSkZWSTJaUzZQVVQ4WkFLSTNkazhqUVl2eThq?=
 =?utf-8?B?YVhZUWpjazJBZzNKMW5IMnBRYWRkcEExVkhtc1dtbjhodUhQeWRxU1ZsNWR1?=
 =?utf-8?B?dkRuNzFRQmd0NkVGZC9xS3RIL0NiRW9obENrWklac2h1R1Fsbmc4Y3VzakRu?=
 =?utf-8?B?ZUdyYWZtQW5OT2VHMmIzcU9mai9EZFFUN2VaclpTQVdvUFNFbndiSFlIZUdC?=
 =?utf-8?B?WFZzSEFEKzV0dWtuUkpKUjhxT3hLbkRMY3UwOVliemhSR056UnRJSGpTYW81?=
 =?utf-8?B?UzFvUUhkT3RmYkFIMHo3bGFMTHNlUCtHSDFSRUtvRGNDTnRGQkJzcFVJd3da?=
 =?utf-8?B?bGZzSmFjUzRHNFVGVnJzZ1o1ZUhjVENuU3Y5OEVwK1lvVHU2MDhpa29GTW14?=
 =?utf-8?B?TWhpV2hGbFJ5ZTFJV3hHS25wWkNqdm9qNmZXdnJvMFJBWlU1OVpvVW0relRj?=
 =?utf-8?B?S1Fxa0k2TG0xNlFYWTNaMUMxcldrZk0wdS9teTNQcTVlWEVlTEd3Njh2WlR5?=
 =?utf-8?B?UCtoSGJ1eS9MUWtGQVV3ZEtMTmdnQjAwU2diOG9LNEJhVTM3bmVhaTdjL0hp?=
 =?utf-8?B?R0lUNWU2VnVoRVgrcEFKNmo2NW53ZW9JTFhmcXZSeTJiVW5xOTlWa1Q2WERh?=
 =?utf-8?B?Z284VTF2eWU5cXR1SUh2MXY1T2tyeS9TSTF2Qk41SVZ4WHVhYWo3N1NhZU0x?=
 =?utf-8?B?b2YzdkxJb24vMVpZU2xMS2FGMWY4aWpjby8yZTlOTnN2YVNwc1NNT2ZxZ05I?=
 =?utf-8?B?dFB3NWpyMWFzbC83NEhwclR2UlpGcFFzbCtxR1VXT2dnd2NwK1FFbWxjSzMv?=
 =?utf-8?B?N1F4ZkhzbkJLSUkyS1g5RFRNZWVNUzlsdTNMVTNsdjNKK3N4MHdkNUlUQU9J?=
 =?utf-8?B?aEExUEhpNG9ONHpleC94N1FJaGIzN2lXNXdBRzdHTUdVeXVUamIvcEp6Q1dX?=
 =?utf-8?B?R1Q3Qm1UTzJOOXBMeWd3M2VydkNabGZacCtXR01ETXVsdnhnYi9zMGxuSDQ1?=
 =?utf-8?B?Qzhtb214MUlXMEM1ZGhCU2h1MktSR0ZlT3Jyb2wzUjlodVJoMXRmNFN2VVVJ?=
 =?utf-8?B?bXRxemEzejlBTWRVY2JqcjdXMG5NQzlLMFlZMUJYMGNwSEh1VDJrUklUMnQ4?=
 =?utf-8?B?L0N6ZmtXTDQvMzJBWFVjKy83NWhrRkF1OFEzN25TUUM0ZG1FdGcxN0RjYWc2?=
 =?utf-8?B?Q3hWTUNJSzc1eUdTQ1FadVlSR1RWdlBpQ1hUMlBwM0owM3BhajlwVFcxbnJD?=
 =?utf-8?B?NVk5aCtHQVBnZy90a2N5K0lpNEFWOFRFa2FEN0VXdCtFM25SOGdhSkxwNERV?=
 =?utf-8?B?V05yNGRZQXBkbWpOeFBMbFFhblByTG9hSVE1dFEzaCs0YStJNzlWcEdJckJr?=
 =?utf-8?B?WUtvNmJIS1oxazNsTlN6V2R3R1kzd3JkU05GOVgybE92SUhxRGFCN2lQcHhP?=
 =?utf-8?B?S0ZpcDkyVmpnN3AvVU9BMkNLclJRR3hZTk50RnFoSkw2QjAwSGFCYis3YndJ?=
 =?utf-8?B?bXZsV2RhNDA3dENZOHNwWWhGQ3ZoWVhxR0N0elk5NEJWNTNQa3d0aGtDNTVN?=
 =?utf-8?B?UlVxVDZBQWgvWityaFRSak9yYkIxVmVkeFRyc0UyQmg5bDg5MU8xaGRINzh3?=
 =?utf-8?B?RDZFZFJJRUR6SEZaZXVjY1owM2tiNXVJR1Z2eVJGbTM4Qm0rb2FjS1Z3eEJh?=
 =?utf-8?B?TGhqYTBOMTYzQklVdjJHSUhGaVFMbTdQNk5CWUpZd295a3F0U3I3MXJuUWNY?=
 =?utf-8?B?RWhUb1hRNkgvUUh5TGx6ZTQrd01sbWhWQ1g3VFFDb04zQmNROHZJczZwbXd4?=
 =?utf-8?B?dkdlRzJTZnoyUzFXVDAxQWd4TU9RVjRWWDduVVRzY3dUSndacmFNZE9rZEdC?=
 =?utf-8?B?TlFSclFmY2NLUy9ZNXFlL1p2bHZqMDljR2FJeU80Mmd1WXl1RHZuTmJrRzBY?=
 =?utf-8?B?d2Z6SFlHMEhHNU9PdUlJckNiU0hodm5WT0NDaDBjbHdmeTU4dWVEV1V0V1lK?=
 =?utf-8?B?NTR0cEwxT3dYZDFGM2tsaVJGeGFXamdscnBIbmRTYVBDYVBCVlNEUit6NXBS?=
 =?utf-8?B?cFZOY1kwKzgrd04zMGszd1p5UDJZYVFVVzZ4a3NycEpWMERiNVl4TFBrNmFi?=
 =?utf-8?Q?J7gQxOs88maN7tnSa0zTH8Xi4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c0bdc5b-67f4-4b1b-8cc7-08dc28a772c2
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 13:11:23.2559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQiFkUk2WI7d3nijz2eIWDPKrUR+eLhmwFTujcSP1nXQOSsDRIeFRsfXtxYoim9N2go5rxP8+7KTqvacXnYt0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8792


On 08/02/2024 09:53, Simon Horman wrote:
> On Thu, Feb 08, 2024 at 09:26:27AM +0000, Simon Horman wrote:
>> On Wed, Feb 07, 2024 at 11:56:26AM +0000, Jon Hunter wrote:
>>>
>>> On 03/02/2024 05:14, Furong Xu wrote:
>>>> Commit 56e58d6c8a56 ("net: stmmac: Implement Safety Features in
>>>> XGMAC core") checks and reports safety errors, but leaves the
>>>> Data Path Parity Errors for each channel in DMA unhandled at all, lead to
>>>> a storm of interrupt.
>>>> Fix it by checking and clearing the DMA_DPP_Interrupt_Status register.
>>>>
>>>> Fixes: 56e58d6c8a56 ("net: stmmac: Implement Safety Features in XGMAC core")
>>>> Signed-off-by: Furong Xu <0x1207@gmail.com>
>>>> Reviewed-by: Simon Horman <horms@kernel.org>
>>>> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
>>>> ---
>>>> Changes in v4:
>>>>    - fix a typo name of DDPP bit, thanks Serge Semin
>>>>
>>>> Changes in v3:
>>>>    - code style fix, thanks Paolo Abeni
>>>>
>>>> Changes in v2:
>>>>     - explicit enable Data Path Parity Protection
>>>>     - add new counters to stmmac_safety_stats
>>>>     - add detailed log
>>>> ---
>>>>    drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
>>>>    .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  3 +
>>>>    .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 57 ++++++++++++++++++-
>>>>    3 files changed, 60 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
>>>> index 721c1f8e892f..b4f60ab078d6 100644
>>>> --- a/drivers/net/ethernet/stmicro/stmmac/common.h
>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/common.h
>>>> @@ -216,6 +216,7 @@ struct stmmac_safety_stats {
>>>>    	unsigned long mac_errors[32];
>>>>    	unsigned long mtl_errors[32];
>>>>    	unsigned long dma_errors[32];
>>>> +	unsigned long dma_dpp_errors[32];
>>>>    };
>>>>    /* Number of fields in Safety Stats */
>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
>>>> index 207ff1799f2c..5c67a3f89f08 100644
>>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
>>>> @@ -303,6 +303,8 @@
>>>>    #define XGMAC_RXCEIE			BIT(4)
>>>>    #define XGMAC_TXCEIE			BIT(0)
>>>>    #define XGMAC_MTL_ECC_INT_STATUS	0x000010cc
>>>> +#define XGMAC_MTL_DPP_CONTROL		0x000010e0
>>>> +#define XGMAC_DPP_DISABLE		BIT(0)
>>>>    #define XGMAC_MTL_TXQ_OPMODE(x)		(0x00001100 + (0x80 * (x)))
>>>>    #define XGMAC_TQS			GENMASK(25, 16)
>>>>    #define XGMAC_TQS_SHIFT			16
>>>> @@ -385,6 +387,7 @@
>>>>    #define XGMAC_DCEIE			BIT(1)
>>>>    #define XGMAC_TCEIE			BIT(0)
>>>>    #define XGMAC_DMA_ECC_INT_STATUS	0x0000306c
>>>> +#define XGMAC_DMA_DPP_INT_STATUS	0x00003074
>>>>    #define XGMAC_DMA_CH_CONTROL(x)		(0x00003100 + (0x80 * (x)))
>>>>    #define XGMAC_SPH			BIT(24)
>>>>    #define XGMAC_PBLx8			BIT(16)
>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
>>>> index eb48211d9b0e..04d7c4dc2e35 100644
>>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
>>>> @@ -830,6 +830,43 @@ static const struct dwxgmac3_error_desc dwxgmac3_dma_errors[32]= {
>>>>    	{ false, "UNKNOWN", "Unknown Error" }, /* 31 */
>>>>    };
>>>> +static const char * const dpp_rx_err = "Read Rx Descriptor Parity checker Error";
>>>> +static const char * const dpp_tx_err = "Read Tx Descriptor Parity checker Error";
>>>> +static const struct dwxgmac3_error_desc dwxgmac3_dma_dpp_errors[32] = {
>>>> +	{ true, "TDPES0", dpp_tx_err },
>>>> +	{ true, "TDPES1", dpp_tx_err },
>>>> +	{ true, "TDPES2", dpp_tx_err },
>>>> +	{ true, "TDPES3", dpp_tx_err },
>>>> +	{ true, "TDPES4", dpp_tx_err },
>>>> +	{ true, "TDPES5", dpp_tx_err },
>>>> +	{ true, "TDPES6", dpp_tx_err },
>>>> +	{ true, "TDPES7", dpp_tx_err },
>>>> +	{ true, "TDPES8", dpp_tx_err },
>>>> +	{ true, "TDPES9", dpp_tx_err },
>>>> +	{ true, "TDPES10", dpp_tx_err },
>>>> +	{ true, "TDPES11", dpp_tx_err },
>>>> +	{ true, "TDPES12", dpp_tx_err },
>>>> +	{ true, "TDPES13", dpp_tx_err },
>>>> +	{ true, "TDPES14", dpp_tx_err },
>>>> +	{ true, "TDPES15", dpp_tx_err },
>>>> +	{ true, "RDPES0", dpp_rx_err },
>>>> +	{ true, "RDPES1", dpp_rx_err },
>>>> +	{ true, "RDPES2", dpp_rx_err },
>>>> +	{ true, "RDPES3", dpp_rx_err },
>>>> +	{ true, "RDPES4", dpp_rx_err },
>>>> +	{ true, "RDPES5", dpp_rx_err },
>>>> +	{ true, "RDPES6", dpp_rx_err },
>>>> +	{ true, "RDPES7", dpp_rx_err },
>>>> +	{ true, "RDPES8", dpp_rx_err },
>>>> +	{ true, "RDPES9", dpp_rx_err },
>>>> +	{ true, "RDPES10", dpp_rx_err },
>>>> +	{ true, "RDPES11", dpp_rx_err },
>>>> +	{ true, "RDPES12", dpp_rx_err },
>>>> +	{ true, "RDPES13", dpp_rx_err },
>>>> +	{ true, "RDPES14", dpp_rx_err },
>>>> +	{ true, "RDPES15", dpp_rx_err },
>>>> +};
>>>> +
>>>>    static void dwxgmac3_handle_dma_err(struct net_device *ndev,
>>>>    				    void __iomem *ioaddr, bool correctable,
>>>>    				    struct stmmac_safety_stats *stats)
>>>> @@ -841,6 +878,13 @@ static void dwxgmac3_handle_dma_err(struct net_device *ndev,
>>>>    	dwxgmac3_log_error(ndev, value, correctable, "DMA",
>>>>    			   dwxgmac3_dma_errors, STAT_OFF(dma_errors), stats);
>>>> +
>>>> +	value = readl(ioaddr + XGMAC_DMA_DPP_INT_STATUS);
>>>> +	writel(value, ioaddr + XGMAC_DMA_DPP_INT_STATUS);
>>>> +
>>>> +	dwxgmac3_log_error(ndev, value, false, "DMA_DPP",
>>>> +			   dwxgmac3_dma_dpp_errors,
>>>> +			   STAT_OFF(dma_dpp_errors), stats);
>>>>    }
>>>>    static int
>>>> @@ -881,6 +925,12 @@ dwxgmac3_safety_feat_config(void __iomem *ioaddr, unsigned int asp,
>>>>    	value |= XGMAC_TMOUTEN; /* FSM Timeout Feature */
>>>>    	writel(value, ioaddr + XGMAC_MAC_FSM_CONTROL);
>>>> +	/* 5. Enable Data Path Parity Protection */
>>>> +	value = readl(ioaddr + XGMAC_MTL_DPP_CONTROL);
>>>> +	/* already enabled by default, explicit enable it again */
>>>> +	value &= ~XGMAC_DPP_DISABLE;
>>>> +	writel(value, ioaddr + XGMAC_MTL_DPP_CONTROL);
>>>> +
>>>>    	return 0;
>>>>    }
>>>> @@ -914,7 +964,11 @@ static int dwxgmac3_safety_feat_irq_status(struct net_device *ndev,
>>>>    		ret |= !corr;
>>>>    	}
>>>> -	err = dma & (XGMAC_DEUIS | XGMAC_DECIS);
>>>> +	/* DMA_DPP_Interrupt_Status is indicated by MCSIS bit in
>>>> +	 * DMA_Safety_Interrupt_Status, so we handle DMA Data Path
>>>> +	 * Parity Errors here
>>>> +	 */
>>>> +	err = dma & (XGMAC_DEUIS | XGMAC_DECIS | XGMAC_MCSIS);
>>>>    	corr = dma & XGMAC_DECIS;
>>>>    	if (err) {
>>>>    		dwxgmac3_handle_dma_err(ndev, ioaddr, corr, stats);
>>>> @@ -930,6 +984,7 @@ static const struct dwxgmac3_error {
>>>>    	{ dwxgmac3_mac_errors },
>>>>    	{ dwxgmac3_mtl_errors },
>>>>    	{ dwxgmac3_dma_errors },
>>>> +	{ dwxgmac3_dma_dpp_errors },
>>>>    };
>>>>    static int dwxgmac3_safety_feat_dump(struct stmmac_safety_stats *stats,
>>>
>>>
>>> This change is breaking the build on some of our builders that are still using GCC 6.x ...
>>>
>>> drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c:836:20: error: initialiser element is not constant
>>>    { true, "TDPES0", dpp_tx_err },
>>>                      ^~~~~~~~~~
>>> drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c:836:20: note: (near initialisation for ‘dwxgmac3_dma_dpp_errors[0].detailed_desc’)
>>> drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c:837:20: error: initialiser element is not constant
>>>    { true, "TDPES1", dpp_tx_err },
>>>                      ^~~~~~~~~~
>>> drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c:837:20: note: (near initialisation for ‘dwxgmac3_dma_dpp_errors[1].detailed_desc’)
>>> ...
>>>
>>> I know that this is quite old but the minimum supported by the kernel is v5.1 ...
>>>
>>> https://www.kernel.org/doc/html/next/process/changes.html
>>
>> Thanks Jon,
>>
>> I separately received a notification about this occurring with gcc 7.
>>
>> https://lore.kernel.org/oe-kbuild-all/202402081135.lAxxBXHk-lkp@intel.com/
>>
>> It is unclear to me why this occurs, as dpp_tx_err and dpp_tx_err are const.
>> But I do seem to be able to address this problem by using #defines for
>> these values instead.
>>
>> I plan to post a patch shortly.
> 
> Patch posted:
> - [PATCH net] net: stmmac: xgmac: use #define for string constants
>    https://lore.kernel.org/netdev/20240208-xgmac-const-v1-1-e69a1eeabfc8@kernel.org/
> 


Thanks for fixing! Works for me.

Jon

-- 
nvpublic


Return-Path: <linux-kernel+bounces-7505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9709481A909
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA7D11C229EC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354CA4A99E;
	Wed, 20 Dec 2023 22:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gNfwP5KM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0255D4AF64;
	Wed, 20 Dec 2023 22:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703110934; x=1734646934;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LMgMSfaqZfhbPsirQ54LaqiD3a7aRk/3zyqBthX/XpY=;
  b=gNfwP5KMgtmm31BN0QCAxKAwGpPw26urM16kuYInxPh4SX/WLT2fcTaD
   n+C23ns23O3KWWbMA2bjIddkxbJEFxd0wZftIEKG4y9daEdoML0VnL4/5
   vM/Gcw55nvjsCwZvAm43eRPTIungbHamgBd911Z1ZWkT6zB3phbxVix2A
   En9DpBcQzaSGW95uH6DlDhI1iET6vwIUo7ul5yBBVUqOz9sJJtgEVYk26
   +Qr9U11YePF6h2ppkb/cBpgbHT0WYBNogLvoSyA7ZHnWXGRFm/IZ0jzXM
   IimcO3zCSoJ87b22797ZH4lQX+R0nvo/Oef3wloezpHmIzctwN9aAjrfq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="460221385"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="460221385"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 14:22:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="920108307"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="920108307"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2023 14:22:13 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 14:22:13 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Dec 2023 14:22:13 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Dec 2023 14:22:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDRplzPxmJKWus8bqAZgBcZD9Yuy3ETYZT8klk742/3nMMI2kabLe0PIRBUOdqK5JGHko+VS5aotNfHPCuW2Xg36FaTi5stbFAstDKMI18+fgO1Fb6tj7iK+tNtChfjTlUVBvpER1luguEORjsQIzTIy/HskDBoOTNBG9eJZ8itc52AjjJcfpsO4o8w30upmHL5MCUloYcNex77I5ug18hIerv4XxSpAFdWxc/hkG39bcklN5nXR9n3JStPsKirB7GHHDkkGXAIJoHHa0oSkRj+NlGpeozTbtM+lhZWOV5Hi3Vc5H1HY1Rrm2CdQF7nFAgTLZ682q0dH0gYxJRcAGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufHDAf726kVnw97bH/XOTzNVroB3nrJbKtrEOwaegaY=;
 b=GzBDm8LU/JsPruXlQRzxfLrR3/Pu3Q9wzi5dat3f9jwRbpBhHvwbXyaHws7WpJOsXqdeGTn2RrBwOYIGk+KuI4tGBJFDZoBJsl4VWLK5kbLop6cfNeyKvIp+ue+kgH75jVzbov3QdyVMDq1Sqlm/b74s8d4gJfdFA4Jf/cpB1tpYEFSL3UWZ0U0hOKEDYsuy7fB2o38fTdCRp9lLrSwxnRwPaWr9girmtwQKudODos7uVwdxPOQtZx4YETC9s1VocrWBi2UQWs1JCC21J1et4SB1W4po+6hA/qNJK5Ww7PO/sl0FYZWH0MWUbhgtwh3ZgpHs0c+gPgI9cSUal+UY4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by SA3PR11MB7413.namprd11.prod.outlook.com (2603:10b6:806:31a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 22:22:06 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::ea27:681d:ec93:3851]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::ea27:681d:ec93:3851%5]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 22:22:06 +0000
Message-ID: <7a233358-2353-4c61-9d90-9f687f63b8bd@intel.com>
Date: Wed, 20 Dec 2023 14:22:05 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 03/12 net-next] qca_spi: Avoid skb_copy_expand in TX
 path
Content-Language: en-US
To: Stefan Wahren <wahrenst@gmx.net>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231218232639.33327-1-wahrenst@gmx.net>
 <20231218232639.33327-4-wahrenst@gmx.net>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231218232639.33327-4-wahrenst@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0023.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::28) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|SA3PR11MB7413:EE_
X-MS-Office365-Filtering-Correlation-Id: 81e143c3-e69e-461d-0fa7-08dc01aa197f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c9h3l0aTmPzfpUym/tXEBWACVN/Ar5UxYMCTvzCyS/AtNGLYrthoBMTM5/k3tgMCgHJpjpUk0+ecbZZpezDpWuoWu6SnIkUY6i0bAg0x624wyV3Bg7Mc11ue2EOcISIHJETH3woPX2NkdL/jQiF/vaiX5RDfdT7QHU+9tNreaWkaCuOYTw3DRSK8hjwPGno2AO4xFmU1pJic+3Bumd0b5SZPCLIQD4sOl3ufrKwGca1c2t2nzRTFlzZ1erirNCunnWUBKf0TqiU0PZ72z1WZwVJxbeNnu23cWDLZpE+ZOnah1fMr2qM7avCtSf9YYwJs6HF8x39UWzEYsBRmOxbCfkAlEO/sJZrrDMNivJ9bg4xjWNHakAfs8cnloGU3d6vdwK8zJCaWapULCAMXzIWD/eGvpbMUg634BNCX6hNB/nG53sCARNm+T+VjdCWQPjxCVpcUSuNphH0xBvxKZPBq2IUs42idmDkrJlVXQmtpl6JvsbgfZCenTEZ0hbSlv9Q3e5q5Jm0EgHV0xJmWkMPkc0iNAgAWWxcnE/Cg0ij5IBduoYd1vdFgNXlhXMKLr7QwnBmZnU+AmSpgibUhWn7Dfz1hgb6KRZGQndK0VGM5J7HkNab6b+FN13UZRNBxrnmkht6nnHZxoZh4RxJ1ev9iEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(39860400002)(346002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(2616005)(6506007)(8936002)(53546011)(5660300002)(83380400001)(6512007)(41300700001)(478600001)(4744005)(2906002)(66946007)(316002)(66476007)(8676002)(4326008)(6486002)(66556008)(110136005)(82960400001)(36756003)(86362001)(38100700002)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXRVeVkvNGQ2dGRMbCtDc3ZCMHg2R1lXTUFxOEVVSVJiSVpMRWdvMGNhRTY5?=
 =?utf-8?B?SXhhdXlWMXFJRC9paGw3VEZhekVVNXhJMG94U3dKcVVuOTFMQ1hZYzlmM2lJ?=
 =?utf-8?B?endCSm0zc1ZwTkxFTG5EdVUrWlJmdlFVakVFZzhENXo3dU9kUFNRV2dMTTlI?=
 =?utf-8?B?ZktIUkFmeEt0OEQraE83cEVBRWdmc251by9SVWhXV1RuazFKZXJZS3VpeEgy?=
 =?utf-8?B?WTVUdWtHWldYUk00VGN4TTF0SklVMVV3TEVmbElpV01Dd2UvQkUxQTJVUDhX?=
 =?utf-8?B?U1NOQmgxbm4wLzdnNkU1M2ZISHRMRWsvL0p4NTNqMHNVVmY2WUxtcG9lUkhJ?=
 =?utf-8?B?OXN6RVFvRVQxQXR0d3ZCc09WU2lYTFROalphZWhTeVhrZS80TmFNcDJpbEdS?=
 =?utf-8?B?WlZlU2lIa3orZFgrUVowTVd2MkNVSEJIQ0Q1ZXBtZThwWVJtZUR3cGRuNWNm?=
 =?utf-8?B?bGlTZ1AwRDJZSlQ3R1NvZitUdVpMQ0tsWFFOQ3kxQ292NUhGcW9JQm9FcE84?=
 =?utf-8?B?WlFFYTBUMUVTdkhQY2FWVEJXdStHVW5jK0FEc3JGUFJOMnhlY2pjY1E0dzNG?=
 =?utf-8?B?Ymk1VWVzMWk4Q0FFbWduZkVxMnU5WUtpT2V1N0Q5amE3dElRMTlIVHhnV1NM?=
 =?utf-8?B?WHp5U0ljZEhOa1VON0RoUktUeUo4ZDFBa2tZWCtVRmMyWFo0bTN1eW16VGR2?=
 =?utf-8?B?WjJYMitzSG8rQ2xuYW1RUUYrZ1B0cXlTTk5qOG9IWmdyU25yaEszUGVwY2hr?=
 =?utf-8?B?WG9zbEVwK2c0cGJFdmZReGNiTjRkYlVQdFR0cU0xTEh1blFadGlNMUYrQmU2?=
 =?utf-8?B?ay9CUnlDZWYzdjI2eE5EZ01SWExma1czcjZGbEZrYWYxMWpDVm0xN2ZlOVdD?=
 =?utf-8?B?SWttS2ZFSHhuOG5OcnZsWTNLV3NqcExRbU5BTkxOT1FDOGV1YlFQUHBzaHph?=
 =?utf-8?B?S2RoeEhsSVpabjRHWWs1VXhSZHpwT2ozUFU2QlJ5RmpuVVdGN2dpakM0WjJI?=
 =?utf-8?B?eXgzMHVMZlJpZHpuYXE3K3lkcUJEUjQwblVDL0kvcGNHdS9CeG5TejNJalE3?=
 =?utf-8?B?T3kyTGk1YW9lMXoxRFh3eEhDaUhtSFpRZlVNc2x5Rkl1QWF0WHZOeHVaUmRk?=
 =?utf-8?B?QUVZYVQyaGVna1VFQTY5ZWRtdUlrdktJWWVPSlZDeGNJQ0VhazZTSHRTYThx?=
 =?utf-8?B?YXdOL2I4MG1OczJyckRzNEF0N3lvUzlJUUxCRDVIZHhrbGFMNG1LUmI3N08z?=
 =?utf-8?B?OExobENIYXpyVlJwS0lMdi9VQ0k0UGh3NFJIWkFVNTdKVkcvOFVLYjQ2d0Fa?=
 =?utf-8?B?dDVhOWNVWUJ4VEtiZzVVR0JaTTVTdXM5NWM4dTF4UjQ3WHYxaTBUQ0NrTnhC?=
 =?utf-8?B?Wm0xbWxpeTFaVzkvbEJQbzJaMjFOQ0E0U3NDeVM5cVVHTDJJYU1BbGNpOTkw?=
 =?utf-8?B?UzM3NXVNU2E2UDN0VGJML0ptZ2Jid2RPcENRbTFlVE14eklNMnNkZm4zRWxU?=
 =?utf-8?B?Q2pNelJ3WlJGdHlaL29DcGlWWlM1T0VHSHIrTjlmQTduZXBGbGxHekQxUXov?=
 =?utf-8?B?NWJJNEkxU2ZNUXBlcXBKYXZxaktWNjRnSEJybUY0K0lER3BlaW5SaFliNEhv?=
 =?utf-8?B?UklhTHNsRjlEWEJYTWluVTZDdWtRRTF0NXoyK2UwQis2QTR5UmZmRlBia2xO?=
 =?utf-8?B?WWlsZDJLWE9VR3lseFg1dnBzd2NUd0ZUM3JMRURSbGVLVjZmSTNDWWEzZHBY?=
 =?utf-8?B?RVh6bXpySVkzTVN6YlhOWk13bjVRMUVpemdCZEpNQUVmZkZtVGRpdS82L2Va?=
 =?utf-8?B?ek5uT1BydS90RXdkTGlySkVQM1pPVFFZa1kwbXpheFlZalpmbGdBTXd6akRq?=
 =?utf-8?B?VjNCZXRKQ3dWMzBsV25BTElZUmNUa3pYcVlZYzVTZVFKNHlxWXJtRU1odDBU?=
 =?utf-8?B?TklIcnVCeEVOQlQ1RHlmaExZbE15TzJ1QWw2UUE3c2U4YWxJMlZHcHlLS3Rs?=
 =?utf-8?B?cjRFTngyL1loR21CNnFlTm1FUndadWphc0J5Q0R5ajN5eGxRYXBpTzFlaDl1?=
 =?utf-8?B?VERtZG5UVyt6aTM4NVpBR3M0a1krenZVWGtFd1kxcTJKbzUzOTgrekhFTlEr?=
 =?utf-8?B?b3ZXa0o2alB2Q0tMdzRSTEcydEs2TmpNRzU0b041TlRaOC9FeGwvMkdkUkRS?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e143c3-e69e-461d-0fa7-08dc01aa197f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 22:22:06.5293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iop3se0TEthp7blk0dvf2UuzZNDsfHKihEBRJnLy8qVBw1VDgqZDmxjcsxXwADQ8O6EJV1HHUl5pU0POQ2cjMnXXUy4rekeI6xhiPH7PWRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7413
X-OriginatorOrg: intel.com



On 12/18/2023 3:26 PM, Stefan Wahren wrote:
> The skb spare room needs to be expanded for SPI header, footer
> and possible padding within the TX path. So announce the necessary
> space in order to avoid expensive skb_copy_expand calls.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>


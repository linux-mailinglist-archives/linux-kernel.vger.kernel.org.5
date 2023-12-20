Return-Path: <linux-kernel+bounces-7509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B0481A911
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 087E4281657
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734234A9A4;
	Wed, 20 Dec 2023 22:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cg8jyD6w"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8292D4AF66;
	Wed, 20 Dec 2023 22:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703111042; x=1734647042;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oqA+MvOk6NTzTBqiIu3hJJd60IiE8ie7mvlZgcNVxvQ=;
  b=Cg8jyD6w3QAr09SG/jCh/S1rTSrJcPA32bwtxUSt8g5OkhgrDg7LRCMU
   JgPzB7pyu+5m2d5UMsVLfJUC0AeJ0DNJEo3z+X8AnpgW9tQNjHi12g8IZ
   uMHTLFh1Ux2bCRVePyHt0XZXtPAhkMLqzoWGIqgNYLx/Df1tcQGIY7xWV
   OKqcxycG1Gy9MYDE7/ffr6WReHaCvGrVvI4Tnpw4cDYKTyKXjb+rlGdi5
   qwNWzUYC/SL4BadH/vmVQLS0HQso6XMcOQE3c573NC8cirS7PTCZcNZsG
   77zMrN8izvX7gCjHEgfcVyGW4uKBOtLEMezc89PA2ohMbcrkrObPsswvJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="399715009"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="399715009"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 14:24:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="776481748"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="776481748"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2023 14:23:58 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 14:23:57 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 14:23:57 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Dec 2023 14:23:57 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Dec 2023 14:23:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZc9dNwDLN+mJZ1kdNOb9vGWHotsDkY38JUfUKK0rwpVqd+QmM+isLDFZRBtr6/8XxwRXd+5CsCtZiLDxPeNh2YhtklfAc3pjICMicPSG60Im2oO8sAZUgmIpCx6JSl3RRlJdiE4lb4Uw+3HNaVsYof5gvhrrsrGISmWf7POxLJXy6K88PR3Z5DsJpfCdIkAt15mYm7FllishGq5o1Dd9GFFSAU4sttVFZaRS0JLotbcTa9FAJ5fZhmPTltgpELUEw9b7CrX5h1OyT21Sy5lCX0S8KFPJDKCE7FIg6v1B5FLbuCsuPn6l03vZP2FgSvJaYBDtuDbt5TsVzAaT8PxGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CjXquu0U88gb+G2FpmebLLDmHsSOLEuWGylgAeWezlA=;
 b=HkerIn5+RvDsccPne4M1jmP1DAMfA1q4bql8svpEHdpHJuLhLft9Jz6IFurNH0Sc6eFkA8OielMyK0GQJlrsDXrVKh5AgXlVlBUWR7OwCkJfWRgAhJZCvTTtuCGvM9hq195ts7KVgP38PEXcl3IHU0MJneddhxCkYdJ4fODBNqDn64DsInZ3Xkm0ZfCTYAgE38hHU5rzIJnBIZhPdj6eVArJuJH+yPcpBhT97DjYdBMhhEu6DKBEXJNQqZJPz9LLv5o5vuhpMcEJdpR45qyGJ1Piww6z0XZB4ZJwedsvQ7ynaCYzFWiVVZoiff/208bvSN/PvAVgG26kNKJviw6zvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by SJ0PR11MB4926.namprd11.prod.outlook.com (2603:10b6:a03:2d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 22:23:55 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::ea27:681d:ec93:3851]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::ea27:681d:ec93:3851%5]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 22:23:55 +0000
Message-ID: <24ed9131-584a-4de3-97b3-1f0e9e36ada3@intel.com>
Date: Wed, 20 Dec 2023 14:23:54 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 05/12 net-next] qca_7k_common: Drop unused len from
 qcafrm_handle
Content-Language: en-US
To: Stefan Wahren <wahrenst@gmx.net>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231218232639.33327-1-wahrenst@gmx.net>
 <20231218232639.33327-6-wahrenst@gmx.net>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231218232639.33327-6-wahrenst@gmx.net>
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
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|SJ0PR11MB4926:EE_
X-MS-Office365-Filtering-Correlation-Id: 38cab847-7060-45f2-7317-08dc01aa5a11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZJpy8pCaaqB/0G/zKhWtvrjq4Db8PuBVzEZKM4dKon1Lh4F3NXmL81+E+L7F5pooGgZDIn2yc4bvym8tIkeguphWW1tq686l6RMASSqhG+wj1czgZZKuPL/u8vb5L3AG/ALJOCujmeG2GAwYRft/rK7p54qzfD70k7Fcu9bwi/ufzhTg+W2mhDzjXNI5NGq2pkOsM9B1pJaunPqER3WLYkfsZK2nsghwhXpxHDkREdJux6k8OXyhTqTFt0Lon1vM5MTj7EGgbv5X5F5/ZMLEpWyDRNBhGocvtFe33H5Gx5o1/lklvZ/Sm7knwt/aiMmvlDeQR3AWJyFsc/OCXFHOd1p/k5J5MOY7kYTw/dc4vvPmx7eD/phAgd01qPsjrXplClyg1CXxJpZXqn5mON2CGNbSmkrTvDGxYlWH6VZDK6u8T+TP2sr27kx8Z3EiLwj8IgK036pqC68jQGDPYsRhDB3VTgBWD0cuxf2CCyLw/rVpMuobWZi8QONuhAGBkHKkB3JOW5rL6WKZ2sF/HCzWajfdVt9Qb3zNmBvuFWRLQIX2J56Q2RyVheyTA+Afq83en03k1YwHYJHZuBCNXjYDNDwaOfwc9Gz3rkI8a60cKC2DYGMWfXBrF7BRIsZsqCmfmfAnnjMKj9VWwjwSw5nl2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(366004)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(38100700002)(41300700001)(2906002)(5660300002)(8676002)(66556008)(66946007)(66476007)(316002)(4326008)(31696002)(86362001)(26005)(82960400001)(8936002)(558084003)(110136005)(36756003)(6486002)(83380400001)(6506007)(53546011)(478600001)(2616005)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1ZUNTRuNlROZlpzQlkzRTRYOFdrTU9udG1wYnF6S08yangwdncyYVdHYlMw?=
 =?utf-8?B?SVpDRUFycGVWbW5ibnpQK1NPVTZLTzI5NTFPV20wK2xvN2c2akFVSW5UU0Z1?=
 =?utf-8?B?NFFzZGRjeEEvMGJLdzZaOHJIcmJ3Rnk3SHh5WW5ha3d3U21HZlZIdHJ1US9v?=
 =?utf-8?B?Q3VyZm1aRWlIVFBBWkYrdEE2NXo4SE52elBDQVY1Y3dVMTAzRXRnS3luRTQ0?=
 =?utf-8?B?REp4T21BWkd3VjV0cFUrTjMzRnlJMXNvdWtvZlZLSFoxM0I1ZG4zS0wrZG9w?=
 =?utf-8?B?bnRxNnFXeW9DUFhlWTVCYlhjZC9nc1dzUHgyTUVSdDdzNHBna3ZhdlRYNkRK?=
 =?utf-8?B?b21FdWhCU3FidG1wN2l2bjlDOUxFUHZoQ1NrYTgzYU14L0FZSVJlbTNRUXFp?=
 =?utf-8?B?NkFpV2hqR0FES2JYRmIxQmxRRHB2TTRiU1BpRXNTaGIwZWI1dlE5QXJyeERw?=
 =?utf-8?B?REVjSmpIK0NvQk9SZTRLNHoxSWs4MGl3WWlZU1RkeWJlcm53T1Y5ZlNpM2pp?=
 =?utf-8?B?ZGFQWmpCdm1zdUkzMmE3bmxHVUhZWnBjLy91VHptVXdvK2M2OW9CdjFQZ1g0?=
 =?utf-8?B?djJTbjRMWDc4OExoQVdOL0FBN3MwbTFYekFGcVE4bCt0QS9OMW5hSU5ZRnFP?=
 =?utf-8?B?Z2V4eVprejl5NjNuYnhXeHBOcGd2MEgraXlJZk5EZmFjY3lqbmdNN0xMK3NN?=
 =?utf-8?B?djNENmtRWUl2MklkbHorNnhzeXlHck91UWVIS3JPWmZ5WFk4ZDZCcXFPck1Q?=
 =?utf-8?B?YW54RXFtdkxGNXAyVFhLTEU2QVJHT3EvTVRkY1VzMEFJUzZLRE56OUR0RTVh?=
 =?utf-8?B?OTZRVFNieFpMbjloNW1uM3gzY2tVSWhPVXAzVFVzZlZjaythbk9XeHIrRXFj?=
 =?utf-8?B?RWloL0x6LzhpSGl3TTVpUlAwVUlEYmFCR0pzRmFqSW5jNk1TTDRXVlRNN3JU?=
 =?utf-8?B?L2xRTHZTclpBSVJVNEFvdjhkd01odTV1ZzF6NU9XMzB5U0JzRTNtZE9kZG92?=
 =?utf-8?B?MDUzSVg1QkRSMDBpdXU4aUNYTWhlUkVLcWNvNGRtMXRoSGpNR1BIdzRRSGdp?=
 =?utf-8?B?YS9HQk45U3U0dk1ZTmJSdFJ4V2paZ2wvcXgyN2l2VXBxaGtOaGhhT1VOT0pl?=
 =?utf-8?B?SkVPeHBQOGdDd05ZWTJPMlZMUmxieVNENWNxazhpdlBUem5KWWprNGdpNllV?=
 =?utf-8?B?Sm16QVVoYWFFaHd5QnJja1FUWG83dW91Z29HMHRLdlpCamNDUGF6QWM0UTNR?=
 =?utf-8?B?WStsOTJycnFpdHV4dUpWT2VyVHp1cGFBUFk1TllGS3hWdEpNRFZHRTh6YVl0?=
 =?utf-8?B?NU43U3pRNStvNGxoOXV1T3U5cEp0cXc3Q3BMbk1FOWVNSjZGWU1taGFWUVcz?=
 =?utf-8?B?WHJnZlNDZ3pqeGp1TE01WGMwUGFsZGk1WWxLbk16U09BS0dHQ1FZWWNqUkIx?=
 =?utf-8?B?SWlENi9ROU91TVFDaHpWWlAwNTQzOUNCWUJ1QnY5ZFdjWmd6RDJFVVZMREdZ?=
 =?utf-8?B?QzVvL0V6T3FBK0IzcFJ3K1krNzdGWEk2c0RNb0QwdGI2cWw3UFkrTUwvTGNH?=
 =?utf-8?B?S25SajZFSjJwKzJ1cGZvUVBJTG53VXYxR3JFMmFReXRIaHhLOTFLRXhtdWRy?=
 =?utf-8?B?ZFdSR2Z2cDBDR2dsUXlTRmRiVHYyQlpBdU5qell5emUxTFBSb0pTUVJibHU3?=
 =?utf-8?B?SjBlNmMvSXMxNjdKYVJUVEhJa0ZUZHVzWDB2SDlRZlZkU3ZBellnR05VQWpx?=
 =?utf-8?B?Y2tKeUtpTGlMZTNBN3c2bHpwRWgvZTFOS1huQktNL2E4ZXJSNFFJemMxNVhS?=
 =?utf-8?B?WXdGVHNpeXd0VjFKQmdEMG94ODR1K1ZHeGl1RFNHK0hxMzVDdUVhSHRPc25a?=
 =?utf-8?B?OFFsRlZ1T0ZoZnh6dHpLOERETWZrYnZ2aFQ1K2VHMUxSNE41K3p1WGY3QjAv?=
 =?utf-8?B?L3ZPNzBrQTExNks2VWJIb1dmOVlWS2paQ0ZqanZDM1poVy9wTnd3WDk5cWFJ?=
 =?utf-8?B?VTU1RXFSb2hqdXFxa1RRU0taRHJwbXk5ZHZPdVhYamQwenZhTTExZW43Z3Jm?=
 =?utf-8?B?dVFSZlBDT1RydW96SHJqcm11U3dFM2srRDBPSnA2WUdycWcvQzc2WExJVWk0?=
 =?utf-8?B?b3R1ck5pRW9FWHFTWUdBaW95b1QzUXB2S01oYzBxV2VnWTB2NElxcloxS3dU?=
 =?utf-8?B?RFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38cab847-7060-45f2-7317-08dc01aa5a11
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 22:23:54.9312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M3XrwdiosqMD29q4/q1B8MTcewU2Znm5W4XLnmMWK07FVkkfZs2bvQKdu5SqigK+bHx7qkhGvUtigtrUsjysNU+LxPgiBMPjsioNXGQaMRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4926
X-OriginatorOrg: intel.com



On 12/18/2023 3:26 PM, Stefan Wahren wrote:
> This member is never used. So drop it.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>  drivers/net/ethernet/qualcomm/qca_7k_common.h | 3 ---
>  1 file changed, 3 deletions(-)
> 

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>


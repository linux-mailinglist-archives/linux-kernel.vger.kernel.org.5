Return-Path: <linux-kernel+bounces-7508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5208481A90F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2501F23A5A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566344A99E;
	Wed, 20 Dec 2023 22:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N66J5oxt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0564B5A1;
	Wed, 20 Dec 2023 22:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703111013; x=1734647013;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bQ07Q7MR/Phhnn3hqinfjw8Mel4QAkBm6NZgLqZ3Gqg=;
  b=N66J5oxtKdEDvDl2yvg8l2e2A6Ka7MMqukAHo9qzz3eVx0jn4f48t+Dt
   teIToTWfjrOth2thFwf8Q5ALWc5ECswODuPIzTTDc5poKHcAsH93y0o2U
   JsdlxaC0X4qCDYtYGuViJd9i0G1UN+KYCwo31QLNpznc7t1kFxSmNRgd3
   pIUgEXfrza/pI1YW11QOc/Va1mvPYregDp4nOYUnd2vUnvjEsY74+NYoD
   OgDPfga3D/fbNEmtVwIlKanAr8wic7EvOLUki/Qb8SgtGTAMe9d76wJK1
   yX5RpApdDxVT8vfrmjJGb5bgHcHvNgx9G2Xrlx70JWNSD23Ai2R/oMPko
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="2708630"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="2708630"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 14:23:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="842413124"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="842413124"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2023 14:23:32 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 14:23:31 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 14:23:31 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Dec 2023 14:23:31 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Dec 2023 14:23:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XrNLcTFau26lQXCPIOziBY6QMzIxZwAGVW0QKqZMaKZExC+bEFGz0SC5qW5kUXY8Sin2zDVwu0V0L8yLGiNdMarBwHgdoJPPBgcHaEX1EZwLSPlXAsuCQang39Mkla9C/xd15+mmeigcQiBJMy6jxRH6oIbMlONd5Ldsl6m4UEb2eB31K+ABMDXxJ/ZTXcpv/oKoK+k2RBuBE4krefMHm8a20E3oH/fl1sxvXndYEWU4oWX82ZPPP6o+HQ5nHnb2pkGRMDt6P7rQNOk00mPb5EfrH+k8Jdahl/0jhkbZFzoPj6xFnSwEy0jQBAPWbKglWPAZoa0o8Ps28cZin0v9Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnnLD9vWYJAx2gPL0fnO6C559+uXuZa7Y4H5YrTNDdY=;
 b=Der/L0tVzPPVTR64MRTF9gLdZWJjZNwQ5RyI5o4F5caOjc20pwAsQagaQU6VWfC2098IuHmGwq2LwniYzB9XQZRl2agx3N2CSb4fuzBW6RGAkWJMSB0HpJP9cfQbnne4b/oDTEABTAwmxh9j8YXLN3+Cu2SbSKtueBy4FaCoyJnJ+RiLuSpeCsi5EI/LLeNbUpdQrWr1vgn9eQiywff1r5hvJUPPVOd9S/8dUBOp2ZiPlr8OTT4qbFRYrNkKr4QaEfw9db5eFYCTTgqvFZZ10ZHZydVP0JoQUktskocXfhfb9F+nEB7IFN2mcZTQPyjYdoFEIawiYy7vyBBSTt14Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by SJ0PR11MB4926.namprd11.prod.outlook.com (2603:10b6:a03:2d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 22:23:27 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::ea27:681d:ec93:3851]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::ea27:681d:ec93:3851%5]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 22:23:26 +0000
Message-ID: <940c4d0c-b354-4d85-b1c7-b290be1d0d19@intel.com>
Date: Wed, 20 Dec 2023 14:23:26 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 04/12 net-next] qca_7k_common: Drop unnecessary
 function description
Content-Language: en-US
To: Stefan Wahren <wahrenst@gmx.net>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231218232639.33327-1-wahrenst@gmx.net>
 <20231218232639.33327-5-wahrenst@gmx.net>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231218232639.33327-5-wahrenst@gmx.net>
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
X-MS-Office365-Filtering-Correlation-Id: 49da782f-e393-4aa3-8c7c-08dc01aa4965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i2PSuLJoCz0djwupmpBfBDsZmzF2Ugkmq0jLZ5uRLC71Y7NhZUAFHbFO1ji/P9KQW5HFs08ejZA3lHzaDwqKcwaFBiK3cyFtguHvNOvnG/h8tkT7O9Ad7sXEcOvc6GQ4JbORNCHL2b86wsgoZsAz64Gc8fhUfGdn+ZVN+Qs9g7dxxDi4kzOZaMVTZ/kt3xBFK/ncQMv0XrJ0dY6tVpRmP8bq2NjSfvxiRtafsEvXuM8p6Joj5Ta0q/SQhH/aVYvxarvcKGOtHkNRJ6bT/XhbpqUGwOs4I716EZjeK/KtT8t5M7ofmVDNqYJiB8wRaZpnIfb6kqH+CNHCLM+VbcUHtUmSNf7iHMo5usvBdrt+1LZ4L/K+GGCRP+0Sgj24vfElAJJZGh0OPI8Vj0TlYVPYGPa0xL6IvpTwWyP5o+3F9/x5IMdpy4jpjkId9vSkWXYqhoiUw2ggs57y9DB0ESSU6K0gaVKrDLCIS9eVyJNfJmse34Az2LydOfkjK39T5kEAR5a4DMvzFwhG0RxiEboEfW1SnZvdDfGPYFn68KG5KEzadd5sPh3WRGZT5gxTBIPDHsiWF9Hd/vRkBeiIdQp0fWUlmr9DsEXCxcF01+0xpud+4xAa5nNFKe+CbRWRvJoMXQ1Nx0x1jpYl7BoOtRKJmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(366004)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(38100700002)(41300700001)(2906002)(5660300002)(4744005)(8676002)(66556008)(66946007)(66476007)(316002)(4326008)(31696002)(86362001)(26005)(82960400001)(8936002)(110136005)(36756003)(6486002)(6506007)(53546011)(478600001)(2616005)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEFDYkIvbVFwZ0RUOXF1QU5kaS9rNTVDRnJZRXVQcFVabFhMYndnRnZHN3Fy?=
 =?utf-8?B?eUpRRUZVKzNzUzkrWWgxSjdTTms0c3N0WitvN2tEZTVwSnhmbk1TalFWK0ta?=
 =?utf-8?B?NGQ3byt4cFFjMGh2RnZhYkZYSDVvaVg2KzkwMi9sa2xEdjErYmJOWWdvbzRq?=
 =?utf-8?B?dWtsUklZUkVRQUUwM3JzWE1lWXNKWjBYODJOMkpSTzA5c2kvNjVDV3VCUzFI?=
 =?utf-8?B?NEpUdFhDc01yT2diWE1YZ0pLZHZheE9GdUVoMGtIUUVSaU8xVHh6cFZiY1VN?=
 =?utf-8?B?bHlvNXlrL3lLbk5SUTFMMGo1bm9zMjNxQkxpRmlBWkJEY3NScGgwTjJCODNl?=
 =?utf-8?B?M21WNkNCcmZxOHlJalJXQVhCQ2NYQ1h2aWdYTDgvY0RkdEl6YkoxSlBjNTd4?=
 =?utf-8?B?L0NSS3U2eXAwTGVwTTR0SURxWjkxajdKV2c1S3Y3eE1yKzlyTVBkRVlZTmdj?=
 =?utf-8?B?K2JrTGJ5Z25WRmR2RTk0MzJueFFuRHBmTzFHZTNOdkRPSG5keWp3REdqWUIz?=
 =?utf-8?B?SWY4VTlqZGNxcTBsZ3F0MmlXL3NHQUMxK1RIMW1oakNnVWZSeURRWEh6cVlN?=
 =?utf-8?B?MnVJejc0Q01yU1RtQ0w3ZldUYzJWNnlKVmQvb0VuQnA5dWZENFJ6WHVhSWNq?=
 =?utf-8?B?QWVwMWZ3bWY2VjJEcnlnb2hLRnptbzlYaW4rcGNzZGpIQ3A4WndkMWQ3dnRW?=
 =?utf-8?B?OWdnUVUyd1NScWd1VzlnNmRzeEhqZkhrME1YUUhGMzlYbml5ME9JdmJTZkxy?=
 =?utf-8?B?dzdzSTF2dlNnL1Y3c1cxMDFWK3VEbC9mVFBiY1dselFGSmtlOWFMclFJbWox?=
 =?utf-8?B?NDRua2tuYzVQNFFjcUZEZ3cwdTZMZTY0dEpGNWRqSmNoZUlXd0NML1lXS2h4?=
 =?utf-8?B?L2tkVXFOWUdHYmlONjBPYTVPN296WUluNmJYQkJkNXNWcnpYWGRCeldUR1Qx?=
 =?utf-8?B?aVhOR2c0d0huUVgrTHgyNndJTDZkVG1IZ1VCMzNSWVhxUjBZbW5jc0NnZ29z?=
 =?utf-8?B?dXJlenc5M3lHcEs2V3lhMWNCWkNoOUhvQjIvRTQvVld0djVmZ1hrQlFzSEtP?=
 =?utf-8?B?NFlQV1YrQ1pRSlh2eFN3QmUzSS9scUM1MEhzM1kxN1BKdzR6SXhnMkdzaG52?=
 =?utf-8?B?c0V3OTBDRFlNTVJpSzJhRS8ybEFSRlpCaXpOOVZSMzZPMU5RNUtMeDU3TUdG?=
 =?utf-8?B?MU9wbld2TlpDMXEyMlpoTmhwRDNXRjFUK0RXKytIbFE3RE4rSUIwRnpOQy9i?=
 =?utf-8?B?UkRiQ0NTdUZpSitpTTNpSVBVekV4TE1UQzVKdnNkY3hqcGk1ZFhpajZXczdD?=
 =?utf-8?B?dCtDSkZLaXZwcUhzSHhGWTlRY0dDbnpxL1JmUGxydk91TlIwNWJudjBsV0kx?=
 =?utf-8?B?T1RsbWM2WTRLV09RRUFaang2c1VZcnp2S1pJa3ozdWxNS2djWWUyVVR2amMz?=
 =?utf-8?B?RUkwZHE4U2FkMUpycEp3VGNGaHZCQ2dNTUJTL3pyVFh4b1VaZ3RvWXV2aTU0?=
 =?utf-8?B?aThreGxaakFBKzd5U001bVJmV0w0dzZVUDMvYnBhT2xEYnB1a1NkT3pGenhn?=
 =?utf-8?B?RUZQSW5TRU1wQXNneFdyYjFWUTVzZUV0WHU5K1ZGa2FTQmpVR3ByZFNZZlVw?=
 =?utf-8?B?UDRPTWpDSEczVzUrUjNiVXNpK2EzUThMbWMvUXFFK1Rsekp2TWpYdXdtQmly?=
 =?utf-8?B?Y054SUJvT3FVMnpGbHB3SUdsTHgvK25zdDZ5ZkV0WVpiL2lySW1yMDc3TkZT?=
 =?utf-8?B?NndVVUdWUFFnbFFVZ1l2SHVYTTVOOXZMRlVaeTNLb2FkcEtRVjlNVzBEaHUr?=
 =?utf-8?B?Zi9GdXB3YzlnTkJPRGdjT1duT0cyMURzTGdzeGcxKzJOR2t1VjNLcTZkRmt5?=
 =?utf-8?B?dWUvRFoxVGlLR0pMcXRKbS9mWXVzcGxndE5OVGpYSzZQZCtrM2tHeDJ0UFg0?=
 =?utf-8?B?VWxUUUhnVjJ6dWxESGJ0ZUM4NlU5aUxnamxyZXFGUEhNRGJDZE1DZ1k4T25S?=
 =?utf-8?B?V0ZLQlNKMmlXY0dxYjFRZjJvR2JpLzdoWXQ4UVJpSjNnTTRyQjhXTFBNWEJz?=
 =?utf-8?B?Vk8yOFU4Q2dzY3FqT1krWlNqQSs1N3BWUnZrV0k3MTJMa2NwaU9hQ2V6cGd3?=
 =?utf-8?B?K3dJaE9zUGNpYVBBMWZhd0cvSnUxMTBLK0h2K3R0SjMraXVIYStyTDFPSDdo?=
 =?utf-8?B?Nmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 49da782f-e393-4aa3-8c7c-08dc01aa4965
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 22:23:26.8909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eGqkYTKeC8lyu9+3hX+CeDdUY3cKof01NIjb4ZEUAHH33td4AS/BHiayA/4aVPtf86mVl/q284KwD8z3Lsn5maab8cjlD/rXPdWAkL/Peao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4926
X-OriginatorOrg: intel.com



On 12/18/2023 3:26 PM, Stefan Wahren wrote:
> qcafrm_fsm_decode has the almost the same function description in
> qca_7k_common.c. So drop the comment here.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---

Better to have this in only one place so its less likely to become
stale. Users who want to review just the doc and prototypes can generate
this from the kernel-doc. Makes sense.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>


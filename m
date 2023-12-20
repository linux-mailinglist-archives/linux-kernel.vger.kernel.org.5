Return-Path: <linux-kernel+bounces-7614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4CD81AAD4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 764D71F26DC7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DD64E1DC;
	Wed, 20 Dec 2023 23:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U5EQmxm8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B794BA8E;
	Wed, 20 Dec 2023 23:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703113239; x=1734649239;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sGF42XiDl8iUvhs0Y3aAPpd1bxxnsiXqP8hsfhlQYP8=;
  b=U5EQmxm8sdCsPfkGfKuBdqQC1SKeX0W6tVRtY7DczDZl6fEBbYtkHJ/t
   kysrLaeC0rUzLFlZU4DlJgQaSVyRXlJv/VAIpdYMW1zJ2+tf0cYLiHeEK
   VngPzMQKyh/cRnvyY641SIIlwac1V6IyoamVXt6fLjkWCG0DqdsJrHJKZ
   U3usg+q1LBupuguUoUX2YrJ1hz1cPGzmLlXxS4y+IUY1AFlSRi56CHsLi
   yNTZt7h4J7U38UaWZeZuBr8ZggTzpJH0yZwbi5WejBfKc+w6ii/AWJnrz
   oblSLdGOa4nUj/Vj+QJxuymJ+e1kIBfAHY4XcJvTR3xC4eGOR7gdchcX2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="380875421"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="380875421"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 15:00:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="1107877426"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="1107877426"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2023 15:00:37 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 15:00:37 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 15:00:37 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Dec 2023 15:00:37 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Dec 2023 15:00:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PY6bQheonejB6yPHX6KWW/YR+emVuQQfb1Xcs42lFliSFZkruQrin1ucV3PueSEYPTKNFU8oL7axG11Xi3bk+LAApD1YROMtr7bFN15oeSG3S9okMx/oD52JwktDrsWntNQHH1AG/okXb8FtG3c9Qi1oyMl8tLeDrTfByp+UYxjbapMpHD707ol7ZdYOzh6R8MA86CkqyPjtI5ItVshyaSdHZpDN0abWTjBO+EgkO2+d+cx+/GDs+KkKyfQ5FVxrp5LDWXUMEo4XQZ2jjGFN7kfwzQU5yixgXgdV2Wx9n1sVqsd5YFAf0qhJ2k0z9ALNO6qG+Ty7ezzaLVHSQs1hBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IwJ0MAHiLVQbryxL+HzpSYdpva7UFj968rq9jiRZIZ0=;
 b=d6zZIygo+knSfKELhuBvZlAkHQYVYYDjpxpE7YfqGCDCg/YMaG+vvuftkph9ISkIZZi4sE4NEshviwLPxx4U9ob9AGaqsIwx58GpHq972mGRa06TESlkuQrpq8zN04+DbskMW6MRyo4uDzOUeEPtKuEk2r7AKL+2GrWZE/ZEnYrAkdcDiD7VWlYM/wPNm30uIus6iBTt387gmOB/DHTYSvolOEFzxAOGqvkjcr4kiu40C7uRfeXhgm8UpdKTQicurYvSmUE5VA7RDyWNzHzAvBPbi2VX2xC42e7mFoXsPIJKCpkI1f0enwx8QS+bH3ZOs3VRO89TWkVpvtS0O66nxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by IA1PR11MB6073.namprd11.prod.outlook.com (2603:10b6:208:3d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Wed, 20 Dec
 2023 23:00:33 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::ea27:681d:ec93:3851]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::ea27:681d:ec93:3851%5]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 23:00:33 +0000
Message-ID: <04e4381d-0b74-4bb4-8c53-093b99bba3ff@intel.com>
Date: Wed, 20 Dec 2023 15:00:29 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 08/12 net-next] qca_spi: Improve calculation of RX
 buffer size
Content-Language: en-US
To: Stefan Wahren <wahrenst@gmx.net>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231218232639.33327-1-wahrenst@gmx.net>
 <20231218232639.33327-9-wahrenst@gmx.net>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231218232639.33327-9-wahrenst@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0306.namprd03.prod.outlook.com
 (2603:10b6:303:dd::11) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|IA1PR11MB6073:EE_
X-MS-Office365-Filtering-Correlation-Id: 7331026d-78ed-4a1b-97ab-08dc01af781c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mTcXp78i1KuEmWyBqX4+cY7dxj0GC0zNrvMqkytKVQPID9hofoBCgFzsHF+6S0rAgsFCm9dXaExpfxsifYywTlJaUl1rSEGd/ZFFLrMrQ1x3jBiR15Su7x5rY2PQ12tgVJaxPwHUpEXVJPqRL622K7X0Mj3m69tKm/QTKdKZNpqYOvEoa/92g/kKPSRAxEQ+mrzF1hSrvDUIhPEKtCo5LiMUxiymoAo5Ty9VPikmF/spSPYI6JJ74Qz/+bFEw/qEAOEO6otjopAsFd5/46SWug3ZuxM+zgKnTKA6ifhUWD85qzIee/a+0KoR6/FRO1w8J03nw/EXOCoDRIaTUzNGs09QK64qux1UOyb3/v4GlN7f7+cbqP8BQCwll3q56oF9n4FkFWQfnYp4Xz52foA+iWuBU/PQXiqj229i4xjAC8+uzk7Cm0SGlW64M8moNOOuu2iMSEJFOsbo3Jx8FNtwXuK3MuMarVIrNS6uUBXjkPSL4MhKULn2e3X5QDDsjtAEputNDVa7mvcVci/jk1PVK8tBhbqFx9alr6itXnIyK0gIq41/cwdgI0Bhq0Yf6fXrr5yFAppvk+Tus9qwoOl50TvTdvCriiI42ODfeAODJY6Whhsy63cmooxtoqvIQpEuCQ6tZRbAdBUjTRk2J+eMOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(396003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(36756003)(316002)(83380400001)(110136005)(6486002)(66476007)(66556008)(66946007)(2906002)(8936002)(38100700002)(8676002)(5660300002)(4326008)(6666004)(6512007)(53546011)(478600001)(86362001)(31686004)(31696002)(6506007)(2616005)(41300700001)(26005)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXRjMUZFZmJlOVY0ODBIRE5aK25UUlEzRHdYUXJxaUhueGNpdzJmVUV3YXVv?=
 =?utf-8?B?S252QTg5MXkxeUtwS0lVZTVaYmI2YmhFMmdQVFRscGowUDI1WXo2ZnRJcUZS?=
 =?utf-8?B?Q1JkYVl6cjdjem1WekhYTXI3V0ltN29ILzhWR1U5d1pTWUQ1UGFBTWdDSHkr?=
 =?utf-8?B?bnZpVVpBNnVDY1M3aElEaTd3OWdxYndGWnh6eXYrY3lPMUJNUzloblZiTHZx?=
 =?utf-8?B?UkcwYjlibDVaOUd6MzRvNzBFMXo1bXFwaWIwU2QyUjdFcEdQRzcvTmxOMHBY?=
 =?utf-8?B?Y25UWGJjSVFuSTYvL1FXSk84NzdSYm1qZHp4ZnV2Q2Z0SExmajRrT1Z3SWNW?=
 =?utf-8?B?L0VrcUYyOC9CMldBaXdxK2ZjNU1XTnIzMWV3b2l5RXIxTTJjUzJwVktjRjJR?=
 =?utf-8?B?anRVd2owTEFvN2tDNW1qK2dvQ242Q1JTYTQ3QzVMRWtwODkyQ0k0Ymg5SUQz?=
 =?utf-8?B?VnR3dnNvb1Z1L3ZkOHYvOXdNek5yYjZ2MnpKNmlXbUMvblRrcm92VTZUK3pr?=
 =?utf-8?B?WFpzMHlQaEVIYmVnZURNK3BDdjJGN1A4eGQ2aTFjTXd2Qm9uZ20yd2JqeE9u?=
 =?utf-8?B?KzNaL0ZGM0ZubnY0NVRDM2p1Ky9wYWlVSmV2OTNVQ2JZZ2ZjbU0zRWttNzFu?=
 =?utf-8?B?WnR1Tnp0VnBFS1V4ZG5kdkdUKzArRzRzenJ2YzZ1bVFPRFZvS09UbUoyWXVS?=
 =?utf-8?B?bXBCZEsybDdkZlRMcDEyb3FpakluY0gwWXQxVll3ZFBTTVlOU2Ywc05DdFZW?=
 =?utf-8?B?b2MwMFc2OHdvYy9UL0JhVXdPaEVseC9DUDEyNU83VkY1T3pCRjNiTHkvMWJ0?=
 =?utf-8?B?QXB0WGFnWUNKazlxMUMzQUkxRFU2MDFOMFpaYnh6d3lGZFZrWi91ZjZVT2NF?=
 =?utf-8?B?Y0daVTFzQ2RUOG5CYXptMFFTSjAzUk5yQ0dKQURqWEdTZUx4bnhHdXlPNGFo?=
 =?utf-8?B?VFlScDlNNU5tRlZJelRsN3VZUFpIcUcrU1JMNDZ1THVNRllISzFFRWdieGFO?=
 =?utf-8?B?d1NCQTdXb1NLbTJkSHo4aC9JMzRUYnJIYWpzalNvem0valRxRktHV0xtZU02?=
 =?utf-8?B?QXA2VkgrcVN4R212Q1BLemF6YS9NNVV4Y2RCSUJoZXAvUlFlQ3lmN2NlL1NY?=
 =?utf-8?B?MjE5V1F0T1h4Z3YyQ3pka3p5SDRWcDFZNXdmdWxPQWVpL04wK2JUamRVVytD?=
 =?utf-8?B?dkhtU090SkZIRkd4VkpiUW1nU2wwNVNWR3huckFCaHZxSUIxem9KVHVZNVZq?=
 =?utf-8?B?dC8wcTJpNXJiQnVCRVYzM3ZGa2pRL0FJR3djencxeWVtYnZEMjdRWnhYWTN5?=
 =?utf-8?B?eUJDTzJ1a2ltMlJyUnYyWXYwU2xuemZ1QjNISVVpWW5xZlRINDJPL2ptUDk3?=
 =?utf-8?B?L3hCN21SUlJ5U05mTFFXYnIvTXdaYWxnOFA5L0VUTC9RbDFZSXJ1YktjWk5X?=
 =?utf-8?B?MVIwSFZlRVRvTlBDMU5VUmJKR3lOVDhLeFYxUVE3bTZyNzZXYllQdlc1M2Nm?=
 =?utf-8?B?T3dySlY4VEE2aTZMc2R3aVZYNjhiOEwwSVVCQS9FbnRSSm56cVFuKzNORndW?=
 =?utf-8?B?Z1ZRMndDbU12allkSVFKQ1YrQVJ4ZmkwQVBjQUt0OUZpNzF6VSt4QXN6bVYv?=
 =?utf-8?B?cjhnWXhOM2EyM2dScjFpT0dVcWZBZk11KytWZURCVno5cmdTNVA5OG53THIv?=
 =?utf-8?B?eW04ZmJrMnF2aGN6T1dWRCtjNU1aam5YS3c2a2dzdnduWUFveDl1RDJ6RWs0?=
 =?utf-8?B?THJIK3JwVlhaVVFib3pQRlpWdFZlSzZZZ3ZMT0QwUUlhL2hCUFpiQmpaNDM3?=
 =?utf-8?B?UEhGdHlRVTlxYkhIUVEwalFEQzcraWgvQlZ6Z1BnN0F4eVMyb0ZnN2piRTF6?=
 =?utf-8?B?amtRQTI5Q1pxSkhCZTc1MlBFMXJTVzlKU1BrL1AwTythLzQwbFlXaUNLUjVp?=
 =?utf-8?B?aFNITTFMbUVtMlYrNjc4UEx1NWdyRThuZzNJKzNDSWU2bmxrT2hDMUxrQmU3?=
 =?utf-8?B?c2dHeEF3akt4VDVtanhObGsrNGhmMHFKSlFTeWg4NTVXUTJxck04S212YmZp?=
 =?utf-8?B?bDA2VnlLTFFWY1pmVGhnWFhQSFdpQWpXcHQ5RU5PVWp6dTlQVTBFVENpTXpH?=
 =?utf-8?B?Ni9VcXNqenFXZzRkeVFKZWpWR0hqdUV3UzVHOGJoK3gyUzNjOThwZC9DRjRX?=
 =?utf-8?B?VUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7331026d-78ed-4a1b-97ab-08dc01af781c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 23:00:32.7727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XWqw4tD2L9AtCFeAvhkYJJ4r9Te/62k48TUL53/WC2Yy7KH9NqoZk5l2/QdWhbJV2FfhJgkFv27kkfUZtecriu0gbglxXickuHwRwZYm4yY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6073
X-OriginatorOrg: intel.com



On 12/18/2023 3:26 PM, Stefan Wahren wrote:
> There are two points with the calculation of RX buffer size which are
> not optimal:
> 1. mtu is a mutual parameter, but actually we need the maximum possible
>    MTU. So better use the define directly.
> 2. This magic number 4 represent the hardware generated frame length
>    which is specific to SPI. We better replace this with the suitable
>    define.
> 
> There is no functional change.
> 

This is a bit confusing why you said no functional change. At first my
thought was that dev->mtu could easily be smaller than the maximum MTU.
(thats why its configurable after all?). But actually the diff context
cuts off a few lines that are extremely relevant:

>         struct qcaspi *qca = netdev_priv(dev);
> 
>         dev->mtu = QCAFRM_MAX_MTU;

We assign dev->mtu here to QCAFRM_MAX_MTU

>         dev->type = ARPHRD_ETHER;
>         qca->clkspeed = qcaspi_clkspeed;
>         qca->burst_len = qcaspi_burst_len;
>         qca->spi_thread = NULL;
>         qca->buffer_size = (dev->mtu + VLAN_ETH_HLEN + QCAFRM_HEADER_LEN +
>                 QCAFRM_FOOTER_LEN + 4) * 4;

And then use it here.

> 
>         memset(&qca->stats, 0, sizeof(struct qcaspi_stats));
> 

Makes sense to use the constant directly.

It might have helped to have a bit more of this context in the commit
message, but its still a good cleanup.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>  drivers/net/ethernet/qualcomm/qca_spi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/ethernet/qualcomm/qca_spi.c
> index 80182f8a4a50..6d2859aad921 100644
> --- a/drivers/net/ethernet/qualcomm/qca_spi.c
> +++ b/drivers/net/ethernet/qualcomm/qca_spi.c
> @@ -813,8 +813,8 @@ qcaspi_netdev_init(struct net_device *dev)
>  	qca->clkspeed = qcaspi_clkspeed;
>  	qca->burst_len = qcaspi_burst_len;
>  	qca->spi_thread = NULL;
> -	qca->buffer_size = (dev->mtu + VLAN_ETH_HLEN + QCAFRM_HEADER_LEN +
> -		QCAFRM_FOOTER_LEN + 4) * QCASPI_RX_MAX_FRAMES;
> +	qca->buffer_size = (QCAFRM_MAX_MTU + VLAN_ETH_HLEN + QCAFRM_HEADER_LEN +
> +		QCAFRM_FOOTER_LEN + QCASPI_HW_PKT_LEN) * QCASPI_RX_MAX_FRAMES;
> 
>  	memset(&qca->stats, 0, sizeof(struct qcaspi_stats));
> 
> --
> 2.34.1
> 
> 


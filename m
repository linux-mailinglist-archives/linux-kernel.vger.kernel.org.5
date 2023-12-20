Return-Path: <linux-kernel+bounces-7618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9EF81AAE0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55954B24E0C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DCE4F60C;
	Wed, 20 Dec 2023 23:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hO8xc0UF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4404C3C3;
	Wed, 20 Dec 2023 23:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703113416; x=1734649416;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7J0c/+FRED2B6aGoa0sdjDhKNnMcreY3bHd5Wn7kNko=;
  b=hO8xc0UFdnVr0SMMKNJP9+1SxtnYW7go82m0mglJK8ioXVeL7g3htEzy
   YBNbmZRuCunZW9+RwPA4ipEbbaHrDAnTnTQ3cIzHa97ttjfXn9u1DUUkV
   iAxUZeOc0tCRM06gqMSVQ8BfWYN0MdpxrnaP5Ww/PMRuK9gTWVJXGePOs
   5xUF64tQRNmmTcuAO8Lbji5F50EHiBJo4kkTdTgJw05R9ZLrFTKPZKm4p
   V2geek3BQbJMWbDTqfyCGi/13kGh6ym5Og60HctIv7c3Tu8NtEm5/ye3F
   peyAd0mY0Zcy9DXwmM7QSp92biaQwWgt96AX/vFIWyQre82o2ll4JB9sR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="2712450"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="2712450"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 15:02:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="805406800"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="805406800"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2023 15:02:07 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 15:02:07 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Dec 2023 15:02:07 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Dec 2023 15:02:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBVCjxpxN+eeOL7tgsxsg38IWwU15sz4ZJwso56Aurc3MDc3wawEaQifciDF+SuIqycBgCLxl52H6ITXZKuMAPVsXFZx+r/2om8iew2nMvB64J22IT88O+Gc1tB4m2VRp/OISIUH5iw7h3NgOYropCVyB19yf1c9n0z4jfXfQKDukeSYjZjJTO8RsxfoRbE8q2x1iSXdv9hL3O74g9OIV4/7/XIAnKgwW04qu1vSs3m4e8niRN/Ryhlvu/BnGn//Ixn36TbRMPYCjQcpwpzLPfiRQQn1Zwrd6kIvFTohc5odjaV9D66Til2dFS+6dFSkBYxUTVbc6nxRe29oLcmrXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkCPetjHqhLEnpov4aWWB7lL2RDPvCUuQQYri7ZPGlU=;
 b=kQvUGNY5Z160jPvgvEFvsD6wqu209XPBwr6kD+lRLn9lkZ2rZia3NN0izADb5iKuzUgeE0qkfwLab05AjyGk0DqL6lhLq1HA6oYc2C84z5OENOUbvTLODoOI3PRWL0L2z8vLT4e0osnVjdEE6BYb6hXl2MRDh7nuf/nxbdUDf5Zrq6G14FyOcegj4cdb9Ws+2n23f2lSukmhw2zwmMLjMT/hMXk08EE4xUOiILA4LglzlHE1iVI8/xyumtyDBqCKmC90LGNp5oICM7ry5vv9aP04mtnC/ENYNSi3QY1hj/NciO+JondgNBwgMLUZtic5EXRb0uqt3+YW40HbUX+PmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by IA1PR11MB6073.namprd11.prod.outlook.com (2603:10b6:208:3d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Wed, 20 Dec
 2023 23:02:05 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::ea27:681d:ec93:3851]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::ea27:681d:ec93:3851%5]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 23:02:04 +0000
Message-ID: <115635f1-584e-4db8-ab41-2c0e10e8b784@intel.com>
Date: Wed, 20 Dec 2023 15:02:04 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 10/12 net-next] qca_spi: Adjust log of
 SPI_REG_RDBUF_BYTE_AVA
Content-Language: en-US
To: Stefan Wahren <wahrenst@gmx.net>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231218232639.33327-1-wahrenst@gmx.net>
 <20231218232639.33327-11-wahrenst@gmx.net>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231218232639.33327-11-wahrenst@gmx.net>
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
X-MS-Office365-Filtering-Correlation-Id: 6adee0a3-6d91-40de-134f-08dc01afaef8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pG4J5hisquiUXYyL4Gy2QInO4at8aZRTqiHzYlnCNIWDqwMZlnkpGgxddlLIu8+WvjYbzT4ms7y0mIWxgfBYNgvCkx4XmReLwhydL80FBbfCihagtjO81DPSYE1LYsDuvll7bpCQxrGlmleJMY4V7rqTjSkSTVPOzltDFTxpFGaNXgl13CELungYxx9DjimZfebfoTeILcrF/wR58c+K/wXu3q8oAWri2fjeZk9C8rV/QPZ0RNW8cyS6p9zmYsW1NomGywkMIMkQt2YscEy7YaomBrwYiIdILVQADoiF9uyF+kb85pBTsbNkwH0oIXIKgSRNTPdYO92Y+amIMyfDzXFHRadAFQDWy71pFExutOUcQSqzBDFIyXHbPnMvtOuRHwd64BOzmJuizc6vXHHEtNchf17Kcu4A+veOJRrTuRZRM7tQQgCfFILyRXQSdXCAK3uV5BIjBxRloQTdXsfpQeJ5zMtTjQu6Aeleowuk1YzRvHYw9Uo8sqq4+I2kBOxsALV7QEYt4eak8PmJo6SAHSuK/uzhSCIJOqi6sd+0RxaqlziYN78OuXy+oQS9YEDvByv0PNXgGtZOekpnSOKHKZJJgB3TIve9oEy9f/yzfjT1LZi0nP5zvY7jvXCUuk9ygLGQP/wnBDincftLPU/a6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(396003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(36756003)(316002)(83380400001)(110136005)(6486002)(66476007)(66556008)(66946007)(2906002)(8936002)(38100700002)(8676002)(5660300002)(4326008)(6512007)(53546011)(478600001)(86362001)(31686004)(31696002)(6506007)(2616005)(41300700001)(26005)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGl6VWlVUEVBbDhSbU95bU9EQmFIbnJyL0tUOTh4TFo2ZUYxQ0JGdDU1R1F5?=
 =?utf-8?B?Q0IzRFFHU3NLdWJwZUw1MTg0SVAzM1crbktGd2JYcXppeDFrUks0Q1lUdUlO?=
 =?utf-8?B?OHVGSkRVNnh3T2E4V0JTck55bGJEYjYwdnU2NmVlZnpNMGxwSjczSXJVaFN4?=
 =?utf-8?B?Vkx4TitCdWRERHo3bWlwaks0Z1NkUDRRWGZEK2Q0RmVvcjhST0RPUHZHMjZU?=
 =?utf-8?B?T0dQc3pmM3Jxby9LQjUxYk13Ky9hZ0tSaURGM0swM000QTFDVEtxVHkweEh5?=
 =?utf-8?B?OHZ2K0NYSnpHNUN2NGFzZ3FqRlBqWnY1Rk9aYUhIUy9GUGMyQTk5OTVhRzl6?=
 =?utf-8?B?TEw4V1Q1RU9yay90NmoyU3dmaCtEcGdlK2xqR1NPdGw4OVJkUDRzVVFYbGFr?=
 =?utf-8?B?S1UzeG5rbDI1U2hsUWNZSEo2NjFYWFlMdXcwazdwYzFhNFNER2IzQUh6TWxW?=
 =?utf-8?B?d2ZSbWl4M2NmNzhLOWRxSStXYldYVGFVWWJPNGhVOEFCcWJvN3UrMVdITjAr?=
 =?utf-8?B?MXFqRjk5SEpnSzU1OHBOd1I3SkdlTUhWY1lpWE1EdUdyKzJ5YVIvY2VDWFU1?=
 =?utf-8?B?UEFSWmhBZldGVkhmNG4vcEFDYkJSQk5SOVVScVRGTUNaTTlCM1E4Tms1TlB4?=
 =?utf-8?B?di9ORVpaQlFXZWVESUFiMFNkRElNV0pWTUFDWFdLUEJUUFZMemt4K2hodm1m?=
 =?utf-8?B?NmcxSUpiMUhUQmpUVm1hbW9wcmptSHZxUlFVNHFHb3pmOFVPWWExRVB5eVM2?=
 =?utf-8?B?M0VIZWd0TlVRTU5FZ25oamJtNU4xNmRvdFdIb3lNdzFjdnErUkVtdU5aekRM?=
 =?utf-8?B?NUhXbm8rVzQwV05BWXVjcEdIN2s4QmZFUXhoMGlVZEcwNkpwdGdyZlNYYk1u?=
 =?utf-8?B?dENjZlR2NkVseFQrVVJEUGRjR1NCSjRham9CZXJqaHJObWJLb1dhVXVhWTZm?=
 =?utf-8?B?UGtjWllKSGpUV1U4YzNqMFhiRlFYTGtFaHlwb0psSkpxVFJsZzJDNWc2QjRG?=
 =?utf-8?B?NzB0cmk1Wk0xNEdJa2xmZ3ByY2NQcjJkMHAyVjMzRDJzSDRRQitXV0lFSkhI?=
 =?utf-8?B?NUljTGZ6MVhEU1Y4alh6dEQzc1UvVXYzcU50Rmx4aWhLNDZFdm5rakwyLzNh?=
 =?utf-8?B?R0pEc1ExWWd1NXZMT1VsdzlJMG9PK1l3cmVWc01Na0sxUTl2U0lEcWhUVFBi?=
 =?utf-8?B?bnFaRFJ4SWxRWWdLeEpOZDRGOGlMZVRTUkErcHpjWlYreDhhRHdGZU1oYS9S?=
 =?utf-8?B?ZWJ3UGFUT1FUV29jWnJWUmpEZFFFVFBXWW02TnRWYlFlL1g0SFdZVEo1TGJU?=
 =?utf-8?B?d2I1ZmxmcVJkMlVyeXhRYmpsTFg0RVZPVXBHNG95b1I5MjRPWDRWb0h5Tkhj?=
 =?utf-8?B?dlhkemtFVFlQZytENERxYUZZdmFSalhVNVZvNy83czliWHNXTklMaUxrZWpQ?=
 =?utf-8?B?Z2YyYlZ6UFJvREVYQkxjN0ptWUxseElwWnJZZDRyeHMwVW5tM3NjdWJvaHF2?=
 =?utf-8?B?NWRoVm1kQU1zeXBNVk00bU9iMk5EVFc3NDc0bER1eWRaZzJ4UU5xMFBERFk5?=
 =?utf-8?B?TzdYQ0xDZ2I2S3JSK2ZaeWtrSnU5S25VMGxVcElXc2J4QS9ZRmVMdmJwSFJ0?=
 =?utf-8?B?WGhEN1o2RFk0YXRJanoxbGJyTTFaNUNJaWUxeXY2cmRPOHUrRUZDdXoybDlO?=
 =?utf-8?B?TC8vVzdFZnFjbTdMMWZRcys1TGY1d0x0SGJobFNFbVV3RStiTEhPdnRuZ1RP?=
 =?utf-8?B?WXZTa3F6Q05GTUNmSytVd3JKUGk2MDhMdGRhbkR0WjdyV3ZwcG5XK0prWExq?=
 =?utf-8?B?ak93Q1lFbUN1MXE0Y3Mwd1ZISTRaamxoZXdRNFhJcmFDWHVqOE01cUhKdGhn?=
 =?utf-8?B?OEMzVVJXWVkxZlRjU2Z1cEUxeHVEa2tXczRDZk5QNDZvcGUvV0VJTlAzdldw?=
 =?utf-8?B?YmpXK3YrUnNNOWtjdHVyN2pFRDNxSkkyOE9ncXJ6QVlRUlMxNm9uYmk0U1RO?=
 =?utf-8?B?ZW1RUzhPZU9JN25YNjkxamlPN0M4SUJEMmo0cURNVU4wSnZsRE50WWtrT1Ir?=
 =?utf-8?B?NlhndnU3Q3ZqQUNHT2l4T1kyZFZVcVVBcEdiQVg4cjZVYVhaZ3JvcHRXZUhY?=
 =?utf-8?B?QThsdEROMGR5UUNNVDJFOU5wb3ZYM3NnZHM0aUsvWUxuRkhpdjlCSG1VM0hK?=
 =?utf-8?B?SUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6adee0a3-6d91-40de-134f-08dc01afaef8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 23:02:04.8673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rbXiDUOPg23JXBA5x/cHFIFRzUXHPkyQVReOBRYXyY7LGhIvI2dksUMnkf2AsnEuVtmR2y0ZN8Qdx5s8COyVzqHR3iNTNeke64kb3myet0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6073
X-OriginatorOrg: intel.com



On 12/18/2023 3:26 PM, Stefan Wahren wrote:
> All known SPI registers of the QCA700x are 16 bit long. So adjust
> the formater width accordingly.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>  drivers/net/ethernet/qualcomm/qca_spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/ethernet/qualcomm/qca_spi.c
> index c5d240fe4146..d3109eb24b4d 100644
> --- a/drivers/net/ethernet/qualcomm/qca_spi.c
> +++ b/drivers/net/ethernet/qualcomm/qca_spi.c
> @@ -359,7 +359,7 @@ qcaspi_receive(struct qcaspi *qca)
>  	/* Read the packet size. */
>  	qcaspi_read_register(qca, SPI_REG_RDBUF_BYTE_AVA, &available);
> 
> -	netdev_dbg(net_dev, "qcaspi_receive: SPI_REG_RDBUF_BYTE_AVA: Value: %08x\n",
> +	netdev_dbg(net_dev, "qcaspi_receive: SPI_REG_RDBUF_BYTE_AVA: Value: %04x\n",
>  		   available);
> 

Sure, no reason to show 0x0000FFFF when just 0xFFFF would be sufficient.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  	if (available > QCASPI_HW_BUF_LEN + QCASPI_HW_PKT_LEN) {
> --
> 2.34.1
> 
> 


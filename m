Return-Path: <linux-kernel+bounces-66170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8F7855812
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 732921C21320
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA1012D169;
	Thu, 15 Feb 2024 00:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nvHjFXc5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4013014A83;
	Thu, 15 Feb 2024 00:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707955218; cv=fail; b=iigsdz7Y8rLeKKodxKTPcJ77dk2mO/IX42emugNytiGTGrCPZJT06d9L7IY5B8K/eghHTiESO+xSli1ArDH0u8Vl0NccT3Bj2+nvlXbnEP1OaclAGQRfwxG1oCgRDEbv4lBG9m50Fn6ST+oUNHRD8jFXkBo7I/yIZuCDTXaURVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707955218; c=relaxed/simple;
	bh=OWH+M7LP2y0ekO05rZj3S/sNT0JcvUmypX4A9BNi37g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f8Lu9KLIPkRifzRzD8SUqtxmnvh4pfzad/3vJTRLU8YprEewBGvFfm/cyFNM1nwPljsrIBsFrflApiVDRqIiLKRA6j3R3Wf7UE3dJt6aO/SiJ5rL7MbLKFlkPoTO6yw67UUa9Xk69t5G5ySy/K4Kxk0tTxtQsYGI4q2bmYRIDYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nvHjFXc5; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707955216; x=1739491216;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OWH+M7LP2y0ekO05rZj3S/sNT0JcvUmypX4A9BNi37g=;
  b=nvHjFXc55JYmI6E/nbEEz4rFWm/1U6gzw7HPTqyuCYAZCT2J+IP15o66
   ugx+7/Pi72zTlWD65tXlnM6TLgGVQT1DQ+PQvOotog6IuMrfk4O2v4Fsh
   pVlYiESdQF60fefB1/2CnMTBRk+MktrGpOEF8JI5sFsEn/vKpmTkh49nT
   dJg0tQ983Ai5ErHgMLd047yCEYY6FsSlwT8Z0+E3hIs3SjqopIDOhQJA1
   5PNd0BK5JCE5YaWOZHiNjBZJozOBpov5n/mXcCbfGfzfrMYH74govQv77
   jBzHq8tqZPrjLB+BrKn46NSDeelppa/SqAnsFkxg3pww+NX+1UJQtciy2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="4994431"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="4994431"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 16:00:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="3694682"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2024 16:00:15 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 16:00:14 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 16:00:14 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 14 Feb 2024 16:00:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUgjJtBdqMfEc7yBiyKmVwNneRc8WhYLa95rWFicb5XYy8ADQ4UVDCueuCEhTkGBK6WRnM+r2O3OJOhP1K420nUjiCfPwI31fQDH6IkrUbb/SD+Z531KSwGV/KZBsiP4kdMvN2g/RkuD61ej6ipGvnjYVSzR0ocPcXnpvLAEgN524gnxUPhCVFor6kYudo3c/NT2abSNusSwVYb22bktzgO98Dx9dtWxNmvB1SM41CkJe1iLlSlK3uD1gLgEwbrosVsGI5T2F0flQc+5hACzAld7qkcK3zVql2XjMMgbCyV5EJoVlc2WzZKUADadHQaFDDINlUwcLQPN/w9QMOfL2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzD/54Mh7jF7Ny32ZEdB+MRIm2crymqL53ULSXJ7DuY=;
 b=I3CK0tEpYRRhtdVzqvqxMr/ZEGUZPMSU9tYrELmfadvr5e4spauuoQP8x4V5PNfsAIFmwmURc28vfDkZMAp3+jTcDY44XgXDDpmhXszKWqMJ5L9GFL7NREW3wcCEmA5kzIW7ih/5wLH27ft1VFDs6n4Z90vBNL/Wgk3doGUwrbI7kJa1xBYxseLxXONKDbVpfPQIzVsevzlC4aX6JcJrSzXNgxltzmEQQEQ9IpNmK5uwhxdArkTkoYeZiGjx28jhevSFb17GJ5w3yZkWS98kr2a1KPmLrFHnVrKhzWwWBmqMe5GT6TjHK5LN6K88oNZVb5MR3vLYyl6xNITBa4BT1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CY8PR11MB7058.namprd11.prod.outlook.com (2603:10b6:930:52::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Thu, 15 Feb
 2024 00:00:12 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d%4]) with mapi id 15.20.7292.026; Thu, 15 Feb 2024
 00:00:12 +0000
Message-ID: <7c5fb62b-1414-4547-bbb2-93d0ca866c89@intel.com>
Date: Wed, 14 Feb 2024 16:00:10 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next v2 5/8] net: intel: i40e/igc:
 Remove setting Autoneg in EEE capabilities
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Ariel Elior <aelior@marvell.com>, Manish Chopra
	<manishc@marvell.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, "Tony
 Nguyen" <anthony.l.nguyen@intel.com>
CC: <netdev@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>
References: <20240214-keee-u32-cleanup-v2-0-4ac534b83d66@lunn.ch>
 <20240214-keee-u32-cleanup-v2-5-4ac534b83d66@lunn.ch>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240214-keee-u32-cleanup-v2-5-4ac534b83d66@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0337.namprd04.prod.outlook.com
 (2603:10b6:303:8a::12) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CY8PR11MB7058:EE_
X-MS-Office365-Filtering-Correlation-Id: 7394d845-b639-445b-e475-08dc2db91506
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nn33HvS1Qj8SfwqC3hl/FELsYxfJMFaVf2shDhfYKVDaU5cJ2nCOXuIbgIh443cghpQ2h+86K8b9h3ZFo/04Gbrb8SU69YlNSW1r+X+ygvPgkzJtPFz64rNozrxVlBbD6iskLq0hWvRT5PQmOLuINTpDlBl/GeroBkG2f58FG+SmGo9cDzzMBxuCHTwI2CAvH6Ns323ETdmUhoT8TUH314iWXN29G/7BI2iMYL202nIb6QQrGUbpVpDGRxgXuh/QKeGpCDBYn9cAZMENNqoHCxYnFxmln30WFQWs/Zkj0TvxjsxTJZN4I0g/Ol+isHw6Yra9z4NceV+vDggHQU58cewdBrqCLHI+Jni3BSk+EHMwI1xNGaVrbgDidhkr6sqWIeFuLgF9H5gG2D420l/h54mB64PGKzH58elW5enR2k8IAWS+IrZH9bNXLYJk8s7aqRs+Uox1aRDA2vUCp7NctWSd1TKK48LQe//wp0xIl5rL2utTsSvj2Q0t9NpMW54OqxM2ArrkvCjU6jrLUQy2mLmkROjBuzCbI0YbzKqMtSpNWax3aQaBDTcVwl72UQDG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(86362001)(31696002)(31686004)(5660300002)(66476007)(8936002)(4744005)(478600001)(4326008)(53546011)(6506007)(6512007)(6486002)(7416002)(2906002)(26005)(82960400001)(2616005)(41300700001)(38100700002)(8676002)(66556008)(66946007)(316002)(6636002)(110136005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QklJc0NlOHcrQk1ENVlHSllVVmNnTmh5UkNWUGYyc2xXZldsZDZxV2krbnpi?=
 =?utf-8?B?NjE4aTE0NGZhbnBMNnVXbGxicjNUbjBseEtMQmd5SGZ6UENUQnMxL29pTXFR?=
 =?utf-8?B?WEZUUUVlOXluOHlTbWVVa0k0YXFlYXNGSEpQRyttVm9pQkh6M1hhVEtDSmlj?=
 =?utf-8?B?WVhKcm54a3MzUmtlSVhKS0FBZnk4V3RHVmpuaWZGK1BxVkJERndkYTY2aWVv?=
 =?utf-8?B?R2FNSENhMTRjWGM4TXBrQ2pmMlgyd2Y0dEJQa0p5aWRBRVQzYWUyVmNmT3Nq?=
 =?utf-8?B?REtsQmRQOTBLbTZaWXJFSzU1akFwUnNtRC9xQ1NUdWFNYXB6eU9WcXZDazdF?=
 =?utf-8?B?clpNWHd1SXR5OEFVdGxQUFljanNHWU5ucUdWREw5V0xyZW5ORmZzcEdteUQw?=
 =?utf-8?B?L2tucGFCcFdiU0wydVhFb0hqMmlEWjQ4T2F2QWxmZmduQm1TSUp5SW90SzRp?=
 =?utf-8?B?blJYMHB3Vk5wT2NQbENOMC91V0o4bkMrZzhDa3ZKSmtDRDFkVjNsbEF4aTJV?=
 =?utf-8?B?YlkwTjFONGVXRGdLaXVqYjVqbkwwS3RXUEpCakttT1JRRUExSW9FWTE4aVZN?=
 =?utf-8?B?S3JsQ1NqRmwwYjhvTktRRytNWkhab0wrNjJFd282RERkcENjUTNnRmRIWmdk?=
 =?utf-8?B?UExmU3FTTVlFL3BSc09GbC95SnZlemtxUFNwZ21uTFRMYk03QlhFUjVOeUxu?=
 =?utf-8?B?elk2L2VWRHRrN09nRDMvRlVKay8vd1NCb1N0TUVQZEhzVU5KSkViWXYwREsz?=
 =?utf-8?B?WEFJMjRKa0JsQjl1SGhzRFUvWTVGRU5vazVkQlIzRDlyUzZHVnJZQkY5cjBZ?=
 =?utf-8?B?bFdnVk5RTEY4aDMwZE85U2duME9TUTJlWEw1SFMzOW9kdEhqeFZPd015dXY0?=
 =?utf-8?B?emFQcGROVlhKY25TOHZPaENrSWFMNHltdVI1Tk85Yk5SSWN2V1JPZDBNeW9o?=
 =?utf-8?B?YlVBaVNpUXhnQW9vWEhsRDBoM0RNTWUwUVNFei91d2w3K2lQTVhRaHBIVEdw?=
 =?utf-8?B?WDBNV3VEbDJUalRwaFludmdVejRUcUoxVDlJclFLVzYweURmRUlSaGsvQU03?=
 =?utf-8?B?UndTaFVkL1dLeU9NNjFhQ2JLMmtlRzBhMlo5MlgyNmlhYXlNT2I4QXRUTlMx?=
 =?utf-8?B?TVowd2pjL1pnTFZlTzRZYStxUVJ5L0FBTkljdDRFUGpRSFpIajVmQkJRdXBN?=
 =?utf-8?B?Uk5ESXJPOGVNR05vZlhtS3NIZnZqVXJwN2hSUllpUDcrY3VKN3p6VWV2UmdT?=
 =?utf-8?B?N3BSa2kraXUzQWlyS211N2Z6c0lXbXh1K211VFREN2JQajF1WnU2MEhPbU9y?=
 =?utf-8?B?NFRPbTFDREpyMVJvUVg4SjkzUkladTBOWVduR01NcjVvZnUyUk1GaXhhc3NG?=
 =?utf-8?B?bDQ0dkVxNHpQQy80Yk80bGU3dm9DTm82clViOWJrR2NaQ1RQVnZTVUE2RlBs?=
 =?utf-8?B?ZTB5N2JLMkdmTlpuSWMxSTBkZXFCY2ZaMjAxZ1lCTUd2dHBicW1rOVkwL0JB?=
 =?utf-8?B?ZkF0NEI5aENBTjVUeDIxaFRPK0xnS210VmZyalhxVU1LaC9mUjYxOC82T3Np?=
 =?utf-8?B?Sk9wMlJaU1lMWlBhYTNkR0s1TmVoc0J2S0JibWhOYjFQbzBhV050M0oxalRj?=
 =?utf-8?B?ZVcrWmd5bUl1VmtGQUNUbjAxT1R4SThINSs0V3BOZmduZlJ6and3MFdrWHU2?=
 =?utf-8?B?azlTQmVEYVJjYkJBQ1B6d0VtV3RQbndFejkxMzlsZmpRTSsvcjJaY0J4dTV0?=
 =?utf-8?B?c2tHSDBxYmVjaGtrRDNicXRSSm5VdHdkcUYrOUcxd3NrSEtDdGlteGdRK3lG?=
 =?utf-8?B?aHFGa0libWxRZnRXQzlNQ2JtUUVsV0YxVTNQK3UwbU1zMWR3WWhicys0ZDRS?=
 =?utf-8?B?QStUY2UvSGR4SVFLNXl3Z3lpTzdVcTBqWS9IV0FNdFNGSk5sTjZPVjJYYmpv?=
 =?utf-8?B?S2lWTzJONXBGdm9HdFpZY1RBb1FrdXR5MWpicmxMVDgvNmNuVzFIdWJabmsy?=
 =?utf-8?B?blpPRXZrcnBzNm11YmFTOHJFK2N6WitjVjV6Vmk0Y2JoN3Q1QmduR3BCZHYx?=
 =?utf-8?B?TjU5dHFMQVpsbUx1MkFxUU9iOHlZdTMxTW9CWVhxdk9ZUkJhWTdjMDAwYis4?=
 =?utf-8?B?dml1bGg0VDd5M2FuamFXdEEwMkdkb0ErMWRCMXBLbFltVWVCRGpZWTFWaXNN?=
 =?utf-8?B?aGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7394d845-b639-445b-e475-08dc2db91506
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 00:00:12.5560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: voZ9Vku3W1doGz48pVbT7eq1ZRDRJsHAUGEMDVHk6hXovRm/EdhKeSnDHhNUxIHyUQGSzAQacAlyj4UbCEzq3tQDa5Ql584Aix2BVdK/plA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7058
X-OriginatorOrg: intel.com



On 2/14/2024 3:13 PM, Andrew Lunn wrote:
> Energy Efficient Ethernet should always be negotiated with the link
> peer. Don't include SUPPORTED_Autoneg in the results of get_eee() for
> supported, advertised or lp_advertised, since it is
> assumed. Additionally, ethtool(1) ignores the set bit, and no other
> driver sets this.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---

I checked the git blame for both igc, and i40e both in-tree and in our
out-of-tree drivers which have this code. There is no explanation given
and it was just part of the original commits for implementing EEE
support for these two drivers.

I can't find any trace of a justification for this.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>


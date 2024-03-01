Return-Path: <linux-kernel+bounces-88059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9E686DCE1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E55F9288FC0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC84B69D2C;
	Fri,  1 Mar 2024 08:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SpHMSUB/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9474EB23;
	Fri,  1 Mar 2024 08:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709281077; cv=fail; b=uKtfdAEADtfIGStcryQweYxFGKtxaDAVEVOuCxPnAfUI7TfkCpC9uxtIUvnqMu40TnNMEFJQXKgIrII+ub6HxpU+qLs4ErrPJ+3IYc/lBZI7P9TI10VhywU+B7JomPGqVKnvJAvmI+uT+7zP8DAE2lQXY+KcD6UxbTBYKFOcJys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709281077; c=relaxed/simple;
	bh=2RhzOt+ILfBQiTPX3dCY1gRxROHkBIvuNjYyXGcynw0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=phRBH7jk3P+5nx1ojLNj5FnOj1Ad3ywB4an050M9oAhNHBBQFEU88V60cSPJvffYk5gOMddFwhaLUxs4XIcxeYC4bY5Qw1NGi6sOaH5bey7tef1t4CDc7m/7Sx5QdAeO0W5X3VwnaVdIBOT2kORyVHwIo30jZftZb1+7sZW1i7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SpHMSUB/; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709281076; x=1740817076;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2RhzOt+ILfBQiTPX3dCY1gRxROHkBIvuNjYyXGcynw0=;
  b=SpHMSUB/ep7eG5Ax2U6rYp5DgNkA3xH3kCzEFEV/LZMCv5Wg48/1V0bg
   xyaY8RH0LWe3d71yxKqcSrZz1PKBFdH0KnKgIsMeJAUiKW1Eo1kpz1UYW
   yTzRPJkvws3QTm4LBxCAAwv19Bwb6C+/z/kyqaHSzQBXe/9T9cXMssjuH
   M7859f11M1RZSuksR7nMg21yQwPj3fYVRsWUPDWYmIUW+sIwwdiESx+B5
   AN8RCN3E8kU62QlI41jNw665vhqgFD83CQnaIzBuiSPy8mc6J+p3CWWbt
   5Qx4Mb+lmpDVrAPMnLBxj/bCPAPDVEqgr3wajz8Y+n3viusioR0vHJwFI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3925584"
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="3925584"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 00:17:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="8019096"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Mar 2024 00:17:53 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 00:17:52 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 1 Mar 2024 00:17:52 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 00:17:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFRtPZJHQeZ+R3B+NhbRSC997MnaPoUxXztYIbKUaX7s0Kk0n2tGeD6p9NHsXVe+1rfGFS3L3ZLeodBz2nnYG5WffU/sV8ejBRSQmNHJ+IQqxUHhjG8E7gfuXYaYj4MwFiiUZ0BExjeKETaxmIwUKdf/OHQ2D6BaflYCnYSFSt03Gkk+2OR0Az2fqJYgkiZ0ONHXWuIH0lriElhnSHrFZBNqzzGK5aqBY7XBQ9DEJDA8+op9oNoTXMZqbhWbGsgVp8Ct3JsLAaxQ/EfSVjCARTtiyYm6qPLvGEixclY+VpkzjaCDSkm86i5YjHDcHy7RdX8esplQ+2gb5xjxImgXOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKOPz55QXUxHMH5zmL0BE6q+DRXyeEPzdKSMUNKTx+c=;
 b=D2u2LTgFoWshnRw4mAJ7JqS2QTNn8j5oAnX3Oek1681gHUSLhmj4zf19sseaopbV5jCcroiZy1BtInbDnswIN+RQ6HAgYrWOmz982FWvr4p4oIlnUEOfBuOFTpK2xUjFDphKpfvVEs/1O55QEfgRxJWIGiGOdtxm2InSGlXe6rVLd4tZBbzvRzDS1KD833VsGNQLBjGzFX4mF9N4T1wOCwDlerjegYrHpgO8Cfx9U3Kvy2GBsxYioFv+eZB9jfCJ2vzqqABHbY2XerrAyoWUFEH4d7Q0CbBK2poZvVFijBnQLR5istRTsXyXYrubTH7w23l1Ao8KHZbzqRNSI5YFjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by SA1PR11MB8575.namprd11.prod.outlook.com (2603:10b6:806:3a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.22; Fri, 1 Mar
 2024 08:17:47 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::8079:6172:11ca:5fe9]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::8079:6172:11ca:5fe9%3]) with mapi id 15.20.7362.015; Fri, 1 Mar 2024
 08:17:47 +0000
Message-ID: <4a0e5f42-ec5a-48d2-8887-d14a019a054a@intel.com>
Date: Fri, 1 Mar 2024 09:17:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] net: phy: micrel: lan8814 led errata
To: Horatiu Vultur <horatiu.vultur@microchip.com>, <andrew@lunn.ch>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
References: <20240229195220.2673049-1-horatiu.vultur@microchip.com>
 <20240229195220.2673049-2-horatiu.vultur@microchip.com>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240229195220.2673049-2-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0107.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::10) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|SA1PR11MB8575:EE_
X-MS-Office365-Filtering-Correlation-Id: d3bcdb25-23cb-46f1-7feb-08dc39c813bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wbb0aRLOcUAnuOhcVDv/0BWcVMnqKm/8C2/CTnr4cPAuyXd7vHceik64vRiI1OaIW3KM/F4GKGLSGeJJGzi/Qrnf8pTjvDe5OgJYk7C8/YozR4xtR8JCuGW/5P8sIoLBNPdKLpioHk/mi66lUyp4ZYcSpj1QzDrYK5kquFFYaUixAWF371Bk7hjHhDM0Ss0P7h41XT5n+6tegndQStxxwyIAfzBeclaLl1hYSaV612iYZBrTh4NxTNkf5k5oNe90Yyjz8iI13nFAoyJs3OTrtYORMp2Csq8CgQdsC8gN+OWFnxg/qnf3kIDGjhsVmMjILj7ZD8ttvkGYtZJP+Jwt9cXcwnTTSrOLKDdSX7ONyZ8x381UnSnAnGzn+c0gPs5XT5I3uCIdyfVfpbD6jXppKgkL2+fbgMBevrdvXBgCgwK/pAQNEWOF3lTw7NbRne9QczhYWyRin229QMpc6LaPiAYc1Ehfz+jdX8k9ZeMo0t/ZJzrjKdK0Kx9SG2AvwfL7w7HicrK04Cn3dIjtVC3O/dnG/76VbWvBQmYFqPITXaxr+612ws+GUZY4QVr9XNRjbpg7mftnu8/OrjIILra8tt7iwivfi11th95a/cv17d/+WqpCLL6ZYaXmCpM9oe1Hq52zSziz6xNJX+cGdNUfoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2Qza1RUYzc1ZXM3ZnI0RjhoelVzQ1Q3Nm1XZlM3Ulo1akpJd3huVUFMREZp?=
 =?utf-8?B?NEg1U2ZGM2hxQkV0aXNRT2FQNEhtek4xYlV1VlVpZ3BJRmFGZXM1Tys5NVJ0?=
 =?utf-8?B?d2FEaU5PZ2RGK0lDYi9RUDIrQ1hIMVZIUHZhbkpNbHBpYTlQY1Y3Wks2KzJ3?=
 =?utf-8?B?NUsxaGVsZU9EU1BYc0xRbGVZMzFIWnBZMHRsR3V1dGd3cGJwQWFEOS9iUEpG?=
 =?utf-8?B?TGVqbThtRCtKQjB2QzlqcExaNEF1bHFad0RZbnFRSjlleWxnSTkwNXpxSCto?=
 =?utf-8?B?c21tZGlRZHZsRi8vS1FxSnNHVlYwbnVLTXplMzFPS3owcUtqR2pRUm5YRnpQ?=
 =?utf-8?B?VFhMNVd2b3RoZVZOWEc4YllnMzdPSzUyMUxXL0M1eHRGQ0hLaHBITjdzbU96?=
 =?utf-8?B?YS9rdTZBRWNyM2QwYXZQS25BcUNVMEJydk05WUlmRDROQkhLM1lHM1lrdDE3?=
 =?utf-8?B?WDBOaG9NcDdTNFdwUWF1UGNHbWtxY0duZFJLcW5xbzFrMlQyUGFoK3JneEtS?=
 =?utf-8?B?c01KUTUxbHVQd1d6azE1QjVyc1RwOVMrK3VsemJXS0pFcnhGT3o5R2dONWhh?=
 =?utf-8?B?eUMwVktYOEY0aHpNUWlWU01uUmRlVWJmTWt5Z0lsZm1UK1hGdjBaZUZ4OCtt?=
 =?utf-8?B?UVZja2ErV2FjV0hCOFdQTkxYc2ZTcXVqdTVYNnVJWHNEY015RGFMVFdSNEw2?=
 =?utf-8?B?N2hWMzVZcnp0bUw4a21mU1RDY0lHWjRSRkJlaDhhbGpKK0RaN0c0T1IzdGNP?=
 =?utf-8?B?bmVyU3BLN1owcDlleWl3ZXR6N2lZUkZJTXdPVmZsK014akNtcTUzOG5BZXJw?=
 =?utf-8?B?K1VmdkdnK0lFZEk2LzB2VTlvVVhiREx1ZkFxVXd6aTZ5ZE1WQmNaTnZ2L254?=
 =?utf-8?B?LzJLamVsR3BlZVJuQUJvRkhHRVJNaFlpUkRkem5UWGRtQXNXWnMvUzRBQW15?=
 =?utf-8?B?Wi9qbExTQWd2ZDlWemJIa2V0SjBIVUpQano4QmE5Y0pndXczSDAwN210NUth?=
 =?utf-8?B?ZTY2SW50MHRNMkN4NUh1VkZ6VW05WHBPWVZob0tlblN0SVg0YjZYcHVOYkFx?=
 =?utf-8?B?OGkxcWJuUXJ0SDRzbGRRalMvN1MvZ3BmYnhqTHJBc2VBSmYvTVk0aC9IUWlC?=
 =?utf-8?B?dys3aUJtRXVVUzdWeS9WRlEwOUkrNk9UMkt6RXp2NHBrK3VXVCtXdit2NDgz?=
 =?utf-8?B?QSt4eG5yaFNlZDNPT3gvTFVYNmRFRHBxZEZQbzN0cDhNVUhycGp4S0trRmNq?=
 =?utf-8?B?Z2YweUJOeTRBOEQ0Qis2QXVDY2xlRVl5RDhUUXVrN0dlcHNhSk5MN0RJSlpK?=
 =?utf-8?B?R2w3R3M3cHR1MGx5ekhIUXRqeTByMVJoNGUyUldFdVk4KzB4Mjg4RHNhcyt4?=
 =?utf-8?B?Q2dib2RRYk1XUDY5eU5pTkwyTWZua0t5bWJNRDhsNjM1T1FHTkpJMkYrczg0?=
 =?utf-8?B?WUxLc1JFaU02RS9LRlpTNExSRFZqeGdta2RrTlplVzhjRTZqR3pXV2QraFhl?=
 =?utf-8?B?bXppektUUVB3ME5LbGgvNDk1UWxKNlA1VzYxVm1lQlFLVzlHYUMweDl0VCtM?=
 =?utf-8?B?QmZQRWhNZEVSRHdtWml4Ym5IcjY5NzdlZG5USEQxSkFtYkp3cTE0RGNZSEJP?=
 =?utf-8?B?azRWU1BtUlIxL3dUR3hSa3J2ZDZ1MUh0bWtQZnpFNmh6R0thRjNRUHpnUlp5?=
 =?utf-8?B?U0M4MFFFeUJSSnQ0QTBtK3B0aktJZnFHK0tGdzhpTk5nN004SGVGa2RkTy9D?=
 =?utf-8?B?R0g2SEZsMHJPSVlhNkVNazJkOEVRd3RYc2VxaTNFUkVDd2d5Q3VsdjBYVmsr?=
 =?utf-8?B?T1lzOUtKMXlQSVRYN1R1N0JYOEptTXN1QXE4RGxjUm1RRXB3Y0p6ME5veExM?=
 =?utf-8?B?SWd6VUlTYWh5dkRldm0yQ3ljbUplYW92Vm5OVy9tTWI1QzdxRTRsc3FrOTVp?=
 =?utf-8?B?aVROUWM1N0g5b3R1Z25uVTZuaUQ3eHo0ZWtDY2ZuQVhJckROZytoL0p0VUFE?=
 =?utf-8?B?dnVZRW9ScWREd21jakJnU1VCb1Qrc0JPaEFFTXRrVWp4d2ZHWE1MdDdJRy9Z?=
 =?utf-8?B?MWZXMEZ0dHFUdk1GdjJKTHVVaEQySmUzM2ZKNk9OME1lYTFUTjlISDE3OWVx?=
 =?utf-8?B?cUI4R3ZQRjFZSVZCVnpuUEoyeG5kWlpHZzdjZTAxMWFRb3NldFFGNit1cmxF?=
 =?utf-8?B?N1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d3bcdb25-23cb-46f1-7feb-08dc39c813bb
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 08:17:46.9353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nWEm9iHwNI2K38SYWJpNjrkVDP2x5QMipd91DJixccA4OD43CdetgcxjVwenbKqNkOeVBxZpYhY3F2JJuiNNDX2YoyffjuRbj267eDM7Cio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8575
X-OriginatorOrg: intel.com



On 29.02.2024 20:52, Horatiu Vultur wrote:
> Lan8814 phy led behavior is not correct. It was noticed that the led
> still remains ON when the cable is unplugged while there was traffic
> passing at that time.
> 
> The fix consists in clearing bit 10 of register 0x38, in this way the
> led behaviour is correct and gets OFF when there is no link.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---

Thank you!
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/phy/micrel.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> index 9b69735819896..88cc03982bb78 100644
> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c
> @@ -114,6 +114,9 @@
>  #define LAN8814_INTR_CTRL_REG_POLARITY		BIT(1)
>  #define LAN8814_INTR_CTRL_REG_INTR_ENABLE	BIT(0)
>  
> +#define LAN8814_EEE_STATE			0x38
> +#define LAN8814_EEE_STATE_MASK2P5P		BIT(10)
> +
>  /* Represents 1ppm adjustment in 2^32 format with
>   * each nsec contains 4 clock cycles.
>   * The value is calculated as following: (1/1000000)/((2^-32)/4)
> @@ -3288,6 +3291,19 @@ static int lan8814_release_coma_mode(struct phy_device *phydev)
>  	return 0;
>  }
>  
> +static void lan8814_clear_2psp_bit(struct phy_device *phydev)
> +{
> +	u16 val;
> +
> +	/* It was noticed that when traffic is passing through the PHY and the
> +	 * cable is removed then the LED was still one even though there is no
> +	 * link
> +	 */
> +	val = lanphy_read_page_reg(phydev, 2, LAN8814_EEE_STATE);
> +	val &= ~LAN8814_EEE_STATE_MASK2P5P;
> +	lanphy_write_page_reg(phydev, 2, LAN8814_EEE_STATE, val);
> +}
> +
>  static int lan8814_probe(struct phy_device *phydev)
>  {
>  	const struct kszphy_type *type = phydev->drv->driver_data;
> @@ -3324,6 +3340,9 @@ static int lan8814_probe(struct phy_device *phydev)
>  
>  	lan8814_ptp_init(phydev);
>  
> +	/* Errata workarounds */
> +	lan8814_clear_2psp_bit(phydev);
> +
>  	return 0;
>  }
>  


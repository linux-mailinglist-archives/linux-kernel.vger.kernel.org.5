Return-Path: <linux-kernel+bounces-12511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7E481F5EC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 09:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 088D7281F78
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 08:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0548F613C;
	Thu, 28 Dec 2023 08:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EZVvo6eC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260655244;
	Thu, 28 Dec 2023 08:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703751893; x=1735287893;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aQQL/E4WC93dU9lJwbfBkAH12tiADbFtXqIQs6HL9SY=;
  b=EZVvo6eCDYX7wGFalYFRWTlLMpGX6ZUrykc1H2dta7zoU3gH7dZUf0xX
   Fr8Qd5+XaehR3BdZaIYr1ZSwbOlcTCLiOl2+RWVP0oNvcLlhb3dsIOiBY
   o73crIs3CmMQ7K7JF+RP1HezXzxy4+2ELRTVmt6aoNgorMf2Wa/mSsM5K
   nD/5taC1qH3DXGAkmSgcR4xfxlVVz8LFnN4L2upVxguV/tU9q1YhDyuOw
   bhDt+uhan4dXbGC5GSr71sqJyXu1TDOIiVsNa8WPN/2PaWi8++q8zmvj3
   CG8wzCzuFKoxIaCuRunRFLB+kdecSzIppOtrNpPBnViYnZXfyf9OAJ+/R
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="395418161"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="395418161"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 00:24:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="26801795"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Dec 2023 00:24:51 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Dec 2023 00:24:50 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Dec 2023 00:24:50 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Dec 2023 00:24:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TxsvZpvb9IcKiTSbrcZmhfYZnUrvs2nQcSpRnkvnGvWCNBCugBCsWUy5htWQ3dg5JooaZ64vMoW/WLwe7A8FnXDIlxnMbArWwT+ahWDMGABWjyCChU98kicItEyw2AK87jpATZy5MtlmTu/w6kfutEjSQx5YyYSKF//BFSrrYWVgd13z9UYVg76ijzXYsXlyEp03asJDTsiqy4lQhVafa2S/7UvScCMj4taOqDeWMZ/9yhixiGS2TIGOsRsL3X+z1cFMjRUwUMZjYgKA5a+3oaPAo4bfCl0MXYEXFVICBv4qQqyMpLF0vqcQcSSVnU+/Zq4ngpzYYyf2BGEaARX3tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1TG1u4FB7ik/I9HjCYW5nF8W9rUzOkSlMiiqbuhEFE=;
 b=GI2zDiEZ1govYqqWxonDTmGo3mtwTR1nZP1fSr3GmSTMkxPgNcHPrWabif7c/uHeBN7kxDQTm1ZlNav67nGuBUlskzMNXZ11BCTVtm7deTqHNuI3rcICd13plk/wW3mb8STsdXOiYxDaL0+6HgJbNl8R1TKq7YI7rNu3g7DY1oXmkhYF8ZSlcuGcHW78X9zvtsdHEhkgCOdlMcf5TT0hqYE+4qOLmIa5hg6CCRcdYh0bwa8n43Dnz2GbqjopX9IKL42zNB5jDvL7Ovwbz3OD02t7vZBoVgo75MP2bq7llYJXwx/Sq+ugdEM6KzKMrLvZVXSrf7BeyKyWUzY3st6rDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by SA0PR11MB4750.namprd11.prod.outlook.com (2603:10b6:806:9d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 08:24:48 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::ef7b:6435:f727:4d5c]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::ef7b:6435:f727:4d5c%3]) with mapi id 15.20.7113.026; Thu, 28 Dec 2023
 08:24:48 +0000
Message-ID: <95b7ee65-5661-6529-07d3-ce13968a3c25@intel.com>
Date: Thu, 28 Dec 2023 09:24:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH net-next] net: phy: Cleanup struct mdio_driver_common
To: Yajun Deng <yajun.deng@linux.dev>
CC: <andrew@lunn.ch>, <olteanv@gmail.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <rmk+kernel@armlinux.org.uk>, <kabel@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-phy@lists.infradead.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
References: <20231228072350.1294425-1-yajun.deng@linux.dev>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20231228072350.1294425-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::17) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|SA0PR11MB4750:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d90a34a-ac0d-47bc-d31d-08dc077e745a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pYIVdfoRChmwGwoPr50zvu0QctUHWPKVUtOquJwTwgi/leInXT8Ys5VhXZMam4/LPOkYg0pjIIzB3kENI8zVIU87+L2pQF2YAOIkdTAUCaRnSRG+6bvX31h3JNL0KkDDIegrQYXVGHP7/F0PJeTCHrTSrnkDx04x7Gwa+3VHU062gfCv3Mnd9wCrg3nwj+nhrMrm5yU4uG/tQ+UlBXDqkXodMkg57QTDDAxrS2i7Dr0s82olC52zsHp/vPnhrRXoDXeJV2Bti/e0OIo0YpPUyAsvlPE3se7DqgUE/PgpZh3xRTGIXvPWhJ06k94zW4u9RJf10nq7qTGjsEExdHmxJux5Tkm3uCDsglY8oBKISvN0tbTOhObdJxQ3ht84RwaQtSPxugRozyi4ESLMovQzL+5Q1m0F21ZfxKigkr0Mh8LISZyp5XNZEUMAJD7R3EdlmgXRTtBeiMZITzMWXSMlfP8X6PgiWYtXPuz7WqTmdzgV9+0BS2GRZjcYfnEmxahP48OnEk/V4GtTyP+mOLcsdvTCuJXvOWQCJHvBCbcjVlVc7qDvqgo9VJ6k6wyjPpd2lmXA6cEzQJAx0u2yx1mbvY4cDpBXzpfa2bw2Be9nYUaVIr6M1nWGpwcccbaxLzfr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(366004)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(36756003)(31686004)(82960400001)(41300700001)(83380400001)(38100700002)(66946007)(66476007)(8936002)(8676002)(6916009)(2616005)(66556008)(7416002)(5660300002)(30864003)(316002)(4326008)(6486002)(86362001)(31696002)(26005)(6512007)(6666004)(478600001)(6506007)(966005)(53546011)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NE9yQlQ4OG1zRTh3NVhsSEVWc0ZIZ2lveEJGL2V5Y3ROc2F3MjBra0ZQZFpy?=
 =?utf-8?B?WG9qMGJhaWNvd205ZjVWWkNGSlRJazVGR3MvQytrWmVGbVNacHNQR0ZQK2kw?=
 =?utf-8?B?VTVpUU10VnExMmtrUTlDSHdRM1QzZzMzQTFXdldlcE9aVVQzUWJaVDN5Slh2?=
 =?utf-8?B?ckFlME00Tnl0ZU9ZOWZ1cG9NZ2lCSG85K0JObEdqbHdMWkNPUks5M1lQN3Y4?=
 =?utf-8?B?T05lL0ZwODdzTi9SbEs3NEx1TFBueE5LeXNOUENRdW40a2FGMUdvQ2Z5NE9F?=
 =?utf-8?B?bmxSelNrZ1BXU0RaTytSVGR5bCtMSVpWWjBEQUNMd0hZQ1U3YlpzbFZsR1ZF?=
 =?utf-8?B?SFc2ak1ySC9ISlZXd0JBYVhIa1MrY1BRdDE4cWJPS015Q0ZCV2VkQ1o0ZVlt?=
 =?utf-8?B?MGpBbjRtQjRtVW1rUWpEQmE3cEZETngzblZ3QzVaNEdqanlsM2NtR2ozaXUx?=
 =?utf-8?B?OStaVmd6ZW1HQ2ErNWR1cjdFSnYzeTNjOGdyMWlKYmtEUnJweTRTT2xuaTVK?=
 =?utf-8?B?alB2UVloaUd6UjQvd0pRam1RdFJ4T1FGQmx1Zktub1ZOREt1R2VDNThuY21o?=
 =?utf-8?B?dDZvaHpkUUlHanZTbFBSVHNrMDlhS3NCRzltaHVCR09zbUJQRllza1JFV28x?=
 =?utf-8?B?MWx1NU9HcXU3cGJVaTFqV3B6VmFCOWoyTWF5TGNtc2FDQWlySkdZVm9oUSt6?=
 =?utf-8?B?a05vWFFPWjJ3YXV0ZDB6K3pjbUxLM2JzQkxyYSt0OFY4VUdpU3pFZG1QbjNS?=
 =?utf-8?B?Y2c3RkpWTXdZMVZNK2U1bkJkSmNkaUhpUDRoOVJxZ2h4NGJBK2lldWcwUjJn?=
 =?utf-8?B?cURBeTdSTVpHb0ZwRGQyb2pkWW1LWitXV3VNNE4vQkd6ZUtrRHdZNzZhZ1pZ?=
 =?utf-8?B?bm9sQys4c2c5eGVtWmpzdXV5NkdYTE54cEFRQ0pvV2F4T2czRTZDcGk4dFh4?=
 =?utf-8?B?R0dXVW1tT0xlNW9YYVljYVRWZzRjWjRLclZSdXZBYi9qa2oxZW04eHRTUUZl?=
 =?utf-8?B?ZzJaRWVhMTNndHN6NnM0eG8reDBFRjc1b0ZwaFJNWngydnZzNGF2cjhDOGZw?=
 =?utf-8?B?SGt3WkVVWHk5TmZOODlVRU9MbXVxMDRJdThZL1NaZFJnU3JueVViMnZzc1E4?=
 =?utf-8?B?Wk1PYkZLTWV4MUpIanVUL0dJMmZRblc1Y09rZnVBbVBuRlhRVHJ5T1hvSUJV?=
 =?utf-8?B?RzZOUGc3alBZc01FemRHUWk0ditkdFVLSk9MMVU2b1MrcmlSOHpqT1pOSXVu?=
 =?utf-8?B?Tmx4SGM3eE9SV0p4ZmwvZjF4KzZ2NkxOZGl5OEVjWlRQMUozeWVMVGp3endt?=
 =?utf-8?B?UkRYMjNUT05TeDdBTFpNWnlQWVAxKzhDcE54blV6TmZWUVgzQ28wRVBTL0Jh?=
 =?utf-8?B?dEJIaUNYTzFlNmdnelM1TVFIdHZFNm5UTy9vZkNtbkViRkJVRlJyRERDNXJX?=
 =?utf-8?B?aWJvNFlCTGx1REY2ZVZMdzZvUWRkYXZydGpwNlBPc0w5c3R6VDVhQjRmNWEw?=
 =?utf-8?B?Z0s1NElDc1NsU1prb0srWDhrSUF0K0FRT01icTNYaUlza0hXdG1mZ3Q1ajh6?=
 =?utf-8?B?UU5DakJMR0V2cGNnbjdWR29YUTZmYTVTZTNCZHNUaHdQVU5rcTd4NWdrQVlz?=
 =?utf-8?B?VFdKUnc1bi9zOFQ1aG11ZWlWS1Y0Qk4wZUlhQkJhSkl4TmlSbFdGeEk5dXlv?=
 =?utf-8?B?eUNSRTFmOXd5a0U0T1ZueHZXTytrU0FQdEVMUFhhS1BwWjR4dkt0RmFJeW1y?=
 =?utf-8?B?SFpWSGtqRlRiV2gzcGs4K1N5MytiNURHeENaODl1WVNLaG5iTkRPNm1VKzZm?=
 =?utf-8?B?bjZ1bk1ZTDZrQkU3MFJMMW9pNDlLd05GMjJZNkVwNi9PN2V3ekhReWw3V2FU?=
 =?utf-8?B?dHBOSXVmaVZFZy9FYkVRNi81ZGJoMUIrOExYQ01FN3E5UmVSUUFFdnBENjNP?=
 =?utf-8?B?QzFyS241K3A1TVV0cUdPa0tFeFQvQm1jTEhQcGFxRkMxazJIdG1NeStsRHFM?=
 =?utf-8?B?ejhOdnI2dHRpMkFhdGhkTlY4VHNvc09WYnJ3M3ZNZW1NckV5bExoQkJsUDUz?=
 =?utf-8?B?L3FVV3J1OEFSTnVBWmpUbS93Z1dJbDhYZGkwbGwzM2dXTmtjSnZEUlI0Sk00?=
 =?utf-8?B?cnRrTGdTcjNvMXZLTXZYdzVyUlBtWVdnRXhzZkhWZ252ZGt6OHF3VmVjekxV?=
 =?utf-8?B?b2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d90a34a-ac0d-47bc-d31d-08dc077e745a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 08:24:48.0498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ju5apRSJj1yiACQKvsds1YkvBCpDw/3FP7xis9hW7CwEaVQHkTyAp/7BG99FyqT6wpiGuVMjFCRpg9B1P3pdEzc1s1Rgblbb49BVXhKFmwc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4750
X-OriginatorOrg: intel.com

On 12/28/23 08:23, Yajun Deng wrote:
> The struct mdio_driver_common is a wrapper for driver-model structure,
> it contains device_driver and flags. There are only struct phy_driver
> and mdio_driver that use it. The flags is used to distinguish between
> struct phy_driver and mdio_driver.
> 
> We can test that if probe of device_driver is equal to phy_probe. This
> way, the struct mdio_driver_common is no longer needed, and struct
> phy_driver and usb_mdio_driver will be consistent with other driver
> structs.
> 
> Cleanup struct mdio_driver_common and introduce is_phy_driver(). Use
> is_phy_driver() test that if the driver is a phy or not.
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>   drivers/net/dsa/b53/b53_mdio.c          |  2 +-
>   drivers/net/dsa/dsa_loop.c              |  2 +-
>   drivers/net/dsa/lan9303_mdio.c          |  2 +-
>   drivers/net/dsa/microchip/ksz8863_smi.c |  2 +-
>   drivers/net/dsa/mt7530-mdio.c           |  2 +-
>   drivers/net/dsa/mv88e6060.c             |  2 +-
>   drivers/net/dsa/mv88e6xxx/chip.c        |  2 +-
>   drivers/net/dsa/qca/ar9331.c            |  2 +-
>   drivers/net/dsa/qca/qca8k-8xxx.c        |  2 +-
>   drivers/net/dsa/realtek/realtek-mdio.c  |  2 +-
>   drivers/net/dsa/xrs700x/xrs700x_mdio.c  |  2 +-
>   drivers/net/phy/mdio_bus.c              |  2 +-
>   drivers/net/phy/mdio_device.c           | 21 +++++++--------
>   drivers/net/phy/phy_device.c            | 35 ++++++++++++++-----------
>   drivers/net/phy/xilinx_gmii2rgmii.c     |  2 +-
>   drivers/phy/broadcom/phy-bcm-ns-usb3.c  |  8 +++---
>   drivers/phy/broadcom/phy-bcm-ns2-pcie.c |  8 +++---
>   include/linux/mdio.h                    | 16 ++---------
>   include/linux/phy.h                     |  9 +++----
>   19 files changed, 54 insertions(+), 69 deletions(-)
> 

some nitpicks from me,
otherwise looks fine:
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

BTW, please send v2 after winter break:
https://patchwork.hopto.org/net-next.html


> diff --git a/drivers/net/dsa/b53/b53_mdio.c b/drivers/net/dsa/b53/b53_mdio.c
> index 897e5e8b3d69..1ececa4d44e4 100644
> --- a/drivers/net/dsa/b53/b53_mdio.c
> +++ b/drivers/net/dsa/b53/b53_mdio.c
> @@ -392,7 +392,7 @@ static struct mdio_driver b53_mdio_driver = {
>   	.probe	= b53_mdio_probe,
>   	.remove	= b53_mdio_remove,
>   	.shutdown = b53_mdio_shutdown,
> -	.mdiodrv.driver = {
> +	.driver = {
>   		.name = "bcm53xx",
>   		.of_match_table = b53_of_match,
>   	},
> diff --git a/drivers/net/dsa/dsa_loop.c b/drivers/net/dsa/dsa_loop.c
> index c70ed67cc188..3f885878be3a 100644
> --- a/drivers/net/dsa/dsa_loop.c
> +++ b/drivers/net/dsa/dsa_loop.c
> @@ -375,7 +375,7 @@ static void dsa_loop_drv_shutdown(struct mdio_device *mdiodev)
>   }
>   
>   static struct mdio_driver dsa_loop_drv = {
> -	.mdiodrv.driver	= {
> +	.driver	= {
>   		.name	= "dsa-loop",
>   	},
>   	.probe	= dsa_loop_drv_probe,
> diff --git a/drivers/net/dsa/lan9303_mdio.c b/drivers/net/dsa/lan9303_mdio.c
> index 167a86f39f27..7cb7e2b1478a 100644
> --- a/drivers/net/dsa/lan9303_mdio.c
> +++ b/drivers/net/dsa/lan9303_mdio.c
> @@ -162,7 +162,7 @@ static const struct of_device_id lan9303_mdio_of_match[] = {
>   MODULE_DEVICE_TABLE(of, lan9303_mdio_of_match);
>   
>   static struct mdio_driver lan9303_mdio_driver = {
> -	.mdiodrv.driver = {
> +	.driver = {
>   		.name = "LAN9303_MDIO",
>   		.of_match_table = lan9303_mdio_of_match,
>   	},
> diff --git a/drivers/net/dsa/microchip/ksz8863_smi.c b/drivers/net/dsa/microchip/ksz8863_smi.c
> index 5711a59e2ac9..c788cadd7595 100644
> --- a/drivers/net/dsa/microchip/ksz8863_smi.c
> +++ b/drivers/net/dsa/microchip/ksz8863_smi.c
> @@ -213,7 +213,7 @@ static struct mdio_driver ksz8863_driver = {
>   	.probe	= ksz8863_smi_probe,
>   	.remove	= ksz8863_smi_remove,
>   	.shutdown = ksz8863_smi_shutdown,
> -	.mdiodrv.driver = {
> +	.driver = {
>   		.name	= "ksz8863-switch",
>   		.of_match_table = ksz8863_dt_ids,
>   	},
> diff --git a/drivers/net/dsa/mt7530-mdio.c b/drivers/net/dsa/mt7530-mdio.c
> index 088533663b83..7315654a6757 100644
> --- a/drivers/net/dsa/mt7530-mdio.c
> +++ b/drivers/net/dsa/mt7530-mdio.c
> @@ -258,7 +258,7 @@ static struct mdio_driver mt7530_mdio_driver = {
>   	.probe  = mt7530_probe,
>   	.remove = mt7530_remove,
>   	.shutdown = mt7530_shutdown,
> -	.mdiodrv.driver = {
> +	.driver = {
>   		.name = "mt7530-mdio",
>   		.of_match_table = mt7530_of_match,
>   	},
> diff --git a/drivers/net/dsa/mv88e6060.c b/drivers/net/dsa/mv88e6060.c
> index 294312b58e4f..5925f23e7ab3 100644
> --- a/drivers/net/dsa/mv88e6060.c
> +++ b/drivers/net/dsa/mv88e6060.c
> @@ -367,7 +367,7 @@ static struct mdio_driver mv88e6060_driver = {
>   	.probe	= mv88e6060_probe,
>   	.remove = mv88e6060_remove,
>   	.shutdown = mv88e6060_shutdown,
> -	.mdiodrv.driver = {
> +	.driver = {
>   		.name = "mv88e6060",
>   		.of_match_table = mv88e6060_of_match,
>   	},
> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
> index 383b3c4d6f59..4f24699264d1 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.c
> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
> @@ -7258,7 +7258,7 @@ static struct mdio_driver mv88e6xxx_driver = {
>   	.probe	= mv88e6xxx_probe,
>   	.remove = mv88e6xxx_remove,
>   	.shutdown = mv88e6xxx_shutdown,
> -	.mdiodrv.driver = {
> +	.driver = {
>   		.name = "mv88e6085",
>   		.of_match_table = mv88e6xxx_of_match,
>   		.pm = &mv88e6xxx_pm_ops,
> diff --git a/drivers/net/dsa/qca/ar9331.c b/drivers/net/dsa/qca/ar9331.c
> index 8d9d271ac3af..da392d60c9e7 100644
> --- a/drivers/net/dsa/qca/ar9331.c
> +++ b/drivers/net/dsa/qca/ar9331.c
> @@ -1122,7 +1122,7 @@ static struct mdio_driver ar9331_sw_mdio_driver = {
>   	.probe = ar9331_sw_probe,
>   	.remove = ar9331_sw_remove,
>   	.shutdown = ar9331_sw_shutdown,
> -	.mdiodrv.driver = {
> +	.driver = {
>   		.name = AR9331_SW_NAME,
>   		.of_match_table = ar9331_sw_of_match,
>   	},
> diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
> index ec57d9d52072..fe396397f405 100644
> --- a/drivers/net/dsa/qca/qca8k-8xxx.c
> +++ b/drivers/net/dsa/qca/qca8k-8xxx.c
> @@ -2187,7 +2187,7 @@ static struct mdio_driver qca8kmdio_driver = {
>   	.probe  = qca8k_sw_probe,
>   	.remove = qca8k_sw_remove,
>   	.shutdown = qca8k_sw_shutdown,
> -	.mdiodrv.driver = {
> +	.driver = {
>   		.name = "qca8k",
>   		.of_match_table = qca8k_of_match,
>   		.pm = &qca8k_pm_ops,
> diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
> index 292e6d087e8b..8e6a951b391c 100644
> --- a/drivers/net/dsa/realtek/realtek-mdio.c
> +++ b/drivers/net/dsa/realtek/realtek-mdio.c
> @@ -274,7 +274,7 @@ static const struct of_device_id realtek_mdio_of_match[] = {
>   MODULE_DEVICE_TABLE(of, realtek_mdio_of_match);
>   
>   static struct mdio_driver realtek_mdio_driver = {
> -	.mdiodrv.driver = {
> +	.driver = {
>   		.name = "realtek-mdio",
>   		.of_match_table = realtek_mdio_of_match,
>   	},
> diff --git a/drivers/net/dsa/xrs700x/xrs700x_mdio.c b/drivers/net/dsa/xrs700x/xrs700x_mdio.c
> index 5f7d344b5d73..1a76d9d49f13 100644
> --- a/drivers/net/dsa/xrs700x/xrs700x_mdio.c
> +++ b/drivers/net/dsa/xrs700x/xrs700x_mdio.c
> @@ -164,7 +164,7 @@ static const struct of_device_id __maybe_unused xrs700x_mdio_dt_ids[] = {
>   MODULE_DEVICE_TABLE(of, xrs700x_mdio_dt_ids);
>   
>   static struct mdio_driver xrs700x_mdio_driver = {
> -	.mdiodrv.driver = {
> +	.driver = {
>   		.name	= "xrs700x-mdio",
>   		.of_match_table = of_match_ptr(xrs700x_mdio_dt_ids),
>   	},
> diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
> index 6cf73c15635b..a1092c641d14 100644
> --- a/drivers/net/phy/mdio_bus.c
> +++ b/drivers/net/phy/mdio_bus.c
> @@ -1342,7 +1342,7 @@ static int mdio_bus_match(struct device *dev, struct device_driver *drv)
>   	struct mdio_device *mdio = to_mdio_device(dev);
>   
>   	/* Both the driver and device must type-match */
> -	if (!(mdiodrv->mdiodrv.flags & MDIO_DEVICE_IS_PHY) !=
> +	if (!(is_phy_driver(&mdiodrv->driver)) !=
>   	    !(mdio->flags & MDIO_DEVICE_FLAG_PHY))

you could remove one pair of parens, and even change condition to:
   if (is_phy_driver(&mdiodrv->driver) == !(mdio->flags &
       MDIO_DEVICE_FLAG_PHY))


>   		return 0;
>   
> diff --git a/drivers/net/phy/mdio_device.c b/drivers/net/phy/mdio_device.c
> index 73f6539b9e50..16232e7a1255 100644
> --- a/drivers/net/phy/mdio_device.c
> +++ b/drivers/net/phy/mdio_device.c
> @@ -40,7 +40,7 @@ int mdio_device_bus_match(struct device *dev, struct device_driver *drv)
>   	struct mdio_device *mdiodev = to_mdio_device(dev);
>   	struct mdio_driver *mdiodrv = to_mdio_driver(drv);
>   
> -	if (mdiodrv->mdiodrv.flags & MDIO_DEVICE_IS_PHY)
> +	if (is_phy_driver(&mdiodrv->driver))
>   		return 0;
>   
>   	return strcmp(mdiodev->modalias, drv->name) == 0;
> @@ -203,20 +203,19 @@ static void mdio_shutdown(struct device *dev)
>    */
>   int mdio_driver_register(struct mdio_driver *drv)
>   {
> -	struct mdio_driver_common *mdiodrv = &drv->mdiodrv;
>   	int retval;
>   
> -	pr_debug("%s: %s\n", __func__, mdiodrv->driver.name);
> +	pr_debug("%s: %s\n", __func__, drv->driver.name);
>   
> -	mdiodrv->driver.bus = &mdio_bus_type;
> -	mdiodrv->driver.probe = mdio_probe;
> -	mdiodrv->driver.remove = mdio_remove;
> -	mdiodrv->driver.shutdown = mdio_shutdown;
> +	drv->driver.bus = &mdio_bus_type;
> +	drv->driver.probe = mdio_probe;
> +	drv->driver.remove = mdio_remove;
> +	drv->driver.shutdown = mdio_shutdown;
>   
> -	retval = driver_register(&mdiodrv->driver);
> +	retval = driver_register(&drv->driver);
>   	if (retval) {
>   		pr_err("%s: Error %d in registering driver\n",
> -		       mdiodrv->driver.name, retval);
> +		       drv->driver.name, retval);
>   
>   		return retval;
>   	}
> @@ -227,8 +226,6 @@ EXPORT_SYMBOL(mdio_driver_register);
>   
>   void mdio_driver_unregister(struct mdio_driver *drv)
>   {
> -	struct mdio_driver_common *mdiodrv = &drv->mdiodrv;
> -
> -	driver_unregister(&mdiodrv->driver);
> +	driver_unregister(&drv->driver);
>   }
>   EXPORT_SYMBOL(mdio_driver_unregister);
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 3611ea64875e..55494a345bd4 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -529,7 +529,7 @@ static int phy_bus_match(struct device *dev, struct device_driver *drv)
>   	const int num_ids = ARRAY_SIZE(phydev->c45_ids.device_ids);
>   	int i;
>   
> -	if (!(phydrv->mdiodrv.flags & MDIO_DEVICE_IS_PHY))
> +	if (!(is_phy_driver(&phydrv->driver)))

here parens are redundant too

>   		return 0;
>   
>   	if (phydrv->match_phy_device)
> @@ -1456,9 +1456,9 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
>   	 */
>   	if (!d->driver) {
>   		if (phydev->is_c45)
> -			d->driver = &genphy_c45_driver.mdiodrv.driver;
> +			d->driver = &genphy_c45_driver.driver;
>   		else
> -			d->driver = &genphy_driver.mdiodrv.driver;
> +			d->driver = &genphy_driver.driver;
>   
>   		using_genphy = true;
>   	}
> @@ -1638,14 +1638,14 @@ static bool phy_driver_is_genphy_kind(struct phy_device *phydev,
>   bool phy_driver_is_genphy(struct phy_device *phydev)
>   {
>   	return phy_driver_is_genphy_kind(phydev,
> -					 &genphy_driver.mdiodrv.driver);
> +					 &genphy_driver.driver);
>   }
>   EXPORT_SYMBOL_GPL(phy_driver_is_genphy);
>   
>   bool phy_driver_is_genphy_10g(struct phy_device *phydev)
>   {
>   	return phy_driver_is_genphy_kind(phydev,
> -					 &genphy_c45_driver.mdiodrv.driver);
> +					 &genphy_c45_driver.driver);

now it fits into one line (same for phy_driver_is_genphy())

>   }
>   EXPORT_SYMBOL_GPL(phy_driver_is_genphy_10g);

[snip]



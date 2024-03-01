Return-Path: <linux-kernel+bounces-88061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A8786DCE7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A355EB26A87
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734F169D09;
	Fri,  1 Mar 2024 08:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FcHgM3Gb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20F069D20;
	Fri,  1 Mar 2024 08:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709281111; cv=fail; b=JevljkHbT+DxWXV59mtdxypNRkQcpft1TplyCgDPc4w8yyuRn8XYbB4yh2cy5hRlIdzJWMkDA8t0fDPFMW+sQuAR0FkZ1L3mKVHdPSIt4fu13X1OFRp13mByw0Zqx6Z8GrlRtVN5FaHwxmFM6kAWOZKXJBa4pMfFG8e0y9VPANk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709281111; c=relaxed/simple;
	bh=IvnGUE38c0chxvw1ypO0GQQGxbkq1L3l6OXZjPqEH+c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sH86gldO2voRUtVIF253pkX1Se98z5QeCBMkWRZON4UVDCeUd8ryksOkESPVJbtODRBlnYKodKnDBMnl71uY/x1AIDnNofnU5tdRp7Fkz1deNAuoWx8xrvtwdWGfxC12MF2yHjqdxnx3dM9DH0Vi0FQ6HY/Vyve8HtnY7FrLiKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FcHgM3Gb; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709281110; x=1740817110;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IvnGUE38c0chxvw1ypO0GQQGxbkq1L3l6OXZjPqEH+c=;
  b=FcHgM3GbehGWJrfqO6KIbH7K2XlEODB4h9YfgDwWkDamoIgfSmHL72Jz
   dC1KGszKngoDW3yMaAeCtb/pMllOOXWtCq6HHscI4ug5ZTnmaOwgUyW65
   ucjV5OGiGAkCvPTI/8L5ZMFbzE9ggFWsoPiU9nln8fJbUTT2tzF24sG6Y
   2pD0l6+kPir2WiT9LddHjIAH44lo/kH2Vjj9m0RsPTzLfvYEq0yeQOPHZ
   CseCaTt7yMcg13XeQUovpceY6Kv/cFheC1GLTp0xPcXM+7Zy81SLNTnXb
   Nn5NluqrolLe8bqIsscAsHlZJWBe6/myEE0pczcQqMpz0CqGdg+ihUQPI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3925899"
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="3925899"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 00:18:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="8019421"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Mar 2024 00:18:29 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 00:18:28 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 1 Mar 2024 00:18:28 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 00:18:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kdsi8YEy5SE/Yex0QB2ha3CTf/vwho4+zcSMn8fHiV/Zo8s0b637yQ3WUy79FHu4Qf81uPismxNHmtWh+oD+EVBcVcTVUxYU904+6Et/ZTIZwI3V1SaIxDV6RsMnS5M2d3g+WwEpLc9yoNfUvHQ26pUti7UgH62rWdulhZCt4ipkqgtJuhK6lcJX6JkCwYMPB31dIUGmIJnPKTrfx4p00QCpinzrMschYZvyfachlY0CXXzVlUDiXaUFqkbvK3NVz3GvnMAFXcsvMigz+kAMB+AJod3HNBWSPHSJTqfDGlH/vtJTLDWDEGQV0T3uiwY/GCr+tsO+KmUH1BzpvEkWPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCSmJzimcpx2X6GLa64bNjerIyhPAymf6eUvgDTHc4E=;
 b=L24OazNYJeF/MpNnwiOInGKrSv1D80RNlfjUaUeB1yk5J2KbJhWwtWw3m1nKmKzrhGh7b4Xs0LJI41iYi+XC8qOiTIVwtEjVvQOyB2WSVhcTqVjWm265mp1VeAUf7HoIxSJY0ednV1rVxXM/DVvP9qGIpvTDkHM46DnRS+2bFm+lAoh2ctfyGM5NFIo4o1s359LDZ3lyeAOqRThHzylI7qPcOj6HWiVCYwE8TABuWt/YpovSIWEBY5J5Db6SY95wnlQ9xuYS4vJFRA/wHiokXKKWWCcLIP7kCBBM55SoFzDuog5KxB9ceEiYSb5xtx1zUmuB3Jhrl1NMRlH7aJrrig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by SA1PR11MB8575.namprd11.prod.outlook.com (2603:10b6:806:3a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.22; Fri, 1 Mar
 2024 08:18:26 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::8079:6172:11ca:5fe9]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::8079:6172:11ca:5fe9%3]) with mapi id 15.20.7362.015; Fri, 1 Mar 2024
 08:18:26 +0000
Message-ID: <97713349-723b-4ce1-bc12-2557086cef2e@intel.com>
Date: Fri, 1 Mar 2024 09:18:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net: phy: micrel: lan8814 cable
 improvement errata
Content-Language: en-US
To: Horatiu Vultur <horatiu.vultur@microchip.com>, <andrew@lunn.ch>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
References: <20240229195220.2673049-1-horatiu.vultur@microchip.com>
 <20240229195220.2673049-3-horatiu.vultur@microchip.com>
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240229195220.2673049-3-horatiu.vultur@microchip.com>
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
X-MS-Office365-Filtering-Correlation-Id: 320b72c4-b20e-4343-828b-08dc39c82b1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iqhbuOYNu+/6cqgydmRT/yMsTt1cDtCQ1T/Y/zCBI9hnZZQUgGY1oh5wX/tw15g+0UdLqPBebv3/c6I0h0C+9J04FUMKAtpRCQoSG998sJo8AGI4jb3FsjeHuN5JHVnmzmv2LQoYtk6TxDmra5G31R6cNTbeLAUIZVWlndUb55I7S1lLR5D3OSKDkpIi2SfxlvmZHoqMUtLHvoORErmfvD9zCVw1lLhKjCdPBqgebUaFlhTTOZ7UHwfqOihk1juQOxCcu+BF5i7ROuMJc6zsJ+fEJBTFLk11PVKDpD6e7r6644xwwhJKG3vED5qQ87tpjCCijBLc4/k5IrLY456dUq+Bj5o5ExKsnGuHg6gbw8VYlTDdwz4oPKYFIGAQQGBfblP8bTHtw5S0002OlIdpUPFy+KYUVY7ZKpJXG7DtaO/jeL07tPHrjaRb7sBGcFL9i4c9UUttQQ9Ws8xmvgvaW6MW5dxF2zE0Q2cgDpKEEwbWbQdRMYhTvOpGcUyq2n6eCU4qzmUCwW2KUe7z20x6ciIwXGN4VfAkwJTS7Ycabijbnt5OIEC/vgFaXVUSF8rV9gflcknTwccRbw3MUzBpGKI/ruNNUHXAj/vEz/KYJY9rA8oT2auADrvRjaFt13b+eDL/ZfY+dpS6iwfwIeGCJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2tXWkl2Ny9wdkhYMEJPM3AweG5ZWmYxK3Rudm1GTGgwUU5pZTNORzlGY3JO?=
 =?utf-8?B?cDBhN0pXVjQyOEM5NGdhSlpFdFc3SVgybytGUFd4KzdrcXZUd3kvZDZxTU43?=
 =?utf-8?B?R1F2dGN4Skl1aW9zV2Y4OWlzNkUrS1hxMkg3bk02QlJGN3M5aVRRdWswcTdO?=
 =?utf-8?B?STJnbVJnL3piRUdpWjMyR3FvUGFTUkx6RCtnSkYxVzNJQlVYL1lxNk1xUHFJ?=
 =?utf-8?B?MktmS0wybFVTUTdZMnNNeUM4N2h6Ti9aVXp5cmZRSDgzZUpnZ0w3NUVpYjl1?=
 =?utf-8?B?NWlwWVVuN3kyLzJYS1hBbHNFU3hjaFdqVDMvZ0xNUEVtSUhMUjMwOTZ1b29k?=
 =?utf-8?B?NStLZnFzcFh5TlBVSVZaL21KblIwRzJnT1JEeVlOZmhaSVloSTdtaElHS2hr?=
 =?utf-8?B?SDR6RTNCUDhmdEszTU1hZUkrZ1JuRmhuemVoWHRleG5CcitSR0FCaTdwNUZh?=
 =?utf-8?B?RG5KQnZVY3p2cjd6dkpGVXdBeXFOQ1NpclRiVHFzYys2ZnFVZ2VocHpEU3Fj?=
 =?utf-8?B?OFBucHVLUnpIdXMrZ0M3d3k0Tm5NNmdrWHRCQWVFZ2J1RFhUbXNhK3VkU1A2?=
 =?utf-8?B?RVBKaUJaUXJDUzdPTGJvdTJYaEt0M09ldjFWdEtZWGxJVXZmNUxFQkpoSGov?=
 =?utf-8?B?VWZteUl0NGlEUXNDcTR3blJRdWhhQ3pVUjhQcVUwL3BpaHp0MCszQmY1WWRQ?=
 =?utf-8?B?bmlkUVJoMWxnKzBKYy9QU3FqSUZoWVp0WUVQaGF3eWdGZUY0anp5b2Y1YmMv?=
 =?utf-8?B?bU8xd3lNWGU4c29ncVcySUU0RlkrRVJ4cXZXdEJNN3JWUUVBUHFDaU1RaVM0?=
 =?utf-8?B?RVE4Z0VWVDRvYWNDOGs5b2g0azRFRFFIT1h2YzcvZ2JLSlFEM2tJR0VSYUsr?=
 =?utf-8?B?cEh1Qk5IOUFpOUlSMUgzWEZiQ0QwcHhidjh1MytiNnVnZCtpNVg1NHJBN003?=
 =?utf-8?B?VmIwOWE4THVTeUp3bFAwd1djUm9leVVqZWNvRTV1U21GRTlCWHM5QVhWN3dI?=
 =?utf-8?B?Q2tGZEN0UGYxK3FMWER2ZkhWOFNXT0lwWkJJM0hJc3Bvd3llSVpCNDVHZFdz?=
 =?utf-8?B?ZmFTMk5XUE5aSm15d2FXcWdITkRCODVTYWtiMGxkTkRvYUYyOXBncnBOUmpB?=
 =?utf-8?B?dVhRcjYvU29zUUpWdzRNTE1UWW5ZWTd2eEdCaCs1SzE3V2M5YXFXQ2xmczdP?=
 =?utf-8?B?NG8zcExQOVFiTFd6bEZUekduUTBBWjdqaXFkZWovUTRHeXhiZXB6b2pWK3BO?=
 =?utf-8?B?MmJ1QnIxTnpkLzh3ZXZNQkpSWU0rR1VlM3AxZTYrMTVEZjNsZ3lYcXI5blMr?=
 =?utf-8?B?TlI5d20zLzEyTmZSYm5ZQnRZWGVwOS9TN0pob3VVaVJzajdWYWtJOWxSL0U0?=
 =?utf-8?B?TGs3b3IybWhoKzNVK2ExWi9XR3NYbTN1SXgreFdER1dpWTFOUU42Ly9XZUpy?=
 =?utf-8?B?UGYxclNYZFJtNFZyNGdoSDRsZjRsRkZVTmQ3bjNnS0plMVQzcndBNUZyRGFE?=
 =?utf-8?B?Y3VuWHNDOGd3TjZKckxGQm5LaGZUUkJoUlRXOTFXbncyMFpScHFleUxpSEhF?=
 =?utf-8?B?WUJnWFJIVmxLdDd0MllCVzJVSWtNUGp2OTRTS2lNTFpxN0MvYm5Uc1h4ZkNm?=
 =?utf-8?B?cGt4dVBiNkIyZTlpUUZpUVVJZVlJZklwZ29RMWw5ZGxZNVdNYjJUOS9zOEZM?=
 =?utf-8?B?TldIcWFiTGdlcFBEZjkzWDVXL0FMRmFtSHdzTGhqOHNvVSs5RkM2bGg2aHoz?=
 =?utf-8?B?MEJwZlBaaW1tck5tc1RoemRsRXBhK1AraVpWSmhncXJSM3d1Q1dhZThlV05W?=
 =?utf-8?B?OHprdkhBQ3B4blo3OTdidXRITVhSTkIrR2dDSWdhbnNEWXBlRGFGOXB5Skw4?=
 =?utf-8?B?ZzNqcDBMandwQnNlejhocGdKSXR4bUg2dGdDRE10c2lKTUtjV2F5YUs3REVB?=
 =?utf-8?B?dDJxRlBUWG55QXFTeTFUcnl5ZjBzaTBvQktPWDFxdW5URXQ2WFp2NEIzSG1x?=
 =?utf-8?B?cUpaODdEc1d3MDdjN0VPRlFyNUV5Z1FET0JaRDk2K2ZUM0UvYzhvalQrdVRo?=
 =?utf-8?B?YkJwU3JCclRjRXNpWm1ya3hGY1BCMGNvbFpvQ3kwSklubWNNbTI2clVwVVlJ?=
 =?utf-8?B?TTZkWkhSWkFwQ3JPeWVQNkZIR2M2RUhvcmF5Vm1aaTdYUU5UaDM1VlpRYzdM?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 320b72c4-b20e-4343-828b-08dc39c82b1b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 08:18:26.1528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mo6X5TAUV4lUOHbOfEbO8vrLT5bnzOr+dOlZTRQtA9AqVUerItkeC8XblDiSkGepC141tws6Ye3vdF5FcyaUW5e21uaZPUxIud4wJctYO/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8575
X-OriginatorOrg: intel.com



On 29.02.2024 20:52, Horatiu Vultur wrote:
> When the length of the cable is more than 100m and the lan8814 is
> configured to run in 1000Base-T Slave then the register of the device
> needs to be optimized.
> 
> Workaround this by setting the measure time to a value of 0xb. This
> value can be set regardless of the configuration.
> 
> This issue is described in 'LAN8814 Silicon Errata and Data Sheet
> Clarification' and according to that, this will not be corrected in a
> future silicon revision.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/phy/micrel.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> index 88cc03982bb78..788fdd54fd22d 100644
> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c
> @@ -117,6 +117,10 @@
>  #define LAN8814_EEE_STATE			0x38
>  #define LAN8814_EEE_STATE_MASK2P5P		BIT(10)
>  
> +#define LAN8814_PD_CONTROLS			0x9d
> +#define LAN8814_PD_CONTROLS_PD_MEAS_TIME_MASK_	GENMASK(3, 0)
> +#define LAN8814_PD_CONTROLS_PD_MEAS_TIME_VAL_	0xb
> +
>  /* Represents 1ppm adjustment in 2^32 format with
>   * each nsec contains 4 clock cycles.
>   * The value is calculated as following: (1/1000000)/((2^-32)/4)
> @@ -3304,6 +3308,20 @@ static void lan8814_clear_2psp_bit(struct phy_device *phydev)
>  	lanphy_write_page_reg(phydev, 2, LAN8814_EEE_STATE, val);
>  }
>  
> +static void lan8814_update_meas_time(struct phy_device *phydev)
> +{
> +	u16 val;
> +
> +	/* By setting the measure time to a value of 0xb this will allow cables
> +	 * longer than 100m to be used. This configuration can be used
> +	 * regardless of the mode of operation of the PHY
> +	 */
> +	val = lanphy_read_page_reg(phydev, 1, LAN8814_PD_CONTROLS);
> +	val &= ~LAN8814_PD_CONTROLS_PD_MEAS_TIME_MASK_;
> +	val |= LAN8814_PD_CONTROLS_PD_MEAS_TIME_VAL_;
> +	lanphy_write_page_reg(phydev, 1, LAN8814_PD_CONTROLS, val);
> +}
> +
>  static int lan8814_probe(struct phy_device *phydev)
>  {
>  	const struct kszphy_type *type = phydev->drv->driver_data;
> @@ -3342,6 +3360,7 @@ static int lan8814_probe(struct phy_device *phydev)
>  
>  	/* Errata workarounds */
>  	lan8814_clear_2psp_bit(phydev);
> +	lan8814_update_meas_time(phydev);
>  
>  	return 0;
>  }


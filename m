Return-Path: <linux-kernel+bounces-97652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D24A8876D1E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 23:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 895A6282EC0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9551860DF6;
	Fri,  8 Mar 2024 22:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GAI8WV6h"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EB160B8C;
	Fri,  8 Mar 2024 22:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709936907; cv=fail; b=SEPULs4oyWhTX0z3kBChTPGBMUF5O5QGjiJDS1Nd3S6/FfXezsL/G1i1qvdvsNTqKDoYomEDu/9rAIsqbS/QT+4rT1DNPnHcf0xgW5keJteJJyWAvEtLN+Y0oSvHrnMHlbtdKQeXGrMZm2eM26qfclWVR3fnyK26F0lnLGHr3xA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709936907; c=relaxed/simple;
	bh=s7wvEmbPeI/jp659H7cQKNUtmXUDLwIWVFAuqchzLFc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FkfidjGLfqQa4WpEMWcvhxed6GLkPb1qBaY0Jd+a0X3aUvR5Ch2KsqOOFyiRLIp1rCH6k0pDBXKDPS38KyniBpOuaCi07lEdiCAwELnXIpQcg3ReRX/VMIQELRNwLtedY4y7LNL2mj6GGfVlgTWB/zycicJZW4TdpNm4dOigMxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GAI8WV6h; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709936905; x=1741472905;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s7wvEmbPeI/jp659H7cQKNUtmXUDLwIWVFAuqchzLFc=;
  b=GAI8WV6hAZ+HOlAD4WOsjxGC75VM3yv3KWCOX/EFSk+G1grenz8bhwmn
   r9j8LR2nlij96hRvSN0bf5ZK6w32SrxhkKMsKwmgnuYn1Q89rEhvdRRvR
   p858HmrvHKrn04SJnyqHIPIddu6Ibp1Z7B2apBMN+JCwG5poX2cSXJLmj
   MlZkhXhxddEcuWSqX2tSq8T3IIeuJxX/2r/phJwJmjM8j4Qw6fZzE6ynL
   qOwDokgA8yRrof+bRnRmwPuFKBnBnGOzxjwZjn1l7skQy/Q5AewazBoQl
   Zowpn09HzsHmlJWr5ENBJW4gBc7IqD6TJITgxBfBYSm/Xk6T6WIxOWh6l
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11007"; a="15814785"
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="15814785"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 14:28:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="10652566"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Mar 2024 14:28:08 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 14:28:07 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 8 Mar 2024 14:28:07 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Mar 2024 14:28:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPxzk4HvFdfR2M3ER3d86tvdCIHeRrOuhULoDmx0dcdBoNS4sjhrdRyRWFi3QbQCNS4mWIM0Nyiq6H2/OutUNsC/c+SKfVJhGuGpQ2u0+UQhmurL6cJrfj8LzS64jmDcpGKGt2ERwrqRQWZl/Jzdnf0/FiTdtsjnzI1CWAY1e32XfyuUFTJR8Gg3PkliKhXqMb+PSoi1HqswemWidJR3aniFTfeYas3KH4qxq++GklhZjBLeOTe8cqj655vgNWny3o64JH663y4WDAckx/8UM7tgNqovLvmUWcLxy/0wD+MvFnwICVRszggUxSnfODF4khaDvj1qWNs6LHfouUo/Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K716sMpAUBHSNeBImCU3v/ZCwSsEKhoU4OxCuiycOBg=;
 b=MmK6QYhBEtoROo0t2ZxHrb4o9iMBA6Mcfvd6AGE5fCUqtZP07pqqPM0PKlcQUA4m6Em3cdyeycEvESUZmFN5wvPA8x2kIMuHvjEw3YUzrXR10pEFmZdX3lG4v0SK4cqsk7vCoIAJxEzmXt4G8Fv/tieqCiYn9Ll0xjPxs1DW50FY2iU7XKihhiglIDB2XNXcbn/p5h1f//ByRDPNiTaA3GdJ+3P4+IvVxGU6ottKcUKMeN2qFgyyyFAOigbNqUkD6c6DECm6zqnRe4iSMkYUjrbvVaDrptVlmnTdtmC4CxNUsybfQQPDAcMYwy+1hPuY+L15bIVxJVMib2O7SKAXlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM4PR11MB6017.namprd11.prod.outlook.com (2603:10b6:8:5c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.6; Fri, 8 Mar
 2024 22:28:05 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7362.019; Fri, 8 Mar 2024
 22:28:05 +0000
Message-ID: <b2862eca-bff1-4def-9ac2-2ee426d3c6dd@intel.com>
Date: Fri, 8 Mar 2024 14:28:01 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next v1 1/6] ethtool: add interface to read Tx
 hardware timestamping statistics
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
CC: Saeed Mahameed <saeed@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Jonathan
 Corbet" <corbet@lwn.net>, Richard Cochran <richardcochran@gmail.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
	<hkallweit1@gmail.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"Ahmed Zaki" <ahmed.zaki@intel.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Hangbin Liu <liuhangbin@gmail.com>, "Paul
 Greenwalt" <paul.greenwalt@intel.com>, Justin Stitt <justinstitt@google.com>,
	Randy Dunlap <rdunlap@infradead.org>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Kory Maincent <kory.maincent@bootlin.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Jiri Pirko <jiri@resnulli.us>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "Dragos
 Tatulea" <dtatulea@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
 <20240223192658.45893-2-rrameshbabu@nvidia.com>
 <abbff26c-c626-42ce-82a9-4dc983372de3@intel.com> <875xyex10q.fsf@nvidia.com>
 <a84df9ec-475d-4ffc-a975-a0911a57901e@intel.com> <87il2evhtk.fsf@nvidia.com>
 <ec969f62-a1bb-4287-a4eb-083201134bae@intel.com> <87le6tvpq8.fsf@nvidia.com>
 <d030d02d-150d-4337-a063-69da28049548@intel.com> <87edcljnp0.fsf@nvidia.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <87edcljnp0.fsf@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0087.namprd04.prod.outlook.com
 (2603:10b6:303:6b::32) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM4PR11MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: 85e706b1-f94c-4af4-a76d-08dc3fbf05eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sKCuabgUqeA/NL+N1Zs6BMi7WSfkMX8f5NlzxSnY4aGtsVBeDUuXMtlnc/QE41xpPAXDA5k83SfcHRRPnNAldNwNzU4j3WQmx9/EuIyrhr71pEzSr2AePsjsg82uZyznFTIr3q/Y0zf9X6GHtyYlhvHjDnMiLsBOLHVysjskJnOQZO7ue31lULNC2fguC42X/KXki5tRiCqE5aHKpbig3vi8fb/27Zh6G4c30yP7MiHea8oMllRoM5JVxRxRSEydqAzHYZHD/U7HsRtJAhry/CVJJMs7ot4JEfone4M+EgSO//aXL+BaGCvl+6l9qaKNKpunq0FuIgGgOfZCahoURcyzFnYj7Ufux0R1GCFSM7NpK1XwBYR31pokA/+y+OGe2S9zzSaMuIv8ZrIw6vkZp8U8QDhVfUxd1WKswtZ+qULEPInbapUU71fgeWktKBZTJCsbcNblE6vhU24EpRQTL/ijMWJrnT9vwO+7x+LQ4d3p1g5U9Z2qPSo3mIjsxosJSU3V+DzowzNdQVIkcyxW+K5Vx+xXMVl+achaM+L9wH0Ek/861qRqUQCiAk0RFmCdOIs/oFCdqjPmT+1kujzyugW1zBvZBkFnRa4j3bIXXY+hovNUOCHwb2XylKZuMUhP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHNRa3VwcjNXWEpHWWVWQW9CNGptV1Q1dllmbUw2alkyT0xJaTlVWWlRZVdQ?=
 =?utf-8?B?NnhJSXdycEwyb3dtQ2xHYmx3b1F3ZmZISkRkRnVrdzZEUkpTSTQxeTY3a2Za?=
 =?utf-8?B?TGFDV05kVjZuOVVHcXhQeGNjNUZvVE9kZUlLSmF6RkJscElvNGRzY1JGU3RP?=
 =?utf-8?B?M1Nic1BpUERXZmRXMnAxeWcya09pZm5OcjdkZE01U3daajBYelBxeWQvUCtU?=
 =?utf-8?B?TDB4VHN3QmdLa09nS0ZabE81RWh3WlMvRkxMZ3B2dXB3L1hKUEtGRVFJQ3dK?=
 =?utf-8?B?ZCttWUp5WnlmVFdRSENSRUk0aW1zUmExaklQbVNVY1RYWVdTRVE4Q0pnV2JV?=
 =?utf-8?B?dHJBaURmWW9BRnJVSU9DbHZTV09UNVRlK0dDeXhUU2Z4WUQrSTBMQ0dpaEgx?=
 =?utf-8?B?UWgvZGdtalZQbzVQQUFIUitSanVHZ1JQY3h0aklyUnRZK0h0TWU5NnVMNDR2?=
 =?utf-8?B?akgvM0JIOWRYU0RndTBaRnoxelJrUUpXd3BtSTQ0d2VWdFova2t2YVova0Yx?=
 =?utf-8?B?SGlXMkc5eVlxekh3Y2Npb25JMm1sclRyUnRLRW55TFM5OGFoTFpHWnNoN3lT?=
 =?utf-8?B?V0Q4b1lzQ3dLMkl4Slpsdi95VUg2TkJjRVZhNytwRndMd1VuWUJTMXhkelhv?=
 =?utf-8?B?NzF4S3BlOWQybmxpZkhrVEtuNXlyUVV3alUrTEFmRVhObTNrV2J1cDBLbTI5?=
 =?utf-8?B?UDVMZWZNYUcwODNEZG9WSWRZRlFnSGgwK1RudndkaHNacGRyY1FOL3oveG53?=
 =?utf-8?B?bDFmSmxCR0liVGRwUkJNUHE1ZlNzV3NhdnEvTWlSWjNSNVVsL2JWZGdQamRV?=
 =?utf-8?B?VlRDdVE3ZXBXcUVyckdDNEJnN3VxNi9TT1BEQkVMWXJwMlltaERBNkVHRmxC?=
 =?utf-8?B?RWU5TUpaZlhHT2dLOWtxOGJlY1RkN1IxUi8wcERBNjBJYnZ6VTZFSGI3eVgw?=
 =?utf-8?B?Z1Y5YXAzUENhUUd0RzJHUldURGw0eHViTW1ZSWF6bFhmWE0vVkcyZ3BQeUpD?=
 =?utf-8?B?YStQaFQvMkJySzBJNFVIRUoyWHI5NGFCNzRBelhhc3VOVjhCTEpxdEk2UDUz?=
 =?utf-8?B?ekdYM3RsUzBGWXlpYUt6aDRvam54QmU2bzUzdHBXczVqZ0ZoOE9MeWZkZlNB?=
 =?utf-8?B?MXVEMnZ0QmVmMVpqOGJENHNQaGJxNXoxM21sUjRNL3oweWh2UUxvcTB2U0lU?=
 =?utf-8?B?dVVPWmVpZ05zTllJbmtSaWJERngrdWFBWjlYb01oY3NyUDRZV0hXR0x6TTRr?=
 =?utf-8?B?ZzdWdjA1SnFyTlZ4bndzVVhOR0M0a0srM1ZnM2NMV1NOOXhZNjQ0ZGtJdzQw?=
 =?utf-8?B?YXduZmZJTU1rSXdYU1R5alR1T3liWWQ2K2gzd1ZiSVRBTG4rSDVEcGl4WG1G?=
 =?utf-8?B?eFE0RSs4ZFlHSWlHWUJJTW9BUXN3NGdjbzdwck1scVdTOGVkZWxhaVdCRW1M?=
 =?utf-8?B?WktSazNlOVZNakFrTzBHeUVSRFk1S3NiUWEyMVMyMWJBdjAwNDhmM2xZYXdJ?=
 =?utf-8?B?cmE0MzhwcklXR2RUWmQvVW9ySGUvWnpqdzZYUlNHcXNZN1k5ak5CbmVWUGVh?=
 =?utf-8?B?TzQ5QUdBcm1tRXJxcThEbUR6clJWM3UrRnk2c1Z2Ti9VN3FWU3lFZUV4Ri93?=
 =?utf-8?B?MmxpTWQ4Uk9nOERFNHBSZTZhSDlRTHcya1JubkdsdXJCQm1SWnRMbkdzU1VN?=
 =?utf-8?B?WnJxNDdZYWlUL3dYSGFJQnlNZThUUUFRNHI3VWFKaC9EZU5oK1FRT3ZDQTE2?=
 =?utf-8?B?d0d6SzlWakJRTXRCbllMWjUwLzd5OUV4U1h4enc0T056Z0ZWWkg0UEI3bklk?=
 =?utf-8?B?a05IWjViL3lUUHV2Unc4Qm03QWNMRGV6U0czbzFXbzBOc0N4ZElZUUdqZGV5?=
 =?utf-8?B?MXNTTjVrVzdSRXdFNm02Q2JDLy9EQXpSQzdqY2xSU0hYbWsrbHEyNkpKejBm?=
 =?utf-8?B?ZlNPckdWcmdDM3BJbU5uTk1xTkl3SHZkUVc2VThZOS9KaWlacHdrS2xUQkg4?=
 =?utf-8?B?SUFzd3JndllXVkI4NlljamJKQW9HM0NGY3ZEOUhRRkc0RHplOGJvS29lRlVy?=
 =?utf-8?B?MVVFNFNQeEUwdnJUcnVoNGpaTnRPelYzaVl2OTE2VzlGQy83OG0zNDFja1V4?=
 =?utf-8?B?LzQrZGxQSDJXZmlsb1RKUzZhR3V5VXZkSk1hc3RqOU9uYktOTlZyejdkRlE1?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e706b1-f94c-4af4-a76d-08dc3fbf05eb
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 22:28:05.1749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ImR9g+jSsemqmOPSsUqWEJ5+JOm5eQh+q7ZDb9g6Gx8EcU1imh+AA07SuGBTvXfGhcWhF+5xfTiQAA531tv4DeuDPPEUkP9QXQ9haasTQsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6017
X-OriginatorOrg: intel.com



On 3/7/2024 9:09 PM, Rahul Rameshbabu wrote:
> 
> On Thu, 07 Mar, 2024 19:29:08 -0800 Jacob Keller <jacob.e.keller@intel.com> wrote:
>> On 3/7/2024 10:47 AM, Rahul Rameshbabu wrote:
>>> Hi Jacob,
>>>
>>> On Mon, 26 Feb, 2024 11:54:49 -0800 Jacob Keller <jacob.e.keller@intel.com> wrote:
>>>> On 2/23/2024 3:43 PM, Rahul Rameshbabu wrote:
>>>>>
>>>>> On Fri, 23 Feb, 2024 14:48:51 -0800 Jacob Keller <jacob.e.keller@intel.com>
>>>>> wrote:
>>>>>> On 2/23/2024 2:21 PM, Rahul Rameshbabu wrote:
>>>>>>> Do you have any example of a case of skipping timestamp information that
>>>>>>> is not related to lack of delivery over time? I am wondering if this
>>>>>>> case is more like a hardware error or not. Or is it more like something
>>>>>>> along the lines of being busy/would impact line rate of timestamp
>>>>>>> information must be recorded?
>>>>>>>
>>>>>>
>>>>>> The main example for skipped is the event where all our slots are full
>>>>>> at point of timestamp request.
>>>>>
>>>>> This is what I was guessing as the main (if not only reason). For this
>>>>> specific reason, I think a general "busy" stats counter makes sense.
>>>>> mlx5 does not need this counter, but I can see a lot of other hw
>>>>> implementations needing this. (The skipped counter name obviously should
>>>>> be left only in the ice driver. Just felt "busy" was easy to understand
>>>>> for generalized counters.)
>>>>
>>>> Yea, I don't expect this would be required for all hardware but it seems
>>>> like a common approach if you have limited slots for Tx timestamps
>>>> available.
>>>>
>>> Sorry to bump this thread once more, but I had a question regarding the
>>> Intel driver in regards to this. Instead of having a busy case when all
>>> the slots are full, would it make sense to stop the netdev queues in
>>> this case, we actually do this in mlx5 (though keep in mind that we have
>>> a dedicated queue just for port/phy timestamping that we start/stop).
>>>
>>> Maybe in your case, you can have a mix of HW timestamping and non-HW
>>> timestamping in the same queue, which is why you have a busy case?
>>>
>>
>> We don't use a dedicated queue. The issue isn't queue capacity so much
>> as it is the number of slots in the PHY for where it can save the
>> timestamp data.
> 
> In mlx5, we use a dedicated queue just for the purpose of HW
> timestamping because we actually do have a similar slot mechanism. We
> call it metadata. We have a limit of 256 entries. We steer PTP traffic
> specifically (though we will be changing this to any HW timestamped
> traffic with the work Kory is doing) to this queue by matching against
> the protocol and port. All other traffic goes to the normal queues that
> cannot consume the timestamping slots. When all the slots are occupied,
> we stop the timestamping queue rather than throwing some busy error.
> 
>>
>> In practice the most common application (ptp4l) synchronously waits for
>> timestamps, and only has one outstanding at a time. Likely due to
>> limitations with original hardware that only supported one outstanding
>> Tx timestamp.
>>
>>> Wanted to inquire about this before sending out a RFC v2.
>>
>> That's actually an interesting approach to change to a dedicated queue
>> which we could lock and start/stop it when the indexes are full. How
>> does that interact with the stack UDP and Ethernet stacks? Presumably
>> when you go to transmit, you'd need to pick a queue and if its stopped
>> you'd have to drop or tell the stack?
> 
> Let me share a pointer in mlx5 for how we do the queue selection. Like I
> mentioned, we steer ptp traffic specifically, but we can change this to
> just steer any skb that indicates hw timestamping.
> 
> * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h?id=3aaa8ce7a3350d95b241046ae2401103a4384ba2#n71
> 
> Then, here is how we manage stopping and waking the queue (we tell the
> core stack about this so we do not have to drop traffic due to some kind
> of busy state because our metadata/slots are all consumed).
> 

Makes sense.

> * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c?id=3aaa8ce7a3350d95b241046ae2401103a4384ba2#n775
> * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c?id=3aaa8ce7a3350d95b241046ae2401103a4384ba2#n257
> * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c?id=3aaa8ce7a3350d95b241046ae2401103a4384ba2#n397
> 
>>
>> I think I remember someone experimenting with returning NETDEV_TX_BUSY
>> when the slots were full, but in practice this caused a lot of issues.
>> None of the other devices we have with only a single slot (one set of
>> registers, ixgbe, i40e, igb, e1000) did that either.
> 
> So we experimented that even with a single slot (we had reasons for
> testing this), the dedicated queue for timestamping worked out nicely. I
> really would suggest investigating this model since I think it might
> play out nicely for the Intel family.
> 
>>
>> If this queue model behaves in a sane way (or if we can communicate
>> something similar by reporting back up the stack without needing a
>> dedicated queue?) that could be better than the current situation.
> 
> I personally really like the dedicated queue in the device drivers, but
> if we want to instead model this slot management work in the core netdev
> stack, I do not think that is a bad endeavor either (when slots are
> full, hw timestamping traffic is held back till they become available).
> I do think the netif_tx_wake_queue/netif_tx_stop_queue + dedicated HW
> timestamping queue does work out nicely.

Ok so if I understand this right, .ndo_select_queue has the stack pick a
queue, and we'd implement this to use the SKB flag. Then whenever the
slots for the queue are full we issue netif_tx_stop_queue, and whenever
the slots are released and we have slots open again we issue
netif_tx_wake_queue..

While the queue is stopped, the stack basically just buffers requests
and doesn't try to call the ndo_do_xmit routine for that queue until the
queue is ready again?

Using a dedicated queue has some other advantages in that it could be
programmed with different priority both from the hardware side (prefer
packets waiting in the timestamp queue) and from the software side
(prioritize CPUs running the threads for processing it). That could be
useful in some applications too...

> 
> Let me know your thoughts on this. If you think it's an interesting idea
> to explore, lets not add the busy counter now in this series. I already
> dropped the late counter. We can add the busy counter later on if you
> feel this model I have shared is not viable for Intel. I wanted to avoid
> introducing too many counters pre-emptively that might not actually be
> consumed widely. I had a thought that what you presented with slots is
> very similar to what we have with metadata in mlx5, so I thought that
> maybe handling the management of these slots in a different way with
> something like a dedicated queue for HW timestamping could make the
> design cleaner.
> 

I think I agree with the queue model, though I'm not sure when I could
get to working on implementing this. I'm fine with dropping the busy
counter from this series.

> --
> Thanks,
> 
> Rahul Rameshbabu


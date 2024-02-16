Return-Path: <linux-kernel+bounces-69399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D9E858871
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC284288708
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272491487E3;
	Fri, 16 Feb 2024 22:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H5huawOF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8B71482F0;
	Fri, 16 Feb 2024 22:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708122043; cv=fail; b=Fu1uXBlNDcDGHtI9PnC8tZfU/0I9yNIE8+XgOQznxo6DKE5c+iFP6/AoNnxNO4w7UhAPtwPuIMvfNRHyVEVstB96JjV8PoUD5bu1Si19t+XLiECYsaO340v/K7D4FkDQnyGhR5VXkqZLyZUq0LpT6l3yHnZzVxmQcPuv5u6fs4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708122043; c=relaxed/simple;
	bh=lxoUGfNA2hfnMyEqjaEL2chpVVX5UkYFiJNdUHBLMAM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Btsccvd7ed3QirM9jiIQ3yepjaeEEh1YCtu+lJ/mI3su34rgqPccg9sEKoYzqXmfX028yxlSNqWP5El7BTOEu5mWmZHfuY4zu7a5dwVCNiHeOg1D5fb0UFj4cVwfxG8Vpmjl+So86S2TLualHD+7tQ+/BfjniY30rpL7Ewv4THU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H5huawOF; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708122041; x=1739658041;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lxoUGfNA2hfnMyEqjaEL2chpVVX5UkYFiJNdUHBLMAM=;
  b=H5huawOFjzGMXg8javdCSdiIpbZzl5P1OI0kvQ3yXC+RYK1iGOTdtAl8
   N9i4GeeFaskHU3Vpqar29Fy5ro2WtvsE8+B3U9CUj8qH1y4ANrGF4Bftj
   1tiPl/+2zXuTts1OmwZbggZkcas2sNgYMwuowi1F5ouC9GX2sVkS8ukpi
   FRl+3gtaWjrOV5LgLZ2JKI5q+n27ZIO2PixKEk7Z8XjvV8wbLBnfUXWRJ
   9dCfELqedltwqbD9mkCbjeQM44liX7D0V68IQU4CaLA/jjfCHbyCmS3xy
   8v6DmA72lQmsbhALS9oMtGc5oKTfpLRhPIiaD/JKVtA8y8Cxblf26mW87
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="2171923"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="2171923"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 14:20:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="4338531"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Feb 2024 14:20:39 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 14:20:39 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 14:20:38 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 16 Feb 2024 14:20:38 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 16 Feb 2024 14:20:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWCaf/Fa2cQ95UVrdXyGeqXTXn8oNo3a9XOL9QvONkw2qlgVtDeHq/IqrdvFHvCS4rCbUUS0MDsvt9aLdpeZBtc7S6yeHzm8AXiMWNnubgBlXl/0RIsUpAV5pP8wZnhClFA7NLcupVMNyCoiCznCzhIvv1n9XJ9y+Q4qTsYAJ+h/YGbuUd30MWeoggKS6Z0w2jRpD8wuMktcv+QKBclu8CPZc3tcoCtab5igbhJxaFOooCq7vauTXEhs1A5kUpnVA6CkTFj/YKljq3B+enRhucaGqVOPwpsGnVWmHMkqNk1a0OTmwBqjWiEaDlrNR5fDfgQMAwo9ptIeTGDEJTHFJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mg3rdV1LPyjGyMvZOEuupQLjX5G6RuAAh4soVABkzn4=;
 b=mFiYvjo3tAgCKmKXYLOe31kji0VCoyQfZhkUKIi65IidTwAifSy0zfo2W/LieT0h9Dh2mxK65h1MuIhBlnwTnqhEv50pQBWtiilHwpBw5QkB9SoTufyDsD3wYq4AD+Dtv8TzIfAI6yeKhTgxcP5P9GGc38onJVhDDPmCAe4JTwnfJit5UT1U/zpztAQIJIkoiSKSvqs1O+k9RzE7DdAYTUb5mOy/9RGAH1QflKg54liOdcma9r4p/7L8QghBrLtKR0Vock3oj7R4UwS3AndvhtBql4wzDNKm4Z/RrGNh7OqZS1zTKrkxNM0gXJ1Ti5pP0zYD7xyt1lWZQJKIL+mp1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH0PR11MB5476.namprd11.prod.outlook.com (2603:10b6:610:d7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 22:20:36 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::d543:1173:aba6:2b77]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::d543:1173:aba6:2b77%3]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 22:20:36 +0000
Message-ID: <de819ec8-4723-4fdc-9e3e-5a0c9632dec6@intel.com>
Date: Fri, 16 Feb 2024 14:20:34 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: ethernet: ti: am65-cpts: Enable PTP RX
 HW timestamp using CPTS FIFO
Content-Language: en-US
To: Chintan Vankar <c-vankar@ti.com>, Dan Carpenter
	<dan.carpenter@linaro.org>, Roger Quadros <rogerq@kernel.org>, "Siddharth
 Vadapalli" <s-vadapalli@ti.com>, Richard Cochran <richardcochran@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, "Eric
 Dumazet" <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20240215110953.3225099-1-c-vankar@ti.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240215110953.3225099-1-c-vankar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0049.namprd04.prod.outlook.com
 (2603:10b6:303:6a::24) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH0PR11MB5476:EE_
X-MS-Office365-Filtering-Correlation-Id: eadccc6c-f14b-43a6-542d-08dc2f3d7fb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Grw8nxX0reavz6hP6Tpp63jlzYH1Esl4kkProqkogxQzHSQu+mwA8ZkCv1rf5lvFAJ4Ww6qOG63McwxKnKlQW+Yb+dmRK+KM30mbQSxOtNPB6uYahLk8KVdrPZZDsaLDoiYu1RG8Bo6xD3lT0EdBCDW6+4d/WaJxk9h76ScVUYzSaheNpbjbyAY1i8rG83dRu8bbrxKvRpUcQAQOd+oLiLQiSfHTPhQAbUxFuVWJ/0LY2CrXmYY+DkLdgHH67SCjzqUM9Aakz0VQvZT78TrfggBkP8a03EW2DwS5Z5fyPCl9cuok4kxS2RDLXbyPve/jSNDWnMcaDmTyZ+DVzl8kA9ldrNbsDEcBwyYsX3uXRY1C/UqPosXOIU9Q7yxFFQkAy0lmHjuesw07RTS+IHxf1Hal7HxElRP7LNq8FbiQtqwfe8OlnMprBaObWOV6WgLtekYZ14RF24jM6yrJ6Q3zx3Je5BjBKUJz5ZFWX2DGR7X6PCmcpCpWDjRZbk0bpP6n9/5id9yK1yk8dsKK60B9RxcLnt3tXQ6bKtKU6qngv0ofRqQ9/UqvyZJTo0UaNATq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(53546011)(6506007)(6512007)(2616005)(6486002)(478600001)(31686004)(2906002)(4744005)(66556008)(7416002)(5660300002)(66946007)(66476007)(8936002)(4326008)(8676002)(110136005)(41300700001)(316002)(26005)(36756003)(31696002)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1Q5MGlONWwzYUNpOHpMc3czMlQwSU52ckJBVW0wU1hHQWhSdXBYaUxtVE0x?=
 =?utf-8?B?VVBtWHNxa3ZxTWswdDQ2SEsyb3VYbVlqSDhhNDZGUmtlQWJHM283cmFLZlhO?=
 =?utf-8?B?MTVScmNiblJDQ2oxZElQamxnQWV4alA4OWhJeHZ0NTdaNkgxdjE1by9zWTJZ?=
 =?utf-8?B?cTJMWHYrM3hGUjdlWWpFeHArL1VxYnR4SGxKdVEwaWhmSFZpbVZjbktDa3lI?=
 =?utf-8?B?VGFWbFRGOEJmeWQrNkVXd2lUdEQrTXMycHVYUzhVUE5Jb0JVY3RhNXphSGJp?=
 =?utf-8?B?b1FWaCtVSTVRNWxXZmhqVUt2MEtPc2Y0eDVGWms1OEtPYy9janFGUkpLU2xN?=
 =?utf-8?B?dXIxUmthZ2hLbjlhRW13elRJUVJkZUM4L0tiNGZId2VGKzVSUG9MM211R3cr?=
 =?utf-8?B?bXo2Vm9YMXlQYXZFSkg0VmFiVDh1Mm5FVDNDUzczSk93TExIMDVaUGJQV2Jx?=
 =?utf-8?B?ekgvdklVUmZPcTlIU1VtNzJTeUhhVTJjcUg5cEg3L1Z4OXZjR1RhWng4eDFG?=
 =?utf-8?B?U3BGOTJ0SkJ4ZmJVcmlMMng5aTlkaVlxdE1tL3VGSlY3VE1RMUkwT3o3cmcx?=
 =?utf-8?B?QzVQRmVwamZMY01icU1yUTI4L1J0L0NSMEUvTTJ2cmdGQTlnYUVmTnJpb0p1?=
 =?utf-8?B?YmJIN1VMMXJ6WWw2eVV6b1pMR0N5QU5BQUQxWHpPSkF3aWx6M1UycGZ2a2lM?=
 =?utf-8?B?d2tNSVN6VWNPc1p4Vk40bEkyY1NpbHJobzJBd0RvcTU5STQ0U0UvUStOU3k5?=
 =?utf-8?B?NlFHbnluSEVMZWNnbkFIdEhuQ0szSmpubWFJdUgza3VnQlg4eGRWdXYyRVIz?=
 =?utf-8?B?b3N3b1B0dWpWdC84b2tOTi9ENGhwY1NJZnI0MVM4R0RwV1ZZZXdSRDNFZklN?=
 =?utf-8?B?V1dkOGt6NmN2ZFFuWmhjNVJqczE2bGFreU5vcFVab2kwRHpIeTh2d01zR0Zv?=
 =?utf-8?B?b0xDam1mUGxsb1U5V2EyY1RhczdGQlZiNi95Sk45ajFqenprbGlvTmlOb2Uw?=
 =?utf-8?B?OTFkeGFpVzlaYVZlZDJPMkNaRlgyUU13SVdWajJxdklVTDdwU1FHUW1wUWRu?=
 =?utf-8?B?cWx2NUp0VTJTa1lKT21mdEhrNHRQTHRSaXQwTjZTY2FUZDhXeGU1bUR6aGJh?=
 =?utf-8?B?cU9yYVZkSHhtbk56cjhGajU3ckwrYS9xQ29FVEkzS2tJQ29aVVZKUlVaTy9Y?=
 =?utf-8?B?b01XcUgyTUYwd1dDVUxvbUVrUnh0VkF3UTJ4MVZRSmgrWlJDMXFLT3czQ1NY?=
 =?utf-8?B?MWZ2NE03d3RDcU9HZlAvMXFhbWxsWTJseGszMFRWYzI0WmxJU2VpOGY4QlJX?=
 =?utf-8?B?SDJWUHFLQzVKNU5pKzl2OU5NeXFhdUlUSGVkRngvVmZBUzAxNURZVDhJTmpl?=
 =?utf-8?B?eklwR3JhVHRmRnl6YnZLalpDYyt4MDVvNHdoSXprVk84MG5PYUJGVkVYSkZ2?=
 =?utf-8?B?UG9va0R4VXkwSkJiUU1VMmFibGYzNjRmOWFpU1BTRkp0VXRnUnEybEIzWDNp?=
 =?utf-8?B?SVozK0FXYzNSb1FuWXBJUzZSVkIxci9uUnBrR3JjMHNYN2FQSEtwUEhHY1Np?=
 =?utf-8?B?WTBZN3p3UWdjV0pyalNid1BzTGM2ZHpyYjhlYnVyNWkzVWt2Rk8zdmFTb25v?=
 =?utf-8?B?cE8zSlNMSHp2R0lxR25xTTlWVFY0SXJKcUhEd2tsOGp3U05KMTNQZXNBc0ND?=
 =?utf-8?B?Y3UyTFNndE0rZTNCZE9yUHZnREp5Z2FYQlJFdFpwNHV5NlN6SmlmbGZnVkFE?=
 =?utf-8?B?bXhkZlZ3UHlCNjgwRExKMHdUekd0S09TVHRiYktsWFdNSU4zZFY0WGkvSVhO?=
 =?utf-8?B?WTdxL0I2amt0dml3dkx4VURPUTlBTmVLV29ZQVlhYUFsSDZzRUJkaVNWSXVR?=
 =?utf-8?B?YlhRV1lYdnU1K2piRkM1UE5kUlhqNnBmaE1NK0FvSWk3Tjh3VzIzbHNLakZi?=
 =?utf-8?B?Wi9JeldxNWwwbnJvZlpXOUxtWncwN0gwMEczTHBEQUdudkpXZndxLzdMdnRW?=
 =?utf-8?B?U3QwWVNGZDJlZGoyaXUwZG5oQm81cDl0WGZmKytBcXkyL0doZVVVTFlYYnZU?=
 =?utf-8?B?cmtWQml1RjJHYWtXVktIMHp1L3h0MVNDSTIrUWJtdDlmVlR3VkV5TERXM3NS?=
 =?utf-8?B?SWxVaHRTT2hIdHpBKzJ1bHdtTW9vdGUxdTN6YnhtcjRiREtYeG9qeHQrSW1G?=
 =?utf-8?B?a1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eadccc6c-f14b-43a6-542d-08dc2f3d7fb6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 22:20:36.2896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jAzSWn+wVzcByVPCiG29PI7t+EB8gwDJD06tmZVfjXmFHkYkEyTf5uJMaNtXSVkpmrgpPJGrP7NEWk/aLcjZmkMjakn9628Xl3Dj/l/dizY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5476
X-OriginatorOrg: intel.com



On 2/15/2024 3:09 AM, Chintan Vankar wrote:
> CPTS module supports capturing timestamp for every packet it receives,
> add a new function named "am65_cpts_rx_find_ts()" to get the timestamp
> of received packets from CPTS FIFO.
> 
> Add another function named "am65_cpts_rx_timestamp()" which internally
> calls "am65_cpts_rx_find_ts()" function and timestamps the received
> PTP packets.
> 
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>


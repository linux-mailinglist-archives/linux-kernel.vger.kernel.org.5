Return-Path: <linux-kernel+bounces-60085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C26084FFAD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 993001F2467B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909942E646;
	Fri,  9 Feb 2024 22:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m8RWdnRU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41AE383A4;
	Fri,  9 Feb 2024 22:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707517001; cv=fail; b=DTngyICPlm2OxZyc6/yTLBfoyuTh7jiXgJZ8UDA30hredwriccNR+XglSuuHiLtjHczVYLoZwiqAEtprDE25G/PPuKa06b+gYXcu2aLvbxR8wGfMJ/+igv+FWq2xLWvODHBIatXI1W5mGjz5OrhBLeP+jV193B4iGIT2EUfesAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707517001; c=relaxed/simple;
	bh=tbL7D4RmrFtih1X/v4fFxaghiT7R/hZGKpTaAJxw5eQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gXHetAHatnpyXsEVp/+suUHCCNIwpgMD3euB0ZBc8M5kc2TeeRxW0w3+CnfzVbvU2Wet1foTSs1chXbrV+50TQ17tqXJTcela8uKcpGYtemYbmZKCmx5Bj0vzfXl2Pl616vVfXH0uJ8gwrlemN9UcJz/9QPmblWcCAEe9QUD7tU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m8RWdnRU; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707516999; x=1739052999;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tbL7D4RmrFtih1X/v4fFxaghiT7R/hZGKpTaAJxw5eQ=;
  b=m8RWdnRU9qOAPlM19ciGfHcjVgRcQAjeK0znFis+p3UtfDywW+4wkhtW
   aDdyez1WBlcWYbMb+7musVgKPQKaT1X0ro/MPeudsoC1hyZ7cOY5goD2B
   lkFCCwbcXxdf1RYVO2FYZvJmYXz05lZLHvDtDtp1n/6Lm9SPBq7qMXMbW
   b+0t8G850XKIULC2WQWLgnV6fMsMTHVHIYSQ5wGeS+bQS8joMPijtOyRT
   GeeTocMNYDdPwUOBMdr0B6v6AMO/iJBAA+7lWQeRYFHZqTMoOfIHFrjuZ
   81aE9tNY3fxZDxIUDJYZa69YLz28DLGOGjIaYivUBbkFWKtXxAny6oYB2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1826823"
X-IronPort-AV: E=Sophos;i="6.05,258,1701158400"; 
   d="scan'208";a="1826823"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 14:16:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,258,1701158400"; 
   d="scan'208";a="25278693"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Feb 2024 14:16:39 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 14:16:38 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 14:16:37 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 14:16:37 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Feb 2024 14:16:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/h4Ul3Q6xOWG/nPIs7Ef72UJ5dxRdFEPP0srsR8r4l4dceohCMWXs1/grfy/IdUGiU04+EO+m3VcL/nYSVgoUDf5pNTf+BajnRzgnpc7wOGkeI2QM5yV0HhloY1wVX+Tcc/Wp3iImw+YoJXeS7vH8adV83c9xUYXK5DI3QTZe5U4OxCAA6vYO4R44MubT2pNGLLx3FuJqX/2TH39fsJArLmcSoUbCO3o1bd3RXGsA1gBo9T+9BJbnvK+NJbIWl0uqDVJVllxfBFz3Z1S+ufQe5qFJG+RSbZeMOGiEofVOIoLad+vd9wJ6X6MFhBtFccss24nvEcoA2gu5fH8fRgyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64Wnt954SiE2sKkdPrVrPTeTgKTK1xsaEjxH1YC9u58=;
 b=gIotzzMoyjcKXme3yVWzDjlhx9JQk1eqn+2UpfvG50AF/5sVgIC0EmAiuW3wHP3qu2zJHw6pOD3u2dMakK4qAymVnD2nqqVoE046h36MRy0MIZ2Yf74yF0zddxY2kemPvnmz8RUpzFMgjS3d7M02dCSWsmyh+MAdPGliSkDmPx0P6vn4y6NPnSngEtZ5AEydXNgrrK4XBCnsubhgS5UuPLyE9sMMTGju1q0mOkbVii5Cw/vmr19VJKqPhJ3KfXEqi2lTlsSP9W1tA9Fa6NH94V21oMXkkaHNEW71kkAduxNlQbG82rLFDqUyCuZaJ8RkBQ7R7uMHlNdlM3HCce4FoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CO1PR11MB5011.namprd11.prod.outlook.com (2603:10b6:303:6d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Fri, 9 Feb
 2024 22:16:36 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7249.035; Fri, 9 Feb 2024
 22:16:36 +0000
Message-ID: <59944211-d34a-4ba3-a1de-095822c0b3f0@intel.com>
Date: Fri, 9 Feb 2024 14:16:33 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15-RFC 0/8] Add support for Sub-NUMA cluster (SNC)
 systems
Content-Language: en-US
To: "Luck, Tony" <tony.luck@intel.com>, "babu.moger@amd.com"
	<babu.moger@amd.com>
CC: "Yu, Fenghua" <fenghua.yu@intel.com>, Peter Newman
	<peternewman@google.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, "x86@kernel.org" <x86@kernel.org>, Shaopeng Tan
	<tan.shaopeng@fujitsu.com>, James Morse <james.morse@arm.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Randy Dunlap <rdunlap@infradead.org>, Drew Fustini
	<dfustini@baylibre.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
References: <20240126223837.21835-1-tony.luck@intel.com>
 <20240130222034.37181-1-tony.luck@intel.com>
 <91bd281e-e21f-4b60-9e73-2f14fcbec316@amd.com>
 <ZcZvguSNel-z3Xe5@agluck-desk3>
 <f4d4ff97-7d40-4915-943a-a7371e24dae5@amd.com>
 <65e1d936-0e1d-4d6c-81de-0b2b1d3256fd@intel.com>
 <SJ1PR11MB6083D539920A888F93902954FC4B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <SJ1PR11MB6083D539920A888F93902954FC4B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0314.namprd04.prod.outlook.com
 (2603:10b6:303:82::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CO1PR11MB5011:EE_
X-MS-Office365-Filtering-Correlation-Id: 685e1d73-f754-42b1-b5f1-08dc29bcc799
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0xGBkzSqFgJHcpcl7QUxiatBIReAJ/vnlgNT6bhsWrbhcUaaK9p0/mrfJEXTs208OIicL38+0/HgvAnodtPOph2M6r8IOAkNP9IFTcn5M/O1pBDBTPGx5jZDgQ4baPQo+DRD6vFCZkUkPhsdaFHNCBx2pJSBowLj7IURLO/rdeCAkJHYEj0gs4V1Ka2OUsHYZB1hqvrQd+V4264YOMMtPSX7RENkYXrOAfXf9oErXMAv0hKoZChlWP34ws/LPxE4nNZ8HH3Y5HQ0rWfTLSq2N3r6YItOGTpbs9RyqNLQcxRnGDUicd9Mzx4D+gmW2LIg889dU/f32apoFIxH0cTw6ii4N3GMhy8d6DtDOOxv//DlNwJPYhbD2CbNX1VGBU8oPtYBQo9YpC7ZdCAHvzTgCSPP13wQ3hFwTJ9f9GYX78+UbVjYJstl48zQx268d2uF+zgIyheyqjAdmdZZhe4MYDh3N993czeT8b/x5cq/lD69vD5roADBJR/EkPjagN0pNSMeu9Ctj1S0wOMA73xYOFsnu+VpZIky5hdUpLKiLtykVDh4lLOM2q8RWK5nlOxk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(376002)(396003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(478600001)(83380400001)(53546011)(6666004)(6512007)(26005)(2616005)(7416002)(2906002)(316002)(110136005)(66946007)(66476007)(66556008)(54906003)(8936002)(44832011)(4326008)(8676002)(5660300002)(38100700002)(36756003)(82960400001)(31696002)(86362001)(6506007)(6486002)(41300700001)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UE9Lc2N3eWZRRHBYK3B6blVjeXNUVm9jeXdWOVhvYUIzekdaL1J5bnVIYXRG?=
 =?utf-8?B?TEFyZHovbHd0eThUTFV1UlpJZHVrcmt4aEtoVnV3UFMvTkJwQXFKbVBPVHRm?=
 =?utf-8?B?WEdTWnhkWmMrK0NpZktZaXVTcmJ0cmdaQ2VlbXlMSDAwWXhwMzkxUkpVT2N4?=
 =?utf-8?B?VUJJUHFKcDNEWHJoaWpWOXJiT2NTQ3Z3SnBQcUtGR1pkQTRkRnVacTRHY2xL?=
 =?utf-8?B?MnFsbGxYQ3pQUW1hYkdWcHdnVk5zbFlzSEYzOG9kVGJxY1lSSEJMVDY2R2t4?=
 =?utf-8?B?alh1SUJmTWJ2cVZOc3dYQlBKb2kxbFZSZHpRZlBoV09tMi9qU05MWDJhdWNh?=
 =?utf-8?B?ZW5zMXAxYnROaVFMbXV0dFBIYXpsNEc0c2V1WHYwaDA0ajA5KzJQbXg5RHY1?=
 =?utf-8?B?amlSVkpXeGlxY3U0MWFzd0t5Q0REYllLTDFycUMyQnJXejRCVUJEdFZNMHRQ?=
 =?utf-8?B?NlVwOWtrdEpMaEpmOWFOWjlVTGZJWU1wWmZwMCtWM0xHdmNGQVhWdkFnYmRK?=
 =?utf-8?B?QThWM1ZRWTl2YXJ4U2tIYTczajJsS2ZybWIwMzVYMm5xb0ZCMi90Y1hMQVlz?=
 =?utf-8?B?UFdKMWNHZ1BheFBjZmwxQVpzZk5EQm5tZy9Vc0NwbDY5WGdHU3AvVEtNcGtt?=
 =?utf-8?B?aVZzUnA5TzAyclZNWmtlRVFFWk9lL3Bac2RTS2ljZnlvSW45dnVweTMzR2VF?=
 =?utf-8?B?czNEbHZlV3d4RGlXMjk4eTB1L1gzdy9jWkg5L05mYUNMSS9QK3I1MFFudnUv?=
 =?utf-8?B?Vy9IYmNUcE8vYVF5S0FodmQzb1dRV0djTjFNU0hUM3l3alZ0VEZkdzFxY1VW?=
 =?utf-8?B?UnBEVkpnWGpock1IUlZYUTR3N01CYmtHM2wvSzl2U0t2N1k0Rmp5dlcwbndE?=
 =?utf-8?B?SFpNMTg2d2hWWEtOZ1NZcGhXckUwM2dTc05Ba0pYSE94NloyUUROSTVCaFQ4?=
 =?utf-8?B?N29CbUxFT1dsN0RYUWVFV0dsQ01BcFg4cmZVekZ5KzBIWGhTOUZVWTA3Nlgy?=
 =?utf-8?B?L043WkwrampqMlZXUVEwaTBLVVJCMGRoOWVpMHpXdU9IRzJiTnFiUDVTUXNX?=
 =?utf-8?B?MWFmdHRxUUhxbGxkM0ZGSDVlci9kQUdwOURPaWZLSHRaVlI5NlJ1bTRvQXE0?=
 =?utf-8?B?VGtsRXNVRjVaSE1MUHVOWSt4eWNFSlFDcDhMR3J0T3BodHVEZFA0TVZ6R0xx?=
 =?utf-8?B?VUpNNWVZTjhhVXBHT1QvVWZRTndkcUNEYktyQkhNL09wSUNhSDRZMW5zbS9O?=
 =?utf-8?B?b0xqcEtTbGh4OVh3VVI0TElsbkpFTjhuL3UvOG9jU1RUaUMwQUtaR2hBeTlH?=
 =?utf-8?B?Wk9wdDZYclpHeDVpM1Vzb0UxNThXVTdSN0kzWVBtNzNXVkJrSHVNMngrN0Er?=
 =?utf-8?B?REZCQzNycFM3NkUxU3lSTkdXU0xUMDVLUUFKcEhmeUZCM3NmM3liUFlKUHdJ?=
 =?utf-8?B?SlVxK3hjTDMyS3FBQ1RnV1dxMTlzdmxkREZRUjI5T0JXZjc0U1pWUXl1cmhQ?=
 =?utf-8?B?ZjZsVkZNQUxubmRGTThybzh4WUhoQWhzbUlEVkQ2djc4Y2Y1dFpGZGZ1UXRk?=
 =?utf-8?B?aGUvNW9rbGxEWjhRK3FKTWdGQmx3emVBbjk3NXZaRDVWNklFMjJ3Rms3bzVh?=
 =?utf-8?B?SXpaRUZHRU1CWVN6VmlUM05jWDVoRGFVNm9XSjdBYmZxQTJ2T0p5K3hTU3B6?=
 =?utf-8?B?ZHQ5S0tBcHNINDFSSGNoMGVYMFBNZytoQkJwMUlNR1AxUlAwSHd1V3JCZkJp?=
 =?utf-8?B?RmVJSXFoQUVvenVWYUxZQzZzNzlSdGtQQi9iRDdPdlF5TTBoQVR6NnlTRWVF?=
 =?utf-8?B?TzRLVkhkUUJjaUtRM2w0U0RGSWN6eWpKT1ZuUW5UUG5MZXRYT3BRQ0lKYUFy?=
 =?utf-8?B?OHNyVTlLcmQ0blJSbjF1R1BWTHR6dFhpTXI1MDhGQ3pGMmo0bkVPaXl2ZWFV?=
 =?utf-8?B?RkE2SVFjcUtRVmJXaFIvV3drcUloNC9oTVU0OEVqbHlDK2JORnNFenBKRkh0?=
 =?utf-8?B?Q2N2NElFSlVYNE5BNVpJeWR6RWtrVHZqN2lWczVnUW0zVnJrWFlEQmxOd09v?=
 =?utf-8?B?Z1ZtZ0ZJaW4xWnF0N09vUTZtVW1xMXY4K0sxYXZoUmtuc0pyUmpXSitGTDg5?=
 =?utf-8?B?Uk9hcWRwSTYxZHBGRzRTSGU2WlF0RjRzb3c2WU1ZT1hJcllONzNZbmxNOVI4?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 685e1d73-f754-42b1-b5f1-08dc29bcc799
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 22:16:36.0255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6bG6rP82Rl5ylpm9nqVs7UAPKToMbZtzEY+mEMcB4LVlTMuNYYrf39PDZd8d1U5WqJx0cPUSFXKtk39+so0AQIikTxZwdAOtoN4lq/dsbxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5011
X-OriginatorOrg: intel.com

Hi Tony,

On 2/9/2024 1:36 PM, Luck, Tony wrote:
>>> Reinette seem to have some concerns about this series. But, I am fine with
>>> both these approaches. I feel this is more clean approach.
>>
>> I questioned the motivation but never received a response. 
> 
> Reinette,
> 
> Sorry. My motivation was to reduce the amount of code churn that
> was done in the by the previous incarnation.
> 
>    9 files changed, 629 insertions(+), 282 deletions(-)
> 
> Vast amounts of that just added "_mon" or "_ctrl" to structure
> or variable names.

I actually had specific points that this response also ignores. 
Let me repeat and highlight the same points:

1) You claim that this series "removes the need for separate domain
   lists" ... but then this series does just that (create a separate
   domain list), but in an obfuscated way (duplicate the resource to
   have the monitoring domain list in there).
2) You claim this series "reduces amount of code churn", but this is
   because this series keeps using the same original data structures
   for separate monitoring and control usages. The previous series made 
   an effort to separate the structures for the different usages
   but this series does not. What makes it ok in this series to
   use the same data structures for different usages? 

Additionally:

Regarding "Vast amounts of that just added "_mon" or "_ctrl" to structure
or variable names." ... that is because the structures are actually split,
no? It is not just renaming for unnecessary churn.

What is the benefit of keeping the data structures to be shared
between monitor and control usages?
If there is a benefit to keeping these data structures, why not just
address this aspect in previous solution?

Reinette

   



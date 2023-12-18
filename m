Return-Path: <linux-kernel+bounces-4456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC00A817D77
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D47A1C21CE9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 22:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5DB760A3;
	Mon, 18 Dec 2023 22:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GoUHUTp8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6578174E38;
	Mon, 18 Dec 2023 22:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702940008; x=1734476008;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E93zh6C0i2zJNLubx/aNNhEN2mL6SKekrBPeZjtxNbw=;
  b=GoUHUTp8gSZjuvcwm+FCWiZzD5OsK3gGKFqqPtAYf+XEK5sHg762FlYN
   psjl3x99CqTMwjYkuFtwE+lsxGaEE6f9onIVUVv2AZd0rbHXuzkUDmPEX
   k5bRbBiiKTpUFUolg5HkuLLaNMhTr1DgUdJjvzXjk4EvnnTiQ0WKqG7Qh
   6pzfavuMKAAUxZLov+5oVa/bbY9VHYLIH+NiovmdWvIf2HZcY7ERW2GHR
   lbpFWsp8kmTU00SYp6IwCCMqRITY36eVxeDScZrj8alq+Dq5jXhsmLZMk
   STB18T3P5uJ1TE/Lcif9q8IvpjI4b7oKPP9p+xbaFJv0E/vqJwsBmmVIT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="459917224"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="459917224"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 14:53:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="846112508"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="846112508"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2023 14:53:27 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 14:53:26 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Dec 2023 14:53:26 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Dec 2023 14:53:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJO7PwExdQfLQ8odrw/d6XxoqgYL5aqYob7xuRBPtBkzyHNJ7uGMUTmDCrkY+qkFrLU80xds24aTCzFkcj6bacQJ6RT80Hna9lK0KDXsQ3fAAI3YQS+sHxN5y3ETLNgqpdXDyNLCQtvzm1kZON888y7bvHlQ7QmAsEHeGm/nPOR8+BTZhDO4jVPY/EZdoi6VE81M8wuLY0D0lcudAKrqK/x1FTejWkJ9XVENf23UBoIYFoTbDSBCHFsKmtef4Vt/xNqfshxLsGMTWc+Vty9XohyGCjnsFuqruCA1/csJ3eBGMh1i6sDynHThfKbmuX9SgwrelGDWQadekKnUhafodw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SmlojfHIvQIVixkGiQ8cuygdZ6uPDQec3T+v/Io01h0=;
 b=L4NMfVoQgIxAyWf/1fgPxsa6dPNNHCz5n4q/InvjT1VK7CMxnhwVfRQYS6TMmj0w5pS0m34wSDPU0gL6qm1t6a5Rrvix5hwlkJZqTrSJifaB847AKZnFxJs4X3CoZa7zxZ9GQlPt8qIvD9HjdOazgEQDiLzpMxQqzbRB1F+CnVjAAVdUochc+q+1qV06SI0C2Eoc3TfIzB/f7jQBqvb2fgxwo9succMYy7bJVVF521oggVQu2q3j7Cb3m2WZknVA1h7pVPWMaPIfFL5j1V3VJvI4H3OaiJVQpxetHP4TLzutf642tsVLHl/APehHCNxSa/02BS2oZSkIjHH7AXyoQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB8478.namprd11.prod.outlook.com (2603:10b6:510:308::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 22:53:24 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5%4]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 22:53:24 +0000
Message-ID: <453e0abd-30a4-4abd-b5ae-63d9982ec1b8@intel.com>
Date: Mon, 18 Dec 2023 14:53:21 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/9] Enable networking support for StarFive JH7100 SoC
Content-Language: en-US
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	"Emil Renner Berthing" <kernel@esmil.dk>, Samin Guo
	<samin.guo@starfivetech.com>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Hal
 Feng <hal.feng@starfivetech.com>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Richard Cochran
	<richardcochran@gmail.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-clk@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <kernel@collabora.com>
References: <20231218214451.2345691-1-cristian.ciocaltea@collabora.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231218214451.2345691-1-cristian.ciocaltea@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0187.namprd04.prod.outlook.com
 (2603:10b6:303:86::12) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH7PR11MB8478:EE_
X-MS-Office365-Filtering-Correlation-Id: 333b3f98-9d54-46b4-76d3-08dc001c23ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BrdHmuIzkRNJLwKld1fM7a0o9JbLHJqyYjUWGCTgwOS/3tY2Xk1xLEzICuw6Sq/d6MMDUnWzFFs6O1tus1761TJD9DAI7Pq/ppm3YLp0H1AUbCGtX1Bl59yd7Ck/lUFipX0z1oT0L0kr3p/3UVJD7G/9sWPM6c+C+OhQO42Jc6nrr6prO05xzghcL7+QJeBU40mNW3IwfdzcDY+g0M+LE7/AxVCB1xqpdronzzgQt5QLFIPye+aG3Cy0Ov9q+fQQVQFiHtMN4maX4/bMM80eGPUeAOp5oyGeSywp/0ekc8dt+L8ycd1GnzOSBnXSWuxp6dOrlu1q41TeA81iGFzzwtbxQM/bsfLnueLcjdNOXV9JENB24X4lwtbIaHsThC2R7nfD4+UJ0WDRpp7WO8UeMrtg63Pz2DJ2CrqcN4vFYLrytk1sEJOPs63GMsekRFd3fxYOh9dRzokDlgOhoHJGUJxlckhhVlG6+6oy7w/iptixbxynd3gNKxvgfxBsBXQIVbgXNFzhxFHvU+V8mPZscNoJ+hkxYp5AG1V4abPrOEP6i41egK5m11NQUFQVeN95CFALU184A+tXD0ziOhpDcHoPZTjRK2w2vndTd361/m/Xx7w1wUUlIC/48x5yJRUtyKCdzQbFnIuMojVDeIzwpBC63KWWgN68SR4mKfOWIQnOi/Nd0g/IquWAsRB9ZLTi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(39860400002)(346002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(921008)(66946007)(66556008)(38100700002)(82960400001)(36756003)(31696002)(86362001)(66476007)(83380400001)(6512007)(2616005)(6506007)(53546011)(478600001)(2906002)(6486002)(966005)(8676002)(6666004)(8936002)(316002)(110136005)(5660300002)(7416002)(26005)(41300700001)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTJKbDlZdVJiVHlzazlPUkpuV2Y5Q1cvMkUxRkZyMWM4Z1dpYXJWckwzTnlY?=
 =?utf-8?B?MVI3SDJtOUh6YytLbWs4Yyt3cEJYRGVnblNVNjhCYURzc2pVZUhIWE03ZzVx?=
 =?utf-8?B?Q1pCWlVzWEZBK0xSeWtJTHZpM21pRVhmM1RjSWJ2TEJwRzBPaWV1OFhaNFYw?=
 =?utf-8?B?bXJXajlIYWs2WHFzZ0lqRHZiSnZmaW9pUC9nN3ZqMFA3QmwzS0haZUV3QlVO?=
 =?utf-8?B?czVxYkVQMEFGaENUK1hEaXZjMmFFVzJZdVVNUGpMd28wN1lnMEpZTm9DNGNP?=
 =?utf-8?B?K2U4RXNSRVVaVXFEeXczWUtQNk54NXF3WnM2MHN4TVJrK3hwNmVJY21OVlZn?=
 =?utf-8?B?K0xJZFR3UzRnWXRKVStET2VacXZUTzFnQjJEenlrL3hQL21lZkRoNmhVczlq?=
 =?utf-8?B?TGhaNmRnUEo2djEvYUpaR1Z5RmJreS9GSnNvNVAyNHViZFFVa0VBWUpQWHpS?=
 =?utf-8?B?SjdOM0VpMzlYUGZFVm12NFZUK2piVWN4TDBaTk9EY3dVVWtVWTNjRGdoMDdu?=
 =?utf-8?B?VDZOMUY0SjhpV0RvYjFtOEdxYzdmRWdJeDNDNFBRbWJrWGtHRjJkMXJ0SlMr?=
 =?utf-8?B?bUdyREEraXJMTVlPWmwrSmxVTzJsaXJVRjluL0FVcnRHY3p2dkdzcGtFanNG?=
 =?utf-8?B?eHdzNDJIRmthdFZUMzlIQnF6SWpPYkV1Sm1yRkRBU0JBQjFibjA3RmhlcmFF?=
 =?utf-8?B?dDIrR2FxMkd5RGdVMUtUV3FZdGdacFBEZHpPNDNoU3dKdEVudm9zVWFKVmNn?=
 =?utf-8?B?ZmdsWHkydUtDM1dHTktlU05xVjROTW04UDRZWGZhdktnTDljTXk4Uyt6WEsw?=
 =?utf-8?B?UzFmVHpYMFRZMmVSWDFMVXcxK1dMY2ZxbnRMM1BZRFMxQWNoT1dKYmJiWHlr?=
 =?utf-8?B?YjBiVmR1UFRhSzFzYThLdWRDWDJnQjY0bHJRMlNTemZKQmgxdElBeW1vNGN2?=
 =?utf-8?B?a2p4ZDg5WFNkZEtaejhESXJLUnduQW0zVG1LeDljUUNEMnlyZitmL3Y2MDgr?=
 =?utf-8?B?NndUODZYeDJrd0h1ZjR2a1BvN1VpWWNNVFltb2M3cFVUYkdKcHlaNVBvTHlM?=
 =?utf-8?B?d0pXVFI0QmFFR2MwYlppKzZWbk1KTHJ6eE9sVFVRQjhkVEFvK1FacnQvTTd3?=
 =?utf-8?B?L0NWRyttUlR0bE11bk9JNDlxYWUrN2ljSC9vVms3a0twUDZ0RXFFKzg1YWxs?=
 =?utf-8?B?NDltUmY4N25lQ21kU0g1Q29MeTZmTi9TVGN0SVQybzd4UXlzcXRBOHJNaXkr?=
 =?utf-8?B?RHY4L05jYnEvRVFZT2gzOTJwMFFjWFNMbnhjVnJUWHZHV2g1ZmFhek5wNXJu?=
 =?utf-8?B?cW9Bc2p5RG1OOUhCaERodnNTZ01rQUF1R1M1MFlucGU4S0V4TmlxN1Jsa0lD?=
 =?utf-8?B?bm9HT0pnbXMzOWl5OHh6N3lqcXVhNndURy9hdUVkTTVBNXhNRyt2SERTeUFW?=
 =?utf-8?B?ZXVsVlRnUnd1NjdrK3p3ZFVDRlkzSC83b0FKYlNCeHVsNzRLTFd3TENHR2JY?=
 =?utf-8?B?bU12cjFOQ1JPbzJrUTJtWllST2JLb2pZVi9neGFGNFZJZkNqbXhydm00aVNj?=
 =?utf-8?B?R0ZVTm9TOTVpUkovYS9jV1o4KzY0eWdaRlVTUmtQZVhWZDVjWFE0TGFycEZN?=
 =?utf-8?B?Mittem5ZU241V1p0MnRWUHhPbUM4aUF2b3ViVWs1cjZralhOd3VJRmRIQWhw?=
 =?utf-8?B?eERNTkxFNXdITkpEemtmZWdMSVExV21aWUJ2NFBhR3ZkSXZIeG55UEt1WW51?=
 =?utf-8?B?Z1AzNnRMV0k5VFd5R3ZXVUx0ekNtdllUUkxnOVVXYndiRG4rcVB0dzhlZElu?=
 =?utf-8?B?cEhYOG9xV05WU3lXSHpxZWxWTmVlTVl0d25leWdGb1lOVnhaS213aFpjWlpn?=
 =?utf-8?B?K1RWTUcrQ0lIRTZreEQzK3B0dU9WeXBGMU53Y1M4eU15SGVMTFJ4TDNyZDk0?=
 =?utf-8?B?TGNTcGIvWUs0clNSWDhnVTcwaUtkSnk0eG5FNGM2bWdSQkhaRVhjK28yRWM5?=
 =?utf-8?B?YUsxMHlvSjhtSG14WnVvamNHcGN3Yk1yOXY5RTV3TVFIdllPQ3ZZK2taMlNk?=
 =?utf-8?B?YVJmMHhZa0xCQTNtYmJGbUd3UEFVcnBZR21yblVJbFNrVVJHYWkySmIyMUdH?=
 =?utf-8?B?SHg2YzArTnp6MzNLOS9PM3I2Q3dXMDd3ZHN3WFZtbE15SmRnYnF2Tkp0elpX?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 333b3f98-9d54-46b4-76d3-08dc001c23ec
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 22:53:24.2899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iL3Xa+SFFcecjgrkgKBftI517Q5d+gkN0Xt6Lyovb8LKRPYuR5h+AkFceC86WkRMW9IoWTlxFAMfjJWuSCLOPuKw0kKO+r2nn5ODPsPqlx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8478
X-OriginatorOrg: intel.com



On 12/18/2023 1:44 PM, Cristian Ciocaltea wrote:
> This patch series adds ethernet support for the StarFive JH7100 SoC and makes it
> available for the StarFive VisionFive V1 and BeagleV Starlight boards, although
> I could only validate on the former SBC.  Thank you Emil and Geert for helping
> with tests on BeagleV!
> 
> The work is heavily based on the reference implementation [1] and depends on the
> SiFive Composable Cache controller and non-coherent DMA support provided by Emil
> via [2] and [3].
> 
> *Update*: as of next-20231214, all dependencies have been merged.
> 
> [1] https://github.com/starfive-tech/linux/commits/visionfive
> [2] https://lore.kernel.org/all/CAJM55Z_pdoGxRXbmBgJ5GbVWyeM1N6+LHihbNdT26Oo_qA5VYA@mail.gmail.com/
> [3] https://lore.kernel.org/all/20231130151932.729708-1-emil.renner.berthing@canonical.com/
> 

I'm not super familiar with how the various pieces fit together, so I'm
not sure how valuable my read through is.. but I didn't see anything
obviously wrong.

For the series:

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> Changes in v4:
>  - Restricted double usage of 'ahb' reset name in PATCH 2 (Jessica, Samuel)
>  - Moved phy reference from PATCH 5 to both PATCH 6 & 7 where the node is
>    actually defined (Emil, Conor)
>  - Drop unnecessary gpio include in PATCH 6; also added a DTS comment describing
>    the rational behind RX internal delay adjustment (Andrew)
>  - v3:
>    https://lore.kernel.org/lkml/20231215204050.2296404-1-cristian.ciocaltea@collabora.com/
> 
> Changes in v3:
>  - Rebased series onto next-20231214 and dropped the ccache & DMA coherency
>    related patches (v2 06-08/12) handled by Emil via [3]
>  - Squashed PATCH v2 01/12 into PATCH v3 2/9, per Krzysztof's review
>  - Dropped incorrect PATCH v2 02/12
>  - Incorporated Emil's feedback; also added his Co-developed-by on all dts
>    patches
>  - Documented the need of adjusting RX internal delay in PATCH v3 8/9, per
>    Andrew's request
>  - Added clock fixes from Emil (PATCH v3 8-9/9) required to support 10/100Mb
>    link speeds
>  - v2:
>    https://lore.kernel.org/lkml/20231029042712.520010-1-cristian.ciocaltea@collabora.com/
> 
> Changes in v2:
>  - Dropped ccache PATCH 01-05 reworked by Emil via [2]
>  - Dropped already applied PATCH 06/12
>  - Added PATCH v2 01 to prepare snps-dwmac binding for JH7100 support
>  - Added PATCH v2 02-03 to provide some jh7110-dwmac binding optimizations
>  - Handled JH7110 conflicting work in PATCH 07 via PATCH v2 04
>  - Reworked PATCH 8 via PATCH v2 05, adding JH7100 quirk and dropped
>    starfive,gtxclk-dlychain DT property; also fixed register naming
>  - Added PATCH v2 08 providing DMA coherency related DT changes
>  - Updated PATCH 9 commit msg:
>    s/OF_DMA_DEFAULT_COHERENT/ARCH_DMA_DEFAULT_COHERENT/
>  - Replaced 'uncached-offset' property with 'sifive,cache-ops' in PATCH 10/12
>    and dropped 'sideband' reg
>  - Add new patch providing coherent DMA memory pool (PATCH v2 10)
>  - Updated PATCH 11/12 according to the stmmac glue layer changes in upstream
>  - Split PATCH 12/12 into PATCH v2 10-12 to handle individual gmac setup of
>    VisionFive v1 and BeagleV boards as they use different PHYs; also switched
>    phy-mode from "rgmii-tx" to "rgmii-id" (requires a reduction of
>    rx-internal-delay-ps by ~50%)
>  - Rebased series onto next-20231024
>  - v1:
>    https://lore.kernel.org/lkml/20230211031821.976408-1-cristian.ciocaltea@collabora.com/
> 
> Cristian Ciocaltea (7):
>   dt-bindings: net: starfive,jh7110-dwmac: Drop redundant reset
>     description
>   dt-bindings: net: starfive,jh7110-dwmac: Add JH7100 SoC compatible
>   net: stmmac: dwmac-starfive: Add support for JH7100 SoC
>   riscv: dts: starfive: jh7100: Add sysmain and gmac DT nodes
>   riscv: dts: starfive: jh7100-common: Setup pinmux and enable gmac
>   riscv: dts: starfive: visionfive-v1: Setup ethernet phy
>   riscv: dts: starfive: beaglev-starlight: Setup phy reset gpio
> 
> Emil Renner Berthing (2):
>   clk: starfive: Add flags argument to JH71X0__MUX macro
>   clk: starfive: jh7100: Add CLK_SET_RATE_PARENT to gmac_tx
> 
>  .../devicetree/bindings/net/snps,dwmac.yaml   | 11 ++-
>  .../bindings/net/starfive,jh7110-dwmac.yaml   | 75 ++++++++++++-----
>  .../dts/starfive/jh7100-beaglev-starlight.dts | 11 +++
>  .../boot/dts/starfive/jh7100-common.dtsi      | 84 +++++++++++++++++++
>  .../jh7100-starfive-visionfive-v1.dts         | 22 ++++-
>  arch/riscv/boot/dts/starfive/jh7100.dtsi      | 36 ++++++++
>  .../clk/starfive/clk-starfive-jh7100-audio.c  |  2 +-
>  drivers/clk/starfive/clk-starfive-jh7100.c    | 32 +++----
>  .../clk/starfive/clk-starfive-jh7110-aon.c    |  6 +-
>  .../clk/starfive/clk-starfive-jh7110-isp.c    |  2 +-
>  .../clk/starfive/clk-starfive-jh7110-sys.c    | 26 +++---
>  drivers/clk/starfive/clk-starfive-jh71x0.h    |  4 +-
>  drivers/net/ethernet/stmicro/stmmac/Kconfig   |  6 +-
>  .../ethernet/stmicro/stmmac/dwmac-starfive.c  | 32 ++++++-
>  14 files changed, 280 insertions(+), 69 deletions(-)
> 


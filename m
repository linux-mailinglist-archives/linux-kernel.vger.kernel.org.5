Return-Path: <linux-kernel+bounces-48310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB364845A1D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A26BB290A4E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28835F468;
	Thu,  1 Feb 2024 14:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XHk10yVz"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F6F6214F
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 14:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706797358; cv=fail; b=RseXpLNERPwT3YTTCgb6B/VSvOX9aJpQeFFozKiGj3S1Bd8FaJ7vdZkVNFY3lIa2Uv26sL9qN3sBXZCgrH3f3VyyMfResNTZ5cFHVMAGgS27VgO/h0+lWlEPN5QXNLqv/eeaDb2NfXcNwq7o8MNKPe1zmgCJXP9wtn6/gpjGKrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706797358; c=relaxed/simple;
	bh=6ph3sTZaNy9bfabSEYskQslTPdRHXdBZuKnsEVMcrTU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CoO1v0bIQy2gAiXw8wzs/wQ/F0tZ0IOLALc10yS1pRLAX9zsC9ADRiYDjsiAB6cZ22B9/5xDfzQH4ejViZUDAgBl58GX3DGj1C32uAPFoH0nTx4ZLjCphEu2bH7ylO6ZhlS2UpH02Xaf1Z1pavB5ufkGqtgiajeLOZOaATWh7Ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XHk10yVz; arc=fail smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706797356; x=1738333356;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6ph3sTZaNy9bfabSEYskQslTPdRHXdBZuKnsEVMcrTU=;
  b=XHk10yVzdQm/BH5jYtqrLPn11sXrosAX/LrG9Pc69EAHa+8PTfXtEghz
   3TTXzRntFBPQ2GxatWMU32orlak1yjzCnvC42gA4W7Sru7JYSKmnNVknA
   7Q+QZEHbHRstahKlKsU3g/gYL+Eb7CCJE9AQwqxQHckUdfxuYc25FXMx8
   8H8NhCYqat/2Q9uznka56Rjbye3HYge448El43zVmRCzmqe0OQHZ/OmfB
   l2TWWh0YfDoKn5UqBx6YKKYzgOZaJCjdk1bi1I489qD/fHPb2XcMyOMH9
   oR+vTVDVaAFDhd49WQgGZEdldSXcZm40s6DqyNo1k9L4pFHpE48RmdhjT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="394352462"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="394352462"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:22:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="117034"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Feb 2024 06:22:35 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 06:22:34 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 1 Feb 2024 06:22:34 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 1 Feb 2024 06:22:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJVju8050nf2f9WiQd+UITELvxaLBljsoS3E3rnDAQdYQDsvwzbttx1Xp2PHNi1dxuSXSX+uB7trzBYUi/PvZ06P1s0rrKpRxdb9y0TaH8ORSZLkeS21rcSd54LqWozIkOga9KSnt/E3M/Z1IraLlrIEDpwo9U8sgNjmMTGzkjSIeaFtGY8l7kYh7PJ5WyCP0NLHgsSAxul+hiVihT52qhAeMg+pwdtgqmu3+vjBEC8pQeqO2q8wVM1PsCT65K168L0ZhpE0lOGj89avDmzqNoodOlEjv8Hc66z/Pra3w9NuVPL8/2ZmqvFhczkfmJd4LUvcI+Sc3QZFj3gkHzEGiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1s7cz8gSEKLGzMeumXKuTiD5DzWRQmzjVRQyWam2KBQ=;
 b=JYetaC6Stzu9igjvdTmhi26QQsXTmROty47WwIaeZ/p2iPaihh2yqqRnTeuHs5gTGc21myQJJrP2psRxccRG2L8N95HN0S4s08BUsvwBGGOu7xZ1TW5UWiDPkOvWvn+IN5DzkR7WL9LSrFa2Alcbq+oBoX1C96p4z/D+4FJea5WuQ59bjjxdAVmxCzg/NWQBvHBoVO7qlJwkmOM/8pMV7egWoD+Bc4cfNxr/Paiv3gVq5UX2xB+V/nb/byNzqFO3oCIKGrT7KiTYcLDAwUvs/PKwN8Y4Vm2yx6dCiMSPkmfmkuYPq8PBGtIgstU0QJpr+kX3zSIeI1Inn7u+MzFN9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CY8PR11MB7874.namprd11.prod.outlook.com (2603:10b6:930:7c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Thu, 1 Feb
 2024 14:22:31 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ff69:9925:693:c5ab]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ff69:9925:693:c5ab%6]) with mapi id 15.20.7249.024; Thu, 1 Feb 2024
 14:22:31 +0000
Message-ID: <0c990c7d-4df9-45c1-8c03-980d9842b963@intel.com>
Date: Thu, 1 Feb 2024 22:22:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] x86/kexec(): Reset TDX private memory on platforms
 with TDX erratum
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Dave Hansen
	<dave.hansen@intel.com>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <tglx@linutronix.de>,
	<bp@alien8.de>, <mingo@redhat.com>, <hpa@zytor.com>, <luto@kernel.org>,
	<peterz@infradead.org>, <thomas.lendacky@amd.com>, <chao.gao@intel.com>,
	<bhe@redhat.com>, <nik.borisov@suse.com>, <pbonzini@redhat.com>
References: <cover.1706698706.git.kai.huang@intel.com>
 <b52ed259e0d487b3a968b98da91cb4f55a28ae82.1706698706.git.kai.huang@intel.com>
 <12a927df-e437-40ff-ba4d-ceca5446c5b1@intel.com>
 <l3uo3n3li27czehll2wz34xxkcv5j2vcshgp5a6w7u4h4aidpu@4oe2cwye2e6z>
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <l3uo3n3li27czehll2wz34xxkcv5j2vcshgp5a6w7u4h4aidpu@4oe2cwye2e6z>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0109.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::13) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|CY8PR11MB7874:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c46c8dd-dd1b-4bd7-11c4-08dc233139de
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pgH3MYHGnvxPn/m3jIf6qGUb/lLxc9ACwj6t67QBFwsblVjlzTESHHfcDhPgXXO2E58jcr4zjDahGNAULvQAw0c8kRsiCSV4wT7ywwZhMDj7vtq3DvbtsABs4xBbW1QDT+uKyaSWaMjrp/kHOIA0oU3aLYhRFpI05T1ChGtYM/pLkheDHMGrV8gnLCt4Q38O+4tliQkcuyLFsObVGoUbYc7yfGv6h8ofT+j29dRMaHgNvaYzSqe66rjGdaLEAVteZovNjARhXpVwjce+T3Dfva8fhWm79XedbAqfruLy8Lk3fmxEeErCDL+TpNJ41l5ymJHNoaTAh8/Bi0zvVx4S28xkMX7NsKRsN+qKLGvxd9+MDSn/3r2ECqOWojC6GS8GmriH/FG9NPdQCRp7SmwmgARYsyfiLQp0GblkLA87/EJ0lK9wT68B01+LieqBsQ3OF9VfRd4Eg1zNNQH27VO21A/VIVsj3oDAbPBbMSKVompvtiFB+DfsklImNHYXokm70YBTCIk15e46IC6QmK6IvxKRs9vFFEvOdEc+SdtxiuihIU61Z6RF2e4FHGuhYm+/4STxqmr7FXhAdUMxHeclZG6ySlGBOalTglYxgYUl9cG593rkCa65h5qQ8dcnAyFv+YecY/6BMG9NiXvgn0nU0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(376002)(396003)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(5660300002)(7416002)(2906002)(6506007)(6666004)(86362001)(478600001)(53546011)(2616005)(31696002)(66946007)(6512007)(66556008)(66476007)(6636002)(316002)(110136005)(6486002)(36756003)(38100700002)(26005)(41300700001)(82960400001)(83380400001)(4326008)(8936002)(8676002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWFBMm9sdGxYU0NRRkpXM2t2UHNFc3hyM3kwZjlxVkVlMmkwK1NacEhINEZJ?=
 =?utf-8?B?dnMwK1BYdFc4OUZkdmNQZ29HNWx3bkJIdmprdVV1Y0JsTkx5Ty9LTGpsZkho?=
 =?utf-8?B?cmQvQ2NPMElMSWVEc3lGR2JWeUpxREo1d2NSZzM3NGZ4dlE1NUVQWjQ2YXFm?=
 =?utf-8?B?OUxhVHpqNDZEdERINGx1UEUrUzRVOHJmY0lHRXhjc1YwOWl0eDJoOEF2TnJh?=
 =?utf-8?B?T3YycnJnaGRFTWthMHd1OWREQWN1ZHJwT1R0T2UzSEZ4dUJEQmp3T2owZWpi?=
 =?utf-8?B?TWdveExpQ1h6aS96VklnenVZZVNUdnc0d2NYSDU4RzhKRC9nM0Qya2FxN1FK?=
 =?utf-8?B?Ti9zd1BBYVVLL0tPdzJ1bUJEMFB0MHNidmtmQTdPdjRDNnRaSjBjbThXWWN0?=
 =?utf-8?B?dVJLd3U4R1ZuL1ZETTYzWGY0MXpYSW9lYklpbWlTUTROa3BCZjhtcGJ1bUZm?=
 =?utf-8?B?Yi9ISGZSeVN4dVRCNFBmTlJtd2k4NUpQT3pSckZvdExmQ0tvL29Ydkc5UW1u?=
 =?utf-8?B?Q1lMK1RmK2lnU2h4bXRBVGY2VGY4S1czZ1plU2ZYb2k5ZXlOM1k2MkN4Qnk5?=
 =?utf-8?B?UmpIOVBkWjk1b1V0YjlHL0dwSUlzOEIwb3dWaVVkM1pzSFZHd25tdytDUGVz?=
 =?utf-8?B?WGIrWWNBMGdaRHhIbHVUaHROeUdnaVBobkRjMzhkaVR3eERQd05nM2JRbnlS?=
 =?utf-8?B?ellRdHZxMkJJWG0zMi9ObnZWOFF5engzL0RLN1o1SE5MSlU4VGFYNXdKMCtG?=
 =?utf-8?B?QklyZ2FhUDlpWlcyc1RTcHhiT0cyMjRXTkdJQnZKZHQ2eHplUTBGb1N3bWxE?=
 =?utf-8?B?UzA1S2NwanZLNWRlM0lwQVZuZWVNaytUcGJHUnJZSWNHdTZRTlhMakVDdDA5?=
 =?utf-8?B?MlJsVjBmTUhROVBVc2xXa2pLYUZKV3psWDdBbVVvazdianRLczJkWVIzRWtp?=
 =?utf-8?B?MnJDTjJtSmpUaXk4bmU2ZXI2TTN6aTVKbi9GcTEzY0RRV2MzbGxkdWJhd1p4?=
 =?utf-8?B?TUNGZzZzcVdVa0JiMktIWnBEM3VyUUpzNG1QSWg2UlhvTEFLYnVFdWhhcDZP?=
 =?utf-8?B?c0RyQnNFVlRIUjM0Z3UzRkpvZXpVakxtRkhTQk5LQlkzQ3B1dVoyMG5wT1lp?=
 =?utf-8?B?d29vUkVaam0xc1BXdEVLQW5KNStiTDg5UThHL29lZmNxcFp3OHBrQWs0bzZS?=
 =?utf-8?B?dnZPQWQzWVNqbmNNbWdOa25DcUxHUFIxQzRxTk5vUEFUVGtuWEh2VE9aNlIz?=
 =?utf-8?B?QlNWeDlmS0lpZHFtUTdNTDVTczdBSlpkSlVUc1dQeGorMm52MjhSYnZrQWtE?=
 =?utf-8?B?T3ZIQnVxUCs4Nm84QWhQeExnQm1PUVViSG41b0dtOEYrWE5kZWpMZDlQZ0Z5?=
 =?utf-8?B?TEtMaUc1aVVnTHBFVFN6aWlnT2FadWZBVVNkNENmMmlSVXh4dUhuNXoxa2JU?=
 =?utf-8?B?SmZGSXlpZStpT2xWbnpQMU5zS0lMZExGNFdkckdRVHRVeWgxSCtsbUhXV3gw?=
 =?utf-8?B?dFBLVW01Sm52L216OUZab0txaENYaGU2eUpxeHdVVnRxNTk4UUpaNlBwdSta?=
 =?utf-8?B?eUlTcys5bWxramtqbm9LcE1YUzRWN2NRVG5QTjROUHFuQVM3UlFNcVRLYkV5?=
 =?utf-8?B?U0xIa21GRnRnT3VoUDEwSUxRNDZDRXZqMUhSK3hlTzBZWDJrWEo5Tko4TEor?=
 =?utf-8?B?MDdsVDBjUVdoSXVHSUlqZTRlTmJSditRdmRhSC9IL0VXdWFWNlZqZkxEQ09a?=
 =?utf-8?B?c09uVG1iLzIwZG1sbE84UkJLNTRRam5RQWRHdDJ2RmtOclh2ZFNMR3hLNWp3?=
 =?utf-8?B?SkJ6bWtJcG91N3A5cVF6WU1DUWJWSWVRSTZZUktNdmg1VGg3VlpGYVIwVVla?=
 =?utf-8?B?NWtYRy9UdGttd1A2NWRpNzVqNWgyQ3c5L0ZTZjF6eGxjbmxWbENzaXNuM0Ns?=
 =?utf-8?B?YUxLWGhlakU3ZVBrSi8wZFlST2pTWE5NUlFLem9CdzQ5TUtTK0t4R0N3bEN5?=
 =?utf-8?B?T2pVelEyU3JYL29LdFJVcmNTdFNhSlkreGczTG9pV01WNm9DMGt5MDZ1SGdS?=
 =?utf-8?B?KzJLVTR1TDNDcHVJdGFEQjg5YjEyU2RXbXZEV1EvODF0WlY1emJtbVFaYUlk?=
 =?utf-8?Q?EbOEST3uG/RHTNere+ND7sos5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c46c8dd-dd1b-4bd7-11c4-08dc233139de
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 14:22:31.6521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SXXgfGE+IQZbj/V5LgN9/ucd2wM+XgsSwSryqKJggrYoulMTCRYO4vSi3oTKiEova1byF5mq0Nh97IMlV2gT2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7874
X-OriginatorOrg: intel.com



On 1/02/2024 6:03 am, Kirill A. Shutemov wrote:
> On Wed, Jan 31, 2024 at 01:21:39PM -0800, Dave Hansen wrote:
>>>   #ifdef CONFIG_KEXEC_JUMP
>>>   	if (image->preserve_context)
>>>   		save_processor_state();
>>> +	else
>>> +		tdx_reset_memory();
>>> +#else
>>> +	tdx_reset_memory();
>>>   #endif
>>
>> Wow, that's awfully hard to read.  I really wish folks' gag reflex would
>> kick in when they see stuff like this to get them to spend an additional
>> 15 seconds to turn this into:
>>
>> 	if (IS_ENABLED(CONFIG_KEXEC_JUMP) && image->preserve_context)
>> 		save_processor_state();
>> 	else
>> 		tdx_reset_memory();
> 
> save_processor_state() is declared under CONFIG_PM_SLEEP, so I guess your
> variant might break build in some cases without updated suspend.h.

I tried.  If I turn off both SUSPEND and HIBERNATION in the Kconfig I 
got build error：

arch/x86/kernel/machine_kexec_64.c:325:17: error: implicit declaration 
of function ‘save_processor_state’ [-Werror=implicit-function-declaration]
   325 |                 save_processor_state();
       |                 ^~~~~~~~~~~~~~~~~~~~



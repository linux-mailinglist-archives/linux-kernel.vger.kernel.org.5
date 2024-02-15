Return-Path: <linux-kernel+bounces-67008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C068564B9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CB211C221A5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FADD12FF7C;
	Thu, 15 Feb 2024 13:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iLaNYbEl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E8512BEAC;
	Thu, 15 Feb 2024 13:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708004730; cv=fail; b=P3CkcxxOzJBvN/pHwfqoimWwEvBqF5kp1xY1mfgFbb0na04bT8dPZXrzeS7Q21J0p0gpAFuxpfVyrW4zC3rIeAaTssOI+/EyZh8lLVhmTwsHlEo/w+1WlvNBi3drKPYWD8wDPjR2VHP5w1ndzQvjGMNqFNyEnNMLXjXC6ExhqFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708004730; c=relaxed/simple;
	bh=ftP4hp9wDXJ43lCKf0CiLp53iBXsyypmETYesSwODvY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p+shbN1AKAB3myX9ChJQ0wb2hK9VlV2DgltHSASpYsj9sIxPkHHKDecZ1//f/jBEwSfdcDaaoAS90n7WhZG4tKr+4KVf82R6fG51AoHqUsDQ9ROvmu9m1ImzqyMCXi0nngEyYSSGKwrKYRckfsw+orUWzk8JYFPfLA/xUPTggkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iLaNYbEl; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708004729; x=1739540729;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ftP4hp9wDXJ43lCKf0CiLp53iBXsyypmETYesSwODvY=;
  b=iLaNYbElVHpqWnDX5fMvCvf+svRjQwXozT0BGjPBkmpnyeHR8FFnJPXm
   xtQlsjMylrOqZAjIqMFEvvbLQUeDooB3a9aWl5T/vT/83c4o310s7OMjC
   tUzPJv7ZWcwZBWNx1RQpWHCMGug+tFQY/yICZDoXaDRJuwtPIlSB6KUCF
   RzEC2Hk1wB2ILHAlGAKc76rDHZkbI646tJmhPmsjHKKy9urJHmT+hAIhl
   0hi5hW8trVgILYEGKVesIjhBGlM0PFBS3Da+pcawJBIenTPa/7MpiCR0N
   J5Kgj+12rzSlAmrigp3RLBLxPNvngsDYIqs3wE8xUKc0AYYY7GOmVpFQs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="13486475"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="13486475"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 05:45:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="8141416"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Feb 2024 05:45:27 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 05:45:26 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 05:45:26 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 15 Feb 2024 05:45:26 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 15 Feb 2024 05:45:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWwFWyDvwh1Wmk67rviF/51Opo4P+yefXMPrf57U4oUx3lOfNg42A1NbN6KK5oC682ifk0Me7A9l+4J4TPB+6uKZaOEFCXLsDHzl7+cNgJbKybpfdD8EHtHsZCZAxypnHVEp6gmJIec2Czsk8ZrD4d7YTp8LlFiSfCM4d8A4HmBjcgFLkSs6Ot5byr6yeN8CXue+R1KulHg9UZt6Lh3x+vR9UCSZy/DHi8Sbsif5r4fVSbNbKaZnRPVXmR6euWmMCavxjQBLAwmZnpBg0skqOzdiNwovpZ3ruj/OnQunPsKQ46ak4xo2LGJ7p9sqCIC2Xc3OaVP7CnY9/5J2IErJbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMfMucvuFvLLHnKD8dahL3zyeNa4ofP2aRP6Nip+RgQ=;
 b=NuxdUCOCgDH0QHVgD8kmcm8YXHnn9VS0unb0gpS1WVtPTuetFjXTZpjlo4BdugbmhRXFP5lKfvTBktgot6/TaF5VGJPKMCbsVRYo7uyO8ipAxbBEAr3xirNyni1kLTRLvMJewRmSzDGiEkQAgVQlOuuyf4JvbFFEnm1GFJcDzDQf3mpAxp4dnQO8QTcdHRDeh/EQJi4E5tlx7Gim2kQEa1IDqES4yxdsf8krXVs48TAt/1/FG+RsdshxzgA09G5YPV0F+D50eBGMK0W189zXuNa0yIrWZG0HPf7C2wKQu16s6bVzA6ldXGp+H9ee5gTzKQIxJaOQKlA8jKqW7ziYNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CH3PR11MB8434.namprd11.prod.outlook.com (2603:10b6:610:176::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Thu, 15 Feb
 2024 13:45:22 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::c806:4ac2:939:3f6]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::c806:4ac2:939:3f6%6]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 13:45:22 +0000
Message-ID: <15766d46-162c-4c99-84a0-7a4bc60c3289@intel.com>
Date: Thu, 15 Feb 2024 14:45:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] page_pool: disable direct recycling based on
 pool->cpuid on destroy
Content-Language: en-US
To: Lorenzo Bianconi <lorenzo@kernel.org>
CC: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240215113905.96817-1-aleksander.lobakin@intel.com>
 <87v86qc4qd.fsf@toke.dk> <8aa809c0-585f-4750-98d4-e19165c6ff73@intel.com>
 <Zc4Tht2TAkFOhq9Y@lore-desk>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <Zc4Tht2TAkFOhq9Y@lore-desk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::19) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CH3PR11MB8434:EE_
X-MS-Office365-Filtering-Correlation-Id: 64491fd1-8ee8-4c7c-40e3-08dc2e2c5b40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fv0qXU7IWpy5fSqYGbqRqZ7i1TIq8Fo4aWeowoqY5QfDtdQHEWynTC6WzorelYmJMt9Ei8U2U+EuIv+X92gwvuVQ9gLE9NniiNtl0Y8H83mfg0Fm31A7EyHqpIDwVRa10vUrlIOXna8mmbfAFUPsm2iZ/L0z4OeBonmYUHEMucoMO4MUTKofaiX6C1aET2xkt5qrgJYKoqQ0apv/6NQTwvICxTSWFvVWynoUok+HjpClciX4qPgiWX5j5qFQBJ6yQxYq9qIzMhwURE4W5musGJ0YWDyG2DHP61sKVSnbu3JIZ5d/KutE1IuInUEtrOxXYdf0EsFcYps0nLbWVJ9wcwNY4Xtk6sRK+LOqpzaDyF+QDCe717bKAFva8kaP6tAtR6+TEDeQmTsAQrtMfF9LNYTT2NhHUw3+ENJy1JfLS8iWlSGmmFumKNdNvz5mzTSS6RohyIRRbdtNB1WdJRhj6uXZP3TQsJQDYxTPWlSKgmWhFmtkztCZlHBLJE1GFCVlB5X1hkPMRG0WiRZh/Fp6h+YLBdUhESISgIpOGwRgrKjAMXKGD1B10zyrVChfzSLZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(136003)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(31686004)(5660300002)(2906002)(26005)(2616005)(6916009)(41300700001)(8936002)(8676002)(478600001)(66946007)(66476007)(4326008)(66556008)(54906003)(6506007)(6666004)(316002)(6512007)(6486002)(82960400001)(86362001)(31696002)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVR5UzBtNmtlaWVZaDNxMUFmZkxsSURuVm9aUUVIUUVBZjhPRDQ2b2ZDZWRO?=
 =?utf-8?B?VHR4MlZtdk9CUUZPRVZUZTd0TjhXNENTWG5Ia1NlaTAvZHMvanQzazl6MUdH?=
 =?utf-8?B?dWpWaU1udDZnZWppbGdaNHBrYzhkYW12d0dEUHcxNU9ZWGxObVhPbHpMZGRR?=
 =?utf-8?B?UlIzVy9qbTlvajE5TWs5SVM0VGJ3KzJHejcxQW5TancvWmpsek9reDU1SUlB?=
 =?utf-8?B?b0ZqUWljRmxwd0h4OHIzTVNJd2tPMmpERXhYZHp2NWt2UGtOdE51ZXg3amZa?=
 =?utf-8?B?RGYwZWcvZkw1SWl5MlVJbVp4WXk4NVRjd0kzUGorMS82WEpOY3BCSlVzR084?=
 =?utf-8?B?Y0w1ZW82aTJyd3dBOHR5TE1JTTZZZmhSaWp3R0dtSzkwNnpPVlBWZGFITFhr?=
 =?utf-8?B?RGtWaHZSU3MwVkh5Mjc5aUlDVFBtMGUvejJFOGFwQkVraTA1WTVXRVc1anJT?=
 =?utf-8?B?WlhsL3l6RjI2UmIzWHRaQU1vRXEvVXN4SVhER2RtNzNjcEc1RFhCYkJJK1o1?=
 =?utf-8?B?VmUvRmgyZUdQcUNGMThlWDFROGliSXA0NCtEa1RSZWRrOVNhYXlzR0hzRGZ2?=
 =?utf-8?B?SGJMZThxN0hLZjZwVUVEWkxURDlqV1JySGNVZEgyQmxETS9NL0JGN3hwa0Z6?=
 =?utf-8?B?czJlajlXTG5QWUVOdzZyRWNwZEJuZ0tUcEFDYXBNQjdXQXRqMVY1c29OeHA2?=
 =?utf-8?B?QVRPYm8xcFQrNzkvdklINUJZZ3VtS2JXRmpka0Vxa0JIaDJsREVpR2VuNkRZ?=
 =?utf-8?B?b3pJUlZUZmROSTFLd2N2TzNJUVpoN0o5ZkRNTjRyYVQvNUJqTFNIYWVoWEV6?=
 =?utf-8?B?cG1EMXpqVjNXQjNRcnI3MXdncVlocmRzZzdlNzQ0RWNSaFRjK011eFZ6US9w?=
 =?utf-8?B?UzIzMW1jRzN6bUxMRzFJYTdCMnIwV25yc0FSTThwcjhwRnVzUjgyV1BiYUhK?=
 =?utf-8?B?dzkzOFpzRjREcDNQY3Z3a2FkcU9FVUI4eGIvMWczV0plQUlicTdxaDFqeUF1?=
 =?utf-8?B?cGIyeU1EVzRhNzRlT1lNUEo1TnZTSnN3LzhZQkhVYXdXK0FnNVE2UnNiSzRo?=
 =?utf-8?B?UEJCbis5OE9BN242NkcrYUxicHBNbHdFTFJWbmw0dlhEYjh5UDNNRGd6TWRE?=
 =?utf-8?B?VjcreXU1TmxxUWFFalhVOVN3SWc5R0NrbkFFcU1LSzBTWnZaTDhHTzRpWndW?=
 =?utf-8?B?R2QvR2wzenBSZFNqYzE0SHgwQlI4a0dydG5DRWt3bm9lUldjd0tINmZPUmFw?=
 =?utf-8?B?dXBiZEhia1RVZHNOWWxmdVUyUVVFODkwU1hHMldHVzR6S1dMZEIvSUJWWHdZ?=
 =?utf-8?B?TnhJWU5wMENQRm41ZElwRm54MVBScG96K2FpdVcxVW5NQktWYU1seXJTbWZo?=
 =?utf-8?B?WE5WUk5TQWlqNUZ0R3BhVWlWczlZeFBsZVVOSyttQlJVQ1BTQ2xuQmpvUXRt?=
 =?utf-8?B?U2VhQW10Yzl5ZXNiT1FZaklzSDQ5bHFlRklwNDBZOFMxdUJ0b1pXTmNZN1Ro?=
 =?utf-8?B?a0dnSGNpeXA2c0tYTStLMXUvTGh4cVlyUlp3bE1KRG5aMUhoeFBzQk9TcVg0?=
 =?utf-8?B?dVBRWEh6Wld6M3Z0dWtDazFSRW5CSkFMclJlMjJyQUZZTUg5b0hCeHVXazRQ?=
 =?utf-8?B?eFhJV24vOWF2TnJPOUZlM0NPRFlsTlFRcjlzSnJEQmVrUEY4M29xZkVLS1lN?=
 =?utf-8?B?L3J0ZkdQeGovUE5iZ0tjN2wxRkFhMHZYYlpGUUVsS05LVTRiSCs3TjhLRGlP?=
 =?utf-8?B?MzhhZ2YzTWxJOHJSWW83TDBHTCt4TW1uZTQvZkhnUUxnVmhRcmRDMDZaMitF?=
 =?utf-8?B?MERrSEhEekt1YjA1cUNQVzhtdmdaZVpteEdzczZicFdMNVZna0xyK3hWWU1O?=
 =?utf-8?B?c2V4ZTVSbFhDTVl1K1FFaWEvQWNpd3IxenJiV1RSYzRGMkhtTEhPaVgyL2Ev?=
 =?utf-8?B?RGViZmM4blV4MldnRlkwakEzNWlCYnpsYVpOQ3o4N0FEUGZLQzVKZFBHMlFz?=
 =?utf-8?B?TVVsRnFKV2g4TTFLNDRSUkNTOHRuSDVOa0lRV1BsR3JJa2xwMHVqUzc4WUJJ?=
 =?utf-8?B?RGlCMmk0VmNKWDhxaWtWSzhtUUZ1SktkTk12NWJTL0t5VTNtSkppN296TXVk?=
 =?utf-8?B?dWh2YUtLTnIyYjd4ZHNVSE5PYi9FT3B0RDFKb0pYcUpIU21LRDNPUGMvdkNy?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 64491fd1-8ee8-4c7c-40e3-08dc2e2c5b40
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 13:45:22.5390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P0HYzu6JGDOCEkzqCzEyTycnQUhUKx0aP8yBdmM6RZuCP/skAQ46U5jYaNESWbSu2oAvrbvW67S9Q56F44zFJMlTci0ix1AzFayDkLx7lAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8434
X-OriginatorOrg: intel.com

From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 15 Feb 2024 14:37:10 +0100

>> From: Toke Høiland-Jørgensen <toke@redhat.com>
>> Date: Thu, 15 Feb 2024 13:05:30 +0100
>>
>>> Alexander Lobakin <aleksander.lobakin@intel.com> writes:
>>>
>>>> Now that direct recycling is performed basing on pool->cpuid when set,
>>>> memory leaks are possible:
>>>>
>>>> 1. A pool is destroyed.
>>>> 2. Alloc cache is emptied (it's done only once).
>>>> 3. pool->cpuid is still set.
>>>> 4. napi_pp_put_page() does direct recycling basing on pool->cpuid.
>>>> 5. Now alloc cache is not empty, but it won't ever be freed.
>>>
>>> Did you actually manage to trigger this? pool->cpuid is only set for the
>>> system page pool instance which is never destroyed; so this seems a very
>>> theoretical concern?
>>
>> To both Lorenzo and Toke:
>>
>> Yes, system page pools are never destroyed, but we might latter use
>> cpuid in non-persistent PPs. Then there will be memory leaks.
>> I was able to trigger this by creating bpf/test_run page_pools with the
>> cpuid set to test direct recycling of live frames.
> 
> what about avoiding the page to be destroyed int this case? I do not like the

I think I didn't get what you wanted to say here :s

Rewriting cpuid doesn't introduce any new checks on hotpath. Destroying
the pool is slowpath and we shouldn't hurt hotpath to handle it.

> idea of overwriting the cpuid field for it.

We also overwrite pp->p.napi field a couple lines below. It happens only
when destroying the pool, we don't care about the fields at this point.

> 
> Regards,
> Lorenzo
> 
>>
>>>
>>> I guess we could still do this in case we find other uses for setting
>>> the cpuid; I don't think the addition of the READ_ONCE() will have any
>>> measurable overhead on the common arches?
>>
>> READ_ONCE() is cheap, but I thought it's worth mentioning in the
>> commitmsg anyway :)
>>
>>>
>>> -Toke

Thanks,
Olek


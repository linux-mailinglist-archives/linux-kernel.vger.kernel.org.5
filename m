Return-Path: <linux-kernel+bounces-65792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 227A28551E5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A4161F221E7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E4B127B74;
	Wed, 14 Feb 2024 18:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YlTrJCvA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFF8126F38;
	Wed, 14 Feb 2024 18:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707934496; cv=fail; b=PEkhpXoC2A4Cid3hxqUO6Ub9ciE2EXXjWr2snmPoCx3V48LmbK4GxVtY6WWKTT8XFN5/sry21X2vjTYnGHORLdk3zVdTuG1bbIw1bglE5gHJIW/RLRg3nuGu7o3OXfbvBNGl3dTKesS4fzJLBjtEZJQw9aD/nrWDaGoSIiroGBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707934496; c=relaxed/simple;
	bh=CpsQwcmek1GCcJFfXeBIIYlS4sydZA80zZThwo1dy8w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I0WeQ8Kwel5cb1jjd9M+uZwTjgI1vLrvZsJivvWGWpa6+d2lZHfwIQDQW0wWbaQC7iPBL6keevGSQSnhuF/xH6Msnh2p3rO3Lt222q5SDT4fbE6aVIM2g6bBjj3ds3CbSBqp0+zXLvaoCqaKdaAFMalZguxe4eOd7yivTRKqMos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YlTrJCvA; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707934495; x=1739470495;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CpsQwcmek1GCcJFfXeBIIYlS4sydZA80zZThwo1dy8w=;
  b=YlTrJCvA/4pMQ8eXaVJFdY7WSbPhEHvnPfgZWHOaAFrEwZkPpHJCBt37
   pHAAE3+gmP5zG1vNbhBqx7/OifxpdWzI02egXbnpq7cD/RjVqaYsWs8FJ
   wehXWszD3na+dMUVoQ4TscE2DGy/Q7IxSj7NqL5yyH0DX1xjBdD2W4hf1
   xdR6mi6sJjt6pAwaVkVxAPBfySvHtubtXbupbaQvw+YZOABZ2eGa5zViL
   Hj3PU5bKBqYo1QKhJHl8YiC8srupfkv4lYNrfJCoAnn6ZB17UNl+kbwTq
   WqrEMwH4//KfzgDY9ZzWg4O2viQRkGQCbybpGIXmF+txf5/8661IEfTKe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="2135674"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="2135674"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 10:14:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="3553366"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2024 10:14:54 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 10:14:53 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 10:14:53 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 10:14:53 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 14 Feb 2024 10:14:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKSqAcb4j6awPRXaZRiG9FDRlPBqJJ8sb02Og6w5Hage949PuoufPCMNy8pvwKMFw4IoFE1h0FoNE+MoamGM27rMXjppHWSjhll61gJCqsJswj+RoWt8Mf6JIZkgDmXSbM0/x9Q9y7Rp3JJ48TW0IVFI66jPKVzs4De/0rsNiHsLC1Inj/WBwc9zRgMtxv2Kdmg/XAAaWE0i9pk5/0/cZsA8D6UM2pTaFhr1dO8xIjGt7/ay+5GVM4KqrR5ycZ44IEZkGHNYIVRuXEN8EepdDIKAwFg7XrVm62Lro8Y9R686q5fpovUN7H+IUwAI3DewmjeYs/6ZquSbIEzs92N6dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CpsQwcmek1GCcJFfXeBIIYlS4sydZA80zZThwo1dy8w=;
 b=LCQze8T4JTtsRNST/1mcP7aMHUdReerLAU2bJvbt6WgqVvmxMWoPTavjHuL8R7PpbdOqUfFYPEiq8C2O0d//wxWRAsK7pV2sOi2yQr6VVutN2XqOwrHtb7LTLroBjCmG4GapJBOrhbAIua6ER5PdaL6a9tMEevUJGzHfegYv7Dp/Qt2GPtcKn5EuV/VPAJpzmY3xz/eKc52NAKfc26TbnSt3WjjKEQr8320maKv6NKx6y7cwJLH4CpQLpcdc6RcVguMid1b9SIMKZRibPQTxSbWtbbwUCTgoJvZKkVkd5JQ2ATPxAJp9necondcohntb8bXMEifRkPtbzRaQp/CXGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DM6PR11MB4660.namprd11.prod.outlook.com (2603:10b6:5:2ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Wed, 14 Feb
 2024 18:14:50 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409%7]) with mapi id 15.20.7270.031; Wed, 14 Feb 2024
 18:14:50 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "hpa@zytor.com" <hpa@zytor.com>, "petr@tesarici.cz" <petr@tesarici.cz>
CC: "Xu, Pengfei" <pengfei.xu@intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "luto@kernel.org" <luto@kernel.org>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"brgerst@gmail.com" <brgerst@gmail.com>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "corbet@lwn.net" <corbet@lwn.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Li, Xin3"
	<xin3.li@intel.com>, "roberto.sassu@huaweicloud.com"
	<roberto.sassu@huaweicloud.com>, "petr.tesarik1@huawei-partners.com"
	<petr.tesarik1@huawei-partners.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"peterz@infradead.org" <peterz@infradead.org>, "rppt@kernel.org"
	<rppt@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "mhiramat@kernel.org"
	<mhiramat@kernel.org>, "oleg@redhat.com" <oleg@redhat.com>,
	"keescook@chromium.org" <keescook@chromium.org>, "Huang, Kai"
	<kai.huang@intel.com>, "jacob.jun.pan@linux.intel.com"
	<jacob.jun.pan@linux.intel.com>, "zegao2021@gmail.com" <zegao2021@gmail.com>,
	"Rodel, Jorg" <jroedel@suse.de>, "mingo@redhat.com" <mingo@redhat.com>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>, "Zhang, Tina"
	<tina.zhang@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"petrtesarik@huaweicloud.com" <petrtesarik@huaweicloud.com>
Subject: Re: [PATCH v1 0/8] x86_64 SandBox Mode arch hooks
Thread-Topic: [PATCH v1 0/8] x86_64 SandBox Mode arch hooks
Thread-Index: AQHaXzn8yQ0cq1LpsEep6xLElvfqRLEJ7IWAgAAJ+YCAABRvgIAAGgOA
Date: Wed, 14 Feb 2024 18:14:49 +0000
Message-ID: <a27c9c32e410fc3582f3593f209cc1cf3b287042.camel@intel.com>
References: <20240214113516.2307-1-petrtesarik@huaweicloud.com>
	 <c424618c-d6c6-430a-8975-8851a617204e@intel.com>
	 <34B19756-91D3-4DA1-BE76-BD3122C16E95@zytor.com>
	 <20240214174143.74a4f10c@meshulam.tesarici.cz>
In-Reply-To: <20240214174143.74a4f10c@meshulam.tesarici.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DM6PR11MB4660:EE_
x-ms-office365-filtering-correlation-id: 92b04b8e-0531-46eb-6059-08dc2d88d56f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HSl04iJxLhPvpkPfDj9zmmro34s04etZdjiR810U8IT0ggcx7LbwBjL9J6LsB7Nol8T2xWepLO9LFmlJ5cwcHmB3YLrruOlAjhH4Rn27ldz0ga352uCpmhkD9g/oGlwfWRNCcw+LCHPIbA7nAN53PE/NkgSSKk3CShVgnr3ADtza/aQ5s2YumzcGVrI7UEVp6K5NNsj+MG0/6pj3u1m4/AdlnQX9Fe1V0nYGFqvgNVo+GWYdhy7YHUbrbxUzDm/ZGI2eEU1EYKp5/BnY1RVWuhVT1ZdTCtdOQxsAmzd74xJu65bzBO7YsH3mYulGXIbM9P4phMpWSQOuNwHjthuPCXCG0gW+eGHb4v3orMxmQAWCbsBqS7HjVk9coT9eHgQvw2rCaR40j+0gtry0JIqIfy+QwM67xeW07Zt1F/mHZAFWY5p2af+lYShKFTsADEW0+QZfVq2u0fEkn2/lBi7AhyLwR8dk3vz5zYyqjgO8tn6CNugkVfxW8pIbVqLQK2lP5dzhizlNTXFzVnKMaAzWQQa3bGVfAlVSDvM5DLU5F1WLYXAOTbMdeyBqpG35R5MDGk6ZX2IL7LZxNfz9vc84ZALQMNMsAz5lQ+aJM4hLVLjzsnqV3qDXdnHUz9Ted6/w
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(39860400002)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(2906002)(122000001)(4744005)(5660300002)(7416002)(38100700002)(82960400001)(6506007)(86362001)(71200400001)(6512007)(83380400001)(38070700009)(26005)(64756008)(36756003)(66446008)(316002)(54906003)(66476007)(66556008)(8676002)(66946007)(2616005)(8936002)(76116006)(4326008)(478600001)(6486002)(110136005)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZE1keWY3RVZEZVd3V1ZKSTM3Y2haRjdRa1JIWVE3bmNxaE80dnAwTlRHVkJF?=
 =?utf-8?B?bDF6b3A3Y2JiQ3hpYTNRRUlLdkhMOHhWQzFNSVZ6OFhNNlFhQllUY3l1M21V?=
 =?utf-8?B?RDNzMm5OOXAreXNab2VoV1pmRmFyYThQVk5hbjlTeVJrVkY5VUNhWWJiczl1?=
 =?utf-8?B?aFZudlVCSGFwNG1QU0FBZmxGaTJoajNxL0pOb3dRZ3NhQ3QxbmFDZDJVUWZX?=
 =?utf-8?B?YzduUDNyeGlXUmlRTUJGNWpsWFowNU5SQ2NHVkVQdzQ5bWpjOGxlVml0WjRD?=
 =?utf-8?B?dU15eGlHVmY4OEFvNFpvWEE0REUvT3MvckZ6bmY5K1doZlZicy9MVUFrSUFF?=
 =?utf-8?B?QnQrY2ZzdUFTR3Zhbmt0OWJkTzhBY0pKWFNESjZtTG1YOVBPQTVaZEl6MEh0?=
 =?utf-8?B?NkdLMHZtSWlpVXEzV2d6Ym16b3o2RWFyeDRHMmlkVkhPMXdrMm9Sd1ZPS1Vp?=
 =?utf-8?B?OU51R0REaWFxU3djNFhTQjI0dUtKU1dNTHN3b1ltOXhzSG55MXhOVSsySFR4?=
 =?utf-8?B?b1RQKzljN05UUjBxbDM2OHZvSXl3cGdpRFB5ZjF2YWFHV3UrQytPMkRxMXUy?=
 =?utf-8?B?Z0xmdnB5ZFdFYW1YZTVUS1NNNlJVWGlNanc4bllvQWdYOW5za1BFR21WVzUy?=
 =?utf-8?B?aXUvb0dxS0ZXcUMxSzBwa0tNM3h4U3ZXSGFlOThvczl3Q3F6eExTSGE4SHd1?=
 =?utf-8?B?Wm5BY0lZU0gzOFdUaGp1bk9mamFQZ01QOFdjTWVPWFQ4ZTlpWG9jRE05VHRj?=
 =?utf-8?B?aDk0QVpsMWo1Nlh2NmFRQ3hSeVBMa3dkWHlpb0Z0VjhWdE1VQ25ONzB3a2lZ?=
 =?utf-8?B?V3VJYk11OHpiT0xta0RaT2QvdFFRbDBuOEtrMlhRUWdJUHQ1eTNNYXA5cTB3?=
 =?utf-8?B?K0RmN0VtRElHWFF4ZzNPaTZLaDdmMUoyNmQrUHB1RVpORU9keDhyU3JzUnNp?=
 =?utf-8?B?aCtvcFFGOFFRQWI0N0dWTmFMeGJOYlhteHZVM3pONHI1RGRJVmhSNFpQRkZy?=
 =?utf-8?B?anYzbTMxZzlIOGpETnVhSjEzRzhKb0xtOVNVLzVBQTEvZlVYMkpEakw1S0RE?=
 =?utf-8?B?RDRjS0JydHlFZHRON2QzeXNST0xhNG82U0V0NVZZbm5CMTJCWWxBVlZBYkZu?=
 =?utf-8?B?em14ZE94endGVTRnNmN0U1J0U2pTZ3dMNFhtMzRuRlZ3ZXlDM1BuWEZHTWVQ?=
 =?utf-8?B?Q3RLT1FVc24rUDkrV05iTjlLbEZ3c2Y4aVh0aHpSeFZBdi9lNjJYaXl0RGk0?=
 =?utf-8?B?N0dOS0hLMGlHTDZDVytUYjRPYnZSdWo5a01LcGtucUxWVUhxbXlDU0hRMVEz?=
 =?utf-8?B?YXQrdFhxYUgvcVhGUHhIMjN6THFHOUFVRGFPQXVoK1RwZG1KYzg4NVFxN21U?=
 =?utf-8?B?dTBjbnF2VmZ1YUk5UlZUTEtyMkpLTzFGdkd6d3h4REU3cjVjaXJ3Qmxwa1BQ?=
 =?utf-8?B?V0VqVHFwR0w2dFZHdFdkVnJ2K1Q0QTJKdWN4OXBhWTFJTUUyTGdQVG9Hb2Nt?=
 =?utf-8?B?WkF1OGRKS2s5YldnSWlMNS82OFlVbUlzSUZ5bHZ0dVBseUpBZXQ5YS9wWjZv?=
 =?utf-8?B?WWdvWUxTaWVTNGtLb2tVdUowOEt4eXZkcFBLd0lscThQVFFzRllYd3JRaXdz?=
 =?utf-8?B?akxiSWx6akgvbytIMWlhZTF2Z3FRK2NjdUJXNlZ4Ym11VWt3amtleGEzbE5z?=
 =?utf-8?B?ZXBha3VyaTRaQU00QU4rWWNmVXRnVzAzQWZIcmViSzROWXMvSVdFV0lScGJX?=
 =?utf-8?B?bGs1NDkrTVpiNXhnMC83MnpRN0pRUWwySTBtbGsyMk1KU2xQRktrQUxDZTBX?=
 =?utf-8?B?SjcxWkZWRmpXVTQvbXF0aVBHU3FoamIyWkx2YTJEUWlwc0ZWNHVMT2xielNI?=
 =?utf-8?B?TGF0Y3FiUjdHZ01hK2pQV1lEY2dPYU85M3A0eCtMKzJLSnNwMmZMb0pDUWll?=
 =?utf-8?B?ZGo1aG5RK2VrVFVCcWl4bWpTWWF0RWJ0alBUTkZ0dkMvTTFqeGJZZXF5K1Rq?=
 =?utf-8?B?cThCWnhYVk5OR0Fia3poVkx3aml0cXJyQTdwdDVpbXBGUEJYREZNMzQxckp4?=
 =?utf-8?B?cXZ2VU14WVpCZjU5Z1lyOFZ6TjJ6SkZrdzB3RTFyOExwWkVRUFl1UmlBdG1q?=
 =?utf-8?B?NUZjKzNlSUZkalF1OUxBSnIxZTV1V3BxTnVXSXhvUklMOHY5SGwrcU8rVE1o?=
 =?utf-8?B?VXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EDD57D3293EC349BF99D7F7781252FA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b04b8e-0531-46eb-6059-08dc2d88d56f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2024 18:14:49.9045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y3TaKGu2hxDqaui350ZF01+7eteKMR5MLuQdf3Y9f+7R8Vcg+8clrhtoCyQg/PX+bt01cli4LQtY/0kZ46QDTHntq4F08owA4W0wUOmx6hI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4660
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTAyLTE0IGF0IDE3OjQxICswMTAwLCBQZXRyIFRlc2HFmcOtayB3cm90ZToN
Cj4gU2Vjb25kLCBhIHNhbmRib3ggY2FuIHJ1biB1bm1vZGlmaWVkIGtlcm5lbCBjb2RlIGFuZCBp
bnRlcmFjdA0KPiBkaXJlY3RseQ0KPiB3aXRoIG90aGVyIHBhcnRzIG9mIHRoZSBrZXJuZWwuIEl0
J3Mgbm90IHJlYWxseSBwb3NzaWJsZSB3aXRoIHRoaXMNCj4gaW5pdGlhbCBwYXRjaCBzZXJpZXMs
IGJ1dCB0aGUgcGxhbiBpcyB0aGF0IHNhbmRib3ggbW9kZSBjYW4gc2hhcmUNCj4gbG9ja3MNCj4g
d2l0aCB0aGUga2VybmVsLg0KPiANCj4gVGhpcmQsIHNhbmRib3ggY29kZSBjYW4gYmUgdHJ1c3Rl
ZCBmb3Igb3BlcmF0aW9ucyBsaWtlIHBhcnNpbmcga2V5cw0KPiBmb3INCj4gdGhlIHRydXN0ZWQg
a2V5Y2hhaW4gaWYgdGhlIGtlcm5lbCBpcyBsb2NrZWQgZG93biwgaS5lLiB3aGVuIGV2ZW4gYQ0K
PiBwcm9jZXNzIHdpdGggVUlEIDAgaXMgbm90IG9uIHRoZSBzYW1lIHRydXN0IGxldmVsIGFzIGtl
cm5lbCBtb2RlLg0KDQpXaGF0IHVzZSBjYXNlIG5lZWRzIHRvIGhhdmUgdGhlIHNhbmRib3ggYm90
aCBwcm90ZWN0ZWQgZnJvbSB0aGUga2VybmVsDQoodHJ1c3RlZCBvcGVyYXRpb25zKSBhbmQgbm9u
LXByaXZpbGVnZWQgKHRoZSBrZXJuZWwgcHJvdGVjdGVkIGZyb20gaXQNCnZpYSBDUEwzKT8gSXQg
c2VlbXMgbGlrZSBvcHBvc2l0ZSB0aGluZ3MuDQo=


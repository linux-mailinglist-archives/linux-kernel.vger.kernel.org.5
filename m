Return-Path: <linux-kernel+bounces-85782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 511B086BAAA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF74DB2528F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C8F1361CC;
	Wed, 28 Feb 2024 22:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AA8Ve6gI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C68E1361B9
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 22:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709158913; cv=fail; b=H5RiddTiT92470l6pxRc42A5Sc7LU9yVOPHC94BAWuhpACXjJVcVo7YJcZgT/n074HsNlZCs60IdpE2ihqFWRs5Xw5fff32wae8wFIm5u6F5QqQFdQFdOgk5dMIy7jDTq5mvlnGiXmChQBTVW0bJ6NksLzGPoy8/xJQdqF7l/Cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709158913; c=relaxed/simple;
	bh=LHvi3Na6zUE7YC0gNtznqC4wjhrKNl+wEEEEtO5CUNs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WOhu1s7Zr1IVrzqLmczTWz6FQ33GoczV8vQW0ToMQIDXGPgXhjAUZN1ntt6ZN+QbviQ9qKWXKtNfJ4kSJ08oi+cTvA1wGZ+x7rHJhQ9f8+/3yVi4INdOUeUvdKf098zVufDYoVg845UYc/MzDV8tIXcPYwt8s3y7EkTVVYXtv3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AA8Ve6gI; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709158912; x=1740694912;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LHvi3Na6zUE7YC0gNtznqC4wjhrKNl+wEEEEtO5CUNs=;
  b=AA8Ve6gI41a1XtaPD5iDi0fcNwhWMO0ESjIlBeg+pQhbVYjHXQpY8nnN
   sdL9RO2oChqzfCVY+E6zBIcn+YleWlDX/qdVsJtYgZih+VDGVybRZh8Qx
   sQOW2LGxD8Y8H32wALE7XnnWefSDAgBkG5wNkNMQ8n1tWDlNtH+SJ+at9
   YmMp3DlaSCjZ8HQkVX8rSuUisbaXJNlLe3Kc9wFrqnOaaY0f9DQpm2xNs
   P16TWEMPDVwvTAfWl/OMpE+hdIqsD1WM5k4R2X7eaoepCf8yguwiCx/vh
   pPGkgGnPw/HJcK/9XIveI7XaYHWe3lwTj/vGPIS0IhEbwYgcZvaULBxTT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3473857"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="3473857"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 14:21:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="7505161"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Feb 2024 14:21:50 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 14:21:50 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 14:21:49 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 28 Feb 2024 14:21:49 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 28 Feb 2024 14:21:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GfsXuTNLYp/bWvdGD7WXFQjHRs+GEgl8mWwLxn5vGVat4o0/CdVT3AmVItz9X+x3VX9G66POfsMOpbAi3UrLxLJay+mmZAnnL5UpU55Qi3zKIL6V4CVbG/dozKG1gXAdEJLvNhLXlqdW1IP/i1EhAErtcg6xvCBm6e0sdv80dzsSTp982xyTesifKZiprLlqTcdMLrtkio0tA79wcrlDpwznsat+Wv2As44EGqSMXbiLjWRsfekn+zCFyqnYhE6rqbjYZToE4NziC/Rufd/87AM5EwpUKiwh6UfIJY+vQTCgtM4o3tO99aair9rPY1XdmqoIKdEmDW9qVnqfWh5ZMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cF96X7jYb/WiVXBUuUPkag5T5//F8jIZk/7c/xTDZEk=;
 b=ANj+PCE3z+WZfmAUtf8e6w4Z8PSrficterKfolnwj0H2tVORLaL3J+WV4zHt4OJ/fX3Vkqpkr4i2mx4MJM4x5b3pYQz+1wXJ5Lh6JipNh8rREmfnmSyOyZQCHG2F5G2Q/sGjElzSNFbsWAPPq7YXntJHdCNXAPHSJ0PXDAb+98LoyEZTcSPoa9vbxFRV3SgEHMZ8RwknVz0lfrk6X1SlN9hEyGXmV2RHr6UQvL9f2VBQDSQ5jLxtOmALDG1WS+l+zNjvt7mCgkegox8DcPcx77AjqNb/lcsgcH7bdjt9CjLE8naTfp5dp2hUHkt9UOEMBOCUFfUeDOyI70csF8eVoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB6477.namprd11.prod.outlook.com (2603:10b6:8:88::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.22; Wed, 28 Feb
 2024 22:21:47 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7339.024; Wed, 28 Feb 2024
 22:21:47 +0000
Message-ID: <1511b773-5f79-4882-9566-e0db8d8f53b3@intel.com>
Date: Thu, 29 Feb 2024 11:21:36 +1300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] x86/coco: Add a new CC attribute to unify cache flush
 during kexec
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
CC: "dyoung@redhat.com" <dyoung@redhat.com>, "Gao, Chao" <chao.gao@intel.com>,
	"luto@kernel.org" <luto@kernel.org>, "Hansen, Dave" <dave.hansen@intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "bhe@redhat.com" <bhe@redhat.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>
References: <20240219203222.GIZdO61ucfq4bFxRT0@fat_crate.local>
 <283877fd-78c7-4322-bbce-ba6420d56765@amd.com>
 <20240220142812.GBZdS2_HJEA50F8RZD@fat_crate.local>
 <28a494ca-3173-4072-921c-6c5f5b257e79@amd.com>
 <ec58908ac8bc7d953d4c00825217615918436721.camel@intel.com>
 <24844584-8031-4b58-ba5c-f85ef2f4c718@amd.com>
 <20240221092856.GAZdXCWGJL7c9KLewv@fat_crate.local>
 <CALu+AoR-VFHCK_7LHiJ3z_Vk1B=sFS90iAyCs9qmSmf2+XORLw@mail.gmail.com>
 <CALu+AoSZkq1kz-xjvHkkuJ3C71d0SM5ibEJurdgmkZqZvNp2dQ@mail.gmail.com>
 <8c3e3e8c32b50cf488413d965ac6730ce8814214.camel@intel.com>
 <20240228110207.GCZd8Sr8mXHA2KTiLz@fat_crate.local>
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <20240228110207.GCZd8Sr8mXHA2KTiLz@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0050.namprd04.prod.outlook.com
 (2603:10b6:303:6a::25) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|DM4PR11MB6477:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b18e7c4-588d-4f24-9bb9-08dc38aba6aa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CbBG0tQNvT+BT9HF6n/eIkjUJYvD+mOP4rNX6upr4vnZX+WwEbXxe4O2j+ST1koDGOJ6aQZpK9i21irEfuXu/hYd7uJQiBgRrJgk1UY8VRZ4JUsWt68C9wm8UpnbogsRqgHMTFEQuFQk+oAmC5lemeZ/SAcQjP3h12lPhEC01jfsMaehCqnm8i/eGh0U+i9IghYrgXvjqWyH0Sb30aUtIlMQTIUNO3kqqvaKMXy36h8x9omZo3aCfAaWmOl8PzH1WtI0Yd0aij9WLSO4kGPIL/2TWyV3hd85NoG1ItEEvjx/bcq9HAkPUQwkQe91JPdftrrCHVnmhpLuACJmdCFEjn58alyeNwFMJL04cEyGLNy2dbwuC2O24yqHf4uHWEzMrxh6is5488laguMxgEA/E3jdfXT0MXHZvzcAZLu1HcnhcJ+Mkt58Kd5tzqQ/AEsWQcXPpz69jaVm0FjTHpHVrhAx/nfNOhyB5A25WW82Tz2oMMHhoPH8mFQarFcrHD+Qw1Msr/4SYrVreYAL+OgVyPPryqGzpXV6lGap/ZPLWrmfvLKo3uVNIGdcckf70nf5uHteSAIvSPSNxMObd3KfGqrsbRWMGLfABwJKOFeTVLyVByzvXXNfrmqmBp7KG0iA8uJsyz3w0D/digTDAlANmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVBybmNleEY0NnFkOWZnMTJEbVdSeVpiTFBHWG5TZXdiRFJFZUpDUTdzQitp?=
 =?utf-8?B?U0NDaEJWNTRYN1BOamVQeHhtVUdvbGZFQUIrcVhWL3o2cTJrb2s1N01zZlVk?=
 =?utf-8?B?UU5wT01Vd2lOa1Q0MXhXZXBHOFA0U0xiSUxaaHF1OVE4elpIU2dLaERLR2Za?=
 =?utf-8?B?SEp1UTBjcHhFcFhyMERLOFY1TnRkUDM0STI4c3VoTnpCcERtbDNLWkxZT2N5?=
 =?utf-8?B?V2EwU3RHN3RsaXVWSzhBNWdkajRJSS9PeHJCQW1mK2ViZVEycTFqM1NnMFpD?=
 =?utf-8?B?SmRSZWZBVEdjQ1dWWVY4TkR2SGlscno5eXFHbFNESnZRU2o4cUFWb0R5ejg2?=
 =?utf-8?B?dUZGTU5qUHI1U1ROT3poQmN0UksyQ1hBUm9ScllPak1MSTRocFV1N1BjM0FH?=
 =?utf-8?B?WmJsWHBOQTB4NW1pUi9XOVpTTG1SYXBXcTRqei94OVBKVjlIY0x0bXBVcTZL?=
 =?utf-8?B?ZmFZTFlRQ29jUVQyM25QNDBSREdsK1d4WTcyblhGWVhGenJiUlFMNWkwREl0?=
 =?utf-8?B?M242STkrQlJBdzRPN1FwekpFUkVDV1ZtbDdja3JTczRwdk1RYkZ0dHRvSFhF?=
 =?utf-8?B?TmQ0ZXloekhDM3RaR3lQTzRnN1FhWkNrbDBVZld4WUdOTmZQWHZweHdWN29C?=
 =?utf-8?B?UmZqRFRZTkUzNGl1RzZTTDFoc09XTUp0MUdSUnhKdFdscXA1MVRUT2ZVaStQ?=
 =?utf-8?B?aG0vRkpMQzhSS1JFVFdLYWdBRVpTTngwQVZEbUN0bUNnSVczRmtNYmlyNlZB?=
 =?utf-8?B?WjVHZ2N6N3I1bjA1bWRJSDFzR1NFTFpJSzVLcUdGR01NWTlvMzlmbG1TczBP?=
 =?utf-8?B?K2xVZUZEalpKakphdFE1cGJPVU9nbGZmTHRZMjV3M2MxaFljNEl2azR4cjha?=
 =?utf-8?B?SllsVDY1UDRxMkxOWGZ3VDFuUldmbll0T1lvTGNHMmFSeThTVVlhTVBnY0Z0?=
 =?utf-8?B?enBKTEk2QWxhNmFUWFhOS2RqZnA3dWhMVW1LSi9mcnRod2V0YkhqK2Y5Zmpr?=
 =?utf-8?B?UEdwTW1vcmlWRUY0OGpHYUdISWZPVWxsYXoreE4zRFZTNFFDeC9yYis2TFNq?=
 =?utf-8?B?NEdHQjYrTWpuR1VySFQ1bGoxd0lyWnExWlRjMnp1OHMwYlV4OTE1Vjl0M1U4?=
 =?utf-8?B?clh0TzhXNi9kb3gvWS9rME1GSjV6ODhHS2IyYzZrUE50VW1JOUZQcHVuYWFh?=
 =?utf-8?B?RXRlUk0rbE5PVUNDeDNqOFo2Zi96R05hYTU5YnF6ejZUZXRhOUpMT3c0UXZP?=
 =?utf-8?B?UDdwTFRkQ2EvTDRPNVQrUVZNdC9XZ2VJMEljYlNyMDFpMDYreWRIbGg0eGV4?=
 =?utf-8?B?WWJWblVXa0JsdjhZbmtsN1R0NUlVeGtoaWZVc2NFSDViOCtCb2ZadE13bHRj?=
 =?utf-8?B?ZHUzRERrN2R6WkJHOUhMWFpMaTcrY0VzdlBramV6VWlpOFVJQUZZTTRTbzZu?=
 =?utf-8?B?VnhBWTh0V0Zmc0ptc0tDUXl4OU5UQThLcVEzdEVnN0ZlV3J0L2FIRTVGNEJv?=
 =?utf-8?B?bWcvejh6MmRucmoraE5BSjZxNFQxSzdxYWVzc2JqQ2lEMFFQcEt6L2dNcjBu?=
 =?utf-8?B?enl2UThjZC9CQXNsc3dUZWhkTHhpVHNrWkdRMEJMUGY1YjBpMHhMVDltKzdm?=
 =?utf-8?B?Q0F1ZEdoQStMNGtqWktDRlBPbXNsaDMyblUzb0Nmc2xFUTFYN3djR21TOVpq?=
 =?utf-8?B?YmxqbmxQS2d6VHY4RWJHTFFGN1V0dkdOUmp1ZFplVGkzeVVnMXhXZnIrdXNL?=
 =?utf-8?B?UXpCS2xrcTdvTk4yamN6cEx4eVNUK25hMUtCVS9mcVorazFRNU9GMEE3eUpo?=
 =?utf-8?B?TUdFZGtXelVOdWNnVUs0UkR4ekp0bUlxa05zdzVPVDZNN3YyVXNpeWNCenh6?=
 =?utf-8?B?UlZVZWFjeUJ2a1UwbCtGZ2xrVVZ3Q2JlOGVtdk44TFUxNG1UUWRYZklNeG9D?=
 =?utf-8?B?bk9oYUpsck9nNUNPSFFJcytQOEVMYk16dmlMMUZnMVVRa09wNHRnNkg3TWt3?=
 =?utf-8?B?OGQ2T3cwSFh4S09ZbHZzNjRHM25rSmpVMWt2Tkl6YW1USlRCSlNWeS8vQThw?=
 =?utf-8?B?UHdLSkpZKzhtckNSQnB5RmlZejNwRFlQZkVoTTZCcHJ4RjUwdkJWbExyY29D?=
 =?utf-8?Q?zNyncI1WecJDSi13rCb+56UmH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b18e7c4-588d-4f24-9bb9-08dc38aba6aa
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 22:21:47.0051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: spwKhWCv/r5R9Dfkj0OXQ8ugr2CaKs4tnnku4fmgC9RX3i16+Bm0kvZbty61ATaPKGFM8u6NsZGe+9xJtci+IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6477
X-OriginatorOrg: intel.com



On 29/02/2024 12:02 am, Borislav Petkov wrote:
> On Wed, Feb 28, 2024 at 09:21:00AM +0000, Huang, Kai wrote:
>> Based on this I'll change to do unconditional WBINVD during kexec() for in
>> stop_this_cpu() and relocate_kernel().  Please let me know if you have any
>> comments.
> 
> Yes, pls make sure to summarize in the commit message what this thread
> figured out. But basically, we want to try the simple approach and
> WBINVD unconditionally on the CPU stopping path so that caches are clean
> and there's no potential issues...
> 

Yes will do.  Thanks for the feedback.


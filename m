Return-Path: <linux-kernel+bounces-76557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F9C85F91D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55E541F2692E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAB812F5B5;
	Thu, 22 Feb 2024 13:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LIyaixIy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA6A12E1F4;
	Thu, 22 Feb 2024 13:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708607093; cv=fail; b=jHDFjGdKoSULCz3bh8uxeEtlw8A8hgRuY1kdqMqtCAVmrfDadpa0K+NcEXZUlMrk9BpEhN1jaFjX58X+15Otd2jc8KhrtRqc0O+n2Kq3QxOE0ozyvMoeZQNQwzGjL01GOQKruZqWGFBILoWXG77cuhww6VSsUxsJZNa6AT9ZpBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708607093; c=relaxed/simple;
	bh=SCfGJtblC58+VpdRHvAHdvz9TrhY1YUX9G/+Rr12/Bk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oWuGCeJnECWpWfTROHXOFWGnPqeRzMPCnyINFCu5jv5lCOfzPGakhdwZl33ohmNfkQ0CPGcQhGn20WeVgFfQor3goVOFW02J6Kmlh+hyoNfKVd/NS32P/bdLs6BR15GeYAfINSpzrJo+NMMnzxl9+KFywJCuSFUe5HvIqLIfnwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LIyaixIy; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708607093; x=1740143093;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SCfGJtblC58+VpdRHvAHdvz9TrhY1YUX9G/+Rr12/Bk=;
  b=LIyaixIyr7svEN71asvhqHb6XcU35xf7gexkYIDQ84b4xsHHHxajHozB
   k2YRgCZd0DKnr3oYjmssuvDjcZVUGf2PtayMsMA6wpvLlZ7KrAhSccCiP
   Pbu9QG02nwEbjDiBwWJQORmOIw7Yqgy9EP8GouS7dIc2beODhmuMGJ1Km
   5FiLt0J6NX1D1wB4Gh09ceejsSHZQ5WYspPei7E8irIFAIjkPzX5/XKw0
   VHDnqNjUKrhRzlEm0codyJrmBFKRGTscDB0U7mTCquZA4RzGnexH7Ym4a
   S81HFKJ3opm1GJYFY11jDVQCR5uv8FBe2gNWOlsIMBqhXUCjWNnQOiHcA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="20381166"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="20381166"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 05:04:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="5433323"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Feb 2024 05:04:50 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 05:04:50 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 05:04:49 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 22 Feb 2024 05:04:49 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 22 Feb 2024 05:04:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/fu2WZX5+Li9O7VScsrbhSaM8JKQJIXD8EuqxV0xuvlC4/vlH8uwXNOZOuUL0m4qloI5klsClUjrzpUBckgDwu1nILwRAi4xlD3MdtbzZ46Q78GsC8riVT5tNDYKkjoav31Eoy0wHWyPvv5pf0Ic1tRQtJNFLABeZ5b9+zp+17BJSk5uOAaAlgjuVJzCyxw7tgC3rjFIBV0FhQkDe7SRsQCfnwp+YmOWPAVKvlNloZk4Bn1GSuy9q90daXC4QUwCnT844PFOIQssIFln/44afh1tUH4xuGcuZLKIfOfL2URq4/sLoyGryh/m+VP7uEXgHROmlzLjKdZNBVoYH7gKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCfGJtblC58+VpdRHvAHdvz9TrhY1YUX9G/+Rr12/Bk=;
 b=VpU3DYHtUg9CA/Tbzoplf8J86jFb7fi02yBq1UqR5aUsWob5wAMzu4WocthmJqQuPPklSSsWtDV5YzKu8/S4r1fY79fl9R0oxQS9UtKN84kLLT2AVFvoZR8vKf3WQa+pa1dnHvYy7ORr9lUyTW7yuHxspHntrgB34NNr//iEWdKklKUFmDTl0CkCjHpNjwMWzlNBkyV54VrKu5B4DNpKRUCnxS8SjnH518GhrPVfXiSrwtunHTMwkS1HLYkLCnKKY2t//tdgmHkNATBYQZ7xnnln6HFBGStfH6kHwvvxfnicBP4t3vVxQpRxtQ85I6vtbjuFKf/rrouy6Kn7KwXk8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4836.namprd11.prod.outlook.com (2603:10b6:303:9d::22)
 by IA1PR11MB6393.namprd11.prod.outlook.com (2603:10b6:208:3ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Thu, 22 Feb
 2024 13:04:46 +0000
Received: from CO1PR11MB4836.namprd11.prod.outlook.com
 ([fe80::1c0d:8bac:f817:dd43]) by CO1PR11MB4836.namprd11.prod.outlook.com
 ([fe80::1c0d:8bac:f817:dd43%7]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 13:04:46 +0000
From: "Luse, Paul E" <paul.e.luse@intel.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
CC: Paul Menzel <pmenzel@molgen.mpg.de>, Paul E Luse
	<paul.e.luse@linux.intel.com>, "song@kernel.org" <song@kernel.org>,
	"neilb@suse.com" <neilb@suse.com>, "shli@fb.com" <shli@fb.com>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yi.zhang@huawei.com" <yi.zhang@huawei.com>, "yangerkun@huawei.com"
	<yangerkun@huawei.com>, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH md-6.9 00/10] md/raid1: refactor read_balance() and some
 minor fix
Thread-Topic: [PATCH md-6.9 00/10] md/raid1: refactor read_balance() and some
 minor fix
Thread-Index: AQHaZWXTcgAGq6twWUm2qdPCVe9amLEWCq6AgAAIAwCAAEHiAA==
Date: Thu, 22 Feb 2024 13:04:46 +0000
Message-ID: <6BE93F19-AF6B-4E05-ABFC-24FC7DF97524@intel.com>
References: <20240222075806.1816400-1-yukuai1@huaweicloud.com>
 <34b04a5f-7ef8-4e00-b1c6-c4e692281499@molgen.mpg.de>
 <0f2a89e7-fa2c-fe83-bcb7-cfc449c5a721@huaweicloud.com>
In-Reply-To: <0f2a89e7-fa2c-fe83-bcb7-cfc449c5a721@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.400.31)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4836:EE_|IA1PR11MB6393:EE_
x-ms-office365-filtering-correlation-id: 8a2b4dc1-9939-487a-e47a-08dc33a6d82e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pN0/ngR9RGXjsc2Vpttb0H2LKkAI81tbdK+ahdvKiPUoZuEW9Hi5P5wtWuLC6mGgkFxgN9A1ZIwgtv3R/tFagJ1JHLyejv9romCsWfoy43cv/+nCDZgK3qDEaY4+ZeNN69kCATI47M5LbPD0ZuMbytzhcY3zdtXEJbNouyII8RAKHrCGobTLsEcx6WL8HmPwo+oFzmhTimPRR8vkP9WMucVhJU6jV+l5MLLY57R0q2HloqsiZgji3tDQiT1hHZs8tvs262Ii0k5PjZO+Pi7WESGJsPoA0EKm/JSt2dnwCtzpGCsE1u9gnJB+yBzqOf9OKKMYW7LTtI+90RNvnB26giVDVGzO70H5xacIHGFho8Qy92J3+NWMxEwC7HBUKhm3eyqgJXGTE7lZxuLt6HVGlIx8MzSM/T8bpjUcOlkdbbx3QrqeJKAEi2/sgNi/NFQ23B55BUc6FLbAOv5TsoRD0E1hpULnKfw6fjVx6tskJS+kgNmpGYvZb7ECkWFGAABWYrfUSmFSnffmfhoogSVc9PjEVwK60w8G9ibRJMxfEfk6p9RrtEi8f6xau8VebhdqdBoHPudM180liv0F4L66k1wKLVNgc2mwvzVo1+NZh3U32kgWSqFjVLkmFz6t5D7u
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWJTTEV6Sk1xQmJiUlpTZjdPK3FkUWNCMjR1bnppbW1HV2FlczRtaFVjeEZ2?=
 =?utf-8?B?Rm1XcVVLcjNIbGVGa09QaldvWDJvUUwvQ0Z2dmV4TVQ2TGRNV1owN29sZk1n?=
 =?utf-8?B?N2RrUVV3ZEduUk1SWldVRXhsVFFxVE1iSlhZMHljdlRPZmptNGYreDJBVzk1?=
 =?utf-8?B?VkFVT1VYYWh0VE1TdFMvcXZGK0p4OEpLaWpZVmFaOThVYmJUMm1Lc3B1bnFB?=
 =?utf-8?B?SUlGUmo4dVVtTXQvR2FPaGovWUlYNGNyWXA4ZmdwbDFaWkJUK1haYjNxMms4?=
 =?utf-8?B?TGY1K0FmN2RBUVlDSTdTMWwrSGtkRGZralRYZWhnVEpqVFFvVnR3RlZmTGFY?=
 =?utf-8?B?RE9UVU1pc1RZUDJjZFdGdlI4SDJDQ1ZPNjNLckJ5REhsYTVURWhqUmsycTRG?=
 =?utf-8?B?bmF3MDlQQVBCUW1OK2ZTM2R4a2N4T0dlcHlLWmlrdXBXMWtGU3NQRXZlcEFl?=
 =?utf-8?B?VjlLN3hjOVd2K3E0ZktRMGJNU05DWlhMN2pKUkhEVC9vQkxXNXJVWHVyYkJY?=
 =?utf-8?B?WWhpaGx2bjZGRUFsdENXTm54emcxa3dJTGNkK09XVHRWVlVGdE1VR1QrbWwy?=
 =?utf-8?B?ZFNESmJKRWpGOU1ZVE5YM3o1U3E2NEtEVkp2ZkNDRFpVQm56d2phQ21ydzJp?=
 =?utf-8?B?SENYbklUbkVNVG5Vb0NKMHFMMWxUYWtCTW1QbFpxQTIzYUh4RDByZGU2c1pn?=
 =?utf-8?B?M3NUWmZWV0pzZXl3OUQ0aDJFKzROdWRKcWMxMUl1VEJVVm51bkhIdEl3OWFR?=
 =?utf-8?B?UXV2ZW81dHRra3pPZnAvdk1KSnEvd0paeko5S0RLT3l0T2FlMkNNUjQ1MDNQ?=
 =?utf-8?B?WE04NW9McEV5WnlaK09mUTNOWVB0TTNLclhtdlppLzA2K2g0RlJEYzhmbmZT?=
 =?utf-8?B?WGlkcmZiQURzeVFvaDIrU3d1YlU2OFJCMTQwUWNWcm1aUjVPZktqYVIxaEJ0?=
 =?utf-8?B?QnVDcDAySDJCczB2d0oyMWc2R0NlUWMwWm81TVJvZkVJZEs3U05kelRIcm5Z?=
 =?utf-8?B?S1gyNG5qNnRONktrM0VxSmhXK0l5QXZXK3VvSEpRbVJJTGp1eGVuT2tuU3hD?=
 =?utf-8?B?dzVHRUVGbjZKTVp0c3VCd2tkUjN2U29zd05rR2NmM1FyNW9KYW42OG9LWm5p?=
 =?utf-8?B?N0ZEN3dtZGljNEpxNDEwdEY4RDVFM2Z6TTJWMC8vNldtdHpDM0IwV1NRL1ox?=
 =?utf-8?B?ZHdJVEI0K0lNRldHN0E0UDhNcVhxbkUvZTlGOGRaQ0FzZXJFY3pMMjVuMVlB?=
 =?utf-8?B?RWRMQTgydmR6bERPdWF5c21na0lRK3VzSndFcWkwelVHYnpjN1gvT2pBcDlK?=
 =?utf-8?B?bkpodDVFaUEzVU1zT2dMZ1l3Wlp6WEtoWnRCZG1IQnp3Qi80L1hYc0lyNUlh?=
 =?utf-8?B?Ti9heVFKZDA3R0QvR1FxMFJ2bFJyNUVoQURkRVk2UDNBMXZka1VlRHkzS3ZE?=
 =?utf-8?B?aHI4VURINnNNMXZRQllMdEk4bkpGeG1pVWpYMmthYW84eWFGbTg1WThxYzNS?=
 =?utf-8?B?Z05ERkJhNzhYNCtRR0oyTDFRQU1nbDN6R2ZnQy9zeEI4UEFtV1Qwa0h0aTNJ?=
 =?utf-8?B?ZUVaOVNMVHJOZDFreW9ic3djSldKbVJLWlNraGNOMnY2cnVSZDd5YXZTUTFR?=
 =?utf-8?B?Y3djRmVSOW1BcnowdHdBY0ZyamRVSGtJRXZsd1BDRlNheEJ4OEdGTGgwZ3Er?=
 =?utf-8?B?OVZWT2hHOGpub2ZhK3ZFSkgwbDkzQi94a1ZtbzNDVDRPbjJFcm5JR0ZFSFY2?=
 =?utf-8?B?Q2pCdi9sMnprS3krM0VveVhHdHBtZFpnNTBCREZlT0U5Y1JGNHA0MEM4NC9P?=
 =?utf-8?B?NGppSS9ab1h1R0RLS3BzY0dyclNrVWhQU213MjdKWDlZWE0wbjRDZ3NWWktn?=
 =?utf-8?B?UU5raUFsSzA2a2pQdHd6VGJjdkVpMjhlY3VEczFUOUlCUTE0eTM2MHdNYXNH?=
 =?utf-8?B?MU9mM2xOZXhJQnFSZllsWTR1c3ZMajZEYWM4ZkVnclRLSm5QcFdjVmluWFJJ?=
 =?utf-8?B?VVU3QXNoa1YyVlowbjFYTmZ2eVZYQXFNRUREMUsveHFTRW5IWWx1cUhkYVc2?=
 =?utf-8?B?d0MvQnNKZWpLMzBhalRnbW90R0Ficm5kV0ViWThURFZyeDFxdjBJdVNWUSs1?=
 =?utf-8?B?ZUI1UkZjQWNVeTY5aWJ4aHhIUWFuRW9DRFF1Ni8rdENBcUFDaHYveWZOQkFZ?=
 =?utf-8?B?N1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D69C3D7CD661A8439917D8F8DC30E6B8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2b4dc1-9939-487a-e47a-08dc33a6d82e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 13:04:46.4169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uZqSN04+tmAmVkQNPVZpaVBDrU1evOIIURGtJ31PGhYxxMR3KhJO1bBNCt3/z5n2ZJbM5ADh+JxBzAmSzutqSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6393
X-OriginatorOrg: intel.com

DQoNCj4gT24gRmViIDIyLCAyMDI0LCBhdCAyOjA44oCvQU0sIFl1IEt1YWkgPHl1a3VhaTFAaHVh
d2VpY2xvdWQuY29tPiB3cm90ZToNCj4gDQo+IEhpLA0KPiANCj4g5ZyoIDIwMjQvMDIvMjIgMTY6
NDAsIFBhdWwgTWVuemVsIOWGmemBkzoNCj4+IElzIHRoZXJlIGEgY2hhbmdlIGluIHBlcmZvcm1h
bmNlIHdpdGggdGhlIGN1cnJlbnQgcGF0Y2ggc2V0PyBJcyByYWRpMSB3ZWxsIGVub3VnaCBjb3Zl
cmVkIGJ5IHRoZSB0ZXN0IHN1aXRlPw0KPiANCj4gWWVzLCB0aGVyZSBhcmUgbm8gcGVyZm9ybWFu
Y2UgZGVncmFkYXRpb24sIGFuZCBtZGFkbSB0ZXN0cyBwYXNzZWQuIEFuZA0KPiBQYXVsIEx1c2Ug
YWxzbyByYW4gZmlvIG1peGVkIHdvcmtsb2FkIHcvZGF0YSBpbnRlZ3JpdHkgYW5kIGl0IHBhc3Nl
cy4NCj4gDQo+IFRoYW5rcywNCj4gS3VhaQ0KPiANCg0KS3VhaSBpcyBjb3JyZWN0LCBpbiBteSBv
cmlnaW5hbCBwZXJmIGltcHJvdmVtZW50IHBhdGNoIEkgaW5jbHVkZWQgbG90cyBvZiByZXN1bHRz
LiAgRm9yIHRoaXMgc2V0IHdoZXJlIHdlIGp1c3QgcmVmYWN0b3JlZCBJIGNoZWNrZWQgcGVyZm9y
bWFuY2UgdG8gYXNzdXJlIHdlIGRpZG4ndCBnbyBkb3duaGlsbCBidXQgZGlkbid0IHNhdmUgdGhl
IHJlc3VsdHMgYXMgZGVsdGFzIHdlcmUgaW4gdGhlIG5vaXNlLiAgQWZ0ZXIgdGhpcyBzZXJpZXMg
bGFuZHMgd2Ugd2lsbCBsb29rIGF0IGludHJvZHVjaW5nIHBlcmZvcm1hbmNlIGltcHJvdmVtZW50
cyBhZ2FpbiBhbmQgYXQgdGhhdCB0aW1lIHJlc3VsdHMgZnJvbSBhIGZ1bGwgcGVyZm9ybWFuY2Ug
c3dlZXAgd2lsbCBiZSBpbmNsdWRlZC4gIA0KDQpGb3IgZGF0YSBpbnRlZ3JpdHksIDEgYW5kIDIg
ZGlzayBtaXJyb3JzIHdlcmUgcmFuIG92ZXJuaWdodCB3L2ZpbyBhbmQgY3JjcjMyIGNoZWNrIC0g
bm8gaXNzdWVzLg0KDQpUbyBhc3N1cmUgb3RoZXIgY29kZSBwYXRocyBleGVjdXRlIGFzIHRoZXkg
ZGlkIGJlZm9yZSB3YXMgYSBsaXR0bGUgdHJpY2tpZXIgd2l0aG91dCBhIHVuaXQgdGVzdCBmcmFt
ZXdvcmsgYnV0IGZvciB0aG9zZSBjYXNlcyBJIGRpZCBtb2RpZnkvdW4tbW9kaWZ5IHRoZSBjb2Rl
IHNldmVyYWwgdGltZXMgdG8gZm9sbG93IHZhcmlvdXMgY29kZSBwYXRocyBhbmQgYXNzdXJlIHRo
ZXkncmUgd29ya2luZyBhcyBleHBlY3RlZCAoaWUgYmFkIGJsb2NrcywgZXRjKQ0KDQotUGF1bA0K
DQo=


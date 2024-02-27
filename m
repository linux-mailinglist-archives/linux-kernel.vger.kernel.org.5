Return-Path: <linux-kernel+bounces-83100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93541868E69
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAE611C232F4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B26139568;
	Tue, 27 Feb 2024 11:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jV8P3kE6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1861386D9
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 11:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709032184; cv=fail; b=GtQZOuH6bVRrKYNnN0pPOvucOf0Uw5ubT/xkeKihMPTBQv4PADpgswDiEfGoE+BFj+ZEReOBTuDQiRKfLubBMiCDA66zFTNQ21Qlmv0cUjOtYCeEtizSlg/JfAJv/zjOdVtTXwFeuXSgspzrOJ5SI32R/LwaUCKHbMVUFU7amg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709032184; c=relaxed/simple;
	bh=36abQFTgqPTGt+AylcAEsHk1LqJeKK+DNwPd5LL+Zsw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MFzcJ9ku65LV/Z0ZGWT1PQur/e9JkXKADVzQxcwq+VpCEriUYTkaUv1Gk3hMkorvCouHEu28kZEbo8hWqZAw/yY9zPN0hHSQDhKLqVWD2N+u9GJnIFz2LVrPSe9+cvK3cKdduge7xz+6mwvcAouARhN1EqMmRqTq7tnWqerCudM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jV8P3kE6; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709032183; x=1740568183;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=36abQFTgqPTGt+AylcAEsHk1LqJeKK+DNwPd5LL+Zsw=;
  b=jV8P3kE6Y8N8S8/seg3hPsExlLhEYK+k0Jx5Tw1uR/IVu4DOxCe+p/Se
   z/paK0bU6j71U/y6kD6E96ccHYAwEA8O6E+k9yS36/X92ngq3a/Wgv9Z3
   4QDQ7pUcwk924oOhQQ9g/SHHNsYwCy0bQnMsGbfKMZFu61zssYReH5OTv
   syGoj1mD7oVBWy2y+55jV0/JNJC4zOVx2OE/6eNMlfZ49HEHgm/KMnGjo
   8x+8LpwiF0j0F21foEJ0yUW2YlahFzUpI/V+nuWHGza4ZxKeFt3S6To2I
   O0d3/7vaPSepWx9PKWPtsPWfkf9cWKBvgWUM7yRHfKAzBTus9h1czllM2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14074859"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="14074859"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 03:09:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="11581407"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Feb 2024 03:09:42 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 03:09:41 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 03:09:41 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 27 Feb 2024 03:09:41 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 03:09:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMYhJjcYoJJz7Hiu+2DhlveDQyGDt1W6bDX6kd1qKVEOOcrPIG6uO6CSf9RQzych8Uv122A+TKuF59yr9Ma4THn2wDP/7qWgYc3hspbkMIXx7AELVLLu9Xhw9wQdcw8aJeNmBzeVz6xgc/G0zlnriBQDqE9CPkT9f0BE3FXm9IX8kc7ng4Bcbbu3+eNDtc3XN9mq9YsbtB8NP4c7PDlwIlHqdoTS3NfYvUm14eIbRD6OfQ3cRgz+2KHTv9XOXXg+66JvXO5mFKJ5xMGc6xjppwRZEsEYuUmlehDI6u0cq8y1H6Pgg6aFP20pdl9EzK+D99Ly+1UxdiXj8oC4kaX2uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36abQFTgqPTGt+AylcAEsHk1LqJeKK+DNwPd5LL+Zsw=;
 b=JnKe+l2WnjHTdBLU82gFpYaz7yJcPmxXchGKMk3+JT3o5aFSMv2Z4J/LRDwQ+97UGSGmJysEWQz8yxsr1iYSHWuhUvXlg3h1xlgkD3pepgMVLDt8HTomR90AqpxV9sV2Exx/MdjNeuZFbDwAlNlNa6sqmrXnprOovuqapbtZgKGd3gw0r1I4SNgg1vY7Edmwl3ouKs3tIGh3T3/ZhesqarxseFBRQJlr6OfhfXzl56A1YK4/z+sP2FezxhhdL7X/m7ev6V6B4WEfJwKSzilah7uNukGB3NxFhOjNLKaM7MoWKTRO4Q+twzq4Im65iuVZUghAlaEi6kW8miiajt7Zig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CH3PR11MB8185.namprd11.prod.outlook.com (2603:10b6:610:159::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.23; Tue, 27 Feb
 2024 11:09:39 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7339.024; Tue, 27 Feb 2024
 11:09:39 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de"
	<bp@alien8.de>
Subject: Re: [RFC][PATCH 07/34] x86/mm: Introduce virtual address space limit
 helper
Thread-Topic: [RFC][PATCH 07/34] x86/mm: Introduce virtual address space limit
 helper
Thread-Index: AQHaZb8s3Vy7ncTfcUOHU2S6G4jWV7EeD2aA
Date: Tue, 27 Feb 2024 11:09:39 +0000
Message-ID: <6642fd5a2e2635a3d466f5b5dd5e649dbe7e7943.camel@intel.com>
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
	 <20240222183935.286751FF@davehans-spike.ostc.intel.com>
In-Reply-To: <20240222183935.286751FF@davehans-spike.ostc.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CH3PR11MB8185:EE_
x-ms-office365-filtering-correlation-id: 1db77669-c574-4e0b-628c-08dc37849764
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2LnDqxcuPRkgM9zx1NPrCcgqgnlSOWw+5qE+S46b+ITchGOKewBrPiPnvKXl/mDPMln2Wmz6hlZR88chWf7Drlm4F2GR1aLqNDagIP1voFx9LtPKMeT16y6797qfDsafx19vZu/VckNES2tD3SFDJUeLLCDWuJrUuN6urldENb7PVJZkuaD5ZpUnbybiAzMCbgLLSJ7+xjMcPLgUaXQ3PV7u05PF0YR49aIAPes0UjptwUks/5D0NhH1HEY5nxBJF6CJt96SmMrPDWeA04zlc81D+FzMJ2LLr8AJZZdQhT3Ew4IERvWZ1yRS7mW0GpCC3ylKv29mJBzdTCX7Ibjyshf3cFg2vHaOq6nTQbsUwIye07IPvm13KpMWS0ut7PT0575TjvtjllKW7V+dQVB3Q8DegFZndSEqo3fjoUCUazmZpUMTMN8Ly7Zs6ko/A3DUJ8nNDsBwN/Mgw5GceCrgd5/ZYORl4AEU9iQUn8CjfzD96elysT+KMe7pGAysntfLf8a7UTWgCKUsXJL3dINL5A49gTnOU0NigCt/fGWvb4L1PXrMtbQ83uOS/AvCEuSyZAic46S7MqSkSVMtN32h4AG9X8KlRPkMirrbWJLG9vxRK+BH/dzk50bSHqOfJBX7FSuEguCv6r3aPVOXsYT3c3C5OsQ6qkvnjGpUhwAgJ5sLGfumDt8OfNSN/7+OMiMmoQbqmNZ8EQFoApVHVWqbpw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVhKWHkvMEsza3pSbmI4QTNYYjArd1FTbFgrNUR0Ym41RnRES2NxUnh6eVNT?=
 =?utf-8?B?Si8vdHEySXpTWndZeHYrcDVuQ2VjTEFaNlJRdGlwSTJ6RlIrajdLZEQvQWdE?=
 =?utf-8?B?SWsxcDN3ZUhIcXdIZ05tNEhMV2svU3hMaFQxRVV4bnNtcnN2cDdIQm9EdXJY?=
 =?utf-8?B?TFUwNS9Ic05xTmVlWXU0ZlZENzNuQk9uYlI5T3B6TDBpV1RYU1VVQjFGSHNP?=
 =?utf-8?B?Tmo4aGdpY3VkMTg3cS9CanM1SWNQcGMrT3Z6WUhtb0ZydFF0MUlYcmVUYi9H?=
 =?utf-8?B?SUltZ0xOK3hSVlBLOS9pRSt0MmVBTGY0M3N6ZGVMVDNnODZTSURpYjZQckF6?=
 =?utf-8?B?MmR6TVk3OXRzRVdYOEVSV3VMVk5IQkxpbW5IVmg0RHgxaUFRb2ZqTWpyR3FS?=
 =?utf-8?B?Q2gzclUvRktPa1IyRUdUNUdFZzZ6K090MVJvaTZxZm14OXErYXZmT011OVhE?=
 =?utf-8?B?TTNkMjBxQUY4L0hWY05mN3ZhcHhza3ZDdDFnWHBtMXRmRmh2T0xYdnZyZ0pH?=
 =?utf-8?B?VGNWWjlaUXZZSjBFRnUvMTB1Z014WGxHdk9zcVBqZG5uV1VNZjh4U1g5TGNM?=
 =?utf-8?B?RktIbUVLNG04WE5idXFsdUdsd1VmN3B5OFNIdFVsUmVpbVZjV1FncjdnRjhD?=
 =?utf-8?B?YmM0d3BBNC82eTNBTTVnR0wvUWFSUTRleThINzQ4TmhrSEZzcHdkYUpWemZx?=
 =?utf-8?B?NDhyUC9rRVpkdjRHNVpWWFVzZnp1UG1BOVVFckUzNzFsV1RsK2k4bG9BbEhB?=
 =?utf-8?B?UmRDbnlSU1RCcFJVN1l1S1I5Qy9QRklhS1ZKYkxIdDNsNlNIYTFvR0tsWERV?=
 =?utf-8?B?Y2xKQ3ladk5BVnh1TFJRNU8xMXpQWDBPeCt4Smo4ZHNib0JqWFQyZ0JiV1Mr?=
 =?utf-8?B?S1htK0c5bm50VWg1M3lDb2g5YkpiV3pyS1RtRlJyVjcya2U4SE90UVREY01p?=
 =?utf-8?B?d0NxSSs3QnNaU2xYa0d1WVI0MUNibDBrNG0yNXB3S1RoU0ZxbVRFZmpJakcr?=
 =?utf-8?B?bXRCNE16ZndEcGJQUWNMV28wd2VzcWdQaE5qNnRhT1Z6TEFrWTlTa1IzWVlk?=
 =?utf-8?B?azQ4dng5Sk1nU0dxNVJlVm5oUlRKdjZwZGIvSkt0K0JGeVllTldWT291WHZI?=
 =?utf-8?B?RDMvRi9Lc1l2VjRoQUlkaytkKysvSFBUU3NEYU5vQjdJY3hHcEYrUG5NbkE1?=
 =?utf-8?B?T08xNFlpZ29WSDZiODF4dlIrMUR4cG1vTnRvTXJKNFlKNXY3R3dkTjJ1VU1S?=
 =?utf-8?B?bk9WRVRIZlBHbEZ0c3FEWVVBSS9YR3ZReDYvejBrTmdTWWVOUW16V3p0MFlE?=
 =?utf-8?B?R3o3ZmlROEFNa2p1OVRzWVpTWk1QNGl5MlkyV2k5SGdkVUt2ZFJmM2dKYnYy?=
 =?utf-8?B?eGJpcGV4M1ZwVVdmYUQzSnJjS1ZzTzNINU5JLy85eGpyd3cxbVJEbjNISmU5?=
 =?utf-8?B?VnBMajlONCtrVTFBQnl6YUZnNURTUm1iTHRmaUF1WURsc0NaUmY5d2hrZHh5?=
 =?utf-8?B?cHVLK05uUi9GS2I2cWJJMmxJVEJYbzljV29LS21WQTNYKzJKUzI2SHp4NllH?=
 =?utf-8?B?bmFZc1VXRjJwNmh3VjFjN0NDRW1MT1M3QWQwTjJwTkpIL3k2NytzQnNHbGcv?=
 =?utf-8?B?VmFUNFI1N05IakpSUDlLZXh6ci9FdFJTWExGV1c5cjkwcTJLMWROUUk1WkI4?=
 =?utf-8?B?aGNUamYxMWZJUVVNUUdVc1MzU0QxZVFRbTdDZXlRYVVZcDNkTGF4OUZvNnRW?=
 =?utf-8?B?eTBpOVFzdW9CUjRnYU44akNiN3JBa1VtWFpJMFU5LzJQMlE5TEZzRmd5UmpQ?=
 =?utf-8?B?Z0dpRHJjWEtGWHl4VEVzV2FsUVFXRUVJenVURWNQaWM0QXMwTDI1TzlxcGhj?=
 =?utf-8?B?UThPZEs2c1N5VU5QTTVFL3h4bUR0UTZiNmZQV0tWUk1Hby9VRzUyQnhsSWxG?=
 =?utf-8?B?QkpnYkl1eDR3UW9OM0FVczZ5ejlzY2RWTi92ZTVHU213ajg0d0tvTXlzbElT?=
 =?utf-8?B?NkdLaFowMTBiQjdvNG1sYkxLQkFNa1hKNkQ1b21pN2hlc2laODJoVlh0bHhl?=
 =?utf-8?B?Ynp5djRmcnloNmYwWWFsV1FiK1dLcHVHZ3UzRkc1V2F0bGg1Q2ZQQ1NQY25G?=
 =?utf-8?B?enZKN2FDeEVGRExvTTJlUm15Znlaa1dJZHEyYXlkS0hPZkNlby9rbXJyMjdi?=
 =?utf-8?B?L1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <92533CEED55F71479503414231169866@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db77669-c574-4e0b-628c-08dc37849764
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 11:09:39.4808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g8D+qq41E3K1Lt8Q22oKIs+gTggCVZXge+q2s+wbfhwVnXKz9wXj0UY9Y+qc9KLDppmftALE6yU/cWrGLZYpRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8185
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTAyLTIyIGF0IDEwOjM5IC0wODAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
RnJvbTogRGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT4NCj4gDQo+IFRo
aXMgdXNlcyB0aGUgc2FtZSBsb2dpYyBhbmQgYXBwcm9hY2ggd2hpY2ggd2VyZSB1c2VkIGZvciB0
aGUgcGh5c2ljYWwNCj4gYWRkcmVzcyBsaW1pdHMgd2l0aCB4ODZfcGh5c19iaXRzKCkgYW5kIGV4
dGVuZHMgdGhlbSB0byB0aGUgdmlydHVhbA0KPiBhZGRyZXNzIHNwYWNlLg0KPiANCj4gSW50cm9k
dWNlIGEgc3lzdGVtLXdpZGUgaGVscGVyIGZvciB1c2VycyB0byBxdWVyeSB0aGUgc2l6ZSBvZiB0
aGUNCj4gdmlydHVhbCBhZGRyZXNzIHNwYWNlOiB4ODZfdmlydF9iaXRzKCkNCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IERhdmUgSGFuc2VuIDxkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb20+DQo+IC0t
LQ0KPiANCg0KUmV2aWV3ZWQtYnk6IEthaSBIdWFuZyA8a2FpLmh1YW5nQGludGVsLmNvbT4NCg==


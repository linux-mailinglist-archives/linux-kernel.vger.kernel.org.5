Return-Path: <linux-kernel+bounces-123635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C21890C07
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83296B233EE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D6613B59A;
	Thu, 28 Mar 2024 20:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KuwEbViB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFBE13B288
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 20:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711659174; cv=fail; b=uhHA+kGqBsAH2ehwTgu5F7Hckw4zwkMAQ64p9RQxn4GhM8YN+PRpfbOTwjZeOaxW60wEKn7TK9tsoY4JmInK1CgxApVJ+zD5AMnp2BNwLoq+A/C32I/Itckp/L7MElL+4bWdmBATjp6y3nC7U6onwVeV1EAg93au4FaZ+xowsq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711659174; c=relaxed/simple;
	bh=UWVI3bH60SA/eFN8CeWO5BLmJIlZNiZnK43dtOmmfVA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R9wlrhlAgPuWTLbCNvjRAUOoDxdrQVbbKrFUljfgzLwq1DL/3jQym0jSejI3guHB5QnvWpp6UEepT4EnLdDPMbtYPxIvXLyGFprkxtjpi+slIelP8FignxA9gU3zTB1a9Xiu6abAy9WDCMrtgiDSBCGBVWGmzeZsCScX9kPApDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KuwEbViB; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711659173; x=1743195173;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UWVI3bH60SA/eFN8CeWO5BLmJIlZNiZnK43dtOmmfVA=;
  b=KuwEbViBrEA4GKO8KHFu7gvM9rTNVeEVBH/Oi8KiyXY9aBp1Ij7Bijxw
   muQ0cAWQZfXQeTJ3diNFjbBCVKoUL+Ck1NkR/GfBKGyWSW1BIBEIMB4nm
   EyjR24S3msJyERYKlHamRxSoZU1rkrtTUU/KfgbT3UoOo3rZXRSbD/D13
   WTCjMwkKRqeQfxrtoxiDRvLalv3d1CjWyYhezQskmkaoRPd0uSdqQqkym
   RJ3C0OCRicBU+52Ys7xdl+SRcV+BaXs+lR2eCLG2i2WrDl+58gjqjiNVJ
   THkCdMuWmrikv0kmapn8crk9zbUHyNOt6MuZ+IqI9xqxFqcfOflGo0wF2
   w==;
X-CSE-ConnectionGUID: co/FIafjT7GPaaqBZ0XU3g==
X-CSE-MsgGUID: VjFZDXmMTdComHa/hTSWuQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="29323035"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="29323035"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 13:52:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="39926507"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Mar 2024 13:52:53 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 13:52:51 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Mar 2024 13:52:51 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 13:52:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNS3U7ob7S8j68+SaYbqbRxR9ERVzhE6Lf/Zz+jdQm5cLT7XYoGOyHTOOz/di46D8uzM27uLaEeMNVP8n11jWAw1K/cq8WFTZS+tfl22zSVXEQsJOGrUSQFJu6UYmFDxVluGksrQQ9lZkbrpzvAu2MRgopG9bEnBmAeDJBzQVOzmmJh0CYJc2sxQV1a22m9EMjEJIXI6aFYmBFh4I5ZOlExz2r3kdaZ7FIDo/jd9wwfUxIxPZx42srrz+Lsyxn9tAsjbWdUEAUV1dPJ8a5zL8PC1NPb4JrOfYt6IJutFlB7rK9t3XEuxSD+CVFylHLAWHRRIe7D94ggBvzt3Dp/Jeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWVI3bH60SA/eFN8CeWO5BLmJIlZNiZnK43dtOmmfVA=;
 b=WBMG8eFNmH1JhQrVBnlIu8IZBaRf/ckd8tob2RLEiTQYI0TzNTRg4I84KZdRYpNEqbKjPZ3aNieijFIqPvwAioyIdq9R+EkHLzV/K5bgW2iIXEPzMqcKUZtW7IvxaI/M/O4hLghyIkJcTNDTYznWa4Nk8EVBBZwRX9rKCfVjlNfph4DHIMPFagvpMuqHDu3gcfcDKQNNCjsAsoJs+cHZuFQUsxf1ys3DwFrcVwvn9DvGUr97yMx73/y4kYPSmCq6K6KdL7C93Ak+H1Z5nUWMmnE2do0/F3LfuzQfjHYLo9ytnGy5B8ts7t0SmszwPZEeQoZAk5SnXjv87HhrqMEO7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CY5PR11MB6439.namprd11.prod.outlook.com (2603:10b6:930:34::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 20:52:49 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 20:52:49 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 01/74] x86/cpu/vfm: Add/initialize x86_vfm field to struct
 cpuinfo_x86
Thread-Topic: [PATCH 01/74] x86/cpu/vfm: Add/initialize x86_vfm field to
 struct cpuinfo_x86
Thread-Index: AQHagS5KoaFl1e6FLU2YPMaZiCLmO7FNXROAgAABToCAAAEjsIAABDsAgAASPNCAACk+cA==
Date: Thu, 28 Mar 2024 20:52:49 +0000
Message-ID: <SJ1PR11MB6083DA36FF995724D3C1273DFC3B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240328163746.243023-1-tony.luck@intel.com>
 <20240328163746.243023-2-tony.luck@intel.com>
 <20240328164811.GDZgWfSzAWZXO7dUky@fat_crate.local>
 <20240328165251.GEZgWgY1Clb9z4t3VX@fat_crate.local>
 <SJ1PR11MB6083AADC97E50462C1137D71FC3B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240328171204.GGZgWk5JNOzQzoaEql@fat_crate.local>
 <SJ1PR11MB6083D8BB65748452B204ED8AFC3B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB6083D8BB65748452B204ED8AFC3B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CY5PR11MB6439:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eS9jjN7D29p396F4SInci9njgnQY1m2QRlvGjYrrw4FtjH1OLnipOKo6FulAnANXykbrf7joGTqmcm2R+46opsTsV5ADb4iddJ8ho+GJg32mNtrieAFC3XlpONP28CgUiDCafa27oYj++eZrtO327+suV6om5QIKGZRMDxRPbwMGCoGPIPF9HEPaNiRmQkxbMT+RtSbcPYOMG6stt8EU2FscWBdx2gKVx1Nxx0Me03Q+jxRr6tv+5B6h9QRJa4IVe/CFRcKRtlKRTtBIdpKeTVvAWVkPfvWIothDURefSeKVxaiMnp8pvvZjrRoyJp1PNTmOUR8CjRPgTOVV1lwlwqdmGN9QDq1eSz2ePKSRhWKN5rDeC/SDh0HPrdWlkHXfBYWtjSmgPglLJfWq5tOMxgILsHRTmECxfNf+edj4YQclQ1XkZnRYv2wKiOazYl7sJFy6Zi3FJazbH/wnnL5qDW8pbmSvraij3bN339P2f9Nf7iU6nCqvms6luGfntj8mged2GA+2gKk56e119teL+SuOGWbfmNriD3CkxUl7RaCZM0H8dmKR8HyFJHaFELWvNc2YfM6PiENhbalNHlyoA7OIV0h52hpEpBrn+ogh55HojhZi73/i3eR6rQr7/NQzKfWjQmnobwccGz2xm8px95+5DOm2l579UuvAaxwCt9Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjFqVzNJSUlWVGg0THIrcTRrMmgyZEcwdnFhYXFldWlxdnMwWUovVFFxbTBD?=
 =?utf-8?B?STZuWTRnMVo3K1I2V3JMVlRPODhncFcvNFV0cCtpb0FPNnFTR2QzdjRObGdG?=
 =?utf-8?B?T20vUnBLdXVad3lYNk9pU0hTcGR0RzJjd2MvbCtFTTlrUFluKzJ4d1A1Wkw4?=
 =?utf-8?B?c1ozY3NBYUdFWmRxVEpuajBjbUo3cXNVQVFZeGFmQXZRdXF2czlqV28vRTA1?=
 =?utf-8?B?WVJyQWhwQlpWYWxSQkRVQWhRWlR5OGY3a0g3WkhvYlB4bXZSa2hzWU1qczhD?=
 =?utf-8?B?cXRnQ01Ga1NZdUpCaEx5aGIyNVNpeTRGWVZQTTFkL3RINUNkNE5XNFQraVNF?=
 =?utf-8?B?cDVEaTZ6a0ZyY1N0M3dGVDF4T2JOWUdtTU9GMTRFOXpjWnpnU3NlMitkVk5j?=
 =?utf-8?B?ZEJEOUY2bDlXOEZMd3MvRkxHVzB4ckp1QnlodzVibWtvSUgxZ2pyZE1STDNS?=
 =?utf-8?B?Y1N1TUgybmZ4cmhiOTRxaGhnK2JmNUZ6bTNPODY4YU4ybXQzVlBPdCs3dVVk?=
 =?utf-8?B?TTRJUk5jdVFMUWNML2tvZDJGTzFseFNSTi9iaEFkUG5GQjMwSCtjcWVCbmdE?=
 =?utf-8?B?cEpBdWxrQVZkWUo3Wk9xdThFM1I0QjhNT0JtQ1JrRG96ZmtwbTllZUYwcExq?=
 =?utf-8?B?ZkJ1WE1NVlRKOHN5RUwremJDMFA4WUJMZ0JsNzBJRWcwazlGbFA3S2tjZm5J?=
 =?utf-8?B?Q0J3VXBPUnVFMklOYldKcFYxWS9LQ1NHc2FPaGhCWmRiNTEwK21IaUlyWHNx?=
 =?utf-8?B?Q3RTQ2VUTDBXazA0T2FvSGdueEVvejNGWitYTnN5bGcvamJNenp1UWgxNDBu?=
 =?utf-8?B?MHlXcEdvTEgvMmhIYlVSeVptc0x0T1RodVJkZWJ4VUY1WW92eUplTnZxQ25p?=
 =?utf-8?B?TGFxOHZXUzVYOVMxWHBjSkFqRXh0MXZ0SEVjTW9DNmtjWjZMZ0pac1NRdTRq?=
 =?utf-8?B?VVFRN3Ywa3dUeHRocndlSDEwQTZKdG5idmFCWVhHVmtZRWwydUc1ZXFUb3Nr?=
 =?utf-8?B?dDEvSm16NWdQTkhBQkdTaHdocXhJQ0dWZTBzSFFVWGhLR0NucVJRYy90RUl6?=
 =?utf-8?B?Z3pIWHphRDg5MnRITDI3ZkdiMXJsK2lhUkpnWFdNK01nMTc3bEtDMHZpSHFk?=
 =?utf-8?B?OWo5Ukkvc1hWV1JQb2t1aDFPcExneXhiZEhxL2tnRjhJc3cvUW5CUVluaXJ6?=
 =?utf-8?B?dVdxN0VleWJrd00xQ0xRcGFxeit0cUNqdzNPWXMzUjFvU2Zid0JTWDRSemtC?=
 =?utf-8?B?Z0JKWWpMSURwdm01MHkwdi9OeElFV3VLeUVEU1hueUpMeUIxZURFTWlTNStI?=
 =?utf-8?B?a1ZuY2pQdTVYZGUvcmtPN0ZYTUVGZzdXWEhQTEdtazhFdi80c2JwTHBiWGVO?=
 =?utf-8?B?ZHkvbVBqemdpcUZ4bytLM1VpZjMzemNBRVIvajIrbkNONllwdk45bWgvUGtM?=
 =?utf-8?B?R2Q0UWRrbm1ZSmxMblpaWC9JNjM0cUtIS3BHcFQwRWM3WTZVbW5PSG1CNFI4?=
 =?utf-8?B?MnBzbUQ3RkQ0Zjh4U09ubk91eE51ZlJNODJQYlFLQ0tHQmZtRjEwNVhxYzZH?=
 =?utf-8?B?aDlDK1pua1FnWVJoa3JYeEpoczNoY0NNdDB5cG10Q2IwckhncFJKUG9Gdkx0?=
 =?utf-8?B?VThpQmRsR1J5TEJCYlU3ZEQ1SW82c2NJSUpyQlFERDhQVmVtQ0piZWpzeVlC?=
 =?utf-8?B?eXlFNXVFeHhrVXZ3L1hFK0w2bHhmNWh6OGQvMXQraDlhZ0h2SGp2VU5GeW5D?=
 =?utf-8?B?VU94bEV1dGRPak1XdlJrV0FDUHFoMnNmYWZ1NVVIZVVJTndVamE0bmFhOEhS?=
 =?utf-8?B?Tmx2MEcrV3owSjFaSTYwVkRNUTFvMDR2ME5DOUkxdWtQR2lCb3pyT2I1Rjh3?=
 =?utf-8?B?UzRCMDBEbVF3cWR6ZXp3TWVIUXRKYjFOcDFUa3JnaWtqRDNpY1VBeDhHS0I3?=
 =?utf-8?B?ZFBpdGVvcUNDN2pXRWxJNGlsemUyUlBjei9MWldVb0hqL1l5T0FUaGFGRU5V?=
 =?utf-8?B?S0piRFh2Sk5VRmpCSjNlTzJNaDc4eGlNWWZCYkY2Nm1sMFpvOTludlpOcXVI?=
 =?utf-8?B?R1BscGIyeTU0TXlZbmR3YTFiTEQyVUFnWmoyR0lvOVJWTkYzUE50N2x6ckk0?=
 =?utf-8?Q?zl8M/v48aGwXOh7kURwmFz6js?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ccf9397-8a10-437c-e6ba-08dc4f69073e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 20:52:49.1410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xQYqm0j+IRqv9aqvp5NqcqJDCj/k4gWy95d2elW3NIC2jmqyoqv0YuO4XHe8SFAMUlTcPRK7Ba4zj9ZcGLXc/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6439
X-OriginatorOrg: intel.com

PiBJIGRvbid0IHRoaW5rIHRoZSBmb3JtYXQgaXMgcmVhbGx5IHRoYXQgYmlnIGFuIGlzc3VlLiBJ
bmNsdWRpbmcgc3RlcHBpbmcgaW4gdGhlDQo+IGZvcm1hdCBhZGRzIGNvbXBsZXhpdHkgdG8gYSB0
aG91c2FuZCBwbGFjZXMgdGhlc2UgY2hlY2tzIGFyZSBtYWRlIHdoaWxlDQo+IG9ubHkgYmVpbmcg
dXNlZnVsIGluIGEgZmV3IGRvemVuLg0KDQpTdGF0cyB0byBiYWNrIHRoYXQgdXA6DQoNCiQgZ2l0
IGdyZXAgSU5URUxfRkFNNiB8IHdjIC1sDQo4NzYNCg0KYnV0IHNvbWUgb2YgdGhvc2UgYXJlIHRo
ZSBkZWZpbml0aW9ucyBvZiB0aGUgbW9kZWwgbmFtZSBtYWNyb3M6DQokIGdpdCBncmVwIElOVEVM
X0ZBTTYgLS0gYXJjaC94ODYvaW5jbHVkZS9hc20vaW50ZWwtZmFtaWx5LmggfCB3YyAtbA0KODIN
Cg0KUGxhY2VzIHVzaW5nIHRoZSBYODZfTUFUQ0hfSU5URUwgbWFjcm9zIGRvbid0IHNob3cgaW4g
YWJvdmUgY291bnQ6DQoNCiQgZ2l0IGdyZXAgWDg2X01BVENIX0lOVEVMIHwgd2MgLWwNCjQzMA0K
DQpQbGFjZXMgdGhhdCB1c2UgU1RFUFBJTkdTOg0KJCBnaXQgZ3JlcCBYODZfTUFUQ0hfSU5URUxf
RkFNNl9NT0RFTF9TVEVQUElOR1MgfCB3YyAtbA0KMjENCg0Kb3IgU1RFUFBJTkdTICsgRkVBVFVS
RQ0KJCBnaXQgZ3JlcCBnZyBYODZfTUFUQ0hfVkVORE9SX0ZBTV9NT0RFTF9TVEVQUElOR1NfRkVB
VFVSRSB8IHdjIC1sDQo2DQoNCiQgZ2l0IGdyZXAgeDg2X3N0ZXBwaW5nIHwgd2MgLWwNCjgzDQoN
Ci1Ub255DQo=


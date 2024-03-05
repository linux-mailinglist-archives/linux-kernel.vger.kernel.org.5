Return-Path: <linux-kernel+bounces-91440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9C4871181
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 348981F21A5D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B8A257B;
	Tue,  5 Mar 2024 00:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MgwU4/ga"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CEE7FD;
	Tue,  5 Mar 2024 00:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709597843; cv=fail; b=UTBCsn8YUflwx4UY6NQ4D/tt9JkMZ5zPng4p2n0OKERhCht8mPZUNB0QxlGPpbbQ5cKTir4EreaCp36per8aLzKBw39KLzx5qRFm7y0pX+Zx068r1tiLoJvR8LWjlO8J2JFyh1CV0Zoo72dlCsmIboWK2jwhS5JFZyeNKl2DeP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709597843; c=relaxed/simple;
	bh=OrYmlrr5vrLLZ/oqJ5kYt47qEVY6kjWh8GGDAJsr0w4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Kidykim01JJa9CMPJ3EjBPEean5agRGD9MSRX2AhXEYwQoogPZ/TT4pWTXZL8cUvmO/GaRqn7kaCse4Sk65vFpzinzY9v6sCPGOdTN1psQ4VjUmxF0ui2un41g8HPWoZDtgdALYmHXOs1jpoilAAYLex6jUCim90sV1gLkhPyKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MgwU4/ga; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709597843; x=1741133843;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OrYmlrr5vrLLZ/oqJ5kYt47qEVY6kjWh8GGDAJsr0w4=;
  b=MgwU4/gamCHNVRqpVXDvJNX2Ad1ZjXCMJkc3tVgf2P6lF8iQRG44qt5M
   G09if148VcjZqlNq83FoxRjjSfnsbQ+p+1jYEWJ/fnWH2sciCNWEAYTW+
   JvVXF3YWoOzLJvQVKdIAqhu5+U950u5qV8AamAK/kpMoF34vt9O3Qgnj0
   GIcCN4ZkC0uzaNtncspJAn2Vn/Gii5YtSzBvJ1GHRhhIdIoVQGMVvQ+CV
   vKHBSXefk/8V/Ul1tSjrvCnVINcDOlaxm1jSJWZqSCh4tTXZqtBAQBhue
   YEg/oAmYhzlO5eca4cXYC+vZJi07qzz9yDsJCiQLgaR8QAEmPiW2GawSv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="7943628"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="7943628"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 16:17:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="9592458"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2024 16:17:20 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 16:17:20 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 16:17:19 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Mar 2024 16:17:19 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 4 Mar 2024 16:17:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghGQfcKL33g00ZgIJsjNP3yxjpkDea+oUbQMjJ9DfqR3Vnp9JY93//UvNmSOSDGl+rnwx7sDvdS+TkZNDjzTKP3rhDwK8DTobgE73qpGdq0pGuqoOIsaFQMljcgsYWJ4dUirbgxaqZvmIxtB5cRXORWAak6vXySbAupy9e6lrhOUqqR7OJ37AqrsMRRkqSUQh19NK/S7d7iZK2UxXbCGyFVJx4+3nRITlyDkyvxJIBBEL/MKFwU6XuHgn6K2bHgalpHlxYmfyL9pTdCnEW5hedRpfbAqWd/33n1zC9pTs7PX9NnZBE2X3TuqAA4csYEfcSZniZLXnMSAcNzaBzGG/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrYmlrr5vrLLZ/oqJ5kYt47qEVY6kjWh8GGDAJsr0w4=;
 b=KVF5I9hd1bvMw+lRX/F3ztM28pfsjfUcimxXSD27Dy9OPKt+nvEdJ/y6OUHQ0kF3HlvGkw3nU+htxjXjBZHsQTYCqIw3qv5c4Evy9sX6ODfwynAgjMgs4RgUejDYA2JFI+wWz3LgzDOBRH8dBQ/5wKw8yknh5Ub4EeDOljnbybRmqjeDBbmHFYrz9X05R4kEpvrqKRggFRO365R4f35DGhsgN/QPzIjO9hCyiksWIYxSzrBJ3N6HgRFwSXBNQvUsGnH/rvFZON9InYGoAZGeUEvoU3nMP/xpejX44mcKtalHjiTwNXS3s7brTSSYXKDy/C5H0yN6Gjh90T2Iv60g1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CH3PR11MB8155.namprd11.prod.outlook.com (2603:10b6:610:164::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23; Tue, 5 Mar
 2024 00:17:04 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::d5ce:2b6c:458:3ca9]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::d5ce:2b6c:458:3ca9%7]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 00:17:03 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Chatre, Reinette" <reinette.chatre@intel.com>, "Yu, Fenghua"
	<fenghua.yu@intel.com>, Peter Newman <peternewman@google.com>, "Jonathan
 Corbet" <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	"x86@kernel.org" <x86@kernel.org>
CC: Shaopeng Tan <tan.shaopeng@fujitsu.com>, James Morse
	<james.morse@arm.com>, Jamie Iles <quic_jiles@quicinc.com>, Babu Moger
	<babu.moger@amd.com>, Randy Dunlap <rdunlap@infradead.org>, Drew Fustini
	<dfustini@baylibre.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
Subject: RE: [PATCH v4 1/2] x86/resctrl: Pass domain to target CPU
Thread-Topic: [PATCH v4 1/2] x86/resctrl: Pass domain to target CPU
Thread-Index: AQHaan2PyoBPXNeezkGw1htb4OlYn7EoPHyAgAASjmA=
Date: Tue, 5 Mar 2024 00:17:03 +0000
Message-ID: <SJ1PR11MB60839371908CDC17A01F2167FC222@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240228112215.8044-tony.luck@intel.com>
 <20240228193717.8170-1-tony.luck@intel.com>
 <12766261-26b2-4aa4-a735-c2380c4963fd@intel.com>
In-Reply-To: <12766261-26b2-4aa4-a735-c2380c4963fd@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CH3PR11MB8155:EE_
x-ms-office365-filtering-correlation-id: b5f41b1b-e566-4309-2d46-08dc3ca995c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PoO1vnww6be/yIWcRPmCCZn2cp//YK6Wi5R0/UlDEg7S6926B4p/sUWmCL6+VukNuM//S63Fgoz5iILyl50H2+TzbZHtQXeOLMeCSaUJXD+Llb2fqdwFKk584NnYvl5bJ9dphRGJ313k7O4G3PVq3VVh7JQpKpXE+kK+fhhSTeOHOBS3L3cV1eRafDjMeWjCQFQ4RtALLjlWsSXS0SWIeOeCX7D1wMDuf/31xETZdTJ+cJwREMTnEuZbG0OmdUYykggnBrc7TnzVQNdp2bSxA7cj/gGUEyZw5dwLoa78oelyWxEcWhJ8E1ktCbSsWNYc+DX8ZFI7l+3iHK8ffyi5E3OByYQajVix1f7MTMxYAEb4HBgla7S8OJQVeJA/wtmsv1TubQ7zFWYDT4GLBjBSd+CWCDagnuvdMsTqFnrImSnrgQvIjfVTPwS9IBvFFGHjAGwo9QlrQoHIRSJkAnM4uykPNRHKGtcXyqHh9+3ZQfnUeTH9+1ZiBz7DiwvjeHlAnE18W4XFMR9BOtr9huWp48l9SDQ7BXGnza1LyUN/5TdHerXtZC4HMFBo0n720HSoVXfnWh+VTsqKnfz+LTI0+DB2zGqCYeg6BQcbNHoYvdiCyNC83LFcEb5X9c9R3wdDr+yATdRQ1JIw9VUTGenxljy+Q+Cn5P6gcW/H+atI93+MBlebT4po9CMU66i0hbB/scHbM+rS0nTyrmzwcwCIA5gjV2uOoEmzXI4rvtSE5TY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXQ2Y2pEcmtBYjlIcWNBR3FaMm9lbUhDTEVXY0l4Q1hoSURVYlhpQTZKMW92?=
 =?utf-8?B?Z29SYkdCOWtSZ0dqNldGR0xTeUorcEw2clFSbFdKa2lTMXU0ZWorSXFaR3oy?=
 =?utf-8?B?d01iTFBIVDNuQThVblZQMXFoU2N5RmlVWTRVbE84NXZScE9uNGNNWE9oaUYy?=
 =?utf-8?B?SEFYM3Y3VXNsRlBSL0Z5R0ZnTmo2T2s0RVoyS00xaktrVmo0SGJwQjg2dHFJ?=
 =?utf-8?B?L2g4Y0gzbW53a25yV1o5bkNrRGtLczUzN1AzSE8yelF1K2hwYkFYc3poWWJ1?=
 =?utf-8?B?UjJTZzBqdkl4RG5BUVFhYnpTbjd6d3kwVW42QzJNdWprWjRIVzh0S1hNK2dC?=
 =?utf-8?B?enIrS012enVhdjQ5SzB5bEVZOTdUV2ZseW1HSklqNFVMY0cyaUVLVmFhRlhM?=
 =?utf-8?B?cWNpZDloLzE3LzZEUGRUMk5SNVpnZ0VabHJZa1NMNDdyMjZtVnNteitXNXpI?=
 =?utf-8?B?enc5WVJIL3psS3Q1T3hUbXptOE9UNXkxVnV5QlNpVWF1VlZLa0ZPcnJuUmxG?=
 =?utf-8?B?VHJYUmlGcThsZENJdmVBLzB6TVRkMVNOTGN1TWJvRGI3UFdQWkdLeWNFVEY4?=
 =?utf-8?B?eVArVjI2dTRha0xBVUZSTkVFTktObnlFUmpoRnY3RnBRMlZSdkN2TzVqSnMx?=
 =?utf-8?B?a25zbEx2MytycGIwSTJUSXY2b0NYYlEveXVhdVd2RzlUVTVVWUJkZU5pRFdW?=
 =?utf-8?B?Qnp3VmYxNUVqa28vWFlsVWNQbUJoaHBoVTlDaHIyTTFOMWhIUDNNWWhvWE5u?=
 =?utf-8?B?WUdSV0FMajRocnFmWUl5VkR2SjZtOTU3ODFaUDhZbnBOM2Zrck5qZDdFOGV2?=
 =?utf-8?B?Ym1pVVErMkdzWnhQblB4bUU2WDdtYXpYSjVURnhJajZVRGNSNVdEQnMrMWJu?=
 =?utf-8?B?TGJ1S3ZOYnh4ellFZDBtdGJxM05Gb2ZibzRndS8xS0J5dmdtMTM3UXRsRHJP?=
 =?utf-8?B?VkZvMGc3aTRNSjdkWXJvUTRtNndZbC91RllXc0NNdTZ4WnM2K3RmUTlpQkZC?=
 =?utf-8?B?WC9WLzRObXFNVWJLOEF4RUlBUHJwY2huTFlteFFna2l2WjlVVWxPenhWSzJI?=
 =?utf-8?B?aStkSUkxWHZtaUpBVFIzV2RmT1JBKzlwaUxmM2FVSkxkempmM3lOM3dhdmdE?=
 =?utf-8?B?VjRMYkJ6OHgybEdyMGxQN3hLMWJrU0RGalB5bTBPNDA3dkxKMFR2OG1Eeno0?=
 =?utf-8?B?Rm1DbCtJZUpjUlhsMndxU0ZwM3V3aVVENVkyQjMvYSt2ZUljOHpkek1iU3dV?=
 =?utf-8?B?Qi84MVZNTElWRU1NblVvUkIrSlJpL29UR3BKZ2dUUWFwMXloK2hSbExrbTZC?=
 =?utf-8?B?T0lKeFdqQms3emJwNlUvclNwYUQvZFdoeGlQZXpHNldVNW4wdDFTYzBKeGhY?=
 =?utf-8?B?NVVuRHVubGFndW5IdEMvRG9TSDZza0FjRG1kcnRyRUtNRXpIcVd6dmhTcVY5?=
 =?utf-8?B?N0tCc1lmeTIzblFWZG5BK0dKTHJDZ0xMdHpSSEpOYUs4SGpxVlVQNkxOSUlo?=
 =?utf-8?B?NTRxd1lkdXZCUG81UlBjcmw1TzZTVjJqUFB0cyt2RW5PblF6elRTNHk4MCtu?=
 =?utf-8?B?RjAzTHB4WENHUXJCQUlnZGVpTVVjcnY2dVZ3WG9yZ0tUSzRjMk05ODRVUlZK?=
 =?utf-8?B?eFVMNm5lSE1uNUFVWkVjTnE5NFVnZjI3Q3d3WE1JNFVySGh1MmlWS1dqQWFk?=
 =?utf-8?B?V0dvOVlKZEMwK1lSbGs5RDEyNWF3NDFBbFVxSnJoU2p3dE5DZGZzTVZkOFF1?=
 =?utf-8?B?aDUwTmFxemIvZ0k1NGhsWDdJeG44M3FYbDJ5L1JuSXd5VFJmRndadDlxOEpY?=
 =?utf-8?B?NUUvUzNXU3ZsZjNaS1RQRE9WWVArc0psQ2RVR0Y4VGRKdVRDZUNWVitrZVpM?=
 =?utf-8?B?WERVMGNTY243TU54Q1g1bjJmRkgranIyYWpkZDBsK0szR1UwbWV4RHk1RUs3?=
 =?utf-8?B?RGxyVGppSUJibFFwWjN0a3lSd0d0elNzcTFYeWJ1Nzh1K01JZU9FYTBPSVQ3?=
 =?utf-8?B?Tlo0K21NM2p3akVRREpjbmFQVXJYVVRwSnJ6YTJHampIS2UzaVdCYkJHcjlD?=
 =?utf-8?B?cHdKT0tQR0FobG02TUExbm9SVHdJWnFNVXJUNkhxRE1ISWJ6QjZrSENSSDd0?=
 =?utf-8?Q?HCOzuu55wH384wbP9hfCR4gP2?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f41b1b-e566-4309-2d46-08dc3ca995c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 00:17:03.9192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wXtNuQ1miGY9eBCeg/WZeponaUlXUxXtNxR/Tgs0PheAQROnPXMx76WmL7QPvcvPcOYpn3VuFy4KSvyTFz3eEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8155
X-OriginatorOrg: intel.com

PiA+ICsgICAgICAgICAgICAgICAgICAgY3B1ID0gY3B1bWFza19hbnkoJmQtPmNwdV9tYXNrKTsN
Cj4gPg0KPg0KPiBjcHUgb25seSBuZWVkcyB0byBiZSBhc3NpZ25lZCBvbmNlLiBIb3cgYWJvdXQg
aW5pdGlhbGl6aW5nIGNwdSB0bw0KPiBucl9jcHVfaWRzIGF0IHRoZSBzYW1lIHRpbWUgbXNyX3Bh
cmFtLnJlcyBhbmQgbXNyX3BhcmFtLmRvbSBpcw0KPiBpbml0aWFsaXplZCBhbmQgb25seSBhc3Np
Z24gaXQgd2hlbiBtc3JfcGFyYW0ucmVzIGlzIGFzc2lnbmVkPw0KPiBJIHRoaW5rIHRoYXQgd2ls
bCBiZSBtb3JlIHJvYnVzdC4NCj4NCj4gSWYgeW91IGFncmVlIGFuZCBkbyB0aGlzIHRoZW4gcGxl
YXNlIGZlZWwgZnJlZSB0byBhZGQ6DQo+IFJldmlld2VkLWJ5OiBSZWluZXR0ZSBDaGF0cmUgPHJl
aW5ldHRlLmNoYXRyZUBpbnRlbC5jb20+DQoNClJlaW5ldHRlLA0KDQpJIGFncmVlLiBJJ2xsIG1v
dmUgdGhlIGFzc2lnbm1lbnQgdG8gImNwdSIgb3V0c2lkZSB0aGUgQ0RQX05VTV9UWVBFUw0KbG9v
cC4NCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQotVG9ueQ0KDQo=


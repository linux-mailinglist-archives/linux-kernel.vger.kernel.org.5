Return-Path: <linux-kernel+bounces-24123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A69F882B7E3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 00:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96BC31C24AA3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 23:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEB458AD7;
	Thu, 11 Jan 2024 23:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hWx9AKKN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051A857870
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 23:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705014879; x=1736550879;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zLSbfmOKtTJQzkSVXkqyMbslcc2a1ocjfVtNhe6RJaQ=;
  b=hWx9AKKNYeYzDMe+Mkxr7iEUkEQaEupv9iYXL7p4DA3e2c5zbmYCdYU4
   sCHrbCyXsXo2qxHfz105TEfgQrCmgRZ+igzoA+PaL4T4JPpVhN6uKJLPR
   0Li3VIBGm2HjbNJ1Z63Rk6ShBx6P9Qz/UkHHkucrYk6OFJZEGsM+sszdA
   Vu0NFbVejX6xGLZ2di357u3jRuFjyg/4pIxvPo3auQvcP8tDSHSpOxu71
   /1RfAV0LJx8WJTlkVAklBczuEMvTrMs5vX5eIvH9GO1KVhQgrYsALIXD1
   71jsKlS34c7A+onubuvK9qOpsLNRXcwIlxWNC2hb+9r8Co0nLg5LB0cBS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="20492962"
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="20492962"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 15:14:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="17198253"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jan 2024 15:14:38 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 15:14:37 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Jan 2024 15:14:37 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Jan 2024 15:14:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhvfLH/1rr+OTIV8AGTX5+9HhB3jsWtKo3JxAAfq0SMdvQcKdqLDPdf5DENwbUml3bQ2LpCUHJHGBKw+A4i3d16SL98SgjV7Mxa3wxvAkE7jRaAalB6Ax0CjEweWQMROtlXUjMc2KOY/yrR4t8GplTbv/SAxNhwqjziW5OSav8v/SkuhDQlYMKdtTbDlt73yatAvQBh0m548HhiapClUC75uYywjdYqf7qp+ehBvUL2ulgXDoBZFnjnOuEVVF4R88tBMEF5Feg84AdR6IjSZbrXEZOBsGpIVMEQjMFOBT/FLgYYosY3a9S2xDPIxMcHMCq9heu0Q6CMVb96cXpEZIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLSbfmOKtTJQzkSVXkqyMbslcc2a1ocjfVtNhe6RJaQ=;
 b=iWpNOztlsDRLlVKYlfjiS8dTkG6pckq4w+yfEUqJDTe6qmPWHxlE6mI20rOXSyASquEVq4bLlVR8mc/yQ0JxIKsM9HDKGq+7Mzah3CHB1DT22T4S0NX9WwIoXe25kXkbc+JbE/zBkHbKkintl9WnaQPJu/cLCzGcR8vLfWL/JXDB5fwl8pAnYDqMkOT5/BDDfmeK+MoLC/IuwPSHxa50frfaZ9wC6sv80+l7IBQnewoc4mwRW+NkK3xbmKktOSGjMDFBDsG/fzdv7vmXtjpYNYW2jjLWnnwyK0rElwVK6d/aYF3hZ9PogROiaUo1Jru2T+XYEZYg3yKvbmA9KeUL2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CO1PR11MB5010.namprd11.prod.outlook.com (2603:10b6:303:93::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Thu, 11 Jan
 2024 23:14:35 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a136:fb19:acde:7670]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a136:fb19:acde:7670%7]) with mapi id 15.20.7181.015; Thu, 11 Jan 2024
 23:14:35 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Chatre, Reinette" <reinette.chatre@intel.com>, Peter Newman
	<peternewman@google.com>
CC: Amit Singh Tomar <amitsinght@marvell.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "Yu, Fenghua" <fenghua.yu@intel.com>,
	"james.morse@arm.com" <james.morse@arm.com>, George Cherian
	<gcherian@marvell.com>, "robh@kernel.org" <robh@kernel.org>
Subject: RE: [EXT] Re: [RFC 00/12] ARM: MPAM: add support for priority
 partitioning control
Thread-Topic: [EXT] Re: [RFC 00/12] ARM: MPAM: add support for priority
 partitioning control
Thread-Index: AQHZ0T6XikHFu8Y0uEe4Hq2FndRcXq/2Si6AgAH9QACAACj2AIAADSIAgACwfACA3NDSAIAAEhWAgAAQ0TA=
Date: Thu, 11 Jan 2024 23:14:34 +0000
Message-ID: <SJ1PR11MB60839C1BA84823B44376B90AFC682@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230815152712.1760046-1-amitsinght@marvell.com>
 <f0e10f31-8571-baf6-6665-b077af067777@intel.com>
 <MW4PR18MB5084D5EEBC450BD66E8063E3C61FA@MW4PR18MB5084.namprd18.prod.outlook.com>
 <6114c8d0-97a1-be54-3e43-30348be38683@intel.com>
 <MW4PR18MB50847032F3ACFDBDBCA6D57AC61CA@MW4PR18MB5084.namprd18.prod.outlook.com>
 <be51596e-2e62-2fb9-4176-b0b2a2abb1d3@intel.com>
 <MW4PR18MB5084EB7DBE4985D981FE84F2C61DA@MW4PR18MB5084.namprd18.prod.outlook.com>
 <CALPaoCgjFKtTtgrh2UwEsX0DsVnmRF2+8LS4CUdSLjMPmLVgMA@mail.gmail.com>
 <ZaBgUOQ3iWs3hLrb@agluck-desk3>
 <1daadc08-57e9-40b6-9a34-cfe47d368348@intel.com>
In-Reply-To: <1daadc08-57e9-40b6-9a34-cfe47d368348@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CO1PR11MB5010:EE_
x-ms-office365-filtering-correlation-id: 715d8747-2259-48ca-db56-08dc12fb134d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eFnqWimvyiuDGgX2CWDzyQRAGFqqZqgzGtAwfrC9ZIonG2YhoEJhC8jK4bh+0q0yOJUs4tO3S3zHUWhlIj0tGu0vvdLFy/gqjk+rUukQuG2o03ZOZXg9EkriMuKmzxmbeovD5Yx0O3FXR+AKxmUFitl0gFBPDKKyGlpUO4vbyQ59K2oqEaftMeUhJmYH7y5JuBh5/1RAMDl/zqv7m79DMn8ocfW+a0L7pXrYtUIRhr0Jwa3LccKtfe53aJY82nVjq7ZaTmtBkfSjH+gusbZ5z/ppAaLSOVeY/15+WYTDSOSISEwXQ+diKn4UoKEkDuDY28vFGUUZavMUviqmtX4OnKTz6q1/ZNP/QLDqVBDIh8AdFbiGt19tzR3bIeUWFvcER3pGBsY0YTX7NGavR3lcZSaVw2+72SZwfBGqQiFgH3RuaK9nylbD5T8de0Ei0yd0mOedku8oebVCz8TVob/coTDwMylHq9r8g2AhSsDjmTY/B5dyLbflBnD5nafdk2M5yxqKLfotNFr/+AKCiatgvL7ksuzgwz+EOs41peCmxZGTo3L+53vYQEsTn5s4VpVx1iklvI66FtgtQa1z1HYtve64Ggih+P2Hpz3dw8HWUku9f+UyyvBBPjciv2OiA0kN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(396003)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(55016003)(110136005)(82960400001)(38100700002)(54906003)(478600001)(66946007)(76116006)(66556008)(8936002)(66476007)(66446008)(64756008)(4326008)(52536014)(316002)(9686003)(8676002)(7696005)(6506007)(122000001)(71200400001)(5660300002)(38070700009)(26005)(33656002)(2906002)(41300700001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aklycmtvQ3IzeHZLTXQxYjRsMUNUWUEyTnFvTGRwL3AwK3pEMWRSU2NzUE1D?=
 =?utf-8?B?cXR3T0UxYWtNQzRNdHcrMUlUYzJUdlhOeDBoQnd1NjBBeVpKVkpNR3hLYlpz?=
 =?utf-8?B?U3ZXZTVnSlhZQy9QaWRhUUlkK2lQNDIrQ2ZYUnVRS2NnazcreGt2SnY1cjB1?=
 =?utf-8?B?c0NFemNyNTlMWFo1MExFWkhETjdHS1hoSkc5Um5oWTcxd0RvK2dPSDR0TnU4?=
 =?utf-8?B?Q3FKNHVwRWZIeC9Jc0h4SlhZVFhlTkg4ckZYSFJ3QUFSVGZLMTZENzQvL0Rs?=
 =?utf-8?B?TUZxNE9GQy9wdzkyUzBxMVY1WUtMbUFoU3poTGxzQXZnaEVYajJIUXF6ZkpJ?=
 =?utf-8?B?eXRqMStyalRuY21vK0gwRStmV2VXWGU1YzhKNHR3YjY1YXRwc2RtZkNqdFdG?=
 =?utf-8?B?MnhLSEJrN3pva2xBWFFVMm9OQVgxUWJjNVl4aFBURGJzekxzQWJyRXFPOXhU?=
 =?utf-8?B?Rm54S3hEWUNUZitHL25iZVYxTzdiWjIrS29qUExYYU1aNy9nNURZOVVwNDBp?=
 =?utf-8?B?VGs2NHVUOCs1b2RDN092WkdsbGlNVEx2cWR2N1U3ZFArcm83QnFlNXI2VmJk?=
 =?utf-8?B?bnVrcjRHeU5leFZZRXFJRHNFM0FoRlFCeFUwbEY5ZlZSZFlNSk4vKzA4VURn?=
 =?utf-8?B?Q0NMRE11UmFpUGZCSSsvcm9TSGRSU0pLa0JaU1lIUGtoZFJHSy96NWJUekY0?=
 =?utf-8?B?dFVqVHhHSENUZ1JyMFJITDl4OTFXZ1dFZ3g4aThuOHJ6bXcyYWZVRHdENi9J?=
 =?utf-8?B?cDFTc1d1c2dJMlYyYzlFaklGaHhMcEpleWhhaitIVnJYa29BRWxCbGhsWUpN?=
 =?utf-8?B?YjQ3SDdFeG04cUF3aHUwM1NyTmhJNUFucmgxY3lIOC8zaVludlBtM21rT3dz?=
 =?utf-8?B?ZkYycUdjK1lMNnNkaTVRU09NZGtULzlEK3RLN1I4ZFpHYXZZMkZYM3FUQng1?=
 =?utf-8?B?Qk5IWGxmWnJaM215K1htYnpYWUpZMFlyNk9JNGpFUHpkM0U3VjBTQTMwclZF?=
 =?utf-8?B?Z2xIcWJRRUVOOTA3YnhLZWFDdWdKMjZMZTk1SGlMa1F6QTRjZHpaajVGWm1r?=
 =?utf-8?B?SGlMUmY2d250dDBZbFh0a3gwanpIeVZFUHkzZmxJOWN0b2NvN0xrRTcxOGh6?=
 =?utf-8?B?dnR2anlWa0RsREoyN3VyUjZKWit1UjN4Q2lSQXloVC9yWTVsUnRTM0F2b2ZE?=
 =?utf-8?B?ZXFibU5EYWRJUVhnNTV2emltbFdvOSt4UzVsblB1eFZMZjhGZExsMkIxbGJk?=
 =?utf-8?B?UUJhbm4zSitHWlRCNFNCRVN4RHRiNVlTUzN1RFZQakJxSERYcjZ0L01aZEdP?=
 =?utf-8?B?alh6YjdXWVYrU1lFeXlTMXdZOE9JcXpicmkyR1V0eUFtV2xvbE5tU0trdTlL?=
 =?utf-8?B?eTF4aTZ3TE95WWlRSDFVRmc3eUN2WGZXNVF2MTVrb3hLT0NWQmRIaks3eGNO?=
 =?utf-8?B?cXNFMmJEV1FtZFJrekdPWGNMbnVLa2lFdXI5NnliOTN0Z2laVGxTcFh4L016?=
 =?utf-8?B?eXE0Z1Z0ZFpvTzhXazBQQWtwVFhJcjk3OWFySTlxR1ppVVl5Ujc2QzduNHRj?=
 =?utf-8?B?UW93elZVbzZ0clRrTHFydEpNcGlDWnc0MnBOdlZUMjlyVnlDbFNsUmxIZEFk?=
 =?utf-8?B?OStZYWUzbUticlFhK1hsQVYzcnl1Z1lXN1E0UW5ZRVZMQmo5dHR5VEZmK3pW?=
 =?utf-8?B?ZUVTZXVFUUZIZE5GdDJtMzhMVHBRK0YvSTB2OC82VTBNWmN3bmczVXo0Y3RU?=
 =?utf-8?B?S0ZZV0QrK0hFVDdVZHQrWXdpTU95WEhwWGZ4WkxFOHR3ZGIzQ1ZGaDdZN1hR?=
 =?utf-8?B?dmR5cllCTXZEOHNMWk9iRzhhQVF5Vy81b3QxNWRNa0I3RWFlb2sxR3lGUWJj?=
 =?utf-8?B?cXp5NVpFdWZSWjhJcnozTjlScTIranp6OUdtQk5XVUpRdjhVWkZ3bTBobi80?=
 =?utf-8?B?bkJKYU5TY2UzTWVZL3d6K3RLT2hwQjVPR2g3QVpBblJzZ0dLeVZJVUVVd3hr?=
 =?utf-8?B?eHVBN2FiOFpJSk1FQlIwMUlLZDF0cFNqK2lLbW5CeXVkS29obk1oc2dCMlpW?=
 =?utf-8?B?T2pjaFlsdWdUYUxleEpzdDhXM1ZzTUVLbDBwazJWT2lLZk1Qb2cvNHMxK2Vp?=
 =?utf-8?Q?/egwarR5KRsvICykvNdNezZI9?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 715d8747-2259-48ca-db56-08dc12fb134d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 23:14:34.9313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CFcHfCs37Q5Bc7LkeTlT+VcKDrJ9z8kxPgY2SP9eX4mk15hDnLdSognKhcK8/Ohi3HwDuQ8h4XJ5+XjPPycLCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5010
X-OriginatorOrg: intel.com

Pj4gSSdtIG5vdCBzdXJlIGhhdmluZyBtdWx0aXBsZSBsaW5lcyBmb3IgdGhlIHNhbWUgcmVzb3Vy
Y2UgbWFrZXMgYW55dGhpbmcNCj4+IGNsZWFyZXIuICBJIHByZWZlcnJlZCBvbmUgb2YgdGhlIGVh
cmxpZXIgcHJvcG9zYWxzIGxpa2UgdGhpcyBvbmU6DQo+PiANCj4+IAlMMzowPVhYWFgsUFBBUlQ9
WCxDQ0FQPVg7MT1ZWVlZLENDQVA9WQ0KPg0KPiBUaGlzIGFzc3VtZXMgdGhhdCBhbGwgdG9vbHMg
KHB1YmxpYyBhbmQgcHJpdmF0ZSkgdGhhdCBjdXJyZW50bHkgcGFyc2UgdGhlIHNjaGVtYXRhDQo+
IGZpbGUgd2lsbCBiZSBhYmxlIHRvIGhhbmRsZSB0aGlzIGFkZGl0aW9uYWwgaW5mb3JtYXRpb24g
c2VhbWxlc3NseS4NCg0KUmVpbmV0dGUsDQoNClllcy4gSWYgdGhlcmUgYXJlIHRvb2xzIHRoYXQg
KnJlYWQqIHNjaGVtYXRhIGZpbGVzLCB0aGV5IHdpbGwgYmUgc3VycHJpc2VkIGJ5IHRoaXMgZXh0
cmEgaW5mb3JtYXRpb24uDQoNCkJ1dCB0aGF0IGFsc28gYXBwbGllcyBpZiB0aGUgImV4dHJhIiBp
bmZvcm1hdGlvbiBpcyBtb3ZlZCB0byBhIHNlY29uZCBsaW5lIHRoYXQgYWxzbyBiZWdpbnMgd2l0
aCAiTDM6Ii4NCg0KVG9vbHMgdGhhdCAqd3JpdGUqIHNjaGVtYXRhIGZpbGVzIHNob3VsZCBiZSBP
SyBhcyBsb25nIGFzIHRoZSBrZXJuZWwgd2lsbCBzdGlsbCBhY2NlcHQ6DQoNCiAgIyBlY2hvICJM
MzoxPWZmZiIgPiBzY2hlbWF0YQ0KDQpFLmcuIHRoZSBMaW51eCBzZWxmdGVzdHMgaW4gdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC8gc2hvdWxkIHN0aWxsIHJ1biB3aXRob3V0DQphbnkg
bW9kaWZpY2F0aW9uLg0KDQpUaGUgInNlcGFyYXRlIGxpbmUiIG9wdGlvbiBjb3VsZCB3b3JrIGlm
IHRoZSBwcmVmaXggaXNuJ3QgIkwzOiIuICBFLmcuDQoNCkwzOjA9WFhYWDsxPVlZWVkNCkwzUFBB
UlQ6MD1YDQpMM0NDQVA6MD1YOzE9WQ0KDQpJZiB0aGVzZSBvcHRpb25zIGFyZSBhc3ltbWV0cmlj
YWxseSBhdmFpbGFibGUgb24gY2FjaGUgaW5zdGFuY2VzLCB0aGVzZSBleHRyYQ0KbGluZXMgd29u
J3QgaGF2ZSBldmVyeSBMMyBjYWNoZSBpbnN0YW5jZSBsaXN0ZWQuDQoNCi1Ub255DQoNCg==


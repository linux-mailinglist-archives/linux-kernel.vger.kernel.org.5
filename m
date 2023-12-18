Return-Path: <linux-kernel+bounces-3434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 968D9816C2D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0679C1F237C5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9831A59D;
	Mon, 18 Dec 2023 11:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a5KMeEed"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1291A594
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 11:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702899164; x=1734435164;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qgszrdGhaF4C8nxsh5SrxhCkPw8n3Wr+u8IyjGcMjSQ=;
  b=a5KMeEedkoyLFUJWT5uvroPG6mO2WzyXqKxGO+sL7XM4U2xhpRe6WtoC
   3ChWmfuU2cPakMXMXlztzx230vf2Kseg5luWn96Wa17aprj5l769zOi0L
   yREIgkhemd2FOI2s8EiTNpzIGuDRyXLomXc/SU3EDWiFrUoyHXRlfWtTI
   rh4VEQqx8mYkiRXyj/MKhdcf4x8mTizWpzBQT3j8LkgB1BgYT8aL12wgY
   2nwnkMQhQy2AqL9426SENnJ0wfSrzk2NQ3iV3FTjjzWqLpf8oh447C9Zy
   jEZEqxRwOXLM0ZUzfX0LUxnmRnAk0B96bzYYSfQw3ZanDtB5gGhcsX/fu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="385916826"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="385916826"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 03:32:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="775548435"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="775548435"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2023 03:32:43 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 03:32:43 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 03:32:43 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Dec 2023 03:32:43 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Dec 2023 03:32:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1nq2tNDGqOqpbJH0QYD5fTlaUaN1CDhci+4gF7iFk8UoN8VSlMP0p42ABaDWov/z3lTsFAGRnNSKsaAdcq1QkxjF0XJtQC0auW2BUxbZH/UbyV2uorjMcedtoKxe2bsbuePU/ioDOAiTZ84tUucs2PD0ZfxrdPQECj0WkwO460FMwiuE/B+D5P7y0yMyxSuLbujlcAHvWWIdlFPAcsa3sO3AZFr9AyzzCUJq8t9A1aEv7X6PVz0vgPKrGSSuV9jLAKX3V5VHVlpWbylvoUirnDV3T7uaRo2arzXApiXia9fj5cptPH+mO6rC9z6yiaKfpOontKj8pe+dE77TUs0zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgszrdGhaF4C8nxsh5SrxhCkPw8n3Wr+u8IyjGcMjSQ=;
 b=lsD1tJCJyQOG/UWDers8r60IgEI9tx8NpnLn6bapgxcF6uVIgJNSycI/VeRUOviuYrgcxEsXMdskxm66wJ8SIl/mb1K/yExiK7GEi2H7qcSJKOW3tCbZzYGpMaQH6F6QSFcsO+QbLO4dnGEzNaHF5O7Ua6gfTO6laTj7n4/RrT9353WWuLuaMH1G4QVew+Fd6u4Gg7YsT6LO2WC6buWkHmHUwDd0M+TNEjfKK0n1J+MF30adq5jd/g/nseMWfA6fdpI1nwE1HNqcBCISPcvjlTJpslia5dyHM1BnRw98UKXkJFq2wlsu743P5HcjYQ9hAOtodDh62uFdAzB0TC73Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5907.namprd11.prod.outlook.com (2603:10b6:303:1a1::13)
 by LV8PR11MB8461.namprd11.prod.outlook.com (2603:10b6:408:1e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 11:32:35 +0000
Received: from MW5PR11MB5907.namprd11.prod.outlook.com
 ([fe80::ea3a:1981:2d65:b3e6]) by MW5PR11MB5907.namprd11.prod.outlook.com
 ([fe80::ea3a:1981:2d65:b3e6%7]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 11:32:35 +0000
From: "Prasad, Aravinda" <aravinda.prasad@intel.com>
To: Yu Zhao <yuzhao@google.com>
CC: "damon@lists.linux.dev" <damon@lists.linux.dev>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "sj@kernel.org" <sj@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"s2322819@ed.ac.uk" <s2322819@ed.ac.uk>, "Kumar, Sandeep4"
	<sandeep4.kumar@intel.com>, "Huang, Ying" <ying.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"Subramoney, Sreenivas" <sreenivas.subramoney@intel.com>, "Kervinen, Antti"
	<antti.kervinen@intel.com>, "Kanevskiy, Alexander"
	<alexander.kanevskiy@intel.com>, Juergen Gross <jgross@suse.com>, "Ryan
 Roberts" <ryan.roberts@arm.com>
Subject: RE: mm/DAMON: Profiling enhancements for DAMON
Thread-Topic: mm/DAMON: Profiling enhancements for DAMON
Thread-Index: AQHaLypE0BGAPWFioUOkts0KQWZiNLCqBGAAgAALcyCAAVbwAIADcvDA
Date: Mon, 18 Dec 2023 11:32:35 +0000
Message-ID: <MW5PR11MB590766F7800767BD0DC803E0F290A@MW5PR11MB5907.namprd11.prod.outlook.com>
References: <20231215074619.173787-1-aravinda.prasad@intel.com>
 <CAOUHufZW8ZbNDnu3Cfc61oJ4FkXK+AbT90XpS5Ei++1_5mcFFQ@mail.gmail.com>
 <MW5PR11MB5907BA0C9546C069925C9955F293A@MW5PR11MB5907.namprd11.prod.outlook.com>
 <CAOUHufbDzy5dMcLR9ex25VdB_QBmSrW_We-2+KftZVYKNn4s9g@mail.gmail.com>
In-Reply-To: <CAOUHufbDzy5dMcLR9ex25VdB_QBmSrW_We-2+KftZVYKNn4s9g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5907:EE_|LV8PR11MB8461:EE_
x-ms-office365-filtering-correlation-id: d33bb7bc-6fc9-410d-b37b-08dbffbd0857
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jbso0xPdbVPAZIUiumtrAaiFu9XAOww1AvrnKQnSHhc5jzLm2NJT8OTokAbm1uYRJrbz3CbD66LJVKPe57iSAwj2fZFz/DPxk3l1fHZ1WaIgXKgBvN5eUe5RhRDve08k18jsqVTev/IQ0WYRyFacYBgyZYvmMpwpvmgKennkCDIKop4PVTE+JEkX1yFtdl8yXjkhtQ/yV/a87cYbfoxaOgzC0xVKdI02wNQ55xbN4umMVmDPykqEV+b9VAf/sSirG5Yi1zYqPHFIixpelH2OhwGJlYq41wqutz3JpQz4lLIsYkeDJc/ytQfy/yY1cyHG951Y8O1L4W6V315kXVJTkhWNig4jxRa/M4a2+Vn0R/qxYN+K0qIWnYVXY9O/caQvWFnOettXmWz9+5BO0PLuRMi5AqAH439FcL8YFGHpfwepgdGyll9K5RW7ZHooNMOh4PgVRZIDH1SLy89ne7yGJJv7y61vjDg60roUzHMIXF/tPBBHe1vUL3hCgpGfJzuzF0H5iTSKVeOdTZHLqrVq35Dwv6WGZ+X297nmm2er/oknmpPnCIpIMbeS19X1s5tzh2he5/cCra0ie+fNlv2LhT9+irPTI98c9ESxJXgBkp8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5907.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(366004)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(71200400001)(26005)(9686003)(53546011)(7696005)(6506007)(83380400001)(478600001)(5660300002)(2906002)(41300700001)(8676002)(8936002)(4326008)(966005)(76116006)(52536014)(54906003)(66446008)(66476007)(66556008)(66946007)(64756008)(6916009)(316002)(38070700009)(122000001)(38100700002)(82960400001)(33656002)(86362001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHI3M2IxUGxmUnFlRHN1b2N3Ny9zcDUzREw1OGFOU2R3N3Nqd1RSZU5QanZW?=
 =?utf-8?B?N2xxVUNxQmdFWm5mbDM1WkNGbURtR1lIcnNreVBLcGtzdUx4VUxZci9HdXlR?=
 =?utf-8?B?ZHpCYTFEdTJWVkJuNzNadDlJT2R4b3ZIbGcrQkdlV1JmcmhLZnVHblB2MytH?=
 =?utf-8?B?MWhCL1ovRVNHQ1FKL2x1bUx2NmpHZGFySStlaWpqWEc0SndmMnNtRWRiRjRI?=
 =?utf-8?B?U3dMYTFSZnV6akxpc2tDdFl4Zk9IZ0ZwclkwSWRJbERhNm9hOU4zazJ5UjZL?=
 =?utf-8?B?Rm9lUnZVZ0J0QnY4V1JwZ1ZtenVTenM1NjF2T0RyTDhBUjRVdUlYT3p5cjZR?=
 =?utf-8?B?TzQrSHB4SEN6d1cybkV5S0tCOGZpMEpTUm1RbFlvM0pzSjVGeUFIY090a3VE?=
 =?utf-8?B?MnEwRGNkV0pnMkVBbHpQQ01qSUlCRUE0UG51dm5iTVp2SDhqUmFtcm9iTXN5?=
 =?utf-8?B?ZFBRU3YxNGwyTkQ2eWxMTUJvOFJvUkVVdU1RcTBuSjAyWm9TMGc0ZFZmZnBs?=
 =?utf-8?B?SHZHSk5iMCswN00rTnUySUh3QXdWVmdrS2YxQy92bGZpN2Zja3ErTFpZYU5l?=
 =?utf-8?B?ODhqMXlQeTNyT2c2MFYvTzQvK09HUWJJU2w2MHVGOUllUk9ORFBHSWR6cjdZ?=
 =?utf-8?B?ZHZkS3EyWWJKTXdZcUhyc3pZd2FCbUJUMkZrL1BnTEF2R1JqaklnMHZwYVdU?=
 =?utf-8?B?VVFEdHdicWdUZmM0emZlYnhDWVRHclBLdTB2KzJOM0x2SzJtMXU1ZTlMZ3VB?=
 =?utf-8?B?bnl4VlFtZmpMRnRHMmdmYUlvNXV3NjlqQWgrdGxWVmtWQzY3L2RUZlFCaXNl?=
 =?utf-8?B?dnd4MXQwTnRwbThOUVErMExIS3IxSUxMYitWNVdmNkd4YU0va0NnUElQbk5J?=
 =?utf-8?B?YWowZjFEMHNMSmZFYUs3NzNRMml5WmlLZWYyd3ZVR0hpZ3J1VmVZZWo3S0xY?=
 =?utf-8?B?ZWVSeFEzNURJVVhvdUo5R1FJN2pQcUR5S3hodDNYUi9oVzdjY2hhb1hKc1Yv?=
 =?utf-8?B?cGdjSGVyV0tYUkJMZncwRXk1SDZoS3JLeFJpejZWZ2c0blo5dzRmWWF4dkdE?=
 =?utf-8?B?OWI4RDBoakE4NWdXRm9MbHlpQlEyOVJ5c0RtS3BDS2xoTFFoZDdZOWk2QTA0?=
 =?utf-8?B?ZTZROHFKclUzNG4rUE4xYWtPS09kMmNieEpPbjVyaG1oZmh6V2lvMlBkOHoz?=
 =?utf-8?B?VThDT1lTSHd0Y0JIWTAwWnIvZ1BCWnVyR3ZvZ2RkM0Q0YjJ6UERWaTdmRUlr?=
 =?utf-8?B?Q2srWVZBWEltWUhwQm5NWUw3ODExNGVPMDFHclYzZDdvNW5zMlEzb2txRW9o?=
 =?utf-8?B?b09TdnBXQXcvZFNXT1djWHcxYjgwSWtOaWpPaFJ3SHdPZ1lIdWRBMm5TZC9W?=
 =?utf-8?B?ZVR6Z3pZa1VJYUVEclZNWVQyTFBRZmg4WDFoWUpCQjZHcTZic29lZnkxeTFM?=
 =?utf-8?B?eFl6MlIwbmVRYitlUmJwbE8zeVZvYy9NaTFGYVpvRW9nemludU1CMFBuNk4r?=
 =?utf-8?B?c2lrZ3hjcDhweE10Nm5LVW53WDBYTFo5eUhkemsrMDFIY2RPOGk3Q3h5bGpu?=
 =?utf-8?B?T1JBMTdxdnpBK2hCOW1KV25heC9CT1JrdFhxTnlOdDQxNnRDZ0pNQkdFMWVU?=
 =?utf-8?B?bzlzZnNJdlhhN250aThUU2Vxd1crTVV1eTczSzhFSDV2dHZ3NkphaDlqVDgy?=
 =?utf-8?B?RFo0b1lYcTNUc2U3aWdRT05MVWRobGgxZmlQUmExRU15T0h6NVVIT3hnRE1q?=
 =?utf-8?B?RUFZRkR5M3BSZEtPWTN3cVhUcUFiaFN1RDVwbHRBUm92UUhVRk1XZlVDKzls?=
 =?utf-8?B?OTVNR1c5OWFUaXRER2E5VEFKTkRTZnlDUzNRYVBKSk5jaFBERWY3Z2I4cE9D?=
 =?utf-8?B?NjJBdzA1QlZDTHA0TEhxS01xM0RxTFdVd25UTk53NWhBTFNrbWZoVVB5Tlg3?=
 =?utf-8?B?ZXZscDUrSUNaT0FTUmhHZXRsOEJWZzBhZEhCREtjWHRmd0lDT1ZVTmlwTEVE?=
 =?utf-8?B?TnN4cUVRSGJtREhnaVRyU3RJU2JxendPejlTVitsc00weWU1Rll6Yi9BSWxG?=
 =?utf-8?B?NUtPUHFmdTVwS1J6WkhBVTVMT0lGYk1FRXZWRnFzd0pxMUxoTmQwOGJLMkZo?=
 =?utf-8?Q?uLvdZnp1G0lM3nK42d0zUda1q?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5907.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d33bb7bc-6fc9-410d-b37b-08dbffbd0857
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2023 11:32:35.6385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lozWuLBffbZRriZTiuMBjZHsF4nfJwaIFz8L6q9zXJbtUQKt2sNLrQsRNR7vfrobdKiqLJm55rAzG/KwpqaTOP4+O+KKBSPbfOQXsoPFzoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8461
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWXUgWmhhbyA8eXV6aGFv
QGdvb2dsZS5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBEZWNlbWJlciAxNiwgMjAyMyAxMToxMiBB
TQ0KPiBUbzogUHJhc2FkLCBBcmF2aW5kYSA8YXJhdmluZGEucHJhc2FkQGludGVsLmNvbT4NCj4g
Q2M6IGRhbW9uQGxpc3RzLmxpbnV4LmRldjsgbGludXgtbW1Aa3ZhY2sub3JnOyBzakBrZXJuZWwu
b3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgczIzMjI4MTlAZWQuYWMudWs7
IEt1bWFyLCBTYW5kZWVwNA0KPiA8c2FuZGVlcDQua3VtYXJAaW50ZWwuY29tPjsgSHVhbmcsIFlp
bmcgPHlpbmcuaHVhbmdAaW50ZWwuY29tPjsgSGFuc2VuLA0KPiBEYXZlIDxkYXZlLmhhbnNlbkBp
bnRlbC5jb20+OyBXaWxsaWFtcywgRGFuIEogPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT47DQo+
IFN1YnJhbW9uZXksIFNyZWVuaXZhcyA8c3JlZW5pdmFzLnN1YnJhbW9uZXlAaW50ZWwuY29tPjsg
S2VydmluZW4sIEFudHRpDQo+IDxhbnR0aS5rZXJ2aW5lbkBpbnRlbC5jb20+OyBLYW5ldnNraXks
IEFsZXhhbmRlcg0KPiA8YWxleGFuZGVyLmthbmV2c2tpeUBpbnRlbC5jb20+OyBBbGFuIE5haXIg
PGFsYW4ubmFpckBpbnRlbC5jb20+OyBKdWVyZ2VuDQo+IEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+
OyBSeWFuIFJvYmVydHMgPHJ5YW4ucm9iZXJ0c0Bhcm0uY29tPg0KPiBTdWJqZWN0OiBSZTogbW0v
REFNT046IFByb2ZpbGluZyBlbmhhbmNlbWVudHMgZm9yIERBTU9ODQo+IA0KPiBPbiBGcmksIERl
YyAxNSwgMjAyMyBhdCAzOjA44oCvQU0gUHJhc2FkLCBBcmF2aW5kYSA8YXJhdmluZGEucHJhc2Fk
QGludGVsLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiA+IE9uIEZyaSwgRGVjIDE1LCAyMDIzIGF0
IDEyOjQy4oCvQU0gQXJhdmluZGEgUHJhc2FkDQo+ID4gPiA8YXJhdmluZGEucHJhc2FkQGludGVs
LmNvbT4gd3JvdGU6DQo+ID4gPiAuLi4NCj4gPiA+DQo+ID4gPiA+IFRoaXMgcGF0Y2ggcHJvcG9z
ZXMgcHJvZmlsaW5nIGRpZmZlcmVudCBsZXZlbHMgb2YgdGhlDQo+ID4gPiA+IGFwcGxpY2F0aW9u
4oCZcyBwYWdlIHRhYmxlIHRyZWUgdG8gZGV0ZWN0IHdoZXRoZXIgYSByZWdpb24gaXMNCj4gPiA+
ID4gYWNjZXNzZWQgb3Igbm90LiBUaGlzIHBhdGNoIGlzIGJhc2VkIG9uIHRoZSBvYnNlcnZhdGlv
biB0aGF0LCB3aGVuDQo+ID4gPiA+IHRoZSBhY2Nlc3NlZCBiaXQgZm9yIGEgcGFnZSBpcyBzZXQs
IHRoZSBhY2Nlc3NlZCBiaXRzIGF0IHRoZQ0KPiA+ID4gPiBoaWdoZXIgbGV2ZWxzIG9mIHRoZSBw
YWdlIHRhYmxlIHRyZWUgKFBNRC9QVUQvUEdEKSBjb3JyZXNwb25kaW5nDQo+ID4gPiA+IHRvIHRo
ZSBwYXRoIG9mIHRoZSBwYWdlIHRhYmxlIHdhbGsgYXJlIGFsc28gc2V0LiBIZW5jZSwgaXQgaXMN
Cj4gPiA+ID4gZWZmaWNpZW50IHRvICBjaGVjayB0aGUgYWNjZXNzZWQgYml0cyBhdCB0aGUgaGln
aGVyIGxldmVscyBvZiB0aGUNCj4gPiA+ID4gcGFnZSB0YWJsZSB0cmVlIHRvIGRldGVjdCB3aGV0
aGVyIGEgcmVnaW9uIGlzIGFjY2Vzc2VkIG9yIG5vdC4NCj4gPiA+DQo+ID4gPiBUaGlzIHBhdGNo
IGNhbiBjcmFzaCBvbiBYZW4uIFNlZSBjb21taXQgNGFhZjI2OWM3NjhkKCJtbTogaW50cm9kdWNl
DQo+ID4gPiBhcmNoX2hhc19od19ub25sZWFmX3BtZF95b3VuZygpIikNCj4gPg0KPiA+IFdpbGwg
Zml4IGFzIHN1Z2dlc3RlZCBpbiB0aGUgY29tbWl0Lg0KPiA+DQo+ID4gPg0KPiA+ID4gTUdMUlUg
YWxyZWFkeSBkb2VzIHRoaXMgaW4gdGhlIGNvcnJlY3Qgd2F5LiBTZWUgbW0vdm1zY2FuLmMuDQoN
Cm5vdGVkDQoNCj4gPg0KPiA+IEkgZG9uJ3Qgc2VlIGFjY2VzcyBiaXRzIGF0IFBVRCBvciBQR0Qg
Y2hlY2tlZCBmb3IgNEsgcGFnZSBzaXplLiBDYW4NCj4gPiB5b3UgcG9pbnQgbWUgdG8gdGhlIGNv
ZGUgd2hlcmUgYWNjZXNzIGJpdHMgYXJlIGNoZWNrZWQgYXQgUFVEIGFuZCBQR0QgbGV2ZWw/DQo+
IA0KPiBUaGVyZSBpc24ndCBhbnksIGJlY2F1c2UgKnRoZSBzeXN0ZW0qIGJvdHRsZW5lY2tzIGF0
IHRoZSBQVEUgbGV2ZWwgYW5kIGF0IG1vdmluZw0KPiBtZW1vcnkgYmV0d2VlbiB0aWVycy4gT3B0
aW1pemluZyBhdCB0aGUgUFVEL1BHRCBsZXZlbHMgaGFzIGluc2lnbmlmaWNhbnQgUk9JDQo+IGZv
ciB0aGUgc3lzdGVtLg0KDQpPcHRpbWl6YXRpb24gYXQgUFVEL1BHRCBjYW4gYmUgdXNlZCBmb3Ig
bGFyZ2UgZm9vdHByaW50IGFwcGxpY2F0aW9ucywgZXNwZWNpYWxseQ0KZm9yIGRhbW9uLCB0byBm
aW5kIGlmIGFueSBwYWdlcyBpbiBhIHJlZ2lvbiBhcmUgYWNjZXNzZWQgb3Igbm90Lg0KDQo+IA0K
PiBBbmQgZm9vZCBmb3IgdGhvdWdodDoNCj4gMS4gQ2FuIGEgUFVEL1BHRCBjb3ZlciBtZW1vcnkg
ZnJvbSBkaWZmZXJlbnQgdGllcnM/DQoNClllcywgaXQgY2FuLg0KDQo+IDIuIENhbiB0aGUgQS1i
aXQgaW4gbm9uLWxlYWYgZW50cmllcyB3b3JrIGZvciBFUFQ/DQoNCk5lZWQgdG8gY2hlY2suDQoN
Cj4gDQo+ID4gPiBUaGlzIHBhdGNoIGFsc28gY2FuIGNhdXNlIFVTRVIgREFUQSBDT1JSVVBUSU9O
LiBTZWUgY29tbWl0DQo+ID4gPiBjMTFkMzRmYTEzOWUgKCJtbS9kYW1vbi9vcHMtY29tbW9uOiBh
dG9taWNhbGx5IHRlc3QgYW5kIGNsZWFyIHlvdW5nDQo+ID4gPiBvbiBwdGVzIGFuZCBwbWRzIiku
DQo+ID4NCj4gPiBPay4gV2lsbCBhdG9taWNhbGx5IHRlc3QgYW5kIHNldCB0aGUgYWNjZXNzIGJp
dHMuDQo+ID4NCj4gPiA+DQo+ID4gPiBUaGUgcXVhbGl0eSBvZiB5b3VyIHBhdGNoIG1ha2VzIG1l
IHZlcnkgbXVjaCBkb3VidCB0aGUgcXVhbGl0eSBvZg0KPiA+ID4geW91ciBwYXBlciwgZXNwZWNp
YWxseSB5b3VyIHJlc3VsdHMgb24gR29vZ2xlJ3Mga3N0YWxlZCBhbmQgTUdMUlUgaW4gdGFibGUN
Cj4gNi4yLg0KPiA+DQo+ID4gVGhlIHJlc3VsdHMgYXJlIHZlcnkgbXVjaCByZXByb2R1Y2libGUu
IFdlIGhhdmUgbm90IHVzZWQga3N0YWxlZC9NR0xSVQ0KPiA+IGZvciB0aGUgZGF0YSBpbiBGaWd1
cmUgMywgYnV0IHdlIGxpbmVhcmx5IHNjYW4gcGFnZXMgc2ltaWxhciB0bw0KPiA+IGtzdGFsZWQg
YnkgaW1wbGVtZW50aW5nIGEga2VybmVsIHRocmVhZCBmb3Igc2Nhbm5pbmcuDQo+IA0KPiBZb3Ug
aGF2ZSBub3QgdXNlZCBNR0xSVSwgYW5kIHlldCB5b3VyIHJlc3VsdHMgYXJlIHZlcnkgbXVjaCBy
ZXByb2R1Y2libGUuDQoNCkFzIHdlIGhhdmUgbWVudGlvbmVkIGluIHRoZSBwYXBlciwgdGhlIHJl
c3VsdHMgYXJlIGZvciBjaGVja2luZy9zY2FubmluZyANCmFjY2Vzc2VkIGJpdHMgZm9yIHBhZ2Vz
IGF0IGxlYWYgbGV2ZWwgKFBURSBmb3IgNEsgYW5kIFBNRCBmb3IgMk0pLiBJbiBnZW5lcmFsDQp0
aGlzIGlzIGFwcGxpY2FibGUgdG8gYW55IHRlY2huaXF1ZSB1c2luZyBsZWFmIGxldmVsIHNjYW5u
aW5nIHdoZXJlIGZvciBsYXJnZQ0KZm9vdHByaW50IGFwcGxpY2F0aW9ucywgdGhlIHNjYW5uaW5n
IHRpbWUgZHJhc3RpY2FsbHkgaW5jcmVhc2VzLg0KDQpNR0xSVSBhbHNvIHNjYW5zIGxlYWYgbGV2
ZWwgYWNjZXNzZWQgYml0cyBhbmQgaGVuY2UgZmFsbHMgaW50byB0aGlzIGNhdGVnb3J5DQoNClNp
bWlsYXIgb2JzZXJ2YXRpb25zIG9uIHNjYW5uaW5nIHdlcmUgYWxzbyBtYWRlIGJ5IEhlTWVtIFsy
XSBpbiBGaWd1cmUgMy4NCg0KWzJdIEhlTWVtOiBTY2FsYWJsZSBUaWVyZWQgTWVtb3J5IE1hbmFn
ZW1lbnQgZm9yIEJpZyBEYXRhIEFwcGxpY2F0aW9ucw0KYW5kIFJlYWwgTlZNIiwgaHR0cHM6Ly9k
bC5hY20ub3JnL2RvaS9wZGYvMTAuMTE0NS8zNDc3MTMyLjM0ODM1NTANCg0KPiANCj4gPiBPdXIg
YXJndW1lbnQgZm9yIGtzdGFsZWQvTUdMUlUgaXMgdGhhdCwgc2Nhbm5pbmcgaW5kaXZpZHVhbCBw
YWdlcyBhdA0KPiA+IDRLIGdyYW51bGFyaXR5IG1heSBub3QgYmUgZWZmaWNpZW50IGZvciBsYXJn
ZSBmb290cHJpbnQgYXBwbGljYXRpb25zLg0KPiANCj4gWW91ciBhcmd1bWVudCBmb3IgTUdMUlUg
aXMgYmFzZWQgb24gYSB3cm9uZyBhc3N1bXB0aW9uLCBhcyBJIGhhdmUgYWxyZWFkeQ0KPiBwb2lu
dGVkIG91dC4NCg0KT3VyIGFyZ3VtZW50IGluIHRoZSBwYXBlciBpcyBmb3IgYW55IHRlY2huaXF1
ZSB0aGF0IGlzIHNjYW5uaW5nIGxlYWYgbGV2ZWwNCmFjY2Vzc2VkIGJpdHMsIGJlIGl0IGtzdGFs
ZWQgb3IgTUdMUlUuDQoNCj4gDQo+ID4gSW5zdGVhZCwNCj4gPiBhY2Nlc3MgYml0cyBhdCB0aGUg
aGlnaGVyIGxldmVsIG9mIHRoZSBwYWdlIHRhYmxlIHRyZWUgY2FuIGJlIHVzZWQuIEluDQo+ID4g
dGhlIHBhcGVyIHdlIGhhdmUgZGVtb25zdHJhdGVkIHRoaXMgd2l0aCBEQU1PTiBidXQgdGhlIGNv
bmNlcHQgY2FuIGJlDQo+ID4gYXBwbGllZCB0byBrc3RhbGVkL01HTFJVIGFzIHdlbGwuDQo+IA0K
PiBZb3UgZ290IGl0IGJhY2t3YXJkOiBNR0xSVSBpbnRyb2R1Y2VkIHRoZSBjb25jZXB0OyB5b3Ug
ZmFicmljYXRlZCBhIGNvbXBhcmlzb24NCj4gdGFibGUuDQoNCk5vdCBjb252aW5jZWQuIEkgc2Vl
IGZyb20gZG9jdW1lbnRhdGlvbiBtZW50aW9uaW5nIHRoYXQgImNsZWFyaW5nIHRoZSBhY2Nlc3Nl
ZA0KYml0IGluIG5vbi1sZWFmIHBhZ2UgdGFibGUgZW50cmllcyIgd2l0aCAweDAwMDQgaW4gL3N5
cy9rZXJuZWwvbW0vbHJ1X2dlbi9lbmFibGVkDQoNCkJ1dCB0aGUgY29kZSBpcyByZXN0cmljdGVk
IHRvIFBNRCBvbmx5Lg0KDQpzdGF0aWMgYm9vbCBzaG91bGRfY2xlYXJfcG1kX3lvdW5nKHZvaWQp
DQp7DQogICAgICAgIHJldHVybiBhcmNoX2hhc19od19ub25sZWFmX3BtZF95b3VuZygpICYmIGdl
dF9jYXAoTFJVX0dFTl9OT05MRUFGX1lPVU5HKTsNCn0NCg0KUmVnYXJkcywNCkFyYXZpbmRhDQog
DQoNCg0K


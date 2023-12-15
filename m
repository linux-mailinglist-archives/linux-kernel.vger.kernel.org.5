Return-Path: <linux-kernel+bounces-723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B8181452C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 054351F23B4E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E0E1A711;
	Fri, 15 Dec 2023 10:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gBGxZjhL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9D71A702
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 10:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702634880; x=1734170880;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OZ//dlZMarAXiJy0Xq/LCzxlrHRDc8KwegMf5i2Ii68=;
  b=gBGxZjhL4+8o0iHX/utNNkrfGDN/fqr5lDmEp3P8HBG1UA/Q8sWr68C9
   dZgiGQHw88FvY3aY/Q5D63MompbVrxKwg1MEmQ+1MQBlzZy+tRzYtCi7g
   dxlkOqQ8tRWOtgDjGWH3IpcFTKVVL0s65XKmIuDSkf3G5kI2Dqbja0tmC
   IEaI2aiidUqe4LWMVFQ/LakGGFlyTBfNydY7d8NYxPWBSf9mw3ApqLFEC
   Vj/w9BuQXQe0KnTBurSJWtSS0U4BVjbtPHRqBlmfGE8392hts32EWfXqz
   CiovptSjt4QcwsRtDWGmdcGilYQQAJpaEDnV/cMdOF7VIWhSw6w4SAg3c
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="426388370"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="426388370"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 02:07:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="840609798"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="840609798"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Dec 2023 02:07:58 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 02:07:57 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 02:07:57 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Dec 2023 02:07:57 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Dec 2023 02:07:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BlMYrMjuCwV7Etgv8sMsIN8ewV1BzjPmW6oALWqRmY45bT2suArGlX/inY/Qo/tDfwFvlOqVjVnXZIO9QWwjzhQxQvDEK2rEQ8HAMIspFsOSYMRjlbcM5n0OOaSPRFHMET2qmJEsDqLrDKjn+P2tGgx1KmUILkIvi3JPPzAqfFq8LXRXfqpWX5O9ojWsXpC3w5t0Cm/XOwpAI5ptLWt3s7cW0KZ88mg0r8kkeR3VgLiZMU8fzIFI0NVdL3lzs+Xmj573B20fAIk+pHZyt7Dw0yORKSGSiia1cn0E17bjo2rCfp8fzdBOOH84oz6ccoC4QHGcUQLUGq42M6mDfid/Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZ//dlZMarAXiJy0Xq/LCzxlrHRDc8KwegMf5i2Ii68=;
 b=DmPL1DkX+eg7wuXA+9CiT15uQZ9YREtSxakkqFb9/WiC1JLk7p1BbKOHnX4plMV1immZvSIKHi/a+Doxe/cEEk+fzzLylnp4B1iX9WtUxTnEZcH1iRKU43A607CAL/EJ1pB0nT1OgQxlJuG1zyUuppmqLdUaSEp6oph5W7RO3bSsvneEmxj6PL0o6wLs6qkK95jX3DqSmxjfolrOC/1eUBzoBGh5rqSjCcyd7GMLcD5tRq80ENr3kWFVTwFAJMeHsky/YvsY4lxLYBY3rJ0SgQVsu+WbBi/G0u/pnAYpovwlDYl8BxkI1Ho9vVKTbR6jBuKSlI9eUv25vWAHtXX1CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5907.namprd11.prod.outlook.com (2603:10b6:303:1a1::13)
 by SA3PR11MB7535.namprd11.prod.outlook.com (2603:10b6:806:307::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 10:07:55 +0000
Received: from MW5PR11MB5907.namprd11.prod.outlook.com
 ([fe80::ea3a:1981:2d65:b3e6]) by MW5PR11MB5907.namprd11.prod.outlook.com
 ([fe80::ea3a:1981:2d65:b3e6%7]) with mapi id 15.20.7091.032; Fri, 15 Dec 2023
 10:07:54 +0000
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
	<alexander.kanevskiy@intel.com>, Alan Nair <alan.nair@intel.com>, "Juergen
 Gross" <jgross@suse.com>, Ryan Roberts <ryan.roberts@arm.com>
Subject: RE: mm/DAMON: Profiling enhancements for DAMON
Thread-Topic: mm/DAMON: Profiling enhancements for DAMON
Thread-Index: AQHaLypE0BGAPWFioUOkts0KQWZiNLCqBGAAgAALcyA=
Date: Fri, 15 Dec 2023 10:07:54 +0000
Message-ID: <MW5PR11MB5907BA0C9546C069925C9955F293A@MW5PR11MB5907.namprd11.prod.outlook.com>
References: <20231215074619.173787-1-aravinda.prasad@intel.com>
 <CAOUHufZW8ZbNDnu3Cfc61oJ4FkXK+AbT90XpS5Ei++1_5mcFFQ@mail.gmail.com>
In-Reply-To: <CAOUHufZW8ZbNDnu3Cfc61oJ4FkXK+AbT90XpS5Ei++1_5mcFFQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5907:EE_|SA3PR11MB7535:EE_
x-ms-office365-filtering-correlation-id: dee87908-2eee-4ca7-3c9b-08dbfd55b457
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LTTBYu60cRnpvmkCIbBuVYqv6a0qgrb1T93EUklUNKDdF4Falh97Vk1aC7kPOR0nSNFCVDUDRvVXyh6swPJOw9iiGurqS1ZCSDqXRYzjYbGBahHdnr+kXB1ZFbdBeEQzlnhldDzoPNTOmjWQ+QMjfuwo0b/rokCZa/NeoKvPHgEGy20hG4T88OAcA9lDRmTRBtDYS2EoVAHuyHXW9I8sYk/UPIpK2fK0hUNNzTaqZgd+xPYiutxbTwko/TsgnTI4FUIWj66ZhGzx0SdgqTTnWPpcgJSKsEDtGTXYphnPcekQUAqM2ngSYg7zZ1uL9LehZ55R2jDolgQ9av/ESNDLvVIucMuXozi5VgMv+h9tZbPOFzHsbJ6ns08ZAL32LJpuu/2hBNWjMnkj1J/kkOB3CrbhSfR2l1A2RBcRXGtvITSpV8BhmfDmBKjdEyV+TUlU5VYZ5S2OyKWM1jI8ohfu5YRTyIvs+zWGjbvJuW9P9YicpySh7NL8OvQ405IjEY53jsic0hL2+olrwDFCNBWY9KH+5yPHQ6FrmPDfW5+Njn4kkJe4uDHp6cnP3VUaMounZfOeAgpsRxdaL6GAr81+vVVBnisphGIEh8QJang7wl4QvIIF+D6pNUuKeHU+DOdr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5907.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(52536014)(55016003)(478600001)(5660300002)(71200400001)(82960400001)(53546011)(9686003)(2906002)(7696005)(6506007)(26005)(66446008)(86362001)(76116006)(54906003)(64756008)(316002)(6916009)(66556008)(33656002)(66476007)(4326008)(66946007)(8676002)(8936002)(122000001)(83380400001)(41300700001)(38070700009)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0ZTZVM2NmFJcVZxbnE3NWhGU0hjbGp2Yy82QVJERU13aG9CbHVZYmlVR0JE?=
 =?utf-8?B?cUh3MlN3empMd0hVOVo0NjBCelhHQ0FHUHV5K3Zha3VMQmlGVWowcDdQN0h0?=
 =?utf-8?B?bFdNV3pnRmNBRlFMbnZmaGpDQmFpQUVBbDlwcDliazZFWDQwaFJFMmZicnBW?=
 =?utf-8?B?bGFZTXkrazA0Zlc1WUdXbjZtSkt3ZUUxVCt2MXZ0RGtPZExTa0VwZ2tHVi8y?=
 =?utf-8?B?NlpodUJnanpoR0xPam4vTnJMVzAwOTJWZktNd2tINGFyb3lKaStpS294dTRv?=
 =?utf-8?B?YWIrRVJJZXUySVNUWXRXL2E0SGQyS1hXU0pWS3VwbUN5WXA3L0g1cmxiZ1Vh?=
 =?utf-8?B?L2d4cFZqa0RtMHRrUkhQc1NnUDkveGs1WnhvM0hSSkMvc3JtNVhzZlh0ZTVC?=
 =?utf-8?B?VHJ4TVA3djRBZitLZ09nbHZpSy9uSlZZdjg2WkRFbjJaTmRqR0tGVUVvcjRB?=
 =?utf-8?B?RVJKbXJsMnNPVGlNTUxldnpHUmF5R3cyTEhtcTJROUZ6aUtPc1JkQ3pyNU5J?=
 =?utf-8?B?TXdmaXFabG1nUlQ0RFRreGM2L25jNmE3UFM3aHdKUTZ4eFc2dEo3M3l4b1B0?=
 =?utf-8?B?QzFua0R5L0NCNjJ4NWU5WWl4SGV0NE5VandlZVV1RWkvOTdWSFgzTG5NbThu?=
 =?utf-8?B?Vm9FK21YcUYyQkU1WG1XdmpwV2VZbFp6bnlmZlAxUERzcStsLzdXeXlOSTB1?=
 =?utf-8?B?UVF3TGllU2lLSGF6NDhQSm12U1p4ZkN0VGl5MXprS0dJV1VhaExhSC9uSTFE?=
 =?utf-8?B?bnJ4Mis2bytXYWh6NmhQRzRyTWNZR3RwNnBFVGQ1OGhNMDExaXNMdjRaSGlH?=
 =?utf-8?B?Z1I4K1ZBeWhleDdxMThuakNJalIxaFJvL3J2TFV2QUozdm1NRDZlM1dUQlg4?=
 =?utf-8?B?bzJSekJrMlBFeHVYbld2N0dOYWdRZzZ4V0JDNVBEVHZGN2VCZjljRlozdVNS?=
 =?utf-8?B?ZnlPU0JQZGdTMndyL285dW1XSDdaVFJJV3cxcFlTVVRYc3Z5WHROcUd4TE5Q?=
 =?utf-8?B?OFVYcEZyd0IwTnU2WFVyam9kNGRacytReVBNYVFQemlVYnJ4ZjNibythM25n?=
 =?utf-8?B?aGhjUzdzZVpaSm9GanJvc1RKeVVFbDZoMUpuQmFzVmc5Y1NCd25mZ3Z6K0dF?=
 =?utf-8?B?ZjlwK1hXREh2STNyZDJZU3NZZk9rTHhwYSs2WWlYaGJ3K3ZMcmxOT3dKek9F?=
 =?utf-8?B?UzQ3aDN4YkFWUjBZRE5iSTFCeU9YMzI1LytKQ0RHZEpobHNjbm4wNEk4RjJU?=
 =?utf-8?B?R2ZNdUo1TlRndkx5VGtqV3p5Z25Ua2x2ZDBRWTdSbjZWYThXRmNlMEl0bXpC?=
 =?utf-8?B?Wm9yMjBMSXh4REt5VXZxU3lSK2hpcDNESmZqc2t3QnBsckNLTXdGVy92MmJh?=
 =?utf-8?B?RjR3S1JISXMwSm05R3h3ZnBjcWYyYmUxaDNtSS9UditjNjFqZmNtMnZaYUxS?=
 =?utf-8?B?RVFzWjdJSCtBMkVUV2ZuaWk2N1hSd05vdG1LUFo5ZkdVZU5TNlo3M2dRcTYr?=
 =?utf-8?B?eXRGcDd5YXdOUHlqN1dvSHdpSWVhOG1hYjZWYXdOVUwwa3h3SjVZSjBKYTg3?=
 =?utf-8?B?bFZmV0hXaVBua2NjYjNYTURKU2xkODhRdlFuaFdTRGdqK21hak9wY1JYWHhn?=
 =?utf-8?B?MUt5d0JXYkF0aC9sMDNxYkxyMHp0OUc5RFNSRHNKdzJHVVMvT1VCcDcrWkNS?=
 =?utf-8?B?cFU4NDFjTjJqSDlyT0lKeDJ5Wm5CT0s3YWxSL1JGQVZMQzI1U2FaZlYxallD?=
 =?utf-8?B?R09vc3NnR1Vnc3JMMGxSdWVkUk54TEpISjg4WGhRT0xwaTVaUzM3ODBlZ3ZQ?=
 =?utf-8?B?aXZValJQNnVPRVBMcGx5dDF5ZUpjME5tSW82U3N6MlU5dnhQRkpRV3FjMkdr?=
 =?utf-8?B?UE55NmhqMklxbUk5V3ZzTGdyZWVMejZkZjZqOHN4d3NjYUtTaWJwOUtpNk12?=
 =?utf-8?B?MGV2VVJOa3JIY2EvVEZSRExqRlZWUHBwclh1bEU4WXFObVpOMEpkM0tBY3Yw?=
 =?utf-8?B?SGFpVzE0Q085Tmd4T1ozWDVWejF4V0R5OXFPL2lMSWdLaGwwVzdFcWZYTWhP?=
 =?utf-8?B?MXVCZVRZT3VJaEIzK05ySENKUy9VbTFXTTBVVGYwWm1DOFI0YXVDajhQeU40?=
 =?utf-8?Q?GDDfleF2Ju4zotjnk+a416b2q?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dee87908-2eee-4ca7-3c9b-08dbfd55b457
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 10:07:54.2131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pme7jONlYhL0m0nOb3ELbSxJhOt6Juyp7/zGTi01fQtvK3meTz6d5uhsPubGT6g2Px6oUDvbEuI4qPuNZNrcXntaR7hM5mQbHKa6SLilaFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7535
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWXUgWmhhbyA8eXV6aGFv
QGdvb2dsZS5jb20+DQo+IFNlbnQ6IEZyaWRheSwgRGVjZW1iZXIgMTUsIDIwMjMgMjowMyBQTQ0K
PiBUbzogUHJhc2FkLCBBcmF2aW5kYSA8YXJhdmluZGEucHJhc2FkQGludGVsLmNvbT4NCj4gQ2M6
IGRhbW9uQGxpc3RzLmxpbnV4LmRldjsgbGludXgtbW1Aa3ZhY2sub3JnOyBzakBrZXJuZWwub3Jn
OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgczIzMjI4MTlAZWQuYWMudWs7IEt1
bWFyLCBTYW5kZWVwNA0KPiA8c2FuZGVlcDQua3VtYXJAaW50ZWwuY29tPjsgSHVhbmcsIFlpbmcg
PHlpbmcuaHVhbmdAaW50ZWwuY29tPjsNCj4gSGFuc2VuLCBEYXZlIDxkYXZlLmhhbnNlbkBpbnRl
bC5jb20+OyBXaWxsaWFtcywgRGFuIEoNCj4gPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT47IFN1
YnJhbW9uZXksIFNyZWVuaXZhcw0KPiA8c3JlZW5pdmFzLnN1YnJhbW9uZXlAaW50ZWwuY29tPjsg
S2VydmluZW4sIEFudHRpDQo+IDxhbnR0aS5rZXJ2aW5lbkBpbnRlbC5jb20+OyBLYW5ldnNraXks
IEFsZXhhbmRlcg0KPiA8YWxleGFuZGVyLmthbmV2c2tpeUBpbnRlbC5jb20+OyBBbGFuIE5haXIg
PGFsYW4ubmFpckBpbnRlbC5jb20+OyBKdWVyZ2VuDQo+IEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+
OyBSeWFuIFJvYmVydHMgPHJ5YW4ucm9iZXJ0c0Bhcm0uY29tPg0KPiBTdWJqZWN0OiBSZTogbW0v
REFNT046IFByb2ZpbGluZyBlbmhhbmNlbWVudHMgZm9yIERBTU9ODQo+IA0KPiBPbiBGcmksIERl
YyAxNSwgMjAyMyBhdCAxMjo0MuKAr0FNIEFyYXZpbmRhIFByYXNhZA0KPiA8YXJhdmluZGEucHJh
c2FkQGludGVsLmNvbT4gd3JvdGU6DQo+IC4uLg0KPiANCj4gPiBUaGlzIHBhdGNoIHByb3Bvc2Vz
IHByb2ZpbGluZyBkaWZmZXJlbnQgbGV2ZWxzIG9mIHRoZSBhcHBsaWNhdGlvbuKAmXMNCj4gPiBw
YWdlIHRhYmxlIHRyZWUgdG8gZGV0ZWN0IHdoZXRoZXIgYSByZWdpb24gaXMgYWNjZXNzZWQgb3Ig
bm90LiBUaGlzDQo+ID4gcGF0Y2ggaXMgYmFzZWQgb24gdGhlIG9ic2VydmF0aW9uIHRoYXQsIHdo
ZW4gdGhlIGFjY2Vzc2VkIGJpdCBmb3IgYQ0KPiA+IHBhZ2UgaXMgc2V0LCB0aGUgYWNjZXNzZWQg
Yml0cyBhdCB0aGUgaGlnaGVyIGxldmVscyBvZiB0aGUgcGFnZSB0YWJsZQ0KPiA+IHRyZWUgKFBN
RC9QVUQvUEdEKSBjb3JyZXNwb25kaW5nIHRvIHRoZSBwYXRoIG9mIHRoZSBwYWdlIHRhYmxlIHdh
bGsNCj4gPiBhcmUgYWxzbyBzZXQuIEhlbmNlLCBpdCBpcyBlZmZpY2llbnQgdG8gIGNoZWNrIHRo
ZSBhY2Nlc3NlZCBiaXRzIGF0DQo+ID4gdGhlIGhpZ2hlciBsZXZlbHMgb2YgdGhlIHBhZ2UgdGFi
bGUgdHJlZSB0byBkZXRlY3Qgd2hldGhlciBhIHJlZ2lvbiBpcw0KPiA+IGFjY2Vzc2VkIG9yIG5v
dC4NCj4gDQo+IFRoaXMgcGF0Y2ggY2FuIGNyYXNoIG9uIFhlbi4gU2VlIGNvbW1pdCA0YWFmMjY5
Yzc2OGQoIm1tOiBpbnRyb2R1Y2UNCj4gYXJjaF9oYXNfaHdfbm9ubGVhZl9wbWRfeW91bmcoKSIp
DQoNCldpbGwgZml4IGFzIHN1Z2dlc3RlZCBpbiB0aGUgY29tbWl0Lg0KDQo+IA0KPiBNR0xSVSBh
bHJlYWR5IGRvZXMgdGhpcyBpbiB0aGUgY29ycmVjdCB3YXkuIFNlZSBtbS92bXNjYW4uYy4NCg0K
SSBkb24ndCBzZWUgYWNjZXNzIGJpdHMgYXQgUFVEIG9yIFBHRCBjaGVja2VkIGZvciA0SyBwYWdl
IHNpemUuIENhbiB5b3UNCnBvaW50IG1lIHRvIHRoZSBjb2RlIHdoZXJlIGFjY2VzcyBiaXRzIGFy
ZSBjaGVja2VkIGF0IFBVRCBhbmQgUEdEIGxldmVsPyANCg0KPiANCj4gVGhpcyBwYXRjaCBhbHNv
IGNhbiBjYXVzZSBVU0VSIERBVEEgQ09SUlVQVElPTi4gU2VlIGNvbW1pdA0KPiBjMTFkMzRmYTEz
OWUgKCJtbS9kYW1vbi9vcHMtY29tbW9uOiBhdG9taWNhbGx5IHRlc3QgYW5kIGNsZWFyIHlvdW5n
DQo+IG9uIHB0ZXMgYW5kIHBtZHMiKS4NCg0KT2suIFdpbGwgYXRvbWljYWxseSB0ZXN0IGFuZCBz
ZXQgdGhlIGFjY2VzcyBiaXRzLg0KDQo+IA0KPiBUaGUgcXVhbGl0eSBvZiB5b3VyIHBhdGNoIG1h
a2VzIG1lIHZlcnkgbXVjaCBkb3VidCB0aGUgcXVhbGl0eSBvZiB5b3VyDQo+IHBhcGVyLCBlc3Bl
Y2lhbGx5IHlvdXIgcmVzdWx0cyBvbiBHb29nbGUncyBrc3RhbGVkIGFuZCBNR0xSVSBpbiB0YWJs
ZSA2LjIuDQoNClRoZSByZXN1bHRzIGFyZSB2ZXJ5IG11Y2ggcmVwcm9kdWNpYmxlLiBXZSBoYXZl
IG5vdCB1c2VkIGtzdGFsZWQvTUdMUlUgZm9yDQp0aGUgZGF0YSBpbiBGaWd1cmUgMywgYnV0IHdl
IGxpbmVhcmx5IHNjYW4gcGFnZXMgc2ltaWxhciB0byBrc3RhbGVkIGJ5IGltcGxlbWVudGluZw0K
YSBrZXJuZWwgdGhyZWFkIGZvciBzY2FubmluZy4gDQoNCk91ciBhcmd1bWVudCBmb3Iga3N0YWxl
ZC9NR0xSVSBpcyB0aGF0LCBzY2FubmluZyBpbmRpdmlkdWFsIHBhZ2VzIGF0IDRLDQpncmFudWxh
cml0eSBtYXkgbm90IGJlIGVmZmljaWVudCBmb3IgbGFyZ2UgZm9vdHByaW50IGFwcGxpY2F0aW9u
cy4gSW5zdGVhZCwgDQphY2Nlc3MgYml0cyBhdCB0aGUgaGlnaGVyIGxldmVsIG9mIHRoZSBwYWdl
IHRhYmxlIHRyZWUgY2FuIGJlIHVzZWQuIEluIHRoZSANCnBhcGVyIHdlIGhhdmUgZGVtb25zdHJh
dGVkIHRoaXMgd2l0aCBEQU1PTiBidXQgdGhlIGNvbmNlcHQgY2FuIGJlDQphcHBsaWVkIHRvIGtz
dGFsZWQvTUdMUlUgYXMgd2VsbC4NCg0KUmVnYXJkcywNCkFyYXZpbmRhDQo=


Return-Path: <linux-kernel+bounces-2916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3C5816430
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 02:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A33051C20CCE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 01:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A2523BE;
	Mon, 18 Dec 2023 01:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dy672pC3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5AB2100;
	Mon, 18 Dec 2023 01:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702864395; x=1734400395;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VYb5KMyRZWhJuQWvOi6/xCK8CrCDBlNuCoPIBhGd3R4=;
  b=dy672pC3pGdg1Ghhp6af3AmIPpkE4hmfyi+GNTDoxUVa4EgBz/fdLRuf
   aldOqNQ/IjuM2PnZAsY/MiyaVFBtknAI2hfuxl5nSxFOri0DgUR3sNsZT
   lVyEiSmIC1W+F2TGVYo4sXEmSxgM4tM6SupqvLlUeI1k6NQSRa+xtl1Bz
   SkgdpxNSn9H7Arvu8JjfI3VCrRyDHXWp+Zvm7F5NoCFqSfXVNzwNgO6NS
   tntE8Bd9aya9GMRaDVTQWeXF2x0l97Qg92FQMC6kvrLl7WU2TDR5xP4z+
   7+Mj3oWsUPKDG4FT5X/G8Zmdrs6zpgiNrTKKgbrnRJyo9ep/4TzPgTr8k
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="385867635"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="385867635"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 17:53:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="898795005"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="898795005"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Dec 2023 17:53:14 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 17 Dec 2023 17:53:14 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 17 Dec 2023 17:53:14 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 17 Dec 2023 17:53:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UiXr8zxQ97J9asJov1zz8bgBpHT1YjvoesTvFbDMtwu0lMtNi+m9J9WAWodX626MpYwvV1drIfmEVe2nkwfJn/pMTg7JwHRxfP+xpDoO4Mqs9FhJGlMVCp96hs2LPPyARkAgHcUsu/v8YGIcRP1aLat+zCP6/mdhkrYhif+tDrP2jQ1/9G0wHTC4qeSlEbGjlZVv6kycHJp5A/N6G8RgGmw8e8l97dRMryVMUQZE1LNP8BftF1w0HbDfEYHBHlL0Ehe0W9vjC8+F73JVXbF0UpGXFbgLX2nymMg9SdPi0GWy3iSmEsCogoHWMLfkqIk38y0CP3+k+/3W/BHhIcSZBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYb5KMyRZWhJuQWvOi6/xCK8CrCDBlNuCoPIBhGd3R4=;
 b=aJg990CEzs6cIeDK03w8OOcoKEY50ymelZYWEIt2ZRmv37s8XRc8Nbz0cuYrD5k88x90+wy9wVkrfbx538gNO2Y634Lmmts0lxpxunZz4wT9SbSrUVFDk5wHiPz2w/WuoHgTW8UquUITrMJD8zOo6qLJutJ7oXd7BZws4qXwKyjzeC1anMjYD+i3+Y10C5Abb64UU9mp0bDasB7xObjygSLw2LJ5p+G7/O2zOEZSTU8TiwC8PVOJcBWTWJVJFMr+0NDDIom8+jaw9OD0I2tBRTLzo3qvUN9M7d/HyoNhhvDlADYht7lt6lk9KyrBXbcH6BVb7KSvNy+tuCSoYB/B7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA3PR11MB7533.namprd11.prod.outlook.com (2603:10b6:806:306::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.35; Mon, 18 Dec
 2023 01:53:11 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%7]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 01:53:11 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
	"jarkko@kernel.org" <jarkko@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/sgx: fix kernel-doc comment misuse
Thread-Topic: [PATCH] x86/sgx: fix kernel-doc comment misuse
Thread-Index: AQHaMEOchsxkoJxZC0mxt8rYMRG/1LCuSV+A
Date: Mon, 18 Dec 2023 01:53:11 +0000
Message-ID: <72ccd73c246675604d30f8d4b1b37529e8b72b8c.camel@intel.com>
References: <20231216171610.13224-1-rdunlap@infradead.org>
In-Reply-To: <20231216171610.13224-1-rdunlap@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.2 (3.50.2-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA3PR11MB7533:EE_
x-ms-office365-filtering-correlation-id: da1fcf87-62b7-484f-e978-08dbff6c175c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XrRnWM0p0BgIMNLROq7KMh7Qf4wsf8L50p/PXKx9Yg8c3j4I+VDBZxweWx06v+wKmwjNfb7IE33yR78lCfkMeEDXRHWHpI0vK4rOx+0xrS2nvv+a9T8U22hTJn2WlXDc97B+lnNd+wNKZqa5XZf9XrQ7wYzF9g0P2JENiqaSW4b9lIcO/6JkTjin9WZoyylYj0x3Hov+3mVhtm4Ag9mGJX1R+XrAlpu5t1oblDLVcbb+rnGJsr/6IzUb4odmck3VCIoJso9tNFz5IbBmDb6Ih5Z/DnIkg20Cqu+ysx05Ub38ZR2svByJy+REVii8347JNhYfg0HNzXWwMX07rSC6pwLm7BsHdCSmibzlhY5IoA8Xhowxx5wgr3vlDVjDDw4pKsBLhXpDF/JXdybPzcxfXy4fciZVv0ZnFj75SH3JH7/WKZ0SfqaquyjZQrF0kHKMiUzNnQBi6amtUmZN7bPoRsCwKcap5dqcabWfpLPgTRixz6f/TOLJnviOs9Wyw5kcLcuGkGjB56RCQceNPTVjq7Uv5T/kgdDsvByWTf8BwEeHzBZdnpAZh7Z93bDVwA/Czn/7bODJdMwPyIEVnH5Ee/9RJOxgijkeHvyfd5FFn/bNmyyorU32VBI2ZlXx1sUvEIajKFMXqQ6mO7cvzH0Qr+U1dkveV3ejSPOPWOx8Sz4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39860400002)(376002)(346002)(230273577357003)(230173577357003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(36756003)(38070700009)(66556008)(316002)(83380400001)(76116006)(91956017)(66476007)(66946007)(54906003)(64756008)(66446008)(110136005)(4744005)(122000001)(2906002)(4326008)(8676002)(8936002)(5660300002)(71200400001)(4001150100001)(6512007)(38100700002)(26005)(478600001)(6486002)(2616005)(86362001)(41300700001)(82960400001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1laWEdUeWI2QThJc1RCM3lSWGpQeW94SnR4L1FNYnNrR2lFY1FkYVJ5QW5z?=
 =?utf-8?B?YU5tekFSWmhGZFdCWUovcFNUbjdWRFZQZE1PN0o3dDlGU0JxREtxaG5DYmR3?=
 =?utf-8?B?UmFtRGEyUVdNdVJ5aE1FSC9Eb01yTEhud01Jek8rREVCNmtjUjdLMTNvSmtO?=
 =?utf-8?B?aXZmMkRZMWpWdkc3N2lobUxpL1RFUUtzenZHVHU3SlBWNnZkS1RoOG94N1dn?=
 =?utf-8?B?MTZjNC9oRHBENEhKZFhmTGxZVm1EQW45b2g0MWdNYjFoQ0ZBcUY3ODhJeDlH?=
 =?utf-8?B?ZXJxN3lHcUVLVVg3RHZnZFdOeHBySkt2enY2VldPL1lVQldTUE9xdEM5eHZV?=
 =?utf-8?B?UmZkanAwZWZjdXFwUzI5aUxaeGJpaWM1YmVoczkxblVGSjcyMStYeTROUmY3?=
 =?utf-8?B?amMvZ0doZldTaWQyUnE2VzdQc0dNbXlBZTBJY0t3QTVFbkZzZXVCcFVDaXdB?=
 =?utf-8?B?dEJTMUxKRVFheWhXcGptbTMveVNNQkNlL1hzYkVwNmFTK0o4ZUJTZGwwWWdZ?=
 =?utf-8?B?dDhFN04zT3RQUnpWTHJlVUN3cXV0RkJ2WUhJWFJvcjdYbmVHZE80cEdIa1RO?=
 =?utf-8?B?UVpJTHhoRlp1enRxK3NDdG9IV1ZBSW9oSjV4N1p4VnE5STRuL2d1b1RjcDBr?=
 =?utf-8?B?ZVZlcnB1eUpkSHNKTDFvUFNYcThiM05TMFZpU3lzbk0va2gzeFNnTm0xYmc4?=
 =?utf-8?B?dnZjRDgzOWRLZFVoNCtMcEw4UjdaVjd5QnJKQUVGSEZ0U2pxM1A4eVg2T2w0?=
 =?utf-8?B?TWh6WGV1elcwMm55NE56MFVLbWhqQkkzTTVaS2NjWVZxOVlSR0c2aXpYMmtH?=
 =?utf-8?B?ME5Zb1RIUTVxRkJCZ3dydHZ0LzUzWVhjV3RHRDYxRVJXRjVsUGdZc0RxcWtT?=
 =?utf-8?B?Mm9aZE5NN1FCWGRNSHJJdkExYzNtdkQrRmZRTC9pQUtLRFdjTlNTeVZ0bmpW?=
 =?utf-8?B?Vko3R3BxOGkwL1ExOHB6UVlReVJWejNvSkptTlNqTGUyNFU1MkhROFdjcDRk?=
 =?utf-8?B?RXppek1sa096ZEtVaXhVbW9IQy83OHJka2Q3eFh1SjIvVXdMUXJtMnJjWUNW?=
 =?utf-8?B?K3V1QjNlV1NPMFZIemFKczVtZkppWlYwTngxMnU4YUs0NHk1RDZrekl3TWtW?=
 =?utf-8?B?SjN5ak5LOWtTZ3Q3b2p6SWJHMlNXNUVOK3VmeWx2QytQekFhV2F2QWYyRUlT?=
 =?utf-8?B?SU14bkpQWi92djNhbWFjK2tYUFR2R3VONEpIaHRldCs0a1VmMzRXM0dkNDM5?=
 =?utf-8?B?dmd0bVFrbFhjQnZpOEhNUzZDYWdzeDFTaWd1L1pYV2haUzFrR3RCbWRIZEN6?=
 =?utf-8?B?dk9tam44WTBrM0VVZ1puZUdvTFFnUnp0d2hZcE44Ujl1VUdaK004Umh3TGhr?=
 =?utf-8?B?bkRDSWhXZVpXWHR0NVF4QnhSYXhQaVQyYitIcHlpSVRtUXNVUW1GZGxtbGN5?=
 =?utf-8?B?OHJUQlZQZXBnTnh2VWJKc3FDUDFCZWFMQzhsbHljL0xmWlhnbUFBWGhvbDZs?=
 =?utf-8?B?OW5LK0ErQndaTTZmYWwvRHZOTnJZQ08rUm92MEV1czNObCtESVE5Y2dHeTFZ?=
 =?utf-8?B?QXYwbFdjVFY3WGE2SWlNNWpKM0N4a2k4ZkNLNE5PRnkzemxqMTZJdHVNeDlK?=
 =?utf-8?B?QjN3MzBVaFBzSTF5L084UnUxelRjVm53L1FSajc2V1lKWHgrVWk3Ull3ekp3?=
 =?utf-8?B?aGc2WFk3QVp4eURSNnBxUVhuTVAvUjhmZnpOZUpLN29KYjFwS1BwV2lZNEdi?=
 =?utf-8?B?cklSb1I0T0RuR21jbG5kdVJzb3RTSWNxUUwrUk5UZWxyL2EzbXQzMitmcTk5?=
 =?utf-8?B?TnBJckIyYk82UkhwUC9WNEFHdFFZSkhEMXpwN2lHVTViWjNPWUNGR1ZSUE51?=
 =?utf-8?B?OElCdGZpNWZJSTgyTWNCbUxPUGl2VTRwQjYwV3hHdEdGYlVEckFLV0pLbkY5?=
 =?utf-8?B?OXF1dFpQRXpwTyt2L3ZBeDkyMTlqaVliaWw5d0dhZVlmVnJHK0FlOGpGTlJh?=
 =?utf-8?B?ZXIzRjBUaUszY2JjR3dqZTRNelBxRExFN0VBQnEwdmptaGRURnJIMzRSdWFB?=
 =?utf-8?B?SENWV3RWc3d5bW5CS2dOaDJPMGVkZ29ZQVlSWno4SndNcG9UU0twcDQvYWx3?=
 =?utf-8?B?N1dVVFZFRnB6c0NvUER2UTZmU3dxNDV4ZTJvUFBDblBtUS9OUDdieE03eDdT?=
 =?utf-8?B?MFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B531FB036266642BE6887F6931C5E9A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da1fcf87-62b7-484f-e978-08dbff6c175c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2023 01:53:11.6326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9NjniCslyQuLEL2HOxQF//6mJYm6jAAAA+zVCFtqsIjjrRaB3nVvooIdd4Sog9BZkiy7d6K1ITIWL/oHq/a8YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7533
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDIzLTEyLTE2IGF0IDA5OjE2IC0wODAwLCBSYW5keSBEdW5sYXAgd3JvdGU6DQo+
IERvbid0IHVzZSAiLyoqIiBmb3IgYSBub24ta2VybmVsLWRvYyBjb21tZW50LiBUaGlzIHByZXZl
bnRzIGEgd2FybmluZw0KPiBmcm9tIHNjcmlwdHMva2VybmVsLWRvYzoNCj4gDQo+IG1haW4uYzo3
NDA6IHdhcm5pbmc6IGV4cGVjdGluZyBwcm90b3R5cGUgZm9yIEEgc2VjdGlvbiBtZXRyaWMgaXMg
Y29uY2F0ZW5hdGVkIGluIGEgd2F5IHRoYXQgQGxvdyBiaXRzIDEyKCkuIFByb3RvdHlwZSB3YXMg
Zm9yIHNneF9jYWxjX3NlY3Rpb25fbWV0cmljKCkgaW5zdGVhZA0KPiANCj4gU2lnbmVkLW9mZi1i
eTogUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+DQo+IENjOiBKYXJra28gU2Fr
a2luZW4gPGphcmtrb0BrZXJuZWwub3JnPg0KPiBDYzogRGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2Vu
QGxpbnV4LmludGVsLmNvbT4NCj4gQ2M6IGxpbnV4LXNneEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6
IHg4NkBrZXJuZWwub3JnDQoNClJldmlld2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5odWFuZ0BpbnRl
bC5jb20+DQoNCj4gLS0tDQo+ICBhcmNoL3g4Ni9rZXJuZWwvY3B1L3NneC9tYWluLmMgfCAgICAy
ICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4g
DQo+IGRpZmYgLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3NneC9tYWluLmMgYi9hcmNoL3g4Ni9r
ZXJuZWwvY3B1L3NneC9tYWluLmMNCj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9zZ3gvbWFp
bi5jDQo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvc2d4L21haW4uYw0KPiBAQCAtNzMxLDcg
KzczMSw3IEBAIG91dDoNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gIA0KPiAtLyoqDQo+ICsvKg0K
PiAgICogQSBzZWN0aW9uIG1ldHJpYyBpcyBjb25jYXRlbmF0ZWQgaW4gYSB3YXkgdGhhdCBAbG93
IGJpdHMgMTItMzEgZGVmaW5lIHRoZQ0KPiAgICogYml0cyAxMi0zMSBvZiB0aGUgbWV0cmljIGFu
ZCBAaGlnaCBiaXRzIDAtMTkgZGVmaW5lIHRoZSBiaXRzIDMyLTUxIG9mIHRoZQ0KPiAgICogbWV0
cmljLg0KPiANCg0K


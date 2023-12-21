Return-Path: <linux-kernel+bounces-8547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6951E81B93D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD07DB28F0F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FEF6D6D8;
	Thu, 21 Dec 2023 14:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aEXkTgni"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1586D6C4;
	Thu, 21 Dec 2023 14:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703167207; x=1734703207;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oZvSUSbTyeActxqfE5huUUAy2aPIdWeSSKVbXSnMfUs=;
  b=aEXkTgniiKhdMB0p/aY12y5zh9IfEGSGP0GVckHJ1BcVezogm4hTV09f
   bAVr04sG+NLfYJELsurYyJPWXdDpITMk6JKxXKuJV/lCnQfmAx2dqHzDq
   ZrAjjGIM1HNoGeS/YDusrNZOXhQkhxOD7ga5gzws4cEi2mB7QdIGvD/9X
   Jhad2T8zXpgf2P9ZKUvJBeARSBaJDNjgA9c7fWxxTHdu40xjczZLpvXWa
   +MsHZZSQNFmFaFOVmcoPlPF18OW44b/Xh8E4oJGVC8I0vgP8w+oIsplII
   pIC5D4DBL9kb2gAw2MryvuqllMEqS6t5s2RQc4ZXlKN3Ae6nLsNrDXyvN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="9358475"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="9358475"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 06:00:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="895107044"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="895107044"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Dec 2023 06:00:06 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 06:00:05 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 06:00:05 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Dec 2023 06:00:05 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Dec 2023 06:00:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NeJhZLBRTK/ztffZeWmZx5h6hS3XTI3sXo5IBbJnjgshvRXSHH9ooZJjsmpIAUM7U6ZqDasUB8/2+oD8D7jPBvXKVcIu6y6JCDRtMp78W6cA4Omxhq+LT8tiGiEqNbjItFVFLmg5BMeNE8sPAf+OgSlzjMjLysMc8G5S/Nx5ZMQmmZcumnHQcMVIEQSC4R+8eov5lUW8H085dLaTEf1MIxeXozHMCO4rSqlKeNY9Hpa5LYogeqG4D1O2iZCVnNn8Qpy8O9PBKDD3cRIMkIM3AAogjASexekdr5H3+nfm1eaK4VAFtoJc9gvU7lhAUa4S1wXIpZO8jCuFDVhkrkQqQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZvSUSbTyeActxqfE5huUUAy2aPIdWeSSKVbXSnMfUs=;
 b=B6F9kR1Ihbvp5JRhbp+lvg7OgkrUjwIp6QVdhoWwZPvcDSEBsfy7/DkyQWvUgvcC+AWPKxPAouOS/zbowVC2TXgFdrKpOebLTPS6oQZr340sh1Tfcn6nsfgfdRDUk/odD83HtnKmOp0sxY1qQ2JaKlcB1zgZ2l6LpjR1rkfMDaeVD1yDmpA2r44DTEbDQqPpVjVZejwLrN/YhRzwGXNSTgu0mMVVABYE6XUXK/PnEMuZMeND35yHzE/PW/os65WIpkRXk1yaM3NMbteKyUqcJHCa4B8OzOn0bUguTdG47eRZga2VrGb/68EMqYJLy1/fQcoTIujRF3dEYfWLDwth1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5611.namprd11.prod.outlook.com (2603:10b6:510:ed::9)
 by CO1PR11MB5185.namprd11.prod.outlook.com (2603:10b6:303:6e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 14:00:03 +0000
Received: from PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::8ba4:4bbd:ce09:b53c]) by PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::8ba4:4bbd:ce09:b53c%4]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 14:00:03 +0000
From: "Staikov, Andrii" <andrii.staikov@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Ostrowska,
 Karen" <karen.ostrowska@intel.com>, Mateusz Palczewski
	<mateusz.palczewski@intel.com>, "Drewek, Wojciech"
	<wojciech.drewek@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [PATCH iwl-net v4] i40e: Restore VF MSI-X state during PCI reset
Thread-Topic: [PATCH iwl-net v4] i40e: Restore VF MSI-X state during PCI reset
Thread-Index: AQHaLg+2e0fwDUJS0k2xqs9dD7OKmLCzz7XA
Date: Thu, 21 Dec 2023 14:00:03 +0000
Message-ID: <PH0PR11MB5611D8F48DE4DEA4CA6F40C38595A@PH0PR11MB5611.namprd11.prod.outlook.com>
References: <20231212122452.3250691-1-andrii.staikov@intel.com>
 <714694aa-a6c3-4e89-ae12-a6a87bdf430a@intel.com>
In-Reply-To: <714694aa-a6c3-4e89-ae12-a6a87bdf430a@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5611:EE_|CO1PR11MB5185:EE_
x-ms-office365-filtering-correlation-id: 71a9aae0-3178-4c6d-76ec-08dc022d2110
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZBn48nELPkgVmEdrbJFAsiG5HgwEWDBsdlkBCSzAY9JpuqgSjnAPBrfTLTrehUr4N1LCgmjrJfn1ifEwU64Ooz6ticZBZRXGFLhWDq+sVhqB1W50bKpqSx7BXsZj0Z/v0h74Prf/zc391ybcN9QsSi4k8ODvVr5TGjRW7SmIJLUxEXAihzi6BA32y38SBSHbvtmr58Tv9QJKGkyWW9/40Az0phcxFRpztJpLjn6YwJ+st4N4W16Hc69CFQynPqo7NbJCvGlEGh2nKKP5U+bcGeThJ2z6q3iEDVwDy6AcoM1Oj8BALehIY6ysSNAVeNyO6Jk2wRHdV2NUYFsjF2Z4i4UlyikwqrO+9T+SZ4wO/7Qaqb3Ppb6y1bvcTwSLw2l5wn9idwLKgPnFtvpfxFpRYg9G040KSXmLCmTJUg3yG97zEwruwNh/u9TGjz7LJR+ZSYXqoxeJs0lWrhgLcrugIGU5jnGTyEqpeLqEfGUh6aGZPe3RrsKLJCMW8iHNhshXBwALdy42WuzODfiIDo/6m4d8DpW08EeBuiDt7mhySH2etHIq701IC9Ov2mKJxlbEFEYm+gVQtPUtRwgU4l2Ms4K2JkyBslnze/jGunQr+CQUytn0LqDlGbD2NtRI+Ryxo3AkxqhnBA/6dQQfgXILXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5611.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(55016003)(26005)(7696005)(107886003)(6506007)(9686003)(33656002)(82960400001)(86362001)(5660300002)(38100700002)(38070700009)(8936002)(83380400001)(4326008)(52536014)(64756008)(122000001)(54906003)(110136005)(66446008)(8676002)(41300700001)(66946007)(66476007)(76116006)(4744005)(66556008)(316002)(478600001)(966005)(71200400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1hkOWtZL0RkUisxL0JXWDI3bnRVU3RNRU1LWXRIR3pYSmc5R0ExcWJ2K3lY?=
 =?utf-8?B?QXdMVHNiU2tYc3k5S1NON3Z0cmtQNnZ3UWE4Z3VTZE4vVnZTaHdzcDBYYURE?=
 =?utf-8?B?OVN3bW5NRy9CQnFNbUU3VlRmYWdTT3AxMFNaWnlsSUNDa3FyelZBZGtNcWxw?=
 =?utf-8?B?eGF1NXpibEFGaE5JSDRPTjVneEtabmwzaFpIbHJvWlBGcEJaWjY5RjM1VVlG?=
 =?utf-8?B?SVRybTlzTHVTTlVDS01WQUxFOFV2cE11R3VseEhIdnJKcHdqRnRFZWRucFVh?=
 =?utf-8?B?VmwrRDk2QlVTT2NxOFloR2tiNDcrSUNuN2tGNmVqVjRVS2JKZWZQVHRDQzBU?=
 =?utf-8?B?K1BTanZlSHY4ejVxMWF5MDNGdEwwWngvY3pabTRWMzEzc24vMDRnRTl1MUVJ?=
 =?utf-8?B?NEdMaDhoNVZ3azZtS05aMUdySDBXaUY3M0JXZi9OQUNsbDMwYm1PcWFyL1dk?=
 =?utf-8?B?QTdnKzl1MVFoU3k4Zm1ZM1FQbWg2bG10U3lCN2FFOHc3NzdweTAveEFUQXRr?=
 =?utf-8?B?U05mK1VHcjQwZDVxNFhzVS95OVpNckh0SVQwUldtL3g3Zi9mdThGTm5pNXBQ?=
 =?utf-8?B?eHhaNG5zbTZ4WTg2KzE2bWJ2ZFpGSHZJL3lVdzNoOG5GdTdFMlFOK3JxOStu?=
 =?utf-8?B?cnBzanQ1RFFtWUVvUFZUejhKTUFIQ0Vld0dtZGVlOVk0ckd6dlhXbWNvQ0x1?=
 =?utf-8?B?TWk3aGlpeFZ3M1Y3a3lsbEV0V3BOeDhDRUZ6M1phbVpXN256MlVybGNnV2l1?=
 =?utf-8?B?eDVvQzg0cE0vZHpTb2JmQTRDeitSOSs1bGtXSlVscHRNTHl5Q09qS2pOaUhS?=
 =?utf-8?B?RnNvQ1ZrYUpTdDJsSmtDUjdJMjU1MTYzcDZ4OFFuUURsMHg3TXpmQnZ6eFJD?=
 =?utf-8?B?T0pYY0RiUUNFRmVEWUVWSlhyUFRjWkJCZ1pmbFVHTk5FZWpjL2Y1UE5qRmNY?=
 =?utf-8?B?ekhxNVJvTUwwVmR6cDdSdzlObStiN2tUSFZmRjl3OTQrcHFZek1kN1dDU0Jx?=
 =?utf-8?B?QjhvRVlla09yREE3Z3JTZEMrWUtBblk1Y1NuSkVGR3NZNVZ2YzBJRmNUTy8x?=
 =?utf-8?B?Mml5SDNTL3pqT1dKQllIVkthanpOblN1SUcxRW5XUnpkSGgveDY2SFBYNVdJ?=
 =?utf-8?B?V2pLUE1USm1LNUN2NE8xM3V3Y2dIK3lMUDBuMjZ0SUM2WXp4VWl3ZE1FWGN1?=
 =?utf-8?B?dUp0aEFlSlMwa0NYY1NWVmRkYXUzNEFyaitCdWlFWFcwY2xpN2NrT0tzUGFO?=
 =?utf-8?B?amN5ekt2bjJnYk1PeXNKeEZ3cG0rU01SNlNsb0VTY1NmVG1sdzBVaFA4QjlX?=
 =?utf-8?B?dnU2SmNYWHRkYlhKcEhQWVJEaTBZQzhDZU5sZTNkaEZzbkRlMzVsY3pOUFZq?=
 =?utf-8?B?UnlOLzRsM3NBNjFNQmx6RysvZmJSWmN1UWlFa0VJaXlHbUV1SEFMaDBpSS9q?=
 =?utf-8?B?VW9RZTZWelJNTEdpbDh6VzAxSXZ0dkg1YVEzWmM5bGF2aiswVUhEVVRZb0ow?=
 =?utf-8?B?N3dtYk1BdHlCK3M4dW11dXR2bGhBbldNSWZmcWVUTW8vekRJN09CMGRqN2Yr?=
 =?utf-8?B?S09LZDlzZkxuMjRiRkxTT294QVVpNGhLcUs2NGR2Q2d3SXRvaHFoTXFxRjJk?=
 =?utf-8?B?alFFOWs5YzV2bFZzV29oMGJaVWtnTlArSmVidGJsekxJZDJMY0MyQlFxZHNC?=
 =?utf-8?B?bk9uWkZ6TU9wOUVEbEltdjlQZ0IxYWp4T0UyVlpoU2kzeWQyVTg2M1lMRlJt?=
 =?utf-8?B?b0pLOHhGWWFSWEJpbHdYQ0llRy9qbTRHMmt1SkJ4dzVJU2hOSUo3T2VSZ2lS?=
 =?utf-8?B?dXZFZzNpZ3JpRjRTUFZKRjhZNUczQ2U1eHZyMDdlbG5KcXRZK1p1NXhUWEdX?=
 =?utf-8?B?c1crdjBsY1JldGIyT0xaSjU2TVlSRGcyMmpSWTZuVGxTdy95U1EwaU1JamRx?=
 =?utf-8?B?bUpaaDJQMzlqNlBVYTVabmJDSy9kejZQcDFBYkI5QXJpYkczOFRnWFE0TGxh?=
 =?utf-8?B?Y1Qyb2RDRGcyb3RrZzBYNDdrbWQwa0VZT05rcXA0UHJ6aWZYQXdOelRJTzNx?=
 =?utf-8?B?cjJ4TUdoekZ2anpkUWpVRVlLaVh2OEYxQ0V2cFRtcHB1Vm9LZEh5M2RnZmhP?=
 =?utf-8?Q?5KBckAZL9G9Ss7NWHCm3umRRq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5611.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a9aae0-3178-4c6d-76ec-08dc022d2110
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2023 14:00:03.0795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m4ZSuIdHlCGWtFcj4aU5MDI7esfYJKmp6nCr+7PsE+qZmUQM5E4O/uzAyf75nILPUDClcGd+Ycqdg3qlrWAQJOhL7Bixdd1GOci3mcTrhZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5185
X-OriginatorOrg: intel.com

DQo+IFRoZSBpY2UgZHJpdmVyIHJlY2VudGx5IHN0YXJ0ZWQgY2FjaGluZyB0aGUgUENJIGRldmlj
ZSBzdHJ1Y3R1cmUNCj4gcG9pbnRlcnMgaW4gdGhlaXIgVkYgc3RydWN0dXJlIGluc3RlYWQgb2Yg
aGF2aW5nIHRvIGRvIHRoaXMgc29ydCBvZg0KPiBsb29rdXAgb24gdGhlIGZseS4NCj4gDQo+IFNl
ZSAzMTY0MmQyODU0ZTIgKCJpY2U6IHN0b3JlIFZGJ3MgcGNpX2RldiBwdHIgaW4gaWNlX3ZmIikg
WzFdWzJdDQo+IA0KPiBbMV06DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2ludGVsLXdpcmVk
LWxhbi8yMDIzMDkxMjExNTYyNi4xMDU4MjgtMS1tYXRldXN6LnBvbGNobG9wZWtAaW50ZWwuY29t
Lw0KPiBbMl06DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL25ldGRldi8yMDIzMTAxOTE3MzIy
Ny4zMTc1NTc1LTQtamFjb2IuZS5rZWxsZXJAaW50ZWwuY29tLw0KPiANCj4gQ2FuIHdlIGRvIHNv
bWV0aGluZyBzaW1pbGFyIGZvciBpNDBlPw0KDQpGb3Igbm93IHdlIGRvbid0IGFudGljaXBhdGUg
bXVjaCBiZW5lZml0IG9mIHRoaXMgYXBwcm9hY2gsIGFuZCB3ZSB3YW50IHJlbGF0aXZlbHkgc21h
bGxlciBjaGFuZ2UgZm9yIGEgYnVnZml4Lg0KDQpSZWdhcmRzLA0KU3RhaWtvdiBBbmRyaWkNCg==


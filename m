Return-Path: <linux-kernel+bounces-6613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96037819B01
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA4951C25879
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86601CF8F;
	Wed, 20 Dec 2023 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KT536zHc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9F31D528
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 08:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703062609; x=1734598609;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SPGctyxESAATji7rGNEsW42HwQhdV2623MquqdbPjeI=;
  b=KT536zHc302TYlGxfskef6DSFm13T+h2W75Qn7VBipDN48YmAQVbT0Y2
   EHCipNgR5Vd93aCf8g+WpCPjtk8rSdeZNnV0ziQIYb1BGNj1DQm4n/Kci
   EPuCRlVE1b6ki6+HFJHIZmP6VxbnjUVVlfgBFkkHS9zYhgtNBbdxr9IcU
   qPFsPDZVBmbGWDPfe0u1VozFbtteJc7h33Uf3H5e5MOqnvjeTfDyDeooh
   ot0ZIb85+ri8JNIsQYMVCPBTKP2l9AhfZnOLbSuwWuff3TEFFT/+pc23m
   +01cKjnZdUIqD7Geb4hERV3fCx+PXdOJhTIbdeUZvRj13cfom/hXziRtV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="460126808"
X-IronPort-AV: E=Sophos;i="6.04,290,1695711600"; 
   d="scan'208";a="460126808"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 00:56:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,290,1695711600"; 
   d="scan'208";a="17878014"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2023 00:56:48 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 00:56:47 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 00:56:47 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Dec 2023 00:56:47 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Dec 2023 00:56:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxMhZf5cFdjdXy8FWw9J6tu7qdCNXl4vt9h6CTcDJtm7X+RMBcazJHHIO6Uataxt07y07ecnd7srinZvQY/ft7zvc3P3oZTUwiFqNAhkSymFNjy8xqBW1wWm70tYbZ3nnkMkadtlL9sbDAbGZt2LX0qmbo/QhXHQlEbX32qav2Wiwmh5/cbnggWQ3QkUfUSd8YFght+OucLyisEvUVi/VMlc8arXwhlpqiPCsW4KepjPVmIOEj3Yb34Oa4V9P8bVyh2uZWPN+pdnZJ6nubXYvOsSyf4iDYUWFUs/hw05GXHCzgfVQQAb8GBDrJSkB5D1XzwJMjHSXmW0OzDTFAhKIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPGctyxESAATji7rGNEsW42HwQhdV2623MquqdbPjeI=;
 b=L9ggJTyJ9q7SWbFZCI8+asHXbW1MFe1DMa0s5tbI1eTqh2OdngOE4m5Cr+Ba86CkG9uZ3H2SgFuAXLIDwjMe1tyrBYBRwtC+3Q7YH9UhJptH+jZNq2Iwgd7LwcPlZY0NghlYx+ZDRhTGnZ1qmZWAmo4T59uhOpy2wYpiV52hxw2Al7N2eg3aoPM7e4C1vVsSWrrLqxystPg74teEsjDuYXk7A/rnTzai3KVHO1gZaowAv5R/hWrBt+ChaNpoRP3Io2qhaqRePk4CpG5dkQCc79kT4UnCOMFkpuqKqixB3ofChQ4UvrRAp5UGZWb49mzxWUvhMLKCWLAXPgXuhfLmoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by DS7PR11MB5968.namprd11.prod.outlook.com (2603:10b6:8:73::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.38; Wed, 20 Dec 2023 08:56:45 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::6a88:3d6c:99ec:d988]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::6a88:3d6c:99ec:d988%5]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 08:56:45 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Miaohe Lin <linmiaohe@huawei.com>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Luck, Tony"
	<tony.luck@intel.com>, "Huang, Ying" <ying.huang@intel.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
	"Yin, Fengwei" <fengwei.yin@intel.com>
Subject: RE: [PATCH 1/1] mm: memory-failure: Re-split hw-poisoned huge page on
 -EAGAIN
Thread-Topic: [PATCH 1/1] mm: memory-failure: Re-split hw-poisoned huge page
 on -EAGAIN
Thread-Index: AQHaLy56zApP4+g32UCjLA2FEfjfxrCwhNcAgAFeXBA=
Date: Wed, 20 Dec 2023 08:56:45 +0000
Message-ID: <CY8PR11MB7134A31039FA79E85300DA2A8996A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20231215081204.8802-1-qiuxu.zhuo@intel.com>
 <81eebf23-fce3-3bb3-857d-8aab5a75d788@huawei.com>
In-Reply-To: <81eebf23-fce3-3bb3-857d-8aab5a75d788@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|DS7PR11MB5968:EE_
x-ms-office365-filtering-correlation-id: cf63ca5c-1b24-48f7-b4eb-08dc013997ea
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i/aYMCx4ERL29Yo67JJW0CWvW4hsxpztuRdUE+eVb7z2nQ/aqdP20DNldyqwaRiYfgwdEJHCGf0speJBdgxBe42R1BLJ2PNhBnKxbiyg6hiwkcD5WBnE+omTXEm5vSmNrZhwf8ewodCuA/2xuG3dJaW5v/tZN+mIQJ4PKvY7MKfpEXvBArarvH92gjqOXLQEHFTbUZGQGcFWYdOXW+q7kpU6DSaeqd7KDIZOBDGE1pvtSjqEHF9YNdHjjActnburBRBHeCMe7+0bzvc4m8sl447gwf1eUKIJz4KA8T/+ECzktf1zb52YURm/qN95v+Fqzdn8xa+PCFwyf1/FSFbyRUDrXpEVPo070kd8N5cAdFq3f+chM1NWsYSp0A7Xp62Gut9GcSuwI8rtwnxmwY+dQEYF2AXbBo52ae7dcgYX2GW3KYnHDS/S5YFs7WwST8ZKClBn6vr761zGyKD3daQ7zKDPJQIiY4xq6zELtdOaRLh61pUAGeyOT/h5KX5g8hXAKtGp46ZMK7g7g25gGmT/g8mTZkWYiqSrsIvf6LuAOBsEoM1Fmke8NYcL0cxvDXMvAeZjykvBHQDwDxVEjhbM8gxDbS8PbK4hO/xTeSjijVOKTeXVE9Te8W6v9WIxGM8hs2XZlqD6SssmELG/yrR0PA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(346002)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(2906002)(5660300002)(41300700001)(38070700009)(86362001)(33656002)(82960400001)(122000001)(38100700002)(478600001)(66946007)(26005)(107886003)(66556008)(83380400001)(64756008)(55016003)(66476007)(54906003)(76116006)(6916009)(66446008)(316002)(7696005)(6506007)(71200400001)(9686003)(52536014)(4326008)(8676002)(8936002)(14583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTlVODNlYk5tUUlFSmxVaTF0bmhlOCtVWGNidW8zS0ZZQk5lY0FNUmhCdWpi?=
 =?utf-8?B?c1hzUnkwam1rRHhSRGFrbVdRVHR5NG5ETW52NHBWTmU3SVN3Q1Q3NDZUTUNT?=
 =?utf-8?B?TUlFN094cldWOVZpNllKODdnSCtQbmRZMXNFV0tOODNYTjdQK2syY1FHN3NS?=
 =?utf-8?B?Mkx2R2J6N3QvN2RZWjRZWGJvcjZ0ZUd2UUxGbUd5K1Z1VmhCbnIwVURkenNE?=
 =?utf-8?B?bUw0azJpY1FPd2tyT0ZOMXJIU1orM29aR3B3c2dCQVZQb0dsdUlTNHRVS2NJ?=
 =?utf-8?B?cDJiaTZnWFdRTkNMZGxDSVR6WlBSYlNreVZWb1M2WlZZMHFYMnl2SlN6TENG?=
 =?utf-8?B?ckdRazhKQUJUOGFEQjZXRTZIRnFleUxQSVZXbklqMDBlU2xrNWpBT0ZGTDd6?=
 =?utf-8?B?YlIrUVM5TGNwZU55Q2hhVEtaK0FHV3NxNHdKVlB2S1ZJQnVZN2RuMnl1QlhY?=
 =?utf-8?B?SWFIbkp3amZPSjgrcjBNV0o3cHk3cFVrZGQwYWFhTWJSTmdnd256RE1NU0h0?=
 =?utf-8?B?cHFYVm1ZRDBzNGh6ZXBXNmlPRWRtZDRmVHA0cEdGWWN6aEJuOC9KMUxCdzh0?=
 =?utf-8?B?S0tUUC9WTUtNNE1LcHVlVlF3aitHclp4dTMwbkx2M2VoRlVwQW9jbmVMcVlO?=
 =?utf-8?B?akV5T1F4dmdJY0xFNENKMkJGWFRicTJYajVnZEFNUVk0WjJsZ3pjYW5tbXk4?=
 =?utf-8?B?ZTVGK2xxdGR4ZTRqTnVsdjB0c0Nxelc3Mjk5QTcwSkt1YXZqSzVhSmFaajRm?=
 =?utf-8?B?TFc3YkdHQWJoT2pOVkxaQUREeGFUS1BkVE5wSmlZbWNWRjdjd0tlUVFCeEo0?=
 =?utf-8?B?WWxBWVNtWDg2c3ZJa3JTKzR0T3dPWmx6bGhFWnJKUExwV1RWaUpoYXJmMU93?=
 =?utf-8?B?NlR5cnJ0SDZBejhWdUo4VUhuaTFIVzFZbWVwQ1ovcjB1dVNEcWc0Z1hMdXM5?=
 =?utf-8?B?RDM4emxSOHFMWXNSMzBSNzhrMlQvb281c0tnS0poMVpsU1VaVkF6YkpIMXJv?=
 =?utf-8?B?YnJtdHlZZEVWVVNLSDZLaTIxbzZ2QTl1cGZ4Zzd3T2FxUjNzYUdXT05Ka0xM?=
 =?utf-8?B?eEhGNXBjdDlHU01qQTBxZUY2L1d0RURWNFE0YTlmWm55bUhTbE5Gd0Q3SFRQ?=
 =?utf-8?B?MkZIUXBzODdSdUI4VEsyYUpjdFpHbXVobzVrUDdFbXNzbFpKWTJ4OUtVYXkv?=
 =?utf-8?B?WmVENUZra3JhNHJLOGZkdXVNaUszd3RZeWxJenpkWTA3Q3VzS1pxaVc3TXo3?=
 =?utf-8?B?N1ZoQyt4M2tKcE5mYlZZYkU4YVVpd3h3U2ZoVlZvdDZxLzBIM1BVQ2pFRzk1?=
 =?utf-8?B?WS9aOVhHa0hLd3hDa2V2eVVJcXpUdjJKNkw5OVN0dVZPWWxmSHZreHhRbU5Y?=
 =?utf-8?B?cm5EUnkvaUJKM0lsYjkvbjdDMlVWRENIM0NiRHgyNzd3eUxaVlM0YVVJTW80?=
 =?utf-8?B?RlJlYWVuQjFMVjBleTJYNEJLMGNlczNJZzNiZ3ZtY1NnQ2V3SFh0MnR3aWpH?=
 =?utf-8?B?YWRRcnY3RDR0YmZpbVRkVGNOVGJWbm50anlGZHNwSHNKQUROMi8yZmhWWlFi?=
 =?utf-8?B?T3BSdm9SWjV1VjVuNVlTOFQvMm1TdVE2TFZ5YkQ2VXhIOFY5cS85M2dYMVRC?=
 =?utf-8?B?enBoQnZIbjhacllUNTRMeWQzMGI3RWZUOW4yU3ZoUWhOdzNXM3UwREtCYXJI?=
 =?utf-8?B?SDBsSm51VDd1WEQ4dzA3VytTTm5LenhITmFZSFhyTS9XczRPZXIrSnZTRlJJ?=
 =?utf-8?B?WGI2RkV1NXRLTmNUNmh5dHN0QWRDVGtIYnRrTTZDa3VZOE9vdnprOU1TbEJH?=
 =?utf-8?B?R2VOSHorUGUwQ1R0TUpTMys1bzJlNEtzSjhSQmp1b2kzWkwrbDhFMzdGcDJt?=
 =?utf-8?B?eDhzZDVNOTlSUVRqVG1paW0zdGcyTFR3aUV1KzBFMDVIb1hYL25ldC9GbHdG?=
 =?utf-8?B?YWtIR3M0cWc1dXh6cXYvSjNqOHZmd0ZDZ0RRSjRXTnNSaHJ4WXdaTU1ncjNh?=
 =?utf-8?B?UHN0YlF6dFR1NlZmNWJSSE9xem13eEZvd3FXSWZZeW9FejZtTVBrY3lVcDE5?=
 =?utf-8?B?U0hJZHN0MnZXOG94clRqN3V5RUgwTVdmWkhHVDRmSXhGcUc2c2F5cGE2UWlT?=
 =?utf-8?Q?Y+RpyQravmJ/nRuZDTDFj4izt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf63ca5c-1b24-48f7-b4eb-08dc013997ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2023 08:56:45.3177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pxtJYYbRP56Aa/N0Syr63PE/vAnV1UsWHaztN2pLT7KfnMqnHy4qorqw9uBxNSOtOJtwvCoi5TUECxlH+brJ+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5968
X-OriginatorOrg: intel.com

SGkgTWlhb2hlLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuDQpQbGVhc2Ugc2VlIHRoZSBjb21t
ZW50cyBiZWxvdy4NCg0KPiBGcm9tOiBNaWFvaGUgTGluIDxsaW5taWFvaGVAaHVhd2VpLmNvbT4N
Cj4gLi4uDQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCBzcGxpdF90aHBfd29ya19mbihzdHJ1Y3Qg
d29ya19zdHJ1Y3QgKndvcmspIHsNCj4gPiArCXN0cnVjdCBzcGxpdF90aHBfcmVxICpyZXEgPSBj
b250YWluZXJfb2Yod29yaywgdHlwZW9mKCpyZXEpLA0KPiB3b3JrLndvcmspOw0KPiA+ICsJaW50
IHJldDsNCj4gPiArDQo+ID4gKwkvKiBTcGxpdCB0aGUgdGhwLiAqLw0KPiA+ICsJZ2V0X3BhZ2Uo
cmVxLT50aHApOw0KPiANCj4gQ2FuIHJlcS0+dGhwIGJlIGZyZWVkIHdoZW4gc3BsaXRfdGhwX3dv
cmtfZm4gaXMgc2NoZWR1bGVkID8NCg0KSXQncyBwb3NzaWJsZS4gVGhhbmtzIGZvciBjYXRjaGlu
ZyB0aGlzLg0KDQpJbnN0ZWFkIG9mIG1ha2luZyBhIG5ldyB3b3JrIHRvIHJlLXNwbGl0IHRoZSB0
aHAsIA0KSSdsbCBsZXZlcmFnZSB0aGUgZXhpc3RpbmcgbWVtb3J5X2ZhaWx1cmVfcXVldWUoKSB0
byByZXNwbGl0IHRoZSB0aHAgaW4gdGhlIHYyLg0KDQo+IA0KPiA+ICsJbG9ja19wYWdlKHJlcS0+
dGhwKTsNCj4gPiArCXJldCA9IHNwbGl0X2h1Z2VfcGFnZShyZXEtPnRocCk7DQo+ID4gKwl1bmxv
Y2tfcGFnZShyZXEtPnRocCk7DQo+ID4gKwlwdXRfcGFnZShyZXEtPnRocCk7DQo+ID4gKw0KPiA+
ICsJLyogUmV0cnkgd2l0aCBhbiBleHBvbmVudGlhbCBiYWNrb2ZmLiAqLw0KPiA+ICsJaWYgKHJl
dCAmJiArK3JlcS0+cmV0cmllcyA8IFNQTElUX1RIUF9NQVhfUkVUUllfQ05UKSB7DQo+ID4gKwkJ
c2NoZWR1bGVfZGVsYXllZF93b3JrKHRvX2RlbGF5ZWRfd29yayh3b3JrKSwNCj4gPiArDQo+IG1z
ZWNzX3RvX2ppZmZpZXMoU1BMSVRfVEhQX0lOSVRfREVMQVlFRF9NUyA8PCByZXEtPnJldHJpZXMp
KTsNCj4gPiArCQlyZXR1cm47DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJcHJfZXJyKCIlI2x4OiBz
cGxpdCB1bnNwbGl0IHRocCAlc3N1Y2Nlc3NmdWxseS5cbiIsIHBhZ2VfdG9fcGZuKHJlcS0NCj4g
PnRocCksIHJldCA/ICJ1biIgOiAiIik7DQo+ID4gKwlrZnJlZShyZXEpOw0KPiA+ICsJc3BsaXRf
dGhwX3BlbmRpbmcgPSBmYWxzZTsNCj4gDQo+IHNwbGl0X3RocF9wZW5kaW5nIGlzIG5vdCBwcm90
ZWN0ZWQgYWdhaW5zdCBzcGxpdF90aHBfZGVsYXllZD8gVGhvdWdoIHRoaXMNCj4gcmFjZSBzaG91
bGQgYmUgYmVuaWduLg0KDQpUaGFua3MgZm9yIGJlaW5nIGNvbmNlcm5lZCBhYm91dCB0aGlzLg0K
DQpBcyB0aGUgUmVhZC1DaGVjay1Nb2RpZnkgb2YgInNwbGl0X3RocF9wZW5kaW5nIiBpcyBwcm90
ZWN0ZWQgYnkgdGhlDQptdXRleCAiICZtZl9tdXRleCIsIGFuZCB0aGUgd29ya2VyIG9ubHkgbW9k
aWZpZWQgaXQgdG8gZmFsc2UgKG5vIHJlYWQgb24gaXQpLiANCkluIHRoZW9yeSwgdGhlcmUgaXMg
bm8gcmFjZSBoZXJlLiANCg0KV2lsbCBsZXZlcmFnZSB0aGUgZXhpc3RpbmcgbWVtb3J5X2ZhaWx1
cmVfcXVldWUoKSBpbiB2Mi4gVGhlcmUgc2hvdWxkIGJlIG5vDQpzdWNoIGNvbmNlcm4gYWJvdXQg
dGhpcyByYWNlLiDwn5iKDQoNCi1RaXV4dQ0KDQoNCg==


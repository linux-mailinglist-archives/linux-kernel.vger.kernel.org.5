Return-Path: <linux-kernel+bounces-74217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE94185D13B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2762B21E28
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA043B19B;
	Wed, 21 Feb 2024 07:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T2/24zZ5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712743A8F2
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708500179; cv=fail; b=TPPp0cmHZna+ZsxOMYErf1zF9UZmyi4JwBV7hrIaqz7g2dv/bKLVuQQnBo3P0NfO6SnXv5I3QrFfeiY1WKWhUkhKrfztEufnNz5q9niAt2S8qyNw85GVA9ZzEsxp4z/TDmPlS8fKwkDgA0LDBzxF+31Ajdv/lukV7pBj5oF+Suk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708500179; c=relaxed/simple;
	bh=u4WeMbA7Q+FTu7TsuGrITuKDIIkveCtqut24XeO2oPw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AtjPr6WOhZj0irOl0n8GD4WsQGrlaQMPORDExt41vf3eidsBtXGHCDHLFaE7Dsylbrb2DBo0ddJ8UwviP+2KkvKpAv5Nafrl1V3piyTG0S7R4tju5ZV/rAHn1nh9DyT4t1XDFOVgx0Ht24waWMdScRRj4EAiVKwjMcc2YbBKZ3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T2/24zZ5; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708500177; x=1740036177;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u4WeMbA7Q+FTu7TsuGrITuKDIIkveCtqut24XeO2oPw=;
  b=T2/24zZ5+Djo1jBS1KRvD1ZtSJrQcfRFvpuszeSVBT7Fjt/5hJuzhvWX
   c+DPWbatQry9hpZlABOlB118iSUbKGBNg7x0tcHeJr1YXyV1+C8IBY2Hb
   tu1R8Y8XFeZZ1QPq6P1FFSDnaUjo/IAJPSq8OHngcx3yrnDC+87IL6Ln0
   36CZlGlCTB3LvvyMnCWo1dKdx6PzjOHuz8xDYWO8O8rImhbl2G7122WUs
   fnhP90CQuJChFkEVJUOjI/1rtm4Utzka58LTq8iGmhZ/bX8Iij+PFjGti
   KFOclNRClnhPT6kY61/j8jjYUIci3vQ7fUOHw6HaGHb9W967j06b76pmI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="28087926"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="28087926"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 23:22:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="9684124"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 23:22:54 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 23:22:53 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 23:22:53 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 23:22:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCKnMXOxM+6nZmnC4q6K1fsEtzTIGxEgC6LvQv8W7bGD2+//2cmtnzT6pc7RE9S+X2kUK7xvZik5eXkuqmDlXRxCIllqLgE2R9yqynLsmPMiNnN8+cuGMHvkidHE3gu47gmu9sZp9j0jRDcFgEQmg4Mcx87cLPfAq/ON1f3LD+/idCYTg9YzURWL9UPwr4KRK5RUID8GrAW23s9rW8MzBpvEOiX4BUVw4S9Z5tGiYJYonzNKb11g1ajHMiH5H00J8h5C1rBgh1egVwkBtdS6pa/eihcuFF4hzqsdII2KC3dErt7Qj25dph+RFjffzOJ8S/ttludojI5xZhLYXIabWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4WeMbA7Q+FTu7TsuGrITuKDIIkveCtqut24XeO2oPw=;
 b=js7YRUtLKsKVe5SAwsVrA3U6a5Yf3HXmLKVUKdtK5Fk9IvQArSg/gHjcy+JymkJM6OzwzKwARmabGE39DFgpGLRVZ4xAHhgQc/GYm9kusGaPK7L1hhKLlrtXMc9MatBopLLj5kFrDip5fOrLTyBTOBX+hYkpP0qegmnXAzo1m/2lUf1s4HDER5Ur2eahxDllt+4dHdMDQf5wqxMSiXMekk1TAu0M/E8sHsWELcwWpWNqyghx9SRMRHdbmBR/PAlH8J6kgFcxcIKyuZsWwyzHWukznXQpHnqQlQjYNF4fxrBqtFrA6BSvbCaeq/pOBD31JIgBXyxoZLl2k6uBEXv9cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB6266.namprd11.prod.outlook.com (2603:10b6:208:3e6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 07:22:32 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b0e3:e5b2:ab34:ff80]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b0e3:e5b2:ab34:ff80%6]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 07:22:31 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Joerg
 Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Jacob
 Pan" <jacob.jun.pan@linux.intel.com>, Joel Granados <j.granados@samsung.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/8] iommu: Add iopf domain attach/detach/replace
 interface
Thread-Topic: [PATCH v3 1/8] iommu: Add iopf domain attach/detach/replace
 interface
Thread-Index: AQHaTQbdnqiGZVOmpEOcHKLJUGm2irD+nkbwgBXcBoCAAA4BwIAACr0AgAAAREA=
Date: Wed, 21 Feb 2024 07:22:31 +0000
Message-ID: <BN9PR11MB52767FD1AD645F097C27D4088C572@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-2-baolu.lu@linux.intel.com>
 <BN9PR11MB527629BF9A0E27E36D3925B18C452@BN9PR11MB5276.namprd11.prod.outlook.com>
 <b0f5e418-8faa-45d1-b086-61f6c009c0cb@linux.intel.com>
 <BN9PR11MB5276151E34AC91883986A39D8C572@BN9PR11MB5276.namprd11.prod.outlook.com>
 <e77922a5-89d3-4036-8d98-9c3fbef4f39c@linux.intel.com>
In-Reply-To: <e77922a5-89d3-4036-8d98-9c3fbef4f39c@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB6266:EE_
x-ms-office365-filtering-correlation-id: ee37660f-49fc-4a76-49fe-08dc32adde3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: faHRd7Qd2NDYTGU0U+yLImppWehM4eseCmU4nK9vAlBhB1PQnxQEG/hGTC1PFuLAgegt7ogR5hicX72N+HcTBLd9nriTNhxikYpcrbKzkK9si01U2N5djAZSZs7bVjqsQUjXgP0FnBMaRtf+rVJ+7l6jeN7Zcme6CgcczCbBRPvgGvm693kvSPeNdbmLUzMsbztpI4FxrZAhkyzdJCAj/1Laauw1Pj56/MHmF9hBhW3FOEjAuWew4IG7HJP8IYOLWN+NB2klawriRqAaMAbDaEZb8mMWv2T0nafdmj4xkY0W37LiV9893Kpz7lUHc9d6WYlIsCMwua7zuPgyz47VggkSOA3xPBdsyLYaydyiIB8mbeh3hSsY33ltz1Iie1GpGeQN9XsRaxF3MzT4fyfXW2D0O3K2CKlTn2hv1Zkw26tyklw8MGmhgn3YbcmYP/fHXe7kAjOc2LHbWoa23ZLy3aCXlxJR1g+o1YEQvPhQvNJYBfjVSjnxdT80mC43M76iAnn2lWerOlyEJdP6j//0LUKw446CgjeM808PApf+np7GrPY2WQWXQgJCF8AUN9u8K5h896zIQhY8MNJF98MB46h11mmnh9nvcrSLQ7feaMzwYNsZZS9S59UED6MYrG5fCaf4F1lV7kdT6W81vv64XQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkgxMFFyRTlPd202a0RESTQyTzR2MzZPZE5hSi9rekd1amN0a2hCMkJzSFhF?=
 =?utf-8?B?Z0NQTlNXV1hISzhWL3BhZmRkYndCZzBMTDc5ekhab2U0VTVaWkRucGtBc3dX?=
 =?utf-8?B?SVZqejBMMm9ULzAzS1BPRTYrR0pJOGNuOHZZTnVUaGE5UTBrSlFtYXNybU1U?=
 =?utf-8?B?VjlwTXB5UWFlU1F3U0ErZTZDMTgxZVhtK2tGdmtpVEN1cVVMUkxZcGR4TmJs?=
 =?utf-8?B?TmdYQWs3dzlYNWVKL1ZUbEkvRno0TXpDeXBIME5xeGFiWG9RRUFnWUZWK0Jv?=
 =?utf-8?B?c0hmL0dRc0NUTmpDbi8rOVdmYmEvaGxnMmc3bTY1ZDhITUZZWmRFa0RSaS9K?=
 =?utf-8?B?OUdQVjRteGdCQmxOU052T21Rem1NUVhjSm84aGJJaXgvMEVJL0VpL3pGdXY1?=
 =?utf-8?B?RkZtNEdLU1N1Mm52T04xSnRLSExYSzZSZVN4V25vZDJtR083T21KeUpQeFlC?=
 =?utf-8?B?aXloNjIwN0U5c1NIOTIvTEhxSnpDRW1lQUJKVEJhWG42V21Ua0txT2o0d0JZ?=
 =?utf-8?B?cXZwUzFvVVA3MUpSRzJUZjVMNVk1Rkx4Tkl0L2FvM0dqaGk0NW0xaHpuY3By?=
 =?utf-8?B?YWVzS1Q4RWkvZGxkd1NXeHBqa2N6NXMwa29oUzZRLytCNnBvR1RiZTNxeWdv?=
 =?utf-8?B?RTEwZUJJdUFicXRVMTdvK1l3TTNxSTBBTmkvcG9UZVZNYTRWMDNla0E2azRT?=
 =?utf-8?B?aW5JbHozZU1QYWFVdHdsRExEckVrd1dKdnJNZ2hlWS9selFMUjE3MUx1SEpD?=
 =?utf-8?B?SGlOaXZ4MDdlOFhIc0FhbDVmdncvVU5lZVdEbC9tWHdmZG1kZVJSdXNadkRB?=
 =?utf-8?B?cEYrNFV4blJqa3FyVWRYVGlEalZadHlPSHNURUtJU1BZKzVPS2tnOU10bGZJ?=
 =?utf-8?B?d0pEUmhRMVNmZVloZGVGSjJsUFJ6MC9RT3BTdzhGU3BsYkRrbkpxMTNRQVB0?=
 =?utf-8?B?NzdheXNEcDlKTFlWZnFqNVFUYzB2ODViR25aUVp0dVUwVlN6cjQyUDRvejFI?=
 =?utf-8?B?MUpSVGkzTW94cFgvdHdXYURqblRWcFBPOWtQb2tMSjExT0pmbDJRUEVQdzN2?=
 =?utf-8?B?cHJ1TVpoS0IxN0tDdEZIcEVKOVBzeUw0Z1RGRHgwa0JzOG9rdzYxV25YWWVP?=
 =?utf-8?B?NXU4VE5Nem41Y055MDRBb1p4V3RjUEl0Y3RKNEY0UjFIbW5aVU80NkUyVTdX?=
 =?utf-8?B?RU5EMkJSWFFPMVJCUHB2cUNSMzFGdm10bElhcFY0akdnbktsTTVvWTVMdTVs?=
 =?utf-8?B?N0dQd09ONVdSQUJTUWwvaS8zREhYWktCaG9mNDh6V2dmYXZDaHhEenJQV2Yz?=
 =?utf-8?B?R2MxZ0UwMGppRWZDTmV2QUx2S0NpQndjSURwNzVsNUZ4QUdtQm9BSzg3aGQ4?=
 =?utf-8?B?eWxZdjBYWVhMSmlzOCtRQW5YMUUyNFJ0LzNQWElsVTMvTDF2YnZ2aktSTkI4?=
 =?utf-8?B?dVp1VkxMbTRNV0JWN09GTVpGaHphcmJZTVlOSnlUMms1N3dhUlBxTTMyUGEv?=
 =?utf-8?B?T0U4bnd0ZDROTmJ4YjBxRWFnQlBRclBNMlBsVVZsYUN3cVZxUmhmam94SENh?=
 =?utf-8?B?dEZNcTVrWGRqVUVVWHhRbVpaMlBEV1JiQzZvRzV2WXRnenBvOEpPWXQyYm1N?=
 =?utf-8?B?WlpNWFF4NGJCYysyd1o5M2JPeFJ0VTBpSnJCNkpQZE96ak5PYVE4dWV2dmVM?=
 =?utf-8?B?ektXdTdXejBWcjlITGVYTzMzZDBtZ1lxNjJnTzB3cG5rUm5uU2lidHhjQkRU?=
 =?utf-8?B?Y05IV01ZYWRKQVl6eDdnR0FDa3YxdWp1d0lsQUQza0pEZmxxNEhjeGtaM1Y1?=
 =?utf-8?B?MWJrT1QzZmx3QnlIaWQ0Y3dIZ0hIUTljRE90L2phaDA2U3AyRHZwN1QrV1hF?=
 =?utf-8?B?czEzQzRzcjE4cFBLVUx1eC9QLzVvcmlCODNRK2QyOWIyZTlsKzdDL05OVnpF?=
 =?utf-8?B?VzAyTnliT3hqU0VUN01NQ3pMR0JNdTJTbE0zVlVXMWMvMm1tWkZlNDZRK3Er?=
 =?utf-8?B?WjRRYi8yV1JzK25Xdkd6TzRXMUdOUkhsR2xFMk85enFoYUx1ejEzeHZJUVIw?=
 =?utf-8?B?ZFFNVTBXbVNzaVlZanIxemtFRTRTSWdtcFhPNTFFZmlUNkYrNEdUd0RxeHJq?=
 =?utf-8?Q?NL3nhWivocnCtXiMB7IXyd4xe?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee37660f-49fc-4a76-49fe-08dc32adde3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 07:22:31.8749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NVewlLi2TL7Dm1o8wyMq9rG4/QAlHxf5ryXQwOnMyzwIYRThaaLWLITHaxKL/VeN2HiFVWH5fG5AJ8VIXyCLQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6266
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIEZlYnJ1YXJ5IDIxLCAyMDI0IDM6MjEgUE0NCj4gDQo+IE9uIDIwMjQvMi8yMSAxNDo0
OSwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4+Pj4gK3N0cnVjdCBpb3BmX2F0dGFjaF9jb29raWUg
ew0KPiA+Pj4+ICsJc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluOw0KPiA+Pj4+ICsJc3RydWN0
IGRldmljZSAqZGV2Ow0KPiA+Pj4+ICsJdW5zaWduZWQgaW50IHBhc2lkOw0KPiA+Pj4+ICsJcmVm
Y291bnRfdCB1c2VyczsNCj4gPj4+PiArDQo+ID4+Pj4gKwl2b2lkICpwcml2YXRlOw0KPiA+Pj4+
ICsJdm9pZCAoKnJlbGVhc2UpKHN0cnVjdCBpb3BmX2F0dGFjaF9jb29raWUgKmNvb2tpZSk7DQo+
ID4+Pj4gK307DQo+ID4+PiB0aGlzIGNvb2tpZSBoYXMgbm90aGluZyBzcGVjaWZpYyB0byBpb3Bm
Lg0KPiA+Pj4NCj4gPj4+IGl0IG1heSBtYWtlcyBtb3JlIHNlbnNlIHRvIGJ1aWxkIGEgZ2VuZXJp
Yw0KPiBpb21tdV9hdHRhY2hfZGV2aWNlX2Nvb2tpZSgpDQo+ID4+PiBoZWxwZXIgc28gdGhlIHNh
bWUgb2JqZWN0IGNhbiBiZSByZXVzZWQgaW4gZnV0dXJlIG90aGVyIHVzYWdlcyB0b28uDQo+ID4+
Pg0KPiA+Pj4gd2l0aGluIGlvbW11IGNvcmUgaXQgY2FuIGNoZWNrIGRvbWFpbiBpb3BmIGhhbmRs
ZXIgYW5kIHRoaXMgZ2VuZXJpYw0KPiBjb29raWUNCj4gPj4+IHRvIHVwZGF0ZSBpb3BmIHNwZWNp
ZmljIGRhdGEgZS5nLiB0aGUgcGFzaWRfY29va2llIHhhcnJheS4NCj4gPj4gVGhpcyBtZWFucyBh
dHRhY2hpbmcgYW4gaW9wZi1jYXBhYmxlIGRvbWFpbiBmb2xsb3dzIHR3byBzdGVwczoNCj4gPj4N
Cj4gPj4gMSkgQXR0YWNoaW5nIHRoZSBkb21haW4gdG8gdGhlIGRldmljZS4NCj4gPj4gMikgU2V0
dGluZyB1cCB0aGUgaW9wZiBkYXRhLCBuZWNlc3NhcnkgZm9yIGhhbmRsaW5nIGlvcGYgZGF0YS4N
Cj4gPj4NCj4gPj4gVGhpcyBjcmVhdGVzIGEgdGltZSB3aW5kb3cgZHVyaW5nIHdoaWNoIHRoZSBp
b3BmIGlzIGVuYWJsZWQsIGJ1dCB0aGUNCj4gPj4gc29mdHdhcmUgY2Fubm90IGhhbmRsZSBpdC4g
T3Igbm90Pw0KPiA+Pg0KPiA+IHdoeSB0d28gc3RlcHM/IGluIGF0dGFjaCB5b3UgY2FuIHNldHVw
IHRoZSBpb3BmIGRhdGEgd2hlbiByZWNvZ25pemluZw0KPiA+IHRoYXQgdGhlIGRvbWFpbiBpcyBp
b3BmIGNhcGFibGUuLi4NCj4gDQo+IE9oLCBtYXliZSBJIG1pc3VuZGVyc3Rvb2QuIFNvIHlvdXIg
cHJvcG9zYWwgaXMgdG8gbWFrZSB0aGUgbmV3IGludGVyZmFjZQ0KPiBnZW5lcmljLCBub3QgZm9y
IGlvcGYgb25seT8NCj4gDQoNCnllcy4NCg==


Return-Path: <linux-kernel+bounces-84461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D29FD86A707
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 04:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A6661C2476E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C441D54C;
	Wed, 28 Feb 2024 03:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="amh3WNb7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE861F952
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 03:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709089714; cv=fail; b=ZA0Wi/LokBw3tvWGpTbR0uNHKhNFTbnLixcEfmuOfyGWrPNQ4rM/hQpV6MfitXXvRySvECVVNfjEfHezDNFu7KTy5OXTsBcp1vCaWHvtDKuI9rTh36tjanOw82arrc2MCFIA3/SntT8H4aoB93G2hKDjJ9fKwLTkSsmDy4kUiGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709089714; c=relaxed/simple;
	bh=fa2qDAT3VhoLRDedWDHNxXDWl0M7HwnNE1bG05W4HtA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K+m93XTOGupmjpC0u++Tquk7l+7TgomighEOroa9tmWgGMAz+qyiSPzEcAXKBbs4HNvrZ+7tziraerQw/Iav27E+xBoqudros7lDSZCessRlHzlqyfUCfY7tsw/54D2BKcqXj713Ax84oUyZRWTPmtxIjDhJu5gYXdBXmiFE63o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=amh3WNb7; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709089713; x=1740625713;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fa2qDAT3VhoLRDedWDHNxXDWl0M7HwnNE1bG05W4HtA=;
  b=amh3WNb7lLw5bWAwRw8BELJsr6b/AToeH2N3/X0culzAKMp57wmzC9Fs
   butf3S1OIsRza+94PRvgaMeD9qsmOkJSIqDX5GdQ/iReRgiwRPK5cuJM1
   kvyeLtnsd4UdqilgmVrEYwbLZ2TMaBGJzynfqSy/H37+KOxjMwGSYSoDr
   sF+SIvH3XqftYhcuAXdnoXwMh4komnxU4M6ggOfTvketSD6qvJR11ZKNw
   wAHA+/7EgCnrWGKCICCgFUlnWjtJaeMWps79EdlRRa56BlMEIAD9eNwAd
   LeEeftlIO9ZaXTyNSXLSMS0I1881lXwPL2WdOVnod/z40YDK+o/kElgZV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3634317"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="3634317"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 19:08:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="44788933"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Feb 2024 19:08:32 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 19:08:31 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 19:08:31 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 27 Feb 2024 19:08:31 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 19:08:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVhE2fKT3feI7nhPSNVE0USgvbT2UbpJV/yw/ZaUsVivhwGNbdo+LOKNHkPqbrrOMlo1eBlQtcm9Kl25KGRVvNpuODWlTMuxW6YUbaZe/rrQr4BY2G3TPgkzio9U9ahvcNufLemRmQqz9GSNuBo2LGQyS1pECE5CnvIMppZ/EPO4jBiqCe3QQioCDZLMwQe4xEm1kQCcVxp1Xmvj0Ut/IqKUeWXlixPGcu3oJZineB7YKmXeT21s8MKMG4sCTnUxSychup2syPQlA433WvaB+yT+Ec1hlrV7s13kzA5juFiEvAJz+ll1h8/OCUnXdSrj/A9h+9Q/Lw4YF/ipEu968A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fa2qDAT3VhoLRDedWDHNxXDWl0M7HwnNE1bG05W4HtA=;
 b=ffKOXIJpTQxgBDP7IStn48yDpSAMBM98qp5V1civWjvpltGCIYclYbZAklUZk+baGQP+c2FNTaDFrbgaUaAkX82qKebHPNPGI8Dim2KoHBDJJRzuFyTmgk6Sytmu+08VHBobGlJoK1UvjKLPzbrrM5ubxD/+K6fnnKeeJp370Q2H9OITl1RitWC13Ll2Y8jr7ZnKZz0l5CPIy3nIZyiJj73Olnv+UkHnWEsy+5SrfAaf05HxXUCQDJ0dezMjYSWQUXh84JJdkT71wAphJs0Gswt01+IkMkvCD+ZruAsJ9DVMQbNgtgoQ997T84/Ew3ohGYwPqLG4RbXaJWjlM+H5bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB5454.namprd11.prod.outlook.com (2603:10b6:5:399::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.26; Wed, 28 Feb
 2024 03:08:29 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b0e3:e5b2:ab34:ff80]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b0e3:e5b2:ab34:ff80%7]) with mapi id 15.20.7339.024; Wed, 28 Feb 2024
 03:08:29 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Badger, Eric" <ebadger@purestorage.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] iommu/vt-d: Fix NULL domain on device release
Thread-Topic: [PATCH 2/2] iommu/vt-d: Fix NULL domain on device release
Thread-Index: AQHaZhfXSwaK0zWAdEOfbi7sTGWj9LEd0iRAgAEq7ACAAB168A==
Date: Wed, 28 Feb 2024 03:08:29 +0000
Message-ID: <BN9PR11MB52763A554039BB4176214E148C582@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240223051302.177596-1-baolu.lu@linux.intel.com>
 <20240223051302.177596-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52763D19A01C804FB514419F8C592@BN9PR11MB5276.namprd11.prod.outlook.com>
 <64a1f1ff-793d-4bf7-91fc-00984336594c@linux.intel.com>
In-Reply-To: <64a1f1ff-793d-4bf7-91fc-00984336594c@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB5454:EE_
x-ms-office365-filtering-correlation-id: 264224c2-94ad-4874-9ad7-08dc380a89ad
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IPRI2sBuxu7+2DVywXwgciIj6Op7O/IcJpbH1GmiIkGHwfoizRSITbVx+xl/oUH9MO3C8UJp9gub4tuIXt9IVzzs7UGRfg6q5/knkciVvScQp0a3rqAQd9w7DoGuLAnoqzpmNSwGpnBZzhbb3Xqgj+DVRl6sm/4sXp0zZkfQoj+3+FtcjKVOxZL3D7nuLngiF5mAPs60efjYOyayAuPhe7mUp1v0mmKyafGS9OyG+KOS+v/wFNKFQ+lqB1mr+GD+nzQml/5cZFFP4VTmRMfXHFI9iJWvZ+me9jPD8+h7MqBCafv3roErDYXQTj03aNZjiFOfGwkmt5W8U88kmZvusQLYX4VZDfATpha+9XbyC51FVtOYwQSiN1frpQNL2dvsUme9YcAu/Jzy2rnqm6yFnomHpJ4sRmRDZOAQYtGxa5joZx05NsB1Vari1+8M7wrPW/KUfZbzw0/aURMTYMDf//BFikEDDcfhPhB9fqajBFL7lLdj4/626FOHU/9PWviWcKJB7kdVUhKHh325bkssSeEqzCzlhb6HvjX9L8ue8jZ6AUIDCEPR0vjkwSLm3WpfzalREnJGhjr4rA6AB8goa99PWS2Z44QxMRGdTtuIURcyW6KFVvJOCDx27xbyalK9C1cl+j4GHMUfOnfUuJI/istqRM5oAE8nFHpHlg7otd1TNMIS8hNeRdaigPo4Rc2estwWfunqF1DvSiHJx2pYkMCTA36WcP4OAKUHx3XQnXA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlJaQ1pMa2d1Tm9BZE54R1JtMWVGeVFTMjFPeTNVWXhRQWUxWUwrUyt1ajhY?=
 =?utf-8?B?RXpIVE9pRER2cFhnaUZQNENYRFdjTWNUM0hLcnpzQWpDeHliaHhmRkJuY0Z6?=
 =?utf-8?B?SThoY25hVTNYdEFSK3dWa29kWlNXSWMwWkRTMWliRmpjRkt6Y1dYT0xXU0dp?=
 =?utf-8?B?OTI5V2JPRHVIU0c4UWxBRWZlTDlxZSs3dUwxTjN5RXN3T21Day96ZXNjYlMz?=
 =?utf-8?B?UDdPYXprSHNwZFZKNGYvNDJHNDB1TWU5dk9LekNJS2t3SnpYM1luUEJpNzAy?=
 =?utf-8?B?S2k2Q1d5MXl6UlIwUm5OSjNDeStJK2NFdEJsczI2bEExTzJHT2w0bUxxazJP?=
 =?utf-8?B?dkg4SUQ1K3U4WXVhZExYcjk4MlRQQ1NqY3JucFNacVlXZ3UvV0tDZkZnYjM0?=
 =?utf-8?B?REUyWk1rR3NndkZlSXNjWWIxNk1PSEt5UHUxeE5heXc3MDc1K0JUVXRkeHZx?=
 =?utf-8?B?aFdGS1p3WE9Pb3dKbkRxM1ZKQ0QrMDVjd2pzVFJRb1V4WW81bGM5dXR1MVl4?=
 =?utf-8?B?M2IxS2gyUjlNZlFFVS9JQkFlY0hlWWZ2L2VuM0F2NEw2YUJJa0h5bHFUbDRl?=
 =?utf-8?B?NjYzcjNTcS9ZZ2VxY1l0QldtK0w5VUhNNkNaS2NWL2h4SVVtRUJaZWN3Nzlw?=
 =?utf-8?B?Z25nNitIVk5WY3EydTBNRmlkOVN3TlFmRVgrYVZ5VEtieGJzQVR2MjdVMGsv?=
 =?utf-8?B?NmxSQ2JIRklDRDdVY0xSN0tvSGMwSTNPN2dFK3ZhTGV4TkVtQjd2b0t3bEhO?=
 =?utf-8?B?WVZCSkdCRjQ4NFNpYmNleEtxUFJ6SE1oWjQ5a282V0VlT1ZXVVIrRmJSU2Fp?=
 =?utf-8?B?anVBbmxJdTJRZVhkSWZUK3Fhdk1ER3cwK2FIT0szbStOOXMvTFFqSHRjeVgw?=
 =?utf-8?B?K3Brdm12eE9IZjBZeTBqa2RuQ0N0VjhqMGRieHVMZU1jR3AvdnZydklrejNh?=
 =?utf-8?B?Y0VOWkRHMzU0UXAyZDBydUNVMCtTd1FNMnlvbk54Tm1rVUhtNUowbWZTT3M2?=
 =?utf-8?B?eFBkTTdhRU9ZNEQ3bzVqWlNjN0JjYmxxMk1YRzBJejRaK0pKOTF3TUh6UDVE?=
 =?utf-8?B?Y2ExQWk0TjZpL1hzUVVBTVNXUVBFc3dtSEgvWktLc0UzS3JjV2ZDUVNySFVq?=
 =?utf-8?B?OGh0RFhDOWhpeXdnODNTR0Y1UHRiL3RHWC9oWlExNmx2bGE5Tkh2djlQWlZT?=
 =?utf-8?B?Ukp5c2xLcGt5RE9QQk9jQW9BNWxEeEJ1OXM2UGFOSzI1NXZlcStPV2xVR3J3?=
 =?utf-8?B?Ynk4ekVlTDh1QUtQYTMwM1ByNWgwZmNHYWdLMWpYUnFqWU9xNWJxRnBESmpz?=
 =?utf-8?B?c0NIVmhlbHdQVkFYZ3FENWpWMmNoNjRDMTdMZHJYMmNPdUJVZlFrMktTRm55?=
 =?utf-8?B?THIvYWhGcWwxMEVQUCtIeTM2ZXJBejNCaGFBY3NBRHZ5WCtGc3h3VEZ4QjBn?=
 =?utf-8?B?ejl2bFBWeHVWcm1pNkNlUEhzOGN5VHRPWUJ2YUI2SWdldXJWcFBLaGxQVVBz?=
 =?utf-8?B?MlBMWnY4ekJ5b2tKQVo1bTUzN0Urb3g5MVFuK1FBQVB1VGY3Q1R3WGFuQUFO?=
 =?utf-8?B?Rm9IZmFnby9FOWVaVkZEUkpEdXBUZGtjcGFRM0hsY1VhenpZQlNqRHdWMHZo?=
 =?utf-8?B?WmZSTXFZNWNSQzVZSVExSWJMVFo1bEFnZmkrazVXWlgydkY2dVM1RldiL3BH?=
 =?utf-8?B?NjN2c2xpZWJkM2dKYnczNnhwMVRkME5XMGhvZVhMTTFVZEZjL1RtYk45MFlV?=
 =?utf-8?B?L1lxM3l4TjZIQ3E4RktJM01OMXFXUFMzZUR5bzg0UC9HcVNSMk9wcCtBVHFx?=
 =?utf-8?B?LzRicTNwVnpNVnQ3SVpIbkZuUVBMSlpYTWZjZUN0SmFEWGRMRlpDZGd5Q3RL?=
 =?utf-8?B?eThlam1Eck9Wa0lXMUNNbVFxQTB0UGVORy91ZzJ0cksvTnpua1pXaVBYTU1Q?=
 =?utf-8?B?YUYrTjUxdTZKUDVMUUZlVC9LQVVoRFh6amNWQk1GSHhsak45SVdiUmdGMGhl?=
 =?utf-8?B?Nm9BM3RKdzNWMGc2dmVIdGdqdkZvM2JlbU5TWFRqdER3TUZtM2dZY0dlOGRQ?=
 =?utf-8?B?dURJZ3UxeDZnNXQzSk9RRUU4QnFxenNid0ozK2pEcmQ5dFhUbWFncDNTNnlq?=
 =?utf-8?Q?C43PzF1rRknsUsU0l5ypS9KK8?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 264224c2-94ad-4874-9ad7-08dc380a89ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 03:08:29.0411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4sTrPuRkhcDvhXrXRAg40HgEW21SU+5+f9ts6Lg+atsL3uvDQQZ0iOkcX/ci2hD9A87ReMCeqOOp/Z/9yr4Isg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5454
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIEZlYnJ1YXJ5IDI4LCAyMDI0IDk6MjMgQU0NCj4gDQo+IE9uIDIvMjcvMjQgMzo0MCBQ
TSwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4+IEZyb206IEx1IEJhb2x1PGJhb2x1Lmx1QGxpbnV4
LmludGVsLmNvbT4NCj4gPj4gU2VudDogRnJpZGF5LCBGZWJydWFyeSAyMywgMjAyNCAxOjEzIFBN
DQo+ID4+DQo+ID4+IC1zdGF0aWMgdm9pZCBkbWFyX3JlbW92ZV9vbmVfZGV2X2luZm8oc3RydWN0
IGRldmljZSAqZGV2KQ0KPiA+PiAtew0KPiA+PiAtCXN0cnVjdCBkZXZpY2VfZG9tYWluX2luZm8g
KmluZm8gPSBkZXZfaW9tbXVfcHJpdl9nZXQoZGV2KTsNCj4gPj4gLQlzdHJ1Y3QgZG1hcl9kb21h
aW4gKmRvbWFpbiA9IGluZm8tPmRvbWFpbjsNCj4gPj4gLQlzdHJ1Y3QgaW50ZWxfaW9tbXUgKmlv
bW11ID0gaW5mby0+aW9tbXU7DQo+ID4+IC0JdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gPj4gLQ0K
PiA+PiAtCWlmICghZGV2X2lzX3JlYWxfZG1hX3N1YmRldmljZShpbmZvLT5kZXYpKSB7DQo+ID4+
IC0JCWlmIChkZXZfaXNfcGNpKGluZm8tPmRldikgJiYgc21fc3VwcG9ydGVkKGlvbW11KSkNCj4g
Pj4gLQkJCWludGVsX3Bhc2lkX3RlYXJfZG93bl9lbnRyeShpb21tdSwgaW5mby0+ZGV2LA0KPiA+
PiAtCQkJCQlJT01NVV9OT19QQVNJRCwgZmFsc2UpOw0KPiA+PiAtDQo+ID4+IC0JCWlvbW11X2Rp
c2FibGVfcGNpX2NhcHMoaW5mbyk7DQo+ID4+IC0JCWRvbWFpbl9jb250ZXh0X2NsZWFyKGluZm8p
Ow0KPiA+PiAtCX0NCj4gPj4gLQ0KPiA+PiAtCXNwaW5fbG9ja19pcnFzYXZlKCZkb21haW4tPmxv
Y2ssIGZsYWdzKTsNCj4gPj4gLQlsaXN0X2RlbCgmaW5mby0+bGluayk7DQo+ID4+IC0Jc3Bpbl91
bmxvY2tfaXJxcmVzdG9yZSgmZG9tYWluLT5sb2NrLCBmbGFncyk7DQo+ID4+IC0NCj4gPj4gLQlk
b21haW5fZGV0YWNoX2lvbW11KGRvbWFpbiwgaW9tbXUpOw0KPiA+PiAtCWluZm8tPmRvbWFpbiA9
IE5VTEw7DQo+ID4+IC19DQo+ID4+IC0NCj4gPiB3aGF0J3MgcmVxdWlyZWQgaGVyZSBpcyBzbGln
aHRseSBkaWZmZXJlbnQgZnJvbSBkZXZpY2VfYmxvY2tfdHJhbnNsYXRpb24oKQ0KPiA+IHdoaWNo
IGxlYXZlcyBjb250ZXh0IGVudHJ5IHVuY2xlYXJlZCBpbiBzY2FsYWJsZSBtb2RlIChpbXBseWlu
ZyB0aGUNCj4gPiBwYXNpZCB0YWJsZSBtdXN0IGJlIHZhbGlkKS4gYnV0IGluIHRoZSByZWxlYXNl
IHBhdGggdGhlIHBhc2lkIHRhYmxlIHdpbGwNCj4gPiBiZSBmcmVlZCByaWdodCBhZnRlciB0aGVu
IGxlYWRpbmcgdG8gYSB1c2UtYWZ0ZXItZnJlZSBjYXNlLg0KPiA+DQo+ID4gbGV0J3MgYWRkIGFu
IGV4cGxpY2l0IGRvbWFpbl9jb250ZXh0X2NsZWFyKCkgaW4NCj4gaW50ZWxfaW9tbXVfcmVsZWFz
ZV9kZXZpY2UoKS4NCj4gDQo+IE5pY2UgY2F0Y2ghDQo+IA0KPiBIb3cgYWJvdXQgbW92aW5nIHRo
ZSBzY2FsYWJsZSBtb2RlIGNvbnRleHQgZW50cnkgbWFuYWdlbWVudCB0byBwcm9iZQ0KPiBhbmQN
Cj4gcmVsZWFzZSBwYXRoPyBDdXJyZW50bHksIGl0J3MgcGFydCBvZiBkb21haW4gc3dpdGNoLCB0
aGF0J3MgcmVhbGx5DQo+IGlycmVsZXZhbnQuDQo+IA0KDQpzb3VuZHMgZ29vZC4NCg==


Return-Path: <linux-kernel+bounces-134745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B579A89B64A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 05:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EC541F2207D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 03:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817A8187F;
	Mon,  8 Apr 2024 03:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Na5BRvpM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04C81860
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 03:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712546088; cv=fail; b=ITwwsZZs8sj6L/djnBmBuKIc8H1LNb80ZQ+lHaxGxO6SRt1ndsYQTA6fyYLFCYn7d9vi/fFkb237uflM45yfeAMvVHO+Ei4nCjclms8OZe/2Euq+MVusIwvEhCbkcWfoYDfl+vRjWqbgsVLjzszaYsEHcP8MLJ6a3bZXyVtS5C8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712546088; c=relaxed/simple;
	bh=8CcrQoQs/NlIjYgc0nc4x9zvkFkruVaWTHNFJCSUfEE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qGt0YMeOugnjpWtiI8IBsYSugq3ILDhukZaDJjgb563BCaMg0hLuQW3POvKao+drYvin9TNgXO7+9/7op4qw1IarM7TmtrW06ItBCNUDT4ioPqlka6HPDFd3DW9I82Eh3J9p3J5D4eZmBVcHXyimoJae6yav3qSdi9uIvkkZXC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Na5BRvpM; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712546087; x=1744082087;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8CcrQoQs/NlIjYgc0nc4x9zvkFkruVaWTHNFJCSUfEE=;
  b=Na5BRvpMHOg1x6ZPuuZPKhMwt9ZOy3rhE0o1DtTHVRKxW6sZy5bz0Hpr
   REmrMLcYJAw1bFwo/xTxC/1IAfqaWBI0KDXglRla7Ytkbeyii1+4syrSf
   H0CW5C6WAYvdTk+gEdfg9t9v5yyDgz5OLa+x/ZztzcwNWzb6ytm2k5R7l
   +HzbQmz2uWV/mcqeAjkOtKaRlnxmO52X5Bdvsj2zNF/gipm4i7Ti5i6ZH
   R+/KSyqA/Iki7Z6JM0LeXYc07zaIyA3aflXnGwWP5SLolbYGtmk3ZL037
   10ldZ8tROWuA3W6IjBEQu1oQz2hWok6TiWMgx4Yd27cPmYKlBi3Zd7Uvw
   A==;
X-CSE-ConnectionGUID: okPciV2iRD2zj9TU6giDZg==
X-CSE-MsgGUID: k9LBioyGShKLgcCFtQuWJg==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="7989623"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="7989623"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 20:14:40 -0700
X-CSE-ConnectionGUID: kZUNBSUIRg69oPxCB6NRCA==
X-CSE-MsgGUID: kWu8kGnAT8i2Up1+dHjZow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="19829947"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Apr 2024 20:14:40 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Apr 2024 20:14:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 7 Apr 2024 20:14:39 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Apr 2024 20:14:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezqkiRKO1zWoi5hpaTrirmy3WgCPaHgSLBbgo1FKYTDIHgjiOCaduc3qKrK24tEwRDVEJNf1FNlbt9xCkenzNPW1+qvWzB0i5hK5cQoZPWQIyNeNWZQSrPLAm7KlmTGpi3+72JFnWW0Hbrj0TLnbatHQWqCLx9OXQW4yy3gN1dgUkYewtuE0Jqg79q3LrKkygHFAtZkvz8qUliCLuFDF4hfrLM6O/MTHDEyTQZsMVPIlnsftWcnNVTVjByGWI57+Uu25ZrrVZunlC0iA9YggunEj8T3m8zSuj9Vu1VS3Qcx9WHyurmOHoQv4f0REoya0Na91dTWsAwFcePxqoiC0Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8CcrQoQs/NlIjYgc0nc4x9zvkFkruVaWTHNFJCSUfEE=;
 b=OIdgTKmHBDmXOkTiPkPhXPShBDXfRc4rEaVGQY2Jx6elhjGHPMsr7z7e+KtLcYjDGsSNrLjO//SwmsL8YIpTA65ncrjm95rU0ZfRjAwqsDjg+EwDGNMNr0DBTZOGqTbVInEPbsRVZ3wN97Fz8s2MbToiueDRG0/pM+VMgMOl7L8iRwCfh3yfPqXlZCDBsOpi7dqYligyYZEZg69c6Z2u4FbxsvEPfe6uYe0TpfgRQfMWklcKnIEyKCiycwkAORaN3lP79iD2Vc/U1r/FjLnrhBUrZsJ9GUu5zz0WrN5X/+4A3M10WsKOyTBmwV+BnczoVKE/lY8/x+PtGuzRanjioA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB5821.namprd11.prod.outlook.com (2603:10b6:303:184::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Mon, 8 Apr
 2024 03:14:37 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7452.019; Mon, 8 Apr 2024
 03:14:37 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "Zhang, Tina" <tina.zhang@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 02/12] iommu/vt-d: Add cache tag invalidation helpers
Thread-Topic: [PATCH 02/12] iommu/vt-d: Add cache tag invalidation helpers
Thread-Index: AQHaflqwAocS3d3S90WqoPDmpOE9v7FMwc/QgA+blgCAAV70cIAABu0AgAAEZ+A=
Date: Mon, 8 Apr 2024 03:14:37 +0000
Message-ID: <BN9PR11MB527685F85BA0906DCBECEB2B8C002@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240325021705.249769-1-baolu.lu@linux.intel.com>
 <20240325021705.249769-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52769F48D89273B0CCAA0B7C8C3B2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <9aeb7dfd-e8af-4da8-b67e-274f3227efa4@linux.intel.com>
 <BN9PR11MB52760554D81E96A9AAFD964A8C002@BN9PR11MB5276.namprd11.prod.outlook.com>
 <7d90bb2f-ea04-4492-b1d4-1bebe54b8ca2@linux.intel.com>
In-Reply-To: <7d90bb2f-ea04-4492-b1d4-1bebe54b8ca2@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB5821:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: huKKiCokeEZXZydP+VuJgUprS6e/+W6dXwXRnqoTUFJucrsnTCRDZnEj3DAK52E0DjJZXup1WFQoQCdWXUuglUEHarHvTx9v+gGrJ8bcV1bhEdjc3dH0bBdQZ3/xKbR5VMMqD8PQQbvUd+/khM+0B7KtelVbVsA3RSX+ziu3qCB8UX70CwVkgYGmmcTN1+BVL1QyjGMCWpvZ+0kztAApcKbHYNmRTRNupwZI3iicoOj/DEtdmGtssTc/Nm2T25XV6ouWE56yRKdeUiaoB6fVGYH6mgvlLc76i9cn2tfvW06XwRG9A+oEco4YtdTn7GgaxD2xAG0dxkw9KAsWYSdzDXrqfszrQcGzuuIgWLiy8F2bTvg663O9drTeowpjBq/Za5D0sNJKkcFwFHQmRp0cOniHTJcJOyZrWT9sWebdDs6nqgE6Gwerps6KBQnI96BRhqh/PKxm3D21/NEmIEvd1rWMnbW/h4yztGVbzet4BjyISPceVQU7qISGyhxENBdGdKqpm5NBRmr9K0WzaMV6YSNRrfTUwe/H685u5i/usYb1mPSMJS4IkFtSXS4JY914br3LGtsB9aTnK0gE9BenbJxlBCbQu3iRcgRQ7hHhWHxqT6wVNn8QLVUE+YUj97w8I4ozfGfhp/Ns/IhAgVvVoE5gGo5wq2TOBw0F8LGuyf8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0ZZejZDM3drbTFFUW9JM0t0dGxIcUloQnMyU3ZlUjI0NzJpRGlMckNEa1JP?=
 =?utf-8?B?T3lYZU1ldytyZ1lCMzcxTUFoNG1PSWliSk90RzhaZ2VYeGxqQzdjWVRJa2xM?=
 =?utf-8?B?UlF0RFlRSjQyR1p3NTBHaTRNYld5VERhRlRRelA4Qlp5R1hJQWUzVXBSNFJk?=
 =?utf-8?B?L1ZGd0ZRTFA3dTlsKzE3MlYzcFVpUXh2bUVtQmdZeDlwd3VVaW1jaEFieVNy?=
 =?utf-8?B?ZmdUd3NqWlFsYm12QmVwb1NLMThGb0o1MmZVTEp4OGordXBVVFZTcCs3UkVF?=
 =?utf-8?B?TjhabVQ2NjdkQ04xOWRNd09LSC94N0RuWlpsOXppQUxIb1J2dG5LWCtNM0k2?=
 =?utf-8?B?L2hMS0hYZSsvRVdqbTdBUnFPZFU3ZVF6UmlhRnV2Q2kwckI4UkVzd00rLzlz?=
 =?utf-8?B?OUFDUENuZVhZNjcxWmwzS0sxVmxmTFlmZUUxOHFXRWVDcDNpZWt4dS9LQlZQ?=
 =?utf-8?B?c0xmZXFNd2xhWjUzZGNmYWtVd2hiaUg2RnNrQXBqZ082dVN6RkEraXkzaE9L?=
 =?utf-8?B?NFZnY2lWS2RWM1BFMXFSOThCVE1TY2hheHBVWXJJVkNsdFZ2WWwyQkdUeUky?=
 =?utf-8?B?UDdmWjFQNnQyblJ5RFRwRFIrajE5WmZEOG9tVnZLVStOdlJjMnRURDU4dHBF?=
 =?utf-8?B?V1BpU1NWRUQ0SnhWTXpDZDdkZm9lU2pNajhnUlZrRFVSV2tLQ3B2WGpyL1lp?=
 =?utf-8?B?L29LUjFCaEZRTk5NaWlKcEhWRlM3QVlpZzdjTXBFMGZoNkJ5TkJZM1FQbmox?=
 =?utf-8?B?bTdaVjVoMHBxMmhMczNpTWczOVZVSGh0WnFueDBHSEU4SWFhN0MvcmovSUdW?=
 =?utf-8?B?STF6UFM2TW1BOHJsNXhCUlRtcGJkckkvY241RWxFTWEzNGVCWnBHVkFNek81?=
 =?utf-8?B?Mys0Vm1RQmF1dDBoNHA4b2JGaW5jM0Rpb1VKNXpaNE9qNzNrME1IblRxNGIw?=
 =?utf-8?B?UW1TRG45QmVWd2VrOE5DMmliSC91VHo0d28wY3VXS0FvZWczYy94dWQxL3o5?=
 =?utf-8?B?M1pGS2JwQWJMSnZYWFlxNWhxTEZlbDRWZXlyb29pcEwxQm9zOHJRV0JCMnJu?=
 =?utf-8?B?elhSWkpIMjc2Q2R0MVFLd25PQ2haNHMvUkR3MXlKYTV6RHhMeXBFRUwyVjFF?=
 =?utf-8?B?SWdjUTc4RzRiVW5DNUNETUd2WUJRdjYwOW1ybm0vM3l2TUtaSlJqakx5RU0r?=
 =?utf-8?B?TzhjQnBPVkd5MnZERWFsZjJNYmJTajV5bGZGTXN5U21FeGsrbmwyN2VQcUUw?=
 =?utf-8?B?WlAwWjhRN2hkQzhIekh5QlBFd0lkTGFnWldZcG1IUnlOZWJkeEk5VXN4WWho?=
 =?utf-8?B?NmJrT1gvaVJvcXY0d25BTDQzWHYxcElVa2l0elBFVS90UFBORlkwUWZrWDJQ?=
 =?utf-8?B?cyttMUVwR3ZYb1BpYUlRNXoybVFWVnZub1hoOWJxQmIwV1ViNHZaNUFhSDgw?=
 =?utf-8?B?T01ZR2RxYmdFZEFLT1J1eE10Ky9nd1NvOXZFSGpsOGFXdTZXNGpNSDQzMUw4?=
 =?utf-8?B?KzRKN3BzZlVMS1RNMndJU09xaVFLWUdXQnVnRHI1MTdFR3FrNzIyaitMajhM?=
 =?utf-8?B?Mnl5eG81bFJLRnludVcrcXliVkpHUGM1TGxOWWhrRWFubk5jWGJTSEJnYnlx?=
 =?utf-8?B?T1M3ZkcrcU5KZ1MycXFwZEpVaHRudkYyd3FYaTlSODFMbkY3RHdoWHJ1L1hN?=
 =?utf-8?B?N3F6Tk4wSGVDWFhIVm12WWhnWmVFeWl0bm44R1BnaFRnY1FWa2h0VmM2eVJP?=
 =?utf-8?B?V1hubCs2R2dPa3dYN1VvN3d1OFdxSVBybmlsYzFoQWdQbDVhM1ovMkQ2NXk0?=
 =?utf-8?B?WVppQ25lOXlTNmk1dTBKN1lFWG5SZUxNVHREVWlyaFJTRDBNY1k3U2xmbHMy?=
 =?utf-8?B?NktwUVpSbFFadFNQdFBjemduNzNvUVNKNlErTmo1WFYvdFZEakV4dmxFR0cz?=
 =?utf-8?B?RHM4ZUltakNzdjZuNU5NN2NoK3pUdFBqOXRpZmZGL3RoRmxrMlVDdzBZOUh0?=
 =?utf-8?B?ZHAwdVZZNmJidEJuTWtENlhOU3JsK3BDWnlNaVNrVXdycXZ2TGNrV041Nlkv?=
 =?utf-8?B?UVlNcDN6eEZpNjA0L3NnanNSaFlReG8xTHpENmxWdVAxYXp1K0NCNUhXT3ZN?=
 =?utf-8?Q?MEyEV3GVZxjok7a+zMgmlvOS7?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a15b094-20f8-4b50-8ac9-08dc577a05f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 03:14:37.6760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Siov8O9wGaCrjt8YKnFPUPhQSe5fulCzcOeLUNXJhojy+O8IDqtkYyP/n1NMNkURfXV9Gxscsh+jOJLBlykJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5821
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBNb25k
YXksIEFwcmlsIDgsIDIwMjQgMTA6NTQgQU0NCj4gDQo+IE9uIDQvOC8yNCAxMDozMyBBTSwgVGlh
biwgS2V2aW4gd3JvdGU6DQo+ID4+IEZyb206IEJhb2x1IEx1PGJhb2x1Lmx1QGxpbnV4LmludGVs
LmNvbT4NCj4gPj4gU2VudDogU3VuZGF5LCBBcHJpbCA3LCAyMDI0IDE6MzMgUE0NCj4gPj4NCj4g
Pj4gT24gMy8yOC8yNCAzOjM5IFBNLCBUaWFuLCBLZXZpbiB3cm90ZToNCj4gPj4+PiBGcm9tOiBM
dSBCYW9sdTxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+DQo+ID4+Pj4gU2VudDogTW9uZGF5LCBN
YXJjaCAyNSwgMjAyNCAxMDoxNyBBTQ0KPiA+Pj4+DQo+ID4+Pj4gKy8qDQo+ID4+Pj4gKyAqIElu
dmFsaWRhdGUgYSByYW5nZSBvZiBJT1ZBIHdoZW4gSU9NTVUgaXMgaW4gY2FjaGluZyBtb2RlIGFu
ZA0KPiBuZXcNCj4gPj4+PiBtYXBwaW5ncw0KPiA+Pj4+ICsgKiBhcmUgYWRkZWQgdG8gdGhlIHRh
cmdldCBkb21haW4uDQo+ID4+Pj4gKyAqLw0KPiA+Pj4+ICt2b2lkIGNhY2hlX3RhZ19mbHVzaF9j
bV9yYW5nZShzdHJ1Y3QgZG1hcl9kb21haW4gKmRvbWFpbiwNCj4gdW5zaWduZWQNCj4gPj4+PiBs
b25nIHN0YXJ0LA0KPiA+Pj4+ICsJCQkgICAgICB1bnNpZ25lZCBsb25nIGVuZCkNCj4gPj4+PiAr
ew0KPiA+Pj4gSSdtIGFsc28gbm90IHN1cmUgd2h5IHRoaXMgaXMgd29ydGggYSBzZXBhcmF0ZSBo
ZWxwZXIuIHdoeSBjb3VsZG4ndCBpdA0KPiA+Pj4gYmUgbWFuYWdlZCBieSBwcmV2aW91cyBmbHVz
aF9yYW5nZSgpPw0KPiA+PiBUaGlzIGlzIG9ubHkgbXkgcHJlZmVyZW5jZS4gSSdkIGxpa2UgdG8g
c2VwYXJhdGUgdGhpbmdzIGJlbG9uZ2luZyB0bw0KPiA+PiBkaWZmZXJlbnQgcGF0aHMsIHNvIHRo
YXQgaXQncyBlYXNpZXIgZm9yIG1haW50ZW5hbmNlLiBGb3IgZXhhbXBsZSwgaWYsDQo+ID4+IGlu
IHRoZSBmdXR1cmUsIHdlIG5lZWQgdG8gYWRkIG9yIGVuaGFuY2Ugc29tZXRoaW5nIGZvciBhIHNw
ZWNpZmljIGNhc2UsDQo+ID4+IHdlIGRvbid0IG5lZWQgdG8gY2FyZSBhYm91dCBvdGhlciBjYXNl
cy4NCj4gPiBJTUhPIGNhY2hpbmcgbW9kZSBpcyBhbiBhdHRyaWJ1dGUgaW4gbG93IGxldmVsIGlv
bW11IHdoaWNoIGNhbiBiZQ0KPiA+IGhhbmRsZWQgcGVyZmVjdGx5IHdlbGwgd2l0aGluIHRoZSBo
ZWxwZXIgYnkgY2hlY2tpbmcgdGhhdCBhdHRyaWJ1dGUuDQo+ID4NCj4gPiBpdCBzb3VuZHMgYSBi
aXQgd2VpcmQgZm9yIHRoZSBjYWxsZXIgdG8ga25vdyB0aGF0IGRldGFpbCBhbmQgY2FsbCBkaWZm
ZXJlbnQNCj4gPiBoZWxwZXJzIHdoZW4gYWxsIHBhdGhzIGp1c3Qgd2FudCB0byByZXF1ZXN0IHRv
IGZsdXNoIGEgc3BlY2lmaWMgcmFuZ2UuDQo+IA0KPiBJIHNlZS4gVGhlIGhlbHBlciBuYW1lIGlz
IGEgYml0IGNvbmZ1c2luZy4NCj4gDQo+IEdlbmVyYWxseSBzcGVha2luZywgY2FjaGVfdGFnX2Zs
dXNoX3JhbmdlKCkgYW5kIGNhY2hlX3RhZ19mbHVzaF9hbGwoKQ0KPiBhcmUgZGVzaWduZWQgdG8g
Zmx1c2ggY2FjaGVzIGZvciBtYXBwaW5nIGNoYW5nZSBmcm9tIHByZXNlbnQgdG8gbm9uLQ0KPiBw
cmVzZW50LiBXaGlsZSBjYWNoZV90YWdfZmx1c2hfY21fcmFuZ2UoKSBpcyBkZXNpZ25lZCB0byBm
bHVzaCBjYWNoZXMNCj4gZm9yIG1hcHBpbmcgY2hhbmdlIGZyb20gbm9uLXByZXNlbnQgdG8gcHJl
c2VudC4NCj4gDQo+IEhvdyBhYm91dCByZW5hbWluZyB0aGVzZSBoZWxwZXJzIHRvDQo+IA0KPiBj
YWNoZV90YWdfZmx1c2hfcHJlc2VudF9yYW5nZSgpDQo+IGNhY2hlX3RhZ19mbHVzaF9wcmVzZW50
X2FsbCgpDQo+IGNhY2hlX3RhZ19mbHVzaF9ub25fcHJlc2VudF9yYW5nZSgpDQoNCkknbGwgcHJv
YmFibHkga2VlcCBjYWNoZV90YWdfZmx1c2hfcmFuZ2UvYWxsKCkgYXMgaXQgaXMgYmVjYXVzZSB0
aGUNCm5hbWluZyBtYXRjaGVzIHRoZSBnZW5lcmFsIGludGVycHJldGF0aW9uIG9mIHRoZSB0bGIg
c2VtYW50aWNzLg0KDQp0aGVuIGNhbGwgdGhlIDNyZCBvbmUgYXMgY2FjaGVfdGFnX2ZsdXNoX3Jh
bmdlX25wKCkgZm9yIHZhcmlvdXMNCmFkZGl0aW9uYWwgcmVxdWlyZW1lbnRzIG9uIHRyYW5zaXRp
b25zIGZyb20gbm9uLXByZXNlbnQgZW50cnkuDQoNCj4gDQo+ID8NCj4gDQo+IEluIGNhY2hlX3Rh
Z19mbHVzaF9ub25fcHJlc2VudF9yYW5nZSgpLA0KPiANCj4gLSBpZiBJT01NVSBpcyBub3QgaW4g
Y2FjaGluZyBtb2RlLCBmbHVzaCB0aGUgd3JpdGUgYnVmZmVyIGlmIG5lY2Vzc2FyeSwNCg0Kb3Ig
aWYgdXNpbmcgc3RhZ2UtMQ0KDQo+ICAgIG9yIGl0J3MgYSBuby1vcC4NCj4gLSBpZiBJT01NVSBp
cyBpbiBjYWNoaW5nIG1vZGUsIGZsdXNoIHRoZSBJT1RMQiBjYWNoZXMuDQo+IA0KPiBCZXN0IHJl
Z2FyZHMsDQo+IGJhb2x1DQo=


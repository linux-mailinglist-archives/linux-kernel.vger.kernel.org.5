Return-Path: <linux-kernel+bounces-16144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B80C8239A1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 01:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5EC8B24802
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 00:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9D67FE;
	Thu,  4 Jan 2024 00:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dIhe8VRI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89507367;
	Thu,  4 Jan 2024 00:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704327936; x=1735863936;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZIRCcK9Fwe+03V8MJSaI3LcFsOA5VqqXglsifOsJn20=;
  b=dIhe8VRIL/v6zLSRPAr9rn0M0mEzbvYeyt3HQvvTikA5ynorCk+PX9s7
   UEObR7L8rLpTVNOXemFfZ6K+so6tOGL3Kw6ZjF4HqbwjuNeALVO0Ogup0
   bszzWb9IUgLNxxormFXQQFLJfN7FXcd6UqQjYipPkNfCmvFMCuEWw3ujG
   Q4ZwJrTYBWqXsaieFcAaS39qMOrM791BpW++qvMJJtwh0paNPVBtsHhgA
   qVXyCCi/F52qUKm2cUh9y/4eEwlZHDl4toXVBln69491VRoNU4L2E/aTW
   rKVcNU18Py60NGPf7GgKsvkwDe7eR3Yd1KDNi4Y2L1ebFrYGMwHcNylBM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="387554341"
X-IronPort-AV: E=Sophos;i="6.04,329,1695711600"; 
   d="scan'208";a="387554341"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 16:25:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="923730830"
X-IronPort-AV: E=Sophos;i="6.04,329,1695711600"; 
   d="scan'208";a="923730830"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jan 2024 16:25:34 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 16:25:34 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jan 2024 16:25:34 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Jan 2024 16:25:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6uhpwPxfzG4+9/eFaKX54KyLnzZfcymYstpDxt9kk0vghW+aXrNBQolw03sPQDUR7YeViloCmpsFss5R40uoVsDAw+F5O9W0/N8bLupF+pbqgKJLhQQGXF1/ufxqPRw6AV+haUMmJcc8VqoompmB1NdVlqgoVW1hwfJgQVnyYErgPjfHShv+XEQV6A9fiw9K0EekVf5bmFhk22cpE2jzoagZYLkLptSCuUv7ieupVfCNYWW03iA6dmolbfi6v3XpZzJdyUsClNejc5TWQCVvyYqLNiVV+UWSg5wLgyYgBMbkcSkPSAocgxL2apF+EVKqmUCl7mv7wSxDeR29/A4/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIRCcK9Fwe+03V8MJSaI3LcFsOA5VqqXglsifOsJn20=;
 b=Jb6bpAtfdJzsaMYVOusVShJCALy0IHJzyZAUEuYU+D36x+HEtvQQE5VdFeArgqIn7RVXa20gO/G+xyVPyGbOLl27NPgP8zg6WzpWer2y4fMbANqw7ZpuIR1SlvLJK8KDBDvXub+88wkRjZLItIFtwGsVvEMbx/VG5J6+Y0UhFN0/6333Y0zhq9zKuuyXQFu6Rs9Oc7nHvqn1lrRLJBs2iOPzM2zL69lE4QZuuvFeONT/GalYpIajZXgUDQCEK1IxyQf2mUCQGW4BvTxRV2WxDXP8S6rRcD9Nl9kyJhWIZXsk/xOWiLAfl211SoMAEWLx06rNqNakOZyDIcD9+luW9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by PH8PR11MB7046.namprd11.prod.outlook.com (2603:10b6:510:216::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 00:25:31 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::6da1:a4b7:4771:14e1]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::6da1:a4b7:4771:14e1%5]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 00:25:31 +0000
From: "Chiu, Chasel" <chasel.chiu@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
CC: Simon Glass <sjg@chromium.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Rob
 Herring" <robh@kernel.org>, "Tan, Lean Sheng" <sheng.tan@9elements.com>, lkml
	<linux-kernel@vger.kernel.org>, Dhaval Sharma <dhaval@rivosinc.com>, "Brune,
 Maximilian" <maximilian.brune@9elements.com>, Yunhui Cui
	<cuiyunhui@bytedance.com>, "Dong, Guo" <guo.dong@intel.com>, Tom Rini
	<trini@konsulko.com>, ron minnich <rminnich@gmail.com>, "Guo, Gua"
	<gua.guo@intel.com>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: RE: [PATCH v7 2/2] schemas: Add some common reserved-memory usages
Thread-Topic: [PATCH v7 2/2] schemas: Add some common reserved-memory usages
Thread-Index: AQHZ8LGvpttG6mvEz0WlU57NBrVnTbB0GT1wgAEi2gCAA4/1oIALktuAgADzAICAABvkkIAABCKwgAr4SACAABVGMIAj06wAgAAR7BCAAWO2gIAAZ0/wgBKfxgCAACAI0A==
Date: Thu, 4 Jan 2024 00:25:31 +0000
Message-ID: <BN9PR11MB548370E8181B1BB3C6FB9A20E667A@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20230926194242.2732127-1-sjg@chromium.org>
 <20230926194242.2732127-2-sjg@chromium.org>
 <BN9PR11MB5483FF3039913334C7EA83E1E6AEA@BN9PR11MB5483.namprd11.prod.outlook.com>
 <CAMj1kXFG92NpL7T7YocOup0xLKyopt3MnSCp0RL8cLzozzJz7A@mail.gmail.com>
 <BN9PR11MB548303B09536EB1577472029E6B3A@BN9PR11MB5483.namprd11.prod.outlook.com>
 <CAPnjgZ36t8g7E=0MSJyaV8-QKv9RVYe47Jd5E=NU-mFM4LWBQA@mail.gmail.com>
 <CAMj1kXHAEeK7x2f13k_JV3Xcw61nNLasyvXQf+mKwKekQ48EpQ@mail.gmail.com>
 <BN9PR11MB548334E0DA6495C438FBFDE1E6BBA@BN9PR11MB5483.namprd11.prod.outlook.com>
 <BN9PR11MB548314DDE8D4C9503103D51CE6BBA@BN9PR11MB5483.namprd11.prod.outlook.com>
 <CAMj1kXHbM+ArLgNZgnmiok4gOfv6QLYxzyB9OCwfhEkJ2xGK_g@mail.gmail.com>
 <BN9PR11MB5483C2FBCD07DE61DCCDB523E6BCA@BN9PR11MB5483.namprd11.prod.outlook.com>
 <CAMj1kXHmu=ykgBMRiFqG4_ra3FJtHa=GASoMUJswdMFa9v4Xgw@mail.gmail.com>
 <BN9PR11MB54837EEB391CC2A8FA6C0BF5E695A@BN9PR11MB5483.namprd11.prod.outlook.com>
 <CAMj1kXEQL9n1Adedow5KEyZ5gdFQY3Fn+Fz8vSK3mHib_vDFig@mail.gmail.com>
 <BN9PR11MB5483E191F1906641565A1337E694A@BN9PR11MB5483.namprd11.prod.outlook.com>
 <CAMj1kXGcZP99hyURXFAZfwKmYqj-xBN9BcW7R3h9Mm2k937Buw@mail.gmail.com>
In-Reply-To: <CAMj1kXGcZP99hyURXFAZfwKmYqj-xBN9BcW7R3h9Mm2k937Buw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5483:EE_|PH8PR11MB7046:EE_
x-ms-office365-filtering-correlation-id: 3fbc23b5-1da5-4fff-db7c-08dc0cbba8e9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mhHy5rkSNXN4pIwJ463aoQPtD4R1F5dmLKLclUcIpzE6xSDMNqzWFq5sS0uHrI9l3fWShO1BA7WhYYF4k0b+/B4OxFraZmgYJudSSGdy/VpdcHH7ftG5Tw2rV1WPRRe7QZd2tHGSXFU3xxpxx4EOaawoVaOg3woBNlLi/pbV5t7EBVslrNFryDDlLMeeBoBgagfrBFWyGMBocPY4eveV7sNLUkJRS1p7VRwL5edXtLOVjUHoRa2s4YkhH+BaMrIQlpUMf5XB+Dz1aZjebBzHheEPf/9NRQA19elDz4qlse/zdKKhooh5Vm29l+ZmAwSvmuzE8XBRlI3n+F9ZujTJtjhc3Lu8m4HNxeZbA8P3gNAzKZHW8fYBCEzW50zx7fh0cnSGnKOumrPLrXMO35IA9T02NTAVO7l1mr9m2E08Vj6PPJZKlQayFBJD5XXUwRAzd5qujef6qAZIpzcRKKqSg8YJM5H+TX0J/z1WQSWTvSpe3DQdRrFvYcb9S2fj5W5ts1pg8YznNI8ZLcd2dpvJw703oCuw73mZe06y/bJX0gpLjCmp+EtPtoez3kP5mlagGoCZQgPfa3Jh7ZnfF6+FZO9mihbwn2SG6bAlT87Kpfw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(39860400002)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(2906002)(7416002)(8936002)(33656002)(8676002)(4326008)(52536014)(6916009)(64756008)(66476007)(316002)(66446008)(478600001)(54906003)(86362001)(5660300002)(55016003)(966005)(7696005)(53546011)(41300700001)(6506007)(9686003)(38070700009)(71200400001)(82960400001)(26005)(38100700002)(66946007)(66556008)(76116006)(83380400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VEh2WXk3T3NKQnJzWUZUUUMvZzY4S0RGWW10eWNocG9SK0xRVDFBY1crOEtI?=
 =?utf-8?B?bm9NZ2d6MWQrMno5NzZWYmJ1SlJXKzBUVHRoQ3hzaUxIeU9HZEdTTUFzVnVZ?=
 =?utf-8?B?TEw2dDJkQ3hqZ1pzaFVTaUdZZ2pSdkxqVmE4ZmRadkoyTDhsUzFrS0thRkla?=
 =?utf-8?B?QzA1YnRWdFk0OUovd3U2TVAyUFR2dkZwRUs2ODVhSjdFdTRFTDJMNUY5SlhH?=
 =?utf-8?B?MWZpNjZSVGg5Mi9HaWI5aDh1Q0NoZzlKVlg0ZWdRQ2E0MTNQaXJJVURIZktt?=
 =?utf-8?B?bldEb1B1bXNnTHF1Mlc1N1pCSFI2NWU2WTZlOGwvR1piRTQrait6OGtDZlpl?=
 =?utf-8?B?dWQxTDJFN2Rob0ROOUtCT1ErV0Y1Z3RVNVROVkxHa0lvNlRXeU1obGphSFUv?=
 =?utf-8?B?R0RScDhyL2F6dGgrR1JjQ0Y3K3Z4ZWNSLzloSGdDaWE3Q3IyMjh2YkNlSHpE?=
 =?utf-8?B?Z255dnlKb0RRUFo0d0FWT0pwV3R1Q2VyL25qcDZEeWNPRHlyY2ZpbUpDOUFL?=
 =?utf-8?B?S3l0dEI2dkIwOUVuY3YyTVlicFljRVJxSUVMSlR1SXMzUnZ4eUx0VzByd2Vo?=
 =?utf-8?B?OGd2bUFiMXdYZE5uTk5vaitaK0IxV2paRHpaTkNSQVluT1E1Q20xOGNXZ00x?=
 =?utf-8?B?NlhCK010WDVhdFpBaGo4WTF1Z0tSK2xPM09ZQjVsYzc2bWNKQjUwU3hlbGdn?=
 =?utf-8?B?MWJNdXg4UUtYaDd5ZGtiUHc3M3ArNjFFalhBQTFWOUl6K01hMjE4YXRtZS9k?=
 =?utf-8?B?amViN2xZSkFleGFHS1RvV3dxd0dJYmg0eVQ2UkswRjFUbnRreG1YZ2ZsdjY5?=
 =?utf-8?B?dzNNeUZIZWUzSzZ0Qmp3UjdrYXYrazdjNEJCSHpTVnkvQWQrc3djUGVOZDFG?=
 =?utf-8?B?cGJFRGxMTXdtTitkL01XYkZIVzVmbFVidTIvazQ0T3UvdEx1ZjUvNHFRZVBy?=
 =?utf-8?B?bm1ERnUrUEN0eGVIc2tQRVFLaVBXaUFzYVoxekwwSzA2ekJ0dHZFaW9CNjhK?=
 =?utf-8?B?SlZOdG0zRkM4KzkyUmxIOXRERGlPZ0FaMm93c2UrQXRYVHVGdDlTSmJGVG5X?=
 =?utf-8?B?VGZ0MFlzRnFoSFhMWUdURDdQNkxLaXIweFdZR05ublNEMVQwQ1JOLzN0R0xz?=
 =?utf-8?B?S2JmNDVYVm1ldGN0c3N0UFBFQURDYzNFQy9qdGdLME90RHovbW9Sc081NnpG?=
 =?utf-8?B?V1FOYnNjNzR2K3BaVXY0M0JUZ0tmZnc1VVJra2RTcGd5ZFkzR0JiMmFaUG84?=
 =?utf-8?B?M2tNd2tnK3o4dUhMTTdkVjZub0lHNXNiMlRxdTMzL0hKNE1YWnBLblA2RnEy?=
 =?utf-8?B?VlU5NlpteEF1S3BTU1ZUak1xL1RqTFNxRmZNWTdNRGU1OWtkTTZYRUg1SVdr?=
 =?utf-8?B?MkJ5UVdJWFZFSTQxYTdIOG9SQzl5T2NjU3VVNG1yMDJwY1NKSTgxS0tTMlZC?=
 =?utf-8?B?OWgxOTNTT0N2Szdya3FOSFh5WVZObjk5R1gwNUNIbm1zU2pIekZoZ0Yybk0w?=
 =?utf-8?B?enYwcGR2R3RFVSs1NyswREthZHJESWVDcmNrZDhFUHlPTkw2eFVQTEVTa1NU?=
 =?utf-8?B?azlZZHhnMWpSNmlMcGQ5bEpGaldvejJCckZhdTJUeHNMbE13T0tjTVE2ZUdB?=
 =?utf-8?B?Sy80M0RVcjAwdGtzaE02cEVlWVZ1UlVib1RQU2trblJaYWRFdWd4OFV4Z0dV?=
 =?utf-8?B?YVpzVU5NRnJFbkVOeGJqZm9pNnhPL3VzMGE1c1pZMmpuTlZrZFZDRXBxMVVs?=
 =?utf-8?B?SlUzQ2FhWkJlNEdCWmQ4Z1hvY25EWXRxd1dVdVJqUnpZOC9RK0dMVCtTNHJD?=
 =?utf-8?B?VERjWGpmMDVXSW1SSXY2VGhzeUNtMWVsRTNQWmsvVSt4bENmYW1FTWY0WjI2?=
 =?utf-8?B?blBoNGc1QWZyZVZ0UTVYT0p3ZnY1WktFTS9qalE0QjFNcEI0cXlWRkx2M1FH?=
 =?utf-8?B?c3Z3TWNVZmVVaHBRTGU5YzduVnhPemM5L1hCUVpmd0lUaXpBbmN3bnYyTVdy?=
 =?utf-8?B?aGJEa243MC9VeWtlNnZ0YkNZN25ZUzVMMXcya3lSNXN4VUxnL0FWNHF1UmFn?=
 =?utf-8?B?ZWJQdG96RnlGVnB3OXVQS0pjaFR2dDNHWnFybTVZNVpMZ1NMc0gwazBnbkdQ?=
 =?utf-8?Q?zkGgXz75s3a1UnDrFPHr7ZdBy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fbc23b5-1da5-4fff-db7c-08dc0cbba8e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 00:25:31.1781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y5PcpaDfArjtmpI84dy76sFCfavORjWFHp3vkEWLfmuDg8LW4pPcNpA3q0WWG5PGD2mSOXylzDwzcCpuTHMmmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7046
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXJkIEJpZXNoZXV2ZWwg
PGFyZGJAa2VybmVsLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBKYW51YXJ5IDMsIDIwMjQgNzoy
MiBBTQ0KPiBUbzogQ2hpdSwgQ2hhc2VsIDxjaGFzZWwuY2hpdUBpbnRlbC5jb20+DQo+IENjOiBT
aW1vbiBHbGFzcyA8c2pnQGNocm9taXVtLm9yZz47IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3Jn
OyBNYXJrIFJ1dGxhbmQNCj4gPG1hcmsucnV0bGFuZEBhcm0uY29tPjsgUm9iIEhlcnJpbmcgPHJv
YmhAa2VybmVsLm9yZz47IFRhbiwgTGVhbiBTaGVuZw0KPiA8c2hlbmcudGFuQDllbGVtZW50cy5j
b20+OyBsa21sIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgRGhhdmFsDQo+IFNoYXJt
YSA8ZGhhdmFsQHJpdm9zaW5jLmNvbT47IEJydW5lLCBNYXhpbWlsaWFuDQo+IDxtYXhpbWlsaWFu
LmJydW5lQDllbGVtZW50cy5jb20+OyBZdW5odWkgQ3VpIDxjdWl5dW5odWlAYnl0ZWRhbmNlLmNv
bT47DQo+IERvbmcsIEd1byA8Z3VvLmRvbmdAaW50ZWwuY29tPjsgVG9tIFJpbmkgPHRyaW5pQGtv
bnN1bGtvLmNvbT47IHJvbiBtaW5uaWNoDQo+IDxybWlubmljaEBnbWFpbC5jb20+OyBHdW8sIEd1
YSA8Z3VhLmd1b0BpbnRlbC5jb20+OyBsaW51eC0NCj4gYWNwaUB2Z2VyLmtlcm5lbC5vcmc7IFUt
Qm9vdCBNYWlsaW5nIExpc3QgPHUtYm9vdEBsaXN0cy5kZW54LmRlPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHY3IDIvMl0gc2NoZW1hczogQWRkIHNvbWUgY29tbW9uIHJlc2VydmVkLW1lbW9yeQ0K
PiB1c2FnZXMNCj4gDQo+IE9uIEZyaSwgMjIgRGVjIDIwMjMgYXQgMjA6NTIsIENoaXUsIENoYXNl
bCA8Y2hhc2VsLmNoaXVAaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+DQo+ID4gUGxlYXNlIHNl
ZSBteSByZXBseSBiZWxvdyBpbmxpbmUuDQo+ID4NCj4gPiBUaGFua3MsDQo+ID4gQ2hhc2VsDQo+
ID4NCj4gLi4uDQo+ID4gPiA+ID4gVGhlIGdFZmlNZW1vcnlUeXBlSW5mb3JtYXRpb25HdWlkIEhP
QiB0eXBpY2FsbHkgY2FycmllcyBwbGF0Zm9ybQ0KPiA+ID4gPiA+IGRlZmF1bHRzLCBhbmQgdGhl
IGFjdHVhbCBtZW1vcnkgdHlwZSBpbmZvcm1hdGlvbiBpcyBrZXB0IGluIGENCj4gPiA+ID4gPiBu
b24tdm9sYXRpbGUgRUZJIHZhcmlhYmxlLCB3aGljaCBnZXRzIHVwZGF0ZWQgd2hlbiB0aGUgbWVt
b3J5DQo+ID4gPiA+ID4gdXNhZ2UgY2hhbmdlcy4gSXMgdGhpcyBkaWZmZXJlbnQgZm9yIFVlZmlQ
YXlsb2FkUGtnPw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gKEZvciB0aG9zZSBhbW9uZyB0aGUgY2Mn
ZWVzIGxlc3MgdmVyc2VkIGluIEVGSS9FREsyOiB3aGVuIHlvdQ0KPiA+ID4gPiA+IGdldCB0aGUg
J2NvbmZpZyBjaGFuZ2VkIC1yZWJvb3RpbmcnIG1lc3NhZ2UgZnJvbSB0aGUgYm9vdA0KPiA+ID4g
PiA+IGZpcm13YXJlLCBpdCB0eXBpY2FsbHkgbWVhbnMgdGhhdCB0aGlzIG1lbW9yeSB0eXBlIHRh
YmxlIGhhcw0KPiA+ID4gPiA+IGNoYW5nZWQsIGFuZCBhIHJlYm9vdCBpcyBuZWNlc3NhcnkuKQ0K
PiA+ID4gPiA+DQo+ID4gPiA+ID4gU28gdGhlIHBsYXRmb3JtIGluaXQgbmVlZHMgdG8gcmVhZCB0
aGlzIHZhcmlhYmxlLCBvciBnZXQgdGhlDQo+ID4gPiA+ID4gaW5mb3JtYXRpb24gaW4gYSBkaWZm
ZXJlbnQgd2F5LiBJIGFzc3VtZSBpdCBpcyB0aGUgcGF5bG9hZCwgbm90DQo+ID4gPiA+ID4gdGhl
IHBsYXRmb3JtIGluaXQgdGhhdCB1cGRhdGVzIHRoZSB2YXJpYWJsZSB3aGVuIG5lY2Vzc2FyeS4g
VGhpcw0KPiA+ID4gPiA+IG1lYW5zIHRoZSBpbmZvcm1hdGlvbiBmbG93cyBmcm9tIHBheWxvYWQo
bikgdG8gcGxhdGZvcm0NCj4gPiA+ID4gPiBpbml0KG4rMSksIHdoZXJlIG4gaXMgYSBtb25vdG9u
aWMgaW5kZXggdHJhY2tpbmcgY29uc2VjdXRpdmUgYm9vdHMgb2YgdGhlDQo+IHN5c3RlbS4NCj4g
PiA+ID4gPg0KPiA+ID4gPiA+IENhbiB5b3UgZXhwbGFpbiBob3cgdGhlIERUIGZpdHMgaW50byB0
aGlzPyBIb3cgYXJlIHRoZQ0KPiA+ID4gPiA+IHJ1bnRpbWUtY29kZSBhbmQgcnVudGltZS1kYXRh
IG1lbW9yeSByZXNlcnZhdGlvbiBub2RlcyB1bmRlcg0KPiA+ID4gPiA+IC9yZXNlcnZlZC1tZW1v
cnkgdXNlZCB0byBpbXBsZW1lbnQgdGhpcyBpbmZvcm1hdGlvbiBleGNoYW5nZQ0KPiA+ID4gPiA+
IGJldHdlZW4gcGxhdGZvcm0gaW5pdCBhbmQgcGF5bG9hZD8gQW5kIGhvdyBkbyB0aGUgSE9CIGFu
ZCB0aGUgRUZJDQo+IHZhcmlhYmxlIGZpdCBpbnRvIHRoaXMgcGljdHVyZT8NCj4gPiA+ID4NCj4g
PiA+ID4NCj4gPiA+ID4gMS4gV2l0aCBzb21lIG9mZmxpbmUgZGlzY3Vzc2lvbiwgd2Ugd291bGQg
bW92ZQ0KPiA+ID4gPiBnRWZpTWVtb3J5VHlwZUluZm9ybWF0aW9uR3VpZCB1c2FnZSB0byBGRFQt
PnVwbC1jdXN0b20gbm9kZS4gVGhpcw0KPiA+ID4gPiBpcyBiZWNhdXNlIGl0IGlzIGVkazIgaW1w
bGVtZW50YXRpb24gY2hvaWNlIGFuZCBub24tZWRrMg0KPiA+ID4gPiBQbGF0Zm9ybUluaXQgb3Ig
UGF5bG9hZCBtYXkgbm90IGhhdmUgc3VjaCBtZW1vcnkgb3B0aW1pemF0aW9uDQo+ID4gPiA+IGlt
cGxlbWVudGF0aW9uLiAobm90IGEgZ2VuZXJpYyB1c2FnZS9yZXF1aXJlbWVudCBmb3IgUGxhdGZv
cm1Jbml0DQo+ID4gPiA+IGFuZCBQYXlsb2FkKQ0KPiA+ID4gPg0KPiA+ID4gPiBUaGUgZWRrMiBl
eGFtcGxlIGZsb3cgd2lsbCBiZSBsaWtlIGJlbG93Og0KPiA+ID4gPg0KPiA+ID4gPiBQbGF0Zm9y
bUluaXQgdG8gR2V0VmFyaWFibGUgb2YgZ0VmaU1lbW9yeVR5cGVJbmZvcm1hdGlvbkd1aWQgYW5k
DQo+ID4gPiA+IGNyZWF0ZSBIb2ItDQo+ID4gPiA+DQo+ID4gPiA+ICAgUGxhdGZvcm1Jbml0IHRv
IGluaXRpYWxpemUgRkRULT51cGwtY3VzdG9tIG5vZGUgdG8gcmVwb3J0DQo+ID4gPiBnRWZpTWVt
b3J5VHlwZUluZm9ybWF0aW9uR3VpZCBIT0IgaW5mb3JtYXRpb24gLT4NCj4gPiA+ID4gICAgIFVl
ZmlQYXlsb2FkIGVudHJ5IHRvIHJlLWNyZWF0ZSBnRWZpTWVtb3J5VHlwZUluZm9ybWF0aW9uR3Vp
ZA0KPiA+ID4gPiBIT0IgYmFzaW5nDQo+ID4gPiBvbiBGRFQgaW5wdXQgKGluc3RlYWQgb2YgdGhl
IGRlZmF1bHQgTWVtb3J5VHlwZSBpbnNpZGUgVWVmaVBheWxvYWQpDQo+ID4gPiAtPg0KPiA+ID4g
PiAgICAgICBVZWZpUGF5bG9hZCBEeGVNYWluL0djZCB3aWxsIGNvbnN1bWUNCj4gPiA+ID4gZ0Vm
aU1lbW9yeVR5cGVJbmZvcm1hdGlvbkd1aWQNCj4gPiA+IEhvYiBmb3IgbWVtb3J5IHR5cGUgaW5m
b3JtYXRpb24gLT4NCj4gPiA+ID4gICAgICAgICBVZWZpUGF5bG9hZCB0byBpbml0aWFsaXplIFVF
RkkgZW52aXJvbm1lbnQgKG1haW5seSBEWEUgZGlzcGF0Y2hlcikgLT4NCj4gPiA+ID4gICAgICAg
ICAgIChhZGRpdGlvbmFsIEZWIGJpbmFyeSBhcHBlbmRlZCB0byBjb21tb24gVWVmaVBheWxvYWQN
Cj4gPiA+ID4gYmluYXJ5KQ0KPiA+ID4gUGxhdGZvcm1QYXlsb2FkIHRvIHByb3ZpZGUgVmFyaWFi
bGVTZXJ2aWNlIHdoaWNoIGlzIHBsYXRmb3JtDQo+ID4gPiBzcGVjaWZpYyAtPg0KPiA+ID4gPiAg
ICAgICAgICAgICBVZWZpUGF5bG9hZCBVZWZpQm9vdE1hbmFnZXIgd2lsbCBTZXRWYXJpYWJsZSBp
ZiBtZW1vcnkNCj4gPiA+ID4gdHlwZSBjaGFuZ2UNCj4gPiA+IG5lZWRlZCBhbmQgcmVxdWVzdCBh
IHdhcm0gcmVzZXQgLT4NCj4gPiA+ID4gICAgICAgICAgICAgICBCYWNrIHRvIFBsYXRmb3JtSW5p
dCAuLi4NCj4gPiA+ID4NCj4gPiA+DQo+ID4gPiBPSyBzbyB0aGUgdXBsLWN1c3RvbSBub2RlIGNh
biBkbyB3aGF0ZXZlciBpdCBuZWVkcyB0by4gSSBpbWFnaW5lDQo+ID4gPiB0aGVzZSB3aWxsIGlu
Y2x1ZGUgdGhlIG1lbW9yeSBkZXNjcmlwdG9yIGF0dHJpYnV0ZSBmaWVsZCwgYW5kIG90aGVyDQo+
ID4gPiBwYXJ0cyB0aGF0IG1heSBiZSBtaXNzaW5nIGZyb20gdGhlIC9yZXNlcnZlZC1tZW1vcnkg
RFQgbm9kZSBzcGVjaWZpY2F0aW9uPw0KPiA+DQo+ID4NCj4gPiBZZXMsIGlmIG5lZWRlZCBieSBl
ZGsyIHNwZWNpZmljIGltcGxlbWVudGF0aW9uLCBub3QgZ2VuZXJpYyBlbm91Z2gsIHdlIG1heQ0K
PiBjb25zaWRlciB0byB1c2UgdXBsLWN1c3RvbSBub2RlIHRvIHBhc3MgdGhvc2UgZGF0YS4NCj4g
Pg0KPiA+DQo+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiAyLiBOb3cgdGhlIHByb3Bvc2VkIHJlc2Vy
dmVkLW1lbW9yeSBub2RlIHVzYWdlcyB3aWxsIGJlIGZvcg0KPiA+ID4gPiBQbGF0Zm9ybUluaXQg
dG8NCj4gPiA+IHByb3ZpZGUgZGF0YSB3aGljaCBtYXkgYmUgdXNlZCBieSBQYXlsb2FkIG9yIE9T
LiBUaGlzIGlzIG5vdCBlZGsyDQo+ID4gPiBzcGVjaWZpYyBhbmQgYW55IFBsYXRmb3JtSW5pdC9Q
YXlsb2FkIGNvdWxkIGhhdmUgc2FtZSBzdXBwb3J0Lg0KPiA+ID4gPiBOb3RlOiBhbGwgb2YgYmVs
b3cgYXJlIG9wdGlvbmFsIGFuZCBQbGF0Zm9ybUluaXQgbWF5IGNob29zZSB0bw0KPiA+ID4gPiBp
bXBsZW1lbnQgc29tZQ0KPiA+ID4gb2YgdGhlbSBvciBub3QuDQo+ID4gPiA+DQo+ID4gPiA+ICAg
ICAgIC0gYWNwaQ0KPiA+ID4gPiBJZiBQbGF0Zm9ybUluaXQgY3JlYXRlZCBzb21lIEFDUEkgdGFi
bGVzLCB0aGlzIHdpbGwgcmVwb3J0IGENCj4gPiA+ID4gbWVtb3J5IHJlZ2lvbiB3aGljaA0KPiA+
ID4gY29udGFpbnMgYWxsIHRoZSB0YWJsZXMgdG8gUGF5bG9hZCBhbmQgUGF5bG9hZCBtYXkgYmFz
ZSBvbiB0aGlzIHRvDQo+ID4gPiBhZGQgc29tZSBtb3JlIHRhYmxlcyBpZiByZXF1aXJlZC4NCj4g
PiA+ID4NCj4gPiA+ID4gICAgICAgLSBhY3BpLW52cw0KPiA+ID4gPiBJZiBQbGF0Zm9ybUluaXQg
aGFzIGNyZWF0ZWQgc29tZSBBQ1BJIHRhYmxlcyB3aGljaCBoYXZpbmcgQUNQSSBOVlMNCj4gPiA+
ID4gbWVtb3J5DQo+ID4gPiBkZXBlbmRlbmN5LCB0aGlzIHdpbGwgYmUgdGhhdCBudnMgcmVnaW9u
Lg0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+IFRoZXNlIG1ha2Ugc2Vuc2UuDQo+ID4gPg0KPiA+ID4g
PiAgICAgICAtIGJvb3QtY29kZQ0KPiA+ID4gPiBXaGVuIFBsYXRmb3JtSW5pdCBoYXZpbmcgc29t
ZSBGVyBib290IHBoYXNlIGNvZGUgdGhhdCBjb3VsZCBiZQ0KPiA+ID4gPiBmcmVlZCBmb3IgT1Mg
dG8gdXNlIHdoZW4gcGF5bG9hZCB0cmFuc2ZlcnJpbmcgY29udHJvbCB0byBVRUZJIE9TDQo+ID4g
PiA+DQo+ID4gPiA+ICAgICAgIC0gYm9vdC1kYXRhDQo+ID4gPiA+IFdoZW4gUGxhdGZvcm1Jbml0
IGhhdmluZyBzb21lIEZXIGJvb3QgcGhhc2UgZGF0YSB0aGF0IGNvdWxkIGJlDQo+ID4gPiA+IGZy
ZWVkIGZvciBPUw0KPiA+ID4gdG8gdXNlIHdoZW4gcGF5bG9hZCB0cmFuc2ZlcnJpbmcgY29udHJv
bCB0byBVRUZJIE9TLg0KPiA+ID4gPg0KPiA+ID4gPiAgICAgICAtIHJ1bnRpbWUtY29kZQ0KPiA+
ID4gPiBQbGF0Zm9ybUluaXQgbWF5IHByb3ZpZGUgc29tZSBzZXJ2aWNlcyBjb2RlIHRoYXQgY2Fu
IGJlIHVzZWQgZm9yDQo+ID4gPiA+IFBheWxvYWQgdG8NCj4gPiA+IGluaXRpYWxpemUgVUVGSSBS
dW50aW1lIFNlcnZpY2VzIGZvciBzdXBwb3J0aW5nIFVFRkkgT1MuDQo+ID4gPiA+DQo+ID4gPiA+
ICAgICAgIC0gcnVudGltZS1kYXRhDQo+ID4gPiA+IFBsYXRmb3JtSW5pdCBtYXkgcHJvdmlkZSBz
b21lIHNlcnZpY2VzIGRhdGEgdGhhdCBjYW4gYmUgdXNlZCBmb3INCj4gPiA+ID4gUGF5bG9hZCB0
bw0KPiA+ID4gSW5pdGlhbGl6ZSBVRUZJIFJ1bnRpbWUgU2VydmljZXMgZm9yIHN1cHBvcnRpbmcg
VUVGSSBPUy4NCj4gPiA+ID4NCj4gPiA+DQo+ID4gPiBBIFVFRkkgT1MgbXVzdCBjb25zdW1lIHRo
aXMgaW5mb3JtYXRpb24gZnJvbSB0aGUgVUVGSSBtZW1vcnkgbWFwLA0KPiA+ID4gbm90IGZyb20g
dGhlIC9yZXNlcnZlZC1tZW1vcnkgbm9kZXMuIFNvIHRoZXNlIG5vZGVzIG11c3QgZWl0aGVyIG5v
dA0KPiA+ID4gYmUgdmlzaWJsZSB0byB0aGUgT1MgYXQgYWxsLCBvciBjYXJyeSBhbiBhbm5vdGF0
aW9uIHRoYXQgdGhlIE9TIG11c3QgaWdub3JlDQo+IHRoZW0uDQo+ID4gPg0KPiA+ID4gV291bGQg
aXQgYmUgcG9zc2libGUgdG8gaW5jbHVkZSBhIHJlc3RyaWN0aW9uIGluIHRoZSBEVCBzY2hlbWEg
dGhhdA0KPiA+ID4gdGhlc2UgYXJlIG9ubHkgdmFsaWQgaW4gdGhlIGZpcm13YXJlIGJvb3QgcGhh
c2U/DQo+ID4NCj4gPg0KPiA+IGh0dHBzOi8vdWVmaS5vcmcvc3BlY3MvVUVGSS8yLjEwLzA3X1Nl
cnZpY2VzX0Jvb3RfU2VydmljZXMuaHRtbCNlZmktYm8NCj4gPiBvdC1zZXJ2aWNlcy1leGl0Ym9v
dHNlcnZpY2VzIFBlciBVRUZJIHNwZWNpZmljYXRpb24sIFVFRkkgT1Mgd2lsbA0KPiA+IGFsd2F5
cyBjYWxsIFVFRkkgR2V0TWVtb3J5TWFwIGZ1bmN0aW9uIHRvIHJldHJpZXZlIG1lbW9yeSBtYXAs
IHNvIEZEVA0KPiBub2RlIHByZXNlbnQgb3Igbm90IGRvZXMgbm90IG1hdHRlciB0byBVRUZJIE9T
LiBXZSBwcm9iYWJseSBjb3VsZCBoYXZlDQo+IGFubm90YXRpb24gaW4gVVBMIHNwZWNpZmljYXRp
b24gdG8gZW1waGFzaXplIHRoaXMuDQo+ID4gSSdtIG5vdCBmYW1pbGlhciB3aXRoIExpbnV4IEZE
VCBib290LCBidXQgaWYgbm9uLVVFRkkgT1MgZG9lcyBub3QgY2FsbCBVRUZJDQo+IEdldE1lbW9y
eU1hcCgpIGFuZCBkb2VzIG5vdCBrbm93IHdoYXQgaXMgcnVudGltZS1jb2RlL2RhdGEsIGJvb3Qt
DQo+IGNvZGUvZGF0YSwgaXQgbWlnaHQganVzdCB0cmVhdCBzdWNoIHJlc2VydmVkLW1lbW9yeSBu
b2RlcyBhcyAncmVndWxhcicgcmVzZXJ2ZWQNCj4gbWVtb3J5IG5vZGVzLCBhbmQgdGhhdCdzIHN0
aWxsIG9rIGJlY2F1c2Ugbm9uLVVFRkkgT1Mgd2lsbCBub3QgY2FsbCB0byBhbnkNCj4gcnVudGlt
ZSBzZXJ2aWNlIG9yIHJlLXB1cnBvc2UgYm9vdC1jb2RlL2RhdGEgbWVtb3J5IHJlZ2lvbnMuDQo+
ID4NCj4gDQo+IFlvdSBhcmUgc2F5aW5nIHRoZSBzYW1lIHRoaW5nIGJ1dCBpbiBhIGRpZmZlcmVu
dCB3YXkuIEEgVUVGSSBPUyBtdXN0IG9ubHkgcmVseSBvbg0KPiBHZXRNZW1vcnlNYXAoKSwgYW5k
IG5vdCBvbiB0aGUgL3Jlc2VydmVkLW1lbW9yeSBub2RlIHRvIG9idGFpbiB0aGlzDQo+IGluZm9y
bWF0aW9uLiBCdXQgdGhpcyByZXF1aXJlbWVudCBuZWVkcyB0byBiZSBzdGF0ZWQNCj4gc29tZXdo
ZXJlOiB0aGUgVUVGSSBzcGVjIGRvZXMgbm90IHJlYXNvbiBhYm91dCBvdGhlciBzb3VyY2VzIG9m
IEVGSSBtZW1vcnkNCj4gaW5mb3JtYXRpb24gYXQgYWxsLCBhbmQgdGhpcyBEVCBzY2hlbWEgZG9l
cyBub3QgbWVudGlvbiBhbnkgb2YgdGhpcyBlaXRoZXIuDQo+IA0KPiA+IFdvdWxkIHlvdSBwcm92
aWRlIGEgcmVhbCBPUyBjYXNlIHdoaWNoIHdpbGwgYmUgaW1wYWN0ZWQgYnkgdGhpcyByZXNlcnZl
ZC0NCj4gbWVtb3J5IHNjaGVtYSBzbyB3ZSBjYW4gZGlzY3VzcyBiYXNpbmcgb24gcmVhbCBjYXNl
Pw0KPiA+DQo+IA0KPiBGdW5ueSwgdGhhdCBpcyB3aGF0IEkgaGF2ZSBiZWVuIHRyeWluZyB0byBn
ZXQgZnJvbSB5b3UgOi0pDQo+IA0KPiBUaGUgcHJvYmxlbSBJIGFtIGFudGljaXBhdGluZyBoZXJl
IGlzIHRoYXQgdGhlIGluZm9ybWF0aW9uIGluIC9yZXNlcnZlZC1tZW1vcnkNCj4gbWF5IGJlIG91
dCBvZiBzeW5jIHdpdGggdGhlIEVGSSBtZW1vcnkgbWFwLiBJdCBuZWVkcyB0byBiZSBtYWRlIGNs
ZWFyIHRoYXQgdGhlDQo+IEVGSSBtZW1vcnkgbWFwIGlzIHRoZSBvbmx5IHNvdXJjZSBvZiB0cnV0
aCB3aGVuIHRoZSBPUyBpcyBpbnZvbHZlZCwgYW5kIHRoaXMNCj4gL3Jlc2VydmVkLW1lbW9yeSBt
ZWNoYW5pc20gc2hvdWxkIG9ubHkgYmUgdXNlZCBieSBvdGhlciBmaXJtd2FyZSBzdGFnZXMuIEJ1
dA0KPiB0aGUgc2NoZW1hIGRvZXMgbm90IG1lbnRpb24gdGhpcyBhdCBhbGwuIFRoZSBzY2hlbWEg
YWxzbyBkb2VzIG5vdCBtZW50aW9uIHRoYXQNCj4gdGhlIGluZm9ybWF0aW9uIGluIC9yZXNlcnZl
ZC1tZW1vcnkgaXMgbm90IGFjdHVhbGx5IHN1ZmZpY2llbnQgdG8gcmVjb25zdHJ1Y3QgdGhlDQo+
IEVGSSBtZW1vcnkgbWFwIHRoYXQgdGhlIGZpcm13YXJlIHBheWxvYWQgZXhwZWN0cyAod2hpY2gg
aXMgd2h5IHRoZSB1cGwtDQo+IGN1c3RvbS1ub2RlIGV4aXN0cyB0b28pDQoNCg0KDQpEb2VzIGJl
bG93IHNvbHZlIHlvdXIgY29uY2VybnMgaWYgd2UgbWVudGlvbiB0aG9zZSBpbiBzY2hlbWEgZGVz
Y3JpcHRpb24/IChwbGVhc2UgZmVlbCBmcmVlIHRvIGFkZCBtb3JlIGlmIHlvdSBoYXZlKQ0KLiBi
b290LWNvZGUvYm9vdC1kYXRhIGFuZCBydW50aW1lLWNvZGUvcnVudGltZS1kYXRhIHVzYWdlcyBh
cmUgZm9sbG93aW5nIFVFRkkgc3BlY2lmaWNhdGlvbg0KICAuIGJlZm9yZSBFeGl0Qm9vdFNlcnZp
Y2VzOiBodHRwczovL3VlZmkub3JnL3NwZWNzL1VFRkkvMi4xMC8wN19TZXJ2aWNlc19Cb290X1Nl
cnZpY2VzLmh0bWwjbWVtb3J5LXR5cGUtdXNhZ2UtYmVmb3JlLWV4aXRib290c2VydmljZXMNCiAg
LiBhZnRlciBFeGl0Qm9vdFNlcnZpY2VzOiBodHRwczovL3VlZmkub3JnL3NwZWNzL1VFRkkvMi4x
MC8wN19TZXJ2aWNlc19Cb290X1NlcnZpY2VzLmh0bWwjbWVtb3J5LXR5cGUtdXNhZ2UtYWZ0ZXIt
ZXhpdGJvb3RzZXJ2aWNlcyAgDQouIFRoZXNlIHVzYWdlcyBkbyBub3QgaW50ZW5kIHRvIGNvbnN0
cnVjdCBmdWxsIFVFRkkgbWVtb3J5IG1hcCwgaXQgaXMgb25seSBmb3IgUGxhdGZvcm1Jbml0IHRv
IHBhc3MgcHJlLWluc3RhbGxlZCB0YWJsZXMgb3Igc2VydmljZXMgdG8gUGF5bG9hZCBmb3Igc3Vw
cG9ydGluZyBVRUZJIE9TIGJvb3QuDQouIFRoZXNlIHVzYWdlcyBhcmUgb3B0aW9uYWwNCi4gVHlw
aWNhbGx5IFVFRkkgT1MgYm9vdCB3aWxsIGFsd2F5cyBjYWxsIEdldE1lbW9yeU1hcCgpIHRvIHJl
dHJpZXZlIG1lbW9yeSBtYXAgZm9sbG93aW5nIFVFRkkgc3BlYywgbm8gbWF0dGVyIERUIG5vZGVz
IHByZXNlbnQgb3Igbm90IChodHRwczovL3VlZmkub3JnL3NwZWNzL1VFRkkvMi4xMC8wN19TZXJ2
aWNlc19Cb290X1NlcnZpY2VzLmh0bWwjZWZpLWJvb3Qtc2VydmljZXMtZXhpdGJvb3RzZXJ2aWNl
cykNCi4gVHlwaWNhbGx5IE5vbi1VRUZJIE9TIGJvb3Qgd2lsbCB0cmVhdCB0aG9zZSAgYm9vdCog
b3IgcnVudGltZSogcmVzZXJ2ZWQtbWVtb3J5IGFzICdyZWd1bGFyJyByZXNlcnZlZCBtZW1vcnkg
aWYgcHJlc2VudC4NCg0KDQo=


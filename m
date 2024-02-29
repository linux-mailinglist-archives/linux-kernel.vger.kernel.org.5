Return-Path: <linux-kernel+bounces-85935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8510F86BCF5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3964B1F2440B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD2B168B8;
	Thu, 29 Feb 2024 00:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j8vQ2aum"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D72F11CA9;
	Thu, 29 Feb 2024 00:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709167453; cv=fail; b=myEU+B4MnZv211on4EZkuiBON8E2YCcr8y1tq982YF7u5dZLySXVlfNLk//vAxm01lqayahAqRZAjoipOI0u7TaB4Z7ebTzGHk4VUBIAPcUz1FtY9bsAaAyCX+UsulLsvguwcAoKmYUN65d2ci0bb/9OWH/OcaMW3Op/KCGknw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709167453; c=relaxed/simple;
	bh=7mbrrPWEto5GS/9T2YnUkVPnXIiqtWPWHMD7K+Uyj94=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KYLhH7K5SKHQyPVZ+TFl0sv+IB5yNhP2bYUnJfgeyXZntH0brrZzq/3f6HlLVgqJ4HLmveq2BVuK47uZpjHOMRPMSj3mW3Eipn9lSXHbD/Jw4talghbNEYz3C+cIaHkPzlVz356gxuKSn/VkaohQsVeZPlBdCQDRyLBygjPkAqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j8vQ2aum; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709167452; x=1740703452;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7mbrrPWEto5GS/9T2YnUkVPnXIiqtWPWHMD7K+Uyj94=;
  b=j8vQ2aumUGnmvDHylVUDqtECC7ZUEBdei3Z/PxgQR4w05IiaBe2Ovun6
   ZjS/kvqj3e1buOleXp79ZgQD8FmDR6j6gWajY9eEznJLRkqJjKADeJhzP
   5jM7HzV02csTPPuUUHezk99md56x42qvkeuOu/9jiawOIluN/PauoSBH8
   VtBsQyk7oNSDF3+AsFUJtw3l1SFn6jxOtO1TdRyYTos71QfgmXB1TiXa1
   2/DBoPoO6lWXg/QhxgLNFNybzk/palF/dQplxu9UKC79RX4XbaBiNBnsf
   y8Z1oH1B/8rYcw2RYxlbVXIRHhO1OQfXRyQwty5wg97XEOll8HgCq4QVR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3776896"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="3776896"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 16:44:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="12190514"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Feb 2024 16:44:11 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 16:44:10 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 16:44:10 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 28 Feb 2024 16:44:10 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 28 Feb 2024 16:44:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LToimJ0+Lj5CUMevX8GGiVmMMAoFHb0QX0hm8o/6JVsC87+onCujU51Z0wVIQtLHqw+B7KEC/WMCJ2Nz2vA6FbPfwwbWfIGoaWMC6jzY3HAPUGAWqGjfm18ViLER7Z2xJgV06QQ25eSW1YdgagtpJaAmyi/5aygqm7j14OucliR80N5eRUGtCph8VHv+fjTj70OOVJBfYc/E1mYQNY3JEe0puO6z9qwfh2jMkF7ahCbT0yEAG1lbiUJ9u+LDVC/qJ8ZOJ9iC/mEv3ryxzRfb2huJMgYXpy3LEdE2oRe8goSTL2x3rUERFBGafe6vVozgTZ/5FM8hhpjrCIfxwwQ9NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7mbrrPWEto5GS/9T2YnUkVPnXIiqtWPWHMD7K+Uyj94=;
 b=dS2LAvot0ITvlSdouG9gFg7XKgG1ondZZL0zJv4sMS26YWMjrYnRZHavXDApT8kBlEA0ZMGRNYTTjY7DIAbVoM5d/IzpdpnyX2sfc2VgzYQdA8fwA+bIFqn+j8Xa/mvDc3RItWpntEMITs/w0I8yhBrDOkQ0iUrxs9cJ/l3sE90zVn7fiCV43eFvIwuvf/tjou79Tne4i8sEvQBu0IfvxM09+e7+/eUrjz8jTDxIHq4osSWPEnKp8dFXxXwfxPSQPaBSYZdYk8zd2FIYmdg4QPyeLUy0Y0o/M2v7cjEKnTgn8I1jNsP6SH61tpaogdwOzbcN/rELBtYwysT3aC4Qwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CH0PR11MB5396.namprd11.prod.outlook.com (2603:10b6:610:bb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.12; Thu, 29 Feb
 2024 00:44:08 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::d5ce:2b6c:458:3ca9]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::d5ce:2b6c:458:3ca9%7]) with mapi id 15.20.7339.023; Thu, 29 Feb 2024
 00:44:08 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Mehta, Sohil" <sohil.mehta@intel.com>, Borislav Petkov <bp@alien8.de>
CC: "Naik, Avadhut" <avadnaik@amd.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yazen.ghannam@amd.com" <yazen.ghannam@amd.com>, Avadhut Naik
	<avadhut.naik@amd.com>
Subject: RE: [PATCH] x86/mce: Dynamically size space for machine check records
Thread-Topic: [PATCH] x86/mce: Dynamically size space for machine check
 records
Thread-Index: AQHaaqfKQmFM0nwa4EKw4Te8Qt/5b7Ege0ZQ
Date: Thu, 29 Feb 2024 00:44:08 +0000
Message-ID: <SJ1PR11MB6083575E17FF0E2DB38D7A32FC5F2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240212093246.GBZcnlvkPKDC8C7rv5@fat_crate.local>
 <SJ1PR11MB6083B3511D18787BE823AB2CFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240212175408.GIZcpbQHVjEtwRKLS-@fat_crate.local>
 <SJ1PR11MB60830AF35FA89C7869B8C11EFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240212191401.GLZcpt-XHFqPg3cDw-@fat_crate.local>
 <SJ1PR11MB6083C60D7584B02E9CAF19D5FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ZcqPhVO_DtD2x5N7@agluck-desk3>
 <20240212220833.GQZcqW4WxKH34i-oBR@fat_crate.local>
 <20240212221913.GRZcqZYRd6EPTTnN97@fat_crate.local>
 <20240212224220.GSZcqezMhPojxvIcvO@fat_crate.local>
 <Zd--PJp-NbXGrb39@agluck-desk3>
 <72fc647f-b9e3-4839-9529-dffa2d0bf6a9@intel.com>
In-Reply-To: <72fc647f-b9e3-4839-9529-dffa2d0bf6a9@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CH0PR11MB5396:EE_
x-ms-office365-filtering-correlation-id: 8883ad09-d85d-4b90-b32d-08dc38bf8a05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EKkfPLIUBGSXL0wqaYJwIHprIkj31UwmRytPhluEvtCEaRHa3tWz73GSCu/0XOa856PuUdQgJ3SNYPBK1p+AjnIipIFDERIxG82L9TvCYFG6aVvf1TP6eK3GoTW60kAtqMcMLvipRhLOLhz71Ty8yLLmPSyM9Zv7BKo2mpn6mGRnvmkrZax5S+I0TDcnuBolAKfOSTTws3vzmct5MtPBDJYlNa9Bdew5cXZEComB6EgMYIgTbrJ6hs0ZLFVmd4TpChxPeqTg9JPdDnmfpnhHBgaus+HtQ1Urn6fPKvPMjVYAh+2zMM+b9JhQ0xxudplf+nyngmCjyNT54d7Vm7WLK8dJ/j+Cc4vv0skcA3cMmYPp8HRIcpYy1Z6ucp8WPyoiYOQJSi1e/Bn0z8w5uqeAzOVyj14n+aYzLxT4mFh27Xs43U+ldHVh26yTZduhVgWJ3K/gzbkmpZ6HlKIy5gzJR2Gf3No2Zj/KzjfIAy9po3Q1poUp9EhkliWSG6BHacK4SVDB40MWkonzuHuiiAt2T+ZCpiOpRlgGbEuPN/jVETrtjW1kPE2dxCfTP7aiq/CBNAO3NE5MGozlDSy2dJ42GhjZ63CO04SISHQoKF/+/qo9/Oz1WvyrWPtwraxFl1/8FdBHH7NZf3ZprCxb3Xvk2cXgdSGfKWnECwVMCR84VJvDDV7O2YcpxlFn2KqKemTYt6sO42/v+uP1zkPdz8qm95A7KTujgAV2g8tdQ5l2yhY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emU2enBqdm01OTd4VldTd3JIZGdtWVl1WWZBOGxsMXk3MlExejZIN0ZzREcx?=
 =?utf-8?B?cVk0dlNzUkZRU0xmNHJjcDhnYy9vdFdIYUliS1ZtZ1JKd3FsNEFuVFhjajgz?=
 =?utf-8?B?RE40N0RLZGpKbzY2Y0xpajBaUjNpd2tNSmptL0dSNHRuazAyMkFJVUV6UExH?=
 =?utf-8?B?Sng3anhoclZDdTF3dWhGbXNyNThrcDltOHVhN2tTSzlnVU52bVo0QlBiaHpM?=
 =?utf-8?B?cXc0WkpQQjFGSzBHVGdzYjR2Ylp4d0d4WHJ2UWdGbkhRWmdKWXNtbit3YzV3?=
 =?utf-8?B?cGtKK2dyR0FNc3MyNy90dU9KaHJHWkZMS1Q3d1Y4dHlWOTBTUkhsVzRWT1Np?=
 =?utf-8?B?ZVRwOTNNWGdIRi91Q2N4bzhYcG1Eem42TmJhTkU2VU1XTE44dmoxVmI0aUQw?=
 =?utf-8?B?V1FKYmdDcVY0aXRCVVhvSm4rZFVNZVJvMEI0V3JEWkR0elMvY05CU1g2dHZL?=
 =?utf-8?B?Mi9zdlZ4NWVUbUp5YStUaE9QTzVpSzV1WG5abjdlUEYyQ2RJVXZsUDVPZjM4?=
 =?utf-8?B?MC9tOGJ0VTZtZ2E3c25IZnduNGFBZ25sRXA0V0t5cWc4NGEwZ0k0QjM1bFVL?=
 =?utf-8?B?ZTc5d1k3RG9IbU1TcExEQ2F6dUZuR2UyUmgwa25JMjEraVlwdGgySGZrZlpr?=
 =?utf-8?B?TTE3OHQrbDgwYmsvSlJYY3FpMlZvdENkbFFNODd3Y1NZdG5ETndpV1F1N2tv?=
 =?utf-8?B?d3lRRElzbGV4SUdubSsrYkJxYjI2bit5c1ZaMnI3Mndtakp4enRyTmU1NDhG?=
 =?utf-8?B?NHlWSHUvTXdRUGZBMmNNM05welhXdU5YQllxTXdmQ28xbFd1elpFUDJQdmh2?=
 =?utf-8?B?STRSdWtBYUkrS0N0dnY4QUVkbk5jdysvUE5mbkJGeFAwc09WaStIWXJhM0hu?=
 =?utf-8?B?alMwbWNTZmg4dVFNN1RyNzlYV2lhSnVMNXVCcUhuVUJPS2NDTnhYZHNTMXRl?=
 =?utf-8?B?azlXckVFVjNGYmU4NnpYRStFb2tCUE1pdkdwbExmNmJGM3JuSlp4WUh3eDZJ?=
 =?utf-8?B?NUtMelNQUzhEeTdzL3ZpaGNad29GRERxODVFT243SEwyUlQ0N2dodVBTWmh2?=
 =?utf-8?B?UkFNSnh6MzBBWjBlRytVcytSK2I3YXpuTGpuVUtzSHBkVGt4eC9KZ2tWaFpn?=
 =?utf-8?B?NVMwVEVHYVZDcHl6TUM2QllxR1pqMG8xRlpwcEVxTWljUG5MSktMc204L1lN?=
 =?utf-8?B?MXBUVU8yVjJodFU0RnROZ3NmbjNWQnVXU3dVcnRJUHA0YXluM0xiWVJ1SW5r?=
 =?utf-8?B?S2h1aGkrVkovK3NPZ25hMCs0aFBzVlhiQms5VHRYRnp4Umpib3E0VTlobXMv?=
 =?utf-8?B?VGtFRTExc1JVM1EwY1V1QnE1R05tL1Y3bnNzZmYwdXZZYjhSRWxxcytkK3Vq?=
 =?utf-8?B?NDVDR1gxVjJhRUh0Ump6d0JEN1pNQUJIM3lGaWZEdVBOYVBqVjJ6M25zd1Jy?=
 =?utf-8?B?TFV5ZnNWL3poeCtLVktiZEpNL0NqY3BGOVVKcG1lN3NLbWVERXQ3TzRwV0ND?=
 =?utf-8?B?TEJKUjI3MW9JU25HaUhyQk1RM0g2YkpRRm1wQVlMeHo2YmVDN28xUEtvRlo3?=
 =?utf-8?B?enhJRHE4NUFNcTFkSXNtL1lhVG9DcnVuYzl2NjVCVjNpVGxvSW03cUx1WHpm?=
 =?utf-8?B?eFVJKzBPbytzYWZGaDM1Q2NkRFMzVHdlOUtUZEhMQkVuSk5iQ1F1V2FLMFZo?=
 =?utf-8?B?RWc4OStobFNUYWRRbEZPWDMyRHlOZWw0eE5xK0JreDdYRDN6VmdNclk4YXFI?=
 =?utf-8?B?NWJOZS93VTdrTExrN2NoU2lPbEh1K01CblJ1UTRXeGlVUW1Uc2wwWFd5ZFdt?=
 =?utf-8?B?emtYNWZwa1BsMjZ5aEdGbHNCK0RzQjRsWGgzUjNjRmtNd3h4ZnROWjFyT3lV?=
 =?utf-8?B?KzVTRHhjVHkxOUIramEzb1M0RXNpaG93YVF4b1BRVmZUcFhxSndIR3RBRGRS?=
 =?utf-8?B?VDBvbkRuU2FOaTVKY3lwTGFiTnN2SkIyY21iL1U1aDhtZU5LZytlMzVyY3h4?=
 =?utf-8?B?Q1NES05uS3hoTkwrZDNFZStxZ1dobkNFUzc3Y2ZKVUI2MlVsaG5iTmhSby9L?=
 =?utf-8?B?eFd1YkNRRys3Qk1ySkpxY0lFRlBLYlh0cE1hVUJIMXRCOTFxUzl0MHJ1b0lw?=
 =?utf-8?Q?rAzfzi4TorhX/R8+JVJSdRGoB?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8883ad09-d85d-4b90-b32d-08dc38bf8a05
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 00:44:08.4880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uLSPiWeQm3UvWSRN2R8gBZKvHEWPBxj57PEXKwQPF6YuMjOXxndIKmgN9cb8ucPCh2twloHE55+a/A7R43iq0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5396
X-OriginatorOrg: intel.com

Pj4gKwlyZXQgPSBnZW5fcG9vbF9hZGQodG1wcCwgKHVuc2lnbmVkIGxvbmcpbWNlX3Bvb2wsIG1j
ZV9wb29sc3osIC0xKTsNCj4+ICAJaWYgKHJldCkgew0KPj4gIAkJZ2VuX3Bvb2xfZGVzdHJveSh0
bXBwKTsNCj4NCj4gSXMgdGhpcyBtaXNzaW5nIGEga2ZyZWUobWNlX3Bvb2wpIGhlcmU/DQo+DQo+
PiAgCQlnb3RvIG91dDsNCg0KWWVzLiBXaWxsIGFkZC4NCg0KVGhhbmtzDQoNCi1Ub255DQoNCg==


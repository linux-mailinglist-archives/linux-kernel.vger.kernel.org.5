Return-Path: <linux-kernel+bounces-101646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E4C87A9D1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDA981F22D74
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156EE35894;
	Wed, 13 Mar 2024 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cgz2+tg0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE05BA31
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 14:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710341736; cv=fail; b=EQT0sZEeNd+acw/Ru8HCWY9sjNsgCIID/w2ACijZlthQ/yxEdriZT7/LOV0+eaBuFMMpuKmCpIXMANF6vsuzty9xNdXEMu3numX6gMhzXNCMBYED3741hgKCmprU/va5zBOHWofDsH9T6Sc4HMRwh0OK9FbJogV7LwIUgjU4o8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710341736; c=relaxed/simple;
	bh=PrbKo+p3rufy5jarkOc+iF3E+UV5IZks5/OEnxR7RVM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R4wT0JjYzET/ikIKRmWroZM4ctNdWiwNb2EJXQ9f0j1CqrWQ7Zl+4x3VMe1A/tcWKFzTDWV7VvPojHGMkiiz/YFx1RSbRulXM/VMnP/5Gx1sl3BI3bjPEFH/a8CSqQjIP6pfNecfmWA1Gcqbahs0XD+PHFcUcHOsAC8A4SkwPnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cgz2+tg0; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710341735; x=1741877735;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PrbKo+p3rufy5jarkOc+iF3E+UV5IZks5/OEnxR7RVM=;
  b=Cgz2+tg09avEROKeGB8sPZRr2sSJ2dBY7EEWatm9KFrHN5Gz6ajnSVAR
   jgtW8JfbvLPza9jRxgHUxgaH4A8VFoBO9iIHjO/XT65ovaLFCipTv+rs+
   YT5r5rbsZMKMoJ4uPKmCQmbWEh4Pz7KDhe8CZoka3DbdpzDp59HT/wc6j
   gguzw5HC8fo8zUCbr9WJxn42uEXaj/ObT7R7E2vwciAyGp0ujw5r74jQL
   QJuWXk2Pv9eodKP6xxNqnCXJAsw9DqcfHWsfibdz5ByrV2LZS/S/++0GN
   Ip28USAuJX13yv1ose7/MtUZsmkPWnWK5appeZDR4GSwlMJRZEFiiU3Md
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5291562"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="5291562"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 07:55:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="11869024"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Mar 2024 07:55:34 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 07:55:33 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Mar 2024 07:55:33 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 07:55:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KgSEvFTTu0McF8bTrZBiyfolJXpXzyfi57KX2G+TGomXJr6RFeWEcZqPvPY790xxABorGU1Wn/t9uju6HLeoGTigP/SIM0friy7M+FSodN+9QqeTELwoA526JCjfwuvKMostt2fS/xJ/TaEBj1JbkjvETpgLoJoJl7sYc0GfBO0lcYZuJ/irJR5BryfgfEr9jQf2h6RKD13M5HMd74LUKeQJk82MieliJXnEb82QS9nYYmot65enR4CewRrF0dt9Z0VY1XsupnXqd7Y4eSD6sxL6yG5lrumeM1cuCvOXL9vi63KBLIsSUCpToLgKfRzJ37GJ4Mspn70Oifwb+ho3wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrbKo+p3rufy5jarkOc+iF3E+UV5IZks5/OEnxR7RVM=;
 b=VWoDGZpkkUASQ9qLyg1nST6CJn68ysXKrt36rm4abNDKQd0RIrZhhvkoUxPrDBle6/JyH08I/AnYzDL7V1U/RkkJhLcBVw3i1Z5Aq6mJHBrhHWE5kJoXk31sRw1wbrMk5Kwi5NISZW9Qb9CvG2mqsahAqabVGF8lNPA0vWf3pt+GdlwvQTKj1FGCGcWaiT1oB622TwV6u6kh3GzTPO/A+ojnGxSlxJKQWvBfOHOBCaR7IoGr7Xf4ZVEpPAi8dPFhdAls78SqrYy/ylu6FAyQad3Q2XxEyI55bsWJjPJbQUFzwNVGCtLioy4vyrPlqsNO4bLFL92WFbRSiJBbwMAzeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA0PR11MB7792.namprd11.prod.outlook.com (2603:10b6:208:409::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Wed, 13 Mar
 2024 14:55:30 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::fc9e:b72f:eeb5:6c7b]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::fc9e:b72f:eeb5:6c7b%5]) with mapi id 15.20.7386.016; Wed, 13 Mar 2024
 14:55:30 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "debug@rivosinc.com" <debug@rivosinc.com>, "luto@kernel.org"
	<luto@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "broonie@kernel.org"
	<broonie@kernel.org>, "keescook@chromium.org" <keescook@chromium.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "peterz@infradead.org"
	<peterz@infradead.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 03/12] mm: Use get_unmapped_area_vmflags()
Thread-Topic: [PATCH v3 03/12] mm: Use get_unmapped_area_vmflags()
Thread-Index: AQHadMzTz6Z6zGO8YkCu1tXMa0P2wbE1YX0AgABh44A=
Date: Wed, 13 Mar 2024 14:55:30 +0000
Message-ID: <663bfa89e5ea874c1d96203f113529c618ca1655.camel@intel.com>
References: <20240312222843.2505560-1-rick.p.edgecombe@intel.com>
	 <20240312222843.2505560-4-rick.p.edgecombe@intel.com>
	 <660fbd50-64e8-497e-89a2-05cfd4755bec@csgroup.eu>
In-Reply-To: <660fbd50-64e8-497e-89a2-05cfd4755bec@csgroup.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA0PR11MB7792:EE_
x-ms-office365-filtering-correlation-id: 254c9f13-5044-4924-ad6c-08dc436da087
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d/RH8xYSBf3Wy6wFHXYAi5nY+TyDb4EJKNbLFYbkZpSLvaHMo9qE2mjSebkZOaPinTte0k6/P/ulRRho2WMzdS6JDW/7s7KqPwyJ7oPs0oB02bhZNz2UmCS9ByjrHvleSShpdx/S/YPbRoRFM06z5srC436L7dVJse3XXkSSy/Kl3juy/WX+2BFfPrFa2D9040Du+CkHsvaoVCljcTj6Wqj7WO4XNqzktL0d4wnblgfhMh8AUmfBo/y6X9rJK/vZlzsvV0D3wvzRqyifLwIp46eWhK59F8X9MLnK3wmPHhexsM/mrVLhblNLokmNmaluOcl7PyfADRtyFKbzcWCmLA8aeDIB/9NyzdEWw/HXTEKdxxBUdc7jFxpt8A8lsG+DgEaHKWJFS+zq6vbWrQDJ8VFYjtmg2T36iZ8H/LxIMGEGjhd4sCCvNr36I8brFujIxprUCSVCpKuwcrTpZgPzuWA6NIGxN+hTAEQs0Eo0PBzpU8FpZMenL6vDW0S8EYZ0/WjFnz60uTuTmjjLYelS52RxM1AdPavN9rK8HiU1DGEI9sZxq9JspjIAqFKm+a/8hg4zHwAZFZwzNxFNhoWuEJOUCbmdu6xu5G7GU6UDSfGnYmPbKHaHIIa2Ml13PDxrIoVCMzWnQmQBNwXaDVQtlUoqm5pCXu9IcOuc/39v7Qb/fqyAhG4Um7RjD8D98EU6CZOGF6Y7FFViI58y0jwBD9yWi1wMkBjEQI7KSAg5Bpc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MzBFU2w4R3hiWHdkVUhzL2duQkdZcVZpd29yZDBSUTBsd3NmSE95dFpsQTZ1?=
 =?utf-8?B?Mnk0UGhZYU56VjV0T1RZb0xDelJ0UEFsUzlqd25JVk1Uc2puU1RFakh6RUlP?=
 =?utf-8?B?OUhXbm1NQTVUY2xTTWtRZEw5ZHZGZFA3NG05MC8zLyt2L2VuTk1xSzAwc2ZN?=
 =?utf-8?B?WXpoUmJSMHo3WGR4ckJjeWZQZkdTNm9zNHc4eVlsZ3hIVE5LdUJhcTZnVDha?=
 =?utf-8?B?M245Y0FITEREMmtBeDZBQWwreUpDRGJQbUJ3OVJGcGw3N3VjcGtzV0YrNlVr?=
 =?utf-8?B?TVA3aE9qMU5FZmpScm05SURNQVBBKzhtb0RkckNEK2czUEN0THdZZTVYeXNS?=
 =?utf-8?B?OElUVitZMm9zNHNLcFBKclMxKzcyREZDMFVJMnVQdFF4OHkyREViOEovcmtt?=
 =?utf-8?B?UTJsM0RlaGhHUHY5NnVHbFBFL2J0bm9CNTMrYW9abWs3M240RDZWa1hvQkth?=
 =?utf-8?B?WXlUa0ZJaEpXdjFHOWZHUGY5RW8vNkEwOUJIVGZhbkg5a3ZlaXI2VEZubHZ1?=
 =?utf-8?B?bmlUNkhrL2hWWDcxaFBiL0pVdnBTcTZvdnoyaWYzVHhKV0IwYkNsZUxVd2c2?=
 =?utf-8?B?Q3ZTK3RNcC9Ia1MzMEFoempmYk0zeFFLQXlpOURscU51UFFobUYxcmxtN002?=
 =?utf-8?B?NmZLcXUyZVRxVjl3M1BSb1dOMjVBRldiZU9mY0xTZk1xS05wNVc4d3NVWVIy?=
 =?utf-8?B?Wlh5R0RVaGJ1UE1DL0Nid21DRGMyZVFqazQ3ZnYrUzNoL2RnbVdlWkJ3RG11?=
 =?utf-8?B?STlzamhBZ0V6R1Y1MGl1cFJEOTNRU0MrNGVxNzVMWDh2Q0ltaGdHL0NyS1hx?=
 =?utf-8?B?RnQ0TnNTRm11Vy9WYUtiN2IrL2ZZSjRMTWhJVDN4L2xtaXRVQ21nTDc5c04r?=
 =?utf-8?B?MG5qOTVXa1E5bFpFOGMrL3dIc3U3bEdyNDU5MlBCVHhRcmVuSnJtK2ZManFR?=
 =?utf-8?B?Q0REVlhpRnFBWVlWU0pweXMrVDNVeWowdHR3amdrTFc4enF3Y0VtKzVveEtV?=
 =?utf-8?B?dGxURkQvaDZRS0JjVFMxRTg4UldXa0tGbUpwWlZxQ1hZRFNEaFk3WVBjd0Vy?=
 =?utf-8?B?MlFJV2R4ZlorU0VpR2ZEa3MrOGZUcGc0OFVxMkdOVUtpTjdYWjF6SGoreE9M?=
 =?utf-8?B?S0lWeHBldS9ldHdFVmllM242S0lVcHYvL2lpNjRtd2cwaVdkUStOY011QUpE?=
 =?utf-8?B?MUJ0M0tBZEhNVDl2TmVidlA2aHBxclp0N1RZeUNIYUMveUhvSU85WHJYcHdX?=
 =?utf-8?B?WlNiaUxNb0hCKzIyZm9ocTlDZGxWendoMW1mNUtGMS9laGtOYm81aHYyVE5K?=
 =?utf-8?B?aDBKVkFPWTNpQy9YdWdvZG9oTFhkZ1NIUklvZ1h6Q1FsOEdIb3NjYlNWSllG?=
 =?utf-8?B?Z2hEdkQzS3dQUHk0SXhNTjEvS0FPUHBLRW5XajB4clNVZStwSWgwQmowa3VX?=
 =?utf-8?B?MzZDNnpIYmwzQm1vU3ZiaGtHQXNmUFNtdG1YMDNJVGhvZmMzQjFFbSttblVC?=
 =?utf-8?B?T0RCQnI4THJOdzJFakxqMGQ2V3NuSWd1aG9aaC83citIMUhMaXR1TE82Q3lE?=
 =?utf-8?B?bnRFL3lwZGdETFRJaTIwL1RHSEZXZkJRVzRCeDg4YldYNnQweXZmMHZjUlJy?=
 =?utf-8?B?aFVzbXYxM1NLa281dU9Kd3JPK2lqd1VaOVFOZzlWU0l1amVYdExMZjhUR01l?=
 =?utf-8?B?Y1dRczNBQ1V0aDU1RzlOcmt2ajJaTjJMbUlXY01hd1IvaFh4NXJpeHZSQlU2?=
 =?utf-8?B?M1VHYVlRUkg1V3dFNGdOYmhRbkVNd242MmlVZ09TR0lleUNySnZ6Z29nakdZ?=
 =?utf-8?B?WFc2Q0JFVWJSZS9seGg5RzZJRUpDdDNsKzFRbFdzbmplcWxZbXNETnhPNFNm?=
 =?utf-8?B?ME16Rk9ZTmVNbVJrR3RRQy9YaFQvdkFCU0Rpa1JEZjJWWVdseHlsa0JIWnBs?=
 =?utf-8?B?N3huY0JkRmtrcGpLZEFBdGNudm9CaFlpWXNPRVZvVE1OQjlEdGVGd0diSkNG?=
 =?utf-8?B?NEhkSU1OZEFlTDEyRXMrcGtmcWtYWFNsUHd1VXltK0p6WWpSTHJMME5qdlV3?=
 =?utf-8?B?QSsxeER5QVVZaExYd2lJUjE2Z3lXTjZGc3FDbGV1TFNoK1puY054Y09DTWpB?=
 =?utf-8?B?TGRMTk5vbHNUdXNFZU1JMTJ3MSt4c29GTHJuQWtFRWtPdTFtcGlFdkxySWdC?=
 =?utf-8?Q?WylFigsWMhlkG6xBFbTZvy4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4FB9959D691B143B993A0D9104B5FD6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 254c9f13-5044-4924-ad6c-08dc436da087
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 14:55:30.2974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TMv7Bluq0t8eLgjiIoQ2WQBygIGdqZL5pFCNJUhuVtihbcqR3OVH3CllP7xRVUdlhLutMEJCqWJBNX7b0kOnlkXRMSgPSlUv1ZGaczWymYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7792
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTAzLTEzIGF0IDA5OjA1ICswMDAwLCBDaHJpc3RvcGhlIExlcm95IHdyb3Rl
Og0KPiANCj4gV2hhdCBhYm91dCBnZXRfYXJlYSgpLCB3aGF0IGhhcHBlbnMgdG8gdm1fZmxhZ3Mg
aW4gY2FzZSB0aGF0IGZ1bmN0aW9uDQo+IGlzIA0KPiB1c2VkID8NCg0KU2hhZG93IHN0YWNrIGNh
biBvbmx5IGJlIHByaXZhdGUgYW5kIGFub255bW91cyBtZW1vcnkuIFNvIHRoaXMgd2F5IGlzDQp0
byBhdm9pZCB1bm5lY2Vzc2FyeSBwbHVtYmluZy4gQW5kIHRoYXQgcGx1bWJpbmcgYmVjb21lcyBx
dWl0ZQ0KZXh0ZW5zaXZlIHdoZW4geW91IHN0YXJ0IGludGVyc2VjdGluZyB3aXRoIHRoZcKgDQpm
X29wcy0+Z2V0X3VubWFwcGVkX2FyZWEoKSwgc28gaXRzIHByZXR0eSBmb3J0dW5hdGUuDQo=


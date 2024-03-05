Return-Path: <linux-kernel+bounces-92395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1604B871F8A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39F6F1C224E5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F85285920;
	Tue,  5 Mar 2024 12:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eogpd+nK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7074D58AB6;
	Tue,  5 Mar 2024 12:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709643256; cv=fail; b=jXnPoVQE7AfdVNEkK4Hp0A4d5XpwHSx8LQEaKyX27Zn0L3gBK9CU1Dt0nP/EnAfYiKPIp7vesIxEd19E4OJyuvNbEGob4ZOpdoJRJu/OWOa9xquM8ErQILQR14U2glWPCCU5FBep5TfJCXnBntieKBUAZqePR6aO2ipW4GHsMXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709643256; c=relaxed/simple;
	bh=0AeFrB1rBATq9XbI2pLkRv8j8b8rGjhtJ2MTnVN8P2E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qSrlA9wRevfj+Ia0Ad72D8xCsjeAXFcH11sa4pMrvEtTHgPyGSe42vvVJ4nx+UYgZiAZrnEdT+n0kkmmyLmT61M3QJm9CJCpGT+3x08GrlaVRX/P4V82h4XkBa8ccKfHiwutH6oivXRgSb+UorBZ2I8wZf8fZThlkd+YxbgEl4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eogpd+nK; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709643254; x=1741179254;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0AeFrB1rBATq9XbI2pLkRv8j8b8rGjhtJ2MTnVN8P2E=;
  b=eogpd+nKRNDpzhQEZ89a8RmBVFvDOK3PeUQ1WD2JWs2W5WPNmcO40aGN
   yomLT8F5sOw/mOCNv6hXNDYrlbfESyCH/ipbOG/1UcjTAlJXYF38wTcyY
   F8li0/xm5A1zzQTDj14ZsQTxsowCLdcaPmFbc3L5iCxrzj+82zGwB6R8h
   aKOodYcfP/YnICsT+krs3khwz/LiUWBTRLVbSIrkj9a5qAQ8IfliNaiNy
   EKnJrEo7qJY0/sbnmJsckTJH/eO9m4N9t7/i+bAMkHyOZHu0fwKRdGz6L
   4T2YQPf9vKeliYO4t4euPeQdQ1SJT1Kj6EkFTXBNsgwue4H5qsS5XtlRG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="14906719"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="14906719"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 04:54:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="40257620"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Mar 2024 04:54:12 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 04:54:12 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Mar 2024 04:54:12 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 04:54:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDcka6GAkDnv+s/XN8yRtdtPGbd64/PJvyoCeLCTA8YFg8qM4zjERq3QwkuynzksRvee9qvwqVg6yukwAKkh2lt77Pa+zfahtrPHHywJ1yazzOcNGQJ0c0bXCT2J8jg30fkx+NW0FsHTI8RJDe4/BeJ52ASrBB95TaqQZXeszG3dlaxiZlmMKEx197r0Xg6V29p9HvoRYU4XkSVJAM0l9hMUxzoieaTgp2NtCyZ0Dhke5iCNSiVcsASMkQCz1scZ6auQ5WlsLbsX14ZkBt2w/ORNSUyjP0segQDyWPHjMlRxGK0AdTesg0BE+GQLaZzv5CSsM8fTLDDYIcjk0SI8Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AeFrB1rBATq9XbI2pLkRv8j8b8rGjhtJ2MTnVN8P2E=;
 b=Dlj/F14ClnrNdyeTrw/mWxbm9VVw7wOmdvYRYCzY206ySvvGq2v00BW+DFIgS/9RLdhVIf9SxiwFYBWYx7kyoA3GVc0G/flxphytxexN0Q1yzpYvCvkU35JoGvC+wiwP6bw+HrWLWUptFLWh7JkjrqTrHM4fpxuomlaFpM4P2uSqBaU20ffGB3/Q1fNKZH+kBLUksL7ly3dWRVnX7hqLdABCrSONrjKcEwYrakFUBD2Ys1SJNDLtMH1wWtJGOOrbC/NtvkdobKoz1fHgS+2l8TibFTvosax7xA+HzJxFK37oqPu9/ruYh1ysWMrTo556DiwAG9qldHllRIXvDUibOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7605.namprd11.prod.outlook.com (2603:10b6:510:277::5)
 by PH8PR11MB7094.namprd11.prod.outlook.com (2603:10b6:510:216::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Tue, 5 Mar
 2024 12:54:10 +0000
Received: from PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::5144:aca9:5cd9:42bf]) by PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::5144:aca9:5cd9:42bf%3]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 12:54:09 +0000
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Linus Walleij <linus.walleij@linaro.org>, Jens Wiklander
	<jens.wiklander@linaro.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, "Shyam
 Saini" <shyamsaini@linux.microsoft.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, Jerome Forissier <jerome.forissier@linaro.org>,
	Sumit Garg <sumit.garg@linaro.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, "Arnd
 Bergmann" <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Subject: RE: [PATCH v3 1/3] rpmb: add Replay Protected Memory Block (RPMB)
 subsystem
Thread-Topic: [PATCH v3 1/3] rpmb: add Replay Protected Memory Block (RPMB)
 subsystem
Thread-Index: AQHaaZI6hlE8ndSfV0SK+qyaZjIC67EpHm8AgAAGNKA=
Date: Tue, 5 Mar 2024 12:54:09 +0000
Message-ID: <PH7PR11MB7605493349915A168A80CDD8E5222@PH7PR11MB7605.namprd11.prod.outlook.com>
References: <20240227153132.2611499-1-jens.wiklander@linaro.org>
 <20240227153132.2611499-2-jens.wiklander@linaro.org>
 <CACRpkdbhhZ9+Jy_tvWy1RSnyZMjqUhh0ARpS+WRtgWTH3AYCPw@mail.gmail.com>
In-Reply-To: <CACRpkdbhhZ9+Jy_tvWy1RSnyZMjqUhh0ARpS+WRtgWTH3AYCPw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7605:EE_|PH8PR11MB7094:EE_
x-ms-office365-filtering-correlation-id: c4cb7c54-a8f5-404a-4a5a-08dc3d1359bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hh9LzCoECLoaE2/69VJeX74cIInZQ78RMK/nYGW1J5aTY8nbb9xyWC2QL1Rkmf6WSmfJJBHus5xHyarl9f++s+epkP8UpgN0JiBUMjmGQCtBcfeMfcmwDNa865WKE8Y4FFCumk0IzzmiAFObmSRBbZoYcw8564z/3tzOlysmkUfZCjOgkow4b8p6vv5fscySHfHOLGNr4d8CnSzyup0wuQyUkIxN8WyJ7VUuLHmkFsfnKknSdtZA1xYGHWdHP3xI+2lvZa9bO/hBHHnrUxTLFbTyefiBM/F2Id3WY9ktMpuVLzE6pFJvRGDsHowM9squ9zwBjxrUOLFMoPzng2k8lRco9UZjoumCQE4s7qTeyB9T5UfNJwAIOpP96I+Mgtb9PXMkcplS0Gi2EiwIo0fSMAZGaAtEPLairsN8GsnHyXd/Iw4B/nbrMwUa87qvqcCOpleGbGlQobXe4aimDkBVQk27uFB+fC6UYv/p2WP9iHj5vphO1NeTuVWMbtwMBgzDhKW5cU8X/xaEywAwc+MjWcNG6ZwVU3LqBpZGPSdUaR0JZOMRGQS09XJGlykEYtrWo7tyZTwYTtMwGTI7JVgR98QeUSe/WVYrfwKwjcMNZvwwWvShuDQfZ6av6QyulrnKyNpaefzGdwYo541vuDS0RZIXuXNO8E1VEaJy35aInwwhZUu1ivZS/E/zDk1dve4NptF+1PPFqSCPRuqqfbYX3UseGOIXDJWeotM13iUsDNM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGliM1dHb0o0Z1l5ZzNzbFRkU0dKZnY3TC8rdDhmTzNwK3lPenk5eGpBV1BT?=
 =?utf-8?B?N05GbmV2Sm1iZk1LY2tjZHlIUjl0YkMyYlJma3pNb3ZjcUozc2xFSTZycDFH?=
 =?utf-8?B?N1lYS3NtSlorMHdZQXNwRGdBQlZOOXJXWFZWQVVXUkJUVWMrckhrdHcrVitp?=
 =?utf-8?B?Zlc3anFPM0g5cWozS0RwYWluN2UzUGNEWWpaMXFIRGN2c2VabXdUckN5R09W?=
 =?utf-8?B?ZEdjMjZVOElXMXExMEJxVU91bzFEcXdhOU0yVmtwbXNhUTh1Tmk2N1hqa3Iv?=
 =?utf-8?B?K2liZXB0QWszN3hhNmpHRyt2b0pnd3FWYXlEMS83d29Cd1lXTWIwQk9SVGVl?=
 =?utf-8?B?N0JnMktESkVuR2J3SVVUdWJJMW1PZUllZmoxSVZIMUxWRnlPNWcyNU83R3Zt?=
 =?utf-8?B?TEY3bmdJbnlWZUpLM1o2eDFXZlY3cWU3VEVRRnk4QVhzTDdLMG9JUXBENXF4?=
 =?utf-8?B?bW9zSGllVmMxNDZENUdJOVdCMlNiREIwV3VrSmE3ZHBMV3ZmNjI0V2c1WDNh?=
 =?utf-8?B?QWVaamx0ME54L0pEb1BZaEZxQkhnaStUUDFTbTMrN3oyd2ZHVW96V3ZmWnBY?=
 =?utf-8?B?by9HQ3o3ZlRLQ3hFMnJTTFU5K3ROZFU3RUVwQnlXUUZ3ZTNKalVGSHF5d0No?=
 =?utf-8?B?ZmNWSDR5NUlScHQzR05VaVAvemFsdHZKNDYxTFV6WGQ3dmhnSFJ4NDUvOEtX?=
 =?utf-8?B?UU9aMlFORHppQTZYcTVvRWN4MnpPRnUrUlZDRlg5THZucENKOVZNYTczSURm?=
 =?utf-8?B?K1dMUlhsSzZTREx4T3VOMGo1T1lRSGU1V1FUWWNpbzhMa2VManJhbmJVV08y?=
 =?utf-8?B?R2VHelJvMlZxL25GeXlZMU9YYnFVMTJKWjRrUjdldGhzbnlpTHpyUUNOMDRh?=
 =?utf-8?B?bEZQdGVieGdFbkNVVWFodkh1MnUvQXhWVUNUbmlIMzgxVkJnMU1Ca1JFcFpG?=
 =?utf-8?B?eFZ4N0FNMUY1Z0pla3k4ZE4xRXl5SGs5elJhVm5GZzBYTU5hS2Y0Z1pITklB?=
 =?utf-8?B?aENwdGNUUkpGSzhKNVk5ejRhM1lCbWI3a056OWRiSHIyMHA3eFVrUE5qdVhn?=
 =?utf-8?B?T1lVYjZkQ2FzTS9HR092bWNqSFduazhmY1B6YklyNnh0dklLQlB2ZTJ0cjlz?=
 =?utf-8?B?VGFBbkhOY2F6b1RGSjlZQk5GZWNEWDJJSWtuSnBvdzlPOGZjOEFkdHRRWEFv?=
 =?utf-8?B?cDVwUWdxQ2FvQmFmK3doSUMwNlhKRitNOFVVTkxEbDRjb09UMmNneXlxakFX?=
 =?utf-8?B?RjBWVytzTEw2b1Z2SEdDRnZNMnE1V2JIT3ZnbG9NVlJvRUpLT1M3WURsT0ho?=
 =?utf-8?B?RXZhRFd6ejMxbDl0UGNON2UyTjNRWWNiaEFsRzFXT1NlVWwrVk5wR1dySUUw?=
 =?utf-8?B?V1crbWdueE1peTZQOGtrQTNWYkxOelQxSWgxTUtVM2poWE5sNDlyZG1lNzdR?=
 =?utf-8?B?NG1BcVh2NEoxQWU4b3BkZVJwNE5Lb1d2c2R5NDlJR3RKUDZkTzd4K3RveE5K?=
 =?utf-8?B?bWhmL0tuMWFyakhwMXp5bHZXcDFaVThxamlXWEExT1l0U1FyMUtNVlBreHk0?=
 =?utf-8?B?ZXptZTFBMEZmS0wxRHkzcDI2ZHdSYStUQ2tOdnFSSFl1ZkNOc1oxaU5kdU5a?=
 =?utf-8?B?RWhjbHQxbEVPanhyTjZ6Zmk4QUdwbnJtamtVclBwVEpySGhXL25IVmpqWGRq?=
 =?utf-8?B?RkpETUc5UWdOcXo1NWpTMlBnK3FIeDRicXE0bGw3cVgxUnRkTVN5Q2dIeWxa?=
 =?utf-8?B?SGpieWxNREZ1NXBaeHdTNnB4UzdscVFub01GRXl1TkFWdmZmcVltSVZubkpY?=
 =?utf-8?B?Z2pJU0VsNWdZa2NsNW04WlpvSFF4dVVPd3l1aHBVcGRtczhtdk42VkRkZVAx?=
 =?utf-8?B?SzlmRDhWRlRrUUFQa0c3R1J0dWxlYkg0V2JtTHdiWVJPQml4c3N4dndiZkNB?=
 =?utf-8?B?OXZuaCtndWY3eHh1dnEzZnY0MjNUOFdVQUUweTRXYkxqR1I3dWVnNTNtWkc1?=
 =?utf-8?B?ZjRPNnpqVjdRZXVmZ3dXR0RRcWQwY3dsMEhvc0ZPcC82WVlQd0x3VFZtWm9M?=
 =?utf-8?B?Z3NsN3dqVWxOWi9DZ1BLdDRkZkY5cFJNdytlWDFSYStPdWNOOUhweUh1RTJ0?=
 =?utf-8?Q?TKXePW55KZN7vzpxgp8aMkQuq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4cb7c54-a8f5-404a-4a5a-08dc3d1359bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 12:54:09.8349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gNvWJmNoyScSmPSRQOEQ+I2XZgTk7Mf84RPThkeY2MVObt6os10BwDjz1AsC0L/X8vPG7XaVrj6bIeC76EK25Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7094
X-OriginatorOrg: intel.com

DQo+IA0KPiBIaSBKZW5zLA0KPiANCj4gSSByZWFsaXplZCB0aGVyZSBpcyBvbmUgdGhpbmcgSSB3
b25kZXIgYWJvdXQ6DQo+IA0KPiBPbiBUdWUsIEZlYiAyNywgMjAyNCBhdCA0OjMx4oCvUE0gSmVu
cyBXaWtsYW5kZXIgPGplbnMud2lrbGFuZGVyQGxpbmFyby5vcmc+DQo+IHdyb3RlOg0KPiANCj4g
PiArc3RydWN0IHJwbWJfZnJhbWUgew0KPiA+ICsgICAgICAgdTggICAgIHN0dWZmWzE5Nl07DQo+
ID4gKyAgICAgICB1OCAgICAga2V5X21hY1szMl07DQo+ID4gKyAgICAgICB1OCAgICAgZGF0YVsy
NTZdOw0KPiA+ICsgICAgICAgdTggICAgIG5vbmNlWzE2XTsNCj4gPiArICAgICAgIF9fYmUzMiB3
cml0ZV9jb3VudGVyOw0KPiA+ICsgICAgICAgX19iZTE2IGFkZHI7DQo+ID4gKyAgICAgICBfX2Jl
MTYgYmxvY2tfY291bnQ7DQo+ID4gKyAgICAgICBfX2JlMTYgcmVzdWx0Ow0KPiA+ICsgICAgICAg
X19iZTE2IHJlcV9yZXNwOw0KPiA+ICt9IF9fcGFja2VkOw0KPiANCj4gSSBkaWRuJ3QgcXVpdGUg
Z2V0IHdoeSB0aGVzZSB0aGluZ3MgYXJlIGVuY29kZWQgYmlnLWVuZGlhbj8NCg0KDQpCeSB0aGUg
c3BlYy4NCg0KPiANCj4gQXMgb24gdGhlIHByb2R1Y2VyIHNpZGUgKHRoZSBlTU1DIGJhY2tlbmQp
IGl0IHNlZW1zIHdlIGFyZSBhbnl3YXkgY2FsbGluZw0KPiBjcHVfdG9fYmUqIHRvIGNvbnZlcnQg
dGhlbSBpbnRvIHRoaXMgZm9ybWF0Lg0KPiANCj4gSWYgdGhpcyBpcyBhIHJlcXVpcmVtZW50IG9u
IHRoZSBjb25zdW1lciBzaWRlIChzdWNoIGFzIFRFRSkgSSB0aGluayB0aGUNCj4gY29uc3VtZXIg
c2hvdWxkIHN3YXAgdGhlIGJ5dGVzIHJhdGhlciB0aGFuIHRoZSBwcm9kdWNlciwgYnV0IEkgZ3Vl
c3MgdGhhdA0KPiBraW5kIG9mIGFzc3VtZXMgdGhhdCB3ZSBmb3Jlc2VlIHRoZXJlIHdpbGwgYmUg
b3RoZXIgY29uc3VtZXJzIGluIHRoZSBmaXJzdA0KPiBwbGFjZS4NCj4gDQpUaGlzIGlzIGVuZCAy
IGVuZC4gDQoNCj4gWW91cnMsDQo+IExpbnVzIFdhbGxlaWoNCg==


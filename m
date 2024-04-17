Return-Path: <linux-kernel+bounces-148932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DAA8A8928
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C05F2846BF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305D5171070;
	Wed, 17 Apr 2024 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kd9qI+Ay"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B18E16FF53;
	Wed, 17 Apr 2024 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713372224; cv=fail; b=j4f+f7ZxEiyegqVg4Vaa8rtsJTcmheBW5GdNg9Z6mC3o1pqpgXYERwstZetdLHAY92zmGNnUEvsMZNVjLM+FfuYpXJwHxTlVHdomvsUwOUpVxQoM1yOS5sKrxHr8hNEvqyqVU325Ita2oJpghuow1A6tCAI7EV/T7NVhKsExFD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713372224; c=relaxed/simple;
	bh=THaSJ7HJseICCvXZ/+Gcbb4DrSdRpF/c20OuYSE36Lc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eoazc/ekcjFpA6YJjX+9Bi6o/kFi9bUAvUpHBIN41OfskSjhKywreCkj15vRCY1jOmwYReYRGGmqftXCXmzQ3YcKYXgz7F1Z5nxgIurEBzfWVjG2bAs08CRyBOY9C0xO+LQWBsWfoMiOLDfHsuJiE7pqEbp5RjD5wkSSj2IT/rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kd9qI+Ay; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713372223; x=1744908223;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=THaSJ7HJseICCvXZ/+Gcbb4DrSdRpF/c20OuYSE36Lc=;
  b=kd9qI+Ayr646VUknVCTlkr3Y32C0SpQvc0tb0JpzK6Orpln1vh2MyIAu
   NEuHa+hO0Y457RH4kBmLLxu6/98xIobGTxOgNS8JnAWYtNZ5nZS63dfVq
   JUk4TUqfVoszwL/Rl88tLhD/d5s74UsmkgX09cmftIVkzl3+n/8xpBVoC
   3jwEz2f3b15240pZCanbhZI2cHbh2BrdJNHp38XEZpAc+l/cpn4NAtS1x
   kQiVL7CEqeRpPib+9t7o9/Cm8gfnEw9LQteRjgCljDW7g9rzYgXmlSt+v
   RgMg3/Q1y3b0KU3QGuWm6V+luYixmc6tt3ZgawJv3u7NTaIgLc9C/Fxki
   Q==;
X-CSE-ConnectionGUID: Q2ZNxGKtTEyODAcRGb6lQg==
X-CSE-MsgGUID: BsjkNmz4RFiF2G5y5Ptw+w==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="20024088"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="20024088"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 09:43:42 -0700
X-CSE-ConnectionGUID: lpwV+ix4SCyYnHcZxj25dw==
X-CSE-MsgGUID: i9RlVjlWQqujNEeGhv6xDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="22695245"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Apr 2024 09:43:41 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 09:43:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 09:43:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Apr 2024 09:43:40 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 09:43:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzmTHGPs/E2tYgH4TIFXnQMzeBz20R5Ps3dYvL5k/0vHlEt7C6w66sD1tqIUs54bB075OPYxbTPZT8RBzE4GtykPFiVAteGKRiaqwskmdSJYPcLXGrK9ZL89TlRvhrEUjO2tEIfRB2yKq1MuhFYT58N78ikec4wL+pUDMLpYnhkKY0pQKQTxf5d8UfDWW54j2YEbpvPQUP200UQ4y38nrUZg8WihU6SqejVFdKZdNPrNcbxub7yyxthXpikUia2hpRCmwT3Jq065XTC8A2QEfyo1p4sA8CSqc8qVpCOdZUACpsU5xirkDYA7tnuZngMo1AIdm5ogaksj42L9vUHKfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THaSJ7HJseICCvXZ/+Gcbb4DrSdRpF/c20OuYSE36Lc=;
 b=kFRXARhs2V5KNEQjnCJFxrwLqEikgO9txIyYHt6VgLMzXJ74auE29eDnakp7SslokPJ0kIMdzFt6PmUBEKkzkNP+HzwX5zpCDZNldJqy2uSPlXlAlBjY2lIKSKiZwcig7hjh3aiX6RJbcLndWN4MhOXs+lakDGNb4gVTcM2zLuRncweErOvUrk30TqAl9xeOV0sH9Lntx4/2mSsU0voHokp0+ggfWuEE6wx9fCbUu2O4WEMAABPWFjbtAzOVkDftRh7Oq+LlTWoOqFQY89iQTfbXKrwll2Orz3FQtdtBVVXfTPYLhxHY8pKqAS3jcdxDWKGr3LVV+B1ouO3lH8Lnjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH7PR11MB7145.namprd11.prod.outlook.com (2603:10b6:510:1ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26; Wed, 17 Apr
 2024 16:43:38 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7472.027; Wed, 17 Apr 2024
 16:43:38 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>, Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, "linux-integrity@vger.kernel.org"
	<linux-integrity@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
Subject: RE: [PATCH v3 42/74] x86/cpu/vfm: Update tpm files
Thread-Topic: [PATCH v3 42/74] x86/cpu/vfm: Update tpm files
Thread-Index: AQHakEQmjfJi/G5ghU6aC9ZX8qBX2bFsoj0AgAAJN6A=
Date: Wed, 17 Apr 2024 16:43:38 +0000
Message-ID: <SJ1PR11MB608327EBA734DB11B2DAFC84FC0F2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240416211941.9369-1-tony.luck@intel.com>
 <20240416212202.9452-1-tony.luck@intel.com>
 <23faa727-4b1e-4eb2-9e43-c10b8fadaa23@molgen.mpg.de>
In-Reply-To: <23faa727-4b1e-4eb2-9e43-c10b8fadaa23@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH7PR11MB7145:EE_
x-ms-office365-filtering-correlation-id: 2fc12a0f-8968-4788-080d-08dc5efd87f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xgUC1UOoDKYYXC2pimT/a6OZQVzVUR3aroqflIEmWWwPLa1FbHG3iHS1MOu2ikN0r0jbJ6e8+aCpIlc+PWxpjDg0ejtJvHNAIN/WpgQmfF8ttwW2ia4vgZqoITwnigg3pY/toiK0XyexU8uTuLp4lLRcEB19esDqOUDalGe65YS4MRJc9co7mTzO0Ykb2/5wWd/EY8BwgjsEynf8yTIKYBIXsU6LPgOLYc82OW1Fj3URSRRB8z53lhiV8Q+q/NKUFIIPQ74jazZ5LtFxryrW01dp/sUFfnXpXwbgAllcLI7CXHk7ObuNghiVL0tv19/e5wKHR+Ftg4gkUpRDTkM2hQR0GuAJjbx/dzCgp6UM+f95xPvY9ZX4I+rh4cKnNHnYsFofbEfQFUo0cVtURudHgTSznTNTORLx1hUQwJyIKFRLekPhmTafZou6xVQFJI8xkJ5VRLu4iurdrBTy063HPlwdQACKUCoGFcZPV83EGPjwgn5fCe6PAjYrWoxGyzGSzGdf/VQ34x2+EgvTEBIujwwDZm5FjqxwWmgeO0pstDwU9yc/H6QvqqosIm06iFnf8Rc03U63wBbOY0bv/pEMBB6423dTOdpr43xiw1gw02LccgadPv+kT0B+yeo/ujRWLE4NcWbP35hLo+EryEuVSnVzOPEpaDrF9Ort/OX4MIvN0wz3rgEJwrbzj5ulcuStKA0nmg3QZaFMXliVDJx2dzshAZT4qjICgfjhGurMrwY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3NwVUYxcFJab215cTRTU3dWbDRiK2RWeE1GU2RrMXpKUkJhM3Qvcnk5aEkr?=
 =?utf-8?B?SzNHaVFyVEY1cjRuVVh5K0JPK2xYalVTcTNjTllJUm0zUmRxTHFFc1JhbUtD?=
 =?utf-8?B?SCtma0RzNTVaTk9DNXVpeUFKTDVHZjZNV2xLMWU0d2xiRldUVnZsbGRKRGFZ?=
 =?utf-8?B?U0pJWXgyN1kvNDNKcEVIdi9uRkx0ekZYL3dQYndvNmw4aDVIalgwM3RsVndi?=
 =?utf-8?B?YzQ5Um54alg4ZEl1K0ZJRWVSSld6V0dLTUNUeTR2c1VaRVhVR3ZaMkRSTGZK?=
 =?utf-8?B?ZC9wUTBVenRGVHd5ejNCN2pxNENpQUNaVGtDVElNcG56RUEvVmFiVnIzNXMz?=
 =?utf-8?B?QnRwVG5SVnBkclRmZUZkcVJ3eVRTNHhUQWYxLzJETkM2amsvcW9zd2xNbkJo?=
 =?utf-8?B?Qlk4V0V5a25QWnZPMmkxT1pwdXV5UFIrQ2JJTU1iemV5M2FpaTRYa3FyckFM?=
 =?utf-8?B?Tlk3azlicjJtOEw2K0d0U0hEMVlPK1k4K2dvZjhQV25Na1VOdGZJQmFnaGNU?=
 =?utf-8?B?VHBYeFh6UVMxOVBYemdNeDNkLzVablg2eFpUeDdSR3pRalo1NkNPQ1J1Sm5F?=
 =?utf-8?B?dTcwVmxZQUtyYzc5Q3o1T0pJRjQyS0dNR0xVZG10R2k3TGM5Ulo2UGRDZHBj?=
 =?utf-8?B?L3h4T3MxaFF1Z21kSXZJaDk2cWpMcmRybmNEQVp0NGIzektQbDBFOWxDN2VN?=
 =?utf-8?B?Q0xnMUt2OUd1dWk4K3RycE5pNUxLczBVU3RpRVY5MkhsUkc3b0phVEtvUFZN?=
 =?utf-8?B?SnV4QXQyb1BhTUt5S3BZOUhzOVc4MTJ3a3hGL2tPZjhHM09LRkhua2FTMjAy?=
 =?utf-8?B?SVE3bUlvbDF6ancrY1NqRDc2OVF2T3IvWlB0Y1pHR3ZXQkhZVFJ4NHkwVjlP?=
 =?utf-8?B?d0tNZm1ldFhETFZ4anFlL0xrVkhqZ2VIVTRCMVk0RHNCRjc4TzNrcHhuRHpQ?=
 =?utf-8?B?Rk9mcDBXYkV3VEtvZEp6TUpGamFZK0VGTmZYM01VZ3NhOTZ6Ui9EQjNiN3dY?=
 =?utf-8?B?UnNyYjNDSWJseW1ZTU1Wams2My91blloZlZHZWtvRDY4ZEFCbzdEcWg4amVX?=
 =?utf-8?B?bzJ0SVgxVlNpVmxQbUp6VWZmMFFCWDd5ZjdnZnVQQXJ3alh6TVN1OHBWeEVY?=
 =?utf-8?B?amw0YlYwNlF2aGw1NkFqcDVCZ1pxTXFqN2drOXQzRFVrSEtvZTFnaW5tYjRv?=
 =?utf-8?B?RGZUTmY1R0taeFIrZnFCeEVRSWtIbWs1MTFPMDZ6OVo3Rmh4S2E3bkRkV0tz?=
 =?utf-8?B?eWhSdHhRTVhlakY2aGNWZFVnMFkxUmQ3VlNSTFRWejJjOWpNRVJGamxjTktv?=
 =?utf-8?B?eGxhcmtkUU41ODREVnBXUGc1dkMyZkxrelBiYy9pN2liNTI5dWJ3bllIa3VB?=
 =?utf-8?B?TEtqYmoxWTM4R3krYmxBcGs1REVwWnhWTVlqWXo0VlcvMVhEajlFc21ERG5L?=
 =?utf-8?B?aUl3ZlBndDlWL3pwL0RQbVBQUDl2SU5LL0FzLzA0aDhaV3FBVFpxWEZDakFD?=
 =?utf-8?B?ampiM2hjR1hCVlAzQUNhT3J1RG1wM3BwalhrUTFtYWVDb0RFcDErc0YrRE5P?=
 =?utf-8?B?L1J3NDZaeS9vclFLalVodVB4M0J4UGV2eE9LV0JVZEoyb2hyYTF2Z3hDaWFU?=
 =?utf-8?B?YytEM0NSV2ZwVW80c25FMHRyd2pqMzRqdmtFZ2N0aStsb2duZ0IrN1NoeEZu?=
 =?utf-8?B?VGIrMTNXc29IL3lvNWthN1lyUGtJYldNM1pveVRqTHl1UnBnNWFvZ2NWemxF?=
 =?utf-8?B?djdaWnZSMzNQa3hJUDk4a2haeUF3RzBWQUpJYm9XTE00aFloZHFxS3J6OGxp?=
 =?utf-8?B?OU5IQ21pUndwSDg0d0xLNVA4RFNqd1hOcG9TbXdzamFsNVZhTy9ERk9KRVpx?=
 =?utf-8?B?VDhlMFJvWWNzbVh5eGhseUdyNDZGV055YTB6blhJY1FScEpVY2lpU1VrMjhM?=
 =?utf-8?B?OGpEQ0xvcUdtM3k0SHQxZm1zYU1vdnpXWUZ0aVZ1Y2FMQk1HcnJOcklrL1VV?=
 =?utf-8?B?NnNpeTQ1amtNOFhTT3paUjRQWFZaanVzSVlHQnM3Vlk2YXBXQy82Q1hDK1dv?=
 =?utf-8?B?WHBndFFTdENMYXArdXlkdTVYQWpsVVdMWld5L0t4NjN6Qk9JVFByaGpmcnZi?=
 =?utf-8?Q?sjfI9uZRJGnhJPJOfRuCo4rCs?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc12a0f-8968-4788-080d-08dc5efd87f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 16:43:38.0413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hdYPz2Ndn3z4S8BibuA6NXzJMOQz/y/+4LqcRGkfU93avoc3hoa6iH1rLeLSakbHaxIw2vFMlFm//KIDD/H+8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7145
X-OriginatorOrg: intel.com

PiBUaGFuayB5b3UgZm9yIHlvdXIgcGF0Y2guIEl04oCZZCBiZSBncmVhdCBpZiB5b3UgY2hhbmdl
ZCB0aGUgY29tbWl0IA0KPiBtZXNzYWdlIHN1bW1hcnkvdGl0bGUgdG8gYmUgbW9yZSBzcGVjaWZp
Yy4gQ3VycmVudGx5LCB0aGUgc2hvcnQgbG9nLCANCj4gYGdpdCBsb2cgLS1vbmVsaW5lYCwgaXMg
bm90IHZlcnkgbWVhbmluZ2Z1bC4gTWF5YmU6DQo+DQo+IHRwbTogVXNlIG5ldyBWRk0gbWFjcm8g
SU5URUxfQVRPTV9BSVJNT05UDQo+DQo+IG9yDQo+DQo+IHg4Ni9jcHUvdmZtOiBVc2UgbWFjcm8g
SU5URUxfQVRPTV9BSVJNT05UIGluIHRwbQ0KDQpQYXVsLA0KDQpXaXRoIDc0IHBhdGNoZXMgaW4g
dGhpcyBzZXJpZXMgdGhlcmUgd2FzIGEgbG90IG9mIGF1dG9tYXRpb24uIEknbGwNCnNlZSBhYm91
dCB1cGRhdGluZyAiU3ViamVjdDoiIGxpbmVzIHRvIG1hdGNoIHN1YnN5c3RlbSBjb252ZW50aW9u
cw0KYmVmb3JlIHRoZXNlIGFyZSBhcHBsaWVkLg0KDQpBcGFydCBmcm9tIHRoYXQsIGFyZSB5b3Ug
T0sgd2l0aCB0aGUgY29udGVudHMgb2YgdGhpcyBwYXRjaD8NCg0KLVRvbnkNCg==


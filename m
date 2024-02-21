Return-Path: <linux-kernel+bounces-74904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7A485DFD0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEC7DB24D30
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098717F7EA;
	Wed, 21 Feb 2024 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VGM1/iTD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2E378B5E
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 14:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708526103; cv=fail; b=W1qWULsjhT+bRYJ9jwceNFR1822Cie7CTxUtWqnw7xdby4D5zLEn/vyQcPV8o39Yrz1XJ0zpKvEXLexOq97B+5w+0jzG9wY3RUyDiXTs6f1mdfppI9iXolgJIzd0vYtodnVPU8MJptbUH5PO/zwBYJcAvLwu8QfcseGujoUjQWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708526103; c=relaxed/simple;
	bh=+zMQ8/MzmGurJj/Svpfnw2WDqr5UR8cxLmZjJsl2fI4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P9l7gO8fAsMfr/d8WujFZOkvrii6I3Et/4P1tRztOBF4JKJuzPP0upJ7pW9ltSNBa/G+mMJoTIvg6iuK4oX3Usq4+6ugfD74gKuGKY7i2wrf8m7+SpO0VxUb8DQKnSZjKB2Ycpb8mAgEFoAH9ZF/z34M7bplmLH+3gdAbQ0AAkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VGM1/iTD; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708526102; x=1740062102;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+zMQ8/MzmGurJj/Svpfnw2WDqr5UR8cxLmZjJsl2fI4=;
  b=VGM1/iTDS5NNb1ZTDfU/6M+/H0+iDyA++SNHbWFJAe2J1D6Sw4cjkpbh
   zeHwgCLwUX48oVTl3sD6oHtzLLYWTD38YGFcC84UxdFiycNJUIT+/+n14
   9TVp90xHGA8ttHJmvcQRBG6Vw+KrgAJV7uL34Gs55np7dcxj/sQ3lDSGt
   phDsrnYHfFHaeqyHVbSO47ZnueIoGczXCebcRp2ekzgmvBTdVrYkV2VVX
   5TMcaS9OTFJW/9bznPCr286/qc6+avV5enSQWKCIi+wZtt2S4pCcvptEB
   7MUY9moQRBhv9juMl0avVmG5B/b4tfoWCF2ikFqrrQPaxcqz6WzmqJdKQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="3170069"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="3170069"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 06:35:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="9768922"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 06:35:00 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 06:35:00 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 06:35:00 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 06:34:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFpmtEEB0mpaz+w4isnf3izR92HHZ0ZVJpXmhvQx/+BgvsKNEhDwgxJIbOdNambtD0FNoDg9y1ALbTYgMPLrHWQ3X4qVXK9O0a1qW/gChXyY0VXFUucht/Spluyuga+goUVmlV64TCHQ2CRcCIk0624rvbCQOXoIUOKi2w2JTcSi6lrn02TleFcdYeCkvqC5s42mu39fugw+kQ4CcD4h+0MGNssXerzzUyxHqrxZGF7cIke9KcnAu8K7JnvDM2IM1QDlQTgxVmLSJKLrBBNr+Zs4wWioLDNLwTccHUt0uXwx2k/5831XMuRmq+YuDPMH85RH/Ief+wYuNY/OGd4NYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zMQ8/MzmGurJj/Svpfnw2WDqr5UR8cxLmZjJsl2fI4=;
 b=Lc8msA8DVKWwwiRbOTshTMs1Kz002ZcYA+cHittgN1iItcu+8yHdy8hb6BsvCxDTMwBs1/pvOPz8ysdehpWwcqbI36tJkr1VzvUtxr0Msx4n2XOpMh5XuIYszRYLelWY+kRa/oZPhMgWZFXJDt50Vxwopy3Pqi2UNHVdZSIdRzK7sECezamUeN8hHdggnahnAT96r5aIB6adDM+NrLJG/HmLwWcP0L8bR4rjaUnSozpl20PMoUCQdR3Q5wSoF3tko/xF3OlhMPOLIfBtteWkqt0JAOpsk3tLEi3h5iB+Opq5zOsRSyPJ0Iycqr5y2iKDrRDlBoBsX5iM/R+dqK03CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 BN9PR11MB5404.namprd11.prod.outlook.com (2603:10b6:408:11d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Wed, 21 Feb
 2024 14:34:58 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::7e88:63ca:dd41:d190]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::7e88:63ca:dd41:d190%3]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 14:34:57 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Borislav Petkov <bp@alien8.de>, =?utf-8?B?RGFuaWVsIFAgLiBCZXJyYW5nw6k=?=
	<berrange@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter
 Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Kirill A . Shutemov"
	<kirill.shutemov@linux.intel.com>, Theodore Ts'o <tytso@mit.edu>, "Thomas
 Gleixner" <tglx@linutronix.de>
Subject: RE: [PATCH v3] x86/coco: Require seeding RNG with RDRAND on CoCo
 systems
Thread-Topic: [PATCH v3] x86/coco: Require seeding RNG with RDRAND on CoCo
 systems
Thread-Index: AQHaZMI0e+uC4Xjgr02rINi1nuP+9LEU3C1A
Date: Wed, 21 Feb 2024 14:34:57 +0000
Message-ID: <DM8PR11MB57505A725BC9E90219F642A3E7572@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <20240221123248.25570-1-Jason@zx2c4.com>
In-Reply-To: <20240221123248.25570-1-Jason@zx2c4.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|BN9PR11MB5404:EE_
x-ms-office365-filtering-correlation-id: 66f23bef-5ad0-4b29-88c8-08dc32ea4703
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nkKAjjp5D+EJMRYY0+koD2C44OMb6jE8aX279cSK8IskHIoFPk1gvJDvywe0Ebhwo58/74TXOIfHAqeYdQr2126/jhbCf0u0bPoOs5d8MGOUgdyeUGYXrqEi5JqiATaAHk/r0PeE630o3cNpjffEEK6wC/T+zm1OLF98TeIatMpmw85FWkyHPnqwwJoE40lzgSDnbcIheJMTuN6e0tDP6T8wir3p4tRQ1y0pc9V9EmrpwRxqSgGKi/zRdoicUpZ1cqPlFzInuBP4hpvyFKfl6gfzqQyx2AO79j51fwy4InXOxXNRhdLir0l7Vtlo1xN5kDIfOTkwK/Oy9Wux/BgUoiR/H/1Ib2nv5ZBEjxdd1HReG9u4DudOi4/ipUi5Fl2q7JGaJgx2M1ie+pT4GTGMxQgUDxZ4K3oZrQRiPH/y0pAx2xJ7mzNksmVWVm3JXyyojmeSfjeUFxQnEiBlluZqL2tBjW5JjrLSE4ZICEdQ8kyk6I4jCM7SxIaoOMxXvTNmM1C7Trx6CV5C8IfwvF6W+p7Gsaq7zSPx/RYLAKxRKqpSjVr4UaNtrU/j8stKYvzI2latp0u8FznrGDYncOtRXmKhwfv999W7eTn96NESrNl+qXMYqOdkSMvN1dmo9SSG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0s2R1lBbit2bk10WVFSUWhVNHBDamxEK0tGZkc3a2FmNThpVWNPdk55aER0?=
 =?utf-8?B?ZThVMGx3SGJWV1hrTDhyWk8zRHpJaHRxc21tdDRad0Z4bjVaZG1vWXV0N1Np?=
 =?utf-8?B?MzhIOHhUQlBIK1c2Y3dvNlk2RGw0VWZ2cGJjMGY2QkZrdHd4b3N1SjVhbUMx?=
 =?utf-8?B?cG1iMi94SlpDK3pZQk1FREJ2T0FIL1pnTCtBMG9vTjZ3VVJHZmt4dHdZYlV0?=
 =?utf-8?B?UnpUb3FiRlVQSkN2RUtxQVpkUFV6enNnYTAvYk0xNUt3SEFDeWR0VnpRb1hr?=
 =?utf-8?B?MTNLM0FlZXp0eWhUZkRHWGtocEZjVStRUmtIVG9tbE1kaCtGZHd1a1R6VXow?=
 =?utf-8?B?eTJMS3hueFFTRU5ic2gxeXpXUWdQbFdZTjQ0TXFWN0gxazNtTnpLQzJrN1BM?=
 =?utf-8?B?RE92amJwdHZ5ZzY5UHdxNlpwK3ZNVzZqcWdIOE9zdzBwcm1OSSszRGltaUJF?=
 =?utf-8?B?c0tWRzhQZHgvcTR3YXQzamU3SlNnQ1RSbzd4T0NhYm41cWVpWlp3dzZRbm1a?=
 =?utf-8?B?ekhLWWduVEJXb2pzV2pLWXdqQnA3azBtL3hCTUNrT0JxcHYxQkpCVHdVQVhm?=
 =?utf-8?B?QWl3ejBnYW5mVi9VcThnajJjdEs4eGF6RmlLWk1DZzZjUUV2TFBiRUU0MUkr?=
 =?utf-8?B?cFZBaVZCODhhUW0vLzJSZHJEc2t4N0hvUEJxcDY5SkpmNlNxTi8yNllEQmRW?=
 =?utf-8?B?ZThTb1ZVeVJ6czZvODNXOGxsQWJkOHZtQ2I1ZmovaE5YQmsrMHJxWllTbERP?=
 =?utf-8?B?ZExPZGFOWFV4bFI4Q0NBd081YUhadzgxSEYxdyt3WkJ2U1FlOVBGWWdSZmFD?=
 =?utf-8?B?NUdDRmY5ZTZJbGg4YVU3Nm9DWkhRckVjWFpHSXhrYkVhUDVES0tNR2ZCdzJY?=
 =?utf-8?B?Z0dpSFZMZUdjRG9KVmdtaEE2a1FmNE5BNUNNaWpHcU1NZWRUQjh2Q0l5SHZ2?=
 =?utf-8?B?YVVxWlhqU2NaQjlzNExvbkRZM2syczRrSVp2Y0VaZGtNMmJnc3hCcVUvV00r?=
 =?utf-8?B?ajEyRXZ4RE9nU1pEOHRuR2ZNZ0l6OVJFZENrc2VBUURJT29YSDFEU2NsUDdZ?=
 =?utf-8?B?ZGhqeEM5ZUFKc0dxUFJpVTFiNUdlaWJzMSt2NVU1aXJIVVkxZ1VLcWtuczJs?=
 =?utf-8?B?cjIrSDdMT0pOZGJCaDJFNlVCMTdqL1JDK0RSR0wzaXIzL1JlM0RVYmIwUkR6?=
 =?utf-8?B?cmVvTjlmNDlCTGhLaVllMzVWOXJPUzNneGxyMU96azljSXBZQUt3c0V3L3VF?=
 =?utf-8?B?OTMwQzFWK3ZwTWxqNHQ1THZsSzVkeWVpTXZIbGFqdi9DTkIyNlZZYytic3Iy?=
 =?utf-8?B?eThZdEVHY1FKdnZWVDhpV3dpS240am9VdUlhZEwrK1NwMThlZHhWOEVTR3Z2?=
 =?utf-8?B?bG1wSEZoaFE0ZlNMMllrSWtOcGZ1a3ZHMDdGV1NidGI3c3Y2emlOREYyYThk?=
 =?utf-8?B?cmxlcXVjYUg5YlNOd1NIc0cvTVpxL3Qwb3EzTFBRd2lGV2VhSUN5T3hvSGtt?=
 =?utf-8?B?VWJITTNRZ3A5ZytnbTZLQ3NmZjhIRktZb1VlYkRNL3pqZjRscjY5Qno1YnNx?=
 =?utf-8?B?VWZVYUk3NkxSRU5kNHlrblpPd0NOWlBlVUNlZFJ2R1hhVE1Ca2E5eUk0dU05?=
 =?utf-8?B?SUI2anYzNEJnWnJPOUZRRU44MjByTnBwOTlKY1N6N1BFWFE1QUNGU2FLY0Zv?=
 =?utf-8?B?a3dSYXQwVHNKcFhpdUdVYmlCdnFObVdBaDk0RVVwZGQwRDYzL0o1K0Mzd05J?=
 =?utf-8?B?Tm84dFhNYm1sRytnWVEra0pNT3pERWlXSnkxYllTeUVYVlhXVjFlSUtaYlZ4?=
 =?utf-8?B?aDdtV0FwYVlJTEF0dno4cG9JRmtTeGdXNDB2WXdKYzhlS25WMzI2dnNnWENQ?=
 =?utf-8?B?dDRHdXlIaVd6eWRJS3BjRzhIaU9CbkFIbmhRWVV6QWFJNnRWOXI3M05oNi9S?=
 =?utf-8?B?TE1oRFhTdE54clVmcTFSVmxHMTRxK1RtaFJJUmtkQTRVUmJ6c0JzbUIrZFgy?=
 =?utf-8?B?bEUzUGhjelRhMnVNU0Y2UDJzMHREYWVDMFB1cHdBU09aUGUzc1BSUDJlN3hN?=
 =?utf-8?B?bis4ZU9RRkJBN0lYMmdNdTVuN3hoZWk2RDF6ejFuYkdLVDV1bUZtTXBuSTl6?=
 =?utf-8?Q?bOnWLEMbFSmCcIPshWGQ00Gwm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f23bef-5ad0-4b29-88c8-08dc32ea4703
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 14:34:57.4696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ch2KqUk67E7pCzOivnxCixqllBcX4Dhxd9ccudNKU1E14YyF9JUne/PJQE0IHv0YvfUUlLRVEa457cb9x9lNqksaQQjZ770LULpeQlAARLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5404
X-OriginatorOrg: intel.com

DQo+IFRoZXJlIGFyZSBmZXcgdXNlcyBvZiBDb0NvIHRoYXQgZG9uJ3QgcmVseSBvbiB3b3JraW5n
IGNyeXB0b2dyYXBoeSBhbmQNCj4gaGVuY2UgYSB3b3JraW5nIFJORy4gVW5mb3J0dW5hdGVseSwg
dGhlIENvQ28gdGhyZWF0IG1vZGVsIG1lYW5zIHRoYXQgdGhlDQo+IFZNIGhvc3QgY2Fubm90IGJl
IHRydXN0ZWQgYW5kIG1heSBhY3RpdmVseSB3b3JrIGFnYWluc3QgZ3Vlc3RzIHRvDQo+IGV4dHJh
Y3Qgc2VjcmV0cyBvciBtYW5pcHVsYXRlIGNvbXB1dGF0aW9uLiBTaW5jZSBhIG1hbGljaW91cyBo
b3N0IGNhbg0KPiBtb2RpZnkgb3Igb2JzZXJ2ZSBuZWFybHkgYWxsIGlucHV0cyB0byBndWVzdHMs
IHRoZSBvbmx5IHJlbWFpbmluZyBzb3VyY2UNCj4gb2YgZW50cm9weSBmb3IgQ29DbyBndWVzdHMg
aXMgUkRSQU5ELg0KPiANCj4gSWYgUkRSQU5EIGlzIGJyb2tlbiAtLSBkdWUgdG8gQ1BVIGhhcmR3
YXJlIGZhdWx0IC0tIHRoZSBSTkcgYXMgYSB3aG9sZQ0KPiBpcyBtZWFudCB0byBncmFjZWZ1bGx5
IGNvbnRpbnVlIG9uIGdhdGhlcmluZyBlbnRyb3B5IGZyb20gb3RoZXIgc291cmNlcywNCj4gYnV0
IHNpbmNlIHRoZXJlIGFyZW4ndCBvdGhlciBzb3VyY2VzIG9uIENvQ28sIHRoaXMgaXMgY2F0YXN0
cm9waGljLg0KPiBUaGlzIGlzIG1vc3RseSBhIGNvbmNlcm4gYXQgYm9vdCB0aW1lIHdoZW4gaW5p
dGlhbGx5IHNlZWRpbmcgdGhlIFJORywgYXMNCj4gYWZ0ZXIgdGhhdCB0aGUgY29uc2VxdWVuY2Vz
IG9mIGEgYnJva2VuIFJEUkFORCBhcmUgbXVjaCBtb3JlDQo+IHRoZW9yZXRpY2FsLg0KPiANCj4g
U28sIHRyeSBhdCBib290IHRvIHNlZWQgdGhlIFJORyB1c2luZyAyNTYgYml0cyBvZiBSRFJBTkQg
b3V0cHV0LiBJZiB0aGlzDQo+IGZhaWxzLCBwYW5pYygpLiBUaGlzIHdpbGwgYWxzbyB0cmlnZ2Vy
IGlmIHRoZSBzeXN0ZW0gaXMgYm9vdGVkIHdpdGhvdXQNCj4gUkRSQU5ELCBhcyBSRFJBTkQgaXMg
ZXNzZW50aWFsIGZvciBhIHNhZmUgQ29DbyBib290Lg0KPiANCj4gVGhpcyBwYXRjaCBpcyBkZWxp
YmVyYXRlbHkgd3JpdHRlbiB0byBiZSAianVzdCBhIENvQ28geDg2IGRyaXZlcg0KPiBmZWF0dXJl
IiBhbmQgbm90IHBhcnQgb2YgdGhlIFJORyBpdHNlbGYuIE1hbnkgZGV2aWNlIGRyaXZlcnMgYW5k
DQo+IHBsYXRmb3JtcyBoYXZlIHNvbWUgZGVzaXJlIHRvIGNvbnRyaWJ1dGUgc29tZXRoaW5nIHRv
IHRoZSBSTkcsIGFuZA0KPiBhZGRfZGV2aWNlX3JhbmRvbW5lc3MoKSBpcyBzcGVjaWZpY2FsbHkg
bWVhbnQgZm9yIHRoaXMgcHVycG9zZS4gQW55DQo+IGRyaXZlciBjYW4gY2FsbCB0aGlzIHdpdGgg
c2VlZCBkYXRhIG9mIGFueSBxdWFsaXR5LCBvciBldmVuIGdhcmJhZ2UNCj4gcXVhbGl0eSwgYW5k
IGl0IGNhbiBvbmx5IHBvc3NpYmx5IG1ha2UgdGhlIHF1YWxpdHkgb2YgdGhlIFJORyBiZXR0ZXIg
b3INCj4gaGF2ZSBubyBlZmZlY3QsIGJ1dCBjYW4gbmV2ZXIgbWFrZSBpdCB3b3JzZS4gUmF0aGVy
IHRoYW4gdHJ5aW5nIHRvDQo+IGJ1aWxkIHNvbWV0aGluZyBpbnRvIHRoZSBjb3JlIG9mIHRoZSBS
TkcsIHRoaXMgcGF0Y2ggaW50ZXJwcmV0cyB0aGUNCj4gcGFydGljdWxhciBDb0NvIGlzc3VlIGFz
IGp1c3QgYSBDb0NvIGlzc3VlLCBhbmQgdGhlcmVmb3JlIHNlcGFyYXRlcyB0aGlzDQo+IGFsbCBv
dXQgaW50byBkcml2ZXIgKHdlbGwsIGFyY2gvcGxhdGZvcm0pIGNvZGUuDQo+IA0KPiBDYzogQm9y
aXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+DQo+IENjOiBEYW5pZWwgUC4gQmVycmFuZ8OpIDxi
ZXJyYW5nZUByZWRoYXQuY29tPg0KPiBDYzogRGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGxpbnV4
LmludGVsLmNvbT4NCj4gQ2M6IEVsZW5hIFJlc2hldG92YSA8ZWxlbmEucmVzaGV0b3ZhQGludGVs
LmNvbT4NCj4gQ2M6IEguIFBldGVyIEFudmluIDxocGFAenl0b3IuY29tPg0KPiBDYzogSW5nbyBN
b2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+DQo+IENjOiBLaXJpbGwgQS4gU2h1dGVtb3YgPGtpcmls
bC5zaHV0ZW1vdkBsaW51eC5pbnRlbC5jb20+DQo+IENjOiBUaGVvZG9yZSBUcydvIDx0eXRzb0Bt
aXQuZWR1Pg0KPiBDYzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+DQo+IFNp
Z25lZC1vZmYtYnk6IEphc29uIEEuIERvbmVuZmVsZCA8SmFzb25AengyYzQuY29tPg0KDQpSZXZp
ZXdlZC1ieTogRWxlbmEgUmVzaGV0b3ZhIDxlbGVuYS5yZXNoZXRvdmFAaW50ZWwuY29tPg0KDQo+
IC0tLQ0KPiBDaGFuZ2VzIHYyLT52MzoNCj4gLSBSZW1vdmUgcGF0Y2ggdGhhdCBoYW5kbGVkIGdl
bmVyaWMgUkRSQU5EIGZhaWx1cmVzLCBiZWNhdXNlIHRoYXQNCj4gICBkb2Vzbid0IHJlYWxseSBo
YXZlIGFueSBpbXBsaWNhdGlvbiBmb3IgdGhlIFJORywgc2luY2UgaXQncyBzdXBwb3NlZA0KPiAg
IHRvIHJ1biBmaW5lIG9uIHN5c3RlbXMgd2l0aG91dCBSRFJBTkQgYW55d2F5LCBhbmQgQ29DbyBp
cyBhIHdlaXJkDQo+ICAgc3BlY2lhbCBjYXNlLiBJZiBwZW9wbGUgc3RpbGwgd2FudCBhbiBleHRy
YSBnZW5lcmljIFJEUkFORCBmYWlsdXJlDQo+ICAgaGFuZGxlciwgdGhhdCdzIHN0YW5kYWxvbmUg
YW55d2F5LCBzbyB3ZSBjYW4gZG8gdGhhdCBkaXNjb25uZWN0ZWQgZnJvbQ0KPiAgIHRoaXMgcGF0
Y2guIE5vIG5lZWQgdG8gbWFrZSBpdCBhIHNlcmllcy4NCj4gLSBVcGRhdGUgY29tbWVudHMgYW5k
IGNvbW1pdCBtZXNzYWdlIHRvIHJlZmxlY3QgdGhpcy4NCj4gDQo+IENoYW5nZXMgdjEtPnYyOg0K
PiAtIHBhbmljKCkgaW5zdGVhZCBvZiBCVUdfT04oKSwgYXMgc3VnZ2VzdGVkIGJ5IEFuZGkgS2xl
ZW4uDQo+IC0gVXBkYXRlIGNvbW1lbnRzLCBub3cgdGhhdCB3ZSBoYXZlIGluZm8gZnJvbSBBTUQg
YW5kIEludGVsLg0KPiANCj4gIGFyY2gveDg2L2NvY28vY29yZS5jICAgICAgICB8IDM2ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgYXJjaC94ODYvaW5jbHVkZS9hc20v
Y29jby5oIHwgIDIgKysNCj4gIGFyY2gveDg2L2tlcm5lbC9zZXR1cC5jICAgICB8ICAyICsrDQo+
ICAzIGZpbGVzIGNoYW5nZWQsIDQwIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9h
cmNoL3g4Ni9jb2NvL2NvcmUuYyBiL2FyY2gveDg2L2NvY28vY29yZS5jDQo+IGluZGV4IGVlZWM5
OTg2NTcwZS4uMGE1ZDU5OTY2ZDZkIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9jb2NvL2NvcmUu
Yw0KPiArKysgYi9hcmNoL3g4Ni9jb2NvL2NvcmUuYw0KPiBAQCAtMywxMyArMywxNiBAQA0KPiAg
ICogQ29uZmlkZW50aWFsIENvbXB1dGluZyBQbGF0Zm9ybSBDYXBhYmlsaXR5IGNoZWNrcw0KPiAg
ICoNCj4gICAqIENvcHlyaWdodCAoQykgMjAyMSBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJbmMu
DQo+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjQgSmFzb24gQS4gRG9uZW5mZWxkIDxKYXNvbkB6eDJj
NC5jb20+LiBBbGwgUmlnaHRzDQo+IFJlc2VydmVkLg0KPiAgICoNCj4gICAqIEF1dGhvcjogVG9t
IExlbmRhY2t5IDx0aG9tYXMubGVuZGFja3lAYW1kLmNvbT4NCj4gICAqLw0KPiANCj4gICNpbmNs
dWRlIDxsaW51eC9leHBvcnQuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9jY19wbGF0Zm9ybS5oPg0K
PiArI2luY2x1ZGUgPGxpbnV4L3JhbmRvbS5oPg0KPiANCj4gKyNpbmNsdWRlIDxhc20vYXJjaHJh
bmRvbS5oPg0KPiAgI2luY2x1ZGUgPGFzbS9jb2NvLmg+DQo+ICAjaW5jbHVkZSA8YXNtL3Byb2Nl
c3Nvci5oPg0KPiANCj4gQEAgLTE1MywzICsxNTYsMzYgQEAgX19pbml0IHZvaWQgY2Nfc2V0X21h
c2sodTY0IG1hc2spDQo+ICB7DQo+ICAJY2NfbWFzayA9IG1hc2s7DQo+ICB9DQo+ICsNCj4gK19f
aW5pdCB2b2lkIGNjX3JhbmRvbV9pbml0KHZvaWQpDQo+ICt7DQo+ICsJdW5zaWduZWQgbG9uZyBy
bmdfc2VlZFszMiAvIHNpemVvZihsb25nKV07DQo+ICsJc2l6ZV90IGksIGxvbmdzOw0KPiArDQo+
ICsJaWYgKGNjX3ZlbmRvciA9PSBDQ19WRU5ET1JfTk9ORSkNCj4gKwkJcmV0dXJuOw0KPiArDQo+
ICsJLyoNCj4gKwkgKiBTaW5jZSB0aGUgQ29DbyB0aHJlYXQgbW9kZWwgaW5jbHVkZXMgdGhlIGhv
c3QsIHRoZSBvbmx5IHJlbGlhYmxlDQo+ICsJICogc291cmNlIG9mIGVudHJvcHkgdGhhdCBjYW4g
YmUgbmVpdGhlciBvYnNlcnZlZCBub3IgbWFuaXB1bGF0ZWQgaXMNCj4gKwkgKiBSRFJBTkQuIFVz
dWFsbHksIFJEUkFORCBmYWlsdXJlIGlzIGNvbnNpZGVyZWQgdG9sZXJhYmxlLCBidXQgc2luY2UN
Cj4gKwkgKiBDb0NvIGd1ZXN0cyBoYXZlIG5vIG90aGVyIHVub2JzZXJ2YWJsZSBzb3VyY2Ugb2Yg
ZW50cm9weSwgaXQncw0KPiArCSAqIGltcG9ydGFudCB0byBhdCBsZWFzdCBlbnN1cmUgdGhlIFJO
RyBnZXRzIHNvbWUgaW5pdGlhbCByYW5kb20gc2VlZHMuDQo+ICsJICovDQo+ICsJZm9yIChpID0g
MDsgaSA8IEFSUkFZX1NJWkUocm5nX3NlZWQpOyBpICs9IGxvbmdzKSB7DQo+ICsJCWxvbmdzID0g
YXJjaF9nZXRfcmFuZG9tX2xvbmdzKCZybmdfc2VlZFtpXSwNCj4gQVJSQVlfU0laRShybmdfc2Vl
ZCkgLSBpKTsNCj4gKw0KPiArCQkvKg0KPiArCQkgKiBBIHplcm8gcmV0dXJuIHZhbHVlIG1lYW5z
IHRoYXQgdGhlIGd1ZXN0IGRvZXNuJ3QgaGF2ZSBSRFJBTkQNCj4gKwkJICogb3IgdGhlIENQVSBp
cyBwaHlzaWNhbGx5IGJyb2tlbiwgYW5kIGluIGJvdGggY2FzZXMgdGhhdA0KPiArCQkgKiBtZWFu
cyBtb3N0IGNyeXB0byBpbnNpZGUgb2YgdGhlIENvQ28gaW5zdGFuY2Ugd2lsbCBiZQ0KPiArCQkg
KiBicm9rZW4sIGRlZmVhdGluZyB0aGUgcHVycG9zZSBvZiBDb0NvIGluIHRoZSBmaXJzdCBwbGFj
ZS4gU28NCj4gKwkJICoganVzdCBwYW5pYyBoZXJlIGJlY2F1c2UgaXQncyBhYnNvbHV0ZWx5IHVu
c2FmZSB0byBjb250aW51ZQ0KPiArCQkgKiBleGVjdXRpbmcuDQo+ICsJCSAqLw0KPiArCQlpZiAo
bG9uZ3MgPT0gMCkNCj4gKwkJCXBhbmljKCJSRFJBTkQgaXMgZGVmZWN0aXZlLiIpOw0KPiArCX0N
Cj4gKwlhZGRfZGV2aWNlX3JhbmRvbW5lc3Mocm5nX3NlZWQsIHNpemVvZihybmdfc2VlZCkpOw0K
PiArCW1lbXplcm9fZXhwbGljaXQocm5nX3NlZWQsIHNpemVvZihybmdfc2VlZCkpOw0KPiArfQ0K
PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vY29jby5oIGIvYXJjaC94ODYvaW5j
bHVkZS9hc20vY29jby5oDQo+IGluZGV4IDc2YzMxMGIxOWIxMS4uZTlkMDU5NDQ5ODg1IDEwMDY0
NA0KPiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9jb2NvLmgNCj4gKysrIGIvYXJjaC94ODYv
aW5jbHVkZS9hc20vY29jby5oDQo+IEBAIC0xNSw2ICsxNSw3IEBAIGV4dGVybiBlbnVtIGNjX3Zl
bmRvciBjY192ZW5kb3I7DQo+ICB2b2lkIGNjX3NldF9tYXNrKHU2NCBtYXNrKTsNCj4gIHU2NCBj
Y19ta2VuYyh1NjQgdmFsKTsNCj4gIHU2NCBjY19ta2RlYyh1NjQgdmFsKTsNCj4gK3ZvaWQgY2Nf
cmFuZG9tX2luaXQodm9pZCk7DQo+ICAjZWxzZQ0KPiAgI2RlZmluZSBjY192ZW5kb3IgKENDX1ZF
TkRPUl9OT05FKQ0KPiANCj4gQEAgLTI3LDYgKzI4LDcgQEAgc3RhdGljIGlubGluZSB1NjQgY2Nf
bWtkZWModTY0IHZhbCkNCj4gIHsNCj4gIAlyZXR1cm4gdmFsOw0KPiAgfQ0KPiArc3RhdGljIGlu
bGluZSB2b2lkIGNjX3JhbmRvbV9pbml0KHZvaWQpIHsgfQ0KPiAgI2VuZGlmDQo+IA0KPiAgI2Vu
ZGlmIC8qIF9BU01fWDg2X0NPQ09fSCAqLw0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVs
L3NldHVwLmMgYi9hcmNoL3g4Ni9rZXJuZWwvc2V0dXAuYw0KPiBpbmRleCA4NDIwMTA3MWRmYWMu
LjMwYTY1M2NmYzdkMiAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva2VybmVsL3NldHVwLmMNCj4g
KysrIGIvYXJjaC94ODYva2VybmVsL3NldHVwLmMNCj4gQEAgLTM2LDYgKzM2LDcgQEANCj4gICNp
bmNsdWRlIDxhc20vYmlvc19lYmRhLmg+DQo+ICAjaW5jbHVkZSA8YXNtL2J1Z3MuaD4NCj4gICNp
bmNsdWRlIDxhc20vY2FjaGVpbmZvLmg+DQo+ICsjaW5jbHVkZSA8YXNtL2NvY28uaD4NCj4gICNp
bmNsdWRlIDxhc20vY3B1Lmg+DQo+ICAjaW5jbHVkZSA8YXNtL2VmaS5oPg0KPiAgI2luY2x1ZGUg
PGFzbS9nYXJ0Lmg+DQo+IEBAIC05OTQsNiArOTk1LDcgQEAgdm9pZCBfX2luaXQgc2V0dXBfYXJj
aChjaGFyICoqY21kbGluZV9wKQ0KPiAgCSAqIG1lbW9yeSBzaXplLg0KPiAgCSAqLw0KPiAgCW1l
bV9lbmNyeXB0X3NldHVwX2FyY2goKTsNCj4gKwljY19yYW5kb21faW5pdCgpOw0KPiANCj4gIAll
ZmlfZmFrZV9tZW1tYXAoKTsNCj4gIAllZmlfZmluZF9taXJyb3IoKTsNCj4gLS0NCj4gMi40My4w
DQo+IA0KDQo=


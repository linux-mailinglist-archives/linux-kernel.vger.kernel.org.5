Return-Path: <linux-kernel+bounces-123418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DE6890864
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8162B23EE9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07D7137746;
	Thu, 28 Mar 2024 18:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZqIe8eeV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A535612FB3B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 18:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711650763; cv=fail; b=qR5QNSYA/YQoyGW3BKldO/2zZ09XRtKJEPMe0IGR5v4bi80X35Z/GZ34krfcHeQytHHMpLleKk97QZS98EkHGl2J3pTcBwZV5zNllYWnyz8yNUY6i5Ur+r7wBAymNYicp0IBUMc/+NlrwJ97TKCiAp+av+jG8cSgzU0Y1AiTMYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711650763; c=relaxed/simple;
	bh=jFH/ars57/1YZlDAwfSrH52Nv3SD7ZuN4oDCP218Na0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VCW/brQ0Ju16e+rUWM5x+2Ve2OJgi3r22NkYRs+017NzU9YwLEPrCORIrpm1PCgqpVM9d9Bjfr5lIEYUYnhGQQMENxUTgZtwTS30qwP6qsDcsLUtjMa21NSRcM1eEJk8qsvRjjLq2ckUTR/atTPvnYlMiZofrMURKDfkEKqQ6N8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZqIe8eeV; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711650762; x=1743186762;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jFH/ars57/1YZlDAwfSrH52Nv3SD7ZuN4oDCP218Na0=;
  b=ZqIe8eeVIf1AqY+dP6k7hHSe/rq9HjNK/yD9T7vPmHTXwdDHkIRozTA9
   U96JyARkv9a71CJ5dyKfuar3H8iwBNgo2fCzZ5U8UQt05TDcLpKFTm1rm
   yibuZnma2grsAqca3CGIe3YdlkOhu8sXAtz4X2vTTmzOZM6Y/zpABvaUF
   40ZI/3pfPYnTBVT9yyCgoxDwjvLXabynSVOdXpgGxqmzmR8ViZeOHStxR
   VcJuF2ZBeNXXM9ktqLX3KO64A8WtXEx099O3cfMd+c+UYGecTopOggHi4
   EYFRx9/MhC8aQT4/ICXbhPWge+gDb0hqnQpKnDIC7dKdUaZmu2e3WgQB+
   g==;
X-CSE-ConnectionGUID: BPsvf0+ZR8i7fLzXROwQ2Q==
X-CSE-MsgGUID: nGKEywVWQDiOat0CMqi3XA==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6687558"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="6687558"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 11:32:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="21467284"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Mar 2024 11:32:41 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 11:32:40 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 11:32:38 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Mar 2024 11:32:38 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 11:32:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QmVL+rcuNJTTWb+cUF6xOBzXJ0iskHXP5xwaP28J/IRxjf66azN5slSLWDW7SJcLRQI599SYCulY9M9QuEf+CKlKVDo48gOGXv4Sma62U+Uybuu2FrX2dXv1Ha2YbNc8sQ9d/xOxoklHOmokytQ9d8UcgW/mxRdqIXZeF5Xg8pW9x/bpiLCsYLIA4S+0PeoOpJcg+flz1NJLw4vjn7PncDn+j2D7CU6pi/V7L52zfLEwhftshbZ44vfSL1VsM1bS4mJZG79BCSywR8rUhCVngGG0T7Haf1e7xPkXCcrYCWZ2OoHqeL4SgIBwC421+t+43/UAlqj0tTrn0sVeI7OMyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFH/ars57/1YZlDAwfSrH52Nv3SD7ZuN4oDCP218Na0=;
 b=XejDtQrBdhJaaG226SFVbeNpMt5hpz2CLffWW3hZfHsiXjCEG6LGHfvb7rgyaP7pPyEgTaL6CHdSJTRM31xgBTxEIKe/D0QSjTa2NEhNW5jlwx2atLp4aJ5RYofbQPuHtLFDlRv15sue3cIQryxBCFAWZbJ2BWzA/krvrTqPf6UT+kePY9/ZaU0NRO5ZmPEDNA1L6fva5VlPZZZWHq2leM15YKqOAsdcNqW3j35HzBOMc6X6yjBS+sJfOjIfxQcZ+zJwIYTll3FYx56rdm9TNxunNqNgz54H8EuwG5TDV46AQYTB44GECazENdJ5i9wZ22jlPfWTy82CzzOwjHhnQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CH3PR11MB8436.namprd11.prod.outlook.com (2603:10b6:610:173::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 18:32:36 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 18:32:35 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 01/74] x86/cpu/vfm: Add/initialize x86_vfm field to struct
 cpuinfo_x86
Thread-Topic: [PATCH 01/74] x86/cpu/vfm: Add/initialize x86_vfm field to
 struct cpuinfo_x86
Thread-Index: AQHagS5KoaFl1e6FLU2YPMaZiCLmO7FNXROAgAABToCAAAEjsIAABDsAgAASPNA=
Date: Thu, 28 Mar 2024 18:32:35 +0000
Message-ID: <SJ1PR11MB6083D8BB65748452B204ED8AFC3B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240328163746.243023-1-tony.luck@intel.com>
 <20240328163746.243023-2-tony.luck@intel.com>
 <20240328164811.GDZgWfSzAWZXO7dUky@fat_crate.local>
 <20240328165251.GEZgWgY1Clb9z4t3VX@fat_crate.local>
 <SJ1PR11MB6083AADC97E50462C1137D71FC3B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240328171204.GGZgWk5JNOzQzoaEql@fat_crate.local>
In-Reply-To: <20240328171204.GGZgWk5JNOzQzoaEql@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CH3PR11MB8436:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bm+GcwNFY/oJBArZXRUIWIty8wtpL7OsBHOMCir0udPcBAcUvHe2ZpTrsCwQ4OvRRL9332LI8vfMX4clv/CLBmKhRscL6lIa/S5klf+thx8An7WzwKnMKUys9AHNFpDoQS9BfFwbBhKwgneKl3me3K/+psrjfECg/22184K3CAvKL90htIFP9CSgs70HYjker4TqCQweaEdB9zcUcPVljITfa7uNME7osKxnjNnXfQNzDwKvUd+22d0R2Nh4wa7QJBZ6+IVNxuEjoQl6xAG8G8cvKQCTwn6e9oJtr6No1prLGDCBChqaGR1PxE9uiMbXycjRSj1zfEUZLoG6W1HrgZPsfh90Yb/BIxqqHTtQUSCFwj0YfUpRaBa/DkfITvWtTaAQwy3n8i6oS0O7teyNbD51ZHFZIZHliQvc0KrQpRyFNngbQItyBjHgGe40gVHqMFkTfMmaONXRZwUFfivyHgjKK4DRcvbxnKKd3LBIytQhtURqrUBsxDK2Wm3Ra5SUpFsxZDfpYwC9r8b1/VdTPCISX9Zcxiy7GMdAfV4c3qSyFluIPd6Ir2twPXhAvPTlCDiY8o+hajp90I3mKw9fxbY2ihS57uiDXiPAO3CAnU6jg4VCxxOBr9xYldK7URzupOhvppWaFOoq1chjXv8GZiiGKYIjbZFF13JZNys7rtY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUx5V2ZNQzJIZVRJR2N5T0tpd1R6MnFjaXN5OW1kR3plZVZXV1dDNzJ0aUVm?=
 =?utf-8?B?RFpFYjdsdXJJMGRnKy9vZFE1dGFnaG8vSWRBMWpDcEVxOGVERklrUTZpQjNS?=
 =?utf-8?B?YW5TUi90SFVmN0RqRDF3bnhCcFFDVEtTTXBMUFIwYzdwQ0FvV1NSQVo5Tysv?=
 =?utf-8?B?dWFjQ1NqMEk2am1zTXBRdzh6d1krc3lFRk9QaS8zQUdTWUk4VkdKMDlhK05M?=
 =?utf-8?B?KzRLVzJVenBXZDZ1QUc0UElkTlluOW5YZlVkQ0pKOW1KNmF4SHJFVGZseGww?=
 =?utf-8?B?aVZNTWEvU081aFlXcEpZeDl3eHRGcmpjSGNEUHRRK3NrYU50U0tFNVBpMkc2?=
 =?utf-8?B?VlZzeW9zaWpiY2gxMjlkODhhTDlhK1h0K2lqMmVRM0d6MTZhSVcxc3N5VjVI?=
 =?utf-8?B?aXRRZVZiMTdHSnpkMitta2hRS2s3bnZkbmZ3c05Hak95NjBDUHdHV1ZZSzcz?=
 =?utf-8?B?VFk5dkZldk9wb0x3bDBWQW5hcnlSWEw5TTNBb29mKzZvK1FVUHhWSlhINm85?=
 =?utf-8?B?eEFZMzlhRWFSYS9uNDV4bUdZbktuM2Z6Q0V5aDdQamw0cGNHQUhPaUhqK3hs?=
 =?utf-8?B?NUZlMlhhVW9xdWFxejd6WkdNWE5SZVZ0WTh1elBsSDlJcVZMWlZKci9TM21P?=
 =?utf-8?B?N2FSYWFWV2R2UERzSFdVK2hZSGVLSllsSUptUlBOdHNuaFdnKzBoQkRGL3pR?=
 =?utf-8?B?aXNLRlVMTjhHdS9jZXQ0KzVsOVU3UlhKS3ozU01HdkRHbDRNTmZOYlJGcUZN?=
 =?utf-8?B?NXNmTVovZzBzTEFIUm1wZm9ZRk9QYTJGdFVPaU5IYWpzSzBjbkx5bGovRWt6?=
 =?utf-8?B?bSsvZFROSGlOaGZVbXMyWW11UWFSVVFBZlVQbHRFS3FmWEptWU5Rb1ZsQ0NE?=
 =?utf-8?B?K3hmdllFSzRidm11T2tBRTc0OXRhaFNFU3lTZi9zWEtUZVhydVgzWlMyZldL?=
 =?utf-8?B?QjNVT2R5SUw5VkVBSGFGaVF4c29kT3hhQnNWRXB6OVh2WDBuNThjN2FVTHV3?=
 =?utf-8?B?K2IwYUh0cy8zekJkMTlLYnBFSm1hZ0g5aU5DVW9wRlVXVzdnWHUxS0toQjJG?=
 =?utf-8?B?NVRuazlmMlVoTHAvUXppUlRJTDVqQ094SkJaTUZtZ0xMYjUyTytWd3lLV3o5?=
 =?utf-8?B?RmlGOEVsSEFqOFZma3RjQmpnVllsb2YrS25aWEVnMEY0YzRxVGhoZ05HMVpB?=
 =?utf-8?B?MXhZRVM5cXhYWExqZVJHbnFWY1hqK2FTeXZzY3AzTUFCSUJFKzlyRzN3ajZ0?=
 =?utf-8?B?M3FqOHVweXlOd3k3bXlEZXFPMGRBdXBPVUkybXoxNHY3S0dseC96QzhKNnd5?=
 =?utf-8?B?YjFhOGQ1ZVgxUVFJMFpwTTBpUG5UUmlXUUJBRXgxd1BLV2Zna01HV05KSGVN?=
 =?utf-8?B?ZEhDRFRwaDNjOGlZMXZhcEVkWVJzTkgwZXdnY25Cb0Q5L3luYnMwU2NVOG02?=
 =?utf-8?B?c1FjR0srZXZnMWJEOVVIQjJiN2VaelAycEVlSXNTUXBUUG9Pc3UyTkxJRms1?=
 =?utf-8?B?ckNTYXFIWGE5bDYrMVZDZDY2Z3FKTnZYc1UzS20wdDBva1BQS3ZsdlViN2ZV?=
 =?utf-8?B?SnFxcmVZNzFxemp6SHhNd0tyaE5CS2hWcFhRWFpJOE51UmpKN3Y4d0M2ekhI?=
 =?utf-8?B?dnhXZWhxeXpoQUt3Zy9jTzN5OGRFMkRBQU9wemFTdmlDTGZZTlZEYndWcDdn?=
 =?utf-8?B?Y1lvekNKTVlIZmhOMEJ4NHU4eVRxcnA5NnFPendVZVVYWUlFTDlMOU5MT3Fk?=
 =?utf-8?B?ajlZQkQ2clRGRjdocUVPWHBpaS8rOWhLeUtuUkpRMWlqQ1NxNUdkTFVpQUE2?=
 =?utf-8?B?bEJsM0tMZElIcncyY2RIem5hMGpWbngrVmdidFQ0VllVL0tXcHFhMG52bHRr?=
 =?utf-8?B?YjZoRGU4TC9qV2lVcnl5cWduMWFZcVlrdnhNWm1FMkxxNmt3R1NUWmRFWmIw?=
 =?utf-8?B?V2h5ZkthT2Vqb0t1MDIxMlZuRFdzTGFiRkZ0cm1rcDlxb2o3OC9PYmswWE41?=
 =?utf-8?B?TlRyUnpUY01yQVkvMyt4dXJYTGFYQ3dBdXloczZrSWsvd2gzQS92Tjhpd01y?=
 =?utf-8?B?cDhuaUNSRXh2VkZXcTZPQUdWNWJWbDZ5bUJXbjZYZzVqWUlEWGxrVFZ1Qy9W?=
 =?utf-8?Q?qyfDCQJ0Znz6W5Q8b6Xv6Zn6L?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f66729-36db-422f-7465-08dc4f557096
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 18:32:35.8223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hAdI3OHRfyD5gpofuZO/M/HiXZ1+cJS0fHaJ7++ltEbBwNHD68TcLAwqueepvTgoQjhmD9ppQkQJAXkxEOIPlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8436
X-OriginatorOrg: intel.com

PiBBbmQgZnJhbmtseSwgdGhlIHg4NiB2ZW5kb3IgaXMgYSBMaW51eCB0aGluZyBzbyBJIHdvdWxk
bid0IG1pbmQgaWYNCj4gY2hlY2tzIGFyZQ0KPg0KPglpZiAoYy0+eDg2X3ZlbmRvciAgPT0gWDg2
X1ZFTkRPUi4uLiAmJg0KPgkgICAgYy0+Y3B1aWRfMV9lYXggPT0gTUFDUk9fQlVJTERfQ1BVSURf
MV9FQVgoZmFtLCBtb2RlbCwgc3RlcHBpbmcpKQ0KDQpUaGF0IGh1cnRzIG15IGV5ZXMgY29tcGFy
ZWQgdG86DQoNCglpZiAoYy0+eDg2X3ZmbSA9PSBJTlRFTF9ET1VHTEFTQ09WRSkNCg0KPg0KPiBB
bnl3YXksIHVzaW5nIENQVUlEKDEpLkVBWCBpcyBqdXN0IGEgc3VnZ2VzdGlvbiBzbyB0aGF0IHdl
IGRvbid0IGhhdmUgdG8NCj4gaW52ZW50IG91ciBvd24gZm9ybWF0IGFuZCBjb252ZXJ0IHRvIGFu
ZCBmcm8uDQoNCkFsbCB0aGUgY29udmVyc2lvbiBpcyBhdCBjb21waWxlIHRpbWUgdG8gZ2VuZXJh
dGUgdGhlIHZhbHVlcyBmb3IgdGhlIENQVSBtb2RlbA0KbmFtZSAjZGVmaW5lcy4NCg0KPiBBbmQg
dGhhdCB3b3VsZCBiZSBhZHZhbnRhZ2VvdXMgd2hlbiB3ZSBjb252ZXJ0IHRvIGRlYWxpbmcgd2l0
aA0KPiBDUFVJRCgxKS5FQVggdmFsdWVzIGV2ZXJ5d2hlcmUgYW5kIHdlIGNvbXBhcmUgdGhlbSBz
dHJhaWdodGF3YXkuIFdlJ2QNCj4gbmVlZCBtYWNyb3Mgb25seSB3aGVuIHdlIG5lZWQgb25seSBz
b21lIGRhdGEgZWxlbWVudHMgZnJvbSB0aGF0IGxlYWYuDQoNCkl0J3MgYSBodW11bmdvdXMgYW1v
dW50IG1vcmUgY29kZSBjaHVybi4gTW9zdCBvZiB0aGUgY2hhbmdlcyBpbiB0aGlzIHNldCB3ZXJl
DQphY2hpZXZlZCB3aXRoIHNvbWUgc2ltcGxlIHNlZCBzY3JpcHRzIChmb2xsb3dlZCBieSBoYW5k
IG1hc3NhZ2UgdG8gYWRqdXN0IFRBQnMNCnRvIG1ha2UgdGhpbmdzIHByZXR0eSBiZWNhdXNlIGxl
bmd0aHMgb2Ygc3RyaW5ncyBhcmUgZGlmZmVyZW50KS4NCg0KVGFrZSBhIGxvb2sgYXQgYSBmZXcg
b2YgdGhlIHBhdGNoZXMgdGhhdCBpbXBsZW1lbnQgdGhpcyBjaGFuZ2UgYW5kIGNvbnNpZGVyDQpo
b3cgdGhleSB3b3VsZCBsb29rIGJhc2VkIG9uIGEgQ1BVSUQoMSkuRUFYIHZhbHVlLg0KDQo+IEFu
ZCBzaW5jZSB0aGF0IGxlYWYncyBsYXlvdXQgaXMgY29tbW9ubHkga25vd24sIHRoZSBjb252ZXJz
aW9uIGVycm9ycw0KPiBzaG91bGQgYmUgYXQgYSBtaW5pbXVtLi4uDQo+DQo+IEknZCBzYXkuDQoN
CkkgZG9uJ3QgdGhpbmsgdGhlIGZvcm1hdCBpcyByZWFsbHkgdGhhdCBiaWcgYW4gaXNzdWUuIElu
Y2x1ZGluZyBzdGVwcGluZyBpbiB0aGUNCmZvcm1hdCBhZGRzIGNvbXBsZXhpdHkgdG8gYSB0aG91
c2FuZCBwbGFjZXMgdGhlc2UgY2hlY2tzIGFyZSBtYWRlIHdoaWxlDQpvbmx5IGJlaW5nIHVzZWZ1
bCBpbiBhIGZldyBkb3plbi4NCg0KLVRvbnkNCg==


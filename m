Return-Path: <linux-kernel+bounces-60154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A038500D9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 00:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FFF31F2646D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F3E39854;
	Fri,  9 Feb 2024 23:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="khbFX8MU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D683987C;
	Fri,  9 Feb 2024 23:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707522266; cv=fail; b=dsKZYgLcwUROjo9LMHod5XMMh4M7A7A9rn0dGaFtWSU4XYHhoqc4kYDNxezfRyFEgmokneLyq0Z5/0q+xn175AlGGvTRi5Esql33pj07S10GKwebium6ZiYmH/39guXgO3hQjX7nGZwE3rPCOcLnOEfqJDnBHtsgBfOd2LADnVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707522266; c=relaxed/simple;
	bh=WByhCArW4JiYiBTtLE9pFATWujp50ZmWUQXgC7OnFaw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g0I4CFt0dGezDkOcN6ZWybGRfnB9yrChYVMDaRV3QQTeaSYQnf9X934nUqdlqkatHmwEA/smdON0pH4uYO+63CzN8RCYEqdbKyUYGh4Kr6YHgYNltzFtNcN6gOdO/J7N1UtTnoI+svO1dXF2mA55yHNhPhe7REzEhJG+jpvbc+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=khbFX8MU; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707522264; x=1739058264;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WByhCArW4JiYiBTtLE9pFATWujp50ZmWUQXgC7OnFaw=;
  b=khbFX8MU1V/6+F76dBug0pGr8UNXnayAZrTR5gT5QfPq3dUTBaIZX8Se
   AzUPsUeBQ4A+XvZV6XRBe7jX0Wga0ri6dZnAO3HsvbC5IJZ7P8sbCxaLw
   G3z15CAIHdcopYU+9fgEeZ0aA54kZOMl6vHg8FHf27eTWNL+/xG1SHaaf
   b3HZQnT+SRQ7zG+Y8dt45W1KlYJfI96bYcPbNOLT56FiLRVrKSZX895Ad
   x8nN+Cf4R+23L+zjgUGvV+Kg9XNStMRlApkYGBvjL34goMt6mpAWwv5Sh
   NgnTc4/cKwBzFssuuhD6YcmnLBPK1EclAq2HDTSH2MjUysVG6zRSrhGJC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="19027008"
X-IronPort-AV: E=Sophos;i="6.05,258,1701158400"; 
   d="scan'208";a="19027008"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 15:44:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,258,1701158400"; 
   d="scan'208";a="2412078"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Feb 2024 15:44:24 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 15:44:22 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 15:44:22 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Feb 2024 15:44:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTgBwOKtCwoh2JayILKhtHCEfTFVMS+r8oHJtoC9pWSMwDAbffgFLYMfjNbBwePBrie6EBQQQzoiCK5ThB3A/g/2a40U4tenwUpZ0qt0KM2gaJNWmFqb/GrWltGLo4SJ8hpT42seKoAJ/UJ+8CMp6hiX8yQsW1T/cpp/pszJhexkzXg3FXaD0yUMMNibLMSUPDrVtGCFjN/0SrTfwTM0py8OOGwAb02fwYBD3/7L/eX0CdYEJ9Cjd62jiqxeIS3LgOOnDPgyNeLocZAPMHlRNxvRqwZcwI/1aVc0V2V5a73EEiK4WmSZ1i/OcNXaVEB7AStzXpBEfeJwH7pqRskzHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WByhCArW4JiYiBTtLE9pFATWujp50ZmWUQXgC7OnFaw=;
 b=BdsPKaP6JRmXomZ87JwecAHCLplY5SBpw5TESk0cgJwcwpaaG2NWEZUXzjZRoyz4yBS+lf8Duy1sOXcYA+rUO4WI89a9BxdCglJptzvoBDNV9UWCGSkRIQp1V3pkMq+6VGBBH5QlmcktSoXrU1zD9x2A5xYDWKW9BfDAZ6LO4hMCUtc42iwcVgXfozXE/AQv4sONm3YxLlNXSMD+y4pEjtlewLjb68MZt+UEim2UrbBFkLYcpw5UytCVqXyQpmlRPEoN5qMiAOwS3ZKZDKdfRVxSiqCKiu0RQ9+S2ZaS22d6qB5skp32wWzCrGF+IW3TJdc7dM1jsj1bi18vV8xJGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ0PR11MB6720.namprd11.prod.outlook.com (2603:10b6:a03:479::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Fri, 9 Feb
 2024 23:44:20 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7103:9cf7:fcc0:e802]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7103:9cf7:fcc0:e802%3]) with mapi id 15.20.7249.035; Fri, 9 Feb 2024
 23:44:19 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Chatre, Reinette" <reinette.chatre@intel.com>, "babu.moger@amd.com"
	<babu.moger@amd.com>
CC: "Yu, Fenghua" <fenghua.yu@intel.com>, Peter Newman
	<peternewman@google.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, "x86@kernel.org" <x86@kernel.org>, Shaopeng Tan
	<tan.shaopeng@fujitsu.com>, James Morse <james.morse@arm.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Randy Dunlap <rdunlap@infradead.org>, Drew Fustini
	<dfustini@baylibre.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
Subject: RE: [PATCH v15-RFC 0/8] Add support for Sub-NUMA cluster (SNC)
 systems
Thread-Topic: [PATCH v15-RFC 0/8] Add support for Sub-NUMA cluster (SNC)
 systems
Thread-Index: AQHaU8qTZyE779HfV0Os6ryGu61IgLECMYcAgABGHaKAAB4egIAAAUhggAAMp4CAABNrkA==
Date: Fri, 9 Feb 2024 23:44:19 +0000
Message-ID: <SJ1PR11MB60834D4876A8147286FB2284FC4B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240126223837.21835-1-tony.luck@intel.com>
 <20240130222034.37181-1-tony.luck@intel.com>
 <91bd281e-e21f-4b60-9e73-2f14fcbec316@amd.com>
 <ZcZvguSNel-z3Xe5@agluck-desk3>
 <f4d4ff97-7d40-4915-943a-a7371e24dae5@amd.com>
 <65e1d936-0e1d-4d6c-81de-0b2b1d3256fd@intel.com>
 <SJ1PR11MB6083D539920A888F93902954FC4B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <59944211-d34a-4ba3-a1de-095822c0b3f0@intel.com>
In-Reply-To: <59944211-d34a-4ba3-a1de-095822c0b3f0@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ0PR11MB6720:EE_
x-ms-office365-filtering-correlation-id: ba4769ec-e3c9-4815-dd3a-08dc29c908e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y0O8D+HPorteG+hM5cmnCATP6bBRMe9YBy8mcebo0BBUVebnEF1aFj7ITw51opHVMtAuo6TfsYZLjFQzwjK3llWBaOqvSM0P9Ja0evbZvxDtvH+qpryjltJDvughBtOP36tGvtfm5TtgGIEjvSCbCCzCdbR2LcC+R5zRziD7M4Un2ONxpEbgVk+knYMONl1jtHn4nlbkcdOsFO4/qPZrLvOOoET2imjHXo5szM0vBV0GtOhVLKiyI1tHwZC1kanxw3T0mvFKJerfLXH+exqRmRXyi2E2YD/s1jSS0fi2+ATFNuZx49qyiyOzTlI/c2WVSuKukcLGIU+r02VROBhPGoKVD9s6ZWRScW0NA0TeLZhLT1ww1f/qB9MSBGKxcLwnesUu7xfBoIlbexwXr8N1r6mp1OPvt08rQ6cHi1UIxwBACRPcUCP/1ycisk66p4aed84IOLXm3TpJkGkgvF+6DRT6HqQPLIsNhOsio0SzMbzRFk7isfrbBnmCPPbgWaZUkuUCdrIQWhTGBnvyYe2DdU94BaB9dXIlJ2TSirW05WGxTdw4Y9CZh4D6H5kzrdPYf+UtjCM6uHfqTasrB1MfwyUhTKF0pK0KWZBvXBcu9kxO4PYKtwHXbyObvrKZE0Da
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(136003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(2906002)(52536014)(7416002)(5660300002)(55016003)(41300700001)(38100700002)(33656002)(38070700009)(82960400001)(26005)(122000001)(86362001)(66476007)(64756008)(71200400001)(110136005)(54906003)(478600001)(7696005)(8676002)(6506007)(76116006)(66946007)(66556008)(9686003)(8936002)(66446008)(4326008)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3dscThla1lHclE5TWhNcFkwajdRcnl6Tm9qd3U2ZVBicXN0UW5TK2ZzMXZ5?=
 =?utf-8?B?RUNiUG0zcG1rVCtjUU01OTBKNkNQbjBVaVNJU3hYZnJEb25qMTZmYWpqNFI5?=
 =?utf-8?B?b0FjVGw2dEpZanhMVkROK0lmekpUYW9BQ3l1OUM5MG1jOXUrRjNaK0hEc2Rq?=
 =?utf-8?B?anRrbWdzVkcxU0Z6Z1JWSE5MVnByQzM2VzY4ZzM5S2x0eGFnWFZxeXRXM0FB?=
 =?utf-8?B?STZ1OVMyZHJGUkZFMmFvbm11bUl1S3pOU3cvTll2SEgycElNQlVYSVdna1Fl?=
 =?utf-8?B?aEI2SG42UmJxcDdkZklOL3pSNjVJZFVMcEM0ZE1zUnFjUk92dmUwQ092RHUv?=
 =?utf-8?B?cFMvemVmODdNRUI2OVpTUnFxRmJUdzFkVi9lUGRFZGtjVXdHK2hXcEoxbXVG?=
 =?utf-8?B?aWpPWDA1UVcycHdxZEhTSm9aLzM1cUNHTmo0TzFxeGJJZnlQMGsvTkRZdHV6?=
 =?utf-8?B?WXU1SDJqSlM0YlF4R0EvejNaalFlcGtjS1hIUit4V1pmUk9wNCtDZldhK0U1?=
 =?utf-8?B?bjN5OW9xR1FJbXZXc2JyTUFYcWpaaFoxOVI3eU95eEtwbWRTSnBNVlZuQ3lF?=
 =?utf-8?B?UFpISEhaakhkdFJyY29SbUowUmZvZHVtcHMralhwa3phcGxnRm8ySTV2ZkpZ?=
 =?utf-8?B?UmkxQkxsQTZsS29BTzA4SzFFVHUzR1dreUcrUUpCM0ZwekgwNXQ0Skxxcldk?=
 =?utf-8?B?Y2oxWGZWOHU0bWphL1RLc3VYYlNac0hEcnVwOWs3T1AzM3NZQnVqZFIxYkkw?=
 =?utf-8?B?S3Vmd09zNy9FanV2cWFDdU15c01tNkJKZ2hzcDhJSjRsNGN0QjRMWGltSGVj?=
 =?utf-8?B?ajFtQXZ6Q2dFZkNlMzlSZjFUQmpBRTlWTnNwaVg1MlA5UzNNSmlYYlFtM1NH?=
 =?utf-8?B?Q0FReWJoTmlyTnhIcjVhYUgxa0d4YWtuYU1UY0N6VkJIeExQU1ZuWGMrd0s3?=
 =?utf-8?B?YzdnRXk4czNRTzluS1NwZXNPZVEvNXFna2Ixb05jSE5CUTljdG5FVkQ3R1lM?=
 =?utf-8?B?bGNPQjRDeTdDTjdGSW9kZ055TFlFbThFRnBua0pKaUtxMHg5WHpIdEIzRFJK?=
 =?utf-8?B?YWpXR05vTkhtMnEzUE96cS8vMDM2OWpGTFduK0xzMG0rcDNUb2gzaUVCSnVa?=
 =?utf-8?B?UFZkMU1XdDhHVFBoYksrd094VTBRSGsyQXNXcEdoSnc4RVRHMzJsTm9sL0V4?=
 =?utf-8?B?UmthTHdubWwzWjVmRXhTLzhSNXJHc1d2YStFbDZ0K0dncjd1T3ZaQ0lTRitH?=
 =?utf-8?B?MWE1K2c4UzVVdDNoWGFRd2lmejZ0bXpBUjk2cHZKY2xuMjJBeGxpaFRsNUxs?=
 =?utf-8?B?L1dLWGNvMGVSVjIzekFDUDM0cVVHUWtuZERyTHcvTk9maUZHaEF1WWFVOHE2?=
 =?utf-8?B?L1lwZlRTTEVub29pamNUdUdsRVlPV3BkVVZrNGc2MTlKdGxldVhac2VvZjRY?=
 =?utf-8?B?ZEF1UHdWeTFjNFRGTlJULzVDNjJQR0hNRnpOMlNuYTNjMmNaM3JoblFRRzUx?=
 =?utf-8?B?bnBEaVhKNFFZQVppdUJOaXMwYUlBNVgvdjBvc3hTNkoyUTVGMU9nN1NtUE1W?=
 =?utf-8?B?b1VhYmdkU2djcWZFeVBJM2lSdklHTHl2NkJLaEZWdTNERnhyRHpydlk2cUtB?=
 =?utf-8?B?eWt2eUZKbjN0QlpMbVFzWFFjZlE4bFgyZTN0bkdJVExiRkhtaS9ZV1ZNWXkv?=
 =?utf-8?B?SXZUYnFqenBlTHNmN0NVeHV2ekcvMHFTalplekpMaHhJaVJ4WE44RHRjRDl4?=
 =?utf-8?B?NmlIWGh6dUdZQ203WUlqNHJ4bm5ubGQ1MGE4TnJHMFptT0dSbjJCZkUrUGZi?=
 =?utf-8?B?dG9xNFVXM3hFRGJmUGRqcEdSRmhxUEFGN0h4alRVd25IYmE0c1RUdkFFTGln?=
 =?utf-8?B?YTRmdCs2RDF1bzg3N0s5OG9ySC8rUEdobGJZYzZvWHRyLzFGNUgxSU9pVzM0?=
 =?utf-8?B?bE84MDhESG9vekdKdVdHdGhkblNBQ2wySXRjbGNnTUZUMHJ4dzJReU9PMGNz?=
 =?utf-8?B?S3BVdHJWSjMyNzJINkdiM2NNdmhiYmpQZjhsdFd4YlBOaUpFOEZhN090K0NZ?=
 =?utf-8?B?N2VmcHZyRUsrQU1Fa2tuN1d3YmprRlNxV3hlM1ZDQi9JcFllWXh5MGF6VnN4?=
 =?utf-8?Q?X90+v2Pf3Xcies7r9pcsvgEJL?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4769ec-e3c9-4815-dd3a-08dc29c908e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 23:44:19.4370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RXd0gFn2hzoKx9g7UacISEm8uOiaLlIxARMCsSs9A6VtSNvTee8Q4hrrpmf9avCNtbrwVpq/xbjX+d9rG0xjsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6720
X-OriginatorOrg: intel.com

PiBJIGFjdHVhbGx5IGhhZCBzcGVjaWZpYyBwb2ludHMgdGhhdCB0aGlzIHJlc3BvbnNlIGFsc28g
aWdub3Jlcy4NCj4gTGV0IG1lIHJlcGVhdCBhbmQgaGlnaGxpZ2h0IHRoZSBzYW1lIHBvaW50czoN
Cj4NCj4gMSkgWW91IGNsYWltIHRoYXQgdGhpcyBzZXJpZXMgInJlbW92ZXMgdGhlIG5lZWQgZm9y
IHNlcGFyYXRlIGRvbWFpbg0KPiAgICBsaXN0cyIgLi4uIGJ1dCB0aGVuIHRoaXMgc2VyaWVzIGRv
ZXMganVzdCB0aGF0IChjcmVhdGUgYSBzZXBhcmF0ZQ0KPiAgICBkb21haW4gbGlzdCksIGJ1dCBp
biBhbiBvYmZ1c2NhdGVkIHdheSAoZHVwbGljYXRlIHRoZSByZXNvdXJjZSB0bw0KPiAgICBoYXZl
IHRoZSBtb25pdG9yaW5nIGRvbWFpbiBsaXN0IGluIHRoZXJlKS4NCg0KVGhhdCB3YXMgcG9vcmx5
IHdvcmRlZCBvbiBteSBwYXJ0LiBJIHNob3VsZCBoYXZlIHNhaWQgInJlbW92ZXMgdGhlDQpuZWVk
IGZvciBzZXBhcmF0ZSBkb21haW4gbGlzdHMgd2l0aGluIGEgc2luZ2xlIHJkdF9yZXNvdXJjZSIu
DQoNCkFkZGluZyBhbiBleHRyYSBkb21haW4gbGlzdCB0byBhIHJlc291cmNlIG1heSBiZSB0aGUg
c3RhcnQgb2YgYSBzbGlwcGVyeQ0Kc2xvcGUuIFdoYXQgaWYgdGhlcmUgaXMgc29tZSBhZGRpdGlv
bmFsICJMMyItbGlrZSByZXNjdHJsIG9wZXJhdGlvbiB0aGF0DQphY3RzIGF0IHRoZSBzb2NrZXQg
bGV2ZWwgKEludGVsIGhhcyBtYWRlIHByb2R1Y3RzIHdpdGggbXVsdGlwbGUgTDMNCmluc3RhbmNl
cyBwZXIgc29ja2V0IGJlZm9yZSkuIFdvdWxkIHlvdSBiZSBPSyBhZGQgYSB0aGlyZCBkb21haW4N
Cmxpc3QgdG8gZXZlcnkgc3RydWN0IHJkdF9yZXNvdXJjZSB0byBoYW5kbGUgdGhpcz8gT3Igd291
bGQgaXQgYmUgc2ltcGxlcg0KdG8ganVzdCBhZGQgYSBuZXcgcmR0X3Jlc291cmNlIHN0cnVjdHVy
ZSB3aXRoIHNvY2tldCBzY29wZWQgZG9tYWlucz8NCg0KPiAyKSBZb3UgY2xhaW0gdGhpcyBzZXJp
ZXMgInJlZHVjZXMgYW1vdW50IG9mIGNvZGUgY2h1cm4iLCBidXQgdGhpcyBpcw0KPiAgICBiZWNh
dXNlIHRoaXMgc2VyaWVzIGtlZXBzIHVzaW5nIHRoZSBzYW1lIG9yaWdpbmFsIGRhdGEgc3RydWN0
dXJlcw0KPiAgICBmb3Igc2VwYXJhdGUgbW9uaXRvcmluZyBhbmQgY29udHJvbCB1c2FnZXMuIFRo
ZSBwcmV2aW91cyBzZXJpZXMgbWFkZQ0KPiAgICBhbiBlZmZvcnQgdG8gc2VwYXJhdGUgdGhlIHN0
cnVjdHVyZXMgZm9yIHRoZSBkaWZmZXJlbnQgdXNhZ2VzDQo+ICAgIGJ1dCB0aGlzIHNlcmllcyBk
b2VzIG5vdC4gV2hhdCBtYWtlcyBpdCBvayBpbiB0aGlzIHNlcmllcyB0bw0KPiAgICB1c2UgdGhl
IHNhbWUgZGF0YSBzdHJ1Y3R1cmVzIGZvciBkaWZmZXJlbnQgdXNhZ2VzPw0KDQpMZWdhY3kgcmVz
Y3RybCBoYXMgYmVlbiB1c2luZyB0aGUgc2FtZSByZHRfZG9tYWluIHN0cnVjdHVyZSBmb3IgYm90
aA0KdXNhZ2VzIHNpbmNlIHRoZSBkYXduIG9mIHRpbWUuIFNvIGl0IGhhcyBiZWVuIE9LIHVwIHVu
dGlsIG5vdy4NCg0KPiBBZGRpdGlvbmFsbHk6DQo+DQo+IFJlZ2FyZGluZyAiVmFzdCBhbW91bnRz
IG9mIHRoYXQganVzdCBhZGRlZCAiX21vbiIgb3IgIl9jdHJsIiB0byBzdHJ1Y3R1cmUNCj4gb3Ig
dmFyaWFibGUgbmFtZXMuIiAuLi4gdGhhdCBpcyBiZWNhdXNlIHRoZSBzdHJ1Y3R1cmVzIGFyZSBh
Y3R1YWxseSBzcGxpdCwNCj4gbm8/IEl0IGlzIG5vdCBqdXN0IHJlbmFtaW5nIGZvciB1bm5lY2Vz
c2FyeSBjaHVybi4NCg0KUGVyaGFwcyBub3QgInVubmVjZXNzYXJ5IiBjaHVybi4gQnV0IGNlcnRh
aW5seSBhIGxvdCBvZiBjb2RlIGNoYW5nZSBmb3INCndoYXQgSSBwZXJjZWl2ZSBhcyB2ZXJ5IGxp
dHRsZSByZWFsIGdhaW4uIA0KDQo+IFdoYXQgaXMgdGhlIGJlbmVmaXQgb2Yga2VlcGluZyB0aGUg
ZGF0YSBzdHJ1Y3R1cmVzIHRvIGJlIHNoYXJlZA0KPiBiZXR3ZWVuIG1vbml0b3IgYW5kIGNvbnRy
b2wgdXNhZ2VzPw0KDQpCZW5lZml0IGlzIG5vIGNvZGUgY2hhbmdlcy4gQ29zdCBpcyBjb250aW51
aW5nIHRvIHdhc3RlIG1lbW9yeSB3aXRoDQpzdHJ1Y3R1cmVzIHRoYXQgYXJlIHNsaWdodGx5IGJp
Z2dlciB0aGFuIHRoZXkgbmVlZCB0byBiZS4NCg0KPiBJZiB0aGVyZSBpcyBhIGJlbmVmaXQgdG8g
a2VlcGluZyB0aGVzZSBkYXRhIHN0cnVjdHVyZXMsIHdoeSBub3QganVzdA0KPiBhZGRyZXNzIHRo
aXMgYXNwZWN0IGluIHByZXZpb3VzIHNvbHV0aW9uPw0KDQpUaGUgcHJldmlvdXMgc29sdXRpb24g
ZXZvbHZlZCB0byBzcGxpdHRpbmcgdGhlc2Ugc3RydWN0dXJlcy4gQnV0IHRoaXMNCmhhcHBlbmVk
IGluY3JlbWVudGFsbHkgKHJlbWVtYmVyIHRoYXQgYXQgYW4gZWFybHkgc3RhZ2UgdGhlIG1vbml0
b3INCnN0cnVjdHVyZXMgYWxsIGdvdCB0aGUgIl9tb24iIGFkZGl0aW9uIHRvIHRoZWlyIG5hbWVz
LCBidXQgdGhlIGNvbnRyb2wNCnN0cnVjdHVyZXMga2VwdCB0aGUgb3JpZ2luYWwgbmFtZXMpLiBP
bmx5IHdoZW4gSSBnb3QgdG8gdGhlIGVuZCBvZiB0aGlzDQpwcm9jZXNzIGRpZCBJIGxvb2sgYXQg
dGhlIG1hZ25pdHVkZSBvZiB0aGUgY2hhbmdlLg0KDQotVG9ueQ0K


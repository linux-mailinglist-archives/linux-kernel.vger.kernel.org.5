Return-Path: <linux-kernel+bounces-85474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F63086B681
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4421FB260FE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E658415E5AA;
	Wed, 28 Feb 2024 17:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hAAxKMSK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923B615B97D
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709142970; cv=fail; b=Pdx3sXmUUe8RTz6NQbu33i9NWwBqDakyS57CjiKmsjp823kqtgAVpp0pltZ5GX/AWHb+sPxj+a+x+rFkm9bH1nSIUgEj59fv/+H4/ED53IrULdOdbQIFZ5h1yPylf37KMmsGZuUMoI+qW35i3pLRsiakQRMN5Vj29kGOw5G3ZyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709142970; c=relaxed/simple;
	bh=sjw+ZVhkyWApqaOre7hAkyudbWPQe9/kLNNk4IwaIUc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E/xiGWDXOdhB0FZwmPPO+0tM3dbm6d1680DveYHKgTPKDbd58HRsmuFJd80SJvzjC1Rbp6Qe0qfY+DyDJTV12ORgc1Kb0IqbFbU97IOC5jyQdKJCbPUVkaAozdQ24ub62Jry7D+dsRogXdyG10ibURYEPUGOf+4Hsf5MBvgFlDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hAAxKMSK; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709142968; x=1740678968;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sjw+ZVhkyWApqaOre7hAkyudbWPQe9/kLNNk4IwaIUc=;
  b=hAAxKMSKedP/NtLvRurhQOMvumhMm4NeUN4S/rEBXtuJlzQkT7KLqlTy
   xvTeh1twmdS/IUji19ZNgTQOTaXXrMgdt4R8FxJY8qMLffLMDQ5EIcgkB
   Oni/u/PxNVscjUcQ57+GFNAjprP+4M5jngYEQnnjKkvkzMmGq5U35Gzth
   Uz3+f+zmMAnSnw2cms6xSm89xkCboNaxxLKCW1K2zEpj9KsSbtJnznkQJ
   ekubpH90rJNR0xVR2VUo6oV+uUeAu5+Wafd5ImpyibUoOMQ7bJufrWypJ
   wPwecVfWZ4sfHZqVepAG0GeGqYWQkFJ7M6CB3cb2KO+5mue1z3fRhbhKN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3683969"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="3683969"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 09:56:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="7896808"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Feb 2024 09:56:08 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 09:56:07 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 28 Feb 2024 09:56:07 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 28 Feb 2024 09:56:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhGmhgfuy8Un73OBSf0TXiow25bIJYMOSN+iWUcxDbJNtk5pAhOqdhQWdAxJWjbwNtbs7Qh6DpI9Iy0fkMUM8W7YUUjtlv+g9+iDIRavVrSW9RdEiPFkp1y0dLY1ztQ2J6m5PBMdIPVv4hoKkFmiEjtV6pcv4U19QpGkTxE6zoZEVsbQKUu70G2RcXsWFFK1b2BTk32isP5rjQQrGeAgVK1hEarvigBGX7l/3SDLAwTsp8awqTDVjXRNJNypMr+O2mwLgCvqJuQKdFbHmLJ2bGAmVU/STnLn9tqdDJN5yf0ExiuRz/QZqPGLsBsuGAWJyK59jt2rWFHz32bhU2H8oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjw+ZVhkyWApqaOre7hAkyudbWPQe9/kLNNk4IwaIUc=;
 b=XeelihXZC1dNp22WfOBR4L96x9q+kZp+Mim51EIvZfoLXv7oIvCs+cCrtacH8LDBb5qvekrugCQNxJxU/bxsT9iDi4YYpYir0S8xLEfyyvjHMKIvYHsS/HblJHCeNoUGVHeENQmp0YOxmrQ14p2FnyFrB4LiboDlQ/uIdPnnJjqtjP/52f5zJUBsk7avJfDtMuMjvpJLmOxpCDdqDBHy5z1Slfrn4UEm1ssNajcDzhqazUiqMqVCrPgO57cfpPO4qC5tme3OeQzdmzmfB3De9hPxmekzb8brb1NQM7zqtQbr5FjwrWKK7Ez+oY9TZzNJ5+6Bcmv7JUjRvInA1OFb3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB8179.namprd11.prod.outlook.com (2603:10b6:8:18e::22)
 by CH3PR11MB7938.namprd11.prod.outlook.com (2603:10b6:610:12f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Wed, 28 Feb
 2024 17:56:02 +0000
Received: from DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::c563:8fb8:d95:71ac]) by DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::c563:8fb8:d95:71ac%3]) with mapi id 15.20.7339.024; Wed, 28 Feb 2024
 17:56:02 +0000
From: "Souza, Jose" <jose.souza@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Vivi, Rodrigo" <rodrigo.vivi@intel.com>, "quic_mojha@quicinc.com"
	<quic_mojha@quicinc.com>, "Cavitt, Jonathan" <jonathan.cavitt@intel.com>
Subject: Re: [PATCH v2 2/4] devcoredump: Add dev_coredumpm_timeout()
Thread-Topic: [PATCH v2 2/4] devcoredump: Add dev_coredumpm_timeout()
Thread-Index: AQHaamc6S3UimQVv90Kct5lCKqBGwbEf+/WAgAAOAYA=
Date: Wed, 28 Feb 2024 17:56:01 +0000
Message-ID: <a27ac0d3bc52c2181852a25641b7020f50a50648.camel@intel.com>
References: <20240228165709.82089-1-jose.souza@intel.com>
	 <20240228165709.82089-2-jose.souza@intel.com>
	 <84e4f0d70c5552dd7fa350c61c28de9637628ee6.camel@sipsolutions.net>
In-Reply-To: <84e4f0d70c5552dd7fa350c61c28de9637628ee6.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB8179:EE_|CH3PR11MB7938:EE_
x-ms-office365-filtering-correlation-id: 8d30ebd8-ce0d-4382-ad8b-08dc388686ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 80I3y1uJDwGJgXHufYP7sJnVEhs0laNrPi9XRXkAfwsTxZ67GSOogRXz2xEUDU192G4Z4bd7iG5EPpM387TpSjz9SxxNkSLWkKESzk78g7Scc639kqm707NgNMP4LBKQXwdjxbxeGJnG26MAGDkmuqyLlRomPI+KE7OuHWkKdRhf4XY9/wA7MEYY02KlEupahxl9UHU5lOh6DlXr4KiVp01TSpOp3KxODdB3gTyeFDidJplvCNzHvXlRHpffBq+g04iUumX0WTdV8klJVwg3ecpeAe+AQFTPO2cTSL5Oe1Lss0QnjLU+EbgDH6yKDus+c81p+4vHGAFAsxTBzCT4E09NGC7gXldcrwv0+2CcCrBg53oq7X6juqoVXYLfM8r4gcAGG0HJh1OeyhkODsJKyIjitn9lmyKDRZ75wMn3Wpvt/nHtMktRi3gg9sY87f+8RdKjjm1fgpbb85WaboHecHNYttBt/OmaqlOcUUb321qJuLReu/INqAPkBWGPJd8guRfNi4a00KjC9KM7R3awCnP95Ikiz/dh/bGi+8s5EyiM0WgU1lhA8tWgGB1UafwhAaYysiO2oFEsBWQy0eRQGRWs+oxO4ERa2+kCoU+rorS9ZnfBIWtwtcV1tK6WJvNRXCbMV7xnPL4lAbr/UNp8DF6mxawj3E7lpqLrFmkFTkk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB8179.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGNSTlVScTRVREtJSGJkdzNtWXc2WFFGL2R5ZDhsdTM1ZWxwQUNjQ2Rubnlj?=
 =?utf-8?B?OUpaZjh5UUtiN21vNUhYaXkvNzlJUm9pcUkrRytIVG1CZFltWnJuV2ZVSEYr?=
 =?utf-8?B?ZmVrZVUreEpWK1krNjNkSHBOV1ZSc2RINUZxbzFvWXVSMVZ4MFdFaHkvNUFz?=
 =?utf-8?B?R1pmSGdOcjZwWEwyZDZvZnordkt3WmdrNDZCS0lONlpEYVE2ZDhUaVoxWFNV?=
 =?utf-8?B?bVRLOURCeU5sSUpEZzJNaTUrTC9vaENleU9SN0ZnMU5BSEVCWlJ2ZEVESXVN?=
 =?utf-8?B?aUx4T3QxemNCaHYrU1hkVVpGcVNXc2NWMGNleUNpbUlibDNhRmlObUlJYk5p?=
 =?utf-8?B?K2ZqbDNjYWRkM01QYWtNUzkxQjlpdmgzc3NXc3hGY0NackRPd2FtNnp4ekky?=
 =?utf-8?B?NjNvUC9kZG5Sa1VINXJ1WmdnRzVRK2lDMVNQblRvaWVPY0w1K0FmL2tTcGl3?=
 =?utf-8?B?T1J6SWdYZC9zV0x5S2h6aEdsMzNFRjhSMEZPbjFSdktscmc3ejBtT0dGQldj?=
 =?utf-8?B?SjY1RnZvTW4zRHJwK1RGVmtOZ3U0T2ZtdzA2U1B3WXZSSHdQRHc3SHFRL3Bt?=
 =?utf-8?B?dnAvKzQ5a0dxRmVmUGlNLzN3ay9WQ1dDM2xZTjdlcmF0T2hZcWZRR3cvL0dv?=
 =?utf-8?B?NnNVcXNVSm1pK01uVnBuM20zdlRtV0wyZkhiV0RWMmxkaVVoV0xQT2RkQlBj?=
 =?utf-8?B?OUIyVDM2WVplTnYrZFl6T0Ixb25JSmVDYlM4T2d1RHhIbWl2T29zN0NCSi9E?=
 =?utf-8?B?bDMwdFpCSm4vcVVMR1c3Q1BMdEYwczVJbHJNZHhNdjNacVNJZHZ2VkRjLytp?=
 =?utf-8?B?c1lkZjlsQldDRytsbEQzU2JlR1p2QlRXQVRIbUhLZ0lUMG1XU1ZzQXk4dk9p?=
 =?utf-8?B?bHd1K0VJbkwxejZoR1BkV21jdWw4MlpsVjhXbXJuODJ3SWc3WmdMNThkY1lW?=
 =?utf-8?B?eDFCaSszODJ6RkhaY3VqTFVkWGc1SW9BTjZVTkNGWG9sckRSWmxPa0FvWTNN?=
 =?utf-8?B?WU9kSjVYUWk0TFk5WDFUYUhCV2Faa1pZTUFhb01QbzAwZ1c0SEo3MGZSRWM2?=
 =?utf-8?B?Q1VOZDlVOWFoL05oU0I1bUJCQWR3SThBMzhSSU1xMDZzYVdwcy9wbTJ6MVkz?=
 =?utf-8?B?OTdXemJoeVNSY2w2TVhXK3BYa293TnlZS3Fpc0tmV1hTaENqbTY1bWd5UVZu?=
 =?utf-8?B?UlpoQlMrNloyUlZUVFhMRksxSVgxS0xoM3NNVjZiU3pBN2lUeFlHanJPREho?=
 =?utf-8?B?emQ4Z2VZRHNrMDlrSkFmRkZsWUJPSHQ0aGNTZkt3NFBIUmdrMUk5dVZRRzQ4?=
 =?utf-8?B?ZmcxRXBUenVUaE9vNW4yWFJMeHhlaStVNGZHRjY2eEtYeEFEWVlQbzNHOURU?=
 =?utf-8?B?WkowTE5TRzhWSSt0bmRUR2pSN0RyWXhzbG45RlU4WkFDUFVWamZ0VU9MbnBq?=
 =?utf-8?B?amo1akUwYTQ2Mm1OL2ZZajdkaU1pRC9NTFUyNFQyU2lVbzB0UU9sSjNxNFpI?=
 =?utf-8?B?Y1ZGNzdsU2JQdXpVSUpTUnN3MnQzZVNRZE1tQ0hFblhuaW5WRTJYQWhqRm5o?=
 =?utf-8?B?T01maTByNTZ4V0tPOENKelVyWjFpWjJtS0dKbkpmb1pua216bHkvcG5KSU5h?=
 =?utf-8?B?bkp4MXBna2VnZURJRm1Lemp3bmZpUmJuaUZSRTNNbjhGNjd0Z1UzNnpuSTlr?=
 =?utf-8?B?QWU0cXJqN2J2SUpvWGRJbVlpMnhVLzZmVkppWURRQndOQU9tY3JUeEZ4M0tr?=
 =?utf-8?B?N29sZ0F2UlcxcVdhUVMvc0xSOWY2anFLY0I3TEVEL2poTlBCZ3VzMzN1SmZw?=
 =?utf-8?B?dEFvL1BDMWFjMDJaNmV3aThwdGNyUlZKWFhTZmtjTEhGeldzdkNSQmdYVGNs?=
 =?utf-8?B?S2NhbE02VWxGbFdzM2VwZ2daZ2wvdDU0d0NyNDJNUU5pWUNjRDhUM3o3ME1Y?=
 =?utf-8?B?M3ZNeVRpcUR1MjB0OHMvUkQ1TWtpc2V3MzlOQk5yOE5ZU2s4dVJmRmdROER5?=
 =?utf-8?B?dkRIenhNNkZnREplejA4ZUduLzRZYmtYM3QreXU1Q2dsSWdsU2thbXY2SmF4?=
 =?utf-8?B?dFE5NFllU2s5NDhCRUVWd09XV2FGaXpjRlA1YlpXVitaL3M1ZGhhcTNGdWhj?=
 =?utf-8?B?c0dPODl6NEpPWWp3TFV6aUUwdFdLeGtWbUdZMjVrNUZiTE02bDEyM3BsbUNr?=
 =?utf-8?B?RlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB2C84D9F3CAE440A7F825E7FDBD5C0C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB8179.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d30ebd8-ce0d-4382-ad8b-08dc388686ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 17:56:02.0166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tLHyswrhhP7IJZ/dfJWrKRigeacSrHWS8CTeIp8jqdsEEjYwQmLk3+j/zAgRHEx/tQa/3uXt99ZIYDKTSC9Y9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7938
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTAyLTI4IGF0IDE4OjA1ICswMTAwLCBKb2hhbm5lcyBCZXJnIHdyb3RlOg0K
PiA+IEN1cnJlbnQgNS1taW51dGUgdGltZW91dCBtYXkgYmUgdG9vIHNob3J0IGZvciB1c2VycyB0
byBzZWFyY2ggYW5kDQo+ID4gdW5kZXJzdGFuZCB3aGF0IG5lZWRzIHRvIGJlIGRvbmUgdG8gY2Fw
dHVyZSBjb3JlZHVtcCB0byByZXBvcnQgYnVncy4NCj4gDQo+IENvbmNlcHR1YWxseSwgSSdtIG5v
dCBzdXJlIEkgdW5kZXJzdGFuZCB0aGlzLiBVc2VycyBzaG91bGQgcHJvYmFibHkgaGF2ZQ0KPiBh
IHNjcmlwdCB0byBjYXB0dXJlIGNvcmVkdW1wcyB0byBhIGZpbGUgaW4gdGhlIGZpbGVzeXN0ZW0s
IHBvc3NpYmx5IHdpdGgNCj4gYWRkaXRpb25hbCBkYXRhIHN1Y2ggYXMgJ2RtZXNnJyBhdCB0aGUg
dGltZSBvZiB0aGUgZHVtcC4NCj4gDQo+IEhhdmluZyB0aGlzIHN0aWNrIGFyb3VuZCBsb25nZXIg
aW4gY29yZSBrZXJuZWwgbWVtb3J5IChub3QgZXZlbg0KPiBzd2FwcGFibGUpIHNlZW1zIGxpa2Ug
YSBiYWQgaWRlYT8NCj4gDQo+IFdoYXQga2luZCBvZiB0aW1lb3V0IHdlcmUgeW91IHRoaW5raW5n
PyBNYXliZSB5b3UnZCB3YW50IDEwIG1pbnV0ZXM/IEFuDQo+IGhvdXI/DQo+IA0KPiBBbHNvLCB0
aGVuLCB3aHkgc2hvdWxkIHRoZSB0aW1lb3V0IGJlIGRldmljZS1zcGVjaWZpYz8gSWYgdGhlIHVz
ZXIgaXMNCj4gZ29pbmcgdG8gbmVlZCB0aW1lIHRvIGZpbmQgc3R1ZmYsIHRoZW4gc3VyZWx5IHRo
YXQgYXBwbGllcyByZWdhcmRsZXNzIG9mDQo+IHRoZSBkZXZpY2U/DQo+IA0KPiBTbyAuLi4gSSBn
dWVzcyBJIGRvbid0IHJlYWxseSBsaWtlIHRoaXMsIGFuZCBkb24ndCByZWFsbHkgc2VlIGhvdyBp
dA0KPiBtYWtlcyBzZW5zZS4gQXJndWFibHksIDUgbWludXRlcyBldmVuIGlzIHRvbyBsb25nLCBu
b3QgdG9vIHNob3J0LA0KPiBiZWNhdXNlIHlvdSBzaG91bGQgaGF2ZSBzY3JpcHRpbmcgdGhhdCBj
YXB0dXJlcyBpdCwgd3JpdGVzIGl0IHRvIGRpc2ssDQo+IGFuZCBhbGwgdGhhdCBjYW4gaGFwcGVu
IGluIHRoZSBzcGFjZSBvZiBzZWNvbmRzLCByYXRoZXIgdGhhbiBtaW51dGVzLg0KPiBJdCdzIHRy
aXZpYWwgdG8gd3JpdGUgc3VjaCBhIHNjcmlwdCB3aXRoIGEgdWRldiB0cmlnZ2VyIG9yIHNpbWls
YXIuDQo+IA0KPiBJZiB3ZSB3YW50ZWQgdG8sIHdlIGNvdWxkIGV2ZW4gaGF2ZSBhIHNjcmlwdCB0
aGF0IG5vdCBvbmx5IGNhcHR1cmVzIGl0DQo+IHRvIGRpc2ssIGJ1dCBhbHNvIGRlbGV0ZXMgaXQg
YWdhaW4gZnJvbSBkaXNrIGFmdGVyIGEgZGF5IG9yIHNvbWV0aGluZywNCj4gc28gaWYgeW91IGRp
ZG4ndCBjYXJlIHlvdSBkb24ndCBnZXQgdGhpbmdzIGFjY3VtdWxhdGluZy4gQnV0IEkgZG9uJ3Qg
c2VlDQo+IHdoeSB0aGUga2VybmVsIHNob3VsZCBuZWVkIHRvIGhhbmcgb24gdG8gYWxsIHRoZSAo
cG9zc2libHkgYmlnKSBjb3JlDQo+IGR1bXAgaW4gUkFNLCBmb3Igd2hhdGV2ZXIgdGltZS4gQW5k
IEkgYWxzbyBkb24ndCBsaWtlIHRoZSBkZXZpY2UtDQo+IGRlcGVuZGVuY3kgdmVyeSBtdWNoLCBU
QkguDQoNCkluIG15IG9waW5pb24sIHRoZSB0aW1lb3V0IHNob3VsZCBkZXBlbmQgb24gdGhlIHR5
cGUgb2YgZGV2aWNlIGRyaXZlci4NCg0KSW4gdGhlIGNhc2Ugb2Ygc2VydmVyLWNsYXNzIEV0aGVy
bmV0IGNhcmRzLCB3aGVyZSBjb3Jwb3JhdGUgdXNlcnMgYXV0b21hdGUgbW9zdCB0YXNrcywgZml2
ZSBtaW51dGVzIG1pZ2h0IGV2ZW4gYmUgY29uc2lkZXJlZCBleGNlc3NpdmUuDQoNCkZvciBvdXIg
Y2FzZSwgR1BVcywgdXNlcnMgbWlnaHQgZXhwZXJpZW5jZSBtaW5vciBnbGl0Y2hlcyBhbmQgb25s
eSBzZWFyY2ggZm9yIHdoYXQgaGFwcGVuZWQgYWZ0ZXIgZmluaXNoaW5nIHRoZWlyIGN1cnJlbnQg
dGFzayAod3JpdGluZyBhbiBlbWFpbCwNCmVuZGluZyBhIGdhbWluZyBtYXRjaCwgd2F0Y2hpbmcg
YSBZb3VUdWJlIHZpZGVvLCBldGMuKS4NCklmIHRoZXkgbGFuZCBvbiBodHRwczovL2RybS5wYWdl
cy5mcmVlZGVza3RvcC5vcmcvaW50ZWwtZG9jcy9ob3ctdG8tZmlsZS1pOTE1LWJ1Z3MuaHRtbCBv
ciB0aGUgZnV0dXJlIFhlIHZlcnNpb24gb2YgdGhhdCBwYWdlLCBmb2xsb3dpbmcgdGhlDQppbnN0
cnVjdGlvbnMgYWxvbmUgbWF5IHRha2UgaW5leHBlcmllbmNlZCBMaW51eCB1c2VycyBtb3JlIHRo
YW4gZml2ZSBtaW51dGVzLg0KDQpJIGhhdmUgc2V0IHRoZSB0aW1lb3V0IHRvIG9uZSBob3VyIGlu
IHRoZSBYZSBkcml2ZXIsIGJ1dCB0aGlzIGNvdWxkIGluY3JlYXNlIGlmIHdlIHN0YXJ0IHJlY2Vp
dmluZyB1c2VyIGNvbXBsYWludHMuDQoNCj4gDQo+IA0KPiANCj4gQnV0IGlmIHdlIGRvIGdvIHRo
ZXJlIGV2ZW50dWFsbHk6DQo+IA0KPiA+ICt2b2lkIGRldl9jb3JlZHVtcG0oc3RydWN0IGRldmlj
ZSAqZGV2LCBzdHJ1Y3QgbW9kdWxlICpvd25lciwNCj4gPiArCQkgICB2b2lkICpkYXRhLCBzaXpl
X3QgZGF0YWxlbiwgZ2ZwX3QgZ2ZwLA0KPiA+ICsJCSAgIHNzaXplX3QgKCpyZWFkKShjaGFyICpi
dWZmZXIsIGxvZmZfdCBvZmZzZXQsIHNpemVfdCBjb3VudCwNCj4gPiArCQkJCSAgIHZvaWQgKmRh
dGEsIHNpemVfdCBkYXRhbGVuKSwNCj4gPiArCQkgICB2b2lkICgqZnJlZSkodm9pZCAqZGF0YSkp
DQo+ID4gK3sNCj4gPiArCWRldl9jb3JlZHVtcG1fdGltZW91dChkZXYsIG93bmVyLCBkYXRhLCBk
YXRhbGVuLCBnZnAsIHJlYWQsIGZyZWUsDQo+ID4gKwkJCSAgICAgIERFVkNEX1RJTUVPVVQpOw0K
PiA+ICt9DQo+ID4gwqBFWFBPUlRfU1lNQk9MX0dQTChkZXZfY29yZWR1bXBtKTsNCj4gDQo+IFRo
aXMgY291bGQgYmUgYSB0cml2aWFsIHN0YXRpYyBpbmxpbmUgbm93LCBpZiB5b3UganVzdCBwdXQg
REVWQ0RfVElNRU9VVA0KPiBpbnRvIHRoZSBoZWFkZXIgZmlsZS4gU2VlbXMgYmV0dGVyIHRoYW4g
ZXhwb3J0aW5nIGFub3RoZXIgd2hvbGUgZnVuY3Rpb24NCj4gZm9yIGl0LiBUaGVuIHlvdSBhbHNv
IGRvbid0IG5lZWQgdGhlIG5vLW9wIHZlcnNpb24gb2YgaXQuDQoNCndvcmtzIGZvciBtZSB0b28s
IHdpbGwgd2FpdCBhbiBhY2sgaW4gdGhlIGFib3ZlIGV4cGxhbmF0aW9uLg0KDQo+IA0KPiBqb2hh
bm5lcw0KPiANCg0K


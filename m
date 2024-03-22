Return-Path: <linux-kernel+bounces-111737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F4388701A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 729D21F244B6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FE157875;
	Fri, 22 Mar 2024 15:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kuKgRLH4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F7154919
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 15:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711123105; cv=fail; b=oH1L3hJ9rVg0d2HgBl0/zzWwWD/n7m28N5fV4Imxxwvt2pbGDKFuxG7HSwUnr04ePMOMpEGfDMeN2cLJmaZGOjoxoSmOlnN0aBWWD1PmVB5CuiTuFUMaPCRa8Uyucpp1AzrM49Mp/o+0AUHfUv2tRPWZJHJmoVqm7dSLgq/Fu08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711123105; c=relaxed/simple;
	bh=fi4qbsI+Tjyr4L6XJ4T8WzlfLdiqywWECgGPFVb6jts=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pedEowswwjf0d7os01Wqi3KYayNaUqowcSK5OqO++ZRK82qV5KAuC08vVcUlCt1/j0005tRtFxX3eBVONMce0p9l5hJ2tlPXnTxd9SWDBiyRhn0/2E2uzzo8wUrtmTxpH6iRBySL3JiWODertNmyhTg+Q0Oi14WjbA5of8CCK1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kuKgRLH4; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711123104; x=1742659104;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fi4qbsI+Tjyr4L6XJ4T8WzlfLdiqywWECgGPFVb6jts=;
  b=kuKgRLH4gina2gazUuOo5ogeXvbisXmQtzKz+i8DK7Po5pzQgS5OcX1U
   uD81KbUm2A8bWaYPFi+AybwNjTZhPUZKqwbDtBQ/GrjW/F9ZiN14IKh/8
   myDBO6kj9fdP9MueQ5WX5n/fxmRw1PL4tyNAfchkD0SkRKXnMxuFyQEOx
   YYAILmT2x9NXVDSpV9nuSXLMFB/teUkSfdo3RSchA+jfkJQaHxN19vCqz
   bFUvY0Ml+/VSAouMWs67LRVTqQ0A0vX96SLtuoGpouSE0j65xQOI/G+jS
   1M5K8nKa6xP3vd9EaK5L6boZeznf8k+mDRlZx7SeYhZhmee1e28CXK3+3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="6006141"
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="6006141"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 08:58:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="19514532"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Mar 2024 08:58:22 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Mar 2024 08:58:22 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Mar 2024 08:58:21 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 22 Mar 2024 08:58:21 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 08:58:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bx4NEje5RaQkmhqj6jvxieLNw2FLVe053Ku4AmT7HylzMvRpObcY64tECerzUMCCTMoiWSIlUQ2aHbZClPq18Mi5yeWDhAZxveWOAm66um0w1lSIzaDD+otozx03pkYfphK8TInT/t15O2oVjbA1pTNDWJ1zxOiqrVWuzRSoE/b1OJVwghx+ohmYqnUjf08BZzrNBrFfurade54Vy3dqGTiTznjCu/tWKTw+1ZIkrf+9AcpghqqEcYx0o4xPQO6KLMM3rRKsTNhZvlojXDNr245yIacNzGtlUDrWe59tVqQxg4BPV7u80jhO6oflsm6PhWO9t+XYjBvukuByMySCuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fi4qbsI+Tjyr4L6XJ4T8WzlfLdiqywWECgGPFVb6jts=;
 b=fCbhuHHSF7f2Tv6BfcMAifv85wkNVm7Q2BF9rohgFuV1JZ0pN3VFWJ5qECA+BKO4s6x2JhCeRGwrtnyvsGwY46pWiYguaSxahdMSnQZwHvVug24VuF4azYGT0h2Amc8zTfSm/J9enS4NplBfoCCoWg0+e8S2Q6gAprPys4EXsiyqXDwLVkvpfK9WmjNdlG7swzgqNXay+pNDEiHFzLwohkWstcefosaEH6JkphpQg0i9ujqfYOs8bCUZumlEkLehkEqj12pqHs0RYFd7LupNHhQYO3gRyC9COrMSVSlgRW05u7sOtlLSSxYIYaCd8RlxqmfAbNRTRgBrQSTYCOnmwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by MW4PR11MB7163.namprd11.prod.outlook.com (2603:10b6:303:212::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Fri, 22 Mar
 2024 15:58:19 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::1761:33ae:729c:a795]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::1761:33ae:729c:a795%5]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 15:58:19 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "hjl.tools@gmail.com" <hjl.tools@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/shstk: Enable shadow stack for x32
Thread-Topic: [PATCH] x86/shstk: Enable shadow stack for x32
Thread-Index: AQHaduH6Cs7bYZFPJUuH5QAqHlZq5rE42gyAgAAD8gCACvjHAIAAEIUAgAAOdQA=
Date: Fri, 22 Mar 2024 15:58:19 +0000
Message-ID: <95a27fd1e3b263d2b002c47751b1b42b3d639bae.camel@intel.com>
References: <20240315140433.1966543-1-hjl.tools@gmail.com>
	 <5f0620c55a01d6a195154783a477ec295cbb4b1c.camel@intel.com>
	 <CAMe9rOrgAtQvA=Tj0=T095JmdoRZ8pLuNOY3sT_RwwnznJN2Ow@mail.gmail.com>
	 <7b341bef9c0cab324350873cab75b7e1313a5172.camel@intel.com>
	 <CAMe9rOq9=7hS-Ohk+5kOnstp4tFFsAF11L=EKdTm+gUt97ugbg@mail.gmail.com>
In-Reply-To: <CAMe9rOq9=7hS-Ohk+5kOnstp4tFFsAF11L=EKdTm+gUt97ugbg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|MW4PR11MB7163:EE_
x-ms-office365-filtering-correlation-id: 17427cf0-87a5-4dbf-2358-08dc4a88e4a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YOLr1FzI+9SZwF4AbJar/JWY6rdSnr32IVTunWmBP27tOe2KY8zVCZ5RhmRmTIzVaDWIErj/ncZ+HFrWgIicUcz00jaEBelbtr8Fv3CI2mNA6PaIy4JjaligqjV6TuRu7TLgPXxLf1CB+aarNeJHG/+DjoN0X1xWuNYOJAVEU3PHr1sBR5320kBMxd93IZLSDXPuwge2U9pNaHkKRMqO1X2Wl7liwDksGtaPp3IhSikW+qfLJ8k04Uwm7T1ta5Q6ZOdTT/8dhkJIiruAlESw/+St/PCOcuY6zd2Xo/UOP+bQwO/7Dpz/YGlhimxlA8P/7RDP3980uANMYMdPF3RdlnAKlQcaQjp099RCDcLn86ZHSJjC1o3/TTtoCI11DA8Y48M7oqQ86sqyHq+GUOoKlgC+qIHYy+ghiCCgiy7zmXd1v6umGMrd3P89ExJIy4LVKREbDJCcPDPd2QPlQXP9PaFybA7Ylpcx2/sdRFZ2LsuZ9YZ4piLvIUmdYNbvNsFyrvoB3UBDLz8x/vEJFFsRVgZHdMJc+T5l9OIHnB0pch1PURuxzhUbrwCvKU4XPkW+qwOJsH1r3sqdfQUUZ9kv/IDbRGuq2bZvtnWvJTORW9mcJIlq2Z/6+mHAMulIgsGNChKXlNBq+bSNmFeSyQIUpyY3YBK44uWmaTwfMatPUsQV+/U9hOPiOaQ8g+p8F1QXyeJ5Nd0aNFl/dSahidhm6hKNRZmA/FjgfdhFOlqoRQ4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWNoZUoyWHE2SkN0TlYzVXBRYUhXa2xET3JoSDQyd3l5QWVvQkRURTJwN2d0?=
 =?utf-8?B?RjVhdWdQQ3pJNXhmRVhHd2RPREdGMnZTcTJGVnFEY3A0eG1GbDBrbVVRaVVK?=
 =?utf-8?B?UXNTMG0ybEY1Z2ovckVhZU5BaFFHVkpkbjRWZWxDRnRDQytSem1iVllrZnVG?=
 =?utf-8?B?UnN2azhLYTloM09nQko2Zi9aQUpPME1NcmcrNyt2YlRWc0poalFSZ0NXK0xE?=
 =?utf-8?B?Z2laOGdYamx1T2ZRWU4xbzJGcm1VQ1lDQ2I2OXUvQjNXV1AxVXFDdzhHT3ZG?=
 =?utf-8?B?Rk5iQ2tuT0VGQ1dQWjdIK0NjeEh1UG5Ucml0Q1R3RWNUQ24zaW0vS3BIWGVo?=
 =?utf-8?B?MVJsRERxc3NseTlZMVhGb3FnMU4zdWZndTRiNkIxbG01ZG9QbWtvSGpxNExL?=
 =?utf-8?B?Y3cvN3Y1Q2NnUWdrSEUrdlZMLy9Lc2xuS2xsQ2Jkak1IemdiblBOZDlRcnda?=
 =?utf-8?B?L2xEcGFQdGlUYXl6bm44N3dhWXlmdnY0TWZIRDZSYjRZVFd1WElCMzhWalFH?=
 =?utf-8?B?ZHV3MHNDNFlLVmpJZjNqYU1rbTI4TkV2QmFsK2Z0WkRBcDV2RVRLSmVwL3RQ?=
 =?utf-8?B?emFYYlV2bTVmUmtQQ3J1akFMZGJzWUhhcUV4dHVicFhhLzd6N0l0akRIZHZj?=
 =?utf-8?B?NnMyVjZBOVhPaUhQajFVbCtlaGZYaHNtWXFSa0E5SVB2NzZoUzJwMG8yUVVs?=
 =?utf-8?B?dzJud2RVZVQzb3paTFVHNWpuMmw4V0FTbzVENXdEYllYSktpL2JXVFVId09y?=
 =?utf-8?B?b0FTTk5FTGtQMFZ2SjduRkFUemdjVFdxVVdsaGw2Z1lxRmRKRUpnSG5EVEVZ?=
 =?utf-8?B?RmZINkFkZGN1NDRFdkwxdmVXdGljQU9POEZoMHNGd2piZCt5SnRTUExKZHZr?=
 =?utf-8?B?RklHMUxENllycGJhaDBqTWNoM2JidTdxQ0t0dlhZQWJqNGVMWXpkZkRTMHZz?=
 =?utf-8?B?bHloRkVFcExyZ2ZWU01NajZ5QTBQN0w0OFkrUkErcFliT1Qxeitwb2kwV1c2?=
 =?utf-8?B?MmJoRFFRYU5CbUw4MjZ5SWhaN1JuVUVTRThSMGRpSXo0aDJ1dUltSjZCdGZD?=
 =?utf-8?B?ZXg0QzhsWkp3U2NNS25DQjNmM29LaHBmbzVHSzYxTGtuWlo5eGNsYXpUaVB0?=
 =?utf-8?B?Ky9GV0djYXh2bjQwV1EwVitaUEFjQUlvNFhBZTJGdjlsRTJTK2xRYjYyU041?=
 =?utf-8?B?RlVsenliQlk5alpRT1pGeEsyMTIvMFZ4cHR0SjA5cHBvVzNZT04xb280OU1M?=
 =?utf-8?B?RjV0b2FzblMwZ2VWc3hvSmM4Mjc4c0RKRDNhM2hoN2hCODFvTzh3UlNycXBj?=
 =?utf-8?B?RTdtUVk3MnJadE96VXltODVNUEF3dUgzSHNUUm5sRWJXeFU1dEx2QTRscTU5?=
 =?utf-8?B?N3JlZlh0dFBmdmlvSUZja3YrZjBMK05mV2ljd3ZqNm0yczl5UzdIekZsNmdr?=
 =?utf-8?B?eGwxczE4UHNUWEJING9CZU5XdVB1MXZHQUhxOWdSMFV1S0VtN2dkVUgzMmRD?=
 =?utf-8?B?WmIveVlNMWx6bEhwS2lpdHc4cVgvYlVGalpzMk15OFpYNlVPZjR2OWFHM3d0?=
 =?utf-8?B?aGp0ZFlmZjV6bjl0anhTZWlVM2tGRlJvQ3kva2JMbytXTUExSDBKTmdRaXQ2?=
 =?utf-8?B?Qkd2QmY1ZWNmOHRPM0oxSDduaEkreisxbEhWWDl4aklSMHBEdUFwV2NETXFW?=
 =?utf-8?B?QXQrUUJzeEptdFF1dGJiNnFVZTZvN0lvMEZRMlZTOVB2eUFvbGxoZEIyRTJY?=
 =?utf-8?B?cXNLcjRqbFlQWXgySXdSVnZCQldJaHNKNm8yR2FFTms2c2ZYMFZBVDlKa1I3?=
 =?utf-8?B?aWYranZmVzNCZHE3ckZYZDNpTzRDR0ZTcmhldGJzb2RqSjRORTBJVThjQ0J3?=
 =?utf-8?B?bkt1K1lHdVl2SlliZUZvbk9iem8vSndEYitxd3RZdlAyallwd0VacXZNTGFS?=
 =?utf-8?B?TlZIa3BianhSbFMyUkhUSGlBSXg4YkVsSjdiVU5lNkZGdUxDM09xbzN3V010?=
 =?utf-8?B?WG0yb3JUOWZ0Wi9BSGJyeTAzb1JEV2JoV3ZoWUM2VThaeVc2b2JUVWtabDhr?=
 =?utf-8?B?MEdsZ2NRNzlyYVc0VHp0UXZ5NldpejRMYUk3bGMwZnNrNVVSdFFNNklheEtP?=
 =?utf-8?B?OTZlUm5BZXpVbEU0KzVRazg3VWVjZG5ZNDdPTEtxRytSTDhtbnA3U2RnS0o5?=
 =?utf-8?Q?QBzmdN+tSbkxWWCeYNRa8Yc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <966000CEF4FF954E9B2284FA5202F682@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17427cf0-87a5-4dbf-2358-08dc4a88e4a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 15:58:19.1316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 863Cn1gw60UoU8ImWhnpxAnezSuM2VZCzQnzHSAPI9L+CzoVTcPKzCKSu7Kt3FyQBYjzA2GsiBktci4fuLu9/o+u0PhxSbnJPHy9U02jb+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7163
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTAzLTIyIGF0IDA4OjA2IC0wNzAwLCBILkouIEx1IHdyb3RlOg0KPiBPbiBG
cmksIE1hciAyMiwgMjAyNCBhdCA3OjA34oCvQU0gRWRnZWNvbWJlLCBSaWNrIFANCj4gPHJpY2su
cC5lZGdlY29tYmVAaW50ZWwuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBGcmksIDIwMjQtMDMt
MTUgYXQgMDc6MzQgLTA3MDAsIEguSi4gTHUgd3JvdGU6DQo+ID4gPiA+IEhvdyBtYW55IHBlb3Bs
ZSBkbyB5b3UgdGhpbmsgd2lsbCB1c2UgdGhpcz8NCj4gPiANCj4gPiBJJ20gY29uY2VybmVkIHRo
YXQgdGhlIG9ubHkgdXNlIG9mIHRoaXMgd2lsbCBldmVyIGJlIGV4ZXJjaXNlIHZpYQ0KPiA+IHRo
ZQ0KPiA+IGdsaWJjIHVuaXQgdGVzdHMsIGJ1dCB3aWxsIHN0aWxsIHJlcXVpcmUgd29yayB0byBz
dXBwb3J0Lg0KPiANCj4gwqBDb3JyZWN0LsKgIEEgc21hbGwgZ2xpYmMgY2hhbmdlIGlzIG5lZWRl
ZC7CoCBXaWxsIHBvc3QgaXQgYWZ0ZXINCj4gbXkga2VybmVsIGNoYW5nZSBpcyBtZXJnZWQuDQoN
CkkgbWVhbiBpdCB3aWxsIHJlcXVpcmUga2VybmVsIHdvcmsgaW4gdGhlIGZ1dHVyZSB0byBtYWlu
dGFpbiBzdXBwb3J0Lg0KVGhhdCB3ZSB3aWxsIGhhdmUgdG8gdGhpbmsgYWJvdXQgeDMyIGVmZmVj
dHMgd2hlbiBtYWtpbmcgb3RoZXIgc2hhZG93DQpzdGFjayBjaGFuZ2VzLg0KDQpJJ2xsIHBhc3Rl
IG15IG90aGVyIGNvbW1lbnQgaW4gdGhpcyB0aHJlYWQ6DQoNClRoZSBtYWluIHVzYWdlIG9mIHNo
YWRvdyBzdGFjayBpcyBzZWN1cml0eSwgYW5kIGNvbWVzIHdpdGggc29tZQ0Kb3ZlcmhlYWQuIElJ
VUMgdGhlIG1haW4gdXNhZ2Ugb2YgeDMyIGlzIHBlcmZvcm1hbmNlIGJlbmNobWFya2luZyB0eXBl
DQpzdHVmZi4gV2h5IHdvdWxkIHNvbWVvbmUgd2FudCB0byB1c2Ugc2hhZG93IHN0YWNrIGFuZCB4
MzIgdG9nZXRoZXI/DQoNCj4gDQo+IA0KPiA+ID4gPiANCj4gPiA+ID4gSSB3b3VsZCBoYXZlIHRo
b3VnaHQgaXQgd291bGQgcmVxdWlyZSBtb3JlIGNoYW5nZXMgZm9yIGJhc2ljDQo+ID4gPiA+IHgz
Mg0KPiA+ID4gDQo+ID4gPiBUaGlzIGlzIGFsbCBuZWVkZWQuDQo+ID4gPiANCj4gPiA+ID4gb3Bl
cmF0aW9uLiBXaGF0IHdhcyB0aGUgdGVzdGluZyBleGFjdGx5Pw0KPiA+ID4gDQo+ID4gPiBJIGNv
bmZpZ3VyZWQgeDMyIGdsaWJjIHdpdGggLS1lbmFibGUtY2V0LCBidWlsZCBnbGliYyBhbmQNCj4g
PiA+IHJ1biBhbGwgZ2xpYmMgdGVzdHMgd2l0aCBzaGFkb3cgc3RhY2sgZW5hYmxlZC7CoCBUaGVy
ZSBhcmUNCj4gPiA+IG5vIHJlZ3Jlc3Npb25zLsKgIEkgdmVyaWZpZWQgdGhhdCBzaGFkb3cgc3Rh
Y2sgaXMgZW5hYmxlZA0KPiA+ID4gdmlhIC9wcm9jL3BpZC9zdGF0dXMuDQo+ID4gDQo+ID4gVGhl
IHNoYWRvdyBzdGFjayBpcyBzdXBwb3NlZCB0byBiZSBtYXBwZWQgYWJvdmUgNEcsIHNvIGhvdyBp
cyB0aGlzDQo+ID4gc3VwcG9zZWQgdG8gd29yayBmb3IgeDMyPw0KPiANCj4gVGhpcyBpcyBub3Qg
d2hhdCBJIHNlZToNCj4gDQo+IChnZGIpIGluZm8gcmVnDQo+IC4uLg0KPiBwbDNfc3NwwqDCoMKg
wqDCoMKgwqAgMHhmN2RjYmZlOMKgwqDCoMKgwqDCoMKgwqDCoCAweGY3ZGNiZmU4DQoNClRoZSBt
YXBwaW5nIGFib3ZlIDRHIHdhcyBiZWNhdXNlIFBldGVyeiByYWlzZWQgdGhlIHBvc3NpYmlsaXR5
IHRoYXQgYQ0KNjQgYml0IHByb2Nlc3MgY291bGQgZmFyIGNhbGwgaW50byBhIDMyIGJpdCBzZWdt
ZW50IGFuZCBzdGFydCBkb2luZw0Kc2lnbmFsIHN0dWZmIHRoYXQgd291bGQgZW5jb3VudGVyIHVu
ZGVmaW5lZCBiZWhhdmlvci4gSGUgd2FudGVkIGl0DQpjbGVhbmx5IGJsb2NrZWQuIFNvIGJ5IGtl
ZXBpbmcgdGhlIHNoYWRvdyBzdGFjayBhYm92ZSA0R0IsIGV4aXN0aW5nDQpwcm9jZXNzZXMgdGhh
dCB0dXJuZWQgb24gc2hhZG93IHN0YWNrIHdvdWxkIGJlIHByZXZlbnRpbmcgZnJvbSANCnRyYW5z
aXRpb25pbmcgdG8gMzIgYml0IGFuZCBlbmNvdW50ZXJpbmcgdGhlIG1pc3NpbmcgMzIgYml0IHNp
Z25hbA0Kc3VwcG9ydCAoYmVjYXVzZSB0aGUgQ1BVIHdvdWxkICNHUCBkdXJpbmcgdGhlIDMyIGJp
dCB0cmFuc2l0aW9uIGlmIFNTUA0KaXMgYWJvdmUgNEdCKS4NCg0KUHJvYmFibHkgdGhlcmUgaXMg
c29tZSBpbnRlcnBsYXkgYmV0d2VlbiB0aGUgeDMyIG1tYXAgbG9naWMgYW5kIHNoYWRvdw0Kc3Rh
Y2tzIG1hcHBpbmcsIHdoZXJlIGl0IHRoZW4gYmVjb21lcyBwb3NzaWJsZSB0byBnZXQgYmVsb3cg
NEdCLiBTaW5jZQ0KeDMyIG5lZWRzIHRoZSBzaGFkb3cgc3RhY2sgdG8gYmUgYmVsb3cgNEdCLCBp
dCdzIGluY29tcGF0aWJsZSB3aXRoIHRoYXQNCnNvbHV0aW9uLiBTbyB0aGlzIHBhdGNoIGlzIG5v
dCBzdWZmaWNpZW50IHRvIGVuYWJsZSB4MzIgd2l0aG91dCBzaWRlDQplZmZlY3RzIHRoYXQgd2Vy
ZSBwcmV2aW91c2x5IGNvbnNpZGVyZWQgYmFkLg0KDQpJIHNlZSB0aGlzIGlzIGluIHRpcCBub3cu
IEkgZG9uJ3QgdGhpbmsgaXQncyBhIGdvb2QgaWRlYSB0byBzdXBwb3J0DQp1cHN0cmVhbS4gVGhl
IGltcGxpY2F0aW9ucyBuZWVkIG1vcmUgZGlzY3Vzc2lvbiwgYW5kIHRoZXJlIGRvZXNuJ3Qgc2Vl
bQ0KdG8gYmUgYW55IHJlYWwgZW5kIHVzZXIgdmFsdWUuDQo=


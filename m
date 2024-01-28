Return-Path: <linux-kernel+bounces-41947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD12E83F9DF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D19941C212F5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 20:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE1C3C062;
	Sun, 28 Jan 2024 20:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TFc8l0Xk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6B31E525
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 20:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706473675; cv=fail; b=c3DGktbHY52j4R6/eBual8DYOtuNvdeabWppr51O8oUSa9eH9V4WyIVWkrB7EF9RKagu3H0TDj309nxhMO+F2NvwTKhqOgzL2bIz+4y5aGXOtAux/jhlvJJZ8wMMA7gPICVi5chU6jt0ed04DWn02AICbveJAluxLPDSDW+WRfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706473675; c=relaxed/simple;
	bh=e7E+SZEPvsMNNMfStQ16C2M5J227s9ZLpjDlOHuvN5k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bSGnfXAVaX3vndRd2S7Qjyjymhn4yFgClYS0OJAA3wOHc4UTrFs1cxRla2AToWp++O0itbvQYVjlbkXB/fkU5hSYaP0KMUjkYdff7dbZwYvnWgUNMJeSXozU1cL9o0bxijfQsOnPjGdC3TX+9p9fuGZpn3tkc0RegXjm472hDUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TFc8l0Xk; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706473674; x=1738009674;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=e7E+SZEPvsMNNMfStQ16C2M5J227s9ZLpjDlOHuvN5k=;
  b=TFc8l0XkVeZqTkjbVtb+iwesQIhbIy5vS00BBmpYMirjGFDebRzc4hyG
   R7JUW0eAGPiV/qwgkcgyRxmi+26JPJ7CqA9J3mwoLKZqk10yj92Cyumll
   S+UUxEyBLrwqad8mFzb9YDjavNxihfNm9qE9ijW40T0X7WXsNZaWSynpy
   n/ddInfHU1CQJnWJe3HL3o2/Tw8epRPKB7aYDO0AcSQKKufBw1Z9PB/LX
   eRRnvgrcTlewknmOAilopYGarnORF0rbc4BmA8JoKcliCYal25ck/dU31
   0pjEAg84m7XRZpTiiRoZd+ySdqExG8GxJB2QW2AqjvYC2TlNO7qwGCP5v
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="10189227"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="10189227"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 12:27:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="21899963"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jan 2024 12:27:52 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 28 Jan 2024 12:27:51 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 28 Jan 2024 12:27:51 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 28 Jan 2024 12:27:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNaX/f917D01yTPcwg+JhzBtsNFRWJlOphWW2leFICyyQwIPvx/6seU1gO53xY3AtdT7FdRFvI6S7AXZsftfpjzp0256xRdjDg5mx/WbKvHd8yGGP39VuOFtX9Tu9/bVoxafVEEc+sp/EuP88MmwpiEOo/x82if+kgHYCTVk3+uk7OkRL/aswDYwGTBHv+65FH8zjz7EverCifi/y6vu+B7J5plMGfuFRJs8GxFNwGKrp1g9FPa482HpKXcEyvAqog4V3hNO5FyHQJsHNUBSwMmkFbr3d5ZhiTLt9qe/XhBRxAO6d/FTwJpdYedB0LL8gbae0HY8Kfra5RkUO3CqkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7E+SZEPvsMNNMfStQ16C2M5J227s9ZLpjDlOHuvN5k=;
 b=d8k3H6HSMyMTNCvLyuQiO1YqX8lVGeEFY0OCqAIf6T2WZm7nPnGmw21MoNOVyz6Pfvghns46vWE2KyN5uf6SOrPjKP8r6iL5pZQK31OjKBQNg5sh3E+75E+TA5Fhy90QoW3Zkg+fMIHaWrY5TDWnzi/aG44o3OExTsxha/PcwK43XUsVKJfciP+VI1ssqOAS/Ft4B+uIpV4SSy7N3ikoxk/bHmyAdCo337gA+N5E148+AjcJuzga5zYBnYuIEuISPEBZc6fdK9ytAWm8kfU2eoE5Qz3gLaQKbXE4MveNhoLrwIZdnKGmaEepTfEmy2e9yPtPFP3K9lzKZ6WoFgROQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by CY8PR11MB7193.namprd11.prod.outlook.com (2603:10b6:930:91::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Sun, 28 Jan
 2024 20:27:50 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::8ccb:4e83:8802:c277]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::8ccb:4e83:8802:c277%4]) with mapi id 15.20.7228.029; Sun, 28 Jan 2024
 20:27:49 +0000
From: "Li, Xin3" <xin3.li@intel.com>
To: "H. Peter Anvin" <hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "luto@kernel.org" <luto@kernel.org>, "Shankar, Ravi V"
	<ravi.v.shankar@intel.com>, "andrew.cooper3@citrix.com"
	<andrew.cooper3@citrix.com>
Subject: RE: [PATCH 1/2] x86/fred: Fix build with clang
Thread-Topic: [PATCH 1/2] x86/fred: Fix build with clang
Thread-Index: AQHaUQjxIW0LUx+n7UOybQMQ5s4uu7Dt90oAgAAXPYCAAZEZAIAADm6Q
Date: Sun, 28 Jan 2024 20:27:49 +0000
Message-ID: <SA1PR11MB673408407EE572F5043C1C2EA87F2@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20240127093728.1323-1-xin3.li@intel.com>
 <20240127093728.1323-2-xin3.li@intel.com>
 <49BA730F-E9A0-44AA-AB62-D2F40C5C11DD@zytor.com>
 <SA1PR11MB6734916F2BB7E296A6FEE52EA8782@SA1PR11MB6734.namprd11.prod.outlook.com>
 <882e400f-913b-4ed5-9611-ef87cd8b58b2@zytor.com>
In-Reply-To: <882e400f-913b-4ed5-9611-ef87cd8b58b2@zytor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|CY8PR11MB7193:EE_
x-ms-office365-filtering-correlation-id: 482d4180-b3cf-4add-c789-08dc203f98c3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o2kKIx1z6OI8jhOBR3q67KeaUkK0GyTl46FGZ8lL5DaG+3V/eWbo08zs2wT8/Hkf+0G2Uy6hnJNlORy9oVqKNyi05vHySZr/NeQjLi94+H1J276tIIPstGgGQkWK22T2g31Ap2MCNYOh0fn0Cum2GdDw7Tm262QIg6hwFNxrpFW5WnvXfTcLq3msax481BwxZ10ivMi3nU2KiGL5Ax7KqaIPydAJwS0ZfWmFc2xUbiElzHyQbijBB76KaS4XV945ND9+6D/3rTgHwmU3h0ZoRm7e+GWSzl8tYxRXH2pUNie8vxwwopKCqJSogMsHKBKAC6flf/rBitkAio+0lMAqN5wD9sq0rxSdK33WYjoXvV/VMIBaFsVWNcE0WTGbJ/O/hzqqfDW0ZoLZWdKw12r3/LpPbPe4u9EFwrqbcuajY1fQra/ltnVvp+4UFT9Ve5GkAPwrk10POpGbd4mbbWn4UBL+wo12ZyV4jw1WE61JTusInnduBCI2yOZEf9YnnFNkrPCzTy6tO/+THjqWAFzg5c43KyAx8zzoimniY3mDh9Y5HNghmxF3deLN1FFMGusQMrElr0kkpB/4vsWSGNNlzYsE0a5VJng+NMljuIqbXQiWlYsmZSfVFPRV+cOFxrr6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(39860400002)(376002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(55016003)(26005)(83380400001)(7696005)(6506007)(33656002)(86362001)(38070700009)(82960400001)(5660300002)(52536014)(41300700001)(4326008)(8676002)(8936002)(9686003)(38100700002)(122000001)(76116006)(66946007)(66556008)(110136005)(66476007)(66446008)(64756008)(54906003)(71200400001)(2906002)(478600001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXd2eE1pNG5HWThCVFhxTjdmT0YzMFlYUExaNDFTSUNoSW5xWDB1SmhISGwv?=
 =?utf-8?B?VnM0OXpPUmRVbXh1dWJ4NUpta2ZiVktQRlZsblc4WGpNYU5BNENoalBtelgw?=
 =?utf-8?B?a2FuOW1PZWR4T2loZGljTG1CVnROSlZIenRYVGE0Y1lBQnZ5RHF3RzUxUitX?=
 =?utf-8?B?ODNDTFc1b3k4bHd3QW10Y1NhS2NmZjlsOWxUcDY3bGZHS2xkWFdCTWxBYXRE?=
 =?utf-8?B?MVRWWmEzQkN1dE1KNHdqY0tkRWt3UDdjUHdMbjFBNm1Ed2FWMmVJT1dLa2pw?=
 =?utf-8?B?a0NEcy9ONkVyQ00wZXpUaWxFeFNxblpKSCtSakNDcDRRUFhXWTdLNEVheVRX?=
 =?utf-8?B?NEZlVmJwS2h4VGRqQ0NRMTNsM0h6bmNScTBoZ3pTNytrZTV1REM4ZUlodGNr?=
 =?utf-8?B?NFpQMytzQ1Z3d1FGcDZqT0N6ejk2aGFyUS9NOHA1d3U4RUJiRnFVVzExbks4?=
 =?utf-8?B?eFFXMEVqUHFFVGFseTdoQkFCZ3J1YjR2OEtJQXBqbzRLcHRsSHpYMXJGY0dB?=
 =?utf-8?B?OUo3d3RYVFk0U29SdXZJM3R4a2VCc3JkRlRBRFR1U2l6Z2pwY1gxUFh2Z1JS?=
 =?utf-8?B?Q0pDTGNpOUkxVDFuWTNNS1pzK09uNDFKTlhHeUlWSitndVBUYkNpZXlWTUl1?=
 =?utf-8?B?elo2MVk4Tm1FVldxK0hwUkErUFkyakxPZ0c3VkVUdVJDckdsZk4rU05qbjlj?=
 =?utf-8?B?SGNhZVgwMENGZm5wNzJ5ODJhUUFlUCt5eERCaWFNUHFxUnpzYVZXYXRyTTZ2?=
 =?utf-8?B?dVcxbXI5ejNNUGlXZ3RJcDNvSDc5SHd1b2U5SUhaWnV6ZFY0Um5lMWpFWUxL?=
 =?utf-8?B?Q2VGSUdQcWd2V2Q0U2VvV042NEJKSVpTb0VPN3FrYVdoTFpWbmxreUNMdkNk?=
 =?utf-8?B?dUpicnB4MXBDNElPM0l6UVlpMDVrcUtaMTdrTGtZZStRMGhyVW55SEh1Smx0?=
 =?utf-8?B?TytDNHhUYkVsTXZRTk1qZlBtSGZEeTdoVld1NUtvclJaanlSZzZSOWZqZE9o?=
 =?utf-8?B?NytBQy9wL0NFOC85RGV1aFlzRzRROFBPKzM0MVB2eXFnWHdHMUY1T0pjNHla?=
 =?utf-8?B?NXV1aWhBSVkyR3lRNitLSENiVEFob0ZSUzBzbnc1VGk3RTJNSDRIQ2VxOW82?=
 =?utf-8?B?Yk5Da1N6WEowVExQRGsrQnlhMmhackxlTUY0dXBtT3NmTXc0K1hoK2plN2F6?=
 =?utf-8?B?b2VlWTFRd053em93TmRjSjFleWQrSlpodlZiZFBuZWR1TTF1RzI1MjJSZWJW?=
 =?utf-8?B?bEFuOXo4Nk9iQVVKQk5TeXI5bU9EM1lUMWYyOGg1cG1USy9nQ2wyMWVML05O?=
 =?utf-8?B?dDloQ3N0ZktBY0k4UmczVko3Q284MzFiR3ZZTlNuQjR3TmNYVU82MWZxV3Zi?=
 =?utf-8?B?SHZWUE4rdlVNNlNodXJSbnlreHk2d1BEWHJCZ0c4THFINVJkNE16UXZzVlFj?=
 =?utf-8?B?aHBnajFXSzUwRCtOWlZWMFBacHFRdDQxNHJFSW5QUFErd1loN0Z0SjRHN1BI?=
 =?utf-8?B?TmtyanV6OUJjakdTREw4ZlFTbExSVkZJRVVCVGV0RXdDbW9XYStwYU50U29G?=
 =?utf-8?B?by9xMk50OGVwczFXQ0JFd0tSNUxVV3Q1UlpuczNKaVltUVA0YUs2RDZTdEIy?=
 =?utf-8?B?amVrcEZqZGJFVVVjSWdJb0xPNUY2MzIzUmthZFJ3TXJNSWRwTlhTV3g3c3Jz?=
 =?utf-8?B?MlVBUG45YkIvemRlOUNNcUU4VWNnc0NlaVdRaE8vY000c1M0SHFDMk9kZHd6?=
 =?utf-8?B?Z2FhRS9wbFlxNFRUSlZoNVUycnUzYTR0UUR4bTBQbklHeUFqRUEremkyWEJO?=
 =?utf-8?B?NmFIU2FpcnJ6Z2hGM3NmQU02amhWcGFaRlA1Y1pGeWNPY2NjSVV3RHdleGdI?=
 =?utf-8?B?YkVka1RHMDFMUDN6cFhudFhRMEQ4c3FCVVFUOVpJMDZINFU4Zi9hTStGeWhq?=
 =?utf-8?B?UnJSSnpnQ3RyckVVYXZzM3BBc2dPY1BOUEI1RnFpRE9YY2xBd0tFZ2JHME9J?=
 =?utf-8?B?M3lsbEhxN0h5bWgyOWZEZFlaQ0tYalhWbmtpS1dIZGxDVkQ4Tnhqek5RR09R?=
 =?utf-8?B?MlNOVXVJdm9sdzVkOXYvdzF0ckpzbXdOVDVxekl4a3E4NHNVWU5Valdiamp0?=
 =?utf-8?Q?V3vQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 482d4180-b3cf-4add-c789-08dc203f98c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2024 20:27:49.7463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OENdjciCrqpOSI8uB8fCHfssOYJgtHNXSJxUDpa6HTCOLoHZU8uaxMM1mueV2D8LmIdcFNGaFoz/aTpZ/RrW8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7193
X-OriginatorOrg: intel.com

PiA+Pj4gQEAgLTQzLDEzICs0MywxMiBAQCBTWU1fSU5ORVJfTEFCRUwoYXNtX2ZyZWRfZXhpdF91
c2VyLA0KPiA+PiBTWU1fTF9HTE9CQUwpDQo+ID4+PiAJX0FTTV9FWFRBQkxFX1RZUEUoMWIsIGFz
bV9mcmVkX2VudHJ5cG9pbnRfdXNlciwgRVhfVFlQRV9FUkVUVSkNCj4gPj4+IFNZTV9DT0RFX0VO
RChhc21fZnJlZF9lbnRyeXBvaW50X3VzZXIpDQo+ID4+Pg0KPiA+Pj4gLS5maWxsIGFzbV9mcmVk
X2VudHJ5cG9pbnRfa2VybmVsIC0gLiwgMSwgMHhjYw0KPiA+Pj4gLQ0KPiA+Pj4gLyoNCj4gPj4+
ICAgKiBUaGUgbmV3IFJJUCB2YWx1ZSB0aGF0IEZSRUQgZXZlbnQgZGVsaXZlcnkgZXN0YWJsaXNo
ZXMgaXMNCj4gPj4+ICAgKiAoSUEzMl9GUkVEX0NPTkZJRyAmIH5GRkZIKSArIDI1NiBmb3IgZXZl
bnRzIHRoYXQgb2NjdXIgaW4NCj4gPj4+ICAgKiByaW5nIDAsIGkuZS4sIGFzbV9mcmVkX2VudHJ5
cG9pbnRfdXNlciArIDI1Ni4NCj4gPj4+ICAgKi8NCj4gPj4+ICsJLmZpbGwgYXNtX2ZyZWRfZW50
cnlwb2ludF91c2VyICsgMjU2IC0gLiwgMSwgMHhjYw0KPiA+Pj4gCS5vcmcgYXNtX2ZyZWRfZW50
cnlwb2ludF91c2VyICsgMjU2DQo+ID4+PiBTWU1fQ09ERV9TVEFSVF9OT0FMSUdOKGFzbV9mcmVk
X2VudHJ5cG9pbnRfa2VybmVsKQ0KPiA+Pj4gCUZSRURfRU5URVINCj4gPj4NCj4gPj4gLmZpbGwg
YW5kIC5vcmcgaGVyZSBhcmUgcmVkdW5kYW50OyBpbiBmYWN0LCB0aGVyZSB0d28gZGlyZWN0aXZl
cyBtZWFuDQo+ID4+IGV4YWN0bHkgdGhlIHNhbWUgdGhpbmcgZXhjZXB0IHRoYXQgLm9yZyBpbXBs
aWNpdGx5IHN1YnRyYWN0cyB0aGUgY3VycmVudCBvZmZzZXQuDQo+ID4NCj4gPiBBaCwgcmlnaHQs
IC5maWxsIGFscmVhZHkgZG9lcyB0aGUgam9iIQ0KPiA+DQo+ID4gSSB3aWxsIHJlbW92ZSAub3Jn
Lg0KPiA+DQo+IA0KPiBJbmNpZGVudGFsbHksIHdhcyB0aGVyZSBhIHByb2JsZW0gd2l0aCAub3Jn
IC4uLiwgMHhjYz8NCg0KT2gsIGl0J3MganVzdCB0aGF0IEkgZGlkbid0IGtub3cgLm9yZyBjYW4g
YmUgdXNlZCB0byBmaWxsLg0KDQogDQo+IE5vdCBhIGNyaXRpY2lzbSwgSSBqdXN0IHdhbnQgdG8g
a25vdyB0byBiZXR0ZXIgdW5kZXJzdGFuZCBjdXJyZW50IGJpbnV0aWxzDQo+IGxpbWl0YXRpb25z
Lg0KPiANCj4gCS1ocGENCg==


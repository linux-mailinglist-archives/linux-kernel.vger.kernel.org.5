Return-Path: <linux-kernel+bounces-61336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DA4851134
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13C821C222B7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8016B208C1;
	Mon, 12 Feb 2024 10:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fdMQEiiG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3F917BDF
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707734433; cv=fail; b=DpaabVUo7sZ6CzR9064FWCrEg+0B+ZZQx7HPcQhI/tLWOpdZ8AmWpdSShSHJkts6XeeTX938pOkNzfi7iQ68rnAMrji6vx1g1OrhYbGAMVpLvqnr78SlUYhr+dWmSBedlsKEjVOXQxzJ4iTYpTwRRhNe8ouebxOido9XoTfJtf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707734433; c=relaxed/simple;
	bh=Gs6PEJ9Tyym3Df3Uhqk/WfcPITNC20LaGjNh2DIG2Ss=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kZpD52ZWHTebQ09GBrM17ursi1Iqgydf3ndcu8BCctPIdjsSp5vBTKT2tffTqpnOfWZqhWKInYvVJbsZMOyCyDWM6RteJuItreT2VAezY9dtuHfBOo1N87fYJlhdkxEl7IFQ0TUR5mROhCJU990xnl1MoLMnVzMwaYeWJWa9D4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fdMQEiiG; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707734432; x=1739270432;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Gs6PEJ9Tyym3Df3Uhqk/WfcPITNC20LaGjNh2DIG2Ss=;
  b=fdMQEiiG8TrJGDpREOoEA53dyn+txbhy6Tsis+RXThW/L8UX3OEdxh0u
   KmPBP9kLjcUkljgrX7plLutH29KQzpiKhuMT5NKwZMyWj1hd1OxmxUksE
   hOIVWJo3MyItLjXVCRRew8F5S7V0sDvqzRDRLXuFFA9/2dW3sySbBObVa
   LbdftAlT6cKTEXvM3FAKTZQMb1eAbZsRqEBiT6eNU8PP+vLmo8jvfMwzV
   osMwplkYaEnYbdJYP33wxxVljwagYq45YTFny0o1gjKrC3bjyTzO9nHwy
   RwkUWULr/VYvDkDvRrP94r39l1yLibYtc87sSEQiAD/2RV3l22/bx7kbe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="1608252"
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="1608252"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 02:40:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="7206777"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2024 02:40:31 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 02:40:29 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 12 Feb 2024 02:40:29 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 12 Feb 2024 02:40:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCnPcW7peFN9XOr1t7Lf/aDHz1wmiafX1EavjuLvpzdH1Cs1SShqc2XgdMaxuADp1eT4QGh53Yw78NjNcgoL8SAsyS6j3u1sqW5ZGMjaW4Ws76y2Ic0ZqRdDWt35UeRdkl+ih2cMuWvqzp2iTysWDlK0nQScUkfjG8mT6lOXdu4sNIdFbB1D2JBh5aXoXH0mhFKkyOzlx7PJYE2cpXayVWmafgmUYXQEyHPp91jti4NJ1TDmVxN1FjsvG7qkwOX/YFaFWXO+nistrsR8nmDEQRgWZ65Cw/q1XuKz3MGK4REnneYoUyfDu4dCF43usadjO02/Sg9WPJEfslTTKdoolw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gs6PEJ9Tyym3Df3Uhqk/WfcPITNC20LaGjNh2DIG2Ss=;
 b=AClneZDrKThQdVFNhJ6ekog7h3eX1amvpiFXyLp1hDCNiPw2D3VIKQNsMw7CRIaQypWUWujDJekwMNNOD8NhpNgvt0pjiGY4DFbON8Tgpz4Vaj+ermtLzPXQ/F/FW/ZbhKObGJevF+7by3KuWhBlVr6w8XVkgUOT+fGPK0gmgHCEZeMaDLRVuFQpNmVWhuL04ksb8pmoaGfJRz3RTSa9AngJpBjiRW/gmcLU43P6h8T3qhloncTgEa+jOmtLoc+Ap8nbLmkZuj6w7Afax8eykV2p4/3GtCQvbf/gKxUrFEXinjco3QK8AYH6OZSoYBF7iniyp4kJXNt96FqYcjMntw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 SN7PR11MB7042.namprd11.prod.outlook.com (2603:10b6:806:299::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.38; Mon, 12 Feb 2024 10:40:27 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::7e88:63ca:dd41:d190]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::7e88:63ca:dd41:d190%3]) with mapi id 15.20.7270.033; Mon, 12 Feb 2024
 10:40:27 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: Tom Lendacky <thomas.lendacky@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, "Williams, Dan J"
	<dan.j.williams@intel.com>, Michael Roth <michael.roth@amd.com>, Ashish Kalra
	<ashish.kalra@amd.com>, "Shutemov, Kirill" <kirill.shutemov@intel.com>,
	"Dong, Eddie" <eddie.dong@intel.com>, Jeremi Piotrowski
	<jpiotrowski@linux.microsoft.com>
Subject: RE: [PATCH 00/11] Provide SEV-SNP support for running under an SVSM
Thread-Topic: [PATCH 00/11] Provide SEV-SNP support for running under an SVSM
Thread-Index: AQHaUKVsbYupSzmAu0q3a+y4/e0Gj7EGmfkg
Date: Mon, 12 Feb 2024 10:40:26 +0000
Message-ID: <DM8PR11MB575087DCCB069C723BBE1B47E7482@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <cover.1706307364.git.thomas.lendacky@amd.com>
In-Reply-To: <cover.1706307364.git.thomas.lendacky@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|SN7PR11MB7042:EE_
x-ms-office365-filtering-correlation-id: 8d156e65-c56b-49be-725f-08dc2bb706aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jE3GeFJzzNdvO0q7ob6Wl+xGkqsDbICLMs68cl0C/g1zoOyias0iFy2wc8K6f+PWxwzPHtFlzMRUfKXm95awVHZh+Uu8EmxH7rmlEkkfa9952qVv3yQ0TKp1dICPBghqKXcMDnsq63fm2t49njkmDJqBUw4vNXGEexNJrbbZBr37BN0DSqGNclrLyZ/spL4c+ycvKFcfPZpuxCjom9r/jGCr7057UIEIMxXSKDpy9LE3FvhJTic/ZYHNoU2LsXyK2G0sNZe+Yk5n1F99s2WkexXCy5x5WL9AEfynhtidvTVTeTNBzkfHHJRWPH0faKhB58CTyCDY3gi+nEoqdHB+ULZph0d/EYOqUo/niikPxJi+QEvx+QTKk6PwP8skofQvcAJeJcX7mJmfUgCk00FU3wR7mQxX0rfU2xJceAeEj4rcrKScAfFvQtrMUXaZg9KEaDLYA7OSeOtW97JbP/Tr2muomqK7NCTr5YUaxaG9H5w73zzWCu9gUJ231vuBeXHMG7NTt5+7FtsAG4HiyELFdAT+B++5H9EM0ven0zwTiclZtJxmm4NCMvQ/z7xMoXS01YyNIhWN1W7mQeEjoBtD75SpdveFk8Z0mFR6INmjfA0+bM2W/ldtqVlaGMidrjqfqO8MSy0qh+H2UMFd6ELbtg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(366004)(376002)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(33656002)(38070700009)(71200400001)(6506007)(7696005)(966005)(478600001)(26005)(9686003)(64756008)(52536014)(2906002)(66446008)(4326008)(7416002)(5660300002)(110136005)(66476007)(66556008)(76116006)(66946007)(54906003)(316002)(8936002)(8676002)(86362001)(83380400001)(82960400001)(122000001)(38100700002)(41300700001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVdpTG9CRTRneFdRT3Nleloxd2hsSkN4MnhYWTNUSEh4cTgrOS9heW5mVFBw?=
 =?utf-8?B?Sm92R21ocEM0Y0VVaFJpVWhSdkh0cDBueWhQaTZMWGJQd3hQU3RXOWJaUE9a?=
 =?utf-8?B?TUVRd0tQak5IY2J1REpVeU9kd09OcmgvdDZNY0dpdGI1TldQMGVvUDh1aVIv?=
 =?utf-8?B?VTNKQkZwSDZqRjAxcFJiMXRwc0lZeTdQTzlLTVJIblZDa3pQUERwbzBWc1Nk?=
 =?utf-8?B?UXEvOU5iRWJhRkpIeVdMQVlTUTdIdmxUVVNpZjFPT0RXYWRHSFdHK0lYUlRt?=
 =?utf-8?B?bkpXMC9uVjI2UTdzSUhHbWs5eDBEK2JTZy95SVowQjd4NU5zcTZxYnJYK1l6?=
 =?utf-8?B?VFloVk8yQzlLNm1IUFVEQnhKNWFUQm12OXp6SG5Jay92elRra3VIU1puNm1X?=
 =?utf-8?B?S2NMWmcycXA5QmVIdHFlakp0aTFXY21rdEFQSkMxenRFTFFFMjhkbEp0Q0ho?=
 =?utf-8?B?U0d3OUVRKzZqS3J3NUtacXk5T0hTakxJdEV0SGFkUHdkdklaMjdRVUZueVZY?=
 =?utf-8?B?UGhiNFNJVnY2a0hhQ3ZLd0Z0VG5DeFFDRVF2OGVHaS92b1FUOU5MV29uaEdl?=
 =?utf-8?B?dExTaUE4VDQwdXg2RWdTalVvaVZHUXJMejRua0hNUldlSXRLbG1HU2pZZktR?=
 =?utf-8?B?MFBpNVBhT2JEeWVvZkhQb2J4M0hJUkNsYTRYNW03ZWRQajc1dnlvYkliWnIy?=
 =?utf-8?B?ZTAvYjVRUXh4ZTdJa0hrZlJhZmYvSnl0WXNNa0VGa3lab2YzVGRoekk3QjVz?=
 =?utf-8?B?S2o3NWR6ZzVlU0tPWXRFZXBmOWcvZEpEV3JnalpJOVNUU0NadE1ZLzN5MUpv?=
 =?utf-8?B?aFlPSFlBMm9pcW82R0c4YlNZeW8wYjRmT3dqQ0pBbTFTNk5vNVhVU0tmWU1p?=
 =?utf-8?B?dnNnb1dFU1J3Ky95ZXA2U20rSWIvc3ltQUhMbUZKSGtYMzRsZHJyRTNDQ290?=
 =?utf-8?B?eHlTbTF6TENBOGRQQ042K2tTRjgybytHT1d2NW52OFVqMVlKZzNuUG03YjlM?=
 =?utf-8?B?ck9rSzZPWWZVZjIwdGRaSEJIeDUxNWRyMEIvY3MxUmlwbHROZ1kyTk1UWWdm?=
 =?utf-8?B?cWVrT3Q5anlHS1VpcTY5SzA2UWpiRTk2bVliZjVNdmp5dGg4RUR0cTRRaGVU?=
 =?utf-8?B?bGVockNndHVja3dldUhEbFNaV1ZrVWJOUEtSUWFyT0JMN0dNZHI3S0hIZzAw?=
 =?utf-8?B?ZmROeUFJWDVna2Rvc1oyLzRiM0JrYU1mdEVUWFJoSmkvZFhFTnJ1NUp1aE1Q?=
 =?utf-8?B?eVFsZWRsdFV2czdiYWwzVmhoSFRlM3puNnFhR3FReDlmWWp6Uk1yV2JPUnNI?=
 =?utf-8?B?ZUtsU1djaktNVTFNQzRUWHpDU1hSb3pRWWN5SkRKSll6N0ZGczh4M2ZhdnhT?=
 =?utf-8?B?YThuVVFlWWdDWnloODl6ZDhha3dKZ012dmJFd2lCVEJLeWpNTFA5NXQ0ZE5O?=
 =?utf-8?B?Nnl4Rm03OWpqY1A4TDNDWlhOMUZTb1BNWEtmRkRYOEkrVGxwNnlkM0xrNTJI?=
 =?utf-8?B?cHJaSDlMdVJvZDdPQ0dORVZlUFN4MzRTSmFla0cxQnQ3RVIzc25zS0ZOY0N0?=
 =?utf-8?B?ZDVBWnc1NG5yc21EOTNwUW96R3RMZjdHUjN5Q1FRZXF2cnNWWG5XV3JCR1dZ?=
 =?utf-8?B?UGdvZEZJMVRTRXNpRVlkZGlCd3FvQ2NlMXB2NlBvaUU0bGVpdUJDdzVPajhI?=
 =?utf-8?B?ejBpaG91bW45WnRzaSt4Rktoa1oxY2VCbnJNMDZtZkpxak9jNXAza2dUaFJL?=
 =?utf-8?B?NFpqZFp1Y2xJUXZ0MlA2cWpldUlDeGlLOE54S1dLT3I1c0hlOHdDQ2hYa0hH?=
 =?utf-8?B?NlZ6VlFyQVdoR1ZHVXNjV2tqdk93Nzd3cGVzYVMwTzl2clJFQmxxbUk5a095?=
 =?utf-8?B?ZUQyZEl1MUhpSHkyVXBFamVFU2FxamQ1SktzK1FyMXg2YVRtNFJ5OWZ4YjF6?=
 =?utf-8?B?b0hlMlNwRExVUzdHbEJtdFdzWGEvS25nczZYemZHVG5VdDRzK3FsK1V6RG5m?=
 =?utf-8?B?K2VPV3hBTjFGZ0NRWWg0dmwxTEh0L0VPM1R4TzJaK3gvUG5aWjdtZUcwOVYx?=
 =?utf-8?B?VnZ6REZveVU3ck1wNXc3alV5eEhHeHVaVk9UdXd6OWIvY2o5VGtmMlg2d2hl?=
 =?utf-8?Q?Cg4sFUxzY4nQX0RDo3B8qpinI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d156e65-c56b-49be-725f-08dc2bb706aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2024 10:40:27.0040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EjIK6TLjQyDK7Ew9Aib4tn43uE0njwYxlIW6D/g4uHHq6K3xwYcvwwe0655zk3hvEi9SgyBWCUDpEx+NTUvTi3GNmf9txL/dqxpr/ymvYGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7042
X-OriginatorOrg: intel.com

PiBUaGlzIHNlcmllcyBhZGRzIFNFVi1TTlAgc3VwcG9ydCBmb3IgcnVubmluZyBMaW51eCB1bmRl
ciBhbiBTZWN1cmUgVk0NCj4gU2VydmljZSBNb2R1bGUgKFNWU00pIGF0IGEgbGVzcyBwcml2aWxl
Z2VkIFZNIFByaXZpbGVnZSBMZXZlbCAoVk1QTCkuDQo+IEJ5IHJ1bm5pbmcgYXQgYSBsZXNzIHBy
aXZpbGVkZ2VkIFZNUEwsIHRoZSBTVlNNIGNhbiBiZSB1c2VkIHRvIHByb3ZpZGUNCj4gc2Vydmlj
ZXMsIGUuZy4gYSB2aXJ0dWFsIFRQTSwgZm9yIExpbnV4IHdpdGhpbiB0aGUgU0VWLVNOUCBjb25m
aWRlbnRpYWwNCj4gVk0gKENWTSkgcmF0aGVyIHRoYW4gdHJ1c3Qgc3VjaCBzZXJ2aWNlcyBmcm9t
IHRoZSBoeXBlcnZpc29yLg0KPiANCj4gQ3VycmVudGx5LCBhIExpbnV4IGd1ZXN0IGV4cGVjdHMg
dG8gcnVuIGF0IHRoZSBoaWdoZXN0IFZNUEwsIFZNUEwwLCBhbmQNCj4gdGhlcmUgYXJlIGNlcnRh
aW4gU05QIHJlbGF0ZWQgb3BlcmF0aW9ucyB0aGF0IHJlcXVpcmUgdGhhdCBWTVBMIGxldmVsLg0K
PiBTcGVjaWZpY2FsbHksIHRoZSBQVkFMSURBVEUgaW5zdHJ1Y3Rpb24gYW5kIHRoZSBSTVBBREpV
U1QgaW5zdHJ1Y3Rpb24NCj4gd2hlbiBzZXR0aW5nIHRoZSBWTVNBIGF0dHJpYnV0ZSBvZiBhIHBh
Z2UgKHVzZWQgd2hlbiBzdGFydGluZyBBUHMpLg0KPiANCj4gSWYgTGludXggaXMgdG8gcnVuIGF0
IGEgbGVzcyBwcml2aWxlZ2VkIFZNUEwsIGUuZy4gVk1QTDIsIHRoZW4gaXQgbXVzdA0KPiB1c2Ug
YW4gU1ZTTSAod2hpY2ggaXMgcnVubmluZyBhdCBWTVBMMCkgdG8gcGVyZm9ybSB0aGUgb3BlcmF0
aW9ucyB0aGF0DQo+IGl0IGlzIG5vIGxvbmdlciBhYmxlIHRvIHBlcmZvcm0uDQo+IA0KPiBIb3cg
TGludXggaW50ZXJhY3RzIHdpdGggYW5kIHVzZXMgdGhlIFNWU00gaXMgZG9jdW1lbnRlZCBpbiB0
aGUgU1ZTTQ0KPiBzcGVjaWZpY2F0aW9uIFsxXSBhbmQgdGhlIEdIQ0Igc3BlY2lmaWNhdGlvbiBb
Ml0uDQo+IA0KPiBUaGlzIHNlcmllcyBpbnRyb2R1Y2VzIHN1cHBvcnQgdG8gcnVuIExpbnV4IHVu
ZGVyIGFuIFNWU00uIEl0IGNvbnNpc3RzDQo+IG9mOg0KPiAgIC0gRGV0ZWN0aW5nIHRoZSBwcmVz
ZW5jZSBvZiBhbiBTVlNNDQo+ICAgLSBXaGVuIG5vdCBydW5uaW5nIGF0IFZNUEwwLCBpbnZva2lu
ZyB0aGUgU1ZTTSBmb3IgcGFnZSB2YWxpZGF0aW9uIGFuZA0KPiAgICAgVk1TQSBwYWdlIGNyZWF0
aW9uL2RlbGV0aW9uDQo+ICAgLSBBZGRpbmcgYSBzeXNmcyBlbnRyeSB0aGF0IHNwZWNpZmllcyB0
aGUgTGludXggVk1QTA0KPiAgIC0gTW9kaWZ5aW5nIHRoZSBzZXYtZ3Vlc3QgZHJpdmVyIHRvIHVz
ZSB0aGUgVk1QQ0sga2V5IGFzc29jaWF0ZWQgd2l0aA0KPiAgICAgdGhlIExpbnV4IFZNUEwNCj4g
ICAtIEV4cGFuZGluZyB0aGUgY29uZmlnLWZzIFRTTSBzdXBwb3J0IHRvIHJlcXVlc3QgYXR0ZXN0
YXRpb24gcmVwb3J0cw0KPiAgICAgZnJvbSB0aGUgU1ZTTQ0KPiAgIC0gRGV0ZWN0aW5nIGFuZCBh
bGxvd2luZyBMaW51eCB0byBydW4gaW4gYSBWTVBMIG90aGVyIHRoYW4gMCB3aGVuIGFuDQo+ICAg
ICBTVlNNIGlzIHByZXNlbnQNCg0KSGkgVG9tIGFuZCBldmVyeW9uZSwgDQoNClRoaXMgcGF0Y2gg
c2V0IGltbyBpcyBhIGdvb2Qgb3Bwb3J0dW5pdHkgdG8gc3RhcnQgYSB3aWRlciBkaXNjdXNzaW9u
IG9uIA0KU1ZTTS1zdHlsZSBjb25maWRlbnRpYWwgZ3Vlc3RzIHRoYXQgd2UgYWN0dWFsbHkgd2Fu
dGVkIHRvIHN0YXJ0IGFueWhvdw0KYmVjYXVzZSBURFggd2lsbCBuZWVkIHNtdGggc2ltaWxhciBp
biB0aGUgZnV0dXJlLg0KU28gbGV0IG1lIGV4cGxhaW4gb3VyIHRoaW5raW5nIGFuZCB0cnkgdG8g
YWxpZ24gdG9nZXRoZXIgaGVyZS4gDQoNCkluIGFkZGl0aW9uIHRvIGFuIGV4aXN0aW5nIG5vdGlv
biBvZiBhIENvbmZpZGVudGlhbCBDb21wdXRpbmcgKENvQ28pIGd1ZXN0DQpib3RoIEludGVsIGFu
ZCBBTUQgZGVmaW5lIGEgY29uY2VwdCB0aGF0IGEgQ29DbyBndWVzdCBjYW4gYmUgZnVydGhlcg0K
c3ViZGl2aWRlZC9wYXJ0aXRpb25lZCBpbnRvIGRpZmZlcmVudCBTVyBsYXllcnMgcnVubmluZyB3
aXRoIGRpZmZlcmVudA0KcHJpdmlsZWdlcy4gSW4gdGhlIEFNRCBTZWN1cmUgRW5jcnlwdGVkIFZp
cnR1YWxpemF0aW9uIHdpdGggU2VjdXJlIE5lc3RlZA0KUGFnaW5nIChTRVYtU05QKSBhcmNoaXRl
Y3R1cmUgdGhpcyBpcyBjYWxsZWQgVk0gUGVybWlzc2lvbiBMZXZlbHMgKFZNUExzKQ0KYW5kIGlu
IHRoZSBJbnRlbCBUcnVzdCBEb21haW4gRXh0ZW5zaW9ucyAoVERYKSBhcmNoaXRlY3R1cmUgaXQg
aXMgY2FsbGVkDQpURFggUGFydGl0aW9uaW5nLiBUaGUgbW9zdCBwcml2aWxlZ2VkIHBhcnQgb2Yg
YSBDb0NvIGd1ZXN0IGlzIHJlZmVycmVkIGFzDQpydW5uaW5nIGF0IFZNUEwwIGZvciBBTUQgU0VW
LVNOUCBhbmQgYXMgTDEgZm9yIEludGVsIFREWCBQYXJ0aXRpb25pbmcuDQpUaGlzIHByaXZpbGVn
ZSBsZXZlbCBoYXMgZnVsbCBjb250cm9sIG92ZXIgdGhlIG90aGVyIGNvbXBvbmVudHMgcnVubmlu
Zw0KaW5zaWRlIGEgQ29DbyBndWVzdCwgYXMgd2VsbCBhcyBzb21lIG9wZXJhdGlvbnMgYXJlIG9u
bHkgYWxsb3dlZCB0byBiZQ0KZXhlY3V0ZWQgYnkgdGhlIFNXIHJ1bm5pbmcgYXQgdGhpcyBwcml2
aWxlZ2UgbGV2ZWwuIFRoZSBhc3N1bXB0aW9uIGlzIHRoYXQNCnRoaXMgbGV2ZWwgaXMgdXNlZCBm
b3IgYSBWaXJ0dWFsIE1hY2hpbmUgTW9uaXRvciAoVk1NKS9IeXBlcnZpc29yIGxpa2UgS1ZNDQph
bmQgb3RoZXJzIG9yIGEgbGlnaHR3ZWlnaHQgU2VydmljZSBNYW5hZ2VyIChTTSkgbGlrZSBjb2Nv
bnV0LVNWU00gWzNdLg0KVGhlIGFjdHVhbCB3b3JrbG9hZCBWTSAodG9nZXRoZXIgd2l0aCBpdHMg
T1MpIGlzIGV4cGVjdGVkIHRvIGJlIHJ1biBpbiBhDQpkaWZmZXJlbnQgcHJpdmlsZWdlIGxldmVs
ICghVk1QTDAgaW4gQU1EIGNhc2UgYW5kIEwyIGxheWVyIGluIEludGVsIGNhc2UpLg0KQm90aCBh
cmNoaXRlY3R1cmVzIGluIG91ciBjdXJyZW50IHVuZGVyc3RhbmRpbmcgKHBsZWFzZSBjb3JyZWN0
IGlmIHRoaXMgaXMNCm5vdCB0cnVlIGZvciBBTUQpIGFsbG93IGZvciBkaWZmZXJlbnQgd29ya2xv
YWQgVk0gb3B0aW9ucyBzdGFydGluZyBmcm9tDQphIGZ1bGx5IHVubW9kaWZpZWQgbGVnYWN5IE9T
IHRvIGEgZnVsbHkgZW5hYmxlZC9lbmxpZ2h0ZW5lZCBBTUQgU0VWLVNOUC8NCkludGVsIFREWCBn
dWVzdCBhbmQgYW55dGhpbmcgaW4gYmV0d2Vlbi4gSG93ZXZlciwgZWFjaCB3b3JrbG9hZCBndWVz
dA0Kb3B0aW9uIHJlcXVpcmVzIGEgZGlmZmVyZW50IGxldmVsIG9mIGltcGxlbWVudGF0aW9uIHN1
cHBvcnQgZnJvbSB0aGUgbW9zdA0KcHJpdmlsZWdlZCBWTVBMMC9MMSBsYXllciBhcyB3ZWxsIGFz
IGZyb20gdGhlIHdvcmtsb2FkIE9TIGl0c2VsZiAocnVubmluZw0KYXQgIVZNUEwwL0wyKSBhbmQg
YWxzbyBoYXMgZGlmZmVyZW50IGVmZmVjdHMgb24gb3ZlcmFsbCBwZXJmb3JtYW5jZSBhbmQNCm90
aGVyIGZhY3RvcnMuIExpbnV4IGFzIGJlaW5nIG9uZSBvZiB0aGUgd29ya2xvYWQgT1NlcyBjdXJy
ZW50bHkgZG9lc27igJl0DQpkZWZpbmUgYSBjb21tb24gbm90aW9uIG9yIGludGVyZmFjZXMgZm9y
IHN1Y2ggc3BlY2lhbCB0eXBlIG9mIENvQ28gZ3Vlc3RzDQphbmQgdGhlcmUgaXMgYSByaXNrIHRo
YXQgZWFjaCB2ZW5kb3IgY2FuIGR1cGxpY2F0ZSBhIGxvdCBvZiBjb21tb24gY29uY2VwdHMNCmlu
c2lkZSBBRE0gU0VWLVNOUCBvciBJbnRlbCBURFggc3BlY2lmaWMgY29kZS4gVGhpcyBpcyBub3Qg
dGhlIGFwcHJvYWNoDQpMaW51eCB1c3VhbGx5IHByZWZlcnMgYW5kIHRoZSB2ZW5kb3IgYWdub3N0
aWMgc29sdXRpb24gc2hvdWxkIGJlIGV4cGxvcmVkIGZpcnN0LiAgDQoNClNvIHRoaXMgaXMgYW4g
YXR0ZW1wdCB0byBzdGFydCBhIGpvaW50IGRpc2N1c3Npb24gb24gaG93L3doYXQvaWYgd2UgY2Fu
IHVuaWZ5DQppbiB0aGlzIHNwYWNlIGFuZCBmb2xsb3dpbmcgdGhlIHJlY2VudCBsa21sIHRocmVh
ZCBbMV0sIGl0IHNlZW1zIHdlIG5lZWQNCnRvIGZpcnN0IGNsYXJpZnkgaG93IHdlIHNlZSB0aGlz
IHNwZWNpYWwgICFWTVBMMC9MMiBndWVzdCBhbmQgd2hlbmV2ZXIgd2UNCmNhbiBvciBuZWVkIHRv
IGRlZmluZSBhIGNvbW1vbiBub3Rpb24gZm9yIGl0LiANClRoZSBmb2xsb3dpbmcgb3B0aW9ucyBh
cmUgKnRoZW9yZXRpY2FsbHkqIHBvc3NpYmxlOg0KDQoxLiBLZWVwIHRoZSAhVk1QTDAvTDIgZ3Vl
c3QgYXMgdW5tb2RpZmllZCBBTUQgU0VWLVNOUC9JbnRlbCBURFggZ3Vlc3QNCmFuZCBoaWRlIGFs
bCBjb21wbGV4aXR5IGluc2lkZSBWTVBMMC9MMSBWTU0gYW5kL29yIHJlc3BlY3RlZCBJbnRlbC9B
TUQNCmFyY2hpdGVjdHVyZSBpbnRlcm5hbCBjb21wb25lbnRzLiBUaGlzIGxpa2VseSBjcmVhdGVz
IGFkZGl0aW9uYWwgY29tcGxleGl0eQ0KaW4gdGhlIGltcGxlbWVudGF0aW9uIG9mIFZNUEwwL0wx
IGxheWVyIGNvbXBhcmVkIHRvIG90aGVyIG9wdGlvbnMgYmVsb3cuDQpUaGlzIG9wdGlvbiBhbHNv
IGRvZXNu4oCZdCBhbGxvdyBzZXJ2aWNlIHByb3ZpZGVycyB0byB1bmlmeSB0aGVpciBpbnRlcmZh
Y2VzDQpiZXR3ZWVuIEFNRC9JbnRlbCBzb2x1dGlvbnMsIGJ1dCByZXF1aXJlcyB0aGVpciBWTVBM
MC9MMSBsYXllciB0byBoYW5kbGUNCmRpZmZlcmVuY2VzIGJldHdlZW4gdGhlc2UgZ3Vlc3RzLiBP
biBhIHBsdXMgc2lkZSB0aGlzIG9wdGlvbiByZXF1aXJlcyBubw0KY2hhbmdlcyBpbiBleGlzdGlu
ZyBBTUQgU0VWLVNOUC9JbnRlbCBURFggTGludXggZ3Vlc3QgY29kZSB0byBzdXBwb3J0DQohVk1Q
TDAvTDIgZ3Vlc3QuIFRoZSBiaWcgb3BlbiBxdWVzdGlvbiB3ZSBoYXZlIGhlcmUgdG8gQU1EIGZv
bGtzIGlzDQp3aGVuZXZlciBpdCBpcyBhcmNoaXRlY3R1cmFsbHkgZmVhc2libGUgZm9yIHlvdSB0
byBzdXBwb3J0IHRoaXMgY2FzZT8gIA0KDQoyLiBLZWVwIGl0IGFzIEludGVsIFREWC9BTUQgU0VW
LVNOUCBndWVzdCB3aXRoIHNvbWUgTGludXggZ3Vlc3QgaW50ZXJuYWwNCmNvZGUgbG9naWMgdG8g
aGFuZGxlIHdoZW5ldmVyIGl0IHJ1bnMgaW4gTDEgdnMgTDIvVk1QTDAgdnMgIVZNUEwwLg0KVGhp
cyBpcyBlc3NlbnRpYWxseSB3aGF0IHRoaXMgcGF0Y2ggc2VyaWVzIGlzIGRvaW5nIGZvciBBTUQu
IA0KVGhpcyBvcHRpb24gcG90ZW50aWFsbHkgY3JlYXRlcyBtYW55IGlmIHN0YXRlbWVudHMgaW5z
aWRlIHJlc3BlY3RlZCBMaW51eA0KaW1wbGVtZW50YXRpb24gb2YgdGhlc2UgdGVjaG5vbG9naWVz
IHRvIGhhbmRsZSB0aGUgZGlmZmVyZW5jZXMsIGNvbXBsaWNhdGVzDQp0aGUgY29kZSwgYW5kIGRv
ZXNu4oCZdCBhbGxvdyBzZXJ2aWNlIHByb3ZpZGVycyB0byB1bmlmeSB0aGVpciBMMS9WTVBMMCBj
b2RlLg0KVGhpcyBvcHRpb24gd2FzIGFsc28gcHJldmlvdXNseSBwcm9wb3NlZCBmb3IgSW50ZWwg
VERYIGluIHRoaXMgbGttbCB0aHJlYWQgWzFdDQphbmQgZ290IGEgbmVnYXRpdmUgaW5pdGlhbCBy
ZWNlcHRpb24uIA0KDQozLiBLZWVwIGl0IGFzIGEgbGVnYWN5IG5vbi1Db0NvIGd1ZXN0LiBUaGlz
IG9wdGlvbiBpcyB2ZXJ5IGJhZCBmcm9tDQpwZXJmb3JtYW5jZSBwb2ludCBvZiB2aWV3IHNpbmNl
IGFsbCBJL08gbXVzdCBiZSBkb25lIHZpYSBWTVBMMC9MMSBsYXllcg0KYW5kIGl0IGlzIGNvbnNp
ZGVyZWQgaW5mZWFzaWJsZS91bmFjY2VwdGFibGUgYnkgc2VydmljZSBwcm92aWRlcnMNCihwZXJm
b3JtYW5jZSBvZiBuZXR3b3JraW5nIGFuZCBkaXNrIGlzIGhvcnJpYmxlKS4gIEl0IGFsc28gcmVx
dWlyZXMgYW4NCmV4dGVuc2l2ZSBpbXBsZW1lbnRhdGlvbiBpbiBWTVBMMC9MMSBsYXllciB0byBz
dXBwb3J0IGVtdWxhdGlvbiBvZiBhbGwgZGV2aWNlcy4gICANCg0KNC4gRGVmaW5lIGEgbmV3IGd1
ZXN0IGFic3RyYWN0aW9uL2d1ZXN0IHR5cGUgdGhhdCB3b3VsZCBiZSB1c2VkIGZvcg0KIVZNUEww
L0wyIGd1ZXN0LiBUaGlzIGFsbG93cyBpbiB0aGUgZnV0dXJlIHRvIGRlZmluZSBhIHVuaWZpZWQg
TDIgPC0+IEwxL1ZNUEwhMA0KPC0+IFZNUEwwIGNvbW11bmljYXRpb24gaW50ZXJmYWNlIHRoYXQg
dW5kZXJuZWF0aCB3b3VsZCB1c2UgSW50ZWwNClREWC9BTUQgU0VWLVNOUCBzcGVjaWZpZWQgY29t
bXVuaWNhdGlvbiBwcmltaXRpdmVzLiBPdXQgb2YgZXhpc3RpbmcgTGludXggY29kZSwNCnRoaXMg
YXBwcm9hY2ggaXMgZm9sbG93ZWQgdG8gc29tZSBpbml0aWFsIGRlZ3JlZSBieSBNU0ZUIEh5cGVy
LVYgaW1wbGVtZW50YXRpb24gWzJdLg0KSXQgZGVmaW5lcyBhIG5ldyB0eXBlIG9mIHZpcnR1YWxp
emVkIGd1ZXN0IHdpdGggaXRzIG93biBpbml0aWFsaXphdGlvbiBwYXRoIGFuZCBjYWxsYmFja3Mg
aW4NCiB4ODZfcGxhdGZvcm0uZ3Vlc3QvaHlwZXIuKi4gSG93ZXZlciwgaW4gb3VyIHVuZGVyc3Rh
bmRpbmcgbm9vbmUgaGFzIHlldA0KYXR0ZW1wdGVkIHRvIGRlZmluZSBhIHVuaWZpZWQgYWJzdHJh
Y3Rpb24gZm9yIHN1Y2ggZ3Vlc3QsIGFzIHdlbGwgYXMgdW5pZmllZCBpbnRlcmZhY2UuDQpBTUQg
U0VWLVNOUCBoYXMgZGVmaW5lZCBpbiBbNF0gYSBWTVBMMCA8LS0+ICFWTVBMMCBjb21tdW5pY2F0
aW9uIGludGVyZmFjZQ0KIHdoaWNoIGlzIEFNRCBzcGVjaWZpYy4gIA0KDQo1LiBBbnl0aGluZyBl
bHNlIGlzIG1pc3Npbmc/ICANCg0KUmVmZXJlbmNlczoNCg0KWzFdIGh0dHBzOi8vbGttbC5vcmcv
bGttbC8yMDIzLzExLzIyLzEwODkgDQoNClsyXSBNU0ZUIGh5cGVyLXYgaW1wbGVtZW50YXRpb24g
b2YgQU1EIFNFVi1TTlAgIVZNUEwwIGd1ZXN0IGFuZCBURFggTDINCnBhcnRpdGlvbmluZyBndWVz
dDoNCmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L2xhdGVzdC9zb3VyY2UvYXJjaC94
ODYvaHlwZXJ2L2l2bS5jI0w1NzUgDQoNClszXSBodHRwczovL2dpdGh1Yi5jb20vY29jb251dC1z
dnNtL3N2c20gIA0KDQpbNF0gaHR0cHM6Ly93d3cuYW1kLmNvbS9jb250ZW50L2RhbS9hbWQvZW4v
ZG9jdW1lbnRzL2VweWMtdGVjaG5pY2FsLWRvY3Mvc3BlY2lmaWNhdGlvbnMvNTgwMTkucGRmICAN
Cg0KDQo=


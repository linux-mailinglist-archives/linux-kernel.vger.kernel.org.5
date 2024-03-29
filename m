Return-Path: <linux-kernel+bounces-125392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9466889254B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ED4C1F23DCA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B3838FA5;
	Fri, 29 Mar 2024 20:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Vlmwz0fK"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11024022.outbound.protection.outlook.com [52.101.61.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7251119F;
	Fri, 29 Mar 2024 20:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711744235; cv=fail; b=GDzU4MvlHuughD008EaBb4ArdmPSxvrw7lehhP4Ncrz1fV/5qz45MP6ygToUjWmIvwe98xVVErb8OqCTWIqixJRHMh1j2mgE2kWJZB+vae7XvO0Kf4jtQStQ9cSV7sb4ZnqhSkKFcjJpmSuK07VYx9xdj/jf39OF9cJmFScyXAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711744235; c=relaxed/simple;
	bh=SWefshFct54xFJD/iH0Dx6/CawPkEeCNsirAqclfn4Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FQ1CAalUxft7s1no1Q/FdVvIrqDcTpcKm3pasmlJn5RFR2rtgt7vp9+ykHw1Z0EmUEvtZFgsN/47vcyXGykgxwYpKanBioUhpw+ejXHXNBe2sPxOge4XHljxLBzaeKsxGi8rvbmU7QrEsr9kADqZDMg+Lmyow0mtfWGrSUvS/9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Vlmwz0fK; arc=fail smtp.client-ip=52.101.61.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gp6k/LsymeJXS/W3+/YC5+vbobyboQq61fJ/4bdbNKJfhh+c4bKgymWng3wj8slQSAGqVJExgCD1wfI3ZFolfStDuNwbWDMbkPiD6kJFr2L8HgeGm9Rc9fqHy6jaizd0nNIQ4pvL1/FIRDEUy84mYxvCzqU47EeNaO9n9AQpq8oGqv+paZ+C2mLEMX7KLmCwDGyBcO7jI2OizvOt05VcSHxfxStHzM2t0cV/Ux3waEIY39gnyS9G5awwg/aQnhIho3cTJoLdXiCqAlrB/MRIsIN/8Ds5jDv8+Lgo1U8BybhzINyvrdl7sfkDfPRQPV37APnG9woFuX1ZrTfsJvWijQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWefshFct54xFJD/iH0Dx6/CawPkEeCNsirAqclfn4Y=;
 b=MzyThPycBW9Ipyc0VWsTRoF+PmU0eHtW9Pnnl5gghgcK60joX2jTplKkcc3CZFK2fUjj8mcnfRUuB2DQdSHHXQHYp8G+xbKY3RTzqu80xtcwl7AekPK2sNirIXcSXfv4s9wrZP8i8nfovIXXtmnjAXkB3f1LM7rf7sWvYmCRV6ti/eLDvy2WGeLH5/vEmRN4gbdSho8tWaH09oa6pycpxJrzfY5LRVvYNbP/93UrJpgqAI0TqvYhht6XeshlkApKOQwrx0V3wVp35FVBlYuYH5hjsDY7rYk9Yq/N1MzxnJcvtBLM8RzAJ0czGWlYzbhNHvCpGki4xcw5UANU+jl4jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWefshFct54xFJD/iH0Dx6/CawPkEeCNsirAqclfn4Y=;
 b=Vlmwz0fKSRCNDLEEiuqEMPVC1+mOyonpyeXtacJXHW5kS8GlwCBVvEzMjq6Fee6kzpwNon068XfiA0/zpfyiYV63tIPlaraLUpK/If1PITvTTPODM2feV7LB5Gqh836ZcaaYMPxSdF8PtqcQVjpTPi5usq+kBoY1lm3RP3emqak=
Received: from CY5PR21MB3759.namprd21.prod.outlook.com (2603:10b6:930:c::10)
 by PH0PR21MB2079.namprd21.prod.outlook.com (2603:10b6:510:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.17; Fri, 29 Mar
 2024 20:30:31 +0000
Received: from CY5PR21MB3759.namprd21.prod.outlook.com
 ([fe80::1c76:5d37:cef1:f135]) by CY5PR21MB3759.namprd21.prod.outlook.com
 ([fe80::1c76:5d37:cef1:f135%5]) with mapi id 15.20.7452.001; Fri, 29 Mar 2024
 20:30:30 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>, "hch@lst.de"
	<hch@lst.de>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "zhangpeng362@huawei.com"
	<zhangpeng362@huawei.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"mhklinux@outlook.com" <mhklinux@outlook.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] swiotlb: Do not set total_used to 0 in
 swiotlb_create_debugfs_files()
Thread-Topic: [PATCH] swiotlb: Do not set total_used to 0 in
 swiotlb_create_debugfs_files()
Thread-Index: AQHaghHPup60+Vul2EyICRlEmMkd0LFPJ6JggAACmpA=
Date: Fri, 29 Mar 2024 20:30:30 +0000
Message-ID:
 <CY5PR21MB3759C7C9F4637F6D157635A1BF3A2@CY5PR21MB3759.namprd21.prod.outlook.com>
References: <20240329192809.17318-1-decui@microsoft.com>
 <07ed50c1-75a9-494c-8a6a-5edcc2d6f932@linux.microsoft.com>
 <CY5PR21MB3759BEE344CCD8F20FBB4E4CBF3A2@CY5PR21MB3759.namprd21.prod.outlook.com>
In-Reply-To:
 <CY5PR21MB3759BEE344CCD8F20FBB4E4CBF3A2@CY5PR21MB3759.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f62ef308-7ef8-4c3c-bba0-bb7106167ec4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-03-29T20:15:47Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR21MB3759:EE_|PH0PR21MB2079:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ZOkhUj5bTDK2dSeGYbXHSowvUO13M3+ta/i4Q5//H9mZRXPepGYhZQcSm1OcutDZ7h6P/1oNHa9nztW4fbVLecPRp9DMl3suHcgI+U7x3J82j142rw1FLL4USHwmW/COShThDVk4ur9dWJKX072wY91Hm8hshtvHyl8xeE297/QigdM6wuk7HmRPXProZjEVzMV8MGjSM9RLe/cBc41Kjs7TidNiYn/4uyOs+Z6eNxSxmxUvuPdn/yphoVvMOjCgXpEwKYEvITA3vn3rWTukDrEUyRrU4Y/ota+VIm62pGycLGTi0uYISg4TOR+edhVyZGHSCjf6frQGqeKOPC1ySoBqJyuwEzfCO/V4tRFoIjhELkpBAqSTxFUNWu3Sii2Zhcp1l3wItveKqlvAPvTBxdeaqFrNXeQR7KUbAv0Dc2Wrui4wm/RRvBQcCYZkxDuwcVcgDUDW4DUkJz+6QoPV2cszGoJkUdUwOdTAMaJVLOg4WEI7+uxefW+82J7U/VdYv+UJLRuPLqJNTIUn1A5SRhMnx250PoMMm48ToicnVvOcgzsJBHISmICQmKuzZS7bEn5cLMRv63sIzCHzxiVBmOHqiletrr8nfoLoxevjhYSUDDzhMvN15iW7aHNklI5eb/JQJ+rXcrv4B+3lrTWS+BW/fZkkoybOC7GjH3xpuss=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR21MB3759.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d1hiUGlFeTloeXJ1U3FnSkc2clhuRmRRRk9oeDBGanJ5RVplcVJ6czlYTW5I?=
 =?utf-8?B?UEpyUXc3bDZ1b3JYTW9FUzJzOEc4dVkycnJ0L0dvZCtLRVM0MkNvb0lPVWFV?=
 =?utf-8?B?Y2lCNTZNazRwRlA3WFp0NTBtcDEyL04yVnJNK1hGZGNHRHBNUTNVWWdFSjJk?=
 =?utf-8?B?c1NSMFU0UlNJTXVYSkJnRUR1TnR2d0dUalFDazRzMEV0TWZkWDRnUmpLNFN6?=
 =?utf-8?B?Qk9lUm81em5oUUIramQzY05aRlZDVkJaUHBwWnAxZWhaOEJoNlVpQnlvajJY?=
 =?utf-8?B?eThkR04yQkVQOVJZUkZ3eUh0ZWV4ODBjY3ZXUFg1RnRBWFpOMlJEVXVpdFlD?=
 =?utf-8?B?UmRNVDBZSnZqakNUWnNxMEdIS1pRNkNBbjMwUjB3bWtNbDdqMTF1dzBwZTd3?=
 =?utf-8?B?REFkWU81UFBWUlRwMC9ObVV6ZFY1N3pvdjlPRjRXd2VwODQ3YURGb3ZoMG5s?=
 =?utf-8?B?d2lodlFaOURjMlBnd0NyR0MxcXd4ait2TmJ1djlsK2V5d3N3cTdZaEV4eWwx?=
 =?utf-8?B?MGEzNnZnV3VCM3lIeUNUNWFuTjE4YmlxMmhneW1yME8va0xLVGtZdUpob3J4?=
 =?utf-8?B?azNSMTJLeWhSWGh1U01mcGZSdTg3YzVYcnlKTjFSTVROdnI2SWFoNG5zZU1K?=
 =?utf-8?B?V3I1VGM1MzFaajF5NXQ4amxpd1ArMU10Q2ZDZEErNDAreEVkWC9tOXM1ZnpL?=
 =?utf-8?B?M3ZuOE92UmVRM1dQRXlZYURwMDlOWjZWV0dGWEk3SGttRGhDVmJwMHZnd0VY?=
 =?utf-8?B?TzA4N21rOFgya3pvaldpazBXRysrRGRQTHlhTUlBak8xbS9YTVg1dGtjRmxW?=
 =?utf-8?B?VTZ4OWZ6RTlKZDRHK0JkWTh4TnBGSUJDWDNhNGtFNzFlV3p0cFpPc3VBMndX?=
 =?utf-8?B?RlZpVEVhaXd1K1oyMUw4S1BPT3BqcytVcTVka0VqNVRhamRGY3NEMEMwOFZl?=
 =?utf-8?B?M2UxNU93TTdpWXBVOWNPbzhiTVFzNTczTElnQ2Y1K1l3U0JDRVV2SDNSUGtq?=
 =?utf-8?B?bS93WGZ4UG5SUENvaGRZOGpidnBYc1FuYzhQeUljTElqbVFnZWl1ZTdwZTZP?=
 =?utf-8?B?UEp5YyszMWViN1h3ckpaeElnMlFsazB4c0NpNFpidWtUVVZveFdtNDk5bWpl?=
 =?utf-8?B?MFd4REMrdFRwakcvWkhMMFpoWUsyNGRwbE8rb0hodEdTa2x6bGZtMWxCMGtn?=
 =?utf-8?B?dFNwWEhiWnV1bFRFVW9Gd2d3YkF3a2d2dzZFbmNXTkZOenZZczlSckwwWVpH?=
 =?utf-8?B?clMyNEcwUTJGTW5kSnR6WTk2S0lnRitSR2g4U1FxNW1aLzRKeW1BZ2l0ZWtO?=
 =?utf-8?B?Z3NuSUxIV0dpZlkxZ2xramNvdFhEME5UdkhiSUhXTElOR25QaHNobXpScXZL?=
 =?utf-8?B?TFVvZ1BPeUF0MHIrMDNpVXNXRkxjbTRXaFpYZmE5TnBJVHp2c2JWS0FRWGdO?=
 =?utf-8?B?QkN5UHNFTU1RWi9tclpzZUhJa3YrMUhyWlVPbUluWlUrSkhuZVZ4ZjBGRVJS?=
 =?utf-8?B?Y1FOY2R2emlZRXNGOUgwbG4xR1hDZUFwWVlRWFc0N1dkaTdrOENSSGRYK0Zy?=
 =?utf-8?B?WGp0TVJMaytFVVBjcXhOTmp0SUJ5K08xSUg0bnVncWUyT2xaMXMza25Nbk9r?=
 =?utf-8?B?UnRhdnNHMVBVSFJWOHE5Ylo1L0J0bGt4T3lJVnNPN2xtZmw4NURiMXpyNjFO?=
 =?utf-8?B?N0YvcWpITHNUVzNER1NzSGpGaU1pQmhCRE56ZkN5Vzlya2ZoeUgxbEhISE5q?=
 =?utf-8?B?UW02bGd2SXQyc0RCRmk2Ym5VTDgyM2tmMDBFUzNraXZiMk5pK3FsWXFtWFd5?=
 =?utf-8?B?VG1DUFhPRGZ0V3FHcnh3RWRzU0ZCNUR4SWJPNVEyUXpPN3EvOHNxTjdqQ1Jy?=
 =?utf-8?B?SGZ4VHNsTHd1VjdMZ0NoWUpyaGNQMjZnZWMrenBreDlsR0JyaFdEZ1VodnFt?=
 =?utf-8?B?QnhwVnVDRzJKdU1SRTh6aEo2RmJRNE1CSlkyWnJZdTJrSDd5N3dHWiswQTVD?=
 =?utf-8?B?NnUwejhUcmR2S3RmMHgwcTZHWjZ2NFFpUy8vcUdxY0gzTVNhYlVIeWhFTTRq?=
 =?utf-8?B?eDZSQ2hCa0hTV3pRTW9hdXFZVjA3UWswcE50T2prd0I1OEVyR3BhbW1NWnJ6?=
 =?utf-8?B?RlgwSGxIRGttcWJCM2pLUTdCcVBSeU01OFNRc1k5RFYwRitzekJzUVhWaGVk?=
 =?utf-8?Q?NDusLId4JLsw6eHbr8q+WPA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR21MB3759.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1682ad3b-ce5c-4b61-f180-08dc502f13f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2024 20:30:30.7604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aleZ3OzunMwhjq1SZ2miNbEDX9ILoHLc8ePHhc57HduApEmR/J9o6PC3HgZ9A9lHRS8ONVx2tDm3aKOZxhlaZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB2079

PiBGcm9tOiBEZXh1YW4gQ3VpDQo+IFNlbnQ6IEZyaWRheSwgTWFyY2ggMjksIDIwMjQgMToyMyBQ
TQ0KPiBUbzogRWFzd2FyIEhhcmloYXJhbiA8ZWFoYXJpaGFAbGludXgubWljcm9zb2Z0LmNvbT47
IGhjaEBsc3QuZGU7DQo+IG0uc3p5cHJvd3NraUBzYW1zdW5nLmNvbTsgcm9iaW4ubXVycGh5QGFy
bS5jb207DQo+IHpoYW5ncGVuZzM2MkBodWF3ZWkuY29tOyBpb21tdUBsaXN0cy5saW51eC5kZXY7
DQo+IG1oa2xpbnV4QG91dGxvb2suY29tDQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0hdIHN3aW90
bGI6IERvIG5vdCBzZXQgdG90YWxfdXNlZCB0byAwIGluDQo+IHN3aW90bGJfY3JlYXRlX2RlYnVn
ZnNfZmlsZXMoKQ0KPiANCj4gPiBGcm9tOiBFYXN3YXIgSGFyaWhhcmFuIDxlYWhhcmloYUBsaW51
eC5taWNyb3NvZnQuY29tPg0KPiA+IFNlbnQ6IEZyaWRheSwgTWFyY2ggMjksIDIwMjQgMTI6NDcg
UE0NCj4gPiBbLi4uXQ0KPiA+IFNvcnJ5LCBJJ20gbWlzc2luZyBhIHdoeSBpbiB0aGlzIGNvbW1p
dCBtZXNzYWdlLiBDYW4geW91IHNheSB3aGF0DQo+IGhhcHBlbnMNCj4gPiBpZiB0aGUgdG90YWxf
dXNlZCBhbmQgdXNlZF9oaXdhdGVyIElTIGJsaW5kbHkgc2V0IHRvIDA/IElzIHRoZSBvbmx5IGVm
ZmVjdA0KPiA+IHRoZSBjaGFuZ2UgIGluIHRoZSByZWFkb3V0IG9mIHRoZSBzd2lvdGxiIGRlYnVn
ZnMgZmlsZXM/DQo+ID4NCj4gPiBUaGFua3MsDQo+ID4gRWFzd2FyDQo+IA0KPiBSaWdodCwgd2hl
biB0aGUgc3lzdGVtIGlzIG5vdCBkb2luZyBhbnkgSS9PLCB0aGUgcmVhZG91dCBtYXkNCj4gcmV0
dXJuIGEgaHVnZSBudW1iZXIgd2hpbGUgaXQgc2hvdWxkIHJldHVybiAwLiBUaGlzIGlzIHRoZSBv
bmx5IGVmZmVjdC4NCj4gDQo+IFRoYW5rcywNCj4gRGV4dWFuDQoNCkxldCBtZSBzaGFyZSBtb3Jl
IGRldGFpbHMuDQoNCmtlcm5lbC9kbWEvc3dpb3RsYi5jIHVzZXMgaW5jX3VzZWRfYW5kX2hpd2F0
ZXIoKSBhbmQgZGVjX3VzZWQoKQ0KdG8gZG8gdGhlIGFjY291bnRpbmcuDQoNClRoZSBpc3N1ZSBo
YXBwZW5zIHRoaXMgd2F5Og0KDQoxLiBpbmNfdXNlZF9hbmRfaGl3YXRlcigpIGFkZHMgbiB0byB0
b3RhbF91c2VkLg0KMi4gc3dpb3RsYl9jcmVhdGVfZGVidWdmc19maWxlcygpIHNldHMgdG90YWxf
dXNlZCB0byAwLg0KMy4gZGVjX3VzZWQoKSBkZWNyZWFzZXMgdG90YWxfdXNlZCBieSBuLCBpLmUu
IHRvdGFsX3VzZWQgaW5jb3JyZWN0bHkgDQpiZWNvbWVzIGEgbmVnYXRpdmUgbnVtYmVyIC1uLCB3
aGljaCBpcyBhIGh1Z2UgbnVtYmVyIHNpbmNlDQptZW1fdXNlZCgpIGNvbnZlcnRzIHRoZSAnbG9u
ZycgdG8gJ3Vuc2lnbmVkIGxvbmcnLg0KDQpUaGFua3MsDQpEZXh1YW4NCg0K


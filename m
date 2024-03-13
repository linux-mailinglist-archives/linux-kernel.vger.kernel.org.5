Return-Path: <linux-kernel+bounces-102102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 227A687AE6C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98A51B25239
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BB459B73;
	Wed, 13 Mar 2024 16:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="MNnd4+bA"
Received: from PA5P264CU001.outbound.protection.outlook.com (mail-francecentralazon11020002.outbound.protection.outlook.com [52.101.167.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDA618F36B
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 16:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.167.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348584; cv=fail; b=sRfBzg+EAoUfdoH1AFw6xMxjoXn/dQpK+Tbc9regC7KYsJ0MxOQdxs5DKQeXUwBqVXp0mZLNHPBO39ESHiIhnWWL36loCH1QoyJagYPuR15bAWVanfFuWPGLymiWVyB+1vcaPcjyjKKSUqJv1DiUM5leliyPS09IeOv/z/xADhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348584; c=relaxed/simple;
	bh=FND307WVRDBrL1mW9BWpoWA2ZdA7VkKqhLlAJ2va1Gc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VYJDkwpH1onLWuf/TRNKwilkZPVtwmqMtNG/oDMyP37IgtCY8AvLbGCcwR/oF+mulxsg4RCL724UXaEF5vCPDpm+RnFpF9xcFZgsIQMpNnGoKWYz+Ms6Ee6gED9opjjeudyqISmxaFEk4WGKE6pa4e161m4SBOaTGykGbtxf8R4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=MNnd4+bA; arc=fail smtp.client-ip=52.101.167.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJ9MipKOQ92yijfld9ZFUHXoz5SAcwoAPjehC2gn+WI2kiCSL8pEbKxcmmJYj9B+L1pduj/62PuVltDaxt7Uy6uS2SdIAymmoJ9z3/V1ztNvED2FZb8pjHPm3q+o5zdKk0dOqEmarAxM5po3Bd+/bwRAnWuSSdsUX8jptyX23BOz0a2yO8Chbr1Sf5StLqB2yMGBSmUrz57ZQrTJ7nJzuC9KUYnfm/VGfet71T8G9CkyZbqPC6OSNLcYrCQG3BoDOcvgQisSeAdvveV5j7yLIw7J0hODhTkqn5sGMrBN5SOOd5btJ5aKL4TE2h8ZPKbbt3TchlQw7dsBxazXIL+cWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FND307WVRDBrL1mW9BWpoWA2ZdA7VkKqhLlAJ2va1Gc=;
 b=YTM3kcfs6eBcLEL/c3FPbWMail/dH8+8ibiKBqE40PIxTe6lUO6J+WQEJ+WXABMXXDoecb+vgxmKsBs2mv2a36rx13COE618gvH5LjBCJYJOlojbOf0f9ymyxJmMd+PHl/etodA0k7k7q6AGkOIs01vreCxzoak/YzrwiI9SvRAMpkGw3ze4BVUueGv+k5rUeKOfPpObsxFpeQSn72CM5WNKVU9TWPPhanyiFlZ+3RvwTEE+OWq/RNwoitssYeaBu7o+WlYzZX2yG7z5lqpb0QSW+9F+qBu8O/MjgJ3v5MXTX/mB1j7hmrWITv+SKt+aUDOrtT49pW7OrallW8lT3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FND307WVRDBrL1mW9BWpoWA2ZdA7VkKqhLlAJ2va1Gc=;
 b=MNnd4+bAYeJ0x5Ss4J+pPbxJ85cc4ZNpdGEMnLGhHAdq+ZGvvMzOWGbbjLR8BatYMOBi3VLA4nVO0LfxrgXMpw4QhqqnpLwXAmA5herlMAdi+EI4kvjSwcdHGiAeGW3y76lDLK6Oh0OCwtUCIVVPvNlTIu3nIYJzRGZ5VZMB7IW5ka9IQ0ohlpVx24DO1hTCUtSWCdnFchQbkbO6px9TMbOX3bLWYi9R5SqsMX2Z/nM3NFD945/2Lw5EqvPiu+VvV3FXaZi4fu7J/LbBjXlH1/QmS4/dmhsFmxBkbotfDF98RWGAyOO+k2VTnRR5OekBUuC386RiONTyCSLk8EYZPQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAZP264MB2493.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Wed, 13 Mar
 2024 16:49:39 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e%6]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 16:49:39 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "debug@rivosinc.com"
	<debug@rivosinc.com>, "luto@kernel.org" <luto@kernel.org>, "x86@kernel.org"
	<x86@kernel.org>, "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
	"broonie@kernel.org" <broonie@kernel.org>, "keescook@chromium.org"
	<keescook@chromium.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "peterz@infradead.org"
	<peterz@infradead.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 03/12] mm: Use get_unmapped_area_vmflags()
Thread-Topic: [PATCH v3 03/12] mm: Use get_unmapped_area_vmflags()
Thread-Index: AQHadMy0Na1Epyvoi0WcqC5L5hFBL7E1YXsAgABh5wCAAB/jAA==
Date: Wed, 13 Mar 2024 16:49:39 +0000
Message-ID: <4eb19ee2-e71e-40a7-bc4c-33df5c12d458@csgroup.eu>
References: <20240312222843.2505560-1-rick.p.edgecombe@intel.com>
 <20240312222843.2505560-4-rick.p.edgecombe@intel.com>
 <660fbd50-64e8-497e-89a2-05cfd4755bec@csgroup.eu>
 <663bfa89e5ea874c1d96203f113529c618ca1655.camel@intel.com>
In-Reply-To: <663bfa89e5ea874c1d96203f113529c618ca1655.camel@intel.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PAZP264MB2493:EE_
x-ms-office365-filtering-correlation-id: 31ecb791-f93a-4015-bdda-08dc437d92f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 rHMfyYSajLy2nsF8NslLUBFceSsdXD03U3r8tITQ8Rrzr2H+IgD7JF/UPaaQ1bvKAgRv6JRtma6yZHP/eIKwGEIZvVMPExyRVd1u1np1S2B9F4CZorWSdWXmdtziaX0s9hcVbjtNpC2tRNARsHCuoUI9+ntfJe0G4usHSHGN1y1hvBmQLTltNWKvSVu6opBkH9D/3xGWA8WfDSRjEg+Sp/h5ofPk+3yi3GEka2CNay6YL9LtFcg5wStkgzdj4LpllaKXcLCEjUkdGqXzKDwYdULz28TpZA+uXxlLgMh3VAfSNevgLsTVLSnSVDjCU+ohFZWLHy6roPl8OGB3+SwOz/sOhb4YmUQcrTBehrWWvnTU8X9KL7uYdP2Bi9Yrc6y7825oJUxJ4t7eUhExvFW/dqq1KP1RLpHz1miqJK61NXi7wkQfEL0sRjN3Uio+EffUF+A014xqejSvgDiXj64VDxUHNywyZkQf9JzidNOijU0gpres6Y1CKwOl67Th5O334VMbdTJSCfcmUys55qsn2bgPA4C34w8HTNZSAsoEpK4eY2Or3vyDrO1e21uqibfD2CkxoGec4sboPwlU0yN7S2d0w/FVIb+zhBb/p+kA39kD/zfbwGnrfvEOLF3OF4TZUxlAy1lX9hfCl7OY6Ok9TOiOgkYKgcRj8QBgvjprdak90LCmHkKhRkS/L2DMnD/yU1+1v3bXS5Cu1C3q412ZUyefj8+x+WH+raQRdDn4ixk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(921011)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VXdFYjMvOUdoS1JjbnBibG80NzZrQ1BMVnBIUnUvcW9qV2ZzSkM1dHJWUzNr?=
 =?utf-8?B?WFFSYXc3YkthRklSMFArSER4eWlaMEVxRmg4MWxISVg3dVBiRHZ0L3psV01r?=
 =?utf-8?B?TENINkxYSHo1OWpVNnBhLzlnTlpEREV5R1pabG1qdGFiSVhUVHVOaGRDdjZq?=
 =?utf-8?B?dHBQWnZ5QXVFa3dKSTU0b1Zha1RhYXAvNHBiT3RWQkRwTDV5TTJBMEU4ZGlP?=
 =?utf-8?B?V0cyUnZtWE5aSzhwWENtenFuOTdaTzgrNGwvZElMV0NDR2VRUzlteGhzbE5q?=
 =?utf-8?B?LzFEdGlPOUpsNGFMVmxFVU4xaHlINTczNjQxNnFyRUIycHY5UnF3UEk0TzFR?=
 =?utf-8?B?dW90SHFqU212UFVIcE52UHBGRjRjcVJFWEt6OEVSem9IZ0RDSXV4RHVkYTdv?=
 =?utf-8?B?QTlVV0x6Z0hIM2hib25DcURCWlJ3b3JvOHFNOVRaTGUwQVNkOTZ2N1VxQjlT?=
 =?utf-8?B?VU9Jd1QxdlplbFJ5aTU4NWIrbkxBYVRyc21wT3hBeU5iUVd6T1FJWWRLQjhP?=
 =?utf-8?B?ZFJKM3JaSlQ3SzFhRVI2VFZBME5mMmxBNDZveStPQ3BYcXVESDE5bGdMMHA0?=
 =?utf-8?B?K3ZHOTZ3Y3ZhZE9XNUc1K245blU3ZW5xUEp5b1hBNDg5YXU5anpTRURGSjha?=
 =?utf-8?B?bDVmZC9lK054SXB0NkNTekFuWGdIWkVYanpnWThaQzZtT1Z0U2gvWmEwZnVP?=
 =?utf-8?B?MFd0ZkJ1WktHUUtsZll3RmRLVTQ0ZzdNTHV0ODVTQ2dua2E2QzlOcG0zdis2?=
 =?utf-8?B?VytnYUNIWXRXQWJwd1duZThzVVlLdHVHTHdrc3pvNUJScXpMeDQ5S3B1clZO?=
 =?utf-8?B?NDgxOGk5d2hRa3lGa2dDekFtQmJ5dzlFUGx5OGdLT3FyY29YeVlOaGQ2OXJh?=
 =?utf-8?B?YW8ya0YvaW5zR05WaVdnZzEvWWVmaVZod2ZvZ2JoYjFXMkxpellXdW8veGx4?=
 =?utf-8?B?YXIrNnFtNHk2dlMxZUxlSnNKZ1NRWFNKRjlUUEx3YVlzdmVkMkRGMzBDd1JP?=
 =?utf-8?B?dHZoTDg4b1phNjQwTDBUUkdTcE4rVlFjVGxDTHg1ZExyZnlLRGJnUDFuK0Ft?=
 =?utf-8?B?d3h4RThScC9ZYVZBU3hzcWl6VXFHZWxaN0NJV1JZeGVVbkdXVWFyN25UU2sx?=
 =?utf-8?B?bG9KeWhVdGRKNmRtdU1PdUM3dzc4UyswM05seWU2Z2ppU2R1OVBvcWVsUTZU?=
 =?utf-8?B?RXlxcThPZkN4RmdKRVVKaWcxUk5rSEtKSW92Z1VoVzY1YWNRWjRKdTNBVEVV?=
 =?utf-8?B?VTJyS3NYTVJzZG9vRHlGWkRDWk5CRjJ4WWhJVldYaUpwVXR6ZUlXVG9QL3VM?=
 =?utf-8?B?TjI3a0Q1bWFtVnVRRVlBaFM4QU80LysrZ0xvaFkwSG8rTXB0K0RYN1ppUHVR?=
 =?utf-8?B?dFFjQURBSm5wbWhtdzhxdTFVd2JmNloyNGNiY0hQRXV5clc3ZjVSZ3dCSE1v?=
 =?utf-8?B?ZkpqdDJYOUVGd2xSMURleExSMit6SlJVY24vTUxrUGF5TklZd3c4NmpzSXZt?=
 =?utf-8?B?OHlrbUh4ekZnMThER0RTa0Q2YWI5V3N1aFpESHFTL00zNWxiVGlBcUZieTBW?=
 =?utf-8?B?ZkJ0MEdEUDVNd2poQlBjbDNmcGw1eXh0NDRJOEp3eWxEcmU1TVJ6VUZNd2hn?=
 =?utf-8?B?Vno2T3ZQYXhuMkQwQ1E2QmJkWm5DV292d0JRTGxKZ2JVUzVQSDRuVGpwRUJU?=
 =?utf-8?B?RTZqNVdvN29meDIxS3NnTlpCdDdGN1hFdHNYNDc4ZTR6UHRMVmgvbzN6aVhi?=
 =?utf-8?B?c05UY2dtMU5mZGo3QWducTAwOFMzNGNVOXRFZU9rcEJPaUZkMDdBSWpNZEV2?=
 =?utf-8?B?WWV6bFl6amVWRFFTWW5LZDl2WmxGQTN3NGF1LzB2cFl4NFg5UHZiMXRDM1d5?=
 =?utf-8?B?UGtOVGlxWks1dDBES0x6WC9XeW9VQmRleVNjcmZ1TmVpNFM3TC8zTjR3SHU3?=
 =?utf-8?B?R01RNmFHSXhEUDFON0x0bjVtQlhxbU12UjdHblRJa2pXemYzS2NTZSttdWsr?=
 =?utf-8?B?Tmd4dmYwd1VabVhyOUlHMU1EMVRrdHhWVnQwNHNDNzBHeXdKSDF4YjFqclds?=
 =?utf-8?B?RkVMekN4SFFVeHo2aWlDWkxZYmRiQWdoYzA1RTh4dGttQjMrQUFnRDBKZ0tP?=
 =?utf-8?B?NUVwRmZzUHROdjNrclAycStNUzhleWlKNXU1cktRZFk0Wnd6TkJJRTNIelhh?=
 =?utf-8?B?SHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B147F8688CF2644F935B5A3CC46E6ED0@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ecb791-f93a-4015-bdda-08dc437d92f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 16:49:39.4925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TjH9pXGV9kG7A06AHYdjdCnE4ToidQ9gjTQ7vJLAN0+7sP0Kq/a74rFKMMp19IDo5vRBa5bQpAIruhJosq3yZ0ABQyroNyAPlr9GNmAwDJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2493

DQoNCkxlIDEzLzAzLzIwMjQgw6AgMTU6NTUsIEVkZ2Vjb21iZSwgUmljayBQIGEgw6ljcml0wqA6
DQo+IE9uIFdlZCwgMjAyNC0wMy0xMyBhdCAwOTowNSArMDAwMCwgQ2hyaXN0b3BoZSBMZXJveSB3
cm90ZToNCj4+DQo+PiBXaGF0IGFib3V0IGdldF9hcmVhKCksIHdoYXQgaGFwcGVucyB0byB2bV9m
bGFncyBpbiBjYXNlIHRoYXQgZnVuY3Rpb24NCj4+IGlzDQo+PiB1c2VkID8NCj4gDQo+IFNoYWRv
dyBzdGFjayBjYW4gb25seSBiZSBwcml2YXRlIGFuZCBhbm9ueW1vdXMgbWVtb3J5LiBTbyB0aGlz
IHdheSBpcw0KPiB0byBhdm9pZCB1bm5lY2Vzc2FyeSBwbHVtYmluZy4gQW5kIHRoYXQgcGx1bWJp
bmcgYmVjb21lcyBxdWl0ZQ0KPiBleHRlbnNpdmUgd2hlbiB5b3Ugc3RhcnQgaW50ZXJzZWN0aW5n
IHdpdGggdGhlDQo+IGZfb3BzLT5nZXRfdW5tYXBwZWRfYXJlYSgpLCBzbyBpdHMgcHJldHR5IGZv
cnR1bmF0ZS4NCg0KT2ssDQoNCg0KUmV2aWV3ZWQtYnk6IENocmlzdG9waGUgTGVyb3kgPGNocmlz
dG9waGUubGVyb3lAY3Nncm91cC5ldT4NCg==


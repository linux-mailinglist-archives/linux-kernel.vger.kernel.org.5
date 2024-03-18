Return-Path: <linux-kernel+bounces-106411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E6887EE44
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 653921C21A0B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBAC54F96;
	Mon, 18 Mar 2024 16:59:11 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2113.outbound.protection.partner.outlook.cn [139.219.146.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279FF54BC5
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 16:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710781151; cv=fail; b=YTzSf7VtfBWv0UwzvzuJCMnO37nSYVX9yBj9tOAsR+CnqHr/w++71986AeHPdlA6yV1KFgb/nSvecYFzeODOeodbp+bJ7o62+bNVJalLILd7f49T5OAbbnJ+rI547Q+C9o88jNfG1422C4wW3qBY6E0REe9j908vw0TWr4YWmFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710781151; c=relaxed/simple;
	bh=9+88kuvNIA9sxbpoRAL7RW7anMeeNYSciSngPjRwLqk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DWPWk9TbNqLqqimPvCAQiDFhm3K9jV99Xbwt8eWPSnr86K0kg6DxIfMG+z0JKIaeNdJOCPRHwva75fcbnpVtmDGqM6F7c2IMelMPV0Atn1WooQrdKq64qmz+v/Ip7hX4mdan6WmQ22cEjQVdmPidcSPWVSvXSksG4O6cqeFpiHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8qzNPmTI3gzSfgww/o+TVqo/9YVn8qvEw3/7jv5g4+9P91a6y3NMwhE1fP9aMmGCd+qNneSY2I1zBTI1dfnzYZX6IS1Xa0GTNYbgQL35QSGGroeogzozzRGVDgB9OPFbMHCQUw8MoMAwptdOyQoQnEUJrTFMWONBzx4AUJFQjsJiIpgfi8VHbAQr0YY0qmP5DM2csmHlYW1/4GoodpEvOKHHFCGlQCZhny1FBI5ApPBRCB0EhCcnWLkXPLhh2cH9HJlZuBvhIKaNemWHfIJYqKqFuvyza/HBNKLINNmrbQK48hwSV34j3M9r5bTTzNoqbOtfNn0jsUKXeVjKyFbSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+88kuvNIA9sxbpoRAL7RW7anMeeNYSciSngPjRwLqk=;
 b=BKFhquLPC50KSvu7SfbLFOPVbDHf2ndI0YvQortfszjsHZJfnTHKb1fXNaCZPsccwW7Im7LaEaoPsxbYVm0dEuUgjWPD52X+G0vgez5zq5CAw3HUxizM9NKyi0+kuqE8s+VuXPlmMqZqjCnQhQFsIBExyH8GC0UzbYB3CUqD8094LLoHz93i7fHnfhw1TbxTSAZxFIWowXb3h7teAMhEDvkAJ3TjHscRv85hNF2BKwGbMnpALl/ohVa8eo56DwmKCF6/iAyPq10Jyl/8BlaZtw9wj1MlAbh9aZWHosCcouZg1mzYBSO1sbDP+CRsJQ5oN/z/3AWZ6eCdcuVRbD7xsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::6) by ZQ0PR01MB1158.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 16:25:46 +0000
Received: from ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 ([fe80::d66d:c2ff:45d:cbbc]) by ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 ([fe80::d66d:c2ff:45d:cbbc%7]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 16:25:46 +0000
From: JiSheng Teoh <jisheng.teoh@starfivetech.com>
To: Palmer Dabbelt <palmer@rivosinc.com>, Conor Dooley <conor@kernel.org>
CC: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, Conor
 Dooley <conor@kernel.org>, Conor Dooley <conor.dooley@microchip.com>, Will
 Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] perf: starfive: fix 64-bit only COMPILE_TEST condition
Thread-Topic: [PATCH v1] perf: starfive: fix 64-bit only COMPILE_TEST
 condition
Thread-Index: AQHaeUn+dJXfI4yliU20QqCIuRLFXrE9rEmAgAACB7A=
Date: Mon, 18 Mar 2024 16:25:46 +0000
Message-ID:
 <ZQ0PR01MB1160EE942B57257DEFCBED32EB2DA@ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn>
References: <20240318-emphatic-rally-f177a4fe1bdc@spud>
 <mhng-abf741db-9f86-4803-b143-2948e9a099af@palmer-ri-x1c9>
In-Reply-To: <mhng-abf741db-9f86-4803-b143-2948e9a099af@palmer-ri-x1c9>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB1160:EE_|ZQ0PR01MB1158:EE_
x-ms-office365-filtering-correlation-id: d658c861-9d9f-473a-334a-08dc476810cb
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 bNbMjE5MJdX4v6zuWVUqiUJwhi+Kka8srIijUUNFMyhbC4719VJtMAksD3xOJ4M0I6T8x9ljLzGqiX1L99IpWm+VA9SbuZVFM57mW8Ybx1W/sC6G2loD7iFhDPgP5zMgC+OXZ3mtL28cDf2eNU/B7LPG+4uOTOYBLI+71g+KYh91EhSyjCEAn46Ie/AXN2G7/TS0Ucy/LSI6YVU2xsqjJkc2cMw2AlZ3n5Q/LPr8SyLTtcTFWrt8JoGvOUT5Jn5EnpGmzZOO1cx0kT78jm+relgZx4GsqlbB8Mviyz22MJ15mxOJcZgbG7j4DE1vLXiCM0GCQcMkfC8kzUMTntXr4tsCbiZE2N/Pfh2u3+VBIN8BA4eheGIFH6Agvfq/BAr2Kc8mo3Nrcz8/XECRt+Vh+0DrBNP5mPgKxuq9PT3ab/AYKqyosqdtT/rl0GEIcYf4iHuk/Q2CYgGUvpFZVU0Drv0mGTWbPeZxtXfemWAekPFNi1adWLNwKdfE7GQkyseQJcnlCBk1sh6XxBi065+XiuSDQggi5lRS3XnDA7xtSJIPJLBBTKPJqD058UebNmjbFHDxioIecjzPNl9YD2z7Lrt3b8NLX40tDu0arze5fbnM2J/mC1txVrnwnX7u8LC2
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(41320700004)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aUY5TlU1b1owVGllTTVMaUdPdU9tSVJpNW1IV1hBVWg3OEVySFpaeXVtelEr?=
 =?utf-8?B?WUVnc2F3UE1ab1FXaTBrejVxSVorOHFGbUNOM1RYV09INFJ3VXFmdFJ2S2sr?=
 =?utf-8?B?bUo0ZU91VTFndmg0ckIzVlZQc1Z2Q3BLSEdzNEJLRXRydUFjWXNIOVhhV2VZ?=
 =?utf-8?B?VHY3VVNTY252MFBZbEMzOXhGazhZdWNBWkFJeStsNlNPZlhPTjZ0b1ZyY1p2?=
 =?utf-8?B?ZW4rM04rRUlra3RwWkVkZmJCUWZVVko0MGZPV1VpdldQc3hsSTRKMWkwNUoy?=
 =?utf-8?B?eElLWW5WeFVncGRZYm5tLzBJdlVTUVQyeXRBQnVqTU9adG1hdlExRHBFMEcv?=
 =?utf-8?B?SVVqN3dBRWxhb1VTL2IzQ0tzL0wwTzdQZ2xmOGNyYVlwcE00NFZWZlg2UEt4?=
 =?utf-8?B?VzVpSlNJZThHdWtBekRPYVNHM0tJaVdGMDk1MEk5Qlg1bEFvc0gwUGhhVmRK?=
 =?utf-8?B?aDVTb3prai9vWW9iclBFWFNpbncyaXM3ZTZFMVBxRUthMlFkTkdWSHlkS0JH?=
 =?utf-8?B?bERXZzlSdzVMOHJQUnN6bVpMcWQxVkQ3MW9iU2duM2dEVFdhNUtEM3d3aXox?=
 =?utf-8?B?THpvV2xtc0x1S2ZrZ2pZV0M4Yk41RWNhZXgwT3JWbS9GNzNxRHhja09wK05l?=
 =?utf-8?B?Vy81UFhRSW9lVThoZ2QvU0Y4dHQ2U25yL05UQzRmWElscHhyZUQ3QWxST1N0?=
 =?utf-8?B?YitwWXNBSy9aU2FremwyZUNmR2dWUXQxQ08yaEhaY0ljTEhTRjg1M2N2UlJw?=
 =?utf-8?B?UUduaUpaNTRIQzVwVWZVNXlOVUMxRUNNaGlqQmVmbDRsdFp5WmZnL3NkQ0p6?=
 =?utf-8?B?ZWloUGFkaEN6bUR0bHoyd3pxYldrUnFkZ0ZOUVg2ZEIrMkI2T0RxSk9JdHlZ?=
 =?utf-8?B?M0ExdnhMM2NyeGdrOWZkTUl4UnVNRWNZNm5BK1I2ZXRMdzVUY2xnNWYyTnpO?=
 =?utf-8?B?QXd3dFVxUlNOaE9ZUTFJR0Z2b1JpQVZpaFIvTjV6YVpIZm1Jc1dHR0lDWmo3?=
 =?utf-8?B?bUhUaWZtcmk1MkNrdEgyR21JOTNXTEJSUVpOS2doVnB6ODdsam9nRTNjUlIx?=
 =?utf-8?B?ZjNCS2FUQkk0NzJ3b3FiVGUwNXlyd0g5KzBJOFRQdVprSjBIZDJQa1VIQklt?=
 =?utf-8?B?dGIzVTZONG1XL3RtM1Y1NVNNYnZ4Vms0ZG8xQklSZWkzNDE2bzNZSXZvYnhw?=
 =?utf-8?B?SzMzTC90bjQvZWp0c1hUWlQ2ODRqZHdjcm5ITUd1aS83aENhdlp0ZWZBbEFJ?=
 =?utf-8?B?S1Z3NUZXK0NabXdaVWpucW1HOXYwTnR0TFFLK2dmMXV4OFhlcWZuRkhIS1pV?=
 =?utf-8?B?YlNMSStDaUtoWFBZb1RMZmVsQ3N4cU9mUnJyRU9qQW9DSXgvWDZQOWpuUHl1?=
 =?utf-8?B?eWdWK0VYV2tXMlNpR2dmZ0w2VzllRDZXeThObXNiVVpjU0d0eHZJQU8yY2tG?=
 =?utf-8?B?cWVxWW1LaHYycWJTMUxGYWVETkRVTDBqVHVEME5sc0w4QnQ4WXl5dnpkekhs?=
 =?utf-8?B?MVhrS25DcXhXT0RLaUY2a3JiM3U4eElFUHNaQmRxdGZleWcvNWF2c0t0YXJL?=
 =?utf-8?B?ZE9DdmVJRGNkL2IwMFFTWG5JOTJlUXdtWE1nSDNlQ041UWlXdG9aclBreTFV?=
 =?utf-8?B?V1pVeDl5Nk1SN3RjSDEzWU0wdU1sbC90bmhHdW1YbjdDUUtRUC9qY1hORFdv?=
 =?utf-8?B?M0xtZUxBWFE0M0V4NDJBU0FUUStCS2t1ditOckpNMVhzYnVjSGtqL3hOaEdz?=
 =?utf-8?B?MWJ4YnN2SmVoTkx0ZjU5QWdZaGlRKzdady91UFFLUXZUWWpRN3FSRGxCWFFI?=
 =?utf-8?B?RmxuSUV0ZS9raUxqcWFlSmpKSytWVnl3b0dEVlhxcmVURWNuNU43aG1CS3Js?=
 =?utf-8?B?U0l6L1Y4bWo1cHIvcElRTHc5dW4xMmZCcEZLS3VlbE9DYWI3aFo2WEcxeWVJ?=
 =?utf-8?B?N2NyaE9OcmdkTml5dlRIblg4ZFRnV3cyenpDMXpVci9xRjlJTWVSSDRWWGhi?=
 =?utf-8?B?dUE4ZmtsVUx0ZXB1RGFPVDNGWG4rZHNRZ0QrcXdBVS9KclJ4YnFJcUdmMkZC?=
 =?utf-8?B?bjZveUlXaGxVRklDMkRReE84SHJSZlZzUlBFMTJCTGo0dzhQSXEyZTErNmZx?=
 =?utf-8?B?U3VUenB4aDVDK1pZUVlnVmM1OExIVEg4WVV4ckdyaksxanNSR0ZZUnAwL2NP?=
 =?utf-8?B?VlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: d658c861-9d9f-473a-334a-08dc476810cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 16:25:46.3067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qcXw+LfifQ68TlC4kIO2ofOdPIQyyucZjvKzsX4pJgh+xaCDmAwEVJWu2eXYDTLvHntCuQDSvXcK4EcpYX1IpbA8Jcg7dGGfqv1wHlwtL20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1158

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFsbWVyIERhYmJlbHQg
PHBhbG1lckByaXZvc2luYy5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDE5LCAyMDI0IDEy
OjE1IEFNDQo+IFRvOiBDb25vciBEb29sZXkgPGNvbm9yQGtlcm5lbC5vcmc+DQo+IENjOiBsaW51
eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnOyBDb25vciBEb29sZXkgPGNvbm9yQGtlcm5lbC5v
cmc+OyBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPjsgV2lsbCBEZWFj
b24NCj4gPHdpbGxAa2VybmVsLm9yZz47IE1hcmsgUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5j
b20+OyBKaVNoZW5nIFRlb2ggPGppc2hlbmcudGVvaEBzdGFyZml2ZXRlY2guY29tPjsgbGludXgt
YXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxXSBwZXJmOiBzdGFyZml2ZTogZml4IDY0
LWJpdCBvbmx5IENPTVBJTEVfVEVTVCBjb25kaXRpb24NCj4gDQo+IE9uIE1vbiwgMTggTWFyIDIw
MjQgMDg6MzU6MDQgUERUICgtMDcwMCksIENvbm9yIERvb2xleSB3cm90ZToNCj4gPiBGcm9tOiBD
b25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPiA+DQo+ID4gQVJDSF9T
VEFSRklWRSBpcyBub3QgcmVzdHJpY3RlZCB0byA2NC1iaXQgcGxhdGZvcm1zLCBzbyB3aGlsZSBX
aWxsJ3MNCj4gPiBhZGRpdGlvbiBvZiBhIDY0LWJpdCBvbmx5IGNvbmRpdGlvbiBzYXRpc2ZpZWQg
dGhlIGJ1aWxkIHJvYm90cyBkb2luZw0KPiA+IENPTVBJTEVfVEVTVCBidWlsZHMsIFBhbG1lciBy
YW4gaW50byB0aGUgc2FtZSBwcm9ibGVtcyB3aXRoIHdyaXRlcSgpDQo+ID4gYmVpbmcgdW5kZWZp
bmVkIGR1cmluZyByZWd1bGFyIHJ2MzIgYnVpbGRzLg0KPiA+DQo+ID4gUHJvbW90ZSB0aGUgZGVw
ZW5kZW5jeSBvbiA2NC1iaXQgdG8gaXRzIG93biBgZGVwZW5kcyBvbmAgc28gdGhhdCB0aGUNCj4g
PiBkcml2ZXIgY2FuIG5ldmVyIGJlIGluY2x1ZGVkIGluIDMyLWJpdCBidWlsZHMuDQo+ID4NCj4g
PiBSZXBvcnRlZC1ieTogUGFsbWVyIERhYmJlbHQgPHBhbG1lckByaXZvc2luYy5jb20+DQo+ID4g
Rml4ZXM6IGMyYjI0ODEyZjdiYyAoInBlcmY6IHN0YXJmaXZlOiBBZGQgU3RhckxpbmsgUE1VIHN1
cHBvcnQiKQ0KPiA+IEZpeGVzOiBmMGRiYzZkMGRlMzggKCJwZXJmOiBzdGFyZml2ZTogT25seSBh
bGxvdyBDT01QSUxFX1RFU1QgZm9yDQo+ID4gNjQtYml0IGFyY2hpdGVjdHVyZXMiKQ0KPiA+IFNp
Z25lZC1vZmYtYnk6IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+
ID4gLS0tDQo+ID4gQ0M6IFdpbGwgRGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+DQo+ID4gQ0M6IE1h
cmsgUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5jb20+DQo+ID4gQ0M6IEppIFNoZW5nIFRlb2gg
PGppc2hlbmcudGVvaEBzdGFyZml2ZXRlY2guY29tPg0KPiA+IENDOiBsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gPiBDQzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zw0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3BlcmYvS2NvbmZpZyB8IDMgKystDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3BlcmYvS2NvbmZpZyBiL2RyaXZlcnMvcGVyZi9LY29uZmlnIGluZGV4
DQo+ID4gNTA2MGUxZjFlYTEwLi43NTI2YTllNzE0ZmEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9wZXJmL0tjb25maWcNCj4gPiArKysgYi9kcml2ZXJzL3BlcmYvS2NvbmZpZw0KPiA+IEBAIC04
Nyw3ICs4Nyw4IEBAIGNvbmZpZyBSSVNDVl9QTVVfU0JJDQo+ID4gIAkgIGZpbHRlcmluZywgY291
bnRlciBjb25maWd1cmF0aW9uLg0KPiA+DQo+ID4gIGNvbmZpZyBTVEFSRklWRV9TVEFSTElOS19Q
TVUNCj4gPiAtCWRlcGVuZHMgb24gQVJDSF9TVEFSRklWRSB8fCAoQ09NUElMRV9URVNUICYmIDY0
QklUKQ0KPiA+ICsJZGVwZW5kcyBvbiBBUkNIX1NUQVJGSVZFIHx8IENPTVBJTEVfVEVTVA0KPiA+
ICsJZGVwZW5kcyBvbiA2NEJJVA0KPiA+ICAJYm9vbCAiU3RhckZpdmUgU3RhckxpbmsgUE1VIg0K
PiA+ICAJaGVscA0KPiA+ICAJICAgUHJvdmlkZSBzdXBwb3J0IGZvciBTdGFyTGluayBQZXJmb3Jt
YW5jZSBNb25pdG9yIFVuaXQuDQo+IA0KPiBSZXZpZXdlZC1ieTogUGFsbWVyIERhYmJlbHQgPHBh
bG1lckByaXZvc2luYy5jb20+DQo+IEFja2VkLWJ5OiBQYWxtZXIgRGFiYmVsdCA8cGFsbWVyQHJp
dm9zaW5jLmNvbT4NCg0KQWNrZWQtYnk6IEppIFNoZW5nIFRlb2ggPGppc2hlbmcudGVvaEBzdGFy
Zml2ZXRlY2guY29tPg0K


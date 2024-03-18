Return-Path: <linux-kernel+bounces-106566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B0187F05D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EED5528218D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E6D56769;
	Mon, 18 Mar 2024 19:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aJK2evZC"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD2556741;
	Mon, 18 Mar 2024 19:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710789787; cv=fail; b=rzXNuF+l0PdH5Sz90wdLUncYKQdtva8Bq6fFQ1b0ouOloYK19TcvdoCwjkmv1BTJQR2/cAM4FFzRPeGGnFnJIY5UEpkHd0IZADmiF/YYawslxQ2/z231HmqPV0Y7mcn2Y/PICegLEDceUEQSO3f+Xn/4VXgPOhmZtGOmOhOb7ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710789787; c=relaxed/simple;
	bh=iksVrfwM7CpQC9hadAwxFI5Fw6/kj6DM55LTpV7mFjY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QWz8f2LlNnZus1ADdw1qQbqLA32V4wf1zqkgOMtw0us6hcUGXrLRDlBnaTGBOV+r5kRZQ18Fvx8cVL5J4RpRHmtL9nU7Cna0orTd6cxNxFDV/hUiFQchhBkn1TuZANYutUUYSW012beILSBKtDwQm82AyJZ1O7nW4M+EsN08SUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aJK2evZC; arc=fail smtp.client-ip=40.107.220.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IkrGvE7x4P/sU2s35u14a/9fV1gQM9DDyMZRb19vJ7nyjxOPqKW+QS5J9JR96WEQ6V0jP70WztMvLMQV93rKy0FcGmLY2Edv8PYKxixE6LBJ1koJE5xiyY6VLWmZ38zZmVamprEU5tnT0HiGyIcapGrjuylm2pfGsIODE9AW7l4AyHltgFI/HPU0RiRnwAgoLTI+b9MH/4w9VnBF4NShOPE2uL5b/M39a9JM33CtQxDl0DXbEfg1U/86eDbuCGrXq3BqgrULe9Og6Zswh6qZEUBn3U9ETY2VNXaGvEG/yEuu+XLmiijDt3nApJGPGHPtnijjYhAX9eYqQf5AkKj1tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iksVrfwM7CpQC9hadAwxFI5Fw6/kj6DM55LTpV7mFjY=;
 b=Oqsg/QYqyr7M5bcq5/KprxzeX7Sx+o4N1nSdYUPMBFVdn7tHjDKonLvUBz1KlybTqD9wi89Jdm6Fkl/54b/C0IA3gYvKKYTL50FuEHEJYbFWzirX0jIq0Rrd031/+9ydnRZ53Tg0uZqVV50e7HcB9rH2tdEyYewLM4FS+kAAR7mUQYYKBTHUH8+fgMgMMXI0w+vymAqtnGPk9XR59uaL8KPKOB0A1ay2Mve0HHlGhxZ8PF8Rs1//euYKcsfuJ95vj85UPB0oqD2lbC3RWHqwy11oDnQ8NUXoR1RO+Or1HG5qg+nefsbD/kqyu9jFefKANGYUKQjXIr4pkvSZ7GW8Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iksVrfwM7CpQC9hadAwxFI5Fw6/kj6DM55LTpV7mFjY=;
 b=aJK2evZC6gQFgYE7aqb1fjxoTOOAD13Op2UbxC/4JzAvDqyLkUw3rIT2poopE+e/oNwapsDccsmUII+ZdHMMNYI6wGzpFYj2i32NhciikdNS0tdD1CuZ4q1KelqzhHhqqk1FL3n28E+8F7nLjDjiOwGIZsA6eUVJ/B6Dnwtt1qw=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by DM6PR12MB4385.namprd12.prod.outlook.com (2603:10b6:5:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 19:23:02 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::ca5b:3117:e891:239c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::ca5b:3117:e891:239c%4]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 19:23:02 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, "Simek, Michal"
	<michal.simek@amd.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "git
 (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v2] usb: dwc3: core: enable CCI support for AMD-xilinx
 DWC3 controller
Thread-Topic: [PATCH v2] usb: dwc3: core: enable CCI support for AMD-xilinx
 DWC3 controller
Thread-Index:
 AQHaZpDns4R4mqNUg0q8M2eTTuX0u7EYiAqAgAAFHYCABgNyMIANBCqAgABlE4CADCG+AIAF4kow
Date: Mon, 18 Mar 2024 19:23:02 +0000
Message-ID:
 <MN0PR12MB59533C758566BC5A98588D74B72D2@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <1708717523-4006664-1-git-send-email-radhey.shyam.pandey@amd.com>
 <20240223224940.y34qflo2azxrvksy@synopsys.com>
 <20240223230758.s7rodlxbsfa44frw@synopsys.com>
 <MN0PR12MB5953B24F0CB175D8C167E73FB7592@MN0PR12MB5953.namprd12.prod.outlook.com>
 <20240307014402.omtcsltp4pxpraf7@synopsys.com>
 <5e87b406-3301-410b-a479-d561d5b19f62@amd.com>
 <20240315010142.qmgx7dugwwb2ort2@synopsys.com>
In-Reply-To: <20240315010142.qmgx7dugwwb2ort2@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|DM6PR12MB4385:EE_
x-ms-office365-filtering-correlation-id: 7993a724-fa8d-4c18-89b4-08dc4780d48c
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 epx8LW2+TNrhyt+lgpKXL0Ou4wgqMqB+gHe8SiW8XK9YRa6ju+JpQLRaK8Y/NqK9MOh9FlDDM3SrJbxWnihxvO0plISjfOFW4P1+0/tz4MPtI+pRfzN/4yThqhe6q6iYgZnCBvrxVcCarTG9F9jGTBnmdTDOzaZsZ9axvSo/kQjD+PljXcRgAMREs9ME74pdEj+Or0WI0EZu/sX7rqwKVOXCr2soLLRO5e8yC2llg/XXTeSVPEZzew/Ef27xoSGIwoIlDD+uRXqSklQ2Jmv0XHPtrsGHfwy81/i5c50iYcLadzYObCmg/BTCxu/5lATPg60w1Nr3yRUaO/oOM5ptlmvDHfJfB3lIvEJMoUwQ7z48FRI5chsL35QTHwSzgQ40iu8Zdm/vzlFxbBWEv6DzhtLdrua0pVwLmGkqUtmkiVL9JNsNdzkq7YI2TcCvSYK9v7YbAGoOrPhUbDDmrMb6X0YRXFpbdQXQRDnX1PhNAT47NVGrZr9msQwAF7HVOaIpWurIylZOfNkA9tg7At66vlCd9rpJrnBFsaHzl2VgiL2lRURMREb47YYxbxhHkmTECEMJ+eGt9V8FHJHhabXNwhtyjrvYVw262AtmqSR90YRXANc45MIE/fBQd9+VRCJ0luZw9tOIF0gLVO2AvWnwWTWenpZrv4U+e9rtbSFY/m13uqy6BQytWAHXDN4ICV/NS4ohTBgYFEVIKNe6PWZO6Tb8JnrcRmjXjfDMIacBGEQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZGZIdlhiZ1BhUkl0SmZVMXk3c0RPL2xiTGFmQm1mbGFsZGdZR3hZT2hUcEZ1?=
 =?utf-8?B?REVJWGhRODdVMUpzckpEV1hubmYvRkVXRk5WMTFOVVBYcExRT2cya29CUTJB?=
 =?utf-8?B?VHg0SlhMU3BleTBlbWhFMElvSCtMaGtzOGtESnp4eHVOdDBsNzFSUklneDFH?=
 =?utf-8?B?TGswdnFvdDBQWHpPU0JpZmlVVWJZaGZMMjAyL1RlYllZZnZUZDZGNWpZS2t2?=
 =?utf-8?B?Y3VIeC9mcEw0V3VJTmcrQlMvR2NQSVBJQU5FOEo4Zi9tZWZRb2pqUG15eW1h?=
 =?utf-8?B?THlMTnhzVG5jTmtnY3paNjcvZm1HT1B1SUlLanV5eHB5dDlsR0REdTVybEJj?=
 =?utf-8?B?VFZLSitRVUQyeTFna2VqRG9ndk9EeGw2bXhNMTBxUzkvcGpZV0ZRUWNFMGNl?=
 =?utf-8?B?OHdPR3d4ZXdnQlB5RUZ2aUdRdnhDQmFxTUU5citMSk01S0hNUGNrWmRkV1hr?=
 =?utf-8?B?NERlUHQzVzB3dzdONzZGMXZRdE00SHQwNklKMVpaWnZ0cmxMQ2QwMEs2ZGw3?=
 =?utf-8?B?ZDlScHBqZkFnSnhra3V4RVFyOWxNWkpkUWtua3U2NTVGMm1jdDJzMitOMGh3?=
 =?utf-8?B?ZVlpUU82RTZzcm1zUm5RWmkveTB1UHVTdkg3STkxTkpSMUFXOEV5MHQ1L3VM?=
 =?utf-8?B?RGsyM3Zob0VXcVlXcDVXcXV0eklYR1RYaVpaY0NUMkpRQUlGSmdWNkhCYU5k?=
 =?utf-8?B?SEEwYTZCcVFtMEFXblFwWEozTklDbDcyTkwrVFVYQ1Q5WkwyeFprbjJkZmNa?=
 =?utf-8?B?cC81VGU0RjU1YTFIMURwQTlBQnVtZ0oyYnlOdmxmeWNNS2xhbUhuTnlCQnBk?=
 =?utf-8?B?Q2Q2WTd4WWpVNFNUKzFZYndNWmpoempDQ3J1K3NjQ2FPRE1xSHZ2SmljQVhJ?=
 =?utf-8?B?MzhIV05PSFRURVZFM2VpVURvUHB3VFcyMkpvRk9TRmpUN2lDcnVUQWhrZUxi?=
 =?utf-8?B?QnBmZVNid3Z3QkYxUXFTWXVDNVZ1Ymx4S2l6cUU4MHlQaHhReW9PT1lLQ0lF?=
 =?utf-8?B?RVArd2E0cHorSUlnQ3UzQXhNdFN3VDdDekdwOFp1S2d0dndSdlBLOUNScjBY?=
 =?utf-8?B?QnNrMmkvOGFZc2FDQ2kwTHRodWhuam1PVjVma0VHem1yVkUzKzlJcVJWMWlN?=
 =?utf-8?B?LzZwRWZ4T1BXNmMzRUFiODJ4cnZTZ1ZOS3o4bTlyTEFVcnhlMWgzekRxamZC?=
 =?utf-8?B?aktaOExtS21MVm8vaURkenBjRmJ2L2JQUmZiZnFDVkJ6VGpsd1g0WUJCNi9o?=
 =?utf-8?B?M1IzMW1ueWsvQVBoWXZDc2lLbU9LenpHZzEvaktYTldGWW10Z1F3S1hnTFRR?=
 =?utf-8?B?b0Yycm9Zc2xNT3lrRVJUWURoNzlVM3FzelRoTWpQclNNK1JyOEUxeWpoYWtw?=
 =?utf-8?B?OUlCbytRdzA4ZGtYNFdWdTdCTDArUEFLbTQxRUlKa2FIUzRkSjZxRlUwYVJ5?=
 =?utf-8?B?dWxJYUZQOFZJbnA1Mm53d2lXQkh3K1hnaVgrcjlnbzllWlBvN1RkWUl4SVpp?=
 =?utf-8?B?WVZpemVCcnQrTlBURDR2NWtzNWhiUnM3UzIrdU5qazNHem5rM1VFckVtTWRh?=
 =?utf-8?B?cEorT1NnTHcrUGl6RXU3Rmc0S2ZhT3U2UUhWSjhXSW45Z0o0dVRFaUZRN1Nv?=
 =?utf-8?B?cVIvYmRJaHczVDB0S2YrcWd5cWJZN1hLbCtkV3BIZlJVK2kxSXhGMmFqcFpS?=
 =?utf-8?B?cjZzZWtYZmhjVVVsMG5TdEpJQUhaaEdzcjVzc2VTWWNuQ0ZUOEVyR3Y0aWtv?=
 =?utf-8?B?dFREdzhZSHdKQzROV1UrM1JoaXlPYk1aS1Q2dHdoSXVwZjJsNmlpSkJRZE9i?=
 =?utf-8?B?d1h0SjVlV1VUcWRGaGlVa3h0blkzdmZ3dTFsUjNMOEdaSnBienJkL04rTDR3?=
 =?utf-8?B?d2tkZ1ZOSlNHZ1BSTFYrU2w4SUtSaUE1RHpqNVpBQ0N6UUliSU1aZG8wSy9R?=
 =?utf-8?B?SFV4aFh6Z3BPNzA2c3BWdUN3Z3AxN1BSNWhUdEpwb3ZUcGMvc251Q2U1OGZE?=
 =?utf-8?B?bGZuQjhJblNBYVdoSFFKV1NadTkwMVk3TmRKRDNyVzdsYVpaNDlBV2Q5eVZ5?=
 =?utf-8?B?QWxiNHptNGM4UUtTRmY0RW1qR1lXMTA5Vlg5OVdDb0owMDdiQmNyMUpUNzZM?=
 =?utf-8?Q?DqYE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7993a724-fa8d-4c18-89b4-08dc4780d48c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 19:23:02.6758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LJeavvRNqV/1F2fdRVr0wcvnsjfFp8OxKV0g4vSdVm6mwh4Xxl5zLUj9a4IVMCLf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4385

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaGluaCBOZ3V5ZW4gPFRoaW5o
Lk5ndXllbkBzeW5vcHN5cy5jb20+DQo+IFNlbnQ6IEZyaWRheSwgTWFyY2ggMTUsIDIwMjQgNjoz
MiBBTQ0KPiBUbzogU2ltZWssIE1pY2hhbCA8bWljaGFsLnNpbWVrQGFtZC5jb20+DQo+IENjOiBU
aGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+OyBQYW5kZXksIFJhZGhleSBT
aHlhbQ0KPiA8cmFkaGV5LnNoeWFtLnBhbmRleUBhbWQuY29tPjsgZ3JlZ2toQGxpbnV4Zm91bmRh
dGlvbi5vcmc7IGxpbnV4LQ0KPiB1c2JAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBnaXQgKEFNRC1YaWxpbngpDQo+IDxnaXRAYW1kLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2Ml0gdXNiOiBkd2MzOiBjb3JlOiBlbmFibGUgQ0NJIHN1cHBvcnQgZm9y
IEFNRC14aWxpbngNCj4gRFdDMyBjb250cm9sbGVyDQo+IA0KPiBPbiBUaHUsIE1hciAwNywgMjAy
NCwgTWljaGFsIFNpbWVrIHdyb3RlOg0KPiA+DQo+ID4NCj4gPiBPbiAzLzcvMjQgMDI6NDQsIFRo
aW5oIE5ndXllbiB3cm90ZToNCj4gPiA+IEhpLA0KPiA+ID4NCj4gPiA+IE9uIFR1ZSwgRmViIDI3
LCAyMDI0LCBQYW5kZXksIFJhZGhleSBTaHlhbSB3cm90ZToNCj4gPiA+ID4gPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPiA+IEZyb206IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1
eWVuQHN5bm9wc3lzLmNvbT4NCj4gPiA+ID4gPiBTZW50OiBTYXR1cmRheSwgRmVicnVhcnkgMjQs
IDIwMjQgNDozOCBBTQ0KPiA+ID4gPiA+IFRvOiBQYW5kZXksIFJhZGhleSBTaHlhbSA8cmFkaGV5
LnNoeWFtLnBhbmRleUBhbWQuY29tPg0KPiA+ID4gPiA+IENjOiBncmVna2hAbGludXhmb3VuZGF0
aW9uLm9yZzsgbGludXgtdXNiQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+ID4gPiA+ID4ga2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgZ2l0IChBTUQtWGlsaW54KSA8Z2l0QGFtZC5jb20+DQo+ID4g
PiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gdXNiOiBkd2MzOiBjb3JlOiBlbmFibGUgQ0NJ
IHN1cHBvcnQgZm9yIEFNRC0NCj4geGlsaW54DQo+ID4gPiA+ID4gRFdDMyBjb250cm9sbGVyDQo+
ID4gPiA+ID4NCj4gPiA+ID4gPiBPbiBGcmksIEZlYiAyMywgMjAyNCwgVGhpbmggTmd1eWVuIHdy
b3RlOg0KPiA+ID4gPiA+ID4gT24gU2F0LCBGZWIgMjQsIDIwMjQsIFJhZGhleSBTaHlhbSBQYW5k
ZXkgd3JvdGU6DQo+ID4gPiA+ID4gPiA+IEZyb206IFBpeXVzaCBNZWh0YSA8cGl5dXNoLm1laHRh
QGFtZC5jb20+DQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IFRoZSBHU0JVU0NGRzAgcmVn
aXN0ZXIgYml0cyBbMzE6MTZdIGFyZSB1c2VkIHRvIGNvbmZpZ3VyZSB0aGUNCj4gY2FjaGUgdHlw
ZQ0KPiA+ID4gPiA+ID4gPiBzZXR0aW5ncyBvZiB0aGUgZGVzY3JpcHRvciBhbmQgZGF0YSB3cml0
ZS9yZWFkIHRyYW5zZmVycw0KPiAoQ2FjaGVhYmxlLA0KPiA+ID4gPiA+ID4gPiBCdWZmZXJhYmxl
LyBQb3N0ZWQpLiBXaGVuIENDSSBpcyBlbmFibGVkIGluIHRoZSBkZXNpZ24sIERXQzMNCj4gY29y
ZQ0KPiA+ID4gPiA+IEdTQlVTQ0ZHMA0KPiA+ID4gPiA+ID4gPiBjYWNoZSBiaXRzIG11c3QgYmUg
dXBkYXRlZCB0byBzdXBwb3J0IENDSSBlbmFibGVkIHRyYW5zZmVycyBpbg0KPiBVU0IuDQo+ID4g
PiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFBpeXVzaCBNZWh0YSA8cGl5
dXNoLm1laHRhQGFtZC5jb20+DQo+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFJhZGhleSBT
aHlhbSBQYW5kZXkNCj4gPiA+ID4gPiA8cmFkaGV5LnNoeWFtLnBhbmRleUBhbWQuY29tPg0KPiA+
ID4gPiA+ID4gPiAtLS0tDQo+ID4gPiA+ID4gPiA+IGNoYW5nZXMgZm9yIHYyOg0KPiA+ID4gPiA+
ID4gPiBNYWtlIEdTQlVTQ0ZHMCBjb25maWd1cmF0aW9uIHNwZWNpZmljIHRvIEFNRC14aWxpbngg
cGxhdGZvcm0uDQo+ID4gPiA+ID4gPiA+IFRha2VuIHJlZmVyZW5jZSBmcm9tIGV4aXN0aW5nIGNv
bW1pdCBlYzVlYjQzODEzYTQgKCJ1c2I6IGR3YzM6DQo+IGNvcmU6DQo+ID4gPiA+ID4gPiA+IGFk
ZCBzdXBwb3J0IGZvciByZWFsdGVrIFNvQ3MgY3VzdG9tJ3MgZ2xvYmFsIHJlZ2lzdGVyIHN0YXJ0
DQo+IGFkZHJlc3MiKQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gUmVnYXJkaW5nIHRoYXQgY2hhbmdl
IGZyb20gUmVhbHRlaywgaXQncyBhIHNwZWNpYWwgY2FzZS4gSSB3YW50IHRvIGF2b2lkDQo+ID4g
PiA+ID4gZG9pbmcgcGxhdGZvcm0gc3BlY2lmaWMgY2hlY2tzIGluIHRoZSBjb3JlLmMgaWYgcG9z
c2libGUuIEV2ZW50dWFsbHksIEkNCj4gPiA+ID4gPiB3YW50IHRvIG1vdmUgdGhhdCBsb2dpYyBm
cm9tIFJlYWx0ZWsgdG8gaXRzIGdsdWUgZHJpdmVyLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gQlIs
DQo+ID4gPiA+ID4gVGhpbmgNCj4gPiA+ID4gVGhhbmtzLiBBcyB5b3Ugc3VnZ2VzdGVkIEkgdHJp
ZWQgInRlbXBvcmFyaWx5IG1lbW9yeSBtYXAgYW5kIHVwZGF0ZQ0KPiB0aGlzDQo+ID4gPiA+IHJl
Z2lzdGVyIGluIHlvdXIgWGlsaW54IGdsdWUgZHJpdmVyLiBJdHMgdmFsdWUgc2hvdWxkIHJldGFp
biBhZnRlciBzb2Z0DQo+IHJlc2V0Ii4NCj4gPiA+ID4NCj4gPiA+ID4gRGlkIGlvcmVtYXAgZm9y
IGNvcmUgcmVnaXN0ZXIgc3BhY2Ugb25jZSBhZ2FpbiBpbiBnbHVlIGRyaXZlciBidXQgaXQNCj4g
cmVzdWx0ZWQNCj4gPiA+ID4gaW4gYmVsb3cgZXJyb3I6DQo+ID4gPiA+IGR3YzMgZmUyMDAwMDAu
dXNiOiBjYW4ndCByZXF1ZXN0IHJlZ2lvbiBmb3IgcmVzb3VyY2UgW21lbQ0KPiAweGZlMjAwMDAw
LTB4ZmUyM2ZmZmZdDQo+ID4gPiA+IGR3YzMteGlsaW54IGZmOWQwMDAwLnVzYjogZXJyb3IgLUVC
VVNZOiBmYWlsZWQgdG8gbWFwIERXQzMgcmVnaXN0ZXJzDQo+ID4gPiA+DQo+ID4gPiA+IFNvIHRv
IGF2b2lkIHJlbWFwcGluZywgbm93IGdldCB0aGUgc3RydWN0IGR3YzMgcGxhdGZvcm0gZGF0YSBo
YW5kbGUgaW4NCj4gZ2x1ZQ0KPiA+ID4gPiBkcml2ZXIgYW5kIHBhc3MgaXQgdG8gZHdjM19yZWFk
bC93cml0ZWwoKSBsaWtlIHRoZSBiZWxvdyBzZXF1ZW5jZS4gSXMNCj4gdGhhdCBmaW5lPw0KPiA+
ID4gPiBJZiB5ZXMgSSB3aWxsIHJlc3BpbiB2MyB3aXRoIHRoZXNlIGNoYW5nZXMgYW5kIGFsc28g
ZG8gc29tZSBtb3JlDQo+ID4gPiA+IHNhbml0eSB0ZXN0cy4NCj4gPiA+ID4NCj4gPiA+ID4gZHJp
dmVycy91c2IvZHdjMy9kd2MzLXhpbGlueC5jDQo+ID4gPiA+ICNpbmNsdWRlICJpby5oIg0KPiA+
ID4gPg0KPiA+ID4gPiA8c25pcD4NCj4gPiA+ID4gcmV0ID0gb2ZfcGxhdGZvcm1fcG9wdWxhdGUo
bnAsIE5VTEwsIE5VTEwsIGRldik7DQo+ID4gPiA+IGlmIChyZXQpIHsNCj4gPiA+ID4gCWRldl9l
cnIoZGV2LCAiZmFpbGVkIHRvIHJlZ2lzdGVyIGR3YzMgY29yZSAtICVkXG4iLCByZXQpOw0KPiA+
ID4gPiAgICAgIGdvdG8gZXJyX2Nsa19wdXQ7DQo+ID4gPiA+IH0NCj4gPiA+ID4NCj4gPiA+ID4g
ZHdjM19ucCA9IG9mX2dldF9jb21wYXRpYmxlX2NoaWxkKG5wLCAic25wcyxkd2MzIik7DQo+ID4g
PiA+IHByaXZfZGF0YS0+ZHdjMyA9IG9mX2ZpbmRfZGV2aWNlX2J5X25vZGUoZHdjM19ucCk7DQo+
ID4gPiA+IGR3YyA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKHByaXZfZGF0YS0+ZHdjMyk7DQo+ID4g
PiA+IGlmIChvZl9kbWFfaXNfY29oZXJlbnQoZGV2LT5vZl9ub2RlKSkgew0KPiA+ID4gPiAJcmVn
ID0gZHdjM19yZWFkbChkd2MtPnJlZ3MgLCBEV0MzX0dTQlVTQ0ZHMCk7DQo+ID4gPiA+IAlyZWcg
fD0gRFdDM19HU0JVU0NGRzBfREFUUkRSRVFJTkZPX01BU0sgfA0KPiA+ID4gPiAgICAgICAgICAg
ICAgICBEV0MzX0dTQlVTQ0ZHMF9ERVNSRFJFUUlORk9fTUFTSyB8DQo+ID4gPiA+ICAgICAgICAg
ICAgICAgIERXQzNfR1NCVVNDRkcwX0RBVFdSUkVRSU5GT19NQVNLIHwNCj4gPiA+ID4gICAgICAg
ICAgICAgICAgRFdDM19HU0JVU0NGRzBfREVTV1JSRVFJTkZPX01BU0s7DQo+ID4gPg0KPiA+ID4g
SXQncyBhIGJpdCBvZGQgdG8gdXNlICJtYXNrIiBhcyB2YWx1ZSBpbnN0ZWFkIG9mIHNvbWUgZGVm
aW5lZA0KPiA+ID4gbWFjcm9zL3ZhbHVlcy4NCj4gPiA+DQo+ID4gPiA+IAlkd2MzX3dyaXRlbChk
d2MtPnJlZ3MgLCBEV0MzX0dTQlVTQ0ZHMCwgcmVnKTsNCj4gPiA+ID4gfQ0KPiA+ID4gPg0KPiA+
ID4NCj4gPiA+IFBlcmhhcHMgaXQgbWF5IGJlIGJldHRlciB0byBhZGQgYSBuZXcgaW50ZXJmYWNl
IGZvciB0aGUgY29yZSB0byBpbnRlcmFjdA0KPiA+ID4gd2l0aCB0aGUgZ2x1ZSBkcml2ZXJzLiBU
aGUgY29yZSBjYW4gdXNlIHRoZXNlIGNhbGxiYWNrcyB0byBwcm9wZXJseSBzZXQNCj4gPiA+IHBs
YXRmb3JtIHNwZWNpZmljIGNvbmZpZ3VyYXRpb24gYXQgc3BlY2lmaWVkIHNlcXVlbmNlIG9mIHRo
ZSBjb250cm9sbGVyDQo+ID4gPiBpbml0aWFsaXphdGlvbi4gSXQgd2lsbCBiZSBiZXR0ZXIgZGVm
aW5lZCBhbmQgbW9yZSBwcmVkaWN0YWJsZSB0aGFuIHdoYXQNCj4gPiA+IHdlIGhhdmUgaGVyZS4g
V2hhdCBkbyB5b3UgdGhpbms/DQo+ID4NCj4gPiBOb3Qgc3VyZSBJIGZ1bGx5IHVuZGVyc3RhbmQg
d2hhdCB5b3UgbWVhbiBieSBtb3JlIHByZWRpY3RhYmxlLg0KPiA+IEFyZSB5b3UgYXNraW5nIGZv
ciBzaW1wbGUgcmVhZC93cml0ZSBpbnRlcmZhY2UgdG8gZHdjMyBjb3JlIElQPw0KPiA+IERvIHlv
dSB3YW50IHRoZXJlIGFueSBsaW1pdGF0aW9uIGZvciBhY2Nlc3NlcyB0byBiZSBhYmxlIHRvIGNv
bnRyb2wgaXQ/DQo+ID4NCj4gPiBJIGRvbid0IHRoaW5rIHdlIGhhdmUgYW55IGlzc3VlIHdpdGgg
eW91ciBzdWdnZXN0aW9uIGJ1dCBpdCBpcyB1bmNsZWFyIGhvdw0KPiA+IGV4YWN0bHkgaXQgc2hv
dWxkIGxvb2sgbGlrZS4NCj4gPiBDYW4geW91IHBsZWFzZSBza2V0Y2ggaXQ/DQo+ID4NCj4gDQo+
IEhpLA0KPiANCj4gU29ycnksIG15IHN1Z2dlc3Rpb24gd291bGQgcmVxdWlyZSBhIGhhbmRsZXIg
Zm9yIHRoZSBnbHVlIGRyaXZlciBhbmQgdGhlDQo+IGNvcmUuIEJ1dCB0aGUgdmFyaW91cyBpbXBs
ZW1lbnRhdGlvbnMgaW4gZGlmZmVyZW50IGdsdWUgZHJpdmVycyBhcmUNCj4gaGFuZGxlZCBpbiBz
dWNoIGEgd2F5IHRoYXQgd29uJ3QgYmUgc2ltcGxlIHRvIHBhc3MgdGhpcyBoYW5kbGUgYXJvdW5k
Lg0KPiBUaGlzIGNhbiBnZXQgaGFpcnkgcXVpY2tseS4uLg0KPiANCj4gTGV0J3Mgc2NyYXRjaCB3
aGF0IEkgc3VnZ2VzdGVkLg0KPiANCj4gSW5zdGVhZCwgcGVyaGFwcyB3ZSBjYW4gZG8gaXQgYXMg
Zm9sbG93aW5nOg0KPiAgKiBLZWVwIHRoZSBzZXR0aW5nIG9mIHRoZSBjb250cm9sbGVyIHJlZ2lz
dGVycyBpbiB0aGUgY29yZQ0KPiAgKiBDcmVhdGUgYSBzb2Z0d2FyZV9ub2RlIHRvIHBhc3MgYSBz
b2Z0d2FyZSBwcm9wZXJ0eSB0byB0aGUgY29yZQ0KVGhhbmtzLiBCeSBzb2Z0d2FyZSBwcm9wZXJ0
eSB5b3UgbWVhbiBmbGFncyBvciBjYXBzIHRoYXQgY2FuIGJlIHBhc3NlZA0KZ2x1ZSBkcml2ZXJz
IHRvIGR3YzMgY29yZSBkcml2ZXIgPw0KDQpkd2MzX3NldF9xdWlya3Moc3RydWN0IGR3YzMgKmR3
YywgdTY0IGZsYWdzKTsNCg0KRGVmaW5lcyBxdWlya3MgaW4gY29yZS5oDQoNCkRXQzNfRkxBR1Nf
Q09NTU9ODQpEV0MzX1hMTlhfQ0NJDQpEV0MzX1hMTlhfSVBEDQpEV0MzX1JFQUxURUtfUkVTX0ZJ
WA0KDQpUaGVuIGJhc2VkIG9uIHRoZXNlIHF1aXJrcy9mbGFncyBwcm9ncmFtIGl0IGluIGNvcmUu
Yy4NCklzIHRoaXMgYXBwcm9hY2ggZmluZSBhbmQgYWxpZ25lZCB3aXRoIHlvdXIgdGhvdWdodHM/
DQoNClRoYW5rcywNClJhZGhleQ0KDQo+IA0KPiBUaGVzZSBzb2Z0d2FyZSBwcm9wZXJ0aWVzIHdp
bGwgbm90IGJlIGRvY3VtZW50ZWQgaW4gdGhlIGRldmljZXRyZWUNCj4gYmluZGluZy4gSnVzdCBk
b2N1bWVudCB0aGVtIGluIHRoZSBkcml2ZXIgY29yZSBoZWFkZXIuIFRoZXkgYXJlIHNpbXBseQ0K
PiBkcml2ZXIgcHJvcGVydGllcyB0aGF0IGdldCBwYXNzZWQgdGhyb3VnaCBzb2Z0d2FyZSBub2Rl
Lg0KPiANCj4gWW91IGNhbiBhZGQgdGhlIHNvZnR3YXJlIG5vZGUgdXNpbmcgZGV2aWNlX2FkZF9z
b2Z0d2FyZV9ub2RlKCkuIFRoaXMgY2FuDQo+IGJlIGRvbmUgYmVmb3JlIGNhbGxpbmcgb2ZfcGxh
dGZvcm1fcG9wdWxhdGUoKSBpbiBkd2MzLXhpbGlueCAoY2FuIGJlDQo+IGRvbmUgaW4gcGx0Zm1f
aW5pdCgpKQ0KPiANCj4gTGV0IG1lIGtub3cgaWYgdGhpcyB3b3JrcyBmb3IgeW91Lg0KPiANCj4g
VGhhbmtzLA0KPiBUaGluaA0K


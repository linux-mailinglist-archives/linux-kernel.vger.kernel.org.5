Return-Path: <linux-kernel+bounces-83902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2162869FF0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67C9C2923C9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1AC51C46;
	Tue, 27 Feb 2024 19:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VMqqDSE1"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D144F8B1;
	Tue, 27 Feb 2024 19:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709061194; cv=fail; b=Pjo4+1CTjUOXphHyAzda7pKUO6PA4MPqm0DRN9RI70RmDKZTNpxY8otn+ksibe4KFXU3j+c9J0ySfijja5Dg0ER+lcQ004DKpqvFEjCpijt/ETfB+QORXb8U+HgVQsQ0nkoyDiH2UUOYz+XoEYMzpzMkVAG8QcRp02J/4Sm8Cwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709061194; c=relaxed/simple;
	bh=oj6yOcm98pFCKGc0yYkfYrOCUuZkAEbbXxuhp35wicU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ew+/j4hFLMVy2WbgMQrTNvt+K4UbRG5Phj4IWQLNM3n+etHaugZZn6kOmHIshyYXknvhyGVmTSeE0r2SqRDBeYDuhZhdAMSwMuXfR6/TKG55VwvI6YpnBAYp/Jlu0Ueo0H/M1ZEeR9sYVZeiPa9Gzf/rYWkKZ4t76OWyp4QjZhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VMqqDSE1; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BH6knvd6Ju7KGzVIuUAsYVPuLRsGtHLkVkav9dckPEG6KU2WAkkxF3SRxA3I2NIPJrpSdANaYvamodDAygF1CfsCp4ceWAoTBKceOSBxL4MstdEhXxuVrZmTgnwt7+GgQfQ53MAwAB98SjKUzYeXCI1/vy6eu6gl1u1WegEtNx9r5DoYCn8C2XOlXmBWiV+Jg/J+Ifa6ewhLyNlL8rX1Xj9BzWf7x4SIGTLyP2BRvcrYaMXZSsK0YkQrtUlk2LOWErB6B/1zGdIiwiYIXhAt0XxuDpj7b5PzFpbCpW6axUXax4c182YaY35xSKTH+aihBsmeilJbEqwX55TMXNf5/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oj6yOcm98pFCKGc0yYkfYrOCUuZkAEbbXxuhp35wicU=;
 b=J815LSlEC6Lqq1Ufyt3sIX7Z1wIGt9nKxK2J9VXeO8BZl7nPuPwCpcQn6JuvT8yUL4axzdChMQdg4BLZJ7RRgT7zsCU5baLjn0MhYbxaftkkGqvUCBAyjJ9Wu55hL83HZKwoiAcp5jyNLpYfoYhpnNhNPcPE/rbcHhAqheuvBGgoUMTvmcGvi16kdPBGdUsM2q+JZhVgofYLWTbvO/coNh1c+bmcJQ7osGm0vDxf/q3mumRK4x6S+ZIWlqBNQvRtYUy5R1rpMltRIsAA8xo8wpoLvgVb9xUmVWwffwO7RejMo7TUB+aM/VBrHrqJqJBS8X8INt6Wn4m+7MyVKJ+vkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oj6yOcm98pFCKGc0yYkfYrOCUuZkAEbbXxuhp35wicU=;
 b=VMqqDSE12uh5bNBPnkl0qhflwQDq+l/VrXhtbgnSfAVUEcz/f9sRkC3lTl4o1MmQKeQmB4TThu7rbAXIEbhzKFTuRAw39aLN0W3Poad/WySKXqwUQ7rZeL7YW6ZVEONaccTXNkZ2kj9LWhNiQ7KCW4MQH4GQOyM1m8/2guHrhGA=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by BN9PR12MB5291.namprd12.prod.outlook.com (2603:10b6:408:104::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Tue, 27 Feb
 2024 19:13:09 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::ca5b:3117:e891:239c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::ca5b:3117:e891:239c%4]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 19:13:09 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "git
 (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v2] usb: dwc3: core: enable CCI support for AMD-xilinx
 DWC3 controller
Thread-Topic: [PATCH v2] usb: dwc3: core: enable CCI support for AMD-xilinx
 DWC3 controller
Thread-Index: AQHaZpDns4R4mqNUg0q8M2eTTuX0u7EYiAqAgAAFHYCABgNyMA==
Date: Tue, 27 Feb 2024 19:13:09 +0000
Message-ID:
 <MN0PR12MB5953B24F0CB175D8C167E73FB7592@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <1708717523-4006664-1-git-send-email-radhey.shyam.pandey@amd.com>
 <20240223224940.y34qflo2azxrvksy@synopsys.com>
 <20240223230758.s7rodlxbsfa44frw@synopsys.com>
In-Reply-To: <20240223230758.s7rodlxbsfa44frw@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|BN9PR12MB5291:EE_
x-ms-office365-filtering-correlation-id: 64a3dfa8-803a-40b4-e6e1-08dc37c822cc
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ArcfYzcmooIDIi7TX2lcs10y+7qJbFy54f/3/l+N3+He/MMozrGxH0DZe7RKxV+IXi83iE25/gtBJNzmCOiH3DSBTAn34PAKPF8onvJmCHoBGpMj/fCFrW1kqPsbmIN3gt4CgHDwuL7ZSVs47bmjjyViBoJ0Q2xFqL9Gyzou2LYB6VM56rmoXPuj1R+wk94EWhwaK2CAAw6BFQwvvVr3MxXdDsdku7ZpXSyWa5qRR/xIVMcLrgNSFsln6dj+533HuGNh977iAfQ4SbmbLhgpPs3TrGOgjN7NCKU2EAegx2YsVNpBjgDnEje2uK4oGUU4RrpdLkMY4gZ76JlMbmQNZ9tx6NeQOvBKwgTEuIRG5XGiK+u6gWrcW5C/yboDwZx0tWxagXtR4wB9YGrTuvqOWtGjSJoZiHPZTiw5drc2bET4gHkDmsowcWQtpQb1+vySonp02Z0nnhdGDc6Ao64IFtW5es5FPna8EkXs1/IZWbJoyhHpWD7LbpsBz1nKAn0QU8afUyewB+EN9V7VvWKXE/9aD4dt1SAQYq8zBGIthoR407P6GaJHMd9rP22b8QkqVyejzb/ae7my6+w1Q6ybvPRMmi2/AI5rMcgeOUOgvkrh+5HWglnC68bpem2duy8R2u+ot0HxVNavIrhSIcRVgvXmqZeAlkYSgqLBTS54xW9GbpD8JEH01Yxjgy/InkD9915WxgmXyv1W1qibryXyyv6XDHC9gwmQ3AStgv8HDDk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b1doL1Q0NzhtQm9TUy9KQlhFT1FCNU82ZXNlVmVTMmNYNFRZSXJ6S3c3eUx6?=
 =?utf-8?B?WFFROXNRbDI2THNwVDh5KzFKTnl6WTNxaC95ampwQWo3Q1BrcUNzL0xNME14?=
 =?utf-8?B?SXFFNm9Lc0hRTWlEYTdIdjFlT3dPRGd1bWxld1VXOXhiNlhCU3h6V3RXektm?=
 =?utf-8?B?YmZMU1greEFsSWh3MmxMaW9DUlREcVRqK05mWnZ4c3R0bHBLMVFqakNHT21I?=
 =?utf-8?B?Qm55NTcxQ053MVpPa3pCU210M2cyOTZFTXFSSGplbXVjVTdXZXNIcktsNWtk?=
 =?utf-8?B?ckpBSmpqVFhEazFvMUpoVXpkQ0JFQlVpd3hkdmh4QVNTclBXQlZFTlUyejht?=
 =?utf-8?B?WHRuWGU1SEVJVnFoVzlaS2crR1g0c3pPK0RnUy9rekZhMS80aEpGTHd2S3J5?=
 =?utf-8?B?L084WllTcFpzV1ViS2MwRlJpdGp5amFoSGVab3A4a21FVU1sZXE4Q0w3dDRD?=
 =?utf-8?B?Z01OVmRhYWdWNXR2dnFNNDJCSnhnZDZVU1NXN0FSTi9pWG95SGprUlVLbEpD?=
 =?utf-8?B?MU55MFAyaFhUYktHUFQrWW9EblVxT0ZFREZVdDJITXliVkRHQUg3YkhRN1pP?=
 =?utf-8?B?SE9LUTFxaWRmMEZNL1RtemdFWDFma0JCb00wL1ZObnJzcXM2d0ZsVlZzWjcw?=
 =?utf-8?B?bXBleGFaT2tDbmNWK1NBWUxndmJoSHVmait2MGlMVks3TDc2RS85em42M0xy?=
 =?utf-8?B?Z1VWeHAvN1dUWXNBeG4xVzNwT3p2dGVmMzJXeGkwV3pFS0ZnN1V0OU93a3Vm?=
 =?utf-8?B?bTh4UVlnOHdEUklqcDdMN2FXYU9GV3U2L0JLcllwS3JkMFFWVFJlV3NLVXFV?=
 =?utf-8?B?SlpHSmhCR2dQSjRkZ0VVMGVYZEJzUHVMcmhxbVU1VXE0RlVvYVZSUnFTZ0tH?=
 =?utf-8?B?a0ZxQVljUERUNUIraGxaM0pBN2ZYMWMyVkkveS9XVHhqdTVVUy80NjZ6NGhN?=
 =?utf-8?B?NTdpYUtERHNiUzlwWWVBZnVjcmNLbExhek1kNDVZMEtmUHorZGlCVjhyQ25o?=
 =?utf-8?B?V2xvbStNN2dQT0tIV1NxR0tPYmV6c2JwNmJQN0FBVm9jdGFqQjhKczBMcnBr?=
 =?utf-8?B?RlpRbmFuQUlzWGlwM2RmaDdqb3hlcklCRW9qbnZFUXZ1NGV2S1hSZUpMSUdn?=
 =?utf-8?B?c3dEU2s0c2xJNnFyaVFERkFFM1puaHBkUXNtZkFSMitJZHJXeU9oOXJMeU9r?=
 =?utf-8?B?cm9lWEE0d0JXL2gxSmV6Y1pnd09kT2g1M1hZdXAraXRxMTlIRlplZE9xYVJG?=
 =?utf-8?B?bzQ1cmloWGRFNVl2T1crT1VGNFViR2dSMDJKN0haQmJzRmVLYnl6OGhIQjdU?=
 =?utf-8?B?NmpNTmVIN0hFYjlGdDA3bDdEOGQ3Z3Z4NTFaZkphd1Vubm9LNllhTjAvaTNW?=
 =?utf-8?B?Rk85TkgyOUtSYkxqaWEyM0JhMXllc3R0V21IM3Q5SklnZ2JEQ1VUK2RBZ1VI?=
 =?utf-8?B?ZGkxMUJobmV6alVNbzhLaWRFNzZXM3U1YUxUOUtLc2RrYlJFS2pWNXkwSGtP?=
 =?utf-8?B?ZUYzWTdOQzVXM2k2WWJRUzI2ZWNQSHV6ZUtvd05NcWhjRGpzYjZScUNIQUFU?=
 =?utf-8?B?WCtCTzlRV3V0M20zTnp1d0ZBOGg4QTBYQTdLNXlTVWFwUVFrWXNwMHYzNC9n?=
 =?utf-8?B?V0FXaDBZeEpyaFpSN01PRVRkUWtEYkplcFlWOWErY3B6UUNRd1A5dEVtRCtj?=
 =?utf-8?B?SkUxZXdlUmZxYUtDYnlOYnRyalgzSmFna0ZObE1Wd1BseDUxbXlEK2gwc2dZ?=
 =?utf-8?B?alh0UUord2Y1Znpkd0diWDZsL2daWW1KdnlPd2tkb2tuK2NwYk5DNE1kVVBT?=
 =?utf-8?B?MnpzSGx2MEZwbWYzOExQSzdGTnJSWmNaMnY5L3pRZTQvQlE5cyttUnArb2Fj?=
 =?utf-8?B?VGlKWHpXSU9BMUlmTVNUYmViZE9reVE0OHpDZjhTQ09GUDU4RVYxSllKOVJP?=
 =?utf-8?B?bWpuM1lscS9oQ0k5SXY4VzNqOWxPQzkvZERNVFFGUFIwVU1sR2ZMZnVDNzRM?=
 =?utf-8?B?VzFGcFVqMDRlM1VVQkpTWVhwU2lXSlVmRjNjLzZ5M3o2a0JxanFFOGloQWsw?=
 =?utf-8?B?dEw4dDU3YUp5LzdrcDFabyt0ZS9IL08zNXZCTkVtL1I1VEZoOUVsRGRiSE82?=
 =?utf-8?Q?hCOE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 64a3dfa8-803a-40b4-e6e1-08dc37c822cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 19:13:09.6062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K5JIQ0SN13j7J55fSKMu/w1TZVrF2kJSwRXdnSZCITcQWHp9qJG6vyiRC9dicsK7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5291

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaGluaCBOZ3V5ZW4gPFRoaW5o
Lk5ndXllbkBzeW5vcHN5cy5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBGZWJydWFyeSAyNCwgMjAy
NCA0OjM4IEFNDQo+IFRvOiBQYW5kZXksIFJhZGhleSBTaHlhbSA8cmFkaGV5LnNoeWFtLnBhbmRl
eUBhbWQuY29tPg0KPiBDYzogZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IGxpbnV4LXVzYkB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBnaXQgKEFN
RC1YaWxpbngpIDxnaXRAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gdXNiOiBk
d2MzOiBjb3JlOiBlbmFibGUgQ0NJIHN1cHBvcnQgZm9yIEFNRC14aWxpbngNCj4gRFdDMyBjb250
cm9sbGVyDQo+IA0KPiBPbiBGcmksIEZlYiAyMywgMjAyNCwgVGhpbmggTmd1eWVuIHdyb3RlOg0K
PiA+IE9uIFNhdCwgRmViIDI0LCAyMDI0LCBSYWRoZXkgU2h5YW0gUGFuZGV5IHdyb3RlOg0KPiA+
ID4gRnJvbTogUGl5dXNoIE1laHRhIDxwaXl1c2gubWVodGFAYW1kLmNvbT4NCj4gPiA+DQo+ID4g
PiBUaGUgR1NCVVNDRkcwIHJlZ2lzdGVyIGJpdHMgWzMxOjE2XSBhcmUgdXNlZCB0byBjb25maWd1
cmUgdGhlIGNhY2hlIHR5cGUNCj4gPiA+IHNldHRpbmdzIG9mIHRoZSBkZXNjcmlwdG9yIGFuZCBk
YXRhIHdyaXRlL3JlYWQgdHJhbnNmZXJzIChDYWNoZWFibGUsDQo+ID4gPiBCdWZmZXJhYmxlLyBQ
b3N0ZWQpLiBXaGVuIENDSSBpcyBlbmFibGVkIGluIHRoZSBkZXNpZ24sIERXQzMgY29yZQ0KPiBH
U0JVU0NGRzANCj4gPiA+IGNhY2hlIGJpdHMgbXVzdCBiZSB1cGRhdGVkIHRvIHN1cHBvcnQgQ0NJ
IGVuYWJsZWQgdHJhbnNmZXJzIGluIFVTQi4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBQ
aXl1c2ggTWVodGEgPHBpeXVzaC5tZWh0YUBhbWQuY29tPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTog
UmFkaGV5IFNoeWFtIFBhbmRleQ0KPiA8cmFkaGV5LnNoeWFtLnBhbmRleUBhbWQuY29tPg0KPiA+
ID4gLS0tLQ0KPiA+ID4gY2hhbmdlcyBmb3IgdjI6DQo+ID4gPiBNYWtlIEdTQlVTQ0ZHMCBjb25m
aWd1cmF0aW9uIHNwZWNpZmljIHRvIEFNRC14aWxpbnggcGxhdGZvcm0uDQo+ID4gPiBUYWtlbiBy
ZWZlcmVuY2UgZnJvbSBleGlzdGluZyBjb21taXQgZWM1ZWI0MzgxM2E0ICgidXNiOiBkd2MzOiBj
b3JlOg0KPiA+ID4gYWRkIHN1cHBvcnQgZm9yIHJlYWx0ZWsgU29DcyBjdXN0b20ncyBnbG9iYWwg
cmVnaXN0ZXIgc3RhcnQgYWRkcmVzcyIpDQo+IA0KPiBSZWdhcmRpbmcgdGhhdCBjaGFuZ2UgZnJv
bSBSZWFsdGVrLCBpdCdzIGEgc3BlY2lhbCBjYXNlLiBJIHdhbnQgdG8gYXZvaWQNCj4gZG9pbmcg
cGxhdGZvcm0gc3BlY2lmaWMgY2hlY2tzIGluIHRoZSBjb3JlLmMgaWYgcG9zc2libGUuIEV2ZW50
dWFsbHksIEkNCj4gd2FudCB0byBtb3ZlIHRoYXQgbG9naWMgZnJvbSBSZWFsdGVrIHRvIGl0cyBn
bHVlIGRyaXZlci4NCj4gDQo+IEJSLA0KPiBUaGluaA0KVGhhbmtzLiBBcyB5b3Ugc3VnZ2VzdGVk
IEkgdHJpZWQgInRlbXBvcmFyaWx5IG1lbW9yeSBtYXAgYW5kIHVwZGF0ZSB0aGlzIA0KcmVnaXN0
ZXIgaW4geW91ciBYaWxpbnggZ2x1ZSBkcml2ZXIuIEl0cyB2YWx1ZSBzaG91bGQgcmV0YWluIGFm
dGVyIHNvZnQgcmVzZXQiLg0KDQpEaWQgaW9yZW1hcCBmb3IgY29yZSByZWdpc3RlciBzcGFjZSBv
bmNlIGFnYWluIGluIGdsdWUgZHJpdmVyIGJ1dCBpdCByZXN1bHRlZA0KaW4gYmVsb3cgZXJyb3I6
DQpkd2MzIGZlMjAwMDAwLnVzYjogY2FuJ3QgcmVxdWVzdCByZWdpb24gZm9yIHJlc291cmNlIFtt
ZW0gMHhmZTIwMDAwMC0weGZlMjNmZmZmXQ0KZHdjMy14aWxpbnggZmY5ZDAwMDAudXNiOiBlcnJv
ciAtRUJVU1k6IGZhaWxlZCB0byBtYXAgRFdDMyByZWdpc3RlcnMNCg0KU28gdG8gYXZvaWQgcmVt
YXBwaW5nLCBub3cgZ2V0IHRoZSBzdHJ1Y3QgZHdjMyBwbGF0Zm9ybSBkYXRhIGhhbmRsZSBpbiBn
bHVlDQpkcml2ZXIgYW5kIHBhc3MgaXQgdG8gZHdjM19yZWFkbC93cml0ZWwoKSBsaWtlIHRoZSBi
ZWxvdyBzZXF1ZW5jZS4gSXMgdGhhdCBmaW5lPyANCklmIHllcyBJIHdpbGwgcmVzcGluIHYzIHdp
dGggdGhlc2UgY2hhbmdlcyBhbmQgYWxzbyBkbyBzb21lIG1vcmUgDQpzYW5pdHkgdGVzdHMuDQoN
CmRyaXZlcnMvdXNiL2R3YzMvZHdjMy14aWxpbnguYw0KI2luY2x1ZGUgImlvLmgiDQoNCjxzbmlw
Pg0KcmV0ID0gb2ZfcGxhdGZvcm1fcG9wdWxhdGUobnAsIE5VTEwsIE5VTEwsIGRldik7DQppZiAo
cmV0KSB7DQoJZGV2X2VycihkZXYsICJmYWlsZWQgdG8gcmVnaXN0ZXIgZHdjMyBjb3JlIC0gJWRc
biIsIHJldCk7DQogICAgZ290byBlcnJfY2xrX3B1dDsNCn0NCg0KZHdjM19ucCA9IG9mX2dldF9j
b21wYXRpYmxlX2NoaWxkKG5wLCAic25wcyxkd2MzIik7DQpwcml2X2RhdGEtPmR3YzMgPSBvZl9m
aW5kX2RldmljZV9ieV9ub2RlKGR3YzNfbnApOw0KZHdjID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEo
cHJpdl9kYXRhLT5kd2MzKTsNCmlmIChvZl9kbWFfaXNfY29oZXJlbnQoZGV2LT5vZl9ub2RlKSkg
ew0KCXJlZyA9IGR3YzNfcmVhZGwoZHdjLT5yZWdzICwgRFdDM19HU0JVU0NGRzApOw0KCXJlZyB8
PSBEV0MzX0dTQlVTQ0ZHMF9EQVRSRFJFUUlORk9fTUFTSyB8DQogICAgICAgICAgICAgIERXQzNf
R1NCVVNDRkcwX0RFU1JEUkVRSU5GT19NQVNLIHwNCiAgICAgICAgICAgICAgRFdDM19HU0JVU0NG
RzBfREFUV1JSRVFJTkZPX01BU0sgfA0KICAgICAgICAgICAgICBEV0MzX0dTQlVTQ0ZHMF9ERVNX
UlJFUUlORk9fTUFTSzsNCglkd2MzX3dyaXRlbChkd2MtPnJlZ3MgLCBEV0MzX0dTQlVTQ0ZHMCwg
cmVnKTsNCn0NCg0KVGhhbmtzLA0KUmFkaGV5DQo=


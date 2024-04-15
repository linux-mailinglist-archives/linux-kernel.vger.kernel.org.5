Return-Path: <linux-kernel+bounces-145748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFC48A5A59
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E94A01C22551
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A73D155A4F;
	Mon, 15 Apr 2024 19:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F1siVqXE"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4802313B78F;
	Mon, 15 Apr 2024 19:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713207977; cv=fail; b=pGmsWL6ur0+VPnWSsUBjOzeRbFoI6bPF5FNiq3YJi97zqBKfh2IUwyaoqJx71ZUMKylwLErOdqppE7a7Ec2c8J1JJPhsjbp0G4BZPH9XoeUisw64BJjqE4H50gns+0rHmJoQfhL9aUv/AvN9q04I18HmFJ2fMlg8+JSXwHnDV9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713207977; c=relaxed/simple;
	bh=QFPRkf2gJzJlDalPIsdqtVI+fw9d4ZB5LOB9nqwEo2c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KQvoQKaq2rPPtT5zK6lwEMMsLmekJp7XclXIRwwGuvteAKyTFzGvSaBydw4C0oGeeWPzd7umlxR+Jm4gVSs92FvLWq2wiUA9VNB14vITzBMSUQfi3yVj2y0DBGUjWSPSv/c+8xqGj3YFmej9A6a7G1/Ex7TE3s7JNkcg8X79UaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F1siVqXE; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+zrFXAIvW0Y/AxE0b0eP2JNbPRpw54IezicVBmF33OwlfWUy+3ZvHnZr/j4Eaa5ZCW0d9NSC5sk8Jg+/9ax1ni2rnQLmVQia4zzRdQsBQ91XDUFxizhoy9Ic9FF1STCFKBFkCABx9Dxt44RSK4fDMf4JylAG2S9yn1vAu1HT1cRAD+HjXfZWzlrIfgxQmCy7EEMfpsf38aIez5g4Wkg8ZAyMgr6ESClwwHnW7dEZCHqUkweiwBBkE20TwPsoNIFMS9RuY7vf6q3IQ2u7PpZIvQ5F3KoJi004MK89LC4r0jNBSQ+PU+Wwv4T+Bbt1q3u93f5YHBK+lrL8v3/V+98ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFPRkf2gJzJlDalPIsdqtVI+fw9d4ZB5LOB9nqwEo2c=;
 b=ZnU1DU6j1qiSJmoRhDeiciiRUjY6QsTghFipl/iekvknnmXAsWgtQXRA/5dwt0l9xTU7AKN/wF1eME3zRQHsXDOMMMQExrREwBRBKcfH39YPPoXkS8hruF0mIApN1GtdaKQtJ9/4oxMtDV32fBe5YVJ9f1ka9/Ok41naaxLzSXoZMYqmSPIXI7BNjnoH3QuaJ5fmLIjf7413EJfPKOt8GTYCjCYjZ2ytYHGLWbtzlpD35y7mHYXaesAeBRB0nZc3rCan9XgqB2q/0ho7K+1FQwQHB9AmZ0weI+sBbwaw5MRctFpc4SegwHXJxcNO/J+H1LxqkLJq/KvQCAx0+WWPwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFPRkf2gJzJlDalPIsdqtVI+fw9d4ZB5LOB9nqwEo2c=;
 b=F1siVqXEkTttCK/K1bUeOpzichS7jShg9ORWizDu/DYcYbX9W7FvxmKCCR4G931PeLQJsnuDImynqNy5H1EVMbhz5/ISdSpv/W+3NU/gaoywC7FPpNKAOH/PJhnzRV+uejq21haUOqvkMVyoWmL3J/HIGWscUDgOj8dNiYQSWZM=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by SN7PR12MB8129.namprd12.prod.outlook.com (2603:10b6:806:323::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 19:06:12 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::fa86:a86d:f94b:390d]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::fa86:a86d:f94b:390d%3]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 19:06:12 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>, Rob Herring <robh+dt@kernel.org>
CC: "Simek, Michal" <michal.simek@amd.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v2] usb: dwc3: core: enable CCI support for AMD-xilinx
 DWC3 controller
Thread-Topic: [PATCH v2] usb: dwc3: core: enable CCI support for AMD-xilinx
 DWC3 controller
Thread-Index:
 AQHaZpDns4R4mqNUg0q8M2eTTuX0u7EYiAqAgAAFHYCABgNyMIANBCqAgABlE4CADCG+AIAF4kowgAH1lACAKgmrIA==
Date: Mon, 15 Apr 2024 19:06:12 +0000
Message-ID:
 <MN0PR12MB59536B21229DE2FB64200B70B7092@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <1708717523-4006664-1-git-send-email-radhey.shyam.pandey@amd.com>
 <20240223224940.y34qflo2azxrvksy@synopsys.com>
 <20240223230758.s7rodlxbsfa44frw@synopsys.com>
 <MN0PR12MB5953B24F0CB175D8C167E73FB7592@MN0PR12MB5953.namprd12.prod.outlook.com>
 <20240307014402.omtcsltp4pxpraf7@synopsys.com>
 <5e87b406-3301-410b-a479-d561d5b19f62@amd.com>
 <20240315010142.qmgx7dugwwb2ort2@synopsys.com>
 <MN0PR12MB59533C758566BC5A98588D74B72D2@MN0PR12MB5953.namprd12.prod.outlook.com>
 <20240320004810.6omwumwbcxk5as4k@synopsys.com>
In-Reply-To: <20240320004810.6omwumwbcxk5as4k@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|SN7PR12MB8129:EE_
x-ms-office365-filtering-correlation-id: 16716fcd-679d-4f12-5fb6-08dc5d7f1ded
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 C0yhy0dBr5Qg/ASqeZ8FH2F/grXSBexXb/SM5u/tGmMTGm/wyFEKdfr89QRWsCsB4EvO/sEHzSAXwMtYqipLpuZqx4/inobZpfSC6iDnZ3W7Xj8bBdkT+Cj5xidB/u7q+WEDvv3NAej1V24yOJ1zMilfeJVoQpQKu7n/I9wUTskaqjzcCpbx3dCWBQe542i7aKoZD2RhYI8tW6yic6+IihjO5N6Zlsz5sy1OgjGeFZBpjh/4HGCVVApuYg9pR8EoJ0ow9mXnfmrpNVsVXfY8pbmx0OGXC88sXxv7BKgbKmRZxuaTXa9dfysJ4XliB8LiYhPjL4aNTwf1XhrnCnF2SoYhB/NoJUuyZteDMeui8FvcR4Kaqjhyp/fNJV58DX19CPgpjWQu2oZsegKkyRrTE8v5lT7Y1+iKzYkLo7Gdh+bNyCUtcX5+Z24oIJQqDNKboa09x/jWbgW2q3LQUSPRRu/St+x2pgBF1q3OOtEjXXIFZ383a6vsszsIMlQT3okJZaOJMj6vnzn2ROMWIV2xt8Y1j6e0DhQ/1eBmIjifN9XArzPZ7+w8azMfUxRbAhDkZJ4fc7NoO0Xc1EXyt0YhsohVdn9dfon8FmELvQkcKr7YnsR2iRTumZbGHrDYc0Hwzb0NQ1lgtBeIOfSdT17/YD0b0jGqA0zKXL5+8NcdBn9ayf6e25d+YIvdh3yJp1umEx4JlYFW4V4sfZX194NKFncdvvShbUcp+8eFKaaoBIQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RU8yODZKUTNYK1E0VGFNcGZJL21abG5GRHRicmxGVGsyWVNkUlhXc2RyQVBv?=
 =?utf-8?B?Y2JCa0JXL0xyUVFIVGxMNzA3SkVGTVdxcjFNd3NDRW9PNGZwa09oT3AyL0FV?=
 =?utf-8?B?bzg4ZkN6UkNRUVM1eGxjelNDaEllWDhCL0dHa3E4RFdmU1VvVlgydGMyckhu?=
 =?utf-8?B?cjRMc0JtaTJldWFkYlhWdlkyaVAyYW1YWVU3Y3BzWSt3ZUFqM1FrWjNCTDVH?=
 =?utf-8?B?RDAzdGdqL3YyVjBVT01BdU9BanNtNFVyaEw4LzZ1QTFkUkdFVDYvd3BXRXJV?=
 =?utf-8?B?ZGl1ak5YTnRXZmxHdHBNb1ZlT1FlbWp6MEVKWnR3M3dhYnN3NFpPb01KS01B?=
 =?utf-8?B?QU1Ta293WElhN094VHZubHFuSzZjOFVHOVdnN0pRMjJuY3V2L0Y4SGpPMm5S?=
 =?utf-8?B?U1ZtL2VtVUNaUk16cU1ROHhhaVZaM0cvclhiMFJEVndFSVFsL0U4V0pqNWdC?=
 =?utf-8?B?YVZ0Z0NEam1KdUp4NW56QXIzRFcvTFF6VTZRMzlxT3dmNnRFSE4vd0N2aVdP?=
 =?utf-8?B?WmNPYy9BQnkzK0QvajdvcTQyUnFjQ1Jtbk1uUzdGc3RjRVVpdk9NNk9lRjJU?=
 =?utf-8?B?S2hFcW9rWU8xeXMvQ2h2TlNOMVFoWWdTNnowV0lLL21xMXBzUnZBcW1EMFN1?=
 =?utf-8?B?OGphVmhmaGRhOXJBZWFZc1VPU3c1NWx3TGZXYWs4UTBFaXl2QWtSbTRqQTNt?=
 =?utf-8?B?alVTRStKVG1jZ2VJZjR0TVNjTnhKVVMzblRaQ1dncEgyWFhjYVp5cVhwckJ3?=
 =?utf-8?B?dVdVek54bWptUGdIZXBkR3VFM2x1N1dhbnZsQ0dGaGJtMndtRUI2Vy9WOU9Z?=
 =?utf-8?B?Sm5lV09lRlZEQUQxVkdMQjBoL0pSYjBBUVV2MTFOWEcyTGxWV0VRWGh4YmVC?=
 =?utf-8?B?RWdqaGZXZXNvU3ByRVRJL1pFZnlaMnByODVIT0ZWc2N0alRzRElBTVozaisv?=
 =?utf-8?B?ZkwyaDhLZmlKQjRLK1Vjajk2Vlc1OEpMZ3lTUjVLRnJ0cHBYc0lHaS9qaUlk?=
 =?utf-8?B?OGlUT3RrRldXMElTZzFiQk55eURZMGRMUm9aUGM5enQ0N0p4K2wwcWgvTW8y?=
 =?utf-8?B?bG8zMnNndDN3SStaSmRYUHlmK1BPOURHc3ZFbmQyRlMyeUJXWDFQVnFaOENE?=
 =?utf-8?B?dGozWWpMOUh4UmtFaUFkc2Urall0TWFJQWkzaWJlK0I0bnVoY0V4aXFHRHJH?=
 =?utf-8?B?VTRxcDdnZHp6SlZnTzJlRGRDNVlBWVhFTWZLL2NrYUZJT05kVUt1RFhlN2Vz?=
 =?utf-8?B?U2gxR2I0ZHJOcndkYUN1cm5KZ0hrMGhWZHdaaG0yVkYycVpOWGV1YmR6Qmd1?=
 =?utf-8?B?NWswdDFyM1BpblJieWZPTms5K0dCZWhWUnBkd1hTUlZHTGF4ZitzOTlwUm1K?=
 =?utf-8?B?bVdmS2FIWlI5NzNac0Y4cWFjQk1LNWJVWFArK0w2V3YzZHdRNURoNW5FelJZ?=
 =?utf-8?B?a0NtUkdFMGpMQTFKV2ZSOVZTVkJucG93bzFlWjlTL2NQdlRYaGp1SVRkanp1?=
 =?utf-8?B?NEVBUnUvTGhHUWJxVFpwZ1pwQXdEUFpmNlFkM3dJS0p2Qlc0NFRON0xibVZn?=
 =?utf-8?B?UnJIZ3pITkpaTWsrcGNhTktRUkxTZjdHSklKZTBsSERQQzdHalIwUHFKekYx?=
 =?utf-8?B?aXlIZHAwTmkra2ZkU3MvdGtQeTVUQ20vNWFuUGFkdkg2OXQ5eGp0ekhZRUNS?=
 =?utf-8?B?Z0doT0E3Wkt6SUpsQkJoanhxNFowNlNJK0p5OGxNSlZDTDNWMGhWRkFrZkNj?=
 =?utf-8?B?eWN1bmhtemRYb2YvSXNzYjFZYy9BbGx1aWx4R0llYkxHQm9xK1hqN25BaGpC?=
 =?utf-8?B?Uk1meFk1U3FNZUR1bGtjVGpRbGJBbERVYUNHQitxUnNSY3FCRzdtSFNOUi8w?=
 =?utf-8?B?WHBjSDdaeWhHVHVzbFlNbUUyTTBDTUhwaDhLYkRzY0gwbTlZM3hIMG84WEFy?=
 =?utf-8?B?eTAzUzEweUNtbVVPbitqWEd6cDBDckx2WktjdktGN3c1M2d3TEFvWUhUL3kz?=
 =?utf-8?B?OEZLWHNZQnNvaDg2R1BqYlJqNzlCUFBoZ084MGRlZUhGdWdZbnNnZXRvNUpt?=
 =?utf-8?B?UjZDK0UyVjlzUHByQ0NVNkp6YTRiMm1SWUx0QkZGWjU3TWVwYzl5TnZpWXRM?=
 =?utf-8?Q?vNG8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 16716fcd-679d-4f12-5fb6-08dc5d7f1ded
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 19:06:12.3666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EP8fIx448ORpOWsM+VzQZACtVBHOU77dFrjdSAd5s8XHyUGvS6NZCxQWSch+F9bQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8129

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaGluaCBOZ3V5ZW4gPFRoaW5o
Lk5ndXllbkBzeW5vcHN5cy5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggMjAsIDIwMjQg
NjoxOCBBTQ0KPiBUbzogUGFuZGV5LCBSYWRoZXkgU2h5YW0gPHJhZGhleS5zaHlhbS5wYW5kZXlA
YW1kLmNvbT47IEtyenlzenRvZg0KPiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGlu
YXJvLm9yZz47IFJvYiBIZXJyaW5nDQo+IDxyb2JoK2R0QGtlcm5lbC5vcmc+DQo+IENjOiBUaGlu
aCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+OyBTaW1laywgTWljaGFsDQo+IDxt
aWNoYWwuc2ltZWtAYW1kLmNvbT47IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBncmVn
a2hAbGludXhmb3VuZGF0aW9uLm9yZzsgbGludXgtdXNiQHZnZXIua2VybmVsLm9yZzsgbGludXgt
DQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGdpdCAoQU1ELVhpbGlueCkgPGdpdEBhbWQuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSB1c2I6IGR3YzM6IGNvcmU6IGVuYWJsZSBDQ0kg
c3VwcG9ydCBmb3IgQU1ELXhpbGlueA0KPiBEV0MzIGNvbnRyb2xsZXINCj4gDQo+ICtkZXZpY2V0
cmVlIG1haW50YWluZXJzDQo+IA0KPiBPbiBNb24sIE1hciAxOCwgMjAyNCwgUGFuZGV5LCBSYWRo
ZXkgU2h5YW0gd3JvdGU6DQo+ID4gPg0KPiA+ID4gSW5zdGVhZCwgcGVyaGFwcyB3ZSBjYW4gZG8g
aXQgYXMgZm9sbG93aW5nOg0KPiA+ID4gICogS2VlcCB0aGUgc2V0dGluZyBvZiB0aGUgY29udHJv
bGxlciByZWdpc3RlcnMgaW4gdGhlIGNvcmUNCj4gPiA+ICAqIENyZWF0ZSBhIHNvZnR3YXJlX25v
ZGUgdG8gcGFzcyBhIHNvZnR3YXJlIHByb3BlcnR5IHRvIHRoZSBjb3JlDQo+ID4gVGhhbmtzLiBC
eSBzb2Z0d2FyZSBwcm9wZXJ0eSB5b3UgbWVhbiBmbGFncyBvciBjYXBzIHRoYXQgY2FuIGJlIHBh
c3NlZA0KPiA+IGdsdWUgZHJpdmVycyB0byBkd2MzIGNvcmUgZHJpdmVyID8NCj4gPg0KPiA+IGR3
YzNfc2V0X3F1aXJrcyhzdHJ1Y3QgZHdjMyAqZHdjLCB1NjQgZmxhZ3MpOw0KPiA+DQo+ID4gRGVm
aW5lcyBxdWlya3MgaW4gY29yZS5oDQo+ID4NCj4gPiBEV0MzX0ZMQUdTX0NPTU1PTg0KPiA+IERX
QzNfWExOWF9DQ0kNCj4gPiBEV0MzX1hMTlhfSVBEDQo+ID4gRFdDM19SRUFMVEVLX1JFU19GSVgN
Cj4gPg0KPiA+IFRoZW4gYmFzZWQgb24gdGhlc2UgcXVpcmtzL2ZsYWdzIHByb2dyYW0gaXQgaW4g
Y29yZS5jLg0KPiA+IElzIHRoaXMgYXBwcm9hY2ggZmluZSBhbmQgYWxpZ25lZCB3aXRoIHlvdXIg
dGhvdWdodHM/DQo+ID4NCj4gDQo+IE5vdCBhcyBhIGZsYWcuIENyZWF0ZSA0IHByb3BlcnRpZXMg
Zm9yIEdTQlVTQ0ZHMC5EQVRSRFJFUUlORk8sDQo+IERFU1JEUkVRSU5GTywgREFUV1JSRVFJTkZP
LCBhbmQgREVTV1JSRVFJTkZPIGluIHlvdXIgZ2x1ZSBkcml2ZXIuDQo+IFBhc3MgdGhlbSB0aHJv
dWdoIHlvdXIgc29mdHdhcmUgbm9kZSBhcyBQUk9QRVJUWV9FTlRSWV9VMTYuIFRoZSBjb3JlDQo+
IHdpbGwgb3ZlcnJpZGUgdGhlIGRlZmF1bHQgY29yZUNvbnN1bHRhbnQgdmFsdWUgb2YgR1NCVVND
RkcwIGJhc2VkIG9uIHRoZXNlDQo+IHByb3BlcnRpZXMgaW4gZHdjM19nZXRfcHJvcGVydGllcygp
Lg0KDQpUaGFua3MgLiBJdCBpcyBjbGVhciB0byBtZSBub3cuDQo+IA0KPiBDaGVjayBkcml2ZXJz
L3VzYi9kd2MzL2hvc3QuYyBmb3IgcmVmZXJlbmNlLg0KPiANCj4gPg0KPiA+ID4NCj4gPiA+IFRo
ZXNlIHNvZnR3YXJlIHByb3BlcnRpZXMgd2lsbCBub3QgYmUgZG9jdW1lbnRlZCBpbiB0aGUgZGV2
aWNldHJlZQ0KPiA+ID4gYmluZGluZy4gSnVzdCBkb2N1bWVudCB0aGVtIGluIHRoZSBkcml2ZXIg
Y29yZSBoZWFkZXIuIFRoZXkgYXJlDQo+ID4gPiBzaW1wbHkgZHJpdmVyIHByb3BlcnRpZXMgdGhh
dCBnZXQgcGFzc2VkIHRocm91Z2ggc29mdHdhcmUgbm9kZS4NCj4gPiA+DQo+ID4gPiBZb3UgY2Fu
IGFkZCB0aGUgc29mdHdhcmUgbm9kZSB1c2luZyBkZXZpY2VfYWRkX3NvZnR3YXJlX25vZGUoKS4g
VGhpcw0KPiA+ID4gY2FuIGJlIGRvbmUgYmVmb3JlIGNhbGxpbmcgb2ZfcGxhdGZvcm1fcG9wdWxh
dGUoKSBpbiBkd2MzLXhpbGlueA0KPiA+ID4gKGNhbiBiZSBkb25lIGluIHBsdGZtX2luaXQoKSkN
Cj4gPiA+DQo+ID4gPiBMZXQgbWUga25vdyBpZiB0aGlzIHdvcmtzIGZvciB5b3UuDQo+ID4gPg0K
PiANCj4gSGkgUm9iL0tyenlzenRvZiwNCj4gDQo+IEp1c3Qgd2FudCB0byBjaGVjayBpbiB3aXRo
IHlvdSBmb3IgeW91ciBvcGluaW9uLiBUbyBzdW1tYXJpemUgbXkgc3VnZ2VzdGlvbg0KPiB0byBQ
YW5kZXksIGhlcmUgYXJlIHRoZSBrZXkgbm90ZXM6DQo+ICogUGxhdGZvcm0gc3BlY2lmaWMgc2V0
dGluZ3MgYXJlIHNldCBpbiBnbHVlIGRyaXZlcnMgKG1hdGNoIHRocm91Z2gNCj4gICBjb21wYXRp
YmxlIHN0cmluZykNCj4gKiBUaGVzZSBzZXR0aW5ncyBhcmUgc2V0IGJ5IGNvbnRyb2xsZXIgcmVn
aXN0ZXJzIHRoYXQgc2hvdWxkIG9ubHkNCj4gICBiZSBhY2Nlc3NpYmxlIGluIHRoZSBkd2MzIGNv
cmUNCj4gKiBTbywgdGhlIHN1Z2dlc3Rpb24gaXMgdG8gcGFzcyB0aGVzZSBzZXR0aW5ncyBhcyBw
cm9wZXJ0aWVzIHVzaW5nDQo+ICAgc29mdHdhcmVfbm9kZSBjcmVhdGVkIGZyb20gdGhlIGdsdWUg
ZHJpdmVyIHRvIHRoZSBkd2MzIGNvcmUNCj4gKiBUaGVzZSBwcm9wZXJ0aWVzIHdpbGwgbm90IGJl
IGRvY3VtZW50ZWQgaW4gdGhlIGRldmljZXRyZWUgYmluZGluZywgYnV0DQo+ICAgb25seSBpbiB0
aGUgZHJpdmVyDQo+IA0KPiBXZSdyZSBhbHJlYWR5IGRvaW5nIHRoYXQgdG8gc29tZSBwcm9wZXJ0
aWVzIHN1Y2ggYXMNCj4gImxpbnV4LHN5c2Rldl9pc19wYXJlbnQiDQo+IA0KPiBJZiB0aGlzIHN1
Z2dlc3Rpb24gbWFrZXMgc2Vuc2UsIHdvdWxkIHRoZSBwcmVmaXggImxpbnV4LCIgZm9yIGxpbnV4
IHNwZWNpZmljDQo+IGJpbmRpbmcgb3IgInNucHMsIiBpcyBhIGJldHRlciBmaXQ/DQoNClJvYi9L
cnp5c3p0b2Y6IFBsZWFzZSBsZXQgbWUga25vdyB5b3VyIHRob3VnaHRzIG9uIFRoaW5oJ3Mgc3Vn
Z2VzdGlvbj8NCkJhc2VkIG9uIGl0IEkgY2FuIHdvcmsgYW5kIHN1Ym1pdCB0aGUgbmV4dCB2ZXJz
aW9uLg0KDQpUaGFua3MsDQpSYWRoZXkNCg0K


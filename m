Return-Path: <linux-kernel+bounces-106955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EFA87F5EE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 04:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE5F9B218A3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B8B7BAFD;
	Tue, 19 Mar 2024 03:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L1+e4MSq"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2110.outbound.protection.outlook.com [40.107.244.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F285A4CD;
	Tue, 19 Mar 2024 03:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710817600; cv=fail; b=h4gRgtiXLXM048NipMdchX3+WeYNpPZaEZYFWmtLyu4IKasUyRFWbAZZT47JnAdkIS67P6upcmNJb06PDJRkrTan4edPG4n59KrtVmWwrXJ6LXKQIpJhPJxfy4nwza5G58xewH7JPX4NNS18p+QqRE1o6y6Uy2qAd+RKzArLiag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710817600; c=relaxed/simple;
	bh=p/vBZ/lfGS64OotJhrUlt6M8FXG50zcBfySdDxafip8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s7H5krbWxu8fYauMl76mLth2vlO7XIhwLC6npvMcJZjuixMNhD/oCaAOqdoyYOGYP+3rzblxsNpZj/5jYwcoXDyXTK148GiMa8ErwC1ch4N7KmA1hX0W7/HHzBAiQ9XMOxzm2o9HT+LWpnSxHiCEDMT5ZGqtUk/6VNUGu2Xp9kI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L1+e4MSq; arc=fail smtp.client-ip=40.107.244.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6+MSgM5Mb7bYPuf2+/LAcjs58TlmJrHKe0RJLsLu2lCksRuFdYumux7rnE2wl8ulgsDMbve7wMOae7sAMouERd/m5UwKN3iSXvu2zUYUdH16gpEeMDb1PM4ypT3lQV366/LpGOU+YrQDWqT+HH8lEP9JqgRpJ8CKxm2nFw83bkeZ/TZPkC1ZcCeRTBSx97zfZ1yy34viHfj7QbtrJYXz6Z2zphlJ4n7mr/mHRt09AT1hMnbDC/dzhFBve7ZLQpf/92x7Du8Ar52DGICpnPxVr51xj5yJSTQwrf/GLrzgEYb0wA2wUU7WrCeNEpmyZglLKdnjBq96tvkfFwnkJAqQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/vBZ/lfGS64OotJhrUlt6M8FXG50zcBfySdDxafip8=;
 b=Z+z8reDYyMAZ5iD9OTd3LFSfhSypbXafuuvs9jN74pjl3UXKKywGwxUwNK1LGZaOUKajqZCknapKMNaZPzh/3sEp/61ApfA8KBttrwloLvlRt5LXyCGPtfQo8/6J3ny9nR4512wIT3O+M7VoNrO1iAzfXGkodvbGixVFpjNOQyLQ3iNezHQprBsx+WAd3z9rcKeKXJsLxFoonx6ro4VHEao4Gb9ThEKhJ/ZaE70bbYzJFqFmxI4hqSAI7SA6LyraZSe0b9Ij24MpKydvY7w2lDO0/OsR8hZQhaPbiuKtCBAkF3nk/taMeguFgqtKwNmsHiaO7y5CIQNcQkN29Im8Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/vBZ/lfGS64OotJhrUlt6M8FXG50zcBfySdDxafip8=;
 b=L1+e4MSqW7bBCgw6yCcgDQC288GtXr5AkNx1AZFrrBUP1dP1qamYyxgwPUMu6VYYk2RFWeYTisyh38ykGoD6jhYZ3+vs/vXH9fErOGHPM1qoHAlSUtezm8OTQwRi9yHP+y1aAPceihNMx06Sb+iINPX6IbXiLXOchztpmF0c/yp2B32ztj46+7MrO+9qSq93zuicqa79KbPpwuODPb7fJCHTk442c7y1E6QOV/MvIwXKKkS8eZHIPha7qk+UVfZonJrxAREBb0XF/vUvcC4vJccLZZiY/IDOiHz7sOdVifDamVXwDRxlo6y7YYAK2/hhsUSSQdSxqU2qSjxfrLvtpg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH3PR12MB9251.namprd12.prod.outlook.com (2603:10b6:610:1bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Tue, 19 Mar
 2024 03:06:36 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 03:06:36 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Li zeming <zeming@nfschina.com>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject:
 =?utf-8?B?UmU6IFtQQVRDSF0gYmxrLXBtOiBSZW1vdmUgdW5uZWNlc3Nhcnkg4oCYMA==?=
 =?utf-8?B?4oCZIHZhbHVlcyBmcm9tIHJldA==?=
Thread-Topic:
 =?utf-8?B?W1BBVENIXSBibGstcG06IFJlbW92ZSB1bm5lY2Vzc2FyeSDigJgw4oCZIHZh?=
 =?utf-8?Q?lues_from_ret?=
Thread-Index: AQHaeOF5HALlztinN0OEeb8YvHTZ87E+YySA
Date: Tue, 19 Mar 2024 03:06:36 +0000
Message-ID: <4b460a34-1956-4b24-b044-bc663d4244aa@nvidia.com>
References: <20240318030707.18198-1-zeming@nfschina.com>
In-Reply-To: <20240318030707.18198-1-zeming@nfschina.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH3PR12MB9251:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 cTxue0QpvVfLavqSqspcldpeR9xzoCZT8b0dnffbDJlEwyzQ/h2jXiyUPUaFVRlyrZyN7kaJBX9xYZnuJo49+zYJKQ3+BvIx+sqoZZKnwLVFbvpMihftuY99BJwTCfsWc3XM0L1Vtt7h8HBk+hErb7nTClj0FAy/ugc+tge5zdkJm3hVuMgAr3QJnCYdYIoZU0QqRqA13Hgvg2C9KXCfzMzLlZrKvSRmTKBsso26PIHDMqEhjrmMivekeWt2/OeSLz8nYUJFihCc/5ASg0k6rx634ThQoTftbtbhuvfZcqS8wseh4Mkw5gL2XQt56UdPKbjhdFdykj6WXJmz9TpnLZsSKP2WpWMptfBJrvOUYqQEDbh/57OoO4wHzO6pEwMVzGKCUXoH0uTY5jEWiCZ/DvBKHBa47CpbsXOrM5v299309QSO2I53M1iNGbFRd4PMrXIshb2tdN3UUOhENsiWHwxMGaejgR1Cisr+W6LGUpHC7oMe+IASbHh1oNYInhKv+4bkX2SkjJTMCjPf4teOkUNphCddjiDv8QdHOraIb5mprfTxY2d5cRQi03ieXA9zY22PuIwA7AAqQGn0pdusuqAKMCtDhFa2FZUOsBBnP5P5tp2H1eu1IbNu/tPQXytKl8NRKaTkCSTBVQ3u5Uf0qRmzdPzX+kiEz96RK82VJ0c=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?azlOMzY3TjM5d2N3dzEybDNWanpVQzVwVWZ5eWd6UEp0dnNhVUU1UENkRHl1?=
 =?utf-8?B?ZFp4YjgzNUF0QUc2bWp2aXpsbDZvU2NUdzBqck9BeHM2L3lid0JiS2Z5RFBX?=
 =?utf-8?B?UGtnRUtIdFBkWVlyNDQ3YnBmbXM1SUthMUJHQlBhQkJLd0FQWVdYSXdaNkNL?=
 =?utf-8?B?dkY3NHBLU3EzaXFVRVdJWHZLRExuUUtManB3RURJS2haSDY3YUYyS045dEpw?=
 =?utf-8?B?N0FFZmRqT3Irb25CWFM5YU5ZMHNBSjJsbTZib2V2cjhmRWFoYjEvZ3A1RlhN?=
 =?utf-8?B?dDJnYlBXSXI2dnl5RzVNREJ6VGFYTUJxcVBudHZZbC9XNFNQZVVYNjQzNnhC?=
 =?utf-8?B?UUx0NU4rT3lFNWorM0xQSy9raUFvdTBlRnQ1enNMZyszTXJRdTI4dWlGMlN0?=
 =?utf-8?B?Ym9TL0ZuTWVrSmc4UHo3KzVxSWpmajNrbkFaeE1wKy9hWDYrUElxMDhBRUZl?=
 =?utf-8?B?cmx5M3lUVlpoaDVqZkxjWGpzeTBWM3VOQTV2UDFLQjdXQk9waVFGeElGN3lj?=
 =?utf-8?B?RmVTMUZicVhWeWR2Q25tb3IwUkwrQTluZ1dvbDcrUGRDNW1BQTVlOU5ObzVI?=
 =?utf-8?B?S2Fhb0lOWGhZMXhTR3pDUmdMZmx6RWtsTThHT3F4dlo1MG95d0VlS0kvallF?=
 =?utf-8?B?cGxnNHdmdEtNV2dnWFlnZjkrSXg5S2NvVERTYmtRUzhoQlZGZGdOV3F4eWdz?=
 =?utf-8?B?UWM5VGszcHRBdTNaUVpER2Y1YXBGMzE0Tnh6NVA2Q1hFOU5YaWZFZ1JHeVhi?=
 =?utf-8?B?NTBPd2s2cXNzbUlkNmN2cGxmSU9WVXA4cUV6dXRaL2drMzRJbFByRit1eXY2?=
 =?utf-8?B?SWpPS3kxTmpuN3VxZE51SnMxWlNPRkFOdEhpeXl1STA3RGY3QXpNaEhyUmdu?=
 =?utf-8?B?cWs0bXgxZnl1Wk9JWFNvU3h1c3J1eGdkYWE5Q2tXSlQ5enBBRElFTVppN29u?=
 =?utf-8?B?RGptUExwaU5NV1MwWHFTWVkzQzBUUmNmY0ZKUFptQ0JSZTl2UzVycXJtMllk?=
 =?utf-8?B?ZURxWU5YdVR1T2hWYkV5aHA2SEdKQWpPdmNvZDF5UWNTd2FaR1JqRjhIS3VQ?=
 =?utf-8?B?WmlzUG1QVXFBNnNQZ0FCQW92Vk5ydVJ0TFBpNElQaFQwZG5CSTltRlhScFRW?=
 =?utf-8?B?RklEUUxPZE0xT3JvOVRUZjR3VDNqNUR1UzZtWFpXNkxsQ1ZmQloyVUthc1N1?=
 =?utf-8?B?RXYyUGNIcC95L21zY1N1Ykljd3lSek01L2FUZkVhaW9ZT2EwcEV3SGtHUDBK?=
 =?utf-8?B?WExMYlBWWnBkNGhXRGVUSlBGOHliMnZhMU9iMzVlZHRBNWQ0Vis1S1E2VEtJ?=
 =?utf-8?B?Uy9PMXZVbXhMOTZ2K0pyNFdTTmp6NXdlMzlaY2xxR2krSW5sR3hIZmtCVGND?=
 =?utf-8?B?OTVlRGpsb1BQVktXUHh3cWtkTDB3OGtZNnQ4VFRPemFrZHBvZGVtRE5Nc29k?=
 =?utf-8?B?cTlNMlJZU2pZcytjTnAwQlJTQUN2d1NVUWJ6ajZYMzRIdzgrSmpWWlVxck9p?=
 =?utf-8?B?VmFmcmM5Z3czQ2l2cDQrb0FISmdpL2ErSGN3d1libEVheURjL3YxYTNJT0xT?=
 =?utf-8?B?WmRTZjlBWlhRVkZ0bmFVTElDdlRtdTNPcmhneWlQS0toK0tydWZSbFhGYU5V?=
 =?utf-8?B?TFhXbllmQlR3Y2RQZWhzOG1BSGRHdjdQS0hqc3ZXWGdTRitZM092MmN2c0x1?=
 =?utf-8?B?cmlrRFhFSFR5cHppZ0MzdFZ4NWVZRDBydzVET3ltbGFhWTh2Mjc2alYrLzh2?=
 =?utf-8?B?V09EdDVVUHRkRE1PR3FldWZNN0hxUmFjVGJkZnRFMFpyWFQrMUs0bjZkc3Ru?=
 =?utf-8?B?SFlMdjZTYlVKOTc5VmJZaFdrRktEdWsvODFjd1RUSm1Qc3lFTjFwVERvL2dO?=
 =?utf-8?B?SXdLb2Qrc3EyTjFWdGNhNGc1RHlLTVRiU25LMEVuTVFYTDh0dDFpUytDSWZ3?=
 =?utf-8?B?cnJxWjg3QUhBL2Nmbit3ang3S1FLbENLZkthUUNPcHZIRGFqYTlMK04zREd4?=
 =?utf-8?B?cWZWK0FhdlYzVnozc0hoZE16WWpNTXFWelU1SEJhaGw4WFc4cnRaTGRMdTk2?=
 =?utf-8?B?UmFKWEZ5SzliSTFjYmkzUlVsMm9vSzBtaGhOcTE3NEdiNXovUFhjN3NDVFI4?=
 =?utf-8?B?SWE0QXozVGc4bW9jZ2dNbUlhbDZQNDhFMnM4alpHM2VVZng3VlYrZG1hRWVV?=
 =?utf-8?Q?UNzmwSd0fTMcTd19Wjysx6R8jyx0uCkHIdrELu9c9kiV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <25422FDFECBB4C46AD4F65FCA4EDE66A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ea7e95-ba83-4403-8a63-08dc47c196a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 03:06:36.1172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9dTRKKpTpoBVmUFm5wKgXLi4UM1TO0Zgyd1BeaxrpvHq5xUvJBQc69DgOZ/9DztmEfgp/B/HM7Y8IrPuTseP4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9251

T24gMy8xNy8yNCAyMDowNywgTGkgemVtaW5nIHdyb3RlOg0KPiByZXQgaXMgYXNzaWduZWQgZmly
c3QsIHNvIGl0IGRvZXMgbm90IG5lZWQgdG8gaW5pdGlhbGl6ZSB0aGUgYXNzaWdubWVudC4NCj4N
Cj4gU2lnbmVkLW9mZi1ieTogTGkgemVtaW5nIDx6ZW1pbmdAbmZzY2hpbmEuY29tPg0KPiAtLS0N
Cj4gICBibG9jay9ibGstcG0uYyB8IDQgKystLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9ibG9jay9ibGstcG0u
YyBiL2Jsb2NrL2Jsay1wbS5jDQo+IGluZGV4IDQyZTg0MjA3NDcxNTMuLmM3NmQ1YTMxNjk0MTcg
MTAwNjQ0DQo+IC0tLSBhL2Jsb2NrL2Jsay1wbS5jDQo+ICsrKyBiL2Jsb2NrL2Jsay1wbS5jDQo+
IEBAIC01OCwxMCArNTgsMTAgQEAgRVhQT1JUX1NZTUJPTChibGtfcG1fcnVudGltZV9pbml0KTsN
Cj4gICAgKi8NCj4gICBpbnQgYmxrX3ByZV9ydW50aW1lX3N1c3BlbmQoc3RydWN0IHJlcXVlc3Rf
cXVldWUgKnEpDQo+ICAgew0KPiAtCWludCByZXQgPSAwOw0KPiArCWludCByZXQ7DQo+ICAgDQo+
ICAgCWlmICghcS0+ZGV2KQ0KPiAtCQlyZXR1cm4gcmV0Ow0KPiArCQlyZXR1cm4gMDsNCj4gICAN
Cj4gICAJV0FSTl9PTl9PTkNFKHEtPnJwbV9zdGF0dXMgIT0gUlBNX0FDVElWRSk7DQo+ICAgDQoN
CkkgZG9uJ3Qgc2VlIHdoeSB3ZSBuZWVkIHRoaXMgcGF0Y2gsIGV4aXN0aW5nIGNvZGUgaXMgZmlu
ZSAuLi4NCg0KLWNrDQoNCg0K


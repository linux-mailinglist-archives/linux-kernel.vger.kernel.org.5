Return-Path: <linux-kernel+bounces-65229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C28F8549BE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD8191F27992
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6006252F90;
	Wed, 14 Feb 2024 12:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="S0ODDW8Z"
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2053.outbound.protection.outlook.com [40.92.103.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5437C52F8C;
	Wed, 14 Feb 2024 12:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707915284; cv=fail; b=eJcW5zJPDXF+chI32DoLVkR3ggs2Hwk4/Ck/FpM50xFS6bxlfqaAbepyhnQe/Tj+IRsYscmjiPmemcjTZTO/SJq3NTbFtdiMOsLsDPTyGSTbfuOHkU6wemP8ss2tHDjWjuTuIJ9sFMbtfdsZZEvKHN2orIr30EJJeDnvQCLiiyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707915284; c=relaxed/simple;
	bh=F9ESh+XbVs6IHqIevErE0oPZBK2o9BFsoMbi2o2m00E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z1uFKImHU5nkgzYHSjRaflfB13i3ye1PvihWBCujm9lRZtShhbTaz3/4vPjWQ2O4febOWFKKNAtS0ozyhzgaf0OJa2fLat1CPj6xjbPySEgNP9impl7heqOZZhoqGfR4OvMrkFcTNN53OtyB01JRzXgv29tsN8BgKMyPdUkpZsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=S0ODDW8Z; arc=fail smtp.client-ip=40.92.103.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgCM+h/g7H3p4JbA2+0RUtyLaODD9+e7Vu2Pq5OdRCAk2TWFrKAehxpjOe1Z6am1x+2X8nOCiY52sPrEKX4L1BzIhFvfhZgnuZnwqfdWNqO2q2mOYtIbeuBQSQpY6btBbq2ye2kKCNh6rtCbdRINPF5L2ir1IDS6VWL+ARaby1diqDNaWMmsZp9zlTXYX3wHMXlEh151H7qXQGmtrekmufIGntH7MNyK9yO2go1DMtwotuTI4KdFStO3fa9tuatmRQiyyJ14rNCIE3trB3tzU3rTKHsvlYPMmQR6AsifNmfMK/PM9iw77efkIAie1+2QNlY7xRnGoDeEvhgLrUAdag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9ESh+XbVs6IHqIevErE0oPZBK2o9BFsoMbi2o2m00E=;
 b=LRiW67W407Dju+Pp6Hfoet+qEyg5JDL0J+Qzr+trE19N32iIGvJFepRr88QLHbSoRnLXWiJYyxjNXEaS0+du/OWV0GT9LGYv8Z5O0S/jjs3ppqAaS+EwjtuLy92RIDFT+CHErLJDIrgPBMWqEhfW02YgBQ+4g0KyPO10VZfMeL2uaqTeR0+d+pSE/bHn8pt7IxZyS+kwf5N72+x9+nPbRhTt1JYNyqtk2AX2M3MoOT8OV3i5YpEhnB1kSTyg/c3RyL7GuSo/hDnEGHu3DYqH9LZMz607xhis/CYulFsgtdoxqXz6grQ02BXarscmS9yVVp+lJ23J6r7UQ6WS/Zp8tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9ESh+XbVs6IHqIevErE0oPZBK2o9BFsoMbi2o2m00E=;
 b=S0ODDW8Zazgp+mmBdMCGlW0wmXMMrYyvO7Es+VzSkVce8tKWCC9TMey0ntO+ylO8CccwW4Em2rpRm1l/Pm5rLKbB2xeKWCU9uXIBhF+1IUZne+GWQbAAdSa4JTaD5WhKpz0CpNlcDT1Zi1/iKcjQFFrOemCAlqnQ1mITJ45f8j0a2CGX8+i0x3UV4PAB/A5Oi6mPv+UGfK20aoi2lbrKhcWx2Bwx91TtjaYbDgBLydk/NXhf6QPrlWAX2K4/bTNYUeJde2/IxjUxuIoqbUgoE7rrXnIg16vWo0/lecPVJRKZbx8X0eVjXsPnwsU3LVwCpWnQwxpg2cBJRVySnaNYnA==
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b3::9) by
 PN1P287MB2692.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:217::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.26; Wed, 14 Feb 2024 12:54:37 +0000
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::9500:80b2:4eeb:4a16]) by MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::9500:80b2:4eeb:4a16%2]) with mapi id 15.20.7292.022; Wed, 14 Feb 2024
 12:54:37 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
CC: "jikos@kernel.org" <jikos@kernel.org>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Paul Pawlowski <paul@mrarm.io>, Aun-Ali Zaidi
	<admin@kodeit.net>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/7] HID: apple: remove unused members from struct
 apple_sc_backlight
Thread-Topic: [PATCH 1/7] HID: apple: remove unused members from struct
 apple_sc_backlight
Thread-Index: AQHaVQVI4bzzN8ICm0KW+e59Lr0v0bEJ3+Nb
Date: Wed, 14 Feb 2024 12:54:37 +0000
Message-ID:
 <MA0P287MB02170D0CDAB9294D93755C0DB84E2@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
References: <20240201115320.684-1-jirislaby@kernel.org>
 <20240201115320.684-2-jirislaby@kernel.org>
In-Reply-To: <20240201115320.684-2-jirislaby@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [6mTmV6HKeTQI08BygCCIJXVGia6sV0rP0eawTvLZWAk=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB0217:EE_|PN1P287MB2692:EE_
x-ms-office365-filtering-correlation-id: e36370e6-1673-4403-7fe6-08dc2d5c19af
x-ms-exchange-slblob-mailprops:
 YfhX3sd/0TUIjNBgvGxJgbt+hYWSLXPTm2paaDpmh3PW5/Zbc/oCWYokrw445PCWxSLOz9IHG57j4CLuhKUmqMTeJgS2pVbyj1r7NezXTC2kX4WvKbvwoAQsTHmR0+xVKhDESJoL/J8mmjouLKshu9tlzhH/9AZw7glxH7CV2inHM7c3/y6Avd925C61Y4xum4chP4LJPdcBtTF5X4Imo/eB9xB7iNSWU69qYWg6VIIHP+LtVwT79iu3TC8hL9FxkWfws1L/kOYTk85sw04htz4dPosT0veue1DKkAck4W8wtH9M92J3bUlLtq7RX64W2U+SvvyT97aKE3WG6d3QjT2Uw9GMenv4clDzHsLnjar6psdthys9tAVQcFCBBI3VsGcXNEm4hReaZtFB7asc2KxFW8c/4w7hE+0+Q3KuxZO9zS7rTNT8RJs9EsGDyB1/azOgpX4nVvNIHm7mcOJYBZ8FknWyQzQKmnx9o1mfUVxM+Twjwt+5albNHJvce4Tc3NFGwXbUpkck3m8BfbfBWGICVZjzZ2EBKDoweafuO1V/7IgtvIOp9OjZ/skcJOQaw5kzGeN9NQjKobR6p2buyidDcNSCWhlaHv7dADAileYIeTRf6+epdOD+4WGqtEdOTi9Dvfbo81p2HtosRkLiEAEUAqZoys2GKQKT8rBjN7woVB1PH06v72WiCkEn+gw3RO5LMvV0TdU8ZmB1iklGypxm4vgsmQBgzouOjPZ73/7OjehVe8ox1EnVF9jy1whcG/jS8OC3d2iahVTnE4iUZjXohKjoTymm6UFtQ4K3KRo=
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Nx+aNk8mfinATiV00KyVUnrCx0l4OK1Go2qeVdjIzZqlIG0RyIPCkVfHx5ouDz0ULqJrUyD+9z+NVEw9HVo5nEwtv9MmAZkbqIDQ5vqIDHBFhvNjbzQfhusvX7tJw7IGe6Vud5TankVe6ffgiyvn7oySTrNiB+yyy+hgdPIyiYEsjjHeuHk9uzpmzVDr7W/eWWgo+qg/N5STpB029QX3ZTnfOm7aecZbBd0imZfD1FccT7XETZRKOfpFKERMSQC/AVRGoznS8hRhYhvTFxLPNAszKPPsOM9htgQd8Duigo0EjAWVOFkpQ9tj3TyBmkwifT+pjSoWVSijUD6IFQIN+czcs5hBXEbfsWO87ancCqd8tXAMeNuSXzOewXOI8JOjMPndG0J4XCcdPYKTz00T+SQAL6CU3qYvBBFwFQz940Lgh95YyQES0UuW+HOe03nuMFH6ifrwUPZZAlhT+6T+tNv+6uKLKcTnL3um+W2QpSuIue3GG36oAa6kLGY7cKla0FFkN1AoDaYsQcqaLKobUj5y4DxUkU1sxXxC/AmzEOi/2QuF2We06Xwh3Vv1APmjLooHsR81ZV3MrW4pBMuwxtj4lFY/uoXvmY+fI6n1r5g=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c3dySFZZSkVNV2RmT3BvSm5PeC9TTC9UeU90QVhMRXQrTnVhNXRVTmtpdWhm?=
 =?utf-8?B?ZFNEbFowTUppN3ZjQkxGajE0M2xrRHdPZmtPRTgvQmNsVmdURkUrOHI4ZkRH?=
 =?utf-8?B?TWNxMzVmaEJGRGxmWWIwd2F3UjN1azF2Q1BUanlOSFJGOEUrSklwTkMwRDlv?=
 =?utf-8?B?VFM5MHM2bXhmK29EKzBXUjYzWEl4VUMvNVcvMFRpdzllcjhZR0IxcDhXUWtX?=
 =?utf-8?B?RkZYR3pLalRyc25UTk05cVh5M0ZySEFZZjQralcwbjhYd2hZUnJWR2Nzc3M2?=
 =?utf-8?B?TU1vdGFrbG1jVWJWSGRnQmdJKzY2bnNIemQzNFZkdmM5cXRORDhRYWlhVThn?=
 =?utf-8?B?cEtqMnJPa0VjZ0JaVHM3NlpPRUhmUVJ3ems4d0IydDRQT0hWZVg0YkFPRDNW?=
 =?utf-8?B?SEkzdlQrV2lsWHlFb1UxWFhUSUxCeU9xdGNITHJQeTB5OEZTazg0UEVpUmJK?=
 =?utf-8?B?RCt3U2t0RkhybmV5K3VKTWh1SUdlMzFzaUwwOXo2d0xLUEp6QzhITlBtTWs3?=
 =?utf-8?B?b2xNMXNGY2RjV1lSTi9TUlFOeUFkUHpTcHJIU3dRUzRoVzNsTmF2cGNnZktB?=
 =?utf-8?B?dFUzRC8wZXZ6c1JHN2ZtbGdpN01KVFZsNnpXcThrbXRVS08vZzYxTkplckJB?=
 =?utf-8?B?WXJtWmhyNnhnVGI4SGVUTFEzR2xtNVY3aURJWktqNHB0QloxREwyeWo5bFM3?=
 =?utf-8?B?Ym8zbFZEdnBJeHpDcTQwZGx2ZEJwZWxmT3NNWW94SXVLWDBISHFFYU5kTUpl?=
 =?utf-8?B?TGVEUVVBcFVqM3RjeEVmUHFRTHJIM1Q2aWVrY2x1M3loTm4xSk9mKzN0Zlhr?=
 =?utf-8?B?SjUvd3NUcWhtTTMwdkFLZFNoSldWZUI1QkJVZW91TGNQT0FxZ28vYTNvU0dT?=
 =?utf-8?B?QnFUakEybWFVMjlyTVVObHBHVEtscHdXUURvdTJqNDA5MlNKcEExNnQvUUxv?=
 =?utf-8?B?R3JzeEFHdkdKU1k4TVJZbHp0VlFIb0VLUEpKeVY0WG5ndnZ0d1ZZejhYVTIr?=
 =?utf-8?B?RFlJNXJkSmJuOEQ1U2owZ1ZxVmVlTkdPTHdZNjVrbDQ0SkhHRFdVT3pRdElC?=
 =?utf-8?B?b2FPTThRRnpkTHdJL1BISStDQjBqdlpzQWlBTDBIMUZoQ25hZml5V3FTRFJy?=
 =?utf-8?B?NEo3SzRRNnlSTnlpS2gzVXJ4MlVhWGRSckNyV09zdi9BV2prOWZDUFNySytm?=
 =?utf-8?B?N1V6VEMycHFrZjN6LzJUbGxTSHRNVURkNm9pbk9VNkUvSXB1RDVlWDBob0hU?=
 =?utf-8?B?MWU0R3VGcjVZMlp2a0hVQXVBbkNXRlpCL1o3d0dPNklsL3ZKOUZRMUQwWVNX?=
 =?utf-8?B?MU9CZ2JQeGZ4RzUwUW00aWJ5bjVHMWY4ZWtVOXF4dkVvSVJ3dTNFazFKQm5a?=
 =?utf-8?B?R0c3dHYwUit3Nk11Nk9KN2piMXgyeHlsdlRyK2tIN0lDZ2E0ekVyYVlHWEJ3?=
 =?utf-8?B?M0VzNi9sdHNudkJPSXlha1lWbFVrMWxnMnVVM3pWRGVDVTQ0T1N1bFVpWmpj?=
 =?utf-8?B?Tk1KeDRTaXUrZ1MwTWF6QjF3RUx6ZGo5OEVrRGRIRjdyYVJ6ekNwcU1YOGF2?=
 =?utf-8?B?bXFlZFJEMGdrREIydXlrRmdqMy9Tb05pZXp3dkJNZHUzNmJRUVA1Z0lzTXpL?=
 =?utf-8?Q?qxTxYK9d10D5r6243lt+Wb2F0mDwp+d8X9L0arMZtNp8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bafef.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e36370e6-1673-4403-7fe6-08dc2d5c19af
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2024 12:54:37.0310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN1P287MB2692

SGkgSmlyaQ0KDQpJIGdvdCB0aGlzIHBhdGNoIHRlc3RlZCBieSBhIHVzZXIgYW5kIG5vIHJlZ3Jl
c3Npb24gd2FzIHJlcG9ydGVkLg0KDQpUaGFua3MNCg0KPiBPbiAwMS1GZWItMjAyNCwgYXQgNToy
M+KAr1BNLCBKaXJpIFNsYWJ5IChTVVNFKSA8amlyaXNsYWJ5QGtlcm5lbC5vcmc+IHdyb3RlOg0K
PiANCj4g77u/VGhlIGJhY2tsaWdodCBtZW1iZXJzIGluIHN0cnVjdCBhcHBsZV9zY19iYWNrbGln
aHQgYXJlIHVudXNlZC4gVGhleSB3ZXJlDQo+IGFkZGVkIGluIGNvbW1pdCA5MDE4ZWFjYmU2MjMg
KEhJRDogYXBwbGU6IEFkZCBzdXBwb3J0IGZvciBrZXlib2FyZA0KPiBiYWNrbGlnaHQgb24gY2Vy
dGFpbiBUMiBNYWNzLiksIGJ1dCBuZXZlciB1c2VkLg0KPiANCj4gQXMgdGhpcyBpcyBub3QgYSBz
dHJ1Y3QgdG8gY29tbXVuaWNhdGUgd2l0aCB0aGUgSFcsIHJlbW92ZSB0aGVzZS4NCj4gDQo+IEZv
dW5kIGJ5IGh0dHBzOi8vZ2l0aHViLmNvbS9qaXJpc2xhYnkvY2xhbmctc3RydWN0Lg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogSmlyaSBTbGFieSAoU1VTRSkgPGppcmlzbGFieUBrZXJuZWwub3JnPg0K
PiBDYzogUGF1bCBQYXdsb3dza2kgPHBhdWxAbXJhcm0uaW8+DQo+IENjOiBBdW4tQWxpIFphaWRp
IDxhZG1pbkBrb2RlaXQubmV0Pg0KPiBDYzogQWRpdHlhIEdhcmcgPGdhcmdhZGl0eWEwOEBsaXZl
LmNvbT4NCj4gQ2M6IEppcmkgS29zaW5hIDxqaWtvc0BrZXJuZWwub3JnPg0KPiBDYzogQmVuamFt
aW4gVGlzc29pcmVzIDxiZW5qYW1pbi50aXNzb2lyZXNAcmVkaGF0LmNvbT4NCj4gLS0tDQo+IGRy
aXZlcnMvaGlkL2hpZC1hcHBsZS5jIHwgMSAtDQo+IDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9u
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9oaWQvaGlkLWFwcGxlLmMgYi9kcml2ZXJz
L2hpZC9oaWQtYXBwbGUuYw0KPiBpbmRleCBiOWM3YzBlZDdiY2MuLmJkMDIyZTAwNDM1NiAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9oaWQvaGlkLWFwcGxlLmMNCj4gKysrIGIvZHJpdmVycy9oaWQv
aGlkLWFwcGxlLmMNCj4gQEAgLTc5LDcgKzc5LDYgQEAgc3RydWN0IGFwcGxlX25vbl9hcHBsZV9r
ZXlib2FyZCB7DQo+IHN0cnVjdCBhcHBsZV9zY19iYWNrbGlnaHQgew0KPiAgICBzdHJ1Y3QgbGVk
X2NsYXNzZGV2IGNkZXY7DQo+ICAgIHN0cnVjdCBoaWRfZGV2aWNlICpoZGV2Ow0KPiAtICAgIHVu
c2lnbmVkIHNob3J0IGJhY2tsaWdodF9vZmYsIGJhY2tsaWdodF9vbl9taW4sIGJhY2tsaWdodF9v
bl9tYXg7DQo+IH07DQo+IA0KPiBzdHJ1Y3QgYXBwbGVfc2Mgew0KPiAtLQ0KPiAyLjQzLjANCj4g
DQo=


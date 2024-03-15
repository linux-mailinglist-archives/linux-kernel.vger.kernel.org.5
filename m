Return-Path: <linux-kernel+bounces-103943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2EF87C6DA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 01:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D55F4B21F78
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0C4259C;
	Fri, 15 Mar 2024 00:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="dGGWgqPZ"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2138.outbound.protection.outlook.com [40.107.117.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDE81361
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 00:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710464209; cv=fail; b=EJpSZ4Q6sCU0qu9XaNeX0w29Ntad3ACJRMUjzk59YD6c99uGjg63Fs+Lr/UyhXAXl6J6T79cImwbho2i4mQOs4MfS9WD34SaDLm4gvgdjAeeJZC4ZvFSL7J+x5Kkd8syBjF7RNAjrx2T5Uz5dS4vhFBFLL0SqqQ6HZDBIPXMXfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710464209; c=relaxed/simple;
	bh=puv/0PR9DVSJ91SoYHL3NspEglqLQ8XFlctbrGpvIiE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gJc3jcDmlOCgt+ZLy+xv3Xkup1ELxuSVCQIw7fD1XsehZqExXqB1QUIGWAgb6mh3bZDwxyfIY39yjVo6UqBNYcUDVPZyNr+QT3NefOOzFyeYE266i5nZizo0PDPABtp11FwpJh5OMDdY4I6Q5zFJERRALDQRIsc+kIXD9Z7f2FQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=dGGWgqPZ; arc=fail smtp.client-ip=40.107.117.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AIYu2vMNx1MZtylry+Vq61qe8ozNJRy3JmfK5HTapJnuDQqetj6u2ltimJAIPd4DzRJbjP2ISdMm0NuKlx+uMrAD+UujnnS3/BGHDubOeFsJIMx9knni5oQppam01RxF9jfVlXIlexdBhpU55EewAC7lbhF927Z1b3fR1FmAfTXW4dYAiLsczevkNyYHJh2Zcgl3FNL7bsFxc28GB5UcnJLrSaCMYQ4CikClwTpV9dIrSIDWzCvD2emlMusCSvvPwEgFq/fZejo1oQAvvOfiq+otvGT4H0unpJisPbxPvlVSmr4ZAYbQBEJRBKbJg7d3GAwoJi0O5GDIWro+SeCtiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=puv/0PR9DVSJ91SoYHL3NspEglqLQ8XFlctbrGpvIiE=;
 b=crbduuKcrlCgdWagdHHI2mn2OBZSv8Wz75ufrWoLBItmRtIEsreJOArTVRIiftJPyT6123gYD27cLCAwQhfoQUr8BZjAsQ2jSYi+K58/5FVutCBrX9OJNy0Hx8o9nBFYQMISK44frEljWgEO8KbDZjwdTs+gkkPNvYvcSWIGsSqbP2QaJyHc2Vy8QEMyjcvao1yx633+T4Qzbc23MDYMhehF3qxuIi++SmpG+4Fpnh3Y74SOr6mA61xuVHVpUcoWEZiAC8EacVV42qSJhvZbMejLBU+se/0xEaw3YEZoIi0bZb7mT0d1X8/slGMCOdpYloKmhZM5CIHz6HR8c8UwjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=puv/0PR9DVSJ91SoYHL3NspEglqLQ8XFlctbrGpvIiE=;
 b=dGGWgqPZj4ALTB4Z8wTwb5mgfHmmIsGiQ8PUYAhIZgWln03ovinbkiefaPBDHRGhKKnSwIVw1/fHgTTRSRex99vUYJ5232FsOTbpFf2f0t8g08+K64oiBQQ1As5lu82PphmMKS60dt0Nck/wMEejRu1X6eSzu3/iBmmEWIa0Qpni75LYQaHQ187+caMVt/eFtCGjpueT3unq8XXWQhoSFEk0W987pBd55GSJ+RXeY/EshJvFFQ2VHaPGJk8lI3dyP3uQuag0pTqeawDkz93DBK6j9NVQdadBWa/Nb4/5VMhXTAaVy4L/DgHs0lNJSnJ5TBbT+oGpIvCBi6PrT0b2cw==
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 (2603:1096:820:b1::13) by KL1PR06MB6942.apcprd06.prod.outlook.com
 (2603:1096:820:129::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Fri, 15 Mar
 2024 00:56:41 +0000
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::1ecf:ff1c:bbe9:49e3]) by KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::1ecf:ff1c:bbe9:49e3%5]) with mapi id 15.20.7386.020; Fri, 15 Mar 2024
 00:56:41 +0000
From: Rex Nie <rex.nie@jaguarmicro.com>
To: Peter Newman <peternewman@google.com>
CC: "james.morse@arm.com" <james.morse@arm.com>, "x86@kernel.org"
	<x86@kernel.org>, "Luck, Tony" <tony.luck@intel.com>, Babu Moger
	<babu.moger@amd.com>, Borislav Petkov <bp@alien8.de>, "fenghua.yu@intel.com"
	<fenghua.yu@intel.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Reinette Chatre <reinette.chatre@intel.com>
Subject:
 =?utf-8?B?562U5aSNOiAzMmJpdCByZXNjdHJsPyAod2FzIFJlOiBbUEFUQ0ggdjJdIGZz?=
 =?utf-8?Q?/resctrl:_fix_domid_loss_precision_issue)?=
Thread-Topic: 32bit resctrl? (was Re: [PATCH v2] fs/resctrl: fix domid loss
 precision issue)
Thread-Index: AQHadiPZ1gWMs35/vku96kkUckCWyLE37H0AgAAMbNA=
Date: Fri, 15 Mar 2024 00:56:41 +0000
Message-ID:
 <KL1PR0601MB57739915A074146DF05632A4E6282@KL1PR0601MB5773.apcprd06.prod.outlook.com>
References: <20240312075349.977-1-rex.nie@jaguarmicro.com>
 <fed6affb-c7f4-4992-8646-8f5a52c33966@intel.com>
 <CALPaoChnAt9+2=iVzpownX-bN+mb3Ujn_C=_QS2qsAph=LPSiA@mail.gmail.com>
In-Reply-To:
 <CALPaoChnAt9+2=iVzpownX-bN+mb3Ujn_C=_QS2qsAph=LPSiA@mail.gmail.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB5773:EE_|KL1PR06MB6942:EE_
x-ms-office365-filtering-correlation-id: 91d4d55c-7941-434a-a73a-08dc448ac6ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5pXl174rPRig1hnnPo41YbE+m6NAxEcjqrFycZI0cjTL/9xrgqtQ7X629MFMbnHdsHqtNNGSpY7Ed6lqQIAeQGJCE8vO3Nea5xe/k8xlvuH6C89LRSrk+b6csBD7Kcu9pIzMI2cApJgBLL/ezL9nhUNI0GCdOhWj/62sMVr1I/y1F8yksfC4WRpj+wcxpYkP+L4zi9wQ9Lim0BK1WvC0Wjc5UyZQUJggdeeWEJDf/IZ0juQtcgOtcX8QtZAm05l85Xbu4eNXVdL6miBe9AW+jA9lW8xOo+WNfB3abNLX86ZoqYGUO9nXU1Rluedy9jD8omYpJ9YtGXxG6JXgbkSFdvoOSwzaGqQLRJoxygYFc7fFZxCQB2QBvHAy04urb6OzFfaAhbroyT9HXN47RovBZ4zIOnkf8FGTbG4OmETVPBwIabtLj0hDK/Y8aHH9Fh2kupepaiDaWJ3Ito00eNF+A4VTHIsSK6jTjyY2705IWIm2iY9tzfghZ9E8rxW2sh1amB2NaZLNtUkmPFARN3GpSc39b+BMagR28wAvyABQw8kdLHLFV2rnMEYSzBM0FQOc17WJtd1NX2dfKCL+xWyWTvpO62nLych4pzjoUNCs/WfNVHkU+KK0USxGzXttp13EeJ+GlfND6jJI8q3F/gD79VsTsnSHWbWOBKWWORPy/lQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB5773.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NGNEcTRnOGVHNEJ6T1AzQWd1ODVNdnpwRUttbDBtSWF0YTFKT01KN29WR0wz?=
 =?utf-8?B?Y1JqVE10eWNJaG5yY3MyY0Z0Q1BtZktFQ1RGSmE4NUxvLzNZSkhSUU9TQ05Q?=
 =?utf-8?B?cDE1aTZWNGNLb1FUVFlKZSswVXM3RXBWSUhwVzYvZWE0THA2TnRKcnBBZWJv?=
 =?utf-8?B?cllvczNscDROWXFhQ2YwZlE5VnVvblJVbDI1Sk1Sclpmb2hTbGF1QzlneG1C?=
 =?utf-8?B?N0NaYWI4SllpdnFqcThiNWxIR0J4WDd5U0hxb2xMOVJlM1hIREVCc1BoNGIy?=
 =?utf-8?B?RmRGcHQvNFZiSE11aU12NStTZTRCVzd0ZHBBdTg3N3daNDBOT3JodERhOTkx?=
 =?utf-8?B?dHFGR1I2NTlFajBnNmkzVlE2cWUvWW1GL2c3RVdPbUhVNFlnNWo4ZjB2dE9N?=
 =?utf-8?B?VzZWQm1lY0ZOYjdhL2FBUG9vN1lJK2h4VEVmZ2w4Y3RHUkdic2lZNCtBQ3Qx?=
 =?utf-8?B?N3FoSm1ld3B5d3hTL1gzWStSM2E2NkZSWmlBTUQxbU1WZkFsZkhmTzlvUnlm?=
 =?utf-8?B?c2ZVY1VmVW5NSmJSbnd0alYrL01TSjNyci9pRG9icHBvc3RYNWI5eTBXSFZi?=
 =?utf-8?B?UlJDTFh4bGJXRnByNWlQbFBOSUlkdEFCZTUwWjgwNFozWWk5WGRhcmFzd2lw?=
 =?utf-8?B?dXhvMlNCcWRGM1VpZkNybm5LR0dPR3ZuVVRjNVpnMzFuVytpemQxbW9RRU1z?=
 =?utf-8?B?VVlvOWx3NDI2QTZ6WEtEZHU0NjBVV0Uvc1drbGVqa3U4eTFFVUhGUW9pYmIr?=
 =?utf-8?B?L0JwYkJxT3VmcEFzdXp0eThycmw1bDIydG83SWZGZzZTOGtMZk5rd3RXMDRL?=
 =?utf-8?B?ak0vSXBBb3Q2TGRwaHE1MUZKdjFVRS8vNjF1b1kydkF1cHM2d0xraVJuTmNv?=
 =?utf-8?B?aGpaZVc3UDJQZTlMU2VybWVBWGNLb2xudWRxbXFydHc4WXZwNENKRGtxWjNN?=
 =?utf-8?B?aGJTN25Ddm5pZEVVUU8wdHBxeDhSd2UxYjVRRXBIK0RSTnRLQXk0ejFTTWZC?=
 =?utf-8?B?K1FYUXhpM1hSbTJLUTdJNXluSTkvY1BZR29ReUlJdFlCZXpTNUZ5eENjVnJV?=
 =?utf-8?B?ZDBDc1lyL1RKcjJtSTQ2YnlOaXlWcmdNNVBJZFlCaHZvOXRXdDZUTW5ENzk2?=
 =?utf-8?B?VkFHeVNXcjZTUjlIQStidERCejFGV3pUbG9JU3R3NXMyWTA5RE1PSGc4UzJo?=
 =?utf-8?B?YmFVbmFTM1NJZUNZYmZoS2pCOXNCVldDTXdhVFZpVzZqNytZUFBwQS93d0Fy?=
 =?utf-8?B?ejRFa1lZai83dFdlVE5uMU94c0YySFZHMWtKV0xWSUZRSm5zc09DR0xIcUNU?=
 =?utf-8?B?Smk2TWloU3lod0c5VWRQUGpWV2NEczRRTEJ4bDdScVV5Y2hpUkpFYmU3MWdG?=
 =?utf-8?B?RjRKMS9QV1AwUThCdXlEZjA1bXJzT0VRUityRFNXQThkSWhlYXpzakZZODYy?=
 =?utf-8?B?aHlYTkE5Y1hOWmgyOTJlb0d2clBVWlFOUUpXamxwQkFBZzYralMrOEk5K05K?=
 =?utf-8?B?eVZPUDA5ZkFmN2hjQ2lWQW0xZjZlQzJ6dnI2cXZzdHA3SlNSZDg2eThVbGla?=
 =?utf-8?B?Y2hLZ2Z5MnhJemZuRHhMZzRFUmw2WWNDSEV0dWcwa3A0Qmk5L1JNWjhQOTU3?=
 =?utf-8?B?ME1DSkxmcXM1eWdYWGpDRVo1dUlBN0JBa0VEeENmcTBTaytBQTdZNkpLS2R0?=
 =?utf-8?B?TTJuam5RTFRoU0JTaWhJcDlEVXA3M0c2dHJZcklrdXl4ZFFLK3EyUHVNZDE2?=
 =?utf-8?B?WXZEMVBDVkZkSnIzRWZGWTZUNG1zNjgrVVpCWjBWRVovR2pCV1NQTUNvckdF?=
 =?utf-8?B?L05scjNIVVp6cGZrSDFLdzZ5cys5MVVyS1ZjWThwSGZvS0xsWnhTekdYc3Nn?=
 =?utf-8?B?R0Fqb2JGUmZqYXpCbG9ua2w3cnJaOXB0ek9RSGt6b09sbjlkS0M3eUhFM3pV?=
 =?utf-8?B?bWVvc3lhSS9KMFlPRTluNVVTYUN4WjZKbTIzMGcxYlo4VDd4S25EZ0ZlZzVF?=
 =?utf-8?B?ZEcwODB3aXdQOFdTY01YV2FCUjRGVytUMzZkY3JVZ01Lb25scWFvOCtrOW5y?=
 =?utf-8?B?dkVTZzloYlRkelU3Ull4aUY3MXRMcEx1cmFSQ0NFd0lvVEwwSjJyTzdXYjNW?=
 =?utf-8?Q?CoTUCAuJsT18JNIAYDRYbLBLk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5773.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d4d55c-7941-434a-a73a-08dc448ac6ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 00:56:41.2897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w559M5yCOEMkdr/rczxTNM66YYfUvC6gtXeWSZ9QdzODcO58l1Tlcs5iWfDBeiYRD7aGyPiA6zWnObA+gNbcPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6942

SEkgUGV0ZXIsDQoJSW4gbmV4dCBsaW5rLCBNYWNpZWogV2llY3pvci1SZXRtYW4gYW5kIEkgdGFs
a2VkIGFib3V0IGFybSBjYWNoZSBpZC4gRllJDQoJaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxs
L0tMMVBSMDYwMU1CNTc3MzA5OTRDMDUwMTIxMkRGNkREQzZFRTYyNDJAS0wxUFIwNjAxTUI1Nzcz
LmFwY3ByZDA2LnByb2Qub3V0bG9vay5jb20vDQpCUnMNClJleA0KDQo+IC0tLS0t6YKu5Lu25Y6f
5Lu2LS0tLS0NCj4g5Y+R5Lu25Lq6OiBQZXRlciBOZXdtYW4gPHBldGVybmV3bWFuQGdvb2dsZS5j
b20+DQo+IOWPkemAgeaXtumXtDogMjAyNOW5tDPmnIgxNeaXpSA4OjA1DQo+IOaUtuS7tuS6ujog
UmV4IE5pZSA8cmV4Lm5pZUBqYWd1YXJtaWNyby5jb20+DQo+IOaKhOmAgTogamFtZXMubW9yc2VA
YXJtLmNvbTsgeDg2QGtlcm5lbC5vcmc7IEx1Y2ssIFRvbnkNCj4gPHRvbnkubHVja0BpbnRlbC5j
b20+OyBCYWJ1IE1vZ2VyIDxiYWJ1Lm1vZ2VyQGFtZC5jb20+OyBCb3Jpc2xhdg0KPiBQZXRrb3Yg
PGJwQGFsaWVuOC5kZT47IGZlbmdodWEueXVAaW50ZWwuY29tOyBpbHBvLmphcnZpbmVuQGxpbnV4
LmludGVsLmNvbTsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgUmVpbmV0dGUgQ2hh
dHJlIDxyZWluZXR0ZS5jaGF0cmVAaW50ZWwuY29tPg0KPiDkuLvpopg6IFJlOiAzMmJpdCByZXNj
dHJsPyAod2FzIFJlOiBbUEFUQ0ggdjJdIGZzL3Jlc2N0cmw6IGZpeCBkb21pZCBsb3NzIHByZWNp
c2lvbg0KPiBpc3N1ZSkNCj4gDQo+IEV4dGVybmFsIE1haWw6IFRoaXMgZW1haWwgb3JpZ2luYXRl
ZCBmcm9tIE9VVFNJREUgb2YgdGhlIG9yZ2FuaXphdGlvbiENCj4gRG8gbm90IGNsaWNrIGxpbmtz
LCBvcGVuIGF0dGFjaG1lbnRzIG9yIHByb3ZpZGUgQU5ZIGluZm9ybWF0aW9uIHVubGVzcyB5b3UN
Cj4gcmVjb2duaXplIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4g
DQo+IA0KPiBIaSBSZXgsDQo+IA0KPiBPbiBUaHUsIE1hciAxNCwgMjAyNCBhdCA4OjI14oCvQU0g
UmVpbmV0dGUgQ2hhdHJlIDxyZWluZXR0ZS5jaGF0cmVAaW50ZWwuY29tPg0KPiB3cm90ZToNCj4g
Pg0KPiA+ICt4ODYgbWFpbnRhaW5lcnMsIFRvbnksIEJhYnUsIFBldGVyDQo+ID4NCj4gPiBIaSBF
dmVyeWJvZHksDQo+ID4NCj4gPiBPbiAzLzEyLzIwMjQgMTI6NTMgQU0sIFJleCBOaWUgd3JvdGU6
DQo+ID4gPiBCZWxvdyBzdGF0ZW1lbnQgZnJvbSBta2Rpcl9tb25kYXRhX3N1YmRpciBmdW5jdGlv
biB3aWxsIGxvc3MNCj4gPiA+IHByZWNpc2lvbiwgYmVjYXVzZSBpdCBhc3NpZ25zIGludCB0byAx
NCBiaXRzIGJpdGZpZWxkLg0KPiA+ID4gICAgICAgcHJpdi51LmRvbWlkID0gZC0+aWQ7DQo+ID4g
Pg0KPiA+ID4gT24gc29tZSBwbGF0Zm9ybXMoZS5nLix4ODYpLCB0aGUgbWF4IGNhY2hlX2lkIGlz
IHRoZSBhbW91bnQgb2YgTDMNCj4gPiA+IGNhY2hlcywgc28gaXQgaXMgbm90IGluIHRoZSByYW5n
ZSBvZiAweDNmZmYuIEJ1dCBzb21lIHBsYXRmb3JtcyB1c2UNCj4gPiA+IGhpZ2hlciBjYWNoZV9p
ZCwgZS5nLiwgYXJtIHVzZXMgY2FjaGVfaWQgYXMgbG9jYXRvciBmb3IgY2FjaGUgTVNDLg0KPiA+
ID4gVGhpcyB3aWxsIGNhdXNlIGJlbG93IGlzc3VlIGlmIGNhY2hlX2lkID4gMHgzZmZmIGxpa2Vz
Og0KPiA+ID4gL3N5cy9mcy9yZXNjdHJsL21vbl9ncm91cHMvcDEvbW9uX2RhdGEvbW9uX0wzXzEw
NDg1NjQgIyBjYXQNCj4gPiA+IGxsY19vY2N1cGFuY3kNCj4gDQo+IFRoaXMgZG9tYWluIElEIHNl
ZW1zIHVucmVhZGFibGUgaW4gZGVjaW1hbCBhbmQgSSdtIHdvbmRlcmluZyB3aGV0aGVyIGl0J3MN
Cj4gdGhlIGJlc3QgdmFsdWUgdG8gdXNlIHRvIGlkZW50aWZ5IHRoZSBkb21haW4uIERvZXMgdGhp
cyBzeXN0ZW0gaGF2ZSBvdmVyIDENCj4gbWlsbGlvbiBMMyBkb21haW5zPw0KPiANCj4gVGhhbmtz
IQ0KPiAtUGV0ZXINCg==


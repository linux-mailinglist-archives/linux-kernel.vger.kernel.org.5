Return-Path: <linux-kernel+bounces-94215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FE9873B87
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20D2CB243E3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674D813E7ED;
	Wed,  6 Mar 2024 16:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CNfI7nu5"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B361113E7D7;
	Wed,  6 Mar 2024 16:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740876; cv=fail; b=ONkEW680xNU7m32YSOVBWTIMa2kQnE6N4+bJX21tihckvX6wYtFanZ4FbhGKosE1JIwVtQVDxGY4PC5I7afeFGWDofUbz+LY0/2nsaGIRNgDO1LcIwo00FK5E6FYPc6AH3Ydd1Gz/PLfifzwQFqZDnXjMjCpCuZiT74e6nYySlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740876; c=relaxed/simple;
	bh=FRlsj+vWPPYTGD6mq2NJx4FLvhe040g1jgkAgidGtaw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FZ0Iw88kQddVxRi7ln3u72vepnDxt/J0WSbOhPBBWgZ15l/kGQJ1o9H3/6WrHSAigY4jPu0HGt9TMkDs6tTIo4AHkXnyqJg5rjV2ZcR9o2ZmPKberYBdlFydTWg2jWcO8Y6p7HgANUXYq3zjcYGR8KpIWS0S/mk7DuSFK3hJEYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CNfI7nu5; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nccrZdi4CV/+MlUTDVuDkcLG5ftARyeShgUgWEwpfvxPfI9rU6qBj0Boluti0mPwniMz6YSsoV7EtHM4DS3PogLAWNUJkBXrq7J6zf5y6eLzCd8Cv27rLNmXIZK1VGcN/VOyzc4VFaH0C7xyFwxm0fck/BbqGoS2rvMZ2jBaBl4byh2YBgsrgEAjW/1z9SOp1lE49xGy+QEkLEoqumqe0wDDWHv8K3uRAy09SowmMsuL3EiHrEVq1Y/M9HaHB4o6iOZfC2mswd5W3kWZaoMrwM/pIMdXtFh5ff+9g34njeF9E2u+DtDDTO+E+yywv6csZ+eD7uYOkqmWC4elMvhaow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRlsj+vWPPYTGD6mq2NJx4FLvhe040g1jgkAgidGtaw=;
 b=UgfJ04qx1Zdn2ENk9icwg9c66Dw2oThdCSzdVy+N/PyKC9AbNlk6Qfj4rqi9uI2bLwBD+pdSzNir4ZlFdRWnGOxz4Q9efDtNaQvgiB6KfJBSpvykFGqWo9EcOqHGPKS1m7JdiOvKCu8S9w/Kmx6IXwpYRQdlksPf+mhoCXhaDvuzLt72xtWlXAADOhtT0dV2vxOyOVEYiZDi/qMx0p6jQMjSzIWHz0BKI0Zu3rSB/7D02OuVpLo2gcQ75RxsjBvKOkWOxLOgvU4Pim4ABo9DRFXY9ZL9AH7Oy78Dtj+0c4lyRg1mKs15RY32bUqoBUI/S6O47bIlWbY36gT6k4cDjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRlsj+vWPPYTGD6mq2NJx4FLvhe040g1jgkAgidGtaw=;
 b=CNfI7nu5GzJMsXvOKI3Mv0Oc8s87JPIt0tmrKau2X2giqQYu5i+Eurce0fWb0S2KEIsvaQo0Hg2ly8lGkZogZGECcPWn6neCuSwXkeaNheMhX0On+nytODuYdeQRGSf38S9exYsXXLRT9peE9D6U6u+KxWFpXhvAznsyVTe5D9Bt19eV0BaV2YfULeIAjj+PK1jMuZiosOpFdvLEwyFF+kumdcHsYX67bQq1Gjn+mB0XvMr+t9hiOFiiVUBEquRtY4Si4TI2aB64z3AYHTBg5Lw9VJq2iiKlEnqAuL/HhDVmEandB+H5VHnTsX5Csi0Pyj00+8HmEM8o1MoeLvlYnw==
Received: from BN9PR12MB5381.namprd12.prod.outlook.com (2603:10b6:408:102::24)
 by IA0PR12MB8861.namprd12.prod.outlook.com (2603:10b6:208:487::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 16:01:11 +0000
Received: from BN9PR12MB5381.namprd12.prod.outlook.com
 ([fe80::122:c58:8a3:743d]) by BN9PR12MB5381.namprd12.prod.outlook.com
 ([fe80::122:c58:8a3:743d%5]) with mapi id 15.20.7362.024; Wed, 6 Mar 2024
 16:01:11 +0000
From: Vadim Pasternak <vadimp@nvidia.com>
To: Daniil Dulov <d.dulov@aladdin.ru>
CC: Mark Gross <mgross@linux.intel.com>, Andy Shevchenko <andy@infradead.org>,
	Darren Hart <dvhart@infradead.org>, Hans de Goede <hdegoede@redhat.com>,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: RE: [PATCH] platform/mellanox: mlxreg-hotplug: Remove redundant
 NULL-check
Thread-Topic: [PATCH] platform/mellanox: mlxreg-hotplug: Remove redundant
 NULL-check
Thread-Index: AQHab9xfnK+/KvM0KU29Hhkf8ALdwbEq3xuA
Date: Wed, 6 Mar 2024 16:01:10 +0000
Message-ID:
 <BN9PR12MB53813701D8E50C8370C7C387AF212@BN9PR12MB5381.namprd12.prod.outlook.com>
References:
 <BN9PR12MB53815F52C9033DC526085827AF232@BN9PR12MB5381.namprd12.prod.outlook.com>
 <20240306153804.6509-1-d.dulov@aladdin.ru>
In-Reply-To: <20240306153804.6509-1-d.dulov@aladdin.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5381:EE_|IA0PR12MB8861:EE_
x-ms-office365-filtering-correlation-id: b202c3e6-d95c-480f-305a-08dc3df6a474
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 zm1o9Rayr7Ak+L7L4nMAgYmzj8ML5oWdsQH2CG32yAsLLxC3tCiz3+fVDBRPqPfOmN95D10EwqfnnEGqCRZw5qRYMgoaGEft+5vCARFtNIEbdmVAcJOmls5Gse3/q+P+iNi+Jg6J4Za3d0RTAYvHStmpnPV8w9IMVB8fu0Y2gZ0/wXZiY3uQVd63mfTswYzADcIeHNrirDOnlVqTRrJ7FpjtFrh5FHXUKoGDG1X67ihDk9lavyXknwO5ftUpqPanr9ok+wQMoO143QuttutKns2L/6Vvwayo4xtkWbrrgWTu6mvud2CzVb19utv0hOc7jirrdaPRTgTex0mDJSbcjD5plx/aozwqJg/TBoectaz5XxhpmHMsUYnvG2Win9NJON9afEKUSMYVEbKLoWDmKoVDdMGelQZm//tuosnLxxvZPpaHUX1Rwb9HofV2x/W7iYVN/rLJ/JmKnmwPdV6yPJYWYKF4zCAMt6fZknX6YKLvbNaInz9oGQLnJcRYh5eiGhB/QTfg4hxDuRwdsy2Q4WNY7gAdOC1+qom0G6PK9MGXzkqnDsjEzbBucb9TLfOa4SUMRAuqNpEHwnqr73nLUP8rt21pxVyWIVc1ZxFXwY0ZYaeKx47qeAM8fBjR7MulOsoGoaUzGmFJOwDay1ae4iR4smReuv9axdOsb98dQBtLq/YQBWtYXpohJivrrLOh3Z/F1pr1YNrg/eDzfhFLKqM1h7QcSPbknFNlyPDfo2w=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5381.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TkRoL3dHS0I4T0hSOFcyaEcrV2J6c2crbE1PNVNMSHZJQTlHMzY3Q2l1WUNE?=
 =?utf-8?B?SDh5elFXZ01Dd00zS00zalNRcGZTa0FXVFZtUlRXWTIrRDNZdXRSTkJGUGx3?=
 =?utf-8?B?Q2R2a1ltVjZRdkNTdnlQNXhObWlCUHFIVllTcjhyTjZwMDAyakR1ejdOdXBM?=
 =?utf-8?B?a1d6WWdpV3Rnei9paGQwTldqNGpTdW1kdk1yRDRLbExwYUg4WlJoTkJMQTVK?=
 =?utf-8?B?VnlZeTVIRWNlTXJQZDVNVDJNWkFJLzl2bjhva1ZUclIrOU4wWjNLRENUNVhZ?=
 =?utf-8?B?amE2NGo2QjZ1eTh6bVhDTm5DemZVS2huQzhJa1pSb2hiMWlNR0ZWSndSc2Ur?=
 =?utf-8?B?bXBtQ05hdElsejVJeFBLRkhOWUVQTTltMHZLU0hSZGNxU0owMTZ0WDBnWGo0?=
 =?utf-8?B?MmRzdnRKbms1NmZnZDBPZmNmOHRHYXh2YnJuQ2pWVStmeGFJSjh1cEpnQmNz?=
 =?utf-8?B?Mko2Q2VZL1FMQzRxcXlNeTFsUmIyMDY5cDJoN3RXdmFQLy9xVWFqRGxydzBL?=
 =?utf-8?B?UGVncGh2NEJPbDhyMXhUeks4VFB1UTZpWlpqMjFVRWp3Y3daT2dlTHNSblRq?=
 =?utf-8?B?djlIUlVUUVdpOGRyNWY4bUJDbE5aeXJDeWkzMURYWHFrcFhmLzF5OTZ6eXJm?=
 =?utf-8?B?Z2dRb0M0OXhjNExJbWd5T0VFei93Z0tXS0NCTk9WU1RHMG9OVWVrZTAyMFNj?=
 =?utf-8?B?b3VPL000WU9QdFEyVUg0SG9BaU1tQ3dUaFZEckh1b0U4OGZVTzVHTCtZTENT?=
 =?utf-8?B?SzBrdW53Y1gzNDFLbThiZE5wSVBuK0JIR051eCttQUtMRDBJMXYxSzhoc0dL?=
 =?utf-8?B?K2pEQjZPRG1kbUo4NDlQZjZ3enpaYVg4WHhSZGtpeElwaUdhOGM5TVRzaGlT?=
 =?utf-8?B?aG5sN1ZZZ2JqT3Rrd0ptUmtneHhwZU5sdmREMXNmTmtJU0xGdVU1K0wzQ1Qr?=
 =?utf-8?B?RlA1eXM0WW9YQi9Pd0wzMmpFVFIxVmUxbmljK3YxVGVxT3k3NTJEdGc3ZWs3?=
 =?utf-8?B?Ync4TWo3bDlHeGNOcUVZWDFqSHA3Umk1QWpzYm5aOExDNG1uQjZCa2t6QmF4?=
 =?utf-8?B?WlJYa1NhRlFRcG4yUm9ISVZ6UVUvQ05wektRM20vaTFiVU9KS3FldVZVano5?=
 =?utf-8?B?Sk8xOEduSmZpam9BZTJsNUxhd29hd3UwenpxUUFjVTlnSHBhVkc0S1g4OHds?=
 =?utf-8?B?TmRxQnp1RTB0WHFLSHFUVnJQc2lrWDAwemdFQWlXOHBhM0o4UzB2V2oyV2d4?=
 =?utf-8?B?MHRBU2MvNW9wRWhET3RIaVlxU3ZId1ZrRlhTaDRReDVaL0duMnNNOERrNkZT?=
 =?utf-8?B?UG81SDBMa05nRTNpdlJIK2Vjc0JSV0picjc0RUFzZmU5amxUbDlIVXprOThC?=
 =?utf-8?B?bUViZng3Y3NwdktXTXA4a1JLZHR0WEFtdkFFQjBxNVZlOThwWjlhYUl1dUxn?=
 =?utf-8?B?Y2N4WEZNTlE2OUhqMEF3WENFaDd1VVBaQ2o1Tnc3MHlZTGxqc2RNU0FsK1Z3?=
 =?utf-8?B?aHhXV0VTdWhxclc0ZWc1N3BiYUw5a1laS0RUemZIeEtBVVBuLytVQW5MRUM5?=
 =?utf-8?B?NG5MWGVzV3VoSzFBM21DQ011ZnlEbTNIa3U4WU02Sk52SGVTL0UrTm5Xa1g5?=
 =?utf-8?B?b1dXRXdHd0IvS2FlRkQ4RHdlRSs3VUpIOWl2ZmFGdDVHOFRtbTR4c1FCV21L?=
 =?utf-8?B?b1p2ZFhuaXBMbHFCNEF2Y1FoMXNyNVhoYjZTQS9EdCsyRnRaWFA4bE9zVWtN?=
 =?utf-8?B?dEtyZ01UM2ttU2R2azdyYlkySmJGc3BWODBrNEQyOXZ2eFkzSSsyS2wvdGQ2?=
 =?utf-8?B?RUdiZUt2MGpwdVJqZGFQUW9SUXBWZ3hDaHRxc3N6TjRGRTlQUjk2RUVUUk5t?=
 =?utf-8?B?ZlpKWUFTOXRVc3BtMUJCSm80Z05ubElFSENLbGNwNWFsQXlKVWEzakFiL0Jl?=
 =?utf-8?B?Y1pWeThyVTlRUjFhOXNlSzBtN05sNTliYTFLZHE1N2tXTjNxTGp1Mk1Wc0pJ?=
 =?utf-8?B?clRoekZHNXZ3SkFCcXN5TGwzb1ZTdGxBSVp2cnhTS2wvcHZkYnlxd3RFOXRs?=
 =?utf-8?B?azhtd3hXR2NyUzZHVkZhczA2K0pnUk5qWFdmcThCdnZMdmNuNWMwMGh4OHRZ?=
 =?utf-8?Q?kb7hBCeHe5CbDPoCehsNQw+8+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5381.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b202c3e6-d95c-480f-305a-08dc3df6a474
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 16:01:11.0043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WTM9JtMp53YADMnamwi6LA4AFKJ/NvvvSisXpsXBEIXRX/L5/lborXr/MoVtYy/JJ0/30KqONyuH+urqdPHKlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8861

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuaWlsIER1bG92IDxk
LmR1bG92QGFsYWRkaW4ucnU+DQo+IFNlbnQ6IFdlZG5lc2RheSwgNiBNYXJjaCAyMDI0IDE3OjM4
DQo+IFRvOiBWYWRpbSBQYXN0ZXJuYWsgPHZhZGltcEBudmlkaWEuY29tPg0KPiBDYzogRGFuaWls
IER1bG92IDxkLmR1bG92QGFsYWRkaW4ucnU+OyBNYXJrIEdyb3NzDQo+IDxtZ3Jvc3NAbGludXgu
aW50ZWwuY29tPjsgQW5keSBTaGV2Y2hlbmtvIDxhbmR5QGluZnJhZGVhZC5vcmc+OyBEYXJyZW4N
Cj4gSGFydCA8ZHZoYXJ0QGluZnJhZGVhZC5vcmc+OyBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUBy
ZWRoYXQuY29tPjsNCj4gcGxhdGZvcm0tZHJpdmVyLXg4NkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGx2Yy0NCj4gcHJvamVjdEBsaW51eHRlc3Rpbmcub3Jn
DQo+IFN1YmplY3Q6IFtQQVRDSF0gcGxhdGZvcm0vbWVsbGFub3g6IG1seHJlZy1ob3RwbHVnOiBS
ZW1vdmUgcmVkdW5kYW50DQo+IE5VTEwtY2hlY2sNCj4gDQo+IFBvaW50ZXIgaXRlbSBpcyBjaGVj
a2VkIGZvIE5VTEwgYXQgbWx4cmVnX2hvdHBsdWdfd29ya19oZWxwZXIoKSBhbmQgdGhlbiBpdA0K
PiBpcyBkZXJlZmVyZW5jZWQgdG8gcHJvZHVjZSBkZXZfZXJyKCkuDQo+IFRoaXMgcG9pbnRlciBp
cyBhbHNvIGRlcmVmZXJlbmNlZCBiZWZvcmUgY2FsbGluZyB0aGlzIGZ1bmN0aW9uIGFuZCBzaG91
bGQgbmV2ZXINCj4gYmUgTlVMTCBleGNlcHQgc29tZSBwaWVjZSBvZiBoYXJkd2FyZSBpcyBicm9r
ZW4gYXMgaXQgaXMgc2FpZCBpbiB0aGUgY29tbWVudA0KPiBiZWZvcmUgdGhlIGNoZWNrLiBTbywg
dGhpcyBjaGVjayBjYW4gYmUgc2FmZWx5IHJlbW92ZWQuDQo+IA0KPiBGb3VuZCBieSBMaW51eCBW
ZXJpZmljYXRpb24gQ2VudGVyIChsaW51eHRlc3Rpbmcub3JnKSB3aXRoIFNWQUNFLg0KPiANCj4g
Rml4ZXM6IGM2YWNhZDY4ZWIyZCAoInBsYXRmb3JtL21lbGxhbm94OiBtbHhyZWctaG90cGx1Zzog
TW9kaWZ5IHRvIHVzZSBhDQo+IHJlZ21hcCBpbnRlcmZhY2UiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBE
YW5paWwgRHVsb3YgPGQuZHVsb3ZAYWxhZGRpbi5ydT4NCg0KUmV2aWV3ZWQtYnk6IFZhZGltIFBh
c3Rlcm5hayA8dmFkaW1wQG52aWRpYS5jb20+DQoNCj4gLS0tDQo+ICBkcml2ZXJzL3BsYXRmb3Jt
L21lbGxhbm94L21seHJlZy1ob3RwbHVnLmMgfCAxNCAtLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDE0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxh
dGZvcm0vbWVsbGFub3gvbWx4cmVnLWhvdHBsdWcuYw0KPiBiL2RyaXZlcnMvcGxhdGZvcm0vbWVs
bGFub3gvbWx4cmVnLWhvdHBsdWcuYw0KPiBpbmRleCA1YzAyMmIyNThmOTEuLjBjZTlmZmYxZjdk
NCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wbGF0Zm9ybS9tZWxsYW5veC9tbHhyZWctaG90cGx1
Zy5jDQo+ICsrKyBiL2RyaXZlcnMvcGxhdGZvcm0vbWVsbGFub3gvbWx4cmVnLWhvdHBsdWcuYw0K
PiBAQCAtMzQ4LDIwICszNDgsNiBAQCBtbHhyZWdfaG90cGx1Z193b3JrX2hlbHBlcihzdHJ1Y3QN
Cj4gbWx4cmVnX2hvdHBsdWdfcHJpdl9kYXRhICpwcml2LA0KPiAgCXUzMiByZWd2YWwsIGJpdDsN
Cj4gIAlpbnQgcmV0Ow0KPiANCj4gLQkvKg0KPiAtCSAqIFZhbGlkYXRlIGlmIGl0ZW0gcmVsYXRl
ZCB0byByZWNlaXZlZCBzaWduYWwgdHlwZSBpcyB2YWxpZC4NCj4gLQkgKiBJdCBzaG91bGQgbmV2
ZXIgaGFwcGVuLCBleGNlcHRlZCB0aGUgc2l0dWF0aW9uIHdoZW4gc29tZQ0KPiAtCSAqIHBpZWNl
IG9mIGhhcmR3YXJlIGlzIGJyb2tlbi4gSW4gc3VjaCBzaXR1YXRpb24ganVzdCBwcm9kdWNlDQo+
IC0JICogZXJyb3IgbWVzc2FnZSBhbmQgcmV0dXJuLiBDYWxsZXIgbXVzdCBjb250aW51ZSB0byBo
YW5kbGUgdGhlDQo+IC0JICogc2lnbmFscyBmcm9tIG90aGVyIGRldmljZXMgaWYgYW55Lg0KPiAt
CSAqLw0KPiAtCWlmICh1bmxpa2VseSghaXRlbSkpIHsNCj4gLQkJZGV2X2Vycihwcml2LT5kZXYs
ICJGYWxzZSBzaWduYWw6IGF0IG9mZnNldDptYXNrDQo+IDB4JTAyeDoweCUwMnguXG4iLA0KPiAt
CQkJaXRlbS0+cmVnLCBpdGVtLT5tYXNrKTsNCj4gLQ0KPiAtCQlyZXR1cm47DQo+IC0JfQ0KPiAt
DQo+ICAJLyogTWFzayBldmVudC4gKi8NCj4gIAlyZXQgPSByZWdtYXBfd3JpdGUocHJpdi0+cmVn
bWFwLCBpdGVtLT5yZWcgKw0KPiBNTFhSRUdfSE9UUExVR19NQVNLX09GRiwNCj4gIAkJCSAgIDAp
Ow0KPiAtLQ0KPiAyLjI1LjENCg0K


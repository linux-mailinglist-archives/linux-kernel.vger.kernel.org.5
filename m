Return-Path: <linux-kernel+bounces-86229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F3786C270
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E5871C22D41
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A3F44C97;
	Thu, 29 Feb 2024 07:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mEqiEwWl"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6684A44C69;
	Thu, 29 Feb 2024 07:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709191420; cv=fail; b=awjpPBmeXrIYUP81xz8iaDCUlWwv5zWVbP4zBEikNjV9CzfnCU5DOoDLy4OsOjmPsqLl+VjIl4evaivsHaGsP+ikvHlKy6q/0YWZWyYKA4oOjii5Yzp1siFtGszhVj1VzSdgPPRJF/YtP1j70ZfI1oR/z1Nw+PS7bAUcWFxjaa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709191420; c=relaxed/simple;
	bh=ZN0ihHmAoCVHGs3bNP3SmYBxWDnSS4QszB6Ch1l64sA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gm3NB2a616CbdZiJN8sHvtqsaiMfb+KOjKgnVE0Hb+S3rjCG0r4jsVA3wRdvLSinKwLA+9k8tDHV6t7TFsqMl/3/gbL1yXAb3KTyjE7upgi+qh+nNS5XGZfPgYMQ15gN2MBvTfc2dwa1Pa9F1gnNsoXLiVbUFnDBMbh9bq2aXsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mEqiEwWl; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWbg3dENnTl3skDBhl17ihJ503uyHJ6gjKB3A5hFabvYSKfB2yFTq7LTPgeG8JxNYREL5v971dBsQEboJr100IRGPuNHgiShEcQ45IErtd9jfa2T/kGpXlDwKwqxS1nlXzgdftnU2sdD2HpWggAog9dxzdNQ3mHJlLw5WnIB1uL1AODXLkzVorSJ2XnnInQC67Biso8b28RfTvTOvJ1JmiJOEqOE0FImeT5doPJJJk5x79IOMJfS8yYajPBosbp1dNNmlTgS8X4gJFt8wgkhw2e5LWBVkTeYigi1QPgkS91bW9mudOEeVzU2JTlZGdFZwoZKB0c9qCgRzxiUXfH29g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZN0ihHmAoCVHGs3bNP3SmYBxWDnSS4QszB6Ch1l64sA=;
 b=lnzuTRhIoqCIjU+Ct9J7owYRbrehlnN+rhj8i71o9SF+2rPU4Rq8kLivG9NsgEOEgdnoz+Amb0ov2rGK3JUoYsHrGdHBTMIE7dqh110gKlZ9RY1oBFSnC2Mv3uxddOIN9Z3KKHayiF2ciw7FRzP39QF+ZouVpZKMZ/6r2e6LWDp0/JKxVqQVMziY57v2AZMJIjpzUyN0sEkNkUw1wuDWNouXXgVvYFBRjbUkKR2hoTfD+hppbhPEYDYYS4un0h2naVo0KqOY/AGNQdG/QbGcglDqhxEozRmka3Wp+R8/C+582zmOCGeKH3++DC77GyuWADCD4lGm94QpkbMSyzhcog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZN0ihHmAoCVHGs3bNP3SmYBxWDnSS4QszB6Ch1l64sA=;
 b=mEqiEwWlqnk7ynIcvixY+0m0xJlwBOFQKtJZ+x5VGWrKTtBTjOjZb7CK/nMOptfiEWZmx7FuIRUEesTODSPAvzMIY4a9VwQS0DanrKUusWIzgpMVCzYZLw8uIgUJODJbVZl0Sm4QNWtVuteG1VageJpCL+/fqD9yW+zyLxl+bLpTxzalive2GERQmB4p8hL3xzROqI4WHIbpWFGCsBCG7vLQgiGEplScZ7V48LFUWWPdzhAA7F4TQEH23h4D+Lsy9Shq3ePG9HIQ6iXc8oj/+ZQ88K0b2NtrRF68MdhghNhzwsc53zY7aq5dzuT3Vb0C1bFnxH0JE1po4AYk/wg9Yg==
Received: from BN9PR12MB5381.namprd12.prod.outlook.com (2603:10b6:408:102::24)
 by PH0PR12MB8776.namprd12.prod.outlook.com (2603:10b6:510:26f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Thu, 29 Feb
 2024 07:23:32 +0000
Received: from BN9PR12MB5381.namprd12.prod.outlook.com
 ([fe80::122:c58:8a3:743d]) by BN9PR12MB5381.namprd12.prod.outlook.com
 ([fe80::122:c58:8a3:743d%4]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 07:23:32 +0000
From: Vadim Pasternak <vadimp@nvidia.com>
To: Randy Dunlap <rdunlap@infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
	"linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>
Subject: RE: [PATCH] leds: fix 3 drivers' kernel-doc warnings
Thread-Topic: [PATCH] leds: fix 3 drivers' kernel-doc warnings
Thread-Index: AQHaat+oN9HA7ClIzkOf6Rn2DbElGbEg6mcg
Date: Thu, 29 Feb 2024 07:23:32 +0000
Message-ID:
 <BN9PR12MB53810AD438785B76C38F3CF5AF5F2@BN9PR12MB5381.namprd12.prod.outlook.com>
References: <20240229071931.7870-1-rdunlap@infradead.org>
In-Reply-To: <20240229071931.7870-1-rdunlap@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5381:EE_|PH0PR12MB8776:EE_
x-ms-office365-filtering-correlation-id: f0c6b092-6fe0-4aec-e677-08dc38f755cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 PUPIXnqp+exnik9xMyxvLEa2k/tW+7C23HJVDp7QDBUW+paRc0lh3waNcRt2TGoYISSp32WuyoW5Kk4rDb79JZWoKscnJF8TEozSZZL3cVOUWwWJQqUyW+upe6miAmTWXSPWOxOMvhvcAIdoB6bpleGwAREDxl4xkFmensTRPangsrHJBKhh3rQvqpXwof7evszdgfZ1TKX5CabybGy/AfmxVgaPFeDvnEP+x2L/Q0t09fuj9LUuTuHk0BhVm5kRVsvSRtn3m+xApM+eRQULbmVkJYYfoo4szjIp03AGaeRufKCvbpWXPkv+sost7pzFYiboZWKJ61y5MkOx1gD2YAUFcCwaTS1GNwRWDHwies5lCkDZszFyIuKo77MbtG1VJ4y+42wo8UUNws7z+ZGqFezsK2jgY5VwWXnrqYD5W2D9FkYRYr7be+HWXekCrCjobpuxo+Zo91nyn8OmVIWMX1mHTZ87mKP+qKu0WuF1JvQDE3+00vi0jWtwYF2/nwfPQ6DmGZdY7Dp67cIL95JJi2a3pKlig+h8vMintZxYmGDjqvnco/2fCMnVY4nZlT2DMiYcOhnC5vQ3xBJlWv7shsbEXkCPOfKyN4cpYDYJwsc4EppzoVjOAsXRVJ8yX/RFZhlC6FQv8tvL/qokAFOTn8M0PETsnFzRl8xCMhI4vbZEEEif+F0gJ2mZRun7glx4IlNGGWKPxVLRWpn7qEwSZA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5381.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZDBFRS94L1oxa2tXTmxzcy9FRE5HRlRIOUs3ekNFNUREc3lVZERjUTdTdzZ5?=
 =?utf-8?B?dEwwRnRIcExmMGp3OXgzNkNjZFZ2MlI0UHpuR1J5a1ViMS92ZXgrRTJSK0wx?=
 =?utf-8?B?V1NvZ2tjSVIzYVFHbTBTdEZJc25TYmlreFhSTXlLVExxamovWlZ4cUxUUGxk?=
 =?utf-8?B?QnFNSnVZano2SmVoMmpvNWMwVGFyUUtMbUFybkdGZUpTQjhzaC9uRXpOWjlW?=
 =?utf-8?B?Y29XWWtzalhvQVQwbHR5L0FTeDVTTWNTRFFpT2F2NjBsYUwwa3hQM1ZpeXQ0?=
 =?utf-8?B?Y29VM3I4Wkc4UjNaL01rWjdhR2xPSlJML2wrenF3dkFuRTBoeTc2RzdNNlNP?=
 =?utf-8?B?NUJEMmY3ZmdadGRkeTNId3pINHNZV285QnhhUk1ZN04wVm5qZEVJQlVvMGg0?=
 =?utf-8?B?WHFod2pWQWRIQmh4VnN4Q1diQVpOUk5jS1dLcHJ0cldRUDQ5K2s3enBtb0sr?=
 =?utf-8?B?SGtFVm9LcjZTcUpwd1hTdElqQ3BRemFqdmo1VDlySmRxeWlzclZON2RkNEpw?=
 =?utf-8?B?bFVwN1J4NmduZkdwb2F6NmdxdXNEZlF4NVAyMDhyZ2IyOSsrc0orRDZ5Yzl2?=
 =?utf-8?B?TnBRb091R2xTTVp0NVpodlBybi9rR1pIZUp3ZjZvMWpGL2Via2VEbEI3U2hE?=
 =?utf-8?B?Qk9SeXpxSUZhdTJxUUM5TkxFZ0R5TDhJWDdScmdtSk5ncTkwUnZTMnE5OTY5?=
 =?utf-8?B?U00yWGpzM28vOStBZ3l6VUkrczh5cnpvb3hnbmxZSUxIRHJOWFRGQWJFNW9x?=
 =?utf-8?B?ejAzRS9WcTVSQlpZZlFSSTdGVzU1Zlk2M1lRUUNLeTI2eWRFOThTcFdQR2dh?=
 =?utf-8?B?a2pqOXJNYlY2WHFwNkdhaTEwZ1RsN2xRZU12UHZBQkVySjRISVBseEFSMnlV?=
 =?utf-8?B?RklIaDdEQlJkbTdlTThrSVlDSUtubkNJNVRXL2RaSno3cDhCM1NXS3NaMXF5?=
 =?utf-8?B?NkkwYmVKR1liR3EvYWl0QnR0S1VDTlBUdzNYakNMQWJLNTZNOTNlUzhMYmVa?=
 =?utf-8?B?M2NpVVpEa1V5TktMdVRiQVRvZ3R4NmcvaHRlMXNGMGh3STkzb2FYc0VpcTZS?=
 =?utf-8?B?YkVOQythTFpxY0QxMmZvWEJiVlh1M2diR1JIbURFNWQwaUY3TUlrUFJjWFNm?=
 =?utf-8?B?azVEYWwrcmZ5U1pGTTNkU05MVXJZRUNQOXVTU2pVdWQyVVlEYmJRK0Y5YzJa?=
 =?utf-8?B?V29JVm1HT21tN0IrZnRLL2VWbTBnam1YWTN3bDhOL3dLamJUUkZsTUdrWmdS?=
 =?utf-8?B?OUxKYnBmN3dXM01hTG9sbkw3bFpiWHBaV3FiOTFKUkthQnEzM0RydERjSVRD?=
 =?utf-8?B?M2pGcERyU3hVR2t4WDAzRXFrUGhTeDVoVTZWSk1rVFp1K1ZjdTBoTjJTTTFn?=
 =?utf-8?B?TEkyUy8rWC9jQXJQY0E5eVo3bVdrMWhBWjlqOVVnaXJLandIaElLellOOWh4?=
 =?utf-8?B?emtjeHdMa1hhaGhtQk9oSnJhWGoyRGVlZE5BN3BPLzZybTREMUlIeG4rWGdi?=
 =?utf-8?B?T3E0WnQwQ0Q3K0FSaHFTa3BJdVAwNVdJQVk1NVBZYzhlSmkvL1FqUUtoQmcy?=
 =?utf-8?B?b01HYXdsdjFDMWwzSlZNaUlrWTJUNW1YVEFoNnFpUzFWZ3Z3YzVhc0FFemdZ?=
 =?utf-8?B?ejhMNjJhSzM2YXluSzFrMkVySzEvR1NsZ3ZVVE9naEM0Tm1xbWJvcGpqMm5h?=
 =?utf-8?B?WnlzR2RKaDRucE53Ylh4a0VKU0VqUkcrdzFnZTVTQlRuZHBHNWtIVkdFVUNy?=
 =?utf-8?B?R1lqVXk5cGliTVdBd1MvejVQK21jdUVOemNDNUtiaXkrZGFobFU5UzZ3RWtn?=
 =?utf-8?B?UWptcm5IczhMZTVENVR0dWl6WjlCSStpcExOb2pNS2JsU1lhanBjVnhybjlp?=
 =?utf-8?B?Wjk1aHMvWkw4Q29xZnVnUENma01TSE1UWTEyMDJkQ0U2ZnM3RjluWXloUzQv?=
 =?utf-8?B?VmNxRjRwZk1Tb0IydzNOVk4ySlFCcEFzeThzR25oNjFhNWVBOElQV2hzRmVU?=
 =?utf-8?B?aVhDMnBRamtwTlFOTlh3Y0xvckpVMXZoWngxSzdxVkgyUDBEZXFWMHRPZnBX?=
 =?utf-8?B?bDlHYWI5a1dkSVdRZ1NIZzVrdmxSQUY4ZTRsTkVNK01ZbGhqNUZ2MmwySzFP?=
 =?utf-8?Q?HYhwB8FXVZA3AFh6wjTtZDKkd?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c6b092-6fe0-4aec-e677-08dc38f755cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 07:23:32.6986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KcjfKF0nx9M8qXrEFcpfCNJSH3HYsGiCULPPbKkF5iKZrE+y0cd+2B4faGPl5pEjHEL2Fj0xSZxgbSGN7479ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8776

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFuZHkgRHVubGFwIDxy
ZHVubGFwQGluZnJhZGVhZC5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCAyOSBGZWJydWFyeSAyMDI0
IDk6MTkNCj4gVG86IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IFJhbmR5IER1
bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPjsgUGF2ZWwgTWFjaGVrIDxwYXZlbEB1Y3cuY3o+
Ow0KPiBMZWUgSm9uZXMgPGxlZUBrZXJuZWwub3JnPjsgbGludXgtbGVkc0B2Z2VyLmtlcm5lbC5v
cmc7IFZhZGltIFBhc3Rlcm5haw0KPiA8dmFkaW1wQG52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFtQ
QVRDSF0gbGVkczogZml4IDMgZHJpdmVycycga2VybmVsLWRvYyB3YXJuaW5ncw0KPiANCj4gRml4
IGtlcm5lbC1kb2Mgd2FybmluZ3MgaW4gMyBsZWRzIGRyaXZlcnM6DQo+IA0KPiAgW1BBVENIIHYy
IDEvM10gbGVkczogbG0zNjAxeDogZml4IHN0cnVjdCBsbTM2MDFfbGVkIGtlcm5lbC1kb2Mgd2Fy
bmluZ3MNCj4gW1BBVENIIHYyIDIvM10gbGVkczogbGVkcy1tbHhjcGxkOiBmaXggc3RydWN0IG1s
eGNwbGRfbGVkX3ByaXYgbWVtYmVyIG5hbWUNCj4gW1BBVENIIHYyIDMvM10gbGVkczogbWx4cmVn
OiBkcm9wIGFuIGV4Y2VzcyBzdHJ1Y3QgbWx4cmVnX2xlZF9kYXRhIG1lbWJlcg0KPiANCj4gIGRy
aXZlcnMvbGVkcy9mbGFzaC9sZWRzLWxtMzYwMXguYyB8ICAgIDMgKy0tDQo+ICBkcml2ZXJzL2xl
ZHMvbGVkcy1tbHhjcGxkLmMgICAgICAgfCAgICAyICstDQo+ICBkcml2ZXJzL2xlZHMvbGVkcy1t
bHhyZWcuYyAgICAgICAgfCAgICAxIC0NCj4gIDMgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gQ2M6IFBhdmVsIE1hY2hlayA8cGF2ZWxAdWN3LmN6
Pg0KPiBDYzogTGVlIEpvbmVzIDxsZWVAa2VybmVsLm9yZz4NCj4gQ2M6IGxpbnV4LWxlZHNAdmdl
ci5rZXJuZWwub3JnDQo+IENjOiBWYWRpbSBQYXN0ZXJuYWsgPHZhZGltcEBudmlkaWEuY29tPg0K
DQpBY2tlZC1ieTogVmFkaW0gUGFzdGVybmFrIDx2YWRpbXBAbnZpZGlhLmNvbT4NCg==


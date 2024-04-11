Return-Path: <linux-kernel+bounces-140304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B830F8A127B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB2231C21827
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D33147C74;
	Thu, 11 Apr 2024 11:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dektech.com.au header.i=@dektech.com.au header.b="QHlu4TAR"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2093.outbound.protection.outlook.com [40.107.22.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B558E13D258;
	Thu, 11 Apr 2024 11:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712833464; cv=fail; b=O4jq3JAqk4fuIuqM61lgPAoAtdyHTo8+0DyhhZLV+ZwjA5IUt/h0D1h23L+DhN9di1Ox+BY+c0QM0uCkZ7f9zP6eJrAHuv9dok5De/rTsXCdooLhiXBQE+zQfs1LJYIyLyAQfvcsLBwk93Nbw9niR75+Yyv5p4u2PnzCMPZ/hL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712833464; c=relaxed/simple;
	bh=bcpcsdRA5iFaNBCck6NjqpB70CBiklb7/ZZdaAX3aCk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bi2WqFi3V7+8W1jSPOoqnyRglA+kbowhbjCwfPINwM5c90n8lTzJvw5TFu/f7eMr0WbYIjhIQtONu01SRu2ZTtH5Sk1a66Cg3CwcRmrWFHhISvM+gUbb9J9/9b97PQJRL9uJrM2FfZkF6gtYj3ykNA3m51FQzpuv51PsgHlaruc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dektech.com.au; spf=pass smtp.mailfrom=dektech.com.au; dkim=pass (2048-bit key) header.d=dektech.com.au header.i=@dektech.com.au header.b=QHlu4TAR; arc=fail smtp.client-ip=40.107.22.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dektech.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dektech.com.au
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElxnxpzqL5b2OvFSPc3dWGRlKj9dHkxyFl3KD+zzmI2Ce4f8Z+8ax/5JONaL1lMD2ei8/XhAf21luElDi97y+SMvhDo0RYHcWz27/CgOZwqGA46gYUnzy/tJn/0J4eyfrcU+x1D0s2Q9IfSVyzOdACsnqtUVXzodcKIzji+THkKdFnrzX4oq7Nrq8g/vzV+TyfBibYfmbmvvCDAJHY+Ufj8+UBwPU2rhNEMrQezC/c5rcruHaDd4zLp25/8UaE4w6Y0wEY+zW5oInk7zOXfYcE9xj2IFftedrvuGyy99S010rpvlaX9BAPwU6QHYBVm76RrWCYKS2s8zBKnX1pn61A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcpcsdRA5iFaNBCck6NjqpB70CBiklb7/ZZdaAX3aCk=;
 b=fxpHjM0s6Z70Sqd2sl1v+4mBcI5Sk9wKu6kF8VQAk3Jdnh+fuseCHbUdCfFqzQcNXrYuhR5xTPOnsZ2/kh9Et7AOMYeNedk7bLIBShpYwYdOBM5tau0/JP5rqijX3ifYV0esVVPNcB4yn1HUZ9kifIXtJk1GwkZPGJGGWY//FFqIoqK/saAGXdjL1xZQN2gB6fTONSM/cNyFe+HrxSRWByWSt4tPTGOS36VMQBXmpd9N9oL1nsiaW50ftMmEc5lDg4LFILp6fDdWDMAQVOGHWJ+ihv/zn2goPIaE4pMh9/YpJAzfVDdDJgmHGprxjqBJNbFw/sCmLzqrGriF/T3MkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dektech.com.au; dmarc=pass action=none
 header.from=dektech.com.au; dkim=pass header.d=dektech.com.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dektech.com.au;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcpcsdRA5iFaNBCck6NjqpB70CBiklb7/ZZdaAX3aCk=;
 b=QHlu4TARKTJgozjYoHfr8St1W61ghrm97JRxVGr6aJCLH/7TKmbkAmOWT+TYd12m7ozhIO6Eaw60EJnEBLkj4eHbTsoN0N2dIDGeFlr8h2qzg0eSaEiG38ZRCBkxedKd8Xllwd3PNp/56HXDyUKAv0HDXzTU1akBtOR22c7JB7YgDTL29EcnisuxLAtpDVqXdmUJM89OzF4kNuwxsZvnfJ2afwaIdhloWmRWNXv07Ws3K1HwBNQjmaQQ4KuptCYicv6DX0vi0pbX9mH61NulViFVaN5hCokxc0E62WHz+KDsaMdn159Jx1CulGS/UO8GfIxRucSdZabPpKlL6aH8uA==
Received: from AS4PR05MB9647.eurprd05.prod.outlook.com (2603:10a6:20b:4ce::15)
 by AS2PR05MB9909.eurprd05.prod.outlook.com (2603:10a6:20b:5e6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 11:04:16 +0000
Received: from AS4PR05MB9647.eurprd05.prod.outlook.com
 ([fe80::8e06:8f6c:4364:7266]) by AS4PR05MB9647.eurprd05.prod.outlook.com
 ([fe80::8e06:8f6c:4364:7266%6]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 11:04:16 +0000
From: Tung Quang Nguyen <tung.q.nguyen@dektech.com.au>
To: "Colin King (gmail)" <colin.i.king@gmail.com>, Dan Carpenter
	<dan.carpenter@linaro.org>
CC: Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][next] tipc: remove redundant assignment to ret, simplify
 code
Thread-Topic: [PATCH][next] tipc: remove redundant assignment to ret, simplify
 code
Thread-Index: AQHai/ET8yH2w4BKm0CIExMIZvn7kbFi08+AgAALIwCAAANvgIAAA9WQ
Date: Thu, 11 Apr 2024 11:04:15 +0000
Message-ID:
 <AS4PR05MB9647FC45E89AECEDC01068C388052@AS4PR05MB9647.eurprd05.prod.outlook.com>
References: <20240411091704.306752-1-colin.i.king@gmail.com>
 <AS4PR05MB96479D9B6F9EC765371AA8A588052@AS4PR05MB9647.eurprd05.prod.outlook.com>
 <ce0a63fc-1985-4e25-a08b-c0045ae095f4@moroto.mountain>
 <3011ca26-08d4-4b4e-847e-d68c0751f98d@gmail.com>
In-Reply-To: <3011ca26-08d4-4b4e-847e-d68c0751f98d@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dektech.com.au;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR05MB9647:EE_|AS2PR05MB9909:EE_
x-ms-office365-filtering-correlation-id: 969e1d1b-4ab9-4ad0-f264-08dc5a1720c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 +0f3NDOb2JsJkESE0qaVepW6thcjqRavBlpjCh+S4Q1DFTDu8EcfFDVrmJ0o5E5y9HROjjnfUvVJoJNToHbgBgVOOHPhJAWn1ahfGEa9awvmTX8daN3f55qtKK26L1bq9DT9djnFvYvl/XRpGY58A32/ouPYEhmf2enaSKGy3xBdJz7O6SY99EbX21gNjmoScNvPUNCuoY408SoagqOgUCNnSuQadngCS7bUY0Fs0g8klukizHTU8dJwVio0GJB40OFCb1ZN+jsAhmf0oI+VlMQAO9Mwp7URLnGGP3N9/P8RI7E9vF5w0Pkr1iTsGaQZks9x7weNH3Az2P6JUd5m6XtxEABdcAfcUX3D2vNG/kjWKq8glN2rUqG2wOyIZkgwW7D5J7tGhc+TzxOsEJv6a0RTAGSJIsJpIlMbU6+YEDoi2ZiVYfon232iDEHKN4GIhQ3875b0OlLzPav6I6UR9OzuN62jaH3uzFhpUe6XukA10pCtPTV+teL2PmGzB6VtXQIBpoNrQeJffUE7aBJTuhQfmJHjW4mFgAWgDhtus9Wgc2pE0KZlCxtBMlXckA6ZBu7eP88/8DWjW8eY+ZFH7Qa8QIMkRav9rE4aGzARhWqhuT/IWr4Tm5ylTURb9jccsTZvnqhUbX0QU4Y6tSNkJEzsoB3SUdR7kNlCXYu9aYxROvWoXwPoE+GfN6J9sX4F317GUR4lgFhE2LDYwj18Dtq/4/m3okHP0DMH5+4NlxI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR05MB9647.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M1ZPTTE5YWx5TktQUTNOR1N1U2dUaldUQ09YL2txSnltRWFVOXdBQnQwdFJS?=
 =?utf-8?B?VkJwZWJrVERhRWhvS1JGZm1HZjQ0UmR4UnJReVRFNHpNK043djNzcFpLa1lP?=
 =?utf-8?B?QUVvMWhGTURrNjM1MDN2a3FHT3FpVGVHRjNwdS9pZGtUa25yVjBzVXBMMXVF?=
 =?utf-8?B?bThObWlwSUxDa2pmdDVGSk1RNUNOZkg1RnYwT0JlY0VGdGJUa1RQT3FBNDcz?=
 =?utf-8?B?MncwRkQ5Y2ljc0VJWWQ5M3NvOEVKNUc0eVIzNWNwc1Y4Ukd2ZHV1RmpNZ2FB?=
 =?utf-8?B?V3hNakpIa0hwNzAwQTZuaG9EMnlReVZxd0cvT2QvLzN0TC9OWHE1ZmZrQzVh?=
 =?utf-8?B?NUE1OXViSVI1RXRNMkhBS1J0aUFDdEdXVytmbStPQ0M3K3psRXNsaVJ3Ri92?=
 =?utf-8?B?ZWw0eGRrQ0RCYTcva3d4dndWVnBydnJHZmFLa0Urd0w4Sm5HZlZqTlpIMmNa?=
 =?utf-8?B?UlRjaVpRaTk0RGh2b1V4ak9rWGYyY2w4dU43TGY5TSsyRnZKRUxBSVc3aUp5?=
 =?utf-8?B?V1VWTElQMUlTajd4Q01SZXNzSC90QzVHOXhpdDczYW9EUnQwd1dTNXpLZkVR?=
 =?utf-8?B?anNZN0FoU3pPQjZmZTloc0Rja2hsaGdoUnhkZkVGZDMzK1Irb0FpQ2VZRmhM?=
 =?utf-8?B?RHhnMkVxRnh3cFVUaUs4VkVKd0p5bXU0ckgxbTk5TkRTWkJLbVBtUHNCNVNq?=
 =?utf-8?B?QXJGWEZ6a2VqcWIxaVhKZWpOY0Z5TXNiR01mUVdkTmtmSWxWdk5acWNERHN0?=
 =?utf-8?B?UHVxVHh2QzVkL0pxTmNRNjBETDRmZ0ZRRDNLY2FraC9OZXpFeXhpWFVnbEpx?=
 =?utf-8?B?RGRnQWFOZHpoKzhSemFWUU9XNmx0UXlDeTNEb0o1K3J0TWRrV2hTcU04UGNF?=
 =?utf-8?B?ZHRwN1dEZW5DM2NOMjdEaEppdndkWGQyNGNWdEFRemFUWjFkU05aQTcrUGNx?=
 =?utf-8?B?ZFpuaVA3TVFHTkcvL3E1aDhMd2J5Vi83cjNhMGNIc1VSRHEwdUR1Y2I4R0gx?=
 =?utf-8?B?RDI3UnVucGdaUkZxbWRaUUdrZ3QyRFRDanlpQnN5K0ZrZC9LUUU3d2FzWUt5?=
 =?utf-8?B?a25EanNmRVdSTUpqM0tsR09Na2tXamZkN0NINjFMaWp1MFlyTUwzR1NxdjVy?=
 =?utf-8?B?MDlRM3ZuSUhNSzFwbEo1SFRHTTYwRUlWOEpvWk5XR2tpVWNVSER5aXdpZklY?=
 =?utf-8?B?YzRndExvSEtkekF6aTE2QVV1RFJ6d25NVzdSeDk5MW9aOU9JL1g1UlcwVVJa?=
 =?utf-8?B?azd3SEJyVWlWbVpwMHJzbFF3YkU2VXdwMksvRzgxOUVIRmwwSU1ReUVHTU9R?=
 =?utf-8?B?Y25ObUp3dXRxRGlzY0ZoL1B3cEZSdDkwQjJwQXluU2lOYXduQWNhOHdTZTdI?=
 =?utf-8?B?SHFzTktHY08zOHQ1dXVBazE1YUVSQ2ZCT1hoQ2JYUzJvZlgzTHJKNFNXQmdI?=
 =?utf-8?B?WWRMNGNKaUI2RFdUOHFQRHAwRGdvSzJMcjBadFRaZ2xtN3Y3aXJ4ODVFeUh0?=
 =?utf-8?B?TXRETEtBNGhEWmhvL1VBZHN5NlRKR0FVY1JFN1REbXFzNURRZWhPam9BVFdm?=
 =?utf-8?B?U0pSNUdxR2JYZS90UlBGUEVDd1Z3a3BVT0RDenQxRHY4Q3RyM0FIdFpvakV5?=
 =?utf-8?B?azBiR3FQUktEdU9GdmpnbXBzeXZib3hxT21BaE9GcFZIUFd0ZGViUjFWWWJI?=
 =?utf-8?B?TXYwZk1pZGxkRlkrd25HZ245c0NZNWlGU1EzRlZsMHF6elBsUVJXQXZzQ04w?=
 =?utf-8?B?a1JrQ0xMK3BYZWZ6OVhQZkt6TTVzNEg5YS92VkZLd3RoYjM5cVYvanVUblFm?=
 =?utf-8?B?ZVhBeE9GYUdESkZUSUY4YUhBRWkzb1czdkFPbXZtVFVKdHA4TlN0Z1M5c0FH?=
 =?utf-8?B?d3FRUzRNQzlXOVdJZUJYbXFQSU1XMDliREdnaUJRR0kwc0QzTVQxTDRFK3VM?=
 =?utf-8?B?MlJJRHpnMEdrKzE0NTkrYmsyazkrNlkwRHRHYTBxc3lTTDRoVkppcG83V0pn?=
 =?utf-8?B?NndBZlRCYkFQbC9HNGZLVjJuZ3BCYndYM3pycnZiNTQrYlNNS2VKSGFxalNx?=
 =?utf-8?B?RkdwREtMV2h1REZaUE9uWjNWQkdSNklrdEV1cjYxU2p0aks2WkY3WUZ2ZWlO?=
 =?utf-8?B?MFBqZWltWDB2V0ZUVituV0I3byttZElvK3oxcG9XTGZUVWxCeXY5bi9BVjRy?=
 =?utf-8?B?UEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: dektech.com.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR05MB9647.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 969e1d1b-4ab9-4ad0-f264-08dc5a1720c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2024 11:04:16.0033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1957ea50-0dd8-4360-8db0-c9530df996b2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2QOQZ2GtarLUGqh1g8tbk1sVqLllmy0iySc3iLIyJ22r0CdufbraVZAZgONs9Ip+PQD1cDf5jvFAB8+UZhaG3aHmS2TYlMegk/jaTVsiSAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR05MB9909

PlN1YmplY3Q6IFJlOiBbUEFUQ0hdW25leHRdIHRpcGM6IHJlbW92ZSByZWR1bmRhbnQgYXNzaWdu
bWVudCB0byByZXQsIHNpbXBsaWZ5IGNvZGUNCj4NCj5PbiAxMS8wNC8yMDI0IDExOjMxLCBEYW4g
Q2FycGVudGVyIHdyb3RlOg0KPj4gT24gVGh1LCBBcHIgMTEsIDIwMjQgYXQgMTA6MDQ6MTBBTSAr
MDAwMCwgVHVuZyBRdWFuZyBOZ3V5ZW4gd3JvdGU6DQo+Pj4+DQo+Pj4gSSBzdWdnZXN0IHRoYXQg
ZXJyIHZhcmlhYmxlIHNob3VsZCBiZSBjb21wbGV0ZWx5IHJlbW92ZWQuIENvdWxkIHlvdQ0KPj4+
IHBsZWFzZSBhbHNvIGRvIHRoZSBzYW1lIHRoaW5nIGZvciB0aGlzIGNvZGUgPw0KPj4+ICINCj4+
PiAuLi4NCj4+PiBlcnIgPSBza2JfaGFuZGxlcihza2IsIGNiLCB0c2spOw0KPj4+IGlmIChlcnIp
IHsNCj4+DQo+PiBJZiB3ZSB3cml0ZSB0aGUgY29kZSBhczoNCj4+DQo+PiAJaWYgKHNvbWVfZnVu
Y3Rpb24ocGFyYW1ldGVycykpIHsNCj4+DQo+PiB0aGVuIGF0IGZpcnN0IHRoYXQgbG9va3MgbGlr
ZSBhIGJvb2xlYW4uICBQZW9wbGUgcHJvYmFibHkgdGhpbmsgdGhlDQo+PiBmdW5jdGlvbiByZXR1
cm5zIHRydWUvZmFsc2UuICBCdXQgaWYgd2UgbGVhdmUgaXQgYXMtaXM6DQo+Pg0KPj4gCWVyciA9
IHNvbWVfZnVuY3Rpb24ocGFyYW1ldGVycyk7DQo+PiAJaWYgKGVycikgew0KPj4NCj4+IFRoZW4g
dGhhdCBsb29rcyBsaWtlIGVycm9yIGhhbmRsaW5nLg0KPj4NCj4+IFNvIGl0J3MgYmV0dGVyIGFu
ZCBtb3JlIHJlYWRhYmxlIHRvIGxlYXZlIGl0IGFzLWlzLg0KPj4NCj4+IHJlZ2FyZHMsDQo+PiBk
YW4gY2FycGVudGVyDQo+DQo+SSBjb25jdXIgd2l0aCBEYW4ncyBjb21tZW50cy4NCj4NCj5Db2xp
bg0KSSBoYXZlIGEgZGlmZmVyZW50IHZpZXcuDQpJdCBkb2VzIG5vdCBtYWtlIHNlbnNlIHRvIG1l
IHRvIHVzZSBzdGFjayB2YXJpYWJsZSAnZXJyJyBqdXN0IGZvciBjaGVja2luZyByZXR1cm4gY29k
ZSBvZiB0aGUgZnVuY3Rpb25zIChfX3RpcGNfbmxfYWRkX3NrLyBfX3RpcGNfYWRkX3NvY2tfZGlh
ZykgdGhhdCB3ZSBrbm93IGFsd2F5cyByZXR1cm4gdHJ1ZSBvbiBlcnJvci4NCg0K


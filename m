Return-Path: <linux-kernel+bounces-106959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D7D87F602
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 04:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E24D281FA8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC587BAF7;
	Tue, 19 Mar 2024 03:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="nYFLU/Y2"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2125.outbound.protection.outlook.com [40.107.215.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80757535CA
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 03:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710818503; cv=fail; b=Taxy3iMAq0hXSq/uJS9wSmpUS+UAc4u+pBTiZgjXNAN/8ZythfS8ZUD7LAcE8QjcCtm4c+u8vGHZZxbdowM5tkGvL7ba/iA7EqNVnL2TpOr2XmkJi7zC5/lHPAHOZ8jJRRoyGv6x1BW5vnO5aIFdduOx8Irj7Y6Rb/fPbwP8NU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710818503; c=relaxed/simple;
	bh=v1Ci5cG/5v/4UtbPmE28HRSbRHzBU+DBQ2qxXa/aoK8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XQLDZ34P18EofW1CiVHJc6d/c74OfzcPdK8E9U8a/xTdi0cKGO8CiSUfAeAQhO3t8kwgdI9utpAb0MU2jw4cLPZNRs1/nYfwKhskbPLn0JSyhj/AZrU+URcY9D/hlEuWGYNMlwmde14nKZj1MLj4eWnLdtNULNlO6VjFWJPfXOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=nYFLU/Y2; arc=fail smtp.client-ip=40.107.215.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSm7WqZPrp14LAHzzOa/l+KOWpRFfpwBz9CpHYchGnfxY7NfSVkea4GGOLgp2+YBd0HkYod0Pp822GjqxPjF2THQrCNTVHDwPcB3RgavV3Vi0CEnUT2kZ8lFgI04ezVv/kcHfXrMPbECLltSUFB1bhbMi8fCa2StSQxcd9vWp01AFBdDC3ZuudSQdIepOnxYpRMg00+CkWPz6quaVyjSBS63j0kWh1pshqftUGo1mh68Zf3F+3voUCutBvlx5FliVZ1q5xmoxvUXGb3dnYQfNAA/9T/BK+w+fFoEMrWtNJrzsuYudx077h5PTY2dV/B27u3KyaPpwGhyUCqInTVZJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1Ci5cG/5v/4UtbPmE28HRSbRHzBU+DBQ2qxXa/aoK8=;
 b=I7/W1bERbsxq2h+o33F6mtgVjUYHGgEjMqG3cA8fYxUcVPt8kd7tIz9r5oLYfDR2LvXTSqHDjKlfRDH6veNA6mCmrL6t6Jc2fCzJFzjCZa5VTzQlTU5+zmq7B+XQzvAlLWSO+bQ2JF2xgeO+9APtysHJVbWAEhUjhwAoj1GLZdNZwlk3UXZzFxNq92QZI7al4PwrQxJg17bzrotauNo82eIJZDxOItqehqxfy3OrzUS6S7n3QojORHoZHEQ1zxKD+lEb0jquXmy8tcL1m2U04d/EWpNrzxs2du3w0TnGNdFOFCTMBVw9sEITyyrIqNq3/K2kkKDw8dmGjuay2Bo8sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1Ci5cG/5v/4UtbPmE28HRSbRHzBU+DBQ2qxXa/aoK8=;
 b=nYFLU/Y2IbQrMN/Tee54+FwzUSTwWla9TRdTSwdm1yCRtvDW9mxsf+bybmKk5j1WPOW79sVfBdiZyeEi5Hip61WseEVSnC+ugkjadqaMANqRvlHXx7ppl5C3yF7v9RCctf/SxiQVTOxn29LlnSIYIfqP9TcIQnpnvR9t6DPbEZY5tK4/IBppm1KEQLuKYd2+k9d2fvnpKdLXFSe//WKm+Zf0jPbZz/r1kPuPV4s9RNA2zkDy00ifjKao135pzuQrFnD3G5KxJ2+5kxQoo+N9pdgkpjecwsSinxtJpa3G/4YnSJ2pRB9oS0W/81GmVZPNmTVnAyApdLLStweB7uLDSQ==
Received: from TY0PR06MB5754.apcprd06.prod.outlook.com (2603:1096:400:270::9)
 by SEZPR06MB6230.apcprd06.prod.outlook.com (2603:1096:101:f1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Tue, 19 Mar
 2024 03:21:33 +0000
Received: from TY0PR06MB5754.apcprd06.prod.outlook.com
 ([fe80::6fdb:bc24:3387:af5]) by TY0PR06MB5754.apcprd06.prod.outlook.com
 ([fe80::6fdb:bc24:3387:af5%5]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 03:21:33 +0000
From: Rex Nie <rex.nie@jaguarmicro.com>
To: James Morse <james.morse@arm.com>
CC: "fenghua.yu@intel.com" <fenghua.yu@intel.com>, "reinette.chatre@intel.com"
	<reinette.chatre@intel.com>, "rohit.mathew@arm.com" <rohit.mathew@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Angus Chen
	<angus.chen@jaguarmicro.com>
Subject:
 =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQQVRDSF0gZnMvcmVzY3RybDogVW5pZm9ybSBk?=
 =?utf-8?B?YXRhIHR5cGUgb2YgY29tcG9uZW50X2lkL2RvbWlkL2lkL2NhY2hlX2lk?=
Thread-Topic:
 =?utf-8?B?562U5aSNOiBbUEFUQ0hdIGZzL3Jlc2N0cmw6IFVuaWZvcm0gZGF0YSB0eXBl?=
 =?utf-8?B?IG9mIGNvbXBvbmVudF9pZC9kb21pZC9pZC9jYWNoZV9pZA==?=
Thread-Index: AQHac4y6H5635aXxlkm66nOBJ0wPFrEy01UAgACKSeCACm/TAIAAoBPg
Date: Tue, 19 Mar 2024 03:21:33 +0000
Message-ID:
 <TY0PR06MB5754514C42217BE6055455A3E62C2@TY0PR06MB5754.apcprd06.prod.outlook.com>
References: <20240311081839.937-1-rex.nie@jaguarmicro.com>
 <e731b262-c201-4294-9b1e-abfa0c6ac817@arm.com>
 <KL1PR0601MB577382D132A25E055856C543E62B2@KL1PR0601MB5773.apcprd06.prod.outlook.com>
 <d0277225-199a-4175-a43b-a09c1445138a@arm.com>
In-Reply-To: <d0277225-199a-4175-a43b-a09c1445138a@arm.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR06MB5754:EE_|SEZPR06MB6230:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 uArLgJ1qgnB+2hymQ4LGJ0tu3oInTnaIn6+ELsBXTwEMi+cKs2TgfZiwWlE3xyccCy6fo/XUTap277hzxpmuao5ztH5uSV5wX5S7MMMkM6mX570F5HmlgoQeMtfg/4kATrfvsDWdaPG0twWx/TeAvzsqqc0F26IXfwzN2ZSjhel1JGdjBaR95c7fc/XvKNUuOvh/HiTkpVPkRj3GrqTvxc5CnUGC+tmSQ7pJatHBULHnYZp1tnQxw9R/OOwsrWDG9lmEdpPXfHf8HE02fh1D20fptT3XruyxypbY5/BHJOKyaqnDqSqkKiG1eevtkDRuhounH8SFLzNsnsHoznzRebXxiiw9YRVVacYy84YQkevbt87YnaHknmZZTa78uZ3NXqhnVju/Xisw7KI9q8eRDfR9ka/gGnyRZQQ5d5fcM/r0WGplaszfKlEETxcBdA7V9wFFP5T0747/Z2S/lBjxa9Fohh73XHjwm76ifZvjt+TfJhxQZLvA+t5d1fz3V4rbNtRZdoxWyne5qrTO86MyZ01y5a2n/KYkh77CEWDRDwTvnVyEfoy2IhJgpPsc8X8/JN5mppq3yxfGMDOXNWjwJBKm8i2IGFOiHp9OlD/CDu0+bBOOi1PWl0k9c91dirCWOeHKzkmgaQbMEeJeTVv01w==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR06MB5754.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OFdOdndrYktmS0trazJkRm1XdXMwVlR2bUJDaVlCcGNXQ2hiOUVoOHVXb0tO?=
 =?utf-8?B?aUtrTnV6V1VIUmlXT0JreXRTeG9CbmFCZDNuWmlubUM1Y0NMMFVEdkRsWlhr?=
 =?utf-8?B?UzJsSEN1cG1qYzlnUGpETlUzdi9CWFQ0QTVjQjl1VFN2RkFhaWVHL2lwNWhH?=
 =?utf-8?B?a2V3Uk9vdlJhMEtHZzVET2JnQmlBZ1dpWmZqSG9XYzR0cUpmSnRaK3lFTG5M?=
 =?utf-8?B?ZVJqMzZXSld5R0l1bHovc2lGbzN5WVBjaXVOUEQvRW9tMjVHRVRFTHR0ZnNP?=
 =?utf-8?B?bTA1VFhPb0lRc0FKY09aNFA4MXFSZzV1VGRvMWxnVXdMa1FLVFg3NWhFN05X?=
 =?utf-8?B?dDVPRWs1dFY4cmJ6R0d6akVJaHdxVzQvMk1aZUVadU4ybUQyTzBGSkt6T3ZX?=
 =?utf-8?B?djV0djNidmx4V2M0bWhJRWpjS3NqNnFoNzBPTDdGTkQyc1J3UnU5UVRWMW1p?=
 =?utf-8?B?b1V6eDMyM3pybVlTK3dDbzBSWDRsaXB0L0hKY0U5RmtWZVZydEc1MXVVUnVL?=
 =?utf-8?B?OVlxMXlaWUpVS0M2RkQ3UEFveWVHeFM0blRiVTcyQUN5SUtGYm5uZklhT243?=
 =?utf-8?B?bzFsb0k4MjJ1WUtYRXVMc2ZTRkNEZ2FtbUQrM0wzV2wzSElMNkhUd2orKzdQ?=
 =?utf-8?B?K1Q0Y2Z2SFZUcTZtRlBRdzc0Nm9wM29lR1VoQmhscXNRUkQrdGJMajFYQkdn?=
 =?utf-8?B?M1RVWm1zTjhKM09LRUhyQjlsUjZxKzJ6M3d2WG5GdFpFTCtxUXZjcHlwMFZW?=
 =?utf-8?B?UGtUbzNHNzgvUGx0a2I2dnkzeFE1cjBVZWh0cWdFeFVaQjIvOHFGazlLS21i?=
 =?utf-8?B?MmpvcnR5VGdHd0FKZGt0K2gxL0k2L0tPdmloUnp2bmYvRno1Y25IUXNvQjJo?=
 =?utf-8?B?OTlhWitETzZDVUZhOUhsOStFRXl5ZHdmZFRnYlJLY3VOUG9zaC90bFh1RjNu?=
 =?utf-8?B?R05wSVRNMm9FWlVHV1hiSFVSWFhYNk84UG83MVNYL2hjb1FBRTNZbnFwTHh0?=
 =?utf-8?B?Wm50alBGb0g0QS9FVHdZQmN5TDZxWlJ2NExwd3owaUFoeFhjV3VPc29ZOEht?=
 =?utf-8?B?dGduL0VYVklPUHBoa2dVaCtDblJjZ2RsYkxoQlhZT3NxZVhFMTczN0E2cmsy?=
 =?utf-8?B?UFNBbzJCMzNscktENnREbnVKdkNnNHNreHVHQXZ0UVpVcUE3WnhCaUFnbDhk?=
 =?utf-8?B?WHhYQUhSd2ZHY1d6Nksvcnk3bXBFWCtJd2x6cC93T1J1WjF0N2U1Q25HZy92?=
 =?utf-8?B?b1NIc1lTM0lyZXl2K1hkOFJjYlFFcXF5N3Zwd0VPRGNGZFNrQnVLSjE5UW1D?=
 =?utf-8?B?dlpYWDZUaVFNYUhOZ2dHbjBFSDNyVlhYalRTbDludE4xODh2VElNWlVEZUo3?=
 =?utf-8?B?azBWWVRPMHpFc3hRUmhZZ2VsZ1JIQ1JsaFBUSWhYVkdyU1RrNGpqR0YySTRD?=
 =?utf-8?B?S1BuMk1UOFViYi9FSWVDY3ZiTFRzTUYxdCs3aS8vRFcyY1gyVTRvdjQzZHIx?=
 =?utf-8?B?bmUzeVBuSW1tMFRsa0lCRFg3L3Z1MjRMbkFobExjaEhBNUdBRjlXQjNPbWY4?=
 =?utf-8?B?VUVaL3B1dlRuV3ZFV0tRd20rUVo5RXpURitkc2RuVllrcEpMemRnRzN6dXow?=
 =?utf-8?B?R25sSkhpVk1ad251eUc5Wk9TVHdMNy95UTRSWTIrS3VrOHhzUm5ZR0VlVFdG?=
 =?utf-8?B?OGhQeFh6d0ZXbnoyYnFhc1Jwb1ZaeDlsUHZJa3VGNmFLVUNIRmFCODZZeDht?=
 =?utf-8?B?a1B0cVJVYnFmVTYzVFdMUGxSY0x6c0F4bWxXTTZGaUVpRmtjSXRhTVRmT01q?=
 =?utf-8?B?MHFsd0VCQmphaXhLWHhWMVVMTi9wK2hpaEYvMEVBMFkrSlBLb3lQK2RCV0Z5?=
 =?utf-8?B?disrTG03ODh1eS9DSUFCUHE1R1oybzJVczRrR0pKK0hySTZrV0dYRWNnT2N4?=
 =?utf-8?B?akJDVlpKYWh2UTJ6Q2J2L0x1Um5YU0x1MWNnS2xpTjRrTzVtNTJxZUdCblAw?=
 =?utf-8?B?Tnl1N1VZdlNmNFJiNzVpaU9sUm15L1ArMi91Q054c3FSeDVQMWZPMjhvOHZP?=
 =?utf-8?B?V2xUMXV0Wk9TaHl0d0J2alkzSzZvZTkyOFE1YU5JRHN2Q25OL1FHMmRKenJX?=
 =?utf-8?Q?1Nkw4TLjhYO4yrTgJ13OiCjN9?=
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
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5754.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb1cc4e-890c-4dfd-1aa7-08dc47c3adb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 03:21:33.8004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4yXtVEZeI0N/rQbqddC9GNC6TS/uPdETWlLw+vIOF51B7EAjeWqA6aSd6lE1bCB8ci+OhA7Xcs6qderTCctliQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6230

DQo+IC0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCj4g5Y+R5Lu25Lq6OiBKYW1lcyBNb3JzZSA8amFt
ZXMubW9yc2VAYXJtLmNvbT4NCj4g5Y+R6YCB5pe26Ze0OiAyMDI05bm0M+aciDE55pelIDE6MzMN
Cj4g5pS25Lu25Lq6OiBSZXggTmllIDxyZXgubmllQGphZ3Vhcm1pY3JvLmNvbT4NCj4g5oqE6YCB
OiBmZW5naHVhLnl1QGludGVsLmNvbTsgcmVpbmV0dGUuY2hhdHJlQGludGVsLmNvbTsNCj4gcm9o
aXQubWF0aGV3QGFybS5jb207IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4g5Li76aKY
OiBSZTog562U5aSNOiBbUEFUQ0hdIGZzL3Jlc2N0cmw6IFVuaWZvcm0gZGF0YSB0eXBlIG9mDQo+
IGNvbXBvbmVudF9pZC9kb21pZC9pZC9jYWNoZV9pZA0KPiANCj4gSGkgUmV4LA0KPiANCj4gT24g
MTIvMDMvMjAyNCAwMjo1MiwgUmV4IE5pZSB3cm90ZToNCj4gPiAJVGhhbmtzIGZvciB5b3VyIHJl
cGx5LiBQbGVhc2UgY2hlY2sgbXkgaW5saW5lIHJlcGx5Lg0KPiA+IEJUVywgY2FuIEkga25vdyB0
aGUgcHJvZ3Jlc3Mvcm9hZG1hcCBvZiBtcGFtIGRyaXZlciB1cHN0cmVhbT8NCj4gDQo+IFRoZSBz
ZXJpZXMgdG8gY2hhbmdlIHRoZSBtb25pdG9yIGNvZGUgaW4gYSB3YXkgdGhhdCBhbGxvd3MgTVBB
TSB0byB3b3JrLA0KPiBhbmQgc3BsaXQgdGhlIGxvY2tzIGhhcyBiZWVuIG1lcmdlZCBmb3IgcmMx
LiBJIHBsYW4gdG8gcG9zdCB0aGUgbmV4dCBzZXJpZXMNCj4gc2hvcnRseS4gT25jZSB0aGF0IGlz
IHJldmlld2VkIGFuZCBtZXJnZWQgdGhlIHJlZmFjdG9yaW5nIG9mIHJlc2N0cmwgd2lsbCBiZQ0K
PiBmaW5pc2hlZCBhbmQgSSBjYW4gc3RhcnQgcG9zdGluZyB0aGUgTVBBTSBkcml2ZXIuIChpdCBo
YXMgYSBmZXcgc21hbGwNCj4gZGVwZW5kZW5jaWVzIG9uIGNhY2hlaW5mbyBhbmQgUFBUVCBwYXJz
aW5nIGNvZGUpLg0KPiBJIGFudGljaXBhdGUgdGhlIE1QQU0gZHJpdmVyIHdpbGwgYmUgbWVyZ2Vk
IGZhaXJseSBxdWlja2x5IGFzIGl0IHdvbid0IHJlZ3Jlc3MNCj4gZXhpc3Rpbmcgc3lzdGVtcy4N
Cj4gDQo+IEFueSBoZWxwIHJldmlld2luZyB0aGUgeDg2IGNoYW5nZXMgd291bGQgYmUgYXBwcmVj
aWF0ZWQgLSB0aGVzZSBhcmUgdGhlDQo+IGNoYW5nZXMgdGhhdCBjYW4gYWZmZWN0IGV4aXN0aW5n
IHN5c3RlbXMuIChTaGFsbCBJIENDIHlvdSBvbiB0aGUgc2VyaWVzPykNCj4gDQpISSBKYW1lcywN
CglUaGFua3MgZm9yIHNob3dpbmcgbWUgdGhlIHJvYWRtYXAgb2YgbXBhbSB1cHN0cmVhbSBhbmQg
Q0MgbWUgb24gdGhlIHBhdGNoc2V0IHNlcmllcy4gTXBhbSBpcyBhbiBleHRyZW1lbHkgaW1wb3J0
YW50IGZlYXR1cmUgZm9yIG91ciBwcm9kdWN0Lg0KSSBhbHNvIExvb3AgYW5ndXMgd2hvIGlzIGZh
bWlsaWFyIHdpdGggeDg2IGFuZCBhcm0uDQoNCkJScw0KUmV4DQo+IA0KPiBUaGFua3MsDQo+IA0K
PiBKYW1lcw0K


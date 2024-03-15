Return-Path: <linux-kernel+bounces-103965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE5487C713
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 02:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B96201C21FA5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 01:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6266FA9;
	Fri, 15 Mar 2024 01:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="FlOyv3rP"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2104.outbound.protection.outlook.com [40.107.215.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589384C6E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 01:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710465710; cv=fail; b=HEKUbc153i8Tx5dMcKaoDs0QfxZ8z6K+IfqrVY1W7qaateCi9XG+EjV6O3yaUC1r6KDyCJOwX/ynuJRtzFR7ocDJaG+9se2qrGn0P8IXzBAAsV+PMj5Kfy9xGPxKvFFKnrTwZ6TptBvhToBEktwhPgM4FHBasdwK3F5oEqbv+uA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710465710; c=relaxed/simple;
	bh=ccsZAu5f2SKEVJ94hIUtaIvZx896cDIAeCo2ELD3iNY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MWzBXsPdAboHCwOHCPSbQRBxRLn8w2cIqSOdnsvH0xrYDILT7E8X5xMXWq1kyDvc+hIS5WGgEd1pR96SLIkrn4EzaIRcPX/m5T0h4Y5ouJvIQoUYrGt5ycbxkQxqm6x3DvTG9PTfBJOReFnRpZrnuC4eWJBMxHSbcSsAAZq3BVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=FlOyv3rP; arc=fail smtp.client-ip=40.107.215.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbhugW1TeGYXV3LfbHdi0oP7AxzsH6O5sfZK2H3Punbz08iQsKD0Q+NIm8y9MnX0Qec4+1PSY1fEZqgQYPqUqg9oxjNM4H3HYXdcgIYwikmmiE+ytrx4bZc0r/X7YEr8J6I/og5lxsU0Aiytk6RqcrZjYvJGtCaRfu4D+xFbf+Uudk4sH55tcY+QD2IKskdKSHJ5tDfGx6k3sQ/GINMighHADykhi8C4z7k9QBB+InSxpd1Xx/fALpWCmCvzHwBaKRiTV2mluGQZo5FxOAok5Gw9HotbxjGs6Hh+veql1YHsrt//vjaA7WOqQ2ukGJTPV6/eJUxNkrZaEfhuZ+0EvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccsZAu5f2SKEVJ94hIUtaIvZx896cDIAeCo2ELD3iNY=;
 b=Grs+aJpgYGjGShMSFP7L55W3lVP4Si68UgtQhA1JS+YP+bPDgn+EavtgwFpVRT67bHJqMMV4pAJ6Aibq+mjQS8a0V8cA/iK1rE/mvW25tDvAlrWOfOoqfWfRGANmwXViJ6vPpdgY0LZ3klLBIYMl+ESmzzbcYp1bE7SsMOgEEsa9JBL+pp3FAKa4oSUVGKpUiPexOCzDWK/nAfV3RZXosDgHBWQB4+SEz5bsiXYiTlvpVoxLwFxxaPAa/xgj6llHTqPo/SViTWtloImbJWd7O5GbXmW9cmtDqJGdQKrqHPfdcaMOpRZjvmXpNB+xmSnXS4Jp6ynJPaMNHSNm+fdglg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccsZAu5f2SKEVJ94hIUtaIvZx896cDIAeCo2ELD3iNY=;
 b=FlOyv3rPqEtfnqEgJh+wicuhQQPFOg4ed5DLm2amUVg+VI1wvSA/dqkEfdPFa1xfeCjbmTmjTwAUZgzbPmZ8ZHbhXQ8dzz9iIdl4nHatKUZiqu0JeKDiHl1ECmYYc6M/Bmj40KDD2QXVBRn5qeM10Q/CJu5ywgFnNib8SPCFnJ1WdT0LbIZ2b/tUJvhs2Zgah2B+VAYq5U4JAohbJ/98YfpFjQ7P9m5TpFHrNoLgKOwDaGN9gjYol932jCXBjCmf+eXRR51wnaOsZHpBghdk/qKsTivt5AWAI8gSPoXvXAXHlbAYsAkumvqpqmsvZoExlFzSx7sX9JScViTkA4eTVA==
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 (2603:1096:820:b1::13) by TY0PR06MB5236.apcprd06.prod.outlook.com
 (2603:1096:400:205::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Fri, 15 Mar
 2024 01:21:40 +0000
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::1ecf:ff1c:bbe9:49e3]) by KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::1ecf:ff1c:bbe9:49e3%5]) with mapi id 15.20.7386.020; Fri, 15 Mar 2024
 01:21:40 +0000
From: Rex Nie <rex.nie@jaguarmicro.com>
To: Reinette Chatre <reinette.chatre@intel.com>, Peter Newman
	<peternewman@google.com>
CC: "james.morse@arm.com" <james.morse@arm.com>, "x86@kernel.org"
	<x86@kernel.org>, "Luck, Tony" <tony.luck@intel.com>, Babu Moger
	<babu.moger@amd.com>, Borislav Petkov <bp@alien8.de>, "fenghua.yu@intel.com"
	<fenghua.yu@intel.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?utf-8?B?562U5aSNOiAzMmJpdCByZXNjdHJsPyAod2FzIFJlOiBbUEFUQ0ggdjJdIGZz?=
 =?utf-8?Q?/resctrl:_fix_domid_loss_precision_issue)?=
Thread-Topic: 32bit resctrl? (was Re: [PATCH v2] fs/resctrl: fix domid loss
 precision issue)
Thread-Index: AQHadiPZ1gWMs35/vku96kkUckCWyLE37H0AgAANKwCAAAfdoA==
Date: Fri, 15 Mar 2024 01:21:40 +0000
Message-ID:
 <KL1PR0601MB57736F2B4B71364EDA57E622E6282@KL1PR0601MB5773.apcprd06.prod.outlook.com>
References: <20240312075349.977-1-rex.nie@jaguarmicro.com>
 <fed6affb-c7f4-4992-8646-8f5a52c33966@intel.com>
 <CALPaoChnAt9+2=iVzpownX-bN+mb3Ujn_C=_QS2qsAph=LPSiA@mail.gmail.com>
 <3ce123c2-3e04-4ff0-99f3-bd402a47ecb8@intel.com>
In-Reply-To: <3ce123c2-3e04-4ff0-99f3-bd402a47ecb8@intel.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB5773:EE_|TY0PR06MB5236:EE_
x-ms-office365-filtering-correlation-id: 3e6f7e01-cdf8-4984-2496-08dc448e4451
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ElJNW2DAiTcgztsxTp55bc1W1SUqWc5XtKCTNVqwykqDF/UtKyWbXC+biFt1XXj5iU+ikIZWpe9NyLP+yja7/vHlCL3REpz+BzziTULZ2n4qLQXKo6cmXAulk8V05MYQYahAixBPLFBgxwHkI7usH0FoWBR84QtMPNgT8BA31FRF/3yoamHf6SmKFYrU5iG9n/Rz/wLTgY68Q8lp4pF2W9QCpMNRYnpZiBhI+ZeZpwKc8R6ICpgD5E6kCWn7ZIEm9zq47/KBdKycYp25M9NlfPkBvegePaF1PcSmkDgDIncnrq8fuo4jabwtDq6SRqgyvjertuVSpRpPRhPR6FJuIiSWtY81pKUO7rcccmvSFX6icacn8m8DbNvTG2nRMwRhZU7BZ743BSjFGQAiKdwnrTjWPeet8EQC/fpcKIJ6csyKSTpA1SQ12L+VvruKUYN+sNDiEkgTgxyD6ALvJ/H12ijQVhw8X23GxI8qOL72EW4p//IKr+1YHNWkcs0pswDc8TLy5bC4qzlwozApd/bW8C5qmFQTtKyfED2gPf0qPmes4B8dm/gO0VsUPKpwZNFNDFZS73v4Nd9Qb2TGLs40yVoCLb7SCM9tb29cQD9JBVpmpCZaU3NHtW6atAQOIbDoA/w15f80ihrIJ+T4v8OvdusefKmkJBa/ZT9GYlOdp0o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB5773.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YUdJc1ZjcTkrTW4zSC9GbHRxS1l4VnJFbkExNnZHUTBiNmwzR2dTYnU4Z3hN?=
 =?utf-8?B?cEV6RndGWFgyQTd2bE5vQjROU055QXk5aHBsa3FBSVdnOXBNYUxvVVB5WEdy?=
 =?utf-8?B?eDlCa3U2M3VtekhaT3ZrQWFzZmUwWmszcW5xT0JQL2pFNHZkZjhXZlh3dU1a?=
 =?utf-8?B?djViZlUyK25sU3ovMVpsQkl4SzJ0M25IVVdvRitoMGRYcXM0b0hiLy9zK2E2?=
 =?utf-8?B?R092bS8waThEcTE3YlBuTU9EMnQvTENMajNXbTF4bFNGMWIxRldtd3RaZW5M?=
 =?utf-8?B?YkhrWkpPV0dDMUg4bS91aE5iY0JFaVJlc0RFK2x4N2dNa0RYWmRYK2NIM2pH?=
 =?utf-8?B?YkJXOUpBd2dHdVlqNnEzaWlvaWpacjdIaHRIU1BlWGM3V01GOFppVUo2ZHdN?=
 =?utf-8?B?NDRnMkYvT3VxdmlEOWNodFhrNVpGeGU5c2I3QTV4eUxSTU5DcndvVVJ0eCtR?=
 =?utf-8?B?cm1aMDlUamRUS3hjM080ano5QVV0NWRHS2JMVnUwODMrTmtwWGZoYmh2OFV1?=
 =?utf-8?B?SXN3aU1mVXI2em83bS9adE9YTE54UEJYNjFodXdnMTRPb1JMZm9kMG1jV1Vl?=
 =?utf-8?B?eTZ5UUxDL0hpejUxaTExRStvREg1Ynd0TmFKMjBiUDNuNmRBSVRUekxRdmZK?=
 =?utf-8?B?YW1XZlEyQkpvazZXS0pFQ21TVVhnald5V0RhVWd5RWdNY0tRVDJBZXk0bWFv?=
 =?utf-8?B?Q0wyeklZQWVaMUxkMTd5cGlzNHBlUGN1MGtxNExiaFBma01lMDdlRXNDZUZP?=
 =?utf-8?B?SFc2bm1VQVo2WWpEaXNZdStOdFJtcVBlNlhtVkU3Y3FVU1pVN0hVQXYzRDVL?=
 =?utf-8?B?YWwvYmJSN1UvVWlmOVMyOS90elVRdDhSUkJwWnlCZGlQaWJOWmJab2Ryclk4?=
 =?utf-8?B?aEQyMTBVcEwvaUxVV0JTa3NKeCtEWHZrdnhUQjloNndMb2IzV3pwR0x1ak56?=
 =?utf-8?B?ZS9XM1Q5ckp4RzVuZVEwNFpnMXpFeHBNY3UxZEdLbzlIRjgxWHhjUU45d1ds?=
 =?utf-8?B?dm54R1BBaCtUcHBXcU92bmZ6WUZGbkhmdlVSNGl1amtjTzlSenduMWFkSXBl?=
 =?utf-8?B?bnhzQmFWNFJIa2lidmtmbXV3MS8wOVF5dmwxZ3dtNWxtQ1pXM3RjQnY4K3M1?=
 =?utf-8?B?WmRCVWp1Tm15VkxFMDVlQ2lWZmtTenZBbHhPM2hSOGgzaXJkR2NsK2RrQi9s?=
 =?utf-8?B?UWd5dk9Vakd3Qkw0NHQxUzU0SFQ0enh5SysrdTlHYjNxdzdDZlRxSkd3ZXlj?=
 =?utf-8?B?d3YzVVUxRWxyOXgvaUZCOG9ESnZNUklOK1l5eEJiSC8vUktiZFQvZXJNdThp?=
 =?utf-8?B?eUt2cWk2MUw5NXJsQkRQSnFoaEpmNFlKZzEya0pndm45THVFTGRnV0Y4ZUg2?=
 =?utf-8?B?aWJWc3p2TGkyZERUQUkzS2NtUjhyeEtHY0d1cHpLWDN6NzU5Wi8xMmpjM3hW?=
 =?utf-8?B?aXgxeCtmeEZvbVdqQldsL25iTVlWTEE2a2duSnBscXF2THI5MUU1MkF2VVZ4?=
 =?utf-8?B?Z3lqUE5WdGgvT3ZZVFN2ZWdNbHY3WUQ4dHhHNGZSbjFqM3NieG1yeFZOa0N4?=
 =?utf-8?B?WmNSQzdic2Y4T1pvdEloWkQ5VmozYmpPc1BTbXFGTDdwR2ZaZzhielRtYnJw?=
 =?utf-8?B?bStNTWJQRGdIdkhqNzVjb2V1emNUK3R6UTZvUGJxWGZZUXhraTNpTlE0U2No?=
 =?utf-8?B?aXB0am1xSmRiNE5xZVdaeGdyZ1ZsVE5OUDJFVzB3N3hrRWtHc1U2d1lSNERL?=
 =?utf-8?B?OUlLSVE0dFFCc2xYakRabUpGL2l0SitZTlpsRUUwZlBPYXBrL3ZWSUVLM0Rq?=
 =?utf-8?B?MmhzWTYwa3hWRFBMZy96VkRFZ2xkTkFCelc5ZUtYL3lxSkZ3czQwcEQrVXlq?=
 =?utf-8?B?TjNSRFBwbS9Nb3k2ZDJjTHNFUUdFTGNMdm0vRjdOTzJYQmkwUldiMXdZTDc4?=
 =?utf-8?B?NHg0ZGtyVnFYS0VMaUFMM0Y2b2JsdXJUYjVmQ28zaTkxakFNTkk2Vnhacitj?=
 =?utf-8?B?cWZlcElEcjhqNDFrZjZBNlJ3bEpIc0grRTNjMXVIYWcyUTNSeVNVMEpBYXlN?=
 =?utf-8?B?M240bm9qaTA1TlFRV3VUWFhBZGI3MkMvaVhzYkRKYkJPQ2paaVRxRU9pNmU4?=
 =?utf-8?Q?pYsJ0CFKX3L/AnCwLrnVbVHPR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e6f7e01-cdf8-4984-2496-08dc448e4451
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 01:21:40.1540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mFeiXdEbabPbws3uy7Yd7SqdcofZdCVxUzJuSx9GFgx+Vc4JldW/WM+mGi+gK0xJZyMase1P1KSNhvaBF2vM9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5236

DQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IFJlaW5ldHRlIENoYXRy
ZSA8cmVpbmV0dGUuY2hhdHJlQGludGVsLmNvbT4NCj4g5Y+R6YCB5pe26Ze0OiAyMDI05bm0M+ac
iDE15pelIDg6NTINCj4g5pS25Lu25Lq6OiBQZXRlciBOZXdtYW4gPHBldGVybmV3bWFuQGdvb2ds
ZS5jb20+OyBSZXggTmllDQo+IDxyZXgubmllQGphZ3Vhcm1pY3JvLmNvbT4NCj4g5oqE6YCBOiBq
YW1lcy5tb3JzZUBhcm0uY29tOyB4ODZAa2VybmVsLm9yZzsgTHVjaywgVG9ueQ0KPiA8dG9ueS5s
dWNrQGludGVsLmNvbT47IEJhYnUgTW9nZXIgPGJhYnUubW9nZXJAYW1kLmNvbT47IEJvcmlzbGF2
DQo+IFBldGtvdiA8YnBAYWxpZW44LmRlPjsgZmVuZ2h1YS55dUBpbnRlbC5jb207IGlscG8uamFy
dmluZW5AbGludXguaW50ZWwuY29tOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+
IOS4u+mimDogUmU6IDMyYml0IHJlc2N0cmw/ICh3YXMgUmU6IFtQQVRDSCB2Ml0gZnMvcmVzY3Ry
bDogZml4IGRvbWlkIGxvc3MgcHJlY2lzaW9uDQo+IGlzc3VlKQ0KPiANCj4gRXh0ZXJuYWwgTWFp
bDogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gT1VUU0lERSBvZiB0aGUgb3JnYW5pemF0aW9u
IQ0KPiBEbyBub3QgY2xpY2sgbGlua3MsIG9wZW4gYXR0YWNobWVudHMgb3IgcHJvdmlkZSBBTlkg
aW5mb3JtYXRpb24gdW5sZXNzIHlvdQ0KPiByZWNvZ25pemUgdGhlIHNlbmRlciBhbmQga25vdyB0
aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gDQo+IE9uIDMvMTQvMjAyNCA1OjA0IFBNLCBQZXRl
ciBOZXdtYW4gd3JvdGU6DQo+ID4gT24gVGh1LCBNYXIgMTQsIDIwMjQgYXQgODoyNeKAr0FNIFJl
aW5ldHRlIENoYXRyZQ0KPiA+IDxyZWluZXR0ZS5jaGF0cmVAaW50ZWwuY29tPiB3cm90ZToNCj4g
Pj4NCj4gPj4gK3g4NiBtYWludGFpbmVycywgVG9ueSwgQmFidSwgUGV0ZXINCj4gPj4NCj4gPj4g
SGkgRXZlcnlib2R5LA0KPiA+Pg0KPiA+PiBPbiAzLzEyLzIwMjQgMTI6NTMgQU0sIFJleCBOaWUg
d3JvdGU6DQo+ID4+PiBCZWxvdyBzdGF0ZW1lbnQgZnJvbSBta2Rpcl9tb25kYXRhX3N1YmRpciBm
dW5jdGlvbiB3aWxsIGxvc3MNCj4gPj4+IHByZWNpc2lvbiwgYmVjYXVzZSBpdCBhc3NpZ25zIGlu
dCB0byAxNCBiaXRzIGJpdGZpZWxkLg0KPiA+Pj4gICAgICAgcHJpdi51LmRvbWlkID0gZC0+aWQ7
DQo+ID4+Pg0KPiA+Pj4gT24gc29tZSBwbGF0Zm9ybXMoZS5nLix4ODYpLCB0aGUgbWF4IGNhY2hl
X2lkIGlzIHRoZSBhbW91bnQgb2YgTDMNCj4gPj4+IGNhY2hlcywgc28gaXQgaXMgbm90IGluIHRo
ZSByYW5nZSBvZiAweDNmZmYuIEJ1dCBzb21lIHBsYXRmb3JtcyB1c2UNCj4gPj4+IGhpZ2hlciBj
YWNoZV9pZCwgZS5nLiwgYXJtIHVzZXMgY2FjaGVfaWQgYXMgbG9jYXRvciBmb3IgY2FjaGUgTVND
Lg0KPiA+Pj4gVGhpcyB3aWxsIGNhdXNlIGJlbG93IGlzc3VlIGlmIGNhY2hlX2lkID4gMHgzZmZm
IGxpa2VzOg0KPiA+Pj4gL3N5cy9mcy9yZXNjdHJsL21vbl9ncm91cHMvcDEvbW9uX2RhdGEvbW9u
X0wzXzEwNDg1NjQgIyBjYXQNCj4gPj4+IGxsY19vY2N1cGFuY3kNCj4gPg0KPiA+IFRoaXMgZG9t
YWluIElEIHNlZW1zIHVucmVhZGFibGUgaW4gZGVjaW1hbCBhbmQgSSdtIHdvbmRlcmluZyB3aGV0
aGVyDQo+ID4gaXQncyB0aGUgYmVzdCB2YWx1ZSB0byB1c2UgdG8gaWRlbnRpZnkgdGhlIGRvbWFp
bi4gRG9lcyB0aGlzIHN5c3RlbQ0KPiA+IGhhdmUgb3ZlciAxIG1pbGxpb24gTDMgZG9tYWlucz8N
Cj4gDQo+IEkgcHJvcG9zZSB0aGF0IFJleCBpbmNsdWRlcyB0aGUgaW5mb3JtYXRpb24gYWJvdXQg
QXJtJ3MgY2FjaGUgSURzIFsxXSBpbiBmdXR1cmUNCj4gY2hhbmdlbG9ncy4NCj4gDQo+IFJlaW5l
dHRlDQo+IA0KT0ssIEkgd2lsbCBpbmNsdWRlIHRoZSBsaW5rLg0KDQpSZXgNCg0KPiANCj4gWzFd
DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvS0wxUFIwNjAxTUI1NzczMDNDOUQwQjEy
NDc0MzZCQjA2RjhFNjINCj4gNDJAS0wxUFIwNjAxTUI1NzczLmFwY3ByZDA2LnByb2Qub3V0bG9v
ay5jb20vDQoNCg==


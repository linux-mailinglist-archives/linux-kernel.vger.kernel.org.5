Return-Path: <linux-kernel+bounces-59949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C1A84FDC8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BCA91C20A60
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEFD6FC6;
	Fri,  9 Feb 2024 20:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="WX9XQqjD"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2041.outbound.protection.outlook.com [40.107.114.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEC2610C;
	Fri,  9 Feb 2024 20:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707511271; cv=fail; b=uNNfuClRZPhp8tGjvMsJn7tcWSpvs+tmAoGs6cYN0xihMuyxUEZYS6+6LfF2dJZFHBcQJlUkvbLl6RtbAMAORbUEOdfDJc7u3YMWTdyv4FedkuUKiVBw4Tyw0uRKrcwYEpLVX2FX0mPNu/MSfRw9+cAMd5vFN6R6XVjiciKJnDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707511271; c=relaxed/simple;
	bh=EyAKfj+GByfL/4iH7/ERMlC/c8cYH96CGqkfFQPeNDs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J8hUW3kBdtypAiL10VfOA0bF2yprhUhlvl04JKzckIFaW7/6i05IbkIbKeX1zMAhpbWiy+8r0FDRGBMYN6eik2AgRuFyYqNOeLX0WYnY4Kkajf5xKO0F6AgSzUjBlxf6ylqdI/HWkI3pdUiZml7dKOe2KICWtqgJgEZt46g3w9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=WX9XQqjD; arc=fail smtp.client-ip=40.107.114.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDlLpRGIIcDoYTImyu4i/Ew43fWmomMYjiFMAKJudlprpyjSSOJTds2BDvjXCVYJRU7e0ZTxD47xJgZyzWIidiGYEuFQWRxVYsHtwdf3VeSrpK4SQZuIWdc6eodRuOM5S3e+1xn2XsqbNEyMeXGrZsZaSl/zRUvdDLbUrEZRmXeruN6UKdeMFlEbzZZle4MtGpGjRxoc3tmgPB9YWkQb8oNk+ft5HArG7bVL7ghpFDhKQMJ2W9GCX0s9U0mQ1eCyQTloImDnollc0xj8pR1kmPiolyB9o1VPkPbBOq2Cmy51sMh3LYInnyQPU5QRjqs1tgRgcEJXhzX7i0UhfG7cEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyAKfj+GByfL/4iH7/ERMlC/c8cYH96CGqkfFQPeNDs=;
 b=AhWJKilBWDW+4vh73FoLHlT0VYDWWmLrQMdCwd/qX5ulghxTN5hVlhaJ+leqMjMYJvS1TL7tdatTVK3app6lJWtpWwOPMNMjG4WN+fcp13bUrTIaERRiGt5kQtLiLygkOLbpPprL/7mq9+tunIQamEIgi/tuAoPK7QwJZsrGl/cEFFykJNz4Jam5e/Ox0mbxdsNyWUCvgwNmvCG1k4cMQFqPXhh1dPBLCtZ36jDrv5tAkoGfTjIOMx+EIlnHcw2qDc1IAaj6QGuqnpspe25uti+uambZAin1XfNMNxuvxQu6XKtiYiawqcUqs82g7KdPxyAuU3ayDjlWyoE9EA6ofw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyAKfj+GByfL/4iH7/ERMlC/c8cYH96CGqkfFQPeNDs=;
 b=WX9XQqjDCPJe5oGrXAYJAO9X4UvcOMYT2jdsV+F6H69iG5bhrFwgeLCTFiyj/rueaEgxqeSRuQm4Wi6nwdzptGA54NWHjcRYolSuDkpXdq+O1UvBxnMoDvE6oCZVzUYd+aOswSFR1XBotFACud0NFjbncV/kdLIFKo3KM6uDIP0=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TYCPR01MB8740.jpnprd01.prod.outlook.com
 (2603:1096:400:18d::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.28; Fri, 9 Feb
 2024 20:41:05 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0%3]) with mapi id 15.20.7270.028; Fri, 9 Feb 2024
 20:41:05 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Sergey Shtylyov <s.shtylyov@omp.ru>, Claudiu.Beznea
	<claudiu.beznea@tuxon.dev>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH net-next v2 4/5] net: ravb: Do not apply RX checksum
 settings to hardware if the interface is down
Thread-Topic: [PATCH net-next v2 4/5] net: ravb: Do not apply RX checksum
 settings to hardware if the interface is down
Thread-Index: AQHaW3pX9CB/Daj1+EissME+82JRZbECdciAgAACOOA=
Date: Fri, 9 Feb 2024 20:41:05 +0000
Message-ID:
 <TYCPR01MB112693D3BB55CB8CC91437B87864B2@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20240209170459.4143861-1-claudiu.beznea.uj@bp.renesas.com>
 <20240209170459.4143861-5-claudiu.beznea.uj@bp.renesas.com>
 <6f907f89-7588-fd99-1a63-8291f9e29c81@omp.ru>
In-Reply-To: <6f907f89-7588-fd99-1a63-8291f9e29c81@omp.ru>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TYCPR01MB8740:EE_
x-ms-office365-filtering-correlation-id: 961bda7d-9004-4fe3-bd79-08dc29af6fd8
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 2fvmN6/Y/fVAt5CJpcpBtfi9x1sLTDxKjysGQ5gT0Ne2N4DSa5t7aU8JwXL/Ah1MNIUHPHwbdHCmtMzLWVt14xeuj3OowS8NV7dTRh2SpbMZEy9PmIVfAasBZLU305/RCYqdaLH3MdQTWBWIiX2XD20dXaACNRrXOilZYRlewdPorESjmFsoMzj99UsHvzPMIqiCXP0ZFG00CoydaHiUA3szpzpa60wJTzxXn/XYlOwFMg8d5lYW4VQNiLjeueAMJ8B3BNArzqEerXrJbKjm5EVQtbioSmhn0odObGWc5haCWRrOYcBBaF2LLCOmYCkIU2GtLfs1VylVTqOzVhgKWJZwH4AuMBJebTYdXgR5L1E1uGYPiFtvm0yZ2uT4b4p9T8aW9bWBJW7+TPa/cA1GRhOSXgYk/V8mvCHPhIKLB+y0WREcugWN0fWN8RXpHjmU/GbUDg7dh6OJD6mDL7iTbxc6dgABABtImmLhZB1gz9GdPGcBhcWA0exFAW6pOnYtJqvN+ZIP0Wuk48rUm+hl5vUnGE6MAK8sJbF0K2bayFikGISWBG9AS+LEKYjLLFuzrvz2CHwR4YyoR29U4Tg6rSmodFB5YZhjJ8PpI1D3SESD4eZixxnwCAYnu3QFxVU3
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(346002)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(33656002)(38070700009)(26005)(107886003)(478600001)(41300700001)(53546011)(64756008)(83380400001)(76116006)(66946007)(66476007)(4326008)(110136005)(5660300002)(8936002)(71200400001)(8676002)(66446008)(66556008)(54906003)(9686003)(6506007)(7696005)(52536014)(316002)(86362001)(38100700002)(122000001)(55016003)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WXBpNmpsVWJwUEU3RUdSeFhmRmNsaVlML1Z4SFdVQkVnVGpjOWZIZ2ZCc3kw?=
 =?utf-8?B?M2dKM0t4RGl6Sy9zK3k3R1ZFcFN3OEJYVHFXK3ovTXorVUZsSHJpL1BtcXFH?=
 =?utf-8?B?NWtuQ2o5MVZXUU03K2ZhT3lVNG9jYVNENFd6clM0Q3VnYzR0bXJ4MzJNRHNp?=
 =?utf-8?B?cElWQkIvcEhNK09RdE5Fd0lHWEk3dWNxRjE1SUVVditqWXhycXJrbkx2WGI0?=
 =?utf-8?B?Qkp1emQ3N3VRQy9hSnJXblRWSWNlUUhmTWlqRUdTYVNwR1BBQ2JzMHcxYlRz?=
 =?utf-8?B?NWFkK2YwQWtpbks3ZUZZM3BPbS9ZOTZJcXp4VEZMTnVtUFpob0xLVmpZSkFC?=
 =?utf-8?B?L00vbEJMbVpDdldKZmJJL2trZnU4YSt1ekM1enBJQzJhWWVZUlFzblFvdTJH?=
 =?utf-8?B?OGR2N2JoZ3pCSVF2SnlWRU9LS2wwRW1WRmtPZnQ3WjAxVU5kM1I2Z3JMa0RN?=
 =?utf-8?B?SnNQd3diWEo5Wi81VGt2dGRIaW1VdFpSZnVjRXhDaEFvRW9rUkZ2UStxYXpF?=
 =?utf-8?B?Zm1QLzUzaVRPSlBzOSt4Qmovb1ZKcmdCVThydHZJMjl4VVVYTWhrWUpyNVFZ?=
 =?utf-8?B?aGNMUUl3eWsySjg4UENUbmFGYUhXZzJMK1g4Q1ltUnlVWm0ybXY1UFE2UURB?=
 =?utf-8?B?YWEyWjdtdjl1TWhCUVY4Wm1YaU44VENJYmsxS25MS3loSXAybXpnYVBqcUw4?=
 =?utf-8?B?ekNOR3RNZldkT2pHcjZoNTJuaFdNWmRmbWIxY0Q5a3V5RGdmRTRwMVNQd0Fh?=
 =?utf-8?B?SGtOYzRjaGphMFRMZVdlc1dqYXpTaDdnN29scHpDbERVbFpkVlhFb0VzSTZj?=
 =?utf-8?B?ZnBSMUtodTkwWExPVnFNMVpYOU9QMFBVVS9aVXNpYkJycmg0SkhtemJUNVo4?=
 =?utf-8?B?dDFUNDJXdlh5eVp0cHRnUTM4Q09uVytWM1kwZVBlSldrMW9QNWsvaFErdWZ5?=
 =?utf-8?B?eXo0bWN4VTJqc3ZMbEhrazlNZHBGeDVZWEJJYzJHWmJYK3hRWWwxbnJBMG0x?=
 =?utf-8?B?OElBZGdGRXhQWDRkMnhZT080cGU4QlRlNlMxMjhGZ3VPTzI3Vko0YUVwU2lG?=
 =?utf-8?B?V2s0Qy9RK2dCRjVqTmZjU2hJZnZodVZ0QkhKVVFXVm5URStobno0U0tNWTVN?=
 =?utf-8?B?U2FUS05lYjZwOUVOeW1NbDlCLy85TlVoK0lrMDB1ei8xM2U2ZXZnWVlWdnJ2?=
 =?utf-8?B?UHFuTWl1L0Fnck8rSS9nT0NYMWxkKytxcnE5cVhpV0hEZnhocVBaWnVSR0tx?=
 =?utf-8?B?bWVEc3VSTHRCVUtBRVlBWmlUVVQxZWJYSVF3eldFdk5XMEE5Y0VSRmY1aFhq?=
 =?utf-8?B?SGs4Q1pINDAzNnNvS2pmVzgzMDZleGQybkFOMGxoLzh2ekdzdEFFYWRpOHpG?=
 =?utf-8?B?OFJJYlBaTjUvSk5jNFd4QU0xUnBjK1E0VWlXanM0WndUZERNRlBxRnIvWHJQ?=
 =?utf-8?B?RDJBQWtWS0FIUnNWS3c2YVB5dnlwdEF2U2c4ZGlBbFdUeXhDRnZvSkJaZDdo?=
 =?utf-8?B?bUZNNnBISzJ2ajE5T3ViakZnMnJKVGV3dEpoVmp3Q1FPdzBxNWxzdWxVc29p?=
 =?utf-8?B?ZkhDSUlFbXFvL0o1dTdnQzBWanRMbmFiTldZeEJEeUJiM2JxVkFjRDFVWlgw?=
 =?utf-8?B?aHBUTVZsMk9FRVJlc3JmR0R4QXlkOGNzdjluM1BtSFJ6NHhSMU1PMHBPYzd6?=
 =?utf-8?B?MlRnSzJTcWp3d3BJWHR1VzIxVVJjc1BDRmtsRHNhZCtscmNtVFdJNE9sdWJC?=
 =?utf-8?B?YmZSNk82akt3elJMclY2d1dnV0tQTXJqZXBSZHVJQ3B6Z29BVmJVaEhDVlFj?=
 =?utf-8?B?eE5TKzJ4bWxucWlIZmFkeVBsZjBwOTg4Z3N4OHlrcFQvVkNBODhiMlVBNHhy?=
 =?utf-8?B?SFBMbWVGVkJyM3o4Ky9OOWdLYUQ3a2FBUjlRWTcwRzJCUS9jaUNKejNBSGN0?=
 =?utf-8?B?K3JPTjdKa3U2VXV3MStGeVFveXlhN1hGc2IrQkIzS1g4cUN3Nk9vR2crTzd5?=
 =?utf-8?B?K2g4cnorWnRRd0liaDFOMjh5V1N4amVUUE11ZUhiZjF5ZTdYa3J3OExzaTB3?=
 =?utf-8?B?UnhqYXNLQmJzNkFHZnMxWkp4SFJhSGJVTTdWRVU3azhOME9aWUtDQWwxOWFo?=
 =?utf-8?B?MWhlenBpejlHci9HbjZRaWNucHk4VzJxRWU1eFBIdC92enhBU25xQXFDa1ZF?=
 =?utf-8?B?eHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 961bda7d-9004-4fe3-bd79-08dc29af6fd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 20:41:05.2024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hgUyI8ISLbHhwUoj5lYONJ9QhHTFxitBm8RgRfCttdcZFFvTEFoodY8WZP9ScNzs2ej3mMYKqPhqIQzH7z+br/9vgr/GnqPxlW6dFSFjAG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8740

SGkgU2VyZ2V5LA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNlcmdl
eSBTaHR5bHlvdiA8cy5zaHR5bHlvdkBvbXAucnU+DQo+IFNlbnQ6IEZyaWRheSwgRmVicnVhcnkg
OSwgMjAyNCA4OjI3IFBNDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0LW5leHQgdjIgNC81XSBu
ZXQ6IHJhdmI6IERvIG5vdCBhcHBseSBSWCBjaGVja3N1bQ0KPiBzZXR0aW5ncyB0byBoYXJkd2Fy
ZSBpZiB0aGUgaW50ZXJmYWNlIGlzIGRvd24NCj4gDQo+IE9uIDIvOS8yNCA4OjA0IFBNLCBDbGF1
ZGl1IHdyb3RlOg0KPiANCj4gPiBGcm9tOiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWEu
dWpAYnAucmVuZXNhcy5jb20+DQo+ID4NCj4gPiBEbyBub3QgYXBwbHkgdGhlIFJYIGNoZWNrc3Vt
IHNldHRpbmdzIHRvIGhhcmR3YXJlIGlmIHRoZSBpbnRlcmZhY2UgaXMNCj4gZG93bi4NCj4gPiBJ
biBjYXNlIHJ1bnRpbWUgUE0gaXMgZW5hYmxlZCwgYW5kIHdoaWxlIHRoZSBpbnRlcmZhY2UgaXMg
ZG93biwgdGhlIElQDQo+ID4gd2lsbCBiZSBpbiByZXNldCBtb2RlIChhcyBmb3Igc29tZSBwbGF0
Zm9ybXMgZGlzYWJsaW5nIHRoZSBjbG9ja3Mgd2lsbA0KPiA+IHN3aXRjaCB0aGUgSVAgdG8gcmVz
ZXQgbW9kZSwgd2hpY2ggd2lsbCBsZWFkIHRvIGxvc2luZyByZWdpc3Rlcg0KPiA+IGNvbnRlbnRz
KSBhbmQgYXBwbHlpbmcgc2V0dGluZ3MgaW4gcmVzZXQgbW9kZSBpcyBub3QgYW4gb3B0aW9uLg0K
PiA+IEluc3RlYWQsIGNhY2hlIHRoZSBSWCBjaGVja3N1bSBzZXR0aW5ncyBhbmQgYXBwbHkgdGhl
bSBpbiByYXZiX29wZW4oKQ0KPiB0aHJvdWdoIHJhdmJfZW1hY19pbml0KCkuDQo+ID4gVGhpcyBo
YXMgYmVlbiBzb2x2ZWQgYnkgaW50cm9kdWNpbmcgcG1fcnVudGltZV9hY3RpdmUoKSBjaGVjay4g
VGhlDQo+ID4gZGV2aWNlIHJ1bnRpbWUgUE0gdXNhZ2UgY291bnRlciBoYXMgYmVlbiBpbmNyZW1l
bnRlZCB0byBhdm9pZA0KPiA+IGRpc2FibGluZyB0aGUgZGV2aWNlIGNsb2NrcyB3aGlsZSB0aGUg
Y2hlY2sgaXMgaW4gcHJvZ3Jlc3MgKGlmIGFueSkuDQo+ID4NCj4gPiBDb21taXQgcHJlcGFyZXMg
Zm9yIHRoZSBhZGRpdGlvbiBvZiBydW50aW1lIFBNLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
Q2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhLnVqQGJwLnJlbmVzYXMuY29tPg0KPiANCj4g
UmV2aWV3ZWQtYnk6IFNlcmdleSBTaHR5bHlvdiA8cy5zaHR5bHlvdkBvbXAucnU+DQoNClRoaXMg
d2lsbCBkbyB0aGUgc2FtZSBqb2IsIHdpdGhvdXQgY29kZSBkdXBsaWNhdGlvbiByaWdodD8NCg0K
c3RhdGljIGludCByYXZiX3NldF9mZWF0dXJlcyhzdHJ1Y3QgbmV0X2RldmljZSAqbmRldiwNCgkJ
CSAgICAgbmV0ZGV2X2ZlYXR1cmVzX3QgZmVhdHVyZXMpDQp7DQoJc3RydWN0IHJhdmJfcHJpdmF0
ZSAqcHJpdiA9IG5ldGRldl9wcml2KG5kZXYpOw0KCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwcml2
LT5wZGV2LT5kZXY7DQoJY29uc3Qgc3RydWN0IHJhdmJfaHdfaW5mbyAqaW5mbyA9IHByaXYtPmlu
Zm87DQoNCglwbV9ydW50aW1lX2dldF9ub3Jlc3VtZShkZXYpOw0KCWlmICghcG1fcnVudGltZV9h
Y3RpdmUoZGV2KSkgew0KCQlwbV9ydW50aW1lX3B1dF9ub2lkbGUoZGV2KTsNCgkJbmRldi0+ZmVh
dHVyZXMgPSBmZWF0dXJlczsNCgkJcmV0dXJuIDA7DQoJfQ0KCQkNCglyZXR1cm4gaW5mby0+c2V0
X2ZlYXR1cmUobmRldiwgZmVhdHVyZXMpOw0KfQ0KDQpDaGVlcnMsDQpCaWp1DQo=


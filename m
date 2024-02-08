Return-Path: <linux-kernel+bounces-57587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8622984DB14
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A52C1F235DD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5626A32F;
	Thu,  8 Feb 2024 08:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="bU7jV0BV"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2069.outbound.protection.outlook.com [40.107.113.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF4C6BB20;
	Thu,  8 Feb 2024 08:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707379764; cv=fail; b=nPRZREJSo4+9Gf4e6GBAc13FivAifiYvdu5v026G0epH/ahpQ5XvMEv2lijzHrZOeU+oH26fxp4U0EAssGMUWqR3oyunq8NKsUnhjDlIFlpD4MoD4USgASWbS9nH1twvmq7ViF9qpixYdUwvTGE6Wul+KU8bSBomPqaNe+tBH4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707379764; c=relaxed/simple;
	bh=L/qpdnSyd6A+AUGSeL+kxv1H+xJXUSj6bnS8euTqiwY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bVrWNpNsjTl6YSPqSVOMGiQqccnX6Em4gCzhct9ZVJoXidIfuQiSETv3sIUyVkYJj/fYts1kSlJhuUaWKTpbtKBjQ7PjXvhaEffw99juGyRCEF5Ls5wJSC/HTy8PuR3Xvla/p4ZPGFJPlznn4xfFXoAtPPO3tU22MurC62FghZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=bU7jV0BV; arc=fail smtp.client-ip=40.107.113.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOZf+K+FowYWGQ0tC45fFg8KK752GDUD8zEz5fd1kEPePBfPWeCQOTzhRMbnwZIFBikt6lxer956540c0U/WxMVDrLCzTrpAifoqqQuC5BQTtN1W7dC/lYJQuuDldknbwZUd1e3qNBelDrRAWsFC3wE72rGbzOTbjN8lgXyCmZOf0KbZTDF/EVLRpXjxalkIj+uu+1Vb7uaUSb9wnFqxtDJOqeUcQZCnKOAEs0tNN3geVqaWuChKJQqBnYOVyba0IGjzeRDdJQN/KXKshRQ8ZZQtHVJwD8dtU8K9DKObFo7fpoIOUl6GYzvpBfpgzdXXcK6oBqF2b5muXxLkzmR4gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/qpdnSyd6A+AUGSeL+kxv1H+xJXUSj6bnS8euTqiwY=;
 b=ULGCSdWvFLCdRN1lkp4XsOR0zaNJZl6pRB77HiMPBlCtUFM+2R6yTJaCB+30Y5BRkdUgd6V0Ft10kLR90S3fDBF0OnMgYSZaSQDTyKt8y28WdcGh/ln1RF7qXBgp6+sUPs9c6Hjn/h2sIDksbHjwPjDlBk8oXHQQaNU/v2zbSd0BMi6JiBKYtax3oEoY6K4Ucs1kGUagVqzu1WCN5y7DuVneokzHswDXNsMKL6ctHjBF6etdfWsaKcj/Po5+qBWWtkrr1zG5RFo9kNIMddgvtt5F+q3Uslkrb0YEvVHBfjzrmqueOzQ6JJHjA6qMdBY1iQE2aZngMf40cmtk49dOrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/qpdnSyd6A+AUGSeL+kxv1H+xJXUSj6bnS8euTqiwY=;
 b=bU7jV0BV7Jm/BuoB6SYzzFoRxG6alafy1eVRUCAnDxNdqM6c23H2Wmdh5byAv9CJxtA+oSbtuB0vvsAi3uGideBPC5wkDqfBs4wnq/95V0e4jyHYSL/mppXK6aBQTaIHtKQeQwF4ygQmwp93+CMiDHattD+JiJOteP+mtTxg1Dk=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by OS7PR01MB11924.jpnprd01.prod.outlook.com
 (2603:1096:604:23d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 08:09:18 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0%3]) with mapi id 15.20.7249.039; Thu, 8 Feb 2024
 08:09:18 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Sergey Shtylyov <s.shtylyov@omp.ru>, Claudiu.Beznea
	<claudiu.beznea@tuxon.dev>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH net-next 4/5] net: ravb: Do not apply RX checksum settings
 to hardware if the interface is down
Thread-Topic: [PATCH net-next 4/5] net: ravb: Do not apply RX checksum
 settings to hardware if the interface is down
Thread-Index: AQHaWb7W3Y46Kl0YW0WfSZ+OQ75oxrD/WwQAgAC8JeA=
Date: Thu, 8 Feb 2024 08:09:17 +0000
Message-ID:
 <TYCPR01MB11269D8AEFA0E34230195057D86442@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20240207120733.1746920-1-claudiu.beznea.uj@bp.renesas.com>
 <20240207120733.1746920-5-claudiu.beznea.uj@bp.renesas.com>
 <82a95cae-29bc-06c1-0fab-5fa6302b4654@omp.ru>
In-Reply-To: <82a95cae-29bc-06c1-0fab-5fa6302b4654@omp.ru>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|OS7PR01MB11924:EE_
x-ms-office365-filtering-correlation-id: 46e49245-61ed-4a48-6df3-08dc287d3f71
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 sRUeLsxcnb8R5eF33rUpJzofzlHpj/5Gx0M5ULby1ry/Jr45AcBUtbgI5e13slPXoDLr0yF6w/gNxLK0E8MJ0ctOreso3tD5N74Q+Kgzuz6OrjT4w4vmsQWLArU2V/khH0jde56H3phujDRx56U299+OBT0rnD+xnEzZkn2LwaDxXEZUeL6qAKWFCRttrcF5IuVJUv41ZveLxHBkiZddaa8H2zh+sWYvqujIBRrJy7Wp7divGcpglqoj0rpFthGcLL+bQzEivi5L12d6HR5YK5ZruABxvfQEFQ4sj1O9e4QnzZkcnxXqGct2srDzJVZN0u/0p4nOGo1v9sP6wfFgSxfJo1rnDq3PyGbjI5cAkG6XhchA0YFll1NepqlrWgU0ukS1xVtCrMlyhVc3CHFkOkpe2YLf2S1R8kqKmaCVLs6dB7+4mzDsibwZRJcWzRJIfB0lpTyTJ03yZy6oplb0XQtqddhuu7c3AL3ERgPmINEPZwGSJGRDrYFpWON2ZI2mT5WhfjajaN8Ku5Tx1FxHinTCXqGG4S1thb8P8qHOA/PhjkI00aBpYAYGMlMTsNjqmNk2zvm35nMYIdEYqO8ljtNiGIvTQ7+fTJCW4RoT99HrVrLNh/GoVPDFhuUi1TI9
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(39860400002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(26005)(52536014)(2906002)(8936002)(8676002)(4326008)(5660300002)(55016003)(41300700001)(38100700002)(33656002)(86362001)(107886003)(71200400001)(83380400001)(9686003)(55236004)(7696005)(76116006)(6506007)(478600001)(110136005)(66556008)(66946007)(53546011)(122000001)(66476007)(54906003)(66446008)(64756008)(316002)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cDVhSHZKMnlSakhaYnY0Smh0REdPWXozSXZtMGlUM29VdWlhY3h1SmFTTjUy?=
 =?utf-8?B?bmVYeTAxclBENVpLTTJ2aGFBQlE0V09oNnZkcTNRODlmWjhmNUJLc3FxOFpW?=
 =?utf-8?B?U0VXM1B2TStZOGwyZ3ljRUEzS0taT1EwbmxmUTRPK1k4ZzNUcTMxcnVzcWVX?=
 =?utf-8?B?MmRWM0ZSOWJCUkUvUmxkMnJLcWQyNTJad3hTclRyNHhUZlBHaVZxSUZzcGR1?=
 =?utf-8?B?Mk52U2szRmZ6Z0xsdUM5bHlNZUhzbjJJRDQ0T0tHR0E0NlNZMGdZZ2tCQm9G?=
 =?utf-8?B?ZHFVMGtIRlZpOWQ1TEltU1N3UU1idmh2T1NCTHlQQWJnRlEwWSs4clIzelJF?=
 =?utf-8?B?U1NqeVU4NDNscUp1NUpLbUpEcGE2WHlHb3NFR2gwOXl2MjdlYm9ObDBGVWxw?=
 =?utf-8?B?b0VvazNlVFZwUkpwazNOKzE0NWdGU0tiWlNEaXdQeTFlekczcHluMGE0Slpz?=
 =?utf-8?B?SVl4bHpiT255d2NPL05qYm4zWSt4NzdaaDJELzRhM3h2ZFQ0QWRZWDFyT25o?=
 =?utf-8?B?U2VzQmlVN0t3MUJZRDhrZ0JIWHYxZE1KRmJXTUhkT3Q3Qy9XODc1RlNzZERX?=
 =?utf-8?B?L0ZQamtVRk42Y05pcmNKaC82akRsdjBkMzM4ekxLd0U0THB6UzM5L0xiTkRU?=
 =?utf-8?B?L2tXZDR5bDRsak55OG4rdnA4M1U4RWlaa3VER0puVFEzcGRrNjg5Ymg1R2w1?=
 =?utf-8?B?eUh4V01JNlVUeGgrVGR0Z0hYQWVmS0NMS0Y2WUFvT3NwUVI5bXE4MzdCVFla?=
 =?utf-8?B?QnNGcjFXMlU2YkpQcDJISWphSDVacmROTkpOcG1rZHAxbnlNS1ZLc3FINHF6?=
 =?utf-8?B?UlA5eHkwRU5hYlVNYVFIZFdZWTcxQWhuS3BXQmMzSEZieDRKL0FxTjFqOEdq?=
 =?utf-8?B?YlJ6RmRhemRrV1UwSGZoSndQdUliUGVpK3pnb3RHK3ZQcXJneE5iY1VYSzdu?=
 =?utf-8?B?Q0xyNWIrWERWVGh2NjRuVHp6emV0cEZMS3g3eEJja2x2eWJwOUJtK1pqaVFO?=
 =?utf-8?B?dko4dWZqSnlOV1IvOVhtQTZHMk1WOTNQR05lUjVyc1ZoaytnanNLQTl1ZVNM?=
 =?utf-8?B?RkM2WlBZUTJwL0RacmpqVUdKVDZ6d1dDMzVucEk1c2VVK3FVUnJ5N0hsUUdE?=
 =?utf-8?B?eVhTZ1BPa3RveGtPTnVMaDFQSTNWMEZBcEZKcnNQQ212a0hGMmp2eVI5OGsx?=
 =?utf-8?B?SERIZ04zTHc1NGNXUXRrVDREdVNGOHN3U3VKaEY5RlRJTE52QXNheWRJSkpK?=
 =?utf-8?B?S1VrMks1ZGNITHo5dGNkbWhOVkVjNk5UT3ZVS1puODRiaCthNkxScG5pZmc2?=
 =?utf-8?B?OVdOOVpYeGJ6OEFUZjJuZ0VyWXZlYnJjWDB1K1FuRmxvWGdDYWlud0k5NTlt?=
 =?utf-8?B?OXZONTc5NzFuYlB6Z2RGV1lMOXN4eEQvN2oxczh5d1NuVjNyYUd1LzRnVFFM?=
 =?utf-8?B?MlBSUWJ2NmxFQjJmcVdRZ3R4MTUyRHo2dkErQzluMGJnOWpxdlhjbFFEVkxP?=
 =?utf-8?B?OG92QmxUamhuOEM3SGpmNlIrWS8yMmF5RTRaWVY1bHExcVQrUXJSb1U4YmZ5?=
 =?utf-8?B?aExqaVFlRUNBREcwTk1heXhWOW50Zmx3d3Vrb3lmWXl4MnA2T05iSEc2bHVM?=
 =?utf-8?B?TUdwbEZTNzczK3lRc2h4dWVTVjBGWG9wRHc4aHBBQys3b2Fqdno5em01cHNw?=
 =?utf-8?B?TjY5ZTdjdURBK2J4OEMxc3BhTDBRL1hpc2RQTm5lSjlUZERtZTgyWUhLdUxV?=
 =?utf-8?B?dXNLYzNRTFN4dGZURktmcEQzaWVRL2V4QVV3R0M1TEZQbDdUdGF1ZE9xMGVN?=
 =?utf-8?B?Zm1zTXVJaHcxdFJHRmFRc1VMNWk0MTV1a3lkVURVWDYvVWtKQWZHS3Fja2FL?=
 =?utf-8?B?NE1XMzI4Z2J6MXdqL0IrOERLYk5CVk82VjQ0dTE2NWN6OGxCT1RjOU9TblQz?=
 =?utf-8?B?aVUxZ3VMS0tiRFgyR1dibHlSVk1qRW5iNGZrQXdBZ01RVjltSlZzUXdKMTc2?=
 =?utf-8?B?bVQyLzNPSm9uYkNtdTV2SEZIQmd4cktkb0NWSkVDZml4MEhybjltcU1VRFEw?=
 =?utf-8?B?RE9UYnQwanl6bEpxdXBwTjE2TmVJZ0pBTGlWVmtab2V4dlJ0L21sZHdQdVRG?=
 =?utf-8?B?QTdoWHFvMVlpeTNBWUdrbG13NjZFRFlINkJZamhYM1FVdFpheUI4cDk2ZURj?=
 =?utf-8?B?L3c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e49245-61ed-4a48-6df3-08dc287d3f71
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 08:09:18.0073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d9bfzfcxyeOnuPTun3ojGi2xfIc+mrwEeSxO3NBR4tiN6f8Tt2L3nVTmc9Mgzsi0yTHhTipf3Vwy31vQOZU9KWqDazeL168eZ2rL7hnn9qI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11924

SGkgU2VyZ2V5LA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNlcmdl
eSBTaHR5bHlvdiA8cy5zaHR5bHlvdkBvbXAucnU+DQo+IFNlbnQ6IFdlZG5lc2RheSwgRmVicnVh
cnkgNywgMjAyNCA4OjUwIFBNDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0LW5leHQgNC81XSBu
ZXQ6IHJhdmI6IERvIG5vdCBhcHBseSBSWCBjaGVja3N1bQ0KPiBzZXR0aW5ncyB0byBoYXJkd2Fy
ZSBpZiB0aGUgaW50ZXJmYWNlIGlzIGRvd24NCj4gDQo+IE9uIDIvNy8yNCAzOjA3IFBNLCBDbGF1
ZGl1IHdyb3RlOg0KPiANCj4gPiBGcm9tOiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWEu
dWpAYnAucmVuZXNhcy5jb20+DQo+ID4NCj4gPiBEbyBub3QgYXBwbHkgdGhlIFJYIGNoZWNrc3Vt
IHNldHRpbmdzIHRvIGhhcmR3YXJlIGlmIHRoZSBpbnRlcmZhY2UgaXMNCj4gZG93bi4NCj4gPiBJ
biBjYXNlIHJ1bnRpbWUgUE0gaXMgZW5hYmxlZCwgYW5kIHdoaWxlIHRoZSBpbnRlcmZhY2UgaXMg
ZG93biwgdGhlIElQDQo+ID4gd2lsbCBiZSBpbiByZXNldCBtb2RlIChhcyBmb3Igc29tZSBwbGF0
Zm9ybXMgZGlzYWJsaW5nIHRoZSBjbG9ja3Mgd2lsbA0KPiA+IHN3aXRjaCB0aGUgSVAgdG8gcmVz
ZXQgbW9kZSwgd2hpY2ggd2lsbCBsZWFkIHRvIGxvc2luZyByZWdpc3RlcnMNCj4gPiBjb250ZW50
KSBhbmQNCj4gDQo+ICAgIFRoZSByZWdpc3RlciBjb250ZW50cz8gSSB0aG91Z2h0IEknZCBwb2lu
dGVkIG91dCBhbGwgb2YgdGhlc2UuLi4NCj4gDQo+ID4gYXBwbHlpbmcgc2V0dGluZ3MgaW4gcmVz
ZXQgbW9kZSBpcyBub3QgYW4gb3B0aW9uLiBJbnN0ZWFkLCBjYWNoZSB0aGUNCj4gPiBSWCBjaGVj
a3N1bSBzZXR0aW5ncyBhbmQgYXBwbHkgdGhlbSBpbiByYXZiX29wZW4oKSB0aHJvdWdoDQo+IHJh
dmJfZW1hY19pbml0KCkuDQo+ID4gVGhpcyBoYXMgYmVlbiBzb2x2ZWQgYnkgaW50cm9kdWNpbmcg
cG1fcnVudGltZV9hY3RpdmUoKSBjaGVjay4gVGhlDQo+ID4gZGV2aWNlIHJ1bnRpbWUgUE0gdXNh
Z2UgY291bnRlciBoYXMgYmVlbiBpbmNyZW1lbnRlZCB0byBhdm9pZA0KPiA+IGRpc2FibGluZyB0
aGUgZGV2aWNlIGNsb2NrcyB3aGlsZSB0aGUgY2hlY2sgaXMgaW4gcHJvZ3Jlc3MgKGlmIGFueSku
DQo+ID4NCj4gPiBDb21taXQgcHJlcGFyZXMgZm9yIHRoZSBhZGRpdGlvbiBvZiBydW50aW1lIFBN
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVh
LnVqQGJwLnJlbmVzYXMuY29tPg0KPiANCj4gUmV2aWV3ZWQtYnk6IFNlcmdleSBTaHR5bHlvdiA8
cy5zaHR5bHlvdkBvbXAucnU+DQo+IA0KPiAgICBJJ20gYWZyYWlkIHN1Y2ggY2hlY2sgbm93IG5l
ZWRzIHRvIGJlIGFkZGVkIHRvDQo+IHJhdmJfc2V0X2ZlYXR1cmVzX2diZXRoKCkgdGhhdCdzIHBv
cHVsYXRlZCBieSBCaWp1IERhcycgY2hlY2tzdW0gcGF0Y2hlcw0KPiAod2hpY2ggSSd2ZSBhbHJl
YWR5IEFDS2VkKS4uLg0KDQpZb3UgbWVhbiB0aGlzIGNoZWNrIHRvIGJlIG1vdmVkIHRvIHJhdmJf
c2V0X2ZlYXR1cmVzX3JjYXIoKSBpbnN0ZWFkIG9mIHJhdmJfc2V0X3J4X2NzdW0oKQ0KYXMgcmF2
Yl9zZXRfcnhfY3N1bSgpIGlzIGNhbGxlZCBpbiByZWNlaXZlIHBhdGggYXMgd2VsbCB3aGljaCBp
cyBpbnRlcmZhY2UgdXAgY2FzZS4NCk9OIHJlc2V0IG1vZGUsIGFueXdheSB3ZSBkb24ndCBnZXQg
YW55IGludGVycnVwdHMgc28gdGhlcmUgaXMgbm8gcnguDQpUaGVuIHBvc3NpYmlsaXR5IGlzIHRo
cm91Z2ggc2V0X2ZlYXR1cmVzPz8NCg0KQ2hlZXJzLA0KQmlqdQ0K


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047167A4C23
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjIRP0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbjIRP0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:26:45 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2070a.outbound.protection.outlook.com [IPv6:2a01:111:f403:700c::70a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D6810C1;
        Mon, 18 Sep 2023 08:26:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4taH8vUk761lhSj8mIEV/IAPMAuuoCvwEEQBwYvONLB1HLBlJnGAVSzqwZ0+2DIMlj8S8omIR7cwYES9lPHQhi/TlTtQoyHfV5WmPTfMhWdnXRVVlLvQOKzaly2XMNdVUQxCTpDMNh2K7gI0AK7U8zDGQLHGhQZ+kFg3fFlaI2PoEJww0K5OY5SZbFC1dLLpFjfY1iXKqDKsHAFnYvT3CDizpU0rclopviQUFMXhvFIln7gCtx/gv5yr2WE3QfvdaStWhWEBDqoZmbR0B8h4IWEmrMvZKLGZP1AyNc3cpSaBLszR4qUiLK1q+MQvMyNCGK+lrISbpmHk8ID4S0W6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0NX35uj/9vC4oeLK30vbwe0sRr4BkG70nceJUXFgGpY=;
 b=CiHQRJJsMd7XbjWGyM0r3dNQ1czDLoYwtnUUoh6v8LhTwm9yCeqwUtYbzZTD8ickFDSnu81Ce0r2lkSfGYFUh0T2jUFlx6c0IEgUIJuqkrP9Kh0nC1cNDEbRDwuKrpx87liqzcdBPbqry/BlJs20qX/B6eqZCPD9unfNWedZtci4lXPYKIiDHRsoWF3QZbNy7WpMzgHgZl3WclDYIN7mJgGn3XUIruFEB2xl4mE6ITwv3N8SG8QCf0HFultZycHs5H9eOVgAyIV2CAgPu7hJPqTsS6VPRatLykrmcaOMr5zHUe+G7BG0wcUyGqjlXEvtubnU9Jd8Ii8VkCnEveMlsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NX35uj/9vC4oeLK30vbwe0sRr4BkG70nceJUXFgGpY=;
 b=WjMTak3iYvaWKSWovEvBX/NYzrJKiA8obfUVHE1mqhuddtChOAGRg3MWTI+DWZ10E6WFQv4lZp6GQaK979UhXihxK6egR3iM4YyXZi6QHMJvlWmI09xV/N04zKRuRh0txQg3gERpFQnclVzdmvWuXYoURLy+QQ+8PRD7FVBIpKQ=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB11465.jpnprd01.prod.outlook.com (2603:1096:400:402::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 13:18:54 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 13:18:50 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Biju Das <biju.das.au@gmail.com>
Subject: RE: [PATCH 2/2] pinctrl: renesas: rzg2l: Enable noise filter for GPIO
 interrupt input
Thread-Topic: [PATCH 2/2] pinctrl: renesas: rzg2l: Enable noise filter for
 GPIO interrupt input
Thread-Index: AQHZ6ixt37i5mirEkU2vvrutS3Og4rAgivWAgAAEY6A=
Date:   Mon, 18 Sep 2023 13:18:50 +0000
Message-ID: <OS0PR01MB5922356278D492FC32F0583586FBA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230918123355.262115-1-biju.das.jz@bp.renesas.com>
 <20230918123355.262115-3-biju.das.jz@bp.renesas.com>
 <CAMuHMdVcy82eQNKtqufk8Nb6PKYTgmZw_b_mC+qgmGMHt1gyiw@mail.gmail.com>
In-Reply-To: <CAMuHMdVcy82eQNKtqufk8Nb6PKYTgmZw_b_mC+qgmGMHt1gyiw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB11465:EE_
x-ms-office365-filtering-correlation-id: bfac4d12-d58a-451b-2e95-08dbb849cc66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oVxea/ZhK2hv7ZyNgFpavkggXpDayDJUXkv31+9mv55asCgmYWAJttFfNPhPHl3K2W/CX0F2dQ+F/RBBu9nk6ER721hrx7KNe9IHneAljg2meJxS0EXmJHxg0kthaPo2T0hB+6+kPkN2hUSwLHzYeXrcFhYEfynnLyN9ZHPhulzJLjZUIeLAKxS96DRO1Ca/WabVLFkDZBDwvfeDe7OywFx1VTkzXB1Ukk+HEZmiZ6w9tBUUtEnKovrElLD4WADGTFdQH/BQpHI7Tb6/MxJhOL8BkMuxh8UQQOC1Mza9GyQGLyvxkg4Fac8lMJAw4vcUAJzdJxFi8OxlryXoRd6CHttQ19NqepVDQiiQlH+zpTMY2pMUDVrzYDP9u7Kb4PAXhjn+fppw0NwJLlfAi9WTv88TMuWIXqo+OgDHTuaTkOs0+IIYKO+cx5GlMgIFTdprA299QFnLLit+pHjD3/RQReYL6lVcFP1tdppj2L1/qf5+uTuPffcZN7XfaU74Y3wXIWgDfhP4M1BaXoGG3viK/FllNrTuaCI2sK+3DvIfmRs5Mnnm67YCgCrAjHISwi63Yrqa112a3ed0TyX6iL6sxOHZvHGHP4KUHPQjL8utsaqHTYbtzi9i6rra4SMrlIk0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(366004)(39860400002)(186009)(1800799009)(451199024)(55016003)(2906002)(83380400001)(38100700002)(38070700005)(122000001)(53546011)(71200400001)(6506007)(7696005)(9686003)(478600001)(5660300002)(4326008)(76116006)(6916009)(52536014)(316002)(8936002)(8676002)(54906003)(66946007)(66446008)(66556008)(66476007)(64756008)(41300700001)(26005)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlZKWFdXcTlzTlVzWFZ3dVE5QU40alhWWmNNZk9uQnVSc1owdnp6UTYrY1RF?=
 =?utf-8?B?S05PRFFDRDQxaEdvbTQzVVpOQVU5a0x1dTZwcWdVeC9zd3RtVGlLV09sS2hj?=
 =?utf-8?B?TVpEUlY0SE1XVmNoemVKOGJPQ1JFWTRPa1BJdFdxekg2d2J5UFJvaDA3QlNm?=
 =?utf-8?B?MEdvSmVwb1cydTZvOHdMcUtKNnNYZlFCM0hSY3VIQVlHaU8wajdIZ3h0amh1?=
 =?utf-8?B?NXhBNUxTdUJaVzdmaUZNcnBQK3M0ZThqMmZ5Vk1NS1A1bHpUUzc2QUtmaUh3?=
 =?utf-8?B?UFovZG8vbUdROGN0NTZuY1Jzdml3Tm9UUFdCVm00ZVRyWmpPUDQyY0dGVnA5?=
 =?utf-8?B?MU55S3hpanl4QWFjWHd4SUlxdGgyVTJWemcrMUMyVTY4VmpVdGV6UjNOMkd2?=
 =?utf-8?B?Ykc5ZTZTUnZVSTBHYStrdWc5T0NQVU5nS2JWNUxsV0lSbzVxV0NUMXh3OWR0?=
 =?utf-8?B?L29nRGY5L2wyNnRBektVMUZ6aVI4WGo3WFFXWGFJcWNnRzZxNUtkOWwyMTFh?=
 =?utf-8?B?WE9uL3ZPNzRxMWNDdktTQU84SUxDd3RZOWtEOGJ5UjVERk5UR0lEcmk0NlB3?=
 =?utf-8?B?TEtkZ1k1c21QdXF1U3ZNWVI3QVFJZVBmSkkyODFPdHhLVmFvbWluVVJPY0FS?=
 =?utf-8?B?UjF3U0ErZ2RuUlhQWjZ2S2NxVHdsUGtpcWRIcGhLWndNSThYNk9VcG83ZVda?=
 =?utf-8?B?SThtdmNvd1NYR25XUEIzY0JKUW5TQXREa3VZYlZaU2Y1aSt2b2d4MDd1d253?=
 =?utf-8?B?S0VKTlQ1UkY2ZmFCeGNMaXJSd2xDZzNtYit0Wk9EcDJXbCtMZ1JOamttTGFp?=
 =?utf-8?B?dkM2V3Bid3BPZUswNFp0b1RKL2Vub3ZIRDdBZDNxT2w2Y0o0TndnUTQ4aUFs?=
 =?utf-8?B?ZGI0SzJyWno2VVFOMTZYY0dOL1V4SzhCaVFUNytiSDRmQVVwNFRDZGJabk1o?=
 =?utf-8?B?Y3hCcEhGMW1pZW9oRm1xQ2g2T2dIRDRRelBUK2NpSDliOTc3SGlHUllUYUZB?=
 =?utf-8?B?VitBNjA3bWszZTdOSVZFU0JrV1lpZE5IOU9Oay84c0VFdndlTlBXb2tnalo1?=
 =?utf-8?B?TTRMVjljTTFGOTRHNkFRLzRQcDNQZ3NGMDJXbnpFb2FjdTdoUTZXb0NNcWN6?=
 =?utf-8?B?UlRUTWFiSlJmUDdNWFNjZktYT2kwYTg5ZlczWnVweFBIOHJ6enBOOThTZis3?=
 =?utf-8?B?dW5nVmZkRUlHNnBYeFhqc3ZRdllnQVUxRWxSR0FVamVzRDJPQ05sMHk5Qmxt?=
 =?utf-8?B?T21sU291RXdyQzJCalYzT2RrWTNpY21ybUF4WmtoSUQ5NllhSTNCUyswQ21r?=
 =?utf-8?B?RitOY2REbkE4M29abXNxbGdicGxXdnZXblVWWld0VEFWQkkxYm9rSFZzdmwx?=
 =?utf-8?B?cVJ2UDNRdERSbXVONXlvVjNwZWtSQ1NKQTVFZURmS3h3Tk5xVWZsOUR1SHI2?=
 =?utf-8?B?UWQ2ZVZPUHdoSVlXdFR6OGJoRVlWTFhvV0lDRnQwOWU1bmdTQTdFK1ZIdzlR?=
 =?utf-8?B?d25hUTlTZU1FdUtXMHpLOWtQZkVtOGU1dm0zeVNxeUFVa2RxZ2thZWdnRWds?=
 =?utf-8?B?alc3djErcXFGN3dYR0RIaEtHdnI1dTdIcmZOcm0weExWOFdpbmxjcm9Qekpi?=
 =?utf-8?B?T2twL1pJelBnR1RXK0xwa05uNjdjVTJ4WWk5enk5VWpIbDUrSSt5MHJpZEQv?=
 =?utf-8?B?Vmt1Qnk1RzBObk9GMUV4THFWL2VWVjFSRTczMU9QWEt0NldiU1lMdy8xYVAy?=
 =?utf-8?B?KzRSQU05V2ZPb2R4dUhuM3pPUWFBWUxZbHhxUDJDMWNKdFFtelNmbi9WRUFz?=
 =?utf-8?B?ZWZidzN6bHZrV202eFJoMVlqZXRWNWpvM2ROQkFmRHNoTEVXV0lqdlJ6Zlo5?=
 =?utf-8?B?VmxaVHQzMk9CeGhBS3BtTUx2MkdlMEQzeEdUOFdFdFA2ZTRLRnpJTEhxbGMx?=
 =?utf-8?B?WllzYzhsL1l1RlZ3ZXlqcnhOcmdZTmJLN21GM1laazRCV1d6aFNhY3BEU0d1?=
 =?utf-8?B?ZlJOMHJwYTFWYzFNdndIV2dpMHR0OExMNGMzd3lnbXhHYm1FaHdnbStjNkxr?=
 =?utf-8?B?WDZLRHFJZ0VYVkVXeEJBZSsrNytCWlc0YWVLU0lVaDJ1VzZRdzJQSzdQOStH?=
 =?utf-8?B?YjBKTmsrSWpqMUJ3dDVraFluYkpuSlNQM1l4RE1xMHlJdlpFWk5KQ1VUR0sv?=
 =?utf-8?B?bkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfac4d12-d58a-451b-2e95-08dbb849cc66
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 13:18:50.4168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ye6utLa1fx8vHFq8lY74izz5WlsU+rdxpkh/sFnQCAMCAHxDp+R3qxxjTTGFlqV3ytBemwc2IafjzRxb2rHRxbym08gtIL2huYvObubUzxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11465
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggMi8yXSBwaW5jdHJsOiByZW5lc2FzOiByemcybDogRW5hYmxlIG5vaXNlIGZpbHRlciBm
b3INCj4gR1BJTyBpbnRlcnJ1cHQgaW5wdXQNCj4gDQo+IEhpIEJpanUsDQo+IA0KPiBPbiBNb24s
IFNlcCAxOCwgMjAyMyBhdCAyOjM04oCvUE0gQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVz
YXMuY29tPg0KPiB3cm90ZToNCj4gPiBBcyBwZXIgUlovRzJMIGhhcmR3YXJlIG1hbnVhbCBSZXYu
MS4zMCBzZWN0aW9uIDguNy4zIEdQSU8gSW50ZXJydXB0DQo+ID4gKFRJTlQpIGFuZCA0MS40LjEg
T3BlcmF0aW9uIGZvciBHUElPIGZ1bmN0aW9uLCB3ZSBuZWVkIHRvIHNldCBkaWdpdGFsDQo+ID4g
bm9pc2UgZmlsdGVyIGZvciBHUElPIGludGVycnVwdC4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggZW5h
YmxlcyBub2lzZSBmaWx0ZXIgZm9yIEdQSU8gaW50ZXJydXB0IGluDQo+ID4gcnpnMmxfZ3Bpb19p
cnFfZW5hYmxlKCkgYW5kIGRpc2FibGUgaXQgaW4gcnpnMmxfZ3Bpb19pcnFfZGlzYWJsZSgpLg0K
PiA+DQo+ID4gRml4ZXM6IGRiMmU1ZjIxYTQ4ZSAoInBpbmN0cmw6IHJlbmVzYXM6IHBpbmN0cmwt
cnpnMmw6IEFkZCBJUlEgZG9tYWluDQo+ID4gdG8gaGFuZGxlIEdQSU8gaW50ZXJydXB0IikNCj4g
PiBTaWduZWQtb2ZmLWJ5OiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+
ID4gVGVzdGVkLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWEudWpAYnAucmVuZXNh
cy5jb20+DQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2ghDQo+IA0KPiA+IC0tLSBhL2RyaXZl
cnMvcGluY3RybC9yZW5lc2FzL3BpbmN0cmwtcnpnMmwuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGlu
Y3RybC9yZW5lc2FzL3BpbmN0cmwtcnpnMmwuYw0KPiA+IEBAIC05Niw2ICs5Niw3IEBADQo+ID4g
ICNkZWZpbmUgUElOKG4pICAgICAgICAgICAgICAgICAoMHgwODAwICsgMHgxMCArIChuKSkNCj4g
PiAgI2RlZmluZSBJT0xIKG4pICAgICAgICAgICAgICAgICAgICAgICAgKDB4MTAwMCArIChuKSAq
IDgpDQo+ID4gICNkZWZpbmUgSUVOKG4pICAgICAgICAgICAgICAgICAoMHgxODAwICsgKG4pICog
OCkNCj4gPiArI2RlZmluZSBGSUxPTk9GRihuKSAgICAgICAgICAgICgweDIwODAgKyAobikgKiA4
KQ0KPiA+ICAjZGVmaW5lIElTRUwobikgICAgICAgICAgICAgICAgICAgICAgICAoMHgyYzgwICsg
KG4pICogOCkNCj4gPiAgI2RlZmluZSBQV1BSICAgICAgICAgICAgICAgICAgICgweDMwMTQpDQo+
ID4gICNkZWZpbmUgU0RfQ0gobikgICAgICAgICAgICAgICAoMHgzMDAwICsgKG4pICogNCkNCj4g
DQo+IExHVE0sIGJ1dCBzaG91bGRuJ3QgeW91IGNvbmZpZ3VyZSB0aGUgRGlnaXRhbCBOb2lzZSBG
aWx0ZXIgTnVtYmVyDQo+IChGSUxOVU0pIGFuZCBDbG9jayBTZWxlY3Rpb24gKEZJTENMS1NFTCkg
cmVnaXN0ZXJzLCB0b28/DQoNCkN1cnJlbnRseSBpdCB1c2VzIHJlc2V0IHZhbHVlcy4NCg0KMDBi
OiA0LXN0YWdlIGZpbHRlciAoNDEuNjY2IG5zIHggNCA9IDE2Ni42NjYgbnMpIChpbml0aWFsIHZh
bHVlKSBmb3IgRklMTlVNIGFuZA0KDQowMGI6IE5vdCBkaXZpZGVkIChpbml0aWFsIHZhbHVlKSBm
b3IgRklMQ0xLU0VMDQoNCkRvIHlvdSBtZWFuIHdlIHNob3VsZCBwcm92aWRlIHRoZXNlIHNldHRp
bmdzIHRvIERULCBzbyB0aGF0DQppdCBpcyBjdXN0b21pc2VkIGJhc2VkIG9uIHRoZSBQQ0IgZGVz
aWduIGFuZCB0aGUgZW52aXJvbm1lbnQNCnRoZSBib2FyZCBpcyB1c2VkIGluPyBJIGd1ZXNzIHRo
aXMgd2lsbCBtYWtlIGl0IGVhc2llciBmb3INCmN1c3RvbWVycyB0byBtYWtlIHRoZSByZXF1aXJl
ZCBjaGFuZ2VzIGZvciB0aGVpciBhcHBsaWNhdGlvbi4NCg0KQ2hlZXJzLA0KQmlqdQ0K

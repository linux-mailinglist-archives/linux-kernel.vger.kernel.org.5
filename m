Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FEB7B00CE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjI0Jnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjI0Jnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:43:43 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2136.outbound.protection.outlook.com [40.107.113.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C32DF3;
        Wed, 27 Sep 2023 02:43:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DrKcVoNu4XA40rQns0uLvSAQmyexPwEh1H7P6/yWoMQ/iuBi0YTg7WsgtkFI5A5vnGkXysa6EaeLRRkBDFsDO2QewjbyilhY6ssSMCvLuFaxrS2+O0aClm2y5mCI1ov85E2nwwRT2Cg1V4QaXKWlncpDq2YvhuIOXt1GxehDRwLatcomqj4b9S8cz/Zd7Al40WTq9cqILFF5kxsQHD7TEdDp8Umpbrhz9QP31SN+OteLnhZIXfmjjNTuDVCTzbAFETNYvD1qCyQlQNLPKhLtvx7nfJNcW9vzeuDR8iSo6tdVAqI1i0kpSZrlTjNEMQaIa1en3YxGXfele9iO1M31pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9roojSoPrcpkWZ2814mbkl8QGDYXYGwNq44Q8Ye3hU=;
 b=PX5Fng2hgxZtTzj4BcVxVPmMQs0sx36qGbeWkcgcW4X/hNb6F57Y2NYlk+yt+qWGlLm+3qtOWMaJDx6s+d8FsyPCzQqkXeIWsTCd3WZaR4tprwUOACmRL2JoWMM4NjF8e/vamfGR2w6k7Sqbkrg7zFth20IoBhvOENoBL9xSETVPBIPxI1zGl75sYbN5ZUfmMO89PS2k4Jt9trfzQOELroDjH6xXWTS/S1ktlevIpwVNPrsWFjFjA+1PLeFSt9LSVQMGLyypiN2GOynASs42xL6ShLVeaxvoj7ho2BEH63BUKI1W7cr+omP//vxR5Y6MMb3svLOLeKaUbopN83641g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9roojSoPrcpkWZ2814mbkl8QGDYXYGwNq44Q8Ye3hU=;
 b=FVjWTYoJ3bymR6neyPpv0bjTqWO/ZFKLof9UTBBRHR2muBHMlfRbidKnn0auPlSNmqnscbfX5Ofw0VOXxW7jshI9xqmlnpqH/AyLtUyL9iVLn9iV3fc7/R3SD7WkA9r1zCH0OtVfTGusAKoVKW30aljZ9MfYpwnbbgfrtwkVO1Y=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by OS7PR01MB11454.jpnprd01.prod.outlook.com (2603:1096:604:246::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Wed, 27 Sep
 2023 09:43:38 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::600a:9708:18f:2528]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::600a:9708:18f:2528%3]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 09:43:38 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Brown <broonie@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 1/2] spi: renesas,rzv2m-csi: Add SPI Slave related
 properties
Thread-Topic: [PATCH 1/2] spi: renesas,rzv2m-csi: Add SPI Slave related
 properties
Thread-Index: AQHZ8L2blakiXIKx8k6DD60xX0IJ3LAuT32AgAAREwCAAAMCAIAACF3w
Date:   Wed, 27 Sep 2023 09:43:38 +0000
Message-ID: <TYWPR01MB8775E4D0AE5F60592C7E37B1C2C2A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20230926210818.197356-1-fabrizio.castro.jz@renesas.com>
 <20230926210818.197356-2-fabrizio.castro.jz@renesas.com>
 <CAMuHMdUibHxPBCLbeWdNrEk_szm+o4cOcskEMZAqUufNTzQKMQ@mail.gmail.com>
 <ZRPvHJXbuZ9Db2Go@finisterre.sirena.org.uk>
 <CAMuHMdUv8FFwkde8K3Ta8FEWrkkJ=9ZqbTi1EO8sRxVOhGtvzQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUv8FFwkde8K3Ta8FEWrkkJ=9ZqbTi1EO8sRxVOhGtvzQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|OS7PR01MB11454:EE_
x-ms-office365-filtering-correlation-id: 3a749a8a-6005-455e-4cec-08dbbf3e39ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GLpNYCXAVzgCXA1RthZb7sIvJ2cojwb0mSIdDciWBhqqpKRN5CLaGE70cUHXKc8k/zByOHAdtlVZ3YcWv8rcGGkRwY1E7kHEIHKAo5i7tmwHI9PUkf1eoPy6V/DIzGbO45zINGXB0/2OFll9H0XPUNm0k5CGqhizBO7rQ+oCxllItxLXjko2Uth8mpTyBYHcm5lLsHY8RVDCSrROW/y4ybgT3gybwWzYd7+HAuw/hrIQHVVbyiz07/QhiUxrHjGvkHOQlEYlvanBcWSyaUDRJtUDql4irk8tlEfH3YQy9WfRhBiP2JYVrwJigeMi4bItfACqLlSho1/Pf5DMD7CWMu60bEzR33DZFMSCB6UCQF8kibXYa9IsvspocHOTeJmE6BiK6dtrM4U+zjquni+/ngG74D1bN+PP0Tc6kYs5fkImVq6hyO+fQ3KOaNGAEhZmB4Uks+RLreskggLJQIDUgmHtE4Koc9eaAi33byC6zVmaMgnhpnNW9k6iYcWFhzm7+Xj2j0PDmPbzPWtpB2S/loX4YKQI1O4I2sCKDta3yoEgOaoJOqOB/++8Yl6lwBO6Wlg322Cf4tuTpooCg4OCEFP1edZMCn+W6XcNiNRB6U17cdrL7tToThWHHHjVVrlZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(396003)(376002)(136003)(230922051799003)(451199024)(1800799009)(186009)(2906002)(8936002)(7416002)(54906003)(8676002)(52536014)(41300700001)(66476007)(5660300002)(316002)(4326008)(64756008)(66946007)(66556008)(66446008)(76116006)(110136005)(478600001)(71200400001)(6506007)(7696005)(53546011)(9686003)(107886003)(26005)(83380400001)(55016003)(86362001)(122000001)(33656002)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODlvTWtjNXg3U1pHYU5FQVhZYWFXbkpQSVNUSmk1dXY1WEZXUnMvekllYk4y?=
 =?utf-8?B?Nk5maWQraS8yTE5hQWtuNUhkL3V1b0pEZzhoTE1lT2U4MTVscmZRWmgrelBG?=
 =?utf-8?B?ZUpNQXgrWWZHekpyL0U0KysyZWlJbGtPM3ZFQktnVy9HbERTYTVXNUVibW41?=
 =?utf-8?B?K1JvSlJqZTM4SHh5c1NVVlZIbVhPWWwvcFU3WitLZ0hxTmpaWDl2WTVib3RK?=
 =?utf-8?B?K2ZxZkIvTWozdmE4RHFCdytNaDJmNWdZNGV1WFNmTmxwMC9IcEtDdy9uSjJB?=
 =?utf-8?B?dTZQVXE1cTB2R2RmUFJTeXR2SWpnNUM4a1RhaGc2RUF0bnRIQ2lFZG0xSkll?=
 =?utf-8?B?Rmh3UFZpS1dYRE1NRDZHUHFrdmVLUVNEam9lUGRacU1xUmsxemx3dGZJZjVV?=
 =?utf-8?B?eU5rMmllY2tWWEpaS2RVVWJaQTJ5ZWZJN0tQSDByYTk1TXVEWk5CVnorTmxl?=
 =?utf-8?B?aTR3SVpWT2F5SWNTdGkwUUtHUGx3TjNsYjN6VjdYK2VPalJBZGxqK1JsYldB?=
 =?utf-8?B?SVhnSVRwZUJiNWNHUU5EZkp3cmVBNHVLQzcvOEM0bVUvZFlQTUt1V2JBeEM4?=
 =?utf-8?B?R05kdnd2UjBWKy9NTCtNSUg0U2tUME1yUHQzcjluTVV6SWl1N0ZrSmtqUG54?=
 =?utf-8?B?Vm9INWJvci8yU1ZCQnhCSWRJSlBQN0tra2xabS9hMWo5ZE94TTJvcmJDQXlk?=
 =?utf-8?B?b011TExVckltWE9VdE5qdHhTelA4dmZ4OExYS1d2Tk1CZWszc1dsd3VkbTAr?=
 =?utf-8?B?TVdRWVJJUW5pWnU2amNSWEhxa1lWY24zREZldnVWUTd0Qm1hWHBIbXhRb1pi?=
 =?utf-8?B?L1M2am1ZNExZcEl5bEJXeXMrTTNKbmZhSDkwc1JudHJiZEtwdFVBTm1MbXEz?=
 =?utf-8?B?K1VUdVY3WFBxQUl5cjVCMHJmZnd5K3ZZOUNiR1VGVXJETDhjV0ZtTjFLRTBp?=
 =?utf-8?B?dTBQeDFFT2JpbndycXFPc0JadndRWEF1Tk45aE1QaDQ5ZmlwZWNOQmxsZjN0?=
 =?utf-8?B?Z3hseXgvdmVBNVJXYWtQV0QwYXI2dzgzSElHbk45eS9oc1NhYWNPY2RkWXpT?=
 =?utf-8?B?Y1VQQjdFeWxZd1o1L3JKQTFQdjl1ZndXRGxybTFHbWIwRnJUbndoeWE4R0Va?=
 =?utf-8?B?M2kzNjZ4ejg2OUNvS2VKVWN5T0JoNGMzQmRhZWpVZmdrV1V4S2VyczN3ZU0x?=
 =?utf-8?B?TWNZY3piMEVvMG5EUnpLN0VScnVkRGRtbklKWmVLemJhOU1aZmhoeGIwWUQ5?=
 =?utf-8?B?eFNQM2YzSWRaNWZzSTRETDdKOWRwSy90TWdsNmtJd1U5azhSUE1Fb0VOczAw?=
 =?utf-8?B?aDE1N2xuWTNBUW1GNXljY0VVaVJvNzE4bW00U3pHUVg5QW5iVUxiQWhHY2k0?=
 =?utf-8?B?ZlhqVzRTejJqK3dUd21jY1pLV29aV0c5ZEZPVGljRVJId0hXVmJxK3k5MFNZ?=
 =?utf-8?B?clJjRjJTalBVdXRhS2trdVVscTZXbHBnSXk0TDZ4dGxraVltZjIvSmJETFE3?=
 =?utf-8?B?NDJRUmhCTW5OQUNOZDNyVjZlNklReE5rdlNoSGlXZXJiWXNiTXRMbXpOQTRO?=
 =?utf-8?B?eUpkTStCd0RHWmU5U3prRW5TSEhybzdMRE9UL0dWejF3OUNOL2p0UkFiVktl?=
 =?utf-8?B?MFB5b0hOd3djWXR6MU5qdTJKZ284RDNqZE10RjZxQWdKME1pTnBYWEZibkta?=
 =?utf-8?B?N2pHWWkwMzBQMmp5dmxQd2hZMk9PamR1UzJNZStBT29iYmRXZDg1SW9Rc0pM?=
 =?utf-8?B?eXlTZmNMZ3hMcUF4RWdNZlYvaWpnb2hhQmhtS0JyNlZVNUU4TEg3N3N5ZnFm?=
 =?utf-8?B?ZWFsQnZpQ29GL3RXblVNTmovVjVtT1BnY0VkMmlyaDBvdWUzdld1YmJkUlRM?=
 =?utf-8?B?Y2tCZHpNRnlzeWo4bEttN2VmYlZnekNleGJDd01mUTU0QWltZkpmdmx0L1V0?=
 =?utf-8?B?eVpPbDFKdG5zb3l5L29LLzU4VGROdzRkU3RBZTRJdER3MFlFRUZ3R0dJSm5G?=
 =?utf-8?B?SEM3Z1VXOWNET1FLMWNjdGtRN09tSEd1R21VQ0MvYVp5aER1ODdBNElXQjdJ?=
 =?utf-8?B?aldqQ1JheHk4K3dkRWJEYlFMNFhGTjdrQnlFY2pUa0J6S3RTdFJNdk8rNnIw?=
 =?utf-8?B?Z3VqenRPZFZzRDdWaHkrUDhReGRSbFVSTjVuaU1xaWJKbUZrdVk0ZDVYbW9n?=
 =?utf-8?B?YXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a749a8a-6005-455e-4cec-08dbbf3e39ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 09:43:38.0412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IoeRHKY5zurVeFu8S6qBfu+C1G7zOUUtbZaLp6AibTf8G++RpeTZmxgh9mY1fiZCnjKXy/m+saXoGcu663qnbNMaaXXHOHwJ+am4Zl4ffz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11454
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgeW91ciByZXBseSENCg0KPiBGcm9tOiBHZWVydCBVeXR0
ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEv
Ml0gc3BpOiByZW5lc2FzLHJ6djJtLWNzaTogQWRkIFNQSSBTbGF2ZSByZWxhdGVkDQo+IHByb3Bl
cnRpZXMNCj4gDQo+IEhpIE1hcmssDQo+IA0KPiBPbiBXZWQsIFNlcCAyNywgMjAyMyBhdCAxMTow
MOKAr0FNIE1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz4gd3JvdGU6DQo+ID4gT24gV2Vk
LCBTZXAgMjcsIDIwMjMgYXQgMDk6NTk6MDVBTSArMDIwMCwgR2VlcnQgVXl0dGVyaG9ldmVuIHdy
b3RlOg0KPiA+ID4gT24gVHVlLCBTZXAgMjYsIDIwMjMgYXQgMTE6MDjigK9QTSBGYWJyaXppbyBD
YXN0cm8NCj4gPiA+ID4gKyAgICB0eXBlOiBib29sZWFuDQo+ID4gPiA+ICsgICAgZGVzY3JpcHRp
b246DQo+ID4gPiA+ICsgICAgICBVc2UgQ1NJIFNsYXZlIFNlbGVjdGlvbiAoU1MpIHBpbiB0byBl
bmFibGUgdHJhbnNtaXNzaW9uDQo+IGFuZCByZWNlcHRpb24gd2hlbg0KPiA+ID4gPiArICAgICAg
aW4gc2xhdmUgbW9kZS4NCj4gPg0KPiA+ID4gQ2FuJ3QgdGhpcyBiZSBkb25lIGluIGEgbW9yZSBn
ZW5lcmljIHdheT8gSSBoYWQgZXhwZWN0ZWQgdGhhdCB0aGUNCj4gPiA+IGV4aXN0aW5nIFNQSV9O
T19DUyBmbGFnIGNhbiBiZSBzZXQgdXNpbmcgYSBwcm9wZXJ0eSBpbiB0aGUgInNsYXZlIg0KPiBz
dWJub2RlLA0KPiA+ID4gYnV0IGFwcGFyZW50bHkgdGhlcmUgaXMgbm8gInNwaS1uby1jcyIgcHJv
cGVydHkgZGVmaW5lZCB5ZXQuDQo+ID4NCj4gPiBUaGUgZGVzY3JpcHRpb24gaXMgY2xlYXJseSBz
YXlpbmcgdGhlcmUgaXMgYSBjaGlwIHNlbGVjdCwgX05PX0NTDQo+IHNlZW1zDQo+ID4gZW50aXJl
bHkgaW5hcHByb3ByaWF0ZS4gIEl0J3Mgbm90IHNwZWNpZmllZCBpbiB0aGUgZGV2aWNlIHRyZWUN
Cj4gYmVjYXVzZQ0KPiA+IHdoZW4gdGhlcmUncyBubyBjaGlwIHNlbGVjdCBmb3IgYSBkZXZpY2Ug
aXQncyBhIGZ1bmRhbWVudGFsIHByb3BlcnR5DQo+IG9mDQo+ID4gaG93IHRoZSBkZXZpY2UgaXMg
Y29udHJvbGxlZCBhbmQgd2UgZG9uJ3QgbmVlZCBhbnkgaW5mb3JtYXRpb24NCj4gYmV5b25kDQo+
ID4gdGhlIGNvbXBhdGlibGUuDQo+IA0KPiBJbiBob3N0IG1vZGUsIGl0IGluZGVlZCBkb2Vzbid0
IG1hdHRlciwgYXMgeW91IGNhbiBoYXZlIG9ubHkgYSBzaW5nbGUNCj4gZGV2aWNlIGNvbm5lY3Rl
ZCB3aXRoIFNQSV9OT19DUy4NCj4gSW4gZGV2aWNlIG1vZGUsIHRoZSBkZXZpY2UgbmVlZHMgdG8g
a25vdyBpZiBpdCBtdXN0IG1vbml0b3IgdGhlIGNoaXANCj4gc2VsZWN0IGxpbmUgb3Igbm90Lg0K
PiANCj4gSW4gaGluZHNpZ2h0LCBJIHNob3VsZCBoYXZlIGtlcHQgdGhlIHF1ZXN0aW9uIEkgaGFk
IHdyaXR0ZW4gaW5pdGlhbGx5LA0KPiBidXQgZGVsZXRlZCBhZnRlciBoYXZpbmcgcmVhZCB0aGUg
ZG9jdW1lbnRhdGlvbiBmb3IgdGhlIGNvcnJlc3BvbmRpbmcNCj4gUlovVjJNIHJlZ2lzdGVyIGJp
dHM6DQo+IA0KPiAgICAgV2hhdCBkb2VzIGl0IG1lYW4gaWYgdGhpcyBpcyBmYWxzZT8gVGhhdCB0
aGVyZSBpcyBubyBjaGlwIHNlbGVjdD8NCg0KWWVzLCB0aGF0J3Mgd2hhdCBpdCBtZWFucy4gVGhl
IElQIHdvdWxkIGp1c3QgdXNlIHRoZSBjbG9jayBsaW5lIHRvDQpzaGlmdCBkYXRhIGluIGFuZCBv
dXQuDQpDbGVhcmx5LCB0aGF0IGNvdWxkIGxlYWQgdG8gIm1pc3VuZGVyc3RhbmRpbmdzIiBhcyBj
aGFuZ2luZw0KdGhlIGFjdGl2ZSBsZXZlbCBvZiB0aGUgY2xvY2sgbGluZSBvbiB0aGUgaG9zdCBz
aWRlIG1heSBsZWFkIHRvIA0KZXh0cmEgY2xvY2sgY3ljbGVzIGludGVycHJldGVkIGJ5IHRoZSBz
bGF2ZS4NCg0KPiANCj4gU28gInNwaS1uby1jcyIgd291bGQgYmUgdGhlIGludmVyc2Ugb2YgInJl
bmVzYXMsY3NpLXNzIi4NCg0KWWVzLCBleGFjdGx5Lg0KDQpDaGVlcnMsDQpGYWINCg0KPiANCj4g
R3J7b2V0amUsZWV0aW5nfXMsDQo+IA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBHZWVydA0K
PiANCj4gLS0NCj4gR2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBMaW51eCBi
ZXlvbmQgaWEzMiAtLQ0KPiBnZWVydEBsaW51eC1tNjhrLm9yZw0KPiANCj4gSW4gcGVyc29uYWwg
Y29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYQ0KPiBo
YWNrZXIuIEJ1dA0KPiB3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkganVzdCBzYXkg
InByb2dyYW1tZXIiIG9yIHNvbWV0aGluZw0KPiBsaWtlIHRoYXQuDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMNCg==

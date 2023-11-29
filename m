Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28F57FCCED
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 03:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjK2CeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 21:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK2CeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 21:34:11 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DBE1707;
        Tue, 28 Nov 2023 18:34:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7tJgPSMRrqdnvmW7OUKJfM56/eTlsQO10xblyRy1Dk4wnPfrW0Y0Fwz6O6SJ7/+Dzd7MILp0BWIZZnPmEpWP7GFIyiNmj7/rx8TTYkvdQx2EbpIYtx8QfTvlHjQCGv0BeSseTw5LcbvCvVk/SknPYj+/f5+zWVVV86n//6Uz1JBtSofIlheLIrBuMOujLlfqqpPiid4j3h1QjDwYc7NsC55SB1YFyUplKFhu2DD3vUxpFD6ODNIzEReE6GK+sr9H6ueQOUHg+hlutRClLgVduL1KaoEZu2Zn3IXw+0jTDx3PTVZDv/AcFkkGfr/2qjnmvl8gkVpyGhFLu9HW6O/Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0f9Sk2YET84xSmE8/cbON31S2bA9Bjl8qh00i5LE1K4=;
 b=ANd4OkNhhLsL59LVhYjMp0LQhsIjZsrglnvzc/AtYhakRK00KcyTbbNSKWhzBRIHMzx1QtH7klfqf1iOZSoSmi87bIOh4CtsW9OXAuhR+nW1/5Fjia5s5GaLYEaqP2ok1V0SZKdghisTOzZEsbWBUcRuW/MP7wFjE3Bjqhxk+Qdo7hHdfluFE8TkXQXyw3meffvFPezMcB3VHh7L4pXbd8iXo6DwizSyrFIDStQpFYDzKiYxtw2OooLOEtyAWsxXj2OahLtC+iAGoa63bt0dyx+/0nVi7mhv/pSHZvJoA3MJhPlBlamlRBuRa/vp9QmmoMz4iPj7006XTr1LZiUw1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0f9Sk2YET84xSmE8/cbON31S2bA9Bjl8qh00i5LE1K4=;
 b=bHFiSXVivDwQ4nThPEZh1Y5l2lt7z7x6HmaOmC7w7gH+Kt7FrLYHVZxSdv0cglWZuASjdY4aKY3FjOn5JjdR8DxB3omwTcNVSDr/DecQlsuSF9kuC8OcZb9NhixzapM43ZXahBLcSqzXp2Pg9JVgj1JTBH/KcDhPp+l6GqO5nYs=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by PAWPR04MB9840.eurprd04.prod.outlook.com (2603:10a6:102:387::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 02:34:14 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::d6ee:d372:176b:1786]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::d6ee:d372:176b:1786%5]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 02:34:14 +0000
From:   Wei Fang <wei.fang@nxp.com>
To:     "hs@denx.de" <hs@denx.de>, Andrew Lunn <andrew@lunn.ch>,
        Heiko Schocher <heiko.schocher@gmail.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: RE: [PATCH] net: fec: fix probing of fec1 when fec0 is not probed yet
Thread-Topic: [PATCH] net: fec: fix probing of fec1 when fec0 is not probed
 yet
Thread-Index: AQHaHhDbUperEy/doEePeDuPcgDZAbCIVceAgABn4yCAADHNgIAAA0AQgAY7hoCAAWymoA==
Date:   Wed, 29 Nov 2023 02:34:14 +0000
Message-ID: <AM5PR04MB3139190E26F6948EA1D72CC28883A@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20231123132744.62519-1-hs@denx.de>
 <132aca53-6570-41a4-b2b2-0907d74f9b31@lunn.ch>
 <AM5PR04MB313982936800424F9B2E660688B8A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <227dc52c-c555-34e4-d534-1a749af15425@denx.de>
 <AM5PR04MB31395DCE58A5312BD4E8A67A88BDA@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <af87e335-e6f2-7ffd-ba19-22289558819e@denx.de>
In-Reply-To: <af87e335-e6f2-7ffd-ba19-22289558819e@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|PAWPR04MB9840:EE_
x-ms-office365-filtering-correlation-id: ffe94c8e-d72d-4e97-d398-08dbf083ad3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /WgJpGBo7IOoR66iGGj4LjJZiYsOqMuo2CN+hDITAY/U9RJxSTfjjgbo1a21wJr/AzBJWtUdi6Uulyiw7T7c8gDKLUAt7Ejo6elS+ErhX6xOpiTOHSC1b2QLx4ZnqoESm1n9QIbz9WHHwCZ6wg0R3fh2CTrc4bmhuULkeDSuhf+6SW4VQ6kLRt2WwhKL7bvQrfRYx3LbnmDIUXQ37foBwfApiuLr62vcHqmJBm/LYsZEUKo3r7sm0IP4ZZzli1uJDw5HEZl8ED5jrLrC4bX8sPLeQxOU61p+pFzmATOgrrJ41ELL8+kSwxOrC4vjPsVajqgA7SQk1QZp6FF2IK4aNUpXZ6nllti9vNKgNSLPOvUHwP3VwSpdImD/LT/Ov2BWkjYx61CLtm/pBdDUTQvUp0yptXiFRlaEFfHHXMHgNYpdxlkEj3Y1Hsni3BxthJedARuD3gv+iVx/A9yr34M0HL9v1vMqFHFqYqRMY5yCLSAn90Vthn2jJd5SDQde8ifz51HE+ep6DinnlLoEvgANG/LMTIEF5A7EOXRmmRnglc2tJtgAikeXvEdGNiRYuAqhQOvSyZ2k/Nso9uKtWzbXSKN5d24p/lGPkCzy73rBZ0nGAsAvcQMGF4eEI+oBr1O2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(376002)(136003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(66946007)(54906003)(66556008)(66446008)(64756008)(316002)(66476007)(8936002)(8676002)(4326008)(52536014)(76116006)(478600001)(110136005)(44832011)(7416002)(86362001)(2906002)(5660300002)(41300700001)(122000001)(33656002)(38100700002)(6506007)(26005)(7696005)(9686003)(83380400001)(71200400001)(53546011)(38070700009)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?MStTREY2UXBqVWMyMCtxZlFUZkUzK2RSSGI3SWwwY2V0dmtON0Q1cmhlRHVY?=
 =?gb2312?B?ZHFJSnc4Qm5McGphcEhGMmdIRWszOE1pRVFJUHlvdEZpbE9vcTdMeTh3bEhX?=
 =?gb2312?B?Q0dVakhXOVZ6bmhIYVBjazBGSTFhbGhkUzFkdnpodk5qcEszNEo1UmZhNWpz?=
 =?gb2312?B?dG9ySUxyODhJbEdkQXBidHY0VFhiNCtoSjhRVm9UVEhjMFRTaXFnUjJuaStw?=
 =?gb2312?B?dytxVG1oNnd0SjdLcVRJbytPa0xpOEEzcXVGQThWZ2dSc0t2TFhtdWl6RmtJ?=
 =?gb2312?B?MDFzMzZXaTlLVHUxT0RZTFVyZmlOdTdKWVZmSUg2T0cxNWdEeHkreThWWFVG?=
 =?gb2312?B?d1dBVEZ1SzlDWjJLWWpidnUvd3JsaERZSmRJTExJWnEzcDlsaS8vMlVWT3lM?=
 =?gb2312?B?MVBVSXk3QkE1L3g0SkdMZ1BKanRFL0E4emhHMFZaanpORVFoT2g0QmhSQ1Z1?=
 =?gb2312?B?SmNqNWp2ZXRyb3lIUzFXWWt1NlRySnZvV0x5cHExTzlWMnFCNW4reklIVGZG?=
 =?gb2312?B?M1FXSDRWQmdnYTgzdzJ0eFNjbng1cDhEK1J6NHhVWWRKV1NrSnVmYmtGMUJm?=
 =?gb2312?B?K2xCcTNVeFhRTHIrdHdjMW5jakQ4UElMSERSY2k1M2JpQ0IwaHNmbGUvYXk0?=
 =?gb2312?B?QXV2MzBpUzBEbSsxR1dPa1p5akx2RmdaQktmaWxSZDc5cUJGd2tJMWd6YlJv?=
 =?gb2312?B?MVg3YW80aUhnZnAxc3MvbEpQSEdMSnRJbFh5QkpjK296clljMnVSV0VlM3Jh?=
 =?gb2312?B?ZHd3NExROC9XN1BxaTkraGN1Y3dXQUg4MGl0Y3EzbGJYMWNRZWtVTXRpSFRJ?=
 =?gb2312?B?a1FLLzN3dTY3cmFPbEdoOWVjRm5aRzNYTG1xM2hEaGcxM2ZMdDg0TXB6ZU45?=
 =?gb2312?B?b3lRaE56YWdpb0xxZUh0WitDc211N1ova1VZMlFMSDhrWjRVY0tLU0NUWFZa?=
 =?gb2312?B?S3RPd1dVb04rTUd4cmRZc3pmVGUvTHhqQnV6ZUx5OWZhUjZEYUVhcks2alEz?=
 =?gb2312?B?U0VDanQ4RUE5dW02MnBpOHBXQ3dQa0RkUzRidnY5OWhuV1kzVGk1Y1M2ODNi?=
 =?gb2312?B?RUNiWS9rNFRYaWpIdmgrcWozdlBVbW1IL3RzMmNIQUtYbzVkdkhOcnhLZ1lO?=
 =?gb2312?B?SnFIRGxjMVFTWEE1bHhDc0dROVhoOE8vZnFETENEVGlob3RGbEg4ZzBiTk5D?=
 =?gb2312?B?L3R3a1dxZ2RiL0RmMmMvRm5YRXd4QlZmTW5zVmw3UHJPbHh2WUxJY1ltNWpH?=
 =?gb2312?B?QlluVTRpWlQxK0xRcXBDTStCWUxPTmdVWU9mYm1mVGNkbXI0emp5YTVYbDFZ?=
 =?gb2312?B?Nlk3Mjd2MW53Q0hyQ1RaU05EbHY3Qy9jcUNVK1RGRFNnd241QTY1UFduR2dG?=
 =?gb2312?B?ckx2azFFNmhReFNSOGtmT3BpMHNZQnl3ZmRyZ2FiUTArM2h6c3pQREtmb2tj?=
 =?gb2312?B?NnFibzh0UGw4VnU0TDFEWDczcXZ4eFp0UVhKMW9yeWprR2JHQXBZYmFDZU1u?=
 =?gb2312?B?T2JFR1UwSlRtU0tiNkxld1pSUDBJVC9rS3JDaEtoMThDSklXMkVRaUl4dzN6?=
 =?gb2312?B?bTNMTDRKZnRQYzlTMndHcFluTU5tam1XVEJSTTJwYlhCU1hQMVBWZmxBWVRG?=
 =?gb2312?B?bzA0RWVkMk9MRWZzT08yN2dINUQ5ODVDbDNJRnFtYmFkdE45OHdlTE9udlgy?=
 =?gb2312?B?eEhEeUVWTHUvYUxkTFZpY1pYQXpzQWZBblJzY2h0OXVUSTFCUENvOXliY3JH?=
 =?gb2312?B?Z1AxTGVNVDFjNE9RQjhvVTdITTdGdTVZSC9hL2g0N2V3RXc0ZWl5THlUYjV1?=
 =?gb2312?B?eHI4dzBXLzhVc24xTCtsTHJoSEJheXpqeEo0RldGTUFnNGxaZzl1dW0rS1BC?=
 =?gb2312?B?N2J2L0VIOEp2RHE5aC9SSXdOY2k0cXhSeDlTM0FFVUUwNWZtSEVoVXp4UWwy?=
 =?gb2312?B?ZlFpOXZxQTNiVG9jQks3aE51OHZNMTRPT2pQSzJyWkZybFcyZWtkNTl1aU5C?=
 =?gb2312?B?NTgxNzFkS0xsZmZmd09FcXIrdWN2S3M3Q3M2Z1RIZUVsTU9Vdi9LNkViOFVZ?=
 =?gb2312?B?MlZTNmE1OHFNcEFQQ0xjckROdDYxeEVSOTZWTkMyNENkOThGMmlaU3VkOFUx?=
 =?gb2312?Q?NzXQ=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe94c8e-d72d-4e97-d398-08dbf083ad3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2023 02:34:14.0765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M8I61lpArbrgTRl9p99zfCTSYpHQ/qhX/08ukbIUg404S2UFtsJf+gdhFMRgX27WCD8oqoc/rD2olSQydqw6SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9840
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIZWlrbyBTY2hvY2hlciA8aHNA
ZGVueC5kZT4NCj4gU2VudDogMjAyM8TqMTHUwjI4yNUgMTI6NDINCj4gVG86IFdlaSBGYW5nIDx3
ZWkuZmFuZ0BueHAuY29tPjsgQW5kcmV3IEx1bm4gPGFuZHJld0BsdW5uLmNoPjsgSGVpa28NCj4g
U2Nob2NoZXIgPGhlaWtvLnNjaG9jaGVyQGdtYWlsLmNvbT4NCj4gQ2M6IG5ldGRldkB2Z2VyLmtl
cm5lbC5vcmc7IENsYXJrIFdhbmcgPHhpYW9uaW5nLndhbmdAbnhwLmNvbT47IERhdmlkIFMuDQo+
IE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29v
Z2xlLmNvbT47DQo+IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBkbC1saW51eC1p
bXggPGxpbnV4LWlteEBueHAuY29tPjsgUGFvbG8NCj4gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29t
PjsgU2hlbndlaSBXYW5nIDxzaGVud2VpLndhbmdAbnhwLmNvbT47DQo+IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IEFsZXhhbmRlciBTdmVyZGxpbg0KPiA8YWxleGFuZGVyLnN2ZXJkbGlu
QHNpZW1lbnMuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBuZXQ6IGZlYzogZml4IHByb2Jp
bmcgb2YgZmVjMSB3aGVuIGZlYzAgaXMgbm90IHByb2JlZCB5ZXQNCj4gDQo+ID4+Pj4+DQo+ID4+
Pj4+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjX21haW4uYyB8IDIgKy0NCj4g
Pj4+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+
Pj4+Pg0KPiA+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxl
L2ZlY19tYWluLmMNCj4gPj4+Pj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVj
X21haW4uYw0KPiA+Pj4+PiBpbmRleCBjM2I3Njk0YTc0ODUuLmQ5NTZmOTVlN2E2NSAxMDA2NDQN
Cj4gPj4+Pj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMN
Cj4gPj4+Pj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMN
Cj4gPj4+Pj4gQEAgLTI0NDUsNyArMjQ0NSw3IEBAIHN0YXRpYyBpbnQgZmVjX2VuZXRfbWlpX2lu
aXQoc3RydWN0DQo+ID4+Pj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+Pj4+PiAgCQkJbWlp
X2NudCsrOw0KPiA+Pj4+PiAgCQkJcmV0dXJuIDA7DQo+ID4+Pj4+ICAJCX0NCj4gPj4+Pj4gLQkJ
cmV0dXJuIC1FTk9FTlQ7DQo+ID4+Pj4+ICsJCXJldHVybiAtRVBST0JFX0RFRkVSOw0KPiA+Pj4+
DQo+ID4+Pj4gSSB0aGluayB0aGlzIGhhcyBiZWVuIHRyaWVkIGJlZm9yZS4NCj4gPj4+Pg0KPiA+
Pj4gWWVzLCB0aGVyZSB3YXMgaW5kZWVkIGEgc2ltaWxhciBwYXRjaCBbMV0gYmVmb3JlLiBidXQg
dGhpcyBpc3N1ZQ0KPiA+Pj4gc2VlbXMgdG8gb25seSBleGlzdCBpbiBkb3duc3RyZWFtIHRyZWUs
IGJlY2F1c2UgdGhlcmUgaXMgYSBsb2NhbA0KPiA+Pj4gcGF0Y2ggd2hpY2ggaXMgbm90DQo+ID4+
IGluIHRoZSB1cHN0cmVhbS4NCj4gPj4+DQo+ID4+PiAgICAgICAgIC8qIGJvYXJkIG9ubHkgZW5h
YmxlIG9uZSBtaWkgYnVzIGluIGRlZmF1bHQgKi8NCj4gPj4+ICAgICAgICAgaWYgKCFvZl9nZXRf
cHJvcGVydHkobnAsICJmc2wsbWlpLWV4Y2x1c2l2ZSIsIE5VTEwpKQ0KPiA+Pj4gICAgICAgICAg
ICAgICAgIGZlcC0+cXVpcmtzIHw9IEZFQ19RVUlSS19TSU5HTEVfTURJTzsNCj4gPj4NCj4gPj4g
WWVzLCBzb3JyeSBmb3Igb3ZlcnNlZWluZyB0aGlzIC4uLiBidXQgdGhlcmUgYXJlIFNvQ3MgaW4g
dXBzdHJlYW0NCj4gPj4gd2hpY2ggc2V0IEZFQ19RVUlSS19TSU5HTEVfTURJTyBhbmQgc28gbWlp
IGJ1cyBmcm9tIGZvciBleGFtcGxlIGZlYzANCj4gPj4gaXMgdXNlZCBvbiBvdGhlciBmZWNYIGRl
dmljZXMsIGNvcnJlY3Q/DQo+ID4+DQo+ID4gWWVzLCBpLk1YMjggc3RpbGwgdXNlcyBGRUNfUVVJ
UktfU0lOR0xFX01ESU8gZmxhZyBpbiB0aGUgdXBzdHJlYW0sIEJ1dA0KPiA+IHRoZSBjdXJyZW50
IHBhdGNoIGRvZXNuJ3Qgc2VlbSB0byBjb21wbGV0ZWx5IHNvbHZlIHRoaXMgaXNzdWUuDQo+ID4N
Cj4gPiBJZiBmZWMxIGlzIHByb2JlZCBiZWZvcmUgZmVjMCwgSSB0aGluayBpdHMgZmVwLT5kZXZf
aWQgc2hvdWxkIGJlIGVxdWFsDQo+ID4gdG8gMCwgc28gaXQgd2lsbCBub3QgZ28gdG8gdGhlIGZv
bGxvd2luZyBzdGF0ZW1lbnQuDQo+IA0KPiBJbmRlZWQuLi4gYW5kIHRoYW4gZmVwLT5kZXZfaWQg
aXMgaW50ZXJjaGFuZ2VkIHRvby4uLiBJIHdvbmRlciB3aHkgbm90IHVzaW5nOg0KPiANCj4gCWZl
cC0+ZGV2X2lkID0gb2ZfYWxpYXNfZ2V0X2lkKG5wLCAiZXRoZXJuZXQiKTsNCj4gDQpNYXliZSBu
b3QgYWxsIGR0cyBoYXZlIGV0aGVybmV0IGFsaWFzZXMgaW4gdGhlbS4gQW5kIHRoZXJlIGFyZSBz
b21lIHBsYXRmb3Jtcw0KdGhhdCBtYXkgbm90IHVzZSBEVC4NCg0KPiBpbiBmZWNfcHJvYmUgZnVu
Y3Rpb24gZm9yIGdldHRpbmcgdGhlIGRldl9pZC4gV2l0aCB0aGF0IG5vIHByb2JsZW1zIHdpdGgN
Cj4gIndyb25nIiBkZXZfaWQgYW5kIGFsc28gbXkgY2hhbmdlIG1ha2VzIHNlbnNlLi4uDQo+IA0K
PiBCdXQgeW91IGFyZSBjb3JyZWN0LCBjdXJyZW50bHkgcGF0Y2ggaXMgdXNlbGVzcy4NCj4gDQo+
ID4gIGlmICgoZmVwLT5xdWlya3MgJiBGRUNfUVVJUktfU0lOR0xFX01ESU8pICYmIGZlcC0+ZGV2
X2lkID4gMCkgew0KPiA+IAkJLyogZmVjMSB1c2VzIGZlYzAgbWlpX2J1cyAqLw0KPiA+IAkJaWYg
KG1paV9jbnQgJiYgZmVjMF9taWlfYnVzKSB7DQo+ID4gCQkJZmVwLT5taWlfYnVzID0gZmVjMF9t
aWlfYnVzOw0KPiA+IAkJCW1paV9jbnQrKzsNCj4gPiAJCQlyZXR1cm4gMDsNCj4gPiAJCX0NCj4g
PiAJCXJldHVybiAtRU5PRU5UOw0KPiA+IH0NCj4gPg0KPiA+IEknbSBjb25zaWRlcmluZyByZW1v
dmluZyB0aGUgRkVDX1FVSVJLX1NJTkdMRV9NRElPIGZsYWcgZnJvbQ0KPiB1cHN0cmVhbQ0KPiA+
IGluIHRoZSBmdXR1cmUgYXMgaXQncyBub3QgbmVjZXNzYXJ5LiBCdXQgbm90IG5vdyBhcyBJIGFt
IGJ1c3kgd2l0aCBvdGhlcg0KPiBwcm9qZWN0cy4NCj4gDQo+IEhtbS4uIGFuZCB3aGF0IGlzIG9u
IHBsYXRmb3JtcyB3aGljaCBoYXZlIHRoaXMgdXNlY2FzZT8NCj4gDQo+IGJ5ZSwNCj4gSGVpa28N
Cj4gLS0NCj4gREVOWCBTb2Z0d2FyZSBFbmdpbmVlcmluZyBHbWJILCAgICAgIE1hbmFnaW5nIERp
cmVjdG9yOiBFcmlrYSBVbnRlcg0KPiBIUkIgMTY1MjM1IE11bmljaCwgT2ZmaWNlOiBLaXJjaGVu
c3RyLjUsIEQtODIxOTQgR3JvZWJlbnplbGwsIEdlcm1hbnkNCj4gUGhvbmU6ICs0OS04MTQyLTY2
OTg5LTUyICAgRmF4OiArNDktODE0Mi02Njk4OS04MCAgIEVtYWlsOg0KPiBoc0BkZW54LmRlDQo=

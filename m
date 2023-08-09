Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E51D77562D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 11:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjHIJN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 05:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjHIJN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 05:13:28 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2041.outbound.protection.outlook.com [40.107.13.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441AC1FCE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 02:13:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9zA2Mgbqd4k4X8FfPEWXkEr9OO2So18PRz0qrk6PF8g/dd/Z9IcZcL1ZOjyPWTclK4PBp8AmzS7yfPfUAN8pxY1dyuX8JKC2s12iMWYxNRIjBG7HzfKEv/ARNET5bULxKxO0KyeZ1RGMnJcOL1jUbGeylQ/HXyqgIz+Sbu3GU0YPD8iq7rbYIq1Sgq6p10ygvlvY9r84146iSvZrhGsANE4+gyrcBGTjteotfSmlVZMGlV4qt7CLtidq6LKhDHmCms54SzBigL3v+CGomDoR41rdf9wPlW79cuzpFYeigN+9Era7Sq/hn4dR5dALPPqbjdNsWO4OF8jVy0zljG+Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLh5CnKuaXd2Eo9bUGz+1Z/ZhXbsQtxgeF1Qz+7+J/Y=;
 b=S60CVhXPu1S9DeXW/EnW5x7adNwzP+DtVRSiL52kZzpRq3eiYd1f8Fuh0HqjGOvABomXQEZXbt59fBejtK2hUWRuTg65cRQsVqg14lZStUGEMvx4nhyn5mI7nYBxHoC+HGUS++xbgq9lqsFmU2cfvOROkZlozucJ8jokR0dWYlwmvbXUtoIyLFRxifjV74Y+MmgnG0a5wwpp53vlPk3CdtoyFKzJ4tzhYYfO4LBvs0Evp5s2ksWKkIv5yuyZEQXcoK4Lb7k7WCMFxLj10UGd833xsEljHYDw0Y7ZH8sh3+XmlfhUzireqhHABUPgWEIuHxnTFWV1xV/qIpr3wTIQHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLh5CnKuaXd2Eo9bUGz+1Z/ZhXbsQtxgeF1Qz+7+J/Y=;
 b=Au+YY7h+AiECxtyJamzcer2+2xStsiDZ+MHJR1Nr9Os6CkvlvywFRma2RHzLGSH9Cl4K1nATG9TQk+4XucOKOTnCugnzFgPO74JdSaeYzXKyJ03yXznW1bdH7VPVM0LZ/ZhEO+c6ujvlDajsbgT/duxLp+GI1JsiFau6gGlUDFo=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8387.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 09:13:24 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6652.025; Wed, 9 Aug 2023
 09:13:24 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Daniel Baluta <daniel.baluta@gmail.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V6 7/8] firmware: imx: scu-irq: enlarge the
 IMX_SC_IRQ_NUM_GROUP
Thread-Topic: [PATCH V6 7/8] firmware: imx: scu-irq: enlarge the
 IMX_SC_IRQ_NUM_GROUP
Thread-Index: AQHZySgh78vDVR3C9k292DPgLsVv7a/hl9AAgAAXe3A=
Date:   Wed, 9 Aug 2023 09:13:24 +0000
Message-ID: <DU0PR04MB9417EFD2165AC7B5759E6C098812A@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230807121432.3970610-1-peng.fan@oss.nxp.com>
 <20230807121432.3970610-8-peng.fan@oss.nxp.com>
 <CAEnQRZBECPn+JC1PF6hvvroZZBzuVXTU2Zy+Kc_giKsFUFQxVA@mail.gmail.com>
In-Reply-To: <CAEnQRZBECPn+JC1PF6hvvroZZBzuVXTU2Zy+Kc_giKsFUFQxVA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB8387:EE_
x-ms-office365-filtering-correlation-id: b19eb8eb-2dc2-4cd7-0627-08db98b8e287
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oIos3iT9bsLXAXru/Htyyo4Iw9FXNCUx789kfPjSIUjMCT/NDhg922ljhyhw53g2z6DZgsLw/7EdHXx3W8SxDT4yWB+2BtInqwnUhMXzZExPTreLIMUFY1xMeGrNCxAqt5LyqXhHNDjAl7ugTe6ia+fYZ0KUPTLC++VJPug+D4Ok5ApoHJCvdIzYLDld9q+SazZ71b1zlMR5qn4MytlVRci19w5qLGzWclnnWhwoe+EcyyO8LjG9Z+MAKjIvJQlyNjQAX3An4wK0hkoEt/HJzvL5e+SkfvOIsKsW/vHc3TEWPHMN4eHoQIT3b8VTgSA7ghOHCzNgrvdv5WiehHdeZMbdX4sVhNQI9rFKwmq/2AsWxLGr45glI6Y9sCpTIUslLtkBlcBIdmXEGYF5mcvTAxM+b4e+BqpO3tML4fxCOlsZvS/3f5P23ta/hlmaNVotXYnHkxorIe/RpAjjD/AF7AjhXgE0LDRVq4o3heQYRGHqOMk3pifAt1a2WIRi8PyHReDMZAXqDvB7MhXnVMrLjTxr7H95zQtOyQq3zGzKtvAnl2UcY04zN6NV5ScuOUdptGlu87A6VU3LHD88nHGkAUiKBywgwUXjPd7uxWycmDsU7NVot95o340PpsaSGr6RKnb1D2jtx+yqRwAyFpQRmQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(186006)(1800799006)(451199021)(54906003)(9686003)(110136005)(71200400001)(76116006)(4326008)(478600001)(66946007)(66476007)(64756008)(66556008)(66446008)(316002)(7696005)(41300700001)(53546011)(26005)(8936002)(6506007)(8676002)(52536014)(86362001)(5660300002)(55016003)(44832011)(33656002)(83380400001)(2906002)(38070700005)(38100700002)(122000001)(147533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1kzaEtVNERXY2ppZXQ3R1ROamJLQVRKbmNxa2dORU4yUCs2VjBYMHZVTmUw?=
 =?utf-8?B?VWtuQmg0aHc2dHhEaDBJcHlXa3g4bXBBbW1yMmJhRTFaSUc2OGM1MVZnUHpO?=
 =?utf-8?B?REorZ0twSzd2R1VicmxGOGZ5RW1oSXdUZHlUUG5FVTNob3BMOFh2allYbTlj?=
 =?utf-8?B?eFRoQkxMUUE0RHBPWld5K2pYVzFLMVZBOGUwUHh0eTVGSHByL1h2dlZLT3hY?=
 =?utf-8?B?RmZCTUdERHdzU05XTDRuWWVSbEFWaFI1WUk4QXFHQ3MvZFR3OUhQSGIyNlU5?=
 =?utf-8?B?NkpjQms2VUFpb3dobGgvd0RubkJuMkRDaFd1Y21oWlk3MWN0TTB4MFpIN3dK?=
 =?utf-8?B?RVVDc0FveDRUQjdyMHhSSDlUV1lHOS9vU2xENlpCRmo4bFozbzVPdlFGK2tU?=
 =?utf-8?B?cUV4b1hqYk53T3BSR2plZ0h0U2xWU2RGMjNTN2RZUkl1ZG5Zb3Fyb0FkSG5E?=
 =?utf-8?B?TlFNQWF0SEZqU2lHM1Fha1J2MmNaSEpyUXU4c3FYZU41VXFKMy9yR1ZEOUFS?=
 =?utf-8?B?alhONVI3dERqUUFGKzB1Uk96QnAvWmZOenpXUGhIc1VaakVrbDg3aG0yQkM2?=
 =?utf-8?B?bjhmVWZwN1psMm1jV2dXZWlrSml4eXcvVm9LOW5ycGRHd3lzU09DNHNNYTdv?=
 =?utf-8?B?UGxkc0NDVlQrdm0vWmtwMHBVVURjeXl1Z3g4WExoUjRZMHllR2FzVVc4WkNF?=
 =?utf-8?B?d09taHdIU3prclpCSkI1RDlWTC94NHI2R285eGlZRCs4OEZWSktobzBjL1Bv?=
 =?utf-8?B?dnkxaU04WWU2S1ZMa2pGT3Y0bmJCRUFGdUttZ24wU2hOb2pVUE5weU1oZ3ZE?=
 =?utf-8?B?TjVZcHA4ZTltZVF6NmJHSkxVWmVYSXdrWUhTeWpiTFVZNEcvaXd2WHNIcVJy?=
 =?utf-8?B?dWdPek1uVTBERURMclZlaTBoQ2dOS2Q2enJCQ1FIbWQ0cGxJK01ZRGhrVStR?=
 =?utf-8?B?SXVlSWViYTdEUHhiMVBCMENLdHJZY3Jxbml2UEU3Y2RENTdNVGJnbTlSUXF4?=
 =?utf-8?B?akdHRGRoalo5NkZKakl6M0YvNjMrK0ljQWQzdFFza04xWXlHNStMaGRpck4z?=
 =?utf-8?B?eVhTSnZ3enkrR2hIZ0dNYUZDQk12QXhab0lUWVhEMlJ3WU50RFVWWjYrZEZh?=
 =?utf-8?B?dWpKbEtTdlFURnJUNTZuNFo0ZzlQcWRVWEhQTFoxeU8ydWgvVzZxMWRFL20r?=
 =?utf-8?B?MytobzhKWHRPQkFaWFMvUHlXSldHSUVMOVkwU29UWFpKTDVsdUFmYk5KME5E?=
 =?utf-8?B?b1o3TGNMc0xhNmJ3SjJwU1ppTEJxdytyQ3drTk03Y21JYWcxY1BMZjNLRVBZ?=
 =?utf-8?B?L01zakNEeVdpMkYrelFVVmY5VXpja3hEWUNxQXdzTDVBeW1yZm53bUo3YkNj?=
 =?utf-8?B?SGNGRnM0WThJeGcvWVh3WjQ2eXk2YW11RXRYRjBpRTA4eGtCZTlPdGlhcCt4?=
 =?utf-8?B?ZFRMdUEwYWtoTDV2Y3FLOXZtSDNzTXRWVzNzRlhnWmd5OHhKZGVDWG85TTRW?=
 =?utf-8?B?WlZWRjlhaGpjcS9qRExJT21vNU1vTVB5anh0SlRZTEJKT095WU16QnIzc0tX?=
 =?utf-8?B?NGxBUG5kdzBQMkVKdThYbU5qcDJraEdScHQzMFE2QXFpQUs4ZzNxeFkvMHQ2?=
 =?utf-8?B?UUtpLzl1blVBUlFqcGt6K2NqUDJ4ei9IVEVvTUR0bVoxYXhMNlpmelVacmto?=
 =?utf-8?B?QndwY05sR1M5M2xuMlo1SG5qK1pkZEEzMVZvNG4wZkxjMkpKeFN5b3lOSlFO?=
 =?utf-8?B?dTlvOStqVHRyRnBJYUVQR21GNVdRNDR6bEp0R3hiRWlGaFNHVmp6V2xmTHRK?=
 =?utf-8?B?VEVQbUhOVVVzaDI4a1lwelFMbWZQN1VEM0RrMzJHbmNvd1ljWmNIdkI3Yk9Z?=
 =?utf-8?B?ZEV5dmRrd0xsL3JuSGVjWTM1WUJvaktIS2c1TzlwVWgySEdvOEFpMEVnTVRh?=
 =?utf-8?B?WExDU0d5T05SeXhjRit0Q3pSOUxXMXpEYlJUTmxqNmRPdVFhN21pLzdKYXpy?=
 =?utf-8?B?aEFQcXlWL2EzeCt2cDJpSDQ0VjNyUVl5UjFjUjM2ZG1xTmRjOFkrYXJwc05G?=
 =?utf-8?B?NW1kOE0zRkF0dXVZZ2xCSE1KUFBudWxGZ3BNZzFab3VsNVd3K0EyK3NBWkVN?=
 =?utf-8?Q?1wwg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b19eb8eb-2dc2-4cd7-0627-08db98b8e287
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 09:13:24.4858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MH+w06Dv6lSYxKUi7+VVGy2LSbs/7d9LhIEOFQMAmkx/7NuPrRRzY35uyH21uCPdB/TW/0xVmyFh1zAhkpB3mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8387
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIFY2IDcvOF0gZmlybXdhcmU6IGlteDogc2N1LWlycTogZW5s
YXJnZSB0aGUNCj4gSU1YX1NDX0lSUV9OVU1fR1JPVVANCj4gDQo+IE9uIE1vbiwgQXVnIDcsIDIw
MjMgYXQgNDoxMeKAr1BNIFBlbmcgRmFuIChPU1MpIDxwZW5nLmZhbkBvc3MubnhwLmNvbT4NCj4g
d3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPg0K
PiA+IFBlciBTQ0ZXIHVwZGF0ZSwgdXBkYXRlIHRoZSBJTVhfU0NfSVJRX05VTV9HUk9VUCB0byA5
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+
ID4gLS0tDQo+ID4gIGRyaXZlcnMvZmlybXdhcmUvaW14L2lteC1zY3UtaXJxLmMgfCAyICstDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZmlybXdhcmUvaW14L2lteC1zY3UtaXJxLmMNCj4gPiBi
L2RyaXZlcnMvZmlybXdhcmUvaW14L2lteC1zY3UtaXJxLmMNCj4gPiBpbmRleCA2NTQ5ZjM3OTJh
MGYuLjhkOTAyZGIxZGFmMiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Zpcm13YXJlL2lteC9p
bXgtc2N1LWlycS5jDQo+ID4gKysrIGIvZHJpdmVycy9maXJtd2FyZS9pbXgvaW14LXNjdS1pcnEu
Yw0KPiA+IEBAIC0xNCw3ICsxNCw3IEBADQo+ID4NCj4gPiAgI2RlZmluZSBJTVhfU0NfSVJRX0ZV
TkNfRU5BQkxFIDENCj4gPiAgI2RlZmluZSBJTVhfU0NfSVJRX0ZVTkNfU1RBVFVTIDINCj4gPiAt
I2RlZmluZSBJTVhfU0NfSVJRX05VTV9HUk9VUCAgIDQNCj4gPiArI2RlZmluZSBJTVhfU0NfSVJR
X05VTV9HUk9VUCAgIDkNCj4gDQo+IFRoaXMgaXMgdHJpY2t5LiBTaG91bGRuJ3Qgd2UgaGF2ZSBz
b21lIHNvcnQgb2YgdmVyc2lvbmluZyBzbyB0aGF0IHRoZSB1c2VyDQo+IGtub3dzIHRoYXQga2Vy
bmVsIGFuZCBzY2Z3IGFyZSBub3QgY29tcGF0aWJsZSBhbnltb3JlPw0KDQpJdCB3b3VsZCBub3Qg
aHVydCBoZXJlIGZvciBzY3UgaXJxIG51bSBncm91cC4gTmV3ZXIgbGludXgNCmNvdWxkIHdvcmsg
d2l0aCBvbGRlciBzY2Z3Lg0KDQpCdXQgeW91IHJhaXNlZCBhIGdvb2QgcG9pbnQsIHdlIGNvdWxk
IHByaW50IHNjZncgdmVyc2lvbiB3aGVuDQpwcm9iaW5nIHNjdSBmaXJtd2FyZSwgYW5kIGZvciB1
biBjb21wYXRpYmxlIGNhc2UsIHZlcnNpb24NCmNoZWNrIGNvdWxkIGJlIHVzZWQuDQoNClRoYW5r
cywNClBlbmcuDQo=

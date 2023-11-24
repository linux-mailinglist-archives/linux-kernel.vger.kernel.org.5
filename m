Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6EF7F6AB0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 03:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjKXCdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 21:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKXCdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 21:33:11 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2087.outbound.protection.outlook.com [40.107.7.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D9410D3;
        Thu, 23 Nov 2023 18:33:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxPvNrDpM1dXhTVdLTWZGa7oFTJYO39Xq7aYQkWhA6xYPqDVlYtHo+QqZjx+dhbyLVWs2kk9Nv/3A4NYjrwbiRTNKUo4TNYRTtuNiQQbbIaYESnUaZEB8JVtdMM9zMTuYrqGI/RFLWk199csNAy8ytV9Gg35Q9Tux6JJbSh9hUbc53ktxCxO8/0Ek9MU1c5gsrD60j73kP9lTTYqoRK/mdsSPxeMn55qwiax8/hLNLj4YdHFUx8Ao2d7DHs8TV1wzG8A2yAChJUXAUoUOOi4luxNuJo4DjU+5m1xovkdOpGZmyRWM7jBj9imL5DCmC9fBZ7ZBOliO0K1cKsdQrG1HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nF9lyp0TUHrrSjNonmnvrblBMkLwRxqyoeKtXL+PMe4=;
 b=OId4svrL7VGbYqhsOUzxsgMql/eocfXbEkmCe/RcVivePtiPq7+z450cYlxfHt5J8YjxDi7NHPqxdktwR8evIUAI9Yxc3BZAJiYtCU3aTQVqhz/5vcH8Zcy4aGm9b8xgdc1piyJPiye8AvKX4LTc6mCbZLKQuaa/Rxl+2xLSJBYEVY5PcQ3QOlo6ALn6XKST8e5dhYYFr4akULLMAE6cEV+gwbd41ZzcouFVBudGW+4qfd17j0GifgfI25WTR2lO769ovFSqiDnxWmIAX0JKnXfmxoCG04nNG9wJO/aXMoYeXA36phKBlXWiw8OR8Gn3fvBjmU4GkPvwErGONzGNqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nF9lyp0TUHrrSjNonmnvrblBMkLwRxqyoeKtXL+PMe4=;
 b=ZBYMy+qXVeMSjX62Szo0YKRfHOLlEc6SqbbNLZxNi4C3kb5M5sMQyyyvHZHnjN8KUvI2vOcP5ebis71KsxYIVQwN9FEy3HCesZJj13h1zQnTSpVN99Wcdw4wlnLHDV76N7EoabAnY7HKNcHBGIX9w6CTQAmKXo3TFP/fPvn0Md8=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by DB9PR04MB9356.eurprd04.prod.outlook.com (2603:10a6:10:36a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.14; Fri, 24 Nov
 2023 02:33:14 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::d6ee:d372:176b:1786]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::d6ee:d372:176b:1786%5]) with mapi id 15.20.7046.012; Fri, 24 Nov 2023
 02:33:14 +0000
From:   Wei Fang <wei.fang@nxp.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiko Schocher <heiko.schocher@gmail.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Heiko Schocher <hs@denx.de>,
        Clark Wang <xiaoning.wang@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: fec: fix probing of fec1 when fec0 is not probed yet
Thread-Topic: [PATCH] net: fec: fix probing of fec1 when fec0 is not probed
 yet
Thread-Index: AQHaHhDbUperEy/doEePeDuPcgDZAbCIVceAgABn4yA=
Date:   Fri, 24 Nov 2023 02:33:14 +0000
Message-ID: <AM5PR04MB313982936800424F9B2E660688B8A@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20231123132744.62519-1-hs@denx.de>
 <132aca53-6570-41a4-b2b2-0907d74f9b31@lunn.ch>
In-Reply-To: <132aca53-6570-41a4-b2b2-0907d74f9b31@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|DB9PR04MB9356:EE_
x-ms-office365-filtering-correlation-id: 147d3b4e-6305-40a0-73d1-08dbec95b584
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BCMW5HtFlF8wq/UsXxwqDzU341+MU/azmRGpM0AJRnlIQxpNP8RcDHioh43jsXMARUwiQvMTccMzN5y20Eh2UNtMSsKxrnrvx+9Bpey7rqRtVOJTq1uH/0SKSTg9dwS0QfVPkCqFPSeWuCCaa6yP8fh0RJ7RCzaFKVc94UhVVZ62roVAl/RtW0MvZgBc4WWmKpMGUgfiHQ28JvfgvaNEJ/aRD/5W399K17VHll2UKLDuuvd3z6S1BsdH7uwjluw5pTq2J9/eqrqn0WR02h7GU80EUqFwBAAmsMmUlMNTb7CtxKuaLr+Ql/JPMCX96DBgqbRS3kRTq09BvDd4GVdViIcSVBjgbZCZXpSQNobt0w7j5sCbwZCdukZELF2zKv8xpGfT4xLNhr+mAOd7N2tOb122nCB9R+cIZBOlbEsIo/s1j9ZWhJfdbc7FJm31uEVZTKSJSRGLtFVM4ZE/jUOKuZyDJdWvP/kbFaWjHqX/JGZz/Vh8z+S1mjUDAjXCguHaWxDMYNYnkRXD3TVeJIZjFKscAGv0s4itwAxci6/JND6oJzP57ldsYi7jW3OJNSAm7C3uAqGFJESxEEPh7Kem6EhxGPUyYpw7isqa4w3+g5g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(136003)(366004)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2906002)(5660300002)(44832011)(38070700009)(122000001)(86362001)(33656002)(41300700001)(38100700002)(26005)(76116006)(66476007)(66556008)(66446008)(64756008)(9686003)(66946007)(55016003)(110136005)(54906003)(316002)(7696005)(71200400001)(53546011)(478600001)(966005)(6506007)(4326008)(52536014)(8676002)(8936002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?eXpXTWZ5dWZZbXJTaDk5WEpBTmg1eUZVY01UeU50Y1ZpWVBRbjFsUEcydEZv?=
 =?gb2312?B?RHV3SDhiL2ZMTkQwNVV6ZW1jc3hOemVLOVRuaktURDg5ZFp4NzQ4ZVNDUjRE?=
 =?gb2312?B?TDJ3ei9iKzBnREVucC9VaUFZdG9HR09CbDdNeFcxUEowQm5pQVNTWGw4czlr?=
 =?gb2312?B?SkhUZWF5ZGswUFoxMmRKRk5xeXlOQVdJakF5ekY1VW5VN0RNL1ZPY3dWL2NN?=
 =?gb2312?B?SVF1QXVOdGRXckxwa1M0UXQ0VUpaeXNCMkszdXBhSkhmZXJ0UjdqTEVkVkhY?=
 =?gb2312?B?OFg5Q2JaMVV3QXlMM3E1bldueElYTkl1NnJrU2pKMWdCSG1zUHNYZ0FlUTRk?=
 =?gb2312?B?MlVycTlEL01Hb0JuQ2lyK0dTZnJ2Zm9vdHR4ZzN1UnVhU3VwUXdVdU52Y243?=
 =?gb2312?B?WmJ6ZGtBNXZZNVM4QzdIUkthdXFGakxEUC8rdXZrNWxaQy9pRGo3QXV5Uk1o?=
 =?gb2312?B?Q2JKSStRd1lpa1lQQUpVZnBJU2cxRytjVnBKTkVoVXZLWGxPMjh6VHh5RDcw?=
 =?gb2312?B?QzI1VEc3SDdnZHdWbXFod09rRTQzb3Nwd0Vkb09SZ2J0enVGL2tXWFRMY05r?=
 =?gb2312?B?aWZ0U0dpMFlSdlh0bVBNUUlFWDhjTTVLdG5BYW5IbVhRTTVkVjhhcUkyazhw?=
 =?gb2312?B?bXI0QzVmTDBkU1VGdktkdFQ5akVHUzZnM0NieWpxZjBOUXppR3VGdWV3ajJK?=
 =?gb2312?B?OWsrV3VmbjVWUHA2Zmtndng5eXYrZ0JZYU9mak5lQmJwck4rN2x4KzdtVVpD?=
 =?gb2312?B?cFh6YTE5dXdjSWNGc3BkYld0b1hKd25tUlJBN0NzcVcwRGhXNStob0Vma2s1?=
 =?gb2312?B?Rm9kZGN4L1dJaWhndGdmUklZZHYyL3ZSVVNqVGN0eWFXaEhjK0N6eFB1alo1?=
 =?gb2312?B?ZlB1algzZU5ZWXNodGJhTUwySjdpbDN0OWI2YmU0SDltcFJQWWtlTUNBQUNL?=
 =?gb2312?B?K0VQV1VPa0hHU2lkR0JTKzBnayt3Lzg4SGhaY3Ewc0RlZWhzOURNanRJQlNa?=
 =?gb2312?B?bHNBdHlNSHNwZlk0dWF3NmVDOWlYRXNJRHVOQ2FPRGhZd1JUMzlJUWZmMFRp?=
 =?gb2312?B?eThLdDQ0a25Jc0ErSENzejVGdXJzSDJIRjZ2bGgxay9uUmQrbGNyS1hKSW9m?=
 =?gb2312?B?QVU1aDlYVmJEamJSUU0zMERYNVYybld3NHdKdUdRL2pFcCtlTTRhZWNKNEx0?=
 =?gb2312?B?S3pYT2VmQng1WUVIT2RvQkNmS2NkUVozQlRWSnNBTEM1YnkvazJlTGgrMS9r?=
 =?gb2312?B?MjZDc1VWaVgyK3RyM05wbk05aTRKWWZGeGdZaVdhQTZremJFUFkzVHd5amUw?=
 =?gb2312?B?Nm90QjBvUU1QdElmUXh3S2lWcFBPZytCQWVkZlhUekI4SjNrSHB5d29YSzJY?=
 =?gb2312?B?dWlGUDZtWlc3R3JvRUMvZXpueUMxcFlpVVA4NllrRXphN1NodWI5dUFtZWxH?=
 =?gb2312?B?QUlua1hVQStSQy9nb2sraVRpUUdTWWVrWklzYWhXWDdwL2E4VTZCMVBWRGc4?=
 =?gb2312?B?bnFUSy8rQ1kyMFRCTllWOWFkaFVPR2VNaXNrQ1dEZ043M0xGQkZ2cG5HYklE?=
 =?gb2312?B?dWZHSFJpaDlYZU1jS2tJUzJPdDFiaWxzUmc1M01ualBJdmx3amdxbEJKeFVm?=
 =?gb2312?B?ZWRUQXE3dlpLSytuNDBwcEtXbTVtWTRBaURTakIrQVlWNERld01pcjhLdVVq?=
 =?gb2312?B?ZUR6cGFLQjdvUCtTTEpGY0pHVW14YUs4dkJEU002NEMvTHdqaEQvcVhwTmh2?=
 =?gb2312?B?bnoyMTlQSDdQbVpMQ0FXbW9jNUg1VG5xRFBuWkZSVUg4Q0Q5cnhlTk1RWkRJ?=
 =?gb2312?B?OWtuWkJENjZOWURSSUQ1Z2xyR0E2WnkzdFNWSGJaY1dHWnR0THhhRTg3YWZ0?=
 =?gb2312?B?NjJDSG1rS2ZMdzN0VEdqVVhNOGNzRDN3S1BYWlpYcFNGcTdMcmJFWjAxSEIw?=
 =?gb2312?B?dkJGelZMSXlENTVZRXRqWTFueEl2Z2ZHb2o3dENsZjVlb0NqSnlHUGhvL3ZO?=
 =?gb2312?B?TkJVam4xcHJJaDltMC8vUmlTUTRFb0hnaXFhb2M0a01IZFEwRGJTeUVydkt6?=
 =?gb2312?B?WW9hVkFRZDJxTkhFUUplWjZIbmNQZC9EU0d4SUNFUnJVRGpyZ0hpN0hiakVT?=
 =?gb2312?Q?RixA=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 147d3b4e-6305-40a0-73d1-08dbec95b584
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2023 02:33:14.2180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0nycODaPXg+weHx9rrcY8F/oiB/ztWcIYpazi4WojyLbu1/G9diFPP13FAaD99K9LLO0m2zt+4K3VSbr2YyXQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9356
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmRyZXcgTHVubiA8YW5kcmV3
QGx1bm4uY2g+DQo+IFNlbnQ6IDIwMjPE6jEx1MIyNMjVIDQ6MDkNCj4gVG86IEhlaWtvIFNjaG9j
aGVyIDxoZWlrby5zY2hvY2hlckBnbWFpbC5jb20+DQo+IENjOiBuZXRkZXZAdmdlci5rZXJuZWwu
b3JnOyBIZWlrbyBTY2hvY2hlciA8aHNAZGVueC5kZT47IENsYXJrIFdhbmcNCj4gPHhpYW9uaW5n
LndhbmdAbnhwLmNvbT47IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVy
aWMNCj4gRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IEpha3ViIEtpY2luc2tpIDxrdWJh
QGtlcm5lbC5vcmc+Ow0KPiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsgUGFvbG8g
QWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPjsNCj4gU2hlbndlaSBXYW5nIDxzaGVud2VpLndhbmdA
bnhwLmNvbT47IFdlaSBGYW5nIDx3ZWkuZmFuZ0BueHAuY29tPjsNCj4gbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBuZXQ6IGZlYzogZml4IHByb2Jp
bmcgb2YgZmVjMSB3aGVuIGZlYzAgaXMgbm90IHByb2JlZCB5ZXQNCj4gDQo+IE9uIFRodSwgTm92
IDIzLCAyMDIzIGF0IDAyOjI3OjQzUE0gKzAxMDAsIEhlaWtvIFNjaG9jaGVyIHdyb3RlOg0KPiA+
IGl0IGlzIHBvc3NpYmxlIHRoYXQgZmVjMSBpcyBwcm9iZWQgYmVmb3JlIGZlYzAuIE9uIFNvQ3Mg
d2l0aA0KPiA+IEZFQ19RVUlSS19TSU5HTEVfTURJTyBzZXQgKHdoaWNoIG1lYW5zIGZlYzEgdXNl
cyBtaWkgZnJvbSBmZWMwKSBpbml0DQo+ID4gb2YgbWlpIGZhaWxzIGZvciBmZWMxIHdoZW4gZmVj
MCBpcyBub3QgeWV0IHByb2JlZCwgYXMgZmVjMCBzZXR1cHMgbWlpDQo+ID4gYnVzLiBJbiB0aGlz
IGNhc2UgZmVjX2VuZXRfbWlpX2luaXQgZm9yIGZlYzEgcmV0dXJucyB3aXRoIC1FTk9ERVYsIGFu
ZA0KPiA+IHNvIGZlYzEgbmV2ZXIgY29tZXMgdXAuDQo+ID4NCj4gPiBSZXR1cm4gaGVyZSB3aXRo
IC1FUFJPQkVfREVGRVIgc28gaW50ZXJmYWNlIGdldHMgbGF0ZXIgcHJvYmVkIGFnYWluLg0KPiA+
DQo+ID4gRm91bmQgdGhpcyBvbiBpbXg4cXhwIGJhc2VkIGJvYXJkLCB1c2luZyAyIGV0aGVybmV0
IGludGVyZmFjZXMsIGFuZA0KPiA+IGZyb20gdGltZSB0byB0aW1lLCBmZWMxIGludGVyZmFjZSBj
YW1lIG5vdCB1cC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEhlaWtvIFNjaG9jaGVyIDxoc0Bk
ZW54LmRlPg0KPiA+IC0tLQ0KPiA+DQo+ID4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2Fs
ZS9mZWNfbWFpbi5jIHwgMiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5l
dC9mcmVlc2NhbGUvZmVjX21haW4uYw0KPiA+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNj
YWxlL2ZlY19tYWluLmMNCj4gPiBpbmRleCBjM2I3Njk0YTc0ODUuLmQ5NTZmOTVlN2E2NSAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjX21haW4uYw0K
PiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jDQo+ID4g
QEAgLTI0NDUsNyArMjQ0NSw3IEBAIHN0YXRpYyBpbnQgZmVjX2VuZXRfbWlpX2luaXQoc3RydWN0
DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgCQkJbWlpX2NudCsrOw0KPiA+ICAJCQly
ZXR1cm4gMDsNCj4gPiAgCQl9DQo+ID4gLQkJcmV0dXJuIC1FTk9FTlQ7DQo+ID4gKwkJcmV0dXJu
IC1FUFJPQkVfREVGRVI7DQo+IA0KPiBJIHRoaW5rIHRoaXMgaGFzIGJlZW4gdHJpZWQgYmVmb3Jl
Lg0KPiANClllcywgdGhlcmUgd2FzIGluZGVlZCBhIHNpbWlsYXIgcGF0Y2ggWzFdIGJlZm9yZS4g
YnV0IHRoaXMgaXNzdWUgc2VlbXMgdG8gb25seSBleGlzdA0KaW4gZG93bnN0cmVhbSB0cmVlLCBi
ZWNhdXNlIHRoZXJlIGlzIGEgbG9jYWwgcGF0Y2ggd2hpY2ggaXMgbm90IGluIHRoZSB1cHN0cmVh
bS4NCg0KICAgICAgICAvKiBib2FyZCBvbmx5IGVuYWJsZSBvbmUgbWlpIGJ1cyBpbiBkZWZhdWx0
ICovDQogICAgICAgIGlmICghb2ZfZ2V0X3Byb3BlcnR5KG5wLCAiZnNsLG1paS1leGNsdXNpdmUi
LCBOVUxMKSkNCiAgICAgICAgICAgICAgICBmZXAtPnF1aXJrcyB8PSBGRUNfUVVJUktfU0lOR0xF
X01ESU87DQoNCkkgd2lsbCB0aGluayBhYm91dCBob3cgdG8gc29sdmUgdGhpcyBpc3N1ZSBpbiBk
b3duc3RyZWFtIGlmIEknbSBmcmVlIGxhdGVyLg0KDQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbGttbC8yMDIzMDIwODEwMTgyMS44NzEyNjktMS1hbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVu
cy5jb20vVC8jcjYzMTM4NTIwNTRiZjEyYmFhYmUyMTQxODU4NGZiYjZkNTgzNDMxOTcNCg0KPiBB
cmUgdGhlcmUgYW55IGlzc3VlcyB3aXRoIHRoZSBtaWlfY250Kys7IEkgdGhvdWdodCB0aGUgcHJl
dmlvdXMgYXR0ZW1wdCBhcw0KPiB0aGlzIGhhZCBwcm9ibGVtcyB3aXRoIHRoZSB3cm9uZyBtZGlv
IGJ1cyBiZWluZyBhc3NpZ25lZCB0bw0KPiBmZXAtPm1paV9idXMgPyBCdXQgaSBjb3VsZCBiZSBy
ZW1lbWJlcmluZyB3cm9uZ2x5Lg0KPiANCg==

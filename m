Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735E27F9A47
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 07:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbjK0GzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 01:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjK0Gy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 01:54:59 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2081.outbound.protection.outlook.com [40.107.7.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E600012F;
        Sun, 26 Nov 2023 22:55:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SujecGbndRY6mcBNUHu9+7g48xD9VBTwaiLzmREac35GLk8j0hXMLK7VawbHrhx5kzJxzyMNzCFzJMYtYqNcvWy/vzmBSDcBVfTtlHkQ8HTrB8xMxORiay+JYMI9u3rn3Qt/ftl+xbuThy6pQ2SI39xFZ3QDmV9/DQ9zfG1yCpzWXh8QMhUwM1fuYXWof05aMw7CBo1Xwnqfwr1nUe5Im8NOOlDbYJ7fA2iFpUg544F78loqmKFzwXsR45krH7WJgPAVycDhEzzRejtIft4PKaFHRaMX6hIkePr/edMS9VZaLFCV147cO6ZcLXzsXD0JEZAOxBX7TY9fr1A21Q8CTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCPCQUwqbWjQxzLrp+WLXkx4GqQ+nkOiZRw+dGJB/sw=;
 b=AVzMcQEG4J69yqXgBWRuhqB94wMYxrm9FE0XIgOjxdI9Zqjt9AevjtsfCtUuaWz/pi/B5Yc4aO+mFK6K7qxEYd4kR78QkovHYiohr47jDm2a0B9nq/dwqMwlcXMBRP+tfx8JHXyWECUXTuRGStdGT+UzyvKFxXugabHB+drJO1sINhKocUIg5ShOghXQEaVPZ+kUunKA85dCWyJI/pZEJS0lsWZJQhqFzVwvBCWuF81EJ7cTJva/5zGmkt/XU+CzTccNMlrnKRTDWEGIRTe9vhHdOHWCBuov+f5xEYuZP0eAx/3CXzuudsEAp5RWVUHSwCXp51sioAoXpjbvJl1bdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCPCQUwqbWjQxzLrp+WLXkx4GqQ+nkOiZRw+dGJB/sw=;
 b=GJz4S9M4H+jgyTFNh3Qh1u91yohKuhS3Hy7ZgWmbEUCFp7giftn29Xq9Z6brVOHxMlFiTdRpxF5a6TGVS49V/CtZuSt3zEj5X5F6a+3aWGPEb9fss/exfzGm3QDTXaUSMfcvTZmao0pST3F19yGOoN/mr7LlgMb5FIFY9U84jD0=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by AM7PR04MB7014.eurprd04.prod.outlook.com (2603:10a6:20b:121::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.19; Mon, 27 Nov
 2023 06:55:03 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::d6ee:d372:176b:1786]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::d6ee:d372:176b:1786%5]) with mapi id 15.20.7046.015; Mon, 27 Nov 2023
 06:55:03 +0000
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
Thread-Index: AQHaHhDbUperEy/doEePeDuPcgDZAbCIVceAgABn4yCAADHNgIAAA0AQ
Date:   Mon, 27 Nov 2023 06:55:02 +0000
Message-ID: <AM5PR04MB31395DCE58A5312BD4E8A67A88BDA@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20231123132744.62519-1-hs@denx.de>
 <132aca53-6570-41a4-b2b2-0907d74f9b31@lunn.ch>
 <AM5PR04MB313982936800424F9B2E660688B8A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <227dc52c-c555-34e4-d534-1a749af15425@denx.de>
In-Reply-To: <227dc52c-c555-34e4-d534-1a749af15425@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|AM7PR04MB7014:EE_
x-ms-office365-filtering-correlation-id: 0da046b6-6528-4634-39f3-08dbef15c7e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hc/bLloqZlqEn3j/AWGlxt+p7tFt1aSMHabN+Ofk15gtiKNmzAfce8Vu4BpG9K7doCB6IjvCMSE01l07otrpKrx2ivn7Q0dEXyxHPX2UtZrBCsQ6xyY/9f2D4oaKbz4JsrKFhi4rYBEiqSoV1CSaiB+s+Zh67jaq+7myysKzaa5cAHHmFw9HHChNIgIUMh1OuMPZW4KC7EuoiTAN2jwXdVc5mh3fBot8HSccr59KhMt+Te/t9xFJzBE0uTxODnXP0pRWkKZIfZ/Pm+E4XALblI6yq61w/a897Wt7+S+5AtZ9uEKwGO1I4JLsKA7GEgQiXs0XRzfM6LBDUKjItkgHqTzfcy6Ngw73Ikqm5WJJpZpxeEHJHwarrvrjsF/r71aFLJwfiaG1AXdFNejLjm72Fv0GNrhsQ2Se8VIMAS8Vn5AYCaA8muRDt3aezCRETyt7P9O6Pi0wScP85asFJXk/PyxxW87ooZ49UeiPEo2fPYo18rIT06nyeFUi3X/Q4+m8LRGNIvpshmPZqRMkwU1nrVA4vxT207LPuiNY4jmExk94ogQyYFGkbaY+2h5KIbfcFhlhpGa7g6UsLSuAaScguGBD0eLzd1BhpNhg4xJMPpqBiKWXtOP0OKBsEhfrdPxu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(39860400002)(396003)(346002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(38100700002)(122000001)(4326008)(8936002)(8676002)(52536014)(55016003)(9686003)(7696005)(6506007)(53546011)(71200400001)(66946007)(316002)(76116006)(66556008)(110136005)(66476007)(64756008)(54906003)(66446008)(7416002)(86362001)(44832011)(5660300002)(478600001)(2906002)(41300700001)(33656002)(38070700009)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?azhSYUx0d2poeGpRRStUSURzdk4rRXRzZHZhRGxwOXF2Q0lJdlpVUjRiY1ly?=
 =?gb2312?B?a3dkcmtGTXNQUExIY3FPYnlicDE3NTVjdUlCcXZkTU9FRmFhS3g3YWNON01I?=
 =?gb2312?B?dE9rRkpLQ2JpQXRlZ2c1NEYzazFRbENtQndjM2Zzcm9BY2dnNU1mZFhuVkV4?=
 =?gb2312?B?dmdGMTJTYmZJSkpzQlpXUSt0V1I5YldianRzSXkvamdrekRqQ2JVVDBTKzNh?=
 =?gb2312?B?MXNWMjRWQkQ4ZDI4cll1dVI2dHRDRDBOaENKb2lzL3lFVGVlcTYwRm85VDlZ?=
 =?gb2312?B?YXJzaVR5SURiS3NrL0gvM0dqZ2VCUWJ0ZHJJTVlrR2V5K051UTlNcFRTYTVZ?=
 =?gb2312?B?U2taWDlmeFR6eUYyQlJoc2xNdmZxMUgvWk1tVE5XNFU5K2FlTVVWUklJM1Nx?=
 =?gb2312?B?QkpoY3pyMnlJS0ZOYVNyZEF2cm1zSldWa2hEYUl6bk5nb0NCV1FUcFRaU09i?=
 =?gb2312?B?TjJEa1creE9udk9kMzI0djdVK2s2YkQ5Q2JpMTJSd1BIalNVNkFpL1NHSy85?=
 =?gb2312?B?ZW5ob2NLMzlub2pVbHRCRm05NGcyU2hDL3YwRXl4RWdqL04zWFZWNnhpQllV?=
 =?gb2312?B?Z05yZno2LzhmMmpXK1ovRWd4MzZYV0xnVW1OeFEyWmd6U1hOUXRJMjFpTUxw?=
 =?gb2312?B?VGsxTjdBR0N3enFRMGdTWmFGcnpKRC9Calo0V2lmOXpuSHdaOWFyNHl6bTlp?=
 =?gb2312?B?OFZpYVpNOEZjL0tBcHYwRWFjbUVwd0dudGN4UVV6NldKamtLcHdUS3NyUEJP?=
 =?gb2312?B?Wm1PM1Vrc2lybW9WOGZ1NjZaNTJjWi80b3VZblVZOSt2ZUVpcFB4eW1Nc2JE?=
 =?gb2312?B?b0NhUDVud2x4MlB6ZzZoZEhvSVJvUmlCVGdPUFpnbFl4L1IwT3FWeXl5MXpI?=
 =?gb2312?B?N1g3djErcTZYM25MVFZaekVYcEVwa2tCTDBhdXBqSjk0UFFZeXB5MlkyeEU0?=
 =?gb2312?B?RThxS0J1L3hmcHc4MkgyaVhMc3oyMVZJSWhOWTdiSURhVGtEa2JITm1HSXd1?=
 =?gb2312?B?REsvN2VVRFdxaUpMSUdabUZKakdPM0wwaVZFb3FsdzNFZzkwZDBSeENNNVJK?=
 =?gb2312?B?U2t0UjZZK1R1NjRsMTNVNm4wZFZZaWFYN3V2N1puNU8zcXYrYzVoZDhnODli?=
 =?gb2312?B?YmR0MjRXS29YeHdpMHUzWWdUN3o1OHg0SkVwNGdhVkxMbExBTHNlNDYzVTdn?=
 =?gb2312?B?VENwUHVKWDg4c0Zjd1oyb202WjMrQ0dQVWF3UW00SjNhZE4xVUc5NVFnOWFq?=
 =?gb2312?B?K0JQaHVzYi9ORFJQZzBleG5ydWRmbHhjRXkrazBpenc4dmZvZ28yNEkyTlFY?=
 =?gb2312?B?WkZ2QStjZURTdVYwb0c4ZDczU2cyNFJMTnJZWkxxQXNvUW1PVDhFdzhwKzNm?=
 =?gb2312?B?dVhENDEyYWxiU2U0ckJsT2owMkR4cmUvbzVla1Frb3p2NDVUTVBLZENCVmd5?=
 =?gb2312?B?dXJxRGtWeGx1VlNMWEpleENzV1hHdGRHSGxqUm84ZVY4VmZQeHlRN3VISlk0?=
 =?gb2312?B?cnRack9QNWtZbTB6QXF2MUZpZjZUWUo3VUhYT2U3bG5vUTR6c3MzYjd2YW01?=
 =?gb2312?B?NG93SE12TEllY0xpM3ZLaWRNSWE4L1gya1RyWFFIdVdwVzkrMUoyTW9TN3NI?=
 =?gb2312?B?VDQ1MmZhWDVZOHRla3BuUE5EUjBWOHl1M3hXWUk0TCtWWXo1TE5vMmlpbFll?=
 =?gb2312?B?RjBmWDg2WmFSc09qVk90Z1VUWkZGdiszci9raThaZ1hXN0xJRytlNkNlV1cr?=
 =?gb2312?B?OWtBZUFiL29zL0ZrVXg5RXFHcUlrSUx3bzd0ZVJLelZCQVJXZWc5UTh3R2My?=
 =?gb2312?B?MTdNTFhYSGZVMVFZeEcremw2WXQxZmR4VTRyelFocWl1VlU5SUlRUENlRG1v?=
 =?gb2312?B?ZWllWXFqbVBJNUtWa3loTlBVM0d5cW1SUXhwUXBNUGg2Vk9ab0pRdG5BYVc0?=
 =?gb2312?B?TTZ4Tlo4amg2RFVnc2RTeFZJNTZjSmQ0eGxrSGxubkdWSFgyTE5xRGJIelVi?=
 =?gb2312?B?c21vTjlqTlFUYVVnLzMyZGVFRW80VEUvUVBQNFYwdXByc0hDZG1KS1FCV3pD?=
 =?gb2312?B?WVJ1TStDNWcxdHMzbU9BVXozZXpnRnVrUlUybmY3OVZ4b3Q5bE1ESk1oRGhU?=
 =?gb2312?Q?ONIY=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da046b6-6528-4634-39f3-08dbef15c7e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2023 06:55:02.9982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /HNHM9cP2H4upcnMeHgj1IdHq9jUBHOaiFK7zoNg5m/GD0FUSBt03JYTAV5427yuTbugegsDhKD3VcJ02NNEwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7014
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
ZGVueC5kZT4NCj4gU2VudDogMjAyM8TqMTHUwjI0yNUgMTM6MTkNCj4gVG86IFdlaSBGYW5nIDx3
ZWkuZmFuZ0BueHAuY29tPjsgQW5kcmV3IEx1bm4gPGFuZHJld0BsdW5uLmNoPjsgSGVpa28NCj4g
U2Nob2NoZXIgPGhlaWtvLnNjaG9jaGVyQGdtYWlsLmNvbT4NCj4gQ2M6IG5ldGRldkB2Z2VyLmtl
cm5lbC5vcmc7IENsYXJrIFdhbmcgPHhpYW9uaW5nLndhbmdAbnhwLmNvbT47IERhdmlkIFMuDQo+
IE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29v
Z2xlLmNvbT47DQo+IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBkbC1saW51eC1p
bXggPGxpbnV4LWlteEBueHAuY29tPjsgUGFvbG8NCj4gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29t
PjsgU2hlbndlaSBXYW5nIDxzaGVud2VpLndhbmdAbnhwLmNvbT47DQo+IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IEFsZXhhbmRlciBTdmVyZGxpbg0KPiA8YWxleGFuZGVyLnN2ZXJkbGlu
QHNpZW1lbnMuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBuZXQ6IGZlYzogZml4IHByb2Jp
bmcgb2YgZmVjMSB3aGVuIGZlYzAgaXMgbm90IHByb2JlZCB5ZXQNCj4gDQo+IEhlbGxvIFdlaSwN
Cj4gDQo+IE9uIDI0LjExLjIzIDAzOjMzLCBXZWkgRmFuZyB3cm90ZToNCj4gPj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogQW5kcmV3IEx1bm4gPGFuZHJld0BsdW5uLmNo
Pg0KPiA+PiBTZW50OiAyMDIzxOoxMdTCMjTI1SA0OjA5DQo+ID4+IFRvOiBIZWlrbyBTY2hvY2hl
ciA8aGVpa28uc2Nob2NoZXJAZ21haWwuY29tPg0KPiA+PiBDYzogbmV0ZGV2QHZnZXIua2VybmVs
Lm9yZzsgSGVpa28gU2Nob2NoZXIgPGhzQGRlbnguZGU+OyBDbGFyayBXYW5nDQo+ID4+IDx4aWFv
bmluZy53YW5nQG54cC5jb20+OyBEYXZpZCBTLiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+
OyBFcmljDQo+ID4+IER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+OyBKYWt1YiBLaWNpbnNr
aSA8a3ViYUBrZXJuZWwub3JnPjsNCj4gPj4gZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNv
bT47IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT47DQo+ID4+IFNoZW53ZWkgV2FuZyA8
c2hlbndlaS53YW5nQG54cC5jb20+OyBXZWkgRmFuZw0KPiA8d2VpLmZhbmdAbnhwLmNvbT47DQo+
ID4+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPj4gU3ViamVjdDogUmU6IFtQQVRD
SF0gbmV0OiBmZWM6IGZpeCBwcm9iaW5nIG9mIGZlYzEgd2hlbiBmZWMwIGlzIG5vdA0KPiA+PiBw
cm9iZWQgeWV0DQo+ID4+DQo+ID4+IE9uIFRodSwgTm92IDIzLCAyMDIzIGF0IDAyOjI3OjQzUE0g
KzAxMDAsIEhlaWtvIFNjaG9jaGVyIHdyb3RlOg0KPiA+Pj4gaXQgaXMgcG9zc2libGUgdGhhdCBm
ZWMxIGlzIHByb2JlZCBiZWZvcmUgZmVjMC4gT24gU29DcyB3aXRoDQo+ID4+PiBGRUNfUVVJUktf
U0lOR0xFX01ESU8gc2V0ICh3aGljaCBtZWFucyBmZWMxIHVzZXMgbWlpIGZyb20gZmVjMCkgaW5p
dA0KPiA+Pj4gb2YgbWlpIGZhaWxzIGZvciBmZWMxIHdoZW4gZmVjMCBpcyBub3QgeWV0IHByb2Jl
ZCwgYXMgZmVjMCBzZXR1cHMNCj4gPj4+IG1paSBidXMuIEluIHRoaXMgY2FzZSBmZWNfZW5ldF9t
aWlfaW5pdCBmb3IgZmVjMSByZXR1cm5zIHdpdGgNCj4gPj4+IC1FTk9ERVYsIGFuZCBzbyBmZWMx
IG5ldmVyIGNvbWVzIHVwLg0KPiA+Pj4NCj4gPj4+IFJldHVybiBoZXJlIHdpdGggLUVQUk9CRV9E
RUZFUiBzbyBpbnRlcmZhY2UgZ2V0cyBsYXRlciBwcm9iZWQgYWdhaW4uDQo+ID4+Pg0KPiA+Pj4g
Rm91bmQgdGhpcyBvbiBpbXg4cXhwIGJhc2VkIGJvYXJkLCB1c2luZyAyIGV0aGVybmV0IGludGVy
ZmFjZXMsIGFuZA0KPiA+Pj4gZnJvbSB0aW1lIHRvIHRpbWUsIGZlYzEgaW50ZXJmYWNlIGNhbWUg
bm90IHVwLg0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IEhlaWtvIFNjaG9jaGVyIDxoc0Bk
ZW54LmRlPg0KPiA+Pj4gLS0tDQo+ID4+Pg0KPiA+Pj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2Zy
ZWVzY2FsZS9mZWNfbWFpbi5jIHwgMiArLQ0KPiA+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjX21haW4uYw0KPiA+Pj4gYi9kcml2ZXJzL25ldC9l
dGhlcm5ldC9mcmVlc2NhbGUvZmVjX21haW4uYw0KPiA+Pj4gaW5kZXggYzNiNzY5NGE3NDg1Li5k
OTU2Zjk1ZTdhNjUgMTAwNjQ0DQo+ID4+PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVl
c2NhbGUvZmVjX21haW4uYw0KPiA+Pj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNj
YWxlL2ZlY19tYWluLmMNCj4gPj4+IEBAIC0yNDQ1LDcgKzI0NDUsNyBAQCBzdGF0aWMgaW50IGZl
Y19lbmV0X21paV9pbml0KHN0cnVjdA0KPiA+PiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4+
PiAgCQkJbWlpX2NudCsrOw0KPiA+Pj4gIAkJCXJldHVybiAwOw0KPiA+Pj4gIAkJfQ0KPiA+Pj4g
LQkJcmV0dXJuIC1FTk9FTlQ7DQo+ID4+PiArCQlyZXR1cm4gLUVQUk9CRV9ERUZFUjsNCj4gPj4N
Cj4gPj4gSSB0aGluayB0aGlzIGhhcyBiZWVuIHRyaWVkIGJlZm9yZS4NCj4gPj4NCj4gPiBZZXMs
IHRoZXJlIHdhcyBpbmRlZWQgYSBzaW1pbGFyIHBhdGNoIFsxXSBiZWZvcmUuIGJ1dCB0aGlzIGlz
c3VlIHNlZW1zDQo+ID4gdG8gb25seSBleGlzdCBpbiBkb3duc3RyZWFtIHRyZWUsIGJlY2F1c2Ug
dGhlcmUgaXMgYSBsb2NhbCBwYXRjaCB3aGljaCBpcyBub3QNCj4gaW4gdGhlIHVwc3RyZWFtLg0K
PiA+DQo+ID4gICAgICAgICAvKiBib2FyZCBvbmx5IGVuYWJsZSBvbmUgbWlpIGJ1cyBpbiBkZWZh
dWx0ICovDQo+ID4gICAgICAgICBpZiAoIW9mX2dldF9wcm9wZXJ0eShucCwgImZzbCxtaWktZXhj
bHVzaXZlIiwgTlVMTCkpDQo+ID4gICAgICAgICAgICAgICAgIGZlcC0+cXVpcmtzIHw9IEZFQ19R
VUlSS19TSU5HTEVfTURJTzsNCj4gDQo+IFllcywgc29ycnkgZm9yIG92ZXJzZWVpbmcgdGhpcyAu
Li4gYnV0IHRoZXJlIGFyZSBTb0NzIGluIHVwc3RyZWFtIHdoaWNoIHNldA0KPiBGRUNfUVVJUktf
U0lOR0xFX01ESU8gYW5kIHNvIG1paSBidXMgZnJvbSBmb3IgZXhhbXBsZSBmZWMwIGlzIHVzZWQg
b24NCj4gb3RoZXIgZmVjWCBkZXZpY2VzLCBjb3JyZWN0Pw0KPiANClllcywgaS5NWDI4IHN0aWxs
IHVzZXMgRkVDX1FVSVJLX1NJTkdMRV9NRElPIGZsYWcgaW4gdGhlIHVwc3RyZWFtLCBCdXQgdGhl
DQpjdXJyZW50IHBhdGNoIGRvZXNuJ3Qgc2VlbSB0byBjb21wbGV0ZWx5IHNvbHZlIHRoaXMgaXNz
dWUuDQoNCklmIGZlYzEgaXMgcHJvYmVkIGJlZm9yZSBmZWMwLCBJIHRoaW5rIGl0cyBmZXAtPmRl
dl9pZCBzaG91bGQgYmUgZXF1YWwgdG8gMCwgc28gaXQgd2lsbA0Kbm90IGdvIHRvIHRoZSBmb2xs
b3dpbmcgc3RhdGVtZW50Lg0KIGlmICgoZmVwLT5xdWlya3MgJiBGRUNfUVVJUktfU0lOR0xFX01E
SU8pICYmIGZlcC0+ZGV2X2lkID4gMCkgew0KCQkvKiBmZWMxIHVzZXMgZmVjMCBtaWlfYnVzICov
DQoJCWlmIChtaWlfY250ICYmIGZlYzBfbWlpX2J1cykgew0KCQkJZmVwLT5taWlfYnVzID0gZmVj
MF9taWlfYnVzOw0KCQkJbWlpX2NudCsrOw0KCQkJcmV0dXJuIDA7DQoJCX0NCgkJcmV0dXJuIC1F
Tk9FTlQ7DQp9DQoNCkknbSBjb25zaWRlcmluZyByZW1vdmluZyB0aGUgRkVDX1FVSVJLX1NJTkdM
RV9NRElPIGZsYWcgZnJvbSB1cHN0cmVhbQ0KaW4gdGhlIGZ1dHVyZSBhcyBpdCdzIG5vdCBuZWNl
c3NhcnkuIEJ1dCBub3Qgbm93IGFzIEkgYW0gYnVzeSB3aXRoIG90aGVyIHByb2plY3RzLg0K

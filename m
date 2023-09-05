Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C85792488
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 17:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjIEP7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 11:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245333AbjIECBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 22:01:19 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2080.outbound.protection.outlook.com [40.107.22.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F656CC5;
        Mon,  4 Sep 2023 19:01:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7xAhezMOoe9854Gvfmu/M130zeMU/3hO7vX2e7L8xhUFGO2vI7peZikyvBHii+rk2Uq7fI3prZ12z8ZXygJtqszy+/jKsGWvAmTFrQwNvxU3AAFP5ldRmuzAjbpCynrNN89sj8r5cUds1y1yMJm3pKHhHcUXv3GBItEGpnsJ/AgPCR4/KnHxLbrZi2upwYHMQwWWY7AKXyaddd4kSNc5npTmaZcBwUpbB7dONndvTB5zXw5/elXECuxbcUKTeo0c0WE7UgpyNDd0wS1POBxabIabRcykRdthVTRRk2y9OOwUuSpjat0HWJgEwE5Xkdf8pj6l0iQh9Qr90ysknHgLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fM1BFm6657DKpFilBE4IfSZlUK92lPG3T8FmAK5/EI=;
 b=BwPEfs9GPI1SCKASFwegE7tS0gUxkIbLn3MoXOYAQDQgubW/sGhURKZKzMiRoU1ziZWQTR0qUn1/TB8rbW7ZUZSr3fmuEPvPHLbwN5ClnaT9Ag0xO1MXO48UdAdw6tF6XWWBgGU0aE7NkIckwBbpOTQhwz4Mqst3GI7owxR8Xb9ON5JSEX4AEIZ6Lzp6zS596P+ZI8oPoIhumpI8W8Z2+5d50VH2TTM1xR1rpyFnQA1YKGvRCzT7kvB8sXo8rCnue10u/Wf47Kl4/0bTtVt4fZDhNy1ExcGbl3GzpicrwKduf1V2bSWjW5zNceuZOSpBbSGKC3XWs0edtKN+K3Wq7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fM1BFm6657DKpFilBE4IfSZlUK92lPG3T8FmAK5/EI=;
 b=jAMHc522x14XsPwhnC24GdZmxcXCEeYGnagu0Szdw3K6WYsKGgSV6LPGJM5E9/p/b/il4N0ASRr+1dmLVu7wIaXLv+56t0EQvTUc7IWlNa+wCRBRelWv7hBQ0M5pQFvoHY2anOKvmPvafbVHMkkLgx+780X+1ICE1EmMcZPGn/A=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AS8PR04MB8468.eurprd04.prod.outlook.com (2603:10a6:20b:34b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Tue, 5 Sep
 2023 02:01:12 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::d73c:e747:3911:dcc]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::d73c:e747:3911:dcc%5]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 02:01:12 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Philipp Rossak <embed3d@gmail.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iio: adc: imx8qxp: Fix address for command buffer
 registers
Thread-Topic: [PATCH] iio: adc: imx8qxp: Fix address for command buffer
 registers
Thread-Index: AQHZ33t0NucOBt1hIkK0A0x5DMVZ+7ALelRQ
Date:   Tue, 5 Sep 2023 02:01:12 +0000
Message-ID: <DB7PR04MB401089A06CA65A0599456D7190E8A@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20230904220204.23841-1-embed3d@gmail.com>
In-Reply-To: <20230904220204.23841-1-embed3d@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|AS8PR04MB8468:EE_
x-ms-office365-filtering-correlation-id: c0d3211f-8be9-4f51-623f-08dbadb3fada
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LWzpFbjZzUFZXD8QDLGG0ajUoJvyqt0svVqMYupCX/k+XBkdbPm5JHZz8SGytoIag4FcPOUjpq1ySH+7trIiOWn04eXJJ18zogE3z0JQJlBUiYzMVByLCfhwiBNwwVu+CpsJt7lykjpqKioG4T4YMjNl/37v9j/KTLrYUOuNZcvKIBLVPmdVO2zB9ECzI54/fRlyfVx5bj6DhGhJEffZohDQvEsm9dYOd0u2t3sINifKGvz4l4ZalYabDHFHvhAFDdL/OFNgtyfVJWKYbxNVhtNB3fx4Wt4bpASSdLFGMRIKu0oZj4UhVI5fj2hEVbYSC2IwE1tombH7gpnU3QpfEZMVsu4yrTsaEP/cAPsOQna8dlXKHVLo+DQTuS/QHREbbE9CtvXySywb6iZmC7RRxKE7bGADISMuEBUXR7Ywv1LD3i4xWeuHMPFgQxZbBNnB6nchb0W1IMaxzmWOkQ6TLZ4jcObkt54cBo4c/yFY2d9Kzl9jteXWx832WprSozsYWGPPclqvZhkLZ6ZrwnD6Y/SanTgHH9o1MuDxte7dqaDAWcG5fGd+zx1ydxu3Cs7tw+EH8zaFC4wKad5xTq0F6K8lirNUeniPELFtO1PwTRxm6BelVvBkUOwV+7Vmk4NSD1XkcC0R9duoc6Hi4xch7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(186009)(1800799009)(451199024)(41300700001)(7416002)(71200400001)(7696005)(53546011)(122000001)(6506007)(478600001)(26005)(83380400001)(9686003)(38100700002)(38070700005)(55016003)(76116006)(66946007)(66446008)(2906002)(110136005)(66476007)(64756008)(6636002)(316002)(33656002)(54906003)(86362001)(66556008)(5660300002)(52536014)(8936002)(4326008)(8676002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Z2hVa08xNE1oVlZhRVJHdk5UK056M3YxWngwK29HYk44dC9kKzhQYTNoUkdl?=
 =?gb2312?B?cWRwRmU3aDRjRU9iR25neVl5Q3pVREtEb2kyLzJEQVoxTytIYUhkSWpPVWI3?=
 =?gb2312?B?eDNWTGxUUCtRUitoR0lSQUtxYU92ZUROa1crMFJ4U3VHY0hSZFhNM0hnaE5H?=
 =?gb2312?B?RHh5blhLbXJUUjFvMU83anhWdWtWOE53UGZhbFdDTmZoMXVzdUU3N2pnclVL?=
 =?gb2312?B?R0xHbi9nUnIzRW5SVDZGbHIvUXE3YlNnOEY0eU9yeDlNdFR1OWVCNFVoRGJz?=
 =?gb2312?B?b2FaVzc5Snl3dVJPbGx2SXRZdDRiU01tWllyZ1BROWYxTFBuUk9kVm9ib3Vw?=
 =?gb2312?B?TGNoREsrTGpCRW9TYlJNS0FoeEQ3THRoOWs4dTRBZlloaDQxZ2pzU0pLcXA2?=
 =?gb2312?B?VDArMVp6RGZMVCtWVmYrd296bFNOSk0xS1FBZUpQZ1RJRW1YVlpJOGtvcHly?=
 =?gb2312?B?UzVQYTBIYTh5c2JuY0VmUmRhb29ONUxaQWNja1NhMk1hSWhQeXFEbWRKTkZq?=
 =?gb2312?B?RXVvcFFwcHNQMGRqQ0JZUGdVNGZVMGZhYzdzeCtQM1MzZExMM3A5Qll0WWpQ?=
 =?gb2312?B?UDRieDRXdVNLQVdBcEtwejYvWXlveHhNdG1GaG1OZXJodVR6MzZ5c1pPS1JY?=
 =?gb2312?B?TXNhczZ2YTBRcW55TDhWZXd3MXAza2NkN3Q0aGFFVVdKSnozd0NaQW11ekFY?=
 =?gb2312?B?NU1vbHhtQ3o3THI5OUlRckY0anJIZXhaK1JQc0gyZVZ0dDlTVGs0UzdUQlZz?=
 =?gb2312?B?cHljSHlpKzN2YWl2cDZWaHlpZzE4SHF2Y0V1QjQzdlpmWWdFejFMSllzZXQ4?=
 =?gb2312?B?RU1rclZsa01PVlZ2MWVyd284UGs0SWEvYUZMQWFPcEJ4QnpicUV0cnJsTG9w?=
 =?gb2312?B?WTJETVNreTE5ME52NExTUWlYU2xjTHdKSGNKQ3FLM21wb1hOL3cxRzNJUHVk?=
 =?gb2312?B?cTBEcHl0WWIzb3QxMWpTN3RkSVlxTFdMczZic2tWZ2tST1ducjBjZWhrRlQ1?=
 =?gb2312?B?SDU3RlhrbjRwcFYyb1I5eHcxak9Rb2pPL1pBWmdsYjdQY2lnSFFmMG1PZkVU?=
 =?gb2312?B?V0puanpLU1V3Si90emJRQ1JmOTRKZ1lxNlFiVE9RdFF5YkhyU2o2S24yWUc0?=
 =?gb2312?B?Q0xPYkNIclFQQ3VzRkV4eFkwMStETmViY2hZVjRoazRETHJIM0wwVm1JWHBi?=
 =?gb2312?B?WnN0K2E1amc0eGF4UXhlc2YwZWJzVUsyN3BodjZrVWxRemNyRDJHdmN0VGZ6?=
 =?gb2312?B?UFRJNFRTd1RFWlplbVJacCtSTTJHTy84c0tRWGFIVWpqbFkzVmFXemdmbU91?=
 =?gb2312?B?WkRPc3FUdzdwdmtwNmxPbDJZTWhNT1NHS3NsOVZ2L3RtZmgrSDd3ZFQ5ZGRL?=
 =?gb2312?B?c2xMc0NDcWR6amF6MStsODFVZWJRT09wNllRelZCOHJReDZOdkNhcDQ1MnpZ?=
 =?gb2312?B?Y3J4a2VKRlU1RzFkL1EwVGNidlYxcDNiQUtGdlkzNGRGSjEyOVkxUFJoSVpW?=
 =?gb2312?B?MVAvdURxVTd1a1I3YlBFSnhLK1ZyRjN0UVo5dVhpejNCREg4SE16Yk5yODhq?=
 =?gb2312?B?OFZTKzcrVG8rdEhJMGJMeXQ3d1J1dnFUMmNpSGFnSlNueGMvSEdFbUZHSTdu?=
 =?gb2312?B?ZnBwQ1BHSGtvTTBsbUFiaW9lYWVyZFd4NTA4VDQrYTdxTTFnTjcxcy9VZC9w?=
 =?gb2312?B?STA2OVN1SUdES2lEK3NnNVlmbk92UDdVd2tUMG5BR1U1WFF4SHMvRHNHOGlI?=
 =?gb2312?B?M1RrcmVrUkQvUzZJVEdWdGFCVGtIaFZhN2duSUtHdzJrOUUxV21wU1ArRDZQ?=
 =?gb2312?B?OXFmbDZNeVpQU0Y1Mlh1QUQxQytRdkhCSFRGdjJuU3RXSkNCT01vVmhoUHF2?=
 =?gb2312?B?Zm5xOUZuMzNsSGMzTkNlY0grN1prTDA5QjVpRkM3WkorY1V2ZWJsa3BSRTAz?=
 =?gb2312?B?UFJsME43WVkyNDlKUkRTaWx3RXU3VVF2djZFbEdpek1WK3g2Rlk2Vm5ZTnJD?=
 =?gb2312?B?eHFWczdZU0hlOTJnTWtJWnBtYXUySTkyd1pxRHJnZXF2RThNNnlCTVhid2Rv?=
 =?gb2312?B?a1ErSjgyUFZYYlRtT0tSQy9Dc3VLN0dZYTU2M2pSaWltd2ZWMzB6KzFGeFJR?=
 =?gb2312?Q?NfdQ=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d3211f-8be9-4f51-623f-08dbadb3fada
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2023 02:01:12.2089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xmYUm/imNx/TNeaAEdAhlOFQt+jswa2TFMSQ2xch8T7lVawDw9ipQV8Z4G1l2T9hfJfVW+QZ+NlisGvGSWwBOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8468
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQaGlsaXBwIFJvc3NhayA8ZW1i
ZWQzZEBnbWFpbC5jb20+DQo+IFNlbnQ6IDIwMjPE6jnUwjXI1SA2OjAyDQo+IFRvOiBDYWkgSHVv
cWluZyA8Y2FpLmh1b3FpbmdAbGludXguZGV2PjsgQm91Z2ggQ2hlbiA8aGFpYm8uY2hlbkBueHAu
Y29tPjsNCj4gSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz47IExhcnMtUGV0ZXIg
Q2xhdXNlbiA8bGFyc0BtZXRhZm9vLmRlPjsNCj4gU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwu
b3JnPjsgU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPjsNCj4gUGVuZ3V0cm9u
aXggS2VybmVsIFRlYW0gPGtlcm5lbEBwZW5ndXRyb25peC5kZT47IEZhYmlvIEVzdGV2YW0NCj4g
PGZlc3RldmFtQGdtYWlsLmNvbT47IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+
IENjOiBsaW51eC1paW9Admdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFBoaWxpcHAgUm9z
c2FrIDxlbWJlZDNkQGdtYWlsLmNvbT4NCj4gU3ViamVjdDogW1BBVENIXSBpaW86IGFkYzogaW14
OHF4cDogRml4IGFkZHJlc3MgZm9yIGNvbW1hbmQgYnVmZmVyIHJlZ2lzdGVycw0KPiANCj4gVGhl
IEFEQyBDb21tYW5kIEJ1ZmZlciBSZWdpc3RlciBoaWdoIGFuZCBsb3cgYXJlIGN1cnJlbnRseSBw
b2ludGluZyB0byB0aGUNCj4gd3JvbmcgYWRkcmVzcyBhbmQgbWFrZXMgaXQgaW1wb3NzaWJsZSB0
byBwZXJmb3JtIGNvcnJlY3QgQURDIG1lYXN1cmVtZW50cw0KPiBvdmVyIGFsbCBjaGFubmVscy4N
Cj4gDQo+IEFjY29yZGluZyB0byB0aGUgZGF0YXNoZWV0IG9mIHRoZSBpbXg4cXhwIHRoZSBBRENf
Q01ETCByZWdpc3RlciBzdGFydHMgYXQNCj4gYWRkcmVzcyAweDEwMCBhbmQgdGhlIEFEQ19DTURI
IHJlZ2lzdGVyIHN0YXJ0cyBhdCBhZGRyZXNzIDB4MTA0Lg0KPiANCj4gVGhpcyBidWcgc2VlbXMg
dG8gYmUgaW4gdGhlIGtlcm5lbCBzaW5jZSB0aGUgaW50cm9kdWN0aW9uIG9mIHRoaXMgZHJpdmVy
Lg0KPiANCj4gVGhpcyBjYW4gYmUgb2JzZXJ2ZWQgYnkgY2hlY2tpbmcgYWxsIHJhdyB2b2x0YWdl
cyBvZiB0aGUgYWRjIGFuZCB0aGV5IGFyZSBhbGwNCj4gbmVhcmx5IGlkZW50aWNhbDoNCj4gDQo+
IGNhdCAvc3lzL2J1cy9paW8vZGV2aWNlcy9paW9cOmRldmljZTAvaW5fdm9sdGFnZSpfcmF3DQo+
IDM0OTgNCj4gMzQ5NA0KPiAzNDkxDQo+IDM0OTENCj4gMzQ4OQ0KPiAzNDkwDQo+IDM0OTANCj4g
MzQ5MA0KDQpPaCwgcmVhbGx5IHRoYW5rcyBmb3IgdGhpcyBjYXRjaC4NCg0KQWNrZWQtYnk6IEhh
aWJvIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCg0KQmVzdCBSZWdhcmRzDQpIYWlibyBDaGVu
DQo+IA0KPiBGaXhlczogMWUyM2RjYWExYTlmYSAoImlpbzogaW14OHF4cC1hZGM6IEFkZCBkcml2
ZXIgc3VwcG9ydCBmb3IgTlhQIElNWDhRWFANCj4gQURDIikNCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IFBoaWxpcHAgUm9zc2FrIDxlbWJlZDNkQGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2lp
by9hZGMvaW14OHF4cC1hZGMuYyB8IDQgKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9h
ZGMvaW14OHF4cC1hZGMuYyBiL2RyaXZlcnMvaWlvL2FkYy9pbXg4cXhwLWFkYy5jIGluZGV4DQo+
IGY1YTBmYzllNjRjNS4uZmZmNmU1YTJkOTU2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9h
ZGMvaW14OHF4cC1hZGMuYw0KPiArKysgYi9kcml2ZXJzL2lpby9hZGMvaW14OHF4cC1hZGMuYw0K
PiBAQCAtMzgsOCArMzgsOCBAQA0KPiAgI2RlZmluZSBJTVg4UVhQX0FEUl9BRENfRkNUUkwJCTB4
MzANCj4gICNkZWZpbmUgSU1YOFFYUF9BRFJfQURDX1NXVFJJRwkJMHgzNA0KPiAgI2RlZmluZSBJ
TVg4UVhQX0FEUl9BRENfVENUUkwodGlkKQkoMHhjMCArICh0aWQpICogNCkNCj4gLSNkZWZpbmUg
SU1YOFFYUF9BRFJfQURDX0NNREgoY2lkKQkoMHgxMDAgKyAoY2lkKSAqIDgpDQo+IC0jZGVmaW5l
IElNWDhRWFBfQURSX0FEQ19DTURMKGNpZCkJKDB4MTA0ICsgKGNpZCkgKiA4KQ0KPiArI2RlZmlu
ZSBJTVg4UVhQX0FEUl9BRENfQ01ETChjaWQpCSgweDEwMCArIChjaWQpICogOCkNCj4gKyNkZWZp
bmUgSU1YOFFYUF9BRFJfQURDX0NNREgoY2lkKQkoMHgxMDQgKyAoY2lkKSAqIDgpDQo+ICAjZGVm
aW5lIElNWDhRWFBfQURSX0FEQ19SRVNGSUZPCQkweDMwMA0KPiAgI2RlZmluZSBJTVg4UVhQX0FE
Ul9BRENfVFNUCQkweGZmYw0KPiANCj4gLS0NCj4gMi4zOS4yDQoNCg==

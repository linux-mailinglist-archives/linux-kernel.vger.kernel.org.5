Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E351752FAF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 05:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbjGNDFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 23:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbjGNDFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:05:42 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016002699;
        Thu, 13 Jul 2023 20:05:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aS9YrWrt99NarZIxwUhyaP7lGZa1dleha6fjegDsaNXogXPDT2pt4ulSVkoU29v2LlcYUuAUydhmTO8LHHgzctUBlceF9O71OnQ/Yf9GAwhm80mfJsrjnwENpGfPgHPyTQk8B78F0rRxjJElJnPxIEojgLUMcGUtNTu/P0SWpKwsWPwP6QgRK5cDx9fWxFBqY+jPQrR80u0RgUF2vHRmVSiJhVK1zqheyKpXRe4t0jfyQZsRp0GU35yci6+OAQHwa22BhO/qGWdb7yMeAPpqYPZumk7BlbuQ4Sc5p+MDRgT/b/eZaWquYATfuUUcrCDd8cBk9MV08AcBKOFX4bYA1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAVG16DsC1Fxcks1TINKnsLLbcJNKR2inWMjm7StfLk=;
 b=WfR3kJ9n2hCNHFzQRcooFUG0iVztfuDwsBBSTcTFnac0TbwKyig6i4doYalY+UpXNCbftpgkSROHvbZF5ziksavEprDDIrkSAQXNTdWzWvRBdM33J1PeK6KLvx002JkCQryKaEBu4ccFio/ZX4Eq12lR/9DFTVc7OkIpSmQFQZS84eDrBGOctMQwGr6aRxoakw5THs084ovALzbHH7gflRAcRNLipAvkaKtJPa3oipCn0XE4ZLl1JTazb3KoWqWGdBAynOeo2QoZGPJ0EqjQUXMoZ2oSlTOm6DVxboIno8Y0Dxbwg4PvO/9eSwVVI/aGsxYs4YyFgIP21hbO/hVb1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAVG16DsC1Fxcks1TINKnsLLbcJNKR2inWMjm7StfLk=;
 b=IAIL2eaKOGDGogsC58qpBF87LXKAIKRUGKSGjUY114aXrb/nPEJXnA2xomNSdteFlM2Ln8yKw7M3gUIST5fyfD/eTdrBliybqigh3rRF+WzcVJ+RAExQUvsVEXpSY2pKpyG8cfKtwNYTT+C8IudgQH145dFLlKMS1ymc7IB48Mw=
Received: from HE1PR04MB3148.eurprd04.prod.outlook.com (2603:10a6:7:1d::16) by
 DBBPR04MB7977.eurprd04.prod.outlook.com (2603:10a6:10:1ed::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20; Fri, 14 Jul 2023 03:05:37 +0000
Received: from HE1PR04MB3148.eurprd04.prod.outlook.com
 ([fe80::94dc:3b07:140f:5f2d]) by HE1PR04MB3148.eurprd04.prod.outlook.com
 ([fe80::94dc:3b07:140f:5f2d%5]) with mapi id 15.20.6588.017; Fri, 14 Jul 2023
 03:05:36 +0000
From:   Wei Fang <wei.fang@nxp.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxim Georgiev <glipus@gmail.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        =?utf-8?B?S8O2cnkgTWFpbmNlbnQ=?= <kory.maincent@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Gerhard Engleder <gerhard@engleder-embedded.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        Simon Horman <simon.horman@corigine.com>,
        Casper Andersson <casper.casan@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v7 net-next 06/10] net: fec: convert to ndo_hwtstamp_get()
 and ndo_hwtstamp_set()
Thread-Topic: [PATCH v7 net-next 06/10] net: fec: convert to
 ndo_hwtstamp_get() and ndo_hwtstamp_set()
Thread-Index: AQHZtYRM33vxhqTyXkiZmLn17+aSLq+4lJ9w
Date:   Fri, 14 Jul 2023 03:05:36 +0000
Message-ID: <HE1PR04MB31480DBFDFA823EACCD399CB8834A@HE1PR04MB3148.eurprd04.prod.outlook.com>
References: <20230713121907.3249291-1-vladimir.oltean@nxp.com>
 <20230713121907.3249291-7-vladimir.oltean@nxp.com>
In-Reply-To: <20230713121907.3249291-7-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HE1PR04MB3148:EE_|DBBPR04MB7977:EE_
x-ms-office365-filtering-correlation-id: 8e556039-1d45-47cb-377a-08db84173247
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dF3Pb7hWZDZnNL8Wv1hUbWjsnWOA8M9vfKzsurjsusmBW/lWSg8mBrkZirronDQFHkqqcSFE0wEf/fQl+LmOAUznAIvEHzlnmKoGkh3WJ4gFZBC8M763ZDtT4VeCUBoRTvMf7aYexs177F914SVRrUiJyIq+YDe2mlZ7JvD3y9iTFl5ay1F53Xj5dnhMinXYaDpB+vZfwQP2e4WRFv7Od1wFrGqMSEpKtD5IbPAunMIIUDammoKFlGK10VhRRrZyxxckd5PS3HRKbmZ1A8M5wNMjleUkVaqPSQqz9KiSiv0yrRYzhhMEfu8E3q07ulqcJXxuUJs5gZda2fPaJk6TYrGGwXrHoGS9P7nR4AR2rKVysHWuTtk2yWnQyWW1Z4+lJOmIaVB8/dVALcv5o0w8rsj4J1m9Yb1ODGhhEgDkzBzrEAyvPssVTXpgvkkKzJk5YppcvPkQMVIJ9TzlPpOKh5fP0AJ0mSYHuyviLBREl/kAmilOXgCz7n0LosVycJX+H/Y0V1W8j9Wn3EwV4Vea67ooWxFmfdOlnp71snioB2WNyIrQ/aOHUKyF/vo9OMPzZWUXq7hPQ82zaHzzaNeOZJFC8We4GRMED2TWxhb15TD62iH5pu1lS0elM1EnTdxp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR04MB3148.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199021)(8936002)(8676002)(41300700001)(54906003)(110136005)(7696005)(5660300002)(52536014)(7416002)(2906002)(316002)(44832011)(71200400001)(55016003)(4326008)(66556008)(64756008)(66446008)(66946007)(66476007)(76116006)(33656002)(9686003)(478600001)(66574015)(186003)(86362001)(38070700005)(122000001)(38100700002)(26005)(83380400001)(53546011)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVNlZy85YVBvZW10aEdJZ0lLa0IyWHNhN1dIZHY1VEwvcVNOSDgvMFQrdEgv?=
 =?utf-8?B?a29iWlprMnpGcVUzNzE5Um44M2daQzhUTjZkRytXcEZHSjFPZ0lDaUZITEg2?=
 =?utf-8?B?aWxtYVVaR2ZXYVBpZU1ENm1MRDI3TnBibzZFYUw3ak1FUEJ1T3Z2ZGdWcXNJ?=
 =?utf-8?B?Vm9XNTl2Yy9ObytCUVlGK3VFdnRHaVd2dE1YYzlqVE03UmNSYTFweXo5MHVy?=
 =?utf-8?B?WjdkWVRqRUdKcTJvVHdPcU1hNHZhdkQzc0VtT3BRaWZINFdxLzlrQ05PcDlk?=
 =?utf-8?B?TCtQNFNlTU9UNis4VGg4ejMvbWpucXlyM0l6dVc1MUFwUWJYa2tpU1IwN1Z5?=
 =?utf-8?B?Vzlvc0xtWW1pMmZjdjBaUExzT3VyMkZYeGhNekJEWTM2ZGQyREpkRmxFcFE5?=
 =?utf-8?B?aU1YdjJBV00xNkM0WlZRcEhmNFhCTmhyVmsrK1BaUnRRL2R6SXhMTjZvV0gv?=
 =?utf-8?B?SXdsODZDamF2SGRCa2R1empBY2ZaRDNLK0xadmlwYzBuRkpzOEpnRERRNDVO?=
 =?utf-8?B?RTdsUmw1ZDF2VW9uOUhGNmxGTEhwZGlWUXVMTVlMcktKazFQZW53L2Vkd1pV?=
 =?utf-8?B?dTU1b2tVdWhqbk9rdjdEQ1hxeHkva0VkbU5QN1FjQzBVeDFtN0RhWEtabytz?=
 =?utf-8?B?NUpHWEwxeE1FUmM4eDJmbWdzZWZYL1J6L2MxczFHQWxvZFR1U09WUnlKMFhv?=
 =?utf-8?B?QjRMOHcrQWYzNlMvMEY0dnBuTnQzc2cyYWU4VmdZQTJqakdkQmhhenl0bTNp?=
 =?utf-8?B?dk1JbS9xVnFSMUFHcUY0eWp1dCtONTZMY1JWT3Y0NEUwTzE3N1NiMU1aNVRm?=
 =?utf-8?B?dVhwbWVXNmVjdHpQckxmSHJFMVFraEV6Ylk2UWtqOTVZNnJyUTB6QmNIU09o?=
 =?utf-8?B?ZUdnSENFbzdJZ3IyZzZ1NkxIS2hNOG1UZFpzaEptdi83WE1oMitvN1FmTEpG?=
 =?utf-8?B?cFB1djgxV1hkWG9PbVE1dER0MEx4VnpYZThkc1FGOUpTekJqak9GTGFTeEox?=
 =?utf-8?B?QkRFTkpKR202RzlRRGJVTFphZFJaa1g1VHg0SkUxMi9KNjNlZWJlZUFJYmNn?=
 =?utf-8?B?S21CSjk5RDU0VnhQNXlLdm1jTHpDdTFjeHF2OVo1bUFKQ3ZMM2w2WTdsZlYw?=
 =?utf-8?B?QURnWjlQSUU4UDNRS0FyZWk4SEdsb1paanBNWmxEU0t0LzJGVkNVelcrdkJO?=
 =?utf-8?B?UURKY0VsRlU4OW5VdjlobjVta3NkU0c5TFlvNVlhQ2lDaDdNOFNVYkdOTytt?=
 =?utf-8?B?K2ZVbE5NOGtwSFJhdDN4Y3UzemhieHBIQi82WnRZQ1VQTGdVR2pTT2I2N2RO?=
 =?utf-8?B?SHpqbG5WOStnK29zMXVwbkpOU0VXOVBVbUd4dHBRaUh4SkRXeE80bTg1RGhr?=
 =?utf-8?B?dW8zNU12S0c0bkdtTTJxZmdXV1hZVHNxNEtFd0phcTkydlNnNnhKN05YbHRM?=
 =?utf-8?B?N3ZJNFhVdHFOUXNRTHQvNFQra1pWNFBpNHlGc1lQQmFNNUhpU0RBUk95dVJE?=
 =?utf-8?B?QlJwUXZXK0hXTzR4Yys0S2gvWXZYMzV6VktTNHRNbE5zQWtuSlU2MndranRB?=
 =?utf-8?B?bjlCM2pXUHVZQzlOZ3J2a0M1V0gySERNNXFKbHpqT3E5ZjcxMzNIazVxZjRm?=
 =?utf-8?B?L0hKMVpaWEJnNVMwVklBZWdFMEFJdmVvTmRkUVNZN29KRnN5cjFFTGtOdUp1?=
 =?utf-8?B?ekdUYlRmTkJPcWo5UnFxNEx2MkNZK2QzME9oRHdiVHB6L1QzbFZ2R01zOHQv?=
 =?utf-8?B?elBvUVFhWFJYWitGSXRNWktUT3RqK1JXVGZsSzZLZFQwTWRRcmM1R3d0bmkv?=
 =?utf-8?B?Sm9wb2VGc2tsaU9WUndlWEl5dUdPL0Z6a010bGMrNW9hSnRuSGx5R3FMUG1R?=
 =?utf-8?B?RjNlRkE1QjE5TUtTTEFjaWg1TkNLcndmYnpBR0ZqYzczT0QxNHZRSWxlSkY5?=
 =?utf-8?B?ME40ZUtVeUl5VUlZb0dVSHJtQUdhZDQwanlja2lES0JVejhpcmxaRU5ndW9t?=
 =?utf-8?B?MUFPZitZWllwU0pTa0xHVFhEQm5zN296alFiTXdkSGx1WnZhTTBldktYbmhj?=
 =?utf-8?B?cFpXOG9VTW5SK0VabFhlZmNkTUV5T2poUVZSSzVGNU4wM09EQWZFcUJsM21K?=
 =?utf-8?Q?onPU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR04MB3148.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e556039-1d45-47cb-377a-08db84173247
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 03:05:36.5091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I8wS3Mt7isevWOFeBjlV8E0sPu0+nXZMQQctkn2VlNFcgrePD471nv2oO45U4QROV29CvJZD3xV2UfYFBC8ELA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7977
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWbGFkaW1pciBPbHRlYW4gPHZs
YWRpbWlyLm9sdGVhbkBueHAuY29tPg0KPiBTZW50OiAyMDIz5bm0N+aciDEz5pelIDIwOjE5DQo+
IFRvOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnDQo+IENjOiBEYXZpZCBTLiBNaWxsZXIgPGRhdmVt
QGRhdmVtbG9mdC5uZXQ+OyBFcmljIER1bWF6ZXQNCj4gPGVkdW1hemV0QGdvb2dsZS5jb20+OyBK
YWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8gQWJlbmkNCj4gPHBhYmVuaUBy
ZWRoYXQuY29tPjsgQW5kcmV3IEx1bm4gPGFuZHJld0BsdW5uLmNoPjsgRmxvcmlhbiBGYWluZWxs
aQ0KPiA8Zi5mYWluZWxsaUBnbWFpbC5jb20+OyBNYXhpbSBHZW9yZ2lldiA8Z2xpcHVzQGdtYWls
LmNvbT47IEhvcmF0aXUgVnVsdHVyDQo+IDxob3JhdGl1LnZ1bHR1ckBtaWNyb2NoaXAuY29tPjsg
S8O2cnkgTWFpbmNlbnQNCj4gPGtvcnkubWFpbmNlbnRAYm9vdGxpbi5jb20+OyBNYXhpbWUgQ2hl
dmFsbGllcg0KPiA8bWF4aW1lLmNoZXZhbGxpZXJAYm9vdGxpbi5jb20+OyBSaWNoYXJkIENvY2hy
YW4NCj4gPHJpY2hhcmRjb2NocmFuQGdtYWlsLmNvbT47IFZhZGltIEZlZG9yZW5rbw0KPiA8dmFk
aW0uZmVkb3JlbmtvQGxpbnV4LmRldj47IEdlcmhhcmQgRW5nbGVkZXINCj4gPGdlcmhhcmRAZW5n
bGVkZXItZW1iZWRkZWQuY29tPjsgSGFuZ2JpbiBMaXUgPGxpdWhhbmdiaW5AZ21haWwuY29tPjsN
Cj4gUnVzc2VsbCBLaW5nIDxsaW51eEBhcm1saW51eC5vcmcudWs+OyBIZWluZXIgS2FsbHdlaXQN
Cj4gPGhrYWxsd2VpdDFAZ21haWwuY29tPjsgSmFjb2IgS2VsbGVyIDxqYWNvYi5lLmtlbGxlckBp
bnRlbC5jb20+OyBKYXkNCj4gVm9zYnVyZ2ggPGoudm9zYnVyZ2hAZ21haWwuY29tPjsgQW5keSBH
b3Nwb2RhcmVrIDxhbmR5QGdyZXlob3VzZS5uZXQ+Ow0KPiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhw
LmNvbT47IFNoZW53ZWkgV2FuZyA8c2hlbndlaS53YW5nQG54cC5jb20+Ow0KPiBDbGFyayBXYW5n
IDx4aWFvbmluZy53YW5nQG54cC5jb20+OyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29t
PjsNCj4gVU5HTGludXhEcml2ZXJAbWljcm9jaGlwLmNvbTsgTGFycyBQb3Zsc2VuIDxsYXJzLnBv
dmxzZW5AbWljcm9jaGlwLmNvbT47DQo+IFN0ZWVuIEhlZ2VsdW5kIDxTdGVlbi5IZWdlbHVuZEBt
aWNyb2NoaXAuY29tPjsgRGFuaWVsIE1hY2hvbg0KPiA8ZGFuaWVsLm1hY2hvbkBtaWNyb2NoaXAu
Y29tPjsgU2ltb24gSG9ybWFuDQo+IDxzaW1vbi5ob3JtYW5AY29yaWdpbmUuY29tPjsgQ2FzcGVy
IEFuZGVyc3Nvbg0KPiA8Y2FzcGVyLmNhc2FuQGdtYWlsLmNvbT47IFNlcmdleSBPcmdhbm92IDxz
b3JnYW5vdkBnbWFpbC5jb20+Ow0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIIHY3IG5l
dC1uZXh0IDA2LzEwXSBuZXQ6IGZlYzogY29udmVydCB0byBuZG9faHd0c3RhbXBfZ2V0KCkNCj4g
YW5kIG5kb19od3RzdGFtcF9zZXQoKQ0KPiANCj4gVGhlIGhhcmR3YXJlIHRpbWVzdGFtcGluZyB0
aHJvdWdoIG5kb19ldGhfaW9jdGwoKSBpcyBnb2luZyBhd2F5Lg0KPiBDb252ZXJ0IHRoZSBGRUMg
ZHJpdmVyIHRvIHRoZSBuZXcgQVBJIGJlZm9yZSB0aGF0IGNhbiBiZSByZW1vdmVkLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogVmxhZGltaXIgT2x0ZWFuIDx2bGFkaW1pci5vbHRlYW5AbnhwLmNvbT4N
Cj4gLS0tDQo+IENoYW5nZXMgaW4gdjc6DQo+IC0gUGF0Y2ggaXMgbmV3DQo+IA0KPiAgZHJpdmVy
cy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlYy5oICAgICAgfCAgNSArKy0NCj4gIGRyaXZlcnMv
bmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jIHwgNTIgKysrKysrKysrKysrKysrKyst
LS0tLS0NCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19wdHAuYyAgfCAzMSAr
KysrKy0tLS0tLS0tLQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA1MiBpbnNlcnRpb25zKCspLCAzNiBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVl
c2NhbGUvZmVjLmgNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjLmgNCj4g
aW5kZXggOTkzOWNjYWZiNTU2Li5kNGFlMGU3YzBhNDQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
bmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWMuaA0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5l
dC9mcmVlc2NhbGUvZmVjLmgNCj4gQEAgLTY5MSw4ICs2OTEsOSBAQCB2b2lkIGZlY19wdHBfaW5p
dChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LCBpbnQNCj4gaXJxX2lkeCk7ICB2b2lkIGZl
Y19wdHBfc3RvcChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KTsgIHZvaWQNCj4gZmVjX3B0
cF9zdGFydF9jeWNsZWNvdW50ZXIoc3RydWN0IG5ldF9kZXZpY2UgKm5kZXYpOyAgdm9pZA0KPiBm
ZWNfcHRwX2Rpc2FibGVfaHd0cyhzdHJ1Y3QgbmV0X2RldmljZSAqbmRldik7IC1pbnQgZmVjX3B0
cF9zZXQoc3RydWN0DQo+IG5ldF9kZXZpY2UgKm5kZXYsIHN0cnVjdCBpZnJlcSAqaWZyKTsgLWlu
dCBmZWNfcHRwX2dldChzdHJ1Y3QgbmV0X2RldmljZSAqbmRldiwNCj4gc3RydWN0IGlmcmVxICpp
ZnIpOw0KPiAraW50IGZlY19wdHBfc2V0KHN0cnVjdCBuZXRfZGV2aWNlICpuZGV2LCBzdHJ1Y3Qg
a2VybmVsX2h3dHN0YW1wX2NvbmZpZw0KPiAqY29uZmlnLA0KPiArCQlzdHJ1Y3QgbmV0bGlua19l
eHRfYWNrICpleHRhY2spOw0KPiArdm9pZCBmZWNfcHRwX2dldChzdHJ1Y3QgbmV0X2RldmljZSAq
bmRldiwgc3RydWN0IGtlcm5lbF9od3RzdGFtcF9jb25maWcNCj4gKypjb25maWcpOw0KPiANCj4g
DQo+IC8qKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioNCj4gKioqKioqKioqKi8NCj4gICNlbmRpZiAvKiBGRUNfSCAqLw0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMNCj4g
Yi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjX21haW4uYw0KPiBpbmRleCAxMjgw
ZGE2OTlmYTMuLmMwYjY4ZmMzZWM4YiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJl
ZXNjYWxlL2ZlY19tYWluLmMNCj4gQEAgLTMxOTYsNyArMzE5Niw2IEBAIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgZXRodG9vbF9vcHMNCj4gZmVjX2VuZXRfZXRodG9vbF9vcHMgPSB7DQo+IA0KPiAgc3Rh
dGljIGludCBmZWNfZW5ldF9pb2N0bChzdHJ1Y3QgbmV0X2RldmljZSAqbmRldiwgc3RydWN0IGlm
cmVxICpycSwgaW50IGNtZCkgIHsNCj4gLQlzdHJ1Y3QgZmVjX2VuZXRfcHJpdmF0ZSAqZmVwID0g
bmV0ZGV2X3ByaXYobmRldik7DQo+ICAJc3RydWN0IHBoeV9kZXZpY2UgKnBoeWRldiA9IG5kZXYt
PnBoeWRldjsNCj4gDQo+ICAJaWYgKCFuZXRpZl9ydW5uaW5nKG5kZXYpKQ0KPiBAQCAtMzIwNSwx
OSArMzIwNCw2IEBAIHN0YXRpYyBpbnQgZmVjX2VuZXRfaW9jdGwoc3RydWN0IG5ldF9kZXZpY2Ug
Km5kZXYsDQo+IHN0cnVjdCBpZnJlcSAqcnEsIGludCBjbWQpDQo+ICAJaWYgKCFwaHlkZXYpDQo+
ICAJCXJldHVybiAtRU5PREVWOw0KPiANCj4gLQlpZiAoZmVwLT5idWZkZXNjX2V4KSB7DQo+IC0J
CWJvb2wgdXNlX2ZlY19od3RzID0gIXBoeV9oYXNfaHd0c3RhbXAocGh5ZGV2KTsNCj4gLQ0KPiAt
CQlpZiAoY21kID09IFNJT0NTSFdUU1RBTVApIHsNCj4gLQkJCWlmICh1c2VfZmVjX2h3dHMpDQo+
IC0JCQkJcmV0dXJuIGZlY19wdHBfc2V0KG5kZXYsIHJxKTsNCj4gLQkJCWZlY19wdHBfZGlzYWJs
ZV9od3RzKG5kZXYpOw0KPiAtCQl9IGVsc2UgaWYgKGNtZCA9PSBTSU9DR0hXVFNUQU1QKSB7DQo+
IC0JCQlpZiAodXNlX2ZlY19od3RzKQ0KPiAtCQkJCXJldHVybiBmZWNfcHRwX2dldChuZGV2LCBy
cSk7DQo+IC0JCX0NCj4gLQl9DQo+IC0NCj4gIAlyZXR1cm4gcGh5X21paV9pb2N0bChwaHlkZXYs
IHJxLCBjbWQpOyAgfQ0KPiANCj4gQEAgLTM4NjgsNiArMzg1NCw0MiBAQCBzdGF0aWMgaW50IGZl
Y19lbmV0X3hkcF94bWl0KHN0cnVjdCBuZXRfZGV2aWNlDQo+ICpkZXYsDQo+ICAJcmV0dXJuIHNl
bnRfZnJhbWVzOw0KPiAgfQ0KPiANCj4gK3N0YXRpYyBpbnQgZmVjX2h3dHN0YW1wX2dldChzdHJ1
Y3QgbmV0X2RldmljZSAqbmRldiwNCj4gKwkJCSAgICBzdHJ1Y3Qga2VybmVsX2h3dHN0YW1wX2Nv
bmZpZyAqY29uZmlnKSB7DQo+ICsJc3RydWN0IGZlY19lbmV0X3ByaXZhdGUgKmZlcCA9IG5ldGRl
dl9wcml2KG5kZXYpOw0KPiArCXN0cnVjdCBwaHlfZGV2aWNlICpwaHlkZXYgPSBuZGV2LT5waHlk
ZXY7DQo+ICsNCj4gKwlpZiAocGh5X2hhc19od3RzdGFtcChwaHlkZXYpKQ0KPiArCQlyZXR1cm4g
cGh5X21paV9pb2N0bChwaHlkZXYsIGNvbmZpZy0+aWZyLCBTSU9DR0hXVFNUQU1QKTsNCj4gKw0K
PiArCWlmICghZmVwLT5idWZkZXNjX2V4KQ0KPiArCQlyZXR1cm4gLUVPUE5PVFNVUFA7DQo+ICsN
Cj4gKwlmZWNfcHRwX2dldChuZGV2LCBjb25maWcpOw0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9
DQo+ICsNCj4gK3N0YXRpYyBpbnQgZmVjX2h3dHN0YW1wX3NldChzdHJ1Y3QgbmV0X2RldmljZSAq
bmRldiwNCj4gKwkJCSAgICBzdHJ1Y3Qga2VybmVsX2h3dHN0YW1wX2NvbmZpZyAqY29uZmlnLA0K
PiArCQkJICAgIHN0cnVjdCBuZXRsaW5rX2V4dF9hY2sgKmV4dGFjaykNCj4gK3sNCj4gKwlzdHJ1
Y3QgZmVjX2VuZXRfcHJpdmF0ZSAqZmVwID0gbmV0ZGV2X3ByaXYobmRldik7DQo+ICsJc3RydWN0
IHBoeV9kZXZpY2UgKnBoeWRldiA9IG5kZXYtPnBoeWRldjsNCj4gKw0KPiArCWlmIChwaHlfaGFz
X2h3dHN0YW1wKHBoeWRldikpIHsNCj4gKwkJZmVjX3B0cF9kaXNhYmxlX2h3dHMobmRldik7DQo+
ICsNCj4gKwkJcmV0dXJuIHBoeV9taWlfaW9jdGwocGh5ZGV2LCBjb25maWctPmlmciwgU0lPQ1NI
V1RTVEFNUCk7DQo+ICsJfQ0KPiArDQo+ICsJaWYgKCFmZXAtPmJ1ZmRlc2NfZXgpDQo+ICsJCXJl
dHVybiAtRU9QTk9UU1VQUDsNCj4gKw0KPiArCXJldHVybiBmZWNfcHRwX3NldChuZGV2LCBjb25m
aWcsIGV4dGFjayk7IH0NCj4gKw0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBuZXRfZGV2aWNlX29w
cyBmZWNfbmV0ZGV2X29wcyA9IHsNCj4gIAkubmRvX29wZW4JCT0gZmVjX2VuZXRfb3BlbiwNCj4g
IAkubmRvX3N0b3AJCT0gZmVjX2VuZXRfY2xvc2UsDQo+IEBAIC0zODg0LDYgKzM5MDYsOCBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IG5ldF9kZXZpY2Vfb3BzIGZlY19uZXRkZXZfb3BzID0NCj4gew0K
PiAgCS5uZG9fc2V0X2ZlYXR1cmVzCT0gZmVjX3NldF9mZWF0dXJlcywNCj4gIAkubmRvX2JwZgkJ
PSBmZWNfZW5ldF9icGYsDQo+ICAJLm5kb194ZHBfeG1pdAkJPSBmZWNfZW5ldF94ZHBfeG1pdCwN
Cj4gKwkubmRvX2h3dHN0YW1wX2dldAk9IGZlY19od3RzdGFtcF9nZXQsDQo+ICsJLm5kb19od3Rz
dGFtcF9zZXQJPSBmZWNfaHd0c3RhbXBfc2V0LA0KPiAgfTsNCj4gDQo+ICBzdGF0aWMgY29uc3Qg
dW5zaWduZWQgc2hvcnQgb2Zmc2V0X2Rlc19hY3RpdmVfcnhxW10gPSB7IGRpZmYgLS1naXQNCj4g
YS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjX3B0cC5jDQo+IGIvZHJpdmVycy9u
ZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19wdHAuYw0KPiBpbmRleCBhYjg2YmI4NTYyZWYuLjNm
NTNiOGFlNTdkZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxl
L2ZlY19wdHAuYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjX3B0
cC5jDQo+IEBAIC02MTgsMTYgKzYxOCwxMiBAQCB2b2lkIGZlY19wdHBfZGlzYWJsZV9od3RzKHN0
cnVjdCBuZXRfZGV2aWNlICpuZGV2KQ0KPiAgCWZlcC0+aHd0c19yeF9lbiA9IDA7DQo+ICB9DQo+
IA0KPiAtaW50IGZlY19wdHBfc2V0KHN0cnVjdCBuZXRfZGV2aWNlICpuZGV2LCBzdHJ1Y3QgaWZy
ZXEgKmlmcikNCj4gK2ludCBmZWNfcHRwX3NldChzdHJ1Y3QgbmV0X2RldmljZSAqbmRldiwgc3Ry
dWN0IGtlcm5lbF9od3RzdGFtcF9jb25maWcNCj4gKmNvbmZpZywNCj4gKwkJc3RydWN0IG5ldGxp
bmtfZXh0X2FjayAqZXh0YWNrKQ0KPiAgew0KPiAgCXN0cnVjdCBmZWNfZW5ldF9wcml2YXRlICpm
ZXAgPSBuZXRkZXZfcHJpdihuZGV2KTsNCj4gDQo+IC0Jc3RydWN0IGh3dHN0YW1wX2NvbmZpZyBj
b25maWc7DQo+IC0NCj4gLQlpZiAoY29weV9mcm9tX3VzZXIoJmNvbmZpZywgaWZyLT5pZnJfZGF0
YSwgc2l6ZW9mKGNvbmZpZykpKQ0KPiAtCQlyZXR1cm4gLUVGQVVMVDsNCj4gLQ0KPiAtCXN3aXRj
aCAoY29uZmlnLnR4X3R5cGUpIHsNCj4gKwlzd2l0Y2ggKGNvbmZpZy0+dHhfdHlwZSkgew0KPiAg
CWNhc2UgSFdUU1RBTVBfVFhfT0ZGOg0KPiAgCQlmZXAtPmh3dHNfdHhfZW4gPSAwOw0KPiAgCQli
cmVhazsNCj4gQEAgLTYzOCwzMyArNjM0LDI4IEBAIGludCBmZWNfcHRwX3NldChzdHJ1Y3QgbmV0
X2RldmljZSAqbmRldiwgc3RydWN0IGlmcmVxDQo+ICppZnIpDQo+ICAJCXJldHVybiAtRVJBTkdF
Ow0KPiAgCX0NCj4gDQo+IC0Jc3dpdGNoIChjb25maWcucnhfZmlsdGVyKSB7DQo+ICsJc3dpdGNo
IChjb25maWctPnJ4X2ZpbHRlcikgew0KPiAgCWNhc2UgSFdUU1RBTVBfRklMVEVSX05PTkU6DQo+
ICAJCWZlcC0+aHd0c19yeF9lbiA9IDA7DQo+ICAJCWJyZWFrOw0KPiANCj4gIAlkZWZhdWx0Og0K
PiAgCQlmZXAtPmh3dHNfcnhfZW4gPSAxOw0KPiAtCQljb25maWcucnhfZmlsdGVyID0gSFdUU1RB
TVBfRklMVEVSX0FMTDsNCj4gKwkJY29uZmlnLT5yeF9maWx0ZXIgPSBIV1RTVEFNUF9GSUxURVJf
QUxMOw0KPiAgCQlicmVhazsNCj4gIAl9DQo+IA0KPiAtCXJldHVybiBjb3B5X3RvX3VzZXIoaWZy
LT5pZnJfZGF0YSwgJmNvbmZpZywgc2l6ZW9mKGNvbmZpZykpID8NCj4gLQkgICAgLUVGQVVMVCA6
IDA7DQo+ICsJcmV0dXJuIDA7DQo+ICB9DQo+IA0KPiAtaW50IGZlY19wdHBfZ2V0KHN0cnVjdCBu
ZXRfZGV2aWNlICpuZGV2LCBzdHJ1Y3QgaWZyZXEgKmlmcikNCj4gK3ZvaWQgZmVjX3B0cF9nZXQo
c3RydWN0IG5ldF9kZXZpY2UgKm5kZXYsIHN0cnVjdCBrZXJuZWxfaHd0c3RhbXBfY29uZmlnDQo+
ICsqY29uZmlnKQ0KPiAgew0KPiAgCXN0cnVjdCBmZWNfZW5ldF9wcml2YXRlICpmZXAgPSBuZXRk
ZXZfcHJpdihuZGV2KTsNCj4gLQlzdHJ1Y3QgaHd0c3RhbXBfY29uZmlnIGNvbmZpZzsNCj4gLQ0K
PiAtCWNvbmZpZy5mbGFncyA9IDA7DQo+IC0JY29uZmlnLnR4X3R5cGUgPSBmZXAtPmh3dHNfdHhf
ZW4gPyBIV1RTVEFNUF9UWF9PTiA6DQo+IEhXVFNUQU1QX1RYX09GRjsNCj4gLQljb25maWcucnhf
ZmlsdGVyID0gKGZlcC0+aHd0c19yeF9lbiA/DQo+IC0JCQkgICAgSFdUU1RBTVBfRklMVEVSX0FM
TCA6IEhXVFNUQU1QX0ZJTFRFUl9OT05FKTsNCj4gDQo+IC0JcmV0dXJuIGNvcHlfdG9fdXNlcihp
ZnItPmlmcl9kYXRhLCAmY29uZmlnLCBzaXplb2YoY29uZmlnKSkgPw0KPiAtCQktRUZBVUxUIDog
MDsNCj4gKwljb25maWctPmZsYWdzID0gMDsNCj4gKwljb25maWctPnR4X3R5cGUgPSBmZXAtPmh3
dHNfdHhfZW4gPyBIV1RTVEFNUF9UWF9PTiA6DQo+IEhXVFNUQU1QX1RYX09GRjsNCj4gKwljb25m
aWctPnJ4X2ZpbHRlciA9IChmZXAtPmh3dHNfcnhfZW4gPw0KPiArCQkJICAgICBIV1RTVEFNUF9G
SUxURVJfQUxMIDogSFdUU1RBTVBfRklMVEVSX05PTkUpOw0KPiAgfQ0KPiANCj4gIC8qDQo+IC0t
DQo+IDIuMzQuMQ0KDQpUaGFua3MhDQpSZXZpZXdlZC1ieTogV2VpIEZhbmcgPCB3ZWkuZmFuZ0Bu
eHAuY29tID4NCg==

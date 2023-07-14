Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4AD75361F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbjGNJI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235403AbjGNJI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:08:57 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2068.outbound.protection.outlook.com [40.107.104.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E806830E8;
        Fri, 14 Jul 2023 02:08:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCfSjzfhVe/pgvEI1Ysm3zByp7qifoAo1gHeMS4/bGqKU62BPf3NOX+ebeLCAUOjXE0+X75rkc6bCsechVpLjMK+vtOKDN7/3bDuRnqv+TEorKxuWvJCDhKePY7BZYen7fC4QTUHI91pjmoKtkZol/Zp+r1pidkVfLfSZt/qNC3pdvLGSxAaMteYtvX2YYOAiUgjdkkgH0CEiaotoE35vntWRKW0HPHT9WfW9n63B29kFPsE4wlNklcLdaS/Wx08bhPbMjl6SfqFpOCsjWekUvL9YPnRvA/mZPid4c9DzpWWka098IZmFktj4tbaTbo+5oueorz6UKjq6PPwEJyc1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+1M4gzuVpQeCnMft5kR3K83y3k8RuPMvZirLWOotvI=;
 b=BOdUTFuXR/uR79g9Z/QRJ4nz3fqli3Vha/WGQfCiTyyoiZ8C54YyDzcBfMoX9rdyghk0grA+d+LMv+iEzqKwrUr5a0j2WImiliP3xgf1gtiB5QECSumnoaCWm8k2Sx7FJfGuzE2lO9RpR9bGUeo3kkPSRR4+z7EgbkcK/Ckw1j6Z2BHkTzv2UzkFTOWmSPUPYCLEYRRKT4B1/MzwhSsbAUiyxHKWccNuEhVtA4sSruQN0vutZqx0cgXefaToWE37MLwmAUe0+qaQ0KnAsJAHM/LLHnG0HdS43QfBGTwKE5eP2EW50DdAxzgDWwP9fe1fZyYHLJRagKs2CoOtHDIY+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+1M4gzuVpQeCnMft5kR3K83y3k8RuPMvZirLWOotvI=;
 b=q47vsdYNA04L5Fy/xoAO1tx55kNCCmhYbCLZMbnPkYKos1HOiEwclpNg9rSSsJWwn9GMjCtZOKRocYbd8eumtSXMDYRU7Xdu10SQYB0RFL/pVoxStCuy++O/zlvGeu4DtWaICIZew05Q4vYK4idDhxyvEf57wv2eGj8biEyDluA=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by AS8PR04MB8532.eurprd04.prod.outlook.com (2603:10a6:20b:423::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 14 Jul
 2023 09:08:43 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::1edd:68cb:85d0:29e0]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::1edd:68cb:85d0:29e0%7]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 09:08:43 +0000
From:   Wei Fang <wei.fang@nxp.com>
To:     Russell King <linux@armlinux.org.uk>
CC:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
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
Thread-Index: AQHZtYRM33vxhqTyXkiZmLn17+aSLq+4lJ9wgABgFoCAAAVCkA==
Date:   Fri, 14 Jul 2023 09:08:43 +0000
Message-ID: <AM5PR04MB313934D20C540A1E4E6D7DDE8834A@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20230713121907.3249291-1-vladimir.oltean@nxp.com>
 <20230713121907.3249291-7-vladimir.oltean@nxp.com>
 <HE1PR04MB31480DBFDFA823EACCD399CB8834A@HE1PR04MB3148.eurprd04.prod.outlook.com>
 <ZLELt4Ove4tKDQPS@shell.armlinux.org.uk>
In-Reply-To: <ZLELt4Ove4tKDQPS@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|AS8PR04MB8532:EE_
x-ms-office365-filtering-correlation-id: 56932874-6847-4385-e5b9-08db8449ec2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ozq9dSVZoe9uECAFLyZpADH2q5lbQoWpFka0HWbBNs46/oWDe+UqKAuf5NqxbiAClFcpVJ/TpPYVgBSXCbgM2VRnujJc5861qlDGSRi8TmoHcGKzMy9NH9jl8ACoxnBJ2Mlk0Ru+jLP8yG9C1SqPzaQiHn+/B6fdaWNiyrnm4QdwnG/gpB4KJsqHksiSnZk9a93m5Q832hMkEg13Av0N4GKO3oDgj3/OREoyEyP9jBWv+KhLFeLlcT6qL24cUUzFQsZS85ftyKDotxgONGSdDtF9EYE15APGxOfWQdvqqfRdwy2mBOwnX94nwUjf2//UYPPQ5TeyoEZGuy3EIk+e1vHmVvy9qDq663Z2HNLXW4Z9Dyj8adXIgvg2ONoWsN5ZQS+O+jQ5Iy8UfbdXzLQhsSTwHLHICjVjVIyR1NLwVvoHcTs1MkBbkzbJ0BNWFcz5O9DfzMN2X56uV+VVYTJeAi3l/eaHSgxwsLDBL7xJ5COvH8hrIwva+pt4mPkSHrru2K/smxqTTXr8EFiveIpkzp4g/OP8Ba1tCAP0H6ccNif6wgU/q78KjlER80TtAocSvnMJDrWiVRbZtU/C1DngnBKyjOdR/Oz1TvqqfRclm7A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(451199021)(66446008)(44832011)(7416002)(52536014)(2906002)(478600001)(86362001)(55016003)(8936002)(66946007)(5660300002)(66556008)(33656002)(966005)(38100700002)(45080400002)(53546011)(186003)(26005)(7696005)(122000001)(9686003)(66574015)(64756008)(83380400001)(38070700005)(4326008)(6506007)(76116006)(8676002)(316002)(66476007)(54906003)(71200400001)(41300700001)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDRvTzFRUDFlbU0yMXJPTFBOT3NSWkVsdXgwM1hxZ2YxOFFyU24rODFNT1NQ?=
 =?utf-8?B?T3lqNlpmc3M3OW02bnBnSUFMdGJhT3FPekVsU0phdXJsYjdSTlEzVldLNnNS?=
 =?utf-8?B?MmVEWGNURkZoNSsvYmpkMnZFaG4xZ0dab0ZaM0tiSjJMVUwzUmhNdG04ak5w?=
 =?utf-8?B?S00vSGEyNTl2SkpGdUdFQnNUdGZBWFJ2OXRUQVU4WllGZHZZeE52ZTg0SWJV?=
 =?utf-8?B?R3ZKc0xUclc1UVNzWWtmRGJudEVEb3FlaGVSYTlCeFhyRnFLWG1LbVJrRjVa?=
 =?utf-8?B?dml4QkJCaE1qaTFPWUlKVVM0VkpVUE9OMVczaTNrMllTeTNnaDgxYTBCeU1i?=
 =?utf-8?B?UDVmMjdISU8ra2U0RjFzSDJMdTZWWWh4c1M1K2dIaXI5U0ZUWkp5M21oTlIv?=
 =?utf-8?B?T296TlhWT3Q4cTBuTmVEdzg0dFF0cTdJRmp5WmNQTWphWHBISTBxclFwWVg1?=
 =?utf-8?B?Ykw4THNHSjF1QWN2M3NGRHhTZHVKUW94WngwSTR0V2pBdWQrWmFYS0s3T04v?=
 =?utf-8?B?Q0RUU3VuV2g4VmY2ZDFsMTYvQWVOSHFuaXF6T084eFFlOWpPY2g1eDdFb2Rm?=
 =?utf-8?B?QWRLd2M1bGFCenRCdVJjYU5zTEtKU0pQcWFCZzZ0U2Q3U2NUTDY0QnVCYjl0?=
 =?utf-8?B?WWpmM2ZCdGlwOVdqQk9YWm5vNlEwNHk0ZnR2MXVFWXR3anRjL2hVMWNYRjc3?=
 =?utf-8?B?M0FCSjhUbEtDbFBQUTR2bDh0VmRhWmUveCtXb2tKeTBkR0hmUlJzOEhsMDRz?=
 =?utf-8?B?WUNTWlVUNjBRVXdCbTV6a2hOcVFpeVlTUHJ4OXVEa1ZwanM3VDhHak5SRlhR?=
 =?utf-8?B?RFB1Y3VrN014bEQyV3oxY0twbktPMjNKRStvVzN4QURzdFlRMmdIYlFPNTJi?=
 =?utf-8?B?a2pHMzVDMCtuWXZjblZEWm93NXZjbmp4WVprWk5BdjJQTm1oNUZUVDl1WDFy?=
 =?utf-8?B?cStKb216eC9ONFZxa1g2K2F5eFNEOW52K202SHlaZHdrWDh6WkpSbmcvYXc0?=
 =?utf-8?B?SjIvaWZENXEvQk5pa0w2K1A5aG5oRURUMGVybmp0M1NxR0QyWGRNYytXZjAw?=
 =?utf-8?B?Szc5NmZJdXRNWmQ2aFRveHVRb2laaDNOL2RwejJQSnFCWm1CakNzU0xWN2ZP?=
 =?utf-8?B?aFN4Z0hmTTI3eWEwQ1dFbExVTmhlOUVmZzhlbVNtTXhOaGlzVVNGQzNUK0Vt?=
 =?utf-8?B?M0tQUnN4eEFzNkZJeWt4Z3ZRa3JUclA2d0lleURWSFpjSWFsV0NrVS9sa0tF?=
 =?utf-8?B?Rk1MeG85cWhqTFZOYTNrM3EvbmptcEZXSEViMUZBNmxNVGhzY3didGVKQ0FQ?=
 =?utf-8?B?a3ZQUzJnSE9zc2tGcnhqREFIVStlWm5XcUVGbUlXNGNLUHF0ck14Sm1IbmlD?=
 =?utf-8?B?RWNpOCtJTWdEYlY1eHlxQ2tpVkdtQ3kxV1BwQzBwOTVxODVoODhDTkw5SU9z?=
 =?utf-8?B?T3lhWGZTbG1FOU1KWHJ3djd4YktHbVV3WTBydVBMNUlSZ1ZxU2ZSM1VYOVFh?=
 =?utf-8?B?UmNHaXNYcmd0V0ZBYkl4Vk41YmQwRGRWSFQ1SEV6eXpXeGYyeTVPYkJMSElk?=
 =?utf-8?B?UEtWQTV3c3VRR2djYW0zWHF0QUw2S1h1SEJRZHFLTWp1MVh2SHcxb3RST0Rk?=
 =?utf-8?B?c2w1MTk5RlhLK3NTS3BxZVlKSVliK080NzFUcVRoL0JWdS9XaG5ldGd3c3RW?=
 =?utf-8?B?SWVQK3VvbjYyZmlJV1p4a3NBdjZWVm5HbFV5dm1YSzU0WW5GdEhScU9UWm05?=
 =?utf-8?B?anhFSWkrVy9pWU53Q1FBNXV2ZnJGT04wQWNqOXBpclJhb1l3QkhtQW1EMW5v?=
 =?utf-8?B?M2FEY050R3d4UUlZaWt1alhVSC96TWZvUzZsSXFRSlNpVERzTFZXRzRZazF5?=
 =?utf-8?B?Rld6SDRHTmxQRFVmdGRubkM5M0V1cmhHdzNPS3VUc3RBZk83NVB4Rk1xd0lO?=
 =?utf-8?B?YUxSMk5zRFVrM3VjY0RNbXVKdXIwOEd6Z3MxNFlzWkUxTUpkc3dWYXN5Ri9D?=
 =?utf-8?B?VTFmSjExc3dmYldNTFNQK0NHUU9TVkh3THkzYWNiYWltS0c3UkVFbm4xTGlq?=
 =?utf-8?B?WmFNNndUR2VCRXQ4ZTgzaTFKa1Y3RXYwL24yakNzcE5ISjBuZTRVVVRuZElZ?=
 =?utf-8?Q?pCk0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56932874-6847-4385-e5b9-08db8449ec2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 09:08:43.2877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rc8pHk79q7KkQcAgFKHUm1AaKzT4Vtd7/d6+s9gQDcw8a9U31bXOG8lbu3Z4dOmf6ITeRibGFoZTGcP45zZhfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8532
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSdXNzZWxsIEtpbmcgPGxpbnV4
QGFybWxpbnV4Lm9yZy51az4NCj4gU2VudDogMjAyM+W5tDfmnIgxNOaXpSAxNjo0OA0KPiBUbzog
V2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+DQo+IENjOiBWbGFkaW1pciBPbHRlYW4gPHZsYWRp
bWlyLm9sdGVhbkBueHAuY29tPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsNCj4gRGF2aWQgUy4g
TWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBEdW1hemV0DQo+IDxlZHVtYXpldEBn
b29nbGUuY29tPjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBhb2xvIEFiZW5p
DQo+IDxwYWJlbmlAcmVkaGF0LmNvbT47IEFuZHJldyBMdW5uIDxhbmRyZXdAbHVubi5jaD47IEZs
b3JpYW4gRmFpbmVsbGkNCj4gPGYuZmFpbmVsbGlAZ21haWwuY29tPjsgTWF4aW0gR2VvcmdpZXYg
PGdsaXB1c0BnbWFpbC5jb20+OyBIb3JhdGl1IFZ1bHR1cg0KPiA8aG9yYXRpdS52dWx0dXJAbWlj
cm9jaGlwLmNvbT47IEvDtnJ5IE1haW5jZW50DQo+IDxrb3J5Lm1haW5jZW50QGJvb3RsaW4uY29t
PjsgTWF4aW1lIENoZXZhbGxpZXINCj4gPG1heGltZS5jaGV2YWxsaWVyQGJvb3RsaW4uY29tPjsg
UmljaGFyZCBDb2NocmFuDQo+IDxyaWNoYXJkY29jaHJhbkBnbWFpbC5jb20+OyBWYWRpbSBGZWRv
cmVua28NCj4gPHZhZGltLmZlZG9yZW5rb0BsaW51eC5kZXY+OyBHZXJoYXJkIEVuZ2xlZGVyDQo+
IDxnZXJoYXJkQGVuZ2xlZGVyLWVtYmVkZGVkLmNvbT47IEhhbmdiaW4gTGl1IDxsaXVoYW5nYmlu
QGdtYWlsLmNvbT47DQo+IEhlaW5lciBLYWxsd2VpdCA8aGthbGx3ZWl0MUBnbWFpbC5jb20+OyBK
YWNvYiBLZWxsZXINCj4gPGphY29iLmUua2VsbGVyQGludGVsLmNvbT47IEpheSBWb3NidXJnaCA8
ai52b3NidXJnaEBnbWFpbC5jb20+OyBBbmR5DQo+IEdvc3BvZGFyZWsgPGFuZHlAZ3JleWhvdXNl
Lm5ldD47IFNoZW53ZWkgV2FuZw0KPiA8c2hlbndlaS53YW5nQG54cC5jb20+OyBDbGFyayBXYW5n
IDx4aWFvbmluZy53YW5nQG54cC5jb20+Ow0KPiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAu
Y29tPjsgVU5HTGludXhEcml2ZXJAbWljcm9jaGlwLmNvbTsgTGFycw0KPiBQb3Zsc2VuIDxsYXJz
LnBvdmxzZW5AbWljcm9jaGlwLmNvbT47IFN0ZWVuIEhlZ2VsdW5kDQo+IDxTdGVlbi5IZWdlbHVu
ZEBtaWNyb2NoaXAuY29tPjsgRGFuaWVsIE1hY2hvbg0KPiA8ZGFuaWVsLm1hY2hvbkBtaWNyb2No
aXAuY29tPjsgU2ltb24gSG9ybWFuDQo+IDxzaW1vbi5ob3JtYW5AY29yaWdpbmUuY29tPjsgQ2Fz
cGVyIEFuZGVyc3Nvbg0KPiA8Y2FzcGVyLmNhc2FuQGdtYWlsLmNvbT47IFNlcmdleSBPcmdhbm92
IDxzb3JnYW5vdkBnbWFpbC5jb20+Ow0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2NyBuZXQtbmV4dCAwNi8xMF0gbmV0OiBmZWM6IGNvbnZlcnQgdG8NCj4gbmRvX2h3dHN0YW1w
X2dldCgpIGFuZCBuZG9faHd0c3RhbXBfc2V0KCkNCj4NCj4gT24gRnJpLCBKdWwgMTQsIDIwMjMg
YXQgMDM6MDU6MzZBTSArMDAwMCwgV2VpIEZhbmcgd3JvdGU6DQo+ID4gVGhhbmtzIQ0KPiA+IFJl
dmlld2VkLWJ5OiBXZWkgRmFuZyA8IHdlaS5mYW5nQG54cC5jb20gPg0KPg0KPiBQbGVhc2Ugbm90
ZSB0aGF0IGNvcnJlY3QgZm9ybWF0dGluZyBpczoNCj4NCj4gUmV2aWV3ZWQtYnk6IFdlaSBGYW5n
IDx3ZWkuZmFuZ0BueHAuY29tPg0KPg0KPiBObyBzcGFjZXMgYmV0d2VlbiB0aGUgPD4gYW5kIHRo
ZSBlbWFpbCBhZGRyZXNzIGl0c2VsZi4gSXQncyBleGFjdGx5IHRoZSBzYW1lDQo+IGZvcm1hdCB1
c2VkIGluIGVtYWlsIGhlYWRlcnMgb24gdGhlIEludGVybmV0Lg0KPg0KU29ycnkgZm9yIHRoZSB0
eXBvLCBJIHNob3VsZCBjaGVjayBiZWZvcmUgcmVwbHlpbmcuIDooDQo+IC0tDQo+IFJNSydzIFBh
dGNoIHN5c3RlbToNCj4gaHR0cHM6Ly93d3cuYXIvDQo+IG1saW51eC5vcmcudWslMkZkZXZlbG9w
ZXIlMkZwYXRjaGVzJTJGJmRhdGE9MDUlN0MwMSU3Q3dlaS5mYW5nJTQwDQo+IG54cC5jb20lN0M2
MDU0NWFiNzBjMTI0OGI2NWQ3NjA4ZGI4NDQ3MGU5YSU3QzY4NmVhMWQzYmMyYjRjNmZhDQo+IDky
Y2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM4MjQ5MjEyOTM5ODQ0OTQ1JTdDVW5rbm93biU3Q1QN
Cj4gV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJ
NklrMWhhV3dpTENKDQo+IFhWQ0k2TW4wJTNEJTdDMzAwMCU3QyU3QyU3QyZzZGF0YT00MjJqc0cl
MkJkMzF5bUp2VCUyRkJrbnRzbw0KPiBROEJJJTJCN2R6ZDBGY3p3YjJRbTRCMCUzRCZyZXNlcnZl
ZD0wDQo+IEZUVFAgaXMgaGVyZSEgODBNYnBzIGRvd24gMTBNYnBzIHVwLiBEZWNlbnQgY29ubmVj
dGl2aXR5IGF0IGxhc3QhDQoNCg==

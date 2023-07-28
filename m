Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A6C767036
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237225AbjG1PJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237206AbjG1PJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:09:30 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2086.outbound.protection.outlook.com [40.107.6.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF99644AA;
        Fri, 28 Jul 2023 08:09:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2V7BEu6O+vLuqAB81MPgkX0pgwMCk120W272mZK1SxHatD5nh8rL/Re/EehsHnqhRlZVllk/5ax4d17duS2SA0hxemO8VXmFBPfLeGe9BkZtlJ+UDOXgy7dQqvhtlrI+RJUfbMtTSsuct0C/JJGwvGS7/MAKCuyFE2WTw3Fd3yHeNArRa4qXq7p6/29IC+xbVLZt4u2qImk3j/A8bJ94SPnXftKtZjqLeimq+B7o/2uJpb4AfRoYlyNKsbCzUNFFEk7dOW3Tk7TCXXOGDkQfZVzuX4vmzZaHPmCfux36Q3jsUyaT5FnA0C0dbde3CySL9fidR04H2t3nfaL1c5aLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/GfOHRZQVfCTiHF3FwaTKXdsUAxcoO7aPxiuRy7gyw=;
 b=IzSkAJoTruXfPv0wOOh+q/+UswHI4cKbpGdd4BkwnZhG3TUZasCUWHRKz8Eun4YRkntBhzJbZarfTIZNdrPmL444PBVlTK3tlhxWVf9zrbxB6/T9QCJDAfZgTWXn8aJmo3467eDPLugjGQc6qNxuZyBDMmpt5WS9fSNTX7bDvYABppWsiudMLjct3hKwLstbC+6nkOsKfPlbkbsGfNL3nx5TGsnTM5hOKm6RWWUHbpSYDowjVceZ9lgQJaGmrLRCgvCN6+KCY5EqyyMdQT/wzyYcGbwVbmwhMjn/O6bEVkA6jhZn6Lmdtw3dZG+VFAnQlBo2Nn0zBKxaRhBdD0BKbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/GfOHRZQVfCTiHF3FwaTKXdsUAxcoO7aPxiuRy7gyw=;
 b=NjjEm5A5yOUw9sAMOn8+gxbpuXUiR5Viwy6B5tLXRB1fq6b8HH4XMWQ+mn9hVPG50TQ8ahijBP5tzc+i5YjGd0rMJEkk4eY2NCGB8/eB11d/HOrHEgDSh/TlY2iq4m5WDycXI77HmLgO110xzsQPH3WRq9gEZjMnvnsEs95dqNI=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DB8PR04MB7035.eurprd04.prod.outlook.com (2603:10a6:10:127::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 15:09:19 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 15:09:19 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>, Andrew Lunn <andrew@lunn.ch>
CC:     Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Simon Horman <simon.horman@corigine.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Wong Vee Khee <veekhee@apple.com>,
        Revanth Kumar Uppala <ruppala@nvidia.com>,
        Jochen Henneberg <jh@henneberg-systemdesign.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        Frank Li <frank.li@nxp.com>
Subject: RE: [EXT] Re: [PATCH v2 net 2/2] net: stmmac: dwmac-imx: pause the
 TXC clock in fixed-link
Thread-Topic: [EXT] Re: [PATCH v2 net 2/2] net: stmmac: dwmac-imx: pause the
 TXC clock in fixed-link
Thread-Index: AQHZwJ6ZmPtrsmRv9UGenRTta+C4Xq/PBDcAgABC5IA=
Date:   Fri, 28 Jul 2023 15:09:19 +0000
Message-ID: <PAXPR04MB9185945F7E5B1A36ADF4F3E28906A@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20230727152503.2199550-1-shenwei.wang@nxp.com>
 <20230727152503.2199550-3-shenwei.wang@nxp.com>
 <CAOMZO5ANQmVbk_jy7qdVtzs3716FisT2c72W+3WZyu7FoAochw@mail.gmail.com>
In-Reply-To: <CAOMZO5ANQmVbk_jy7qdVtzs3716FisT2c72W+3WZyu7FoAochw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|DB8PR04MB7035:EE_
x-ms-office365-filtering-correlation-id: 900c1f95-3025-4dfd-c987-08db8f7c9e08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MCmEIGvRzsO09RKNzoc8bB7+jHBXa83O7qLExEEVKyE7kYl/HCCj0ws6ZmT1xImCAq83YqqiSFj+8aYnsibVFdMaKI+EnuD05qhj9sYrseacS/nvli4JVPV0CJEpgoRDZqNywdzW+KA8pXKXmDC0z5ui7t5EgicjuBZTeLj7CVEM8anFxSTZk1ad7cnbF3VOvc1InkWWDgS26OkcW33MeTfDyX1GFs7zbTYVHWBFgDMzf4l/sYiF+2QOz7ZSfKkS8P/vKSvK0HKR0wcqwcewORl8Wm59QD2kgqxy6zDZbnZ9I1JHKfIllodXhZtZ6LSfKruli+VE4MAv/1Z45sjx/5zwiYPI8aPw3cf0beYjlsPtGXa4XriXvW8wCr/4pcdZCcdGW4r/Cka7lKJwnm5sBWVGckwRBK/V7eEOQdF6Bx1LnJAqY4vw1J7us2TK5hA7Vj4VfRRYrWZVi4d32/DgrFpqJ3lAJ0HEI+Pkan/1tQwGo7xZ6/7/1B1o9+PpJkPzcFYKSNe2XNxQXUNCjsktJZU/aemw4W+07hmIhk9sIE+mFiAd2Vi0yhQS1SfGfQHArifFWlO02mdQbCABS5TWax0wCAmeLstd4q8iM5WCMx5HewKq4LHlxSFbZvapfIIb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(451199021)(316002)(2906002)(8936002)(8676002)(52536014)(7406005)(5660300002)(7416002)(38070700005)(44832011)(41300700001)(33656002)(55016003)(86362001)(7696005)(71200400001)(122000001)(26005)(6506007)(53546011)(55236004)(186003)(110136005)(54906003)(9686003)(478600001)(66946007)(66556008)(76116006)(83380400001)(38100700002)(64756008)(66476007)(4326008)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MllUVDVXbExpdWVoVm9CVGJCNkRTNlN3aEFheEsvai9Yd3ROSG5TdXFDNEl6?=
 =?utf-8?B?MVJmUDNPbVJ1QUYzRUhWeTJwdDBUZkt6S2tJU1pnK05lTXRzWCsxL1hYcU00?=
 =?utf-8?B?Tk5PK083bFl6clhXSFZRcFpGNEpHNmFHRFlrWG1WKzZoUlRpVVFJemhsRjl1?=
 =?utf-8?B?VEYwd1lXM09ndGxHNHkwV3poMVVJM1BhNHhRNWRHQmZ1T1hXV3pra3VpWlgr?=
 =?utf-8?B?U1ZqN1ZlT1dTK2hkZ2M1aE1Pdm10OE1JWnhTYlVaeC9qK3pCc1hMK0JMeW4v?=
 =?utf-8?B?bXpGcW1vb29JSkdwM2RaRmF6aFF4RUsxTjNTWnhPM3htM09lZ2tBSVV5L0dO?=
 =?utf-8?B?TXpuUmRHaGhBdnNGWWVORFUwTVhMQVpzSWxnckR4bjlFU0xFYjExU3JST1BZ?=
 =?utf-8?B?bDM2Tjg0SXdZQW5say81bzVKQUZBQVBNNjBNKy9XdkxpeXh6MVQyTDM1akoy?=
 =?utf-8?B?NExMRkw2NCtYNjA1d1VSSko4bjNyeHdSdGp0TUpkeWFUWEpkU2wwOHZCaU9O?=
 =?utf-8?B?QU1kZW51blUxdFJqd2F1UHdaRnNRK2U2WS9YKzFjZ2Y1WGNINVFUZy9UNU44?=
 =?utf-8?B?WTJYUW1DUGphcGNCQjVaZ1VNYWVaWDF5dTF1MlBVYmMwMVNKUmhXMlV4dFJv?=
 =?utf-8?B?RzNhSmUvYitmOSt6QnNKSkZyTmVXV0lhdkcvc0hzYVRTOGsrV1l1eHhZT1FK?=
 =?utf-8?B?MUhhdmRRMmorZFh0Tk1ibVpacVVORzlKTzhlREtoU3RMaituY1NLeC93eXhE?=
 =?utf-8?B?M2drRmRSTXM2TE1oTlFCUEJqSGcyMkRjRXhMYU95TnRsVkJEVEc4ZFBXdkdF?=
 =?utf-8?B?RkhqbitSZVowRlpRbGppNDJRYmR2Wi9qWXhMR1Q3MTRtVFk0cWtEM0FNbVVF?=
 =?utf-8?B?aU9sL0t1VTBuSUlSMExtdzdWZU8zbWxHQ0p2THZ2MkhMQVV1SFJpR2ZUeTd0?=
 =?utf-8?B?Yjh4T1JZaGo3QlpjRDVPZWhVWjNVK1RPSjdnbWVtOTA1MGJsZEcydUVMV21V?=
 =?utf-8?B?cGovU2hSU2o0YjdWZ3FCMk10ang5ZmxkV3BCVC9SUXVIdTVHQVpPM2p1STZJ?=
 =?utf-8?B?dk4zMyt6b1dPZ0ZKdUZ3QkE5ejIrRjVmRXFIZHp1THMvOWJMM0VtaVN2dUdH?=
 =?utf-8?B?bEh6Rkdod1dmdkJ6V0Q1SXhYd1JwaVdkakxmemVjUE1KYnJlNXNXWTAxUERv?=
 =?utf-8?B?OVZVb0xISW5PMjJESGQyOWpVbXR0OXJBdnh5UE1DVzF5LzkxWm52YVZZbzUr?=
 =?utf-8?B?NGphQWlESm52MUpOdE9JVUo4Ym1BWGRBZmxwbzE4ditENzFqM2licVg3c1ZY?=
 =?utf-8?B?a1djdmhwazBoTXRCcS9LSzNKT0NzaE4yajl2Tk9hNjRZS2YzNHMwR1FUZlRK?=
 =?utf-8?B?TW5abFZHV2RVaEhQYmlYalNxZy9sUE0yeFZEaUlQaGplcEV6T0hmWWtYYVc1?=
 =?utf-8?B?bHBrM3VVRW56RTlTQ2crUGpMNVBYUkx3TlBWNHlJK0pNZXdYVStmRkNIRy9M?=
 =?utf-8?B?alloVnlCMVdWeHZMRXd5cVBWbWVGMzVNWkUzbGhTekRrVGtTMkg1NTlMS0hl?=
 =?utf-8?B?dTNVWVBYbHZSd1UxcXNRK21pNWV6ckc1T1crdjZYSU1YOWpITlhNeFFCZVNI?=
 =?utf-8?B?NERoakR5WjN1Z3BqbEh3RnlyRWhXZFk0d2ZGOFo0S1VsclhDSVltSkprY0VD?=
 =?utf-8?B?TENkWjdXUjMrU2xhOWo0L3F6NzFYek5ZTll1NEYwQVhPeVJSZFpoTHJ4Y3I0?=
 =?utf-8?B?QTlHV1o3OUNhSzJtaXM3ODYvQlBOMGdhb2hxaHF0a3ZMTS90dWFvNHZVMkk3?=
 =?utf-8?B?bTZaSTZTRW1sWVdZV0ltdjNPeVgvQ2svNHpNU3RBeDVjY2dTbDMzQmxWK2dt?=
 =?utf-8?B?WS9mMndWLzR4N3VxdWsvcTd6V05HV3BjaXByRW5UVi9JREExVUx2TlQ2b0VG?=
 =?utf-8?B?TGZ2NmZINVpyN3J6TWVwQ0lhM1RVT1pVU3pKb0NBOE16d0FLRklvbUtnQmtv?=
 =?utf-8?B?OUx3Q2tybWVsSitrWnNvQzBRb0k1MUEwUFpFVlBYUFNVVGJ1SzRXOU9lcGxS?=
 =?utf-8?B?MXlBUGkzajNxYzNJTm1rN3YwU2pJMW5ITGdIODNJdStBRy9Ddk9MaTBEYWVv?=
 =?utf-8?Q?f6oUNJ2V6XIKPI/JVmHYAuDb7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 900c1f95-3025-4dfd-c987-08db8f7c9e08
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 15:09:19.3107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KcsrBtK2NDvrgNRRL3rAWyEWEefkhSedBpzCraMCKPK57sZemOXqIOtF2kMARMLIEdveBDmoR1iTfxPIDUKpbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7035
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmFiaW8gRXN0ZXZhbSA8
ZmVzdGV2YW1AZ21haWwuY29tPg0KPiBTZW50OiBGcmlkYXksIEp1bHkgMjgsIDIwMjMgNjowMSBB
TQ0KPiBUbzogU2hlbndlaSBXYW5nIDxzaGVud2VpLndhbmdAbnhwLmNvbT47IEFuZHJldyBMdW5u
IDxhbmRyZXdAbHVubi5jaD4NCj4gQ2M6IFJ1c3NlbGwgS2luZyA8bGludXhAYXJtbGludXgub3Jn
LnVrPjsgRGF2aWQgUy4gTWlsbGVyDQo+IDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBEdW1h
emV0IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWINCj4gS2ljaW5za2kgPGt1YmFAa2VybmVs
Lm9yZz47IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT47IE1heGltZQ0KPiBDb3F1ZWxp
biA8bWNvcXVlbGluLnN0bTMyQGdtYWlsLmNvbT47IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVs
Lm9yZz47DQo+IFNhc2NoYSBIYXVlciA8cy5oYXVlckBwZW5ndXRyb25peC5kZT47IE5laWwgQXJt
c3Ryb25nDQo+IDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPjsgS2V2aW4gSGlsbWFuIDxraGls
bWFuQGJheWxpYnJlLmNvbT47IFZpbm9kDQo+IEtvdWwgPHZrb3VsQGtlcm5lbC5vcmc+OyBDaGVu
LVl1IFRzYWkgPHdlbnNAY3NpZS5vcmc+OyBKZXJuZWogU2tyYWJlYw0KPiA8amVybmVqLnNrcmFi
ZWNAZ21haWwuY29tPjsgU2FtdWVsIEhvbGxhbmQgPHNhbXVlbEBzaG9sbGFuZC5vcmc+Ow0KPiBH
aXVzZXBwZSBDYXZhbGxhcm8gPHBlcHBlLmNhdmFsbGFyb0BzdC5jb20+OyBBbGV4YW5kcmUgVG9y
Z3VlDQo+IDxhbGV4YW5kcmUudG9yZ3VlQGZvc3Muc3QuY29tPjsgSm9zZSBBYnJldSA8am9hYnJl
dUBzeW5vcHN5cy5jb20+Ow0KPiBQZW5ndXRyb25peCBLZXJuZWwgVGVhbSA8a2VybmVsQHBlbmd1
dHJvbml4LmRlPjsgZGwtbGludXgtaW14IDxsaW51eC0NCj4gDQo+IA0KPiBPbiBUaHUsIEp1bCAy
NywgMjAyMyBhdCAxMjoyNeKAr1BNIFNoZW53ZWkgV2FuZyA8c2hlbndlaS53YW5nQG54cC5jb20+
DQo+IHdyb3RlOg0KPiANCj4gPiAgICAgICAgIHN0cnVjdCBwbGF0X3N0bW1hY2VuZXRfZGF0YSAq
cGxhdF9kYXQgPSBwcml2OyBAQCAtMzE3LDgNCj4gPiArMzU5LDExIEBAIHN0YXRpYyBpbnQgaW14
X2R3bWFjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gICAgICAgICBw
bGF0X2RhdC0+ZXhpdCA9IGlteF9kd21hY19leGl0Ow0KPiA+ICAgICAgICAgcGxhdF9kYXQtPmNs
a3NfY29uZmlnID0gaW14X2R3bWFjX2Nsa3NfY29uZmlnOw0KPiA+ICAgICAgICAgcGxhdF9kYXQt
PmZpeF9tYWNfc3BlZWQgPSBpbXhfZHdtYWNfZml4X3NwZWVkOw0KPiA+ICsgICAgICAgaWYgKG9m
X21hY2hpbmVfaXNfY29tcGF0aWJsZSgiZnNsLGlteDkzIikpDQo+ID4gKyAgICAgICAgICAgICAg
IHBsYXRfZGF0LT5maXhfbWFjX3NwZWVkID0gaW14X2R3bWFjX2ZpeF9zcGVlZF9teDkzOw0KPiAN
Cj4gU28geW91IGFyZSBmb3JjaW5nIHRoaXMgb24gYWxsIGlteDkzIGJvYXJkcywgZXZlbiBpZiB0
aGV5IGRvbid0IHVzZSBhIFNKQTExMDUuDQo+IA0KDQpZZXMsIHRoYXQncyB0aGUgcHVycG9zZSBi
ZWNhdXNlIGl0IHdvbid0IGh1cnQgZXZlbiB0aGUgb3RoZXIgc2lkZSBpcyBub3QgU0pBMTEwNS4N
Cg0KPiBBbmRyZXcgTHVubiBnYXZlIHRoZSBmb2xsb3dpbmcgZmVlZGJhY2sgaW4gdjE6DQo+IA0K
PiAiVGhlIFNKQTExMDUgaGFzIHRoZSBwcm9ibGVtLCBzbyBpIHdvdWxkIGV4cGVjdCBpdCB0byBi
ZSBpbnZvbHZlZCBpbiB0aGUgc29sdXRpb24uDQo+IE90aGVyd2lzZSwgaG93IGlzIHRoaXMgZ29p
bmcgdG8gd29yayBmb3Igb3RoZXIgTUFDIGRyaXZlcnM/DQo+IA0KPiBNYXliZSB5b3UgbmVlZCB0
byBleHBvc2UgYSBjb21tb24gY2xvY2sgZnJhbWV3b3JrIGNsb2NrIGZvciB0aGUgVFhDIGNsb2Nr
DQo+IGxpbmUsIHdoaWNoIHRoZSBTSkExMTA1IGNhbiBkaXNhYmxlL2VuYWJsZT8gVGhhdCB0aGVu
IG1ha2VzIGl0IGNsZWFyIHdoYXQgb3RoZXINCj4gTUFDIGRyaXZlcnMgbmVlZCB0byBkby4iDQoN
CkkgaGF2ZSBiZWVuIGNvbnNpZGVyaW5nIHRoaXMgcGxhbiBmb3Igc29tZSB0aW1lLiBUaGUgaWRl
YSBzaG91bGQgYmUgaW1wbGVtZW50ZWQgDQphY3Jvc3MgYWxsIGkubXg4LzkgcGxhdGZvcm1zLiBJ
IGFtIGdvaW5nIHRvIHN0YXJ0IHRvIHdvcmsgb24gaXQgaW4gdGhlIGZvbGxvd2luZyBtb250aCwg
DQphbmQgaXQgd2lsbCB0YWtlIHNvbWUgdGltZSB0byBpbXBsZW1lbnQgaXQuDQoNClRoYW5rcywN
ClNoZW53ZWkNCg0KDQoNCg==

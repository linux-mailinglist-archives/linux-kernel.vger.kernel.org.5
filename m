Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CE076BCBA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjHASoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 14:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbjHASn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:43:57 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED002689;
        Tue,  1 Aug 2023 11:43:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELU6e42YgUUrLZYtqKEnh7jHf44Gigho5sn+bbGodSf+GopYMuSfFWfI6+f45QK7Lbzq15oJK3gV0ZJpOnMzlyihQBbKmbrDy9P9D5u571ow6Rd9ox0cfF3tYxyEo+2v0whBlLFb9t2BEzX5hq/M8jYsfVxZJiLSWVa/IhsWPGllnbXORhNUR1LVv02oTVvaf9n6+z5g4+NkWXMjpntzWuX5Scwj1n7xEC1KymitmybyTtyMTsbu5rjaV5sNuSOIxaAWl6lUGNA4V9tUu6Huo+tXwXtRXDQB+z0YiFWpiZt7mXqcqT1l8My5wX3uOoVvlmpOhFsDxb/6BXWl7sLxOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRMpUiIgV4YOn1vTWrmLmaUylJzonpyfehM2T1xathU=;
 b=cqhk2iYOcnXW1Ci6sJx7LWndR4NBWIKmpsR6DH4TPAYnQZDO/E+VB/nVrhYkZWwfkH3afg9BQnBA3qMZ0/Fnsrifvxn7Qs/BmLNjD/TM0k0tmCbo9kTbUWW74ZXpUP+UacNwEC2gFLJE19EK1AmWrHZ2EBcMJLOl8LGqcZNM4PUsFSZe4qqWPqfRGjWxBIB/UZUrJqj1gXEN/0+boDkLfTpe7pfnlxA7oql1+Hf+lhgzKvEJ7XT/74V1nLtwonOE/eoqJ4pq6dg6YxHFDZXcpFg76vhoGZYwZkevqaDZZjh2zGmNQ5nfYqLacbpg4E5XQfdvUqr/w3ahgrKGgyUsVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRMpUiIgV4YOn1vTWrmLmaUylJzonpyfehM2T1xathU=;
 b=havft8qnPRaJS8YPIYEGGsZNtegoloRZF6u3tgmKufhXzYCX8suSi0mo6zSJu2uesE7svQi+f/l8czLkbub6MMcP427/svXMmmU319SQQYFiVubvYeZuS9vDIEcfaftnS2D0+VxTPhuaXpxMA69mWkDws3eWlzo3CYoxWeRvTpQ=
Received: from AS8PR04MB9176.eurprd04.prod.outlook.com (2603:10a6:20b:44b::7)
 by AM7PR04MB6952.eurprd04.prod.outlook.com (2603:10a6:20b:107::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Tue, 1 Aug
 2023 18:43:52 +0000
Received: from AS8PR04MB9176.eurprd04.prod.outlook.com
 ([fe80::f75:1e4c:6201:d003]) by AS8PR04MB9176.eurprd04.prod.outlook.com
 ([fe80::f75:1e4c:6201:d003%6]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 18:43:52 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
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
        Jose Abreu <joabreu@synopsys.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        Simon Horman <simon.horman@corigine.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Wong Vee Khee <veekhee@apple.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Revanth Kumar Uppala <ruppala@nvidia.com>,
        Jochen Henneberg <jh@henneberg-systemdesign.com>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: RE: [EXT] Re: [PATCH v3 net 1/2] net: stmmac: add new mode parameter
 for fix_mac_speed
Thread-Topic: [EXT] Re: [PATCH v3 net 1/2] net: stmmac: add new mode parameter
 for fix_mac_speed
Thread-Index: AQHZw8rncXkT+tBv7kuTZDED3nHZB6/U/amAgADJUBA=
Date:   Tue, 1 Aug 2023 18:43:52 +0000
Message-ID: <AS8PR04MB9176FC45B9663B5BF964F58A890AA@AS8PR04MB9176.eurprd04.prod.outlook.com>
References: <20230731161929.2341584-1-shenwei.wang@nxp.com>
 <20230731161929.2341584-2-shenwei.wang@nxp.com>
 <20230801-portside-prepaid-513f1f39f245-mkl@pengutronix.de>
In-Reply-To: <20230801-portside-prepaid-513f1f39f245-mkl@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB9176:EE_|AM7PR04MB6952:EE_
x-ms-office365-filtering-correlation-id: fbb8f1a1-2d49-4e73-0670-08db92bf40aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +3QGJlznFuTwBhP/AyH0WSD51VCnWl0HzStGgM60N7I2NccN5lGyysxa8iUc8rJVwab4CVc7yT9czRWDUPrWpFNdiigKV9hwL02c4lu5b4useiWA88UveEOR+JFvSruthuBQtQuAkssYCuvc3y3XTgzPEEEKVF0wkqPsBU+1rgxVsuMqEhgw4ijCNXl3qVrM4+ZigggLhk74E9tIkc5tvFnlOi01vFbvKYb9F8/2oEvRRKRUv9j1/qUu6eXi3MoDQJRBGzXkbRRqqmuN0QuelvBnQeIKwm3Oek6KrsqOImAjmN85vIxvo2ryqrLPcON/6t59CTgvjOL3JRry//6kBe1ZkoK4PiNMgbLLJSjpVXwOjfh1U+4MAWtN06OXnrnp7K6Etg3QaVmBvC/HojhYTPUg37Nxup2CRmZJE3jDNfS6By686ebt3FzkJAIbCoiYgG0sCv6b2NT4xmG36b8rcD+Jij1fijFyoIH5Tl1EeHIz5NOW6LvfKhbrmKXJN84+mBBJZpFEqPjqYRKhDddhtvGv24M+gpgS89cJ+YJsmDPDhFp7Ci4XH93eRkj5qLY9QM2HnVQtxeePZrFly9t3A2rgV+ZRmzhG+AT6G4Jeyq0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9176.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(451199021)(66946007)(2906002)(76116006)(64756008)(66476007)(6916009)(66446008)(4326008)(66556008)(7696005)(33656002)(478600001)(71200400001)(86362001)(966005)(9686003)(83380400001)(186003)(122000001)(38070700005)(26005)(6506007)(38100700002)(55236004)(53546011)(54906003)(55016003)(41300700001)(52536014)(8676002)(8936002)(5660300002)(44832011)(7416002)(316002)(7406005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXN4ZTUramo1VmliMGlnYXdmVzFpY3ZtOC8xNjlEMzVPVWZPQndSY3ZOd0JH?=
 =?utf-8?B?MnhVb3hiZnh1RmNZM3cyUHVubDBscWpQYWt2VUcwK1I1Y3BQMUsydnpJTnB5?=
 =?utf-8?B?MkdGNjlvdzNwNGJhYkVHVDhZZ0VFTzlvWkxMSDIzQjNwVFgvWWliRkQ4M29J?=
 =?utf-8?B?eGM3N3BPR3JSWVRDU1UwUEVzd0tZUTBXdDlVNGJycSsrODcybWdTdHowaXBC?=
 =?utf-8?B?emYzNXFnUkdIRFhZd2dlMVZuNDZpc2FDZldFMmJVbXRDdU5WdVg3RGFySFFv?=
 =?utf-8?B?N0h3ejY4S1BCdmhETGhpZ0VUcmx6YSs5ejE0UXp3V2lZTDNKTHdDTGR1NVJk?=
 =?utf-8?B?STBNdWN3bXl1b0lZTEYvaUpvRGVWM3U3cytkZUFqdURaZVJ3SWZrRzB0VTFQ?=
 =?utf-8?B?Wk0veTlrVXJtY3NIcFRLdHlZL3d1ZS9BQmVFNmlrWHhoWTk0Y1FXVHNicDNw?=
 =?utf-8?B?RnM4UmxLYll2cEhlNkdTWXNGZzB5NmUyalBiWHA1eEpTQ1dYTHQ2d25tdzA4?=
 =?utf-8?B?cXg4allhLy9UZmpHRXEvQW9ERTdtekVsaTVQYk9hcW1sVnJWa05Ra3JrV0Nw?=
 =?utf-8?B?OHAxV1EvQ3hwbzdmSmJZN0x3U0U0VUt6aTd0WnFhR3pBVkM3RC9yaUhKNFIx?=
 =?utf-8?B?ME9TR1lmWkFmUmx3TFo5NjBWWitLVFZpVS9DTGhkeGhRZVZMYjFDbkQveVhs?=
 =?utf-8?B?OWdSbjlmeEcvUFBUclhwSngzYXJKelJFVkVZOWwzL2dMcW5JQVh3NkFxWEJY?=
 =?utf-8?B?UkE3bjVzc0tpM2NDWXhJSGxtbVdaVHRQUUdnTTNxTDB2dXdIUlJBa0tVM3NQ?=
 =?utf-8?B?QXM4REkwRjlIbTJhS05RQUprejFUNnVxRzVLNytLWCtCcTZKVUdWYVJVUU0y?=
 =?utf-8?B?SjFheUJtTHR0UjVtdFhNYXFCMWFHSFZVM1NWKzR6RFBKWXhpcWlOcURvbGlq?=
 =?utf-8?B?amN0bUVWYkFKVXJLMDg3b1I3dnIwQkcrbjdIVUM1c2k0UHQ5NHhoVm5ZSW9D?=
 =?utf-8?B?MHJIejhJM2ZOVWxWa3RaTjhYd21KWUdQYjZIeVdNWlFXTmpVdmx0ektSWHE1?=
 =?utf-8?B?a2pKa3Jzcy8zT0dod1cwTnVRUXoyd1c5S3ZCRHE4aXV2RnVmK0VWcHFtbEdF?=
 =?utf-8?B?K3hDdStldmpVbGpVL0pTNStVNGgxKzFDd0syUktmU053WFFCK3FnMWdwUHp6?=
 =?utf-8?B?bGZlczdYVnVjYWlYcFVpOHhDR0FkU216bWcwdUt4UVFmc0l2ZVFsRDVaV1FK?=
 =?utf-8?B?dis2dkpFSHRzMDdoWjB3Vm82b0w1Y1ozc1F1MTlaTlNTeUhFWlpGNFRKMVZk?=
 =?utf-8?B?dUMvVGxvTjFoV1NDSzQ2Q2grR1pRT3FidUNGeFpUVWphMmpSR295TklCUVhQ?=
 =?utf-8?B?eUNCcGREQm9aOXBsT2t1MmFvQ0poK2REajFjMS9uME1qanhIdC9HZDYyNXlo?=
 =?utf-8?B?K1F2a2NpeGJXUWt5a0plUE9haU9RM1E3Q3I4M25NdFczOWVuS1pwWmlPZHRH?=
 =?utf-8?B?Uzc5bEFIV2cwNXdtMWFWWEpTRG1VV2Q3OVA3VVZaNmg0UVBuZEF3dFRmZEY0?=
 =?utf-8?B?eUpYU09uYkRzNEgvamptRXduZ2VYOCtIME5KMzFJVmxkSVQ0YnlOY3lZK2dI?=
 =?utf-8?B?c3duZER3UmlDT0xEeDY5VDhEVWtMR25JWXJuRHNwbnVRUnJ1S1RPSlNTWHFr?=
 =?utf-8?B?TzJ0NlA5aGFwRjU5Z2NRUTBxOWtXOG94VzdJcEJJaXNJSWJsY251WW01bHZq?=
 =?utf-8?B?c2ZIdGZZcjkwUVl4UXRzZ2pyWnhxWUcwVitJeGEweHBDcitYU1ByQi9Sc1pS?=
 =?utf-8?B?UzZqVVZTWnFWZyt5ejJnT0xsTGxzeHdQYVdBb0d1UDJoSzJNcmxMOFlXTm03?=
 =?utf-8?B?WjRiYjhrNmJOamRSblQ4ZmZobm9qSlZ4UDJZZWk2aHo3UWRoVnF6aHhqTDcy?=
 =?utf-8?B?MUpwNnNKdCtBL1VHcDJmL2F3ejdpK2NEb2VodkNDejV1S3pJZmdiY0QzUTAx?=
 =?utf-8?B?UmZYVTRFZ3VBYVNsSnYreXFrc2laREN1WDNvVGRnMDNIUXNONDZRVjlxcDRN?=
 =?utf-8?B?dWJPd0c1OW9GeUtGVnU2bkZTa2FiaEFQZW9Ndjd1UW96TVcwSUpnbjFOUzJ6?=
 =?utf-8?Q?reJwu8H+1i8yjppUUqg7z6g1V?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9176.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb8f1a1-2d49-4e73-0670-08db92bf40aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 18:43:52.4178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OUlAS0uE7OiSv51aQC1wcyaQBWj9dxfL0xxmvnWW2HtJmhO8HNnK1pQpCDPodXuY4A7xcYjh3itwTvGrFTlS4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6952
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyYyBLbGVpbmUtQnVk
ZGUgPG1rbEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogVHVlc2RheSwgQXVndXN0IDEsIDIwMjMg
MTozNyBBTQ0KPiBUbzogU2hlbndlaSBXYW5nIDxzaGVud2VpLndhbmdAbnhwLmNvbT4NCj4gQ2M6
IFJ1c3NlbGwgS2luZyA8bGludXhAYXJtbGludXgub3JnLnVrPjsgRGF2aWQgUy4gTWlsbGVyDQo+
IDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29t
PjsgSmFrdWINCj4gS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBhb2xvIEFiZW5pIDxwYWJl
bmlAcmVkaGF0LmNvbT47IE1heGltZQ0KPiBDb3F1ZWxpbiA8bWNvcXVlbGluLnN0bTMyQGdtYWls
LmNvbT47IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz47DQo+IFNhc2NoYSBIYXVlciA8
cy5oYXVlckBwZW5ndXRyb25peC5kZT47IE5laWwgQXJtc3Ryb25nDQo+IDxuZWlsLmFybXN0cm9u
Z0BsaW5hcm8ub3JnPjsgS2V2aW4gSGlsbWFuIDxraGlsbWFuQGJheWxpYnJlLmNvbT47IFZpbm9k
DQo+IEtvdWwgPHZrb3VsQGtlcm5lbC5vcmc+OyBDaGVuLVl1IFRzYWkgPHdlbnNAY3NpZS5vcmc+
OyBKZXJuZWogU2tyYWJlYw0KPiA8amVybmVqLnNrcmFiZWNAZ21haWwuY29tPjsgU2FtdWVsIEhv
bGxhbmQgPHNhbXVlbEBzaG9sbGFuZC5vcmc+OyBKb3NlDQo+IEFicmV1IDxqb2FicmV1QHN5bm9w
c3lzLmNvbT47IGlteEBsaXN0cy5saW51eC5kZXY7IFNpbW9uIEhvcm1hbg0KPiA8c2ltb24uaG9y
bWFuQGNvcmlnaW5lLmNvbT47IEFsZXhhbmRyZSBUb3JndWUNCj4gPGFsZXhhbmRyZS50b3JndWVA
Zm9zcy5zdC5jb20+OyBHaXVzZXBwZSBDYXZhbGxhcm8NCj4gPHBlcHBlLmNhdmFsbGFyb0BzdC5j
b20+OyBOb2J1aGlybyBJd2FtYXRzdQ0KPiA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28u
anA+OyBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+Ow0KPiBsaW51eC1zdG0zMkBz
dC1tZC1tYWlsbWFuLnN0b3JtcmVwbHkuY29tOyBKZXJvbWUgQnJ1bmV0DQo+IDxqYnJ1bmV0QGJh
eWxpYnJlLmNvbT47IEJhcnRvc3ogR29sYXN6ZXdza2kNCj4gPGJhcnRvc3ouZ29sYXN6ZXdza2lA
bGluYXJvLm9yZz47IFdvbmcgVmVlIEtoZWUgPHZlZWtoZWVAYXBwbGUuY29tPjsgZGwtDQo+IGxp
bnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBBbmRyZXcgSGFsYW5leSA8YWhhbGFuZXlAcmVk
aGF0LmNvbT47DQo+IEJodXBlc2ggU2hhcm1hIDxiaHVwZXNoLnNoYXJtYUBsaW5hcm8ub3JnPjsg
TWFydGluIEJsdW1lbnN0aW5nbA0KPiA8bWFydGluLmJsdW1lbnN0aW5nbEBnb29nbGVtYWlsLmNv
bT47IFJldmFudGggS3VtYXIgVXBwYWxhDQo+IDxydXBwYWxhQG52aWRpYS5jb20+OyBKb2NoZW4g
SGVubmViZXJnIDxqaEBoZW5uZWJlcmctc3lzdGVtZGVzaWduLmNvbT47DQo+IGxpbnV4LWFtbG9n
aWNAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnOw0KPiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBQZW5ndXRyb25peCBLZXJuZWwNCj4gVGVhbSA8a2VybmVsQHBlbmd1dHJvbml4LmRlPg0K
PiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIHYzIG5ldCAxLzJdIG5ldDogc3RtbWFjOiBhZGQg
bmV3IG1vZGUgcGFyYW1ldGVyDQo+IGZvciBmaXhfbWFjX3NwZWVkDQo+IA0KPiBPbiAzMS4wNy4y
MDIzIDExOjE5OjI4LCBTaGVud2VpIFdhbmcgd3JvdGU6DQo+ID4gQSBtb2RlIHBhcmFtZXRlciBo
YXMgYmVlbiBhZGRlZCB0byB0aGUgY2FsbGJhY2sgZnVuY3Rpb24gb2YNCj4gPiBmaXhfbWFjX3Nw
ZWVkIHRvIGluZGljYXRlIHRoZSBwaHlzaWNhbCBsYXllciB0eXBlLg0KPiA+DQo+ID4gVGhlIG1v
ZGUgY2FuIGJlIG9uZSB0aGUgZm9sbG93aW5nOg0KPiA+IAlNTE9fQU5fUEhZCS0gQ29udmVudGlv
bmFsIFBIWQ0KPiA+IAlNTE9fQU5fRklYRUQJLSBGaXhlZC1saW5rIG1vZGUNCj4gPiAJTUxPX0FO
X0lOQkFORAktIEluLWJhbmQgcHJvdG9jb2wNCj4gPg0KPiA+IEFsc28gdXNlIHNob3J0IHZlcnNp
b24gb2YgJ3VpbnQnIHRvIHJlcGxhY2UgdGhlICd1bnNpZ25lZCBpbnQnIGluIHRoZQ0KPiA+IGZ1
bmN0aW9uIGRlZmluaXRpb25zLg0KPiANCj4gVGhlcmUgYXJlIG5vdCBtYW55IHVzZXJzIG9mICd1
aW50JyBpbiB0aGUga2VybmVsIGFuZCBpdCdzIG5vdCB1c2VkIGluIHRoZSBzdG1tYWMNCj4gZHJp
dmVyIHNvIGZhci4gRnJvbSBteSBwb2ludCBvZiB2aWV3IEkgd291bGQgbm90IGludHJvZHVjZSBp
dCBhbmQgc3RpY2sgdG8gdGhlDQo+IHN0YW5kYXJkICd1bnNpZ25lZCBpbnQnLg0KPiANCg0KVXNp
bmcgJ3VpbnQnIG1ha2VzIHRoZSBjb2RlIGxvb2sgY2xlYW5lciBiZWNhdXNlIGFkZGluZyBvbmUg
ZXh0cmEgcGFyYW1ldGVyIG1heSBjYXVzZSBzb21lIGZ1bmN0aW9uIA0KZGVjbGFyYXRpb25zIHRv
IHNwYW4gbXVsdGlwbGUgbGluZXMuICBUaGlzIGNoYW5nZSBrZWVwcyBmdW5jdGlvbiBkZWNsYXJh
dGlvbnMgY29tcGFjdCBvbiBhIHNpbmdsZSBsaW5lLg0KDQpUaGFua3MsDQpTaGVud2VpDQoNCj4g
SnVzdCBteSAyIGNlbnQsDQo+IE1hcmMNCj4gDQo+IC0tDQo+IFBlbmd1dHJvbml4IGUuSy4gICAg
ICAgICAgICAgICAgIHwgTWFyYyBLbGVpbmUtQnVkZGUgICAgICAgICAgfA0KPiBFbWJlZGRlZCBM
aW51eCAgICAgICAgICAgICAgICAgICB8IGh0dHBzOi8vd3d3LnBlbmd1dHJvbml4LmRlIHwNCj4g
VmVydHJldHVuZyBOw7xybmJlcmcgICAgICAgICAgICAgIHwgUGhvbmU6ICs0OS01MTIxLTIwNjkx
Ny0xMjkgfA0KPiBBbXRzZ2VyaWNodCBIaWxkZXNoZWltLCBIUkEgMjY4NiB8IEZheDogICArNDkt
NTEyMS0yMDY5MTctOSAgIHwNCg==

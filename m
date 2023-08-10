Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBE4777029
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 08:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjHJGR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 02:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjHJGR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 02:17:56 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2089.outbound.protection.outlook.com [40.107.20.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360FBA6;
        Wed,  9 Aug 2023 23:17:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+KljN3Xfo32e1nbnzXM2WUjOwbltxCPh7QZfywgyHcVkjWmKiVvFGz/iFy7KQxmIDMAAljezIjcLnc9cMrtpdcPD/MuvDnkT4vuAxkOJNwzidbw24J9rtAMudsqmyKTeYBN0goKfrI0hN56GI4JWW0rW0b0tLDFtJoqzwpXyOM9y6IUMtFBcCUgd6yPnTd/e8tvG/M4g+/rhXkW4Y4IEQTpfmDfTu8RinI/nfcRGcrE8wfBfquHFerX4Kyp7d97CcBmBFR9sjgOOLxWJhXZaHQd9a1r9AZ4eBdHro3diBYzryFNfsH1ELkPV1glEukztcHn7G+s2T5BWqYST39Pzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lMmSmk9e25OkyR1NVjAXe/lHNnXogVkWoVzM+/bZnA=;
 b=oCKCdVr5E4+JsA3CBAXoGEBANtm4fz0KeHbgbwEwCQlcRa/tvZRiqtcfegB8zbSi4vWETQVp2kmTMT9HdU5skp2iUVWmngpJn0IjLDTbmStsId5vThkzF6in/9dVuQ7zwrXp2/zP6xb4bhFApJpF0fiCOdiWqIsPI6/+Ss3iRc2iQquPzv6BmggwKmR3XYl/RFhf6XT0AhJjhpNIcEYjGJr4swjWzbNOxGpIEvTgNJr0RC6BJb7Y8YmuzRar31X5RnRh3IdThgT2WtOyEuKv2IQ5yL3nfnhn6LHwHC6hXCjwvrCIqGBJgwn5EPSkBj3jEdaBYxh3pqdP4Owq8OLkzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lMmSmk9e25OkyR1NVjAXe/lHNnXogVkWoVzM+/bZnA=;
 b=BN63snSkPY7d0GYXBCahs1ztqoKl0HvGSH/G0np9EX8KhD8dHZ6cBAHS0HGZr1wMe/+DDJc27GinhpQu5b4BBTBYAyOZ0BOE2x0qEAcjnFvPkAImzft1Ur2BLYvtObDpabiIxjWFCFd0lm0+9608VCRdGprKUf7IPdRYNpHT+00=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DU0PR04MB9493.eurprd04.prod.outlook.com (2603:10a6:10:350::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Thu, 10 Aug
 2023 06:17:51 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::c5e2:98f8:b03:2189]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::c5e2:98f8:b03:2189%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 06:17:51 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     =?utf-8?B?R3VpZG8gR8O8bnRoZXI=?= <agx@sigxcpu.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        "kernel@puri.sm" <kernel@puri.sm>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        David Heidelberg <david@ixit.cz>,
        Bough Chen <haibo.chen@nxp.com>
Subject: RE: [PATCH v1 4/5] arm64: dts: imx8mq-librem5-devkit: Drop
 power-supply
Thread-Topic: [PATCH v1 4/5] arm64: dts: imx8mq-librem5-devkit: Drop
 power-supply
Thread-Index: AQHZyvJnlq9Wn56x9UKSrB9y7QCSxq/jC7UQ
Date:   Thu, 10 Aug 2023 06:17:51 +0000
Message-ID: <AS8PR04MB8404CFE51B0A3ABEA13808569213A@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <cover.1691606520.git.agx@sigxcpu.org>
 <be0267a53cdf31c7a32f9ab43813dccf08b32477.1691606520.git.agx@sigxcpu.org>
In-Reply-To: <be0267a53cdf31c7a32f9ab43813dccf08b32477.1691606520.git.agx@sigxcpu.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|DU0PR04MB9493:EE_
x-ms-office365-filtering-correlation-id: e9b58b1e-fc11-4e9e-2396-08db9969868f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e4a12QWGeTek8JDIDpZoRow0F5Adf8k0wS5I590or/Tt9ijCDKmidqu0Qc28ca8hr2n7Tiov5OYXYE2sG/pK49IDooay8uDteuWweA20q9/XkDf8wr3MIXKpzznVA1uUlgPxHmAKVbROs7Y7yyFimb7ayNbrt+Rzlr1COe9s7IOsL+2L19FOK9JBzbDuvqTfGuWL1SV2WxyJeVKOnT4Pq0LYKrs1xTK3hw/+5vd96sHpkVvK/AkkSUVkIqqKquIlHtt+20zhFBpQ2S8A2hCmkIfHogOz4aSczU0pSc6+Ui7vzWkeGB1JQZho5EOXSnRbO7fQw9NDCBOgfT/Y3BVOlKfafEAWqqzGP0Ira9+RiFrESKiipWVgc3dXYFj4T7JpuEOsJEm8supOLZecLPGEbG1NxKvoN9JomM7MyfHTO/+2nXDvofuHJ3vzcdyFZ3RL7DF+Tv4qkWNj00zYOVixIrNbnU4NEMSEDSHxez0m3E8m9hoDRjlARvz/to7HC+wxa/cr6d5c6RYZ676nrFrgL/DqcACpfHkNYTkY35zwywGi0bUQ2uWx/oryehDcGNiz7tnHFhZREQ+5rwXIYpffbQz/Jb6IiBunp5s5ND9ZnmKS+h0tqPz9WhsjqSKW+7bhFMqaZYtKolphMfDx4LbPXIXacUkrNVaUZmF7zc3UYUKw/M6eySpOSxICbzL03bne
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(186006)(451199021)(1800799006)(6506007)(53546011)(33656002)(966005)(9686003)(71200400001)(7696005)(86362001)(478600001)(66574015)(45080400002)(83380400001)(110136005)(6636002)(316002)(66476007)(66556008)(76116006)(66946007)(64756008)(66446008)(41300700001)(8936002)(5660300002)(52536014)(38070700005)(122000001)(55016003)(921005)(38100700002)(8676002)(7416002)(44832011)(2906002)(95444003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFVQQXI0OWZmdHh0a2ZmQ2VUU2hBYnRGYnFYL2lYMXlXRkE2QnhTdlBvM3NK?=
 =?utf-8?B?K2ZlSHlxTlBaS2NBZjVrZzBuY045UGZHdXdRc2lZTFhUVmpSQldwNUt2THVO?=
 =?utf-8?B?ajduRmcvM1Jta3NldTB5OGRlZkdQa0VsdFQ1UDhkL2NzUVhaTXJ0blBNT1RT?=
 =?utf-8?B?aUVtVGJXRlBKeFBzREpWd2RQeC8zNnRSSFYva3MzWVY4NDJsYThiUjBGZWRW?=
 =?utf-8?B?V292alB3Z1NSdmdoeEdhcDZsTU5zaUtqdFdudkt2Ym1xOW1LU0V3bzJLNklh?=
 =?utf-8?B?VGV4ci85U2I1NVVjMEtoUlRuVnJlRi9QbmZHY0xRRTM4b3ZodVVWeEdEQkl4?=
 =?utf-8?B?Y2RZMmhVYWkwdHhza3dGR0tkZDB4SDR6bkpXdFQycDJzWGFiQlNjWG1WdDd3?=
 =?utf-8?B?NzhyZHkwRGRkQWVqZldCS2RiSjd1SVlUdk1MSXdqL1BsWkhQajNmZDlZM211?=
 =?utf-8?B?Z3ZVV3pFa1R2OVhTbXVCRWNzVE42Tm5ydG4weWN6SjR0UnU2ZzhlTyswVU9N?=
 =?utf-8?B?SHpYS1R5TzdXRmFLZTU0L1NQUy9YOGRicERCVFVqcTJVNmExZ240c1RNNzE0?=
 =?utf-8?B?UzM5YkdkSnM2WWZUVEVDK0sra1E1Y0pxWHF6RWEzMGJlY28xUDZpTHhzWGJG?=
 =?utf-8?B?eUdady9Kem0zSjVNZGpNai9ORUExNnlURDVGK09uSkNYZ1ZMa3NCaVVEbGZC?=
 =?utf-8?B?NWxUS0xzTG5yNkQ0VWVOWEVjQlBCeFZwVVhHWFh5aXFRK1pSWWVjWStTZGFT?=
 =?utf-8?B?LzFTZmxvd3ZPdGV4QzI0ZlhnTFY5TXM3UjlCZUkrdUdYczkwSFBjRWNQYmI5?=
 =?utf-8?B?Q0xLTjRLOTJEeXI5c0kyRjRPa1JkSzVxSTRQbnhlRmZnVEVTWmYrRWZqWWpZ?=
 =?utf-8?B?WXRmNTVBUjhzM0Izd2V1TGJXSko2bGRqWk9abitNTlR0U00zZ1lobkZmV3Y1?=
 =?utf-8?B?RlRxTEZkS0l1WTVjbGFyR2RpQjNhZDhRS0sxcWxNVU56MkZoWHZubWh0WTJh?=
 =?utf-8?B?em4rTEc5eGIrVzJZY1ZjS3doRlhTYWVjRUZ6cG5NUEE3b1FNb3pWaXlhenA5?=
 =?utf-8?B?a3d1RE9MV3RmeWlMUWVZcS9MeUsxTkc3dnV2SnJlbHZucFMzM1QwUTYrUTlo?=
 =?utf-8?B?aU4rZFNCY3grRmhkUC94S29NNHZkNnEyYS80cjNjTlpzaGdFaGcvYkdqc29j?=
 =?utf-8?B?WFhBYjg1em11TGpnRnBNdE5vWGRESGttNnNCc1B6YWF2SDhQZ1NPMXUvblIr?=
 =?utf-8?B?SGpSME5MQlJNREJ5MHlPUFNUeWNpbi9wRDNXb0lHWXkvNG5sLythY28zYkl6?=
 =?utf-8?B?Q1ovTE5lRVhXVk5qRmxGaEcveWc4TC84OGNYbG1FNTkwSUk1NEgyY1JFNTlq?=
 =?utf-8?B?SVArUGpmTkMzQjNaS2JTenJSaXRSb0hoRk81VmRaZ0c0MmMxcmZwbUcwSHNs?=
 =?utf-8?B?UXlNNVFqak1sN2V4WTZnUkVPVWRnamdKaFNOOFR2SDVDaFdidGFIaWdZMVQ4?=
 =?utf-8?B?aDJxbXc1dzh0bWtzbXczQkF3SFEzZTE0eWRCTmZWRW8zRWZtdmJRQzdBSGUx?=
 =?utf-8?B?cVFZeUtjQ3hVckl2eGlPRTFTdkdORjNnS0Y3YnZHcUdjbjNSTDNHTjBkVlNr?=
 =?utf-8?B?VE1hRFc5WWNualJpRlg4NXhLVW0vYnNhNjN3Y1lsQ052bVMrNVNsOENtSnpl?=
 =?utf-8?B?WjBkbzBtaW5FN3Y1eHI4bWtwSTFGUXhCZjFUN0V2UlYyOCtSRVhpV1Q2VkU2?=
 =?utf-8?B?S1d2SUM4OFJBMjRVdDVwSzZMODFvRHdBRVFodnBaMGVrMlV4VHR1VGdRbnlN?=
 =?utf-8?B?UzNiNSswc0xJTFc0MFl5TUQzL0FnZ1NhTDdoakhwOGl4RVRJOUc0QitzYzNX?=
 =?utf-8?B?ZDlVZkpFMHNYWVhDSzZZVVFFblVFUlliOFRpRlRnbS9ub0xwa0o5dHJGQXdT?=
 =?utf-8?B?SWt4ZFpDRlpVQjIzV3ZTcG1UanJiSzZkMGh5Z2VrSW9hUjZObzNFdzZ2cU05?=
 =?utf-8?B?OVF1azV0TzNTcm5kL2FEZFFUdlJZTTE3QXRsc2diTUxPV2FQZERrUDg2N3lT?=
 =?utf-8?B?MWdabEdXZlEwamd6QUVkeFhGY3pIU05kWlRNZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b58b1e-fc11-4e9e-2396-08db9969868f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 06:17:51.0623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qGUAxyKRFVpXrsnZefQiu+h5MnBt0ftKBQD1LLuqKR4sGsxIZQ+EDL3Tak1bRElOGzH1Qq84GvLwA1p3sqIOZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9493
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VpZG8gR8O8bnRoZXIg
PGFneEBzaWd4Y3B1Lm9yZz4NCj4gU2VudDogMjAyM+W5tDjmnIgxMOaXpSAyOjUwDQo+IFRvOiBV
bGYgSGFuc3NvbiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz47IFJvYiBIZXJyaW5nDQo+IDxyb2Jo
K2R0QGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93c2tpDQo+IDxrcnp5c3p0b2Yua296bG93
c2tpK2R0QGxpbmFyby5vcmc+OyBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+Ow0K
PiBMaWFtIEdpcmR3b29kIDxsZ2lyZHdvb2RAZ21haWwuY29tPjsgTWFyayBCcm93bg0KPiA8YnJv
b25pZUBrZXJuZWwub3JnPjsgU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPjsgU2FzY2hh
IEhhdWVyDQo+IDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPjsgUGVuZ3V0cm9uaXggS2VybmVsIFRl
YW0NCj4gPGtlcm5lbEBwZW5ndXRyb25peC5kZT47IEZhYmlvIEVzdGV2YW0gPGZlc3RldmFtQGdt
YWlsLmNvbT47IGRsLWxpbnV4LQ0KPiBpbXggPGxpbnV4LWlteEBueHAuY29tPjsgQ2F0YWxpbiBN
YXJpbmFzIDxjYXRhbGluLm1hcmluYXNAYXJtLmNvbT47DQo+IFdpbGwgRGVhY29uIDx3aWxsQGtl
cm5lbC5vcmc+OyBHdWlkbyBHw7xudGhlciA8YWd4QHNpZ3hjcHUub3JnPjsgUGVuZyBGYW4NCj4g
PHBlbmcuZmFuQG54cC5jb20+OyBCam9ybiBBbmRlcnNzb24gPHF1aWNfYmpvcmFuZGVAcXVpY2lu
Yy5jb20+Ow0KPiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPjsgR2VlcnQgVXl0dGVyaG9l
dmVuDQo+IDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT47IEtvbnJhZCBEeWJjaW8gPGtvbnJhZC5k
eWJjaW9AbGluYXJvLm9yZz47DQo+IE7DrWNvbGFzIEYuIFIuIEEuIFByYWRvIDxuZnJhcHJhZG9A
Y29sbGFib3JhLmNvbT47IFJhZmHFgiBNacWCZWNraQ0KPiA8cmFmYWxAbWlsZWNraS5wbD47IGtl
cm5lbEBwdXJpLnNtOyBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZn
ZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgYWxzYS1kZXZlbEBh
bHNhLQ0KPiBwcm9qZWN0Lm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
OyBEYXZpZCBIZWlkZWxiZXJnDQo+IDxkYXZpZEBpeGl0LmN6Pg0KPiBTdWJqZWN0OiBbUEFUQ0gg
djEgNC81XSBhcm02NDogZHRzOiBpbXg4bXEtbGlicmVtNS1kZXZraXQ6IERyb3AgcG93ZXItDQo+
IHN1cHBseQ0KPiANCj4gVXNlIGEgcG93ZXIgc2VxdWVuY2UgaW5zdGVhZC4gQXMgdGhpcyBoYW5k
bGVzIHRoZSB3aWZpIGRpc2FibGUgbGluZSByZW5hbWUNCj4gdGhlIHBpbmNvbnRyb2wgYWNjb3Jk
aW5nbHkuIFRoaXMgYWxzbyBtYWtlcyBpdCBzaW1pbGFyIHRvIHRoZSBMaWJyZW0gNS4NCj4gDQo+
IFJlc29sdmVzIGZvbGxvd2luZyB3YXJuaW5nOg0KPiANCj4gYXJjaC9hcm02NC9ib290L2R0cy9m
cmVlc2NhbGUvaW14OG1xLWxpYnJlbTUtZGV2a2l0LmR0YjoNCj4gbW1jQDMwYjUwMDAwOiBVbmV2
YWx1YXRlZCBwcm9wZXJ0aWVzIGFyZSBub3QgYWxsb3dlZCAoJ3Bvd2VyLXN1cHBseScNCj4gd2Fz
IHVuZXhwZWN0ZWQpDQo+ICAgICAgICAgZnJvbSBzY2hlbWEgJGlkOg0KPiBodHRwczovL2V1cjAx
LnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRmRldmlj
ZXQNCj4gcmVlLm9yZyUyRnNjaGVtYXMlMkZtbWMlMkZmc2wtaW14LQ0KPiBlc2RoYy55YW1sJTIz
JmRhdGE9MDUlN0MwMSU3Q3NoZXJyeS5zdW4lNDBueHAuY29tJTdDZmVmZWZlZjUzMjZmDQo+IDQy
MDUxNjdjMDhkYjk5MDk4OGQ3JTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0Mw
JTdDMA0KPiAlN0M2MzgyNzIwMzg0NDcyODkzNjklN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlK
V0lqb2lNQzR3TGoNCj4gQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pY
VkNJNk1uMCUzRCU3QzMwMDAlN0MlDQo+IDdDJTdDJnNkYXRhPUVwY2RzYldOa1UwJTJGdVlCeDl0
SGx3OXFvU284N1huZU1OeE9IdzVaNCUyRkZBDQo+ICUzRCZyZXNlcnZlZD0wDQo+IA0KPiBSZXBv
cnRlZC1ieTogRGF2aWQgSGVpZGVsYmVyZyA8ZGF2aWRAaXhpdC5jej4NCj4gU2lnbmVkLW9mZi1i
eTogR3VpZG8gR8O8bnRoZXIgPGFneEBzaWd4Y3B1Lm9yZz4NCj4gLS0tDQo+ICAuLi4vYm9vdC9k
dHMvZnJlZXNjYWxlL2lteDhtcS1saWJyZW01LWRldmtpdC5kdHMgICAgfCAxMyArKysrLS0tLS0t
LS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS1s
aWJyZW01LWRldmtpdC5kdHMNCj4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4
bXEtbGlicmVtNS1kZXZraXQuZHRzDQo+IGluZGV4IGJlOWVmNWMyNzFkZi4uMjQ0MDc1ZTJhNTk5
IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEtbGli
cmVtNS1kZXZraXQuZHRzDQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lt
eDhtcS1saWJyZW01LWRldmtpdC5kdHMNCj4gQEAgLTIzMSwxNiArMjMxLDExIEBAIHZpYnJhdG9y
IHsNCj4gIAkJdmNjLXN1cHBseSA9IDwmcmVnXzN2M19wPjsNCj4gIAl9Ow0KPiANCj4gLQl3aWZp
X3B3cl9lbjogcmVndWxhdG9yLXdpZmktZW4gew0KPiAtCQljb21wYXRpYmxlID0gInJlZ3VsYXRv
ci1maXhlZCI7DQo+ICsJd2lmaV9wd3JzZXE6IHB3cnNlcSB7DQo+ICAJCXBpbmN0cmwtbmFtZXMg
PSAiZGVmYXVsdCI7DQo+ICAJCXBpbmN0cmwtMCA9IDwmcGluY3RybF93aWZpX3B3cl9lbj47DQo+
IC0JCXJlZ3VsYXRvci1uYW1lID0gIldJRklfRU4iOw0KPiAtCQlyZWd1bGF0b3ItbWluLW1pY3Jv
dm9sdCA9IDwzMzAwMDAwPjsNCj4gLQkJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8MzMwMDAw
MD47DQo+IC0JCWdwaW8gPSA8JmdwaW8zIDUgR1BJT19BQ1RJVkVfSElHSD47DQo+IC0JCWVuYWJs
ZS1hY3RpdmUtaGlnaDsNCj4gLQkJcmVndWxhdG9yLWFsd2F5cy1vbjsNCj4gKwkJY29tcGF0aWJs
ZSA9ICJtbWMtcHdyc2VxLXNpbXBsZSI7DQo+ICsJCXJlc2V0LWdwaW9zID0gPCZncGlvMyA1IEdQ
SU9fQUNUSVZFX0xPVz47DQo+ICAJfTsNCj4gIH07DQo+IA0KPiBAQCAtMTAzMiw3ICsxMDI3LDcg
QEAgJnVzZGhjMiB7DQo+ICAJcGluY3RybC0yID0gPCZwaW5jdHJsX3VzZGhjMl8yMDBtaHo+Ow0K
PiAgCWJ1cy13aWR0aCA9IDw0PjsNCj4gIAl2bW1jLXN1cHBseSA9IDwmcmVnX3VzZGhjMl92bW1j
PjsNCj4gLQlwb3dlci1zdXBwbHkgPSA8JndpZmlfcHdyX2VuPjsNCj4gKwltbWMtcHdyc2VxID0g
PCZ3aWZpX3B3cnNlcT47DQoNCkhpIEd1aWRvLA0KDQpOb3JtYWxseSB3ZSBzaG91bGQgdXNlIHZt
bWMtc3VwcGx5IHRvIGNvbnRyb2wgdGhlIE0uMiBwaW41NihXX0RJU0FCTEUxIyksIHdoaWNoIGNv
bnRyb2xzIHRoZSBXTEFOIHJhZGlvIHBvd2VyLg0KQW5kIHVzZSB0aGUgcmVzZXQtZ3Bpb3Mgb2Yg
bW1jLXB3cnNlcSB0byBjb250cm9sIHRoZSBNLjIgcGluMjMoU0RJT19SRVNFVCMpLCBpdCBjYW4g
aW5kZXBlbmRlbnRseSByZXNldCB0aGUgV2ktRmkgcmFkaW8uDQoNCkJlc3QgUmVnYXJkcw0KU2hl
cnJ5DQo=

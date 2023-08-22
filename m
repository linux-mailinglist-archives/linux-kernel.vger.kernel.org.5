Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB4E784540
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236822AbjHVPSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbjHVPSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:18:11 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2041.outbound.protection.outlook.com [40.107.6.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809F5CC6;
        Tue, 22 Aug 2023 08:18:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7z2DrDHkuMidlepbU0vmR+PYBYGMS4ucJt3fHyGEs1sm8VaPn/b933E+ASUFiXoi882TZYsdcX6DCrfkMSk2M5tvNdVW8CNd45rAN14PsUkROQfEGuEVZcGKOJmM+Wf8nu3uGp8hU9mMldjpaff61QzJzMVRkZuIS9ZtN1PwcKYcbxQ4FcgbGjKJTH/O1oisoted3cOH31DPwcFN5TqcYMKBu41RPYD/9yUaBIi18bQMiqS9AMCU1uDIswiTt1eJcySxwFrdfPD3Ts0X702gGmwBZ/+H91gLBpk0RQkNYlFFQ5PgibU/+VdJCZC2GsR44kV1veV9GFtqODFbw5Iaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6zShbY+YxMS+i8BRW82Hpb295/JOVkSNDvCTAmN1lY=;
 b=GtFxenruYSgS68hrhP1VEGBL9BDXgRUGyVd3AWbPnHmzkbplho5qDr93ihLthdUdh6sCNnAzBkru9330gRHCHJRTLAyxzs9gQ1+VpHPz4LZGkipYKOZjJNa/WT0byUY2vuI9AdaBPen61AtzjURJnLEVmr8SmGyLctoU5mO2axGMXPlYKHAd9ZfG49qNS+QAFSbekvNU4vtFySErTr1gUFKLRCUHoJrAt4Pil9k/kkaN8ek+HswUkcmEpLBaBiPcuNeJJXpkARUYMLQUgVQRRMPBAbFwRnBPaFOkaXxU7kgt5vWC6yJKPmusNbOjl0dxeIZfqgwwjNR1cDbHGAKoYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6zShbY+YxMS+i8BRW82Hpb295/JOVkSNDvCTAmN1lY=;
 b=nq9UklTjVmGLkBhjYCp/O0XxHJTMrSQivZzDVieTgixneVRmykOM62gFMYIkp5EuDg5P6/vcp+G4P83CoOEoB8OZsDjRcu8NjDgis75UG0+Fw7h1/RyhrrSYhd8ItJXm65p6nzj86Fe59HgtQC48t9zjHnuqQVGXKA56e9YqRfM=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DB8PR04MB7193.eurprd04.prod.outlook.com (2603:10a6:10:121::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 15:18:06 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 15:18:06 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml file
Thread-Topic: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml file
Thread-Index: AQHZ1Qvad0tEZmhA00uHLX8j50FdDA==
Date:   Tue, 22 Aug 2023 15:18:06 +0000
Message-ID: <PAXPR04MB918567C378D420DB4830B869891FA@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20230818153446.1076027-1-shenwei.wang@nxp.com>
 <CAL_Jsq+XA_P-aRK9_WuGPmJ0_xJgsSr9smZy4BRbKZbmVsMQBQ@mail.gmail.com>
 <PAXPR04MB918539A19B8F817F623BBD1F891BA@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <9927403d-6dd9-3e5e-8f9d-f38e6640f95f@linaro.org>
 <PAXPR04MB91850D8807CE374BD7C30CC5891EA@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <CAL_JsqJ3dr7gxq+D5DYG8oQ=igzjARz=beQoYL7rrydV4SwDTw@mail.gmail.com>
In-Reply-To: <CAL_JsqJ3dr7gxq+D5DYG8oQ=igzjARz=beQoYL7rrydV4SwDTw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|DB8PR04MB7193:EE_
x-ms-office365-filtering-correlation-id: 2306967b-afd5-4a6b-eedc-08dba322fc9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZofGKZViJq5lVOjvibHvRo8QD7ahbBwXar/uZdBCdNohuTnJ+KzbcLFcexTyUVdzyet8jH97pJd8Z/gjN0wHC3lnY4dqqIO9Bb2f44gfTn9OfeDu2Bon5kf1IJt4w9O6VyBwYQBW9CElz9qqPkQwW6L/s+Q+piFM8xsiH4p7I3x8Yws20skJ2c4/Tv9Zvj5nKPyvKDIAQ7+KX3z7Ok3NcCiEbfeGRSBjkWrROZNBx5QSvU5gzxelAFyek4dmDdEw9Wymz67zCcyWSmXQoarCLSIittpDZVj1ejSgah6LnAXZaxqq8k8YQyLX67duqd6CFsCWjWDbfiZhH72qpKQDIQ1LXIniN/Rz7d3MPnYy1BTbNzC0Hci2S+apvz1/CY+lbM3ciiIFU0axGn1VfWVixUC8gC9wS8bK1kQPSy8BFjnBPlywD3m3GmYERWwer8qhmCDgyTmNGCwuwyzIVoJhIZ5wPJ0JIipYOUlsE/C73wc7J94oZshQOQIE7bmHeRHFb4NS3wC88b1wnQn7U9r6J3GvY3G7RGRDm7nJf6y4/+ceKdVJjRMiOL3mTaXxUazx6iA3A7kDf9p8cczPTPrVumdLPta1DwMB7E5zYXRrPo0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199024)(186009)(1800799009)(83380400001)(2906002)(7416002)(55236004)(53546011)(6506007)(38100700002)(5660300002)(44832011)(33656002)(52536014)(26005)(86362001)(38070700005)(8676002)(4326008)(8936002)(66946007)(9686003)(316002)(64756008)(54906003)(66556008)(66446008)(76116006)(66476007)(478600001)(122000001)(55016003)(71200400001)(7696005)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkxkREoyZW9UQ2NLcVdxL1RXeXRyaXc0WEtqdmJoV3krLzM5UWREaXYxU0N1?=
 =?utf-8?B?bTRDdUxWM1V6b09tTVVpM1d6aTI5MXl0SVNVOWVjdHJXaEsyRWFVc2NZMlFy?=
 =?utf-8?B?TXlWcENZelBGdjhRTXRqTXZrazNJcmNxMjY2a3JDRG9FelJtTGdzR0xMbU1s?=
 =?utf-8?B?Uy8wdXFJeCtxZ2NXWFdyOUVYU25EVXRtcjQ4bFBlWjZUUUZ4Y2d5RzZDcFpK?=
 =?utf-8?B?Q3E3YmRhRktETkMvbnBPUmxkemJ3TFduM2NTVFVaSXN2VkRqbGdNaE83bkI1?=
 =?utf-8?B?TmFLRWMwNUVUUG4rQVVYQjc0ZkxGOHpMVFNtWXhaZTBWc3NLYmx2bVBvY0tR?=
 =?utf-8?B?emhlRXdzRml0Z282RmI4UEV0czJ2RytmWHpiODUvSUxLZnpaUi96ckFmbmdh?=
 =?utf-8?B?UjZQVklsUys2Zkxqbk1FZUdVQzlobW9vd3pQd01LRzBaeFhCZDJhekNnam1N?=
 =?utf-8?B?THYvcWo0L1YySUNER1RvaG5wQ3YrNk9WQ1dZVGF6L0lxbHRBalhnaUtvVlhv?=
 =?utf-8?B?VExIV0hxZnRNQjZpanRVMjlwemVkYVh3dVJQbDhEb2xPdk5QT21ucWxCRHRw?=
 =?utf-8?B?OUlIS0k4dVl3WWdiSGp2MTY2THVCb3RuRWZWdkJuay9hUE1DWStSNllOZ2pi?=
 =?utf-8?B?d1FkWU8rbTMwdGhmQWxRNWpzRXJpYWhuZ1VhT0Z0SFBzdTluZ2pHYjBUY3pL?=
 =?utf-8?B?WmxBNjFnMmloeHZvdFVyWlcrTC9FNHMzbGVuZytqa3lpaTR3YVdJckw5aVU3?=
 =?utf-8?B?UllYUTZHYkdUTEUrWnlhLzF5K2RyRnkzaDRxV2FEaGVNaE1rRm4wOUIveWI5?=
 =?utf-8?B?RHczcTJjenRDalZEdnVmYlArMnVQUU1OaFlYekhUcE1uSmcwY3BTeWpqRDZH?=
 =?utf-8?B?Q3pZWk9vTnRreEpkSUZDQ1k3Mmp4MDdEd043NTArQysyN0xnalJRbHhjcDJk?=
 =?utf-8?B?VjdQQldQK21leWlQMUR6ZnJ6dkRZU0xRVGdoQ1VxYUM0dnNmN2EzTWVvY3Q0?=
 =?utf-8?B?K282THZwKzdMVFkwYUt0c1JIZGpxQmdkblllYklFOTRaNzJ6VVRGNzZHZS9s?=
 =?utf-8?B?bHgycnAzSEwwVW5iLzBNekNFRG5FT1RRUCtseTdkUFhlT1BkWW1Vd0sxUGJ0?=
 =?utf-8?B?WThybTNKQ2pUdDJ3eDZuaW1hK1pQam9WMnE5b0p1dWxrdC9DMEVDQVNPVE9Y?=
 =?utf-8?B?VTRqc1YzR0hGd3BjaFQzRGk5SDRqVjZBMnNXSnlhdHZhZzZ2MUZUWFFqd00v?=
 =?utf-8?B?NlQ5RkxMaGlpT1BieDZ0S1JabVU5SUJLdStyTXVkbXJiU0FOaVFaY1NpMkxZ?=
 =?utf-8?B?YllTM1pVVDE4dzF0bUlSY2dVTVBEYUk4WnpJM1ZFRmFTQTMzNlFzTnUwLzNu?=
 =?utf-8?B?VjBJSTRLM2U5S0pYM3lzU3FTS0F0OU1Ba3E1Znd4cmxJTVBXTUJHWFYvbHNp?=
 =?utf-8?B?LzkwZVZEcG9weGdzVU5wUjY3a2Q1ZVRNUmpyN3YwTE1FTUNkczR5S3d2Rmo3?=
 =?utf-8?B?VGp1dEIzZlNyZHVuK1hLRFFNbDB3M2F6eFoyMVA2Wjd1RGhwb0dINGxmM0pW?=
 =?utf-8?B?TUdSMjlpRmd3K3Q5Zjc4SVFQdTBYYUJ1ZzNkYlJTR3FEdkZlVStxK0JsSnhU?=
 =?utf-8?B?Q3NZVkE0NWpLckpyc3dGU3R5UXh3MHlRQ3FFL2JXSDRPM1hpZVVyWVFSSzlN?=
 =?utf-8?B?b1hhQlVOVFA1V205WVc2aDhJbDBETDJLc3A2UzFSOG5zazVxd2oyOUo5a1JZ?=
 =?utf-8?B?Qjh2VE0xa2RSQTVoRGQzVm5jRytvMGdnMUVQUEpNVmFJZFNIblhScXlKdHNZ?=
 =?utf-8?B?aVE4S2JWZUttWnFDYWxKU1k4V0FhWDBFcGFQWjMySnMvYzd3NXhZeXJmcWVQ?=
 =?utf-8?B?d1VlRFJpayt0MUUyQklBelhmZkFHMG0vTFRpejZXczVmbnlZMVNlMnBVdWZW?=
 =?utf-8?B?V2dtc0VQVkdMMzlsK1pnNGFuLzRDNlg1dmRNdHNkL0NDWTZYcXB0U253TXNT?=
 =?utf-8?B?ZXU4TnlqRkFVcUM2Qmg3NDJUUkI2aG1odzE4NzJjL016aC9ZYVU2YWxwbGpN?=
 =?utf-8?B?ay9QTllLb2pwUjFVTFFMMkVBSUVMeW9OQmc0clNwd0I0OVRjUEdHNy9Lc1pR?=
 =?utf-8?Q?hoPdUlRIgaHWyipVV5sYeiX3B?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2306967b-afd5-4a6b-eedc-08dba322fc9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2023 15:18:06.5241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4j3Mw9PrZhiwm1egV+wZnsSgMInJde4qaQl7WO6q2vOM1k36oUcGXR4S/itIgPyJ6ZyRtCaybEO9OxXhAi4iEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7193
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iIEhlcnJpbmcgPHJv
YmgrZHRAa2VybmVsLm9yZz4NCj4gU2VudDogTW9uZGF5LCBBdWd1c3QgMjEsIDIwMjMgMTo1MCBQ
TQ0KPiBUbzogU2hlbndlaSBXYW5nIDxzaGVud2VpLndhbmdAbnhwLmNvbT4NCj4gQ2M6IEtyenlz
enRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz47IEtyenlzenRv
ZiBLb3psb3dza2kNCj4gPGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZz47IENvbm9y
IERvb2xleSA8Y29ub3IrZHRAa2VybmVsLm9yZz47DQo+IFVsZiBIYW5zc29uIDx1bGYuaGFuc3Nv
bkBsaW5hcm8ub3JnPjsgTGlhbSBHaXJkd29vZA0KPiA8bGdpcmR3b29kQGdtYWlsLmNvbT47IE1h
cmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz47DQo+ID4gVGhhbmsgeW91IGZvciBwcm92aWRp
bmcgdGhlIGxpbmsuIEFmdGVyIHJldmlld2luZyB0aGUgZW50aXJlIHRocmVhZCwgSQ0KPiA+IHN0
aWxsIGRvbid0IHVuZGVyc3RhbmQgaG93IHRvIHByb2NlZWQuIFdoYXQgaXMgdGhlIGNvbmNsdXNp
b24NCj4gPiByZWdhcmRpbmcgdGhpcyBjb21tb25seSB1c2VkIHVzZSBjYXNlIGJ1dCBvdmVybG9v
a2VkIGZlYXR1cmUgaW4gdGhlDQo+IHVwc3RyZWFtIGtlcm5lbD8NCj4gDQo+IE92ZXJsb29rZWQg
aW1wbGllcyB3ZSBtaXNzZWQgYW5kIGlnbm9yZWQgaXQsIGJ1dCB0aGUgc2FtZSBjb25jZXB0IGhh
cyBiZWVuDQo+IHN1Ym1pdHRlZCB0d2ljZSBhbmQgcmVqZWN0ZWQgdHdpY2UuIFdoYXQgdXNlIGNh
c2UgY2Fubm90IGJlIHN1cHBvcnRlZD8NCj4gDQoNCk5vIG9mZmVuZC4gOikgU29ycnkgZm9yIG15
IHBvb3Igd29yZC4gVG8gcHJvdmlkZSBtb3JlIGNvbnRleHQsIGEgY29tbW9uIHVzZSBjYXNlIA0K
ZXhhbXBsZSBpcyB1c2luZyBhIEdQSU8gcGluIGFzIGEgcG93ZXIgc3dpdGNoLiBUaGUgY3VycmVu
dCBpbXBsZW1lbnRhdGlvbiBvcGVyYXRlcyANCmFzIGEgZml4ZWQgcmVndWxhdG9yLCB3aGljaCBt
YWtlcyBpdCBkaWZmaWN1bHQgdG8gY29udHJvbCB0aGUgb24vb2ZmIHRpbWluZyB3aXRob3V0IG1v
ZGlmeWluZw0KaXRzIGRyaXZlci4gSXQgYWxzbyBsYWNrcyBwb3dlciBtYW5hZ2VtZW50IHN1cHBv
cnQuIA0KDQo+IFRoZSBkZXRhaWwgdGhhdCBwb3dlci1kb21haW5zIGdldCBoYW5kbGVkIGF1dG9t
YXRpY2FsbHkgaXMgYW4gaW1wbGVtZW50YXRpb24NCj4gZGV0YWlsIGluIHRoZSBrZXJuZWwgKGN1
cnJlbnRseSkuIFRoYXQgY291bGQgZWFzaWx5IGNoYW5nZSBhbmQgeW91J2QgYmUgaW4gdGhlIHNh
bWUNCj4gcG9zaXRpb24gYXMgd2l0aCByZWd1bGF0b3Igc3VwcGxpZXMuDQoNClRoZSBwcm9wb3Nl
ZCByZWd1bGF0b3ItcGQgZHJpdmVyIGZvbGxvd3MgdGhlIHN0YW5kYXJkIFBEIGRyaXZlciBmcmFt
ZXdvcmssIHNvIGl0IGZvciBzdXJlDQpyZWxpZXMgb24gY2VydGFpbiBrZXJuZWwgaW1wbGVtZW50
YXRpb24gZGV0YWlscy4gSWYgdGhvc2UgdW5kZXJseWluZyBpbXBsZW1lbnRhdGlvbiBkZXRhaWxz
IA0KY2hhbmdlIGluIHRoZSBmdXR1cmUsIHRoaXMgZHJpdmVyIGFzIHdlbGwgYXMgb3RoZXIgUEQg
ZHJpdmVycyBidWlsdCBvbiB0aGUgc2FtZSBmcmFtZXdvcmsgDQp3b3VsZCBuZWVkIHRvIGJlIHVw
ZGF0ZWQgYWNjb3JkaW5nbHkuIA0KDQo+IFdlIGNvdWxkIGp1c3QgYXMgZWFzaWx5IGRlY2lkZSB0
byBtYWtlIHRoZSBkcml2ZXIgY29yZSB0dXJuIG9uIGFsbCBzdXBwbGllcyBpbiBhDQo+IG5vZGUu
IFRoYXQgd291bGQgZ2l2ZSB5b3UgdGhlIHNhbWUgImZlYXR1cmUiLiBXaHkgd291bGQgeW91IGRl
c2lnbiB5b3VyIERUDQo+IGFyb3VuZCBpbXBsZW1lbnRhdGlvbiBkZWNpc2lvbnMgb2YgdGhlIE9T
Pw0KPiANCg0KVGhpcyBEVCBwcm9wZXJ0aWVzIGFyZSBwcm9wb3NlZCBzb2xlbHkgZm9yIHRoaXMg
c3BlY2lmaWMgZHJpdmVyLCBub3QgdG8gaGFjayB0aGUgT1MuIFRoaXMgDQppcyBubyBkaWZmZXJl
bnQgdGhhbiBvdGhlciBQRCBkcml2ZXJzIGxpa2UgZ3BjL3NjdS1wZC9pbXg5My1wZC4NCg0KVGhh
bmtzLA0KU2hlbndlaQ0KDQo+IFJvYg0K

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1CD78B78D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjH1Sum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbjH1Su3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:50:29 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2043.outbound.protection.outlook.com [40.107.7.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FBFB3;
        Mon, 28 Aug 2023 11:50:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtFN38wiaDBrHsznV6nYccSj4ggDGNcqtoAIxV2PKtrzUWt+FzacUwxN5cKCvH58HBRmsEFrnoSdDbOjGPDHi3q2idKGIGrryfeyQEjGSvVDG/TgLwUwBxcecJdB5KkPurIXsVZ1xUNI5JdZKO8amw+J5EV5FdoEpVvYOfIvpHhStXwEJrkg3AaHn3RsBJ5pIAq+/JEBaxExezR2pUqTNNxnDNSasb6j7GAnkOXkIsZl1chG4yUi1vxlczkJ+3KdAL9rN4J8wut2O/ESDnAhDl8hcTf3jfekd6MDfATEqs0MxIC8X0ayg9O3aUXSAcbOS/tIgr/y6jnPdSIXmWqGog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yDpconAymnz+m6qaxGaveRDq5FdlMGcCVPcjm2+un4=;
 b=amywePPGWvZ5gTMZxZ06SjYxeLW0Cb3QVko7VEALziUlvj4pQbUT8mDMjvQQFBu8xXJvzn83uoVC4KSRNl8t/0SWqx743DlKhfxBrrtAviWuQJ0etGmvkV8C+qwtoeCQDxqY6dPEKpNxCU3u2PsvyXqmZ/DngA6a5AWDLLkVG4Ml/Xhj3qqXol3HzyJc/rqncX5RhJsl82mRW4ve6GoDUEoo+Ox3CKpinUsT0eCgoxvHz0zih6gtiZZyBusOJtK+DwqxliUmez06U2DML/fVvs4N1LFK5gvGz9nxLBmE+18PruOJLviG4JAoS5djixp7PtNcfgwzzMw7p3/a9aTdjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yDpconAymnz+m6qaxGaveRDq5FdlMGcCVPcjm2+un4=;
 b=Ir5DN9iFoR9if9A59avBSCp9eHL/pHbjXLT+4iHoxgUgdynUo89kMlCWXDz+PcwUFXDuj9mAQsVWxjh7s/iMWvp3BxmdE1DWnIA465oi8GW2jq1x+TWZLssG4dqDNH+CVe/xtkwEQKMj750aKi8OONFbuGJI+ly/I86+m9GH2Xg=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by GVXPR04MB9952.eurprd04.prod.outlook.com (2603:10a6:150:117::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 18:50:23 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 18:50:23 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml file
Thread-Topic: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml file
Thread-Index: AQHZ2eCA0ItmF91pjkOxQX8dYMR6wQ==
Date:   Mon, 28 Aug 2023 18:50:23 +0000
Message-ID: <PAXPR04MB91852AD4E5242306B57A910B89E0A@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20230818153446.1076027-1-shenwei.wang@nxp.com>
 <CAPDyKFqsn6kVjPFUdVyRxNDiOaHO9hq=9c+6eAK4N-v-LVWUPw@mail.gmail.com>
 <PAXPR04MB91858254554272C90822FED1891DA@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <CAPDyKFoV2Z=-WUiF3SgXqhF+K+r5QqsLgz8_hau0WKfZxTzYpg@mail.gmail.com>
 <PAXPR04MB9185F6AA20B0440B8FAB847789E3A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <4e2c18e3-b1ed-6361-3998-5de060d2bcf0@linaro.org>
 <PAXPR04MB9185957B729588D3E7CA3A5089E0A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <51fe3126-16ba-ade6-b106-e3683f96ad26@linaro.org>
 <PAXPR04MB9185DC79721E78E631F9889589E0A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <154b36de-652b-3931-96e6-04e99253a09f@linaro.org>
In-Reply-To: <154b36de-652b-3931-96e6-04e99253a09f@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|GVXPR04MB9952:EE_
x-ms-office365-filtering-correlation-id: 307c5f2e-2b7a-48f4-2e52-08dba7f7a2a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KksZpU2eeMt3l7uK7UVOby6bRlzvtsF/XXJMhz4yO/fq8qYXZqrFzIT7GYpVrsacsa8lAFePnARHF8PP0OPyGGVIwJYmdYi/dTOrKtXyW7JdIikS+W5rJ8DBhaHkwPw+OhjfaO46WdbsQFrfLbxC30HYL4z01LjhLha9y4tU6jtbnRlFyD1aCpNHcI0tilA+l1lh0uFX5uM5YvXpDxSPEgcQTkCPA0ykzDVacXHXEdJiFD16aG3y1WWvIOcZHBD3ZEgqdoqLbk2JoNBKkH/TZ27hIKtlhXgakwf4OY4FMN10lEsXyWeLb7Ky+Ju93arGq/7lIAk5IQGSK+TLRPLhksAO2Dr9cqPmiKZ6aBfNr/Ic/Wv8s4lYN9VheTYTUOQ1HoqD7DdA3Fb2IBm7UsFhiMT5qbbLyvKSDFz98XTGfGY4rXL6F/1D9NS88Oxs4fN+qwQVKHAB76xtHADnzNwoC8C8qBf1f2LoiZlwYuPHfgl86wsD5C8N2BdqIJOeGtbIFzHQ52u21HrL1jnPOgVBzBCQVDUleFWNv+tyYWA9Df+urdQ0AP90DR/ks9+5PCt33X/pB14e8FFY9kky2Z/qRcbtwhyXRgST/p/KMo1hGHhuw8T6G0CkqaStuZ4KXvUW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(39860400002)(346002)(1800799009)(186009)(451199024)(44832011)(7696005)(71200400001)(33656002)(55236004)(76116006)(83380400001)(9686003)(26005)(53546011)(478600001)(2906002)(7416002)(41300700001)(64756008)(54906003)(4326008)(8676002)(316002)(66946007)(52536014)(66476007)(66556008)(8936002)(5660300002)(110136005)(66446008)(38100700002)(86362001)(55016003)(38070700005)(122000001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmNRdjQrd2dqcTd2MjVwcFVmUXg5MEd1eXBxeDBZZUxKRjZrQzJ0cGRBWUxt?=
 =?utf-8?B?ejNzSUhxVDE0NXJFSHVsdnpPcVhLNk45Q1luQXRSdHNKVUxoS3drazh3aGlw?=
 =?utf-8?B?dHdoRmkwUlFEN3pGYUJVOGtPdWpHa3BpWC9YYVBldlRuaFVuV3hiNkw5NnYz?=
 =?utf-8?B?YVNCS3c1eG5CSWFIeEdIYWtGbTZaMmpyQzAyamxobE1EZXhKMFRWM1FSemdF?=
 =?utf-8?B?a3VYN1k3ZlIrQUVhM2krNno2RFBZTFVEeE9EYWFoM2pjMjZXVFk3bmpQTkdQ?=
 =?utf-8?B?dmFCN3NiNFVwNWl5eGRUaWVmYjF1WUlUTUxVTUM4ak0vckM2UHVkOTcxZUtW?=
 =?utf-8?B?QVJjbll2WGlNSnZySnVKaWFJdUEvZ0hRNUFWeDdDN0pHdWQwenVqWkR6c0Fs?=
 =?utf-8?B?N2R2aFdReHgxRVNPUnlVdXlDd1RBenFiUTFkQlNSbU83S3NVMWFmYXVadlRu?=
 =?utf-8?B?dkREZ09XSTVzcC9CYTB2UGJFZTAra0h1cmo2eHVTVE9ha1MySm44WHdIcnQv?=
 =?utf-8?B?Uko5Z0VwMmhJOFZQUG84LzNrMHp5MWZVQzlsV3hONDdwQ3pScjZyQkhPZEN4?=
 =?utf-8?B?TzBWeHpNZ05kTlRrb1A4Z2JrV3lrbStkSWxmQkNveENWbWgrcXJHdkRrNkUw?=
 =?utf-8?B?WjJrdEpETHU1MlYxdlZoVG54dEJ6aGV4aTUxTURkaFMyaGVobTJHYWF2MGU2?=
 =?utf-8?B?U0FrZERjOVpOVStETnRJRHpsVUFYcDFERXBxTFVjV0VGalpnVkRTdXBVYjdw?=
 =?utf-8?B?QzFzZkk3VGZadFZ3TEdXZ2pReDNpZnNTdHJuaTlqbFBPZlI2dEhzcGIyQklp?=
 =?utf-8?B?eVFBWkdxKzV4MXBKRlF5OEUwUXdlVnJYMlh3Y1BjbFQ1Y3FuZjNKTXp5b1Yv?=
 =?utf-8?B?TjN2cXpvWElQSDZKZENndi90dHphYTFPdGFOOEtqWFJBMHJlWHl1VC8wa0Zk?=
 =?utf-8?B?cEhUODFTTHAxWkwvQk4zazRMNEt3TGtIWEZHYytoenlvTXVMYVZ0Mzh4bGhx?=
 =?utf-8?B?N05lV3RHUDRtZzJaNzQ5WVg4UmlxY2hmRGxuczE3WmpvdDB4QlpsMUhCaysv?=
 =?utf-8?B?WDl1MWRUOTFhRWliVGptaDNsY045dHdPenJTTVd0MFphUUpGR2FUTE5WVXhB?=
 =?utf-8?B?L09ha3pFek84eGtqWE9Za2VxN3dpOUNwWkJQazAxVlVTelV1TDRaRlkzMStj?=
 =?utf-8?B?bzBja3NZR3BBU2puOGg0K0VyeHJYTUlSUlZjemZmc3ZhcmZqbjZTYWV1VFZq?=
 =?utf-8?B?eFB6d2JkaXlHS241YWxGU1EwZDNyN0pUYk1KT0VLUHNaR045WktDVHk5a085?=
 =?utf-8?B?RGVCN3MvS1FaTlZpMU1uZnJmS1VNQXl1VTBIMnJaMnNJVlIyc1Y0a2tlZHln?=
 =?utf-8?B?YVkyYVBJZ1ZnckVNandRRkVsVG1ReWtwVWpFaTVMTHFtRm5zdmtKUWdIcmRW?=
 =?utf-8?B?d1gzMW9EdEFBcHlqU3ZvS0RTSkw5dklIalA5amF2aHorbTZYa3FRSStvUFND?=
 =?utf-8?B?Y0ptNnduV2E2amd5VE5iYStuVVdSUGhXZit0QlNCWUxhcmxkWjRhdVNza05m?=
 =?utf-8?B?UzFlODA3bW9LekFWSHJ1eER2U05YV2tzQ0poYzBidGZLVHgzaE12S0dWd0xV?=
 =?utf-8?B?Y0l3Y2Z2SzNCSDB4SElxWXdhT2Y0R3hkSHEvZFFQeU1kTWlsZ1FOcXc4VzQv?=
 =?utf-8?B?aC8yeEx1RkFxL21nVENKMllpT3QvS3FDckhHQ29RNkNMUksxcU5ocHVaVzdI?=
 =?utf-8?B?Yyt6M3RtanJNS0htanJoc0JDcGFPMW85YVlsWWp5M2M2aWJXdlkwSTNSR2tE?=
 =?utf-8?B?S0p5bmRYTlRvTWgwZ3VXYmtVY0FmeFprMXBMQklCTHllV2JJY1d1d20rVHky?=
 =?utf-8?B?RncxRlI1YjZVMHZrc2ZPMm1QRG12U1BTTVJ0elNVNlVjdEdWbVRqNGgzVStM?=
 =?utf-8?B?YVNuR2FWSkZIMDZvaGIzNUN2SFhWbGo3VFRNNGZhTUxnLzMyenhsditWaFJ4?=
 =?utf-8?B?UEhtbEdNcm1FR09FZFg0NnhLTUxhOFhDeU5wTGxMSjZkOGQ1a3MyQjI2V3dM?=
 =?utf-8?B?c0Vtd0pVaFY0eGd2RHk1bHZkQkdaN0QvWTB1UmxtT2tXaEU0WjlBaXBWM3Nq?=
 =?utf-8?Q?vLLJ8IWOaQWuI891eSnjpPs8q?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 307c5f2e-2b7a-48f4-2e52-08dba7f7a2a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 18:50:23.0592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K5dCHzZi1JNGawXTGMBYP2k9fXLJ3KFD4eRnz1+VcNO3sq7J4U+KGdzRWLEsCUzcei6fZgxwxt3amNjaBEvkvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9952
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBNb25kYXksIEF1
Z3VzdCAyOCwgMjAyMyAxOjQyIFBNDQo+IFRvOiBTaGVud2VpIFdhbmcgPHNoZW53ZWkud2FuZ0Bu
eHAuY29tPjsgVWxmIEhhbnNzb24NCj4gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+DQo+IENjOiBS
b2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtvemxvd3NraQ0KPiA8
a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnPjsgQ29ub3IgRG9vbGV5IDxjb25vcitk
dEBrZXJuZWwub3JnPjsNCj4gTGlhbSBHaXJkd29vZCA8bGdpcmR3b29kQGdtYWlsLmNvbT47IE1h
cmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz47DQo+IGlteEBsaXN0cy5saW51eC5kZXY7IGRl
dmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0K
PiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBbRVhUXSBSZTog
W1BBVENIIDEvMl0gZHQtYmluZGluZ3M6IHBvd2VyOiBBZGQgcmVndWxhdG9yLXBkIHlhbWwgZmls
ZQ0KPiA+Pj4+PiBBcmUgeW91IHN1Z2dlc3RpbmcgdG8gbW92ZSB0aGUgcmVndWxhdG9yLXBkIHRv
IHRoZSBpbXggZGlyZWN0b3J5DQo+ID4+Pj4+IGFuZCBhZGQgYSBjb21wYW55IHByZWZpeCB0byB0
aGUgY29tcGF0aWJsZSBzdHJpbmc/DQo+ID4+Pj4NCj4gPj4+PiBUaGVyZSBpcyBubyBzdWNoIHBh
cnQgb2YgaU1YIHByb2Nlc3NvciBhcyBzdWNoDQo+ID4+Pj4gcmVndWxhdG9yLXBvd2VyLWRvbWFp
biwgc28gSSBkb24ndCByZWNvbW1lbmQgdGhhdCBhcHByb2FjaC4gRFRTDQo+ID4+Pj4gbm9kZXMg
cmVwcmVzZW50IGhhcmR3YXJlLCBub3QgeW91ciBTVyBsYXllcnMuDQo+ID4+Pj4NCj4gPj4+DQo+
ID4+PiBUaGF0J3Mgbm90IGFsd2F5cyB0aGUgY2FzZSwgYXMgd2UgZG8gc29tZXRpbWVzIG5lZWQg
YSB2aXJ0dWFsIGRldmljZS4NCj4gPj4+IEFzIGFuIGV4YW1wbGUsIHRoZSAicmVndWxhdG9yLWZp
eGVkIiBhY3RzIGFzIGEgc29mdHdhcmUgYWJzdHJhY3Rpb24NCj4gPj4+IGxheWVyIHRvIGNyZWF0
ZSB2aXJ0dWFsIHJlZ3VsYXRvciBkZXZpY2VzIGJ5IGludGVyZmFjaW5nIHdpdGggdGhlDQo+ID4+
PiB1bmRlcmx5aW5nDQo+ID4+IEdQSU8gZHJpdmVycy4NCj4gPj4NCj4gPj4gTm90IHRydWUuIFRo
aXMgaXMgYSByZWFsIHJlZ3VsYXRvciBkZXZpY2UuIFJlYWwgaGFyZHdhcmUgb24gdGhlIGJvYXJk
Lg0KPiA+PiBZb3UgY2FuIGV2ZW4gc2VlIGFuZCB0b3VjaCBpdC4NCj4gPj4NCj4gPg0KPiA+IFRo
ZSBwaHlzaWNhbCBoYXJkd2FyZSBjb21wb25lbnQgaXMgdGhlIEdQSU8gcGluLCB3aGljaCBpcyB3
aGF0IHlvdSBjYW4gb25seQ0KPiB0b3VjaC4NCj4gDQo+IE5vLiBUaGUgcmVndWxhdG9yIGlzIHRo
ZSBjaGlwLg0KPiANCg0KSW4gdGhlIGRlZmluaXRpb24gb2YgZHRzIG5vZGUgYmVsb3csIHdoZXJl
IGlzIHRoZSBjaGlwPyBUaGUgcmVhbCBoYXJkd2FyZSBpcyBqdXN0IGEgR1BJTyBQaW4uDQogICAg
cmVnMTogcmVndWxhdG9yLTEgew0KICAgIAljb21wYXRpYmxlID0gInJlZ3VsYXRvci1maXhlZCI7
DQogICAgCXJlZ3VsYXRvci1uYW1lID0gIlJFRzEiOw0KICAgIAlyZWd1bGF0b3ItbWluLW1pY3Jv
dm9sdCA9IDwzMDAwMDAwPjsNCiAgICAJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8MzAwMDAw
MD47DQogICAgCWdwaW8gPSA8JmxzaW9fZ3BpbzQgMTkgR1BJT19BQ1RJVkVfSElHSD47DQogICAg
CWVuYWJsZS1hY3RpdmUtaGlnaDsNCiAgICB9Ow0KDQo+ID4gVGhlIHJlZ3VsYXRvciBmdW5jdGlv
bnMgdmlydHVhbGx5IHRocm91Z2ggc29mdHdhcmUgbGF5ZXIgYWJvdmUgb2YgdGhlDQo+ID4gR1BJ
TyBkcml2ZXIuIFdoaWxlIHdlIG1heSBjYWxsIGl0IGEgInJlZ3VsYXRvciIgb3Igd2hhdGV2ZXIg
ZWxzZSwgdGhpcw0KPiA+IGNhbm5vdCBvYnNjdXJlIHRoZSBmYWN0IHRoYXQgdGhlIHVuZGVybHlp
bmcgaGFyZHdhcmUgaXMganVzdCBhIEdQSU8gcGluIGJlaW5nDQo+IHVzZWQgaW4gYSBzcGVjaWFs
aXplZCB3YXkuDQo+IA0KPiBUaGUgcmVndWxhdG9yIGlzIHNvbWUgdGlueSBsaXR0bGUgYm94LCB5
b3UgY2FuIHRvdWNoIGFuZCBjYWxsZWQNCj4gdGksdHBzNTE2MzIgb3Igc2ltaWxhci4NCj4gDQoN
CldlIGFyZSB0YWxraW5nIGFib3V0IHRoZSBzcGVjaWZpYyAicmVndWxhdG9yLWZpeGVkIiBkcml2
ZXIsIHdoeSBkaWQgeW91IGJyaW5nIHVwICJ0aSx0cHM1MTYzMiIgaGVyZT8NCg0KVGhhbmtzLA0K
U2hlbndlaQ0KDQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K

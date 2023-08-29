Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328EF78C513
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235971AbjH2NWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236007AbjH2NV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:21:56 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2064.outbound.protection.outlook.com [40.107.105.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23443199;
        Tue, 29 Aug 2023 06:21:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8GwHfaFAj1gooyFJDE7qGwRo5v1gyu0mrAhIwmoDLo2gNZd65WIBelPBhYtl6ws2H8Zl9m+ayJblqo+IWFMEyIU6lew5HznU/7QC4knkfHOQ81fiNipWk1SnuppOU110UUQWU6iFaULC6s+AvzBWFi+IW9qexvHXZ+eEKu7DfxTo1kuFIhWe2BVJAgq7oAIJlBDfGt4kdsT1CHebPk5091SNbOYaOl8CZu1setTVQdEOhAqIjuoLm4VWK1FC6N/kAP+i8VjWcj8j+pYje0eEAyoF08Q2c54R38+yzLPcPNJQR4bUAiQ5sdCzNQv+RBtK/LX9alJXROConQMSsfo5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBF422gbU14tEx1lZNd6DmL3dHzoeU2LwjHEpS03OJU=;
 b=mk9xKyq5edk/A8XjjHLO9BBnyI+8zQlo72pg3m1tbOv8lzUKE92I2OI1mzxig/ZEy1VuuC7GXPDlEXwyrT/ICOQsGRgJGqIi3UeOdEbq9CuLLkRdoxnMIMROVRLv0y1wyY7UOujcEU44TO4msTO3piwji8cfhgbr8lLoBhbXK1C8ulSbPrt24Rcm2VaGjDoAWs2rVvYfX5kdwMA2HvOOWvAf6Ey2bxiVMnHCQxhgqtOWxJbBYJfvLAyjotgezrBzEZn6bxBZd4OTGTqI6/0ehTfRTGWQL7/Hmr3m531Hbl1/qZHUF2W7CmMBZ9jmcjOra16EL6lTlZK5V2e7xvYDsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBF422gbU14tEx1lZNd6DmL3dHzoeU2LwjHEpS03OJU=;
 b=FKntOigVcR3ZE3ZaylmNEOVdlN2xw9Q8mVXSyqdVQD0AdKC7wJuCt4FKWXizWEZH2OzueXGdzN3g4oS0P4e6A87e8hVpfaZkhQvoRsfE86kpVQyJUZcpc6YWtfuVrQlVPiQ+NQw44w15D0MxLbJJCR99kCBHVFRUYTgf2ItGTN8=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by PAXPR04MB8444.eurprd04.prod.outlook.com (2603:10a6:102:1db::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 13:21:40 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 13:21:40 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
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
Thread-Index: AQHZ2nu/S2vq/017mUGtcNKn0i+drA==
Date:   Tue, 29 Aug 2023 13:21:40 +0000
Message-ID: <PAXPR04MB9185D6762854207129D81CC789E7A@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20230818153446.1076027-1-shenwei.wang@nxp.com>
 <PAXPR04MB91858254554272C90822FED1891DA@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <CAPDyKFoV2Z=-WUiF3SgXqhF+K+r5QqsLgz8_hau0WKfZxTzYpg@mail.gmail.com>
 <PAXPR04MB9185F6AA20B0440B8FAB847789E3A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <4e2c18e3-b1ed-6361-3998-5de060d2bcf0@linaro.org>
 <PAXPR04MB9185957B729588D3E7CA3A5089E0A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <51fe3126-16ba-ade6-b106-e3683f96ad26@linaro.org>
 <PAXPR04MB9185DC79721E78E631F9889589E0A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <154b36de-652b-3931-96e6-04e99253a09f@linaro.org>
 <PAXPR04MB91852AD4E5242306B57A910B89E0A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <f3e89479-14ab-d1d0-ad87-6f457f313c39@linaro.org>
 <PAXPR04MB9185D87525AA88A8C3543EEA89E0A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <465e61a0-895d-54b9-d1b9-424265c82855@linaro.org>
 <PAXPR04MB91851302EAB989EC8261AEFD89E0A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <2bd01950-20e0-51f1-91d2-88c9ee2e8dc0@linaro.org>
 <PAXPR04MB9185526385C775306A87D85989E0A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <CAL_JsqKki2pcf+4q_7e-dEH+B59zr8uUtv-Y7ZCP0hb9jX25PA@mail.gmail.com>
In-Reply-To: <CAL_JsqKki2pcf+4q_7e-dEH+B59zr8uUtv-Y7ZCP0hb9jX25PA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|PAXPR04MB8444:EE_
x-ms-office365-filtering-correlation-id: c2e56687-d3fe-45f5-616d-08dba892e18f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zlzhm9cN/nGtbj3CRASu9fg5ZmBn23Eh7HgSMEFxE8aaCquBvmkavIhNx/DeTtpt5Z+DHvKgfwL6qK9MLY/PgovEm6tDdQuIWl+X6dUyF7bA5/aqfdfPkVk3WJBxUTEWpbjQaQA6rDcpIukSlhQNDMU+G2AtMKqIU/PbL97fisZt5e1Enq4SV7EuCnfrUuMRZ4AZ5uHmvEgtzn2v1UEXtzXhErB7kaLhp6mFsGUYzSf4VLONxEp1yAYKjS/5rMDdWHL2rKIFg7mADkZow70ngHRAiThVgVM9Juxsk1t6qAZN/ThlSjGogpmszDIOanv3GJUZeLB1RrN0ew/nR2L0W21ffhrVcw4KomUSLkn40Gvnm8MyvuuHzFEf2MRJmjdoejjlqybsIKpAav5kDD+zsjQNfvVXWOErveiexVyxIsQ7kWQb00LRhzG3aQc/wZxdlO9zYeCXZCF/PboUbnd32LMrruEaURXHp25tp5U7fHTehig1+qIT+HJkHzaac/ZcoMn1PJbNqZ8+MBqfa4pvGd7fNs/ZihlrJdCt8PxIWBxjocJ7vNC0KtUKzWG/x756zziYCRzWdejuFc6xys5JE/yO8wEhwQGxOnYgiLh1gzTXFeekBtPU4tNxUJ8Bc8qN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(39860400002)(376002)(396003)(186009)(1800799009)(451199024)(71200400001)(55016003)(7696005)(6506007)(86362001)(33656002)(26005)(55236004)(83380400001)(9686003)(38070700005)(316002)(7416002)(66446008)(5660300002)(53546011)(76116006)(66946007)(66556008)(41300700001)(66476007)(38100700002)(54906003)(52536014)(64756008)(44832011)(2906002)(122000001)(478600001)(8936002)(8676002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3Z3ckcvQ3Fubk92aFp6MjZFS0dJYjNMWGtQeUZMSnIxNzV2TXZhTmJleUQx?=
 =?utf-8?B?bmw5QTdHUnhJb0Nqb1RUMjdMeTE2ZmdwL0YvZXloYjNkR2d2bWFxZTM4U1kr?=
 =?utf-8?B?cFBlTXlSUmZ6QS9LOXo2L2I1aUZndzBlWWJxb0dSTXowZlJGUFJIMTFsczBL?=
 =?utf-8?B?T1pkbi9abC9uME5xaWx4alllTDJzc204QVgrT2pidzU0KzhZc0RnMTZsdDN4?=
 =?utf-8?B?akl2WjFJOEV1Vmg4ZC9zU3lHdEQ0QlJrcTBHRTFId2J6Q3hBL0lPaTQrb3l0?=
 =?utf-8?B?K3JtS3NYM0p3ZUhDMjZSUDVnT0FjMm1hOXFLVFBIajVicnBCWk9YVEJzeldw?=
 =?utf-8?B?YkNaaVBTZ0R3aHA4QXk2bWx1amlqWklMQVg5YnJwYUlCT1VvcHIyRENJMVRu?=
 =?utf-8?B?b011dlFxd093U2xwQlFHVjkrRFFDYlI0MW5SNWJqZWcvaFd0TUloNTBQWDBX?=
 =?utf-8?B?MXJEK3lRQUdGQXdyVUtuUUM4RlMzNmVMMlVDeUk4RGVoR2o4T3JSZWlhNzRI?=
 =?utf-8?B?QVZmbzR3YTFVVWNkaWhOQ0tWTFA5VGFINHpuZTdOcS81RllzLzZ0U0xROUhr?=
 =?utf-8?B?dUtHQ1UrUmxHSHVQdTUyZGFYVGpnb1RJVTJkYTFsT3RGU0ZscGlZaUNCektv?=
 =?utf-8?B?VGIraDF1REZNM1ZJYWU3U1h1SWo1Z1lIVTk1TDdHNnY1NVJLUU9WMUphTTBL?=
 =?utf-8?B?bWRML0hFcS9aSzdydlpoR1M5SUVVK1BNckN5Y21TSEFFQWRNOFBzblByYkE1?=
 =?utf-8?B?ZWczbmpRSU55L3BkQ3gwQ2lqOW5OY1hYZUR6VzMvcFJ3ZXhrNjFvTVgycEFR?=
 =?utf-8?B?L3J1VHVXUXF2MHZWZXhFMktQZHIzbjJ4Wnk2bTZ5RGxCcGJZdzJKYnlJYmMv?=
 =?utf-8?B?MEVuQW1PcnE1eHZSNFNXaDhvZ0pqc09GTDhtL0h2ZVJ6QW1KYUhRTkV4cURv?=
 =?utf-8?B?MGl2cm5MRzlJcTh5ZTdnc3BQcTR3NlBWc0ZHSG5YTlgwSTJhZEkrR1JERkla?=
 =?utf-8?B?WEhKSHZiblo0dmZSWDJlVCt0b2FtQmhqdzZZdzVCUjZ0bW00VUwvNjQ1a2hn?=
 =?utf-8?B?QUI0MVJISkp5bjVBMGNDTEdNU1RCSzFaNmlwODREUzVsZDZlNW1ENkxWR09k?=
 =?utf-8?B?KzV5L0JZYndSM3R4c1RRZ3pOYmhuNUE2WXFOTEJQUnBzWEgxTkl3YmZLMmVX?=
 =?utf-8?B?cEFxenVkek96VTd1K1VGOU5ldFV4b3ozcFVROW9oejZUL1BBODlVNzdoYy80?=
 =?utf-8?B?ZWYzUFFualJNQ1VvcW0wb0p0OGlVZWdaYjZMZlZjdGxvSG1Jb1dKUUd0cDNx?=
 =?utf-8?B?N1BsT0JmbjNkYlM0WXBRL3NmbFhqNmpreWVqVmNyVjR4TG5oaHdKZU9GVll0?=
 =?utf-8?B?dnE4d0ptZUlJa2FHa2wwNUltVE1tVmRjeDFhdFoxU0xQNjNlYS9hK2FzUUxs?=
 =?utf-8?B?a2hYcUZYNDVYWnhIY0pMN3ZDSkZQL0lnWTFSZC9sWm5RNTBxTFJlZmtaRTYr?=
 =?utf-8?B?dE0yS0w0VkRPTWlXNFdsSTk2cWNYeTBxdlp4dm5jenhwTXR3a3N6aWVCbmJU?=
 =?utf-8?B?dGp4UkRKdTVsYllNdGtsYUlQZGFNWkl4TUI3bDFyZlhvQVFCajZKY3FveWdG?=
 =?utf-8?B?TkxLNUJRaHpqYmZ5M1A2a0JtYjlDU0I2aFp0R1pNSmJnS240L3pZUk5Ub1ox?=
 =?utf-8?B?NE1ySnBtWGxQT05EVGt6cGVLZmRsNlp4bWVsaTR0ZFRqR24zZ0ZWcHE0L1hL?=
 =?utf-8?B?bStvVE03dmZ5N0h2N2ZvUXR2TVZndFZvT2Q3dXlQc3dSMWVZblNndUVzZkN4?=
 =?utf-8?B?STlwVjhia0JiZU9TTTQwYmxjN3ovY0RYOWplWmJBUm96cm1TOEhEeEF4aFUv?=
 =?utf-8?B?ZDE4SCszRWlVeHlhZGg4L2hpUGNCT3EwNzdCdkZhWndFTi9jVzdIa2ZJK29J?=
 =?utf-8?B?YW54aDNSY3p4NFJFWTU0ZXFLeDdJQzFRbEZXaXVqQk9wclJ0b1JoSGN3SDFN?=
 =?utf-8?B?TXUwcTAwcWNlZ1EzRU1ZNnVJeStBR08xMnRZblZrVnF4YlpyZjVoS0k4SElQ?=
 =?utf-8?B?Q3N1VVgrcy9lRjY5SjRLTjhxbXRMR21wRE5MSFdkVExrYmRDSURVYzN6eCtM?=
 =?utf-8?Q?Q2B0YVBmLZjuSvno7UD6wen7C?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e56687-d3fe-45f5-616d-08dba892e18f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 13:21:40.5668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b2mEFZ4YotcgERjOGjg6emAxzPTX4zPlBMJeXrK39wr7jViESuzVkZZhWkVUv5Xe5doHXVSpDcwFts0gx6sQfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8444
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iIEhlcnJpbmcgPHJv
YmgrZHRAa2VybmVsLm9yZz4NCj4gU2VudDogTW9uZGF5LCBBdWd1c3QgMjgsIDIwMjMgNDoxNCBQ
TQ0KPiBUbzogU2hlbndlaSBXYW5nIDxzaGVud2VpLndhbmdAbnhwLmNvbT4NCj4gQ2M6IEtyenlz
enRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz47IFVsZiBIYW5z
c29uDQo+IDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPjsgS3J6eXN6dG9mIEtvemxvd3NraQ0KPiA8
a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnPjsgQ29ub3IgRG9vbGV5IDxjb25vcitk
dEBrZXJuZWwub3JnPjsNCj4gTGlhbSBHaXJkd29vZCA8bGdpcmR3b29kQGdtYWlsLmNvbT47IE1h
cmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz47DQo+IGlteEBsaXN0cy5saW51eC5kZXY7IGRl
dmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0K
PiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBbRVhUXSBSZTog
W1BBVENIIDEvMl0gZHQtYmluZGluZ3M6IHBvd2VyOiBBZGQgcmVndWxhdG9yLXBkIHlhbWwgZmls
ZQ0KPiA+ID4gPiBUaGUgZml4ZWQtcmVndWxhdG9yIGlzIGEgdmlydHVhbCByZWd1bGF0b3IgZHJp
dmVyIHRoYXQgdXNlcyB0aGUgR1BJTyBwaW4uDQo+ID4gPg0KPiA+ID4gV2UgZG8gbm90IHRhbGsg
YWJvdXQgZHJpdmVycyBidXQgYmluZGluZ3MgYW5kIERUUy4gV2h5IGRvIHlvdSBicmluZw0KPiA+
ID4gYWdhaW4gZHJpdmVycywgYWxsIHRoZSB0aW1lPw0KPiA+ID4NCj4gPiA+ID4gWW91IGNsYWlt
ZWQgdGhpcw0KPiA+ID4gPiBhcyBhIGhhcmR3YXJlIGNoaXAuDQo+ID4gPg0KPiA+ID4gPz8/IFNv
cnJ5LCB0aGlzIGlzIGdldHRpbmcgYm9yaW5nLiBUaGUgRFRTLXNuaXBwZXQgaXMgYSBoYXJkd2Fy
ZSBjaGlwLg0KPiA+ID4gSWYgaXQgaXMgbm90LCB0aGVuIGRyb3AgaXQgZnJvbSB5b3VyIERUUy4g
SSBpbnNpc3QuIFNyc2x5LCB0aGlyZCB0aW1lIEkgaW5zaXN0Lg0KPiA+ID4NCj4gPiA+DQo+ID4g
PiA+DQo+ID4gPiA+IFRoZSByZWd1bGF0b3ItcGQgZHJpdmVyIGFsc28gdXNlcyB0aGUgc2FtZSBH
UElPIHBpbi4NCj4gPiA+DQo+ID4gPiBBZ2Fpbiwgd2hhdCBpcyB3aXRoIHRoZSBkcml2ZXJzPyBD
YW4geW91IHN0b3AgYnJpbmdpbmcgaXQgdG8gdGhlIGRpc2N1c3Npb24/DQo+ID4gPg0KPiA+DQo+
ID4gSSBoYXZlIHRvIGFkbWl0IHlvdSBoYXZlIGEgcmVhbCB0YWxlbnQgZm9yIGRlYmF0ZS4NCj4g
DQo+IEl0IHRha2VzIDIuLi4NCj4gDQo+IFlvdSd2ZSBnb3R0ZW4gZmVlZGJhY2sgZnJvbSBtdWx0
aXBsZSBwZW9wbGUgdGhhdCB5b3VyIHByb3Bvc2FsIGlzIG5vdCBnb2luZyB0bw0KPiBiZSBhY2Nl
cHRlZC4gVGhlIHByaW9yIGF0dGVtcHQgb2YgdGhlIHNhbWUgdGhpbmcgaGFkIHNpbWlsYXIgZmVl
ZGJhY2sgZnJvbQ0KPiBldmVuIG1vcmUgcGVvcGxlLiBQbGVhc2UgZ28gcmUtcmVhZCB0aGUgcmVz
cG9uc2VzIHVudGlsIHlvdSB1bmRlcnN0YW5kLg0KPiANCj4gRm9yIGZpeGVkLXJlZ3VsYXRvciwg
SSBjYW4gdGVsbCB5b3UgdmVyeSBlYXNpbHkgd2hhdCB0aGUgaC93IGxvb2tzIGxpa2U6DQo+IA0K
PiBWZml4LS0tfGdhdGV8LS0tVmZpeC1nYXRlZA0KPiAgICAgICAgICAgICB8DQo+IEdQSU8tLS0t
LS0tLXwNCj4gDQo+ICdnYXRlJyBoZXJlIG1heSBiZSBhIGNoaXAgb3IgZGlzY3JldGUgdHJhbnNp
c3Rvci4gVGhhdCdzIGEgdmVyeSBjb21tb24gYm9hcmQNCj4gbGV2ZWwgY29tcG9uZW50Lg0KPiAN
Cg0KVGhlIGRpZmZlcmVuY2UgaXMgaW4gaG93IHdlIG1vZGVsIHRoZSBoYXJkd2FyZS4gSW4geW91
ciBleGFtcGxlLCB5b3UgbW9kZWwgdGhlIEdQSU8gDQphcyBhIHNpbXBsZSBzd2l0Y2ggdG8gZml0
IHRoZSBmaXhlZCByZWd1bGF0b3IgdXNlIGNhc2UuIEhvd2V2ZXIsIHdlIGNvdWxkIGFsc28gbW9k
ZWwgdGhlIA0Kc2FtZSBHUElPIGFzIGEgcG93ZXIgZG9tYWluIGlmIHdlIGNvbnNpZGVyIHRoZSBk
ZXZpY2UgY29ubmVjdGVkIHRvIGl0LiANClRoaXMgYWxsb3dzIGZvciBtb3JlIG51YW5jZWQgaGFy
ZHdhcmUgbW9kZWxpbmcgYmFzZWQgb24gdGhlIGNvbnRleHQgYW5kIGNvbXBvbmVudHMgDQppbnZv
bHZlZC4NCg0KUmVndWxhdG9yLTEgLSstPiBbRGV2aWNlIEFdIA0KDQpUaGlzIGdpdmUgeW91IG9u
ZSByZWd1bGF0b3IodmlhIEdQSU8gUGluKSBhbmQgb25lIHBvd2VyIGRvbWFpbiAoRGV2aWNlIEEp
Lg0KDQpUaGUgZm9sbG93aW5nIGFyZSB0aGUgZXhhbXBsZSBkaWFncmFtIGdpdmVuIGJ5IHRoZSBw
b3dlciBkb21haW4gb3ZlcnZpZXcgZG9jOg0KDQogICAgICAgICAgICAgICAgICAgICBSZWd1bGF0
b3ItMSAtKy0+IFJlZ3VsYXRvci0yIC0rLT4gW0NvbnN1bWVyIEFdDQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICst
PiBbQ29uc3VtZXIgQl0NCg0KICAgICAgICAgICAgICAgICAgIFRoaXMgZ2l2ZXMgdXMgdHdvIHJl
Z3VsYXRvcnMgYW5kIHR3byBwb3dlciBkb21haW5zOg0KDQogICAgICAgICAgICAgICAgICAgLSBE
b21haW4gMTogUmVndWxhdG9yLTIsIENvbnN1bWVyIEIuDQogICAgICAgICAgICAgICAgICAgLSBE
b21haW4gMjogQ29uc3VtZXIgQS4NCg0KVGhhbmtzLA0KU2hlbndlaQ0KDQo+IElmIHlvdSB3YW50
IHRvIGRpc2N1c3MgdGhpcyBhbnkgZnVydGhlciwgZGVzY3JpYmUgdGhlIGgvdyBpbiB0ZXJtcyBv
ZiBzaW1wbGlmaWVkDQo+IHNjaGVtYXRpY3MuIE90aGVyd2lzZSwgdGhlcmUgaXMgbm90aGluZyBt
b3JlIHRvIGRpc2N1c3MuDQo+IA0KPiBSb2INCg==

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219F478B28B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjH1OEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbjH1OEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:04:06 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2055.outbound.protection.outlook.com [40.107.247.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63947F7;
        Mon, 28 Aug 2023 07:04:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e06dof+l8/0pNYkqsXm79d0vZKTJNy2Vi8zQdgU1L3pZ20r7GVTr4iwJrd3bu+PtpIUx+wzQH4IcL8EFmzfW0v99sB7T91/0uNku2lYxKl6WZuyoSczlZ95iHeO7G90HynVRnNxdF+nr5F+sGVyTo/TVQd9etXxE3RbjN13VdUAP2sP2AOXN1RKrPQoXkP8wxmQ6pLHyTIo5cEEXOC5WoCViL4exliTsBF5YrUILaK0yEq4uwWA2Vvfd3hHdXfvLxxGkAmEtBOR8N5dzH2g+BAdrhBNawXDPuARWUaF4oIgOeOeRrUSx3Y67wmTdMg7FHzgSPLkOfv6CIoVTNk+c8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=771jezG8Ax40XSah3pcavh6sj4w74tj3QV6/ndcqjyo=;
 b=gkRJuVoJMasqwKSVaf63rcV/+EqllBMbq3eUmaCaGgs7WZNX+l7Svn2EiiiJFszI7aAc3RfgkynNAyLX1sSGyk4yJtPM96W2lDiVHC8R8aXH2Uri89GXaW2pnZRqyPBJRidBsoqvuAMC89/rHxI5Lu9XkKh3WfCvyUQjexErPHm0vwy6rT+rwBFpNh0ai/RrFa/HnOiSLZ+ymdCJNcuscSYJC1XL7CWc4/SEo4BQAhEgpZFFrpUTTmDRDa7aGaWTLOghYz6vUw9emjbF5b347sBUhqn8KbNFgc6OxCRo0bL8vYNOmatm6AkftntsJDQgfPDmJKhEGcank7O/zIMVWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=771jezG8Ax40XSah3pcavh6sj4w74tj3QV6/ndcqjyo=;
 b=l8xHRUwZvD7/dd2PUNGn9nfMRkqqLtPxuYeQFESDjHcvm5anLxJz5nnQNcJhX3BKRlJcwefdfQWppz8lnuUvzAjfMZ9Ao9/5FZWr/qhp1ibJw7kI3a3FgsQjh7hNKHq6oGDQR7twOJkbsbq7f+lm3jnUCwG89Tc4g/fSf0SqLIg=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AS8PR04MB7686.eurprd04.prod.outlook.com (2603:10a6:20b:290::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 14:04:00 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 14:04:00 +0000
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
Thread-Index: AQHZ2bh+vGBIZcBauEmrH5FKU4sboA==
Date:   Mon, 28 Aug 2023 14:04:00 +0000
Message-ID: <PAXPR04MB9185957B729588D3E7CA3A5089E0A@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20230818153446.1076027-1-shenwei.wang@nxp.com>
 <CAPDyKFqsn6kVjPFUdVyRxNDiOaHO9hq=9c+6eAK4N-v-LVWUPw@mail.gmail.com>
 <PAXPR04MB91858254554272C90822FED1891DA@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <CAPDyKFoV2Z=-WUiF3SgXqhF+K+r5QqsLgz8_hau0WKfZxTzYpg@mail.gmail.com>
 <PAXPR04MB9185F6AA20B0440B8FAB847789E3A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <4e2c18e3-b1ed-6361-3998-5de060d2bcf0@linaro.org>
In-Reply-To: <4e2c18e3-b1ed-6361-3998-5de060d2bcf0@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|AS8PR04MB7686:EE_
x-ms-office365-filtering-correlation-id: bd298967-ed7f-46c9-8dd0-08dba7cfa108
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n9LIN97U5i1jgbZvKSlEWHWod6cSjynB5zNkwx0C8CLn3HUFUbeJxAoSdgvbXxpdk0pAGJ9i7UJxwdellQo9efb6cPf93I/qgfsIuzxQng8hg2+tqfqYuDpyVhuHOqhUY9/GaIRFaZuv9c2k/PUm1L/5UgUhbaiuYX/XcW/Zdp6MJQMjUFXnMPbW4cNlZb1PWUdO1xvhvhtmcqX5mE1fwuGvEa1IrXJx/dqz2bFHZ7+jl2kS7f6uYiMSSeR0Imdd45MfVB8L+EoYDIiudnlJFzIEK5Fi3wcIogw5ospIaW8DBHoJ5NUYoL/+K2K6/khCogZlzVVJIfJWxnORVqxDa8kTiy2IX5Iflhhfi9OmUYHstyKfzhcmbu19g5q/bM2UckvQjlPOTI5kBbqqzVsv2Dgxn+rzggUS5oN9ikgv77th1kAzla/+hg2Pxfb7EDCYQOzVoxkuqZIaG2LvCWqoZPBrYRpMVGZnKoxHMLCZ0MpEYBLNwrqPtt4ekzWqBr7mcdfWgv6jQ0rPzBQ6ccNjPRgX/4SqrUOa3IKyLXFHInwmR1eH3QdSDVVR4Twj7m9nHZQyVNMpR4+IRBXeWMnBwrby6t7zQiUzWJYAnoRR4iQ45xwOTgTq5u1K8QuVzyZ4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(39860400002)(346002)(186009)(1800799009)(451199024)(41300700001)(66899024)(7416002)(26005)(122000001)(38100700002)(86362001)(478600001)(38070700005)(71200400001)(83380400001)(9686003)(55236004)(6506007)(7696005)(53546011)(55016003)(76116006)(66476007)(54906003)(66556008)(110136005)(64756008)(2906002)(33656002)(66446008)(66946007)(316002)(5660300002)(8676002)(8936002)(4326008)(52536014)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emVscjZoRzh6T0k2a3RLU0lTN3d6S2NpVlVFQmt2RHd5WTMzYjhIaHVYSG5S?=
 =?utf-8?B?a0pyUWoveUdQVlB0Q1hvUzNUVlNBM0dxdU5xTExpRGhlbkpEaXBFUFFxNzlF?=
 =?utf-8?B?VVhWTzJzNnpraXdrK3JabWlEZlgwVUd6Yi9iZ254MkFyeC9QdXlOcXpzZVZp?=
 =?utf-8?B?dUx3MFZPanphRmt5Y0Q4SVZuR01vUG1rOE1id0I0RFRQL1NxR0tWWTBOSnlY?=
 =?utf-8?B?cnNLOExUanl0Ni8rUU51dzAzQmR1bldMNHpuOEcra1hsUHcxRlZmMGlDbi9T?=
 =?utf-8?B?ekNvOEE0eUh5b2loTm51YkU1NTRQS0JRYkxVS0VmbW1HbVl0U0Q0T1Y1TVhI?=
 =?utf-8?B?dUgyeGh3clQ1VTJHV2c0Nlo5Rmg1ZzJYRU9HYlpWUVBIcEF0WTN4NDVtNjNy?=
 =?utf-8?B?bHlBVlNENlJOclZHYVpqenZtY01hdWhkSStMbUttcXBqNjVSZEhvd2dYWXhj?=
 =?utf-8?B?VWo2L3RzMjgxYkc2d0k1dzdIZDRYdjBvVkdrZXNFUzRQNnJhVVpLeGNXcldn?=
 =?utf-8?B?b2JHaHZiM1czR0lVM0RJWEVTMERxYXJBWlNDQng4Qk55Zjdtc3dvRHN4WUNX?=
 =?utf-8?B?QlZtdlMvV3E4MUdQZTNZV3Vrd1YvblZXWUd4Y3hmdVk0a0M3V3E2d29oZkIv?=
 =?utf-8?B?YTBpeUhXbDA5ditRRTA4VVhVcjREVk1lWGJJUlpxSmhLUzRUZkl4Yi9rQnN2?=
 =?utf-8?B?TFgvT2UvZEVBNFpGcFBEYU53Mlp6bWpaOTRBRmtsSWJXUS9Bd0hYL2pmdWpr?=
 =?utf-8?B?b0hCR0lmMXNJMHNtOFZmQVQwZ2swcXhKUjRkMVdScGJxaEpwdHQwUTlpY2ZN?=
 =?utf-8?B?RjNyRyswVExETVp4VndIK21HWThreE1Ha1M4b1ZRckVXTTJhT0E5UVlVMWkx?=
 =?utf-8?B?M1crb3h1eGUyM0JaR0orVm1VV3hTT291ZjMvN3E1ejI5RXpjOXVHNk15NkRh?=
 =?utf-8?B?R2ZNL2Q2aUR5Qm1JN0x3MUpKdlZlcjJjd0pnWVZpdDlmSDJBdC9VMUZsMEp1?=
 =?utf-8?B?MjUyQ3hWc2xqVVV6ZWIrRDBuUWE1MnZuQm5Mb0praWRqaXQ3Mlp3ZGhNUkwz?=
 =?utf-8?B?VEI4b2NVaUNFQnc5Qzc3OUF0dmVEWmtQeGYvdDRPeVpDZXlaVnJNS2xJbzNa?=
 =?utf-8?B?ZGRSKzB6VGh4NVBWdk9ReWtzMm1IMkNyL2xidXU4R1gxYnZwQWJqeWh6em9P?=
 =?utf-8?B?d3NmYVZXajNVblpOZFZTOVpZZVZxSkppZitUN05zNjk5Rzc5NGlETkdkYWhl?=
 =?utf-8?B?R0hxazhqNDRVWXQ4NHJJV2lZbG15NElxZVlES2VjKzl1WjdKYUwydURnaFRr?=
 =?utf-8?B?ZWRTeFRpcVVTQlBua0J6cmkrTk9lcjdzaitlY21Ld2wyRVJsazBJTzhpL3Y0?=
 =?utf-8?B?NEI5cjBkQnMxU29ZQ2Z0WGFiVDN0b1NqamVHU2J1MStjNEtUSnRUTEVScFU3?=
 =?utf-8?B?ZFV5ZVBhWkRvNGpPcG1UaUJGaU5DOHgrV1NzdVY4MDVwY2EvalJvdkVkSWpz?=
 =?utf-8?B?NlhlZG5DQzM2MFpXcWRKVjBwWmNnOEprWkpSRUoxaUVOcU9aSVY3ZzgxTWJN?=
 =?utf-8?B?eTU1bHM0d0M3R3p6RmxBcllaWUdOTFZIYVJRSGlITFYzSDdkWGZZWmJjSkFL?=
 =?utf-8?B?b09vTzJvS3I1b2FjMHlMSTd5cndwZmE1endMRlhmamR1Z2VGQnFFZXJ1djln?=
 =?utf-8?B?OERUaTBkM0NmK0J5TFdrV1FEd0NGUmhweEd2d3RvdFRGRTlOdktGdlNQSDMr?=
 =?utf-8?B?ME1GLzB5Y2U2d3J3QjJmL3RiczhxdnNKQmUzejBVeTUrUU9sZU1LL3FwbUtR?=
 =?utf-8?B?TVozdi84MVFiditlNEgwTU13TlR4Sk1KN0VkOFM2R2RLWGp6WmJmQmJHc295?=
 =?utf-8?B?UktvMk1vSEVmRTRaWXA1RG9mcmIrRUdGd25CVGpQeURMQlE5UStrQ09zbHdD?=
 =?utf-8?B?RjBlYWVLR2kvcW0zZzRwbG44c0JYSUQvSEt0OEJhQWdmZnBtWTBJT2FXNjMw?=
 =?utf-8?B?UEptZHdCNGtaSEN4cDlkY2VuNXVKekdwTGJ1SGhGSFNZVDdsM3lyc3AwN21n?=
 =?utf-8?B?R1FaYlZ6RE51N2tXRTdXN3hBdmFIOEZIaGJ3a1I5L2NmRzdKWDFBRE41OXRi?=
 =?utf-8?Q?OOpcDoIdjm/2EYnAu0d9AveOC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd298967-ed7f-46c9-8dd0-08dba7cfa108
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 14:04:00.4372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hvvaGvf46Brfn7aiLqVXabuzuYUHUvP65BF9CRu4aF71ExBFwSVEjPVKM/OfTsrXQtlVM2B2CNjphMBOfZ9M5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7686
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
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBTYXR1cmRheSwg
QXVndXN0IDI2LCAyMDIzIDEyOjMyIFBNDQo+IFRvOiBTaGVud2VpIFdhbmcgPHNoZW53ZWkud2Fu
Z0BueHAuY29tPjsgVWxmIEhhbnNzb24NCj4gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+DQo+IENj
OiBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtvemxvd3NraQ0K
PiA8a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnPjsgQ29ub3IgRG9vbGV5IDxjb25v
citkdEBrZXJuZWwub3JnPjsNCj4gTGlhbSBHaXJkd29vZCA8bGdpcmR3b29kQGdtYWlsLmNvbT47
IE1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz47DQo+IGlteEBsaXN0cy5saW51eC5kZXY7
IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
Ow0KPiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBbRVhUXSBS
ZTogW1BBVENIIDEvMl0gZHQtYmluZGluZ3M6IHBvd2VyOiBBZGQgcmVndWxhdG9yLXBkIHlhbWwg
ZmlsZQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgID4NCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICA+ICAgICAgICAgcmVndWxhdG9yLW51bWJlciA9IDwyPjsN
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICA+ICAgICAgICAgcmVndWxhdG9yLTAtc3VwcGx5ID0gPCZyZWcxPjsNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA+
ICAgICAgICAgcmVndWxhdG9yLTEtc3VwcGx5ID0gPCZyZWcyPjsNCj4gPiAgICAgfTsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIH07DQo+ID4NCj4gPiBBcmUgeW91IHN1Z2dlc3RpbmcgdG8gbW92ZSB0aGUgcmVndWxhdG9y
LXBkIHRvIHRoZSBpbXggZGlyZWN0b3J5IGFuZA0KPiA+IGFkZCBhIGNvbXBhbnkgcHJlZml4IHRv
IHRoZSBjb21wYXRpYmxlIHN0cmluZz8NCj4gDQo+IFRoZXJlIGlzIG5vIHN1Y2ggcGFydCBvZiBp
TVggcHJvY2Vzc29yIGFzIHN1Y2ggcmVndWxhdG9yLXBvd2VyLWRvbWFpbiwgc28gSQ0KPiBkb24n
dCByZWNvbW1lbmQgdGhhdCBhcHByb2FjaC4gRFRTIG5vZGVzIHJlcHJlc2VudCBoYXJkd2FyZSwg
bm90IHlvdXIgU1cNCj4gbGF5ZXJzLg0KPiANCg0KVGhhdCdzIG5vdCBhbHdheXMgdGhlIGNhc2Us
IGFzIHdlIGRvIHNvbWV0aW1lcyBuZWVkIGEgdmlydHVhbCBkZXZpY2UuIA0KQXMgYW4gZXhhbXBs
ZSwgdGhlICJyZWd1bGF0b3ItZml4ZWQiIGFjdHMgYXMgYSBzb2Z0d2FyZSBhYnN0cmFjdGlvbiBs
YXllciB0byBjcmVhdGUgdmlydHVhbCByZWd1bGF0b3IgDQpkZXZpY2VzIGJ5IGludGVyZmFjaW5n
IHdpdGggdGhlIHVuZGVybHlpbmcgR1BJTyBkcml2ZXJzLg0KU2ltaWxhcmx5LCAicmVndWxhdG9y
LXBkIiBwcm92aWRlcyBhIHNvZnR3YXJlIGFic3RyYWN0aW9uIGxheWVyIGZvciB2aXJ0dWFsIFBE
IGRldmljZXMgYnVpbHQgb24gDQp0b3Agb2YgZXhpc3RpbmcgcmVndWxhdG9yIGRyaXZlcnMuDQpX
aGVuIGxvb2tpbmcgYXQgdGhlIGNvbmNlcHR1YWwgcHVycG9zZSwgcmVndWxhdG9yLWZpeGVkIGFu
ZCByZWd1bGF0b3ItcGQgYXJlIGNvbXBhcmFibGUgaW4gDQp0aGF0IHRoZXkgYm90aCBvZmZlciBz
b2Z0d2FyZSBhYnN0cmFjdGlvbiBsYXllcnMgZm9yIHZpcnR1YWwgZGV2aWNlcy4iDQoNClRoYW5r
cywNClNoZW53ZWkNCg0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=

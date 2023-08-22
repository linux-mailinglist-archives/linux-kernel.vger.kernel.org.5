Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9360B78463A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237363AbjHVPua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237356AbjHVPu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:50:28 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF11DCE7;
        Tue, 22 Aug 2023 08:50:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FELBuKS9LXeUrnnzWj7kD11jRLph8LjC7f1T5UOg2tqbRtN6DbQGL1/AIsWftwt7krNvQqR2PlHJIwYZpZMEF2VNLf7vkajgZtrjFWojvqHOlqQwUUici5ygfYvs6jsiFQ9SfyNSj9xQh3MpmJCoUdw03WZbRxQTVtnrJJyhOJRbbkaDHENl1iQJarj/ljZ0c00eU7NVEUpJ/9Fj6VnjvRJ6FG8+AezctRR/LTOvoagiUhB3ahfvexdE7rT0Vhxw4X8VuVWAgrOjZAgs37n1sQz5iMa28pcpFYw5UDVt/NhnjY5msZYAx5vhwrbZZoUIhD/+GdLRswX6wLAjijJMEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9l+B7nrnwvEL/7+rD32v1HBK/2KlMV+pnAcqaM/mQU=;
 b=lt3IYgTxyT/uNSal5L/ReJTnUcxWm9ktVWfm4AiPus6jeKmfxYpCUYTczbEZDwwd6MEUUOGeHbxhtzQDHUhzjVbfCPLZDhMR9MCdrVJcVhmI2sR3BklL78BpiqAjgTYN1yac9x1XyXsElnEA6xYtGZhir7u9p8cDKH9xAAKxFniyp/1tFFnXRdPnb+CtlA2a4PRi4z5LNw6Bc6XuGQ4K74Zy+aPdz/w+1yyNZ6t2db4ChBs7HI1TfWyGdU5qPEwa1bb2/qGHb70ikmNSlucoW7E00hXOqMwh1BUNyLKrl02XLvZbyzixNMBuUG6AJ3gI+X8uFAu4l46m34sHGfw0OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9l+B7nrnwvEL/7+rD32v1HBK/2KlMV+pnAcqaM/mQU=;
 b=AfN3z29VZV9UPGeEw6Bx1etlNnDi4ghD60xtP231aTxLxAFjANwiLFEMOD9dvqyOatxmWpgvrXLSQDlKLwQJNa56ZHzXK2Rqer5VL48MvWE/o+LtIBeO+4frCBgMapYuJtUEIHr6pcpwNjjQkppRD87cnf4zyxbHmV20/CXdWaM=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DBBPR04MB7643.eurprd04.prod.outlook.com (2603:10a6:10:203::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 15:50:19 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 15:50:19 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [EXT] Re: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml
 file
Thread-Topic: [EXT] Re: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml
 file
Thread-Index: AQHZ1Qvad0tEZmhA00uHLX8j50FdDK/2b60AgAABTDA=
Date:   Tue, 22 Aug 2023 15:50:18 +0000
Message-ID: <PAXPR04MB9185F7B520E8BE94B97C4908891FA@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20230818153446.1076027-1-shenwei.wang@nxp.com>
 <CAL_Jsq+XA_P-aRK9_WuGPmJ0_xJgsSr9smZy4BRbKZbmVsMQBQ@mail.gmail.com>
 <PAXPR04MB918539A19B8F817F623BBD1F891BA@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <9927403d-6dd9-3e5e-8f9d-f38e6640f95f@linaro.org>
 <PAXPR04MB91850D8807CE374BD7C30CC5891EA@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <CAL_JsqJ3dr7gxq+D5DYG8oQ=igzjARz=beQoYL7rrydV4SwDTw@mail.gmail.com>
 <PAXPR04MB918567C378D420DB4830B869891FA@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <51bc0ccf-425b-5f16-b8f2-94d7cc979fae@linaro.org>
In-Reply-To: <51bc0ccf-425b-5f16-b8f2-94d7cc979fae@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|DBBPR04MB7643:EE_
x-ms-office365-filtering-correlation-id: a3e2806c-89b3-43af-2905-08dba3277c73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /1v7dOlMAElX8a90d4BG00Ke9B2Ob6msslP5a4ALE8Qe6nKloMmU01XHQBSWs0NXIAcjG0/7zsxoGwCcv2PxFVKcIkwUI09ElCSu7NSRiW81nLNR6Ri5SoJo8uI3FD6W0JsgVu0feRDcrPKFwtIHAYyOrS3TfJBq+BKoi6vIBOn68OJ9y6yKF088zrEcPVCrfEKz8K123mKioA6vPMi57FcAA7khk0fb7lm58cOdHLwrzFD+MshQa4+1GE1ucSkOW/O8bD2SMCSE5vI087eiqZDPLoc1ICLTL1VjxGONl5JJQerjsXF69mD7pWoCJXjchcjfl3NHRwSyXDJ0eZTb26Iyu6nnEJyNEolSwbxjCbVGe/GoVexm0Qu9gqAusOooUVOwRbDU3luT19xst56cZg9E42kuFqJFp18xSaapMA92JAlVfcKXC6DI8qiXp+Cv/RtxEDvGhnsh6Bmsf+KF5/F0sBvGtK6/nfP3B+1CAn5oAIQMCNTimAowE4qcbwi+Z1rgi2/W2mQ8Y4hZ4ztyXtpM4EM7HlsRR+9kwqCFUvYIY38XKxEtEHUO6DBwq0copdQeXeugGnDsXQhPQs5+Psu+Zmr3mC4tWrpNcIL7fh91uYgToxkm0enjS38APEnJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(346002)(366004)(1800799009)(186009)(451199024)(54906003)(76116006)(66476007)(66446008)(66556008)(64756008)(316002)(66946007)(9686003)(110136005)(8676002)(8936002)(4326008)(41300700001)(478600001)(122000001)(55016003)(71200400001)(38100700002)(38070700005)(53546011)(6506007)(55236004)(83380400001)(2906002)(7416002)(7696005)(86362001)(44832011)(5660300002)(26005)(33656002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUkrT1dacGJVaDdHWG5xV0M2NFdFTENIbjNvS3VITFNYUW9oWWo0U1NrTXhB?=
 =?utf-8?B?dDcrTzNHZW5SVUFoK3BmZXA5TTkrR28zcFc0c0JkdU1nZUFwTU1ZSVRxRXN1?=
 =?utf-8?B?alNaUERmQkxrNWFnYy8yRlhQK3BjNDIyaDdtZFYzS3lkRTlCRm5BVCtINWhh?=
 =?utf-8?B?cDFzbHY4TlFvVklvRkM5N1d2TFhUZXMzZHpWSTZpeng5K3JHZlZPQTBSb0dn?=
 =?utf-8?B?L2N1aGw5aVJYVVhvWmprZ0taQy9CWXdjSlZ0L1ZvV2Jac1FMR1Znc3ppMThn?=
 =?utf-8?B?ZmlIZ0hkOUU2am1Ub2laK2orOHNjWFhIT1JmUlU2YTgxb3Z0ZTdpM2ZCamh1?=
 =?utf-8?B?Uk9WVkJhRXNPT3dKYU9LWXNOSVdaZ0UraU8xM3dleUNGYklLQlVQN1ZZc2FF?=
 =?utf-8?B?S0o3RU96d2M4OVJCb2dBNnIxM05hNGZ6emtjREVqNUNOUThvTCtDTlJmZWQx?=
 =?utf-8?B?WDdKZFRza0RiZytEMWVvNWlBZkdGZ0xlVlJPaHFLQ1FtbEExRW45cXkvUGov?=
 =?utf-8?B?eWg0dDE5cGVzT1hNWjkyd0NYaGRPS1VqZ3UxSHg3S3ZZbDBOMk5CUDdpMmZh?=
 =?utf-8?B?ZUF5aURraWdSZVN4N2FUMmUrc2MxUVE0eFpvdGI3YWlxVXd6M2NielJiUjFr?=
 =?utf-8?B?dE9zY2Z0ejFRSHBXQmlFVXZnZVl6QnNBbFFrVG56QXg0TDNiRW5xVlBGaDNu?=
 =?utf-8?B?Zi9rWCtmQ1VmK05xWDZ3bHZxTitkcGZWdmtDa2xxaHRtZlVST0hMTnhXUmxZ?=
 =?utf-8?B?Z2llTDIwZ1pFL1IrUGtUaGRUSW9PQmNESm5RdUc4bU14MEFmWEN4MW5sN3Ns?=
 =?utf-8?B?MTB1MVhGQ1NFZERBV3NLRXg1NGRDMUhwUElQM2hZY2JySVo2cUVvOUVKblQ3?=
 =?utf-8?B?U1llODZBSTRxWW1CeGdVWDVTQ1REazRMY2crRFVrQ2hocDBxa1RnYjk2bC9V?=
 =?utf-8?B?L3dXUm90d1RrYlVEM3FyRFh4WlVmNjNJZjNvYnpZUFJNVE9vcmJKZzFsR0cy?=
 =?utf-8?B?YWZFTXZuZjFvMGVDbkNZS3ZmQmZYeTNDd0VXa0hCSzhpTHhKL1VJNlBIMWRh?=
 =?utf-8?B?OUtta2hzWXdscWRyMDdseHlhdi9NdzNxZk0yZXlVWEVQSjFLWWpndHJSSWwx?=
 =?utf-8?B?VG9ZdTYwSkJJMnBPQ0FULzJHc3lWQkRNaVVjckpaeDBSL2hHQ0NZd3pFdUJi?=
 =?utf-8?B?d1dSYy9naDJFanRreFNFODhOdUd5Rzg2MjRJWHpxY25tVmdFeEVTOFo2Umdl?=
 =?utf-8?B?WHE2bms1TnJia0d0T3UvNjM4ZCtBdDdwaHFMNDlQZmVXWmZGakRBcVFDNG5V?=
 =?utf-8?B?bzRxeEVRd1hHOHJwQ1VPR1Nia1BRMzdlSEluSFpnajY1dW5EL1JBa2p0SERH?=
 =?utf-8?B?L3R2MW9FQkFjWFJhd2owdy9pQVBZWjdtSGRiWVVSdld3aEFxRmdBd1ppQkJH?=
 =?utf-8?B?MHNnS1NXSTQwMzBKU1Z5SE4yR3lDZ1g5RWZJNDVmMzl5eU8zeEVUdmlPSU42?=
 =?utf-8?B?emhqU2VHY3RXYUN3cGxuT0ViamJQQW5RLzQ1USt4SUxVMXlKN0svc2R0YmRo?=
 =?utf-8?B?bzlBSzkrd0RpL3BCMEJvVCsrU1ZodVBtM29QTXQrOWJmQk5iNVNJQ2NOZ2Mx?=
 =?utf-8?B?THM4Y0hlMjg0WFNNUHFacGs3MXg1cEIwQ2RlbDY1WEtTQzlDZDNOakx0QVhO?=
 =?utf-8?B?bFpRenpUa20xUEgwdzB4K2RIb2FJSndGVDJSQUJVazlzZGZxZDRVbmFKenFW?=
 =?utf-8?B?cEtERGVJaU5FZGFXOU9NZ3UxeGZRY0xNSVYyRnRDR3E5VGJyajJ6aWhBM1la?=
 =?utf-8?B?MFN5QndqM01mZzNzczRQUW9pdDJvb3R1RGROT01ZYVZ1WllPcUNhZkxkU2dr?=
 =?utf-8?B?ZUw0UVdWY1MyRzluNi9YbjhoQzA1SzZOMzAzY1RCdnZxejdlYUQwSlQ1bmRM?=
 =?utf-8?B?b2piMzJwb0duVkVtOXg1bXhNaTUweXc1bFBNbm5oQ0Y4b2doT3MwdUFXM3Bk?=
 =?utf-8?B?ZzA3UXBUSG5SQnB5a2tqRkxmWDV1Szd4aXBvMXZINXlSRkh1aUhERU54amQ1?=
 =?utf-8?B?TWJGdU9SMEl2QldnY093enlSNWJoMGpROXEvbUxmcVVBRUhwN0l2eXcrSjI2?=
 =?utf-8?Q?Qjhpxi044vwp5qSUZowESOZa5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e2806c-89b3-43af-2905-08dba3277c73
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2023 15:50:18.9669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OTjXMfuYqyXGNkABbnLwkLXCPv2S8C5mOwxbjloF/9XYCPy2Zr50wLWN7gYf3xN2+HkIuwEGvVw+Btr6IPiXUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7643
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBB
dWd1c3QgMjIsIDIwMjMgMTA6MjYgQU0NCj4gVG86IFNoZW53ZWkgV2FuZyA8c2hlbndlaS53YW5n
QG54cC5jb20+OyBSb2IgSGVycmluZw0KPiA8cm9iaCtkdEBrZXJuZWwub3JnPg0KPiBDYzogS3J6
eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnPjsgQ29u
b3IgRG9vbGV5DQo+IDxjb25vcitkdEBrZXJuZWwub3JnPjsgVWxmIEhhbnNzb24gPHVsZi5oYW5z
c29uQGxpbmFyby5vcmc+OyBMaWFtIEdpcmR3b29kDQo+IDxsZ2lyZHdvb2RAZ21haWwuY29tPjsg
TWFyayBCcm93biA8YnJvb25pZUBrZXJuZWwub3JnPjsNCj4gaW14QGxpc3RzLmxpbnV4LmRldjsg
ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
DQo+IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFtFWFRdIFJl
OiBbUEFUQ0ggMS8yXSBkdC1iaW5kaW5nczogcG93ZXI6IEFkZCByZWd1bGF0b3ItcGQgeWFtbCBm
aWxlDQo+ID4NCj4gPiBObyBvZmZlbmQuIDopIFNvcnJ5IGZvciBteSBwb29yIHdvcmQuIFRvIHBy
b3ZpZGUgbW9yZSBjb250ZXh0LCBhDQo+ID4gY29tbW9uIHVzZSBjYXNlIGV4YW1wbGUgaXMgdXNp
bmcgYSBHUElPIHBpbiBhcyBhIHBvd2VyIHN3aXRjaC4gVGhlDQo+ID4gY3VycmVudCBpbXBsZW1l
bnRhdGlvbiBvcGVyYXRlcyBhcyBhIGZpeGVkIHJlZ3VsYXRvciwgd2hpY2ggbWFrZXMgaXQNCj4g
PiBkaWZmaWN1bHQgdG8gY29udHJvbCB0aGUgb24vb2ZmIHRpbWluZyB3aXRob3V0IG1vZGlmeWlu
ZyBpdHMgZHJpdmVyLg0KPiANCj4gU28gaXQgaXMgYSBwcm9ibGVtIG9mIGEgZHJpdmVyPw0KPiAN
Cg0KVGhhdCBpcyBhcmd1YWJsZSB0b28uIFRoZSBkcml2ZXIgbWF5IGFzc3VtZSBpdHMgcG93ZXIg
aXMgb24gd2hlbiBwcm9iZWQsIHdoaWNoIA0KYWxpZ25zIHdpdGggaG93IHRoZSBQRCBiZWhhdmVz
Lg0KDQo+ID4gSXQgYWxzbyBsYWNrcyBwb3dlciBtYW5hZ2VtZW50IHN1cHBvcnQuDQo+IA0KPiBX
aGljaCBpcyBub3QgcmVsYXRlZCB0byBiaW5kaW5ncyBidXQgaW1wbGVtZW50YXRpb24gaW4gZ2l2
ZW4gZHJpdmVyLg0KPiANCg0KRm9yIHRob3NlIHNpbXBsZSBkcml2ZXJzLCB0aGUgZGVmYXVsdCBw
b3dlciBtYW5hZ2VtZW50IGxvZ2ljIGNhbiBoYW5kbGUgDQpwb3dlciBjb3JyZWN0bHkgd2l0aG91
dCByZXF1aXJpbmcgYW55IHNwZWNpYWxpemVkIGltcGxlbWVudGF0aW9uIGluIHRoZSANCmRyaXZl
ciBjb2RlLg0KDQo+ID4NCj4gPj4gVGhlIGRldGFpbCB0aGF0IHBvd2VyLWRvbWFpbnMgZ2V0IGhh
bmRsZWQgYXV0b21hdGljYWxseSBpcyBhbg0KPiA+PiBpbXBsZW1lbnRhdGlvbiBkZXRhaWwgaW4g
dGhlIGtlcm5lbCAoY3VycmVudGx5KS4gVGhhdCBjb3VsZCBlYXNpbHkNCj4gPj4gY2hhbmdlIGFu
ZCB5b3UnZCBiZSBpbiB0aGUgc2FtZSBwb3NpdGlvbiBhcyB3aXRoIHJlZ3VsYXRvciBzdXBwbGll
cy4NCj4gPg0KPiA+IFRoZSBwcm9wb3NlZCByZWd1bGF0b3ItcGQgZHJpdmVyIGZvbGxvd3MgdGhl
IHN0YW5kYXJkIFBEIGRyaXZlcg0KPiA+IGZyYW1ld29yaywgc28gaXQgZm9yIHN1cmUgcmVsaWVz
IG9uIGNlcnRhaW4ga2VybmVsIGltcGxlbWVudGF0aW9uDQo+ID4gZGV0YWlscy4gSWYgdGhvc2Ug
dW5kZXJseWluZyBpbXBsZW1lbnRhdGlvbiBkZXRhaWxzIGNoYW5nZSBpbiB0aGUNCj4gPiBmdXR1
cmUsIHRoaXMgZHJpdmVyIGFzIHdlbGwgYXMgb3RoZXIgUEQgZHJpdmVycyBidWlsdCBvbiB0aGUg
c2FtZSBmcmFtZXdvcmsNCj4gd291bGQgbmVlZCB0byBiZSB1cGRhdGVkIGFjY29yZGluZ2x5Lg0K
PiANCj4gV2UgdGFsayBhYm91dCBiaW5kaW5ncyB3aGljaCB5b3Ugd291bGQgbm90IGJlIGFsbG93
ZWQgdG8gY2hhbmdlLiBUaHVzIHlvdXINCj4gY2FzZSB3b3VsZCBzdG9wIHdvcmtpbmcuLi4NCj4g
DQoNCkFzIGEgbmV3IGRyaXZlciwgaXQgaGFzIHRvIGludm9sdmUgc29tZSBuZXcgYmluZGluZ3Mg
ZXNwZWNpYWxseSB0aGUgY29tcGF0aWJsZSANCnN0cmluZy4NCg0KPiA+DQo+ID4+IFdlIGNvdWxk
IGp1c3QgYXMgZWFzaWx5IGRlY2lkZSB0byBtYWtlIHRoZSBkcml2ZXIgY29yZSB0dXJuIG9uIGFs
bA0KPiA+PiBzdXBwbGllcyBpbiBhIG5vZGUuIFRoYXQgd291bGQgZ2l2ZSB5b3UgdGhlIHNhbWUg
ImZlYXR1cmUiLiBXaHkgd291bGQNCj4gPj4geW91IGRlc2lnbiB5b3VyIERUIGFyb3VuZCBpbXBs
ZW1lbnRhdGlvbiBkZWNpc2lvbnMgb2YgdGhlIE9TPw0KPiA+Pg0KPiA+DQo+ID4gVGhpcyBEVCBw
cm9wZXJ0aWVzIGFyZSBwcm9wb3NlZCBzb2xlbHkgZm9yIHRoaXMgc3BlY2lmaWMgZHJpdmVyLCBu
b3QNCj4gPiB0byBoYWNrIHRoZSBPUy4gVGhpcyBpcyBubyBkaWZmZXJlbnQgdGhhbiBvdGhlciBQ
RCBkcml2ZXJzIGxpa2UgZ3BjL3NjdS0NCj4gcGQvaW14OTMtcGQuDQo+IA0KPiBJIGFtIG5vdCBz
dXJlIGlmIHlvdSBnb3QgUm9iJ3MgcG9pbnQsIEkgaGF2ZSBmZWVsaW5ncyB0aGF0IG5vdC4gQXJn
dW1lbnQgdGhhdA0KPiBzb21lIE9TIGltcGxlbWVudHMgc29tZXRoaW5nIHNvbWUgd2F5LCBpcyBu
b3QgYW4gYXJndW1lbnQgZm9yIGEgbmV3DQo+IGJpbmRpbmcsIGJhcmVseSBoYXJkd2FyZSByZWxh
dGVkLg0KPiANCg0KVGhhbmsgeW91IGZvciB0aGUgY2xhcmlmaWNhdGlvbi4gVGhlIGlzc3VlIGlz
IHRoYXQgdGhpcyBkcml2ZXIgaXMgcHVyZWx5IGEgc29mdHdhcmUgbGF5ZXIgDQp0aGF0IHdyYXBz
IHRoZSByZWd1bGF0b3JzIGFzIGEgcG93ZXIgZG9tYWluLiBUaGUgYmluZGluZ3MgbWFrZSB0aGUg
aW1wbGVtZW50YXRpb24gDQpjbGVhbiBhbmQgZWFzeSB0byB1bmRlcnN0YW5kLiAgSSBkb24ndCB0
aGluayB3ZSBzaG91bGQgYWRkIGV4dHJhIGNvbXBsZXggbG9naWMgaW5zaWRlIA0KdGhlIGRyaXZl
ciBzb2xlbHkgdG8gYXZvaWQgaW50cm9kdWNpbmcgbmV3IGJpbmRpbmdzLg0KDQpUaGFua3MsDQpT
aGVud2VpDQoNCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K

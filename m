Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC3978DFD5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243964AbjH3TWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242269AbjH3Hpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 03:45:40 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB957CDA;
        Wed, 30 Aug 2023 00:45:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+nZMZPy8XGFT1iw15F1tCjfiohEMsiQpnTkLm90I400JBuja3Ci1oz68nQrKN94b0CARXJ/WsZqhxUi4MptPDqiJj6oKJ9UWzG1iy2drl65w/ILuiNLZsO7sPDPrkAU+4C6dyIaAB5kTpgiUVBnZ3g5QhsF2F6SLWm353axBjhnzZujnYYgdfXavxFdHEIhD/4assoPC3z6xDxLjmcxOb7b7Q8Yo/uMViV0gKFCw+NwMiRn2eoPCjDA8BMsgVEWPHRcfCQmN6DE3TtSm1FnZIMQ8DQH28LBI52eXQp2xYg6JpYBCiACP39bKIEPwnfWut8xJorTxuW4Jjxnk1tKDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y6C3fiLE6YqDLo1WZTbyJZk90MSomQLVnYX1rRk3rbQ=;
 b=TKzOgtK4ITP+aTCzh0jqG4HzJhKFcoWp5vSD+wyLxHA9iG5W0QcaAAWo+nO1oOiUWwIdvfoOUgHFJMt9H9GV9wNT8QOFajII/X1toEi4vEcSsA1WQPY1+tbN72RfMx340dMMCiHK4x/TNBQhJ3RE0oVjJaaQT+TESOVp9ALdnAGdF1OAjUIx0R+ANEyn6STIe6qo2lJ+6Adlf5JXDJuqB6HaPkHMefQ+M/I5juH3KL44lF5WGlm8BBrR2YFqtim0HPtsg+wpWpd51my4jkG2OTy8t7tU9g6hSomE65UTRGCpUY5c99v5mhVqh+EVcg4W8tl4oD+gB8xqxbv3V+mRwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6C3fiLE6YqDLo1WZTbyJZk90MSomQLVnYX1rRk3rbQ=;
 b=Ewn11E5hVfMvL2BvHRiDOPA8ceOOchLLZkQj5dCOFRzDZRw+6NCPfHZKRtgsrMkwB7vqgleAiijS/b0o+yl6OSnlng/8iZ46eaPdE/MGH17noLx+DFDbZM318BEFsITIpWrPYGXGvh4RWJDF0P7VqAc1TevHqAnZXbWPN2j+Kws=
Received: from PH8PR12MB6675.namprd12.prod.outlook.com (2603:10b6:510:1c2::15)
 by PH0PR12MB7485.namprd12.prod.outlook.com (2603:10b6:510:1e9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 07:45:33 +0000
Received: from PH8PR12MB6675.namprd12.prod.outlook.com
 ([fe80::3a16:8b71:150d:5e82]) by PH8PR12MB6675.namprd12.prod.outlook.com
 ([fe80::3a16:8b71:150d:5e82%4]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 07:45:32 +0000
From:   "Goud, Srinivas" <srinivas.goud@amd.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
CC:     "wg@grandegger.com" <wg@grandegger.com>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "appana.durga.rao@xilinx.com" <appana.durga.rao@xilinx.com>,
        "naga.sureshkumar.relli@xilinx.com" 
        <naga.sureshkumar.relli@xilinx.com>
Subject: RE: [PATCH v3 1/3] dt-bindings: can: xilinx_can: Add ECC property
 'xlnx,has-ecc'
Thread-Topic: [PATCH v3 1/3] dt-bindings: can: xilinx_can: Add ECC property
 'xlnx,has-ecc'
Thread-Index: AQHZ2cBiFgY83WJUzUyA4MeJwK/v66//2S+AgAKA3ECAABVFAIAABFdQ
Date:   Wed, 30 Aug 2023 07:45:32 +0000
Message-ID: <PH8PR12MB6675D7CE487C584529A4F0EBE1E6A@PH8PR12MB6675.namprd12.prod.outlook.com>
References: <1693234725-3615719-1-git-send-email-srinivas.goud@amd.com>
 <1693234725-3615719-2-git-send-email-srinivas.goud@amd.com>
 <20230828154309.GA604444-robh@kernel.org>
 <PH8PR12MB6675C31C6D1DCD3281FE8A10E1E6A@PH8PR12MB6675.namprd12.prod.outlook.com>
 <12a0f531-851f-cd09-3d56-828e2aeccae3@linaro.org>
In-Reply-To: <12a0f531-851f-cd09-3d56-828e2aeccae3@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB6675:EE_|PH0PR12MB7485:EE_
x-ms-office365-filtering-correlation-id: 4451030d-31e0-4a24-7942-08dba92d16e3
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iJ4PyFeR5xe6wuMgCVnSXrv6aFa+dF8SUz7rssBRGBll9DNOOGtQTMfComhWOC5aPBQjF8ZkEK5zX2h7SzP00Y0CLHtlOMx5eMNr4+N2ebPGcC7xFgIlX8z0JMWVsQh3zC7VV/1kEygH6l6sfgTo/6k7dkYXUnQpIPkenT+QfVRKgiFpTVWctXoxbSC+AG9AFBjn1I5qV265z2TtzR6XbfIo3H9h+O/QTV8VhksWnbrtISjBu11jXS2P6tKAgLi6DPnYCG3wlICeV4EFtUZpwuFHpqRVJM1GpV/nx3fxfcOWgbLRB7lSQ9OKeasjo7sxq8zB/4GxeoR35hFovySuMulJ0UY4W9Vttl9erE4hdBAh94xYeEwTI/b1n2TyEiYT/o+3BE+xm/c/Tci/0lRQeK3/yCrXS8212ILYbKl9mC0X107FZ7vqQR/3yrPZ0nWas5C1xjYAQxnQdRyiKLXuI0dXEXDBxHusX7t3OcmiVUa40kZegdZpTIneTzPXiJrcVJ/156/pMLO5nm41HCQGDfSA5Lv/HimFn8XC7n39feWSsBl1TW2FqDVhcMhwMVrk0DA+AKX1w4FBUeS6EF72m7yetBNB8uP5q4iqYRxGUv61ZnRmFKsndo+ySQenbMJX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6675.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(376002)(396003)(39860400002)(1800799009)(186009)(451199024)(8936002)(110136005)(478600001)(76116006)(122000001)(7696005)(66556008)(6506007)(66946007)(71200400001)(66476007)(64756008)(54906003)(66446008)(38070700005)(316002)(38100700002)(41300700001)(9686003)(26005)(5660300002)(8676002)(83380400001)(2906002)(55016003)(86362001)(52536014)(7416002)(33656002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TzdyZXhWcWRGVC9IRUtzTHpBTElDZDMwbm9kdjZ6V2c1dHRQbnljVjlibEFY?=
 =?utf-8?B?VEhUWVF3azhmZ2x1aFl4M0hXSlJxWTJTQTY0T21rVnRzVFd0azlYZWthdi96?=
 =?utf-8?B?dThTNkIzTGFtWXBEeXREQ09mdThiakZ4R0FIeS9DWW4yNmU2RUcxakw3SG40?=
 =?utf-8?B?b3RUdFdUNlBMU0Iwc1BBbGltT0d6TGtyaWVQdTFEVXcyc0JsL0VQY25Yek1q?=
 =?utf-8?B?cFBtZS9LM3c4eHdGL2pVM2VhRVl6SGRvZFZnT3VZdTEra0JPTU93UHdCTVZt?=
 =?utf-8?B?bVlmMDNEcmk5YVBLWjgvdDFJbVhzUUYxOEpHdldqUzVDN3RUa0lRQWlaRmtt?=
 =?utf-8?B?ZU9TRU9xTlg3b05laW15YmhXMHNsclJSMVVlSitVSERxTk9FYk9JV1pZRi9X?=
 =?utf-8?B?TllKUFRxbm5ZNnZIVjBBVXVZNVBwUngyTnQxK3hCK2FLbkQvelU0Y21zdGJu?=
 =?utf-8?B?VnYvcjI4WTg1S3poVWhFeUJLTUVlRmVOTTZaQ0M0RmNaK0dZSmRwMU1naUtE?=
 =?utf-8?B?dGl0L0RLNnlwd0RMd3Q2RXQ4Vk5GeE42NnFpK3B5L2V4VEFqRkVTbDdPRGVR?=
 =?utf-8?B?UUJKWlRCYWJuaWtVYXhoRko5LzJHcGpNdURycWMwVUlna2FXNlVMQnM5Y0tC?=
 =?utf-8?B?QTkza1BMY1BjdnU4VGVkUGpRUFFtN1R1VU8vODNuYVdROVRLQnVyR1h2blU2?=
 =?utf-8?B?Vm1XYXc2Y25GZlZiZVM2WC80QlBBbWFyd2lsN0pqdXhnWU1abUYvbjNuYmpO?=
 =?utf-8?B?VDZzVlVSbzJkb3k3TTFGeE4zcmlOVFBGL3N6akV6cWFJK3o3UlNwT1VXMlhN?=
 =?utf-8?B?dFRnMXJIVG5mdVZvMGFZMWJVWTZSL01ydHpBVlZ4bzdZMURKWTRYcFpuK2My?=
 =?utf-8?B?T2ZrNnZGNGw3TmhOeGNlZUx6SGlhb3FtWUFIYjVESzREb3laN2MxelJjeHVp?=
 =?utf-8?B?TGxSSmJwdjZURnBUeGNPMzZWSG43RzB5dXhUWFd4WDhZektJL3ZUd2g2YWJv?=
 =?utf-8?B?Z3JBbXJUNjQyWXcvQ1dOR0dMWExUYTZVak8xYTVTQzlTblg1eXVQU1p6OTBx?=
 =?utf-8?B?TmYxUUlxZEVxYVhJbmxISmlGdFNTaDZCZlc5SmNvWHVueFo0dmZXbEJFYk1l?=
 =?utf-8?B?Zk1FQ2hpdjlGZkRJVWNrN1dROE50bEdUZXltSERqVVdES1UyMGJhd0pjVXFJ?=
 =?utf-8?B?RHpSdkErN1RTNXc1cGRhYm9Fd0k5S3V0eFpMTis5K0dNYklVcndqZVcrYUhD?=
 =?utf-8?B?YTM1RmVCeFBoV3hULytVclg5V1I0d2laajJNQVA3MGxrM3lWdzFqSVdqWlE2?=
 =?utf-8?B?UnlJK3ViM2NMVXMyb1o0Slppc3RZNXJLbGJ5RVVsU014SjZTYzViUTZOZUt1?=
 =?utf-8?B?SXJaL1h4RUgxWkdXZkYwVVA4MFBRMm4vZDEyS05OUEhhMXhrQklySUhqOUdu?=
 =?utf-8?B?dktCR1EyOCtBeXlWN3FzSTFiemxEMC9VMVlFSHovbHhTZ2RUQnJYR2QweHh2?=
 =?utf-8?B?akRHdlpUcDRRSFNLTlVMdHFJMDE1dy9VVU5ybDRlT0pIVDZzeFJBYTVyUHpz?=
 =?utf-8?B?NnJaYXhWSEs5eDhHaURsNWo3NzhxQ3ZtZHZ3b3k1cDFPYjFxVzNheXdMazE4?=
 =?utf-8?B?VkkrRlYwaVppNk1GTUVHTWpWV3JUT3Zuc1ltN2g2L25sOHpnUENmQkxhODFt?=
 =?utf-8?B?UnhXMzZEb2RXVytvalFmRWd1cDVpOGRnZi9DOXBJd0R1YkdaTlpBNHdic2VO?=
 =?utf-8?B?QUhwRFlMYmM1M0RzenpPcWtUN1lqS1JURWVKenJwU0dhNnpndEtWeDhPMFNz?=
 =?utf-8?B?ZzNGTzlYWWtacmJIQUVrYjNYUCtEZ3k1MDZncjdKMG0zclAxQTVEV0RPQTYy?=
 =?utf-8?B?N3N3TlpaMHozc2hvVHJJMnR0eTZHN2FyZmhCNW9IaDkwTkFDZFFhT2FCcU15?=
 =?utf-8?B?NzNMWDRIRnF1ZXFEcVdveTNzdEsxNlgrcGRNZzNmLzg2YWFmL05CMHRHS0oy?=
 =?utf-8?B?TnBLOU1LU1lNdUtWbk50VDJqc0RXTTkvQnhFZzFGR042T1VJcUJ2N1lLSTBW?=
 =?utf-8?B?MnY4Z050U09kZFVjZVJSZVB3M3ZMN0xoWlJZMVpOQWw2ZGNzRzlwdHRhazlV?=
 =?utf-8?Q?CVQI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6675.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4451030d-31e0-4a24-7942-08dba92d16e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 07:45:32.5441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d3d0I5wOk9QhjPGfOp1ddy5Rwc9bT6gawVt7ZjD4UmOWR+y0heXIFO83VGFCfk49
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7485
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBLcnp5
c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+U2VudDog
V2VkbmVzZGF5LCBBdWd1c3QgMzAsIDIwMjMgMTI6NDMgUE0NCj5UbzogR291ZCwgU3Jpbml2YXMg
PHNyaW5pdmFzLmdvdWRAYW1kLmNvbT47IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+
Q2M6IHdnQGdyYW5kZWdnZXIuY29tOyBta2xAcGVuZ3V0cm9uaXguZGU7IGRhdmVtQGRhdmVtbG9m
dC5uZXQ7DQo+ZWR1bWF6ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOyBwYWJlbmlAcmVk
aGF0LmNvbTsNCj5rcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7IGNvbm9yK2R0QGtl
cm5lbC5vcmc7DQo+cC56YWJlbEBwZW5ndXRyb25peC5kZTsgZ2l0IChBTUQtWGlsaW54KSA8Z2l0
QGFtZC5jb20+OyBTaW1laywgTWljaGFsDQo+PG1pY2hhbC5zaW1la0BhbWQuY29tPjsgbGludXgt
Y2FuQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLQ0KPmtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPm5ldGRldkB2Z2VyLmtlcm5lbC5v
cmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPmFwcGFuYS5kdXJnYS5yYW9AeGlsaW54
LmNvbTsgbmFnYS5zdXJlc2hrdW1hci5yZWxsaUB4aWxpbnguY29tDQo+U3ViamVjdDogUmU6IFtQ
QVRDSCB2MyAxLzNdIGR0LWJpbmRpbmdzOiBjYW46IHhpbGlueF9jYW46IEFkZCBFQ0MgcHJvcGVy
dHkNCj4neGxueCxoYXMtZWNjJw0KPg0KPk9uIDMwLzA4LzIwMjMgMDg6MDYsIEdvdWQsIFNyaW5p
dmFzIHdyb3RlOg0KPj4+PiArDQo+Pj4+ICByZXF1aXJlZDoNCj4+Pj4gICAgLSBjb21wYXRpYmxl
DQo+Pj4+ICAgIC0gcmVnDQo+Pj4+IEBAIC0xMzcsNiArMTQxLDcgQEAgZXhhbXBsZXM6DQo+Pj4+
ICAgICAgICAgIGludGVycnVwdHMgPSA8R0lDX1NQSSA1OSBJUlFfVFlQRV9FREdFX1JJU0lORz47
DQo+Pj4+ICAgICAgICAgIHR4LWZpZm8tZGVwdGggPSA8MHg0MD47DQo+Pj4+ICAgICAgICAgIHJ4
LWZpZm8tZGVwdGggPSA8MHg0MD47DQo+Pj4+ICsgICAgICAgIHhsbngsaGFzLWVjYw0KPj4+DQo+
Pj4gT2J2aW91c2x5IG5vdCB0ZXN0ZWQuDQo+PiBXaWxsIGZpeCBpdC4NCj4+DQo+DQo+Rml4IGl0
IGJ5IGZpeGluZyBlcnJvciBvciBieSB0ZXN0aW5nPyBDYW4geW91IGRvIGJvdGg/DQpUZXN0ZWQg
d2l0aCB2MSBhbmQgbWlzc2VkIGluIHYyIGR1ZSB0byBjb3B5IHBhc3RlLCB3aWxsIHRlc3QgYW5k
IHNlbmQgbmV4dCB2ZXJzaW9uLg0KDQpUaGFua3MuDQpTcmluaXZhcw0KDQo=

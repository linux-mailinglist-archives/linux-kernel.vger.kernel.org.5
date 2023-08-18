Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134BC780B8A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 14:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376789AbjHRMIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 08:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376826AbjHRMI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 08:08:28 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FDF35AC;
        Fri, 18 Aug 2023 05:08:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOSrDh2Wmj6njRyMkcpu0avIsu2EmN8p4VzZmGCPkKIy02A+trHaaftBE6kP7ijtqot4EKaDX2jp2coBmQ7oToDOJ9yUYsBsIHzXIzq2BXkIQYp6r2ZN8DVf0D+k1xFN6VFXjwa1xWarBZh34NhlZUREqlMVrDOKFzja1GDAbV5R7aeJiLqFYd8Hs26OvYderinKNhz6ctfvfnkKYsVOQp6xxjs9Cw0wj3T58VPoLYHraMCaPkUOhbONbSPknJd53TNR6LGiDNRF2M7T4hcl9ZCysA1VL0FlrB541lZ/zNCelJ6BoJrzeLLQwGCWnrEQVC11hZIpV9KtpUSAftshww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXDPpWmK+wm52yMQ3GyIEsdEzITJYAVeDi/66+FstZ0=;
 b=WzhFWHE+Cg/9otJLz8+hZaOz7KYGKSMS3ssG69SSu7FJ26A634Zxyil7XU1yemuGzY7isn/o9OM6kHbJSQTv5Wbu89+XqoLv3F/nRBqdwz4eb7j++nXFsYXl5E8pvpSg4ll4s7ZIuKqhLJI2AMOMO3SZvc6ss9UO5uCKnN3ukg6wUytamIWw55yazG3jP4TUolYOljW7klB1ebVjiTvtCn4THzpL7jOBaBxvL0aB8LGz0VfGj9mKd55pTaw5NCxBRVHjxmSPxOVRxVlFEBeT9e7d54OTkLcTSiTLHzx/CYj4CtwVrepm6ObZFG5MPxT8bGJcb8/fzbT41oFBJn69yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXDPpWmK+wm52yMQ3GyIEsdEzITJYAVeDi/66+FstZ0=;
 b=pKps0ZZR4P8dgxgegPqusjO39pOsXgJ+e5kmWOQ0zBwBqxi21KziJZLpEsy/7KlFXcBIWSQjzxt3HWxNb5umJNHl8JsYvVe9NdiyarNfhyc+9Gb+OhiWtk0C/rVrZoF3EZmjnP9YKyA++ufAviAlPhPYIkOrD8d4YugpU2dkSnMHumodvO7/Cys3zzit7kch51mMt96y4aPt5w6qrbIagKd4oBPZJ8Py7EITQmXaaSLbg40jK0LLQ5Jt6pXl0UAjUGiuuf5YjJ6dlFEfg5ZKn91YVAZQJQfNRGS+QU38Wi6LmWL20Zl5HyM/G62Q5uocMmtxIcMWSNgWDX6y8CMj/A==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by CH3PR12MB8536.namprd12.prod.outlook.com (2603:10b6:610:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Fri, 18 Aug
 2023 12:08:24 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::ae25:4f33:8a19:32c9]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::ae25:4f33:8a19:32c9%4]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 12:08:24 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] gpio: mlxbf3: Support add_pin_ranges()
Thread-Topic: [PATCH v3 2/2] gpio: mlxbf3: Support add_pin_ranges()
Thread-Index: AQHZ0XJW73DQtqAv20Cf0bFk539ay6/vwcOAgAA0jXA=
Date:   Fri, 18 Aug 2023 12:08:24 +0000
Message-ID: <CH2PR12MB3895048FF2418B8DAE059169D71BA@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20230818012111.22947-1-asmaa@nvidia.com>
 <20230818012111.22947-3-asmaa@nvidia.com>
 <CAHp75VehagLZLTb4hC5J+w8JVUu-zYBDb+npeS8ZgadfF9MheA@mail.gmail.com>
In-Reply-To: <CAHp75VehagLZLTb4hC5J+w8JVUu-zYBDb+npeS8ZgadfF9MheA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB3895:EE_|CH3PR12MB8536:EE_
x-ms-office365-filtering-correlation-id: b8b0fd0a-89fe-4192-8a61-08db9fe3d27e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AHf1QYCA4dIuQTeAGddBtu4fnr3r1KnmEcBCsus8R638+f2WKuPkv7kVN7mzFFdhQ+jGbo2mNgBYwl9FMlnL3tnj9da24RzHfYfYOxmxBV8+7B6MMiZnEVOAiENzgkfE2LAxM17Y3cInhrZ6R4IUmma8E3SAyVCn8Zfm/h8p1YXwbmvRiooa7W42vp+olbLiKIkv5oyhyJGd2s+OxpCrnqZMjndmr0Mx2sksJyq+BAxY2VBIlBrEMOlUBmUOJ8umj80T28GdaVoNgSL5bUUoBKvHsporsqnC+QdUtyXN1OWK4p0+3aiMLsH+PRH2DcuOKJ2wKoad3SmiHA6YVAwqzpINm2tK0h6lcXfzkpu/l+5Z7SPsu9a42z8Vl6tzI/161dGW1FKzbE6cS+Br4UMVnCDMSG6Rd0sVLDN/fXyyQKjN/5D1jvlpzLPyIGJbS7CcQ4S7ggLz7l8WeLbcISblbkRno7YZ84Rdzo8vtw901lAoBa0CmXRLhSLmpcosC0XGIWIh1sMK+aBV+Yj4igKGXQGxoWyUBWoqckX2yqkhP9LuHyRt+Z7pM9Vnv74tfC32qvuNI46e7GE8IhOgOv9encS+fqqaAPFmHyIFionP8VTz32oXoYJDBxeINUvEhb+6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(376002)(136003)(396003)(1800799009)(451199024)(186009)(316002)(8676002)(4326008)(8936002)(76116006)(6916009)(66946007)(64756008)(66556008)(54906003)(66446008)(66476007)(41300700001)(5660300002)(52536014)(2906002)(4744005)(33656002)(478600001)(38100700002)(83380400001)(38070700005)(55016003)(26005)(9686003)(71200400001)(7696005)(6506007)(122000001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0lmTi9yd1dhQkw2S3dEWkZhc1Znc1EzTjJNaEF4T3l2aXZsbEJrNm55Z1F4?=
 =?utf-8?B?cmFCVFdGM0wzd1NjS1ZkNks5OUZHZW5lRWZuV3pPaG4vKy9MUVZCYVVhMU9z?=
 =?utf-8?B?bnZndVpUU29vTmtwUUF6RzQ4TDMrR2NmQkJNNjNwSHNlSGE0Z3F5b2hURSt3?=
 =?utf-8?B?ajJmemlhbEhHNERMY0x3ekEwTmpJdmV4Q2Zzb1BwL2lJWVhBZWxyQ2FVUlNG?=
 =?utf-8?B?MFdYM3BpK3l0TDNOY1VCakEzZXoyWGpBUkpTS3g1RnFlaHpwc3FjOUJSVERv?=
 =?utf-8?B?dlRvWmxJNERVU2Y0eTI3S0llNVlrUWRzZFE3TDE5aDhUR2pvaEJvRE5aRFJo?=
 =?utf-8?B?YVhYSHE1WlVEWi8zU3A3U1JKWWVyQi9IVjNrOEFMRTlzYUcvZDJtOHg3dE9q?=
 =?utf-8?B?OSt0K1MwSWFxL0Y4Nmx2eGpSeFcrV2hHaWJWN2xSY2Z6bkQrSUxlb29zSmZD?=
 =?utf-8?B?eVViWDRsT014NC9NTmFFSzg1d0RyTGdsaWlEemJpdHFybjdTcVRSSmF2c0J0?=
 =?utf-8?B?QTY5eDZGVE8vcDErOGp1TW9kaFlGSjl1WDhiYkw3ZXBnSTNnMTFMLzBzUExw?=
 =?utf-8?B?NXdpd2ZBc1hRVHRsczcyRlpqVDh0QlhGanlVcGMyd1FvK1cxMzlBNndvQzRF?=
 =?utf-8?B?Nm5lN3d1Q0ZvVGlndVBvcTB3K0JYOTdWcjREK1JYeXVHRGEzSUhXMnUxcTJa?=
 =?utf-8?B?N3Z6NmN5MEpFS0QvL0ozT094N1hKQW5YMnNGdlpjaWhXeU13Z0dhMkZtdzNp?=
 =?utf-8?B?SndRTTNYTGdWRDFOMmNZTVlnOWRGcVdBdnVrWmpZOVZlM3lXWEs1VkppaTU2?=
 =?utf-8?B?QnEvYlVsV2UvVkYxTEc2Y21VSGhvNFd0YXhGeWx4cm5qZEtBZnZtcFZ5TXBj?=
 =?utf-8?B?WkR2eW5PQm5LTWxuR1ducUFzMzl6UzhZZTErQWMyTGZwVGlRNjAxNHdPRmZm?=
 =?utf-8?B?TlF1V1NXQjlBY3BYODNyazRPaU96MGhJeGdZRTJmNkFOMjZFcE9tWjcvMXU2?=
 =?utf-8?B?M2tPbXRsWU1xY1hSbjREcjNDYXhLbndiQ3lxT2xyY2pLSlhpanNzUGJhSTUz?=
 =?utf-8?B?d1RNdUpoL1hyUUh4Kzk4WW82OVZFa09lUE5NZks3Q2hvQngxZzlnTGFUZWxw?=
 =?utf-8?B?VFdLYnZiQWhqbFhoQ1NlNXlDT2V1VnU5aTRjZ1FVSFVuMGEwK01EWC9qSE1T?=
 =?utf-8?B?Z2oyTFhjSHZvRWZma1JWTUhjNloweE5hYktvSFk0aUh6S3k2WDBuVTQ2a2FF?=
 =?utf-8?B?anRPS1pFVHVTZ0R0WEJDOFNMNEVXRFpBbkRVcjdWR0w1NUYxZVFkNWphQ2gz?=
 =?utf-8?B?UFJlS054SHRCSE5UUUJSMnlzaWJBTkVNNmlpdVFZQVZaRnVWbUpsK1I4NEk0?=
 =?utf-8?B?MUphNlVFdzNOTDRWMTRHeTYva01Idmx3eEpWWEI2b3F3bFFkdE5SOHZBY1hm?=
 =?utf-8?B?Z0s2RktSZUNaZStrUFpMQzRFQmMzVkY5TEFiQUU1ZU5oMG5ZVkIxdFFyN3Bu?=
 =?utf-8?B?ME9HOS8vWFZvNXdSTERWdFllSE5XamFzcGxPamNPdzFQOUdPeHhPSUVDaU4y?=
 =?utf-8?B?UmdUZHFqS1RJdUxLY2c0Tms2YkVPYXhTWFRqTTBkc3lhNzFCdnhsU2lJcGlh?=
 =?utf-8?B?eXRTVDNJYlo1eEoxTEpJRVdkSnJnbFFvU05iSVFnbGFUdFR6Y1I3ejVZaTRZ?=
 =?utf-8?B?RUdYOXUyTVlPU05hMUhOL3M1Tm16d0p6MDZDckcrYW0rUGg2SkROczhSdUFT?=
 =?utf-8?B?U0VsVFFqRE9udXNyN2dObTVqODJTMG9qNDM2YmFUbUpBZDBrTGV2L3lKQkFi?=
 =?utf-8?B?M0h0d0lmUjVUK25QQTNpTXRIRTluMUFZZk5DZGJ5aWZGNlpFUlFaellUVEI3?=
 =?utf-8?B?RTZaK2FJTFB6dXpBRzZrZkRLeFNEc1Rmd0EvKzdZR1lwWUtCWlI0aGQyN21L?=
 =?utf-8?B?MVBPU09SMGovVnpZbGl4bFBnUEJTVUhwMnh4MVlBME5DL3NVc2Zwei9heCtB?=
 =?utf-8?B?KzRKNkNMc252QUVCQ21RRm1kVk13SVgyZlZpM2VyWUppZGdVbzNsTTJUNzRS?=
 =?utf-8?B?dDVuU2xNWFUzQy92TEJMZUw0b0xXKzNDWTZXSk5aREU4S0hVVmk2WXVuZ3Vx?=
 =?utf-8?Q?GPWA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b0fd0a-89fe-4192-8a61-08db9fe3d27e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 12:08:24.0571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z2M+QDfIur9fd07tj6VrqXVm/dLWyuZV7BJLYO9hqUrMdl/WQFUv4iMd99ORmMfyZRvXQLB5pcV3bRFcsqT8dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8536
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBCZXR0ZXIgbm93LA0KPiBSZXZpZXdlZC1ieTogQW5keSBTaGV2Y2hlbmtvIDxhbmR5LnNoZXZj
aGVua29AZ21haWwuY29tPg0KPiANCj4gLi4uDQo+IA0KPiA+ICAjZGVmaW5lIE1MWEJGM19HUElP
X01BWF9QSU5TX1BFUl9CTE9DSyAzMg0KPiA+ICsjZGVmaW5lIE1MWEJGM19HUElPX01BWF9QSU5T
X0JMT0NLMA0KPiBNTFhCRjNfR1BJT19NQVhfUElOU19QRVJfQkxPQ0sNCj4gPiArI2RlZmluZSBN
TFhCRjNfR1BJT19NQVhfUElOU19CTE9DSzEgICAgMjQNCj4gDQo+IFNpbmNlIGl0J3MgYSBmaXgg
Zm9yIGJhY2twb3J0aW5nLCBJJ20gbm90IGluc2lzdGluZyB0byBhbWVuZCBpdCBub3csIGJ1dCBj
YW4gd2UNCj4gYWN0dWFsbHkgZHJvcCB0aGUgY29tbW9uIGRlZmluZSBhbmQgdXNlDQo+IA0KPiAj
ZGVmaW5lIE1MWEJGM19HUElPX01BWF9QSU5TX0JMT0NLMCAgICAzMg0KPiAjZGVmaW5lIE1MWEJG
M19HUElPX01BWF9QSU5TX0JMT0NLMSAgICAyNA0KPiANCj4gYW5kIG1vZGlmeSBjb2RlIGFjY29y
ZGluZ2x5LCBwbGVhc2U/DQpTdXJlLiBXaWxsIHNlbmQgYSB2NCBhZGRyZXNzaW5nIHRoaXMuDQo=

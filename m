Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820837B4BE3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 08:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbjJBG5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 02:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235457AbjJBG5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 02:57:43 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2120.outbound.protection.outlook.com [40.107.113.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D019F;
        Sun,  1 Oct 2023 23:57:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3HDdqpuvMnXUMR+X3qYHqOwcjj+l43KrVLICSq4BUtL3qMruxrrrj1tS4nzBqRtsUFj8vKhWTdb717HJU/4YGdw7tRc4pnM92B6YainuAeummHze51NTqzGEVCR7v/LYwM9xhRO1QfL2uIvsR0Nh6KSm/UPr0ydFjKXihBf6ylDE8SlT11ZyrGG5fCwHGWBWwsWOfSfN8kh70Y6AAr1r6/aiPRXMSlSXH/rmxrcK8f2UreQct2F/PHXO1f9DbjB/YjuueNpprTbD1IiTTXG+QiqLTIJP4DTeO2hJ5aWHGNSgbW8dVUgdsvpzJH/Z+K0AyykzVwxKmJuUTPsHwm++w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEpdvLeaMxJ650mwwbF0Nim6pcc3DA07TJFbUxBz9rM=;
 b=R/FQoRFWoANPZXYv6yt2j73br9t4GVUdVYPf8c5K/aOiVwKDNz84aQ98cefY+AE60kYgDEfXag2Nzy08AtTvG8l88FM6crC4lOWsu33LGbFBa27S1iy9QHiw5B4465U1E7sn6jdeXzwzAo17V4XQjROME6tR2wyNggvoH2enKLEdPSL3c90/F94BYCmybqhAozvmHoM7bIlRo5fBxe+TG+A/5+PhMC0OzfbJsJGAWB/WyQvokR/YVVT4IaT0v7bJuJvJD56+smb3dm2cG39o8wiTc235vPCgzs/BjV/gMAJfUNF19SdymqUORdkvrdJWjXq3EK5LNwqFGAwONBI5kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEpdvLeaMxJ650mwwbF0Nim6pcc3DA07TJFbUxBz9rM=;
 b=HRZOsSXM6blATHqCCzJvlgrgwjhtgHwbuPqZN3BnBUQyev7SUc2QQDNMT6LxzeG/G0V/OP8JT9kPg64KYq92iEMJP0ojRibFaB57Y80HuKE9ntgmPe2AkyAIFJzbQWWegTAxss+tmZcNZsxJ87fRo7oo4eaKenOVueNBpiV+KaU=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYVPR01MB10622.jpnprd01.prod.outlook.com (2603:1096:400:29b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Mon, 2 Oct
 2023 06:57:36 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fb78:2e8c:f7f9:5629]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fb78:2e8c:f7f9:5629%7]) with mapi id 15.20.6838.028; Mon, 2 Oct 2023
 06:57:32 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     =?utf-8?B?QW5kcsOpIEFwaXR6c2No?= <git@apitzsch.eu>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iio: magnetometer: ak8975: Fix 'Unexpected device' error
Thread-Topic: [PATCH] iio: magnetometer: ak8975: Fix 'Unexpected device' error
Thread-Index: AQHZ9IHazMX7YhLcF0uqntJC6sFjerA2Ec2A
Date:   Mon, 2 Oct 2023 06:57:32 +0000
Message-ID: <OS0PR01MB5922F29615450C4397F7123886C5A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20231001-ak_magnetometer-v1-1-09bf3b8798a3@apitzsch.eu>
In-Reply-To: <20231001-ak_magnetometer-v1-1-09bf3b8798a3@apitzsch.eu>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYVPR01MB10622:EE_
x-ms-office365-filtering-correlation-id: e7eff979-b3fb-44cb-d612-08dbc314d9ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L/yrTuOSSyw8HVWWmF+qiFN6+tW5dxyy5VvxW5Tl05vBVFFoOoR4tx5ljxQbNZb6fEGQAtXYJiHLMHTQgDv1ZtVscmU0MrqB9qg7/qirLI0K39tBwgBF2LObRnT+WQTvTM6jtIgbR/SpSokyyxKEJtPLT/W7Ku/PzC9jhrg7QlQssh83M56gUfdPfXZlDB1vvN126619BFePh9RTAG44NAULT4m4HRs0kF22yZwb+6loq36kXTninYIo1pir6LNwNMDDrkqEVlw7GSYm83GVUxYYwDKlBUPp7VylJScYGR6qEs5gbNDzRByOvU9eoa+TI2hWA9ExHd6AOkhcLeBETflIE6ltZ60B2nv+kigP1NYreu22LQ9eHEIH1I11Z+wp6f4lxcPM21j2G9aR4O/K97UINyM3fZBNbA/D5qgRokVOGJhuEHtgYv9QGgAXmGGRT5Q+yzaa76oIWEZvuSqysqXGQNB8hbJNX3bm9VZXUBnJKUiAih4o8GNO/b0oCUzapcX90hqFnSYbOpdAgmJMnf9zfc+6qT0XstDxHnd/f3eEG111csl7CDmAzarz6QPntuGL/xcuRyI1jRqd0OxRDcwqOUQ8IBLfIztC5BgLBmAz2fGaIMpnT4LfyRAv6NsN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(366004)(136003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(66556008)(66476007)(76116006)(66446008)(54906003)(316002)(64756008)(66946007)(2906002)(478600001)(110136005)(8936002)(8676002)(71200400001)(4326008)(26005)(52536014)(5660300002)(83380400001)(6506007)(7696005)(9686003)(41300700001)(122000001)(38070700005)(38100700002)(86362001)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEkyNG0xR2Q4N2c4bDdhUksyVEhJZGJmclAxdTlPQ29PVC9UdlF1WWRJSkJm?=
 =?utf-8?B?ZjNaUDRiQmhTL25oSm1kRURUUHdxREhEQm9aYnN3U1lEQkxJT0xQbm1SaVRW?=
 =?utf-8?B?YUExcjdEY1ZaVlU3KzM2LzhTb2E2UGpnTS9FelZNUE53bTc5SjdPWnVyNFhE?=
 =?utf-8?B?cDU3OElNMFVYVUZNVnA0ZktBNWY1WTc3MU5PWW53dU14SXpLbGY2SkdSdkxv?=
 =?utf-8?B?YzJYV3FxU1JTSGU3ZTNWYUpZWmwzNHBuUGNwcGlZMFR3WFBvaHAwUEdXbk9M?=
 =?utf-8?B?M1N1M01QREZKejBsdVBuYktJYjlGWFpHZld6anZLVk13SzJtZUtFNDRqM3JL?=
 =?utf-8?B?OVFXV1hKVnJWU1BqYUR6Rmk2c1ozazk3SHFmdmhHT3liTElTN21iT1p4ODR4?=
 =?utf-8?B?akptaEg5QzQ1eWZXYUhyTkMzLzRZTXhOWFczN3lpRG8xVmdaWUNIUGU1U0Zw?=
 =?utf-8?B?cWNMTmR6OUxxT0d2Wk1iNXh0TzBNOW9HZzV4Mi8wa2I1Z05oOW5iREtic2hY?=
 =?utf-8?B?MzJKRFFsZDd3dDBweFArTWhIQzB4aDAwdmdUUWo1bkxJWEhFTGFWWWhBd3ZZ?=
 =?utf-8?B?TWxGblF1R09rbUxmSEs3UG9iVUttL1NVNUZJeTAyYTBKdjBGanlSOGpkQzZO?=
 =?utf-8?B?OGVCdXVYUithNjNoZzdyOWVkOG1yaE5lcWw1SnZtQzcweWlWdlhHc05DMW1W?=
 =?utf-8?B?bDlsUC9ZVnd2Wm1LenlwSWxoZk5qbFFVWm9jbCtobEpCems4djYrOS8wV1c5?=
 =?utf-8?B?cHVHbm5XM2F3NTArL0I0MWJDcGxweS90R1ovZUxDZm5GdUFPRjZDWGkwOHN2?=
 =?utf-8?B?UlZQRWNPRVlrMTVJY0tqSU5BbUk3MUdWVUNkWUFNZ0l4dEhSNkIyL21QMjFZ?=
 =?utf-8?B?RW9RWkdvT0UzQmhZaWlXckdwS1ZoWTRBc3ROVEhIYURhNDBUeVN4ZHFSWFhn?=
 =?utf-8?B?bGttSmFzWmw1bWQxNXBEMjJzQWdpTDdVdkhLZlZlZ1hwTnVQM2dGcGVER1Fj?=
 =?utf-8?B?ZUZRWHpudm1FVEtZaFRobGhyL2NQV0ZwSmd3VVVRSGVIdnF1bzlPSzJGUHEr?=
 =?utf-8?B?bFF6cFRPVHhoajlmZjNWeDRHZEFKdmE0OTRLN3cxWlMvekE4SFBreWNpUzJ4?=
 =?utf-8?B?aXY2bmxnQ1pVNHlwbGR4VmxURlNod0VlM0JGb2kzT2l4V1ZYV0JnSWlpQVRK?=
 =?utf-8?B?WUpNU2JxbGtGTkFBdFZKQmFEK3VoMWZOSnh5ckg5OXFFLzRJNHdNQi9vSjhL?=
 =?utf-8?B?czV1dWlITnRtbG9CblVqUnpvVU5HeWNtUmVpb0o4b3h5WDZHSWdPM0oreWZa?=
 =?utf-8?B?SWJycW5PTjBFQ0ZBM21hRkg0clZVTEFXWk9meHd2VkYxY0srOVgycDNmRjZo?=
 =?utf-8?B?N0JnZzM3TjdhaE93ZEVtVThvdTBUdnBDNk9JNzI5SFd6REpEYXBKeVFuVXZq?=
 =?utf-8?B?alRQZTliV1JNVEpGR2dyblRHU0RiRXB5OWY1RDgrN1kzNGd4UUNWQXZCbURI?=
 =?utf-8?B?bTNUMjlvY2VPdzlwV296QVdDRVZCV09uM0IxbFE0U2hpNnkvMEVIc25HWnBY?=
 =?utf-8?B?ZUVmVzIxSFZEZ3dPNzV0Z1ZNQXlyMWY5UzBCTnFXamNNNVRiL2RzbnpDZFNy?=
 =?utf-8?B?cVpyZCtmbmp4VjlORUxnTzBxWkxzZ3JrWUh5MkU3OUpHaURDOHdEcStwMkJm?=
 =?utf-8?B?RmtlU0lsc3F3dlFwU0E2WGdSWDg1blM4UWE5WU9aTVl5emhGOFczOVpYN3VK?=
 =?utf-8?B?VGUwQ0lzWS9DaWhTdUI0MnA5RnlhbE9EaU51OE5rVnhqUGg1VnpjMzhjc0lL?=
 =?utf-8?B?TjJieEE1SlEzbkVPQjBFSUdYd0VCZDNIRXJhcTRuWnppTUhRRlRoampPL3U4?=
 =?utf-8?B?RDJIZFlaaWt5TmNIcDQ2VUs3YzlhKzBZK0h2TnEyQkh1Z1I2S3BQbTRpUWVp?=
 =?utf-8?B?L1RodFR5TnlKNTJGRkJTRmhraFVCODZpVzduSDJiODB4TzlwMTg1d0dObzBN?=
 =?utf-8?B?aHVzM29qUi93L0JuTFVkUjNlZGQ4WXgzSDNOYXFEajdpRkh4MFBQaDd1dmNY?=
 =?utf-8?B?RkJ2WGtGa0NTUk0rYkNOcEZsTG1BdHgvQnkxS2sxcFVLT1NkdUxHZVBuSDNE?=
 =?utf-8?B?OUlsWUhXZ0Y3M3lOeGErSlMwVm5uOUZTcW5LUGNhSCsxS2tFbTBENjlZME5z?=
 =?utf-8?B?L0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7eff979-b3fb-44cb-d612-08dbc314d9ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 06:57:32.6900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e7Ne2fcjnlOrlHS8zEcU/4/6aibrBr5N4QUQaNDjdXgqyq2ro7zbN/6oWUf2yJGAocW/VSvb3IvlZ7isx2Eb5bjssS1npXLjMqmgQX1Kz9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10622
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcsOpIEFwaXR6c2NoLA0KDQo+IFN1YmplY3Q6IFtQQVRDSF0gaWlvOiBtYWduZXRvbWV0
ZXI6IGFrODk3NTogRml4ICdVbmV4cGVjdGVkIGRldmljZScgZXJyb3INCj4gDQo+IEV4cGxpY2l0
eSBzcGVjaWZ5IGFycmF5IGluZGljZXMgdG8gZml4IG1hcHBpbmcgYmV0d2Vlbg0KPiBhc2FoaV9j
b21wYXNzX2NoaXBzZXQgYW5kIGFrX2RlZl9hcnJheS4NCj4gV2hpbGUgYXQgaXQsIHJlbW92ZSB1
bm5lZWRlZCBBS1hYWFguDQo+IA0KPiBGaXhlczogNGY5ZWE5M2FmZGUxICgiaWlvOiBtYWduZXRv
bWV0ZXI6IGFrODk3NTogQ29udmVydCBlbnVtLT5wb2ludGVyIGZvcg0KPiBkYXRhIGluIHRoZSBt
YXRjaCB0YWJsZXMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyw6kgQXBpdHpzY2ggPGdpdEBhcGl0
enNjaC5ldT4NCj4gLS0tDQo+ICBkcml2ZXJzL2lpby9tYWduZXRvbWV0ZXIvYWs4OTc1LmMgfCAx
MSArKysrKy0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNiBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9tYWduZXRvbWV0ZXIvYWs4
OTc1LmMNCj4gYi9kcml2ZXJzL2lpby9tYWduZXRvbWV0ZXIvYWs4OTc1LmMNCj4gaW5kZXggOGNm
Y2ViMDA3OTM2Li5kZDQ2NmM1ZmE2MjEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaWlvL21hZ25l
dG9tZXRlci9hazg5NzUuYw0KPiArKysgYi9kcml2ZXJzL2lpby9tYWduZXRvbWV0ZXIvYWs4OTc1
LmMNCj4gQEAgLTIwNCw3ICsyMDQsNiBAQCBzdGF0aWMgbG9uZyBhazA5OTEyX3Jhd190b19nYXVz
cyh1MTYgZGF0YSkNCj4gDQo+ICAvKiBDb21wYXRpYmxlIEFzYWhpIEthc2VpIENvbXBhc3MgcGFy
dHMgKi8gIGVudW0gYXNhaGlfY29tcGFzc19jaGlwc2V0IHsNCj4gLQlBS1hYWFgJCT0gMCwNCg0K
SSBndWVzcyB0aGlzIGNoYW5nZSBpcyBlbm91Z2gsIGFmdGVyIHRoaXMgQUs4OTc1ID0gMCBhbmQN
Ck5vIG5lZWQgdG8gdXBkYXRlIHRoZSBtYXBwaW5nLiBBbnl3YXkgdGhpcyBpcyBwZXJzb25hbCBw
cmVmZXJlbmNlLg0KDQpMb29rcyBnb29kIHRvIG1lLg0KDQpSZXZpZXdlZC1ieTogQmlqdSBEYXMg
PGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KDQpDaGVlcnMsDQpCaWp1DQoNCj4gIAlBSzg5
NzUsDQo+ICAJQUs4OTYzLA0KPiAgCUFLMDk5MTEsDQo+IEBAIC0yNDgsNyArMjQ3LDcgQEAgc3Ry
dWN0IGFrX2RlZiB7DQo+ICB9Ow0KPiANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYWtfZGVmIGFr
X2RlZl9hcnJheVtdID0gew0KPiAtCXsNCj4gKwlbQUs4OTc1XSA9IHsNCj4gIAkJLnR5cGUgPSBB
Szg5NzUsDQo+ICAJCS5yYXdfdG9fZ2F1c3MgPSBhazg5NzVfcmF3X3RvX2dhdXNzLA0KPiAgCQku
cmFuZ2UgPSA0MDk2LA0KPiBAQCAtMjczLDcgKzI3Miw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
YWtfZGVmIGFrX2RlZl9hcnJheVtdID0gew0KPiAgCQkJQUs4OTc1X1JFR19IWUwsDQo+ICAJCQlB
Szg5NzVfUkVHX0haTH0sDQo+ICAJfSwNCj4gLQl7DQo+ICsJW0FLODk2M10gPSB7DQo+ICAJCS50
eXBlID0gQUs4OTYzLA0KPiAgCQkucmF3X3RvX2dhdXNzID0gYWs4OTYzXzA5OTExX3Jhd190b19n
YXVzcywNCj4gIAkJLnJhbmdlID0gODE5MCwNCj4gQEAgLTI5OCw3ICsyOTcsNyBAQCBzdGF0aWMg
Y29uc3Qgc3RydWN0IGFrX2RlZiBha19kZWZfYXJyYXlbXSA9IHsNCj4gIAkJCUFLODk3NV9SRUdf
SFlMLA0KPiAgCQkJQUs4OTc1X1JFR19IWkx9LA0KPiAgCX0sDQo+IC0Jew0KPiArCVtBSzA5OTEx
XSA9IHsNCj4gIAkJLnR5cGUgPSBBSzA5OTExLA0KPiAgCQkucmF3X3RvX2dhdXNzID0gYWs4OTYz
XzA5OTExX3Jhd190b19nYXVzcywNCj4gIAkJLnJhbmdlID0gODE5MiwNCj4gQEAgLTMyMyw3ICsz
MjIsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGFrX2RlZiBha19kZWZfYXJyYXlbXSA9IHsNCj4g
IAkJCUFLMDk5MTJfUkVHX0hZTCwNCj4gIAkJCUFLMDk5MTJfUkVHX0haTH0sDQo+ICAJfSwNCj4g
LQl7DQo+ICsJW0FLMDk5MTJdID0gew0KPiAgCQkudHlwZSA9IEFLMDk5MTIsDQo+ICAJCS5yYXdf
dG9fZ2F1c3MgPSBhazA5OTEyX3Jhd190b19nYXVzcywNCj4gIAkJLnJhbmdlID0gMzI3NTIsDQo+
IEBAIC0zNDgsNyArMzQ3LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBha19kZWYgYWtfZGVmX2Fy
cmF5W10gPSB7DQo+ICAJCQlBSzA5OTEyX1JFR19IWUwsDQo+ICAJCQlBSzA5OTEyX1JFR19IWkx9
LA0KPiAgCX0sDQo+IC0Jew0KPiArCVtBSzA5OTE2XSA9IHsNCj4gIAkJLnR5cGUgPSBBSzA5OTE2
LA0KPiAgCQkucmF3X3RvX2dhdXNzID0gYWswOTkxMl9yYXdfdG9fZ2F1c3MsDQo+ICAJCS5yYW5n
ZSA9IDMyNzUyLA0KPiANCj4gLS0tDQo+IGJhc2UtY29tbWl0OiBkZjk2NGNlOWVmOWZlYTEwY2Yx
MzFiZjZiYWQ4NjU4ZmRlNzk1NmY2DQo+IGNoYW5nZS1pZDogMjAyMzEwMDEtYWtfbWFnbmV0b21l
dGVyLWIwNjMwOTgwODJkZA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiAtLQ0KPiBBbmRyw6kgQXBp
dHpzY2ggPGdpdEBhcGl0enNjaC5ldT4NCg0K

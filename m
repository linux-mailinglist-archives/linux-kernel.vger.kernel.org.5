Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CA1762326
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjGYUSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGYUSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:18:14 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2116.outbound.protection.outlook.com [40.107.244.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9E119AD;
        Tue, 25 Jul 2023 13:18:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AuYUXybYNKisIziYsxq437r5E3bDV0SQ/CjCA5MwV7M2j39qE8QKaF4Aqyg63H4WpnhgMOc1ZKIqT+FaF6gp6krylgAlaFKTEbI0nT0fTEpOGepnQH/5vsQ+5hV89QsF4jYIng1YOEtBdCkaYTm+kZlhZhTCcR40PA3MxZZEB8oiUuKTkiQYz/zRSCaeIQMIAqMtppRds8jAeiTDD6GN/aSmkr09DGcZXqv+doZkOEsDesahna9kVic8o7NiLoFh1F/EsGA1h1NGaBxMdVKaSlKVyST4WEouT6sdrm2ijPd7rwilRDxksVSMpsDBq1Vp4s5IJsm5yuZH1ZxosmfkAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUjUg6g4W/sxeJYhHAv06f5nlho0wzO1u+N7NPCmNHg=;
 b=RKr9b9ZqnWkh1MdVGlmyI3bUC+e8zQ9PSFNHhdQIIVXGARszdv7ggFOkZjU40htD+BoIF7WhSQnFOkB5LifoNhGVhLKF/2TNUynLLku0ONa5Ci5n2vazYGhoSa4/8hZ70QBsdUWycYOt6RElE0LrCiXMiTM2Ds/+oZ+l4n+j2b/ET35RCFXqRycbmtjsBy5dRZURvaLS2yt1bJjGjvj/gL5l6hCM8Msa1otVFX7f003gJPcwdFroKmQZmTZqvyZuQcIxze3zJ7meIJlG9wSSgUZLUctMOfYKBLtN6gSqMZ2rO+HDJOFO7tLbOXSYJo9x+RHqwND51K2+fkK9D4mzrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUjUg6g4W/sxeJYhHAv06f5nlho0wzO1u+N7NPCmNHg=;
 b=QqNuPXWGrCbou9i6qNup6bzwTCZY/YQyJVy5YNZveWtH4A95mMd/gcR/aatznvNirICSl8+9OCDUe5zB6pjpTT83okk8DGw27EYhU+dOqUiOL/M5hVqo7fCeIWUpTT5+VY6uE0sBUvtiP48X4ScvkS75QS/ay/dGTbi4bQhkEJU=
Received: from SA1PR01MB8062.prod.exchangelabs.com (2603:10b6:806:335::13) by
 PH0PR01MB7893.prod.exchangelabs.com (2603:10b6:510:286::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.31; Tue, 25 Jul 2023 20:18:09 +0000
Received: from SA1PR01MB8062.prod.exchangelabs.com
 ([fe80::9683:1d6b:f08e:2839]) by SA1PR01MB8062.prod.exchangelabs.com
 ([fe80::9683:1d6b:f08e:2839%4]) with mapi id 15.20.6609.022; Tue, 25 Jul 2023
 20:18:09 +0000
From:   Steve Clevenger OS <scclevenger@os.amperecomputing.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
CC:     Ganapatrao Kulkarni OS <gankulkarni@os.amperecomputing.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: acpi: Remove ETM from AMBA scan list (was Re: [PATCH V6 6/6]
 coresight: etm4x: Add ACPI support in platform driver)
Thread-Topic: acpi: Remove ETM from AMBA scan list (was Re: [PATCH V6 6/6]
 coresight: etm4x: Add ACPI support in platform driver)
Thread-Index: Adm/NSEGPt5aWMZkhkeaV3zl3hD3dA==
Date:   Tue, 25 Jul 2023 20:18:09 +0000
Message-ID: <abbcf3c8-fbd9-727e-780b-74aaf5ae8ec1@os.amperecomputing.com>
References: <20230710062500.45147-1-anshuman.khandual@arm.com>
 <20230710062500.45147-7-anshuman.khandual@arm.com>
 <38f0c8f3-5fb3-a18a-456d-867da2998786@arm.com>
 <ac77142d-964b-691d-ea15-105a523d9738@arm.com>
 <46a3d6d3-f14e-efde-83eb-5952f313f909@arm.com>
In-Reply-To: <46a3d6d3-f14e-efde-83eb-5952f313f909@arm.com>
Reply-To: Steve Clevenger OS <scclevenger@os.amperecomputing.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CH0PR03CA0195.namprd03.prod.outlook.com
 (2603:10b6:610:e4::20) To SA1PR01MB8062.prod.exchangelabs.com
 (2603:10b6:806:335::13)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR01MB8062:EE_|PH0PR01MB7893:EE_
x-ms-office365-filtering-correlation-id: a9bc725e-cb84-48be-579d-08db8d4c4398
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gjwjyLKKj2DloyeqVW+U1HwvuuCVn2b1MToNk6I3KhE8IlqKUmOrmWLxOPvw9RHovlEKXCN587740aqNKyV8RYeIxMswM12MinHWA1oiVdOUw4IB08YZZimsP55JUEI7iBdpPZdKxq9tAgeecbQjvT9dlatsk3YO9n0aKg2EmiZEGHtpX54FvSNMTYGqTbuNghdyc6tVyAd1od5s0pQOLT+sVUTaQrYrxI+I3YG6jRTwuRbFKIispjrouk3llSQTC/Por5rm3ZOZ648gg+D3b1F+8D7aYCzwF0z8X0lqDPqQXhS+m8yXh1xCmSJQCZ5qS1QU61voTnV7u3CtgLYO/+V14fpuZzyShcLz1wvR0fkFMw5RHJLrEiEADwqxhaRyV+IdlkgIvaowr32QxN6C0jFRpJO4+szTdqnmoK8aUOwCTrfO1r/Del7uzPyuJ4Hc30fTM4l9I4ADbuyxKFKVte5OnfmWrclExz8JrH/Aj6R4rpDcjv00jkWmUrvJtiJtcFj3sQBNkV2WDeqHttGtIR4MxB5ApiElYdfyU8Sry2xKJ96XpFt2G/E8G+bdtuDPk96r59gmkKCt37RnvZbuPCPHHQBwuJezlgdVszWRNk0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR01MB8062.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(136003)(376002)(396003)(346002)(366004)(451199021)(110136005)(66556008)(5660300002)(6506007)(26005)(186003)(66476007)(66946007)(41300700001)(31686004)(66446008)(64756008)(316002)(4326008)(53546011)(71200400001)(6486002)(2616005)(2906002)(6512007)(3450700001)(8676002)(31696002)(8936002)(478600001)(7416002)(54906003)(83380400001)(86362001)(38100700002)(122000001)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjMwM2ZCd1U3UDhkelJIRVNCSW43M0RWVHg4OExHV3IwUkFNU3dKMFNrSitG?=
 =?utf-8?B?aDFmb2VKMTZnV1MydGlhV1hMVkhiUDVRY1hETXg1QzhRUnJUTUU2bmNhSTZO?=
 =?utf-8?B?THhOK1F5TGM2eHYrSzIrNVJCbDZnbTF0RHZwVXVaTjBMeW1PUGpxSEdrT1Yx?=
 =?utf-8?B?aG1PV1YvZ1NRUGlhSENnUGloZnNTbjJLQTY2eXBGMm81QVRreUZNelJPZ25D?=
 =?utf-8?B?bzNHZE82Wm9JSTRwQnZmeDNWOUk1ektiYmwrQjdhUDl0VEVzTXRUUTZQbFU2?=
 =?utf-8?B?dU5HeWFTM2VoSENlbzE2RCtPaWE5dDN6K0kzNnVhbmRVS1d1N3RxZ0Q2RkQ1?=
 =?utf-8?B?Y01ZdlNKT01CQTRQbVJrV2paQmNpVWIxTnhiRXhZMVNDUnN1ZXE2Tnp1QUlw?=
 =?utf-8?B?WmpLemZVODgwa244cWRwSndQTUpPT1BUb0dua0RnRVFqVndzb0sxajhVa2lR?=
 =?utf-8?B?aFM3N0k5Ykp2SThlMU81dUEvV3RqeFFZbUJEZ1BoSy96MjZoVXdaeHVtVWw2?=
 =?utf-8?B?MEFScll0dURFanMwemJWaWhpUXVGZXI2eCtkMWVOaWVuWWp6cnB6dC9jTzlN?=
 =?utf-8?B?dUQ0dDVJV3QvUG15RURBdCt4YW91QWpWY1RKS0ZGRTNUVEF4bCswN1BwNFJo?=
 =?utf-8?B?ZkpNUnROK3pzU3dxSWVMSU96S3BjQ01jNFQvaGxBeVZoSXRzN0t0SGw3MFZD?=
 =?utf-8?B?RVc0bVlVWDE3cmN4bGQ4M0lSaVFiK1dJL0crdVBlb0EzNFFHSVJLTnFKNW9h?=
 =?utf-8?B?MFVoSm5RYUpRUXY1N0ZkZWlReWlwVGtxWU5OVUxWR3dqWndycHRPSVVDMytx?=
 =?utf-8?B?K2JxOEJlT0daTTVjZnd0WHE4QXZ2M3ZRVTd5Uks1QndSSDkwbHlVWFV3UHZi?=
 =?utf-8?B?QXlSQWFwbGNQZ1BvUUF0UFlOZE1tZFFQUDMweVpMMSs2ODk3SEY2WHFCcElr?=
 =?utf-8?B?VkJpazFwejAwZ2RZdDFNNDhhcCttbHp2d29rMWtRVWo3eUp3WnpFcFZ1MzBR?=
 =?utf-8?B?enJmZ1BrU3FUNitzMDRvcHRqQVZ3anM3RHloYXdGM09SYVN3MW1PcEd1b1h6?=
 =?utf-8?B?dEhEZW9IM2ExZ0lCZGcreFJyNk9DdVpyZnAzTUtnb1FZVDRUVGNtcDBJK0lR?=
 =?utf-8?B?NnhiWUlTTFIzOW1EWnpJNURDZDFIMnlHeHprYmZrVzlVNGh2RFRYeGp1VGRl?=
 =?utf-8?B?c1N6N1lYVUR0S3M2Qko1RzRWNDVyWnY0ZEN6U0dKSmJuVTZQbVpsaDcyeFZl?=
 =?utf-8?B?WWhieDdrTTR1YWJ0endBU3JYaWxtTkp0U3o2NHJxNlhHWlRZZzBBN1BtaFRF?=
 =?utf-8?B?RFRtTFQ0TUdCTFRoM1M4SFByRGZsOFZROC9EczZTSmlGMTVoODFUZkxOUzFB?=
 =?utf-8?B?Y1dMT0YrdGhKMGdOT2xjUlBoc1A5YlhXeXZkTWNRS09QMUZxV2doWWtZbUhK?=
 =?utf-8?B?bytJNHZXSVNzM3BKSS9FTVhaNHdOYUlFQzlYdUMzL0d6OFdIa3VuenhieEZ3?=
 =?utf-8?B?ZmxSVTZPUkZ4MWltM2c3WFo1RFB1UG82bmt0R0dOKy9aVzhuVGk4NmRYSmEy?=
 =?utf-8?B?T0RtR1plWkJmZ1pNc3MrRFFxdHgzelJuRDJZQWhXbVBsZ0tQemVrU1BxTUhl?=
 =?utf-8?B?NXExWkFwT2kxckFyemRoYVdRd2xiTXRiY3I1WlV0YVJsRlE0UTZ0TkNlZ3dh?=
 =?utf-8?B?bWdxWkp5citEM1prRXcvd3dGV3BWS2hXcWNyTHhva1d4SkN0RW9RWm0xR2dp?=
 =?utf-8?B?QzBvVkNyQ1V0UDNXQVVzenhvL2VSNW91QWpGcDI4ZkhDRjltTHpiSXg3dm9z?=
 =?utf-8?B?Y2Z4U2RvUUtyVm1jcGRpei90YklBQzI1aGN4aUdIalRKU29DM2dBMWpjSXVx?=
 =?utf-8?B?by94SjN0Q2FzVUJ0RGlqOTUwTVB1V0dxazRWYm53ZjNKRktJZkhYREJlWWRZ?=
 =?utf-8?B?cUJXOFRlWFZOV0oxWStSWjdXSzZUWjQ5SHdOWE5NV1NxY1dNTkRHbHNNVkNn?=
 =?utf-8?B?YXd5LzJKWXVLNVFCWU56L2JYZEw5eUY5cUwvT21tWExQa2NPdnJLMmFRQTZP?=
 =?utf-8?B?WXp1enJ5T3hlVGh0SnJYZkpMcGd5WnFnR0hLODAwQ0lLR3FzUXMvNWd3b3A3?=
 =?utf-8?B?QlRxcjFZVkE2ZS9nbS96VHBnaWFwcWVjZEMxclF6RUdQa05BaHE5RXVOYW9p?=
 =?utf-8?Q?+MH9VszJTqvwiooiGXaYZFc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6071B403F4A3FC449DDCDF2194B571AF@prod.exchangelabs.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR01MB8062.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9bc725e-cb84-48be-579d-08db8d4c4398
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 20:18:09.3910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DRy8IXAMhgMDU79ZRkrXLqGbhFceB+pWNfeId9tjR99ibdP1cxLYi0mWA6jEakBE58NuFTc5DP6DqHEAj4D0HTrznMpwSauhi9pIjBL86fzWlt1lm4BKUirOKxRZBVFE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7893
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBSYWZhZWwsIExlbiwNCg0KT24gNy8yNC8yMDIzIDk6MjUgQU0sIFN1enVraSBLIFBvdWxv
c2Ugd3JvdGU6DQo+IEhpIFJhZmFlbC9MZW4NCj4gDQo+IE9uIDE5LzA3LzIwMjMgMTE6MTEsIFN1
enVraSBLIFBvdWxvc2Ugd3JvdGU6DQo+PiBSYWZhZWwsIExlbg0KPj4NCj4+IFBpbmcgKHBhY2tl
dHMgNiwgbG9zdCAxMDAlKS4NCj4+DQo+Pg0KPj4gT24gMTAvMDcvMjAyMyAxNzo0MCwgU3V6dWtp
IEsgUG91bG9zZSB3cm90ZToNCj4+PiBSYWZhZWwsIExlbg0KPj4+DQo+Pj4gT24gMTAvMDcvMjAy
MyAwNzoyNSwgQW5zaHVtYW4gS2hhbmR1YWwgd3JvdGU6DQo+Pj4+IEZyb206IFN1enVraSBLIFBv
dWxvc2UgPHN1enVraS5wb3Vsb3NlQGFybS5jb20+DQo+Pj4+DQo+Pj4+IERyb3AgRVRNNFggQUNQ
SSBJRCBmcm9tIHRoZSBBTUJBIEFDUEkgZGV2aWNlIGxpc3QsIGFuZCBpbnN0ZWFkIGp1c3QNCj4+
Pj4gbW92ZSBpdA0KPj4+PiBpbnNpZGUgdGhlIG5ldyBBQ1BJIGRldmljZXMgbGlzdCBkZXRlY3Rl
ZCBhbmQgdXNlZCB2aWEgcGxhdGZvcm0gZHJpdmVyLg0KPj4+Pg0KPj4+PiBDYzogIlJhZmFlbCBK
LiBXeXNvY2tpIiA8cmFmYWVsQGtlcm5lbC5vcmc+DQo+Pj4+IENjOiBMZW4gQnJvd24gPGxlbmJA
a2VybmVsLm9yZz4NCj4+Pj4gQ2M6IE1hdGhpZXUgUG9pcmllciA8bWF0aGlldS5wb2lyaWVyQGxp
bmFyby5vcmc+DQo+Pj4+IENjOiBTdXp1a2kgSyBQb3Vsb3NlIDxzdXp1a2kucG91bG9zZUBhcm0u
Y29tPg0KPj4+PiBDYzogTWlrZSBMZWFjaCA8bWlrZS5sZWFjaEBsaW5hcm8ub3JnPg0KPj4+PiBD
YzogTGVvIFlhbiA8bGVvLnlhbkBsaW5hcm8ub3JnPg0KPj4+PiBDYzogU3VkZWVwIEhvbGxhIDxz
dWRlZXAuaG9sbGFAYXJtLmNvbT4NCj4+Pj4gQ2M6IExvcmVuem8gUGllcmFsaXNpIDxscGllcmFs
aXNpQGtlcm5lbC5vcmc+DQo+Pj4+IENjOiBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZw0KPj4+
PiBDYzogY29yZXNpZ2h0QGxpc3RzLmxpbmFyby5vcmcNCj4+Pj4gQ2M6IGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPj4+PiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZw0KPj4+PiBSZXZpZXdlZC1ieTogU3VkZWVwIEhvbGxhIDxzdWRlZXAuaG9sbGFAYXJtLmNv
bT4gKGZvciBBQ1BJIHNwZWNpZmljDQo+Pj4+IGNoYW5nZXMpDQo+Pj4+IFNpZ25lZC1vZmYtYnk6
IFN1enVraSBLIFBvdWxvc2UgPHN1enVraS5wb3Vsb3NlQGFybS5jb20+DQo+Pj4+IFNpZ25lZC1v
ZmYtYnk6IEFuc2h1bWFuIEtoYW5kdWFsIDxhbnNodW1hbi5raGFuZHVhbEBhcm0uY29tPg0KPj4+
DQo+Pj4gV2Ugd291bGQgbGlrZSB0byBxdWV1ZSB0aGlzIHZpYSBjb3Jlc2lnaHQgdHJlZS4gVGhl
IGFjcGlfYW1iYSBiaXRzIGhhdmUNCj4+PiBiZWVuIHJldmlld2VkIGJ5IFN1ZGVlcC4gUGxlYXNl
IGNvdWxkIHlvdSBnaXZlIHVzIGFuIEFjaywgaWYgeW91IGFyZQ0KPj4+IGhhcHB5IHdpdGggdGhl
IHByb3Bvc2FsID8NCj4+Pg0KPiANCj4gUGxlYXNlIGNvdWxkIG9uZSBvZiB5b3UgcmVzcG9uZCB0
byB0aGlzIHBhdGNoID8gV2UgYXJlIGJsb2NrZWQgb24geW91cg0KPiBBY2sgZm9yIHF1ZXVpbmcg
dGhpcy4gVGhlcmUgYXJlIG1hY2hpbmVzIG91dCB0aGVyZSwgd2hpY2ggcmVseSBvbiB0aGlzDQo+
IHBhdGNoIHRvIHVzZSBBcm0gc2VsZi1ob3N0ZWQgdHJhY2luZyBiYXNlZCBvbiBDb3JlU2lnaHQu
DQo+IA0KPiBLaW5kIHJlZ2FyZHMNCj4gU3V6dWtpDQoNCkFtcGVyZSBDb21wdXRpbmcgQW1wZXJl
T25lIG1hY2hpbmVzIHJlbHkgb24gdGhpcyBwYXRjaCBzZXJpZXMgdG8gZW5hYmxlDQpTeXN0ZW0g
UmVnaXN0ZXIgQWNjZXNzIHRvIHRoZSBFVE12NC4gQW1wZXJlIHJlbW92ZWQgdGhlIEVUTSBNTUlP
DQpkZXNjcmlwdGlvbnMgZnJvbSBvdXIgQ29yZVNpZ2h0IEFDUEkgdG8gdXNlIHRoaXMuDQoNClN1
enVraSdzIGUtbWFpbCByZXF1ZXN0cyBmb3IgcmV2aWV3L0FjayBvZiB0aGlzIHBhdGNoIHRocmVh
ZCBkYXRlIGJhY2sNCnRvIE1heSAzMC4NCg0KVGhhbmtzIGluIGFkdmFuY2UsDQpTdGV2ZSBDLg0K
DQo+IA0KPj4NCj4+IEtpbmQgcmVnYXJkcw0KPj4gU3V6dWtpDQo+Pg0KPj4+IEtpbmQgcmVnYXJk
cw0KPj4+IFN1enVraQ0KPj4+DQo+Pj4NCj4+Pj4gLS0tDQo+Pj4+IMKgIGRyaXZlcnMvYWNwaS9h
Y3BpX2FtYmEuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfMKgIDEgLQ0KPj4+PiDCoCBkcml2ZXJzL2h3dHJhY2luZy9jb3Jlc2lnaHQvY29yZXNp
Z2h0LWV0bTR4LWNvcmUuYyB8IDEwICsrKysrKysrKysNCj4+Pj4gwqAgMiBmaWxlcyBjaGFuZ2Vk
LCAxMCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2FjcGkvYWNwaV9hbWJhLmMgYi9kcml2ZXJzL2FjcGkvYWNwaV9hbWJhLmMNCj4+
Pj4gaW5kZXggZjViNDQzYWIwMWMyLi4wOTk5NjZjYmFjNWEgMTAwNjQ0DQo+Pj4+IC0tLSBhL2Ry
aXZlcnMvYWNwaS9hY3BpX2FtYmEuYw0KPj4+PiArKysgYi9kcml2ZXJzL2FjcGkvYWNwaV9hbWJh
LmMNCj4+Pj4gQEAgLTIyLDcgKzIyLDYgQEANCj4+Pj4gwqAgc3RhdGljIGNvbnN0IHN0cnVjdCBh
Y3BpX2RldmljZV9pZCBhbWJhX2lkX2xpc3RbXSA9IHsNCj4+Pj4gwqDCoMKgwqDCoCB7IkFSTUgw
MDYxIiwgMH0sIC8qIFBMMDYxIEdQSU8gRGV2aWNlICovDQo+Pj4+IMKgwqDCoMKgwqAgeyJBUk1I
MDMzMCIsIDB9LCAvKiBBUk0gRE1BIENvbnRyb2xsZXIgRE1BLTMzMCAqLw0KPj4+PiAtwqDCoMKg
IHsiQVJNSEM1MDAiLCAwfSwgLyogQVJNIENvcmVTaWdodCBFVE00eCAqLw0KPj4+PiDCoMKgwqDC
oMKgIHsiQVJNSEM1MDEiLCAwfSwgLyogQVJNIENvcmVTaWdodCBFVFIgKi8NCj4+Pj4gwqDCoMKg
wqDCoCB7IkFSTUhDNTAyIiwgMH0sIC8qIEFSTSBDb3JlU2lnaHQgU1RNICovDQo+Pj4+IMKgwqDC
oMKgwqAgeyJBUk1IQzUwMyIsIDB9LCAvKiBBUk0gQ29yZVNpZ2h0IERlYnVnICovDQo+Pj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2h3dHJhY2luZy9jb3Jlc2lnaHQvY29yZXNpZ2h0LWV0bTR4LWNv
cmUuYw0KPj4+PiBiL2RyaXZlcnMvaHd0cmFjaW5nL2NvcmVzaWdodC9jb3Jlc2lnaHQtZXRtNHgt
Y29yZS5jDQo+Pj4+IGluZGV4IDQzZjU4Mzk4NzI1MC4uNzAzYjZmY2JiNmE1IDEwMDY0NA0KPj4+
PiAtLS0gYS9kcml2ZXJzL2h3dHJhY2luZy9jb3Jlc2lnaHQvY29yZXNpZ2h0LWV0bTR4LWNvcmUu
Yw0KPj4+PiArKysgYi9kcml2ZXJzL2h3dHJhY2luZy9jb3Jlc2lnaHQvY29yZXNpZ2h0LWV0bTR4
LWNvcmUuYw0KPj4+PiBAQCAtMyw2ICszLDcgQEANCj4+Pj4gwqDCoCAqIENvcHlyaWdodCAoYykg
MjAxNCwgVGhlIExpbnV4IEZvdW5kYXRpb24uIEFsbCByaWdodHMgcmVzZXJ2ZWQuDQo+Pj4+IMKg
wqAgKi8NCj4+Pj4gKyNpbmNsdWRlIDxsaW51eC9hY3BpLmg+DQo+Pj4+IMKgICNpbmNsdWRlIDxs
aW51eC9iaXRvcHMuaD4NCj4+Pj4gwqAgI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPg0KPj4+PiDC
oCAjaW5jbHVkZSA8bGludXgvbW9kdWxlcGFyYW0uaD4NCj4+Pj4gQEAgLTIzNDcsMTIgKzIzNDgs
MjEgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQNCj4+Pj4gZXRtNF9zeXNyZWdf
bWF0Y2hbXSA9IHsNCj4+Pj4gwqDCoMKgwqDCoCB7fQ0KPj4+PiDCoCB9Ow0KPj4+PiArI2lmZGVm
IENPTkZJR19BQ1BJDQo+Pj4+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGFjcGlfZGV2aWNlX2lkIGV0
bTR4X2FjcGlfaWRzW10gPSB7DQo+Pj4+ICvCoMKgwqAgeyJBUk1IQzUwMCIsIDB9LCAvKiBBUk0g
Q29yZVNpZ2h0IEVUTTR4ICovDQo+Pj4+ICvCoMKgwqAge30NCj4+Pj4gK307DQo+Pj4+ICtNT0RV
TEVfREVWSUNFX1RBQkxFKGFjcGksIGV0bTR4X2FjcGlfaWRzKTsNCj4+Pj4gKyNlbmRpZg0KPj4+
PiArDQo+Pj4+IMKgIHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIGV0bTRfcGxhdGZvcm1f
ZHJpdmVyID0gew0KPj4+PiDCoMKgwqDCoMKgIC5wcm9iZcKgwqDCoMKgwqDCoMKgID0gZXRtNF9w
cm9iZV9wbGF0Zm9ybV9kZXYsDQo+Pj4+IMKgwqDCoMKgwqAgLnJlbW92ZcKgwqDCoMKgwqDCoMKg
ID0gZXRtNF9yZW1vdmVfcGxhdGZvcm1fZGV2LA0KPj4+PiDCoMKgwqDCoMKgIC5kcml2ZXLCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgID0gew0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgLm5hbWXCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgID0gImNvcmVzaWdodC1ldG00eCIsDQo+Pj4+IMKgwqDCoMKgwqDC
oMKgwqDCoCAub2ZfbWF0Y2hfdGFibGXCoMKgwqDCoMKgwqDCoCA9IGV0bTRfc3lzcmVnX21hdGNo
LA0KPj4+PiArwqDCoMKgwqDCoMKgwqAgLmFjcGlfbWF0Y2hfdGFibGXCoMKgwqAgPSBBQ1BJX1BU
UihldG00eF9hY3BpX2lkcyksDQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAuc3VwcHJlc3NfYmlu
ZF9hdHRyc8KgwqDCoCA9IHRydWUsDQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAucG3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgID0gJmV0bTRfZGV2X3BtX29wcywNCj4+Pj4gwqDCoMKgwqDCoCB9LA0K
Pj4+DQo+Pg0KPiANCg==

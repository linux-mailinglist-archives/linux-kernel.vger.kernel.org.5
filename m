Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E11763C88
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 18:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjGZQax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 12:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjGZQav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:30:51 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2093.outbound.protection.outlook.com [40.107.93.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC5A269E;
        Wed, 26 Jul 2023 09:30:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZMgvFEf7irNxGcSQ3bhWC1RV3CCDkeeEn1kZdUC+WWtpcZTVI7ucpeC4xvnM/Uh4EtPOI8a281REhKSHBKRwiLARbBpHRLS1BaR4RJpO3ywofACvHMY5VJ3K2vq3den56QAYRNLCU79g2xU4CoKP7h+bh0Im/RyynAHU5E33eDkgjpdXPgEIYUz4DONvocVN+DV8WonTfycEe2P0WHJlu19lOdtg8m8mLWtyR9DYGXaDV0dYOLFcn6w4vMY5vFQ8qRazVwrFqfC5TM8zm5b62M3bsN/bhks9lC1Ig4tyB+zi+yGBfTml8GGeEQ5tGeDv/OzFctLhEhxFrzUrDYedQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2G0/LnKOaEqnhCL1Xsf7wJfDicck9qvx9ufLDOd5n0o=;
 b=HAzvWq7CXfaPVok5eh14AiEegCUzsJMJ8rFW54cxepERs1Up3neRZ2+6F1TA12wKmGEmBO9DtZ1dQx1ZIrx0TB98DK7NJGGE5EFLnf9DJhOQ/as9QooWiJbTU3/8OC8cW7SIazH0svZCZ0E4D/XYXo/3YLayXzypqzE/D/wAXuckJ87kc+kXTuVFyETblUoFwqeetR1+G/+r0gPWfvGwQm/gcA6WmPscEmmWM+RcmKaMIo82VU3XWDdr34Bq2LhSOCJ7LZio//aqiAA2lhPvcEn4yVXurt9SAZL0v0l7O7U3dQm+pw1e9YmpbSFIZyDX+t81QrG/jiWuXzpiE6pXjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2G0/LnKOaEqnhCL1Xsf7wJfDicck9qvx9ufLDOd5n0o=;
 b=h62O94FSh+CAD2i5nClLPBS44eYevSiW+lMJ2dUQwWJT+9OXH0aWHGsToy3jFOKOJ2ePj0UO6LPZNtzovXXl94TWOeoOkFVMApcOFShfLvwl2EmkdlcUv0lqjcYpz8kqm8h8qxRvt4H2FHvaid452YHEvR2B3IUkGXqkERRPXVM=
Received: from SA1PR01MB8062.prod.exchangelabs.com (2603:10b6:806:335::13) by
 SJ0PR01MB7477.prod.exchangelabs.com (2603:10b6:a03:3e2::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Wed, 26 Jul 2023 16:30:43 +0000
Received: from SA1PR01MB8062.prod.exchangelabs.com
 ([fe80::9683:1d6b:f08e:2839]) by SA1PR01MB8062.prod.exchangelabs.com
 ([fe80::9683:1d6b:f08e:2839%4]) with mapi id 15.20.6609.022; Wed, 26 Jul 2023
 16:30:43 +0000
From:   Steve Clevenger OS <scclevenger@os.amperecomputing.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Len Brown <lenb@kernel.org>,
        Ganapatrao Kulkarni OS <gankulkarni@os.amperecomputing.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
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
Thread-Index: Adm/3oXha9t9D9VZrU28Kcxpl+i/TA==
Date:   Wed, 26 Jul 2023 16:30:43 +0000
Message-ID: <3c9803af-7d33-a959-e553-9eecca0d3e28@os.amperecomputing.com>
References: <20230710062500.45147-1-anshuman.khandual@arm.com>
 <20230710062500.45147-7-anshuman.khandual@arm.com>
 <38f0c8f3-5fb3-a18a-456d-867da2998786@arm.com>
 <ac77142d-964b-691d-ea15-105a523d9738@arm.com>
 <46a3d6d3-f14e-efde-83eb-5952f313f909@arm.com>
 <abbcf3c8-fbd9-727e-780b-74aaf5ae8ec1@os.amperecomputing.com>
 <CAJZ5v0iy9QfSRuy_kNNZarJZyO35GN25Td39GGN=kNbr0-fuBA@mail.gmail.com>
 <20230726150327.jfhla23nhlszigq7@bogus>
In-Reply-To: <20230726150327.jfhla23nhlszigq7@bogus>
Reply-To: Steve Clevenger OS <scclevenger@os.amperecomputing.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CH0PR03CA0335.namprd03.prod.outlook.com
 (2603:10b6:610:11a::31) To SA1PR01MB8062.prod.exchangelabs.com
 (2603:10b6:806:335::13)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR01MB8062:EE_|SJ0PR01MB7477:EE_
x-ms-office365-filtering-correlation-id: 7fe2478d-d8e6-4ae9-b75a-08db8df5a85c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s+rjbj0VOQ+ZcetH6+OUNPLf9xoZPFvQMqz+2ZhiJ5MQXJ3oWlrER2iMnqXR/RnBdkbAjYCioXoKMlmpmnWRINATHo9OKD7r00St/ZzoJAnc5gECoTRnt9sRmxyeJM57qqr4Yn92es9k8acHIAYC7R86uisO9Kj3iLIUGcqnmygJQa9S9ahP9qMAU3+toEtwu/YQ+d9S8hJqAooHQoDWHk4A/XVdbwN4ucFvI8BS0NTyXnh/3LhP8pjciePcAtmNaE0FJTtpGFmjWCfwG+j31j5sHiePD3IVCpwiBEx0NCRGkNqJfJSr5BOh+Q67BfOrbHzntuiAR8u0uQAqlv/EH4ie+1uT2fcGfQeI6csEKaRblivQ+8zzrbJnb+YwzlNdm4aSQssDGL6gIXh6rAwwJ/mHsbibIyq2CuRQvWmz6AS74NGQQiE0QbUuxU0QdIIhMrUZDbBTOWg0LqaOK/oCyLIQsfoDvinr+VPr77izZX3aw3vHxrs21HeZHpwXR/w0dJ/cdc1ZYss03B5EsRhIQqxD1EOV7EHMRafD/lH3+3s+bl4wAV/SbFwTBSG031XJGa6z7wRBjjelKb0VhVJUQBJkpJPKCiRY3ybZe8VnzK0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR01MB8062.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39850400004)(346002)(396003)(376002)(136003)(451199021)(110136005)(3450700001)(54906003)(71200400001)(38100700002)(6486002)(122000001)(2906002)(478600001)(7416002)(316002)(8676002)(8936002)(5660300002)(41300700001)(4326008)(66946007)(66446008)(66476007)(64756008)(66556008)(53546011)(186003)(31696002)(86362001)(6506007)(26005)(83380400001)(2616005)(31686004)(6512007)(966005)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0FlOXlYRTEyQU1MaGNueWQwNXl3RGZoNHBCM084ZHJYZmF6d0lSbk1sQUQ4?=
 =?utf-8?B?ZmsxbjV1ZS9najFYMFU1bytkN1RrUkNCWUlLbjdOSTEybWxQbUpHR211TW90?=
 =?utf-8?B?SUlUd2FodVRiL2hPOVpWTzU0L1Nxd1ArNmNEU2JLY3V0ajRKMHliNkJ0elhv?=
 =?utf-8?B?MUg3dWFBazk5dHIvb0VlQ3lXWGtPcGI0UUdRWlJxWTd4MnJIVzcwaUY3QUxZ?=
 =?utf-8?B?d2E5S3lTYmVBTGVFdmRxMFZTQlk3ekJhbFJDUUxOOEJMbldBUFJ3VkdYWGNj?=
 =?utf-8?B?YVExS2RaUk5OeW96ZnZyZGUzRURVWW1FVHhIdlJ5VXdvZ3duN0pZMVZLM3V2?=
 =?utf-8?B?a21GMGlPUVBVSWdxY1R1U3ZhcXVCcHM4Q01OYndYNm0vVUJKRTJadi9mZXRT?=
 =?utf-8?B?UWpPRnlTeTJSUXgxZHlVeHAwY0o3aTRROGRhMVV2MzNjR2NTUTVIalQ0NDE1?=
 =?utf-8?B?anVNQXVPcVRPWHRVWFRLTkJ1Vlp0aVlYSERadkhLV3l0MStTTVFIWWMxb0s2?=
 =?utf-8?B?Ujh3SGJ0bEdXaytYdjc0YXhOSldjakdMTXdJZFQvS2ZqaDVPcjNWSENjUjFB?=
 =?utf-8?B?TUQydm9PeFZ1dit0dGYvT0FpeHNiV2lHeWw1Y1RBQlgvR3BZQXVNQSt1VUN0?=
 =?utf-8?B?dzJaRlU1ZGdWUUE5WTg1d1JuZE9sNm1STkprdUF6cG91ZVl2VDhFSTBBT0hi?=
 =?utf-8?B?RC81L1hGa1JsY0xWU0xqVVhkRWE2WSszY2pkSTVtbG5RQzNXVXZqSkF6UE9G?=
 =?utf-8?B?Vys3ZHBOR2xab3YyaVcwT3V0Y0tpSExJK1NsaHE2b3hTdURaRU50c2IyYmVE?=
 =?utf-8?B?Z2JWVnA5bHBGeFpSUElJanV6WHV5ZC81WG1ObDVYTENkM3UwcGxvREpzckFp?=
 =?utf-8?B?T1poSXZETjc4V1k5eXQ4WEpDUDdYd3NFNVB2cmJuQmxqQVZPaGd6UTl0dm9w?=
 =?utf-8?B?YTduOWZ4K2RtZW1nY1ZNSmFaVHdxaEl3MDhVQjJrblRhdnAxRnhzYlRHVEt0?=
 =?utf-8?B?REgwbWVJYzNaTFRRckNIbVZHWFBiVnB1K1N3WGhsRThneTQrdDNjM2liNXJz?=
 =?utf-8?B?UGdFOWJlZ1puOEQ5VWR6Nzc3L2NvOHhReDFaSk9WL3F5YVZabEVONWdVSlFr?=
 =?utf-8?B?dktrWUt3aDFqblFGZGdGUllkRUxnTTZqNURQQjFIb2k5b014d0VQQW80TWdZ?=
 =?utf-8?B?Uk1yNmFObU1WVmRIemJ1NCtSRWxwQnoxbDRJcGdKNlZMV0JOTnNzRk9XMUY1?=
 =?utf-8?B?VHVjTkJZSG9tSTdrSkpMS25odklkYWFXRlNhdGdEb1RyaCt0SWRTVEQ2RFg2?=
 =?utf-8?B?OExjZmhERWU0SngvWjNYb0JXVHMrZ0RtNC8rM1ZGNnQ5V01rNmF0QUZnVHMx?=
 =?utf-8?B?TmhqVDF3d1hBS2RCUnJ1WXpjQVA2TUdrcnIvUGFOemlaRXgxUmYyNng5S240?=
 =?utf-8?B?Nk9meUwwWjg4Tzd5VE9VUUZaT05HZHEvM3dPUXFZMEhMK2FFdzNFTkUySDgy?=
 =?utf-8?B?L2JPazVrL1QyK2NKb1hqZ2VYeXNndkJmV2ZQMkcvUStYdmdlbGltRUc1Y3NC?=
 =?utf-8?B?NEV5RkFZcHdiMGdkUDlTOXQrL254UzN2TEtzRzFhY1NITG9GRVgrdElid3JS?=
 =?utf-8?B?N2d3MkdPWU5GeEQxYU1EZUF6RVBtNmFXdy9vZ09nQ2VzM2QzZG9vOWx0Rmty?=
 =?utf-8?B?cjltL2piS2F1VFRxQ2trVE4xL3JtNW9MYlc3Szc4RDh4Mm9XMm16Z080bGRw?=
 =?utf-8?B?MkZ5dXFuQnJieWhHYzJuUXlHTG5Mam5TWVN0elNDcXlDUTI0WURESWVibDVP?=
 =?utf-8?B?cW5aY3V3NHJWdXJZWi9TWVNIQXdwQ2Y1b3BNRWRRTkVpMWIvNms3aHkya0tj?=
 =?utf-8?B?blBqOG9qb2E2OTBRZ3cyUTliamZxY3h2bitNUUVITlV3cVBXK1NUNGlaSTV6?=
 =?utf-8?B?RzEyVlJzUXFvM2VxNVEyS1ZKWjM3T3dnMFFwRUhQMGF4cGUyWkxXOGJrUzRL?=
 =?utf-8?B?ZmJvUWtjQUtQT05OMmN3RWlSWmtvZnR0TE52TzEvblNRRlZ6S1V5Zm5EWFNN?=
 =?utf-8?B?eEM3QklCUTVHOWhuTXJ3NzdQWldyQXdJaExtT3FXaWVXMmM3MDN3a0N2MGtw?=
 =?utf-8?B?M2ptc0tmK0piOTZINXhOZk54RG15Z3B4Mm1CVWJCaVl5NEgrd2hQQjJMVHV4?=
 =?utf-8?Q?f7FnQ9/uV40R8iHh/jrk2Gc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ACCB507D61E60E4B91386EC701ACFE5D@prod.exchangelabs.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR01MB8062.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe2478d-d8e6-4ae9-b75a-08db8df5a85c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 16:30:43.4190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rKgSiOyf4R9z063OMaI+YNtRTLi53YUXsazowqiMY4pCYO8U64/sCP0MIVXlj6Z82SScE+GMszxQXzj/FoLlnZ9iRx4zjZ9A8T/m3f2V9FQQOZPowuu49ZVHNf9soRvM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB7477
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBTdWRlZXAsDQoNCk9uIDcvMjYvMjAyMyA4OjAzIEFNLCBTdWRlZXAgSG9sbGEgd3JvdGU6
DQo+IE9uIFdlZCwgSnVsIDI2LCAyMDIzIGF0IDA0OjMzOjI2UE0gKzAyMDAsIFJhZmFlbCBKLiBX
eXNvY2tpIHdyb3RlOg0KPj4gT24gVHVlLCBKdWwgMjUsIDIwMjMgYXQgMTA6MTjigK9QTSBTdGV2
ZSBDbGV2ZW5nZXIgT1MNCj4+IDxzY2NsZXZlbmdlckBvcy5hbXBlcmVjb21wdXRpbmcuY29tPiB3
cm90ZToNCj4+Pg0KPj4+DQo+Pj4gSGkgUmFmYWVsLCBMZW4sDQo+Pj4NCj4+PiBPbiA3LzI0LzIw
MjMgOToyNSBBTSwgU3V6dWtpIEsgUG91bG9zZSB3cm90ZToNCj4+Pj4gSGkgUmFmYWVsL0xlbg0K
Pj4+Pg0KPj4+PiBPbiAxOS8wNy8yMDIzIDExOjExLCBTdXp1a2kgSyBQb3Vsb3NlIHdyb3RlOg0K
Pj4+Pj4gUmFmYWVsLCBMZW4NCj4+Pj4+DQo+Pj4+PiBQaW5nIChwYWNrZXRzIDYsIGxvc3QgMTAw
JSkuDQo+Pj4+Pg0KPj4+Pj4NCj4+Pj4+IE9uIDEwLzA3LzIwMjMgMTc6NDAsIFN1enVraSBLIFBv
dWxvc2Ugd3JvdGU6DQo+Pj4+Pj4gUmFmYWVsLCBMZW4NCj4+Pj4+Pg0KPj4+Pj4+IE9uIDEwLzA3
LzIwMjMgMDc6MjUsIEFuc2h1bWFuIEtoYW5kdWFsIHdyb3RlOg0KPj4+Pj4+PiBGcm9tOiBTdXp1
a2kgSyBQb3Vsb3NlIDxzdXp1a2kucG91bG9zZUBhcm0uY29tPg0KPj4+Pj4+Pg0KPj4+Pj4+PiBE
cm9wIEVUTTRYIEFDUEkgSUQgZnJvbSB0aGUgQU1CQSBBQ1BJIGRldmljZSBsaXN0LCBhbmQgaW5z
dGVhZCBqdXN0DQo+Pj4+Pj4+IG1vdmUgaXQNCj4+Pj4+Pj4gaW5zaWRlIHRoZSBuZXcgQUNQSSBk
ZXZpY2VzIGxpc3QgZGV0ZWN0ZWQgYW5kIHVzZWQgdmlhIHBsYXRmb3JtIGRyaXZlci4NCj4+Pj4+
Pj4NCj4+Pj4+Pj4gQ2M6ICJSYWZhZWwgSi4gV3lzb2NraSIgPHJhZmFlbEBrZXJuZWwub3JnPg0K
Pj4+Pj4+PiBDYzogTGVuIEJyb3duIDxsZW5iQGtlcm5lbC5vcmc+DQo+Pj4+Pj4+IENjOiBNYXRo
aWV1IFBvaXJpZXIgPG1hdGhpZXUucG9pcmllckBsaW5hcm8ub3JnPg0KPj4+Pj4+PiBDYzogU3V6
dWtpIEsgUG91bG9zZSA8c3V6dWtpLnBvdWxvc2VAYXJtLmNvbT4NCj4+Pj4+Pj4gQ2M6IE1pa2Ug
TGVhY2ggPG1pa2UubGVhY2hAbGluYXJvLm9yZz4NCj4+Pj4+Pj4gQ2M6IExlbyBZYW4gPGxlby55
YW5AbGluYXJvLm9yZz4NCj4+Pj4+Pj4gQ2M6IFN1ZGVlcCBIb2xsYSA8c3VkZWVwLmhvbGxhQGFy
bS5jb20+DQo+Pj4+Pj4+IENjOiBMb3JlbnpvIFBpZXJhbGlzaSA8bHBpZXJhbGlzaUBrZXJuZWwu
b3JnPg0KPj4+Pj4+PiBDYzogbGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmcNCj4+Pj4+Pj4gQ2M6
IGNvcmVzaWdodEBsaXN0cy5saW5hcm8ub3JnDQo+Pj4+Pj4+IENjOiBsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmcNCj4+Pj4+Pj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmcNCj4+Pj4+Pj4gUmV2aWV3ZWQtYnk6IFN1ZGVlcCBIb2xsYSA8c3VkZWVwLmhvbGxhQGFy
bS5jb20+IChmb3IgQUNQSSBzcGVjaWZpYw0KPj4+Pj4+PiBjaGFuZ2VzKQ0KPj4+Pj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBTdXp1a2kgSyBQb3Vsb3NlIDxzdXp1a2kucG91bG9zZUBhcm0uY29tPg0KPj4+
Pj4+PiBTaWduZWQtb2ZmLWJ5OiBBbnNodW1hbiBLaGFuZHVhbCA8YW5zaHVtYW4ua2hhbmR1YWxA
YXJtLmNvbT4NCj4+Pj4+Pg0KPj4+Pj4+IFdlIHdvdWxkIGxpa2UgdG8gcXVldWUgdGhpcyB2aWEg
Y29yZXNpZ2h0IHRyZWUuIFRoZSBhY3BpX2FtYmEgYml0cyBoYXZlDQo+Pj4+Pj4gYmVlbiByZXZp
ZXdlZCBieSBTdWRlZXAuIFBsZWFzZSBjb3VsZCB5b3UgZ2l2ZSB1cyBhbiBBY2ssIGlmIHlvdSBh
cmUNCj4+Pj4+PiBoYXBweSB3aXRoIHRoZSBwcm9wb3NhbCA/DQo+Pj4+Pj4NCj4+Pj4NCj4+Pj4g
UGxlYXNlIGNvdWxkIG9uZSBvZiB5b3UgcmVzcG9uZCB0byB0aGlzIHBhdGNoID8gV2UgYXJlIGJs
b2NrZWQgb24geW91cg0KPj4+PiBBY2sgZm9yIHF1ZXVpbmcgdGhpcy4gVGhlcmUgYXJlIG1hY2hp
bmVzIG91dCB0aGVyZSwgd2hpY2ggcmVseSBvbiB0aGlzDQo+Pj4+IHBhdGNoIHRvIHVzZSBBcm0g
c2VsZi1ob3N0ZWQgdHJhY2luZyBiYXNlZCBvbiBDb3JlU2lnaHQuDQo+Pj4+DQo+Pj4+IEtpbmQg
cmVnYXJkcw0KPj4+PiBTdXp1a2kNCj4+Pg0KPj4+IEFtcGVyZSBDb21wdXRpbmcgQW1wZXJlT25l
IG1hY2hpbmVzIHJlbHkgb24gdGhpcyBwYXRjaCBzZXJpZXMgdG8gZW5hYmxlDQo+Pj4gU3lzdGVt
IFJlZ2lzdGVyIEFjY2VzcyB0byB0aGUgRVRNdjQuIEFtcGVyZSByZW1vdmVkIHRoZSBFVE0gTU1J
Tw0KPj4+IGRlc2NyaXB0aW9ucyBmcm9tIG91ciBDb3JlU2lnaHQgQUNQSSB0byB1c2UgdGhpcy4N
Cj4+Pg0KPj4+IFN1enVraSdzIGUtbWFpbCByZXF1ZXN0cyBmb3IgcmV2aWV3L0FjayBvZiB0aGlz
IHBhdGNoIHRocmVhZCBkYXRlIGJhY2sNCj4+PiB0byBNYXkgMzAuDQo+Pg0KPj4gSSd2ZSBqdXN0
IHRhbGtlZCB0byBTdXp1a2kgYWJvdXQgdGhpczoNCj4+DQo+PiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9saW51eC1hY3BpLzIwMjMwNzI2MTQwNTE1LjM2ODk4MS0xLXN1enVraS5wb3Vsb3NlQGFy
bS5jb20NCj4+DQo+PiBUaGlzIHBhdGNoIGhhcyByZWNlaXZlZCBhIFJldmlld2VkLWJ5IGZyb20g
U3VkZWVwIHdoaWNoIGZvciBhbGwNCj4+IHB1cnBvc2VzIHNob3VsZCBiZSBzdWZmaWNpZW50IGZv
ciBhbnkgQVJNLXJlbGF0ZWQgQUNQSSBtYXRlcmlhbCB0aGF0DQo+PiBkb2Vzbid0IGFmZmVjdCBh
bnkgb3RoZXIgYXJjaGl0ZWN0dXJlcy4gIEFuIEFDSyBmcm9tIG1lIChvciBMZW4gZm9yDQo+PiB0
aGF0IG1hdHRlcikgd291bGQgbm90IG1ha2UgYW55IHJlYWwgZGlmZmVyZW5jZSBmcm9tIHRoZSB0
ZWNobmljYWwNCj4+IHBlcnNwZWN0aXZlLg0KPj4NCj4+IEkgd291bGQgYXBwcmVjaWF0ZSBhc3Np
Z25pbmcgYW4gb2ZmaWNpYWwgQVJNIG1haW50YWluZXIgdG8gYWNwaV9hbWJhLmMNCj4+IHNvIGFz
IHRvIGF2b2lkIHN1Y2ggdW5uZWNlc3NhcnkgZGVsYXlzIGluIHRoZSBmdXR1cmUuDQo+IA0KPiBB
aCBJIGp1c3QgY3Jvc3NlZCBhbmQgcmVwbGllZCBvbiBvdGhlciB0aHJlYWQuIEkgd2lsbCBzb29u
IHNlbmQgYW4gdXBkYXRlDQo+IHRvIGFkZCB0aGlzIGZpbGUgdW5kZXIgQXJtIEFDUEkgZm9yIHRo
ZSBtYWludGVuYW5jZS4NCj4gDQoNClRoYW5rIHlvdS4NCg0KU3RldmUgQy4NCg==

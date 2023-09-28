Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BD37B24FC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 20:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjI1SMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 14:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjI1SMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 14:12:49 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021023.outbound.protection.outlook.com [52.101.62.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E2919E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 11:12:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyai0dasS0SkU0e8k5KtGTzraB3F8buOp0kSVjyUbTAc3PWgjJhjmeGixNZ+kYBH//3joRpWK9C62sNRvEMFauiGJnaOVY96+boBDrxyZDkdWKrJQnQOwphoyD3nUCIO4BKi9rm3FW9fjR9hItzueRZLO4oBxXCMZoDPCR9U4OfKsY9bL5xyPsz39/90cuTJC8Lg7ayfI0ikbxos9xSoLDYq1s8hTsuc9U2teviIFLUtDe0UzNwX6y5izexzzK4llJSxFnm5xomK2rReivzJqfJCnFLhZ+QqgUcAp61el4j4MYWa1Jf/9SwpG17PsJysUT5MMWEmYRS+RE/MqjbPRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NrNElQ7oWj7XPhrmqsaNaJnqK1WGSiT/WUjIs3v9JCY=;
 b=T/xaaOaJTBebtb9D9F+d+gx6EM9UgOvEZvqI6ll9SBU3Ui8TL/QRQ1V8GP89XapnK1E6Vr+sqAEWw14l7n1CzBzR4Nia5mHfTwgxSi8E+JvCly8CEkSUTR3N//xNFP9C+oaLrTggf7vWexfdLBOiyWvOr9o6WhUU9GePrGH5CQDGXkzI06Y1/JBkec/nRMeKdIMDZCdnl6pdhG/cXmrsMERBVd/Ttihi0IG0VNT8gfkNccRiSvYjMYLsJx/wf1y5w6hHOIk6oaxd8ib2vucJ3noPlkDeguTNa1Val9MBKl1kKx0wTRx4RALF3AJlKGYaxFdW0atCCBMHq0sH9xwkqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrNElQ7oWj7XPhrmqsaNaJnqK1WGSiT/WUjIs3v9JCY=;
 b=Qr/o2fTNGIWzxdQYKnxy/XRrCyYQoqlxtIa53E9xTvD/UzSWdobOkp2l4kWvpCNO90/aisjNCXLc/WUYkGEAFEpw4LmqPV6txskV41fbg3qYjPFUI2ZYQIcakorPxvTpv9k7S8d6xQbfsQGEk9esTva3b+RhS7z8WZQPqplrWC4=
Received: from BL1PR21MB3113.namprd21.prod.outlook.com (2603:10b6:208:391::14)
 by CH2PR21MB1462.namprd21.prod.outlook.com (2603:10b6:610:81::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.19; Thu, 28 Sep
 2023 18:12:44 +0000
Received: from BL1PR21MB3113.namprd21.prod.outlook.com
 ([fe80::623a:2dc0:5a6:7b00]) by BL1PR21MB3113.namprd21.prod.outlook.com
 ([fe80::623a:2dc0:5a6:7b00%5]) with mapi id 15.20.6838.010; Thu, 28 Sep 2023
 18:12:44 +0000
From:   KY Srinivasan <kys@microsoft.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
        Baoquan He <bhe@redhat.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "stanislav.kinsburskii@gmail.com" <stanislav.kinsburskii@gmail.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jgowans@amazon.com" <jgowans@amazon.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "graf@amazon.de" <graf@amazon.de>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: RE: [EXTERNAL] Re: [RFC PATCH v2 0/7] Introduce persistent memory
 pool
Thread-Topic: [EXTERNAL] Re: [RFC PATCH v2 0/7] Introduce persistent memory
 pool
Thread-Index: AQHZ8V2QHYUyumbNkEeBOFJiZEPRMrAwOwsAgABGlgCAAACrAIAACO8A
Date:   Thu, 28 Sep 2023 18:12:44 +0000
Message-ID: <BL1PR21MB3113B31101E8E3E4BA08D9ACA0C1A@BL1PR21MB3113.namprd21.prod.outlook.com>
References: <01828.123092517290700465@us-mta-156.us.mimecast.lan>
 <ZRPBRkXrYvbw8+Lt@MiWiFi-R3L-srv> <20230927161319.GA19976@skinsburskii.>
 <ee1907a1-2f04-cfa3-9f09-75b94994e88b@intel.com>
 <fa924c8d-c954-5612-37eb-43e1976a1b7b@redhat.com>
 <f0f68a16-9bf2-703a-345f-5061e821e80a@intel.com>
In-Reply-To: <f0f68a16-9bf2-703a-345f-5061e821e80a@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9c573f06-b2cf-4116-b1c3-d6ca55e91856;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-09-28T18:09:54Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR21MB3113:EE_|CH2PR21MB1462:EE_
x-ms-office365-filtering-correlation-id: 4b64eab5-31c6-473a-9824-08dbc04e8365
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Png3VVRU2XSudby/RXOXvC3+QTwY/gMvnVgl/i5YPwJwyJvO9n6SDf4lLi1UBJX5O8CLolFrBWuCqrU4Wxy2B24K8lIJd/uZf4OTI3i7ilzDoKaZnpZxPNUOxJoELadbIokvLbXlA0fthI9lBISpDXd6TNpSA4sIskzaZnUcB1ZvUtISSzptNdABO6gyHPDnDzuBvWwVHl1iX26ZKkkuESyFCbztvXZiZh8XR6VH0HuQSpg3T4spsaH6CbXwhdeWuQxpDJlvrwMCtJxeVn+dUGmww47bzqycwuZ6J2yFd+VRDKzo1RzwB7NkMbkB6KSzO61bqSa/xt5mcuK6EXfhZmJ+cF3CbKSR7Cye13CsZ8RbF35zIf/bpWANRYI0EM4JTRFXU+S0nVlKgIBAQ1x1pi8BA8thOXOBG8Dc6p2hF3wQNo45Z6Qro7ZUQjE9tBlaZ13fiMkaiIMmxHDqCDvvkeiXTT6ecNVYI9jNojZDUvQI/Auh/g9Bb/fiEKA/ITi8i+eA27FacL2HErFczukehd7WOTfwxjtALFGcwEJz+h9daVYrNnBetfiIM+5q0NTzozPrC4PfW25B2daL4/+jVpvNhpG0qqWujKqaqKfcGrFgfaA+kv9l/mH8n3bw1Fp1cQ2/RrVT45hjJhodYo53W3KOc6awDCMdSSTLVfrY4rc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR21MB3113.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(376002)(396003)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(52536014)(4326008)(64756008)(8676002)(8936002)(53546011)(55016003)(6506007)(76116006)(110136005)(66946007)(316002)(66476007)(54906003)(66556008)(41300700001)(66446008)(5660300002)(71200400001)(7416002)(8990500004)(38070700005)(82960400001)(86362001)(82950400001)(7696005)(10290500003)(33656002)(478600001)(9686003)(2906002)(122000001)(38100700002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFdVOHVYWThiNE1CelVsZEtZU0VrdDV1ZHhVMjUrcm93Mnl0dnNNRnBsN0l2?=
 =?utf-8?B?bXlJd0cvNFVOTWttTm55L09ST0JZY2lydXlnbEx2eUU1Ly9mNGRHZU1KZ1Fj?=
 =?utf-8?B?dkxMc0lHaTdGSTUrVkYvZXpPN3l3Sk42UlJvaS90aXNwdmpvZXJSZ2tCQ0Ns?=
 =?utf-8?B?UmdSMDlWM2Z0UldFNkk0bWlpS2ZQMC9vQTN2c0Q2anBhUmFNZGoyMTNuODRw?=
 =?utf-8?B?WVM4QnN2aVM4UGpkYWZZQlpCbVZzMkg5M1FJUk96enNDaWNNM2tvQ2lLZWE0?=
 =?utf-8?B?UllGME1PM2dnZnF1a1AxQUZtdDQyems2bmJOYmhrcGVtVzFuNWFKNjNYbXNX?=
 =?utf-8?B?Wm5Ec000Qm1uQ1FGMU9XWEdWQlNsWitsWm1BQkV5SlVISFB6aXlGNkFSWmFs?=
 =?utf-8?B?ODE5MzMyUzY2RjF4eTNOZlNXVExndzZOVVIwRUpYSlFjUGp6SGVyNUVZVjZq?=
 =?utf-8?B?NjhyY1dXekhMZnVPSW5ZY09WbW1yN3VqOHJKMWFMV0t0N3ZveHZtQit1ckNs?=
 =?utf-8?B?MXBKMmt2Z1JxcFM0ZHg4Wm5IemluN3pCdlFDbEF0ZUZVOVQwc3hqNUkyZ3dH?=
 =?utf-8?B?Zi9McmdRVGM4N3BaZzY4QzJzVyszTDZKT29NODlFMFozV2grTndLaGZqNVor?=
 =?utf-8?B?cDF0VGp4N1M2TmFqbHgwc1JDK3ZGM3hVK3BuTjJZNngvR1pzOGxkNVhBNmQw?=
 =?utf-8?B?L2JuTHJRb1hXSm8yTk5wTlE4dklnNHBGV21Gcy93bFdHMUowTWhKWFBPNmp6?=
 =?utf-8?B?bWd5UmJFNVpNY2JqYXBQaG5IVzNFaXpwc3ROdkZWbklkWlc4ck1aOUppUjJB?=
 =?utf-8?B?UVhVTjNZdS96Ym9EWXZwVExNOXp4TW9wWVh1Rk9tWTMvTG9UOUt3SmtPaTdr?=
 =?utf-8?B?WGlmUmdpRTdMblpjc0NuQ3dORk1tSUdRUVkyUGhURWlId3FQVWhFb0F3VWo4?=
 =?utf-8?B?SktObHgrSXpzVE1PQzRFelRhbkVyUlU2NHFXbSsyYzdJNTJ6aGVVRHBRa2pZ?=
 =?utf-8?B?YUsvUzY0Rzd3c1RJS2ZIZTZva0ExbjRTa1dxeTlYWFVCUXFXaHR5dENaTjZY?=
 =?utf-8?B?SHo4OVp4akZDL3Z6SVM1YVZHUEJFV2JpbjlDSXJJMkZwOFgva0h2eGlEOGRX?=
 =?utf-8?B?NHBDRzBKTitVeDRvT2p0QlViVE0weFMvZTNCQkJ2ZFkrMW5SK2Fpb0graW01?=
 =?utf-8?B?Nlh0aWswYzA5eWcwYlpWWDZFcFpUS0hOMWNOYXBVMVVqTW1rSTVHM2ZGc2s1?=
 =?utf-8?B?U08vZVcrNWFRLzZoOUlpd3pTdlNWWFZraHhMQXlLTWNON1NZSklmaHlhUEpn?=
 =?utf-8?B?Y3FPdXhPQjhHU2d1c04xbWt4aWRpY2pDSCt0MElzUkh4Y0wyWVNyUTdkZXBY?=
 =?utf-8?B?bkpoL3hJNUdvOWk2NmpkbGdzNE9FN25LcHE2eThnbU9CbTZQTGlFL0lGSlhj?=
 =?utf-8?B?UWlEK3pjSitPYXZsaTU5cUFhSkw2Z2ttcFVRMUhzZUI5Z05IM2lSemZMVWlS?=
 =?utf-8?B?VWZWdjR3RWh2anBxNEVLQTNpd2FYelN6ZXNNSkFnbmcvd0NBb3lkS0dwUHJn?=
 =?utf-8?B?V3JkeGhtSE5QbnJSY3ZKWStlZDljMit0d29Xbkl4b0tPTEVrREg4cHF4TW9V?=
 =?utf-8?B?SWs0cG9qcjNZRWpGaWFvbUljTnE4dktRTTBSaStRU3o4N1B1TkJidXpuS25m?=
 =?utf-8?B?RDJBWDR2NXUzTGR2NnBCV3AzK3R2b0RmWFVGZTFHOWI4eWJXNjVuQkpIR0My?=
 =?utf-8?B?SXFQSmdTbUxUdUVrYnZTSy9sSytrdlA4NXpiTVhwd0NaNmJGTXdMbHF6UWt2?=
 =?utf-8?B?aUNJakhDWW1Rc3d2WGIzQjZIb0hTaStNS2FlT0JhWkdYelJjME41OXIvQ0lv?=
 =?utf-8?B?NHdBWFg2YW8xalVFUXJhVWVJMk12QmZIdVVoMUQ1a25oNit0WDc4V1hEUVdM?=
 =?utf-8?B?SWtTVC9DNjV5V0EyWFU4Q2lQUVZFWlMyZmpraE1uaUV5NXdvV2RRVXVWOGJP?=
 =?utf-8?B?SUM3RFZNNzFaZTcyNUxqd01RUmNNYSs5bTJFSC90T3VBaHJJbGh0RjhmdGVI?=
 =?utf-8?B?RFpQUU1ObmhFQlUzRnI5L1RxMVdLMHo1eXhZVXczRjJKc2N3R2lWdGhYd01p?=
 =?utf-8?B?SklYNzVBZGRMK0ZsR0d1bDdJczlFNWlza0Rxc3ZSMExtcXBRYTVPampqdlFm?=
 =?utf-8?Q?UsZm5PHNNlT0JYMwKa6huZA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR21MB3113.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b64eab5-31c6-473a-9824-08dbc04e8365
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2023 18:12:44.7054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lw79YW6vCosqMKsYcRyuMiL5CrlPJnV/lpnvE2v/9KWPiYEG5ovbQPHoLYB5Nkly8A6NpoJqcNzXocjfyeZrnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR21MB1462
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZlIEhhbnNlbiA8
ZGF2ZS5oYW5zZW5AaW50ZWwuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDI4LCAy
MDIzIDEwOjM4IEFNDQo+IFRvOiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT47
IFN0YW5pc2xhdiBLaW5zYnVyc2tpaQ0KPiA8c2tpbnNidXJza2lpQGxpbnV4Lm1pY3Jvc29mdC5j
b20+OyBCYW9xdWFuIEhlIDxiaGVAcmVkaGF0LmNvbT4NCj4gQ2M6IHRnbHhAbGludXRyb25peC5k
ZTsgbWluZ29AcmVkaGF0LmNvbTsgYnBAYWxpZW44LmRlOw0KPiBkYXZlLmhhbnNlbkBsaW51eC5p
bnRlbC5jb207IHg4NkBrZXJuZWwub3JnOyBocGFAenl0b3IuY29tOw0KPiBlYmllZGVybUB4bWlz
c2lvbi5jb207IGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc7DQo+IHN0YW5pc2xhdi5raW5zYnVy
c2tpaUBnbWFpbC5jb207IGNvcmJldEBsd24ubmV0OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsga2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtbW1Aa3ZhY2sub3JnOyBL
WQ0KPiBTcmluaXZhc2FuIDxreXNAbWljcm9zb2Z0LmNvbT47IGpnb3dhbnNAYW1hem9uLmNvbTsg
d2VpLmxpdUBrZXJuZWwub3JnOw0KPiBhcm5kQGFybmRiLmRlOyBncmVna2hAbGludXhmb3VuZGF0
aW9uLm9yZzsgZ3JhZkBhbWF6b24uZGU7DQo+IHBib256aW5pQHJlZGhhdC5jb20NCj4gU3ViamVj
dDogW0VYVEVSTkFMXSBSZTogW1JGQyBQQVRDSCB2MiAwLzddIEludHJvZHVjZSBwZXJzaXN0ZW50
IG1lbW9yeSBwb29sDQo+IA0KPiBPbiA5LzI4LzIzIDEwOjM1LCBEYXZpZCBIaWxkZW5icmFuZCB3
cm90ZToNCj4gPiBPbiAyOC4wOS4yMyAxNToyMiwgRGF2ZSBIYW5zZW4gd3JvdGU6DQo+ID4+IE9u
IDkvMjcvMjMgMDk6MTMsIFN0YW5pc2xhdiBLaW5zYnVyc2tpaSB3cm90ZToNCj4gPj4+IE9uY2Ug
ZGVwb3NpdGVkLCB0aGVzZSBwYWdlcyBjYW4ndCBiZSBhY2Nlc3NlZCBieSBMaW51eCBhbnltb3Jl
IGFuZA0KPiA+Pj4gdGh1cyBtdXN0IGJlIHByZXNlcnZlZCBpbiAidXNlZCIgc3RhdGUgYWNyb3Nz
IGtleGVjLCBhcyBoeXBlcnZpc29yDQo+ID4+PiBzdGF0ZSBpcyB1bndhcmUgb2Yga2V4ZWMuDQo+
ID4+DQo+ID4+IElmIExpbnV4IGNhbid0IGFjY2VzcyB0aGVtLCB0aGV5J3JlIG5vdCBSQU0gYW55
IG1vcmUuwqAgSSdkIG11Y2gNCj4gPj4gcmF0aGVyIHJlbW92ZSB0aGVtIGZyb20gdGhlIG1lbW9y
eSBtYXAgYW5kIG1vdmUgb24gd2l0aCBsaWZlIHJhdGhlcg0KPiA+PiB0aGFuIGltcGxlbWVudCBh
IGJ1bmNoIG9mIG5ldyBBQkkgdGhhdCdzIGdvdCB0byBiZSBoYW5kZWQgYWNyb3NzIGtlcm5lbHMu
DQo+ID4NCj4gPiBUaGUgbW90aXZhdGlvbiBvZiBoYW5kbGluZyBrZXhlYyAoZmFzdGVyPykgaW4g
YSBoeXBlci12IGRvbWFpbiBkb2Vzbid0DQo+ID4gc291bmQgcGFydGljdWxhcmx5IGNvbXBlbGxp
bmcgZ290IG1lIGZvciBzdWNoIGZlYXR1cmVzLiBJZiB5b3UNCj4gPiBpbmZsYXRlZCBtZW1vcnks
IGp1c3QgZG9uJ3QgYWxsb3cgdG8ga2V4ZWMuIEl0J3MgYmVlbiBicm9rZW4gZm9yIHllYXJzIElJ
VUMuDQo+IA0KPiBUaGF0J3MgYSBnb29kIHBvaW50LiAgV2hhdCBwcmV2ZW50cyBkZWZsYXRpbmcg
YmVmb3JlIGtleGVjPw0KDQoNClRoZSBndWVzdCBoYXMgcmV0dXJuZWQgdGhlIG1lbW9yeSB0byB0
aGUgaG9zdCBhcyBwYXJ0IG9mIGluZmxhdGluZyB0aGUgYmFsbG9vbiBhbmQgc28sDQp0aGlzIG1l
bW9yeSBoYXMgdG8gYmUgcmV0dXJuZWQgYnkgdGhlIGhvc3QgYmVmb3JlIHlvdSBjYW4gZGVmbGF0
ZS4gVGhlIGJlc3Qgb3B0aW9uDQppcyB0byBub3Qga2V4ZWMgd2hlbiB0aGUgbWVtb3J5IGhhcyBi
ZWVuIHJldHVybmVkIHRvIHRoZSBob3N0Lg0KDQpSZWdhcmRzLA0KDQpLLiBZDQo=

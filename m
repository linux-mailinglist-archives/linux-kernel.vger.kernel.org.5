Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A367DBD2F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 16:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbjJ3P6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 11:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbjJ3P6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 11:58:50 -0400
Received: from DM4PR02CU001.outbound.protection.outlook.com (mail-centralusazon11012004.outbound.protection.outlook.com [52.101.63.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB66EDA
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 08:58:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xwujvhx6kkPusj2bQT1M4tT5TjdqLkA2rBojqAC2KilSB8HYil5SHyIANBeNdoIZ7hjoIT5oW9KSqj5A3M2kfSkF0qvYrHwZGdIU58xVMeMTLdYBbRHUD8ILpRiIAjWnUHZMZTwnvw+rJUOhCQt4/J0ywP9L1RsiX7uxclacAV4c19sCF5Rab+fMx8faSUMYmQyDNHug+kZPWKlfeeIm1qkPIqSoWwg3bbNGieJxe9OuUEbHRWYoazI4A8yVQQRH/AbRED2XrRcvSuUO5CeoSlQIVhCuJXBDZa30H6sc2gx/28730bqWZ7/hVgMn99uBR6I8bjlR08S5Cgy/EAV4rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sv9BnbclOW8tIPcf1lnDudHGr2EOuFKuq5WFNkZfccI=;
 b=LFheezU5LP734j4KznsykU+w2ciq723SIrFIoABBMOdxufKCA5fD4iBu6HAERo88rBsorC0NJ6rrecVLUxurgh97/v4D1hYQXM+OMPhCch7A1NVnxTRotByb9cKREqt9bxUI1cE1rPnO60d9+vzmbUDn9dGGjyKj4950pNA5xUM7Hn3zvv9IZubMOommFi+QzB7HndXlkWiThZLGgIC28ZK7fh0JXihR/wmQvZSKnqYvATJETe3aI3qUydAv/DLIVKKMUKmWPPWs/F3d1bz/s8iIlJfszebt7mzDPYNFzAP/xAzYfg+BQEqZdPasxfGzi8NEO21jce395aJOA+GVDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sv9BnbclOW8tIPcf1lnDudHGr2EOuFKuq5WFNkZfccI=;
 b=VrxK1jnJq8LTYaEIPQAFyMztLGZT9BF4kssMiOjLNJ3peQS7kcWJUxHkYK9iyJ6Jv0E4kEZEOHJ9KUhkGX+lD5p+g829E89vVL36ZpAMLNFttkKQw4igpxI+PsMptzmwxRFwYwtZMy1Jkbtesr84N/ZwdPldOXQm9UZoINcoWwY=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by CH3PR05MB10316.namprd05.prod.outlook.com (2603:10b6:610:1a7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Mon, 30 Oct
 2023 15:58:44 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::b668:aef3:606e:923f]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::b668:aef3:606e:923f%4]) with mapi id 15.20.6933.028; Mon, 30 Oct 2023
 15:58:44 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Byungchul Park <byungchul@sk.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "kernel_team@skhynix.com" <kernel_team@skhynix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "xhao@linux.alibaba.com" <xhao@linux.alibaba.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "hughd@google.com" <hughd@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "david@redhat.com" <david@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [v3 2/3] mm: Defer TLB flush by keeping both src and dst folios
 at migration
Thread-Topic: [v3 2/3] mm: Defer TLB flush by keeping both src and dst folios
 at migration
Thread-Index: AQHaCwJWAIN/MoWKfkqwslHpJdh5ILBiSanQgAA0MIA=
Date:   Mon, 30 Oct 2023 15:58:44 +0000
Message-ID: <0138328C-74D5-471E-A2CC-7675CA692F42@vmware.com>
References: <20231030072540.38631-1-byungchul@sk.com>
 <20231030072540.38631-3-byungchul@sk.com>
 <63C530D3-3A1D-4BE9-8AA7-EFF5B895BE80@vmware.com>
 <20231030125129.GD81877@system.software.com>
In-Reply-To: <20231030125129.GD81877@system.software.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|CH3PR05MB10316:EE_
x-ms-office365-filtering-correlation-id: aeed0348-91f3-4f71-6d3d-08dbd9611845
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cKFJ5T23Zhx6loyyNr6Q/of4Y7vw6QeKJV4XMXwNAsIwKB1Ukzo9ULdKUfQUGzFw5Aud6TCxW1s5ygwLf6ToA5OoSpnqQF/c8THPmZIuR1fPHB1HWFHHVF30Q/1HEQCutLxSKvLsGbRoBy9o60SoCdmqkUWGzBmid3E0lAAGhKl3eT1Edwyz8PjAEyZgTudcJn05koEFO63DptJHlNg6ziGRohkM5sx+wEgOF73iTRmB76Lnz+W++yYnyFjycQi9ddTbTVXyRXHXxZ0e9XQdSsV51VA+uDGHp9X1EKOt/VNANScldVpxbD4mXPPFk6udbqFWoIGft9nmF58NxgzyWygIVIUXJF8Nm5qkZUpWOPDKt2ODVxwnkz37GHt5ag4jjDwGaHfBG/93Kj3za5DqCAy5EoFTEjisUVj/RRmXdCgPlVeo5LvZcip9iEGkiCMArO5NiZOft1WC/cHh8rYpPabZFMHfxfKXyvVmQw1yJs6laZxsXu+3cG/AV9SnyA2sT12C6dWyQS9Z0CNfNgA3tQv1wYYPQAcetzfJ8Dky2vJ2JAAQV/KCTr4F2v5z0hx/C0gS+PUxN3aQ7QW7Lb7EH4Q3KOrKWOkcYh6Ff15otsEXDPTxpWy07E6VdpqQvUJNUE6KErHkmgl4JWYPU3rRYIsS3XFFQzEiZNtNPpESDb76uLiDtFfPvD4zdXlmD3xiIFAECYMp4wimuiI1Vc+3HA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(366004)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(26005)(2616005)(122000001)(6512007)(38070700009)(2906002)(4744005)(86362001)(38100700002)(53546011)(478600001)(6486002)(36756003)(71200400001)(6506007)(66946007)(6916009)(66476007)(66556008)(54906003)(64756008)(66446008)(76116006)(316002)(4326008)(8936002)(8676002)(91956017)(7416002)(41300700001)(5660300002)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmdYMFo2UFJTUkNwVGVxL0JwazBROG9ObDQ2Vk1ocG1ZY0RGT1FRQ1NvMVZp?=
 =?utf-8?B?cEc3eEJNaHVzRy9VMFNUSVpBY1FKQTJhVnZuMC9vTWpRQU9xTWFGdFpDSlRo?=
 =?utf-8?B?K09CckN6Tis0NXFaSHpDRk5sOGZUWmorWm5ybHhCQ2VOM2lmb3lVaGxDSlNt?=
 =?utf-8?B?UHVocmQrTVplL0d2Y1RlQ0VNS0I3NjZROEZqc2lML0lMQUorY1pSYTN2SUs0?=
 =?utf-8?B?TEJhQU8wZmtoT2JERWFYSks3aHI2eFlaY0lKanl5MExoZTBVUU15WjA3ck5Z?=
 =?utf-8?B?QVdOTk1ObklYbW9uQXUwRi9aR1RsR0FTU2hMMHNsaUh0YWZiOTU2ekpWcldG?=
 =?utf-8?B?Q1FPWGpTWENPRTgwSk1JR0x1bFNmMmJzUjl4S29VYWg4UXVQVjdKSnZkVE9W?=
 =?utf-8?B?Vi8vZjRxOXE2YWZSVkdzdEhBZ2ZEdDc3TGVwSXJLVVdEbG5yZFZIRWlqOVBC?=
 =?utf-8?B?UVhVY250Um00eTN3NUEyTjBoT2RUNW42Ty9rTVpYYUY0SkIyY2hHd1JEQTE2?=
 =?utf-8?B?OE5mcmVKeUMxdEZsSnpYQUVrTUJFR3JRYWRyREw1bWFEL1lCMUJhcE9VTzNM?=
 =?utf-8?B?bVQvbGlPWHJiTVZIWHRtanAwVTZRZy9ORGR0dnVRK21CZngrM09LZkhXa2U4?=
 =?utf-8?B?YUNsVk8zdDVmZVRsYlZIMkp3VFZ5UjFsU2tUREhwOXEzUEpIK2NWbkJyajlq?=
 =?utf-8?B?MGV6T1dJY2w4bG9Pdm4xSUxQUWhLVUkzdzZ3Zm5LdUFnMjdBVGI3R2lxY3NP?=
 =?utf-8?B?WWc4VGROazkrZkRvUmRsZFY0TUFEVTVRek8vcGZ4cHBnbk5XZjUyWmJMOTBW?=
 =?utf-8?B?Z1RJZDNsSkpIQTRFTmdYOWZLNjFuRGxxTXVoTTBsWE01a2JCcHMzTXROZTNP?=
 =?utf-8?B?Z2RrVjl1RzZ4WDU5b1NDU1F4S3NXMXEvRSs5SDlXN1BXdHI3RWE4Rm5OdWMr?=
 =?utf-8?B?Rkl5R2gybEFaUWQrNytxWHQvVFRiUFl1UUVncmpnWjdVOTh1MlptRkUxSnpK?=
 =?utf-8?B?Sm5zZTduQjJUSTU5UzJOWHFJaTQ1VGhaMjNCdmdoSklxVGl0QUxNN0RwWUV3?=
 =?utf-8?B?T2tqYmRyRHMxczhXTWhVMlBLNWtmRFo1WS9zc0dtNGJURDRVVVFiR1AxU00x?=
 =?utf-8?B?OXlLeG4yQUhrelErN3U4SnZNM2Nrd1FFTVlDajErbUVDdC82cmlKL3lPMUkr?=
 =?utf-8?B?WC9uaEh0UWp2T3V1K1cwUFc4cGtBY0l4QmNqR3NhS3BubHpUQllWUm1Qamdv?=
 =?utf-8?B?UitvekZsRXFpMlJqK0NtUGZRNUcyV1dOeFZkM3B3TXZ6OUNtcEY3TVdFdGhX?=
 =?utf-8?B?YUx3anhDd3JaOHVDYVZUQVNzeTlvdnJndFEyMXZ6K3VKZGtFQU5zY0FWL3JU?=
 =?utf-8?B?eWZnSkpOdnFQaitzWFp1STc4MGt1N3RTaHpuek1nTzBwMHBReDJQYzRhOVJl?=
 =?utf-8?B?UlFpNlRpSGxKSkpLTjlMUHQ2MkJCZ0g0bTRneEpEbXRSdk1DRG5QaTFkSGh0?=
 =?utf-8?B?MXQ5NXJkVXQrYTN2OUxPeFZzZlBQOG85VFkwaTVvSWlkUis2QnRFbGliZ0Rt?=
 =?utf-8?B?eCtjbzA4SWoxMDRtb1hRSFJ5MVkybW1YYTBvZXZvcDRyUW5oc3VmY3ZEQ2ky?=
 =?utf-8?B?bXVScGxnVThrOFZNdnpjN0d6NmNMaVMrK0h2TnJzbEFSU2ZDeWZGd1RUWkZK?=
 =?utf-8?B?Tzh4K1BqTTZ6WFk5cm1YMEVnUzY5NmR4UTJpY2NRYjdId3kxRCtUZXRQTVM1?=
 =?utf-8?B?M1JuSVhKRjRzREs5YW14eGkvUnZXR0hJaXMvZ1drUGxhUzdzOXM1RW9MOTZv?=
 =?utf-8?B?dDlZTXFWUnlqdExLTUk3Y2paNHRRWmFHRm1VRkJhV09vMDJBa2tTSmYyZjYz?=
 =?utf-8?B?SW03S2luamZwdlNoY0Y4ODVFbkZYT3hCNC80T1VoTGNJT0dBQkRwbG15NE9m?=
 =?utf-8?B?SzREL2hoMHJRM2xTTjI3eUt4cjZwOVJxTHIxOUxnaVd2R3JrVEg0VXQzYUtR?=
 =?utf-8?B?cDRaK1FIS2VCcmF3MHpZaXlEQ1AzSXJQcDF5R3hiQ0c1bHN2RGNmL3o5dWJX?=
 =?utf-8?B?Y2RhTytubzdCaWU4Y2pXalFvcFVTQ1hSOHMvbU5NMStNQXVYS0ZDTmEwcjhD?=
 =?utf-8?Q?H/+WUvf4Cut1ISu4k4muTFzqs?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F90C1781A951F24292E3FF7A466243D9@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeed0348-91f3-4f71-6d3d-08dbd9611845
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 15:58:44.5289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4/VFI21oKmW+IJfvzWb4RHFIIN0LrlI2LF7hAXYIZbweHsFNOG7XTcJSjcxqE1vY1thICeS8jHrmR7CyHCFd5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR05MB10316
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gT2N0IDMwLCAyMDIzLCBhdCAyOjUxIFBNLCBCeXVuZ2NodWwgUGFyayA8Ynl1bmdj
aHVsQHNrLmNvbT4gd3JvdGU6DQo+IA0KPiBJIHJlYWxseSBzcGVudCBhIGxvdCBvZiB0aW1lIGhl
c2l0YXRpbmcgd2hldGhlciBzcGxpdHRpbmcgaXQgb3Igbm90Lg0KPiBIb3dldmVyLCB0aGUgdGVz
dCByZXN1bHQgY2Fubm90IGJlIHN0YWJsZSB3aXRob3V0IHRob3NlLiBJJ20gc3RpbGwNCj4gY29u
ZnVzZWQuIEkgdGhpbmsgdGhlIHRlc3QgcmVzdWx0IHNob3VsZCBiZSBzdGFibGUgYXQgZWFjaCBj
b21taXQsDQo+IHJpZ2h0Pw0KDQpPZiBjb3Vyc2UuIFlvdSBjYW4gZXh0cmFjdCB0aGUgb3B0aW1p
emF0aW9uIHdlIG1lbnRpb25lZCwgYW5kIHBlcmhhcHMNCmhhdmUgbW9yZSBwcmVwYXJhdG9yeSBw
YXRjaGVzLg0KDQpKdXN0IGEgY291cGxlIG9mIGNvbW1lbnRzIHRoYXQgbWF5IGFsc28gaGVscCBi
cmVha2luZyB0aGUgcGF0Y2hlczoNCg0KMS4gVGhlIOKAnHN0b3BwaW5n4oCdIGxvZ2ljIGlzIGEg
Yml0IG5vdCBncmVhdC4gVHJ5IHRvIHNlZSBpZiB5b3UgY2FuDQpzb21laG93IHVzZSBzaHJpbmtl
ciBvciBPT00gaW5mcmFzdHJ1Y3R1cmUgaW5zdGVhZC4NCg0KMi4gUmVnYXJkaW5nIOKAnG92ZXJm
bG93c+KAnSwgaXTigJlzIG5vdCBhbHdheXMgYSBxdWVzdGlvbiBvZiB3aGV0aGVyIGFuDQpvdmVy
ZmxvdyB3b3VsZCBoYXBwZW4gbmF0dXJhbGx5LCBidXQgd2hldGhlciBhIG1hbGljaW91cyBwcm9j
ZXNzIGNhbg0KdHJpZ2dlciBpdC4NCg0KUmVnYXJkcywNCk5hZGF2DQoNCg==

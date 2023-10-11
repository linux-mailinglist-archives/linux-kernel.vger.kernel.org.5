Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2237C4C25
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344944AbjJKHmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjJKHmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:42:01 -0400
Received: from BL0PR02CU006.outbound.protection.outlook.com (mail-eastusazon11010000.outbound.protection.outlook.com [52.101.51.0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5202B9B
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:42:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FK21CA/C4pMs/Yfp1taZV6HDzhzyqH23Dyrbf9hAQvIHWt6dHiq4pMTguryk9cztMw9stCIA6YBsEAjA0rMCZ4Q/eTKhG9JjZUGOHwwb/fGaONh1PrnRTsiDMOViIogjbYE+KKxyBkXw2kDa5ZvRIylwoy1tNqwugm0TWoc9v/0O5AduqhJlGA8GiDuSR+kcM3BMWAV0lYYU2p+IrUBcEFOFBXfA/xH5TIIy+laJtxy56JSEjGv+dnUNhsTxZIE0DEy55JJ80ZbRB2rGUvv+M17AWiQHECvhtJIyz1L8RMBxEPDua2XKmYlLP5pdJlZLah/1qIHOzjWYYF216RJ3Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6eAvGAAhoJJMf/QZCjruhZUu+5GFfM3SJmlST9lkUVc=;
 b=MIKXPOIWVvOe6Rt2NS9ea/U7xQYjIKqFYUSE+ZfdXU9LdhmWxwK2HEjgn5x0nhRa5kzTX+gxwqOURJapkr/exwqL/gRYIrVZqt10dcQ6f0iAr+EaE3NoU7sYk0DXHzDBvmshs+ajoOch9HUp8dgN2XoOY7PvvWfbkGh6J6BKv4wBTc3FqpGI4Q0alK8EY+j9xTGDd6zD/xdR6vZFM1PzzquzhIOEVcXU/wsVjH+eobl/kPwiR1j2Zd97oMfE1GT4kJM4DpjM+Rtypn2MnoK7s+3h0YC6J2kYFLu2cBqKWTap6j7TCcbNa3IY87dahe86al8WMM/1it4fDVTMW1hwKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6eAvGAAhoJJMf/QZCjruhZUu+5GFfM3SJmlST9lkUVc=;
 b=rHhVqE+2+ttpCwuWodi2TOQCdvX6BADGqP9lyAjHGwbYfcNwEPx0LGWE2PcglNPERIOARsCxFcF3O5IVWNwe4YcItdcdL6T0hGI9wbaawp6iTtuqyCRYjxvAP5/ARNhVsc6ynLr3SwlOgrdufd+Q0aj5HimZk1OqFGT35T+Zm6k=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by DS7PR05MB7432.namprd05.prod.outlook.com (2603:10b6:5:2d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.42; Wed, 11 Oct
 2023 07:41:58 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e6fb:726:9aa2:fa13]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e6fb:726:9aa2:fa13%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 07:41:58 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Uros Bizjak <ubizjak@gmail.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
Thread-Topic: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
Thread-Index: AQHZ+5jZGZywpkB5zE2yxvhqDFo/FrBDSECAgAAOE4CAAAQxgIAA2xCA
Date:   Wed, 11 Oct 2023 07:41:57 +0000
Message-ID: <F48A9D34-3627-4372-B555-B58CBFC3F241@vmware.com>
References: <20231010164234.140750-1-ubizjak@gmail.com>
 <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
In-Reply-To: <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|DS7PR05MB7432:EE_
x-ms-office365-filtering-correlation-id: b4161323-617a-43e0-16eb-08dbca2d8c67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bcdCCej/dEktRxm52A9/S/VjliakxzzLJhYnppN4j0loBgLIDtYCt3aWFqMdxdaKbSiHJ9apOtxNmJ6HhqY5P4z9xTpgk24EkVWooZd1lAN6TrKEotc3Dagih10gMEnL5h42DHN5If3HN72B0VRk4jCbejR8mnfuzL5PA0FO1NYgTw5uLyF0pqPqlLqeHYEuvoYEJMqAJevdm0mlUT89ooixWiUvCDG19en5r3lowsVf5jCqkOwOVk6UvdqE+Akfo2kyaO96af7ewOs2s7aVtL8vlm4vDCDGH8/jxtmWeXYDpwDWKORin2mKBaUCSl8j+RBDFg0vc6VozH9I8DOGrL625teUy/SNrQWvbr6KwjXSyG95JAr3Wpt73U4tpfbcy6PnLQOaeO3+4OlXaV9RIBPfm7O71Kz7J8fC8dY6dVdVQEqZlF4XqfYNm/qHRtSN+kFcuVuh57nhNHu9ZjMy9EFKVe6ht0xofQUbe/1n6ri4rD1O5mJ4K/Q/rC8cJPBrQXRhP2H+vYxP5rh0LkiySnkeWV0susswNv+79zNQGDGA9KWfqp25XOK70WxvNpuihb/Syg1ty1Y6XKMzGgerPm2F3jfmiAVBY53y/h6iOLON8jSYtnZxuWDP1i93kqe60tO5eVMOOlNW/q9ecKGtveOvTt0nsLJYn9nduSw8BdMKGwRIFCnPCL4TW+uSGyAIOy/R9aJlhdoGx9KtRBUyMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(39860400002)(136003)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6512007)(26005)(6506007)(53546011)(2616005)(71200400001)(6486002)(478600001)(8936002)(8676002)(36756003)(38100700002)(5660300002)(4326008)(41300700001)(4744005)(38070700005)(122000001)(2906002)(86362001)(33656002)(66476007)(66446008)(64756008)(54906003)(66556008)(7416002)(66946007)(91956017)(6916009)(76116006)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVJRRG5vdjg4SlRUS2poc2ZBeE9RVFJxSGFwVmtURjhZbytkQlE0cGoxWGMv?=
 =?utf-8?B?UXJjcy9GQ3dwSXZ0RUo3L1J4b0FxYThrdGFRQy9ZTmZ0Q0ZuZjRBRjlNM01M?=
 =?utf-8?B?dlFjd3R5SXExaFBUdjU1QlkzTFhvckdXZ1dpRkRuSk5JaEg1L2NONFN2aTJK?=
 =?utf-8?B?SUVqekd4N1BYNXhJS1BPdkxaVUxOZXRFRkJRNG9MYmRlUEp5ZzJnUEVrMHNt?=
 =?utf-8?B?YzdtTHVhdVZRVHpBRUxxc2tCQmN5eGZ0NVBmZ1N3cFkvVm1udFZQczZDL29U?=
 =?utf-8?B?RjFvMW85OUFtWkZ4bS9tOUhnS1BQc3RQUXo0MnAzT2JwTy95TTI3ektWOWZt?=
 =?utf-8?B?cUdiMy9IYmRXa0VTMUdqQUMwNGpXV1l2VmRRMGxwZVhyS0Q2NUtIelhKR2Ey?=
 =?utf-8?B?VkxuTE9oTUkxQ1dXR1g5R2wxTzZkak1sV3Q2aTZHMXUzWHhZWjNCeVdnRXRr?=
 =?utf-8?B?T0xrZFR5UzZJeE1Ea2NqUXpIWlBjcG1na2NHMlhWeXpJWWhBQXpJOGNiQURJ?=
 =?utf-8?B?ZGtZa01FVXJ4YlhqSGVmSWdqTmRTSThrR2NBdFBZN2k4Z1lXbmVadE1WVW5y?=
 =?utf-8?B?eDZsTmgzdlZLMFJENElLNC8zS3dNVEFSYXU5VTNRR2t1QWtYOENNMVVEMXJK?=
 =?utf-8?B?VVVtSTNaTExUSWJwVW12MUxPckhLRVBpVnF0V1NlZ3kvU0hzcDdOdklVaWpV?=
 =?utf-8?B?bTZKVVNtMndrRktITEVyZnpoa0l4ZlljTFpVMWVzMEpkUmxqeUlzKzczMnNH?=
 =?utf-8?B?YTVTQ0ZlYWhtV2ZQRjU3K3ByMmJtOWtxM2ZCbWxEaDVOUytlek8xSmVMNU91?=
 =?utf-8?B?MUpHNzBtbWN1eUt1Kzc4cnhUV2FLSE1DWVEwRC9OUmlPcVJoNWJsNXpIek5j?=
 =?utf-8?B?Z0FDbmc0WDJ2TllWQThMdUswenpVTkVkT1FjK25VcWJoMS9DRUVUeTMxSnRj?=
 =?utf-8?B?YlNQU1hPRlJDTUIrRDF5cUdLNThlcUNtcWlkcHdNdTEvVEtuWkU1Y1BWZ0Vl?=
 =?utf-8?B?MDZhdncrY1UvNW00d05LTURESlFUcTNVMnlFdmw0SmRXUW4ydFNKUExDUVBQ?=
 =?utf-8?B?YzlMdHdMRjVJbUJNZU56WkRMQklHbi9TVVFvQVVGOVVQbzJ1M3d5UVZQOGRh?=
 =?utf-8?B?VlRuSzU1eSt5REl5eUVwOGEvS2YzcnVvU0lhMWlhaHVJR1BFc3BldTh4Smlp?=
 =?utf-8?B?ZFhkbGsveHRrUHU1V2ZHUUlab0tTN3k1SGtJemFWM1hOd1F4VDV6NkpFSWl1?=
 =?utf-8?B?OThvRlFiTjVHU2x2bHpJdTFZUGdNeXYwOGZ2bzRsdytiQ1ZDd0g4RzdONGxh?=
 =?utf-8?B?V1lINTNadElBWUZVRGl0ZWV2K0dQNGZETDF2Rlo5YjhTblMwUmtyVDlGSE9p?=
 =?utf-8?B?cGZ2b2VheUR1UWJ3eVhuQkh1eCt0eDZVS2xkOXkwaFBvcWxXMUJCU0FKNVk4?=
 =?utf-8?B?YWVMTDUwOGF3MWQzWjBvM0RtQ1JCKzhhUE1YcDNnYzhYRVVaN0VLRzluMXpZ?=
 =?utf-8?B?dzlxZnpBSXJVSWFIS1FoT01zWlNXNmVyZ3ZHRWppK3o1dEQxazdzZERtcmZu?=
 =?utf-8?B?ZnZEaERDQkoyWkZhOTl4VDZzTXh5bk5lYUlzaU1XMnA5MTVRQXhQeVI1SFUx?=
 =?utf-8?B?T2FNOGEzOEkxQlJvL3IwQ0ZkS3F0aStWQ0ZMam9mNlhTZCtJZFgwdnJtUDFO?=
 =?utf-8?B?YVl6US9xT3BDY1hRVmx3cmNzRzBQYXpuWExwZWFibHhER29Sbml4Z0hmV2dO?=
 =?utf-8?B?U0o0aEJxS0xTWnFxbjlNT2RrT3lmMTNsdzU1ZFZBUkIxNFJOV09lbkVMa0Y3?=
 =?utf-8?B?cmlNSnBkcU10QncrYUg3WVdYUVUyVUNyMTdRalp1L0l5c292bmtJcEZ4MXM3?=
 =?utf-8?B?MFlHMjhXMVkxcFRJSTNFd05mejBDQkJuOU9hNEF1eVZNa01pQU1teiswRzZx?=
 =?utf-8?B?MENLdUpzR1UrVUNlMlp2SGhKa1labHQ3TzNzZGFZVEg3ZjRENElDVzJuL1A1?=
 =?utf-8?B?T1RSRlpuVHkwb0tUOG5LYkJvZDRaMnYySnpYeXh6TTdMMkxpSG1wOGRINkY3?=
 =?utf-8?B?OXlmdUU2ZDltOEZTRHNFTm5tM2REMG40ZnQ4NFVjVzBFckRiMWFsUm02Tm5i?=
 =?utf-8?Q?dFLlLqKKBgTsdIBk8oRI8fsSI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9DA6B14D4C9AA4CA41916160DCBCDC3@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4161323-617a-43e0-16eb-08dbca2d8c67
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 07:41:58.0642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ag0Uf5GR6H8GWT5t93MUqyY8bbDaA902Vm0qbPzQoQDT5PN73nAts+8Q3xxDbognu0mm5leVtf2WzZE31Qw4Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR05MB7432
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gT2N0IDEwLCAyMDIzLCBhdCA5OjM3IFBNLCBMaW51cyBUb3J2YWxkcyA8dG9ydmFs
ZHNAbGludXgtZm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPiANCj4gISEgRXh0ZXJuYWwgRW1haWwN
Cj4gDQo+IE9uIFR1ZSwgMTAgT2N0IDIwMjMgYXQgMTE6MjIsIFVyb3MgQml6amFrIDx1Yml6amFr
QGdtYWlsLmNvbT4gd3JvdGU6DQo+PiANCj4+IFBsZWFzZSBub3RlIHRoYXQgYmVzaWRlcyBwcm9w
YWdhdGlvbiBvZiB0aGUgYWRkaXRpb24gaW50byBhZGRyZXNzLCB0aGUNCj4+IHBhdGNoIGFsc28g
ZXhwb3NlcyBtZW1vcnkgbG9hZCB0byB0aGUgY29tcGlsZXIsIHdpdGggdGhlIGFudGljaXBhdGlv
bg0KPj4gdGhhdCB0aGUgY29tcGlsZXIgQ1NFcyB0aGUgbG9hZCBmcm9tIHRoaXNfY3B1X29mZiBm
cm9tIGV2ZW50dWFsDQo+PiBtdWx0aXBsZSBhZGRyZXNzZXMuIEZvciB0aGlzIHRvIHdvcmssIHdl
IGhhdmUgdG8gZ2V0IHJpZCBvZiB0aGUgYXNtcy4NCj4gDQo+IEkgYWN0dWFsbHkgY2hlY2tlZCB0
aGF0IHRoZSBpbmxpbmUgYXNtIGdldHMgY29tYmluZWQsIHRoZSBzYW1lIHdheSB0aGUNCj4gdGhp
c19jcHVfcmVhZF9zdGFibGUgY2FzZXMgZG8gKHdoaWNoIHdlIHVzZSBmb3IgJ2N1cnJlbnTigJkp
DQoNCllvdSBhcmUgY29ycmVjdC4gSGF2aW5nIHNhaWQgdGhhdCwgZm9yIOKAnGN1cnJlbnQiIHdl
IG1heSBiZSBhYmxlIHRvIGRvIHNvbWV0aGluZw0KYmV0dGVyLCBhcyByZWdhcmRsZXNzIHRvIHBy
ZWVtcHRpb24g4oCcY3VycmVudCIgcmVtYWlucyB0aGUgc2FtZSwgYW5kDQp0aGlzX2NwdV9yZWFk
X3N0YWJsZSgpIGRvZXMgbWlzcyBzb21lIG9wcG9ydHVuaXRpZXMgdG8gYXZvaWQgcmVsb2FkaW5n
IHRoZQ0KdmFsdWUgZnJvbSBtZW1vcnkuIEkgcHJvcG9zZWQgYSBzb2x1dGlvbiBiZWZvcmUsIGJ1
dCBJIGFtIG5vdCBzdXJlIGl0IHdvdWxkDQp3b3JrIHByb3Blcmx5IHdpdGggTFRPLiBJIGd1ZXNz
IFVyb3Mgd291bGQga25vdyBiZXR0ZXIuDQoNCg0K

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879C57BDC1C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346616AbjJIMde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346513AbjJIMdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:33:24 -0400
Received: from MW2PR02CU002.outbound.protection.outlook.com (mail-westus2azon11013008.outbound.protection.outlook.com [52.101.49.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789A513D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 05:21:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ml1/Kg8IYCzzjEcYgoxR1F3HLvn8Gnm/gAWrEtCVKrC5uIQ/wx+uPgFVPRJuifC3HVhR+UpXK98BtijlTrDlfjs8ppUkn5AXBwJT2EAH6L0tthlKK7CLZfCAI+nhKk3lWn1Hpibp8pVm0AB9fCXqgCmr9vRHLbOg85+WMNX9Ei8nI/63Pk56NuRt8zutNdPwcQXUVxLh9J9OJPF2+KPqwPOG8A8tBENwGAURMSnTPOx3PlstplTNyJSE7mVkIylwZsHVzRJmL1w0tK97RLeIzledxIWMO5oFWqF5vScziCJt4ICoSWiCY4OVh9by8WizOKP67XA444NRJlv0FF2TXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIOEFQ3XqhKP3X2CJ/QjncwY8q6Wac/VIMab4eT2rI8=;
 b=jSlV0rfpmHLIIk+fPuaWGq9tuai4ToLLnPZLI5o/LRZ/4nhA590/s20IoJUXAAPu4WhsM7i50Ktp3Mg/lf2Zj2VQFDiKIhL8EfWoyO+3jsxm4xhdOHPlavNh60FyGb3fDajEMm+CUBzX9GnHZt+ZevFMlR7dxLo7ohBLT/QimXI9L2zTWk3ux9/qmyusdhm1uZi5WgiRSY/VoWolEbTzOesEjk7EKkSYmvmrxJMayOFEqRsYvClMrDBXzfvHD3D7ITr8XOMz/SeIXqVYlo1pN1di14Re+y3RP8HVuJhNe9nvV7tkATrDx8VxC6EYuKuWvs3Mc6g+WiqLTRLstWmxqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIOEFQ3XqhKP3X2CJ/QjncwY8q6Wac/VIMab4eT2rI8=;
 b=Cu2i4udTQ0zzgefjQLmz4r25+fErIGM+BW7x3bNLW8BH7f3BtHEr7JcLNuttHXrBtUmECy2iUWq89E1yqFHXhNJsjGGtBf9VDkn1KzTSXnLoSgdf9jB2vHZELvIZB7qlGw0R3x7g2GvR3j4Yb9zRsjq9mlmFrHQGSnIxN9CKEws=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by SJ0PR05MB8678.namprd05.prod.outlook.com (2603:10b6:a03:38e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Mon, 9 Oct
 2023 12:21:34 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e6fb:726:9aa2:fa13]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e6fb:726:9aa2:fa13%6]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 12:21:34 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 4/4] x86/percpu: Use C for percpu read/write accessors
Thread-Topic: [PATCH 4/4] x86/percpu: Use C for percpu read/write accessors
Thread-Index: AQHZ9tJVBFQ4epXLdUKoG1JrhizpE7BANMmAgAAV0QCAAA+tAIAACY4AgAAO9oCAAOqmgIAAAuqAgAACeICAAAXDgA==
Date:   Mon, 9 Oct 2023 12:21:34 +0000
Message-ID: <EEA95C45-87E6-4033-AEB2-0EC109220074@vmware.com>
References: <20231004145137.86537-1-ubizjak@gmail.com>
 <20231004145137.86537-5-ubizjak@gmail.com>
 <CAHk-=wgepFm=jGodFQYPAaEvcBhR3-f_h1BLBYiVQsutCwCnUQ@mail.gmail.com>
 <CAFULd4YWjxoSTyCtMN0OzKgHtshMQOuMH1Z0n_OaWKVnUjy2iA@mail.gmail.com>
 <CAHk-=whq=+LNHmsde8LaF4pdvKxqKt5GxW+Tq+U35_aDcV0ADg@mail.gmail.com>
 <CAHk-=wi6U-O1wdPOESuCE6QO2OaPu0hEzaig0uDOU4L5CREhug@mail.gmail.com>
 <CAFULd4Z3C771u8Y==8h6hi=mhGmy=7RJRAEBGfNZ0SmynxF41g@mail.gmail.com>
 <ZSPm6Z/lTK1ZlO8m@gmail.com> <ZSPpW3zLTn7IohOJ@gmail.com>
 <CAFULd4bjnro3CFQLY=qR0S5M0WY3NkrVUW-JUk4nB4mV7xhWNg@mail.gmail.com>
In-Reply-To: <CAFULd4bjnro3CFQLY=qR0S5M0WY3NkrVUW-JUk4nB4mV7xhWNg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|SJ0PR05MB8678:EE_
x-ms-office365-filtering-correlation-id: d9a71faa-a7b3-466d-323d-08dbc8c2474f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6hmL7XidcTKZ0GF6lUtEyjf4G7bahH4VIZrsGX4XJxnC2QRbL9PW+/4AU2ucQNqN8QWz8o65yS/LHSqb7DZ+R7r1S5QHj1FiTLvTra1CzoGvzC2GIdaM0OX5it8OR+srJArdSfhuKRdxvScFRFj6dnbigavvdYczFGXBccAd1P823NnLCegjIRXKRZ4Ohi3PAPiSvcdC3ZmbY8i/TB98KShDF/v0/pBe/7THVI76FSHduggKMvto6dp7t5PHPit+nshmSisLcYtpJnj6f+x7A6pqpa49eb58RykWtJ+7ELXtQrkE4zhMY5QRNjlLdXpwN12tqQD13cjMvt+s+2RvxuYo6KA5yLx8BOwXapuifsHGgjdXPiAy93GRctHk/5+yvbq9vrlss8pXdttA9/KsUz1Vz3sFcYufHTDxonEx3oSj/OEpCfHfTefRUh3zna6v8jJh/NXNM2kt6h9Ut6Tl4nPNgoGrZD0ehMtkbHp7TOs0ESIm+gPqnucbAC4XF/1AT8SwZ3t2fGxYybut6AeHsqYnvQ+Cj59r1ciLliXGo/MUyBVJ14gfXxkg++IKHaY6QF/ZlqpQfsBwZ503VG+GZcS5Jc1sEdT0QEKS8O6WXtcJhIJbeJzuNPLNYPqbu3rz+oNCqThXDMRMYhGIs6vdl6wvwKBLkvN7tDvF9dP2FW9eM9hDwbckATyE5IQ1D4BcNFIcJMZASw+MuZsLvF1FoA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39860400002)(376002)(396003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(122000001)(86362001)(38100700002)(38070700005)(33656002)(36756003)(2906002)(6512007)(478600001)(4744005)(6486002)(5660300002)(41300700001)(8936002)(4326008)(8676002)(6506007)(71200400001)(83380400001)(2616005)(53546011)(54906003)(66556008)(66476007)(7416002)(66946007)(76116006)(64756008)(66446008)(110136005)(91956017)(316002)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUxaQXhRNDFTNFFzRnA1K01hUVpvUEtLMjhLdjRNekVXYVBnTGRHejJWOG9X?=
 =?utf-8?B?aDd1QXFZMTdzSWw4SDBLV1BFVXJmck8zMmljZlNyTEdLcGtrY2t2bTFRQlls?=
 =?utf-8?B?ekQxRndsT2xGejdjNXhmVCtDbFBVQ29FcTRXQjQ4YnFwQlQrcGdFcm0xTVpu?=
 =?utf-8?B?YlJ3cUo2YVlwMDNPTzRYL05OSERRTk9OZnQ4Nkx1eFdQN25oK09yMi9kQ2xn?=
 =?utf-8?B?dTRBaDliL08yL1FvdnE2azlIMnFzZGlLM25aOVpYUXVkamlPZ2tkdGQ5WHAx?=
 =?utf-8?B?ZjNuYkFVTEJPaU1BZGxFWjFkbnZMaGNsZFJqME1KVEM2N0x6eWVOVVVCamNy?=
 =?utf-8?B?S0FZbTBoQ1Y3RGsvUHJFY1dCOVZNaHh5RUFXZm91SVNzQUN4OXA3aUpybzEv?=
 =?utf-8?B?UnJLVVdJRlcwcVM5TEloTEtScCt4dXlGb2MxY2VKZHJNVzJ1S3BmVTQ5eEpR?=
 =?utf-8?B?UGlvMWNxTVRlNVlyZFc5MW42cFVGU0xyY0tnbHhaVHVZbUROT3FiQkZhYmVX?=
 =?utf-8?B?MFBFRG96MW56R2hLNVdTRnBYbGp6SWZNSTEweXpJa1VxNmw5aFQvRFJXVmFv?=
 =?utf-8?B?UnRaLzNwaGZPQ2FLWUhjdjJ1N2VSbmFNNHFEZmZPWCtKWlJtUmVaY2hmWk5Y?=
 =?utf-8?B?M3RaU1IrN0c0c09kdHQwc0JLYUsyRWUvRTdleGtxLzNhV1N6OVdmL0QwUjFQ?=
 =?utf-8?B?OGNaNXFtOVNrTVVBRG1kK2hGamE0QVgzaWhIK3FWMHROQnNFaWlWVG9mT2JD?=
 =?utf-8?B?SjJOQ0xvTDhhNnJNMWZQcUxSd0J5eFBlZ2pKMzB1QUJKcjV4OGFkbGlMcGVs?=
 =?utf-8?B?UWVZMTVRc3lSRGt2anhaQ0V5aStMdU1OLzdPMXVXMzRxSHF2YXM0N3FnOTZi?=
 =?utf-8?B?YlJiMGd1bndjckdCMW96SEVLN0VUVjZyQnhqZnU5NTJKS0lBdUZqQ1Ntb0VQ?=
 =?utf-8?B?VlREZHgzamVHU1Frck5YbEh6cFd2WW1RWGVTV0dXRVZDTzlCY3BvRkdyZnRo?=
 =?utf-8?B?cDZzbForVlNjblVGYVVEQktVZHhtcTM3dFVLSjlsZ1lMc0gzMm5zZ3RvNkdP?=
 =?utf-8?B?Mm52ajYrOGdNK3p6Njg2dXZUYW1RNFZXZ3YrdDJGM1lMcWI0YTRCYXJJdnZS?=
 =?utf-8?B?RUEzeVZxOGlXa0JsNUhDYWwvOXc5S28vRVVGZmJ3enRDR1ZxWk1RanpYQ2Rm?=
 =?utf-8?B?S0lYU3REZzRLaGtBdmRuVXFDSFU3TGV3eWNhM2VUdmxjTTB3RTFoQy9BdTFI?=
 =?utf-8?B?clRFeDNZSlVIcDZLZzIydGdxZE0zMmV3WThZbForcWtZU2gzVGpLbDA1R1RX?=
 =?utf-8?B?TjkwaVZpRk01aTVKR3JaWGcxQ1o1VUJhQjBHckdCZWZpZnVIeU1MWklCc1Rj?=
 =?utf-8?B?Tng1dTJ4cDFVd1ZsSGJCdzhueXdnVGt3blpmNzQzQzNVTXRaL1AwbWpEeGFP?=
 =?utf-8?B?dzN1c2xRdjlyZzBZTHlsdWlRYkVhNEx1R2VPRldUeUM2STZjWVZRb3JYeWZo?=
 =?utf-8?B?ZWEzVGs5MmpMbjRpMlZDSjAzVkpnSWFrUW9nQVVLd2taTlFQQlhnZmM1Q1Fn?=
 =?utf-8?B?QnFWQ0NzbEMwWlE2VFRkQWl0WUtEQ2R1amhHZzR3cDc4QU5GeUpYaUllVENj?=
 =?utf-8?B?Nkk3ODRqZzFhRm84QmozL0VDamhtaFhNQ1pjUmNFaGVHQnZCWTlITlhVbG1z?=
 =?utf-8?B?SC8rbjFZQmw0RSt2eC9tbmQwYjNuS04zQU5FeHpLR1VuaFhoOHNQTWYxbDZp?=
 =?utf-8?B?RlM4ZUIvVERCRE9ScmYzcDBDZkM3eklETDk4MkpNWHBneWxWdWNmZmxzcUVx?=
 =?utf-8?B?ckxaTnk3TVlWWUZJYmFPVTljUi9TYjZlTHIzQ1VPVG5XN3kzZ1hRRmc3WlhL?=
 =?utf-8?B?NlVEYkVRRXhWUHdGL3dIR2dUTmlWSTZLSGttVFR4RzNCTXNldkpDNmtPRDcx?=
 =?utf-8?B?UFcwSHlOYzhldURkMmZtWEFHTUR4SFVKMk56cmhieEZ6TjUxeGF6b1Mvam1w?=
 =?utf-8?B?STlWR2lPZnRYdCtmWVNPL24zNXhqdHZoZ3NyQy9lNzMyTmVPMkhreHllN0JP?=
 =?utf-8?B?OVdlVDBiL0g3ZW5HR3M5VGYxRWw1dkhPWUI1Q1hGajJtcEw2MU8wdjZ1cWpl?=
 =?utf-8?Q?p36CDKHU14EYA6m3gXFeKK4aN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FAAE67D8EB0FD4699594C06A2255C50@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a71faa-a7b3-466d-323d-08dbc8c2474f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 12:21:34.8507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eoe25Nqv+eX2M6/sir1G95qfN3C/TEVTpSKlUzC8w+UOm+SHnJ3UfiXBq4JwdTI7Ihp1i1nsVhB0/LpxHBs9fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB8678
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gT2N0IDksIDIwMjMsIGF0IDM6MDAgUE0sIFVyb3MgQml6amFrIDx1Yml6amFrQGdt
YWlsLmNvbT4gd3JvdGU6DQo+IA0KPiAhISBFeHRlcm5hbCBFbWFpbA0KPiANCj4gT24gTW9uLCBP
Y3QgOSwgMjAyMyBhdCAxOjUx4oCvUE0gSW5nbyBNb2xuYXIgPG1pbmdvQGtlcm5lbC5vcmc+IHdy
b3RlOg0KPj4gDQo+PiBCVFcuLCB3aGlsZSB0aGlzIE9LIGZvciB0ZXN0aW5nLCB0aGlzIGlzIHRv
byBoZWF2eSBoYW5kZWQgZm9yIHJlbGVhc2UNCj4+IHB1cnBvc2VzLCBzbyBwbGVhc2Ugb25seSBk
aXNhYmxlIHRoZSBLQVNBTiBpbnN0cnVtZW50YXRpb24gZm9yIHRoZSBhZmZlY3RlZA0KPj4gcGVy
Y3B1IGFjY2Vzc29ycy4NCj4+IA0KPj4gU2VlIHRoZSB2YXJpb3VzIF9fbm9fc2FuaXRpemUqIGF0
dHJpYnV0ZXMgYXZhaWxhYmxlLg0KPiANCj4gVGhlc2UgYXR0cmlidXRlcyBhcmUgZm9yIGZ1bmN0
aW9uIGRlY2xhcmF0aW9ucy4gVGhlIHBlcmNwdSBjYXN0cyBjYW4NCj4gbm90IGJlIGltcGxlbWVu
dGVkIHdpdGggc2VwYXJhdGUgc3RhdGljIGlubGluZSBmdW5jdGlvbnMuIEFsc28sDQo+IF9fbm9f
c2FuaXRpemVfYWRkcmVzcyBpcyBtdXR1YWxseSBleGNsdXNpdmUgd2l0aCBfX2Fsd2F5c19pbmxp
bmUuDQoNClJpZ2h0LCBidXQgZm9yIEdDQyB5b3UgbWF5IGJlIGFibGUgdG8gZG8gc29tZXRoaW5n
IGxpa2U6DQogIA0KICAgICNwcmFnbWEgR0NDIGRpYWdub3N0aWMgcHVzaA0KICAgICNwcmFnbWEg
R0NDIGRpYWdub3N0aWMgaWdub3JlZCAiLWZzYW5pdGl6ZT1hZGRyZXNzIg0KICANCiAgICAvLyBZ
b3VyIGNvZGUgaGVyZS4uLg0KICAgICNwcmFnbWEgR0NDIGRpYWdub3N0aWMgcG9wDQoNCk5vdCBz
dXJlIGlmIHRoZXJlIGlzIHNvbWV0aGluZyBlcXVpdmFsZW50IGluIENMQU5HLCBhbmQgaXQgc2hv
dWxkIGJlIGRvbmUgd2l0aA0KdGhlIGtlcm5lbOKAmXMgX1ByYWdtYS4NCg0K

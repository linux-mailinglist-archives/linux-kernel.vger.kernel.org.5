Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F40C7DC9B3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343939AbjJaJfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343875AbjJaJfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:35:13 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7A5C1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 02:35:09 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-102-NPlOFUtyOJyGU0BiTK64og-1; Tue, 31 Oct 2023 09:35:07 +0000
X-MC-Unique: NPlOFUtyOJyGU0BiTK64og-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 31 Oct
 2023 09:35:23 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 31 Oct 2023 09:35:23 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     =?utf-8?B?J0pvc8OpIFBla2thcmluZW4n?= <jose.pekkarinen@foxhound.fi>,
        "seanjc@google.com" <seanjc@google.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>
CC:     "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Subject: RE: [PATCH] KVM: x86: replace do_div with div64_ul
Thread-Topic: [PATCH] KVM: x86: replace do_div with div64_ul
Thread-Index: AQHaCkzW1Xnt8sZ59Em+v+kyKOU1sLBjphAA
Date:   Tue, 31 Oct 2023 09:35:23 +0000
Message-ID: <23f90fd3273a4d7f961b277758ac7af8@AcuMS.aculab.com>
References: <20231029093928.138570-1-jose.pekkarinen@foxhound.fi>
In-Reply-To: <20231029093928.138570-1-jose.pekkarinen@foxhound.fi>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSm9zw6kgUGVra2FyaW5lbg0KPiBTZW50OiAyOSBPY3RvYmVyIDIwMjMgMDk6MzkNCj4g
DQo+IFJlcG9ydGVkIGJ5IGNvY2NpbmVsbGUsIHRoZXJlIGlzIGEgZG9fZGl2IGNhbGwgdGhhdCBk
b2VzDQo+IDY0LWJ5LTMyIGRpdmlzaW9ucyBldmVuIGluIDY0Yml0IHBsYXRmb3JtcywgdGhpcyBw
YXRjaCB3aWxsDQo+IG1vdmUgaXQgdG8gZGl2NjRfdWwgbWFjcm8gdGhhdCB3aWxsIGRlY2lkZSB0
aGUgY29ycmVjdA0KPiBkaXZpc2lvbiBmdW5jdGlvbiBmb3IgdGhlIHBsYXRmb3JtIHVuZGVybmVh
dGguIFRoZSBvdXRwdXQNCj4gdGhlIHdhcm5pbmcgZm9sbG93czoNCj4gDQo+IGFyY2gveDg2L2t2
bS9sYXBpYy5jOjE5NDg6MS03OiBXQVJOSU5HOiBkb19kaXYoKSBkb2VzIGEgNjQtYnktMzIgZGl2
aXNpb24sIHBsZWFzZSBjb25zaWRlciB1c2luZw0KPiBkaXY2NF91bCBpbnN0ZWFkLg0KDQpUaGF0
IGlzIGFib3V0IHRoZSB3b3JzdCBtZXNzYWdlIGZyb20gdGhlIGNvY2NpbmVsbGUgc2NyaXB0cy4N
Ckl0IHJlYWxseSBvdWdodCB0byBhc2sgeW91IHRvIGNoZWNrIHRoZSBkb21haW4gb24gdGhlIHZh
bHVlcy4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSm9zw6kgUGVra2FyaW5lbiA8am9zZS5wZWtr
YXJpbmVuQGZveGhvdW5kLmZpPg0KPiAtLS0NCj4gIGFyY2gveDg2L2t2bS9sYXBpYy5jIHwgMiAr
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL2xhcGljLmMgYi9hcmNoL3g4Ni9rdm0vbGFwaWMu
Yw0KPiBpbmRleCAzZTk3N2RiYmY5OTMuLjBiOTBjNmFkNTA5MSAxMDA2NDQNCj4gLS0tIGEvYXJj
aC94ODYva3ZtL2xhcGljLmMNCj4gKysrIGIvYXJjaC94ODYva3ZtL2xhcGljLmMNCj4gQEAgLTE5
NDUsNyArMTk0NSw3IEBAIHN0YXRpYyB2b2lkIHN0YXJ0X3N3X3RzY2RlYWRsaW5lKHN0cnVjdCBr
dm1fbGFwaWMgKmFwaWMpDQo+ICAJZ3Vlc3RfdHNjID0ga3ZtX3JlYWRfbDFfdHNjKHZjcHUsIHJk
dHNjKCkpOw0KPiANCj4gIAlucyA9ICh0c2NkZWFkbGluZSAtIGd1ZXN0X3RzYykgKiAxMDAwMDAw
VUxMOw0KPiAtCWRvX2RpdihucywgdGhpc190c2Nfa2h6KTsNCj4gKwlkaXY2NF91bChucywgdGhp
c190c2Nfa2h6KTsNCg0KRGlkIHlvdSB0ZXN0IHRoaXM/DQpIaW50IC0geW91IGRpZG4ndC4NCg0K
CURhdmlkDQoNCj4gDQo+ICAJaWYgKGxpa2VseSh0c2NkZWFkbGluZSA+IGd1ZXN0X3RzYykgJiYN
Cj4gIAkgICAgbGlrZWx5KG5zID4gYXBpYy0+bGFwaWNfdGltZXIudGltZXJfYWR2YW5jZV9ucykp
IHsNCj4gLS0NCj4gMi4zOS4yDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJh
bWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0
cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


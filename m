Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52567D6881
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343521AbjJYKaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjJYKaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:30:19 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194D4B0;
        Wed, 25 Oct 2023 03:30:14 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39PAU8vsC1456276, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39PAU8vsC1456276
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 18:30:08 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 25 Oct 2023 18:30:08 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 25 Oct 2023 18:30:08 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::9cb8:8d5:b6b3:213b]) by
 RTEXMBS01.realtek.com.tw ([fe80::9cb8:8d5:b6b3:213b%5]) with mapi id
 15.01.2375.007; Wed, 25 Oct 2023 18:30:08 +0800
From:   Ricky WU <ricky_wu@realtek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "tommyhebb@gmail.com" <tommyhebb@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] mmc: rtsx: improve performance for multi block rw
Thread-Topic: [PATCH v3] mmc: rtsx: improve performance for multi block rw
Thread-Index: AQHX9mTncx2NNhc4Hk2xCW7FootmX6w8X/iAgAN+/CD//4BBAIAB2EewgAY9WACAAfsEAIA+RCiAgATnqGCAAA5YAIO7cd/ggAGUdwCAAVcUMIAHB40AgAxJQWA=
Date:   Wed, 25 Oct 2023 10:30:08 +0000
Message-ID: <8eb029c41a734aeaa27be19d8629ef95@realtek.com>
References: <8e61aed5f64e434abc1d7b6f81859c8a@realtek.com>
 <CAPDyKFrLpim75nUB7ksDie2edkWsnFSq6TbFSFFpw5cY5d4y1w@mail.gmail.com>
 <fabaed5751f04105a9719c1cb0390c98@realtek.com>
 <CAPDyKFr3NRUgfKtkb2DBrhziekFAB0jT_X3Fsfvjk_bGZLC9mA@mail.gmail.com>
 <fa10aa1c644241808c2ad880088240ab@realtek.com>
 <CAPDyKFrtBKHHRgeF-JO27ANsbSmt8rdnhn-WNr5Je9okEgA29Q@mail.gmail.com>
 <feb0c4e71e9c48a2a21f18b7d3baf135@realtek.com>
 <CAPDyKFoq_PDk_JgW4D+o4eEPdcffUq2RLbBreRDqeK47m0UnJA@mail.gmail.com>
 <a82d7e877dc041d4be5e0ef38c2da406@realtek.com>
 <CAPDyKFo59Q3dmUJU-hJ++=k0uwx2KxamW9KckDX=O_CA84O1_g@mail.gmail.com>
 <a533dde76d2d4345b85cd060a8e403db@realtek.com>
 <CAPDyKFp3sbbQmKiV6NnuWnPmpfuyWzRBTuYJaWx_7oTLLsXdaA@mail.gmail.com>
 <5752164983174ca68a669c241e7ef436@realtek.com>
 <CAPDyKFpeirjA4QmCiqnu4MxN8Yph6d0GiyA95pcmOBRYf8ywSg@mail.gmail.com>
In-Reply-To: <CAPDyKFpeirjA4QmCiqnu4MxN8Yph6d0GiyA95pcmOBRYf8ywSg@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.22.81.100]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+DQo+ID4gPiBPbiBXZWQsIDExIE9jdCAyMDIzIGF0IDA3OjM2LCBSaWNreSBXVSA8cmlja3lf
d3VAcmVhbHRlay5jb20+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBIaSBVbGYgSGFuc3NvbiwN
Cj4gPiA+ID4NCj4gPiA+ID4gQ2FuIEkga25vdyB3aGF0IGlzIHRoaXMgcGF0Y2ggc3RhdHVzIG9y
IGhhcyBzb21lIGNvbmNlcm4gb24gdGhpcyBwYXRjaD8NCj4gPiA+DQo+ID4gPiBEaWRuJ3QgeW91
IHJlYWQgbXkgZWFybGllciByZXBsaWVzPw0KPiA+ID4NCj4gPg0KPiA+IEFyZSB5b3UgdGFsa2lu
ZyBhYm91dCBCRlEgZm9yIHRlc3Rpbmcgc3BlZWQ/DQo+ID4gQmVjYXVzZSB3ZSB0ZXN0ZWQgdGhl
IFJlYWQvV3JpdGUgc3BlZWQgYXJlIGJldHRlciB0aGFuIGJlZm9yZSBhbmQgb3VyDQo+IGN1c3Rv
bWVyIHRoYXQgdXNlcyBvdXIgcmVhZGVyIG9uIHRoZWlyIHByb2R1Y3QgYWxzbyB0ZXN0ZWQgdGhl
IFJlYWQvV3JpdGUNCj4gc3BlZWQsIHRoZXkgd2FudCB1cyB0byBwdXNoIHRoaXMgcGF0Y2ggb24N
Cj4gDQo+IEl0J3MgY2VydGFpbmx5IGEgdmVyeSBwb3NpdGl2ZSB0aGluZyB0aGF0IHlvdXIgdGFy
Z2V0IGlzIHRvIHVwc3RyZWFtDQo+IHNvbHV0aW9ucyB0aGF0IGltcHJvdmUgcGVyZm9ybWFuY2Uu
IFdlIGFsbCBhcHByZWNpYXRlIHRoaXMhDQo+IA0KPiBJbiB0aGlzIHJlZ2FyZCwgSSBiZWxpZXZl
IEkgaGF2ZSB0cmllZCB0byBndWlkZSB5b3Ugb24gaG93IHRvIG1vdmUNCj4gZm9yd2FyZCB3aXRo
IHRoaXMuIFRoaXMgcGFydGljdWxhciBvcHRpbWl6YXRpb24gZG9lc24ndCBiZWxvbmcgaW4gYW4N
Cj4gbW1jIGhvc3QgZHJpdmVyLCBidXQgcmF0aGVyIGF0IHRoZSBjb21tb24gdXBwZXIgYmxvY2sg
ZGV2aWNlIGRyaXZlcg0KPiBsYXllciwgc3VjaCB0aGF0IGl0IGNhbiBiZW5lZml0IG1vcmUgdGhh
biBvbmUgcGFydGljdWxhciBtbWMgaG9zdA0KPiBkcml2ZXIuDQo+IA0KPiBJIGZ1bGx5IHVuZGVy
c3RhbmQgdGhhdCBtYWtpbmcgdGhhdCBraW5kIG9mIGltcHJvdmVtZW50IGlzIHdheSBtb3JlDQo+
IGRpZmZpY3VsdCBhbmQgcmVxdWlyZXMgaW4tZGVwdGggYW5hbHlzaXMgdG8gdW5kZXJzdGFuZCB3
aGF0IGlzDQo+IGhhcHBlbmluZyBvbiB0aG9zZSBsYXllcnMgdG9vLiBPbiB0aGUgb3RoZXIgaGFu
ZCBpdCBjb3VsZCBiZSBzb21ldGhpbmcNCj4gdGhhdCBtYXkgYmVuZWZpdCBhIGxvdCBvZiBkZXZp
Y2VzL3BsYXRmb3Jtcy4gVW5mb3J0dW5hdGVseSwgSSBhbQ0KPiBjdXJyZW50bHkgbm90IGluIGEg
cG9zaXRpb24gd2hlcmUgSSBoYXZlIHRoZSBiYW5kd2lkdGggdG8gZGl2ZSBkZWVwZXINCj4gaW50
byB0aGlzLg0KPiANCj4gSWYgeW91IGRlY2lkZSB0byBwdXJzdWUgeW91ciBpbnZlc3RpZ2F0aW9u
cywgSSB0aGluayB3ZSBuZWVkIHRvDQo+IGludm9sdmUgdGhlIGV4cGVydHMgZnJvbSB0aGUgY29t
bW9uIGJsb2NrIGNvbW11bml0eSAobGludXgtYmxvY2sNCj4gbWFpbGluZyBsaXN0KSB0byBnZXQg
dGhlaXIgYWR2aWNlLg0KPiANCj4gU28gdG8gYmUgY2xlYXIsIEkgYW0gbm90IGdvaW5nIHRvIGFw
cGx5ICRzdWJqZWN0IHBhdGNoIC0gb3IgYW55dGhpbmcNCj4gc2ltaWxhciB0byBhbiBtbWMgaG9z
dCBkcml2ZXIuDQo+IA0KDQpUaGlzIGltcHJvdmUgcGVyZm9ybWFuY2Ugc29sdXRpb24gaXMgZGV2
ZWxvcGVkIGZvciBvdXIgSFcgZGVzaWduDQoNCldlIGRpc2N1c3NlZCBpbnRlcm5hbGx5LCBUaGUg
Q01EIDEyIHJlc3BvbnNlIHRpbWluZyBpcyBkZXBlbmQgb24gSFcgZGVzaWduIHNvIHRoaXMgc29s
dXRpb24gDQptYXliZSBjYW5ub3QgbWVldCBhbGwgZGV2aWNlcywgYW5kIHRoZSBjb3JlIHBhcnQg
b2YgdGhpcyBtZWNoYW5pc20gaXMgd2hlbiB3ZSBnb3Qgc2VxdWVudGlhbCBkYXRhIA0Kd2UgY29u
dHJvbCBvdXIgRE1BIHJlZ2lzdGVyIGZvciByZWFkL3dyaXRlIGRhdGEsIHRoaXMgb3BlcmF0aW5n
IGhhcyBkaWZmZXJlbnQgZGVzaWduZWQgb24gZGlmZmVyZW50IGRldmljZSwNCnNvIHRoaXMgaXMg
bm90IGVhc3kgdG8gcHVzaCBhIHNhbWUgd2F5IG9uIHRoZSBtbWMgY29yZS4gDQoNCj4gDQo+IEtp
bmQgcmVnYXJkcw0KPiBVZmZlDQo=

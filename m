Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A8676ECE2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236784AbjHCOl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236028AbjHCOlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:41:09 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DAC3A80
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 07:40:16 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-93-Yef4x2TXMjORgJxQ4THDUQ-1; Thu, 03 Aug 2023 15:39:39 +0100
X-MC-Unique: Yef4x2TXMjORgJxQ4THDUQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 3 Aug
 2023 15:39:38 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 3 Aug 2023 15:39:38 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'paulmck@kernel.org'" <paulmck@kernel.org>,
        Alan Huang <mmpgouride@gmail.com>
CC:     Joel Fernandes <joel@joelfernandes.org>,
        Eric Dumazet <edumazet@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>
Subject: RE: Question about the barrier() in hlist_nulls_for_each_entry_rcu()
Thread-Topic: Question about the barrier() in hlist_nulls_for_each_entry_rcu()
Thread-Index: AQHZxhH18xsGyGi6wkSgE8eJxYMp7K/Yo3ZQ
Date:   Thu, 3 Aug 2023 14:39:38 +0000
Message-ID: <9905e2f8e28246929be7b77b78c07fb4@AcuMS.aculab.com>
References: <E9CF24C7-3080-4720-B540-BAF03068336B@gmail.com>
 <1E0741E0-2BD9-4FA3-BA41-4E83315A10A8@joelfernandes.org>
 <1AF98387-B78C-4556-BE2E-E8F88ADACF8A@gmail.com>
 <43d29007-3c59-4497-a1e5-26f182a7f4c5@paulmck-laptop>
 <784ABF9D-303F-4FC8-8AFF-A3FF319B4E7A@gmail.com>
 <bf86abde-6a90-4ea0-a298-abe5b367f4f9@paulmck-laptop>
In-Reply-To: <bf86abde-6a90-4ea0-a298-abe5b367f4f9@paulmck-laptop>
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
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUGF1bCBFLiBNY0tlbm5leQ0KPiBTZW50OiAwMyBBdWd1c3QgMjAyMyAxNDo1NA0KLi4u
Lg0KPiA+ID4gSWYgYm90aCBhcmUgUkVBRF9PTkNFKCksIHlvdSBzaG91bGQgbm90IG5lZWQgdGhl
IGJhcnJpZXIoKS4gIFVubGVzcyB0aGVyZQ0KPiA+ID4gaXMgc29tZSBvdGhlciBjb2RlIG5vdCBz
aG93biBpbiB5b3VyIGV4YW1wbGUgdGhhdCByZXF1aXJlcyBpdCwgdGhhdCBpcy4NCj4gPg0KPiA+
IEFuZCB1bmxlc3MgdGhlIGNvbXBpbGVyIGhhcyBhIGJ1Zy4gOikNCj4gPg0KPiA+IFNvLCB0aGUg
YmFycmllcigpIGluIGhsaXN0X251bGxzX2Zvcl9lYWNoX2VudHJ5X3JjdSgpIGlzIGEgd29ya2Fy
b3VuZCBmb3IgYSBjb21waWxlciBidWcuDQo+IA0KPiBGYWlyIGVub3VnaCEhISAgOy0pDQoNCkV4
Y2VwdCB0aGF0IGl0IGlzIGxpa2VseSB0aGF0IHRoZSBjb21waWxlciBidWcgaXMgYXZvaWRlZCBi
eSB0aGUNCmltcGxlbWVudGF0aW9uIG9mIFJFQURfT05DRSgpIHJhdGhlciB0aGFuIEFDQ0VTU19P
TkNFKCkuDQoNCkFsc28gdGhlIGNvZGUgdGhhdCBsb29wZWQgZm9yZXZlciAoVURQIHJlY2VpdmUg
c29ja2V0IGxvb2t1cCkNCm5vIGxvbmdlciBoYXMgdGhlIHJldHJ5IC0gd2hpY2ggaXMgYSBkaWZm
ZXJlbnQgYnVnLg0KSWYgYSBzb2NrZXQgcmVoYXNoIGhpdHMgdGhlIGxvb2t1cCB0aGVuIGFuIGVy
cm9uZW91cyBJQ01QDQoncG9ydCB1bnJlYWNoYWJsZScgaXMgc2VudCByYXRoZXIgdGhhbiBkb2lu
ZyBhIHJlc2Nhbi4NCg0KCURhdmlkDQogDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lk
ZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0K
UmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


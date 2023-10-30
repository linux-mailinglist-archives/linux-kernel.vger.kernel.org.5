Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7457DBC97
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 16:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbjJ3P3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 11:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbjJ3P3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 11:29:36 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0329EA9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 08:29:33 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mtapsc-5-oHEMwp6QNkelFYo-i2F22g-1; Mon, 30 Oct 2023 15:29:31 +0000
X-MC-Unique: oHEMwp6QNkelFYo-i2F22g-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 30 Oct
 2023 15:29:45 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 30 Oct 2023 15:29:45 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Shinas Rasheed' <srasheed@marvell.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Haseeb Gani <hgani@marvell.com>,
        Vimlesh Kumar <vimleshk@marvell.com>,
        "egallen@redhat.com" <egallen@redhat.com>,
        "mschmidt@redhat.com" <mschmidt@redhat.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "wizhao@redhat.com" <wizhao@redhat.com>,
        "konguyen@redhat.com" <konguyen@redhat.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Sathesh B Edara <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
Subject: RE: [PATCH net-next v2 3/4] octeon_ep: implement xmit_more in
 transmit
Thread-Topic: [PATCH net-next v2 3/4] octeon_ep: implement xmit_more in
 transmit
Thread-Index: AQHaBomkOels9gSWWE2IVlse9GkwiLBevpOAgAOrQICAAA7xIA==
Date:   Mon, 30 Oct 2023 15:29:45 +0000
Message-ID: <9631475a8ba94c1682696d219c632538@AcuMS.aculab.com>
References: <20231024145119.2366588-1-srasheed@marvell.com>
 <20231024145119.2366588-4-srasheed@marvell.com>
 <0fc50b8e6ff44c43b10481da608c95c3@AcuMS.aculab.com>
 <PH0PR18MB47340A7A9E68DE2747DB94F9C7A1A@PH0PR18MB4734.namprd18.prod.outlook.com>
In-Reply-To: <PH0PR18MB47340A7A9E68DE2747DB94F9C7A1A@PH0PR18MB4734.namprd18.prod.outlook.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU2hpbmFzIFJhc2hlZWQgPHNyYXNoZWVkQG1hcnZlbGwuY29tPg0KPiBTZW50OiAzMCBP
Y3RvYmVyIDIwMjMgMTQ6MTUNCj4gDQo+IEhpLA0KPiANCj4gSSB1bmRlcnN0YW5kIHRoZSB3aW5k
b3cgaXMgY2xvc2VkLCBidXQganVzdCByZXBseWluZyB0byBhIHBlbmRpbmcgY29tbWVudCBvbiB0
aGUgdGhyZWFkLg0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206
IERhdmlkIExhaWdodCA8RGF2aWQuTGFpZ2h0QEFDVUxBQi5DT00+DQo+ID4gLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KPiA+IEZyb206IFNoaW5hcyBSYXNoZWVkDQo+ID4gPiBTZW50OiAyNCBPY3RvYmVyIDIwMjMg
MTU6NTENCj4gPiA+DQo+ID4gPiBBZGQgeG1pdF9tb3JlIGhhbmRsaW5nIGluIHR4IGRhdGFwYXRo
IGZvciBvY3Rlb25fZXAgcGYuDQo+ID4gPg0KPiA+IC4uLg0KPiA+ID4gLQ0KPiA+ID4gLQkvKiBS
aW5nIERvb3JiZWxsIHRvIG5vdGlmeSB0aGUgTklDIHRoZXJlIGlzIGEgbmV3IHBhY2tldCAqLw0K
PiA+ID4gLQl3cml0ZWwoMSwgaXEtPmRvb3JiZWxsX3JlZyk7DQo+ID4gPiAtCWlxLT5zdGF0cy5p
bnN0cl9wb3N0ZWQrKzsNCj4gPiA+ICsJLyogUmluZyBEb29yYmVsbCB0byBub3RpZnkgdGhlIE5J
QyBvZiBuZXcgcGFja2V0cyAqLw0KPiA+ID4gKwl3cml0ZWwoaXEtPmZpbGxfY250LCBpcS0+ZG9v
cmJlbGxfcmVnKTsNCj4gPiA+ICsJaXEtPnN0YXRzLmluc3RyX3Bvc3RlZCArPSBpcS0+ZmlsbF9j
bnQ7DQo+ID4gPiArCWlxLT5maWxsX2NudCA9IDA7DQo+ID4gPiAgCXJldHVybiBORVRERVZfVFhf
T0s7DQo+ID4NCj4gPiBEb2VzIHRoYXQgcmVhbGx5IG5lZWQgdGhlIGNvdW50Pw0KPiA+IEEgJ2Rv
b3JiZWxsJyByZWdpc3RlciB1c3VhbGx5IGp1c3QgdGVsbHMgdGhlIE1BQyBlbmdpbmUNCj4gPiB0
byBnbyBhbmQgbG9vayBhdCB0aGUgdHJhbnNtaXQgcmluZy4NCj4gPiBJdCB0aGVuIGNvbnRpbnVl
cyB0byBwcm9jZXNzIHRyYW5zbWl0cyB1bnRpbCBpdCBmYWlscw0KPiA+IHRvIGZpbmQgYSBwYWNr
ZXQuDQo+ID4gU28gaWYgdGhlIHRyYW5zbWl0IGlzIGFjdGl2ZSB5b3UgZG9uJ3QgbmVlZCB0byBz
ZXQgdGhlIGJpdC4NCj4gPiAoQWx0aG91Z2ggdGhhdCBpcyBhY3R1YWxseSByYXRoZXIgaGFyZCB0
byBkZXRlY3QuKQ0KPiANCj4gVGhlIHdheSB0aGUgb2N0ZW9uIGhhcmR3YXJlIHdvcmtzIGlzIHRo
YXQgaXQgZXhwZWN0cyBudW1iZXIgb2YgbmV3bHkgdXBkYXRlZCBwYWNrZXRzDQo+IHRvIGJlIHdy
aXR0ZW4gdG8gdGhlIGRvb3JiZWxsIHJlZ2lzdGVyLHdoaWNoIGVmZmVjdGl2ZWx5IGluY3JlbWVu
dHMgdGhlIGRvb3JiZWxsDQo+IGNvdW50IHdoaWNoIHNoYWxsIGJlIGRlY3JlbWVudGVkIGJ5IGhh
cmR3YXJlIGFzIGl0IHJlYWRzIHRoZXNlIHBhY2tldHMuIFNvIGluIGVzc2VuY2UsDQo+IHRoZSBk
b29yYmVsbCBjb3VudCBhbHNvIGluZGljYXRlcyBvdXRzdGFuZGluZyBwYWNrZXRzIHRvIGJlIHJl
YWQgYnkgaGFyZHdhcmUuDQoNClVudXN1YWwgLSBJIHdvdWxkbid0IGNhbGwgdGhhdCBhIGRvb3Ji
ZWxsIHJlZ2lzdGVyLg0KDQo+ID4gVGhlICd4bWl0X21vcmUnIGZsYWcgaXMgdXNlZnVsIGlmICh0
aGUgZXF1aXZhbGVudCBvZikgd3JpdGluZw0KPiA+IHRoZSBkb29yYmVsbCByZWdpc3RlciBpcyBl
eHBlbnNpdmUgc2luY2UgaXQgY2FuIGJlIGRlbGF5ZWQNCj4gPiB0byBhIGxhdGVyIGZyYW1lIGFu
ZCBvbmx5IGRvbmUgb25jZSAtIGFkZGluZyBhIHNsaWdodCBsYXRlbmN5DQo+ID4gdG8gdGhlIGVh
cmxpZXIgdHJhbnNtaXRzIGlmIHRoZSBtYWMgZW5naW5lIHdhcyBpZGxlLg0KPiA+DQo+ID4gSSdt
IG5vdCBzdXJlIGhvdyBtdWNoIChpZiBhbnkpIHBlcmZvcm1hbmNlIGdhaW4geW91IGFjdHVhbGx5
DQo+ID4gZ2V0IGZyb20gYXZvaWRpbmcgdGhlIHdyaXRlbCgpLg0KPiA+IFNpbmdsZSBQQ0llIHdy
aXRlcyBhcmUgJ3Bvc3RlZCcgYW5kIHByZXR0eSBtdWNoIGNvbXBsZXRlbHkNCj4gPiBhc3luY2hy
b25vdXMuDQo+IA0KPiBDYW4geW91IGVsYWJvcmF0ZSB3aGF0IHlvdSBhcmUgc3VnZ2VzdGluZyBo
ZXJlIHRvIGRvPyBUaGUgZHJpdmVyIGlzIHRyeWluZw0KPiB0byBtYWtlIHVzZSBvZiB0aGUgJ3ht
aXRfbW9yZScgaGludCBmcm9tIHRoZSBuZXR3b3JrIHN0YWNrLCBhcyBhbnkgbmV0d29yaw0KPiBk
cml2ZXIgbWlnaHQgb3B0IHRvIGRvLg0KDQpUaGVyZSBhcmUgc29tZSBkcml2ZXJzIHdoZXJlIHdh
a2luZyB1cCB0aGUgTUFDIGVuZ2luZSBpcyBleHBlbnNpdmUuDQpJZiB5b3UgbmVlZCB0byBkbyBh
IFBDSWUgcmVhZCB0aGVuIHRoZXkgYXJlIGV4cGVuc2l2ZS4NClRoZXJlIG1pZ2h0IGFsc28gYmUg
ZHJpdmVycyB0aGF0IG5lZWQgdG8gc2VuZCBhIFVTQiBtZXNzYWdlLg0KSSBkb24ndCBhY3R1YWxs
eSBrbm93IHdoaWNoIG9uZSBpdCB3YXMgYWRkZWQgZm9yLg0KDQo+IEkgdGhpbmsgYXZvaWRpbmcg
Y29udGludW91cyBQQ0llIHBvc3RzIGZvciBlYWNoIHBhY2tldCBzaGFsbCBzdGlsbCBiZSB3YXN0
ZWZ1bA0KPiBhcyB0aGUgaGFyZHdhcmUgY2FuIGJ1bGsgcmVhZCBmcm9tIHRoZSBxdWV1ZSBpZiB3
ZSBnaXZlIGl0IGEgYmF0Y2ggb2YgcGFja2V0cy4NCg0KSWYgeW91IGRvIHdyaXRlcyBmb3IgZXZl
cnkgcGFja2V0IHRoZW4gdGhlIGhhcmR3YXJlIGNhbiBnZXQgb24gd2l0aA0Kc2VuZGluZyB0aGUg
Zmlyc3QgcGFja2V0IGFuZCBtaWdodCBiZSBhYmxlIHRvIGRvIGJ1bGsgcmVhZHMNCmZvciB0aGUg
bmV4dCBwYWNrZXQocykgd2hlbiB0aGF0IGZpbmlzaGVzLg0KDQpUaGUgZXh0cmEgY29kZSB5b3Ug
YXJlIGFkZGluZyBjb3VsZCBlYXNpbHkgKHdhdmluZyBoYW5kcykNCmJlIG1vcmUgZXhwZW5zaXZl
IHRoYW4gdGhlIHBvc3RlZCBQQ0llIHdyaXRlLg0KKEVzcGVjaWFsbHkgaWYgeW91IGhhdmUgdG8g
YWRkIGFuIGF0b21pYyBvcGVyYXRpb24uKQ0KDQpVbmxlc3MsIG9mIGNvdXJzZSwgeW91IGhhdmUg
dG8gd2FpdCBmb3IgaXQgdG8gc2VuZCB0aGF0IGJhdGNoDQpvZiBwYWNrZXRzIGJlZm9yZSB5b3Ug
Y2FuIGdpdmUgaXQgYW55IG1vcmUuDQpXaGljaCB3b3VsZCBiZSByYXRoZXIgZW50aXJlbHkgYnJv
a2VuIGFuZCB3b3VsZCByZWFsbHkgcmVxdWlyZQ0KeW91IGRvIHRoZSB3cml0ZSBpbiB0aGUgZW5k
LW9mLXRyYW5zaXQgcGF0aC4NCg0KPiA+IFRoZSBvdGhlciBwcm9ibGVtIEkndmUgc2VlbiBpcyB0
aGF0IG5ldGRldl94bWl0X21vcmUoKSBpcw0KPiA+IHRoZSBzdGF0ZSBvZiB0aGUgcXVldWUgd2hl
biB0aGUgdHJhbnNtaXQgd2FzIHN0YXJ0ZWQsIG5vdA0KPiA+IHRoZSBjdXJyZW50IHN0YXRlLg0K
PiA+IElmIGEgcGFja2V0IGlzIGFkZGVkIHdoaWxlIHRoZSBlYXJsaWVyIHRyYW5zbWl0IHNldHVw
IGNvZGUNCj4gPiBpcyBydW5uaW5nIChzZXR0aW5nIHVwIHRoZSBkZXNjcmlwdG9ycyBldGMpIHRo
ZSBpdCBpc24ndCBzZXQuDQo+ID4gU28gdGhlIGZhc3QgcGF0aCBkb2Vzbid0IGdldCB0YWtlbi4N
Cj4gDQo+IEJ5IHRoZSBuZXh0IHBhY2tldCB0aGUga2VybmVsIHNlbmRzLCB0aGUgeG1pdF9tb3Jl
IHNob3VsZCBiZSBzZXQNCj4gYXMgZmFyIEkgdW5kZXJzdGFuZCwgcmlnaHQ/IChhcyB0aGUgeG1p
dF9tb3JlIGJvb2wgaXMgc2V0IGlmIHNrYi0+bmV4dA0KPiBpcyBwcmVzZW50LCBpZiB0aGUgdHJh
bnNtaXQgcGF0aCBmb2xsb3dzIGRldl9oYXJkX3N0YXJ0X3htaXQpLg0KDQpUaGUgbG9vcCBpcyBz
b21ldGhpbmcgbGlrZToNCgl3aGlsZSAoZ2V0X3BhY2tldCgpKSB7DQoJCXBlcl9jcHUtPnhtaXRf
bW9yZSA9ICFxdWV1ZV9lbXB0eSgpOw0KCQlpZiAodHJhbnNtaXRfcGFja2V0KCkgIT0gVFhfT0sp
DQoJCQlicmVhazsNCgl9DQpTbyBpZiBhIHBhY2tldCBpcyBhZGRlZCB3aGlsZSBhbGwgdGhlIHRy
YW5zbWl0IHNldHVwIGNvZGUgaXMgcnVubmluZw0KaXQgaXNuJ3QgZGV0ZWN0ZWQuDQpJIG1hbmFn
ZWQgdG8gcmVwZWF0ZWRseSBnZXQgdGhhdCB0byBsb29wIHdoZW4geG1pdF9tb3JlIHdhc24ndCBz
ZXQNCmFuZCBpbiBhIGRyaXZlciB3aGVyZSB0aGUgJ2Rvb3JiZWxsJyB3cml0ZSB3YXNuJ3QgZW50
aXJlbHkgdHJpdmlhbC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lk
ZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0K
UmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


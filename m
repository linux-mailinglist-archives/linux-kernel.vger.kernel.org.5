Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47737AA819
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 07:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjIVFMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 01:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjIVFMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 01:12:16 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B7B18F;
        Thu, 21 Sep 2023 22:12:06 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38M5B8Jr83708355, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38M5B8Jr83708355
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 13:11:08 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 22 Sep 2023 13:11:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 22 Sep 2023 13:11:06 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c]) by
 RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c%5]) with mapi id
 15.01.2375.007; Fri, 22 Sep 2023 13:11:06 +0800
From:   Hayes Wang <hayeswang@realtek.com>
To:     Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>
CC:     "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        nic_swsd <nic_swsd@realtek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "bjorn@mork.no" <bjorn@mork.no>
Subject: RE: [PATCH net-next v2 1/2] r8152: remove queuing rx packets in driver
Thread-Topic: [PATCH net-next v2 1/2] r8152: remove queuing rx packets in
 driver
Thread-Index: AQHZ6qdYyQovugIsME21Grz+cVcRerAhiHwAgACHqzCAArZ0gIABgcUA
Date:   Fri, 22 Sep 2023 05:11:05 +0000
Message-ID: <9e03e260818940bcb37828eea83e0137@realtek.com>
References: <20230919031351.7334-429-nic_swsd@realtek.com>
         <20230919031351.7334-430-nic_swsd@realtek.com>
         <369f3139-4e63-4327-8745-2d72d7dfea8f@lunn.ch>
         <1a57cf3f867d4dfd991ef1d4024c931b@realtek.com>
 <50a8ec7dece0100c931fd187e19e14dd1ca1a0e9.camel@redhat.com>
In-Reply-To: <50a8ec7dece0100c931fd187e19e14dd1ca1a0e9.camel@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.22.228.6]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgU2VwdGVt
YmVyIDIxLCAyMDIzIDk6MzkgUE0NClsuLi5dDQo+IE9uZSBvZiB0aGUga2V5IHBvaW50cyBpbiBK
YWt1YidzIHJlcGx5IGlzIHRoYXQgdGhlIGJ1cnN0IG11c3QgZXhjZWVkDQo+IHRoZSBidWRnZXQg
YnkgYSBsaW1pdGVkIG51bWJlciBvZiBwYWNrZXRzOg0KPiANCj4gIk5vdGhpbmcgd2lsbCBleHBs
b2RlIGlmIHdlIHByb2Nlc3MgYSBmZXcgbW9yZSBwYWNrZXRzIHRoYW4gYnVkZ2V0DQo+IChhc3N1
bWluZyBidWRnZXQgPiAwKSINCj4gDQo+IEhvdyBtYW55IHBhY2tldHMgY2FuIGNvbnRhaW4gYXQg
bW9zdCBhIHNpbmdsZSBVUkI/DQoNCkkgdGhpbmsgaXQgZGVwZW5kcyBvbg0KMS4gaWYgdGhlIHBh
Y2tldHMgY29taW5nIGNvbnRpbnVhbGx5DQoyLiB0aGUgc2l6ZSBvZiB0aGUgcGFja2V0DQoNClRo
ZSBVUkIgd291bGQgYmUgY29tcGxldGVkIHdoZW4NCjEuIHRoZSBkZXZpY2UgZG9lc24ndCByZWNl
aXZlIGFueSBwYWNrZXQgZHVyaW5nIHNldmVyYWwgdXMuDQoyLiB0aGUgZGVzaXJlZCBzaXplIGlz
IHJlYWNoZWQuDQoNCkZvciAyLjVHIE5JQyB3aXRoIHRoZSBwYWNrZXRzIG9mIDE1MTQgYnl0ZXMs
IGEgdXJiIGF0IG1vc3QgY29udGFpbnMgYWJvdXQgMjEgcGFja2V0cy4NCklmIGFsbCBwYWNrZXQg
YXJlIDYwIGJ5dGVzLCB0aGUgbnVtYmVyIHdvdWxkIGJlIGFib3V0IDM5MC4NCklmIHRoZSBhdmVy
YWdlIHNpemUgb2YgdGhlIHBhY2tldHMgaXMgNDg4IGJ5dGVzLCB0aGUgbnVtYmVyIGlzIGFib3V0
IDY0Lg0KDQo+IElmIHRoYXQgbnVtYmVyIGNhbiBiZSBzaWduaWZpY2FudCBncmVhdGVyIHRoZW4g
dGhlIG5hcGkgYnVkZ2V0LCBJIHRoaW5rDQo+IHdlIGFyZSBiZXR0ZXIgb2ZmIGtlZXBpbmcgdGhl
IHBhY2tldCBpbiB0aGUgcXVldWUgLSBvdGhlcndpc2UgdGhlIHdob2xlDQo+IHN5c3RlbSBsYXRl
bmN5L3N0YWJpbGl0eSB3b3VsZCBiZSBhZmZlY3RlZC4NCg0KU2hvdWxkIEkgZ28gYmFjayB0aGUg
cGF0Y2ggd2l0aCBxdWV1aW5nIHRoZSByeCBwYWNrZXQgaW4gZHJpdmVyPw0KDQpCZXN0IFJlZ2Fy
ZHMsDQpIYXllcw0KDQo=

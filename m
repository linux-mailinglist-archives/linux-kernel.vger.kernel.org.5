Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B4B7928F5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350457AbjIEQYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354301AbjIEKiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:38:18 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B3891E8;
        Tue,  5 Sep 2023 03:38:13 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 385AbJBS1008732, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 385AbJBS1008732
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Sep 2023 18:37:19 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 5 Sep 2023 18:37:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 5 Sep 2023 18:37:45 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c]) by
 RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c%5]) with mapi id
 15.01.2375.007; Tue, 5 Sep 2023 18:37:45 +0800
From:   Hayes Wang <hayeswang@realtek.com>
To:     Paolo Abeni <pabeni@redhat.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        nic_swsd <nic_swsd@realtek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH net] r8152: avoid the driver drops a lot of packets
Thread-Topic: [PATCH net] r8152: avoid the driver drops a lot of packets
Thread-Index: AQHZ3ynCVnk5WSMfQUWpVA7+s1E7KrALfhaAgACIBVA=
Date:   Tue, 5 Sep 2023 10:37:45 +0000
Message-ID: <48d03f3134bf49c0b04b34464cd7487b@realtek.com>
References: <20230904121706.7132-420-nic_swsd@realtek.com>
 <32c71d3245127b4aa02b8abd75edcb8f5767e966.camel@redhat.com>
In-Reply-To: <32c71d3245127b4aa02b8abd75edcb8f5767e966.camel@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.228.6]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1i
ZXIgNSwgMjAyMyA2OjExIFBNDQpbLi4uXQ0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAvKiBs
aW1pdCB0aGUgc2tiIG51bWJlcnMgZm9yIHJ4X3F1ZXVlICovDQo+ID4gLSAgICAgICAgICAgICAg
ICAgICAgIGlmICh1bmxpa2VseShza2JfcXVldWVfbGVuKCZ0cC0+cnhfcXVldWUpID49DQo+IDEw
MDApKQ0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+IC0NCj4g
DQo+IERyb3BwaW5nIHRoaXMgY2hlY2sgbG9va3MgZGFuZ2Vyb3VzIHRvIG1lLiBXaGF0IGlmIHBh
dXNlIGZyYW1lcyBhcmUNCj4gZGlzYWJsZWQgb24gdGhlIG90aGVyIGVuZCBvciBkcm9wcGVkPyBJ
dCBsb29rcyBsaWtlIHRoaXMgd291bGQgY2F1c2UNCj4gdW5saW1pdGVkIG1lbW9yeSBjb25zdW1w
dGlvbj8hPw0KDQpXaGVuIHRoZSBkcml2ZXIgc3RvcHMgc3VibWl0dGluZyByeCwgdGhlIGRyaXZl
ciB3b3VsZG4ndCBnZXQgYW55IHBhY2tldA0KZnJvbSB0aGUgZGV2aWNlIGFmdGVyIHRoZSBwcmV2
aW91cyB1cmJzIHdoaWNoIGhhdmUgYmVlbiBzdWJtaXR0ZWQgcmV0dXJuLg0KVGhhdCBpcywgc2ti
X3F1ZXVlX2xlbigmdHAtPnJ4X3F1ZXVlKSB3b3VsZG4ndCBpbmNyZWFzZSBhbnkgbW9yZSB1bnRp
bA0KdGhlIGRyaXZlciBzdGFydHMgc3VibWl0dGluZyByeCBhZ2Fpbi4NCg0KTm93LCB0aGUgZHJp
dmVyIHN0b3BzIHN1Ym1pdHRpbmcgcnggd2hlbiB0aGUgc2tiX3F1ZXVlX2xlbiBtb3JlIHRoYW4g
MjU2LA0Kc28gdGhlIGNoZWNrIGJlY29tZXMgcmVkdW5kYW50LiBUaGUgc2tiX3F1ZXVlX2xlbiBo
YXMgYmVlbiBsaW1pdGVkIGxlc3MNCnRoYW4gMTAwMC4NCg0KQmVzaWRlcywgaWYgdGhlIGZsb3cg
Y29udHJvbCBpcyBkaXNhYmxlZCwgdGhlIHBhY2tldHMgbWF5IGJlIGRyb3BwZWQgYnkNCnRoZSBo
YXJkd2FyZSB3aGVuIHRoZSBGSUZPIG9mIHRoZSBkZXZpY2UgaXMgZnVsbCwgYWZ0ZXIgdGhlIGRy
aXZlciBzdG9wcw0Kc3VibWl0dGluZyByeC4NCg0KQmVzdCBSZWdhcmRzLA0KSGF5ZXMNCg0K

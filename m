Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B7E792B40
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245734AbjIEQuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354622AbjIEM6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 08:58:47 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23E5CE9;
        Tue,  5 Sep 2023 05:58:40 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 385CvqzO7024338, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 385CvqzO7024338
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Sep 2023 20:57:52 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 5 Sep 2023 20:58:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 5 Sep 2023 20:58:18 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c]) by
 RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c%5]) with mapi id
 15.01.2375.007; Tue, 5 Sep 2023 20:58:18 +0800
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
Thread-Index: AQHZ3ynCVnk5WSMfQUWpVA7+s1E7KrALfhaAgACIBVD//4uUAIAAmlPQ
Date:   Tue, 5 Sep 2023 12:58:18 +0000
Message-ID: <d46e648ffb2846bea6d7066673135ca0@realtek.com>
References: <20230904121706.7132-420-nic_swsd@realtek.com>
         <32c71d3245127b4aa02b8abd75edcb8f5767e966.camel@redhat.com>
         <48d03f3134bf49c0b04b34464cd7487b@realtek.com>
 <223569649ad4ded66786fcc424156b2115b8ccd8.camel@redhat.com>
In-Reply-To: <223569649ad4ded66786fcc424156b2115b8ccd8.camel@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.228.6]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
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
ZXIgNSwgMjAyMyA3OjIxIFBNDQpbLi4uXQ0KPiBJJ20gc29ycnksIEkgaGF2ZSBhIHZlcnkgc3Vw
ZXJmaWNpYWwga25vd2xlZGdlIG9mIHRoZSBVU0IgbGF5ZXIsIGJ1dCBpdA0KPiBsb29rcyBsaWtl
IHRoYXQgd2hlbiBzdWNoIGNvbmRpdGlvbiBpcyByZWFjaGVkLCBpbiB0aGUgd29yc3QgY29uZGl0
aW9uDQo+IHRoZXJlIGNvdWxkIGJlIHVwIHRvIHVyYnMgaW4gZmxpZ2h0LiBBRkFJQ1MgZWFjaCBv
ZiB0aGVtIGNhcnJpZXMgYSAxNksNCj4gYnVmZmVyLCBjYW4gYmUgdXAgdG8gMTAgc3RhbmRhcmQt
bXR1IHBhY2tldHMgLSBvciBtdWNoIG1vcmUgc21hbGwgb25lcy4NCj4gDQo+IFNldHRpbmcgYW4g
dXBwZXIgbGltaXRzIHRvIHRoZSByeF9xdWV1ZSBzdGlsbCBsb29rcyBsaWtlIGEgcmVhc29uYWJs
ZQ0KPiBzYWZlZ3VhcmQuDQoNCkkgdGhpbmsgaXQgaXMgdmVyeSBoYXJkIHRvIHF1ZXVlIG1vcmUg
dGhhbiAxMDAwIHBhY2tldHMuIFRoZSBOQVBJIGNvbnRpbnVlcw0KY29uc3VtaW5nIHRoZSBxdWV1
ZWQgcGFja2V0cy4gQW5kLCB0aGUgaGFyZHdhcmUgd291bGRuJ3QgY29tcGxldGUgYWxsDQp1cmJz
IGF0IG9uZSB0aW1lLiBIb3dldmVyLCBJIHdvdWxkIGFkZCBXQVJOX09OX09OQ0UoKSB0byBvYnNl
cnZlIGlmIA0KYW55IGV4Y2VwdGlvbiB3b3VsZCBvY2N1ci4NCg0KPiA+IEJlc2lkZXMsIGlmIHRo
ZSBmbG93IGNvbnRyb2wgaXMgZGlzYWJsZWQsIHRoZSBwYWNrZXRzIG1heSBiZSBkcm9wcGVkIGJ5
DQo+ID4gdGhlIGhhcmR3YXJlIHdoZW4gdGhlIEZJRk8gb2YgdGhlIGRldmljZSBpcyBmdWxsLCBh
ZnRlciB0aGUgZHJpdmVyIHN0b3BzDQo+ID4gc3VibWl0dGluZyByeC4NCj4gDQo+IElmIHRoZSBp
bmNvbWluZyByYXRlIGV4Y2VlZHMgdGhlIEgvVyBwcm9jZXNzaW5nIGNhcGFjaXR5LCBwYWNrZXRz
IGFyZQ0KPiBkcm9wcGVkOiB0aGF0IGlzIGV4cGVjdGVkIGFuZCB1bmF2b2lkYWJsZS4NCj4gDQo+
IFBvc3NpYmx5IGV4cG9zaW5nIHRoZSByb290IGNhdXNlIGZvciBzdWNoIGRyb3BzIHRvIHVzZXIg
c3BhY2UgdmlhDQo+IGFwcHJvcHJpYXRlIHN0YXRzIHdvdWxkIGJlIHVzZWZ1bC4NCg0KVGhlIG51
bWJlciBvZiBwYWNrZXQgd2hpY2ggdGhlIGRldmljZSBkcm9wcyBjb3VsZCBiZSBnb3QgdGhyb3Vn
aA0KZXRodG9vbC4NCg0KQmVzdCBSZWdhcmRzLA0KSGF5ZXMNCg0KDQo=

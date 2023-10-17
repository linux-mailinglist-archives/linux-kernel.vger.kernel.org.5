Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F2C7CC401
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343667AbjJQNIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234953AbjJQNIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:08:36 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADC2ED;
        Tue, 17 Oct 2023 06:08:33 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39HD7HGo8038602, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39HD7HGo8038602
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 21:07:17 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 17 Oct 2023 21:07:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 17 Oct 2023 21:07:18 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Tue, 17 Oct 2023 21:07:17 +0800
From:   Hayes Wang <hayeswang@realtek.com>
To:     "'Doug Anderson'" <dianders@chromium.org>
CC:     "'Jakub Kicinski'" <kuba@kernel.org>,
        "'David S . Miller'" <davem@davemloft.net>,
        "'Alan Stern'" <stern@rowland.harvard.edu>,
        "'Simon Horman'" <horms@kernel.org>,
        "'Edward Hill'" <ecgh@chromium.org>,
        "'Laura Nao'" <laura.nao@collabora.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "'Grant Grundler'" <grundler@chromium.org>,
        =?utf-8?B?J0Jqw7hybiBNb3JrJw==?= <bjorn@mork.no>,
        "'Eric Dumazet'" <edumazet@google.com>,
        "'Paolo Abeni'" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH v3 5/5] r8152: Block future register access if register access fails
Thread-Topic: [PATCH v3 5/5] r8152: Block future register access if register
 access fails
Thread-Index: AQHZ/UKPr2uppqw2y0WH24Vf4SC1orBMGX/AgAAGioCAAVSUAA==
Date:   Tue, 17 Oct 2023 13:07:17 +0000
Message-ID: <052401da00fa$dacccd90$906668b0$@realtek.com>
References: <20231012192552.3900360-1-dianders@chromium.org>
 <20231012122458.v3.5.Ib2affdbfdc2527aaeef9b46d4f23f7c04147faeb@changeid>
 <29f9a2ff1979406489213909b940184f@realtek.com>
 <CAD=FV=U4rGozXHoK8+ejPgRtyoACy1971ftoatQivqzk2tk5ng@mail.gmail.com>
In-Reply-To: <CAD=FV=U4rGozXHoK8+ejPgRtyoACy1971ftoatQivqzk2tk5ng@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-ms-exchange-messagesentrepresentingtype: 1
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <4DC78EF98E3BE34C8DB0D4C57C8716A5@realtek.com>
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

RG91ZyBBbmRlcnNvbiA8ZGlhbmRlcnNAY2hyb21pdW0ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBP
Y3RvYmVyIDE3LCAyMDIzIDEyOjQ3IEFNDQpbLi4uDQo+ID4gPiAgc3RhdGljIGludCBnZW5lcmlj
X29jcF9yZWFkKHN0cnVjdCByODE1MiAqdHAsIHUxNiBpbmRleCwgdTE2IHNpemUsDQo+ID4gPiBA
QCAtODI2NSw2ICs4MzUzLDE5IEBAIHN0YXRpYyBpbnQgcnRsODE1Ml9wcmVfcmVzZXQoc3RydWN0
DQo+IHVzYl9pbnRlcmZhY2UNCj4gPiA+ICppbnRmKQ0KPiA+ID4gICAgICAgICBpZiAoIXRwKQ0K
PiA+ID4gICAgICAgICAgICAgICAgIHJldHVybiAwOw0KPiA+ID4NCj4gPiA+ICsgICAgICAgLyog
V2UgY2FuIG9ubHkgdXNlIHRoZSBvcHRpbWl6ZWQgcmVzZXQgaWYgd2UgbWFkZSBpdCB0byB0aGUg
ZW5kIG9mDQo+ID4gPiArICAgICAgICAqIHByb2JlIHdpdGhvdXQgYW55IHJlZ2lzdGVyIGFjY2Vz
cyBmYWlscywgd2hpY2ggc2V0cw0KPiA+ID4gKyAgICAgICAgKiBgUFJPQkVEX1dJVEhfTk9fRVJS
T1JTYCB0byB0cnVlLiBJZiB3ZSBkaWRuJ3QgaGF2ZSB0aGF0IHRoZW4gcmV0dXJuDQo+ID4gPiAr
ICAgICAgICAqIGFuIGVycm9yIGhlcmUgd2hpY2ggdGVsbHMgdGhlIFVTQiBmcmFtZXdvcmsgdG8g
ZnVsbHkgdW5iaW5kL3JlYmluZA0KPiA+ID4gKyAgICAgICAgKiBvdXIgZHJpdmVyLg0KPiA+DQo+
ID4gV291bGQgeW91IHN0YXkgaW4gYSBsb29wIG9mIHVuYmluZCBhbmQgcmViaW5kLA0KPiA+IGlm
IHRoZSBjb250cm9sIHRyYW5zZmVycyBpbiB0aGUgcHJvYmUoKSBhcmUgbm90IGFsd2F5cyBzdWNj
ZXNzZnVsPw0KPiA+IEkganVzdCB0aGluayBhYm91dCB0aGUgd29yc3QgY2FzZSB0aGF0IGF0IGxl
YXN0IG9uZSBjb250cm9sIGFsd2F5cyBmYWlscyBpbiBwcm9iZSgpLg0KPiANCj4gV2Ugd29uJ3Qh
IDotKSBPbmUgb2YgdGhlIGZpcnN0IHRoaW5ncyB0aGF0IHJ0bDgxNTJfcHJvYmUoKSBkb2VzIGlz
IHRvDQo+IGNhbGwgcnRsODE1Ml9nZXRfdmVyc2lvbigpLiBUaGF0IGdvZXMgdGhyb3VnaCB0bw0K
PiBydGw4MTUyX2dldF92ZXJzaW9uKCkuIFRoYXQgZnVuY3Rpb24gX2RvZXNuJ3RfIHF1ZXVlIHVw
IGEgcmVzZXQgaWYNCj4gdGhlcmUgYXJlIGNvbW11bmljYXRpb24gcHJvYmxlbXMsIGJ1dCBpdCBk
b2VzIGRvIDMgcmV0cmllcyBvZiB0aGUNCj4gcmVhZC4gU28gaWYgYWxsIDMgcmVhZHMgZmFpbCB0
aGVuIHdlIHdpbGwgcGVybWFuZW50bHkgZmFpbCBwcm9iZSwNCj4gd2hpY2ggSSB0aGluayBpcyB0
aGUgY29ycmVjdCB0aGluZyB0byBkby4NCg0KVGhlIHByb2JlKCkgY29udGFpbnMgY29udHJvbCB0
cmFuc2ZlcnMgaW4NCgkxLiBydGw4MTUyX2dldF92ZXJzaW9uKCkNCgkyLiB0cC0+cnRsX29wcy5p
bml0KCkNCg0KSWYgb25lIG9mIHRoZSAzIGNvbnRyb2wgdHJhbnNmZXJzIGluIDEpIGlzIHN1Y2Nl
c3NmdWwgQU5EDQphbnkgY29udHJvbCB0cmFuc2ZlciBpbiAyKSBmYWlscywNCnlvdSB3b3VsZCBx
dWV1ZSBhIHVzYiByZXNldCB3aGljaCB3b3VsZCB1bmJpbmQvcmViaW5kIHRoZSBkcml2ZXIuDQpU
aGVuLCB0aGUgbG9vcCBzdGFydHMuDQpUaGUgbG9vcCB3b3VsZCBiZSBicm9rZW4sIGlmIGFuZCBv
bmx5IGlmDQoJYSkgYWxsIGNvbnRyb2wgdHJhbnNmZXJzIGluIDEpIGZhaWwsIE9SDQoJYikgYWxs
IGNvbnRyb2wgdHJhbnNmZXJzIGluIDIpIHN1Y2NlZWQuDQoNClRoYXQgaXMsIHRoZSBsb29wIHdv
dWxkIGJlIGJyb2tlbiB3aGVuIHRoZSBmYWlsIHJhdGUgb2YgdGhlIGNvbnRyb2wgdHJhbnNmZXIg
aXMgaGlnaCBvciBsb3cgZW5vdWdoLg0KT3RoZXJ3aXNlLCB5b3Ugd291bGQgcXVldWUgYSB1c2Ig
cmVzZXQgYWdhaW4gYW5kIGFnYWluLg0KRm9yIGV4YW1wbGUsIGlmIHRoZSBmYWlsIHJhdGUgb2Yg
dGhlIGNvbnRyb2wgdHJhbnNmZXIgaXMgMTAlIH4gNjAlLA0KSSB0aGluayB5b3UgaGF2ZSBoaWdo
IHByb2JhYmlsaXR5IHRvIGtlZXAgdGhlIGxvb3AgY29udGludWFsbHkuDQpXb3VsZCBpdCBuZXZl
ciBoYXBwZW4/DQoNCkJlc3QgUmVnYXJkcywNCkhheWVzDQoNCg0K

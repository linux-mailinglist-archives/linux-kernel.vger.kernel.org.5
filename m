Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6964F7CDADC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjJRLlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjJRLlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:41:40 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27A2111;
        Wed, 18 Oct 2023 04:41:38 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39IBepoP71505718, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39IBepoP71505718
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 19:40:51 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 18 Oct 2023 19:40:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 18 Oct 2023 19:40:50 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Wed, 18 Oct 2023 19:40:50 +0800
From:   Hayes Wang <hayeswang@realtek.com>
To:     Doug Anderson <dianders@chromium.org>
CC:     Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Simon Horman <horms@kernel.org>,
        Edward Hill <ecgh@chromium.org>,
        Laura Nao <laura.nao@collabora.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Grant Grundler <grundler@chromium.org>,
        =?utf-8?B?QmrDuHJuIE1vcms=?= <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH v3 5/5] r8152: Block future register access if register access fails
Thread-Topic: [PATCH v3 5/5] r8152: Block future register access if register
 access fails
Thread-Index: AQHZ/UKPr2uppqw2y0WH24Vf4SC1orBMGX/AgAAGioCAAVSUAIAAE/SAgAGw82A=
Date:   Wed, 18 Oct 2023 11:40:50 +0000
Message-ID: <34d7d7c7b5914674b55a6dc21ced1190@realtek.com>
References: <20231012192552.3900360-1-dianders@chromium.org>
 <20231012122458.v3.5.Ib2affdbfdc2527aaeef9b46d4f23f7c04147faeb@changeid>
 <29f9a2ff1979406489213909b940184f@realtek.com>
 <CAD=FV=U4rGozXHoK8+ejPgRtyoACy1971ftoatQivqzk2tk5ng@mail.gmail.com>
 <052401da00fa$dacccd90$906668b0$@realtek.com>
 <CAD=FV=XQswgKZh-JQ6PuKGRmrDMfDmZwM+MUpAcOk1=7Ppjyiw@mail.gmail.com>
In-Reply-To: <CAD=FV=XQswgKZh-JQ6PuKGRmrDMfDmZwM+MUpAcOk1=7Ppjyiw@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.22.228.6]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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

RG91ZyBBbmRlcnNvbiA8ZGlhbmRlcnNAY2hyb21pdW0ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBP
Y3RvYmVyIDE3LCAyMDIzIDEwOjE3IFBNDQpbLi4uXQ0KPiA+IFRoYXQgaXMsIHRoZSBsb29wIHdv
dWxkIGJlIGJyb2tlbiB3aGVuIHRoZSBmYWlsIHJhdGUgb2YgdGhlIGNvbnRyb2wgdHJhbnNmZXIg
aXMgaGlnaCBvciBsb3cgZW5vdWdoLg0KPiA+IE90aGVyd2lzZSwgeW91IHdvdWxkIHF1ZXVlIGEg
dXNiIHJlc2V0IGFnYWluIGFuZCBhZ2Fpbi4NCj4gPiBGb3IgZXhhbXBsZSwgaWYgdGhlIGZhaWwg
cmF0ZSBvZiB0aGUgY29udHJvbCB0cmFuc2ZlciBpcyAxMCUgfiA2MCUsDQo+ID4gSSB0aGluayB5
b3UgaGF2ZSBoaWdoIHByb2JhYmlsaXR5IHRvIGtlZXAgdGhlIGxvb3AgY29udGludWFsbHkuDQo+
ID4gV291bGQgaXQgbmV2ZXIgaGFwcGVuPw0KPiANCj4gQWN0dWFsbHksIGV2ZW4gd2l0aCBhIGZh
aWx1cmUgcmF0ZSBvZiAxMCUgSSBkb24ndCB0aGluayB5b3UnbGwgZW5kIHVwDQo+IHdpdGggYSBm
dWxseSBjb250aW51b3VzIGxvb3AsIHJpZ2h0PyBBbGwgeW91IG5lZWQgaXMgdG8gZ2V0IDMgZmFp
bHVyZXMNCj4gaW4gYSByb3cgaW4gcnRsODE1Ml9nZXRfdmVyc2lvbigpIHRvIGdldCBvdXQgb2Yg
dGhlIGxvb3AuIFNvIHdpdGggYQ0KPiAxMCUgZmFpbHVyZSByYXRlIHlvdSdkIHVuYmluZC9iaW5k
IDEwMDAgdGltZXMgKG9uIGF2ZXJhZ2UpIGFuZCB0aGVuDQo+IChmaW5hbGx5KSBnaXZlIHVwLiBX
aXRoIGEgNTAlIGZhaWx1cmUgcmF0ZSBJIHRoaW5rIHlvdSdkIG9ubHkNCj4gdW5iaW5kL2JpbmQg
OCB0aW1lcyBvbiBhdmVyYWdlLCByaWdodD8gT2YgY291cnNlLCBJIGd1ZXNzIDEwMDAgbG9vcHMN
Cj4gaXMgcHJldHR5IGNsb3NlIHRvIGluZmluaXRlLg0KPiANCj4gSW4gYW55IGNhc2UsIHdlIGhh
dmVuJ3QgYWN0dWFsbHkgc2VlbiBoYXJkd2FyZSB0aGF0IGZhaWxzIGxpa2UgdGhpcy4NCj4gV2Un
dmUgc2VlbiBmYWlsdXJlIHJhdGVzIHRoYXQgYXJlIG11Y2ggbXVjaCBsb3dlciBhbmQgd2UgY2Fu
IGltYWdpbmUNCj4gZmFpbHVyZSByYXRlcyB0aGF0IGFyZSAxMDAlIGlmIHdlJ3JlIGdvdCByZWFs
bHkgYnJva2VuIGhhcmR3YXJlLiBEbw0KPiB5b3UgdGhpbmsgY2FzZXMgd2hlcmUgZmFpbHVyZSBy
YXRlcyBhcmUgbWlkZGxlLW9mLXRoZS1yb2FkIGFyZSBsaWtlbHk/DQoNClRoYXQgaXMgbXkgcXVl
c3Rpb24sIHRvby4NCkkgZG9uJ3Qga25vdyBpZiBzb21ldGhpbmcgd291bGQgY2F1c2UgdGhlIHNp
dHVhdGlvbiwgZWl0aGVyLg0KVGhpcyBpcyBvdXQgb2YgbXkga25vd2xlZGdlLg0KSSBhbSB3YWl0
aW5nIGZvciB0aGUgcHJvZmVzc2lvbmFsIGFuc3dlcnMsIHRvby4NCg0KQSBsb3Qgb2YgcmVhc29u
cyBtYXkgY2F1c2UgdGhlIGZhaWwgb2YgdGhlIGNvbnRyb2wgdHJhbnNmZXIuDQpJIGRvbid0IGhh
dmUgYWxsIG9mIHRoZSByZWFsIHNpdHVhdGlvbiB0byBhbmFseXplIHRoZW0uDQpUaGVyZWZvcmUs
IHdoYXQgSSBjb3VsZCBkbyBpcyB0byBhc3N1bWUgZGlmZmVyZW50IHNpdHVhdGlvbnMuDQpZb3Ug
Y291bGQgc2F5IG15IGh5cG90aGVzZXMgYXJlIHVucmVhc29uYWJsZS4NCkhvd2V2ZXIsIEkgaGF2
ZSB0byB0ZWxsIHlvdSB3aGF0IEkgd29ycnkuDQoNCj4gSSB3b3VsZCBhbHNvIHNheSB0aGF0IG5v
dGhpbmcgd2UgY2FuIGRvIGNhbiBwZXJmZWN0bHkgaGFuZGxlIGZhdWx0eQ0KPiBoYXJkd2FyZS4g
SWYgd2UncmUgaW1hZ2luaW5nIHRoZW9yZXRpY2FsIGhhcmR3YXJlLCB3ZSBjb3VsZCBpbWFnaW5l
DQo+IHRoZW9yZXRpY2FsIGhhcmR3YXJlIHRoYXQgZGUtZW51bWVyYXRlZCBpdHNlbGYgYW5kIHJl
LWVudW1lcmF0ZWQNCj4gaXRzZWxmIGV2ZXJ5IGhhbGYgc2Vjb25kIGJlY2F1c2UgdGhlIGZpcm13
YXJlIG9uIHRoZSBkZXZpY2UgY3Jhc2hlZCBvcg0KPiBzb21lIHJlZ3VsYXRvciBrZXB0IGRyb3Bw
aW5nLiBUaGlzIGZhdWx0eSBoYXJkd2FyZSB3b3VsZCBhbHNvIGNhdXNlIGFuDQo+IGluZmluaXRl
IGxvb3Agb2YgZGUtZW51bWVyYXRpb24gYW5kIHJlLWVudW1lcmF0aW9uLCByaWdodD8NCj4gDQo+
IFByZXN1bWFibHkgaWYgd2UgZ2V0IGludG8gZWl0aGVyIGNhc2UsIHRoZSB1c2VyIHdpbGwgcmVh
bGl6ZSB0aGF0IHRoZQ0KPiBoYXJkd2FyZSBpc24ndCB3b3JraW5nIGFuZCB3aWxsIHVucGx1ZyBp
dCBmcm9tIHRoZSBzeXN0ZW0uIFdoaWxlIHRoZQ0KDQpTb21lIG9mIG91ciBkZXZpY2VzIGFyZSBv
bmJvYXJkLiBUaGF0IGlzLCB0aGV5IGNvdWxkbid0IGJlIHVucGx1Z2dlZC4NClRoYXQgaXMgd2h5
IEkgaGF2ZSB0byBjb25zaWRlciBhIGxvdCBvZiBzaXR1YXRpb25zLg0KDQo+IHN5c3RlbSBpcyBk
b2luZyB0aGUgbG9vcCBvZiB0cnlpbmcgdG8gZW51bWVyYXRlIHRoZSBoYXJkd2FyZSwgaXQgd2ls
bA0KPiBiZSB0YWtpbmcgdXAgYSBidW5jaCBvZiBleHRyYSBDUFUgY3ljbGVzIGJ1dCAoSSBiZWxp
ZXZlKSBpdCB3b24ndCBiZQ0KPiBmdWxseSBsb2NrZWQgdXAgb3IgYW55dGhpbmcuIFRoZSBtYWNo
aW5lIHdpbGwgc3RpbGwgZnVuY3Rpb24gYW5kIGJlDQo+IGFibGUgdG8gZG8gbm9uLUV0aGVybmV0
IGFjdGl2aXRpZXMsIHJpZ2h0PyBJIHdvdWxkIHNheSB0aGF0IHRoZSB3b3JzdA0KPiB0aGluZyBh
Ym91dCB0aGlzIHN0YXRlIHdvdWxkIGJlIHRoYXQgaXQgd291bGQgc3RyZXNzIGNvcm5lciBjYXNl
cyBpbg0KPiB0aGUgcmVzZXQgb2YgdGhlIFVTQiBzdWJzeXN0ZW0sIHBvc3NpYmx5IHRpY2tpbmcg
YnVncy4NCj4gDQo+IFNvIEkgZ3Vlc3MgSSB3b3VsZCBzdW1tYXJpemUgYWxsIHRoZSBhYm92ZSBh
czoNCj4gDQo+IElmIGhhcmR3YXJlIGlzIGJyb2tlbiBpbiBqdXN0IHRoZSByaWdodCB3YXkgdGhl
biB0aGlzIHBhdGNoIGNvdWxkDQo+IGNhdXNlIGEgbmVhcmx5IGluZmluaXRlIHVuYmluZGluZy9y
ZWJpbmRpbmcgb2YgdGhlIHI4MTUyIGRyaXZlci4NCj4gSG93ZXZlcjoNCj4gDQo+IDEuIEl0IGRv
ZXNuJ3Qgc2VlbSB0ZXJyaWJseSBsaWtlbHkgZm9yIGhhcmR3YXJlIHRvIGJlIGJyb2tlbiBpbiBq
dXN0IHRoaXMgd2F5Lg0KPiANCj4gMi4gV2UgaGF2ZW4ndCBzZWVuIGhhcmR3YXJlIGJyb2tlbiBp
biBqdXN0IHRoaXMgd2F5Lg0KPiANCj4gMy4gSGFyZHdhcmUgYnJva2VuIGluIGEgc2xpZ2h0bHkg
ZGlmZmVyZW50IHdheSBjb3VsZCBjYXVzZSBpbmZpbml0ZQ0KPiB1bmJpbmRpbmcvcmViaW5kaW5n
IGV2ZW4gd2l0aG91dCB0aGlzIHBhdGNoLg0KPiANCj4gNC4gSW5maW5pdGUgdW5iaW5kaW5nL3Jl
YmluZGluZyBvZiBhIFVTQiBhZGFwdGVyIGlzbid0IGdyZWF0LCBidXQgbm90DQo+IHRoZSBhYnNv
bHV0ZSB3b3JzdCB0aGluZy4NCg0KSXQgaXMgZmluZSBpZiBldmVyeW9uZSBhZ3JlZXMgdGhlc2Uu
DQoNCkJlc3QgUmVnYXJkcywNCkhheWVzDQoNCg==

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8C87BAECC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 00:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjJEWZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 18:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjJEWZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 18:25:43 -0400
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A8295;
        Thu,  5 Oct 2023 15:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1696544737; x=1728080737;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=4lNRmXT4BmRQ3teTJfK+a/+f+iw/5qUJ9Zfro83P9FA=;
  b=Dfn+AjghG51/Xn/m6Mt/AfDjZ/AY8a+vph9sPpbOvUoV5WGvY3T5gqSf
   I/54e7xcKvtibOocGNmc0oC2eQSVOlpT+B+uzuVIM4ogK/rMoOfpWThXm
   3Is6kcXrbuXW512H3yoMHVW/3J0ryU+g0Zjg7LSdOCsNe+jsxfqROy+Qm
   k=;
X-IronPort-AV: E=Sophos;i="6.03,203,1694736000"; 
   d="scan'208";a="360362503"
Subject: RE: [PATCH] net: ena: replace deprecated strncpy with strscpy
Thread-Topic: [PATCH] net: ena: replace deprecated strncpy with strscpy
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 22:25:34 +0000
Received: from EX19D015EUA003.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com (Postfix) with ESMTPS id 8C2E248422;
        Thu,  5 Oct 2023 22:25:32 +0000 (UTC)
Received: from EX19D047EUA003.ant.amazon.com (10.252.50.160) by
 EX19D015EUA003.ant.amazon.com (10.252.50.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 5 Oct 2023 22:25:31 +0000
Received: from EX19D022EUA002.ant.amazon.com (10.252.50.201) by
 EX19D047EUA003.ant.amazon.com (10.252.50.160) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 5 Oct 2023 22:25:31 +0000
Received: from EX19D022EUA002.ant.amazon.com ([fe80::7f87:7d63:def0:157d]) by
 EX19D022EUA002.ant.amazon.com ([fe80::7f87:7d63:def0:157d%3]) with mapi id
 15.02.1118.037; Thu, 5 Oct 2023 22:25:31 +0000
From:   "Kiyanovski, Arthur" <akiyano@amazon.com>
To:     Justin Stitt <justinstitt@google.com>,
        "Agroskin, Shay" <shayagr@amazon.com>,
        "Arinzon, David" <darinzon@amazon.com>,
        "Dagan, Noam" <ndagan@amazon.com>,
        "Bshara, Saeed" <saeedb@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Thread-Index: AQHZ9ybKM2b6eyqkVE+Gavzwy9pPV7A7w5Hw
Date:   Thu, 5 Oct 2023 22:25:08 +0000
Deferred-Delivery: Thu, 5 Oct 2023 22:24:26 +0000
Message-ID: <fe65f57f91f342c7a173891b84cda37b@amazon.com>
References: <20231005-strncpy-drivers-net-ethernet-amazon-ena-ena_netdev-c-v1-1-ba4879974160@google.com>
In-Reply-To: <20231005-strncpy-drivers-net-ethernet-amazon-ena-ena_netdev-c-v1-1-ba4879974160@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.85.143.172]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKdXN0aW4gU3RpdHQgPGp1c3Rp
bnN0aXR0QGdvb2dsZS5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDUsIDIwMjMgMzo1
NiBBTQ0KPiBUbzogQWdyb3NraW4sIFNoYXkgPHNoYXlhZ3JAYW1hem9uLmNvbT47IEtpeWFub3Zz
a2ksIEFydGh1cg0KPiA8YWtpeWFub0BhbWF6b24uY29tPjsgQXJpbnpvbiwgRGF2aWQgPGRhcmlu
em9uQGFtYXpvbi5jb20+OyBEYWdhbiwNCj4gTm9hbSA8bmRhZ2FuQGFtYXpvbi5jb20+OyBCc2hh
cmEsIFNhZWVkIDxzYWVlZGJAYW1hem9uLmNvbT47IERhdmlkDQo+IFMuIE1pbGxlciA8ZGF2ZW1A
ZGF2ZW1sb2Z0Lm5ldD47IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47DQo+IEph
a3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhh
dC5jb20+DQo+IENjOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC0NCj4gaGFyZGVuaW5nQHZnZXIua2VybmVsLm9yZzsgSnVzdGluIFN0
aXR0IDxqdXN0aW5zdGl0dEBnb29nbGUuY29tPg0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFtQQVRD
SF0gbmV0OiBlbmE6IHJlcGxhY2UgZGVwcmVjYXRlZCBzdHJuY3B5IHdpdGggc3Ryc2NweQ0KPiAN
Cj4gQ0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3Jn
YW5pemF0aW9uLiBEbyBub3QgY2xpY2sNCj4gbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxl
c3MgeW91IGNhbiBjb25maXJtIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlDQo+IGNvbnRlbnQgaXMg
c2FmZS4NCj4gDQo+IA0KPiANCj4gYHN0cm5jcHlgIGlzIGRlcHJlY2F0ZWQgZm9yIHVzZSBvbiBO
VUwtdGVybWluYXRlZCBkZXN0aW5hdGlvbiBzdHJpbmdzIFsxXSBhbmQgYXMNCj4gc3VjaCB3ZSBz
aG91bGQgcHJlZmVyIG1vcmUgcm9idXN0IGFuZCBsZXNzIGFtYmlndW91cyBzdHJpbmcgaW50ZXJm
YWNlcy4NCj4gDQo+IE5VTC1wYWRkaW5nIGlzIG5vdCBuZWNlc3NhcnkgYXMgaG9zdF9pbmZvIGlz
IGluaXRpYWxpemVkIHRvIGBlbmFfZGV2LQ0KPiA+aG9zdF9hdHRyLmhvc3RfaW5mb2Agd2hpY2gg
aXMgdWx0aW1hdGVseSB6ZXJvLWluaXRpYWxpemVkIHZpYQ0KPiBhbGxvY19ldGhlcmRldl9tcSgp
Lg0KPiANCj4gQSBzdWl0YWJsZSByZXBsYWNlbWVudCBpcyBgc3Ryc2NweWAgWzJdIGR1ZSB0byB0
aGUgZmFjdCB0aGF0IGl0IGd1YXJhbnRlZXMgTlVMLQ0KPiB0ZXJtaW5hdGlvbiBvbiB0aGUgZGVz
dGluYXRpb24gYnVmZmVyIHdpdGhvdXQgdW5uZWNlc3NhcmlseSBOVUwtcGFkZGluZy4NCj4gDQo+
IExpbms6DQo+IGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwvbGF0ZXN0L3Byb2Nlc3Mv
ZGVwcmVjYXRlZC5odG1sI3N0cm5jcHktb24tDQo+IG51bC10ZXJtaW5hdGVkLXN0cmluZ3MgWzFd
DQo+IExpbms6IGh0dHBzOi8vbWFucGFnZXMuZGViaWFuLm9yZy90ZXN0aW5nL2xpbnV4LW1hbnVh
bC00Ljgvc3Ryc2NweS45LmVuLmh0bWwNCj4gWzJdDQo+IExpbms6IGh0dHBzOi8vZ2l0aHViLmNv
bS9LU1BQL2xpbnV4L2lzc3Vlcy85MA0KPiBDYzogbGludXgtaGFyZGVuaW5nQHZnZXIua2VybmVs
Lm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBKdXN0aW4gU3RpdHQgPGp1c3RpbnN0aXR0QGdvb2dsZS5j
b20+DQo+IC0tLQ0KPiBOb3RlOiBidWlsZC10ZXN0ZWQgb25seS4NCj4gLS0tDQo+ICBkcml2ZXJz
L25ldC9ldGhlcm5ldC9hbWF6b24vZW5hL2VuYV9uZXRkZXYuYyB8IDQgKystLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9hbWF6b24vZW5hL2VuYV9uZXRkZXYuYw0KPiBiL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L2FtYXpvbi9lbmEvZW5hX25ldGRldi5jDQo+IGluZGV4IGY5NTVi
ZGUxMGNmOS4uMzExOGE2MTdjOWI2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5l
dC9hbWF6b24vZW5hL2VuYV9uZXRkZXYuYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9h
bWF6b24vZW5hL2VuYV9uZXRkZXYuYw0KPiBAQCAtMzI3Niw4ICszMjc2LDggQEAgc3RhdGljIHZv
aWQgZW5hX2NvbmZpZ19ob3N0X2luZm8oc3RydWN0DQo+IGVuYV9jb21fZGV2ICplbmFfZGV2LCBz
dHJ1Y3QgcGNpX2RldiAqcGQNCj4gICAgICAgICBzdHJzY3B5KGhvc3RfaW5mby0+a2VybmVsX3Zl
cl9zdHIsIHV0c25hbWUoKS0+dmVyc2lvbiwNCj4gICAgICAgICAgICAgICAgIHNpemVvZihob3N0
X2luZm8tPmtlcm5lbF92ZXJfc3RyKSAtIDEpOw0KPiAgICAgICAgIGhvc3RfaW5mby0+b3NfZGlz
dCA9IDA7DQo+IC0gICAgICAgc3RybmNweShob3N0X2luZm8tPm9zX2Rpc3Rfc3RyLCB1dHNuYW1l
KCktPnJlbGVhc2UsDQo+IC0gICAgICAgICAgICAgICBzaXplb2YoaG9zdF9pbmZvLT5vc19kaXN0
X3N0cikgLSAxKTsNCj4gKyAgICAgICBzdHJzY3B5KGhvc3RfaW5mby0+b3NfZGlzdF9zdHIsIHV0
c25hbWUoKS0+cmVsZWFzZSwNCj4gKyAgICAgICAgICAgICAgIHNpemVvZihob3N0X2luZm8tPm9z
X2Rpc3Rfc3RyKSk7DQo+ICAgICAgICAgaG9zdF9pbmZvLT5kcml2ZXJfdmVyc2lvbiA9DQo+ICAg
ICAgICAgICAgICAgICAoRFJWX01PRFVMRV9HRU5fTUFKT1IpIHwNCj4gICAgICAgICAgICAgICAg
IChEUlZfTU9EVUxFX0dFTl9NSU5PUiA8PA0KPiBFTkFfQURNSU5fSE9TVF9JTkZPX01JTk9SX1NI
SUZUKSB8DQo+IA0KPiAtLS0NCj4gYmFzZS1jb21taXQ6IGNiZjNhMmNiMTU2YTJjOTExZDhmMzhk
ODI0NzgxNGI0YzA3ZjQ5YTINCj4gY2hhbmdlLWlkOiAyMDIzMTAwNS1zdHJuY3B5LWRyaXZlcnMt
bmV0LWV0aGVybmV0LWFtYXpvbi1lbmEtZW5hX25ldGRldi1jLQ0KPiA2YzQ4MDQ0NjZhYTcNCj4g
DQo+IEJlc3QgcmVnYXJkcywNCj4gLS0NCj4gSnVzdGluIFN0aXR0IDxqdXN0aW5zdGl0dEBnb29n
bGUuY29tPg0KPiANCg0KVGhhbmtzIGZvciBzdWJtaXR0aW5nIHRoaXMgY2hhbmdlLg0KDQpUaGUg
Y2hhbmdlIGxvb2tzIGdvb2QgYnV0IHRoZSBzZW50ZW5jZSAiTlVMLXBhZGRpbmcgaXMgbm90IG5l
Y2Vzc2FyeSBhcw0KaG9zdF9pbmZvIGlzIGluaXRpYWxpemVkIHRvIGBlbmFfZGV2LT5ob3N0X2F0
dHIuaG9zdF9pbmZvYCB3aGljaCBpcyB1bHRpbWF0ZWx5DQp6ZXJvLWluaXRpYWxpemVkIHZpYSBh
bGxvY19ldGhlcmRldl9tcSgpLiIgaXMgaW5hY2N1cmF0ZS4gDQoNCmhvc3RfaW5mbyBhbGxvY2F0
aW9uIGlzIGRvbmUgaW4gZW5hX2NvbV9hbGxvY2F0ZV9ob3N0X2luZm8oKSB2aWEgDQpkbWFfYWxs
b2NfY29oZXJlbnQoKSBhbmQgaXMgbm90IHplcm8gaW5pdGlhbGl6ZWQgYnkgYWxsb2NfZXRoZXJk
ZXZfbXEoKS4NCg0KSSBsb29rZWQgYXQgYm90aCB0aGUgZG9jdW1lbnRhdGlvbiBvZiBkbWFfYWxs
b2NfY29oZXJlbnQoKSBpbiANCmh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL0RvY3VtZW50YXRp
b24vRE1BLUFQSS50eHQNCmFzIHdlbGwgYXMgdGhlIGNvZGUgaXRzZWxmLCBhbmQgKG1heWJlIEkn
bSB3cm9uZyBidXQpIEkgZGlkbid0IHNlZSAxMDAlDQpndWFyYW50ZWVzIHRoZSB0aGF0IHRoZSBt
ZW1vcnkgaXMgemVyby1pbml0aWFsaXplZC4NCg0KSG93ZXZlciB6ZXJvIGluaXRpYWxpemF0aW9u
IG9mIHRoZSBkZXN0aW5hdGlvbiBkb2Vzbid0IG1hdHRlciBpbiB0aGlzIGNhc2UsDQpiZWNhdXNl
IHN0cnNjcHkoKSBndWFyYW50ZWVzIGEgTlVMTCB0ZXJtaW5hdGlvbi4NCg0KU28gcGxlYXNlIGp1
c3QgcmVtb3ZlIHRoaXMgc2VudGVuY2UgZnJvbSB0aGUgY29tbWl0IG1lc3NhZ2UuDQoNClRoYW5r
cywNCkFydGh1ciBLaXlhbm92c2tpDQoNCg==

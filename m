Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D437D5C25
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 22:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344167AbjJXUKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 16:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbjJXUKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 16:10:21 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE564D7D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 13:10:18 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 3A6952C0405;
        Wed, 25 Oct 2023 09:10:15 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1698178215;
        bh=sRJk5n3pDGUzZ7KoQFWruh7Nt5D3oxQPGHbRvhP453U=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=nXmdQ7TvG6V6Ot3G5CaopLK7k3M1R0/NvY4x601JHyx2ThNoxsIg4ZadcuuuhJKgv
         hDeHHGFi/j2gbtvDFjsVM9SdGL1JCsB8T5lhwD3ZNSMtzAy8dJ+OVCpZ+8HdoHVdzn
         CsR9RCtcZZj1wEJMH3XJXRy11UlNOHrnBKvsyH5rp9oaxM8+6JxWkRtbeJpuvVhRo2
         wTeX8WCfE+b/9k+M6wxwgUOT/z7kNMw9phTrYXiomfMKJtP+HFEBf4Va2RZYJfqPYz
         rMNkAHqRo5xP/cuX398jiqlqYHH2s+8PslqiAFdCgCseuSvLDC3ocw7AYS+s+y5l6o
         Hj2XbUApSuKog==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B653824a70001>; Wed, 25 Oct 2023 09:10:15 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.39; Wed, 25 Oct 2023 09:10:15 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with Microsoft
 SMTP Server (TLS) id 15.0.1497.48; Wed, 25 Oct 2023 09:10:14 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.039; Wed, 25 Oct 2023 09:10:14 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Vladimir Oltean <olteanv@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali@kernel.org>,
        Enrico Mioso <mrkiko.rs@gmail.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Russell King <linux@armlinux.org.uk>
CC:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        =?utf-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v7 5/7] ARM64: dts: marvell: Fix some common
 switch mistakes
Thread-Topic: [PATCH net-next v7 5/7] ARM64: dts: marvell: Fix some common
 switch mistakes
Thread-Index: AQHaBqfxy3RLBZSJF0yAzYSe+JPbArBYhPQA
Date:   Tue, 24 Oct 2023 20:10:14 +0000
Message-ID: <1dff08d1-339b-4d5a-9dd4-6a6daca1dbde@alliedtelesis.co.nz>
References: <20231024-marvell-88e6152-wan-led-v7-0-2869347697d1@linaro.org>
 <20231024-marvell-88e6152-wan-led-v7-5-2869347697d1@linaro.org>
 <20231024182842.flxrg3hjm3scnhjo@skbuf>
In-Reply-To: <20231024182842.flxrg3hjm3scnhjo@skbuf>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE27B8B2EB580E4F8B2132384250D130@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=L6ZjvNb8 c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=KKAkSRfTAAAA:8 a=Nrzf15qNN39qzBdrCVAA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxsLA0KDQpPbiAyNS8xMC8yMyAwNzoyOCwgVmxhZGltaXIgT2x0ZWFuIHdyb3RlOg0KPiBM
aW51cywNCj4NCj4gT24gVHVlLCBPY3QgMjQsIDIwMjMgYXQgMDM6MjA6MzFQTSArMDIwMCwgTGlu
dXMgV2FsbGVpaiB3cm90ZToNCj4+IEZpeCBzb21lIGVycm9ycyBpbiB0aGUgTWFydmVsbCBNVjg4
RTZ4eHggc3dpdGNoIGRlc2NyaXB0aW9uczoNCj4+IC0gVGhlIHRvcCBub2RlIGhhZCBubyBhZGRy
ZXNzIHNpemUgb3IgY2VsbHMuDQo+PiAtIHN3aXRjaDBAMCBpcyBub3QgT0ssIHNob3VsZCBiZSBl
dGhlcm5ldC1zd2l0Y2hAMC4NCj4+IC0gcG9ydHMgc2hvdWxkIGJlIGV0aGVybmV0LXBvcnRzDQo+
PiAtIHBvcnRAMCBzaG91bGQgYmUgZXRoZXJuZXQtcG9ydEAwDQo+PiAtIFBIWXMgc2hvdWxkIGJl
IG5hbWVkIGV0aGVybmV0LXBoeUANCj4+DQo+PiBSZXZpZXdlZC1ieTogQW5kcmV3IEx1bm4gPGFu
ZHJld0BsdW5uLmNoPg0KPj4gU2lnbmVkLW9mZi1ieTogTGludXMgV2FsbGVpaiA8bGludXMud2Fs
bGVpakBsaW5hcm8ub3JnPg0KPHNuaXA+DQo+PiAtLS0NCj4+IGRpZmYgLS1naXQgYS9hcmNoL2Fy
bTY0L2Jvb3QvZHRzL21hcnZlbGwvY245MTMwLWNyYi5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0
cy9tYXJ2ZWxsL2NuOTEzMC1jcmIuZHRzaQ0KPj4gaW5kZXggMzJjZmIzZTJlZmMzLi43NTM4ZWQ1
NjA1M2IgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvY245MTMw
LWNyYi5kdHNpDQo+PiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvY245MTMwLWNy
Yi5kdHNpDQo+PiBAQCAtMjA3LDExICsyMDcsOSBAQCBwaHkwOiBldGhlcm5ldC1waHlAMCB7DQo+
PiAgIAkJcmVnID0gPDA+Ow0KPj4gICAJfTsNCj4+ICAgDQo+PiAtCXN3aXRjaDY6IHN3aXRjaDBA
NiB7DQo+PiArCXN3aXRjaDY6IGV0aGVybmV0LXN3aXRjaEA2IHsNCj4+ICAgCQkvKiBBY3R1YWwg
ZGV2aWNlIGlzIE1WODhFNjM5M1ggKi8NCj4+ICAgCQljb21wYXRpYmxlID0gIm1hcnZlbGwsbXY4
OGU2MTkwIjsNCj4+IC0JCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPj4gLQkJI3NpemUtY2VsbHMg
PSA8MD47DQo+PiAgIAkJcmVnID0gPDY+Ow0KPj4gICAJCWludGVycnVwdC1wYXJlbnQgPSA8JmNw
MF9ncGlvMT47DQo+PiAgIAkJaW50ZXJydXB0cyA9IDwyOCBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0K
Pj4gQEAgLTIyMCw1OSArMjE4LDU5IEBAIHN3aXRjaDY6IHN3aXRjaDBANiB7DQo+PiAgIA0KPj4g
ICAJCWRzYSxtZW1iZXIgPSA8MCAwPjsNCj4+ICAgDQo+PiAtCQlwb3J0cyB7DQo+PiArCQlldGhl
cm5ldC1wb3J0cyB7DQo+PiAgIAkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPj4gICAJCQkjc2l6
ZS1jZWxscyA9IDwwPjsNCj4+ICAgDQo+PiAtCQkJcG9ydEAxIHsNCj4+ICsJCQlldGhlcm5ldC1w
b3J0QDEgew0KPj4gICAJCQkJcmVnID0gPDE+Ow0KPj4gICAJCQkJbGFiZWwgPSAicDEiOw0KPj4g
ICAJCQkJcGh5LWhhbmRsZSA9IDwmc3dpdGNoMHBoeTE+Ow0KPj4gICAJCQl9Ow0KPj4gICANCj4+
IC0JCQlwb3J0QDIgew0KPj4gKwkJCWV0aGVybmV0LXBvcnRAMiB7DQo+PiAgIAkJCQlyZWcgPSA8
Mj47DQo+PiAgIAkJCQlsYWJlbCA9ICJwMiI7DQo+PiAgIAkJCQlwaHktaGFuZGxlID0gPCZzd2l0
Y2gwcGh5Mj47DQo+PiAgIAkJCX07DQo+PiAgIA0KPj4gLQkJCXBvcnRAMyB7DQo+PiArCQkJZXRo
ZXJuZXQtcG9ydEAzIHsNCj4+ICAgCQkJCXJlZyA9IDwzPjsNCj4+ICAgCQkJCWxhYmVsID0gInAz
IjsNCj4+ICAgCQkJCXBoeS1oYW5kbGUgPSA8JnN3aXRjaDBwaHkzPjsNCj4+ICAgCQkJfTsNCj4+
ICAgDQo+PiAtCQkJcG9ydEA0IHsNCj4+ICsJCQlldGhlcm5ldC1wb3J0QDQgew0KPj4gICAJCQkJ
cmVnID0gPDQ+Ow0KPj4gICAJCQkJbGFiZWwgPSAicDQiOw0KPj4gICAJCQkJcGh5LWhhbmRsZSA9
IDwmc3dpdGNoMHBoeTQ+Ow0KPj4gICAJCQl9Ow0KPj4gICANCj4+IC0JCQlwb3J0QDUgew0KPj4g
KwkJCWV0aGVybmV0LXBvcnRANSB7DQo+PiAgIAkJCQlyZWcgPSA8NT47DQo+PiAgIAkJCQlsYWJl
bCA9ICJwNSI7DQo+PiAgIAkJCQlwaHktaGFuZGxlID0gPCZzd2l0Y2gwcGh5NT47DQo+PiAgIAkJ
CX07DQo+PiAgIA0KPj4gLQkJCXBvcnRANiB7DQo+PiArCQkJZXRoZXJuZXQtcG9ydEA2IHsNCj4+
ICAgCQkJCXJlZyA9IDw2PjsNCj4+ICAgCQkJCWxhYmVsID0gInA2IjsNCj4+ICAgCQkJCXBoeS1o
YW5kbGUgPSA8JnN3aXRjaDBwaHk2PjsNCj4+ICAgCQkJfTsNCj4+ICAgDQo+PiAtCQkJcG9ydEA3
IHsNCj4+ICsJCQlldGhlcm5ldC1wb3J0QDcgew0KPj4gICAJCQkJcmVnID0gPDc+Ow0KPj4gICAJ
CQkJbGFiZWwgPSAicDciOw0KPj4gICAJCQkJcGh5LWhhbmRsZSA9IDwmc3dpdGNoMHBoeTc+Ow0K
Pj4gICAJCQl9Ow0KPj4gICANCj4+IC0JCQlwb3J0QDggew0KPj4gKwkJCWV0aGVybmV0LXBvcnRA
OCB7DQo+PiAgIAkJCQlyZWcgPSA8OD47DQo+PiAgIAkJCQlsYWJlbCA9ICJwOCI7DQo+PiAgIAkJ
CQlwaHktaGFuZGxlID0gPCZzd2l0Y2gwcGh5OD47DQo+PiAgIAkJCX07DQo+PiAgIA0KPj4gLQkJ
CXBvcnRAOSB7DQo+PiArCQkJZXRoZXJuZXQtcG9ydEA5IHsNCj4+ICAgCQkJCXJlZyA9IDw5PjsN
Cj4+ICAgCQkJCWxhYmVsID0gInA5IjsNCj4+ICAgCQkJCXBoeS1tb2RlID0gIjEwZ2Jhc2UtciI7
DQo+PiBAQCAtMjgwLDcgKzI3OCw3IEBAIHBvcnRAOSB7DQo+PiAgIAkJCQltYW5hZ2VkID0gImlu
LWJhbmQtc3RhdHVzIjsNCj4+ICAgCQkJfTsNCj4+ICAgDQo+PiAtCQkJcG9ydEBhIHsNCj4+ICsJ
CQlldGhlcm5ldC1wb3J0QGEgew0KPj4gICAJCQkJcmVnID0gPDEwPjsNCj4+ICAgCQkJCWV0aGVy
bmV0ID0gPCZjcDBfZXRoMD47DQo+PiAgIAkJCQlwaHktbW9kZSA9ICIxMGdiYXNlLXIiOw0KPj4g
QEAgLTI5MywzNSArMjkxLDM1IEBAIG1kaW8gew0KPj4gICAJCQkjYWRkcmVzcy1jZWxscyA9IDwx
PjsNCj4+ICAgCQkJI3NpemUtY2VsbHMgPSA8MD47DQo+PiAgIA0KPj4gLQkJCXN3aXRjaDBwaHkx
OiBzd2l0Y2gwcGh5MUAxIHsNCj4+ICsJCQlzd2l0Y2gwcGh5MTogZXRoZXJuZXQtcGh5QDEgew0K
Pj4gICAJCQkJcmVnID0gPDB4MT47DQo+PiAgIAkJCX07DQo+PiAgIA0KPj4gLQkJCXN3aXRjaDBw
aHkyOiBzd2l0Y2gwcGh5MkAyIHsNCj4+ICsJCQlzd2l0Y2gwcGh5MjogZXRoZXJuZXQtcGh5QDIg
ew0KPj4gICAJCQkJcmVnID0gPDB4Mj47DQo+PiAgIAkJCX07DQo+PiAgIA0KPj4gLQkJCXN3aXRj
aDBwaHkzOiBzd2l0Y2gwcGh5M0AzIHsNCj4+ICsJCQlzd2l0Y2gwcGh5MzogZXRoZXJuZXQtcGh5
QDMgew0KPj4gICAJCQkJcmVnID0gPDB4Mz47DQo+PiAgIAkJCX07DQo+PiAgIA0KPj4gLQkJCXN3
aXRjaDBwaHk0OiBzd2l0Y2gwcGh5NEA0IHsNCj4+ICsJCQlzd2l0Y2gwcGh5NDogZXRoZXJuZXQt
cGh5QDQgew0KPj4gICAJCQkJcmVnID0gPDB4ND47DQo+PiAgIAkJCX07DQo+PiAgIA0KPj4gLQkJ
CXN3aXRjaDBwaHk1OiBzd2l0Y2gwcGh5NUA1IHsNCj4+ICsJCQlzd2l0Y2gwcGh5NTogZXRoZXJu
ZXQtcGh5QDUgew0KPj4gICAJCQkJcmVnID0gPDB4NT47DQo+PiAgIAkJCX07DQo+PiAgIA0KPj4g
LQkJCXN3aXRjaDBwaHk2OiBzd2l0Y2gwcGh5NkA2IHsNCj4+ICsJCQlzd2l0Y2gwcGh5NjogZXRo
ZXJuZXQtcGh5QDYgew0KPj4gICAJCQkJcmVnID0gPDB4Nj47DQo+PiAgIAkJCX07DQo+PiAgIA0K
Pj4gLQkJCXN3aXRjaDBwaHk3OiBzd2l0Y2gwcGh5N0A3IHsNCj4+ICsJCQlzd2l0Y2gwcGh5Nzog
ZXRoZXJuZXQtcGh5QDcgew0KPj4gICAJCQkJcmVnID0gPDB4Nz47DQo+PiAgIAkJCX07DQo+PiAg
IA0KPj4gLQkJCXN3aXRjaDBwaHk4OiBzd2l0Y2gwcGh5OEA4IHsNCj4+ICsJCQlzd2l0Y2gwcGh5
ODogZXRoZXJuZXQtcGh5QDggew0KPj4gICAJCQkJcmVnID0gPDB4OD47DQo+PiAgIAkJCX07DQo+
PiAgIAkJfTsNCj4gQ2hyaXMsIGRvZXMgdGhpcyBsb29rIG9rYXk/DQoNClRoZXJlJ3Mgbm90aGlu
ZyBpbiB0aGUgdS1ib290IGNvZGUgZm9yIHRoZSBDTjkxMzAtQ1JCIHRoYXQgY2FyZXMgYWJvdXQg
DQp0aGUgc3dpdGNoIHNvIEkgZG9uJ3QgdGhpbmsgdGhlcmUncyBhbnkgaXNzdWUgQUJJIHdpc2Uu
IFdlIGFyZSB3b3JraW5nIA0Kb24gb3VyIG93biBDTjkxMzAgYmFzZWQgcm91dGVyIHdpdGggYSBM
MiBzd2l0Y2ggYnV0IGl0J3MgYXQgYSBwb2ludCB3ZSANCmNhbiBmb2xsb3cgd2hhdGV2ZXIgdXBz
dHJlYW0gZGVjaWRlIGlzIHRoZSBmaW5hbCBzY2hlbWEuDQoNCkluIHRlcm1zIG9mIG15IHBlcnNv
bmFsIHByZWZlcmVuY2UgdGhlIHNjaGVtYSBxdW90ZWQgdXAgdGhyZWFkIGhhcyB0aGUgDQpwYXR0
ZXJuwqAgJ14oZXRoZXJuZXQtKT9zd2l0Y2goQC4qKT8kJyAoaS5lLiB0aGUgJ2V0aGVybmV0LScg
cGFydCBpcyANCm9wdGlvbmFsKSBzbyBJJ2QgcGVyc29uYWxseSBwcmVmZXIgc3dpdGNoMEA2IC0+
IHN3aXRjaEA2IGJ1dCB0aGF0J3Mgb25seSANCmEgc2xpZ2h0IHByZWZlcmVuY2UgYmVjYXVzZSBJ
IGRlYWwgd2l0aCBFdGhlcm5ldCBzd2l0Y2hlcyBkYXkgaW4gZGF5IG91dC4NCg==

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1510E7735D0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 03:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjHHBW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 21:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjHHBWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 21:22:54 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A55D10D1;
        Mon,  7 Aug 2023 18:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1691457774; x=1722993774;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wNYE27ZB1EWXGF/Ha4qX3HRIwcK9JvWd3lFyQTsSKgg=;
  b=cl+vK4YT5SDpT8vrQrZe8vjWftIZf1iyInq0zlJBEmwoJ70Q0lT55EW4
   yFMYWz3SezMzp9y7OOmPtAzqiNUsJnRk+udLddYu+h/EblFqs6AmLGPsj
   y8SOGVrWwsRmazKbVKrha7W6UmJbM0ntQy0ebxXVVTTpuBvYxPMsqn/MZ
   k=;
X-IronPort-AV: E=Sophos;i="6.01,263,1684800000"; 
   d="scan'208";a="231166607"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-26a610d2.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 01:22:54 +0000
Received: from EX19MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-m6i4x-26a610d2.us-west-2.amazon.com (Postfix) with ESMTPS id D5A9F40D5E;
        Tue,  8 Aug 2023 01:22:52 +0000 (UTC)
Received: from EX19D019UWA001.ant.amazon.com (10.13.139.95) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 8 Aug 2023 01:22:51 +0000
Received: from EX19D019UWA004.ant.amazon.com (10.13.139.126) by
 EX19D019UWA001.ant.amazon.com (10.13.139.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 8 Aug 2023 01:22:51 +0000
Received: from EX19D019UWA004.ant.amazon.com ([fe80::445f:a79:89eb:e469]) by
 EX19D019UWA004.ant.amazon.com ([fe80::445f:a79:89eb:e469%5]) with mapi id
 15.02.1118.030; Tue, 8 Aug 2023 01:22:51 +0000
From:   "Erdogan, Tahsin" <trdgn@amazon.com>
To:     "edumazet@google.com" <edumazet@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v2] tun: avoid high-order page allocation for packet
 header
Thread-Topic: [PATCH v2] tun: avoid high-order page allocation for packet
 header
Thread-Index: AQHZyZbZ6WJcwoAIkUqYVVMSFYLvKg==
Date:   Tue, 8 Aug 2023 01:22:51 +0000
Message-ID: <1327499ea2f2b43c9de485435e028797198ea2aa.camel@amazon.com>
References: <20230731230736.109216-1-trdgn@amazon.com>
         <CANn89iLV0iEeQy19wn+Vfmhpgr6srVpf3L+oBvuDyLRQXfoMug@mail.gmail.com>
         <CANn89iLghUDUSbNv-QOgyJ4dv5DhXGL60caeuVMnHW4HZQVJmg@mail.gmail.com>
In-Reply-To: <CANn89iLghUDUSbNv-QOgyJ4dv5DhXGL60caeuVMnHW4HZQVJmg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.187.171.26]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7172709B2759A140BBD0900A0CB3A09E@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA4LTAxIGF0IDEyOjE2ICswMjAwLCBFcmljIER1bWF6ZXQgd3JvdGU6DQo+
IE9uIFR1ZSwgQXVnIDEsIDIwMjMgYXQgMTE6MzfigK9BTSBFcmljIER1bWF6ZXQgPGVkdW1hemV0
QGdvb2dsZS5jb20+DQo+IHdyb3RlOg0KPiA+IE9uIFR1ZSwgQXVnIDEsIDIwMjMgYXQgMTowN+KA
r0FNIFRhaHNpbiBFcmRvZ2FuIDx0cmRnbkBhbWF6b24uY29tPg0KPiA+IHdyb3RlOg0KPiA+ID4g
V2hlbiBHU08gaXMgbm90IGVuYWJsZWQgYW5kIGEgcGFja2V0IGlzIHRyYW5zbWl0dGVkIHZpYSB3
cml0ZXYoKSwNCj4gPiA+IGFsbA0KPiA+ID4gcGF5bG9hZCBpcyB0cmVhdGVkIGFzIGhlYWRlciB3
aGljaCByZXF1aXJlcyBhIGNvbnRpZ3VvdXMgbWVtb3J5DQo+ID4gPiBhbGxvY2F0aW9uLg0KPiA+
ID4gVGhpcyBhbGxvY2F0aW9uIHJlcXVlc3QgaXMgaGFyZGVyIHRvIHNhdGlzZnksIGFuZCBtYXkg
ZXZlbiBmYWlsDQo+ID4gPiBpZiB0aGVyZSBpcw0KPiA+ID4gZW5vdWdoIGZyYWdtZW50YXRpb24u
DQo+ID4gPiANCj4gPiA+IE5vdGUgdGhhdCBzZW5kbXNnKCkgY29kZSBwYXRoIGxpbWl0cyB0aGUg
bGluZWFyIGNvcHkgbGVuZ3RoLCBzbw0KPiA+ID4gdGhpcyBjaGFuZ2UNCj4gPiA+IG1ha2VzIHdy
aXRldigpIGFuZCBzZW5kbXNnKCkgbW9yZSBjb25zaXN0ZW50Lg0KPiA+ID4gDQo+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBUYWhzaW4gRXJkb2dhbiA8dHJkZ25AYW1hem9uLmNvbT4NCj4gPiA+IC0tLQ0K
PiA+IA0KPiA+IEkgd2lsbCBoYXZlIHRvIHR3ZWFrIG9uZSBleGlzdGluZyBwYWNrZXRkcmlsbCB0
ZXN0LCBub3RoaW5nIG1ham9yLg0KPiA+IA0KPiA+IFRlc3RlZC1ieTogRXJpYyBEdW1hemV0IDxl
ZHVtYXpldEBnb29nbGUuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBFcmljIER1bWF6ZXQgPGVkdW1h
emV0QGdvb2dsZS5jb20+DQo+IA0KPiBJIGhhdmUgdG8gdGFrZSB0aGlzIGJhY2ssIHNvcnJ5Lg0K
PiANCj4gV2UgbmVlZCB0byBjaGFuZ2UgYWxsb2Nfc2tiX3dpdGhfZnJhZ3MoKSBhbmQgdHVuLmMg
dG8gYXR0ZW1wdA0KPiBoaWdoLW9yZGVyIGFsbG9jYXRpb25zLA0KPiBvdGhlcndpc2UgdHVuIHVz
ZXJzIHNlbmRpbmcgdmVyeSBsYXJnZSBidWZmZXJzIHdpbGwgcmVncmVzcy4NCj4gKEV2ZW4gaWYg
dGhpcyBfY291bGRfIGZhaWwgYXMgeW91IHBvaW50ZWQgb3V0IGlmIG1lbW9yeSBpcw0KPiB0aWdo
dC9mcmFnbWVudGVkKQ0KPiANCj4gSSBhbSB3b3JraW5nIHRvIG1ha2UgdGhlIGNoYW5nZSBpbiBh
bGxvY19za2Jfd2l0aF9mcmFncygpIGFuZCBpbiB0dW4sDQo+IHdlIGNhbiBhcHBseSB5b3VyIHBh
dGNoIGFmdGVyIHRoaXMgcHJlcmVxLg0KDQpIaSBFcmljLCBJIGJlbGlldmUgeW91ciBjaGFuZ2Vz
IGFyZSBtZXJnZWQuIEFyZSB3ZSBnb29kIHRvIGFwcGx5IG15DQpwYXRjaCBuZXh0Pw0K

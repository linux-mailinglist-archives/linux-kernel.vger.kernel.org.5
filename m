Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33C9805687
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442264AbjLENvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345523AbjLENvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:51:50 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FE71A1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 05:51:56 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-315-RudkEP8NNOKGvji7MwR1Vg-1; Tue, 05 Dec 2023 13:51:53 +0000
X-MC-Unique: RudkEP8NNOKGvji7MwR1Vg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 5 Dec
 2023 13:51:39 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 5 Dec 2023 13:51:39 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Stefan Hajnoczi' <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
CC:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
        Jason Wang <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Suwan Kim <suwan.kim027@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: RE: [PATCH] virtio_blk: fix snprintf truncation compiler warning
Thread-Topic: [PATCH] virtio_blk: fix snprintf truncation compiler warning
Thread-Index: AQHaJrs9NwtZ5IUyyEqvz6e+TUwc/LCatUxg
Date:   Tue, 5 Dec 2023 13:51:39 +0000
Message-ID: <1c1d57ba13c2497f99e5e0a9c5954667@AcuMS.aculab.com>
References: <20231204140743.1487843-1-stefanha@redhat.com>
In-Reply-To: <20231204140743.1487843-1-stefanha@redhat.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU3RlZmFuIEhham5vY3ppDQo+IFNlbnQ6IDA0IERlY2VtYmVyIDIwMjMgMTQ6MDgNCj4g
DQo+IENvbW1pdCA0ZTA0MDA1MjU2OTEgKCJ2aXJ0aW8tYmxrOiBzdXBwb3J0IHBvbGxpbmcgSS9P
IikgdHJpZ2dlcnMgdGhlDQo+IGZvbGxvd2luZyBnY2MgMTMgVz0xIHdhcm5pbmdzOg0KPiANCj4g
ZHJpdmVycy9ibG9jay92aXJ0aW9fYmxrLmM6IEluIGZ1bmN0aW9uIOKAmGluaXRfdnHigJk6DQo+
IGRyaXZlcnMvYmxvY2svdmlydGlvX2Jsay5jOjEwNzc6Njg6IHdhcm5pbmc6IOKAmCVk4oCZIGRp
cmVjdGl2ZSBvdXRwdXQgbWF5IGJlIHRydW5jYXRlZCB3cml0aW5nIGJldHdlZW4gMQ0KPiBhbmQg
MTEgYnl0ZXMgaW50byBhIHJlZ2lvbiBvZiBzaXplIDcgWy1XZm9ybWF0LXRydW5jYXRpb249XQ0K
PiAgMTA3NyB8ICAgICAgICAgICAgICAgICBzbnByaW50Zih2YmxrLT52cXNbaV0ubmFtZSwgVlFf
TkFNRV9MRU4sICJyZXFfcG9sbC4lZCIsIGkpOw0KPiAgICAgICB8ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefg0KPiBk
cml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsuYzoxMDc3OjU4OiBub3RlOiBkaXJlY3RpdmUgYXJndW1l
bnQgaW4gdGhlIHJhbmdlIFstMjE0NzQ4MzY0OCwgNjU1MzRdDQo+ICAxMDc3IHwgICAgICAgICAg
ICAgICAgIHNucHJpbnRmKHZibGstPnZxc1tpXS5uYW1lLCBWUV9OQU1FX0xFTiwgInJlcV9wb2xs
LiVkIiwgaSk7DQo+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fg0KPiBkcml2ZXJzL2Jsb2NrL3ZpcnRp
b19ibGsuYzoxMDc3OjE3OiBub3RlOiDigJhzbnByaW50ZuKAmSBvdXRwdXQgYmV0d2VlbiAxMSBh
bmQgMjEgYnl0ZXMgaW50byBhIGRlc3RpbmF0aW9uDQo+IG9mIHNpemUgMTYNCj4gIDEwNzcgfCAg
ICAgICAgICAgICAgICAgc25wcmludGYodmJsay0+dnFzW2ldLm5hbWUsIFZRX05BTUVfTEVOLCAi
cmVxX3BvbGwuJWQiLCBpKTsNCj4gICAgICAgfCAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiANCj4gVGhp
cyBpcyBhIGZhbHNlIHBvc2l0aXZlIGJlY2F1c2UgdGhlIGxvd2VyIGJvdW5kIC0yMTQ3NDgzNjQ4
IGlzDQo+IGluY29ycmVjdC4gVGhlIHRydWUgcmFuZ2Ugb2YgaSBpcyBbMCwgbnVtX3ZxcyAtIDFd
IHdoZXJlIDAgPCBudW1fdnFzIDwNCj4gNjU1MzYuDQo+IA0KPiBUaGUgY29kZSBtaXhlcyBpbnQs
IHVuc2lnbmVkIHNob3J0LCBhbmQgdW5zaWduZWQgaW50IHR5cGVzIGluIGFkZGl0aW9uDQo+IHRv
IHVzaW5nICIlZCIgZm9yIGFuIHVuc2lnbmVkIHZhbHVlLiBVc2UgdW5zaWduZWQgc2hvcnQgYW5k
ICIldSINCj4gY29uc2lzdGVudGx5IHRvIHNvbHZlIHRoZSBjb21waWxlciB3YXJuaW5nLg0KPiAN
Cj4gQ2M6IFN1d2FuIEtpbSA8c3V3YW4ua2ltMDI3QGdtYWlsLmNvbT4NCj4gUmVwb3J0ZWQtYnk6
IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KPiBDbG9zZXM6IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL29lLWtidWlsZC1hbGwvMjAyMzEyMDQxNTA5LkRJeXZFdDloLWxrcEBpbnRl
bC5jb20vDQo+IFNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0
LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsuYyB8IDggKysrKy0tLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibG9jay92aXJ0aW9fYmxrLmMgYi9kcml2ZXJzL2Jsb2Nr
L3ZpcnRpb19ibGsuYw0KPiBpbmRleCBkNTNkNmFhOGVlNjkuLjQ3NTU2ZDhjY2MzMiAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9ibG9jay92aXJ0aW9fYmxrLmMNCj4gKysrIGIvZHJpdmVycy9ibG9j
ay92aXJ0aW9fYmxrLmMNCj4gQEAgLTEwMTksMTIgKzEwMTksMTIgQEAgc3RhdGljIHZvaWQgdmly
dGJsa19jb25maWdfY2hhbmdlZChzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikNCj4gIHN0YXRp
YyBpbnQgaW5pdF92cShzdHJ1Y3QgdmlydGlvX2JsayAqdmJsaykNCj4gIHsNCj4gIAlpbnQgZXJy
Ow0KPiAtCWludCBpOw0KPiArCXVuc2lnbmVkIHNob3J0IGk7DQo+ICAJdnFfY2FsbGJhY2tfdCAq
KmNhbGxiYWNrczsNCj4gIAljb25zdCBjaGFyICoqbmFtZXM7DQo+ICAJc3RydWN0IHZpcnRxdWV1
ZSAqKnZxczsNCj4gIAl1bnNpZ25lZCBzaG9ydCBudW1fdnFzOw0KPiAtCXVuc2lnbmVkIGludCBu
dW1fcG9sbF92cXM7DQo+ICsJdW5zaWduZWQgc2hvcnQgbnVtX3BvbGxfdnFzOw0KPiAgCXN0cnVj
dCB2aXJ0aW9fZGV2aWNlICp2ZGV2ID0gdmJsay0+dmRldjsNCj4gIAlzdHJ1Y3QgaXJxX2FmZmlu
aXR5IGRlc2MgPSB7IDAsIH07DQo+IA0KPiBAQCAtMTA2OCwxMyArMTA2OCwxMyBAQCBzdGF0aWMg
aW50IGluaXRfdnEoc3RydWN0IHZpcnRpb19ibGsgKnZibGspDQo+IA0KPiAgCWZvciAoaSA9IDA7
IGkgPCBudW1fdnFzIC0gbnVtX3BvbGxfdnFzOyBpKyspIHsNCg0KVWdnIGRvaW5nIGFyaXRobWV0
aWMgb24gY2hhci9zaG9ydCBpcyBsaWtlbHkgdG8gZ2VuZXJhdGUgaG9ycmlkDQpjb2RlIChlc3Bl
Y2lhbGx5IG9uIG5vbi14ODYpLg0KSGludCwgdGhlcmUgd2lsbCBiZSBleHBsaWNpdCBtYXNraW5n
IGFuZC9vciBzaWduL3plcm8gZXh0ZW5zaW9uLg0KDQpFdmVuIHRoZSBhcnJheSBpbmRleCBtaWdo
dCBhZGQgZXh0cmEgY29kZSAoYWx0aG91Z2ggdGhlcmUnbGwgYmUNCmFuIGV4cGxpY2l0IHNpZ24g
ZXh0ZW5kIHRvIDY0Yml0IHdpdGggdGhlIGN1cnJlbnQgY29kZSkuDQoNClRoZXJlIHJlYWxseSBv
dWdodCB0byBiZSBhIGJldHRlciB3YXkgdG8gbWFrZSBnY2MgU1RGVS4NCg0KSW4gdGhpcyBjYXNl
ICd1bnNpZ25lZCBpbnQgaScgbWlnaHQgYmUgZW5vdWdoIHNpbmNlIGdjYyBzZWVtcw0KdG8gaGF2
ZSBhIHNtYWxsIGVub3VnaCB1cHBlciBib3VuZC4NCg0KCURhdmlkDQoNCg0KPiAgCQljYWxsYmFj
a3NbaV0gPSB2aXJ0YmxrX2RvbmU7DQo+IC0JCXNucHJpbnRmKHZibGstPnZxc1tpXS5uYW1lLCBW
UV9OQU1FX0xFTiwgInJlcS4lZCIsIGkpOw0KPiArCQlzbnByaW50Zih2YmxrLT52cXNbaV0ubmFt
ZSwgVlFfTkFNRV9MRU4sICJyZXEuJXUiLCBpKTsNCj4gIAkJbmFtZXNbaV0gPSB2YmxrLT52cXNb
aV0ubmFtZTsNCj4gIAl9DQo+IA0KPiAgCWZvciAoOyBpIDwgbnVtX3ZxczsgaSsrKSB7DQo+ICAJ
CWNhbGxiYWNrc1tpXSA9IE5VTEw7DQo+IC0JCXNucHJpbnRmKHZibGstPnZxc1tpXS5uYW1lLCBW
UV9OQU1FX0xFTiwgInJlcV9wb2xsLiVkIiwgaSk7DQo+ICsJCXNucHJpbnRmKHZibGstPnZxc1tp
XS5uYW1lLCBWUV9OQU1FX0xFTiwgInJlcV9wb2xsLiV1IiwgaSk7DQo+ICAJCW5hbWVzW2ldID0g
dmJsay0+dnFzW2ldLm5hbWU7DQo+ICAJfQ0KPiANCj4gLS0NCj4gMi40My4wDQoNCi0NClJlZ2lz
dGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24g
S2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


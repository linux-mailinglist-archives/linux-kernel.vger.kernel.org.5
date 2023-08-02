Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F2176C26B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 03:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjHBBme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 21:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjHBBm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 21:42:28 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8172D4E;
        Tue,  1 Aug 2023 18:42:05 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 3721dBOw089645;
        Wed, 2 Aug 2023 09:39:11 +0800 (+08)
        (envelope-from surong.pang@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx02.spreadtrum.com [10.0.1.204])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RFvjh6T77z2NmGQq;
        Wed,  2 Aug 2023 09:37:28 +0800 (CST)
Received: from shmbx05.spreadtrum.com (10.29.1.56) by SHMBX02.spreadtrum.com
 (10.0.1.204) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Wed, 2 Aug
 2023 09:39:09 +0800
Received: from shmbx05.spreadtrum.com ([fe80::3169:eec0:7a15:2543]) by
 shmbx05.spreadtrum.com ([fe80::3169:eec0:7a15:2543%16]) with mapi id
 15.00.1497.023; Wed, 2 Aug 2023 09:39:09 +0800
From:   =?utf-8?B?5bqe6IuP6I2jIChTdXJvbmcgUGFuZyk=?= 
        <surong.pang@unisoc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "rogerq@kernel.org" <rogerq@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        =?utf-8?B?5bqe6IuP6I2jIChTdXJvbmcgUGFuZyk=?= 
        <surong.pang@unisoc.com>
Subject: Re: [PATCH] usb: dwc3: Properly handle processing of pending events
Thread-Topic: [PATCH] usb: dwc3: Properly handle processing of pending events
Thread-Index: AdnE4JtB3fks6OUtQTaFZJ3KC9QX1w==
Date:   Wed, 2 Aug 2023 01:39:09 +0000
Message-ID: <2bf3663abc72448da44427dcaedb49fe@shmbx05.spreadtrum.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.29.69.35]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MAIL: SHSQR01.spreadtrum.com 3721dBOw089645
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhcnPvvIwNCklmIHRoZXJlIGlzL2FyZSBldmVudChzKSBpbiBldnQtPmJ1ZiwgIGluIGR3YzNf
Y2hlY2tfZXZlbnRfYnVmLCAgZHdjM190aHJlYWRfaW50ZXJydXB0IHdpbGwgYmUgd29rZSB1cC4N
Cg0KPiA+IEBAIC00NzE4LDYgKzQ3MjMsOCBAQCB2b2lkIGR3YzNfZ2FkZ2V0X3Byb2Nlc3NfcGVu
ZGluZ19ldmVudHMoc3RydWN0DQo+ID4gZHdjMyAqZHdjKSAgew0KPiA+ICAgICAgIGlmIChkd2Mt
PnBlbmRpbmdfZXZlbnRzKSB7DQo+ID4gICAgICAgICAgICAgICBkd2MzX2ludGVycnVwdChkd2Mt
PmlycV9nYWRnZXQsIGR3Yy0+ZXZfYnVmKTsNCj4gPiArICAgICAgICAgICAgIGR3YzNfdGhyZWFk
X2ludGVycnVwdChkd2MtPmlycV9nYWRnZXQsIGR3Yy0+ZXZfYnVmKTsNCj4gPiArICAgICAgICAg
ICAgIHBtX3J1bnRpbWVfcHV0KGR3Yy0+ZGV2KTsNCj4gPiAgICAgICAgICAgICAgIGR3Yy0+cGVu
ZGluZ19ldmVudHMgPSBmYWxzZTsNCj4gPiAgICAgICAgICAgICAgIGVuYWJsZV9pcnEoZHdjLT5p
cnFfZ2FkZ2V0KTsNCj4gPiAgICAgICB9DQoNCkkganVzdCB3YW50IHRvIGtub3cgZHdjM190aHJl
YWRfaW50ZXJydXB0IGhlcmUgaXMgbmVjZXNzYXJ5IG9yIG5vdD8NCg0KDQo+IE9uIFR1ZSwgQXVn
IDAyLCAyMDIzIDg6MTIgVGhpbmggTmd1eWVuIHdyb3RlOg0KPj4gT24gVHVlLCBBdWcgMDEsIDIw
MjMsIEVsc29uIFJveSBTZXJyYW8gd3JvdGU6DQo+ID4gSWYgZHdjMyBpcyBydW50aW1lIHN1c3Bl
bmRlZCB3ZSBkZWZlciBwcm9jZXNzaW5nIHRoZSBldmVudCBidWZmZXINCj4gPiB1bnRpbCByZXN1
bWUsIGJ5IHNldHRpbmcgdGhlIHBlbmRpbmdfZXZlbnRzIGZsYWcuIFNldCB0aGlzIGZsYWcgYmVm
b3JlDQo+ID4gdHJpZ2dlcmluZyByZXN1bWUgdG8gYXZvaWQgcmFjZSB3aXRoIHRoZSBydW50aW1l
IHJlc3VtZSBjYWxsYmFjay4NCj4gPg0KPiA+IFdoaWxlIGhhbmRsaW5nIHRoZSBwZW5kaW5nIGV2
ZW50cywgaW4gYWRkaXRpb24gdG8gY2hlY2tpbmcgdGhlIGV2ZW50DQo+ID4gYnVmZmVyIHdlIGFs
c28gbmVlZCB0byBwcm9jZXNzIGl0LiBIYW5kbGUgdGhpcyBieSBleHBsaWNpdGx5IGNhbGxpbmcN
Cj4gPiBkd2MzX3RocmVhZF9pbnRlcnJ1cHQoKS4gQWxzbyBiYWxhbmNlIHRoZSBydW50aW1lIHBt
IGdldCgpIG9wZXJhdGlvbg0KPiA+IHRoYXQgdHJpZ2dlcmVkIHRoaXMgcHJvY2Vzc2luZy4NCj4g
Pg0KPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4gRml4ZXM6IGZjOGJiOTFiYzgz
ZSAoInVzYjogZHdjMzogaW1wbGVtZW50IHJ1bnRpbWUgUE0iKQ0KPiA+IFNpZ25lZC1vZmYtYnk6
IEVsc29uIFJveSBTZXJyYW8gPHF1aWNfZXNlcnJhb0BxdWljaW5jLmNvbT4NCj4gPiAtLS0NCj4g
PiBDaGFuZ2Ugc2VwYXJhdGVkIGZyb20gYmVsb3cgc2VyaWVzIGFzIGFuIGluZGVwZW5kZW50IGZp
eCBiYXNlZCBvbiB0aGUNCj4gPiBlYXJsaWVyIGRpc2N1c3Npb24NCj4gPiBodHRwczovL3VybGRl
ZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2JlNTc1MTFkLTIwMDUt
DQo+ID4gYTFmNS1kNWE1LTgwOWU3MTAyOWFlY0BxdWljaW5jLmNvbS9fXzshIUE0RjJSOUdfcGch
WXRaOTNBTEVwRE5UQ0VoZjBXRQ0KPiA+IHlCNVMwOTBwUGxLSUtWdGpxVE9BRUpkeGRXYmw4UUc2
ZWlSbWx2Zml2VXRENXFqS1dXTFgyQzRmYjRXOFZBZzV3OXFhc0wNCj4gPiB1S0IkDQo+ID4NCj4g
PiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8IDkgKysrKysrKystDQo+ID4gIDEgZmlsZSBj
aGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQu
Yw0KPiA+IGluZGV4IDVmZDA2NzE1MWZiZi4uODU4ZmU0YzI5OWI3IDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dh
ZGdldC5jDQo+ID4gQEAgLTQ0NTUsOSArNDQ1NSwxNCBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgZHdj
M19jaGVja19ldmVudF9idWYoc3RydWN0IGR3YzNfZXZlbnRfYnVmZmVyICpldnQpDQo+ID4gICAg
ICAgdTMyIGNvdW50Ow0KPiA+DQo+ID4gICAgICAgaWYgKHBtX3J1bnRpbWVfc3VzcGVuZGVkKGR3
Yy0+ZGV2KSkgew0KPiA+ICsgICAgICAgICAgICAgZHdjLT5wZW5kaW5nX2V2ZW50cyA9IHRydWU7
DQo+ID4gKyAgICAgICAgICAgICAvKg0KPiA+ICsgICAgICAgICAgICAgICogVHJpZ2dlciBydW50
aW1lIHJlc3VtZS4gVGhlIGdldCgpIGZ1bmN0aW9uIHdpbGwgYmUgYmFsYW5jZWQNCj4gPiArICAg
ICAgICAgICAgICAqIGFmdGVyIHByb2Nlc3NpbmcgdGhlIHBlbmRpbmcgZXZlbnRzIGluIGR3YzNf
cHJvY2Vzc19wZW5kaW5nDQo+ID4gKyAgICAgICAgICAgICAgKiBldmVudHMoKS4NCj4gPiArICAg
ICAgICAgICAgICAqLw0KPiA+ICAgICAgICAgICAgICAgcG1fcnVudGltZV9nZXQoZHdjLT5kZXYp
Ow0KPiA+ICAgICAgICAgICAgICAgZGlzYWJsZV9pcnFfbm9zeW5jKGR3Yy0+aXJxX2dhZGdldCk7
DQo+ID4gLSAgICAgICAgICAgICBkd2MtPnBlbmRpbmdfZXZlbnRzID0gdHJ1ZTsNCj4gPiAgICAg
ICAgICAgICAgIHJldHVybiBJUlFfSEFORExFRDsNCj4gPiAgICAgICB9DQo+ID4NCj4gPiBAQCAt
NDcxOCw2ICs0NzIzLDggQEAgdm9pZCBkd2MzX2dhZGdldF9wcm9jZXNzX3BlbmRpbmdfZXZlbnRz
KHN0cnVjdA0KPiA+IGR3YzMgKmR3YykgIHsNCj4gPiAgICAgICBpZiAoZHdjLT5wZW5kaW5nX2V2
ZW50cykgew0KPiA+ICAgICAgICAgICAgICAgZHdjM19pbnRlcnJ1cHQoZHdjLT5pcnFfZ2FkZ2V0
LCBkd2MtPmV2X2J1Zik7DQo+ID4gKyAgICAgICAgICAgICBkd2MzX3RocmVhZF9pbnRlcnJ1cHQo
ZHdjLT5pcnFfZ2FkZ2V0LCBkd2MtPmV2X2J1Zik7DQo+ID4gKyAgICAgICAgICAgICBwbV9ydW50
aW1lX3B1dChkd2MtPmRldik7DQo+ID4gICAgICAgICAgICAgICBkd2MtPnBlbmRpbmdfZXZlbnRz
ID0gZmFsc2U7DQo+ID4gICAgICAgICAgICAgICBlbmFibGVfaXJxKGR3Yy0+aXJxX2dhZGdldCk7
DQo+ID4gICAgICAgfQ0KPiA+IC0tDQo+ID4gMi4xNy4xDQo+ID4NCj4gDQo+IFRoaXMgZml4IGlz
IG1vcmUgY29tcGxldGUuDQo+IA0KPiBBY2tlZC1ieTogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5
ZW5Ac3lub3BzeXMuY29tPg0KPiANCj4gVGhhbmtzLA0KPiBUaGluaA0K

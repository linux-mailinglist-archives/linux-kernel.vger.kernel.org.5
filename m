Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FC57DEDCA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 09:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344848AbjKBIB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 04:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjKBIB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 04:01:58 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5995E7;
        Thu,  2 Nov 2023 01:01:55 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3A280caxE2660653, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3A280caxE2660653
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Nov 2023 16:00:38 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 2 Nov 2023 16:00:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 2 Nov 2023 16:00:36 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Thu, 2 Nov 2023 16:00:36 +0800
From:   =?utf-8?B?SnlhbiBDaG91IFvlkajoirflrold?= <jyanchou@realtek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
        "riteshh@codeaurora.org" <riteshh@codeaurora.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "doug@schmorgal.com" <doug@schmorgal.com>,
        "tonyhuang.sunplus@gmail.com" <tonyhuang.sunplus@gmail.com>,
        "abel.vesa@linaro.org" <abel.vesa@linaro.org>,
        "william.qiu@starfivetech.com" <william.qiu@starfivetech.com>
Subject: RE: [PATCH V4][1/4] mmc: solve DMA boundary limitation of CQHCI driver
Thread-Topic: [PATCH V4][1/4] mmc: solve DMA boundary limitation of CQHCI
 driver
Thread-Index: AQHaCvo5MdQQ9DU650KwwcT/lueAxbBhayoAgAVDtdA=
Date:   Thu, 2 Nov 2023 08:00:36 +0000
Message-ID: <ee385d7d7de34e8f9203f2287b64f3b9@realtek.com>
References: <20231030062749.2840-1-jyanchou@realtek.com>
 <20231030062749.2840-2-jyanchou@realtek.com>
 <0843027c-88ed-4c7e-a054-15277e2a0cb5@linaro.org>
In-Reply-To: <0843027c-88ed-4c7e-a054-15277e2a0cb5@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.190.236]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antivirus-attachment-filter-interceptor-info: license violation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gRHVlIHRvIHN5bm9wc3lzIGRhdGEgYm9vaydzIGRlc2NyaXB0aW9uLCBpdCBoYWQgYSBsaW1p
dGF0aW9uIHdoaWxlIA0KPj4gdXNpbmcgRE1BIHRoYXQgYnVmZmVyIHNpemUgYW5kIHN0YXJ0IGFk
ZHJlc3MgbXVzdCBub3QgZXhjZWVkIDEyOCBNQi4NCj4+DQo+PiBXZSBhZGQgYW4gb3B0aW9uIHNl
dHVwX3RyYW5fZGVzYyB0byBtYWtlIHRyYW5fZGVzYyBzZXR0aW5nIGZsZXhpYmxlLg0KPj4NCj4+
IFNpZ25lZC1vZmYtYnk6IEp5YW4gQ2hvdSA8anlhbmNob3VAcmVhbHRlay5jb20+DQo+Pg0KPj4g
LS0tDQo+PiB2MiAtPiB2MzoNCj4+IC0gRml4IGF1dG8gdGVzdCBjb21waWxlIHdhcm5pbmcuDQo+
Pg0KPj4gdjEgLT4gdjI6DQo+PiAtIEV4cG9ydCBjcWhjaV9zZXRfdHJhbl9kZXNjIGZvciBzZXR0
aW5nIHRoZSBkZXNjcmlwdG9yJ3MgY2FsbGJhY2sgZnVuY3Rpb24uDQo+Pg0KPj4gdjAgLT4gdjE6
DQo+PiAtIFNlcGFyYXRlIGRpZmZlcmVudCBwYXRjaCBzdXBwb3J0cyBpbnRvIHNpbmdsZSBwYXRj
aC4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvbW1jL2hvc3QvY3FoY2ktY29yZS5jIHwgOCArKysrKysr
LQ0KPj4gIGRyaXZlcnMvbW1jL2hvc3QvY3FoY2kuaCAgICAgIHwgNSArKysrKw0KPj4gIDIgZmls
ZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L2NxaGNpLWNvcmUuYyANCj4+IGIvZHJpdmVycy9tbWMv
aG9zdC9jcWhjaS1jb3JlLmMgaW5kZXggYjNkN2Q2ZDhkNjU0Li41NTYwMzI5ZDJhN2QgDQo+PiAx
MDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3QvY3FoY2ktY29yZS5jDQo+PiArKysgYi9k
cml2ZXJzL21tYy9ob3N0L2NxaGNpLWNvcmUuYw0KPj4gQEAgLTQ3NCw3ICs0NzQsNyBAQCBzdGF0
aWMgaW50IGNxaGNpX2RtYV9tYXAoc3RydWN0IG1tY19ob3N0ICpob3N0LCBzdHJ1Y3QgbW1jX3Jl
cXVlc3QgKm1ycSkNCj4+ICAgICAgIHJldHVybiBzZ19jb3VudDsNCj4+ICB9DQo+Pg0KPj4gLXN0
YXRpYyB2b2lkIGNxaGNpX3NldF90cmFuX2Rlc2ModTggKmRlc2MsIGRtYV9hZGRyX3QgYWRkciwg
aW50IGxlbiwgDQo+PiBib29sIGVuZCwNCj4+ICt2b2lkIGNxaGNpX3NldF90cmFuX2Rlc2ModTgg
KmRlc2MsIGRtYV9hZGRyX3QgYWRkciwgaW50IGxlbiwgYm9vbCANCj4+ICtlbmQsDQo+PiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIGRtYTY0KSAgew0KPj4gICAgICAgX19sZTMy
ICphdHRyID0gKF9fbGUzMiBfX2ZvcmNlICopZGVzYzsgQEAgLTQ5NSw2ICs0OTUsNyBAQCANCj4+
IHN0YXRpYyB2b2lkIGNxaGNpX3NldF90cmFuX2Rlc2ModTggKmRlc2MsIGRtYV9hZGRyX3QgYWRk
ciwgaW50IGxlbiwgYm9vbCBlbmQsDQo+PiAgICAgICAgICAgICAgIGRhdGFkZHJbMF0gPSBjcHVf
dG9fbGUzMihhZGRyKTsNCj4+ICAgICAgIH0NCj4+ICB9DQo+PiArRVhQT1JUX1NZTUJPTChjcWhj
aV9zZXRfdHJhbl9kZXNjKTsNCg0KPiBFWFBPUlRfU1lNQk9MX0dQTA0KDQpXZSBoYWQgY29ycmVj
dGVkIGl0Lg0KDQpCZXN0IHJlZ2FyZHMsDQpKeWFuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQpGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFy
by5vcmc+IA0KU2VudDogTW9uZGF5LCBPY3RvYmVyIDMwLCAyMDIzIDM6MzUgUE0NClRvOiBKeWFu
IENob3UgW+WRqOiKt+WuiV0gPGp5YW5jaG91QHJlYWx0ZWsuY29tPjsgdWxmLmhhbnNzb25AbGlu
YXJvLm9yZzsgYWRyaWFuLmh1bnRlckBpbnRlbC5jb207IGpoODAuY2h1bmdAc2Ftc3VuZy5jb207
IHJpdGVzaGhAY29kZWF1cm9yYS5vcmc7IHJvYmgrZHRAa2VybmVsLm9yZzsga3J6eXN6dG9mLmtv
emxvd3NraStkdEBsaW5hcm8ub3JnOyBjb25vcitkdEBrZXJuZWwub3JnOyBhc3V0b3NoZEBjb2Rl
YXVyb3JhLm9yZzsgcC56YWJlbEBwZW5ndXRyb25peC5kZQ0KQ2M6IGxpbnV4LW1tY0B2Z2VyLmtl
cm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBhcm5kQGFybmRiLmRlOyBicmlhbm5vcnJpc0BjaHJvbWl1bS5vcmc7IGRvdWdA
c2NobW9yZ2FsLmNvbTsgdG9ueWh1YW5nLnN1bnBsdXNAZ21haWwuY29tOyBhYmVsLnZlc2FAbGlu
YXJvLm9yZzsgd2lsbGlhbS5xaXVAc3RhcmZpdmV0ZWNoLmNvbQ0KU3ViamVjdDogUmU6IFtQQVRD
SCBWNF1bMS80XSBtbWM6IHNvbHZlIERNQSBib3VuZGFyeSBsaW1pdGF0aW9uIG9mIENRSENJIGRy
aXZlcg0KDQoNCkV4dGVybmFsIG1haWwuDQoNCg0KDQpPbiAzMC8xMC8yMDIzIDA3OjI3LCBKeWFu
IENob3Ugd3JvdGU6DQo+IER1ZSB0byBzeW5vcHN5cyBkYXRhIGJvb2sncyBkZXNjcmlwdGlvbiwg
aXQgaGFkIGEgbGltaXRhdGlvbiB3aGlsZSANCj4gdXNpbmcgRE1BIHRoYXQgYnVmZmVyIHNpemUg
YW5kIHN0YXJ0IGFkZHJlc3MgbXVzdCBub3QgZXhjZWVkIDEyOCBNQi4NCj4NCj4gV2UgYWRkIGFu
IG9wdGlvbiBzZXR1cF90cmFuX2Rlc2MgdG8gbWFrZSB0cmFuX2Rlc2Mgc2V0dGluZyBmbGV4aWJs
ZS4NCj4NCj4gU2lnbmVkLW9mZi1ieTogSnlhbiBDaG91IDxqeWFuY2hvdUByZWFsdGVrLmNvbT4N
Cj4NCj4gLS0tDQo+IHYyIC0+IHYzOg0KPiAtIEZpeCBhdXRvIHRlc3QgY29tcGlsZSB3YXJuaW5n
Lg0KPg0KPiB2MSAtPiB2MjoNCj4gLSBFeHBvcnQgY3FoY2lfc2V0X3RyYW5fZGVzYyBmb3Igc2V0
dGluZyB0aGUgZGVzY3JpcHRvcidzIGNhbGxiYWNrIGZ1bmN0aW9uLg0KPg0KPiB2MCAtPiB2MToN
Cj4gLSBTZXBhcmF0ZSBkaWZmZXJlbnQgcGF0Y2ggc3VwcG9ydHMgaW50byBzaW5nbGUgcGF0Y2gu
DQo+IC0tLQ0KPiAtLS0NCj4gIGRyaXZlcnMvbW1jL2hvc3QvY3FoY2ktY29yZS5jIHwgOCArKysr
KysrLQ0KPiAgZHJpdmVycy9tbWMvaG9zdC9jcWhjaS5oICAgICAgfCA1ICsrKysrDQo+ICAyIGZp
bGVzIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbW1jL2hvc3QvY3FoY2ktY29yZS5jIA0KPiBiL2RyaXZlcnMvbW1jL2hv
c3QvY3FoY2ktY29yZS5jIGluZGV4IGIzZDdkNmQ4ZDY1NC4uNTU2MDMyOWQyYTdkIA0KPiAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9jcWhjaS1jb3JlLmMNCj4gKysrIGIvZHJpdmVy
cy9tbWMvaG9zdC9jcWhjaS1jb3JlLmMNCj4gQEAgLTQ3NCw3ICs0NzQsNyBAQCBzdGF0aWMgaW50
IGNxaGNpX2RtYV9tYXAoc3RydWN0IG1tY19ob3N0ICpob3N0LCBzdHJ1Y3QgbW1jX3JlcXVlc3Qg
Km1ycSkNCj4gICAgICAgcmV0dXJuIHNnX2NvdW50Ow0KPiAgfQ0KPg0KPiAtc3RhdGljIHZvaWQg
Y3FoY2lfc2V0X3RyYW5fZGVzYyh1OCAqZGVzYywgZG1hX2FkZHJfdCBhZGRyLCBpbnQgbGVuLCAN
Cj4gYm9vbCBlbmQsDQo+ICt2b2lkIGNxaGNpX3NldF90cmFuX2Rlc2ModTggKmRlc2MsIGRtYV9h
ZGRyX3QgYWRkciwgaW50IGxlbiwgYm9vbCANCj4gK2VuZCwNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgYm9vbCBkbWE2NCkgIHsNCj4gICAgICAgX19sZTMyICphdHRyID0gKF9fbGUz
MiBfX2ZvcmNlICopZGVzYzsgQEAgLTQ5NSw2ICs0OTUsNyBAQCANCj4gc3RhdGljIHZvaWQgY3Fo
Y2lfc2V0X3RyYW5fZGVzYyh1OCAqZGVzYywgZG1hX2FkZHJfdCBhZGRyLCBpbnQgbGVuLCBib29s
IGVuZCwNCj4gICAgICAgICAgICAgICBkYXRhZGRyWzBdID0gY3B1X3RvX2xlMzIoYWRkcik7DQo+
ICAgICAgIH0NCj4gIH0NCj4gK0VYUE9SVF9TWU1CT0woY3FoY2lfc2V0X3RyYW5fZGVzYyk7DQoN
CkVYUE9SVF9TWU1CT0xfR1BMDQoNCg0KQmVzdCByZWdhcmRzLA0KS3J6eXN6dG9mDQoNCg==

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A1B7F59A2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 08:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344884AbjKWHzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 02:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjKWHzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 02:55:37 -0500
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF1AE7;
        Wed, 22 Nov 2023 23:55:41 -0800 (PST)
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
        by mx0.infotecs.ru (Postfix) with ESMTP id A06161183A38;
        Thu, 23 Nov 2023 10:55:39 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru A06161183A38
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
        t=1700726139; bh=aqIsOIcOR88OV8n3BzXeKdgT7SK6zBo4edh5EAZqIR8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=VdXGVA+BiuT3uKxNtxMrkQA7lYGqD1MHRpZziko5De5IIGC3jmPg6CsuQpFaO6vZ1
         SpRjN4QuhhvhygJ0HilkZ5yC02cKtTt2WUBCKVQ6zOgQdw4n+uRMhr3zgtYi411ZJK
         PSfxHyv8E1GLEHz1mwMYmX6hPa3vl13hMlsHqHAY=
Received: from msk-exch-01.infotecs-nt (msk-exch-01.infotecs-nt [10.0.7.191])
        by mx0.infotecs-nt (Postfix) with ESMTP id 9DBA030A8C4A;
        Thu, 23 Nov 2023 10:55:39 +0300 (MSK)
From:   Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To:     Paul Moore <paul@paul-moore.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Huw Davies <huw@codeweavers.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH net] calipso: Fix memory leak in netlbl_calipso_add_pass()
Thread-Topic: [PATCH net] calipso: Fix memory leak in
 netlbl_calipso_add_pass()
Thread-Index: AQHaHeJzdA++O1H3dkiA65HXAmqNZQ==
Date:   Thu, 23 Nov 2023 07:55:39 +0000
Message-ID: <0a6fff0d-61df-4ac5-ae8e-e2204c60ebb5@infotecs.ru>
References: <20231122135242.2779058-1-Ilia.Gavrilov@infotecs.ru>
 <CAHC9VhTiq1xPXXsETNKRBOtfkB5wohVwhBeae+5QW9uV-h5vvg@mail.gmail.com>
In-Reply-To: <CAHC9VhTiq1xPXXsETNKRBOtfkB5wohVwhBeae+5QW9uV-h5vvg@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.17.0.10]
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A607E215D5A694783D4780659120150@infotecs.ru>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KLMS-Rule-ID: 5
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Status: not scanned, disabled by settings
X-KLMS-AntiSpam-Interceptor-Info: not scanned
X-KLMS-AntiPhishing: Clean, bases: 2023/11/23 06:48:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2023/11/23 06:11:00 #22507418
X-KLMS-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMjIvMjMgMTg6NTYsIFBhdWwgTW9vcmUgd3JvdGU6DQo+IE9uIFdlZCwgTm92IDIyLCAy
MDIzIGF0IDg6NTXigK9BTSBHYXZyaWxvdiBJbGlhIDxJbGlhLkdhdnJpbG92QGluZm90ZWNzLnJ1
PiB3cm90ZToNCj4+DQo+PiBJZiBJUHY2IHN1cHBvcnQgaXMgZGlzYWJsZWQgYXQgYm9vdCAoaXB2
Ni5kaXNhYmxlPTEpLA0KPj4gdGhlIGNhbGlwc29faW5pdCgpIC0+IG5ldGxibF9jYWxpcHNvX29w
c19yZWdpc3RlcigpIGZ1bmN0aW9uIGlzbid0IGNhbGxlZCwNCj4+IGFuZCB0aGUgbmV0bGJsX2Nh
bGlwc29fb3BzX2dldCgpIGZ1bmN0aW9uIGFsd2F5cyByZXR1cm5zIE5VTEwuDQo+PiBJbiB0aGlz
IGNhc2UsIHRoZSBuZXRsYmxfY2FsaXBzb19hZGRfcGFzcygpIGZ1bmN0aW9uIGFsbG9jYXRlcyBt
ZW1vcnkNCj4+IGZvciB0aGUgZG9pX2RlZiB2YXJpYWJsZSBidXQgZG9lc24ndCBmcmVlIGl0IHdp
dGggdGhlIGNhbGlwc29fZG9pX2ZyZWUoKS4NCj4gDQo+IEl0IGxvb2tzIGxpa2UgYSBiZXR0ZXIg
b3B0aW9uIHdvdWxkIGJlIHRvIHJldHVybiBhbiBlcnJvciBjb2RlIGluDQo+IG5ldGxibF9jYWxp
cHNvX2FkZCgpIHNvIHdlIG5ldmVyIGFsbG9jYXRlIHRoZSBtZW1vcnkgaW4gdGhlIGZpcnN0DQo+
IHBsYWNlLg0KPiANCj4gVW50ZXN0ZWQgcGF0Y2ggYmVsb3csIGNvcHktbi1wYXN0ZSdkIHNvIHRo
ZXJlIGlzIGxpa2VseSB3aGl0ZXNwYWNlDQo+IGRhbWFnZSwgYnV0IHlvdSBnZXQgdGhlIGlkZWEu
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvbmV0L25ldGxhYmVsL25ldGxhYmVsX2NhbGlwc28uYyBiL25l
dC9uZXRsYWJlbC9uZXRsYWJlbF9jYWxpcHNvLmMNCj4gaW5kZXggZjFkNWI4NDY1MjE3Li4yNmE1
MDRkYzZlNTcgMTAwNjQ0DQo+IC0tLSBhL25ldC9uZXRsYWJlbC9uZXRsYWJlbF9jYWxpcHNvLmMN
Cj4gKysrIGIvbmV0L25ldGxhYmVsL25ldGxhYmVsX2NhbGlwc28uYw0KPiBAQCAtNTQsOCArNTQs
MzEgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBubGFfcG9saWN5DQo+IGNhbGlwc29fZ2VubF9wb2xp
Y3lbTkxCTF9DQUxJUFNPX0FfTUFYICsgMV0gPSB7DQo+ICAgICAgICAgW05MQkxfQ0FMSVBTT19B
X01UWVBFXSA9IHsgLnR5cGUgPSBOTEFfVTMyIH0sDQo+IH07DQo+IA0KPiArc3RhdGljIGNvbnN0
IHN0cnVjdCBuZXRsYmxfY2FsaXBzb19vcHMgKmNhbGlwc29fb3BzOw0KPiArDQo+ICsvKioNCj4g
KyAqIG5ldGxibF9jYWxpcHNvX29wc19yZWdpc3RlciAtIFJlZ2lzdGVyIHRoZSBDQUxJUFNPIG9w
ZXJhdGlvbnMNCj4gKyAqIEBvcHM6IG9wcyB0byByZWdpc3Rlcg0KPiArICoNCj4gKyAqIERlc2Ny
aXB0aW9uOg0KPiArICogUmVnaXN0ZXIgdGhlIENBTElQU08gcGFja2V0IGVuZ2luZSBvcGVyYXRp
b25zLg0KPiArICoNCj4gKyAqLw0KPiArY29uc3Qgc3RydWN0IG5ldGxibF9jYWxpcHNvX29wcyAq
DQo+ICtuZXRsYmxfY2FsaXBzb19vcHNfcmVnaXN0ZXIoY29uc3Qgc3RydWN0IG5ldGxibF9jYWxp
cHNvX29wcyAqb3BzKQ0KPiArew0KPiArICAgICAgIHJldHVybiB4Y2hnKCZjYWxpcHNvX29wcywg
b3BzKTsNCj4gK30NCj4gK0VYUE9SVF9TWU1CT0wobmV0bGJsX2NhbGlwc29fb3BzX3JlZ2lzdGVy
KTsNCj4gKw0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBuZXRsYmxfY2FsaXBzb19vcHMgKm5ldGxi
bF9jYWxpcHNvX29wc19nZXQodm9pZCkNCj4gK3sNCj4gKyAgICAgICByZXR1cm4gUkVBRF9PTkNF
KGNhbGlwc29fb3BzKTsNCj4gK30NCj4gKw0KPiAvKiBOZXRMYWJlbCBDb21tYW5kIEhhbmRsZXJz
DQo+ICAgKi8NCj4gKw0KPiAvKioNCj4gICAqIG5ldGxibF9jYWxpcHNvX2FkZF9wYXNzIC0gQWRk
cyBhIENBTElQU08gcGFzcyBET0kgZGVmaW5pdGlvbg0KPiAgICogQGluZm86IHRoZSBHZW5lcmlj
IE5FVExJTksgaW5mbyBibG9jaw0KPiBAQCAtMTAwLDEwICsxMjMsMTMgQEAgc3RhdGljIGludCBu
ZXRsYmxfY2FsaXBzb19hZGQoc3RydWN0IHNrX2J1ZmYNCj4gKnNrYiwgc3RydWN0IGdlbmxfaW5m
byAqaW5mbykNCj4gew0KPiAgICAgICAgIGludCByZXRfdmFsID0gLUVJTlZBTDsNCj4gICAgICAg
ICBzdHJ1Y3QgbmV0bGJsX2F1ZGl0IGF1ZGl0X2luZm87DQo+ICsgICAgICAgY29uc3Qgc3RydWN0
IG5ldGxibF9jYWxpcHNvX29wcyAqb3BzID0gbmV0bGJsX2NhbGlwc29fb3BzX2dldCgpOw0KPiAN
Cj4gICAgICAgICBpZiAoIWluZm8tPmF0dHJzW05MQkxfQ0FMSVBTT19BX0RPSV0gfHwNCj4gICAg
ICAgICAgICAgIWluZm8tPmF0dHJzW05MQkxfQ0FMSVBTT19BX01UWVBFXSkNCj4gICAgICAgICAg
ICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiArICAgICAgIGlmICghb3BzKQ0KPiArICAgICAgICAg
ICAgICAgcmV0dXJuIC1FT1BOT1RTVVBQOw0KPiANCj4gICAgICAgICBuZXRsYmxfbmV0bGlua19h
dWRpdGluZm8oJmF1ZGl0X2luZm8pOw0KPiAgICAgICAgIHN3aXRjaCAobmxhX2dldF91MzIoaW5m
by0+YXR0cnNbTkxCTF9DQUxJUFNPX0FfTVRZUEVdKSkgew0KPiBAQCAtMzYzLDI4ICszODksNiBA
QCBpbnQgX19pbml0IG5ldGxibF9jYWxpcHNvX2dlbmxfaW5pdCh2b2lkKQ0KPiAgICAgICAgIHJl
dHVybiBnZW5sX3JlZ2lzdGVyX2ZhbWlseSgmbmV0bGJsX2NhbGlwc29fZ25sX2ZhbWlseSk7DQo+
IH0NCj4gDQo+IC1zdGF0aWMgY29uc3Qgc3RydWN0IG5ldGxibF9jYWxpcHNvX29wcyAqY2FsaXBz
b19vcHM7DQo+IC0NCj4gLS8qKg0KPiAtICogbmV0bGJsX2NhbGlwc29fb3BzX3JlZ2lzdGVyIC0g
UmVnaXN0ZXIgdGhlIENBTElQU08gb3BlcmF0aW9ucw0KPiAtICogQG9wczogb3BzIHRvIHJlZ2lz
dGVyDQo+IC0gKg0KPiAtICogRGVzY3JpcHRpb246DQo+IC0gKiBSZWdpc3RlciB0aGUgQ0FMSVBT
TyBwYWNrZXQgZW5naW5lIG9wZXJhdGlvbnMuDQo+IC0gKg0KPiAtICovDQo+IC1jb25zdCBzdHJ1
Y3QgbmV0bGJsX2NhbGlwc29fb3BzICoNCj4gLW5ldGxibF9jYWxpcHNvX29wc19yZWdpc3Rlcihj
b25zdCBzdHJ1Y3QgbmV0bGJsX2NhbGlwc29fb3BzICpvcHMpDQo+IC17DQo+IC0gICAgICAgcmV0
dXJuIHhjaGcoJmNhbGlwc29fb3BzLCBvcHMpOw0KPiAtfQ0KPiAtRVhQT1JUX1NZTUJPTChuZXRs
YmxfY2FsaXBzb19vcHNfcmVnaXN0ZXIpOw0KPiAtDQo+IC1zdGF0aWMgY29uc3Qgc3RydWN0IG5l
dGxibF9jYWxpcHNvX29wcyAqbmV0bGJsX2NhbGlwc29fb3BzX2dldCh2b2lkKQ0KPiAtew0KPiAt
ICAgICAgIHJldHVybiBSRUFEX09OQ0UoY2FsaXBzb19vcHMpOw0KPiAtfQ0KPiAtDQo+IC8qKg0K
PiAgICogY2FsaXBzb19kb2lfYWRkIC0gQWRkIGEgbmV3IERPSSB0byB0aGUgQ0FMSVBTTyBwcm90
b2NvbCBlbmdpbmUNCj4gICAqIEBkb2lfZGVmOiB0aGUgRE9JIHN0cnVjdHVyZQ0KPiANCg0KVGhh
bmsgeW91IGZvciByZXZpZXcuIEknbGwgdGVzdCBhbmQgc2VuZCB0aGlzIGlkZWEgaW4gdGhlIG5l
eHQgdmVyc2lvbi4NCg==

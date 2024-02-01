Return-Path: <linux-kernel+bounces-48749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D8C8460BD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E99EFB2829A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305648526E;
	Thu,  1 Feb 2024 19:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ek2yeli9"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7410385296;
	Thu,  1 Feb 2024 19:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706814859; cv=none; b=avV4bDViiIZnNuamcopFtQ4vloQ5Eyn8kl6gbnO6O7jErvGWBtb4h3cNVn6oaXi3JFKtJkMndJ1CGzTsxhwtF2Ke6U6CuK2fjxSiuBRS/qakMgOP6QjD6XSAPUqlR0bro8+mAmnhTWtHX/FxdQjw/ZUFEo8Ieg1nsFBEEARkJyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706814859; c=relaxed/simple;
	bh=m/ziZRXHZN97/gkv1/UdmtNk/Ls3Hm4fX8W75gUPpr4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QC0hi8EuDmSigqtBzSHV8Cr15r6beNUo0B+aNxYcrRJDeKy5jFfRD+LUD6BpG6TGsJOyAHdKfnpB/B+iE7Yu/RW7s58+BSgJ2Jh1KI44FpetrJfk/VICfaSKComhvJ8/WNmEWOlSDVaUe+5d/Dwz8j8+OYiVxXhdZWPWTCv8DPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ek2yeli9; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 411JDpWX072326;
	Thu, 1 Feb 2024 13:13:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706814831;
	bh=m/ziZRXHZN97/gkv1/UdmtNk/Ls3Hm4fX8W75gUPpr4=;
	h=From:To:Subject:Date:References:In-Reply-To;
	b=ek2yeli9Hq3pv6IdrDXXM7zFaBDwJ+E8HF3EVFmj3XwY+9dmrHG4bDkee6AF6mM4z
	 ExYiGjakQpk0mi4c4GcAZp0wixVVdHcI4tCPSxmGO4+R3vNrh1f3ik2AYiTpHWQuCu
	 PJhAnw13zMCfs6JQiGsTLwIuCBgYTcpf2Jzz04Vc=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 411JDpoP111319
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Feb 2024 13:13:51 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 13:13:50 -0600
Received: from DLEE108.ent.ti.com ([fe80::922:4dc:27cc:b334]) by
 DLEE108.ent.ti.com ([fe80::922:4dc:27cc:b334%17]) with mapi id
 15.01.2507.023; Thu, 1 Feb 2024 13:13:50 -0600
From: "Brnich, Brandon" <b-brnich@ti.com>
To: "Davis, Andrew" <afd@ti.com>, "Menon, Nishanth" <nm@ti.com>,
        "Raghavendra,
 Vignesh" <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Geert Uytterhoeven
	<geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        =?utf-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "Etheridge, Darren" <detheridge@ti.com>
Subject: RE: [PATCH v3 1/6] arm64: dts: ti: k3-j784s4: Add Wave5 Video
 Encoder/Decoder Node
Thread-Topic: [PATCH v3 1/6] arm64: dts: ti: k3-j784s4: Add Wave5 Video
 Encoder/Decoder Node
Thread-Index: AQHaVIw5E0i18CHpIkKYWPYA552J1rD2NjEA//+jyCA=
Date: Thu, 1 Feb 2024 19:13:50 +0000
Message-ID: <a168bbdc2efd4cb1a71c6c6421dbd7ce@ti.com>
References: <20240131212625.1862775-1-b-brnich@ti.com>
 <20240131212625.1862775-2-b-brnich@ti.com>
 <a5f0059d-b80f-44e6-8c1e-793054586e0a@ti.com>
In-Reply-To: <a5f0059d-b80f-44e6-8c1e-793054586e0a@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgQW5kcmV3LA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhdmlz
LCBBbmRyZXcgPGFmZEB0aS5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBGZWJydWFyeSAxLCAyMDI0
IDEyOjM1IFBNDQo+IFRvOiBCcm5pY2gsIEJyYW5kb24gPGItYnJuaWNoQHRpLmNvbT47IE1lbm9u
LCBOaXNoYW50aCA8bm1AdGkuY29tPjsNCj4gUmFnaGF2ZW5kcmEsIFZpZ25lc2ggPHZpZ25lc2hy
QHRpLmNvbT47IFRlcm8gS3Jpc3RvIDxrcmlzdG9Aa2VybmVsLm9yZz47DQo+IFJvYiBIZXJyaW5n
IDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93c2tpDQo+IDxrcnp5c3p0b2Yu
a296bG93c2tpK2R0QGxpbmFyby5vcmc+OyBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5v
cmc+Ow0KPiBDYXRhbGluIE1hcmluYXMgPGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tPjsgV2lsbCBE
ZWFjb24NCj4gPHdpbGxAa2VybmVsLm9yZz47IEJqb3JuIEFuZGVyc3NvbiA8cXVpY19iam9yYW5k
ZUBxdWljaW5jLmNvbT47IEdlZXJ0DQo+IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlk
ZXIuYmU+OyBBcm5kIEJlcmdtYW5uDQo+IDxhcm5kQGFybmRiLmRlPjsgS29ucmFkIER5YmNpbyA8
a29ucmFkLmR5YmNpb0BsaW5hcm8ub3JnPjsgTmVpbA0KPiBBcm1zdHJvbmcgPG5laWwuYXJtc3Ry
b25nQGxpbmFyby5vcmc+OyBOw61jb2xhcyBGIC4gUiAuIEEgLiBQcmFkbw0KPiA8bmZyYXByYWRv
QGNvbGxhYm9yYS5jb20+OyBNYXJlayBTenlwcm93c2tpDQo+IDxtLnN6eXByb3dza2lAc2Ftc3Vu
Zy5jb20+OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGRldmljZXRy
ZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBFdGhlcmlk
Z2UsIERhcnJlbg0KPiA8ZGV0aGVyaWRnZUB0aS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djMgMS82XSBhcm02NDogZHRzOiB0aTogazMtajc4NHM0OiBBZGQgV2F2ZTUgVmlkZW8NCj4gRW5j
b2Rlci9EZWNvZGVyIE5vZGUNCj4gDQo+IE9uIDEvMzEvMjQgMzoyNiBQTSwgQnJhbmRvbiBCcm5p
Y2ggd3JvdGU6DQo+ID4gVGhpcyBwYXRjaCBhZGRzIHN1cHBvcnQgZm9yIHRoZSBXYXZlNTIxY2wg
b24gdGhlIEo3ODRTNC1ldm0uDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBCcmFuZG9uIEJybmlj
aCA8Yi1icm5pY2hAdGkuY29tPg0KPiA+IC0tLQ0KPiA+ICAgYXJjaC9hcm02NC9ib290L2R0cy90
aS9rMy1qNzg0czQtZXZtLmR0cyAgIHwgIDggKysrKysrKysNCj4gPiAgIGFyY2gvYXJtNjQvYm9v
dC9kdHMvdGkvazMtajc4NHM0LW1haW4uZHRzaSB8IDIwICsrKysrKysrKysrKysrKysrKysrDQo+
ID4gICBhcmNoL2FybTY0L2Jvb3QvZHRzL3RpL2szLWo3ODRzNC5kdHNpICAgICAgfCAgMiArKw0K
PiA+ICAgMyBmaWxlcyBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy90aS9rMy1qNzg0czQtZXZtLmR0cw0KPiA+IGIvYXJj
aC9hcm02NC9ib290L2R0cy90aS9rMy1qNzg0czQtZXZtLmR0cw0KPiA+IGluZGV4IGYzNGI5MmFj
YzU2ZC4uN2QzN2MxMWI0ZGY0IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMv
dGkvazMtajc4NHM0LWV2bS5kdHMNCj4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL3RpL2sz
LWo3ODRzNC1ldm0uZHRzDQo+ID4gQEAgLTc4NCw2ICs3ODQsMTQgQEAgJm1haW5fZ3BpbzAgew0K
PiA+ICAgCXN0YXR1cyA9ICJva2F5IjsNCj4gPiAgIH07DQo+ID4NCj4gPiArJnZwdTAgew0KPiA+
ICsJc3RhdHVzID0gIm9rYXkiOw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArJnZwdTEgew0KPiA+ICsJ
c3RhdHVzID0gIm9rYXkiOw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiAgICZtY3VfY3BzdyB7DQo+ID4g
ICAJc3RhdHVzID0gIm9rYXkiOw0KPiA+ICAgCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+
ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvdGkvazMtajc4NHM0LW1haW4uZHRz
aQ0KPiA+IGIvYXJjaC9hcm02NC9ib290L2R0cy90aS9rMy1qNzg0czQtbWFpbi5kdHNpDQo+ID4g
aW5kZXggZjJiNzIwZWQxZTRmLi44YjI2MjNhYzgxNjAgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9h
cm02NC9ib290L2R0cy90aS9rMy1qNzg0czQtbWFpbi5kdHNpDQo+ID4gKysrIGIvYXJjaC9hcm02
NC9ib290L2R0cy90aS9rMy1qNzg0czQtbWFpbi5kdHNpDQo+ID4gQEAgLTY2Miw2ICs2NjIsMjYg
QEAgbWFpbl9pMmM2OiBpMmNAMjA2MDAwMCB7DQo+ID4gICAJCXN0YXR1cyA9ICJkaXNhYmxlZCI7
DQo+ID4gICAJfTsNCj4gPg0KPiA+ICsJdnB1MDogdmlkZW8tY29kZWNANDIxMDAwMCB7DQo+ID4g
KwkJY29tcGF0aWJsZSA9ICJ0aSxqNzIxczItd2F2ZTUyMWMiLCAiY25tLHdhdmU1MjFjIjsNCj4g
PiArCQlyZWcgPSA8MHgwMCAweDQyMTAwMDAgMHgwMCAweDEwMDAwPjsNCj4gPiArCQlpbnRlcnJ1
cHRzID0gPEdJQ19TUEkgMTgyIElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiA+ICsJCWNsb2NrcyA9
IDwmazNfY2xrcyAyNDEgMj47DQo+ID4gKwkJY2xvY2stbmFtZXMgPSAidmNvZGVjIjsNCj4gPiAr
CQlwb3dlci1kb21haW5zID0gPCZrM19wZHMgMjQxIFRJX1NDSV9QRF9FWENMVVNJVkU+Ow0KPiA+
ICsJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+IA0KPiBXaHkgYXJlIHRoZXNlIGRlZmF1bHQgZGlz
YWJsZWQ/IEkgZG9uJ3Qgc2VlIGFueXRoaW5nIG1pc3NpbmcgdGhhdCB3b3VsZA0KPiBuZWVkIHRv
IGJlIGFkZGVkIGF0IHRoZSBib2FyZCBsZXZlbC4gWW91IGRpc2FibGUgdGhlbSBqdXN0IHRvIHJl
LWVuYWJsZSB0aGVtDQo+IGluIHRoZSBuZXh0IHBhdGNoLiBMZWF2ZSB0aGVzZSBkZWZhdWx0IGVu
YWJsZWQuDQoNCkkgdGhvdWdodCB0aGF0IGRpc2FibGVkIGJ5IGRlZmF1bHQgd2FzIHRoZSBzdGFu
ZGFyZCBmb3Igbm9kZSBpbiBkdHNpIGZpbGVzLCB3aGVyZQ0KdGhleSBnZXQgc3BlY2lmaWNhbGx5
IGVuYWJsZWQgaW4gdGhlIHBhcnRpY3VsYXIgZHRzIGZpbGUgZm9yIHRoZSBTb0MuDQoNCkluIFY0
IEkgd2lsbCByZW1vdmUgdGhlIGRpc2FibGVkIGJ5IGRlZmF1bHQuIFNob3VsZCB0aGlzIGFwcGx5
IHRvIGFsbCBwbGF0Zm9ybXMgaW4NCnRoZSBzZXJpZXM/DQogDQo+ID4gKwl9Ow0KPiA+ICsNCj4g
PiArCXZwdTE6IHZpZGVvLWNvZGVjQDQyMjAwMDAgew0KPiA+ICsJCWNvbXBhdGlibGUgPSAidGks
ajcyMXMyLXdhdmU1MjFjIiwgImNubSx3YXZlNTIxYyI7DQo+ID4gKwkJcmVnID0gPDB4MDAgMHg0
MjIwMDAwIDB4MDAgMHgxMDAwMD47DQo+ID4gKwkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDE4MyBJ
UlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4gPiArCQljbG9ja3MgPSA8JmszX2Nsa3MgMjQyIDI+Ow0K
PiA+ICsJCWNsb2NrLW5hbWVzID0gInZjb2RlYyI7DQo+ID4gKwkJcG93ZXItZG9tYWlucyA9IDwm
azNfcGRzIDI0MiBUSV9TQ0lfUERfRVhDTFVTSVZFPjsNCj4gPiArCQlzdGF0dXMgPSAiZGlzYWJs
ZWQiOw0KPiA+ICsJfTsNCj4gPiArDQo+ID4gICAJbWFpbl9zZGhjaTA6IG1tY0A0ZjgwMDAwIHsN
Cj4gPiAgIAkJY29tcGF0aWJsZSA9ICJ0aSxqNzIxZS1zZGhjaS04Yml0IjsNCj4gPiAgIAkJcmVn
ID0gPDB4MDAgMHgwNGY4MDAwMCAweDAwIDB4MTAwMD4sIGRpZmYgLS1naXQNCj4gPiBhL2FyY2gv
YXJtNjQvYm9vdC9kdHMvdGkvazMtajc4NHM0LmR0c2kNCj4gPiBiL2FyY2gvYXJtNjQvYm9vdC9k
dHMvdGkvazMtajc4NHM0LmR0c2kNCj4gPiBpbmRleCA0Mzk4YzNhNDYzZTEuLjkzYmIwY2JhMWI0
OCAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL3RpL2szLWo3ODRzNC5kdHNp
DQo+ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy90aS9rMy1qNzg0czQuZHRzaQ0KPiA+IEBA
IC0yNDcsNiArMjQ3LDggQEAgY2Jhc3NfbWFpbjogYnVzQDEwMDAwMCB7DQo+ID4gICAJCQkgPDB4
MDAgMHgzMDAwMDAwMCAweDAwIDB4MzAwMDAwMDAgMHgwMA0KPiAweDBjNDAwMDAwPiwgLyogTUFJ
TiBOQVZTUyAqLw0KPiA+ICAgCQkJIDwweDQxIDB4MDAwMDAwMDAgMHg0MSAweDAwMDAwMDAwIDB4
MDENCj4gMHgwMDAwMDAwMD4sIC8qIFBDSWUxIERBVDEgKi8NCj4gPiAgIAkJCSA8MHg0ZSAweDIw
MDAwMDAwIDB4NGUgMHgyMDAwMDAwMCAweDAwDQo+IDB4MDAwODAwMDA+LCAvKiBHUFUgKi8NCj4g
PiArCQkJIDwweDAwIDB4MDQyMTAwMDAgMHgwMCAweDA0MjEwMDAwIDB4MDANCj4gMHgwMDAxMDAw
MD4sIC8qIFZQVTAgKi8NCj4gPiArCQkJIDwweDAwIDB4MDQyMjAwMDAgMHgwMCAweDA0MjIwMDAw
IDB4MDANCj4gMHgwMDAxMDAwMD4sIC8qIFZQVTEgKi8NCj4gDQo+IEFkZCB0aGVzZSBpbiBzb3J0
ZWQgYnkgbWVtb3J5IGFkZHJlc3Mgb3JkZXIuDQoNCldpbGwgZG8gaW4gVjQgYXMgd2VsbC4NCg0K
PiANCj4gQW5kcmV3DQo+IA0KPiA+DQo+ID4gICAJCQkgLyogTUNVU1NfV0tVUCBSYW5nZSAqLw0K
PiA+ICAgCQkJIDwweDAwIDB4MjgzODAwMDAgMHgwMCAweDI4MzgwMDAwIDB4MDANCj4gMHgwMzg4
MDAwMD4sDQoNCkJyYW5kb24NCg==


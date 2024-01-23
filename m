Return-Path: <linux-kernel+bounces-35984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F395839996
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E0F1B2F016
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D802582D88;
	Tue, 23 Jan 2024 19:28:20 +0000 (UTC)
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC72823AE
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 19:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706038100; cv=none; b=mXLu14f5N7rT/GBwW8Eri6QTj+4RldE4iBScVjD89fWkqwHp4lNJnaL99SDwX/ppLO+vSNBG4B1vmf9eQff8EG/SKVtbvMNxW0hsaYDZiVurpVQzirRki7MihKDRu+bTYVkLqNzjBOMAESFppnyED9bzpm3XXYgt5tGm4Ox9OpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706038100; c=relaxed/simple;
	bh=x8IFdXnCeGIrbJjs7/ipMSRqhAWyyhvahEUt53Kfbz8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lmSNE55hiKUN7dW3alWcTQ+r/TKMyzFnZtxXMh10Dsris+sdsWtNoqjgeja9T8UsgfEfbSg1v1aygd7omfxrxS6v7f906U/uoTSQFSyZmhxwMrugkZYPtWLRGsJhoBgKgfgqoF/GwiWB5B1yLM7GD2mX1u3JAHnYCH/BYtHubOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (unknown [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 05EBF2C074C;
	Wed, 24 Jan 2024 08:28:09 +1300 (NZDT)
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65b013480001>; Wed, 24 Jan 2024 08:28:08 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.40; Wed, 24 Jan 2024 08:28:08 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.48; Wed, 24 Jan 2024 08:28:08 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.040; Wed, 24 Jan 2024 08:28:08 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Bjorn Andersson
	<andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, "Srinivas
 Kandagatla" <srinivas.kandagatla@linaro.org>, Banajit Goswami
	<bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Frank Rowand
	<frowand.list@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>, "alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
CC: Bartosz Golaszewski <brgl@bgdev.pl>, Sean Anderson
	<sean.anderson@seco.com>
Subject: Re: [PATCH v4 0/6] reset: gpio: ASoC: shared GPIO resets
Thread-Topic: [PATCH v4 0/6] reset: gpio: ASoC: shared GPIO resets
Thread-Index: AQHaTgZcl1ULQf9J4Eqr3ug6OQdT9LDm7pqA
Date: Tue, 23 Jan 2024 19:28:08 +0000
Message-ID: <6c3e4b71-c92f-4f1e-8435-b5cfb7f47117@alliedtelesis.co.nz>
References: <20240123141311.220505-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240123141311.220505-1-krzysztof.kozlowski@linaro.org>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <6388DE1362E6534FADA1D4908BCF3227@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=LZFCFQXi c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=35lJjsoYTdPToEE-BswA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

DQpPbiAyNC8wMS8yNCAwMzoxMywgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gSGksDQo+
DQo+IFBhdGNoICMyIChjcHVmcmVxOiBkbyBub3Qgb3Blbi1jb2RlIG9mX3BoYW5kbGVfYXJnc19l
cXVhbCgpKSBhbmQgcGF0Y2ggIzQNCj4gKHJlc2V0OiBJbnN0YW50aWF0ZSByZXNldCBHUElPIGNv
bnRyb2xsZXIgZm9yIHNoYXJlZCByZXNldC1ncGlvcykgZGVwZW5kIG9uIE9GDQo+IGNoYW5nZSAo
cGF0Y2ggIzEpLg0KPg0KPiBDaGFuZ2VzIGluIHY0DQo+ID09PT09PT09PT09PT0NCj4gMS4gTmV3
IHBhdGNoZXM6DQo+ICAgICBvZjogYWRkIG9mX3BoYW5kbGVfYXJnc19lcXVhbCgpIGhlbHBlcg0K
PiAgICAgY3B1ZnJlcTogZG8gbm90IG9wZW4tY29kZSBvZl9waGFuZGxlX2FyZ3NfZXF1YWwoKQ0K
Pg0KPiAyLiByZXNldC1ncGlvLmM6DQo+ICAgICAtIERyb3AgdW5uZWVkZWQgY29tbWVudCAoQmFy
dG9zeiksIGFkZCBSYiB0YWcuDQo+ICAgICAtIERvIG5vdCBhc3NpZ24gb2Zfbm9kZS4NCj4NCj4g
My4gcmVzZXQvY29yZS5jOg0KPiAgICAgLSBJbXBsZW1lbnQgbW9zdCBvZiBCYXJ0b3N6IGZlZWRi
YWNrIChJIHJlc3BvbmRlZCB0byBvbmUgd2hpY2ggSSBkaWQgbm90DQo+ICAgICAgIGltcGxlbWVu
dCkgYW5kIGNvbW1lbnRzIGZyb20gUGhpbGlwcC4NCj4gICAgIC0gRXhwZWN0IGVpdGhlciByY2Rl
di0+b2ZfYXJncyBvciByY2Rldi0+b2Zfbm9kZS4NCj4gICAgIC0gRHJvcCBfX3Jlc2V0X2dwaW9z
X2FyZ3NfbWF0Y2goKSBhbmQgdXNlIGNvbW1vbiBoZWxwZXIgKFBoaWxpcHApLg0KPiAgICAgLSBN
b3ZlIGRlY2xhcmF0aW9ucyBvZiBhdXRvbWF0aWMtY2xlYW51cCB2YXJpYWJsZXMgaW4NCj4gICAg
ICAgX19yZXNldF9hZGRfcmVzZXRfZ3Bpb19sb29rdXAoKSB0byBwbGFjZSBvZiB1c2UgKEJhcnRv
c3opLg0KPiAgICAgLSBTZXBhcmF0ZSBncGlvX2RldmljZV9nZXRfbGFiZWwoKSBhbmQga3N0cmR1
cCgpIChQaGlsaXBwKS4NCj4gICAgIC0gQ29ycmVjdCBkb2MgZm9yIF9fcmVzZXRfYWRkX3Jlc2V0
X2dwaW9fZGV2aWNlKCksIHJld3JpdGUgZmV3IGNvbW1lbnRzLg0KPiAgICAgLSBEcm9wIHVubmVl
ZGVkICJyIiB2YXJpYWJsZSBpbiBfX3Jlc2V0X2ZpbmRfcmNkZXYoKSAoUGhpbGlwcCkuDQo+ICAg
ICAtIERyb3Agb2ZfcGhhbmRsZV9hcmdzIGluaXRpYWxpemF0aW9uIGluIF9fb2ZfcmVzZXRfY29u
dHJvbF9nZXQgKFBoaWxpcHApLg0KPiAgICAgLSBDaGVjayBpZiBDT05GSUdfUkVTRVRfR1BJTyBp
cyBlbmFibGVkIGJlZm9yZSB0cnlpbmcgdG8gbG9vayB1cCByZXNldC1ncGlvcy4NCj4NCj4gNC4g
RHJvcCBDaHJpcycgcGF0Y2g6ICJpMmM6IG11eGVzOiBwY2E5NTR4OiBBbGxvdyBzaGFyaW5nIHJl
c2V0IEdQSU8iLCBiZWNhdXNlDQo+ICAgICBkaXNjdXNzaW9uIGlzIG9uIGdvaW5nLg0KDQpJIGFj
dHVhbGx5IHRoaW5rIGl0IHdvdWxkIGhhdmUgYmVlbiBPSyBhcy1pcyB3aXRoIHlvdXIgbGF0ZXN0
IGNoYW5nZSB0byANCnJldHVybiBOVUxMIHdoZW4gQ09ORklHX1JFU0VUX0dQSU8gaXMgbm90IGVu
YWJsZWQuIEJ1dCBJJ20gaGFwcHkgdG8gDQpzdWJtaXQgaXQgaW5kZXBlbmRlbnRseSBhZnRlciB0
aGlzIHNlcmllcyBsYW5kcy4gSXQnbGwgZ2l2ZSBtZSBhIGNoYW5jZSANCnRvIGRvIGEgYml0IG1v
cmUgdGVzdGluZy4NCg0K


Return-Path: <linux-kernel+bounces-118985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D4188C248
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BABC1C3348B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230B65B5B3;
	Tue, 26 Mar 2024 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="morgrQ/1"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9526450A98
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711456639; cv=none; b=TQlB33k77+f5gBd0NhtZWS8eAv+ip3srjCTkNx57MUyd8DsZzV0pp9T/CSXPuBb8OrJPDFNVwYKFRx8xFm/TrvzjRvwXmYgj5xZ1qT7c5IvHVdFZJ7N3AsWIjXI+mHGPrJTtjel6ih4hBIHu4r+22xYWi+R5VeQubrjX3D7Nwoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711456639; c=relaxed/simple;
	bh=IXgQxKxy2wli3FGqfkXaiCnSw/3wyDfEiGy9PlgXW88=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y4QRiH2Mv5boYfqR7rUZc2OwmNK3biOOUPfYbkl/qhOLLtaZGDSu+uPI71h9AIWgaBrTfRhrfYuVH7uCeBVwciTQnmUWpzjA/M/J9Aa5vuSodM3v1eluVdqzSx/ybFyCcVmCE9WXfNZOGA3vAb0meAB5i0ngN4sTE0JRa2U0yLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=morgrQ/1; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42QCa5NH083623;
	Tue, 26 Mar 2024 07:36:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711456565;
	bh=IXgQxKxy2wli3FGqfkXaiCnSw/3wyDfEiGy9PlgXW88=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=morgrQ/1zpu55F0TZr8ONfTK83NWrQ5rRhixUqVpLWLCm31Oad9ZobUKOTxt8ZQaM
	 gk8JLbNPH0fqIOPomRFG1kS9L2ElmxrhNxiwJ4ymrlUGYoxUWvQo6GBwqrbOL27vMj
	 T1ernR2Z3mBoZ2sZXMRBCNZnlsAP0xHRvm4pCt2U=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42QCa5DB024519
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 Mar 2024 07:36:05 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Mar 2024 07:36:05 -0500
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.023; Tue, 26 Mar 2024 07:36:05 -0500
From: "Ding, Shenghao" <shenghao-ding@ti.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz"
	<perex@perex.cz>,
        "13916275206@139.com" <13916275206@139.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
        "bard.liao@intel.com" <bard.liao@intel.com>,
        "mengdong.lin@intel.com"
	<mengdong.lin@intel.com>,
        "yung-chuan.liao@linux.intel.com"
	<yung-chuan.liao@linux.intel.com>,
        "Lu, Kevin" <kevin-lu@ti.com>, "tiwai@suse.de" <tiwai@suse.de>,
        "Xu, Baojun" <baojun.xu@ti.com>, "soyer@irl.hu" <soyer@irl.hu>,
        "Baojun.Xu@fpt.com" <Baojun.Xu@fpt.com>,
        "Navada Kanyana, Mukund" <navada@ti.com>
Subject: RE: [EXTERNAL] Re: [PATCH v11] ASoc: tas2783: Add tas2783 codec
 driver
Thread-Topic: [EXTERNAL] Re: [PATCH v11] ASoc: tas2783: Add tas2783 codec
 driver
Thread-Index: AQHaegWBu01+gHvWf0ynPwZkCTlz1LE/heaAgAp3R8A=
Date: Tue, 26 Mar 2024 12:36:05 +0000
Message-ID: <51a81ac8aace456aae7d07634912367c@ti.com>
References: <20240319135811.186-1-shenghao-ding@ti.com>
 <34f404cd-a12d-4ffa-9398-72de3be244b3@linux.intel.com>
In-Reply-To: <34f404cd-a12d-4ffa-9398-72de3be244b3@linux.intel.com>
Accept-Language: en-US, zh-CN
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

SGkgR3V5DQpUaGFua3MgZm9yIHlvdXIgY29tbWVudHMuIEZlZWRiYWNrIGlubGluZQ0KDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBpZXJyZS1Mb3VpcyBCb3NzYXJ0IDxw
aWVycmUtbG91aXMuYm9zc2FydEBsaW51eC5pbnRlbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE1h
cmNoIDE5LCAyMDI0IDExOjM1IFBNDQo+IFRvOiBEaW5nLCBTaGVuZ2hhbyA8c2hlbmdoYW8tZGlu
Z0B0aS5jb20+OyBicm9vbmllQGtlcm5lbC5vcmcNCj4gQ2M6IGFuZHJpeS5zaGV2Y2hlbmtvQGxp
bnV4LmludGVsLmNvbTsgbGdpcmR3b29kQGdtYWlsLmNvbTsNCj4gcGVyZXhAcGVyZXguY3o7IDEz
OTE2Mjc1MjA2QDEzOS5jb207IGFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZzsNCj4gbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGlhbS5yLmdpcmR3b29kQGludGVsLmNvbTsNCj4gYmFy
ZC5saWFvQGludGVsLmNvbTsgbWVuZ2RvbmcubGluQGludGVsLmNvbTsgeXVuZy0NCj4gY2h1YW4u
bGlhb0BsaW51eC5pbnRlbC5jb207IEx1LCBLZXZpbiA8a2V2aW4tbHVAdGkuY29tPjsgdGl3YWlA
c3VzZS5kZTsgWHUsDQo+IEJhb2p1biA8YmFvanVuLnh1QHRpLmNvbT47IHNveWVyQGlybC5odTsg
QmFvanVuLlh1QGZwdC5jb207IE5hdmFkYQ0KPiBLYW55YW5hLCBNdWt1bmQgPG5hdmFkYUB0aS5j
b20+DQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCB2MTFdIEFTb2M6IHRhczI3ODM6
IEFkZCB0YXMyNzgzIGNvZGVjDQo+IGRyaXZlcg0KPiANCj4gPiArc3RhdGljIGJvb2wgdGFzMjc4
M19yZWFkYWJsZV9yZWdpc3RlcihzdHJ1Y3QgZGV2aWNlICpkZXYsID4gKw0KPiA+ICt1bnNpZ25l
ZCBpbnQgcmVnKSA+ICt7ID4gKyBzd2l0Y2ggKHJlZykgeyA+ICsgLyogUGFnZSAwICovID4gKyBj
YXNlDQo+ID4gKzB4ODAwMCAuLuKAii4gMHg4MDdGOiA+ICsgcmV0dXJuIHRydWU7ID4gKyBkZWZh
dWx0OiA+ICsgcmV0dXJuIGZhbHNlOw0KPiA+ICtzbyBvbmx5IHRoZSByZWdpc3RlcnMNCj4gWmpR
Y21RUllGcGZwdEJhbm5lclN0YXJ0DQo+IFRoaXMgbWVzc2FnZSB3YXMgc2VudCBmcm9tIG91dHNp
ZGUgb2YgVGV4YXMgSW5zdHJ1bWVudHMuDQo+IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2duaXplIHRoZSBzb3VyY2Ugb2YNCj4gdGhpcyBlbWFp
bCBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gWmpRY21RUllGcGZwdEJhbm5l
ckVuZA0KPiANCj4gPiArc3RhdGljIGJvb2wgdGFzMjc4M19yZWFkYWJsZV9yZWdpc3RlcihzdHJ1
Y3QgZGV2aWNlICpkZXYsDQouLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4NCj4gPiArDQo+ID4gKwkvKiBDaGVjayBDYWxpYnJhdGVkIERhdGEgVjIgKi8NCj4g
PiArCWlmICh0bXBfdmFsWzBdID09IDI3ODMpIHsNCj4gPiArCQljb25zdCBzdHJ1Y3QgY2FsaWJk
YXRhdjJfaW5mbyBjYWxpYl9pbmZvID0gew0KPiA+ICsJCQkubnVtYmVyX29mX2RldmljZXMgPSB0
bXBfdmFsWzFdLA0KPiA+ICsJCQkuY3JjMzJfaW5keCA9IDMgKyB0bXBfdmFsWzFdICogNiwNCj4g
PiArCQkJLmJ5dF9zeiA9IDEyICsgdG1wX3ZhbFsxXSAqIDI0LA0KPiA+ICsJCQkuY2FsaV9kYXRh
ID0gJnRtcF92YWxbM10NCj4gPiArCQl9Ow0KPiA+ICsNCj4gPiArCQlpZiAoY2FsaWJfaW5mby5u
dW1iZXJfb2ZfZGV2aWNlcyA+DQo+IFRBUzI3ODNfTUFYX0RFVl9OVU0gfHwNCj4gPiArCQkJY2Fs
aWJfaW5mby5udW1iZXJfb2ZfZGV2aWNlcyA9PSAwKSB7DQo+ID4gKwkJCWRldl9kYmcodGFzX2Rl
di0+ZGV2LCAiTm8gZGV2IGluIGNhbGlicmF0ZWQgZGF0YQ0KPiBWMi4iKTsNCj4gDQo+IHRoZSBs
b2cgaXMgbm90IGFsaWduZWQgd2l0aCB0aGUgZmlyc3QgY29uZGl0aW9uIHdoZXJlIHlvdSBoYXZl
IHRvbyBtYW55DQo+IGRldmljZXMuDQo+IA0KPiBJdCdzIG5vdCBjbGVhciB3aHkgaXQncyBub3Qg
YW4gZXJyb3IuDQpwbGF5YmFjayBzdGlsbCB3b3JrIHdpdGhvdXQgY2FsaWJyYXRlZCBkYXRhIHN0
b3JlZCBpbiBVRUZJLCBmb3IgZXhhbXBsZSBieXBhc3MgbW9kZS4NCkV2ZW4gaWYgaW4gY2FzZSBv
ZiBieXBhc3MgbW9kZSwgYWxnbyBjYW4gc3RpbGwgd29yayB3aXRoIGRlZmF1bHQgY2FsaWJyYXRl
ZCBkYXRhLg0KU28sIG5vdCBhbiBlcnJvci4NCj4gDQo+ID4gKwkJCXJldHVybjsNCj4gPiArCQl9
DQo+ID4gKwkJY3JjID0gY3JjMzIofjAsIGNhbGlfZGF0YS5kYXRhLCBjYWxpYl9pbmZvLmJ5dF9z
eikNCj4gPiArCQkJXiB+MDsNCj4gPiArCQlpZiAoY3JjID09IHRtcF92YWxbY2FsaWJfaW5mby5j
cmMzMl9pbmR4XSkgew0KPiA+ICsJCQl0YXMyNzgzX2FwcGx5X2NhbGlidjIodGFzX2RldiwgJmNh
bGliX2luZm8pOw0KPiA+ICsJCQlkZXZfZGJnKHRhc19kZXYtPmRldiwgIlYyOiAlcHRUcyIsDQo+
IA0KPiBzYW1lLCBpcyB0aGlzIG5lZWRlZD8NCkFjY2VwdGVkLg0KPiA+ICsNCj4gCSZ0bXBfdmFs
W1RBUzI3ODNfQ0FMSURBVEFWMl9USU1FU1RBTVBfSU5EWF0pOw0KPiA+ICsJCX0gZWxzZSB7DQo+
ID4gKwkJCWRldl9kYmcodGFzX2Rldi0+ZGV2LA0KPiA+ICsJCQkJIlYyOiBDUkMgMHglMDh4IG5v
dCBtYXRjaCAweCUwOHhcbiIsDQo+ID4gKwkJCQljcmMsIHRtcF92YWxbY2FsaWJfaW5mby5jcmMz
Ml9pbmR4XSk7DQo+IA0KPiBpcyB0aGlzIG5vdCBhbiBlcnJvcj8NCj4gDQo+ID4gKwkJfQ0KPiA+
ICsJfSBlbHNlIHsNCj4gPiArCQlkZXZfZXJyKHRhc19kZXYtPmRldiwgIk5vbi0yNzgzIGNoaXBc
biIpOw0KPiA+ICsJfQ0KPiA+ICt9DQo+IA0KPiB0aGUgZXJyb3IgbGV2ZWwgc2VlbSBpbmNvbnNp
c3RlbnQgYW5kIGl0J3Mgbm90IGNsZWFyIHdoeSBlcnJvcnMgYXJlIGlnbm9yZWQ/DQpNYXliZSBz
ZXQgdGhlbSBhcyBkZXZfd2Fybj8NCg0K


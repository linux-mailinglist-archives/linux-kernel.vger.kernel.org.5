Return-Path: <linux-kernel+bounces-422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A47808140EF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 05:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E9741F21BF5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 04:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5844863B2;
	Fri, 15 Dec 2023 04:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="0XwQS7wt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD1F5698
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 04:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 470E12C0381;
	Fri, 15 Dec 2023 17:21:58 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1702614118;
	bh=SVUOOR0rCQvpdqTF1+SbvUi+Db5NcfNoL6CdiMFlLV4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=0XwQS7wtY455IRqvSdYmrZyxK25QiEh6tNCgbfG+xU6M9FiyUr1DAG1A2GPNGS1O+
	 qYqUaPzsJXWsUrnQIKAABIXp2GrQhgI0KYP2FMuJDcgVObFr5yh5T+SVsV3EDX10zb
	 FCFVLTyFV2IR52mSwwwH2j8uheLSBnNw9Q94YjBikMgbT+b08NOFMIv/muh1gpPZPe
	 UPR4vg7AfdCyz3GX+ZFWr0kX+x//DeAJ5+mc4W1Lq3GJ4+EYq67/wBh+AHoXSDTog4
	 PfwC7fXg2CAd3KnFJYHx2bPP2XymZNcJuFr0Z+7j3GrR3erl/Gkp8NwKUJhmFt/H7U
	 UDScGFPB2Tedw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B657bd4660001>; Fri, 15 Dec 2023 17:21:58 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.40; Fri, 15 Dec 2023 17:21:58 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with Microsoft
 SMTP Server (TLS) id 15.0.1497.48; Fri, 15 Dec 2023 17:21:57 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.040; Fri, 15 Dec 2023 17:21:57 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Elad Nachman <enachman@marvell.com>, "wim@linux-watchdog.org"
	<wim@linux-watchdog.org>, "linux@roeck-us.net" <linux@roeck-us.net>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "gregory.clement@bootlin.com"
	<gregory.clement@bootlin.com>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"fu.wei@linaro.org" <fu.wei@linaro.org>, "Suravee.Suthikulpanit@amd.com"
	<Suravee.Suthikulpanit@amd.com>, "al.stone@linaro.org" <al.stone@linaro.org>,
	"timur@codeaurora.org" <timur@codeaurora.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "cyuval@marvell.com" <cyuval@marvell.com>
Subject: Re: [PATCH 0/3] watchdog: sbsa_gwdt: add support for Marvell ac5
Thread-Topic: [PATCH 0/3] watchdog: sbsa_gwdt: add support for Marvell ac5
Thread-Index: AQHaLp7UhCt7s/9TXkCz5F6TLW3ne7Co5U+A
Date: Fri, 15 Dec 2023 04:21:57 +0000
Message-ID: <cdfee2e1-8a94-4e44-b81b-0ade384fa481@alliedtelesis.co.nz>
References: <20231214150414.1849058-1-enachman@marvell.com>
In-Reply-To: <20231214150414.1849058-1-enachman@marvell.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5162494EBD49B49BA2701D403EFDFFB@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=CYB2G4jl c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=e2cXIFwxEfEA:10 a=M5GUcnROAAAA:8 a=K2GjWCfgx9wMK7TpFYYA:9 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-SEG-SpamProfiler-Score: 0

DQpPbiAxNS8xMi8yMyAwNDowNCwgRWxhZCBOYWNobWFuIHdyb3RlOg0KPiBGcm9tOiBFbGFkIE5h
Y2htYW4gPGVuYWNobWFuQG1hcnZlbGwuY29tPg0KPg0KPiBBZGQgc3VwcG9ydCBmb3IgTWFydmVs
bCBhYzUveCB2YXJpYW50IG9mIHRoZSBBUk0NCj4gc2JzYSBnbG9iYWwgd2F0Y2hkb2cuIFRoaXMg
d2F0Y2hkb2cgZGV2aWF0ZXMgZnJvbQ0KPiB0aGUgc3RhbmRhcmQgZHJpdmVyIGJ5IHRoZSBmb2xs
b3dpbmcgaXRlbXM6DQo+DQo+IDEuIFJlZ2lzdGVycyByZXNpZGUgaW4gc2VjdXJlIHJlZ2lzdGVy
IHNlY3Rpb24uDQo+ICAgICBoZW5jZSBhY2Nlc3MgaXMgb25seSBwb3NzaWJsZSB2aWEgU01DIGNh
bGxzIHRvIEFURi4NCj4NCj4gMi4gVGhlcmUgYXJlIGNvdXBsZSBtb3JlIHJlZ2lzdGVycyB3aGlj
aCByZXNpZGUgaW4NCj4gICAgIG90aGVyIHJlZ2lzdGVyIGFyZWFzLCB3aGljaCBuZWVkcyB0byBi
ZSBjb25maWd1cmVkDQo+ICAgICBpbiBvcmRlciBmb3IgdGhlIHdhdGNoZG9nIHRvIHByb3Blcmx5
IGdlbmVyYXRlDQo+ICAgICByZXNldCB0aHJvdWdoIHRoZSBTT0MuDQo+DQo+ICAgICBUaGUgbmV3
IE1hcnZlbGwgY29tcGF0aWJpbGl0eSBzdHJpbmcgZGlmZmVyZW50aWF0ZXMgYmV0d2Vlbg0KPiAg
ICAgdGhlIG9yaWdpbmFsIHNic2EgbW9kZSBvZiBvcGVyYXRpb24gYW5kIHRoZSBNYXJ2ZWxsIG1v
ZGUgb2YNCj4gICAgIG9wZXJhdGlvbi4NCg0KSSBnYXZlIHRoaXMgYSBxdWljayB0cnkgb24gb3Vy
IEFDNVggYmFzZWQgYm9hcmQgYW5kIGl0IHdvcmtlZCB3ZWxsIHdpdGggDQpib3RoIGFjdGlvbj0w
L2FjdGlvbj0xDQoNCj4gRWxhZCBOYWNobWFuICgzKToNCj4gICAgZHQtYmluZGluZ3M6IHdhdGNo
ZG9nOiBhZGQgTWFydmVsbCBBQzUgd2F0Y2hkb2cNCj4gICAgYXJtNjQ6IGR0czogYWM1OiBhZGQg
d2F0Y2hkb2cgbm9kZXMNCj4gICAgd2F0Y2hkb2c6IHNic2FfZ3dkdDogYWRkIHN1cHBvcnQgZm9y
IE1hcnZlbGwgYWM1DQo+DQo+ICAgLi4uL2JpbmRpbmdzL3dhdGNoZG9nL2FybSxzYnNhLWd3ZHQu
eWFtbCAgICAgIHwgIDUyICsrKy0NCj4gICBhcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYWM1
LTk4ZHgyNXh4LmR0c2kgfCAgMTQgKw0KPiAgIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9h
YzUtOThkeDM1eHguZHRzaSB8ICAgOCArDQo+ICAgZHJpdmVycy93YXRjaGRvZy9zYnNhX2d3ZHQu
YyAgICAgICAgICAgICAgICAgIHwgMjQ3ICsrKysrKysrKysrKysrKystLQ0KPiAgIDQgZmlsZXMg
Y2hhbmdlZCwgMjk4IGluc2VydGlvbnMoKyksIDIzIGRlbGV0aW9ucygtKQ0KPg==


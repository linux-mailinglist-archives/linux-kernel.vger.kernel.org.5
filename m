Return-Path: <linux-kernel+bounces-128726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F39FF895EAE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 315831C2190E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B6C15E7EB;
	Tue,  2 Apr 2024 21:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="IKg2GcXA"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8D815E804
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 21:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712092961; cv=none; b=aRlJzGSbFPFdbzQ8cFHce9OpGUs01Zj0NEtt0GHo4hHQ5GfvN35YO4cyaq6aY1NKk2LCdPOrSAlN/1SEFZNj1uO/DBvQetTmNsBIWDYDdCA6dRgS4X2xDXpr5D1PvqBq2LE42U5WC5ntEz/npeh4s8z1mpnlO7jP48BYWOZg3mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712092961; c=relaxed/simple;
	bh=QUoOOq239FWfIM+7L2bUVe4hfJusbR6KJkTFIMaw8fg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Sev/DJwuMVVYeM60utqPlN+p1cHvXQNpvOWnJWkYZHnRoNwB84eGWg0xI3cVpoI2Ef2ysCcEU0QQl6mlM+4hgmLPegkL3Aaquy9qLG1Z8jTXp52y3/gH4RySfPoLVNv4LgN+sKYysuEHK5udwbS1aPJZj+nUbJI5ssojPRCjlnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=IKg2GcXA; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 9CAC32C02E0;
	Wed,  3 Apr 2024 10:22:36 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1712092956;
	bh=QUoOOq239FWfIM+7L2bUVe4hfJusbR6KJkTFIMaw8fg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=IKg2GcXAjtxm8/cQX08HescMQYZYJfI9Rkb/9g+swaCT5eXdsabGq1t/woT1ub+oo
	 kq600bcPbf/OXnvOUcPcgOjZX/PwZ9OhDS1/GXhmX6FaeoOxgOlSPyu6aAJ6dWx3tW
	 Fei5DVa08UCyW54PsTS64/x6ZRWvM2wav3DB//4a/EMbCuJC0RgXLoA8E8L/SKYmSl
	 QSBfK3ETZLTNW54j/LU+uZetysNhyslHUqeVoBY+BJa+UwVPQbgGFhCdGhSeYkbwgD
	 dVZJtXo3ZYc+9SR4/akKIVk6oZXUK0QWIpDaWfGbiRjDcoeo/91NYyYsWhsZRPgYV0
	 KZ8e13Nqy1QfQ==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B660c771c0001>; Wed, 03 Apr 2024 10:22:36 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 3 Apr 2024 10:22:36 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.009; Wed, 3 Apr 2024 10:22:36 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Guenter Roeck <linux@roeck-us.net>
CC: "jdelvare@suse.com" <jdelvare@suse.com>, "linux-hwmon@vger.kernel.org"
	<linux-hwmon@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: hwmon: label vs temp%d_label
Thread-Topic: hwmon: label vs temp%d_label
Thread-Index: AQHahTvINn4/LiD+qEqZV7u6Rj72trFUnPeAgAAGZwA=
Date: Tue, 2 Apr 2024 21:22:36 +0000
Message-ID: <448b5cfb-b433-4b38-98ae-066bda44f1fd@alliedtelesis.co.nz>
References: <9a09bf46-d097-4e5b-bdb3-cc9dc6f5d01c@alliedtelesis.co.nz>
 <fdd952dd-2f3c-4f66-8e73-68f1dadde237@roeck-us.net>
In-Reply-To: <fdd952dd-2f3c-4f66-8e73-68f1dadde237@roeck-us.net>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D3FD5929821634B9CB59D6C5620BFD7@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=KIH5D0Fo c=1 sm=1 tr=0 ts=660c771c a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=X1bIBW7fO_EA:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=raytVjVEu-sA:10 a=VNa-VUgOKwxTY--yjHkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

DQpPbiAzLzA0LzI0IDA5OjU5LCBHdWVudGVyIFJvZWNrIHdyb3RlOg0KPiBPbiBUdWUsIEFwciAw
MiwgMjAyNCBhdCAwODoyNDozN1BNICswMDAwLCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPj4gSGkg
R3VlbnRlciwgSmVhbiwNCj4+DQo+PiBJJ3ZlIGdvdCBhIHJlcXVpcmVtZW50IHRvIGFkZCBzb21l
IG1lYW5pbmdmdWwgbmFtZXMgdG8gc29tZSBod21vbg0KPj4gc2Vuc29ycyAoTE03NSBzcGVjaWZp
Y2FsbHkpIHNvIHRoYXQgd2UgY2FuIHByb3ZpZGUgc29tZSBpbmRpY2F0aW9uIG9mDQo+PiB3aGVy
ZSBvbiBhIGJvYXJkIHRoZSBzZW5zb3IgaXMgbG9jYXRlZCAoZS5nLiAiSW50YWtlIiB2cyAiRXho
YXVzdCIgdnMNCj4+ICJOZWFyIHRoYXQgcmVhbGx5IGhvdCBjaGlwIikuDQo+Pg0KPj4gSSBzZWUg
dGhhdCB0aGUgc3lzZnMgQUJJIGRvY3VtZW50cyBib3RoICJsYWJlbCIgZm9yIHRoZSBjaGlwIGFu
ZA0KPj4gInRlbXBbMS0qXV9sYWJlbCIgKGFzIHdlbGwgYXMgc2ltaWxhciBmYW4gYW5kIFZpbiBh
dHRyaWJ1dGVzKS4gVGhlDQo+PiBsYXR0ZXIgc2VlbSB0byBiZSBzdXBwb3J0ZWQgYnkgdGhlIGh3
bW9uIGNvcmUgYnV0IEkgZG9uJ3Qgc2VlIGFueXRoaW5nDQo+PiBmb3IgdGhlIGZvcm1lciAoSSdt
IHN0cnVnZ2xpbmcgdG8gZmluZCBhbnkgZHJpdmVyIHRoYXQgc3VwcG9ydHMgYQ0KPj4gY2hpcC13
aWRlIGxhYmVsKS4NCj4+DQo+PiBBc3N1bWluZyBJIHdhbnQgdG8gaGF2ZSBhIGxhYmVsIGFkZGVk
IGluIHRoZSBkZXZpY2UgdHJlZSB0byBhIGxtNzUgd291bGQNCj4+IHNvbWV0aGluZyBsaWtlIHRo
ZSBmb2xsb3dpbmcgYmUgYWNjZXB0YWJsZQ0KPj4NCj4+ICAgwqDCoMKgwqDCoCBzZW5zb3JANDgg
ew0KPj4gICDCoMKgwqDCoMKgwqDCoCBjb21wYXRpYmxlID0gIm5hdGlvbmFsLGxtNzUiOw0KPj4g
ICDCoMKgwqDCoMKgwqDCoCByZWcgPSA8MHg0OD47DQo+PiAgIMKgwqDCoMKgwqDCoMKgIGxhYmVs
ID0gIkludGFrZSI7DQo+PiAgIMKgwqDCoMKgwqAgfTsNCj4+DQo+PiBJJ2QgdGhlbiB1cGRhdGUg
dGhlIGxtNzUgZHJpdmVyIHRvIGdyYWIgdGhhdCBmcm9tIHRoZSBkZXZpY2V0cmVlIGFuZCB1c2UN
Cj4+IGl0IHRvIHByb3ZpZGUgdGhlIGh3bW9uX3RlbXBfbGFiZWwgYXR0cmlidXRlLg0KPj4NCj4g
SGF2ZSB5b3UgdHJpZWQganVzdCBkZWNsYXJpbmcgdGhlIGxhYmVsIHByb3BlcnR5IGFzIHlvdSBz
dWdnZXN0ZWQgYWJvdmUNCj4gaW4geW91ciBzeXN0ZW0gd2l0aG91dCBkb2luZyBhbnl0aGluZyBl
bHNlLCBhbmQgbG9va2VkIGF0IHRoZSBnZW5lcmF0ZWQNCj4gc3lzZnMgYXR0cmlidXRlcyA/DQoN
CkkgaGF2ZSBub3QuIEJ1dCBpbiBteSBkZWZlbnNlIEknbSBhbHNvIHVzaW5nIGFuIG9sZGVyIGtl
cm5lbCBMVFMgdGhhdCANCmRvZXNuJ3QgaGF2ZSBjb21taXQgZTFjOWQ2ZDYxZGRmICgiaHdtb246
IEFkZCAibGFiZWwiIGF0dHJpYnV0ZSIpLiBCdXQgDQpub3cgdGhhdCBJIGtub3cgaXQgZXhpc3Rz
IEkgY2FuIGNhcnJ5IGl0IGFzIGEgbG9jYWwgcGF0Y2ggdW50aWwgd2UgbmV4dCANCnVwZGF0ZS4N
Cg0KVGhhbmtzLA0KQ2hyaXMNCg==


Return-Path: <linux-kernel+bounces-36948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0984B83A940
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6560628A1CE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0BF63122;
	Wed, 24 Jan 2024 12:08:20 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541C360DEC
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 12:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706098099; cv=none; b=sssgfrmRoPgspZBA52vAZ/HMEU1eev5K24N68bCGNr+GIYURmCUqODv4srQa/SroW+Sw4grfG4FDquYtb2f5IZG5mboxBWvvcPY43QyY4LS8BDwHnSf/O7FWjFzT/KS8RanvcydLVovbBKIuLFAN/S7PSDySSMiehhCqde0EQ0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706098099; c=relaxed/simple;
	bh=j8m38Wxa0ueG/c2usEBBoOWFaURw0WrD5+sPcGSKHQw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=dBIJ7Yi91nqYOUwnRDVRmkxoT/yhlJ2BfnLD+oeAxTkEhhfXL10l4BMACTbFs0zFf5bMvPl4DgnvbeMu/89iB2YQTUE6zA8Xe3dqQMakCMgucEv37UNfX++SVCsdzZlF1KdfaGDlv8iXWtC+f6N+BVwyAhDsKkmgaI4htoctJS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-65-CWVIYUQzONCGT7J_c3iAPg-1; Wed, 24 Jan 2024 12:08:14 +0000
X-MC-Unique: CWVIYUQzONCGT7J_c3iAPg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 24 Jan
 2024 12:07:55 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 24 Jan 2024 12:07:55 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Jens Axboe' <axboe@kernel.dk>, LKML <linux-kernel@vger.kernel.org>
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>
Subject: RE: [PATCH] iov_iter: streamline iovec/bvec alignment iteration
Thread-Topic: [PATCH] iov_iter: streamline iovec/bvec alignment iteration
Thread-Index: AQHaTjVALU/5Ken0i0iH5Q5cLi4B8rDo3vlA
Date: Wed, 24 Jan 2024 12:07:55 +0000
Message-ID: <9b43b9f3a32642e5a6388f3b1c8b114d@AcuMS.aculab.com>
References: <bd2f28ab-78cf-4ae0-a62a-d23a94fb3839@kernel.dk>
In-Reply-To: <bd2f28ab-78cf-4ae0-a62a-d23a94fb3839@kernel.dk>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogSmVucyBBeGJvZQ0KPiBTZW50OiAyMyBKYW51YXJ5IDIwMjQgMTk6NDkNCj4gDQo+IFJl
d3JpdGUgaW92X2l0ZXJfYWxpZ25lZF9pb3ZlYygpIGFuZCBpb3ZfaXRlcl9hbGlnbmVkX2J2ZWMo
KSB0byBiZSBib3RoDQo+IGVhc2llciB0byByZWFkLCBhbmQgYWxzbyBzaWduaWZpY2FudGx5IG1v
cmUgY29tcGFjdCBpbiB0ZXJtcyBvZg0KPiBnZW5lcmF0ZWQgY29kZS4gVGhpcyBzYXZlcyAxNzgg
Ynl0ZXMgb2YgdGV4dCBvbiB4ODYtNjQgZm9yIG1lICh3aXRoDQo+IGNsYW5nLTE4KSBhbmQgMTM2
IGJ5dGVzIG9uIGFybTY0ICh3aXRoIGdjYy0xMykuDQo+IA0KLi4uDQo+IGRpZmYgLS1naXQgYS9s
aWIvaW92X2l0ZXIuYyBiL2xpYi9pb3ZfaXRlci5jDQo+IGluZGV4IGUwYWE2YjQ0MGNhNS4uMmZj
YzQ3ZDgyMmUzIDEwMDY0NA0KPiAtLS0gYS9saWIvaW92X2l0ZXIuYw0KPiArKysgYi9saWIvaW92
X2l0ZXIuYw0KPiBAQCAtNzE0LDEyICs3MTQsMTEgQEAgRVhQT1JUX1NZTUJPTChpb3ZfaXRlcl9k
aXNjYXJkKTsNCi4uLg0KPiAtCWZvciAoayA9IDA7IGsgPCBpLT5ucl9zZWdzOyBrKyssIHNraXAg
PSAwKSB7DQo+IC0JCWNvbnN0IHN0cnVjdCBpb3ZlYyAqaW92ID0gaXRlcl9pb3YoaSkgKyBrOw0K
PiArCWRvIHsNCj4gIAkJc2l6ZV90IGxlbiA9IGlvdi0+aW92X2xlbiAtIHNraXA7DQoNCklzIGkt
Pm5yX3NlZ3MgYWxsb3dlZCB0byBiZSB6ZXJvPw0KVGhlIG9sZCBjb2RlIChzZWVtZWQgdG8pIGNo
ZWNrIGZvciB6ZXJvLg0KVGhlIG5ldyB2ZXJzaW9uIHdpbGwgZ28gaG9ycmlibHkgd3JvbmcuDQoN
CglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwg
TW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzog
MTM5NzM4NiAoV2FsZXMpDQo=



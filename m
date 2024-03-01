Return-Path: <linux-kernel+bounces-89169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F17FB86EB88
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9282D1F21385
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8A859141;
	Fri,  1 Mar 2024 21:58:53 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9665C54273
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 21:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709330332; cv=none; b=lAmeBQKFWZw7L/zOT0N+wVjG42Y9MzUgRCKQykmWHX3V3YiyFLwcdYrDMl03GNd6Yz1nABGdroC2vy7JFD0sLwbagazx3ruAfbhM2npXeAf1yhdBKbBYm9geNpBMo5g2PzhBJG5j8KUaCQ0hB2MkniNQCFX8xOdVq7EuDiG1mf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709330332; c=relaxed/simple;
	bh=qCBfkczFyAktNdJLsCmJAf1+pslthg3Q8FHNiNZ0JHY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=LHnANpVQ7rmtxcaiP79xtzJY8ULSAjzhRazOUfVntoTLrygFu7hKlPcaXzMgIbHjvrcFQXGMZEn/8tfe6DEJkOsV/d0DK4m4XHS6r++dJYqf5kvhbsdERTCVP28iBc3Hgn+1i3m+pFGTn551f3FdG+lbwfDfnHprk6kW0O2kA0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-187-ANi1P3KDNg-TLvPDunxNkw-1; Fri, 01 Mar 2024 21:58:45 +0000
X-MC-Unique: ANi1P3KDNg-TLvPDunxNkw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 1 Mar
 2024 21:58:43 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 1 Mar 2024 21:58:43 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Chris Li' <chrisl@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, Yosry Ahmed
	<yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>, Johannes Weiner
	<hannes@cmpxchg.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chengming Zhou <zhouchengming@bytedance.com>, Barry Song
	<v-songbaohua@oppo.com>
Subject: RE: [PATCH v2] zswap: replace RB tree with xarray
Thread-Topic: [PATCH v2] zswap: replace RB tree with xarray
Thread-Index: AQHaauvOjxzLEbVhBE68Iy55RbwJdrEjcLVw
Date: Fri, 1 Mar 2024 21:58:43 +0000
Message-ID: <26e77602326d4e169a9484314cac2465@AcuMS.aculab.com>
References: <20240229-zswap-xarray-v2-1-e50284dfcdb1@kernel.org>
In-Reply-To: <20240229-zswap-xarray-v2-1-e50284dfcdb1@kernel.org>
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

RnJvbTogQ2hyaXMgTGkNCj4gU2VudDogMjkgRmVicnVhcnkgMjAyNCAwODo0Ng0KPiANCj4gVmVy
eSBkZWVwIFJCIHRyZWUgcmVxdWlyZXMgcmViYWxhbmNlIGF0IHRpbWVzLiBUaGF0DQo+IGNvbnRy
aWJ1dGVzIHRvIHRoZSB6c3dhcCBmYXVsdCBsYXRlbmNpZXMuIFhhcnJheSBkb2VzIG5vdA0KPiBu
ZWVkIHRvIHBlcmZvcm0gdHJlZSByZWJhbGFuY2UuIFJlcGxhY2luZyBSQiB0cmVlIHRvIHhhcnJh
eQ0KPiBjYW4gaGF2ZSBzb21lIHNtYWxsIHBlcmZvcm1hbmNlIGdhaW4uDQo+IA0KPiBPbmUgc21h
bGwgZGlmZmVyZW5jZSBpcyB0aGF0IHhhcnJheSBpbnNlcnQgbWlnaHQgZmFpbCB3aXRoDQo+IEVO
T01FTSwgd2hpbGUgUkIgdHJlZSBpbnNlcnQgZG9lcyBub3QgYWxsb2NhdGUgYWRkaXRpb25hbA0K
PiBtZW1vcnkuDQoNCldoYXQgaXMgdGhlIGRpZmZlcmVuY2UgaW4ga2VybmVsIG1lbW9yeSB1c2U/
DQpJSVJDIHNvbWVvbmUgcG9pbnRlZCBvdXQgKGluIHRoZSByb3NlYnVzaCB0aHJlYWQpIHRoYXQg
eGFycmF5DQp1c2VzIGEgbG90IG9mIGtlcm5lbCBtZW1vcnkgaWYgdGhlIGl0ZW1zIGFyZSByYW5k
b21seSBkaXN0cmlidXRlZC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtl
c2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBV
Sw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==



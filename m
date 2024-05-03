Return-Path: <linux-kernel+bounces-168222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F7F8BB550
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2F8428517B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C1859151;
	Fri,  3 May 2024 21:11:33 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D5D83CB8
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714770693; cv=none; b=SLuZNJmzxMrAIGog9avxwWScipV6WXYmOA1zDrFublRlWHLxBvFKHWBrAx30lAxK3knT54UUzix8047t0gHRKoYJ128o87zsP4wi9ENlurJOgba4nVgh5vGv0g/4bbzBXXE04T9q8TlPFrXg3M2vxFOsX2WrpXTDJ7FKeN0SlYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714770693; c=relaxed/simple;
	bh=GQMl/ZMjQH+yE6pO5lv00tf82rh65qrvDhQORINV/U8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Fb3I0WzWPun2KvqCBeOvjmrvR6VFP3gFRW9/g57iRQ16Hvl6xlHvfubXdM/0T4gduId6gli4BrwC44W9+iH2FE3ZhLL9346Zt08TvynZwQJ1HAKAkABWFcbgyxcTWA9NSsvv9MYMS3K0UfR16ge9CZfm7fSfJU2ZzFHK9xEWiPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-241-Q1lJQQW8PeWRE9Y4W_F7wg-1; Fri, 03 May 2024 22:11:20 +0100
X-MC-Unique: Q1lJQQW8PeWRE9Y4W_F7wg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 3 May
 2024 22:10:53 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 3 May 2024 22:10:53 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Waiman Long' <longman@redhat.com>, "'linux-kernel@vger.kernel.org'"
	<linux-kernel@vger.kernel.org>, "'peterz@infradead.org'"
	<peterz@infradead.org>
CC: "'mingo@redhat.com'" <mingo@redhat.com>, "'will@kernel.org'"
	<will@kernel.org>, "'boqun.feng@gmail.com'" <boqun.feng@gmail.com>, "'Linus
 Torvalds'" <torvalds@linux-foundation.org>,
	"'virtualization@lists.linux-foundation.org'"
	<virtualization@lists.linux-foundation.org>, 'Zeng Heng'
	<zengheng4@huawei.com>
Subject: RE: [PATCH next v2 5/5] locking/osq_lock: Optimise decode_cpu() and
 per_cpu_ptr().
Thread-Topic: [PATCH next v2 5/5] locking/osq_lock: Optimise decode_cpu() and
 per_cpu_ptr().
Thread-Index: Ado8NCf0vtha6NqURtGgfE7//QxHexhPrXlAAAq+3cA=
Date: Fri, 3 May 2024 21:10:53 +0000
Message-ID: <a2c35933c3de481faec0b201ab1a0c16@AcuMS.aculab.com>
References: <2b4e8a5816a742d2bd23fdbaa8498e80@AcuMS.aculab.com>
 <7c1148fe64fb46a7a81c984776cd91df@AcuMS.aculab.com>
 <9d4024ba-6422-4775-b934-bfa80a72a858@redhat.com>
 <16557e30-8353-4cd1-995b-23ec763d2b07@redhat.com>
In-Reply-To: <16557e30-8353-4cd1-995b-23ec763d2b07@redhat.com>
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

RnJvbTogV2FpbWFuIExvbmcNCj4gU2VudDogMDMgTWF5IDIwMjQgMTc6MDANCi4uLg0KPiBEYXZp
ZCwNCj4gDQo+IENvdWxkIHlvdSByZXNwaW4gdGhlIHNlcmllcyBiYXNlZCBvbiB0aGUgbGF0ZXN0
IHVwc3RyZWFtIGNvZGU/DQoNCkkndmUganVzdCByZWFwcGxpZWQgdGhlIHBhdGNoZXMgdG8gJ21h
c3RlcicgYW5kIHRoZXkgYWxsIGFwcGx5DQpjbGVhbmx5IGFuZCBkaWZmaW5nIHRoZSBuZXcgcGF0
Y2hlcyB0byB0aGUgb2xkIG9uZXMgZ2l2ZXMgbm8gZGlmZmVyZW5jZXMuDQpTbyBJIHRoaW5rIHRo
ZXkgc2hvdWxkIHN0aWxsIGFwcGx5Lg0KDQpXZXJlIHlvdSBzZWVpbmcgYSBzcGVjaWZpYyBwcm9i
bGVtPw0KDQpJIGRvbid0IHJlbWVtYmVyIGFueSBzdWdnZXN0ZWQgY2hhbmdlZCBlaXRoZXIuDQoo
QXBhcnQgZnJvbSBhIHZlcnkgbG9jYWwgdmFyaWFibGUgSSB1c2VkIHRvIGtlZXAgYSBwYXRjaCBp
c29sYXRlZC4pDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJy
YW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lz
dHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=



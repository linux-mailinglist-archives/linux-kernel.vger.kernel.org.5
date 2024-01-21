Return-Path: <linux-kernel+bounces-32198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 040C7835816
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 23:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC0211F21868
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 22:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7998138F80;
	Sun, 21 Jan 2024 22:18:41 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE8F38DDC
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 22:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705875521; cv=none; b=gq1P9TDJ2n44QJX0E+E5KmW77qZ0MtAHnouxe8fKY/HvUr8V36AUtzeJfJV69SNZJTbfsBMGQ6PSotYNIXbLQUsUpdydRdbGq/WcPr88wXRbAP3DqTKbWAJZE4IfcsNYsCJdjr/lz2ykGlKQUx/iAaJ7K8OSnv28de6bBtn9Vpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705875521; c=relaxed/simple;
	bh=nygEOmY4tiUQZD8Nz78osBPg27O8u0wY5EOk7X6w99E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=W+6QShf1AXaSweFh8RAXZxGP3CSgcCUhLRTqztUw2hY1ajhC6JhiBjkIuXygYiOjdMGAajrILyCovxSMZ7JzZheQb7FK0LshwpEBS8kopj5Q5tzo+C5YzQVeXo0WWr9ePGCZoELA2pCgEWBfoxgtxEB/boR5RhLPZkfwXUavp6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-281-eFEnWUa9P2KaNIVFV8PzgA-1; Sun, 21 Jan 2024 22:18:30 +0000
X-MC-Unique: eFEnWUa9P2KaNIVFV8PzgA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 21 Jan
 2024 22:18:06 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 21 Jan 2024 22:18:05 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>
CC: Stephen Rothwell <sfr@canb.auug.org.au>, Jiri Slaby <jirislaby@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: RE: [PATCH next v4 0/5] minmax: Relax type checks in min() and max().
Thread-Topic: [PATCH next v4 0/5] minmax: Relax type checks in min() and
 max().
Thread-Index: AdnqB/CwAvMQ3gkdSO607JUF4aSKdhZ9C6k7AAacz4AB9HBKgAAztg+A
Date: Sun, 21 Jan 2024 22:18:05 +0000
Message-ID: <8aaf72d07b464dc1aeee5f66fba05326@AcuMS.aculab.com>
References: <b97faef60ad24922b530241c5d7c933c@AcuMS.aculab.com>
 <18c6df0d-45ed-450c-9eda-95160a2bbb8e@gmail.com>
 <CAHk-=wjvM5KiQFpbPMPXH-DcvheNcPGj+ThNEJVm+QL6n05A8A@mail.gmail.com>
 <CAHk-=wjE1eLMtkKqTt0XqNSnKAeDagV=WQU+vxHL_wsLuO8Gag@mail.gmail.com>
 <CAHk-=whkGHOmpM_1kNgzX1UDAs10+UuALcpeEWN29EE0m-my=w@mail.gmail.com>
 <20240110171739.2e2d9de0@canb.auug.org.au>
 <CAHk-=wj1uqgU7hS=WqDSwEvc6=CwuWYBUmjSJAT6zx86CF=QBQ@mail.gmail.com>
 <ad3a9cf720cd4e1ebe942cdc84a6a670@AcuMS.aculab.com>
 <CAHk-=whKAaFmqNBEnY=n8Twnh6AEegHh7OL0YFkNS8b3xVQ-3w@mail.gmail.com>
In-Reply-To: <CAHk-=whKAaFmqNBEnY=n8Twnh6AEegHh7OL0YFkNS8b3xVQ-3w@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjAgSmFudWFyeSAyMDI0IDIxOjM0DQo+IA0K
PiBbIEdvaW5nIHRocm91Z2ggc29tZSBwZW5kaW5nIGlzc3VlcyBub3cgdGhhdCBJJ3ZlIG1vc3Rs
eSBlbXB0aWVkIG15IHB1bGwgcXVldWUgXQ0KPiANCj4gT24gV2VkLCAxMCBKYW4gMjAyNCBhdCAx
NDo1OCwgRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWlnaHRAYWN1bGFiLmNvbT4gd3JvdGU6DQo+ID4N
Cj4gPiBUaGUgZmlyc3QgY2hlY2sgaW4gX190eXBlc19vaygpIGNhbiBnbywgdGhlIHNlY29uZCBv
bmUgKHdpdGggdGhlICcrIDAnKQ0KPiA+IChhZGRlZCB0byBwcm9tb3RlIGNoYXIgdG8gaW50KSBp
bmNsdWRlcyB0aGUgZmlyc3Qgb25lLg0KPiANCj4gVGhhdCB0dXJucyBvdXQgdG8gbm90IGJlIHRy
dWUuIEFuIGV4cHJlc3Npb24gbGlrZQ0KPiANCj4gICBtaW4odTgsIHVuc2lnbmVkIGludCkNCj4g
DQo+IGlzIGZpbmUgYmVjYXVzZSB0aGUgdW5kZXJseWluZyB0eXBlcyBhcmUgY29tcGF0aWJsZS4N
Cj4gDQo+IEJ1dCB0aGUgcHJvbW90aW9uIHRvICdpbnQnIG1ha2VzIHRoZSBmaXJzdCBhcmd1bWVu
dCBiZSBhIHNpZ25lZA0KPiBpbnRlZ2VyLCBhbmQgaXMgbm8gbG9uZ2VyIGNvbXBhdGlibGUgd2l0
aCB0aGUgc2Vjb25kIGFyZ3VtZW50Lg0KDQpZZXMsIEkgcmVhbGlzZWQgdGhhdCBhZnRlcndhcmRz
Lg0KDQpUaGlzIHZlcnNpb24gaXMgbXVjaCBzaW1wbGVyIHRob3VnaC4NCg0KKy8qIEFsbG93IHVu
c2lnbmVkIGNvbXBhcmVzIGFnYWluc3Qgbm9uLW5lZ2F0aXZlIHNpZ25lZCBjb25zdGFudHMuICov
DQorI2RlZmluZSBfX2lzX29rX3Vuc2lnbmVkKHgpIFwNCisgICAgICAgKCFpc19zaWduZWRfdHlw
ZSh0eXBlb2YoeCkpIHx8IChfX2lzX2NvbnN0ZXhwcih4KSA/ICh4KSA+PSAwIDogMCkpDQorDQor
LyogQ2hlY2sgZm9yIHNpZ25lZCBhZnRlciBwcm9tb3RpbmcgdW5zaWduZWQgY2hhci9zaG9ydCB0
byBpbnQgKi8NCisjZGVmaW5lIF9faXNfb2tfc2lnbmVkKHgpIGlzX3NpZ25lZF90eXBlKHR5cGVv
ZigoeCkgKyAwKSkNCisNCisvKiBBbGxvdyBpZiBib3RoIHggYW5kIHkgYXJlIHZhbGlkIGZvciBl
aXRoZXIgc2lnbmVkIG9yIHVuc2lnbmVkIGNvbXBhcmVzLiAqLw0KKyNkZWZpbmUgX190eXBlc19v
ayh4LCB5KSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQorICAgICAgICgoX19pc19v
a19zaWduZWQoeCkgJiYgX19pc19va19zaWduZWQoeSkpIHx8ICAgIFwNCisgICAgICAgIChfX2lz
X29rX3Vuc2lnbmVkKHgpICYmIF9faXNfb2tfdW5zaWduZWQoeSkpKQ0KDQpBbmQgX1N0YXRjX2Fz
c2VydCgpIG9ubHkgbmVlZHMgYSBjb21waWxlLXRpbWUgY29uc3RhbnQsIG5vdA0KYSBjb25zdGFu
dCBleHByZXNzaW9uIC0gc28gbm8gbmVlZCBmb3IgYWxsIHRoZSBfX2J1aWx0aW5fY2hvb3NlX2V4
cHIoKS4NCg0KSSdsbCBwb3N0IHRoZSBhY3R1YWwgcGF0Y2ggc2VyaWVzIGluIGEgY291cGxlIG9m
IGRheXMuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1s
ZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJh
dGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=



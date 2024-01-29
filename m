Return-Path: <linux-kernel+bounces-42481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8978401EB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFA501F22E46
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCED5577B;
	Mon, 29 Jan 2024 09:40:00 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD89A55E4B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706521199; cv=none; b=cow9kCPnKL7QHdrBfic/xbFSK0sZUsIihUJIjho7fAMm/7mmlrjry3qj9g1BQ317G4+ZuDpqz2jYU3oj9y2t10w1agHc5z/Kb7zdd4xJpAN3zst97fF3NaHJ5WiR1p3/FBjIToWNZ3+Ez6czqiGaK6EtzZNbmtRu8lcHJErqiEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706521199; c=relaxed/simple;
	bh=xaq6GMMiSWKpV3vfwhO/Qauwj30MaFSJQmTvX2vGZKs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=kLug6Mg09pE5lz2DeWhHCrJEStBRfNuNzqTw6XFzr5mT+U8SJNE7BIBDij3R1YqPs0Nl2h4r4jtEhD8ppUGjUlyVjEPjv8jyVQiAFeJlLfFsAlj0wqHJlAgp0JyCDasyuxsI3byPLXuiO5jui5jqKVbemiM4zdP++XkN7ruLdn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-55-ICbmqgjGPH61LlJx9jyMGA-1; Mon, 29 Jan 2024 09:39:55 +0000
X-MC-Unique: ICbmqgjGPH61LlJx9jyMGA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 29 Jan
 2024 09:39:28 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 29 Jan 2024 09:39:28 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Lee Jones' <lee@kernel.org>
CC: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Sergey Senozhatsky
	<senozhatsky@chromium.org>, Crutcher Dunnavant
	<crutcher+kernel@datastacks.com>, Juergen Quade <quade@hsnr.de>
Subject: RE: [PATCH 1/1] lib/vsprintf: Implement ssprintf() to catch truncated
 strings
Thread-Topic: [PATCH 1/1] lib/vsprintf: Implement ssprintf() to catch
 truncated strings
Thread-Index: AQHaT3pqpS+sRHqV5U2M6pwWmFnMHbDtupAwgALQcwCAAAFuYA==
Date: Mon, 29 Jan 2024 09:39:28 +0000
Message-ID: <7054dcbfb7214665afedaea93ce4dbad@AcuMS.aculab.com>
References: <20240125083921.1312709-1-lee@kernel.org>
 <a37e8071-32ac-4f5d-95e8-ddd2eb21edcd@rasmusvillemoes.dk>
 <20240125103624.GC74950@google.com>
 <54e518b6dd9647c1add38b706eccbb4b@AcuMS.aculab.com>
 <20240129092440.GA1708181@google.com>
In-Reply-To: <20240129092440.GA1708181@google.com>
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

Li4uDQo+ID4gSSdtIHN1cmUgdGhhdCB0aGUgc2FmZXN0IHJldHVybiBmb3IgJ3RydW5jYXRlZCcg
aXMgdGhlIGJ1ZmZlciBsZW5ndGguDQo+ID4gVGhlIGEgc2VyaWVzIG9mIHN0YXRlbWVudHMgbGlr
ZToNCj4gPiAJYnVmICs9IHh4eChidWYsIGJ1Zl9lbmQgLSBidWYsIC4uLi4uKTsNCj4gPiBjYW4g
YWxsIGJlIGNhbGxlZCB3aXRoIGEgc2luZ2xlIG92ZXJmbG93IGNoZWNrIGF0IHRoZSBlbmQuDQo+
ID4NCj4gPiBGb3JnZXQgdGhlIGNoZWNrLCBhbmQgdGhlIGxlbmd0aCBqdXN0IGNvbnRhaW5zIGEg
dHJhaWxpbmcgJ1wwJw0KPiA+IHdoaWNoIG1pZ2h0IGNhdXNlIGNvbmZ1c2lvbiBidXQgaXNuJ3Qg
Z29pbmcgdG8gaW1tZWRpYXRlbHkNCj4gPiBicmVhayB0aGUgd29ybGQuDQo+IA0KPiBzbnByaW50
ZigpIGRvZXMgdGhpcyBhbmQgaGFzIGJlZW4gcHJvdmVuIHRvIGNhdXNlIGJ1ZmZlci1vdmVyZmxv
d3MuDQo+IFRoZXJlIGhhdmUgYmVlbiBtdWx0aXBsZSBhcnRpY2xlcyBhdXRob3JlZCBkZXNjcmli
aW5nIHdoeSB1c2luZw0KPiBzbnByaW50ZigpIGlzIG5vdCBnZW5lcmFsbHkgYSBnb29kIGlkZWEg
Zm9yIHRoZSBtYXNzZXMgaW5jbHVkaW5nIHRoZSAyDQo+IGxpbmtlZCBpbiB0aGUgY29tbWl0IG1l
c3NhZ2U6DQoNCnNucHJpbnRmKCkgcmV0dXJucyB0aGUgbnVtYmVyIG9mIGJ5dGVzIHRoYXQgd291
bGQgaGF2ZSBiZWVuIG91dHB1dCBbMV0uDQpJJ20gbm90IHN1Z2dlc3RpbmcgdGhhdCwgb3Igbm90
IHRlcm1pbmF0aW5nIHRoZSBidWZmZXIuDQpKdXN0IHJldHVybmluZyB0aGUgbGVuZ3RoIGluY2x1
ZGluZyB0aGUgJ1wwJyAodW5sZXNzIGxlbmd0aCB3YXMgemVybykuDQpUaGlzIHN0aWxsIGxldHMg
dGhlIGNvZGUgY2hlY2sgZm9yIG92ZXJmbG93IGJ1dCBpc24ndCBnb2luZyB0bw0KZ2VuZXJhdGUg
YSBwb2ludGVyIG91dHNpZGUgdGhlIGJ1ZmZlciBpZiB1c2VkIHRvIHVwZGF0ZSBhIHBvaW50ZXIu
DQoNClsxXSBJJ20gcHJldHR5IGNlcnRhaW4gdGhpcyBpcyBiZWNhdXNlIHRoZSBvcmlnaW5hbCBs
aWJjIHZlcnNpb24NCm9mIHNwcmludGYoKSBhbGxvY2F0ZWQgYSBGSUxFIHN0cnVjdHVyZSBvbiBz
dGFjayAoZnVsbHkgYnVmZmVyZWQpDQphbmQgY2FsbGVkIGZwcmludGYoKS4NCnNucHJpbnRmKCkg
d291bGQgaGF2ZSBiZWVuIGRvbmUgdGhlIHNhbWUgd2F5IGJ1dCB3aXRoIHNvbWV0aGluZw0KdG8g
c3RvcCB0aGUgYnVmZmVyIGJlaW5nIGZsdXNoZWQuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVk
IEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5l
cywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=



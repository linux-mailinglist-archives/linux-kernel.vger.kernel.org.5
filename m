Return-Path: <linux-kernel+bounces-60420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAC28504A5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 15:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A095A1C213DB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 14:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B26E53E23;
	Sat, 10 Feb 2024 14:15:11 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDA853E0E
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 14:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707574511; cv=none; b=mWy0ePs3Zuuwi6Ebj296+yJGOKT7ate8983CNZ/l+nNvS6vDnW3cOp06ztqirzTM8OJ7YZNxinxY9K77IDvg6ClUI88j3kxX5wLA1CbRnspzAZ+aVruxQEux0/DboOTu72u09mibqIGH7Ja7n2Qb9eGq3qm1kvd2k+yBfSkfAbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707574511; c=relaxed/simple;
	bh=f/gxJ5qjHSfh2Kv7N083IbPNPjUw9W0IJCyoJ29ppZM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=DMioIjXB6A/VYWdpO1VAY11MAE7siQM9ZpoZoQIdq96Wj6eXdqJF9kN0/h9QIqTTwBkLbF4DWnLnOY/HBkuNBMbecjpZW7ePdJAmzftKsMg9zVYNeVDvAaQcQeTCoPFhCLYV29JIDwMq02HZ85uxGO5lK5lQxdp4QOQg7Wt+mHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-206-OvN_bg1gPyq5vv5cS1WPOQ-1; Sat, 10 Feb 2024 14:15:06 +0000
X-MC-Unique: OvN_bg1gPyq5vv5cS1WPOQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 10 Feb
 2024 14:14:44 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 10 Feb 2024 14:14:44 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Alice Ryhl' <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
CC: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>, =?utf-8?B?QmrDtnJuIFJveSBCYXJvbg==?=
	<bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, "Andreas
 Hindborg" <a.hindborg@samsung.com>, Kees Cook <keescook@chromium.org>, Al
 Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	=?utf-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, Todd Kjos
	<tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes
	<joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, "Suren
 Baghdasaryan" <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "rust-for-linux@vger.kernel.org"
	<rust-for-linux@vger.kernel.org>, Christian Brauner <brauner@kernel.org>
Subject: RE: [PATCH 1/3] rust: add userspace pointers
Thread-Topic: [PATCH 1/3] rust: add userspace pointers
Thread-Index: AQHaWo3R3kxP8CVpE0illE6QcKzkeLEDnmOg
Date: Sat, 10 Feb 2024 14:14:44 +0000
Message-ID: <405e8b56cd0c48d0ba640e8d9c60179e@AcuMS.aculab.com>
References: <20240124-alice-mm-v1-0-d1abcec83c44@google.com>
 <20240124-alice-mm-v1-1-d1abcec83c44@google.com>
 <CALNs47uDaD05oD8TtZoSqUBc4SaRig80u2_1P0qMCXtE3H9_Vw@mail.gmail.com>
 <CAH5fLggdwWoq4wKv7VxZ-_VbWMV_Ui03rGOCMPbWn8=ewznmvA@mail.gmail.com>
In-Reply-To: <CAH5fLggdwWoq4wKv7VxZ-_VbWMV_Ui03rGOCMPbWn8=ewznmvA@mail.gmail.com>
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

Li4uDQo+ID4gTWF5YmUgc29tZXRoaW5nIGxpa2UNCj4gPg0KPiA+ICAgICBFdmVyeSB0aW1lIGEg
bWVtb3J5IGxvY2F0aW9uIGlzIHJlYWQsIHRoZSByZWFkZXIncyBwb3NpdGlvbiBpcyBhZHZhbmNl
ZCBieQ0KPiA+ICAgICB0aGUgcmVhZCBsZW5ndGggYW5kIHRoZSBuZXh0IHJlYWQgd2lsbCBzdGFy
dCBmcm9tIHRoZXJlLiBUaGlzIGhlbHBzIHByZXZlbnQNCj4gPiAgICAgYWNjaWRlbnRhbGx5IHJl
YWRpbmcgdGhlIHNhbWUgbG9jYXRpb24gdHdpY2UgYW5kIGNhdXNpbmcgYSBUT0NUT1UgYnVnLg0K
DQpXVEYgVE9DVE9VPyBJJ20gZ3Vlc3NpbmcgaXQgaXMgcmVhZGluZyB0aGluZ3MgdHdpY2UgYW5k
IGdldHRpbmcNCmRpZmZlcmVudCBhbnN3ZXJzLg0KDQpUaGF0IHJlYWxseSBkb2Vzbid0IG1hdGNo
IGhvdyBjb3B5aW5nIGZyb20gdXNlcnNwYWNlIGlzIHVzZWQgaXMgbWFueSBwbGFjZXMuDQpTb21l
dGltZXMgeW91IHJlYWxseSBkbyB3YW50IHRvIGJlIHVzaW5nIG9mZnNldHMgYW5kIGxlbmd0aHMu
DQpGb3IgaW5zdGFuY2UgdGhlIHVzZXIgYnVmZmVyIG1pZ2h0IGNvbnRhaW4gb2Zmc2V0cyBvZiBp
dGVtcyBmdXJ0aGVyDQpkb3duIHRoZSBidWZmZXIuDQpUaGVyZSBpcyBhbHNvIHRoZSBjb2RlIChl
ZyBpb2N0bCkgdGhhdCBkb2VzIGEgcmVhZC1tb2RpZnktd3JpdGUNCm9uIGEgYnVmZmVyLg0KDQoN
ClRoZXJlIGlzIGFsc28gdGhpcyBiaXQ6DQoNCj4gPiArICAgIC8vLyBSZWFkcyB0aGUgZW50aXJl
dHkgb2YgdGhlIHVzZXIgc2xpY2UuDQo+ID4gKyAgICAvLy8NCj4gPiArICAgIC8vLyBSZXR1cm5z
IGBFRkFVTFRgIGlmIHRoZSBhZGRyZXNzIGRvZXMgbm90IGN1cnJlbnRseSBwb2ludCB0bw0KPiA+
ICsgICAgLy8vIG1hcHBlZCwgcmVhZGFibGUgbWVtb3J5Lg0KPiA+ICsgICAgcHViIGZuIHJlYWRf
YWxsKHNlbGYpIC0+IFJlc3VsdDxWZWM8dTg+PiB7DQo+ID4gKyAgICAgICAgc2VsZi5yZWFkZXIo
KS5yZWFkX2FsbCgpDQo+ID4gKyAgICB9DQo+DQo+IElmIEkgdW5kZXJzdGFuZCBpdCBjb3JyZWN0
bHksIHRoZSBmdW5jdGlvbiB3aWxsIHJldHVybiBgRUZBVUxUYCBpZiBfYW55Xw0KPiBhZGRyZXNz
IGluIHRoZSBpbnRlcnZhbCBgW3NlbGYuMCwgc2VsZi4wICsgc2VsZi4xKWAgZG9lcyBub3QgcG9p
bnQgdG8NCj4gbWFwcGVkLCByZWFkYWJsZSBtZW1vcnkuIE1heWJlIHRoZSBkb2NzIGNvdWxkIGJl
IG1vcmUgZXhwbGljaXQuDQoNClRoYXQgaXNuJ3QgKGFuZCBjYW4ndCBiZSkgaG93IGl0IHdvcmtz
Lg0KYWNjZXNzX29rKCkgY2hlY2tzIHRoYXQgdGhlIGJ1ZmZlciBpc24ndCBpbiBrZXJuZWwgc3Bh
Y2UuDQpUaGUgY29weSBpcyB0aGVuIGRvbmUgdW50aWwgaXQgYWN0dWFsbHkgZmF1bHRzIG9uIGFu
IGludmFsaWQgYWRkcmVzcy4NCkluIHRoYXQgY2FzZSB0aGUgZGVzdGluYXRpb24gYnVmZmVyIGhh
cyBiZWVuIHVwZGF0ZWQgdG8gdGhlIHBvaW50DQpvZiBmYWlsdXJlLg0KDQpZb3UgY2FuJ3QgZG8g
YSBjaGVjayBiZWZvcmUgdGhlIGNvcHkgYmVjYXVzZSBhbm90aGVyIHRocmVhZCBjYW4NCmNoYW5n
ZSB0aGUgbWFwcGluZyAoaXQgd291bGQgYWxzbyBiZSBob3JyaWJseSBleHBlbnNpdmUpLg0KDQoJ
RGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1v
dW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEz
OTczODYgKFdhbGVzKQ0K



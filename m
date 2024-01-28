Return-Path: <linux-kernel+bounces-41619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D067A83F573
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 13:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9167E282BD1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 12:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401AB208AF;
	Sun, 28 Jan 2024 12:17:17 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F2E208B4
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 12:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706444236; cv=none; b=PclIobvy81jVUAECLyOy2x9kFBp2XyJnTU6i0nHsWRxERko7F0HyDlWrBs4U1q/YjFImU/eo6oLNwCLrqNLmJ8VrvOFkiuf8FLkTDGF45c7lw8FFO91GFVcBMWxT0Ccfz7nYkw0M4q9URZ/PNovGI/9DX1BwF8ZUOV9VVb82IGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706444236; c=relaxed/simple;
	bh=SozXLh3KenyMR0qcRmmuAZrWrBYZ30sZ1xNaH0/AzYQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=lhIY5qw9cUOkR5jGjz/H8dMtF+vqSbUPklOb9SCzSz3jOcnMrVHVMnP2Xoh2JXShq9XX5SvgAuGhFNatd9Xvnrj3LmaUFBlNWRyh6uaHCcID6VxMZ+JaQWDQO0z5qYGzrhB65ixmAsXUBodGgT5BBja80ZMAMDui+XNG9DFssKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-275--Xf6UUp_NjOr1vM6gW-ukg-1; Sun, 28 Jan 2024 12:17:05 +0000
X-MC-Unique: -Xf6UUp_NjOr1vM6gW-ukg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 28 Jan
 2024 12:16:42 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 28 Jan 2024 12:16:41 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Vincent MAILHOL' <mailhol.vincent@wanadoo.fr>, Finn Thain
	<fthain@linux-m68k.org>
CC: Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Yury Norov <yury.norov@gmail.com>, "Nick
 Desaulniers" <ndesaulniers@google.com>, Douglas Anderson
	<dianders@chromium.org>, Kees Cook <keescook@chromium.org>, Petr Mladek
	<pmladek@suse.com>, Randy Dunlap <rdunlap@infradead.org>, Zhaoyang Huang
	<zhaoyang.huang@unisoc.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Marco Elver <elver@google.com>, Brian Cain <bcain@quicinc.com>, "Geert
 Uytterhoeven" <geert@linux-m68k.org>, Matthew Wilcox <willy@infradead.org>,
	"Paul E . McKenney" <paulmck@kernel.org>, "linux-m68k@lists.linux-m68k.org"
	<linux-m68k@lists.linux-m68k.org>
Subject: RE: [PATCH v4 2/5] m68k/bitops: use __builtin_{clz,ctzl,ffs} to
 evaluate constant expressions
Thread-Topic: [PATCH v4 2/5] m68k/bitops: use __builtin_{clz,ctzl,ffs} to
 evaluate constant expressions
Thread-Index: AQHaUbL1xJNZnFSfqkuoXGWoPFOF8LDvIt6w
Date: Sun, 28 Jan 2024 12:16:41 +0000
Message-ID: <9d9be9dbe92f43d2a95d11d6b2f434c1@AcuMS.aculab.com>
References: <20221111081316.30373-1-mailhol.vincent@wanadoo.fr>
 <20240128050449.1332798-1-mailhol.vincent@wanadoo.fr>
 <20240128050449.1332798-3-mailhol.vincent@wanadoo.fr>
 <c47fedaf-cdc9-f970-460f-d2ee7e806da4@linux-m68k.org>
 <CAMZ6RqKj207uv5AF_fvb65nhCM32V=VAQXsUGLNmbeXYKPvZJg@mail.gmail.com>
In-Reply-To: <CAMZ6RqKj207uv5AF_fvb65nhCM32V=VAQXsUGLNmbeXYKPvZJg@mail.gmail.com>
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

RnJvbTogVmluY2VudCBNQUlMSE9MDQo+IFNlbnQ6IDI4IEphbnVhcnkgMjAyNCAwNjoyNw0KPiAN
Cj4gT24gU3VuLiAyOCBKYW4uIDIwMjQgYXQgMTQ6MzksIEZpbm4gVGhhaW4gPGZ0aGFpbkBsaW51
eC1tNjhrLm9yZz4gd3JvdGU6DQo+ID4gT24gU3VuLCAyOCBKYW4gMjAyNCwgVmluY2VudCBNYWls
aG9sIHdyb3RlOg0KPiA+DQo+ID4gPiBUaGUgY29tcGlsZXIgaXMgbm90IGFibGUgdG8gZG8gY29u
c3RhbnQgZm9sZGluZyBvbiAiYXNtIHZvbGF0aWxlIiBjb2RlLg0KPiA+ID4NCj4gPiA+IEV2YWx1
YXRlIHdoZXRoZXIgb3Igbm90IHRoZSBmdW5jdGlvbiBhcmd1bWVudCBpcyBhIGNvbnN0YW50IGV4
cHJlc3Npb24NCj4gPiA+IGFuZCBpZiB0aGlzIGlzIHRoZSBjYXNlLCByZXR1cm4gYW4gZXF1aXZh
bGVudCBidWlsdGluIGV4cHJlc3Npb24uDQo+ID4gPg0KLi4uDQo+ID4gSWYgdGhlIGJ1aWx0aW4g
aGFzIHRoZSBkZXNpcmVkIGJlaGF2aW91ciwgd2h5IGRvIHdlIHJlaW1wbGVtZW50IGl0IGluIGFz
bT8NCj4gPiBTaG91bGRuJ3Qgd2UgYWJhbmRvbiBvbmUgb3IgdGhlIG90aGVyIHRvIGF2b2lkIGhh
dmluZyB0byBwcm92ZSAoYW5kDQo+ID4gbWFpbnRhaW4pIHRoZWlyIGVxdWl2YWxlbmNlPw0KPiAN
Cj4gVGhlIGFzbSBpcyBtZWFudCB0byBwcm9kdWNlIGJldHRlciByZXN1bHRzIHdoZW4gdGhlIGFy
Z3VtZW50IGlzIG5vdCBhDQo+IGNvbnN0YW50IGV4cHJlc3Npb24uIEJlbG93IGNvbW1pdCBpcyBh
IGdvb2QgaWxsdXN0cmF0aW9uIG9mIHdoeSB3ZQ0KPiB3YW50IGJvdGggdGhlIGFzbSBhbmQgdGhl
IGJ1aWx0Og0KPiANCj4gICBodHRwczovL2dpdC5rZXJuZWwub3JnL3RvcnZhbGRzL2MvMTQ2MDM0
ZmVkNmVlDQo+IA0KPiBJIHNheSAiaXMgbWVhbnQiLCBiZWNhdXNlIEkgZGlkIG5vdCBhc3NlcnQg
d2hldGhlciB0aGlzIGlzIHN0aWxsIHRydWUuDQo+IE5vdGUgdGhhdCB0aGVyZSBhcmUgc29tZSBj
YXNlcyBpbiB3aGljaCB0aGUgYXNtIGlzIG5vdCBiZXR0ZXIgYW55bW9yZSwNCj4gZm9yIGV4YW1w
bGUsIHNlZSB0aGlzIHRocmVhZDoNCj4gDQo+ICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGtt
bC8yMDIyMTEwNjA5NTEwNi44NDkxNTQtMi1tYWlsaG9sLnZpbmNlbnRAd2FuYWRvby5mci8NCj4g
DQo+IGJ1dCBJIGRpZCBub3QgcmVjZWl2ZSBtb3JlIGFuc3dlcnMsIHNvIEkgc3RvcHBlZCB0cnlp
bmcgdG8gaW52ZXN0aWdhdGUNCj4gdGhlIHN1YmplY3QuDQo+IA0KPiBJZiB5b3Ugd2FudCwgeW91
IGNhbiBjaGVjayB0aGUgcHJvZHVjZWQgYXNzZW1ibHkgb2YgYm90aCB0aGUgYXNtIGFuZA0KPiB0
aGUgYnVpbHRpbiBmb3IgYm90aCBjbGFuZyBhbmQgZ2NjLCBhbmQgaWYgdGhlIGJ1aWx0aW4gaXMg
YWx3YXlzDQo+IGVpdGhlciBiZXR0ZXIgb3IgZXF1aXZhbGVudCwgdGhlbiB0aGUgYXNtIGNhbiBi
ZSByZW1vdmVkLiBUaGF0IHNhaWQsIEkNCj4gYW0gbm90IHNwZW5kaW5nIG1vcmUgZWZmb3J0IHRo
ZXJlIGFmdGVyIGJlaW5nIGdob3N0ZWQgb25jZSAoYy5mLiBhYm92ZQ0KPiB0aHJlYWQpLg0KDQpJ
IGRvbid0IHNlZSBhbnkgZXhhbXBsZSB0aGVyZSBvZiB3aHkgdGhlIF9fYnVpbHRpbl94eHgoKSB2
ZXJzaW9ucw0Kc2hvdWxkbid0IGJlIHVzZWQgYWxsIHRoZSB0aW1lLg0KKFRoZSB4ODYtNjQgYXNt
IGJsb2NrcyBjb250YWluIHVucmVsYXRlZCBjYWxsIGluc3RydWN0aW9ucyBhbmQgb2JqZHVtcA0K
d2Fzbid0IHBhc3NlZCAtZCB0byBzaG93IHdoYXQgdGhleSB3ZXJlLg0KT25lIGV2ZW4gaGFzIHRo
ZSAncmV0dXJuIHRodW5rIHBlc3NpbWlzYXRpb24gc2hvd2luZy4pDQoNCkkgYWN0dWFsbHkgc3Vz
cGVjdCB0aGUgYXNtIHZlcnNpb25zIHByZWRhdGUgdGhlIGJ1aWx0aW5zLg0KDQpEb2VzIChvciBj
YW4pIHRoZSBvdXRlciBjb21tb24gaGVhZGVyIHVzZSB0aGUgX19idWlsdGluIGZ1bmN0aW9ucw0K
aWYgbm8gYXNtIHZlcnNpb24gZXhpc3RzPw0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRy
ZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1L
MSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K



Return-Path: <linux-kernel+bounces-152567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAE18AC096
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 20:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D2A61F2127D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 18:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2B53F9CC;
	Sun, 21 Apr 2024 18:08:48 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD5A3D3B1
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 18:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713722928; cv=none; b=Nm0iOrSFvooPHKLNfKzN+Ia4y3zvUATZJXh4YosAfr7dlb1Eqb6r9hS7mR2eaezN5ir8Lgn8IuMH8p+8hplUzYI11vpoLb10IS3AUpAxA5yhq5aIFAqFyFhn5YtEj6wa9DO4lCFfdCdul8A6Q5tLfz5HmOI4YIJjXi11cTXN9Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713722928; c=relaxed/simple;
	bh=gUDiCMIV5dDgsOhLmHcr73y0oYouPqr4oEueMKW9clg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=jD2YByl5J6DyHuzP8Y60CszBHKQGA96Vpmu24dzy4aERTjHf4+PStXgLn8konJkf4C6/wIQ91q7V59VscUMrrztBfpNYczQDLnI4/7rDo6+HmBmScVWDi0fS/d/gAlyGY4lbr3VzyRYbyC2UPMd7wAjZREm/X/09VC+btI7hvBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-253-VTIi08JTPsaBNLatHnFI1w-1; Sun, 21 Apr 2024 19:08:36 +0100
X-MC-Unique: VTIi08JTPsaBNLatHnFI1w-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 21 Apr
 2024 19:08:02 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 21 Apr 2024 19:08:02 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Alice Ryhl' <aliceryhl@google.com>, "boqun.feng@gmail.com"
	<boqun.feng@gmail.com>
CC: "a.hindborg@samsung.com" <a.hindborg@samsung.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"alex.gaynor@gmail.com" <alex.gaynor@gmail.com>, "arnd@arndb.de"
	<arnd@arndb.de>, "arve@android.com" <arve@android.com>,
	"benno.lossin@proton.me" <benno.lossin@proton.me>, "bjorn3_gh@protonmail.com"
	<bjorn3_gh@protonmail.com>, "brauner@kernel.org" <brauner@kernel.org>,
	"cmllamas@google.com" <cmllamas@google.com>, "gary@garyguo.net"
	<gary@garyguo.net>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "joel@joelfernandes.org"
	<joel@joelfernandes.org>, "keescook@chromium.org" <keescook@chromium.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "maco@android.com"
	<maco@android.com>, "ojeda@kernel.org" <ojeda@kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	"surenb@google.com" <surenb@google.com>, "tkjos@android.com"
	<tkjos@android.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"wedsonaf@gmail.com" <wedsonaf@gmail.com>, "willy@infradead.org"
	<willy@infradead.org>
Subject: RE: [PATCH v5 1/4] rust: uaccess: add userspace pointers
Thread-Topic: [PATCH v5 1/4] rust: uaccess: add userspace pointers
Thread-Index: AQHaj+PoXR+cvvbs7Um8Z9suLdW8qbFzDUqQ
Date: Sun, 21 Apr 2024 18:08:02 +0000
Message-ID: <5a45ccc04cae4976900d031989104737@AcuMS.aculab.com>
References: <Zh2hw0uQrkN5yVVA@boqun-archlinux>
 <20240416095323.1107928-1-aliceryhl@google.com>
In-Reply-To: <20240416095323.1107928-1-aliceryhl@google.com>
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

U2hvdWxkIHlvdSBiZSBpbXBsZW1lbnRpbmcgJ3N0cnVjdCBpb3ZfaXRlcicgPw0KDQpFdmVuIGlm
IGl0IG1lYW5zIGNyZWF0aW5nIGFuIElPX1VCVUYgZm9yIGlvY3Rscz8NCihBbHRob3VnaCB0aGF0
IG1pZ2h0IHRha2Ugc29tZSAnZmV0dGxpbmcnIGZvciByZWFkK3dyaXRlIGZvciBpb2N0bHMuKQ0K
DQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQs
IE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86
IDEzOTczODYgKFdhbGVzKQ0K



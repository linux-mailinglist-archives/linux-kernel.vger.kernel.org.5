Return-Path: <linux-kernel+bounces-88188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A35686DE53
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 378C71C2206B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D856A8A5;
	Fri,  1 Mar 2024 09:32:23 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B946A34D
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 09:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709285542; cv=none; b=VMjyV1t0ghaLn9HytA77CtUtLtld9YkdMEd+afdl5ohIM6Kr13D/eLWgccmtJZdWxk+0i4687Ld0iStAmZiXguNT05F6v7TnqQlF6zkZA8nE8g2mDM/6TqtTSMIiveM9yFWWDDdp16f8dJ7NwE2qN70gyiuKhAVFn96LMuu9+hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709285542; c=relaxed/simple;
	bh=pY/JAuUkdZ3AyIyGff0Ip5uQfvmqurSeKSVYl4idjR0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=H9pCv8Vz8xFBbUl2+xm5CRUS6S9MZZnr1qczY6lSE5dFmwO/FBLzmebQgicR6YNscJtSTWmZb7vQd9vu6mS0brT9s5FWR+oJ/kBHxNLUk4v5LxE2OER9NBmjOUdzieCUqYz7xcJ7jHCZS24VQz4qnPrQp+Q/pGGlRRZ2QpWYRkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-144-cAe80tt0OtKldFFkrcHoig-1; Fri, 01 Mar 2024 09:32:17 +0000
X-MC-Unique: cAe80tt0OtKldFFkrcHoig-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 1 Mar
 2024 09:32:16 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 1 Mar 2024 09:32:16 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Kees Cook' <keescook@chromium.org>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>
CC: "Gustavo A . R . Silva" <gustavoars@kernel.org>, Miguel Ojeda
	<miguel.ojeda.sandonis@gmail.com>, Jani Nikula <jani.nikula@linux.intel.com>,
	Nick Desaulniers <ndesaulniers@google.com>, Martin Uecker
	<Martin.Uecker@med.uni-goettingen.de>, Jonathan Corbet <corbet@lwn.net>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Miguel Ojeda
	<ojeda@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>
Subject: RE: [PATCH] compiler.h: Explain how __is_constexpr() works
Thread-Topic: [PATCH] compiler.h: Explain how __is_constexpr() works
Thread-Index: AQHaa5MvghvgXFQBskOAdfSAj6aDybEilNag
Date: Fri, 1 Mar 2024 09:32:16 +0000
Message-ID: <af0eff12e6bc41039614add550406c11@AcuMS.aculab.com>
References: <20240301044428.work.411-kees@kernel.org>
In-Reply-To: <20240301044428.work.411-kees@kernel.org>
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
Content-Transfer-Encoding: quoted-printable

From: Kees Cook
> Sent: 01 March 2024 04:45
> To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>=20
> The __is_constexpr() macro is dark magic. Shed some light on it with
> a comment to explain how and why it works.

All the 8s don't help...

I don't think you need that much explanation.

Perhaps just saying that the type of ?: depends on the types
of the values and is independent of the condition.
The type of (0 ? (void *)p : (foo *)q) is normally 'void *'
(so that both values can be assigned to it).
But if 'p' is 'an integer constant expression with value 0'
then (void *)p is NULL and the type is 'foo *'.

The type can then be checked to find out it 'p' is constant 0.
A non-zero constant 'p' can be multiples by 0.

I need to replace the definition with (the more portable):
#define __if_constexpr(cond, if_const, if_not_const) \
=09_Generic(0 ? (void *)((long)(cond) * 0) : (char *)0, \
=09=09char *: (if_const), \
=09=09void *: (if_not_const))
which is arguably less cryptic.

#define __is_constexpr(cond) __if_constexpr(cond, 1, 0)

So that I can write:
#define is_non_neg_const(x) (__if_constexpr(x, x , -1) >=3D 0)
and avoid the compiler bleating about some comparisons
in unreachable code.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)



Return-Path: <linux-kernel+bounces-64996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F0985465D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA0D9B24C1A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2124B13AED;
	Wed, 14 Feb 2024 09:47:01 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A15313AD8
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707904020; cv=none; b=r/u0XzMU4HGXJH5OIbNLYqDckILTBG/Y2fqVlvwFdrrcuP6ILJcB9/7pSmdmyDa8oG/DOWJlcMVjMuSVXwJpU8daqnQS88eyo7aKfK93sEfMA8JeeM0sBLTbQznQ8qLqvYvr2969EKijz48rg3j5jsfVSXpm/a5EeeT4MTAoT8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707904020; c=relaxed/simple;
	bh=NDP3lJv4zleZeVDMxL6XQcti+46aisw1jmKXENGIgRY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=NuQJj159z++OrDw4m4OtisrLsK2ze6aGVkxGtVmcEqE8ZmQCwgZ9ScFBiWCxo2i/tcTx+TG4r94Erjz6d900hqmiYjjL/2FJTjPrH0Pjc84GaXGddWtEtg+BRiwAtkBSGCSdzgK1vctcfkOiIIiTUoeSFkA8jl9IplXtmtuUH5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-123-NIfzbVeEN7a3ZZr9tPCsfQ-1; Wed, 14 Feb 2024 09:46:55 +0000
X-MC-Unique: NIfzbVeEN7a3ZZr9tPCsfQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 14 Feb
 2024 09:46:33 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 14 Feb 2024 09:46:33 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Segher Boessenkool' <segher@kernel.crashing.org>, Arnd Bergmann
	<arnd@kernel.org>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Arnd
 Bergmann" <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, Nick Desaulniers
	<ndesaulniers@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Nathan Chancellor <nathan@kernel.org>, "Bill
 Wendling" <morbo@google.com>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, Justin Stitt <justinstitt@google.com>, "Jiri
 Slaby" <jirislaby@kernel.org>
Subject: RE: [PATCH] tty: hvc-iucv: fix function pointer casts
Thread-Topic: [PATCH] tty: hvc-iucv: fix function pointer casts
Thread-Index: AQHaXrGUxAtD30hgkEO/PHRuEZrHGLEJlp9g
Date: Wed, 14 Feb 2024 09:46:33 +0000
Message-ID: <57d72e2ccc8245fe99982613a11c461c@AcuMS.aculab.com>
References: <20240213101756.461701-1-arnd@kernel.org>
 <20240213191254.GA19790@gate.crashing.org>
In-Reply-To: <20240213191254.GA19790@gate.crashing.org>
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

From: Segher Boessenkool
> Sent: 13 February 2024 19:13
>=20
> On Tue, Feb 13, 2024 at 11:17:49AM +0100, Arnd Bergmann wrote:
> > clang warns about explicitly casting between incompatible function
> > pointers:
> >
> > drivers/tty/hvc/hvc_iucv.c:1100:23: error: cast from 'void (*)(const vo=
id *)' to 'void (*)(struct
> device *)' converts to incompatible function type [-Werror,-Wcast-functio=
n-type-strict]
> >  1100 |         priv->dev->release =3D (void (*)(struct device *)) kfre=
e;
> >       |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> Such a cast of course is explicitly allowed by 6.3.2.3/8, only calling a
> function using a non-compatible type is UB.  This warning message is
> quite misleading.  Doubly so because of the -Werror, as always.

But it will get called using the wrong type.
And (is it) fine-ibt will reject the incorrect call.

Has clang/gcc added an attribute to 'seed' the ibt hash yet?
So that functions that are void (*)(void) can be separated?

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)



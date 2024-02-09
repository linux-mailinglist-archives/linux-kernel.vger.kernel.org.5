Return-Path: <linux-kernel+bounces-59722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8332784FAED
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 247A01F28A9F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1537E77F;
	Fri,  9 Feb 2024 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b="EM0VMRLq"
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4B37BAF7;
	Fri,  9 Feb 2024 17:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707499225; cv=none; b=fnNaw94/FGEuVmqspdl08W2GG0u0w0VL7ODzZZJmpUFEyO7RjX6E7JiURL7PH8hA/WjUMyHnMI9Bqb++8jkuT3OwRMP1OoPVShqXsZn0WRhkR+ELpC9D790Dbyop+aZiadnB13RIty0WJU7iDBQrC8bz8CY3RACZp48jeFaIhyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707499225; c=relaxed/simple;
	bh=UsNSt6e4uXXzAf272aBm0wKAn8cU99EE380sIjFDd/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bi52yXljtJVMKCnLlZvQa+Q36KbOf0aWKsJlU5bENciZWr+A8ZSJswi4WvVpsgixICaFa/bQEvm+Tij7visCoSVYfMRiF8yBWCJ89YYHj8PkNqeS6KudU47167RqCwGVnfZhT64nHXtPhRfRYm4pX5tMPfi5fg3CgZ0i0BryJ6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b=EM0VMRLq; arc=none smtp.client-ip=212.227.126.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=valentinobst.de;
	s=s1-ionos; t=1707499187; x=1708103987; i=kernel@valentinobst.de;
	bh=UsNSt6e4uXXzAf272aBm0wKAn8cU99EE380sIjFDd/E=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=EM0VMRLqOGOXoL8Qzx04icyqNXHE9PYGwMjCbP/uiZ3pBDdVhnJMlDzFcIwfHvNM
	 XF3/h8l+dCkJKN+7nAV3NDSKQau+r1Ww/TiGKXhpSQYcJu3arSmHKrVIok0g0ZTUI
	 nlw1l+DNLdPEHVK0yRvbB2DZUdVyqqSNa9UHdzopbL51vzm9zK0Zn+m31X+rRUQUT
	 MG+XGT51Uscx5qsQi3XDBfuocO9fuW4c6T55ONQGPxFp0GUUGcx2PE7SZ+730cIPQ
	 Yp/ZOxCRml249a4t8h7SqtHI2nMosIohMYim+/AIfDnTzRyQI29MnLe/PljpZHhFt
	 qbYB7X82AGqLUXErYA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost.localdomain ([217.149.163.107]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M4bd0-1rWpqW4Azu-001kh0; Fri, 09 Feb 2024 18:19:47 +0100
From: Valentin Obst <kernel@valentinobst.de>
To: aliceryhl@google.com
Cc: a.hindborg@samsung.com,
	akpm@linux-foundation.org,
	alex.gaynor@gmail.com,
	arnd@arndb.de,
	arve@android.com,
	benno.lossin@proton.me,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	brauner@kernel.org,
	cmllamas@google.com,
	gary@garyguo.net,
	gregkh@linuxfoundation.org,
	joel@joelfernandes.org,
	keescook@chromium.org,
	kernel@valentinobst.de,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	maco@android.com,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	surenb@google.com,
	tkjos@android.com,
	viro@zeniv.linux.org.uk,
	wedsonaf@gmail.com
Subject: Re: [PATCH v2 3/4] rust: uaccess: add typed accessors for userspace pointers
Date: Fri,  9 Feb 2024 18:18:41 +0100
Message-ID: <20240209171841.3494-1-kernel@valentinobst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAH5fLgg3C79DHz0FJ1LOhvetv4THHNAnu6XPx0vycFCb_txkfg@mail.gmail.com>
References: <CAH5fLgg3C79DHz0FJ1LOhvetv4THHNAnu6XPx0vycFCb_txkfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:E/ajS4dEMh4eVMlP+RWn/KBa4oRK8yFyBO8ueV4i6LAUXCIv+RD
 sZSTvB44KcgMEZqb3bC6CqC5QvYjmCj237ZUb3jDdizWJC6lfT4V3xiGmy7gWzXb4mOThjK
 0bACvJzhuqbFJJTJMT16Z9DkUXQi8pQSESrQdKwr8S4J9YWFYLxcurMlooUyZ8C7OWhnuLP
 F5TxqYREPezYur29PXJng==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QCECXHsTf48=;+jFxZJXMjw0eAGA9wRyu5fsewLe
 EApEVcP3wDMOmD5bC6vVvcWnQ4G8rQKoHSInVKTsQRa6EPbeRqqAGRKyi74GC1MV50+2dNby6
 uDUQdKK0IkZB7owd5vQybtWZ80NLx1rFRH0x+JPCClic+2XRwPmealUGOTbt88jXQHHcaa7m1
 2VAjO7bh0Ipz1luX3eVRr1joEIEsC/B0wqZjteIuO4/EUDmYmXVi4eLTPhZS7/wmSqNhI2fiQ
 PJieTILebbic/r7w1XwFXJh+mbChBQH0oAZ7lVHTsL5GLECyiqJAc0gOGYDJunN3di91zPQfE
 CIEpDkyipJcUMoHNeoxQWww4aQnBeWtZuIl0T19pIv43/oKah3p40772Eru+V98PuTxzptGuB
 PZBWsUo+HC6qkZlEJ62+Lz/REG4DDYOt1UDIQN1o3fhLjp0Aqg2JdkAbhJQIsIdWDIBjICURC
 CTtRcB4PVi+6OTJn53AdIdcfl99iNlemyPLG15tZAWchAcU9hIISP0BuFHHRmdSHzCUEThVYp
 hVRkSNuOFolNQI5jhfrAPFUMp0hRdAhDpNMD9YPrnV1iODkHsZFr3cQXhSXLEyumcePPM3xrI
 C6f74DJCiCM0bYFuB3i2n2D3wkTAYAq55BThRGsunDPx3qpWGot2FG4fF6DrrlkUmFAAlp0sg
 Hu2SyvenPVIUwLBpae6KUyWpVMUyxxALaHcUgmJ8dJVfVD71JpHZJSpbWEkTg8P85Pfb/bTl6
 Pw321gRmZ/mrbq8gtPh4H+P8ZHG3EW2FTvnUCALbo+zj6NV4RAQQ3I=

> > > +/// If a struct implements this trait, then it is okay to copy it byte-for-byte
> > > +/// to userspace. This means that it should not have any padding, as padding
> > > +/// bytes are uninitialized. Reading uninitialized memory is not just undefined
> > > +/// behavior, it may even lead to leaking sensitive information on the stack to
> > > +/// userspace.
> >
> > This feels a bit too restrictive to me. Isn't it okay to copy types with
> > padding if it is ensured that the padding is always initialized?
> >
> > I recall that in C one occasionally does a `memset` for structs that are
> > copied to user space. I imagine that one could have a Rust
> > abstraction/macro that makes it easy to define custom types that can
> > always guarantee that all padding bytes are initialized. Such types
> > would then qualify for being copied to user space if all field do so as
> > well.
> >
> > This could be a significant quality-of-life improvement for drivers
> > as it can be tedious to define struct without padding.
>
> I don't think we should go that route. For example:
>
> let struct_1 = ..;
> memset(&mut struct_1, 0);
> let struct_2 = struct_1;
>
> Even though struct_1 has its padding zeroed here, that is not the case
> for struct_2. When Rust performs a typed copy/move, the padding is not
> copied.
>
> Anyway, there is a work-around. Define your struct with MaybeUninit:
>
> // INVARIANT: All bytes always initialized.
> struct MyWrapper(MaybeUninit<bindings::c_struct>);
>
> impl Default for MyWrapper {
>     fn default() -> Self {
>         MyWrapper(MaybeUninit::zeroed())
>     }
> }
>
> Unlike the bare struct, things wrapped in MaybeUninit always have
> their padding preserved. Then, you can implement the trait for this
> wrapper, since its padding is always initialized even if that is not
> true for the wrapped struct.

Yea, I see the issue posed by moving values around. What I had in mind
was some library code that makes achieving the above behavior more
ergonomic and semantically clearer (in the sense that without the
surrounding comments it might not be immediately clear to someone
reading the code why you are doing things that way). My reply was
mainly about gauging interest into such a feature.

However, this really is independent from this patch and could always be
added later. I agree with mentioning padding in the comment and see
nothing blocking here.

	- Best Valentin

>
> Alice


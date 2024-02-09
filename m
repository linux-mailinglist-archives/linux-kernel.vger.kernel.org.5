Return-Path: <linux-kernel+bounces-59660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5AD84F9FB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A5D028FD8B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547818287F;
	Fri,  9 Feb 2024 16:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b="xNyIik63"
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D8A1E486;
	Fri,  9 Feb 2024 16:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707497147; cv=none; b=aJZCdv4paQdRN+BZ2lQU52OZgn0aWwPZilu9mER2dTxLs1MpKUhoG3ErHpX88ORt3yiPu/rc36zknTqYgqMS4UobB1OcOQN1OHR+1fm7NmBn/2YZstng5I12Gjs4VDkEpS25Iog/3/PSm/4t2oF6lc8J2In2uCDTxfziadZi3Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707497147; c=relaxed/simple;
	bh=y4JWJqxU4/uY3ZOZ2BIggNbVpYDjyAAMh6kaHZrpIBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QisMAAmDVUz6JcDnCH3i3bvVfGJo13QocRjFWFUMGyZt+y+ULybJBWUbpS4N4HkVwz+k9aL43SFGO4dRJgMrch8aUbjJ1RwAs6I5vqcUQGnpqQxJy5xalWETCUcLpC4GwZA7zBLVPdER2mR8xgXS+V0xVFn6t2rFmhsh4suAkwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b=xNyIik63; arc=none smtp.client-ip=212.227.126.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=valentinobst.de;
	s=s1-ionos; t=1707497119; x=1708101919; i=kernel@valentinobst.de;
	bh=y4JWJqxU4/uY3ZOZ2BIggNbVpYDjyAAMh6kaHZrpIBc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=xNyIik63HOtQy+fRA3kGk/SRhg9CKN0fMQjKrZKHKOFRM7PPNVUm9DnQ+QCb6XtQ
	 7kHSW4wCu52uQeYmMXZvxM+UOqCZBRA5HbLYSAmizVyGguNYWOkeSM0BDuD7H8+fj
	 xJmV4kBRH8nvKNWxz7WHQdTBf7OcU2EGSlhlWxxXmN0zAHNiPd1GPYet9XQEj/Igd
	 PEk78zXVKmi4XvVH4sXpPTUTj1YmoNDdRT6eVq7NAbqw7kO3ylm+vFBgJZe6za7fU
	 +pWwjI4DCdGsqQCTAPs41MUosEe4PAG6nMd5bdw5tvyhRifw7aoVuFKJ6+r0QG9Jl
	 b7TAnFmaX1Qiu33z0A==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost.localdomain ([217.149.163.107]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MY5wD-1rVPcI2SGz-00YSSQ; Fri, 09 Feb 2024 17:45:19 +0100
From: Valentin Obst <kernel@valentinobst.de>
To: arnd@arndb.de
Cc: a.hindborg@samsung.com,
	akpm@linux-foundation.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
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
Subject: Re: [PATCH v2 2/4] uaccess: always export _copy_[from|to]_user with CONFIG_RUST
Date: Fri,  9 Feb 2024 17:45:05 +0100
Message-ID: <20240209164505.2108-1-kernel@valentinobst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6eeba3ce-d66c-45e2-8c34-ad0109ec2ef0@app.fastmail.com>
References: <6eeba3ce-d66c-45e2-8c34-ad0109ec2ef0@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:0RIt5+EdzMuvmXdS6iemj0tqNfZuXKA0Tm/b3KsjI2/ioEH2V8L
 g+ahhbuhx1UKDgXO7j0yUxrOr+L1Hm2C/Y/h2Q/irzh5s24NJZw8eCk2Hmuf+K+LbsR1ILZ
 H93KVHeGX5NmRR0Zml/LTVT/JmU2S1qZQd2Ygzn4/gcGaNQByFHaQPlWAcO7S8innBYNYtz
 cF0vUMIgOFFdzkK6/fVBA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WYS6P+aomTw=;XbzcNBCwdRbiLAarLUO+W6j+zRv
 YmUPnF8KuqGLTbCtueKO5+Eo46bePsEZ03rFMT638bJCtRHA9A4Krkn1OTjp3kwSr2jECqCFF
 w+ISolpyNiZdEk271ZbqKHPHDZUts02OBAshvuCzKAiX8+Tz1dxVWFfleqbLAV2WbGgiX0oY9
 niJ+03TbpNIe8y3CZ9r9RtIERZU+uoBiclYpMidzWMALBwCHIvPd6GFvFaO+x/TtJ/d1kyj5b
 h9OlliECsCYXadWNfvp+58EBRbELyL1I7xu/kZK1L70kJFbCksJ2HCRaTvcK/KmE+YpLErwce
 ZP9Erp2Dx1RYwm2TUJvQ5PjZMss4Ut7Ow9jXz4j10cPq/tLBok3nQdfHDEmT7gHI6viqsjcdd
 HEYZJxRisDW/F9CuBRFZdGhxNdyZHJO98UySZSlTJaovLr8FowyZ2s7hD1QE3FljjAZqs+dD5
 FbT9cmERg5UBVZBUhv6GgFhM29l2MNNWPEZwFD1fMROthjQhX6mYKWH374og19eci12ZIA9md
 mKh19gJmToG64bOYCToNhDp38mQuzEjBjd9qaXsn/GvY53O1Adam2zucdHg0uElljPXysj5Pf
 cGIuBkFw2MM3QLkG61eFT/vfB2OQoK0my1R6Dkkb2mqmzfwsnkpCpcO5vXEfuD+Xt9/S6+FjD
 c0tW3gRSltQtP6QBDImfHtql5ZJljlP8ImeLF/gnWj5wiRRdaJ0kaiiP9knYJSMolYsz8i9if
 NiMd+Aq4/na/Wi9+iuya/GspSunD4X9qjhlQUVhnLNYU4kkJ0v+mbQ=

>>> -#else
>>>  extern __must_check unsigned long
>>>  _copy_from_user(void *, const void __user *, unsigned long);
>>> -#endif
>>
>> This function is now unconditionally declared, but only defined if
>> `!defined(INLINE_COPY_FROM_USER) || defined(CONFIG_RUST)`, i.e., in the
>> common case where it is inlined and Rust is disabled this can lead to
>> link-time problems if someone decides to use it.
>
> Yes, that is intentional.
>
> If someone tries to use it when the declaration is not there,
> they just get a compile-time error, which is not all that
> different from a link-time error in practice.
>
> It's unlikely to make a difference here, but enclosing
> declarations in an #ifdef is annoying when you want to
> reference it from somewhere that is parsed by the compiler
> but not called without the respective options.
>
> The if(IS_ENABLED()) and PTR_IF() constructs in particular
> only work when the unused functions are still declared.

I see, thanks for the explanation.

    - Best Valentin

>
>        Arnd


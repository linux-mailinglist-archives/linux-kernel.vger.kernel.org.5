Return-Path: <linux-kernel+bounces-149580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A65C68A930C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 598DB1F2122A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FE374431;
	Thu, 18 Apr 2024 06:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="JqJwQVAL"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F0771727
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 06:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713421606; cv=none; b=LyqKo0c2ZUbo1g5I8RJ3XxU0qXWeoaOl6hwmcOu1zoykH+IS43P4bzmTrLz6Tb/CY71eiO+4QaY3K3Mnd0RDBhxQWx96ENVU5GYLG2gZAK6zEwv/C/MTG5VH1nSMg4ZirsZpFAsFntMZD9/Vs+aUonHd0arcUHqGEsPTCitG2QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713421606; c=relaxed/simple;
	bh=pLZXFcRFsA6pmkWp5sQ8IB/qtz8jCZmegUqL5nF557A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kJPqx6tAZXdM0T7cg3XGJCzhgi/J26r12Mr/fxwbAST3zPwXUHwywZHLm+pubhdDW3ZImVZPZOwKIqpQd370zdeJny3Usub4D6ZYbKtXijyAvOciuxX0jeSo1mJFnVXRsNu3ZWGe/w15JQ2hqTbyK/CdSkIBttof9wTEfkYenVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=JqJwQVAL; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1713421602;
	bh=VM1ymWJhdLE7PRVRkuPaTY1phwPDbzmFe8XcgWwS6dU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JqJwQVALTUJ0ydw1mHTTPSfihUx/qu9thHoYIV1R4WKlzvOWHn3Wsm6cU99tCgS7u
	 +t2ToXrZOldNQz3HgQF9MTCbaF2Tb6Yeol7Db0ng5i4CJz/oqMpYm3KBry4nBCcf+j
	 7QpB+fhA2N56J4jqYGht5ofqSxFI1GeY/5Pgw1x2lHOqqfZNQy/ASlMDjNA4UbHXu0
	 GtLre/te4326SSiVbtF1xUORjssL0I6C0DCkGild3E43pwbMHh7Lq82K8ILcI9FRqR
	 1NiZiKgnDNcGAE49ubVdQvoK1fMHwTqi5FqL7jpdTgPDZHOSCzSeqYxiMuSZRE4E8a
	 7qVZyJCQiDy1Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VKnqN6d03z4wx6;
	Thu, 18 Apr 2024 16:26:40 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Naresh Kamboju
 <naresh.kamboju@linaro.org>, linux-kernel@vger.kernel.org, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, "Aneesh Kumar K . V"
 <aneesh.kumar@kernel.org>, Anders Roxell <anders.roxell@linaro.org>, Kees
 Cook <keescook@chromium.org>, Niklas Schnelle <schnelle@linux.ibm.com>,
 clang-built-linux <llvm@lists.linux.dev>, Nick Desaulniers
 <ndesaulniers@google.com>, Nathan Chancellor <nathan@kernel.org>, Jeff Xu
 <jeffxu@chromium.org>, "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>, Dan
 Carpenter <dan.carpenter@linaro.org>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Baoquan He
 <bhe@redhat.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>
Subject: Re: [PATCH] powerpc: drop port I/O helpers for CONFIG_HAS_IOPORT=n
In-Reply-To: <20240416153331.1617772-1-arnd@kernel.org>
References: <20240416153331.1617772-1-arnd@kernel.org>
Date: Thu, 18 Apr 2024 16:26:40 +1000
Message-ID: <878r1bb2zj.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Arnd Bergmann <arnd@kernel.org> writes:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Calling inb()/outb() on powerpc when CONFIG_PCI is disabled causes
> a NULL pointer dereference, which is bad for a number of reasons.
>
> After my patch to turn on -Werror in linux-next, this caused a
> compiler-time warning with clang:
>
> In file included from arch/powerpc/include/asm/io.h:672:
> arch/powerpc/include/asm/io-defs.h:43:1: error: performing pointer
> arithmetic on a null pointer has undefined behavior
> [-Werror,-Wnull-pointer-arithmetic]
>    43 | DEF_PCI_AC_NORET(insb, (unsigned long p, void *b, unsigned long c),
>       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    44 |                  (p, b, c), pio, p)
>       |                  ~~~~~~~~~~~~~~~~~~
>
> In this configuration, CONFIG_HAS_IOPORT is already disabled, and all
> drivers that use inb()/outb() should now depend on that (some patches are
> still in the process of getting marged).
>
> Hide all references to inb()/outb() in the powerpc code and the definitions
> when HAS_IOPORT is disabled to remove the possible NULL pointer access.
> The same should happin in asm-generic in the near future, but for now
> the empty inb() macros are still defined to ensure the generic version
> does not get pulled in.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> --

This needs a small fixup:

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 86c212fcbc0c..60c80d0baf40 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -692,6 +692,7 @@ static inline void name at                                  \
 #define writesw writesw
 #define writesl writesl

+#ifdef CONFIG_HAS_IOPORT
 #define inb inb
 #define inw inw
 #define inl inl
@@ -704,6 +705,8 @@ static inline void name at                                  \
 #define outsb outsb
 #define outsw outsw
 #define outsl outsl
+#endif // CONFIG_HAS_IOPORT
+
 #ifdef __powerpc64__
 #define readq  readq
 #define writeq writeq


I'm running it through some randconfig builds now.

cheers


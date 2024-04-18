Return-Path: <linux-kernel+bounces-149585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 101578A931F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF1C1281E92
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA0F21373;
	Thu, 18 Apr 2024 06:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="UpYxncQ7"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1772923DE
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 06:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713421987; cv=none; b=C8zjiSCYMsbiQ48zHqHCl+dT4JK3YKwbFlIMP/ZcBEsbKWw0V9mj2UiqlzhhpbSIEUqoZQ3jOFqi5z0+ZKFJmYTGjUBWHFt9Lw74g07kvh4baGY7Zz2rLPkgOIActDcRthG6B85xyOWX3rr6HlmK2209JHJiI8QLX4HvDufF4Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713421987; c=relaxed/simple;
	bh=pQMBecgqfKdbPKjdn4yS3sDc77mBnocF1E8KpVGeTVo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OvSdwn2WrnFXqVW1m3TWiBEfY0MoArUuGnsTt0OvHN0JpGT8/mLl7TLQYks/Z3uvkvg60JZOS9G6H+1EtdChWh7VCF6P6GhWwLIX3EbxwE0vJS6wTDWQUzb86u6dSxF0vYdy5zodvx7xL3a7/sEnifmYbja5xh/OoBXsiIReLBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=UpYxncQ7; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1713421984;
	bh=Os3n75joztuZwb7Uo98ZK8zUHbtnDL2bSCbwHpOcZE4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UpYxncQ7XHP+jss1hZdkT5vMaxWi3UsZZtID/xtfljbj+dZWc2jBahOY2aXHfD8y/
	 RVsJRnN7oRlQ51KLRItu4vVMzvHZuDSBlkXS2vaa0kLCo0FNzJDORHCGtohKi/qiq2
	 O6Y3sB4pjJIKSL+WOdB+MPmuObWgwilq8rQFQIwrB1sqNBG7wj0xvmApVHx7J6xxz2
	 MfSgJr2XjXJrJ9ZSMOm6Ti10tkZS3ejgm15X9sf+rIjEWWXpUVJ0XmA/4yCUKnhR9/
	 6oxerVLHbTcaMiW2Qnfget/zDJ5DS+tRK6pFBaW6lVpH9PuNyfFHDPRPhH6lHPR6ra
	 6I3EG15SaNS2g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VKnym2YSCz4wcR;
	Thu, 18 Apr 2024 16:33:04 +1000 (AEST)
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
In-Reply-To: <878r1bb2zj.fsf@mail.lhotse>
References: <20240416153331.1617772-1-arnd@kernel.org>
 <878r1bb2zj.fsf@mail.lhotse>
Date: Thu, 18 Apr 2024 16:33:04 +1000
Message-ID: <875xwfb2ov.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael Ellerman <mpe@ellerman.id.au> writes:
> Arnd Bergmann <arnd@kernel.org> writes:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> Calling inb()/outb() on powerpc when CONFIG_PCI is disabled causes
>> a NULL pointer dereference, which is bad for a number of reasons.
>>
>> After my patch to turn on -Werror in linux-next, this caused a
>> compiler-time warning with clang:
>>
>> In file included from arch/powerpc/include/asm/io.h:672:
>> arch/powerpc/include/asm/io-defs.h:43:1: error: performing pointer
>> arithmetic on a null pointer has undefined behavior
>> [-Werror,-Wnull-pointer-arithmetic]
>>    43 | DEF_PCI_AC_NORET(insb, (unsigned long p, void *b, unsigned long c),
>>       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    44 |                  (p, b, c), pio, p)
>>       |                  ~~~~~~~~~~~~~~~~~~
>>
>> In this configuration, CONFIG_HAS_IOPORT is already disabled, and all
>> drivers that use inb()/outb() should now depend on that (some patches are
>> still in the process of getting marged).
>>
>> Hide all references to inb()/outb() in the powerpc code and the definitions
>> when HAS_IOPORT is disabled to remove the possible NULL pointer access.
>> The same should happin in asm-generic in the near future, but for now
>> the empty inb() macros are still defined to ensure the generic version
>> does not get pulled in.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
>> --
>
> This needs a small fixup:

Well, only because my tree doesn't have f0a816fb12da ("/dev/port: don't compile file operations without CONFIG_DEVPORT").

cheers


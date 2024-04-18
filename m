Return-Path: <linux-kernel+bounces-150123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 904638A9AC5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C120E1C21705
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF3315FA74;
	Thu, 18 Apr 2024 13:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="q9TFzCh7"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2507215CD50
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713445302; cv=none; b=uuE83vdJOrEb5eAtQIYWIPxzQ+SjOB2ulzvT6JdJ0NwfJTnWaDOkyThkQ95RuF48NlE2CRy9pfQoDT+lV2NHZpwU/WhQq+W8S5Dphpxc9HIzRm6qJKXifLtFxFiy3G3lz8WdtV/dbzvJGC29b8EjhnywAcwn76WVyDjuP9F5jtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713445302; c=relaxed/simple;
	bh=/XJcPlw0F03P3amsg0KmHILuo/lC6Cw5M2DfUOpYyuc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AwKcmnXNebKNtfA9d2O19NiZgP1paCFbpNdRjnlSjxHTj1BpGQTFhnDHOl0JHkxAt480EWEgXca3vxKpFVfWK2ZFZ97hoEqxBVabUVx1XvM0XHZLmi2hJqprzpcDZsqimcCYZO88uznJghjQuLc3GdssyyrizxI3APh6T8nDHYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=q9TFzCh7; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1713445289;
	bh=vNeZ/qdX3LOH0LHZJhAOcqMpEwfgHMqhf2DU3H1Xszg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=q9TFzCh7EhJg+m9fj6qudX6Ks+Uct3uWBknTCV37uU8cbakd81QmCpmVRG0NOIxQ5
	 uNQKi+KMBjdkP9ELAPneTQiXG4RWeLhPSORHg+e8+iojKQsMo6Vww7EZd4Vo8nYxXj
	 i9C+ou7rNcmrbkiJh9KKLdHzBGmSWTBXLplv230qwENBOzJZa0EmJhDvcx7MlY6f+x
	 Kxij9OwVQI817aMiTT0xC/Q13B2je9ictqe0EMnSezFUNR9C4h+0VWvJD9vykrSyNe
	 Xx2VRrYHX09AAOcTymVN0OEteduzRVIKXU3HOEjff+X4D+7mpxgl26SJk8w/e/NwSp
	 b5yKqkqbp1D7w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VKyZw5zyrz4wyx;
	Thu, 18 Apr 2024 23:01:28 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, "Aneesh Kumar K . V"
 <aneesh.kumar@kernel.org>, Anders Roxell <anders.roxell@linaro.org>, Kees
 Cook <keescook@chromium.org>, Niklas Schnelle <schnelle@linux.ibm.com>,
 clang-built-linux <llvm@lists.linux.dev>, Nick Desaulniers
 <ndesaulniers@google.com>, Nathan Chancellor <nathan@kernel.org>, Jeff Xu
 <jeffxu@chromium.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Dan
 Carpenter <dan.carpenter@linaro.org>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Baoquan He
 <bhe@redhat.com>, Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH] powerpc: drop port I/O helpers for CONFIG_HAS_IOPORT=n
In-Reply-To: <59473eb6-1707-4bbf-85a3-ba4835f3ee7f@app.fastmail.com>
References: <20240416153331.1617772-1-arnd@kernel.org>
 <878r1bb2zj.fsf@mail.lhotse>
 <59473eb6-1707-4bbf-85a3-ba4835f3ee7f@app.fastmail.com>
Date: Thu, 18 Apr 2024 23:01:25 +1000
Message-ID: <8734ribza2.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Arnd Bergmann" <arnd@arndb.de> writes:
> On Thu, Apr 18, 2024, at 08:26, Michael Ellerman wrote:
>> Arnd Bergmann <arnd@kernel.org> writes:
>
>> @@ -692,6 +692,7 @@ static inline void name at                          
>>         \
>>  #define writesw writesw
>>  #define writesl writesl
>>
>> +#ifdef CONFIG_HAS_IOPORT
>>  #define inb inb
>>  #define inw inw
>>  #define inl inl
>> @@ -704,6 +705,8 @@ static inline void name at                          
>>         \
>>  #define outsb outsb
>>  #define outsw outsw
>>  #define outsl outsl
>> +#endif // CONFIG_HAS_IOPORT
>> +
>>  #ifdef __powerpc64__
>>  #define readq  readq
>>  #define writeq writeq
>
> I had included this at first, but then I still ran into
> the same warnings because it ends up pulling in the
> generic outsb() etc from include/asm-generic/io.h
> that relies on setting a non-NULL PCI_IOBASE.

Yes you're right. The above fixes the gcc build, but not clang.

So I think I'll just cherry pick f0a816fb12da ("/dev/port: don't compile
file operations without CONFIG_DEVPORT") into my next and then apply
this. But will see if there's any other build failures over night.

cheers


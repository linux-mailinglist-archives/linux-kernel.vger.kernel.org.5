Return-Path: <linux-kernel+bounces-72356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 588DA85B262
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADA98B2141C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0453556B96;
	Tue, 20 Feb 2024 05:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="UIdQfx83"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A047945942
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 05:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708407844; cv=none; b=lhe4jpcPxqLhlc+gzoJuIG4IbeyfoGNz0Bw5RkEf1V6oS2hLdsvAMeqnbIM/6BDoP3UPG0B0OnaJ3q1ftY5scyj4+j1nO+k8+D90fkdNxWox+XskT48TkBdnbUSPSNdrcjAo16mtTw9JNSdSlC2Asx3wzKPz9JnqQh06RqN1ZMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708407844; c=relaxed/simple;
	bh=/BhhWVIVUP0rphj3gdtnNKQJSGZsyxwwpk7tQ5WQDTM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=irpiI5KM1tEigeUmzQA23NISVWJjnRb0BN1xQg3CW76QeeIs03DGLrVdU58mlbU1xFMrYiUy3CzGr9y4ANw4oEL2T2vxpUSuUdoCzepnFbcZDdGgCtCOL2d8E/F0SdTOX8k+f6a6zt30UVNrwgp6oGbfKQ5SGslACkATPa2fJIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=UIdQfx83; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1708407839;
	bh=rfmp0MQ0Ux6RuAaBFyTJq/JUhVdDupJU+ukLbInK8Cg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UIdQfx83ta4KwNnjdsUHHnolD9mS7hxnJ3jK8vioxN7IGtMKNm4GQ0CBzFmg54fm9
	 aoAfzUvq+Kyj9hkDAnzsZoXAlXy+5uL163T6JOBMh5tt92286PRVgKG20wVnxjpr0J
	 8TCUqpissJgjktgxVkwGnPGuCfH7FebtRelbqb4V5IrWXjZYv9my2piVMXn3+72O87
	 cVmzpx87TjuwAyorVlZB6q9XpiU/GQQVxmMj38n313L00uL8i32i9x0RO00rK9ezNQ
	 fZ30//lAYPYdfvdD3tMDvYgfPGZlIXAMB95Hrww5mkLaVQ1O6YRDPmMRQf64AWXjoK
	 rb5tPARdVQzFQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tf7cv0lWkz4wby;
	Tue, 20 Feb 2024 16:43:59 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Masahiro Yamada <masahiroy@kernel.org>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, "Naveen N . Rao"
 <naveen.n.rao@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Daniel Axtens
 <dja@axtens.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: remove unused *_syscall_64.o variables in
 Makefile
In-Reply-To: <CAK7LNARFNoAUUiGMP95pTi_rSxSi5Z0HJo2kBC472f0koMr2mA@mail.gmail.com>
References: <20240216135517.2002749-1-masahiroy@kernel.org>
 <CAK7LNARFNoAUUiGMP95pTi_rSxSi5Z0HJo2kBC472f0koMr2mA@mail.gmail.com>
Date: Tue, 20 Feb 2024 16:43:56 +1100
Message-ID: <874je31yhv.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Masahiro Yamada <masahiroy@kernel.org> writes:
> +To: Daniel Axtens

Unfortunately dja doesn't work on the kernel anymore.

> Maybe, we should check if the issue fixed by
> 2f26ed1764b42a8c40d9c48441c73a70d805decf
> came back.

That crash is specific to Power8, which probably no one is running
syzkaller on anymore.

If I enable KCOV and boot with 1T segments disabled (to make it easier
to trigger the bug) it crashes similarly to the report in that commit.

> On Fri, Feb 16, 2024 at 10:55=E2=80=AFPM Masahiro Yamada <masahiroy@kerne=
l.org> wrote:
..
>> To restore the original behavior, we could replace them with:
>>
>>   GCOV_PROFILE_interrupt.o :=3D n
>>   KCOV_INSTRUMENT_interrupt.o :=3D n
>>   UBSAN_SANITIZE_interrupt.o :=3D n

But just putting those back isn't actually enough to fix it, the code
has changed and there are other places that need KCOV disabled on P8.

So I'm not sure how to handle this one. I guess I might just take it and
then make a todo to fix the KCOV problems later.

cheers


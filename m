Return-Path: <linux-kernel+bounces-79905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8EA862882
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 00:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65326282475
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 23:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B1E4E1DC;
	Sat, 24 Feb 2024 23:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="QJl9jSue"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA544E1BD
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 23:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708818792; cv=none; b=an4+d+0pbLnSWMKsgz9mqSz48UgSR5R0Ylegi134ymg7n4EpFqqH11gv25sd2hmrwETYhaVm5mI+sZgPhkYbdFEGNRJMobMRmSCe9uHXaU0mDB8I9vvx7v6HHz9Hs1u9remDrS6LcndGz2GZzNZYtpDWA3umLQu4fN6dEK+G7XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708818792; c=relaxed/simple;
	bh=1nyHqj0QOBXadNL1hyU/ColE1K5lSLjIwFZkoy6rtag=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bOvFjzPcWhPDeYNWtrD/1rCct/+hw/+5+dqz7jK8X/tcuVyZ1HiB78N7X8I0QYuqDL0uI2tjwwjBlyGiPbPuqSHjORXoSAwrhPxp6FqoLne/MtvKM9BQLDbmzNnXdR+kPyQ3HfhyDm8a9D7AqRG06a+m1vN4p+uTpseAJXmt81M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=QJl9jSue; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1708818781;
	bh=1nyHqj0QOBXadNL1hyU/ColE1K5lSLjIwFZkoy6rtag=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=QJl9jSuexI8C7+aTFRi4Uw3JVm/OzPKx0XyDV4jzYQ5bpBMXjczt1ClZljxOfF4Ik
	 srsogx7TfrD/T0zSjTW1cbU5tAitE6G+eqhAuNYBxrpbqSMfigcsr5KqSsBJng9W8J
	 0+4Wq2O6c/6wyMdoJ6futCIzZC7xIg9YLGsEZegDUZAFH5I6zApLSSEp0D0L4ETpEr
	 l2YNvJgsngE7EmCM7kLJT5IRXDbhZLBEuwLzUhbH4R6362It5/InBWPKnnXudXmOdP
	 5bgDUiVXJ4ilpMy5qr2hYBR8mrzDhk6lLExiZYOh2x3JcX5hG2gsOFtuuWqN2nm4l7
	 8UnXfG7bI+vNQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tj3bc4br7z4wc6;
	Sun, 25 Feb 2024 10:52:58 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Nicholas
 Piggin <npiggin@gmail.com>, "jbglaw@lug-owl.de" <jbglaw@lug-owl.de>
Subject: Re: [PATCH v1 4/5] powerpc: Remove cpu-as-y completely
In-Reply-To: <94d19157-a343-425f-906f-546b1f4def6f@csgroup.eu>
References: <38a8d765ed9149bc6b5484a7142e3bc59ffa3b1a.1671475543.git.christophe.leroy@csgroup.eu>
 <9e43ad8b173c2fdb540e2555a8ba3e375419f3cf.1671475543.git.christophe.leroy@csgroup.eu>
 <873570zxio.fsf@mpe.ellerman.id.au>
 <94d19157-a343-425f-906f-546b1f4def6f@csgroup.eu>
Date: Sun, 25 Feb 2024 10:52:58 +1100
Message-ID: <87msrpa085.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 20/02/2023 =C3=A0 07:00, Michael Ellerman a =C3=A9crit=C2=A0:
>> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>>> cpu-as-y is there to force assembler building options.
>>> But there is no need for that. Gcc is passed the necessary
>>> options and it automatically pass the appropriate option to
>>> GAS.
>>>
>>> GCC is given -maltivec when relevant, so no need
>>> for -Wa,-maltivec in addition
>>>
>>> And -Wa,-many is wrong as it will hide innapropriate
>>> instructions. Better to detect them and handle them on a
>>> case by case basis.
>>> -Wa,-many was added by commit 960e30029863 ("powerpc/Makefile:
>>> Fix PPC_BOOK3S_64 ASFLAGS") in order to fix an issue with
>>> clang and the passed -Wa,-mpower4 option. But we have now
>>> removed it expecting the compiler to automatically pass the
>>> proper options and instructions based on -mcpu=3Dpower4
>>=20
>> I wanted to apply this one, but it caused a lot of breakage for big
>> endian Book3S-64 builds - where we build for power4 but have lots of
>> code that uses >=3D power5 instructions.
>>=20
>> I'll try and get those all fixed and pick this up for the next merge
>> window.
>
> ping ?

Brutal :)

There's still a few issues, I have patches for most of them I think.
Will post this week.

cheers


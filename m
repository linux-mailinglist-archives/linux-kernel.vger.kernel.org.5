Return-Path: <linux-kernel+bounces-52520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58851849937
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBC05B21ABB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FC41758C;
	Mon,  5 Feb 2024 11:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="qFtnvIwy"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A53D18EAD
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 11:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707133825; cv=none; b=hCmb/ZWfNm5ioXc65J22NxssBeSKNdqJ6XopNyxkx6JVgC54BK3oZuRmctCuk/sCjXO4m+D4O8eHohxPr16GeMNZ7T/7aVN2BvgrLGzDhoEyUWY7Wp7zpI9xV3NqW8EkBXE7iGfVLINsc2POZAZe11yO1pEMryCaCqMNTmw9AOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707133825; c=relaxed/simple;
	bh=6XWtce4S7GRyjcwlA6+lanS5MbI/XWrjrzDEdYwxALM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MT0pMQS5wywRiG3jHyHt8maWZKzCFNFDpBFpStYZhd7MCfd3/AEr5VQJdiAGeZKU640FxhTHQApZxRwbgYb6U+0bWmNhgFNGreOF2tFjCtrZkDnTHyeN/y+EZBZ3oRMIo4+gik4EgxCQm5yhHH55E8yrVaH/eRT7+vM3n7GLodE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=qFtnvIwy; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1707133820;
	bh=bq4JnBKH4fcGIQnmBj9NFYLFAco5hbkJPdMheU+N2rg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qFtnvIwyatxe9V0C/oa7VXw+9uKeDDekYVIcg/rKdZBKYY+sfNOvrYEXpL0khVtcw
	 xJxX8RBOuz6kcSKoyDZV8Kwl67LBjdGP81LGqiyVTw7dSM4pqsVX8+hCxpgBpTDoey
	 /IdMaHFHuNNzOQKzKQJLIhfeD45omAFespEwvYoeBs9lBNdd25uGXbqSYugZCD6k5l
	 M6kBe7lHCNkHIyHpM3ryw3oaHEA9e/OqDEGDNDQJFDZlSqvO0Cejql5lelNbGxT+qs
	 zDnzji32v67pY5StdX8BM6iyamOfnu160TUsEFx42ek6ozAvZ2qopEN2GwYdcVoVSY
	 tM8FgIe/rKvsw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TT4SV4yXvz4wcF;
	Mon,  5 Feb 2024 22:50:18 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jan Stancek <jstancek@redhat.com>, Nicholas Piggin <npiggin@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, linuxppc-dev@lists.ozlabs.org, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, jstancek@redhat.com
Subject: Re: [PATCH] powerpc: add crtsavres.o to always-y instead of extra-y
In-Reply-To: <ZbjHTMhQ4Z9lRR6L@t14s>
References: <20231120232332.4100288-1-masahiroy@kernel.org>
 <CX42TU4QHS1Z.A0UUHMDAMZOL@wheely> <ZbjHTMhQ4Z9lRR6L@t14s>
Date: Mon, 05 Feb 2024 22:50:17 +1100
Message-ID: <87v873870m.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jan Stancek <jstancek@redhat.com> writes:
> On Tue, Nov 21, 2023 at 10:51:34AM +1000, Nicholas Piggin wrote:
>>On Tue Nov 21, 2023 at 9:23 AM AEST, Masahiro Yamada wrote:
>>> crtsavres.o is linked to modules. However, as explained in commit
>>> d0e628cd817f ("kbuild: doc: clarify the difference between extra-y
>>> and always-y"), 'make modules' does not build extra-y.
>>>
>>> For example, the following command fails:
>>>
>>>   $ make ARCH=powerpc LLVM=1 KBUILD_MODPOST_WARN=1 mrproper ps3_defconfig modules
>>>     [snip]
>>>     LD [M]  arch/powerpc/platforms/cell/spufs/spufs.ko
>>>   ld.lld: error: cannot open arch/powerpc/lib/crtsavres.o: No such file or directory
>>>   make[3]: *** [scripts/Makefile.modfinal:56: arch/powerpc/platforms/cell/spufs/spufs.ko] Error 1
>>>   make[2]: *** [Makefile:1844: modules] Error 2
>>>   make[1]: *** [/home/masahiro/workspace/linux-kbuild/Makefile:350: __build_one_by_one] Error 2
>>>   make: *** [Makefile:234: __sub-make] Error 2
>>>
>>
>>Thanks. Is this the correct Fixes tag?
>>
>>Fixes: d0e628cd817f ("powerpc/64: Do not link crtsavres.o in vmlinux")
>>
>>Hmm, looks like LLD might just do this now automatically for us
>>too without --save-restore-funcs (https://reviews.llvm.org/D79977).
>>But we probably still need it for older versions, so we still need
>>your patch.
>
> Hi,
>
> I'm still seeing the error of crtsavres.o missing when building external modules
> after "make LLVM=1 modules_prepare". Should it be built also in archprepare?

Or modules_prepare?

Example patch below.

cheers


diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 051247027da0..82cdef40a9cd 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -59,6 +59,11 @@ ifeq ($(CONFIG_PPC64)$(CONFIG_LD_IS_BFD),yy)
 KBUILD_LDFLAGS_MODULE += --save-restore-funcs
 else
 KBUILD_LDFLAGS_MODULE += arch/powerpc/lib/crtsavres.o
+
+crtsavres_prepare: scripts
+	$(MAKE) $(build)=arch/powerpc/lib arch/powerpc/lib/crtsavres.o
+
+modules_prepare: crtsavres_prepare
 endif
 
 ifdef CONFIG_CPU_LITTLE_ENDIAN



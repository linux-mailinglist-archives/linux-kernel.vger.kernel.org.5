Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639317E51FE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 09:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbjKHIaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 03:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjKHIaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 03:30:22 -0500
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2AD1712;
        Wed,  8 Nov 2023 00:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1699432214;
        bh=e/7Coa7s3rCuVMbGWfCBQAE65gFvaoqlhzpw77Swr2k=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Ntcd/X7ToM8F2Mxx6dMLj5YtpzS7sA9lai5sKI5gCc3DB0MmEh1jGStI6EHDjkQpq
         TtSeRsClDHej/Ho9pMfOyDTsfjmO9NMApMIi0JWWraGlZTJtKZVFrd10AKfTBk1A6k
         mCsbjPKYT8CageUraqppGFXb6hV+FIu6IjPBrb4s=
Received: from [192.168.124.15] (unknown [113.140.11.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384))
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id D5CE166A03;
        Wed,  8 Nov 2023 03:30:09 -0500 (EST)
Message-ID: <d32d8a26dcd75a840727cdb50546b621d34d326b.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Disable module from accessing external data
 directly
From:   Xi Ruoyao <xry111@xry111.site>
To:     WANG Rui <wangrui@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, loongson-kernel@lists.loongnix.cn,
        Fangrui Song <maskray@google.com>
Date:   Wed, 08 Nov 2023 16:30:05 +0800
In-Reply-To: <20231108040447.288870-1-wangrui@loongson.cn>
References: <20231108040447.288870-1-wangrui@loongson.cn>
Autocrypt: addr=xry111@xry111.site; prefer-encrypt=mutual;
 keydata=mDMEYnkdPhYJKwYBBAHaRw8BAQdAsY+HvJs3EVKpwIu2gN89cQT/pnrbQtlvd6Yfq7egugi0HlhpIFJ1b3lhbyA8eHJ5MTExQHhyeTExMS5zaXRlPoiTBBMWCgA7FiEEkdD1djAfkk197dzorKrSDhnnEOMFAmJ5HT4CGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQrKrSDhnnEOPHFgD8D9vUToTd1MF5bng9uPJq5y3DfpcxDp+LD3joA3U2TmwA/jZtN9xLH7CGDHeClKZK/ZYELotWfJsqRcthOIGjsdAPuDgEYnkdPhIKKwYBBAGXVQEFAQEHQG+HnNiPZseiBkzYBHwq/nN638o0NPwgYwH70wlKMZhRAwEIB4h4BBgWCgAgFiEEkdD1djAfkk197dzorKrSDhnnEOMFAmJ5HT4CGwwACgkQrKrSDhnnEOPjXgD/euD64cxwqDIqckUaisT3VCst11RcnO5iRHm6meNIwj0BALLmWplyi7beKrOlqKfuZtCLbiAPywGfCNg8LOTt4iMD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-11-08 at 12:04 +0800, WANG Rui wrote:
> When compiling module with GCC, the option `-mdirect-extern-access` is
> disabled by default. The Clang option `-fdirect-access-external-data`
> is enabled by default, so it needs to be explicitly disabled.

I'm wondering why it's enabled by default.

For this simple test case:

extern char **environ;

int main()
{
  __builtin_printf("%10s\n", environ[0]);
}

With Clang 17.0.4 and "clang t1.c -S -O2", it compiles to:

main:
	addi.d	$sp, $sp, -16
	st.d	$ra, $sp, 8
	pcalau12i	$a0, %got_pc_hi20(environ)
	ld.d	$a0, $a0, %got_pc_lo12(environ)
	ld.d	$a0, $a0, 0
	ld.d	$a1, $a0, 0
	pcalau12i	$a0, %pc_hi20(.L.str)
	addi.d	$a0, $a0, %pc_lo12(.L.str)
	bl	%plt(printf)
	move	$a0, $zero
	ld.d	$ra, $sp, 8
	addi.d	$sp, $sp, 16
	ret

So GOT is used for accessing the external variable environ.  With "clang
t1.c -S -O2 -fdirect-access-external-data", we get:

main:
	addi.d	$sp, $sp, -16
	st.d	$ra, $sp, 8
	pcalau12i	$a0, %pc_hi20(environ)
	addi.d	$a0, $a0, %pc_lo12(environ)
	ld.d	$a0, $a0, 0
	ld.d	$a1, $a0, 0
	pcalau12i	$a0, %pc_hi20(.L.str)
	addi.d	$a0, $a0, %pc_lo12(.L.str)
	bl	%plt(printf)
	move	$a0, $zero
	ld.d	$ra, $sp, 8
	addi.d	$sp, $sp, 16
	ret

then the linked binary triggers a SIGBUS.  Ideally this should be
detected by the linker at link time, but currently the BFD linker fails
to detect this error (FWIW this flaw is caused by a really nasty method
for the medium code model implementation).  So to me -fno-direct-access-
external-data is the default.  I also grepped for -fdirect-access-
external-data in the kernel building system but I've not found any
match.=20

Are you using a different version of Clang, or maybe Clang has some
configuration-time option to make -fdirect-access-external-data the
default?

Note that to translate a TU for a normal (dynamically-linked user-space)
executable on LoongArch Linux, -fdirect-access-external-data should not
be used (because copy relocation is now considered a bad idea and we'll
not support it for a new architecture).  Fangrui?

-fdirect-access-external-data can be used in KBUILD_CFLAGS_KERNEL for
avoiding GOT in the main kernel image, OTOH.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

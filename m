Return-Path: <linux-kernel+bounces-17031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0D2824759
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12F30285EF6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE6D2C18C;
	Thu,  4 Jan 2024 17:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozARAWKf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E8828E30;
	Thu,  4 Jan 2024 17:18:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434EFC433C7;
	Thu,  4 Jan 2024 17:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704388703;
	bh=4BDLtWSfYGZgp3W2cYGuKr7Sby6Scya/xnEGeEw71bw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ozARAWKfOoTssT2qAByVR5pY7jB4Pp03cp1083vFpdHUP35jsbwxqDl3iMoG3KCZb
	 LMCQKOLqm5+KgucXw/zwgDVs0VGEgDcqjZqyL8XO78G9PbeUFGkrDhcTPu5LkGgkQl
	 efQ9E9kziOE/XPVH4aJvMosk/kPflkT59rOMsPwUgOuy5S3mjX5EVnpSMankwqAJ5p
	 HOVQXl1ew0mB8BMuPkiZjM2WcVVdyABubVwgeaVJp3rLwi3DVDAsw0Z+miz1gHs6jW
	 DqgGFZNJNtHXPf2rFzV3wtmx6brI/uK3J9AmFh6sRPYrdNcAFe/ur3SmZ2fswTsmSm
	 LImliq38trvHA==
Date: Thu, 4 Jan 2024 09:18:21 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Jerry Shih <jerry.shih@sifive.com>
Cc: linux-crypto@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Phoebe Chen <phoebe.chen@sifive.com>, hongrong.hsu@sifive.com,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Andy Chiu <andy.chiu@sifive.com>
Subject: Re: [RFC PATCH 07/13] crypto: riscv - add vector crypto accelerated
 AES-{ECB,CBC,CTR,XTS}
Message-ID: <20240104171821.GA1127@sol.localdomain>
References: <20240102064743.220490-1-ebiggers@kernel.org>
 <20240102064743.220490-8-ebiggers@kernel.org>
 <20240103145043.GB773@quark.localdomain>
 <905D43CF-B01A-49DE-9046-51A370B6F680@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <905D43CF-B01A-49DE-9046-51A370B6F680@sifive.com>

On Thu, Jan 04, 2024 at 04:47:16PM +0800, Jerry Shih wrote:
> On Jan 3, 2024, at 22:50, Eric Biggers <ebiggers@kernel.org> wrote:
> > On Tue, Jan 02, 2024 at 12:47:33AM -0600, Eric Biggers wrote:
> >> diff --git a/arch/riscv/crypto/Makefile b/arch/riscv/crypto/Makefile
> >> index dca698c5cba3e..5dd91f34f0d52 100644
> >> --- a/arch/riscv/crypto/Makefile
> >> +++ b/arch/riscv/crypto/Makefile
> >> @@ -1,7 +1,10 @@
> >> # SPDX-License-Identifier: GPL-2.0-only
> >> #
> >> # linux/arch/riscv/crypto/Makefile
> >> #
> >> 
> >> obj-$(CONFIG_CRYPTO_AES_RISCV64) += aes-riscv64.o
> >> aes-riscv64-y := aes-riscv64-glue.o aes-riscv64-zvkned.o
> >> +
> >> +obj-$(CONFIG_CRYPTO_AES_BLOCK_RISCV64) += aes-block-riscv64.o
> >> +aes-block-riscv64-y := aes-riscv64-block-mode-glue.o aes-riscv64-zvkned-zvbb-zvkg.o aes-riscv64-zvkned-zvkb.o
> > 
> > A bug I noticed (which is also present in Jerry's patchset) is that some of the
> > code of the aes-block-riscv64 module is located in aes-riscv64-zvkned.S, which
> > isn't built into that module but rather into aes-riscv64.  This causes a build
> > error when both CONFIG_CRYPTO_AES_RISCV64 and CONFIG_CRYPTO_AES_BLOCK_RISCV64
> > are set to 'm':
> > 
> >    ERROR: modpost: "aes_cbc_decrypt_zvkned" [arch/riscv/crypto/aes-block-riscv64.ko] undefined!
> >    ERROR: modpost: "aes_ecb_decrypt_zvkned" [arch/riscv/crypto/aes-block-riscv64.ko] undefined!
> >    ERROR: modpost: "aes_cbc_encrypt_zvkned" [arch/riscv/crypto/aes-block-riscv64.ko] undefined!
> >    ERROR: modpost: "aes_ecb_encrypt_zvkned" [arch/riscv/crypto/aes-block-riscv64.ko] undefined!
> > 
> > To fix this, I think we should just merge the two modules and kconfig options
> > together so that there is one module that provides both the AES modes and the
> > AES single-block cipher.  That's how x86's aesni-intel works, for example.
> > 
> > - Eric
> 
> That's a bug in my patchset.
> I don't test with all options with `M` settings since I can't boot to qemu with all `M` settings.
> 
> Could we move the cbc and ecb from `aes-riscv64-zvkned` to `aes-block-riscv64` instead of merging
> these two modules?
> Thus, we could still enable the single aes block cipher without other extensions(e.g. zvbb or zvkg).

My proposal to merge the two modules still results in the single-block AES
cipher being registered when zvkned alone is present.  It just won't be
selectable separately via kconfig.  I think that's fine.

- Eric


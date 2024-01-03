Return-Path: <linux-kernel+bounces-15670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B36822FDC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D160E281C4A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E101C292;
	Wed,  3 Jan 2024 14:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcgMEXFm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6555F1C282;
	Wed,  3 Jan 2024 14:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BBCCC433C7;
	Wed,  3 Jan 2024 14:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704293448;
	bh=8ypxHIMeE1M2ORBhy1nGrxQtUOicK9rqmadKgZ02QBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IcgMEXFmchMYoWnvwQcWeMVlkOuMuAA1zW/pvPvPlq0PDKwJZVFOEuWVAJ7HlvpPb
	 3IibPUNyGwDJz5u3AoRuXR+nVrfP/8SaBxiwe6yhN8DxaKY/oylM4mOmMn8c/bA8/z
	 ymgBmqj2ylYj0NViC28iJjeZZe0LbqK9OnQL270KmIq8i/QKY1Dfg0V875JHbz3pdO
	 2k14DsNYPqZQuwcb7zk3CdilniEL7cuDXQmp/rOaU6AUcA2ynQTt597YTxm6hsvK+y
	 HPQMuZEEezbOd5ESA2U2OzQCi/YJatBf01QfWH2LH6txOVxOrGOnJ3gBqNmS0/gP8Q
	 Y464pVq4qVs6Q==
Date: Wed, 3 Jan 2024 08:50:43 -0600
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org, linux-riscv@lists.infradead.org,
	Jerry Shih <jerry.shih@sifive.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Phoebe Chen <phoebe.chen@sifive.com>, hongrong.hsu@sifive.com,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Andy Chiu <andy.chiu@sifive.com>
Subject: Re: [RFC PATCH 07/13] crypto: riscv - add vector crypto accelerated
 AES-{ECB,CBC,CTR,XTS}
Message-ID: <20240103145043.GB773@quark.localdomain>
References: <20240102064743.220490-1-ebiggers@kernel.org>
 <20240102064743.220490-8-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102064743.220490-8-ebiggers@kernel.org>

On Tue, Jan 02, 2024 at 12:47:33AM -0600, Eric Biggers wrote:
> diff --git a/arch/riscv/crypto/Makefile b/arch/riscv/crypto/Makefile
> index dca698c5cba3e..5dd91f34f0d52 100644
> --- a/arch/riscv/crypto/Makefile
> +++ b/arch/riscv/crypto/Makefile
> @@ -1,7 +1,10 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  #
>  # linux/arch/riscv/crypto/Makefile
>  #
>  
>  obj-$(CONFIG_CRYPTO_AES_RISCV64) += aes-riscv64.o
>  aes-riscv64-y := aes-riscv64-glue.o aes-riscv64-zvkned.o
> +
> +obj-$(CONFIG_CRYPTO_AES_BLOCK_RISCV64) += aes-block-riscv64.o
> +aes-block-riscv64-y := aes-riscv64-block-mode-glue.o aes-riscv64-zvkned-zvbb-zvkg.o aes-riscv64-zvkned-zvkb.o

A bug I noticed (which is also present in Jerry's patchset) is that some of the
code of the aes-block-riscv64 module is located in aes-riscv64-zvkned.S, which
isn't built into that module but rather into aes-riscv64.  This causes a build
error when both CONFIG_CRYPTO_AES_RISCV64 and CONFIG_CRYPTO_AES_BLOCK_RISCV64
are set to 'm':

    ERROR: modpost: "aes_cbc_decrypt_zvkned" [arch/riscv/crypto/aes-block-riscv64.ko] undefined!
    ERROR: modpost: "aes_ecb_decrypt_zvkned" [arch/riscv/crypto/aes-block-riscv64.ko] undefined!
    ERROR: modpost: "aes_cbc_encrypt_zvkned" [arch/riscv/crypto/aes-block-riscv64.ko] undefined!
    ERROR: modpost: "aes_ecb_encrypt_zvkned" [arch/riscv/crypto/aes-block-riscv64.ko] undefined!

To fix this, I think we should just merge the two modules and kconfig options
together so that there is one module that provides both the AES modes and the
AES single-block cipher.  That's how x86's aesni-intel works, for example.

- Eric


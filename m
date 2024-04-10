Return-Path: <linux-kernel+bounces-138591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D5789F420
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7C7E1C23825
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C2A15EFBA;
	Wed, 10 Apr 2024 13:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPub9SDT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8993815ECD2;
	Wed, 10 Apr 2024 13:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755364; cv=none; b=COI0WN0pijHgZYQY3fG5wPMz3lKa9/hmW4ateSjdvxxVO9by3gpL1ctsS7i3vODtxU+zQST8Wmc3wS1aov0C/7JbHfK277SZbw9tf1isgrGZNVWo+02kfgiP4WoBZNY+mOxCy0CUJxARdArwAfP7Gjx30rtbRol4qANb19y1IMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755364; c=relaxed/simple;
	bh=03D0DQleB9vxk8wekat4Pmx/RVLXpwIuxViW/1q3BPE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CnQr18+SNjO7Rdyq5Zpg4f52quwewq+38ykfmpJhVCNDeUMd5lzKaXB7fWdrQp6JqHuK4w25QJWe88eAhqeR9TjBBc5xzGJzwXPq9ftCLC2wJh6bEhqLHauCsE+y/ZZpu8YH+ATeu4aIFibf41h9Ps50cJSNedbgpbFF7pa8jVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPub9SDT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98FF6C433C7;
	Wed, 10 Apr 2024 13:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712755364;
	bh=03D0DQleB9vxk8wekat4Pmx/RVLXpwIuxViW/1q3BPE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cPub9SDTJInpTD3h3i5Bm0XMXXDO2+Pu3RoVexjDEgpyIom8aOKTpUnOi2fKfG0v/
	 Z21+mTqNAwQ3B0ZxoDkdf+ioemD5P4CiEswiaqPYR2YMFl0r6A7CF6u2sRUasBR0fI
	 q3A3FvUeBdN0WnAVvvxKzvY9zqoV+OKEv93rhNpW8YB4lul59+n6aXt7SE73+lxvAm
	 UUp6giFw1XTo2UdIUxitRqf07eVX36sLFl2qCFX3CNINltqlz6x/1WSFC209Y5iFfx
	 f9yEfchlx+Wdet8CZIpQ7odYqnkYwAV2OIENdLL2IhQRy+7gqbGhgMQRycR3Pyrrb5
	 3f7InogKyfqbQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org
Cc: conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>, Miguel
 Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson
 Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>, rust-for-linux@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH v3 0/1] RISC-V: enable rust
In-Reply-To: <20240409-unsaddle-skittle-c93eb77732bb@spud>
References: <20240409-unsaddle-skittle-c93eb77732bb@spud>
Date: Wed, 10 Apr 2024 15:22:40 +0200
Message-ID: <871q7d73of.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Conor Dooley <conor@kernel.org> writes:

> From: Conor Dooley <conor.dooley@microchip.com>
>
> I've intentionally not turned on the gcc support, as discussed on
> v1. I've also switched over to using the target, but it is a bit heavier
> than the one arm64 seems to be using. RISC-V has fewer targets available
> and this was the closest. I preserved the redzone disabling, just moved
> into the Makefile. Any comment from Gary or the LLVM lads on the target
> would be great I think:
> https://github.com/rust-lang/rust/blob/master/compiler/rustc_target/src/s=
pec/targets/riscv64imac_unknown_none_elf.rs
> arm64 is using:
> https://github.com/rust-lang/rust/blob/master/compiler/rustc_target/src/s=
pec/targets/aarch64_unknown_none.rs
>
> I was gonna send this yesterday, but found out last minute I had invalid
> code in the target generation script. The kernel test robot had given my
> branch the global all-clear - the rust coverage with all the
> "depends on !FOO" must really limit the build coverage. I built for x86
> with rust enabled locally this time to make sure..
>
> As this as lifted from the state of the Rust-for-Linux tree, the commit
> messages from there cannot be preserved, so these patches have commit
> messages that I wrote.
>
> I've tested this on Icicle, and the modules seem to work as expected.
> Unfortunately there appear to be implicit 32-bit divisions (or similar)
> in core Rust code, so, as in the downstream Rust-for-Linux tree, Rust is
> only enabled for 64-bit.

Nice, works with my simple test on VisionFive 2 as well! Cool to have
Rust support in! Now, BTF just needs to be supported, and I can have
Rust *and* BPF in my kernels! :-P \o/

Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>


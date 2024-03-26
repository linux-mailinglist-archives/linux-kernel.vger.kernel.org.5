Return-Path: <linux-kernel+bounces-119696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E01A88CC2C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2D171F8100B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621C813C68E;
	Tue, 26 Mar 2024 18:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyialCPC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C891129E88;
	Tue, 26 Mar 2024 18:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711478579; cv=none; b=Ua5fCnBnbaHcOCFG5mv1sfLXYJPCtWHo2SHb+wTaGFBRhcpLCrMKE4pZsvWwKvsRUW1elze2xjzhVYiFjtUBIhNgZzROw8k2JtExqv41fOkUFT5OgLI26NmMYGCYc+nZJo37MZtlSn3O+EdPVlZ9Tg80ECu2PKVjjDIL19tjY9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711478579; c=relaxed/simple;
	bh=4jVrfD/KvnLbhutEiKxJwcAulEU3J50vmATSDtq9sqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWB6A6M2awg0XwcV2uW/pRNDig4wpQSbezMT3mObcuAHAKXp9ZCP1AYx3TeQCqBPV0xdz+w7M9YZEU4HGjRo0qqsiE/9TFzQDKFIHOGE4qjVPPsBysx9vtGyoedDqzjCQU5NOX6d10r8OBpLpaS/9QYICj7hFJTonu2rCMVWul0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyialCPC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF51BC433C7;
	Tue, 26 Mar 2024 18:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711478579;
	bh=4jVrfD/KvnLbhutEiKxJwcAulEU3J50vmATSDtq9sqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IyialCPC3XtDBNWscY3/R0P7oEJ2BjULmLF15MUdpQ/pvuLKfcck53g46epTk9R58
	 GcoQoHy7q0tyoVKC4r2PeOMLJETm3V64gaZ6n0cpw2/irlliNf5Bz6Ix7/Jk6iiIvv
	 Uq8GFF1QvQUAQYnGCOhzMEDLT49PuPraYC/Xt0eH3RSMJwYnwuVLwWunZJ0YXiJGlF
	 T8d4fgIvrUCpB3xwMLXnx/t4UzEU/u8Bwc3L1mFyD90OxoXAJqCuDmclN+R0yWiD1L
	 PpBZCgmPohc/Oiom6oxYypolD90iiUaNY+Lr04O+HJ3/BolKbCj5SYbKxcLzJ81HLM
	 FE1yx4O0ZhDcw==
Date: Tue, 26 Mar 2024 18:42:54 +0000
From: Conor Dooley <conor@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>, linux-modules@vger.kernel.org,
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v7 2/2] arch/riscv: Enable kprobes when CONFIG_MODULES=n
Message-ID: <20240326-cape-compacted-e76df066752f@spud>
References: <20240326134616.7691-1-jarkko@kernel.org>
 <20240326134616.7691-2-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZY3M3zfLOpMoFKjK"
Content-Disposition: inline
In-Reply-To: <20240326134616.7691-2-jarkko@kernel.org>


--ZY3M3zfLOpMoFKjK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 03:46:16PM +0200, Jarkko Sakkinen wrote:
> Tacing with kprobes while running a monolithic kernel is currently
> impossible due the kernel module allocator dependency.
>=20
> Address the issue by implementing textmem API for RISC-V.

This doesn't compile for nommu:
  /build/tmp.3xucsBhqDV/arch/riscv/kernel/execmem.c:10:46: error: 'MODULES_=
VADDR' undeclared (first use in this function)
  /build/tmp.3xucsBhqDV/arch/riscv/kernel/execmem.c:11:37: error: 'MODULES_=
END' undeclared (first use in this function)
  /build/tmp.3xucsBhqDV/arch/riscv/kernel/execmem.c:14:1: error: control re=
aches end of non-void function [-Werror=3Dreturn-type]
Clang builds also report:
=2E./arch/riscv/kernel/execmem.c:8:56: warning: omitting the parameter name=
 in a function definition is a C2x extension [-Wc2x-extensions]

>=20
> Link: https://www.sochub.fi # for power on testing new SoC's with a minim=
al stack
> Link: https://lore.kernel.org/all/20220608000014.3054333-1-jarkko@profian=
=2Ecom/ # continuation
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v5-v7:
> - No changes.
> v4:
> - Include linux/execmem.h.
> v3:
> - Architecture independent parts have been split to separate patches.
> - Do not change arch/riscv/kernel/module.c as it is out of scope for
>   this patch set now.

Meta comment. I dunno when v1 was sent, but versions can you please
relax with submitting new versions of your patches? There's conversations
ongoing on v5 at the moment, while this is a more recent version. v2
seems to have been sent on the 23rd and there's been 5 versions in the
last day:
https://patchwork.kernel.org/project/linux-riscv/list/?submitter=3D195059&s=
tate=3D*

Could you please also try and use a cover letter for patchsets, ideally
with a consistent subject? Otherwise I have to manually mark stuff as
superseded.

Thanks,
Conor.

> v2:
> - Better late than never right? :-)
> - Focus only to RISC-V for now to make the patch more digestable. This
>   is the arch where I use the patch on a daily basis to help with QA.
> - Introduce HAVE_KPROBES_ALLOC flag to help with more gradual migration.

--ZY3M3zfLOpMoFKjK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgMXLgAKCRB4tDGHoIJi
0kr6APoC8w1hFwYBq68SvRiP5k+lnvxzYoTYGxCdhojX1wA0lAD6AyvaCzZnOAGK
ej3FsxMvaVpbalYkFzvk6xtCRrliwQk=
=Qyv3
-----END PGP SIGNATURE-----

--ZY3M3zfLOpMoFKjK--


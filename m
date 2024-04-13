Return-Path: <linux-kernel+bounces-143503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 345678A3A44
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD5E31F2279B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 01:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BC18F48;
	Sat, 13 Apr 2024 01:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="EDqqRVR7"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A145DDA3;
	Sat, 13 Apr 2024 01:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712973243; cv=none; b=VmAheqCw4h0zjiS/Gstps6gyeUI1nb3dHw4zcJBV3cFjbXtXa8milFa1zFhxbIK8OKm7xp/Hy1T8MbcP7bjmqxpc+InbFJcJZkLsoKZTfqxkHy3Zk7+5vgFN9xpfBLmqDUj9BrT/A0BrM/O2bqySzDyQndXzf3UbM2kHmyQG+MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712973243; c=relaxed/simple;
	bh=nsOYgZD6NcU0rdrT4T38X2Zder785/fBw+JPZN9oFnU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nGcfqiP+Hdpg2xgzHavPMlSzRbPiHc/lLMcWk6PwZBuSuhnooz5Txl/5Rmq61+Sm91FlUOBfW1j0wMw0687rDC6TanDNoNCCIFMSgyP9zQ8ooJCqzuDPHM94icRDF6dLYHaKVpHtZBvZqjBfp58iI7hpYa60mq3GQxBCz/ppR3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=EDqqRVR7; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712973232;
	bh=Y4BOwpk8yD9IlKJHunm77VnxmVc/7lRfLru6wBoJFaA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EDqqRVR7LZ+SNtsMLjm8Fbb2ebWukmsVwlTD9Z5qqjqBTjJ+ij7wd3FflepCx5rPp
	 h+Wwxe5GUSHf8dJHrMu8kjC21MG7Pmwk18uIvcfKqOpW/Po2ZP4FHVkBv8VjM7V8cF
	 9XogbxEee+D2oAoGtql/r7CvmIUHJXpgeisXI96MJbJStyXttEhsr4gawGO9p2JZ39
	 V+/kD2cFFA9AS3zn4p05EpYKcmW/SNA/bUNixWgkQhNp6LQC0EWRG8sX/VlrHxF8qg
	 +XqSGud5sE+3h2q9V3srWooQOTG0n+K15PV6b9mm5nJBDm0BFcmCOhFf4c47Q7FKzH
	 xTPdCfRJOiYSw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VGc0t0dkgz4wcC;
	Sat, 13 Apr 2024 11:53:49 +1000 (AEST)
Date: Sat, 13 Apr 2024 11:53:24 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Sean Christopherson <seanjc@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, Peter Zijlstra
 <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Pawan Gupta
 <pawan.kumar.gupta@linux.intel.com>, Daniel Sneddon
 <daniel.sneddon@linux.intel.com>, <linuxppc-dev@lists.ozlabs.org>, Michael
 Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/3] x86/cpu: Actually turn off mitigations by default
 for SPECULATION_MITIGATIONS=n
Message-ID: <20240413115324.53303a68@canb.auug.org.au>
In-Reply-To: <20240409175108.1512861-2-seanjc@google.com>
References: <20240409175108.1512861-1-seanjc@google.com>
	<20240409175108.1512861-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NbG7tw_eh21Qan+TJ2Af+bh";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/NbG7tw_eh21Qan+TJ2Af+bh
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Sean,

I noticed this commit in linux-next.

On Tue,  9 Apr 2024 10:51:05 -0700 Sean Christopherson <seanjc@google.com> =
wrote:
>
> Initialize cpu_mitigations to CPU_MITIGATIONS_OFF if the kernel is built
> with CONFIG_SPECULATION_MITIGATIONS=3Dn, as the help text quite clearly
> states that disabling SPECULATION_MITIGATIONS is supposed to turn off all
> mitigations by default.
>=20
>   =E2=94=82 If you say N, all mitigations will be disabled. You really
>   =E2=94=82 should know what you are doing to say so.
>=20
> As is, the kernel still defaults to CPU_MITIGATIONS_AUTO, which results in
> some mitigations being enabled in spite of SPECULATION_MITIGATIONS=3Dn.
>=20
> Fixes: f43b9876e857 ("x86/retbleed: Add fine grained Kconfig knobs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  kernel/cpu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 8f6affd051f7..07ad53b7f119 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -3207,7 +3207,8 @@ enum cpu_mitigations {
>  };
> =20
>  static enum cpu_mitigations cpu_mitigations __ro_after_init =3D
> -	CPU_MITIGATIONS_AUTO;
> +	IS_ENABLED(CONFIG_SPECULATION_MITIGATIONS) ? CPU_MITIGATIONS_AUTO :
> +						     CPU_MITIGATIONS_OFF;
> =20
>  static int __init mitigations_parse_cmdline(char *arg)
>  {
> --=20
> 2.44.0.478.gd926399ef9-goog
>=20

I noticed because it turned off all mitigations for my PowerPC qemu
boot tests - probably because CONFIG_SPECULATION_MITIGATIONS only
exists in arch/x86/Kconfig ... thus for other architectures that have
cpu mitigations, this will always default them to off, right?

--=20
Cheers,
Stephen Rothwell

--Sig_/NbG7tw_eh21Qan+TJ2Af+bh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYZ5ZQACgkQAVBC80lX
0GynlAf/Wrk3YC50MGX7+3M9JTuw86KpBU8ObFWWrRoQMz1pL8HUIJ2r3DD3jmY5
Q+Wb4noRymG9Y+zIoB5TFzdn84TKTTJSzQhu6EVrn4loYN2rRQTimU8gmhQejExl
75el/6d9lIOIL2VvgFAddpIvahlc+s2ovo4y1rPXlR7uAQq5LNUEz7H8fuCkGcGO
/ATBSVfhyDN3ryvmDXO7XU+Nsb24Bz5i3NmHTv20sbdMkij26+u8QCtyZFOhmbrY
DjMi+IxL0kcsUg4jnoXrAaC/yy1etU96S5iukrMNRj2ENI4Nv8ivwYDdawdpzIdx
mIFCuaKOVfcaUfJ51s/eUK3Pq0PAVw==
=K4/i
-----END PGP SIGNATURE-----

--Sig_/NbG7tw_eh21Qan+TJ2Af+bh--


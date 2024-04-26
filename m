Return-Path: <linux-kernel+bounces-159572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5500D8B307A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66028B238AE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA20F7E76D;
	Fri, 26 Apr 2024 06:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gmHnbQDK"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5E72F2F;
	Fri, 26 Apr 2024 06:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714113204; cv=none; b=eWYpEgMr9vb+upeh4ZmL7Lbz2kOoU8YZepyEtgYvtPXpnL9bGa8Cadkk+I+opDL0xIwHgRaZHQ4PPvPDeHZ7XxBBk17wHOFsjEDEDbDY7suz0yDKSyVVkMoN9zv5TG4Z0a4+2TJrmdvFjMmtZKz2iT92eP6Cf4ts5UHT2yAlm1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714113204; c=relaxed/simple;
	bh=9D055W7RtRvLj82AeRwJBH59kEMFM/MAOc528dNhuWU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TsfOx02nEnPJnZU95DZ2TUZ3MwauA+wWApUGUW3lbY9oZYs9bwwrnmyDlYSBXdSN1Q18XIgAHx1/9jgyCa9YyWdZoC63lyOQAVusIO+Du/PH+tbtbNc/S7FfXaGE8An6pYzsJ6C5oi27DHDokEcs7fIFJZerzE4J5JJorq8+EXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=gmHnbQDK; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714113198;
	bh=6Y3Pvzw551sAs1KbLGSUMWiK/mGngNA5pQ9eJ3QZexA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gmHnbQDKNIPhPiNHxlmWIEd/nQw7EaS2G27TLsj05iV33X07z4JbTtXZ4aTK6DQkU
	 eQepK8grflZG5lpLqXBxyvX9WzP+drv0ay8ABAFSR5G1zR38EXG54Fq/hRNwcH404H
	 1+K/mgWm75OwGeTfwZ5Ie2DHSLxWyua4RoUPE5akwWUnLBo91x8FKkX5nSI2HqFbJv
	 R4Pej7rSnY7BiJ+hXzm6yeOBPljLwhJUycQM07qLqe9/AUmymZGCGS0qA581eiDdAW
	 IYKn9XSIV4QdKjZxhS2VmXgJDS8AT+qXJcAKwxDtb5RgUDYWfG2O8xS3ASIIfArOWQ
	 39ZGEkJw1kSFQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VQjbL38fsz4wyh;
	Fri, 26 Apr 2024 16:33:18 +1000 (AEST)
Date: Fri, 26 Apr 2024 16:33:17 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mike Rapoport <rppt@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Subject: Re: linux-next: boot failure after merge of the modules tree
Message-ID: <20240426163317.4d908643@canb.auug.org.au>
In-Reply-To: <ZijNiXzNpfoyokrh@kernel.org>
References: <20240424183503.2a6ce847@canb.auug.org.au>
	<ZijNiXzNpfoyokrh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kBDTo./6+AX2Nu=yAld2Qcl";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/kBDTo./6+AX2Nu=yAld2Qcl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mike,

On Wed, 24 Apr 2024 12:14:49 +0300 Mike Rapoport <rppt@kernel.org> wrote:
>
> This should fix it for now, I'll rework initialization a bit in v6
> =20
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 1c4be3373686..bea33bf538e9 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -176,6 +176,7 @@ config PPC
>  	select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
>  	select ARCH_WANT_LD_ORPHAN_WARN
>  	select ARCH_WANT_OPTIMIZE_DAX_VMEMMAP	if PPC_RADIX_MMU
> +	select ARCH_WANTS_EXECMEM_EARLY         if EXECMEM
>  	select ARCH_WANTS_MODULES_DATA_IN_VMALLOC	if PPC_BOOK3S_32 || PPC_8xx
>  	select ARCH_WEAK_RELEASE_ACQUIRE
>  	select BINFMT_ELF

I added the above to today's merge of the modules tree and it made the
boot failure go away.

--=20
Cheers,
Stephen Rothwell

--Sig_/kBDTo./6+AX2Nu=yAld2Qcl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYrSq0ACgkQAVBC80lX
0Gw4Jgf/Si1gEOcumL+/if4mFuaMXl46NLK++hY2yB0CEsh9NWe29U+NWSuU8iU8
hfBkQhpzeBrm34Xp6/vXZK7XWsAxDQBnYosoIQUNFtSzcN6KfOHyb1umpXqod6Wx
RcTGAJhQucD6bvq0D6/EMMz8DzU6uYjSspJQmlOQ1h/EufdYc80UWkePDLwREsfj
hKyLonbk8NFQnkHFtHW8OENvWix7KSdQlcWOKINSWdV4eEC7QM+E/LUphGKyjjXf
CmmqtU85OzcZNEbhVrkfVGxCt65hP0zD+ojuHuEKN/T02CKIYerA4CcntveYlcPU
M158NQ4XPx7utqeszCXpJbF/IH3bsw==
=jX/S
-----END PGP SIGNATURE-----

--Sig_/kBDTo./6+AX2Nu=yAld2Qcl--


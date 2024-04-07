Return-Path: <linux-kernel+bounces-134672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9382089B4B2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 01:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F207282F47
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 23:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB7E44C6A;
	Sun,  7 Apr 2024 23:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lXQZtvCk"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD3043172;
	Sun,  7 Apr 2024 23:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712533860; cv=none; b=ABeQTlRzrvHlDT67T8WInu61Ty/Y6RPEZbZHhAcIROw1icJ3BBNlgQoEXZhcHmC28IfNSpZqHe1ugLh7iRf0z0A2a0EGu6fjJBPH1lyKyMEBqXU1WdTYCxNYkGGD4h/ceIwpUtEF1WAJJkjqluQ+K8O/o80oKK2BjSyj6i3jVOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712533860; c=relaxed/simple;
	bh=1c86L7SqWpvlEFYERJvkDHP0iyqxuQapID99+igNC+M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ukhst4rYAVqVSTzsZQWBHndSL0HveLrW7pJn5XIsvU1hiOMvmzWrjZDcPU5PvAKTGiuUxHHe6X/IjhpXVclpzjZr3II4ZcFr76uAG960ZUGmGYIQb1xv0EPp99k3F1atLb6tcye/6wXfWf8pI92YvrJ+JzdbVmyrlk4wrnCMfU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=lXQZtvCk; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712533854;
	bh=mf1mHLDUv6EvUcSexaiAYQTU14kE40UjmYeqke2141Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lXQZtvCkWynSe58fMpUMCXZbMm6A4MdTZKdsF/bv7ZkpjNI1ycyMVLmOzY703gWFW
	 WcXh7iKSEvIA0ZQTpAC7H39nESfGKuBYaidCbhGSjwGashU65sPRviHUjqqvhwgBxA
	 rmfAubJQ5XOETLgCyOQsNgQkGG16SMdM+HfUbK20E+NhgqQAdd/B6dVUy8sIzcCcLF
	 m0mvUxjeaFeFxHBMskIIgRQqciOqfNO7uR2uZjufDzRQYDfT0nHo2BbiNwl+1BKE0f
	 LsfXZW4x7mpCxdqzIWs/LmBve6OrcPmgVYv5rm503eyYoIoD3+YBL0sndr68wo4gPi
	 QbZPM082u1iYg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VCTWJ3VN8z4wcF;
	Mon,  8 Apr 2024 09:50:52 +1000 (AEST)
Date: Mon, 8 Apr 2024 09:50:51 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Suren Baghdasaryan <surenb@google.com>
Subject: Re: linux-next: manual merge of the tip tree with the mm tree
Message-ID: <20240408095051.53c1cc0e@canb.auug.org.au>
In-Reply-To: <20240405115111.132053a5@canb.auug.org.au>
References: <20240405115111.132053a5@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Tr+SKGF4bRRZrZa3jP+EKeB";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Tr+SKGF4bRRZrZa3jP+EKeB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 5 Apr 2024 11:51:11 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the tip tree got a conflict in:
>=20
>   arch/x86/mm/numa_32.c
>=20
> between commit:
>=20
>   d82a37ff6b88 ("fixup! fix missing vmalloc.h includes")
>=20
> from the mm-unstable branch of the mm tree and commit:
>=20
>   9852b1dc6a14 ("x86/numa/32: Include missing <asm/pgtable_areas.h>")
>=20
> from the tip tree.
>=20
> diff --cc arch/x86/mm/numa_32.c
> index e25e08ba4531,025fd7ea5d69..000000000000
> --- a/arch/x86/mm/numa_32.c
> +++ b/arch/x86/mm/numa_32.c
> @@@ -24,7 -24,7 +24,8 @@@
>  =20
>   #include <linux/memblock.h>
>   #include <linux/init.h>
>  +#include <linux/vmalloc.h>
> + #include <asm/pgtable_areas.h>
>  =20
>   #include "numa_internal.h"
>  =20

This is now a conflict between commit

   9852b1dc6a14 ("x86/numa/32: Include missing <asm/pgtable_areas.h>")

in Linus' tree and commit

  a800a5095942 ("fixup! fix missing vmalloc.h includes")

from the mm-unstable branch of the mm tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/Tr+SKGF4bRRZrZa3jP+EKeB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYTMVsACgkQAVBC80lX
0Gwlnwf/VsoaKMnW6cDikYJg7ReN0oTWe5Eqx7Afu+S//zg8M0a/i+deliAzIXuA
MfInSSmJwDT/5Z5C27EE2nzo2gTJFJUIOXVsX9sAHRaQL5UV/eLJvXqIvwjwxvfW
cppOdzM3mwR0RBSd4Xityp9WBXEOpFiia1fpxKLQjqz0LeeUu/rsVW8W2D0V+jo0
loNDji2QoH8CjNht1nPrW3MtDfKmH2uB7Wb5c4SNYR/xuW81BZ+PBGnkST0AeYZB
ShE7PzhlMe8pU1pXR+uhZ9kGxAxVVdyaZMNIEhGOc7Q4WIncNUG6sA9I6MrNXwWR
QXVAXCJmpk0DsS3ajvx7vwQ3hROBtA==
=HwbZ
-----END PGP SIGNATURE-----

--Sig_/Tr+SKGF4bRRZrZa3jP+EKeB--


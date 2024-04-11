Return-Path: <linux-kernel+bounces-139738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2F68A0708
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 942FD1F2401F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FC113BC24;
	Thu, 11 Apr 2024 04:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="vKIqCYSY"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B8613BC0A;
	Thu, 11 Apr 2024 04:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712809039; cv=none; b=fd4yp87gxGMYmMiS5I6LYUGzgEkUCjhkkyYkuiMrrUPCni12o+yS2EhKZ3WZNuSrMoU+8WRkW9ZNKMDEOEtPL1e3xLTyn0baPcdMRCD852fUvKVJ3xWiYVpft2fdUL/oHiQMR2FJ4wZ6///pw2BnhQuhsDlPfVA1HCZYiglg8H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712809039; c=relaxed/simple;
	bh=bLUDS8Uza7sdmsvCoYzhqfsixzf3KYgISXbAKy3r3TA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MTvjM7xxts74U8Ems80yTVSUze6XYQ4rT5wnmWHW1nvA5nqu8lSNO/C+QiLX4AkqePJLnP9Rg2Uy93WJZHdQrR3wn78ci9ek4TdR+KuRcYEu/CMtEcQeZFxI5OrH2QkGWUzkdz/MhSnHMzUHU8yMP12vbOlQal8ARJUiC3DEVXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=vKIqCYSY; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712809033;
	bh=ffEfYRaJC20w15azJhJo0rYxYYPLTu9jsVa9ZGJDYog=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vKIqCYSYRXf3Z2BZwWv8chkDPKx2YHh5srL5Cc/IwJcrzhBkXG5PxAjvukTDeFFR2
	 0l0921niu8reAoElStC7wDidK7EuIK4WpEMs6a22qM7P65HY86Es3BCKqrg5blQxLD
	 yXNFOikqtVl6q90CZ+x3RoLM85AApjEHMU/3xjQ5f15E3v4y5IANP6dU5piAlrTfmx
	 NG3xuQJ4gB0zPEax8rypiyIaLw1Z1iE7/AML6x4c7kvDoE0AM+HPUGYndCnQSY9Hob
	 aT96qwiv+gcQUB3t3PCZaivlnjiXme8Q+5e+ZlWLlEj0k72TP+oxyTyFtUpaSg7zmH
	 hZDm2ZAIBjCFg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VFRHD1wwJz4wcC;
	Thu, 11 Apr 2024 14:17:12 +1000 (AEST)
Date: Thu, 11 Apr 2024 14:17:11 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the tty tree with the tty.current
 tree
Message-ID: <20240411141711.63dbd8e9@canb.auug.org.au>
In-Reply-To: <20240411135735.58de7090@canb.auug.org.au>
References: <20240411135735.58de7090@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LucqT9vVJzOtGmPApdG1c4/";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/LucqT9vVJzOtGmPApdG1c4/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 11 Apr 2024 13:57:35 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the tty tree got a conflict in:
>=20
>   drivers/tty/serial/serial_core.c
>=20
> between commit:
>=20
>   9cf7ea2eeb74 ("serial: core: Clearing the circular buffer before NULLif=
ying it")
>=20
> from the tty.current tree and commit:
>=20
>   1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo")
>=20
> from the tty tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc drivers/tty/serial/serial_core.c
> index 2247efe97250,a78ded8c60b5..000000000000
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@@ -1788,9 -1773,9 +1773,10 @@@ static void uart_tty_port_shutdown(stru
>   	 * Free the transmit buffer.
>   	 */
>   	uart_port_lock_irq(uport);
>  +	uart_circ_clear(&state->xmit);
> - 	buf =3D state->xmit.buf;
> - 	state->xmit.buf =3D NULL;
> + 	buf =3D port->xmit_buf;
> + 	port->xmit_buf =3D NULL;
> + 	INIT_KFIFO(port->xmit_fifo);
>   	uart_port_unlock_irq(uport);
>  =20
>   	free_page((unsigned long)buf);

That didn't work :-(

So I have used the below resolution instead.
--=20
Cheers,
Stephen Rothwell

diff --cc drivers/tty/serial/serial_core.c
index 2247efe97250,a78ded8c60b5..000000000000
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@@ -1788,9 -1773,9 +1773,10 @@@ static void uart_tty_port_shutdown(stru
  	 * Free the transmit buffer.
  	 */
  	uart_port_lock_irq(uport);
- 	uart_circ_clear(&state->xmit);
- 	buf =3D state->xmit.buf;
- 	state->xmit.buf =3D NULL;
++	kfifo_reset(&state->port.xmit_fifo);
+ 	buf =3D port->xmit_buf;
+ 	port->xmit_buf =3D NULL;
+ 	INIT_KFIFO(port->xmit_fifo);
  	uart_port_unlock_irq(uport);
 =20
  	free_page((unsigned long)buf);

--Sig_/LucqT9vVJzOtGmPApdG1c4/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYXZEcACgkQAVBC80lX
0Gx8/Qf/cqHcVPGJ9s7tLH2/0VRucyqoSHABzLgtK0ygtegijIyJuOI+LqsiLRP4
ETtOyPzeRmBRlw0cN9cB79y8xpaWjHD9Z8pjcz/xQS2Ze8jH5F2NYpZDEowMdIxG
2qQMuqjp6kkqnFu/uNDWz/Dgvf4ubzKH5tCQe9JdGC04qsh9TUcy4GCJQHUfwOH8
9oWJgZhNqj7K4YV4viVIXBIgVbY6CRnnjMzNuKpJrpI37rIkyADHOZscZE+Y0ffW
CLh3k70RpN4IqW7t8F4bQNPp0oxvyv+NYTJXHhGdBPs972g0v9+C/m/oXTe3Z7TE
9SgQiBdLj5J8KUL0E54usnoMWwiw+g==
=J0Ha
-----END PGP SIGNATURE-----

--Sig_/LucqT9vVJzOtGmPApdG1c4/--


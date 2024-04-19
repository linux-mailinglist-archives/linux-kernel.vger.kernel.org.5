Return-Path: <linux-kernel+bounces-150999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 946188AA79B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 06:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 130571F2168C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 04:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00635946C;
	Fri, 19 Apr 2024 04:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="sb8Aj+XG"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE292137E;
	Fri, 19 Apr 2024 04:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713500396; cv=none; b=DPc6ZhPiVJlF86+JggF+RpBbigawZmdHG3fnKeoOHx4vZt4vqPLVtrTUN79VtaR3zZB7L6NcVB81g0qfEXwbnWuewFON28JGJ2lEQEwghNn7dPvw9gja7XyIEq20tuzN2RT3Tiw305Pz3ZxWGaBPACzY0Bh/BlqxGWJQb68aF8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713500396; c=relaxed/simple;
	bh=PBAnXLS7YBdgwAVOVCNs0FlMIlB26SpBlBzxXB19yfg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=DCsM6KqW6PLMACsJkXVebP5mnaFu9Sp+5bu/MNEhvyJcIAvAXawC6oUdJw+Vdq9nQWQPIkw6oACFJtAbwxy6R1dUfHLWQV19oPNiPlxLX1Q/5BE733POuQjZfrWtFJqm1x+7rBtB8GGqqRatKcWWc+SXbyMuDpjYNZ7WcYdWMYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=sb8Aj+XG; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713500390;
	bh=uzRJHPvvStv+0WlWLGWHtXPKQ0B60p9m7wWL6w2VZVg=;
	h=Date:From:To:Cc:Subject:From;
	b=sb8Aj+XGFYGh5tZCOKwi+kmNDQfSUb/CTglGvjKbsKDemMFIJE6R5+53YmfHSxr8h
	 NrokrQEJEISlFF0HaqIPr1wocwO0KpG9K/CEdPErwb7RbIny/Y3I5/Ral8ywXg5S0O
	 N0TbLPq/Fb70vq/BGoZ1+1ToMXaPwFLqxQ8S8vFqLwfF3C571Pib2YCIGjTPnoj/lC
	 qSsKVfss2Ajf8gm6Jykt0ayFHf2zyGDh7O/RlWNZsM7Y8KNGBgpXHjHUGtaQ2w85xq
	 fkc+vXlkwo+mp9ZFvOaZzcVeQ78+t61LObwxlaKyVjbThyAzyEaCJTlVkPg1auYOfo
	 LCAG+8e+Uf36w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VLLyZ0pggz4x0C;
	Fri, 19 Apr 2024 14:19:49 +1000 (AEST)
Date: Fri, 19 Apr 2024 14:19:47 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the tty tree with the tty.current tree
Message-ID: <20240419141947.4bc16fa4@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uVrJRs9Aye1uiDUT3E53_rk";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/uVrJRs9Aye1uiDUT3E53_rk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tty tree got a conflict in:

  drivers/tty/serial/serial_core.c

between commit:

  9cf7ea2eeb74 ("serial: core: Clearing the circular buffer before NULLifyi=
ng it")

from the tty.current tree and commits:

  1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo")
  abcd8632f26b ("serial: core: Extract uart_alloc_xmit_buf() and uart_free_=
xmit_buf()")

from the tty tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/tty/serial/serial_core.c
index c476d884356d,b9d631037ff6..000000000000
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@@ -285,6 -273,53 +273,54 @@@ static int uart_alloc_xmit_buf(struct t
  		free_page(page);
  	}
 =20
+ 	return 0;
+ }
+=20
+ static void uart_free_xmit_buf(struct tty_port *port)
+ {
+ 	struct uart_state *state =3D container_of(port, struct uart_state, port);
+ 	struct uart_port *uport;
+ 	unsigned long flags;
+ 	char *xmit_buf;
+=20
+ 	/*
+ 	 * Do not free() the transmit buffer page under the port lock since
+ 	 * this can create various circular locking scenarios. For instance,
+ 	 * console driver may need to allocate/free a debug object, which
+ 	 * can end up in printk() recursion.
+ 	 */
+ 	uport =3D uart_port_lock(state, flags);
++	kfifo_reset(&state->port.xmit_fifo);
+ 	xmit_buf =3D port->xmit_buf;
+ 	port->xmit_buf =3D NULL;
+ 	INIT_KFIFO(port->xmit_fifo);
+ 	uart_port_unlock(uport, flags);
+=20
+ 	free_page((unsigned long)xmit_buf);
+ }
+=20
+ /*
+  * Startup the port.  This will be called once per open.  All calls
+  * will be serialised by the per-port mutex.
+  */
+ static int uart_port_startup(struct tty_struct *tty, struct uart_state *s=
tate,
+ 			     bool init_hw)
+ {
+ 	struct uart_port *uport =3D uart_port_check(state);
+ 	int retval;
+=20
+ 	if (uport->type =3D=3D PORT_UNKNOWN)
+ 		return 1;
+=20
+ 	/*
+ 	 * Make sure the device is in D0 state.
+ 	 */
+ 	uart_change_pm(state, UART_PM_STATE_ON);
+=20
+ 	retval =3D uart_alloc_xmit_buf(&state->port);
+ 	if (retval)
+ 		return retval;
+=20
  	retval =3D uport->ops->startup(uport);
  	if (retval =3D=3D 0) {
  		if (uart_console(uport) && uport->cons->cflag) {

--Sig_/uVrJRs9Aye1uiDUT3E53_rk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYh8OMACgkQAVBC80lX
0GyP8Qf+PerP7qklRR1sKfZGoIzmimiPT88oA0ClWwytU23oyOfCJbKHF7YssGHz
HhuxaH0C0D2TrYUJG5d998PPtVo+SVtXfYNvXH84mkHRBf2Cuc+8uEKQ1tb9D0mv
AhGhfGH1cvyM8oYjbnAnNGF0XzKbubwVNM7qjcZ/yYJEVJi2fBYKJTmZekc5zDvH
KDTjhA2eKvc3JcKwgQagEM/+MaNBeDG+yT5IjO36zd4Jf+vqlcUw3jNkMWrC0soC
DdZS2QlzOJjgZ3pnlTtaZ7+OVb+orPBszzYG6Fa7yIP4Ah5P1LVzlo0aV+BEw5CN
DqNYggsj+bYuQJKXda6iUmqwMvzYOQ==
=IdQQ
-----END PGP SIGNATURE-----

--Sig_/uVrJRs9Aye1uiDUT3E53_rk--


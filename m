Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034B87B7691
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 04:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240630AbjJDCOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 22:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjJDCOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 22:14:37 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0FDA9;
        Tue,  3 Oct 2023 19:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696385673;
        bh=wL/gvsprhjEZszRQWXUhRI7tvZHZz1TYH1dWVu/QSw4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DhxiBrngDKnaeCE3NffpmXN3231Il4f4EgQGtMOQDQ8olMI8InwXfVWqxhlzaOsMZ
         7l2w98CJJL4qdJU/3ACLY8rdVGhdjGxyTEGR5S1tf8nvHjMsFYXYbiBClSZXZVXxeF
         nQyE7BEmpPLJss/P3bFnT6BGVgYpCeBoxmt74wG6SxIQLL1+nqC0vdJ00nfIyXtubP
         Dhp+YJNjLWVLQIdmW334BgL0Xj5JiMeyXDGr6awR7pZmsWceW1h6LmQSteGSgEuWCp
         9O87It+qu0oND14uArrwJbLY9TBQesO3McpEgByo1tbyXQ1gZOOHPrrTuIfgKlYSwp
         xcIT9kMvwd2QQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S0dYN5xvDz4xF2;
        Wed,  4 Oct 2023 13:14:32 +1100 (AEDT)
Date:   Wed, 4 Oct 2023 13:14:32 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: linux-next: manual merge of the tty tree with the tty.current
 tree
Message-ID: <20231004131432.40b7b946@canb.auug.org.au>
In-Reply-To: <20231004125531.0c61a99d@canb.auug.org.au>
References: <20231004125531.0c61a99d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cWj/Urpy0XUJTATI._GPFnB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cWj/Urpy0XUJTATI._GPFnB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 4 Oct 2023 12:55:31 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the tty tree got a conflict in:
>=20
>   drivers/tty/serial/serial_core.c
>=20
> between commit:
>=20
>   8679328eb859 ("serial: Reduce spinlocked portion of uart_rs485_config()=
")
>=20
> from the tty.current tree and commit:
>=20
>   559c7ff4e324 ("serial: core: Use port lock wrappers")
>=20
> from the tty tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Not quite right :-(  This is what I used:

diff --cc drivers/tty/serial/serial_core.c
index ca26a8aef2cb,b32bbd7aa3d3..ae1d6782ea0e
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@@ -1413,9 -1409,7 +1413,9 @@@ static int uart_rs485_config(struct uar
  	uart_sanitize_serial_rs485(port, rs485);
  	uart_set_rs485_termination(port, rs485);
 =20
- 	spin_lock_irqsave(&port->lock, flags);
++	uart_port_lock_irqsave(port, &flags);
  	ret =3D port->rs485_config(port, NULL, rs485);
- 	spin_unlock_irqrestore(&port->lock, flags);
++	uart_port_unlock_irqrestore(port, flags);
  	if (ret)
  		memset(rs485, 0, sizeof(*rs485));
 =20
@@@ -2480,12 -2474,13 +2480,12 @@@ int uart_resume_port(struct uart_drive
  			if (ret =3D=3D 0) {
  				if (tty)
  					uart_change_line_settings(tty, state, NULL);
 +				uart_rs485_config(uport);
- 				spin_lock_irq(&uport->lock);
+ 				uart_port_lock_irq(uport);
  				if (!(uport->rs485.flags & SER_RS485_ENABLED))
  					ops->set_mctrl(uport, uport->mctrl);
 -				else
 -					uart_rs485_config(uport);
  				ops->start_tx(uport);
- 				spin_unlock_irq(&uport->lock);
+ 				uart_port_unlock_irq(uport);
  				tty_port_set_initialized(port, true);
  			} else {
  				/*
@@@ -2592,10 -2587,10 +2592,10 @@@ uart_configure_port(struct uart_driver=20
  		port->mctrl &=3D TIOCM_DTR;
  		if (!(port->rs485.flags & SER_RS485_ENABLED))
  			port->ops->set_mctrl(port, port->mctrl);
- 		spin_unlock_irqrestore(&port->lock, flags);
 -		else
 -			uart_rs485_config(port);
+ 		uart_port_unlock_irqrestore(port, flags);
 =20
 +		uart_rs485_config(port);
 +
  		/*
  		 * If this driver supports console, and it hasn't been
  		 * successfully registered yet, try to re-register it.


--=20
Cheers,
Stephen Rothwell

--Sig_/cWj/Urpy0XUJTATI._GPFnB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUcyogACgkQAVBC80lX
0GxhSwgAoWBiU6AXSuU+LOvF6GWSl/l9bJUpOBnHtkO4tYs2hs328WU6eb+kEYiK
4ty2iDeVbi+cXId0F84ktivq1C+jmZ9t8sW7qsp2jQHMDYUsa7D9oW0j7zdbxmiJ
I6Go/7gURmRDg7qzx+3zuaSOno1qPGFw1y9JhXN7mC8mkUXKvoMWqmv5Myx4Y+Yk
P9hXSqcEWcmMWGEDVDyG9dcmNDV8r2HnUEafak+ItadarxaWi7UfhkV79tmUdKAN
Ne583pp68VgUBTihNSUeuL9IzJNOlUrRPfHT6EBrMN8kIGQUi33fh6/QKRkaXdhP
Ji/m0P2iQuXl5JQe1Z7ReZmF7muY5g==
=4GaI
-----END PGP SIGNATURE-----

--Sig_/cWj/Urpy0XUJTATI._GPFnB--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CA57B766E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 03:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240501AbjJDBzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 21:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjJDBzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 21:55:44 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5668DA1;
        Tue,  3 Oct 2023 18:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696384534;
        bh=vQQTOrIQzcTUloKrntqCTEdQlI8w03nmxcjn2ljn8Ik=;
        h=Date:From:To:Cc:Subject:From;
        b=RKK5X73jiLVO7FdZpClX+prqHXs27/uzXcJwD58M9CYacouNjEVh5zWAEaFDWSHIm
         4d9EIa2nk23iRR59ZmFbTziM6tv+WMLmDlWHOwUgjlKwyJrBFobAkyzG38Kd2wUmXX
         w30hdv3Nhj4eYcIU3GOY278poiIvjQnChWSNZ8sbb5eLghVhBGqLvSRr5bVNRIfBFR
         q0DbOVKcJv1YpK8+8V83H6cvjSAKQdrFwOzp/B5xA5NGUr4pB1A5oZq3AfTszt7NCt
         nUGj0RnJsaam8Ss5I14/GHUqtvhAhnc6vGUxFTOZedQq8FOHgPvYamDbTDxX0dkNSP
         MVNMkyCUQsLBg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S0d7T3ZPJz4xQT;
        Wed,  4 Oct 2023 12:55:33 +1100 (AEDT)
Date:   Wed, 4 Oct 2023 12:55:31 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: linux-next: manual merge of the tty tree with the tty.current tree
Message-ID: <20231004125531.0c61a99d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1COJnRVI20WB+o=31CaQAmw";
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

--Sig_/1COJnRVI20WB+o=31CaQAmw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tty tree got a conflict in:

  drivers/tty/serial/serial_core.c

between commit:

  8679328eb859 ("serial: Reduce spinlocked portion of uart_rs485_config()")

from the tty.current tree and commit:

  559c7ff4e324 ("serial: core: Use port lock wrappers")

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
index ca26a8aef2cb,b32bbd7aa3d3..000000000000
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@@ -1413,9 -1409,7 +1413,9 @@@ static int uart_rs485_config(struct uar
  	uart_sanitize_serial_rs485(port, rs485);
  	uart_set_rs485_termination(port, rs485);
 =20
- 	spin_lock_irqsave(&port->lock, flags);
++	uart_port_lock_irqsave(port, flags);
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

--Sig_/1COJnRVI20WB+o=31CaQAmw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUcxhMACgkQAVBC80lX
0Gx/1Qf+IH/807Us8iFKamkJHnuRTu4LR700iLVA7WiCxCGOEXLFYIDDFruSxehM
8HXyGY59fReiBOfT1uRpjDvlSmUNtIKTRvJ1WpIoK3b8XM608SvcmrRkzQtpwhhq
ZPyWq4itskPnYs1zq5QPbAq7X2jQ/7qkNlzdYzwJTJIyeCIPo5g947CVcFm7ftQp
0493MvstYKkaTf8PqxWKYM23uCAkwVEFDGi7IDFb90Md95oJcjKUVxV+EpbzLxsy
s9tRxfupgnvm0gLOvGSykWk/8C3VHIeE+QnGszJ5CKfuIjoe9wt6IdQQNuwzcM6o
6qmlEJJz06VvPSRr5HpF9/QjqN013A==
=G/xV
-----END PGP SIGNATURE-----

--Sig_/1COJnRVI20WB+o=31CaQAmw--

Return-Path: <linux-kernel+bounces-142765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D3F8A2FDE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26ABD2824D3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B028595A;
	Fri, 12 Apr 2024 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="GIzGEcdy"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E568529E;
	Fri, 12 Apr 2024 13:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712929866; cv=none; b=LnLCG1bgMEaqJ2Nsw5JLJksz5rBD2oFDxQUMdSixDdSqUQlNrmzZPyYVR6eF4MpGs61q61weodkPXkyDsy0H3n9BDQ+nsT959lRdwn+Jtz+GMajCUjjhlzkbDkfllVjFQSG1QDEL+o/ItXfceEyadMkCpM+89RU1e2CFfcQmEjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712929866; c=relaxed/simple;
	bh=QPNxdChcGjj6Xhl6azjH0njILNbDlSq2oidXRyYX1P4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e2hkKPyGhZgSW0jX6wTzTeIJJO/21Y6B4JCwoPGOJ+iJQdALGL23hopngWA6Yj/XeH7MIQ9XKOiPV0OcITF4dx/ISSjUaban/oKPN6k3XvAbImZcDg0vTOgT4F8CIHj47+D4CqPTX3fdBdV95pEJ2gWeAf9d10Nma4JNtYh8ZmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=GIzGEcdy; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1712929856; x=1713534656; i=parker@finest.io;
	bh=GFn26OoH2nqNMAX4pwMfBVyDN7zSCXmIKI+Z5xWMxrI=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:
	 References;
	b=GIzGEcdy6ws/kMKh3gnsWz0lwDRAqpeW471Wq922uh/E36epWeyoSYiJuKLBvfJg
	 UnEhQsPxufTlFeJEXGqYYtbeUfc725H9lBZ0RiZS5L0gtl8iCsEjzAxN18CnWjHKJ
	 Ke+8MHAyGbGxRwnP8Lz7IsEGGPv6YW+D1rM7bFWuGa3vDQhz2jL7Nq8GBpyQpZn5r
	 aBU8v8cTIPzA4Jcos6F0NmcnL2N+1rFEBnwshqRcyCpuiRd/I2yBe/WvS2wh42oBE
	 3eZRfiy+0ANIXmBcN0QFEIhFSxYGtyiH76arXSMcwsdgnchprklR0OF5j5snbTO81
	 6017nDK1IJGF8VYDBw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id
 1MulRf-1smYmK3uWx-00rlNo; Fri, 12 Apr 2024 15:50:56 +0200
Date: Fri, 12 Apr 2024 09:50:54 -0400
From: Parker Newman <parker@finest.io>
To: Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-serial
 <linux-serial@vger.kernel.org>, Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v2 4/7] serial: exar: add optional board_setup function
Message-ID: <20240412095054.3c80a8fe@SWDEV2.connecttech.local>
In-Reply-To: <385ccf17-199e-13cb-e003-8b583252cab8@linux.intel.com>
References: <cover.1712863999.git.pnewman@connecttech.com>
	<69677365f4c753cbe6b5c028f530db49e6712ab3.1712863999.git.pnewman@connecttech.com>
	<385ccf17-199e-13cb-e003-8b583252cab8@linux.intel.com>
Organization: Connect Tech Inc.
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VoewwBztn8WqfgmSM7thf1nJcrNiZhNaGQzGR/IJYqznn9Ik3Na
 l4ee/akdhZf2Zqn5MrX50+5OtIeJ0HVBgMBlIDLCbpzZDOPzXHLwxsgaDWJFa6jVCjS1hVB
 wilnClrAaL7zqyVmgRby9DaEiuIQPqk5nDN7w2w+uld7FjNCYWJC1qtplbMKpF7Fa0AG/FH
 aFZB0SnKeAaVskk2Fj2UQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qSkTTMbABBw=;0QdzWu9DDxXkQicqxxJe2IN1CNc
 i3L1GkvLRAB5R+jMmPkJgchcSK4DQEoGOUOY77EqtS4mJjHpxrJh11ObeavVugW+b6nwCMGLn
 ckAfyylvlWwYLjN06B8pC5WNLG2S1WAr7+xDalgMP3DYt7T4arBikHxtsuk69Vx3f7xaJ2E/a
 7nun8nehcQz8HryC+IYJ9nP6DaIYOce2l0aLtGBc0kl+KRLGS4k6q815Q046n+8A8L8RUNEgp
 1gM/Wo08NttKto5IW0MuwmsJjyZSFuNPo8F8WniEo7xXzolydF4r4COvACp1a10puIGTqtWWf
 dWCVSbSA+rjKje/o0Qmirm3vKy1m2kNLUhR58ZJnh6SclSqJM7D0W67XZcSOcas/xFDXuwvYc
 U8GP6jRl3ebHJsJ0NwHiESWVEvz5qAPqpTnk/j7+LguhJFq1HixrykOWq62qycf//9cv/ujA3
 bGqsWUHwATik/dju0kYW65s+cjROXDRvrLBGSiSwcIWtzd6+TsqneUX4a5x4ttv4Y+KK3N7Tp
 vAEWax6msgfir+ZZ8HIwe/bumElHgCx/wFBea3+XS5n+yBQYcGJVNjlJS4G1n9xcAvE1VTgPz
 0IOVj9PDDAM1OH0OwTM7kX/39ouAUo4AHlBpuVylHfp+lWbOp41nxoPUpb4DQ9dOGqm4AOkCc
 17QAt+N9INEF46JmbNe12CuyemnH4xnwIK8rk7bIET3Moy+i0BYKCe2/6zBeJQT06iI1DetwV
 AkaLOPvo8yHc1wu8nbeHFT2WqHfj6QbrbcaaORaIfTNaFZzDJmz55w=

On Fri, 12 Apr 2024 13:08:58 +0300 (EEST)
Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> On Thu, 11 Apr 2024, parker@finest.io wrote:
>=20
> > From: Parker Newman <pnewman@connecttech.com>
> >=20
> > Adds an optional "board_setup" function pointer to struct
> > exar8250_board. This gets called once during probe prior to setting up
> > the ports.
> >=20
> > Signed-off-by: Parker Newman <pnewman@connecttech.com>
> > ---
> >  drivers/tty/serial/8250/8250_exar.c | 23 +++++++++++++++++------
> >  1 file changed, 17 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8=
250/8250_exar.c
> > index 9915a99cb7c6..b30f3855652a 100644
> > --- a/drivers/tty/serial/8250/8250_exar.c
> > +++ b/drivers/tty/serial/8250/8250_exar.c
> > @@ -143,7 +143,7 @@
> >   *
> >   * MPIO		Port	Function
> >   * ----		----	--------
> > - * 0		2 	Mode bit 0
> > + * 0		2	Mode bit 0 =20
>=20
> Unrelated change.
>

Sorry, should have added a note about fixing this and the missing argument =
names
below due to checkpatch.pl. I will add a note in v3.=20
=20
> >   * 1		2	Mode bit 1
> >   * 2		2	Terminate bus
> >   * 3		-	<reserved>
> > @@ -179,22 +179,24 @@ struct exar8250_platform {
> >  	int (*rs485_config)(struct uart_port *port, struct ktermios *termios,
> >  			    struct serial_rs485 *rs485);
> >  	const struct serial_rs485 *rs485_supported;
> > -	int (*register_gpio)(struct pci_dev *, struct uart_8250_port *);
> > -	void (*unregister_gpio)(struct uart_8250_port *);
> > +	int (*register_gpio)(struct pci_dev *pcidev, struct uart_8250_port *p=
ort);
> > +	void (*unregister_gpio)(struct uart_8250_port *port);
> >  };
> >=20
> >  /**
> >   * struct exar8250_board - board information
> >   * @num_ports: number of serial ports
> >   * @reg_shift: describes UART register mapping in PCI memory
> > - * @setup: quirk run at ->probe() stage
> > + * @board_setup: quirk run once at ->probe() stage before setting up p=
orts
> > + * @setup: quirk run at ->probe() stage for each port
> >   * @exit: quirk run at ->remove() stage
> >   */
> >  struct exar8250_board {
> >  	unsigned int num_ports;
> >  	unsigned int reg_shift;
> > -	int	(*setup)(struct exar8250 *, struct pci_dev *,
> > -			 struct uart_8250_port *, int);
> > +	int     (*board_setup)(struct exar8250 *priv);
> > +	int	(*setup)(struct exar8250 *priv, struct pci_dev *pcidev,
> > +			 struct uart_8250_port *port, int idx);
> >  	void	(*exit)(struct pci_dev *pcidev);
> >  };
> >=20
> > @@ -966,6 +968,15 @@ exar_pci_probe(struct pci_dev *pcidev, const struc=
t pci_device_id *ent)
> >  	if (rc)
> >  		return rc;
> >=20
> > +	if (board->board_setup) {
> > +		rc =3D board->board_setup(priv); =20
>=20
> Could this be called board_init() as having both ->board_setup() and=20
> ->setup() is bit confusing. =20

sure, good idea.

> > +		if (rc) {
> > +			pci_err(pcidev,
> > +				"failed to setup serial board: %d\n", rc); =20
>=20
> pci_err() belongs to pci subsystem. Please use dev_err() or return=20
> dev_err_probe().

Did not know it was not allowed outside the PCI subsystem. I will switch=20
to dev_err() etc.=20

> > +			return rc;
> > +		}
> > +	}
> > +
> >  	for (i =3D 0; i < nr_ports && i < maxnr; i++) {
> >  		rc =3D board->setup(priv, pcidev, &uart, i);
> >  		if (rc) { =20
>=20
>=20

Thanks,
-Parker

